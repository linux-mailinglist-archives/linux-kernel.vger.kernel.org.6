Return-Path: <linux-kernel+bounces-395753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 380BD9BC269
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 02:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4629282F7B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 01:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179051CF96;
	Tue,  5 Nov 2024 01:19:28 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A66C18EAB
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 01:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730769567; cv=none; b=CI7O3CAb/Z4Hoz2LGDX7SYEGY+cvQLd3SQoeuPRxke4ZhrPdyjyaye25Mz960JbqqCqYMg06wRGCUAmY9EbeTjtQI/eGAGh7P6Db3C0wClBDficadodfH5RDsTEWf0GBy8FbUsG3L6+dciw/rKVwcka+V7LrVSBJPKzVJLDmWOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730769567; c=relaxed/simple;
	bh=5cDGxqb5PL2dnXfhthFkjbB0NA18TlNyE/JRzzme2zg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LWnyRQ2IDKYPqESumYR/iMFBG6wfsYmsGMkwkBbcsDdoBcG4jAN36mjgXxDDTn85LP3ASkaJ9ed44s3Sm9EL9YYXBAWi1ltpxQBooqtS0y8kf5HOlqPIp2EqBo/dHHP9Ott+OEgmv5q7JJk7SO2GT0z5Jmns4v/ViTHSvUhzlx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a6b963ca02so34236005ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 17:19:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730769565; x=1731374365;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hM4FdiCO1/FkeuPlUpxbqHon8yx/aa1NcneBzFYuH6g=;
        b=e/Rym4/hmSpkjfiRUO5T5NB0Wkm8BMl4hMmRe9NO/g6s/GHtZi5FLwylPLCe4VRBeA
         eyQMTegIssq0b6dJLPVmYjZxROCNHeVfr5tnnry7XUBlavG/vMbb9fOlmrqd5YNDg1m1
         ux0JGDt0ChYTTDxXYts3bCRJl7F4+3/qYW0npM1OI13gIPgNSVTwGttBc7PLZsxmXYQs
         FJrjuIAcvf5KDtb9WYlW6s3YADJMuFKRLDsOsmsXAxdPxrIu3U41lSO1kHE+BuF2ozq9
         GmpTz7MRF5zALe8IYQGbWd3odzXiVRdV9VW/pvWhQ4r4UlJN8qK+YiFXg0As3/OvFoxo
         8k5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWX85MaHn/YENA1kA+zY0sjPa7iqOE6JEqNhnFG2Oyif7C3oWrKQ3XxuHnphnziz1nhe3eLvuDH/wWAS+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfpXnLtQRzBdbd2mMBR1RH/y+bfXWSP8uBiZTxc9OxzFwa0DBO
	DeEPldClqIWvNcnBwCmrDw14ckpldwldE9wqq8Y7g5SqP7+r6YlMfJr0V3L9OqWe+U/BH3CUjLE
	w2zviP0TK0jZQ9y9ZDHfu7ZDFqc1W5YSKXMmvDvCtACUyblUb0r0KiNY=
X-Google-Smtp-Source: AGHT+IGTchSHQS+dhxI+dsdTyQ58bL2OulPkVjhT/qAzyAbHdPEYA7BpswuV+A2bCbdY6BWjgATbxYRp+6o5xgFqX08H+LKQWjGD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e09:b0:3a4:eccc:aa5c with SMTP id
 e9e14a558f8ab-3a609a2afbfmr180266535ab.5.1730769564742; Mon, 04 Nov 2024
 17:19:24 -0800 (PST)
Date: Mon, 04 Nov 2024 17:19:24 -0800
In-Reply-To: <6706d42c.050a0220.1139e6.000b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6729729c.050a0220.701a.0012.GAE@google.com>
Subject: Re: [syzbot] [nfs?] INFO: task hung in nfsd_nl_threads_set_doit
From: syzbot <syzbot+e7baeb70aa00c22ed45e@syzkaller.appspotmail.com>
To: Dai.Ngo@oracle.com, anna@kernel.org, chuck.lever@oracle.com, 
	dai.ngo@oracle.com, davem@davemloft.net, edumazet@google.com, 
	jlayton@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, neilb@suse.de, netdev@vger.kernel.org, 
	okorniev@redhat.com, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tom@talpey.com, trondmy@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    5ccdcdf186ae net: xilinx: axienet: Enqueue Tx packets in d..
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10bd6587980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=672325e7ab17fdf7
dashboard link: https://syzkaller.appspot.com/bug?extid=e7baeb70aa00c22ed45e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13526d5f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1654a740580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/61afb2d2686a/disk-5ccdcdf1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4d4a40c7af1b/vmlinux-5ccdcdf1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/178187e5e136/bzImage-5ccdcdf1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e7baeb70aa00c22ed45e@syzkaller.appspotmail.com

INFO: task syz-executor112:5858 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc5-syzkaller-00184-g5ccdcdf186ae #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor112 state:D stack:24432 pid:5858  tgid:5858  ppid:5856   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x18af/0x4bd0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6782
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6839
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 nfsd_nl_threads_set_doit+0x2bb/0x980 fs/nfsd/nfsctl.c:1671
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2551
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:744
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2607
 ___sys_sendmsg net/socket.c:2661 [inline]
 __sys_sendmsg+0x292/0x380 net/socket.c:2690
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7003248da9
RSP: 002b:00007fff732a9b58 EFLAGS: 00000206 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7003248da9
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000005
RBP: 00000000000f4240 R08: 00000000000000a0 R09: 00000000000000a0
R10: 00000000000000a0 R11: 0000000000000206 R12: 0000000000000001
R13: 00007fff732a9d78 R14: 00007fff732a9b80 R15: 00007fff732a9b70
 </TASK>
INFO: task syz-executor112:5860 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc5-syzkaller-00184-g5ccdcdf186ae #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor112 state:D stack:26528 pid:5860  tgid:5860  ppid:5857   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x18af/0x4bd0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6782
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6839
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 nfsd_nl_threads_set_doit+0x2bb/0x980 fs/nfsd/nfsctl.c:1671
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2551
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:744
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2607
 ___sys_sendmsg net/socket.c:2661 [inline]
 __sys_sendmsg+0x292/0x380 net/socket.c:2690
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7003248da9
RSP: 002b:00007fff732a9b58 EFLAGS: 00000206 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7003248da9
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000005
RBP: 00000000000f4240 R08: 00000000000000a0 R09: 00000000000000a0
R10: 00000000000000a0 R11: 0000000000000206 R12: 0000000000000001
R13: 00007fff732a9d78 R14: 00007fff732a9b80 R15: 00007fff732a9b70
 </TASK>
INFO: task syz-executor112:5862 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc5-syzkaller-00184-g5ccdcdf186ae #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor112 state:D stack:26776 pid:5862  tgid:5862  ppid:5859   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x18af/0x4bd0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6782
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6839
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 nfsd_nl_threads_set_doit+0x2bb/0x980 fs/nfsd/nfsctl.c:1671
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2551
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:744
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2607
 ___sys_sendmsg net/socket.c:2661 [inline]
 __sys_sendmsg+0x292/0x380 net/socket.c:2690
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7003248da9
RSP: 002b:00007fff732a9b58 EFLAGS: 00000206 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7003248da9
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000005
RBP: 00000000000f4240 R08: 00000000000000a0 R09: 00000000000000a0
R10: 00000000000000a0 R11: 0000000000000206 R12: 0000000000000001
R13: 00007fff732a9d78 R14: 00007fff732a9b80 R15: 00007fff732a9b70
 </TASK>
INFO: task syz-executor112:5865 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc5-syzkaller-00184-g5ccdcdf186ae #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor112 state:D stack:26776 pid:5865  tgid:5865  ppid:5863   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x18af/0x4bd0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6782
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6839
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 nfsd_nl_threads_set_doit+0x2bb/0x980 fs/nfsd/nfsctl.c:1671
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2551
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:744
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2607
 ___sys_sendmsg net/socket.c:2661 [inline]
 __sys_sendmsg+0x292/0x380 net/socket.c:2690
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7003248da9
RSP: 002b:00007fff732a9b58 EFLAGS: 00000206 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7003248da9
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000005
RBP: 00000000000f4240 R08: 00000000000000a0 R09: 00000000000000a0
R10: 00000000000000a0 R11: 0000000000000206 R12: 0000000000000001
R13: 00007fff732a9d78 R14: 00007fff732a9b80 R15: 00007fff732a9b70
 </TASK>

Showing all locks held in the system:
6 locks held by kworker/u8:0/11:
1 lock held by khungtaskd/30:
 #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6720
2 locks held by getty/5593:
 #0: ffff88814d8630a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
2 locks held by syz-executor112/5858:
 #0: ffffffff8fd39210 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8ec19288 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_threads_set_doit+0x2bb/0x980 fs/nfsd/nfsctl.c:1671
2 locks held by syz-executor112/5860:
 #0: ffffffff8fd39210 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8ec19288 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_threads_set_doit+0x2bb/0x980 fs/nfsd/nfsctl.c:1671
2 locks held by syz-executor112/5862:
 #0: ffffffff8fd39210 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8ec19288 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_threads_set_doit+0x2bb/0x980 fs/nfsd/nfsctl.c:1671
2 locks held by syz-executor112/5864:
 #0: ffffffff8fd39210 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8ec19288 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_threads_set_doit+0x2bb/0x980 fs/nfsd/nfsctl.c:1671
2 locks held by syz-executor112/5865:
 #0: ffffffff8fd39210 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8ec19288 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_threads_set_doit+0x2bb/0x980 fs/nfsd/nfsctl.c:1671

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-rc5-syzkaller-00184-g5ccdcdf186ae #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xff4/0x1040 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
NMI backtrace for cpu 0 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:106 [inline]
NMI backtrace for cpu 0 skipped: idling at acpi_safe_halt+0x21/0x30 drivers/acpi/processor_idle.c:111


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

