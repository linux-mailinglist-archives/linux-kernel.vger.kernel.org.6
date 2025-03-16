Return-Path: <linux-kernel+bounces-562801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74874A63326
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 02:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEE9A16D89E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 01:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BCA1E51D;
	Sun, 16 Mar 2025 01:24:12 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A968440C
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 01:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742088251; cv=none; b=ujkedcZBoMQMh/+JFGiAfeGZAi/BEjOdWTSWfCwz9WZ3uAIFedfR+lpUpcKIz9l7cxlxRN9bjvQRcYWtcNkXiufXydNYkd5kBdvDiJYEynshj/0fvr1+Bydki7YTMcFRIRHaqoE36ze1bAmL+PuQs28pRB5kEJQrnKTmk3+IAJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742088251; c=relaxed/simple;
	bh=+r2f/0BS/iY0R9KENAkGfFMn4gT7q29HbMLMEZ8tWSQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=asvtDpUJxLn2xoyIPsQLblbDPxnSJFuEFyHs1FLdrRerOrdj1EN6w6Z6Lv3WdNVzKUpNTsGU1T0quujyZsW+W8FI2Tq78Uqiexm7LwUHFTow+osNL3f9etGzrhRI3ev3dQenjOEL+DY9fo+ceVPoJ4j0PC45ltzGSeTwItE3D5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ce81a40f5cso71229205ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 18:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742088248; x=1742693048;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l87kUz2yGJ8pxFuXkO8ccX4iZqjpE23gNHSauyCRZuo=;
        b=dzPVPN72duPtEHK1l7zk+B/ogO56xoJuEUQORSwxbtMpb4haOmWmHD9CQUOd6DvWaY
         Gom6AtUBnkI4u7cH4g22VciCJhvXvFEJkE0QcvReA/G3P+IOr9KCamQzoABH/dZ+clno
         fzD1I8Gdnmk5lL0lcczEwArUu5WrAx++llMD+jbtUPYBAJxldyQ3XbPKHX/CG+cbduF8
         lQEsQaQ6pe3SypeKrFMWJgbNIB4Z/ybGbmdUEUFMUQU8uSxUQVBPWPLzZI5iFjbOo0dk
         uMQf6O5ucHmIoYh47J6U2I6vAdWhcaFjnV08TmnrRrrMyvkXpMXd5+bSE5K6wiMZ+Del
         Omng==
X-Forwarded-Encrypted: i=1; AJvYcCXQACtEysCz0YLtHQ2IsIkFo9/NMCr3YvVQctZ8D1ukcrDTpS4TdZVVLrD9UZfL8Gx0FzE/556+AKmnclA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXIPmU72SxYp816ftLkjBMJWw7f+9BGTs1YkT1stuY8/xoMDV6
	8VA4lQrVRzN9rgiDgwul9Ai0D1nrIsjmigM5bTFB3uJxLf4ZkZd55gpFGWoZxoogIrlK7o94GPM
	c4UXywKdfAqkf9AIK0FyXGDjCADD7G9YFxTDrUAraJQ2l8zYzMGr4m8Y=
X-Google-Smtp-Source: AGHT+IEy2jbsHlLoAKOtiCIBVN7bkB3cH0iVMyt5CiqzJbOO083Hq+Ia8Ge3RYzOjjyIJioUiuEk6uEkO4VjbYSrsIXuBTWYWKEU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2589:b0:3d4:2409:ce6 with SMTP id
 e9e14a558f8ab-3d4839f74e1mr86272005ab.5.1742088248221; Sat, 15 Mar 2025
 18:24:08 -0700 (PDT)
Date: Sat, 15 Mar 2025 18:24:08 -0700
In-Reply-To: <tencent_FF211B3F4BBA1BCD253BBA0FBB3F33229E08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d62838.050a0220.14e108.005b.GAE@google.com>
Subject: Re: [syzbot] [wireless?] possible deadlock in ieee80211_change_mac (3)
From: syzbot <syzbot+30de9d963fdd95d745f8@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

  72.433667][ T5886] batman_adv: batadv0: Interface activated: batadv_slave=
_0
[   72.445739][ T5886] batman_adv: batadv0: Interface activated: batadv_sla=
ve_1
[   72.457663][ T5886] netdevsim netdevsim0 netdevsim0: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   72.466980][ T5886] netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   72.476086][ T5886] netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   72.485383][ T5886] netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   72.632760][ T4915] netdevsim netdevsim0 netdevsim3 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   72.692574][ T4915] netdevsim netdevsim0 netdevsim2 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   72.784028][ T4915] netdevsim netdevsim0 netdevsim1 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   72.874605][ T4915] netdevsim netdevsim0 netdevsim0 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
2025/03/16 01:22:38 executed programs: 0
[   73.931356][ T5851] Bluetooth: hci0: unexpected cc 0x0c03 length: 249 > =
1
[   73.940395][ T5851] Bluetooth: hci0: unexpected cc 0x1003 length: 249 > =
9
[   73.950465][ T5851] Bluetooth: hci0: unexpected cc 0x1001 length: 249 > =
9
[   73.960767][ T5851] Bluetooth: hci0: unexpected cc 0x0c23 length: 249 > =
4
[   73.968729][ T5851] Bluetooth: hci0: unexpected cc 0x0c25 length: 249 > =
3
[   73.976076][ T5851] Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > =
2
[   74.076074][ T5939] chnl_net:caif_netlink_parms(): no params data found
[   74.128718][ T5939] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   74.135896][ T5939] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   74.143357][ T5939] bridge_slave_0: entered allmulticast mode
[   74.150540][ T5939] bridge_slave_0: entered promiscuous mode
[   74.157725][ T5939] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   74.165646][ T5939] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   74.173064][ T5939] bridge_slave_1: entered allmulticast mode
[   74.179810][ T5939] bridge_slave_1: entered promiscuous mode
[   74.204642][ T5939] bond0: (slave bond_slave_0): Enslaving as an active =
interface with an up link
[   74.215916][ T5939] bond0: (slave bond_slave_1): Enslaving as an active =
interface with an up link
[   74.241618][ T5939] team0: Port device team_slave_0 added
[   74.250900][ T5939] team0: Port device team_slave_1 added
[   74.269595][ T5939] batman_adv: batadv0: Adding interface: batadv_slave_=
0
[   74.276571][ T5939] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_0 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1560 would solve the problem.
[   74.303099][ T5939] batman_adv: batadv0: Not using interface batadv_slav=
e_0 (retrying later): interface not active
[   74.316822][ T5939] batman_adv: batadv0: Adding interface: batadv_slave_=
1
[   74.323877][ T5939] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_1 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1560 would solve the problem.
[   74.351065][ T5939] batman_adv: batadv0: Not using interface batadv_slav=
e_1 (retrying later): interface not active
[   74.387353][ T5939] hsr_slave_0: entered promiscuous mode
[   74.393586][ T5939] hsr_slave_1: entered promiscuous mode
[   74.400465][ T5939] debugfs: Directory 'hsr0' with parent 'hsr' already =
present!
[   74.408569][ T5939] Cannot create hsr debugfs directory
[   75.504126][ T4915] bridge_slave_1: left allmulticast mode
[   75.510136][ T4915] bridge_slave_1: left promiscuous mode
[   75.516970][ T4915] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   75.536981][ T4915] bridge_slave_0: left allmulticast mode
[   75.544581][ T4915] bridge_slave_0: left promiscuous mode
[   75.551159][ T4915] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   75.802024][ T4915] bond0 (unregistering): (slave bond_slave_0): Releasi=
ng backup interface
[   75.814407][ T4915] bond0 (unregistering): (slave bond_slave_1): Releasi=
ng backup interface
[   75.824472][ T4915] bond0 (unregistering): Released all slaves
[   75.921046][ T4915] hsr_slave_0: left promiscuous mode
[   75.927724][ T4915] hsr_slave_1: left promiscuous mode
[   75.936428][ T4915] batman_adv: batadv0: Interface deactivated: batadv_s=
lave_0
[   75.944464][ T4915] batman_adv: batadv0: Removing interface: batadv_slav=
e_0
[   75.955660][ T4915] batman_adv: batadv0: Interface deactivated: batadv_s=
lave_1
[   75.964004][ T4915] batman_adv: batadv0: Removing interface: batadv_slav=
e_1
[   75.985966][ T4915] veth1_macvtap: left promiscuous mode
[   75.994538][ T4915] veth0_macvtap: left promiscuous mode
[   76.001124][ T4915] veth1_vlan: left promiscuous mode
[   76.006763][ T4915] veth0_vlan: left promiscuous mode
[   76.029255][ T5148] Bluetooth: hci0: command tx timeout
[   76.386411][ T4915] team0 (unregistering): Port device team_slave_1 remo=
ved
[   76.416643][ T4915] team0 (unregistering): Port device team_slave_0 remo=
ved
[   76.680651][ T5503]=20
[   76.682998][ T5503] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
[   76.689143][ T5503] WARNING: possible recursive locking detected
[   76.695340][ T5503] 6.14.0-rc6-syzkaller-gbfc6c67ec2d6-dirty #0 Not tain=
ted
[   76.702636][ T5503] --------------------------------------------
[   76.708784][ T5503] dhcpcd/5503 is trying to acquire lock:
[   76.714415][ T5503] ffff888030558d28 (&dev->lock){+.+.}-{4:4}, at: lapbe=
th_device_event+0x766/0xa20
[   76.723635][ T5503]=20
[   76.723635][ T5503] but task is already holding lock:
[   76.731089][ T5503] ffff888029c3cd28 (&dev->lock){+.+.}-{4:4}, at: dev_c=
hange_flags+0x120/0x270
[   76.740207][ T5503]=20
[   76.740207][ T5503] other info that might help us debug this:
[   76.748254][ T5503]  Possible unsafe locking scenario:
[   76.748254][ T5503]=20
[   76.755709][ T5503]        CPU0
[   76.758970][ T5503]        ----
[   76.762241][ T5503]   lock(&dev->lock);
[   76.766387][ T5503]   lock(&dev->lock);
[   76.770359][ T5503]=20
[   76.770359][ T5503]  *** DEADLOCK ***
[   76.770359][ T5503]=20
[   76.778512][ T5503]  May be due to missing lock nesting notation
[   76.778512][ T5503]=20
[   76.786821][ T5503] 2 locks held by dhcpcd/5503:
[   76.791564][ T5503]  #0: ffffffff8fed6cc8 (rtnl_mutex){+.+.}-{4:4}, at: =
devinet_ioctl+0x34c/0x1d80
[   76.800771][ T5503]  #1: ffff888029c3cd28 (&dev->lock){+.+.}-{4:4}, at: =
dev_change_flags+0x120/0x270
[   76.810056][ T5503]=20
[   76.810056][ T5503] stack backtrace:
[   76.815937][ T5503] CPU: 1 UID: 0 PID: 5503 Comm: dhcpcd Not tainted 6.1=
4.0-rc6-syzkaller-gbfc6c67ec2d6-dirty #0
[   76.815948][ T5503] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 02/12/2025
[   76.815957][ T5503] Call Trace:
[   76.815964][ T5503]  <TASK>
[   76.815969][ T5503]  dump_stack_lvl+0x241/0x360
[   76.815985][ T5503]  ? __pfx_dump_stack_lvl+0x10/0x10
[   76.815995][ T5503]  ? __pfx__printk+0x10/0x10
[   76.816004][ T5503]  ? lockdep_unlock+0x16a/0x300
[   76.816019][ T5503]  print_deadlock_bug+0x483/0x620
[   76.816035][ T5503]  validate_chain+0x15e2/0x5920
[   76.816047][ T5503]  ? is_bpf_text_address+0x26/0x2a0
[   76.816056][ T5503]  ? unwind_next_frame+0x18e6/0x22d0
[   76.816070][ T5503]  ? __pfx_validate_chain+0x10/0x10
[   76.816079][ T5503]  ? preempt_count_add+0x93/0x190
[   76.816092][ T5503]  ? is_bpf_text_address+0x285/0x2a0
[   76.816100][ T5503]  ? is_bpf_text_address+0x26/0x2a0
[   76.816107][ T5503]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[   76.816120][ T5503]  ? kernel_text_address+0xa7/0xe0
[   76.816130][ T5503]  ? look_up_lock_class+0x77/0x170
[   76.816141][ T5503]  ? register_lock_class+0x102/0x980
[   76.816155][ T5503]  ? __pfx_register_lock_class+0x10/0x10
[   76.816168][ T5503]  ? mark_lock+0x9a/0x360
[   76.816176][ T5503]  __lock_acquire+0x1397/0x2100
[   76.816193][ T5503]  lock_acquire+0x1ed/0x550
[   76.816205][ T5503]  ? lapbeth_device_event+0x766/0xa20
[   76.816216][ T5503]  ? __pfx_lock_acquire+0x10/0x10
[   76.816229][ T5503]  ? __pfx___might_resched+0x10/0x10
[   76.816243][ T5503]  __mutex_lock+0x19c/0x1010
[   76.816255][ T5503]  ? lapbeth_device_event+0x766/0xa20
[   76.816264][ T5503]  ? __asan_memset+0x23/0x50
[   76.816274][ T5503]  ? lapbeth_device_event+0x766/0xa20
[   76.816283][ T5503]  ? __pfx___mutex_lock+0x10/0x10
[   76.816298][ T5503]  ? __raw_spin_lock_init+0x45/0x100
[   76.816310][ T5503]  lapbeth_device_event+0x766/0xa20
[   76.816319][ T5503]  notifier_call_chain+0x1a5/0x3f0
[   76.816334][ T5503]  __dev_notify_flags+0x207/0x400
[   76.816345][ T5503]  ? dev_set_rx_mode+0xb8/0x2e0
[   76.816354][ T5503]  ? __pfx___dev_notify_flags+0x10/0x10
[   76.816363][ T5503]  ? __dev_change_flags+0x515/0x6f0
[   76.816372][ T5503]  ? __pfx___mutex_lock+0x10/0x10
[   76.816383][ T5503]  ? __pfx___dev_change_flags+0x10/0x10
[   76.816393][ T5503]  ? __pfx___mutex_lock+0x10/0x10
[   76.816404][ T5503]  netif_change_flags+0xf0/0x1a0
[   76.816414][ T5503]  dev_change_flags+0x146/0x270
[   76.816424][ T5503]  devinet_ioctl+0xea2/0x1d80
[   76.816440][ T5503]  ? __pfx_devinet_ioctl+0x10/0x10
[   76.816453][ T5503]  ? get_user_ifreq+0x1bb/0x200
[   76.816465][ T5503]  inet_ioctl+0x3d7/0x4f0
[   76.816476][ T5503]  ? __pfx_inet_ioctl+0x10/0x10
[   76.816486][ T5503]  ? tomoyo_path_number_perm+0x5dd/0x770
[   76.816503][ T5503]  sock_do_ioctl+0x158/0x460
[   76.816517][ T5503]  ? __pfx_sock_do_ioctl+0x10/0x10
[   76.816529][ T5503]  ? __pfx_lock_release+0x10/0x10
[   76.816544][ T5503]  sock_ioctl+0x626/0x8e0
[   76.816556][ T5503]  ? __pfx_sock_ioctl+0x10/0x10
[   76.816567][ T5503]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[   76.816581][ T5503]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[   76.816594][ T5503]  ? __pfx_sock_ioctl+0x10/0x10
[   76.816605][ T5503]  __se_sys_ioctl+0xf5/0x170
[   76.816616][ T5503]  do_syscall_64+0xf3/0x230
[   76.816628][ T5503]  ? clear_bhb_loop+0x35/0x90
[   76.816641][ T5503]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   76.816659][ T5503] RIP: 0033:0x7fafacad9d49
[   76.816672][ T5503] Code: 5c c3 48 8d 44 24 08 48 89 54 24 e0 48 89 44 2=
4 c0 48 8d 44 24 d0 48 89 44 24 c8 b8 10 00 00 00 c7 44 24 b8 10 00 00 00 0=
f 05 <41> 89 c0 3d 00 f0 ff ff 76 10 48 8b 15 ae 60 0d 00 f7 d8 41 83 c8
[   76.816679][ T5503] RSP: 002b:00007fff965e9208 EFLAGS: 00000246 ORIG_RAX=
: 0000000000000010
[   76.816690][ T5503] RAX: ffffffffffffffda RBX: 00007fafaca0b6c0 RCX: 000=
07fafacad9d49
[   76.816696][ T5503] RDX: 00007fff965f93f8 RSI: 0000000000008914 RDI: 000=
000000000000e
[   76.816702][ T5503] RBP: 00007fff966095b8 R08: 00007fff965f93b8 R09: 000=
07fff965f9368
[   76.816709][ T5503] R10: 0000000000000000 R11: 0000000000000246 R12: 000=
0000000000000
[   76.816714][ T5503] R13: 00007fff965f93f8 R14: 0000000000000028 R15: 000=
0000000008914
[   76.816722][ T5503]  </TASK>
[   77.431447][ T5939] netdevsim netdevsim0 netdevsim0: renamed from eth0
[   77.447065][ T5939] netdevsim netdevsim0 netdevsim1: renamed from eth1
[   77.459986][ T5939] netdevsim netdevsim0 netdevsim2: renamed from eth2
[   77.470884][ T5939] netdevsim netdevsim0 netdevsim3: renamed from eth3
[   77.532921][ T5939] 8021q: adding VLAN 0 to HW filter on device bond0
[   77.562340][ T5939] 8021q: adding VLAN 0 to HW filter on device team0
[   77.580014][ T1055] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   77.587132][ T1055] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   77.706703][ T1055] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   77.713863][ T1055] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   77.881667][ T5939] 8021q: adding VLAN 0 to HW filter on device batadv0
[   77.938802][ T5939] veth0_vlan: entered promiscuous mode
[   77.949800][ T5939] veth1_vlan: entered promiscuous mode
[   77.990643][ T5939] veth0_macvtap: entered promiscuous mode
[   77.999872][ T5939] veth1_macvtap: entered promiscuous mode
[   78.015141][ T5939] batman_adv: batadv0: Interface activated: batadv_sla=
ve_0
[   78.032460][ T5939] batman_adv: batadv0: Interface activated: batadv_sla=
ve_1
[   78.046046][ T5939] netdevsim netdevsim0 netdevsim0: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   78.055528][ T5939] netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   78.066650][ T5939] netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   78.076163][ T5939] netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   78.106714][ T5939] ieee80211 phy5: Selected rate control algorithm 'min=
strel_ht'
[   78.114482][ T5148] Bluetooth: hci0: command tx timeout
[   78.135848][   T13] wlan0: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[   78.144458][   T13] wlan0: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
[   78.152395][ T5939] ieee80211 phy6: Selected rate control algorithm 'min=
strel_ht'
[   78.176744][   T13] wlan1: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[   78.186077][   T13] wlan1: Creating new IBSS network, BSSID 50:50:50:50:=
50:50


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
GOROOT=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod/golang.org/toolchain@v0.0.=
1-go1.23.6.linux-amd64'
GOSUMDB=3D'sum.golang.org'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod/golang.org/toolchain@v0=
.0.1-go1.23.6.linux-amd64/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.23.6'
GODEBUG=3D''
GOTELEMETRY=3D'local'
GOTELEMETRYDIR=3D'/syzkaller/.config/go/telemetry'
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
 -ffile-prefix-map=3D/tmp/go-build162451828=3D/tmp/go-build -gno-record-gcc=
-switches'

git status (err=3D<nil>)
HEAD detached at e28266709d
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
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3De28266709dd2a1d1452d4a5bbf271700e10335c6 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20250313-150626'" -o ./b=
in/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH=
_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"e28266709dd2a1d1452d4a5bbf271700e1=
0335c6\"
/usr/bin/ld: /tmp/cc7kFs5f.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D10d6483f980000


Tested on:

commit:         bfc6c67e net/smc: use the correct ndev to find pnetid ..
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Daeeec842a6bdc8b=
9
dashboard link: https://syzkaller.appspot.com/bug?extid=3D30de9d963fdd95d74=
5f8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D10c6483f9800=
00


