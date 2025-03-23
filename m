Return-Path: <linux-kernel+bounces-572984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F756A6D11C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 21:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B80C216F0C4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 20:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890781A317A;
	Sun, 23 Mar 2025 20:43:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111B3DDDC
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 20:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742762586; cv=none; b=ik8w30iT9Vw/EIHnClk6x4lXjIMeqd3n9mpLp/R0w5B7SK4g8i6KtI5oHtlYUmqqQNPUA5yeRA180l0t1wBpKZEU6M+q3d7PbVEU9qrQ8Zfd/9mDLE8/F9MIkLC22JIlU3VTg6yFhUVdDeEceNbiUBMjnJ06ezOIZru+915HB20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742762586; c=relaxed/simple;
	bh=rzEwX5PH/qAGY+bhsRL81jqJv6vs5mkFpvoAbiwi2SA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DjILjUBjcDPh0gzIkHW+gfqTQIUEj9DqcHheqSrW2kDMkQuqKBMZTibV1HlLbP1wYeC00jYWI/yvXsIvft7DLdT4D2vgOQp7fVbG8sh6uvvTO3+YOUykrL4/Lfb8sj5j1sONbtY4DMCutLrkEllqp24CD/dN+ms44V9FuweAr78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d453d367a0so78792935ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 13:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742762584; x=1743367384;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PNknJcMk1YTbqvhhfgGi4v6+sWs6yFszc7c3LyWQGFg=;
        b=FGZ0GIDYC82mj8t/A+pdY2hj5ajeCb1rDA4c7k6nt3r4SU+yB7/ywDTWdwXX1vb17e
         3TiIbXxNIUFtZzopRcSU4TpcNzL/ofTUpyFeso42MpewJN6FUKz68/Rw04fTHimQCy2J
         f4QWL5QOHkVNRyQ+B2DGvl1O+f7BLZIp80g3VC3Y5z8i6PC3jVm3vGaudePliJ6Raa9L
         AFkBp049nwXA4AfSlarCkR347M6gL5TS/Zo+iRw4b9iQsY4y5nSfHqKXCbhKVmVgk3Wd
         ky01DwpULeswqXGuq0cF1A024k22mUF+0MNdRXAkNfDW0yKDgGyUmz6DT1QftjqbNckx
         5ZqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOQB1McQZIE3zgstTwvpqkL6X47aSkJ50PsGQcg9iITqn97Twiav1h7QBlrUwRyFLLbhO8XVTCLi9XfXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvIiScPUY4hIaSsf6QVcoTIn69YrP4Xxr5g8YT1emRSYOCq8Ak
	LkVURgonNtN7la24DIsNh89JPsuV8deyoW4whXGPqt6P0Wv08wIVJlOpQ4ZAAp3tKcgbY2kQZTJ
	6KEBRw55TpOUbG4iXVfSoA/RbQQQw4vZGYr2TVBgOgjcZhyYhO2+fs7U=
X-Google-Smtp-Source: AGHT+IGhdN9eAgoZzkNFnMHrWSO8u1g1bwivmbDZaTKCgl37ObpudXjSqxqMPA/IgCFVhWmR4Yo8YSRo074qzBqL3mZlVjFXMdnS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c263:0:b0:3cf:c773:6992 with SMTP id
 e9e14a558f8ab-3d59611acdbmr121196155ab.12.1742762584071; Sun, 23 Mar 2025
 13:43:04 -0700 (PDT)
Date: Sun, 23 Mar 2025 13:43:04 -0700
In-Reply-To: <cqyyq5vbtxbz3cpvgdy4hupy3eykhv5fzc46aehgjnk2lifda4@w3jnwtvigvoh>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e07258.050a0220.21942d.0007.GAE@google.com>
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
From: syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>
To: brauner@kernel.org, dhowells@redhat.com, jack@suse.cz, jlayton@kernel.org, 
	kprateek.nayak@amd.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjguzik@gmail.com, netfs@lists.linux.dev, 
	oleg@redhat.com, swapnil.sapkal@amd.com, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in netfs_unbuffered_write_iter

INFO: task syz.0.17:6690 blocked for more than 143 seconds.
      Not tainted 6.13.0-rc1-syzkaller-00017-gaaec5a95d596-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.17        state:D stack:25184 pid:6690  tgid:6689  ppid:6491   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0xe58/0x5ad0 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6848
 bit_wait+0x15/0xe0 kernel/sched/wait_bit.c:237
 __wait_on_bit+0x62/0x180 kernel/sched/wait_bit.c:49
 out_of_line_wait_on_bit+0xda/0x110 kernel/sched/wait_bit.c:64
 wait_on_bit include/linux/wait_bit.h:77 [inline]
 netfs_unbuffered_write_iter_locked+0xba8/0xe70 fs/netfs/direct_write.c:105
 netfs_unbuffered_write_iter+0x413/0x6d0 fs/netfs/direct_write.c:193
 v9fs_file_write_iter+0xbf/0x100 fs/9p/vfs_file.c:404
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x5ae/0x1150 fs/read_write.c:679
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbba998d169
RSP: 002b:00007fbba97f9038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fbba9ba5fa0 RCX: 00007fbba998d169
RDX: 0000000000007fec RSI: 0000400000000540 RDI: 0000000000000007
RBP: 00007fbba9a0e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fbba9ba5fa0 R15: 00007ffea301fe68
 </TASK>

Showing all locks held in the system:
2 locks held by kworker/u8:0/11:
 #0: ffff88801b081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90000107d80 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by kworker/u8:1/12:
 #0: ffff88801b081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90000117d80 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
1 lock held by khungtaskd/30:
 #0: ffffffff8e1bac80 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e1bac80 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e1bac80 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x7f/0x390 kernel/locking/lockdep.c:6744
2 locks held by kworker/u8:2/35:
 #0: ffff88801b081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90000ab7d80 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by kworker/u8:4/80:
 #0: ffff88801b081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000213fd80 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
3 locks held by kworker/u8:6/2887:
2 locks held by kworker/u8:7/2936:
 #0: ffff88801b081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000bc87d80 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by kworker/u8:8/3460:
 #0: ffff88801b081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000c917d80 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by kworker/u8:9/3519:
 #0: ffff88801b081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000c757d80 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by kworker/u8:10/3600:
 #0: ffff88801b081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000cbe7d80 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by kworker/u8:11/3645:
 #0: ffff88801b081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000d047d80 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by kworker/u8:12/3693:
 #0: ffff88801b081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000d437d80 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by getty/5579:
 #0: ffff8880315940a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002fde2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0xfba/0x1480 drivers/tty/n_tty.c:2211
3 locks held by syz.0.17/6690:
 #0: ffff88807c837eb8 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x267/0x390 fs/file.c:1191
 #1: ffff88807341a420 (sb_writers#14){.+.+}-{0:0}, at: ksys_write+0x12b/0x250 fs/read_write.c:731
 #2: ffff8880739f0148 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188
3 locks held by syz.1.19/6790:
 #0: ffff88802beef7b8 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x267/0x390 fs/file.c:1191
 #1: ffff888055054420 (sb_writers#14){.+.+}-{0:0}, at: ksys_write+0x12b/0x250 fs/read_write.c:731
 #2: ffff8880739f07b8 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188
3 locks held by syz.2.22/6813:
 #0: ffff888034a757b8 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x267/0x390 fs/file.c:1191
 #1: ffff8880736a2420 (sb_writers#14){.+.+}-{0:0}, at: ksys_write+0x12b/0x250 fs/read_write.c:731
 #2: ffff8880739f0e28 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188
3 locks held by syz.3.24/6832:
 #0: ffff88802fbce9b8 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x267/0x390 fs/file.c:1191
 #1: ffff888030d96420 (sb_writers#14){.+.+}-{0:0}, at: ksys_write+0x12b/0x250 fs/read_write.c:731
 #2: ffff888073af0148 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188
3 locks held by syz.4.26/6857:
 #0: ffff8880355be638 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x267/0x390 fs/file.c:1191
 #1: ffff8880331c0420 (sb_writers#14){.+.+}-{0:0}, at: ksys_write+0x12b/0x250 fs/read_write.c:731
 #2: ffff888073af07b8 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188
3 locks held by syz.5.28/6882:
 #0: ffff8880635d1eb8 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x267/0x390 fs/file.c:1191
 #1: ffff88807347c420 (sb_writers#14){.+.+}-{0:0}, at: ksys_write+0x12b/0x250 fs/read_write.c:731
 #2: ffff8880739f1498 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188
3 locks held by syz.6.30/6910:
 #0: ffff88807b32e2b8 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x267/0x390 fs/file.c:1191
 #1: ffff888029cb0420 (sb_writers#14){.+.+}-{0:0}, at: ksys_write+0x12b/0x250 fs/read_write.c:731
 #2: ffff8880739f1b08 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188
3 locks held by syz.7.32/6938:
 #0: ffff88802fba9278 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x267/0x390 fs/file.c:1191
 #1: ffff88806225e420 (sb_writers#14){.+.+}-{0:0}, at: ksys_write+0x12b/0x250 fs/read_write.c:731
 #2: ffff888073af0e28 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188
3 locks held by syz.8.34/6969:
 #0: ffff8880336ea478 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x267/0x390 fs/file.c:1191
 #1: ffff88802a7a4420 (sb_writers#14){.+.+}-{0:0}, at: ksys_write+0x12b/0x250 fs/read_write.c:731
 #2: ffff888073af1498 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188
3 locks held by syz.9.36/6996:
 #0: ffff88801e2c27f8 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x267/0x390 fs/file.c:1191
 #1: ffff88802d796420 (sb_writers#14){.+.+}-{0:0}, at: ksys_write+0x12b/0x250 fs/read_write.c:731
 #2: ffff8880739f2178 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.13.0-rc1-syzkaller-00017-gaaec5a95d596-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:234 [inline]
 watchdog+0xf14/0x1240 kernel/hung_task.c:397
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 5871 Comm: kworker/0:4 Not tainted 6.13.0-rc1-syzkaller-00017-gaaec5a95d596-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: events_power_efficient gc_worker
RIP: 0010:__lock_acquire+0x2fe/0x3c40 kernel/locking/lockdep.c:5162
Code: 47 10 48 89 c2 48 89 44 24 50 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 70 2b 00 00 49 8d 47 18 4d 89 67 10 <48> 89 c2 48 89 44 24 48 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03
RSP: 0018:ffffc90003ad7990 EFLAGS: 00000046
RAX: ffff8880315f53c8 RBX: 0000000000000000 RCX: 0000000000000002
RDX: 1ffff110062bea78 RSI: 1ffff110062bea75 RDI: ffff8880315f53b8
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 000000000000000a R11: 0000000000000003 R12: ffffffff8e1bac80
R13: ffff8880315f4880 R14: 0000000000000021 R15: ffff8880315f53b0
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c008d0a000 CR3: 000000000df7e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
 rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 rcu_read_lock include/linux/rcupdate.h:849 [inline]
 gc_worker+0x24d/0x1760 net/netfilter/nf_conntrack_core.c:1532
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         aaec5a95 pipe_read: don't wake up the writer if the pi..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11550804580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d5a2956e94d7972
dashboard link: https://syzkaller.appspot.com/bug?extid=62262fdc0e01d99573fc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10e90804580000


