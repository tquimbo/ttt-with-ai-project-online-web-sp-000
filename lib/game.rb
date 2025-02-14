class Game
    
    attr_accessor :board, :index, :input, :cells, :player_1, :player_2

    WIN_COMBINATIONS= [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

    def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
      @player_1 = player_1
      @player_2 = player_2
      @board = board
    end

    def current_player
        board.turn_count.odd? ? player_2 : player_1
    end

     def won?
      WIN_COMBINATIONS.each do |win|
        if board.cells[win[0]] == "X" && board.cells[win[1]] == "X" && board.cells[win[2]] == "X"
          return win
        elsif board.cells[win[0]] == "O" && board.cells[win[1]] == "O" && board.cells[win[2]] == "O"
          return win
        end
      end
        return false
      end

    def draw?
      board.full? && !won? 
    end
    
    def over?
      won? || board.full? || draw?

    end
    #
    def winner
      if over?
        return board.cells[won?[0]]
      end
    end
  

    def turn
       input = current_player.move(board)
        if board.valid_move?(input)
          board.update(input, current_player)
        else
          turn
      end
    end

    def play
        until over?
          turn
        end
        if won?
          puts "Congratulations #{winner}!"
        elsif draw? == true
          puts "Cat's Game!"
        end
    end

end