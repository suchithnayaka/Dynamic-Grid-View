
import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
    
    @State var data = [

        Type(name: "GTA 5", pic: "gta"),
        Type(name:"Resident Evil",pic:"m3"),
        Type(name: "Resident Evil 2", pic: "re2"),
        Type(name: "Tomb Raider", pic: "tr"),
        Type(name: "Splinter Cell", pic: "sp")
        
    ]
    
    @State var Grid : [Int] = []
    
    var body: some View{
        
        VStack(spacing: 0){
            
            ZStack{
                
                HStack{
                    
                    Button(action: {
                        
                        self.data.append(Type(name: "Resident Evil 3", pic: "re3"))
                        self.Grid.removeAll()
                        self.generateGrid()
                        
                    }) {
                        
                        Image("Grid")
                        .resizable()
                        .renderingMode(.original)
                        .frame(width: 25, height: 23)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }) {
                        
                        Image("User")
                        .resizable()
                        .renderingMode(.original)
                        .frame(width: 22, height: 24)
                    }
                }
                
                Text("Games")
                    .font(.title)
                    .fontWeight(.bold)
            }
            .padding()
            MainView(data: self.$data, Grid: self.$Grid)
        }
        .background(Color.black.opacity(0.06).edgesIgnoringSafeArea(.top))
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            
            self.generateGrid()
        }
    }
    
    func generateGrid(){
        
        for i in stride(from: 0, to: self.data.count, by: 2){
            
            if i != self.data.count{
                
                self.Grid.append(i)
            }
            
        }
    }
}

struct Card : View {
    
    var data : Type
    
    var body: some View{
        
        VStack(spacing: 15){
            
            Image(data.pic)
            .resizable()
            .frame(width: (UIScreen.main.bounds.width - 45) / 2, height: 260)
            .cornerRadius(12)

            Text(data.name)
        }
    }
}

struct MainView : View {
    
    @Binding var data : [Type]
    @Binding var Grid : [Int]
    
    var body: some View{
        
        VStack{
            
            if !self.Grid.isEmpty{
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing : 25){
                        
                        ForEach(self.Grid,id: \.self){i in
                            
                            HStack(spacing: 15){
                                
                                ForEach(i...i+1,id: \.self){j in
                                    
                                    VStack{
                                        
                                        if j != self.data.count{
                                            
                                            Card(data: self.data[j])
                                        }
                                    }
                                    
                                }
                                
                                if i == self.Grid.last! && self.data.count % 2 != 0{
                                    
                                    Spacer(minLength: 0)
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}


struct Type {
    
    var name : String
    var pic : String
}
