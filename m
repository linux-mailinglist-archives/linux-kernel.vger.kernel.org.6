Return-Path: <linux-kernel+bounces-235179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E321291D12A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 12:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A595B2106C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 10:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B55313774B;
	Sun, 30 Jun 2024 10:37:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB181369AA
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 10:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719743826; cv=none; b=Hvf3j793A4CeS9Qz8B5KspKJc1fcYFIXefMMcF4ULGDZ/2esl2vvWEfgeGOUPcF3+oLtSuiBg0fS/tlVHYv5FNhdWqyQkCNUe6JLBYAaJ8iJxe9mAS+46P17W6guDznc8pBX3rS2wkl54qsxhTSGDxt/vAshIBEFcXGfLVn6/1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719743826; c=relaxed/simple;
	bh=slktSbc5n39+gERFddyeaTiaIvTez2dnTbZu9ts3L1I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lJXYo51Aixsz335dtZQhUvThsp+Bv3eFLhk8/+2c1XQbCOJ+SbDRDexiqfQIasdXtBEAYDfw1y0Zt4JiU1NLumqw1taJYwPQsLfPB8xuGr0qTlTF/LzNGAn3LCVd+i1ICJixovEeSaagzdtCIdtVUSROVy84lPCoEIeDZb0zEvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f6307d584aso86345339f.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 03:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719743824; x=1720348624;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DFoBW+cWAdxef5NN3iQd0InQPtd73cZeeR0W1Z9Ip8c=;
        b=KUk0v3r0sT147Cy17jdf5IKmFctlUorw8qWu2X2qDgwmT6ErFRo7D+y5CzlJ0t+U04
         LgPeboZstdTYfkdEhOw8x+ZV1Q7KMRpYxs9kZx6wFDMlaWZSrXFOQqdInNfjvHcnvvlI
         JNQ27RxRV1v6Ule/FZq76Prt7u7HtAjlKuxjzVkQHlPmEJ7ClyQ0/IuBsLdZUL9f+9rk
         z3d6qKTQDPQqsZMIGH601gO1sFD8lTfHZO27iEeS+E2oE8f4TiKunMWh2HW4stIFhiik
         9CY4kPfnc73swQZA+hKAZBb7MoeSVcQOVUqVik6B2DaYDZvk9Pof+RhTRMB1orq0URVk
         kqsg==
X-Forwarded-Encrypted: i=1; AJvYcCV/k1iassSUNyojpzqtknP/WSGqApTI4B0T7Mjx1IjqGz0YA9/APT25mrE6c1HilUIEkx8y5w9qWB8XJOUat5Fj/Rri4/gwFzZrD2BT
X-Gm-Message-State: AOJu0Yx0l6IN//mugribmRx6KOsVBWehKF/pY5Rl9szgWDLiRU2J5pYz
	+in+ERzO2s11jgx9TFAoOwGLAcdFDqjX/JLwRFl7VN5v6Qt0k0rFdUm3hFwZvu5IwUWLRi2NQ1H
	A3iip66A8Sqm4MW9JrWkV94ek3crWJXrDCn0Alx7u+Rmsm/ZE8lLMGp8=
X-Google-Smtp-Source: AGHT+IGUA/tfVzbOv2sFPCDV1QhNGpT9pahIdTJt92DPS+eskchvALHD1ocIEVC4FIyi+GusGH2F7kUJYmVRvIpfkUs7kNutGZAK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:891b:b0:4b9:13c9:b0fb with SMTP id
 8926c6da1cb9f-4bbb6e9cab0mr271276173.5.1719743822816; Sun, 30 Jun 2024
 03:37:02 -0700 (PDT)
Date: Sun, 30 Jun 2024 03:37:02 -0700
In-Reply-To: <20240630092425.2515-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a9f7c3061c190f9c@google.com>
Subject: Re: [syzbot] [bcachefs?] INFO: task hung in bch2_fs_read_only_work
From: syzbot <syzbot+8996d8f176cf946ef641@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in bch2_fs_read_only_work

INFO: task kworker/0:1:9 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc5-syzkaller-00282-g8282d5af7be8 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:1     state:D stack:22864 pid:9     tgid:9     ppid:2      flags:0x00004000
Workqueue: events_long bch2_fs_read_only_work

Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x1796/0x49d0 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 rwsem_down_write_slowpath+0xeeb/0x13b0 kernel/locking/rwsem.c:1178
 __down_write_common+0x1af/0x200 kernel/locking/rwsem.c:1306
 bch2_fs_read_only_work+0x25/0x40 fs/bcachefs/super.c:392
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/0:1/9:
 #0: ffff888015081148 ((wq_completion)events_long){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3223 [inline]
 #0: ffff888015081148 ((wq_completion)events_long){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3329
 #1: ffffc900000e7d00 ((work_completion)(&c->read_only_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3224 [inline]
 #1: ffffc900000e7d00 ((work_completion)(&c->read_only_work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3329
 #2: ffff888061300278 (&c->state_lock){+.+.}-{3:3}, at: bch2_fs_read_only_work+0x25/0x40 fs/bcachefs/super.c:392
1 lock held by khungtaskd/30:
 #0: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
2 locks held by getty/4830:
 #0: ffff88802d5a00a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f0e2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2211
3 locks held by syz-executor/5952:
2 locks held by syz-executor/6492:

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 30 Comm: khungtaskd Not tainted 6.10.0-rc5-syzkaller-00282-g8282d5af7be8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xfde/0x1020 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 4522 Comm: klogd Not tainted 6.10.0-rc5-syzkaller-00282-g8282d5af7be8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:on_stack arch/x86/include/asm/stacktrace.h:58 [inline]
RIP: 0010:stack_access_ok arch/x86/kernel/unwind_orc.c:393 [inline]
RIP: 0010:deref_stack_reg+0xb6/0x260 arch/x86/kernel/unwind_orc.c:403
Code: 00 00 00 00 fc ff df 41 0f b6 04 06 84 c0 0f 85 77 01 00 00 8b 2b 31 ff 89 ee e8 75 11 55 00 85 ed 48 8b 2c 24 48 8b 4c 24 20 <74> 22 48 39 e9 77 1d 49 39 ef 76 18 48 8d 45 08 48 39 c8 76 16 4c
RSP: 0018:ffffc900030171c8 EFLAGS: 00000202
RAX: 0000000000000000 RBX: ffffc90003017300 RCX: ffffc90003010000
RDX: ffff88807cddbc00 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90003017f48 R08: ffffffff81411deb R09: ffffffff8141095f
R10: 0000000000000003 R11: ffff88807cddbc00 R12: 1ffff92000602e61
R13: 1ffff92000602e62 R14: 1ffff92000602e60 R15: ffffc90003018000
FS:  00007f77d92e5380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd9881b0000 CR3: 000000002dbc8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 unwind_next_frame+0x1ab8/0x2a00 arch/x86/kernel/unwind_orc.c:648
 arch_stack_walk+0x151/0x1b0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4123 [inline]
 kmalloc_node_track_caller_noprof+0x225/0x440 mm/slub.c:4143
 kmalloc_reserve+0x111/0x2a0 net/core/skbuff.c:597
 __alloc_skb+0x1f3/0x440 net/core/skbuff.c:666
 alloc_skb include/linux/skbuff.h:1308 [inline]
 alloc_skb_with_frags+0xc3/0x770 net/core/skbuff.c:6504
 sock_alloc_send_pskb+0x91a/0xa60 net/core/sock.c:2794
 unix_dgram_sendmsg+0x6d3/0x1f80 net/unix/af_unix.c:1976
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 __sys_sendto+0x3a4/0x4f0 net/socket.c:2192
 __do_sys_sendto net/socket.c:2204 [inline]
 __se_sys_sendto net/socket.c:2200 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2200
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f77d94479b5
Code: 8b 44 24 08 48 83 c4 28 48 98 c3 48 98 c3 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 26 45 31 c9 45 31 c0 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 7a 48 8b 15 44 c4 0c 00 f7 d8 64 89 02 48 83
RSP: 002b:00007fff73f971d8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f77d94479b5
RDX: 000000000000004c RSI: 000055e9ea82c7b0 RDI: 0000000000000003
RBP: 000055e9ea827910 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000004000 R11: 0000000000000246 R12: 0000000000000013
R13: 00007f77d95d5212 R14: 00007fff73f972d8 R15: 0000000000000000
 </TASK>


Tested on:

commit:         8282d5af Merge tag 'nfs-for-6.10-3' of git://git.linux..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=11eae41a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf5def5af476d39a
dashboard link: https://syzkaller.appspot.com/bug?extid=8996d8f176cf946ef641
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

