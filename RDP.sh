#@title **SSH**

! pip install colab_ssh --upgrade &> /dev/null

Ngrok = True #@param {type:'boolean'}
Agro = False #@param {type:'boolean'}


#@markdown Copy authtoken from https://dashboard.ngrok.com/auth (only for ngrok)
ngrokToken = "" #@param {type:'string'}


def runNGROK():
    from colab_ssh import launch_ssh
    from IPython.display import clear_output
    launch_ssh(ngrokToken, password)
    clear_output()

    print("ssh", username, end='@')
    ! curl -s http://localhost:4040/api/tunnels | python3 -c \
            "import sys, json; print(json.load(sys.stdin)['tunnels'][0]['public_url'][6:].replace(':', ' -p '))"


def runAgro():
    from colab_ssh import launch_ssh_cloudflared
    launch_ssh_cloudflared(password=password)


try:
    if username:
        pass
    elif password:
        pass
except NameError:
    print("No user found using username and password as 'root'")
    username='root'
    password='root'


if Agro and Ngrok:
    print("You can't do that")
    print("Select only one of them")
elif Agro:
    runAgro()
elif Ngrok:
    if ngrokToken == "":
        print("No ngrokToken Found, Please enter it")
    else:
        runNGROK()
else:
    print("Select one of them")
