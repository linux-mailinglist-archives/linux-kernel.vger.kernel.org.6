Return-Path: <linux-kernel+bounces-348203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC7D98E40E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3C711C2245F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00333216A2F;
	Wed,  2 Oct 2024 20:19:28 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7898286A
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 20:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727900367; cv=none; b=K8gs6BSmpkyRet9zthAIELUH3z8Gw9I1aIlBibNfYTITMqp3xrf9G4T3nkX35twZos90966Li7b0seJ17WaKuIbiS5C/kWcaX3dSjk1YdrmGjWP10jx1t1+p1ZXcqSWi2IUvQ9AomwQ289mKWQ/P8dfi1JXGi7lWmbAgDN1pPYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727900367; c=relaxed/simple;
	bh=Ous/yP2QAC/57+hxw8EjxqIlqZ806JD7xQABPlhprRk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=D5H+gA1/KjQZ7Atv6v4LrngDpWHB8ckKZ++ULz1NwHM72pyvS45QIYJwinxAy6I4aBapqubPCw3WcOzQtlDQZXpRmE3PKxndpz61LcQ2qUAKZzJqQviR429uQj/Hj4ViyQ6H73ZmUq3Js7Lfn/OZ4V6wjmKitKCzHqucWuptZVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a2762bfcbbso2719205ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 13:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727900365; x=1728505165;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3PFkAPPKwfTQWiVZb5ZOx5qOX0H/RJSBzFS6dCYqRuo=;
        b=qR7b4634LBVpvn6Z8ZZb1HHjwNUsHGVvOz59fo5fwH6K0J8ZpNl4709rDglohSLWvF
         A8GrkFu8miltvk1fMu4Iiy2zXW7/aEAm5OkJthxZ2+Z+7oDyzAuUnWK/RYVbqPDEA9US
         0xPKg5u+B5r9WwuX3ndvNCYSTllFOhUakPaUvviKmJNVkwaOojfle8PRinmYv+RjmO/h
         IfPyrppo924yRQ+V6BYMbrpHRBrQsBa9jh/DNHx7C1HyXGbhLBDCcv/GkFuYkaGjlaye
         3ZNCXJVT1hFUdqdIwRSlff87PEMOOObp/rpDFcTPISsPMW1dVp1PyZMXADYB/FPFythc
         SrYA==
X-Forwarded-Encrypted: i=1; AJvYcCWYBwhNqc3ZF26YtDxWqbT5/ui1KNKj56nHFbwVOvmmTxeWOgQERUWXftdKjqdFNSkZdMrCsS7FjyehD1U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz50kFTEdDmmt0Q5xE02MoynUMVmygO2wC/amc9Rmz6Qy0X/Une
	k0F2HdXA5tiodNS52+sqLpf0JIDXYI/tfeUSWt1cbk841bctvRnEdPltrAO23G3S1X/5VFhTNvP
	qJrqWG0YhmMqnUjEEKDprcD283psJRin1pVelMtJuV3xls8lki6QLBPU=
X-Google-Smtp-Source: AGHT+IGSCHZ2qmL4P8hsojoVJiai/t2SaXYnyuZpjgm6vWOIeXXdW9A0w6ygjc+Wi6TRaWLxoB829FArc5YIXlWOor1+9xjbM3+C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c03:b0:39f:93a7:e788 with SMTP id
 e9e14a558f8ab-3a3659135dfmr48707985ab.2.1727900364931; Wed, 02 Oct 2024
 13:19:24 -0700 (PDT)
Date: Wed, 02 Oct 2024 13:19:24 -0700
In-Reply-To: <66fa2708.050a0220.aab67.0025.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fdaacc.050a0220.40bef.0023.GAE@google.com>
Subject: Re: [syzbot] [wireguard?] INFO: task hung in wg_destruct (2)
From: syzbot <syzbot+7da6c19dc528c2ebc612@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, davem@davemloft.net, edumazet@google.com, jason@zx2c4.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    e32cde8d2bd7 Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1670339f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=286b31f2cf1c36b5
dashboard link: https://syzkaller.appspot.com/bug?extid=7da6c19dc528c2ebc612
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=146ae580580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f7f2dc1bf47b/disk-e32cde8d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/063e4eafb554/vmlinux-e32cde8d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7ce38bae7b74/bzImage-e32cde8d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7da6c19dc528c2ebc612@syzkaller.appspotmail.com

INFO: task kworker/u8:5:1092 blocked for more than 145 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00031-ge32cde8d2bd7 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:5    state:D stack:22072 pid:1092  tgid:1092  ppid:2      flags:0x00004000
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 wg_destruct+0x25/0x2e0 drivers/net/wireguard/device.c:246
 netdev_run_todo+0xe1a/0x1000 net/core/dev.c:10805
 default_device_exit_batch+0xa24/0xaa0 net/core/dev.c:11945
 ops_exit_list net/core/net_namespace.c:178 [inline]
 cleanup_net+0x89d/0xcc0 net/core/net_namespace.c:626
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task dhcpcd:4899 blocked for more than 153 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00031-ge32cde8d2bd7 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:dhcpcd          state:D stack:20352 pid:4899  tgid:4899  ppid:4898   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 rtnl_lock net/core/rtnetlink.c:79 [inline]
 rtnl_dumpit+0x99/0x200 net/core/rtnetlink.c:6505
 netlink_dump+0x647/0xd80 net/netlink/af_netlink.c:2325
 __netlink_dump_start+0x5a2/0x790 net/netlink/af_netlink.c:2440
 netlink_dump_start include/linux/netlink.h:339 [inline]
 rtnetlink_dump_start net/core/rtnetlink.c:6535 [inline]
 rtnetlink_rcv_msg+0xb3d/0xcf0 net/core/rtnetlink.c:6602
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:744
 __sys_sendto+0x39b/0x4f0 net/socket.c:2209
 __do_sys_sendto net/socket.c:2221 [inline]
 __se_sys_sendto net/socket.c:2217 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2217
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f33cf298ad7
RSP: 002b:00007ffdc403cb38 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007ffdc403dc60 RCX: 00007f33cf298ad7
RDX: 0000000000000014 RSI: 00007ffdc403db80 RDI: 0000000000000013
RBP: 00007ffdc403dbf0 R08: 00007ffdc403db64 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000012
R13: 00007ffdc403db64 R14: 00007ffdc403db80 R15: 0000000000000105
 </TASK>

Showing all locks held in the system:
6 locks held by kworker/0:0/8:
1 lock held by khungtaskd/30:
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6720
3 locks held by kworker/u8:3/52:
5 locks held by kworker/u9:0/54:
 #0: ffff888064184948 ((wq_completion)hci2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff888064184948 ((wq_completion)hci2){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90000bf7d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90000bf7d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffff888028a88d80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x1ec/0x400 net/bluetooth/hci_sync.c:327
 #3: ffff888028a88078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x1ea/0xde0 net/bluetooth/hci_sync.c:5567
 #4: ffffffff8fe3dfa8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1957 [inline]
 #4: ffffffff8fe3dfa8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x15d/0x300 net/bluetooth/hci_conn.c:1262
1 lock held by kswapd0/88:
1 lock held by kswapd1/89:
3 locks held by kworker/1:2/937:
 #0: ffff88801ac81948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac81948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90003907d00 ((reg_check_chans).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90003907d00 ((reg_check_chans).work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: reg_check_chans_work+0x99/0xfd0 net/wireless/reg.c:2480
4 locks held by kworker/u8:5/1092:
 #0: ffff88801baed948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801baed948 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90003e07d00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90003e07d00 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcc4c50 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:580
 #3: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: wg_destruct+0x25/0x2e0 drivers/net/wireguard/device.c:246
3 locks held by kworker/u8:6/2919:
3 locks held by kworker/u8:8/3822:
 #0: ffff88802d6e7148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88802d6e7148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc9000bd0fd00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc9000bd0fd00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xd0/0x16f0 net/ipv6/addrconf.c:4196
2 locks held by syslogd/4667:
1 lock held by klogd/4674:
4 locks held by udevd/4685:
2 locks held by dhcpcd/4899:
 #0: ffff8880245f86c8 (nlk_cb_mutex-ROUTE){+.+.}-{3:3}, at: __netlink_dump_start+0x119/0x790 net/netlink/af_netlink.c:2404


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

