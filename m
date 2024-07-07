Return-Path: <linux-kernel+bounces-243486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 414009296CE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 08:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B720F1F216D0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 06:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EEEAD24;
	Sun,  7 Jul 2024 06:23:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457E93C0B
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 06:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720333385; cv=none; b=GMypV398cmPofayceWvBExmMR1E8PpvQBimeJBTdLTykJIu2r+e/JpmoMFtEbtMANbdB7+LEEgEDUsSyN4Lo1WX55Bhc08OtaWc/Gja2qa4f85GLqefXWpuFo/Oks47NtUKEaPBsE9XeegQSVigbOoJlNpkhtgRqPLXZenLE+2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720333385; c=relaxed/simple;
	bh=yC57IQ3slTDuCWrlOKEjRY0L7+vzHDqEyczUxpJj71Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=insQOmnlegxQSE3ZeebVh5XLVgI8liRBTKspOc/ErGjRLN+d5nF3294V+bRTfUyfQTeBHoFvH+gdzzOglpKTBAxQHy+WYPSnDjNOR6rT6He5bZtMwjw60Gdan3MpDpXx/SUtFwVTJvnu4WBiNz++igJZMqn+CTstRxXMl5EeRBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f6307d584aso352318739f.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 23:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720333382; x=1720938182;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPuPMd83B13CA8PS5d/5z/bglF4sU13i//U1aOFfrsM=;
        b=sRRI99PHQijx1+OsbKM4Q/qMbtU6czEHwYLUzyBGkjXy9HjOW+owSm1kQp9QwApPJi
         y9bD9B4xC2V5lawPeypmnWAfi3dfzZTx4v5r2Wes88lToyF6CRVpBV6vErC75c/wORw/
         1gYZ9/jkIqLXVlsZgZeODoxwrB1p2N2oXMLc0qlrOMo5F3KkSwNiwfWYGzs3eUaxhTyD
         AWrJgvHV6/htjUeX9tCTpdRn9y9CCr0Zyo3lI1clenEfmQT5B4ioOAELvfK//8NtOPXq
         wWjlZiCKocrsQfURT0RcnpoWR7GwNhJAkil7PJtt6WI4EN3W0AaCwiezB4/zmPKIF91k
         oHeg==
X-Forwarded-Encrypted: i=1; AJvYcCWrRLDH61v0VIueeeWf93oY9hDyS4CM28tjR+rbcrTo0Dmuud1BYngL3CSHBLE5tQukA4LczqVQ1xO658uy2w/GZlwLqk2QwP9fE3U4
X-Gm-Message-State: AOJu0YybrvMBiKLY1qW/ih27jmLzaVyhusqHoLlhOvhL+jglaVVDXj2B
	4oKtONgzZRYVhBmwSwCOQJNwfLwYDAZtJWiA/jpQ+Z+XITU36V/fa4K+JUjxGzb7i3tpq0FzUHO
	A0PXXj7gq7J+Cbci9sn1io18LQgDU5Yv9Bh+nJ24gaVzbcVpPDcS0zjM=
X-Google-Smtp-Source: AGHT+IFzMdu3R0PSuw76zDIGF73bWIL/pUvhDFmPyV+mWFbXZuKlkKi8bblJS/8Ih2gOeqZ8oHK+6t7Fb8nQyJ23AJ0d+erS0fA9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1510:b0:7f6:1590:447b with SMTP id
 ca18e2360f4ac-7f66df22089mr34010839f.4.1720333382361; Sat, 06 Jul 2024
 23:23:02 -0700 (PDT)
Date: Sat, 06 Jul 2024 23:23:02 -0700
In-Reply-To: <20240707060028.3261-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000026b72e061ca25485@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in team_del_slave (3)
From: syzbot <syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in team_del_slave

======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc6-syzkaller-00223-gc6653f49e4fd-dirty #0 Not tainted
------------------------------------------------------
kworker/u8:0/11 is trying to acquire lock:
ffff888023258d20 (team->team_lock_key#4){+.+.}-{3:3}, at: team_del_slave+0x32/0x1d0 drivers/net/team/team_core.c:1990

but task is already holding lock:
ffff88801eed0768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: wiphy_lock include/net/cfg80211.h:5966 [inline]
ffff88801eed0768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: ieee80211_remove_interfaces+0x12b/0x6f0 net/mac80211/iface.c:2280

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&rdev->wiphy.mtx){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       wiphy_lock include/net/cfg80211.h:5966 [inline]
       ieee80211_open+0xe7/0x200 net/mac80211/iface.c:449
       __dev_open+0x2d3/0x450 net/core/dev.c:1472
       dev_open+0xae/0x1b0 net/core/dev.c:1508
       team_port_add drivers/net/team/team_core.c:1216 [inline]
       team_add_slave+0x9b3/0x2750 drivers/net/team/team_core.c:1976
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
       ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
       ___sys_sendmsg net/socket.c:2639 [inline]
       __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (team->team_lock_key#4){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       team_del_slave+0x32/0x1d0 drivers/net/team/team_core.c:1990
       team_device_event+0x200/0x5b0 drivers/net/team/team_core.c:2984
       notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
       call_netdevice_notifiers_extack net/core/dev.c:2030 [inline]
       call_netdevice_notifiers net/core/dev.c:2044 [inline]
       unregister_netdevice_many_notify+0xd75/0x16b0 net/core/dev.c:11219
       unregister_netdevice_many net/core/dev.c:11277 [inline]
       unregister_netdevice_queue+0x303/0x370 net/core/dev.c:11156
       unregister_netdevice include/linux/netdevice.h:3119 [inline]
       _cfg80211_unregister_wdev+0x162/0x560 net/wireless/core.c:1206
       ieee80211_remove_interfaces+0x4cd/0x6f0 net/mac80211/iface.c:2305
       ieee80211_unregister_hw+0x5d/0x2c0 net/mac80211/main.c:1659
       mac80211_hwsim_del_radio+0x2c2/0x4c0 drivers/net/wireless/virtual/mac80211_hwsim.c:5576
       hwsim_exit_net+0x5c1/0x670 drivers/net/wireless/virtual/mac80211_hwsim.c:6453
       ops_exit_list net/core/net_namespace.c:173 [inline]
       cleanup_net+0x802/0xcc0 net/core/net_namespace.c:640
       process_one_work kernel/workqueue.c:3248 [inline]
       process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
       worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&rdev->wiphy.mtx);
                               lock(team->team_lock_key#4);
                               lock(&rdev->wiphy.mtx);
  lock(team->team_lock_key#4);

 *** DEADLOCK ***

5 locks held by kworker/u8:0/11:
 #0: ffff888015ed5948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3223 [inline]
 #0: ffff888015ed5948 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3329
 #1: ffffc90000107d00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3224 [inline]
 #1: ffffc90000107d00 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3329
 #2: ffffffff8f5da590 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:594
 #3: ffffffff8f5e6dc8 (rtnl_mutex){+.+.}-{3:3}, at: ieee80211_unregister_hw+0x55/0x2c0 net/mac80211/main.c:1652
 #4: ffff88801eed0768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: wiphy_lock include/net/cfg80211.h:5966 [inline]
 #4: ffff88801eed0768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: ieee80211_remove_interfaces+0x12b/0x6f0 net/mac80211/iface.c:2280

stack backtrace:
CPU: 1 PID: 11 Comm: kworker/u8:0 Not tainted 6.10.0-rc6-syzkaller-00223-gc6653f49e4fd-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 team_del_slave+0x32/0x1d0 drivers/net/team/team_core.c:1990
 team_device_event+0x200/0x5b0 drivers/net/team/team_core.c:2984
 notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
 call_netdevice_notifiers_extack net/core/dev.c:2030 [inline]
 call_netdevice_notifiers net/core/dev.c:2044 [inline]
 unregister_netdevice_many_notify+0xd75/0x16b0 net/core/dev.c:11219
 unregister_netdevice_many net/core/dev.c:11277 [inline]
 unregister_netdevice_queue+0x303/0x370 net/core/dev.c:11156
 unregister_netdevice include/linux/netdevice.h:3119 [inline]
 _cfg80211_unregister_wdev+0x162/0x560 net/wireless/core.c:1206
 ieee80211_remove_interfaces+0x4cd/0x6f0 net/mac80211/iface.c:2305
 ieee80211_unregister_hw+0x5d/0x2c0 net/mac80211/main.c:1659
 mac80211_hwsim_del_radio+0x2c2/0x4c0 drivers/net/wireless/virtual/mac80211_hwsim.c:5576
 hwsim_exit_net+0x5c1/0x670 drivers/net/wireless/virtual/mac80211_hwsim.c:6453
 ops_exit_list net/core/net_namespace.c:173 [inline]
 cleanup_net+0x802/0xcc0 net/core/net_namespace.c:640
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
team0: Port device wlan1 removed
hsr_slave_0: left promiscuous mode
hsr_slave_1: left promiscuous mode
batman_adv: batadv0: Interface deactivated: batadv_slave_0
batman_adv: batadv0: Removing interface: batadv_slave_0
batman_adv: batadv0: Interface deactivated: batadv_slave_1
batman_adv: batadv0: Removing interface: batadv_slave_1
veth1_macvtap: left promiscuous mode
veth0_macvtap: left promiscuous mode
veth1_vlan: left promiscuous mode
veth0_vlan: left promiscuous mode
team0 (unregistering): Port device team_slave_1 removed
team0 (unregistering): Port device team_slave_0 removed
netdevsim netdevsim1 netdevsim3 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim1 netdevsim2 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim1 netdevsim1 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim1 netdevsim0 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim3 netdevsim3 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim3 netdevsim2 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim3 netdevsim1 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim3 netdevsim0 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim3 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim2 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim1 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim0 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
bridge_slave_1: left allmulticast mode
bridge_slave_1: left promiscuous mode
bridge0: port 2(bridge_slave_1) entered disabled state
bridge_slave_0: left allmulticast mode
bridge_slave_0: left promiscuous mode
bridge0: port 1(bridge_slave_0) entered disabled state
bridge_slave_1: left allmulticast mode
bridge_slave_1: left promiscuous mode
bridge0: port 2(bridge_slave_1) entered disabled state
bridge_slave_0: left allmulticast mode
bridge_slave_0: left promiscuous mode
bridge0: port 1(bridge_slave_0) entered disabled state
bridge_slave_1: left allmulticast mode
bridge_slave_1: left promiscuous mode
bridge0: port 2(bridge_slave_1) entered disabled state
bridge_slave_0: left allmulticast mode
bridge_slave_0: left promiscuous mode
bridge0: port 1(bridge_slave_0) entered disabled state
bridge_slave_1: left allmulticast mode
bridge_slave_1: left promiscuous mode
bridge0: port 2(bridge_slave_1) entered disabled state
bridge_slave_0: left allmulticast mode
bridge_slave_0: left promiscuous mode
bridge0: port 1(bridge_slave_0) entered disabled state
bond0 (unregistering): (slave bond_slave_0): Releasing backup interface
bond0 (unregistering): (slave bond_slave_1): Releasing backup interface
bond0 (unregistering): Released all slaves
bond0 (unregistering): (slave bond_slave_0): Releasing backup interface
bond0 (unregistering): (slave bond_slave_1): Releasing backup interface
bond0 (unregistering): Released all slaves
bond0 (unregistering): (slave bond_slave_0): Releasing backup interface
bond0 (unregistering): (slave bond_slave_1): Releasing backup interface
bond0 (unregistering): Released all slaves
bond0 (unregistering): (slave bond_slave_0): Releasing backup interface
bond0 (unregistering): (slave bond_slave_1): Releasing backup interface
bond0 (unregistering): Released all slaves
team0: Port device wlan1 removed
team0: Port device wlan1 removed
team0: Port device wlan1 removed
team0: Port device wlan1 removed
hsr_slave_0: left promiscuous mode
hsr_slave_1: left promiscuous mode
batman_adv: batadv0: Interface deactivated: batadv_slave_0
batman_adv: batadv0: Removing interface: batadv_slave_0
batman_adv: batadv0: Interface deactivated: batadv_slave_1
batman_adv: batadv0: Removing interface: batadv_slave_1
hsr_slave_0: left promiscuous mode
hsr_slave_1: left promiscuous mode
batman_adv: batadv0: Interface deactivated: batadv_slave_0
batman_adv: batadv0: Removing interface: batadv_slave_0
batman_adv: batadv0: Interface deactivated: batadv_slave_1
batman_adv: batadv0: Removing interface: batadv_slave_1
hsr_slave_0: left promiscuous mode
hsr_slave_1: left promiscuous mode
batman_adv: batadv0: Interface deactivated: batadv_slave_0
batman_adv: batadv0: Removing interface: batadv_slave_0
batman_adv: batadv0: Interface deactivated: batadv_slave_1
batman_adv: batadv0: Removing interface: batadv_slave_1
hsr_slave_0: left promiscuous mode
hsr_slave_1: left promiscuous mode
batman_adv: batadv0: Interface deactivated: batadv_slave_0
batman_adv: batadv0: Removing interface: batadv_slave_0
batman_adv: batadv0: Interface deactivated: batadv_slave_1
batman_adv: batadv0: Removing interface: batadv_slave_1
veth1_macvtap: left promiscuous mode
veth0_macvtap: left promiscuous mode
veth1_vlan: left promiscuous mode
veth0_vlan: left promiscuous mode
veth1_macvtap: left promiscuous mode
veth0_macvtap: left promiscuous mode
veth1_vlan: left promiscuous mode
veth0_vlan: left promiscuous mode
veth1_macvtap: left promiscuous mode
veth0_macvtap: left promiscuous mode
veth1_vlan: left promiscuous mode
veth0_vlan: left promiscuous mode
veth1_macvtap: left promiscuous mode
veth0_macvtap: left promiscuous mode
veth1_vlan: left promiscuous mode
veth0_vlan: left promiscuous mode
team0 (unregistering): Port device team_slave_1 removed
team0 (unregistering): Port device team_slave_0 removed
team0 (unregistering): Port device team_slave_1 removed
team0 (unregistering): Port device team_slave_0 removed
team0 (unregistering): Port device team_slave_1 removed
team0 (unregistering): Port device team_slave_0 removed
team0 (unregistering): Port device team_slave_1 removed
team0 (unregistering): Port device team_slave_0 removed


Tested on:

commit:         c6653f49 Merge tag 'powerpc-6.10-4' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1037d4a5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=864caee5f78cab51
dashboard link: https://syzkaller.appspot.com/bug?extid=705c61d60b091ef42c04
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1063e781980000


