Return-Path: <linux-kernel+bounces-362000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3A899AFD6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 03:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 117801C2155A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 01:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64217C2FD;
	Sat, 12 Oct 2024 01:20:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F63A92D
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 01:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728696005; cv=none; b=k81wYdEYL76v9RURq86H2Pn9J5VBgq4Z6QZNptqfaKwxzT74E8dWAeSHAMIAc8aiHdKhHRb/f78Fk+WVj0HM13BkfTFoywonS5bW6ohIQC1m2vgp8EIf5fWVGO2tdi8kqtCbhEzIl7r956FJVTS0yCNk1RYxOwpmTK9l1+U8I5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728696005; c=relaxed/simple;
	bh=YPZxEr/XGog3NdH303jqUeAnVhI+VMXmZP1P3NtRnNg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sYKkNS2y0gCwdLUd53PT2ski0tOsPFGZ4Ex4sFhCdM6/iNvcZQdwHaZnZP0lNf9s1iUj5vpH/+SorHSotZmcq/wRiYS+8EOtVF4+qpL5cD+yRaKbNFCOuKF7JEKAg9AXIfJytBGrEfbVEb7mknePLmWOxNkrxbUinO+WfYOcmhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3b506c87cso12678975ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 18:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728696002; x=1729300802;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QXBa7PU1BjBXggQLrmpfsCNIeAICTCPCuX6qMIRNMyE=;
        b=F2b7lXhCrRW2aY+0JWuEvSaatUHWjcXlwAw7lNQKrXlBJzdElb219QV6KPovq6pa5/
         9+7JA8U+JgK+MGkb8MhUqotC1NpmXxb7VCYFaRfRyE25Sgi0Ou5mjH58KcGFl0p0FBND
         E8GSZnGsLHCqPqBGJ5kdT0/lWuAD+HfcaY7fKUH6HDZqHSpd9piC3GMXktSl6XbKpGBF
         Wqvvcnyl49ONJaHtboIvbvkjxD/otWWVOyY/lLyni6T/50qLvVrRkLZMkJC0pkLifoL1
         fqB4vI1Ce3mjY7lfJgCBNNFLW8fCNFBblok/xgvqmRESX9pHFTCemEYjDU/y9a1Rk3Gq
         g93Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/9vd+iIsLYNYp08HT8co58BH1R66orGv5Ri8ZYaQeq3Li1tSrVQiXiqjETou3oJY1PgQvjwSlE0xcX9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxACboWyz7JMCX82GczDJ5My3cP3/JFuh/2TP0bQ3e5hFATMcfc
	KQSRm2hzu3mVMDvD88wZhrfuk8TOxG9fSchfVO89a5xboOritQ5wdaJO0RguC3yYwwsxMn8agM6
	8zOdQJjnYjoijJ0ZCGNrTsSKxtXpAdllOfEDjGKnEOlX6aQzkKyQP1ZY=
X-Google-Smtp-Source: AGHT+IHuunofKd5DBJYC5nlE1bGma6/U6rBO6yUiY1ihKqNKA6jZIf6zcsczggGEAcwEt/bfL1H7boGU6jI21eNaxJOSe8mPzdIE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c241:0:b0:3a3:b280:dd94 with SMTP id
 e9e14a558f8ab-3a3b5f7a6b6mr32618925ab.14.1728696002628; Fri, 11 Oct 2024
 18:20:02 -0700 (PDT)
Date: Fri, 11 Oct 2024 18:20:02 -0700
In-Reply-To: <CANp29Y6Zvqt7K9_LWEPQ4X-n1WOJbN0W83wx7a6GRhRFuX_OLw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6709cec2.050a0220.3e960.001b.GAE@google.com>
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_ioctl (4)
From: syzbot <syzbot+ed812ed461471ab17a0c@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-kernel@vger.kernel.org, nogikh@google.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in blk_trace_setup

INFO: task syz-executor.0:5945 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc2-syzkaller-00206-g3ae400ee2cd9 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:27360 pid:5945  tgid:5944  ppid:5899   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6774
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6831
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 blk_trace_setup+0xfb/0x1f0 kernel/trace/blktrace.c:630
 blk_trace_ioctl+0x182/0x830 kernel/trace/blktrace.c:730
 blkdev_ioctl+0x45f/0x6f0 block/ioctl.c:682
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0ebba7cae9
RSP: 002b:00007f0ebc7b30c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f0ebbb9bf80 RCX: 00007f0ebba7cae9
RDX: 0000000020000380 RSI: 00000000c0481273 RDI: 0000000000000004
RBP: 00007f0ebbac847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f0ebbb9bf80 R15: 00007fff4cbbb418
 </TASK>
INFO: task syz-executor.0:5946 blocked for more than 145 seconds.
      Not tainted 6.12.0-rc2-syzkaller-00206-g3ae400ee2cd9 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:28752 pid:5946  tgid:5944  ppid:5899   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6774
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6831
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 blk_trace_remove kernel/trace/blktrace.c:406 [inline]
 blk_trace_ioctl+0x1b8/0x830 kernel/trace/blktrace.c:745
 blkdev_common_ioctl+0xe7b/0x2480 block/ioctl.c:622
 blkdev_ioctl+0x51d/0x6f0 block/ioctl.c:687
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0ebba7cae9
RSP: 002b:00007f0ebc7920c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f0ebbb9c050 RCX: 00007f0ebba7cae9
RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000004
RBP: 00007f0ebbac847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f0ebbb9c050 R15: 00007fff4cbbb418
 </TASK>
INFO: task syz-executor.4:5948 blocked for more than 146 seconds.
      Not tainted 6.12.0-rc2-syzkaller-00206-g3ae400ee2cd9 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.4  state:D stack:27360 pid:5948  tgid:5947  ppid:5901   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6774
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6831
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 blk_trace_setup+0xfb/0x1f0 kernel/trace/blktrace.c:630
 blk_trace_ioctl+0x182/0x830 kernel/trace/blktrace.c:730
 blkdev_ioctl+0x45f/0x6f0 block/ioctl.c:682
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1da087cae9
RSP: 002b:00007f1da03ff0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f1da099bf80 RCX: 00007f1da087cae9
RDX: 0000000020000380 RSI: 00000000c0481273 RDI: 0000000000000004
RBP: 00007f1da08c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f1da099bf80 R15: 00007fff0c43a168
 </TASK>
INFO: task syz-executor.4:5949 blocked for more than 146 seconds.
      Not tainted 6.12.0-rc2-syzkaller-00206-g3ae400ee2cd9 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.4  state:D stack:28032 pid:5949  tgid:5947  ppid:5901   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6774
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6831
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 blk_trace_remove kernel/trace/blktrace.c:406 [inline]
 blk_trace_ioctl+0x1b8/0x830 kernel/trace/blktrace.c:745
 blkdev_common_ioctl+0xe7b/0x2480 block/ioctl.c:622
 blkdev_ioctl+0x51d/0x6f0 block/ioctl.c:687
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1da087cae9
RSP: 002b:00007f1da03de0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f1da099c050 RCX: 00007f1da087cae9
RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000004
RBP: 00007f1da08c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f1da099c050 R15: 00007fff0c43a168
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e73a660 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e73a660 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e73a660 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6720
3 locks held by kworker/u8:5/1271:
 #0: ffff88814bf99948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88814bf99948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x98b/0x18f0 kernel/workqueue.c:3310
 #1: ffffc90004737d00 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90004737d00 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x9c6/0x18f0 kernel/workqueue.c:3310
 #2: ffffffff8fa498c8 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_verify_work+0x19/0x30 net/ipv6/addrconf.c:4736
2 locks held by kworker/u8:8/2844:
3 locks held by kworker/u9:1/4493:
 #0: ffff88809896c148 ((wq_completion)hci5){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88809896c148 ((wq_completion)hci5){+.+.}-{0:0}, at: process_scheduled_works+0x98b/0x18f0 kernel/workqueue.c:3310
 #1: ffffc9000db1fd00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc9000db1fd00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x9c6/0x18f0 kernel/workqueue.c:3310
 #2: ffff88802c874d80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x1ec/0x400 net/bluetooth/hci_sync.c:327
4 locks held by klogd/4537:
 #0: ffff8880b913ea98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:593
 #1: ffffffff8e84ce60 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:593
 #2: ffff88807e2cc618 (&p->pi_lock){-.-.}-{2:2}, at: class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:551 [inline]
 #2: ffff88807e2cc618 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0xbe/0x14b0 kernel/sched/core.c:4160
 #3: ffff8880b913ea98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:593
2 locks held by getty/4852:
 #0: ffff88802a4b80a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x616/0x1770 drivers/tty/n_tty.c:2211
3 locks held by kworker/1:5/5500:
 #0: ffff888015480948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff888015480948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x98b/0x18f0 kernel/workqueue.c:3310
 #1: ffffc90004d17d00 (drain_vmap_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90004d17d00 (drain_vmap_work){+.+.}-{0:0}, at: process_scheduled_works+0x9c6/0x18f0 kernel/workqueue.c:3310
 #2: ffffffff8e8373c8 (vmap_purge_lock){+.+.}-{3:3}, at: drain_vmap_area_work+0x17/0x40 mm/vmalloc.c:2321
3 locks held by syz-executor.5/5929:
1 lock held by syz-executor.0/5945:
 #0: ffff888142b6ad90 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0xfb/0x1f0 kernel/trace/blktrace.c:630
1 lock held by syz-executor.0/5946:
 #0: ffff888142b6ad90 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove kernel/trace/blktrace.c:406 [inline]
 #0: ffff888142b6ad90 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0x1b8/0x830 kernel/trace/blktrace.c:745
1 lock held by syz-executor.4/5948:
 #0: ffff888142b6ad90 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0xfb/0x1f0 kernel/trace/blktrace.c:630
1 lock held by syz-executor.4/5949:
 #0: ffff888142b6ad90 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove kernel/trace/blktrace.c:406 [inline]
 #0: ffff888142b6ad90 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0x1b8/0x830 kernel/trace/blktrace.c:745
1 lock held by syz-executor.1/5967:
 #0: ffff888142b6ad90 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0xfb/0x1f0 kernel/trace/blktrace.c:630
1 lock held by syz-executor.1/5968:
 #0: ffff888142b6ad90 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove kernel/trace/blktrace.c:406 [inline]
 #0: ffff888142b6ad90 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0x1b8/0x830 kernel/trace/blktrace.c:745
1 lock held by syz-executor.2/5985:
 #0: ffff888142b6ad90 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0xfb/0x1f0 kernel/trace/blktrace.c:630
1 lock held by syz-executor.2/5986:
 #0: ffff888142b6ad90 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove kernel/trace/blktrace.c:406 [inline]
 #0: ffff888142b6ad90 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0x1b8/0x830 kernel/trace/blktrace.c:745
1 lock held by syz-executor.3/6003:
 #0: ffff888142b6ad90 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0xfb/0x1f0 kernel/trace/blktrace.c:630
1 lock held by syz-executor.3/6004:
 #0: ffff888142b6ad90 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove kernel/trace/blktrace.c:406 [inline]
 #0: ffff888142b6ad90 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0x1b8/0x830 kernel/trace/blktrace.c:745
1 lock held by syz-executor.5/6037:
 #0: ffff888142b6ad90 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0xfb/0x1f0 kernel/trace/blktrace.c:630
1 lock held by syz-executor.5/6038:
 #0: ffff888142b6ad90 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove kernel/trace/blktrace.c:406 [inline]
 #0: ffff888142b6ad90 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0x1b8/0x830 kernel/trace/blktrace.c:745
1 lock held by syz-executor.0/6064:
 #0: ffff888142b6ad90 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove kernel/trace/blktrace.c:406 [inline]
 #0: ffff888142b6ad90 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0x1b8/0x830 kernel/trace/blktrace.c:745
1 lock held by syz-executor.4/6066:
 #0: ffff888142b6ad90 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0xfb/0x1f0 kernel/trace/blktrace.c:630
1 lock held by syz-executor.4/6067:
 #0: ffff888142b6ad90 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove kernel/trace/blktrace.c:406 [inline]
 #0: ffff888142b6ad90 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0x1b8/0x830 kernel/trace/blktrace.c:745
1 lock held by syz-executor.1/6087:
 #0: ffff888142b6ad90 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0xfb/0x1f0 kernel/trace/blktrace.c:630
1 lock held by syz-executor.1/6088:
 #0: ffff888142b6ad90 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove kernel/trace/blktrace.c:406 [inline]
 #0: ffff888142b6ad90 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0x1b8/0x830 kernel/trace/blktrace.c:745
1 lock held by syz-executor.2/6106:
 #0: ffff888142b6ad90 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0xfb/0x1f0 kernel/trace/blktrace.c:630
1 lock held by syz-executor.2/6107:
 #0: ffff888142b6ad90 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove kernel/trace/blktrace.c:406 [inline]
 #0: ffff888142b6ad90 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0x1b8/0x830 kernel/trace/blktrace.c:745
1 lock held by syz-executor.3/6125:
 #0: ffff888142b6ad90 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0xfb/0x1f0 kernel/trace/blktrace.c:630
1 lock held by syz-executor.3/6126:
 #0: ffff888142b6ad90 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove kernel/trace/blktrace.c:406 [inline]
 #0: ffff888142b6ad90 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0x1b8/0x830 kernel/trace/blktrace.c:745
1 lock held by syz-executor.5/6147:
 #0: ffff888142b6ad90 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0xfb/0x1f0 kernel/trace/blktrace.c:630
1 lock held by syz-executor.5/6148:
 #0: ffff888142b6ad90 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove kernel/trace/blktrace.c:406 [inline]
 #0: ffff888142b6ad90 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0x1b8/0x830 kernel/trace/blktrace.c:745
2 locks held by syz-executor.4/6165:
 #0: ffffffff8fa498c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fa498c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6672
 #1: ffffffff8e73fc38 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:329 [inline]
 #1: ffffffff8e73fc38 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x451/0x820 kernel/rcu/tree_exp.h:976
1 lock held by syz-executor.0/6168:
 #0: ffff888142b6ad90 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0xfb/0x1f0 kernel/trace/blktrace.c:630
1 lock held by syz-executor.0/6169:
 #0: ffff888142b6ad90 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove kernel/trace/blktrace.c:406 [inline]
 #0: ffff888142b6ad90 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0x1b8/0x830 kernel/trace/blktrace.c:745
1 lock held by dhcpcd/6177:
 #0: ffff888065d3ca08 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:815 [inline]
 #0: ffff888065d3ca08 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: __sock_release net/socket.c:657 [inline]
 #0: ffff888065d3ca08 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: sock_close+0x90/0x240 net/socket.c:1426

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-rc2-syzkaller-00206-g3ae400ee2cd9 #0
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
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 2844 Comm: kworker/u8:8 Not tainted 6.12.0-rc2-syzkaller-00206-g3ae400ee2cd9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: bat_events batadv_nc_worker
RIP: 0010:debug_lockdep_rcu_enabled+0x2a/0x40 kernel/rcu/update.c:321
Code: f3 0f 1e fa 31 c0 83 3d 9f 8e 50 04 00 74 1e 83 3d f6 bd 50 04 00 74 15 65 48 8b 0c 25 c0 d7 03 00 31 c0 83 b9 dc 0a 00 00 00 <0f> 94 c0 c3 cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00
RSP: 0018:ffffc90009de7b50 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffff888023995a80 RCX: ffff88802902bc00
RDX: dffffc0000000000 RSI: ffffffff8bead560 RDI: ffffffff8c4159e0
RBP: ffff888166c393b0 R08: ffffffff934ac807 R09: 1ffffffff2695900
R10: dffffc0000000000 R11: fffffbfff2695901 R12: ffff88816d91ccc0
R13: 0000000000000276 R14: ffff888023995a80 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007efecd242040 CR3: 000000007b8e8000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 rcu_read_lock include/linux/rcupdate.h:850 [inline]
 batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:408 [inline]
 batadv_nc_worker+0xf5/0x610 net/batman-adv/network-coding.c:719
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xabe/0x18f0 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         3ae400ee blktrace: move user copies out of q->debugfs_..
git tree:       git://git.kernel.dk/linux btrace-fault
console output: https://syzkaller.appspot.com/x/log.txt?x=17995fd0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ac04e079248cbf6c
dashboard link: https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

