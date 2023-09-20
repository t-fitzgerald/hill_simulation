# Load required libraries
library(shiny)
library(ggplot2)

# Define the UI for the Shiny app
ui <- fluidPage(
  titlePanel("3-Parameter Hill Curve"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("n_param", "Hill Coefficient (n):", min = 0.1, max = 10, value = 1),
      sliderInput("ec50_param", "EC50 (Half-max concentration):", min = 0.01, max = 10, value = 1),
      sliderInput("max_param", "Maximum Response (Emax):", min = 0.1, max = 1, value = 1)
    ),
    mainPanel(
      plotOutput("hill_curve_plot")
    )
  )
)

# Define the server logic for the Shiny app
server <- function(input, output) {
  output$hill_curve_plot <- renderPlot({
    # Generate x values
    x <- seq(0, 10, by = 0.1)
    
    # Calculate the Hill curve
    y <- input$max_param * (x^input$n_param) / ((input$ec50_param^input$n_param) + (x^input$n_param))
    
    # Create a data frame for plotting
    df <- data.frame(x, y)
    
    # Create the plot
    ggplot(df, aes(x, y)) +
      geom_line() +
      ylim(0, 1) +
      labs(
        title = "3-Parameter Hill Curve",
        x = "Concentration",
        y = "Response"
      )
  })
}

# Run the Shiny app
shinyApp(ui, server)
