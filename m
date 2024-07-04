Return-Path: <linux-kernel+bounces-241393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B62F927ADB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D1D71C211B4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236091B1510;
	Thu,  4 Jul 2024 16:07:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F671A2C1E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 16:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720109225; cv=none; b=QAtegdB1KfV+CslkjFk+5s6EwNrG1nsg9W5kLr0KMJIqIP6Rgxi6cJHI2TVzbO/HskqLLocawmhe2uSDkDZbzFx3ArVP3yQZPNIeLU9ekKh/pvCjJbxbOq3pqRdw3JoFnwR3PL7BA6a92o5Sw0yvsRIylIUmGGOwaxkipJFoYDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720109225; c=relaxed/simple;
	bh=AF9jmiaPv0JqM/pCs350uAbtjvGvKSrMV2lZHKVZljk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ScHRTHWqCQ3cFb8Sri71uld9oq3DueqAefk2Jr8y9TQP28MS4QxWA5/QBmJ9LCMqjzyqaL1nDB2AAKWle7asewSQ3cgO3GOGRi5uP8/+KGS07KlcDUi32pB3HRgdJk62KN7BCciwhuvJBuLWEQCHAST7adqpfM78T1SS5CoUXMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f3c9b72aebso94644739f.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 09:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720109222; x=1720714022;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yI3RhFkC/No9JmX2lFqkLOXjr2QfpOvIt2Wta3eniV0=;
        b=aXPtQDlR7zYJRmpL4t0O21Dc/Yh9vn75MJ8+4U6Jy4Eh9Ct0ebd1YCB/dqaXIsi2Ig
         Vti+WN5+y3P6cU2EXM4pQwLNzfq6glxaCulJC2KZ5ytQcoIihLTmuOF1pAyZVLZzTxZm
         T9JDm8QjUjRAN71MLon73Cjnps2W/iCFRoH7rdaXbqqLJawAf39EsXvafZ+d3YzGVAzh
         C/pUPfteBT9hPM/cgQpYYcGZ7UR3DuzsFnNtzK7d4Hj2PJ7n8g9STU+OgGUwmzsJ3AWJ
         2Sc8soKfqwLy5aEO6pxJm5fZ0WE/69g5cN6WT5EkDPOHEDAYz4qjrKaTY4VlwwKjKsG9
         ns6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWctFuG1kn+jwDA9mt1E/tjj3mzt7Lc2gGyfg5G+0YoCFwoAlygX2R7anx1f7c7b4M+oCSttxqteMnj582i1baLXDTDWuSv+bP5d6cm
X-Gm-Message-State: AOJu0YzPZ3ENIKE5DhedU8AjmHcbUfCDoNpbd7IcSeh2pnLyChFqrp5X
	R0zHrpfxRlr9SVd0r4EgIh1U8yIF+8SButIWPocTjBpb4P3vtwjSm93LUWPvzKb/GloHpXdCR7d
	nW7ZFyUR6GhF3/VzKNvkQ+sL6cHTAi7zZm15PtXOK1W54sXqx+S3QWJk=
X-Google-Smtp-Source: AGHT+IF+0tiruZsxnDk1V+WGCkGHIzY5XxbHK8rXwYsxYaur6yOHznoCDPEnGyFl2XmFKNtVSQ/99uQkJ8Gj/lWNJ4OcGIvZqXhf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1307:b0:4b9:2bc3:46ba with SMTP id
 8926c6da1cb9f-4bf6375358cmr118961173.3.1720109222437; Thu, 04 Jul 2024
 09:07:02 -0700 (PDT)
Date: Thu, 04 Jul 2024 09:07:02 -0700
In-Reply-To: <20240704104544.91031-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002dbf4a061c6e232a@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in team_del_slave (3)
From: syzbot <syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

possible deadlock in team_add_slave

bond0: (slave bond_slave_0): Enslaving as an active interface with an up li=
nk
bond0: (slave bond_slave_1): Enslaving as an active interface with an up li=
nk
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
WARNING: possible recursive locking detected
6.10.0-rc6-syzkaller-00069-g795c58e4c7fc-dirty #0 Not tainted
--------------------------------------------
syz-executor.0/5159 is trying to acquire lock:
ffffffff8f5e6ec8 (rtnl_mutex){+.+.}-{3:3}, at: team_port_add drivers/net/te=
am/team_core.c:1145 [inline]
ffffffff8f5e6ec8 (rtnl_mutex){+.+.}-{3:3}, at: team_add_slave+0xdd/0x2720 d=
rivers/net/team/team_core.c:1990

but task is already holding lock:
ffffffff8f5e6ec8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink=
.c:79 [inline]
ffffffff8f5e6ec8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x842/0x11=
80 net/core/rtnetlink.c:6632

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(rtnl_mutex);
  lock(rtnl_mutex);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by syz-executor.0/5159:
 #0: ffffffff8f5e6ec8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtne=
tlink.c:79 [inline]
 #0: ffffffff8f5e6ec8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x842=
/0x1180 net/core/rtnetlink.c:6632
 #1: ffff88806a00cd20 (team->team_lock_key){+.+.}-{3:3}, at: team_add_slave=
+0xb0/0x2720 drivers/net/team/team_core.c:1989

stack backtrace:
CPU: 0 PID: 5159 Comm: syz-executor.0 Not tainted 6.10.0-rc6-syzkaller-0006=
9-g795c58e4c7fc-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_deadlock kernel/locking/lockdep.c:3062 [inline]
 validate_chain+0x15d3/0x5900 kernel/locking/lockdep.c:3856
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 team_port_add drivers/net/team/team_core.c:1145 [inline]
 team_add_slave+0xdd/0x2720 drivers/net/team/team_core.c:1990
 do_set_master net/core/rtnetlink.c:2701 [inline]
 do_setlink+0xe70/0x41f0 net/core/rtnetlink.c:2907
 __rtnl_newlink net/core/rtnetlink.c:3696 [inline]
 rtnl_newlink+0x180b/0x20a0 net/core/rtnetlink.c:3743
 rtnetlink_rcv_msg+0x89b/0x1180 net/core/rtnetlink.c:6635
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2564
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8db/0xcb0 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 __sys_sendto+0x3a4/0x4f0 net/socket.c:2192
 __do_sys_sendto net/socket.c:2204 [inline]
 __se_sys_sendto net/socket.c:2200 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2200
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe59307ed43
Code: 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 00 00 00 00 90 =
80 3d c1 91 10 00 00 41 89 ca 74 14 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff f=
f 77 75 c3 0f 1f 40 00 55 48 83 ec 30 44 89 4c 24
RSP: 002b:00007fe5932df648 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007fe593ce4620 RCX: 00007fe59307ed43
RDX: 0000000000000028 RSI: 00007fe593ce4670 RDI: 0000000000000003
RBP: 0000000000000001 R08: 00007fe5932df664 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000003
R13: 0000000000000000 R14: 00007fe593ce4670 R15: 0000000000000000
 </TASK>


Warning: Permanently added '10.128.0.29' (ED25519) to the list of known hos=
ts.
2024/07/04 16:06:06 ignoring optional flag "sandboxArg"=3D"0"
2024/07/04 16:06:07 parsed 1 programs
[   63.126006][ T5090] cgroup: Unknown subsys name 'net'
[   63.411712][ T5090] cgroup: Unknown subsys name 'rlimit'
[   64.609660][ T5092] Adding 124996k swap on ./swap-file.  Priority:0 exte=
nts:1 across:124996k=20
[   65.064470][   T53] Bluetooth: hci0: unexpected cc 0x0c03 length: 249 > =
1
[   65.072894][   T53] Bluetooth: hci0: unexpected cc 0x1003 length: 249 > =
9
[   65.080962][   T53] Bluetooth: hci0: unexpected cc 0x1001 length: 249 > =
9
[   65.090842][   T53] Bluetooth: hci0: unexpected cc 0x0c23 length: 249 > =
4
[   65.103105][   T53] Bluetooth: hci0: unexpected cc 0x0c25 length: 249 > =
3
[   65.121545][   T53] Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > =
2
[   65.438608][ T1046] wlan0: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[   65.457546][ T1046] wlan0: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
[   65.495887][ T2472] wlan1: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[   65.504409][ T2472] wlan1: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
[   66.784406][ T5159] chnl_net:caif_netlink_parms(): no params data found
[   66.879723][ T5159] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   66.889205][ T5159] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   66.896897][ T5159] bridge_slave_0: entered allmulticast mode
[   66.905071][ T5159] bridge_slave_0: entered promiscuous mode
[   66.914541][ T5159] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   66.922253][ T5159] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   66.929529][ T5159] bridge_slave_1: entered allmulticast mode
[   66.937325][ T5159] bridge_slave_1: entered promiscuous mode
[   66.974384][ T5159] bond0: (slave bond_slave_0): Enslaving as an active =
interface with an up link
[   66.986385][ T5159] bond0: (slave bond_slave_1): Enslaving as an active =
interface with an up link
[   67.014300][ T5159]=20
[   67.016708][ T5159] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
[   67.022882][ T5159] WARNING: possible recursive locking detected
[   67.029164][ T5159] 6.10.0-rc6-syzkaller-00069-g795c58e4c7fc-dirty #0 No=
t tainted
[   67.036959][ T5159] --------------------------------------------
[   67.043287][ T5159] syz-executor.0/5159 is trying to acquire lock:
[   67.049949][ T5159] ffffffff8f5e6ec8 (rtnl_mutex){+.+.}-{3:3}, at: team_=
add_slave+0xdd/0x2720
[   67.058734][ T5159]=20
[   67.058734][ T5159] but task is already holding lock:
[   67.066374][ T5159] ffffffff8f5e6ec8 (rtnl_mutex){+.+.}-{3:3}, at: rtnet=
link_rcv_msg+0x842/0x1180
[   67.075446][ T5159]=20
[   67.075446][ T5159] other info that might help us debug this:
[   67.083669][ T5159]  Possible unsafe locking scenario:
[   67.083669][ T5159]=20
[   67.091184][ T5159]        CPU0
[   67.094442][ T5159]        ----
[   67.097721][ T5159]   lock(rtnl_mutex);
[   67.101746][ T5159]   lock(rtnl_mutex);
[   67.105832][ T5159]=20
[   67.105832][ T5159]  *** DEADLOCK ***
[   67.105832][ T5159]=20
[   67.113981][ T5159]  May be due to missing lock nesting notation
[   67.113981][ T5159]=20
[   67.122398][ T5159] 2 locks held by syz-executor.0/5159:
[   67.127935][ T5159]  #0: ffffffff8f5e6ec8 (rtnl_mutex){+.+.}-{3:3}, at: =
rtnetlink_rcv_msg+0x842/0x1180
[   67.137584][ T5159]  #1: ffff88806a00cd20 (team->team_lock_key){+.+.}-{3=
:3}, at: team_add_slave+0xb0/0x2720
[   67.147698][ T5159]=20
[   67.147698][ T5159] stack backtrace:
[   67.153714][ T5159] CPU: 0 PID: 5159 Comm: syz-executor.0 Not tainted 6.=
10.0-rc6-syzkaller-00069-g795c58e4c7fc-dirty #0
[   67.164638][ T5159] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 06/07/2024
[   67.174864][ T5159] Call Trace:
[   67.178320][ T5159]  <TASK>
[   67.181235][ T5159]  dump_stack_lvl+0x241/0x360
[   67.185997][ T5159]  ? __pfx_dump_stack_lvl+0x10/0x10
[   67.191370][ T5159]  ? print_deadlock_bug+0x479/0x620
[   67.196552][ T5159]  validate_chain+0x15d3/0x5900
[   67.201409][ T5159]  ? __pfx_validate_chain+0x10/0x10
[   67.206707][ T5159]  ? stack_trace_save+0x118/0x1d0
[   67.211816][ T5159]  ? __pfx_stack_trace_save+0x10/0x10
[   67.217296][ T5159]  ? lockdep_unlock+0x16a/0x300
[   67.222144][ T5159]  ? mark_lock+0x9a/0x350
[   67.226480][ T5159]  __lock_acquire+0x1346/0x1fd0
[   67.231609][ T5159]  lock_acquire+0x1ed/0x550
[   67.236105][ T5159]  ? team_add_slave+0xdd/0x2720
[   67.240978][ T5159]  ? __pfx_lock_acquire+0x10/0x10
[   67.246022][ T5159]  ? __pfx___might_resched+0x10/0x10
[   67.251353][ T5159]  ? __pfx___mutex_trylock_common+0x10/0x10
[   67.257275][ T5159]  __mutex_lock+0x136/0xd70
[   67.261783][ T5159]  ? team_add_slave+0xdd/0x2720
[   67.266645][ T5159]  ? team_add_slave+0xdd/0x2720
[   67.271654][ T5159]  ? __pfx___mutex_lock+0x10/0x10
[   67.276846][ T5159]  team_add_slave+0xdd/0x2720
[   67.281508][ T5159]  ? __pfx_lock_acquire+0x10/0x10
[   67.286605][ T5159]  ? deref_stack_reg+0x1c7/0x260
[   67.291535][ T5159]  ? __pfx_team_add_slave+0x10/0x10
[   67.296823][ T5159]  ? is_bpf_text_address+0x285/0x2a0
[   67.302187][ T5159]  ? is_bpf_text_address+0x26/0x2a0
[   67.307484][ T5159]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[   67.313666][ T5159]  ? kernel_text_address+0xa7/0xe0
[   67.318792][ T5159]  ? __kernel_text_address+0xd/0x40
[   67.323994][ T5159]  ? unwind_get_return_address+0x91/0xc0
[   67.329730][ T5159]  ? mutex_is_locked+0x12/0x50
[   67.334513][ T5159]  do_setlink+0xe70/0x41f0
[   67.339161][ T5159]  ? stack_trace_save+0x118/0x1d0
[   67.344184][ T5159]  ? __pfx_stack_trace_save+0x10/0x10
[   67.349548][ T5159]  ? __pfx_do_setlink+0x10/0x10
[   67.354458][ T5159]  ? __nla_validate_parse+0x26ce/0x3090
[   67.360197][ T5159]  ? kmalloc_trace_noprof+0x19c/0x2c0
[   67.365569][ T5159]  ? rtnl_newlink+0xf2/0x20a0
[   67.370328][ T5159]  ? __pfx___nla_validate_parse+0x10/0x10
[   67.376043][ T5159]  ? validate_linkmsg+0x71e/0x900
[   67.381225][ T5159]  rtnl_newlink+0x180b/0x20a0
[   67.385888][ T5159]  ? rtnl_newlink+0x4f1/0x20a0
[   67.390647][ T5159]  ? __pfx_rtnl_newlink+0x10/0x10
[   67.395719][ T5159]  ? __pfx___mutex_trylock_common+0x10/0x10
[   67.401615][ T5159]  ? rcu_is_watching+0x15/0xb0
[   67.406401][ T5159]  ? trace_contention_end+0x3c/0x120
[   67.411876][ T5159]  ? __mutex_lock+0x2ef/0xd70
[   67.416760][ T5159]  ? __pfx_lock_release+0x10/0x10
[   67.421801][ T5159]  ? __pfx_rtnl_newlink+0x10/0x10
[   67.426918][ T5159]  rtnetlink_rcv_msg+0x89b/0x1180
[   67.432098][ T5159]  ? rtnetlink_rcv_msg+0x208/0x1180
[   67.437351][ T5159]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[   67.442824][ T5159]  ? is_bpf_text_address+0x285/0x2a0
[   67.448107][ T5159]  ? __pfx_validate_chain+0x10/0x10
[   67.453468][ T5159]  ? __pfx_validate_chain+0x10/0x10
[   67.458685][ T5159]  ? arch_stack_walk+0x16d/0x1b0
[   67.463679][ T5159]  ? mark_lock+0x9a/0x350
[   67.468000][ T5159]  ? __pfx_validate_chain+0x10/0x10
[   67.473274][ T5159]  ? __lock_acquire+0x1346/0x1fd0
[   67.478279][ T5159]  ? mark_lock+0x9a/0x350
[   67.482618][ T5159]  ? __lock_acquire+0x1346/0x1fd0
[   67.487750][ T5159]  netlink_rcv_skb+0x1e3/0x430
[   67.492526][ T5159]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[   67.497973][ T5159]  ? __pfx_netlink_rcv_skb+0x10/0x10
[   67.503358][ T5159]  ? netlink_deliver_tap+0x2e/0x1b0
[   67.508562][ T5159]  netlink_unicast+0x7ea/0x980
[   67.513366][ T5159]  ? __pfx_netlink_unicast+0x10/0x10
[   67.518654][ T5159]  ? __virt_addr_valid+0x183/0x520
[   67.524039][ T5159]  ? __check_object_size+0x49c/0x900
[   67.529325][ T5159]  ? bpf_lsm_netlink_send+0x9/0x10
[   67.534430][ T5159]  netlink_sendmsg+0x8db/0xcb0
[   67.539209][ T5159]  ? __pfx_netlink_sendmsg+0x10/0x10
[   67.544486][ T5159]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[   67.550487][ T5159]  ? aa_sock_msg_perm+0x91/0x160
[   67.555506][ T5159]  ? bpf_lsm_socket_sendmsg+0x9/0x10
[   67.560779][ T5159]  ? security_socket_sendmsg+0x87/0xb0
[   67.566234][ T5159]  ? __pfx_netlink_sendmsg+0x10/0x10
[   67.571514][ T5159]  __sock_sendmsg+0x221/0x270
[   67.576197][ T5159]  __sys_sendto+0x3a4/0x4f0
[   67.580871][ T5159]  ? __pfx___sys_sendto+0x10/0x10
[   67.585926][ T5159]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[   67.591896][ T5159]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[   67.598304][ T5159]  __x64_sys_sendto+0xde/0x100
[   67.603056][ T5159]  do_syscall_64+0xf3/0x230
[   67.607636][ T5159]  ? clear_bhb_loop+0x35/0x90
[   67.612394][ T5159]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   67.618397][ T5159] RIP: 0033:0x7fe59307ed43
[   67.622867][ T5159] Code: 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1=
f 84 00 00 00 00 00 90 80 3d c1 91 10 00 00 41 89 ca 74 14 b8 2c 00 00 00 0=
f 05 <48> 3d 00 f0 ff ff 77 75 c3 0f 1f 40 00 55 48 83 ec 30 44 89 4c 24
[   67.642562][ T5159] RSP: 002b:00007fe5932df648 EFLAGS: 00000202 ORIG_RAX=
: 000000000000002c
[   67.650973][ T5159] RAX: ffffffffffffffda RBX: 00007fe593ce4620 RCX: 000=
07fe59307ed43
[   67.659020][ T5159] RDX: 0000000000000028 RSI: 00007fe593ce4670 RDI: 000=
0000000000003
[   67.666978][ T5159] RBP: 0000000000000001 R08: 00007fe5932df664 R09: 000=
000000000000c
[   67.675020][ T5159] R10: 0000000000000000 R11: 0000000000000202 R12: 000=
0000000000003
[   67.683433][ T5159] R13: 0000000000000000 R14: 00007fe593ce4670 R15: 000=
0000000000000
[   67.691430][ T5159]  </TASK>
[   72.393400][ T1249] ieee802154 phy0 wpan0: encryption failed: -22
[   72.399745][ T1249] ieee802154 phy1 wpan1: encryption failed: -22


syzkaller build log:
go env (err=3D<nil>)
GO111MODULE=3D'auto'
GOARCH=3D'amd64'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFLAGS=3D''
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMODCACHE=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs-2/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.21.4'
GCCGO=3D'gccgo'
GOAMD64=3D'v1'
AR=3D'ar'
CC=3D'gcc'
CXX=3D'g++'
CGO_ENABLED=3D'1'
GOMOD=3D'/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.=
mod'
GOWORK=3D''
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
PKG_CONFIG=3D'pkg-config'
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build2557619195=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at edc5149ad2
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sy=
s/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
go fmt ./sys/... >/dev/null
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dedc5149ad2ab7a38db6b3bcb1b594e0264a92163 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240621-090414'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dedc5149ad2ab7a38db6b3bcb1b594e0264a92163 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240621-090414'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include -fpermissive -w -DGOOS_linu=
x=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"edc5149ad2ab7a38db6b3bcb1b594e0264=
a92163\"



Tested on:

commit:         795c58e4 Merge tag 'trace-v6.10-rc6' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D864caee5f78cab5=
1
dashboard link: https://syzkaller.appspot.com/bug?extid=3D705c61d60b091ef42=
c04
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D13e99bae9800=
00


