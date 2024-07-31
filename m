Return-Path: <linux-kernel+bounces-269172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5873D942EC2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C36E28D01E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A781AE87A;
	Wed, 31 Jul 2024 12:40:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7CF193072
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 12:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722429605; cv=none; b=Ljoa1k1bkMSo3+DbBzoRCSqSol6umxBWRAAFhTuDluLHWb0EA4FdBtzy27OI3doQjW0zxy+XfPDfSIs+lcXhWvFoo7oXymIkl1BsafvlO0CQrAttGrabJuFH5RLD5njyfWVHv7/Tb2CEaF8xwAFSBEFJFE9RH8MWvYSo/lVxHTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722429605; c=relaxed/simple;
	bh=T+EgHEdkR3Noqfi1e8/yMR3oenEEM9Rg5fyeDX5rVlY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DV+ndaIR64ym/vnZ9ZRNLBVQxpKYNPkDVOI9OzjnJP4gaaFuEFnc2OT2aqnoa2oI7slijCqD4hefsu8H8QfcBhCAQYbWJoAItxDv6U7k/agUyi1KdD6faI68j4KKZGuxxt5zG3/G6cHqK2uTG+hTMq4FZ1fmViCPklKkXkAIrFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39a143db6c4so86624365ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 05:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722429602; x=1723034402;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5rNk1hlcKQhsUhcuEJet20WQtchdIn8f87TgjaSrjLM=;
        b=VagVgtl9jlah1PfWedki0Rxs8Qk/mxogJ2ShaH98M0hJcs9mTxvRCl0FCibqnfwYem
         S916ChcqEvUNt1417YQWR5jtt2Z6ysCrw7adJqpIFOURg1+SWAgNZWb6MCJHSTwkEuDp
         JoPeZFytEQAMx1dBPHN7DnM1Czwk855wCv3SFhHrYRzLTy59rf8FRo8aB5DPionJnfmh
         9Bo4WmSIl/cCAg9BlibiwYN2PS6Ld9nWXwgdpXxcQkdoOcMN0Xm4mKf3kFT9adX4xRxV
         VkLJ7RX69JjeFZFIKRnIpalN7S9zxPR4a471SZ4RN4ofARXll1F0ORqgxWcnjmY8DIRn
         BpSA==
X-Forwarded-Encrypted: i=1; AJvYcCUxZSu0I0nCwd8JYmfC3jdm4GA+OxHHkQjJfZUHAG+Vtg2FJ2RzX1zjAVAoXaL8ajOfLRyMRbFbMu7CE7oErYQqUo4Vhh8zfDfF6bSF
X-Gm-Message-State: AOJu0Yyv50u9yFTgsGseG26AKIL2WkinYwFUh08Cw9yeo1lC1nyKfY34
	ZID4erilflnBYOl32p7PKPXQe5WIqduxr4Z6BtxDK1Q1vvs3v1eRiGV6EIjEbnVDy1CPUOvDzpB
	I/ms35piN1bZCoq7RfpadxRmVcnP6FXevk00ndYFzvlw/nJGxbfHz2ds=
X-Google-Smtp-Source: AGHT+IGcScNwIHmND0lWRhcKoHylpSKg8EoeA3BJxWeWB3LKf0AwUefhWqSWg9uU70bP/4apl30w+3Xci87PV2w8My7sAvr0JXT/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c09:b0:381:c5f0:20ef with SMTP id
 e9e14a558f8ab-39aec24d019mr11770725ab.0.1722429602370; Wed, 31 Jul 2024
 05:40:02 -0700 (PDT)
Date: Wed, 31 Jul 2024 05:40:02 -0700
In-Reply-To: <20240731121721.9000-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000099a718061e8a6449@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in team_device_event (3)
From: syzbot <syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in linkwatch_event

INFO: task kworker/2:0:25 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc1-syzkaller-ge4fc196f5ba3-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/2:0     state:D stack:26400 pid:25    tgid:25    ppid:2      flags:0x00004000
Workqueue: events linkwatch_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xe37/0x5490 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 linkwatch_event+0x51/0xc0 net/core/link_watch.c:276
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/1:1:57 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc1-syzkaller-ge4fc196f5ba3-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:1     state:D stack:24608 pid:57    tgid:57    ppid:2      flags:0x00004000
Workqueue: events_power_efficient crda_timeout_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xe37/0x5490 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 crda_timeout_work+0x15/0x50 net/wireless/reg.c:540
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/u32:3:64 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc1-syzkaller-ge4fc196f5ba3-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u32:3   state:D stack:24640 pid:64    tgid:64    ppid:2      flags:0x00004000
Workqueue: ipv6_addrconf addrconf_dad_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xe37/0x5490 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 addrconf_dad_work+0xcf/0x1500 net/ipv6/addrconf.c:4194
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task syz.0.15:5887 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc1-syzkaller-ge4fc196f5ba3-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.15        state:D stack:23008 pid:5887  tgid:5886  ppid:5764   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xe37/0x5490 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 team_port_change_check+0x7f/0x1a0 drivers/net/team/team_core.c:2951
 team_device_event+0x20c/0x520 drivers/net/team/team_core.c:2976
 notifier_call_chain+0xb9/0x410 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1994
 call_netdevice_notifiers_extack net/core/dev.c:2032 [inline]
 call_netdevice_notifiers net/core/dev.c:2046 [inline]
 __dev_notify_flags+0x12d/0x2e0 net/core/dev.c:8876
 dev_change_flags+0x10c/0x160 net/core/dev.c:8914
 vlan_device_event+0xdfc/0x2120 net/8021q/vlan.c:468
 notifier_call_chain+0xb9/0x410 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1994
 call_netdevice_notifiers_extack net/core/dev.c:2032 [inline]
 call_netdevice_notifiers net/core/dev.c:2046 [inline]
 dev_open net/core/dev.c:1515 [inline]
 dev_open+0x144/0x160 net/core/dev.c:1503
 team_port_add drivers/net/team/team_core.c:1216 [inline]
 team_add_slave+0xacd/0x20e0 drivers/net/team/team_core.c:1977
 do_set_master+0x1bc/0x230 net/core/rtnetlink.c:2701
 do_setlink+0xcaf/0x3ff0 net/core/rtnetlink.c:2907
 __rtnl_newlink+0xc35/0x1960 net/core/rtnetlink.c:3696
 rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3743
 rtnetlink_rcv_msg+0x3c7/0xea0 net/core/rtnetlink.c:6647
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x544/0x830 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0xab5/0xc90 net/socket.c:2597
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2651
 __sys_sendmsg+0x117/0x1f0 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8e94977299
RSP: 002b:00007f8e95812048 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f8e94b05f80 RCX: 00007f8e94977299
RDX: 0000000000000000 RSI: 0000000020000600 RDI: 0000000000000012
RBP: 00007f8e949e48e6 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f8e94b05f80 R15: 00007ffd3b89c138
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/2:0/25:
 #0: ffff888015888948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc9000083fd80 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: ffffffff8fa1f4e8 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0x51/0xc0 net/core/link_watch.c:276
1 lock held by khungtaskd/40:
 #0: ffffffff8ddb53a0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #0: ffffffff8ddb53a0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff8ddb53a0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6620
3 locks held by kworker/1:1/57:
 #0: ffff888015889948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc90000a97d80 ((crda_timeout).work){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: ffffffff8fa1f4e8 (rtnl_mutex){+.+.}-{3:3}, at: crda_timeout_work+0x15/0x50 net/wireless/reg.c:540
3 locks held by kworker/u32:3/64:
 #0: ffff88802a7d5948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc90000d17d80 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: ffffffff8fa1f4e8 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xcf/0x1500 net/ipv6/addrconf.c:4194
5 locks held by kworker/u32:5/333:
1 lock held by klogd/4811:
 #0: ffff88806b33edd8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:560
2 locks held by getty/5134:
 #0: ffff88801c27b0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900000cd2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc8/0x1490 drivers/tty/n_tty.c:2211
3 locks held by kworker/2:4/5730:
 #0: ffff888015889948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc9000315fd80 ((reg_check_chans).work){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: ffffffff8fa1f4e8 (rtnl_mutex){+.+.}-{3:3}, at: reg_check_chans_work+0x84/0x1140 net/wireless/reg.c:2480
3 locks held by syz.0.15/5887:
 #0: ffffffff8fa1f4e8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fa1f4e8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
 #1: ffff8880414c8d40 (team->team_lock_key#4){+.+.}-{3:3}, at: team_add_slave+0x9c/0x20e0 drivers/net/team/team_core.c:1976
 #2: ffff8880414c8d40 (team->team_lock_key#4/1){+.+.}-{3:3}, at: team_port_change_check+0x7f/0x1a0 drivers/net/team/team_core.c:2951
1 lock held by syz-executor/5889:
 #0: ffffffff8fa1f4e8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fa1f4e8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/5893:
 #0: ffffffff8fa1f4e8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fa1f4e8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/5905:
 #0: ffffffff8fa1f4e8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fa1f4e8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 40 Comm: khungtaskd Not tainted 6.11.0-rc1-syzkaller-ge4fc196f5ba3-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xf4e/0x1280 kernel/hung_task.c:379
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1-3:
NMI backtrace for cpu 2
CPU: 2 UID: 0 PID: 4804 Comm: syslogd Not tainted 6.11.0-rc1-syzkaller-ge4fc196f5ba3-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:unwind_next_frame+0x5b2/0x23a0 arch/x86/kernel/unwind_orc.c:505
Code: 8b 44 24 28 41 8b 96 b8 03 00 00 4c 89 e1 4c 89 ee 48 89 c7 e8 bf ee ff ff 48 85 c0 49 89 c4 0f 84 99 fd ff ff e8 7e 96 4d 00 <4d> 8d 6c 24 05 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03
RSP: 0018:ffffc9000d1a7540 EFLAGS: 00000293
RAX: 0000000000000000 RBX: ffffc9000d1a75c0 RCX: ffffffff813cd424
RDX: ffff888024858000 RSI: ffffffff813ce4b2 RDI: 0000000000000006
RBP: 0000000000000001 R08: 0000000000000006 R09: ffffffff89b154bf
R10: ffffffff89b154ca R11: 0000000000000000 R12: ffffffff913c6232
R13: ffffffff913c6202 R14: 00000000001a8903 R15: ffffc9000d1a75f5
FS:  00007f451a8d2500(0000) GS:ffff88806b200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7c57dc2270 CR3: 0000000023742000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 arch_stack_walk+0x100/0x170 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x95/0xd0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2252 [inline]
 slab_free mm/slub.c:4473 [inline]
 kmem_cache_free+0x12f/0x3a0 mm/slub.c:4548
 kfree_skbmem+0x10e/0x200 net/core/skbuff.c:1146
 __kfree_skb net/core/skbuff.c:1203 [inline]
 consume_skb net/core/skbuff.c:1426 [inline]
 consume_skb+0xdd/0x170 net/core/skbuff.c:1420
 __unix_dgram_recvmsg+0x821/0xe50 net/unix/af_unix.c:2527
 unix_dgram_recvmsg+0xd0/0x110 net/unix/af_unix.c:2544
 sock_recvmsg_nosec net/socket.c:1046 [inline]
 sock_recvmsg+0x1f6/0x250 net/socket.c:1068
 sock_read_iter+0x2c7/0x3c0 net/socket.c:1138
 new_sync_read fs/read_write.c:395 [inline]
 vfs_read+0xa39/0xbd0 fs/read_write.c:476
 ksys_read+0x1f8/0x260 fs/read_write.c:619
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f451aa26b6a
Code: 00 3d 00 00 41 00 75 0d 50 48 8d 3d 2d 08 0a 00 e8 ea 7d 01 00 31 c0 e9 07 ff ff ff 64 8b 04 25 18 00 00 00 85 c0 75 1b 0f 05 <48> 3d 00 f0 ff ff 76 6c 48 8b 15 8f a2 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007fff6eb8ac08 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f451aa26b6a
RDX: 00000000000000ff RSI: 0000555bf9044300 RDI: 0000000000000000
RBP: 0000555bf90442c0 R08: 0000000000000001 R09: 0000000000000000
R10: 00007f451abc53a3 R11: 0000000000000246 R12: 0000555bf9044353
R13: 0000555bf9044300 R14: 0000000000000000 R15: 00007f451ac09a80
 </TASK>
NMI backtrace for cpu 3 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
NMI backtrace for cpu 3 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:106 [inline]
NMI backtrace for cpu 3 skipped: idling at default_idle+0xf/0x20 arch/x86/kernel/process.c:742
NMI backtrace for cpu 1 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
NMI backtrace for cpu 1 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:106 [inline]
NMI backtrace for cpu 1 skipped: idling at default_idle+0xf/0x20 arch/x86/kernel/process.c:742


Tested on:

commit:         e4fc196f Merge tag 'for-6.11-rc1-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=178dbcd3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7c04fc17f2c61c03
dashboard link: https://syzkaller.appspot.com/bug?extid=b668da2bc4cb9670bf58
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1084416d980000


