Return-Path: <linux-kernel+bounces-189990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5848CF823
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 05:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A8D2817CD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 03:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A786FB0;
	Mon, 27 May 2024 03:40:32 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120AF1FBA
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 03:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716781231; cv=none; b=BZb3U9ILOptkCwUSfR1Y8L4bAUgd4dM9VrnluRcu2J5afPKDZaQoizlNIGRUJmW/+f8R/ENK8bxiDXn5zp9dqulgx03h1eN8CF+rFFLw68YCxsbABvWk1vJ+GP37yPaLottKCXElXGkFUJlkjgpIQ7mLMqCA4NuUvwlNxsFMFpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716781231; c=relaxed/simple;
	bh=Oban1MVB99vN98pXww4yj5LEtv9MIo7FdOVWN6j+5bo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Wj/PP0R8DrZtp8YXrBOxowynwDhCdIjmRKVfnbrvv2E8xS6SqGGmBsx2BcnP3EgKhXrEXoFwNoEzcfxAIorE0P0D+8lfPs1Y7J1rSmhX57RZUM8sSaOrYMJINbZsyv2T8OP9XPzCuvtNI51oLRPmmLRUWZJk7hwsfp7Ukd/pM1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-36da593c0faso50854135ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 20:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716781229; x=1717386029;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/RcSyyLzwkF5x0AozcCsRzsjS6IUg0898Cr7x6cdbqc=;
        b=SlrZL2Xb0MRwyY9iXYV33+x/H5GSgLcNtUBz8kjvUWBaZdy0rD7oiTG9qzENaoCAfG
         E1c0cnHNynJ+pCKulzvji/VAQPEIeoVw3CyOdEzOwOaxOU0kUoWhkoTeu0DRjdGld9WE
         N00ZYNpGkXL7nmnkRlFluJpycrqw16ABtQJoj9pUbL6WPW7FEspAY99HEoAcN/Id6BwV
         JR6LnbFHTGOV3NlzG78rdgnIGL8eehKHxxRwyJOf2SwL6brGYt0J0DWuU1WoaGPDPnOX
         6qZXGKm7UPT91o+mlVR8cxM4FbX2gAqOO9wzUPxeW6oT2IU5DWTIvKNjqlM7UcGKxZ+e
         pq/g==
X-Forwarded-Encrypted: i=1; AJvYcCX9rtu2jvab/pCPqkyJ6HTwcitTmXrHPWA0/KgYfC8TiFILlSEaY5dyPvIjyX1a5wFF9ZHSdxk2ZbH7b5we/fSrZCZNw5WgXBEqZ8Nu
X-Gm-Message-State: AOJu0YwfPuVz/sIjqxoIqW2PgNhI3KyACmzhp2btr05V2tYkGm9GrGii
	13xKV4jFv29VFXTDGQX2acJdPsP1UVb6DM+NMlcv0ySd2RAESd6YkHWLhgnGbbgc1le3UwWwRm8
	8X1Xwd9Os4jqZMvALZdGXTGgeMgSbQpffjxFgd2bgmVbQ6y8L3O4yVCw=
X-Google-Smtp-Source: AGHT+IFRyu7w1mHc84nvZbgFWQ20mXG3NWibaTDFmS4MlkTqeBsGujZH6r3pFAQ2m7x/UOzJO8Mx6QLSJfAi32IFtFFn2c+7JVJv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d83:b0:36b:3b10:7425 with SMTP id
 e9e14a558f8ab-3737b361a17mr5552855ab.6.1716781229316; Sun, 26 May 2024
 20:40:29 -0700 (PDT)
Date: Sun, 26 May 2024 20:40:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000054ad4f0619674784@google.com>
Subject: [syzbot] [mm?] possible deadlock in __mmap_lock_do_trace_acquire_returned
 (2)
From: syzbot <syzbot+24af80aeb2ae9e47a412@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8f6a15f095a6 Merge tag 'cocci-for-6.10' of git://git.kerne..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=150100d8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a6e600de1a27f120
dashboard link: https://syzkaller.appspot.com/bug?extid=24af80aeb2ae9e47a412
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=176b220c980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11003952980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/60dc1346b348/disk-8f6a15f0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f1699c08d767/vmlinux-8f6a15f0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f0c1de6d998e/bzImage-8f6a15f0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+24af80aeb2ae9e47a412@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.9.0-syzkaller-10323-g8f6a15f095a6 #0 Not tainted
------------------------------------------------------
klogd/4524 is trying to acquire lock:
ffff8880b9338ac0 (lock#9){+.+.}-{2:2}, at: local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
ffff8880b9338ac0 (lock#9){+.+.}-{2:2}, at: __mmap_lock_do_trace_acquire_returned+0x7f/0x790 mm/mmap_lock.c:237

but task is already holding lock:
ffff8880b933ec18 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:559

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&rq->__lock){-.-.}-{2:2}:
       _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:559
       raw_spin_rq_lock kernel/sched/sched.h:1406 [inline]
       rq_lock kernel/sched/sched.h:1702 [inline]
       task_fork_fair+0x73/0x250 kernel/sched/fair.c:12710
       sched_cgroup_fork+0x3cf/0x510 kernel/sched/core.c:4844
       copy_process+0x439b/0x8f10 kernel/fork.c:2499
       kernel_clone+0xfd/0x980 kernel/fork.c:2797
       user_mode_thread+0xb4/0xf0 kernel/fork.c:2875
       rest_init+0x23/0x2b0 init/main.c:712
       start_kernel+0x3df/0x4c0 init/main.c:1103
       x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:507
       x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:488
       common_startup_64+0x13e/0x148

-> #2 (&p->pi_lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
       class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:553 [inline]
       try_to_wake_up+0x9a/0x13e0 kernel/sched/core.c:4262
       signal_wake_up_state+0x79/0x120 kernel/signal.c:773
       signal_wake_up include/linux/sched/signal.h:448 [inline]
       complete_signal+0x465/0xc10 kernel/signal.c:1065
       __send_signal_locked+0x509/0x11c0 kernel/signal.c:1185
       do_notify_parent+0xeb4/0x1040 kernel/signal.c:2143
       exit_notify kernel/exit.c:753 [inline]
       do_exit+0x1369/0x2c10 kernel/exit.c:897
       do_group_exit+0xd3/0x2a0 kernel/exit.c:1026
       __do_sys_exit_group kernel/exit.c:1037 [inline]
       __se_sys_exit_group kernel/exit.c:1035 [inline]
       __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1035
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&sighand->siglock){....}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
       __lock_task_sighand+0xc2/0x340 kernel/signal.c:1414
       lock_task_sighand include/linux/sched/signal.h:746 [inline]
       do_send_sig_info kernel/signal.c:1300 [inline]
       group_send_sig_info+0x290/0x300 kernel/signal.c:1453
       bpf_send_signal_common+0x2e8/0x3a0 kernel/trace/bpf_trace.c:881
       ____bpf_send_signal_thread kernel/trace/bpf_trace.c:898 [inline]
       bpf_send_signal_thread+0x16/0x20 kernel/trace/bpf_trace.c:896
       ___bpf_prog_run+0x3e51/0xabd0 kernel/bpf/core.c:2012
       __bpf_prog_run32+0xc1/0x100 kernel/bpf/core.c:2253
       bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
       __bpf_prog_run include/linux/filter.h:691 [inline]
       bpf_prog_run include/linux/filter.h:698 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2403 [inline]
       bpf_trace_run4+0x245/0x5a0 kernel/trace/bpf_trace.c:2446
       __bpf_trace_mmap_lock_acquire_returned+0x134/0x180 include/trace/events/mmap_lock.h:52
       trace_mmap_lock_acquire_returned include/trace/events/mmap_lock.h:52 [inline]
       __mmap_lock_do_trace_acquire_returned+0x456/0x790 mm/mmap_lock.c:237
       __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inline]
       mmap_read_lock include/linux/mmap_lock.h:145 [inline]
       process_vm_rw_single_vec mm/process_vm_access.c:105 [inline]
       process_vm_rw_core.constprop.0+0x7d7/0xa10 mm/process_vm_access.c:216
       process_vm_rw+0x301/0x360 mm/process_vm_access.c:284
       __do_sys_process_vm_readv mm/process_vm_access.c:296 [inline]
       __se_sys_process_vm_readv mm/process_vm_access.c:292 [inline]
       __x64_sys_process_vm_readv+0xe2/0x1c0 mm/process_vm_access.c:292
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (lock#9){+.+.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
       local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
       __mmap_lock_do_trace_acquire_returned+0x97/0x790 mm/mmap_lock.c:237
       __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inline]
       mmap_read_trylock include/linux/mmap_lock.h:164 [inline]
       stack_map_get_build_id_offset+0x5d9/0x7c0 kernel/bpf/stackmap.c:141
       __bpf_get_stack+0x6bf/0x700 kernel/bpf/stackmap.c:449
       ____bpf_get_stack_raw_tp kernel/trace/bpf_trace.c:1994 [inline]
       bpf_get_stack_raw_tp+0x124/0x160 kernel/trace/bpf_trace.c:1984
       ___bpf_prog_run+0x3e51/0xabd0 kernel/bpf/core.c:2012
       __bpf_prog_run32+0xc1/0x100 kernel/bpf/core.c:2253
       bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
       __bpf_prog_run include/linux/filter.h:691 [inline]
       bpf_prog_run include/linux/filter.h:698 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2403 [inline]
       bpf_trace_run2+0x231/0x590 kernel/trace/bpf_trace.c:2444
       __bpf_trace_tlb_flush+0xd2/0x110 include/trace/events/tlb.h:38
       trace_tlb_flush+0xf3/0x170 include/trace/events/tlb.h:38
       switch_mm_irqs_off+0x68b/0xbc0 arch/x86/mm/tlb.c:642
       context_switch kernel/sched/core.c:5392 [inline]
       __schedule+0xd2b/0x5d00 kernel/sched/core.c:6745
       __schedule_loop kernel/sched/core.c:6822 [inline]
       schedule+0xe7/0x350 kernel/sched/core.c:6837
       syslog_print+0x214/0x5d0 kernel/printk/printk.c:1582
       do_syslog+0x3be/0x6a0 kernel/printk/printk.c:1734
       __do_sys_syslog kernel/printk/printk.c:1826 [inline]
       __se_sys_syslog kernel/printk/printk.c:1824 [inline]
       __x64_sys_syslog+0x74/0xb0 kernel/printk/printk.c:1824
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  lock#9 --> &p->pi_lock --> &rq->__lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&rq->__lock);
                               lock(&p->pi_lock);
                               lock(&rq->__lock);
  lock(lock#9);

 *** DEADLOCK ***

3 locks held by klogd/4524:
 #0: ffff8880b933ec18 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:559
 #1: ffffffff8dbb1760 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #1: ffffffff8dbb1760 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #1: ffffffff8dbb1760 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2402 [inline]
 #1: ffffffff8dbb1760 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x1c2/0x590 kernel/trace/bpf_trace.c:2444
 #2: ffff888015477398 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_trylock include/linux/mmap_lock.h:163 [inline]
 #2: ffff888015477398 (&mm->mmap_lock){++++}-{3:3}, at: stack_map_get_build_id_offset+0x1e8/0x7c0 kernel/bpf/stackmap.c:141

stack backtrace:
CPU: 1 PID: 4524 Comm: klogd Not tainted 6.9.0-syzkaller-10323-g8f6a15f095a6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
 __mmap_lock_do_trace_acquire_returned+0x97/0x790 mm/mmap_lock.c:237
 __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inline]
 mmap_read_trylock include/linux/mmap_lock.h:164 [inline]
 stack_map_get_build_id_offset+0x5d9/0x7c0 kernel/bpf/stackmap.c:141
 __bpf_get_stack+0x6bf/0x700 kernel/bpf/stackmap.c:449
 ____bpf_get_stack_raw_tp kernel/trace/bpf_trace.c:1994 [inline]
 bpf_get_stack_raw_tp+0x124/0x160 kernel/trace/bpf_trace.c:1984
 ___bpf_prog_run+0x3e51/0xabd0 kernel/bpf/core.c:2012
 __bpf_prog_run32+0xc1/0x100 kernel/bpf/core.c:2253
 bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
 __bpf_prog_run include/linux/filter.h:691 [inline]
 bpf_prog_run include/linux/filter.h:698 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2403 [inline]
 bpf_trace_run2+0x231/0x590 kernel/trace/bpf_trace.c:2444
 __bpf_trace_tlb_flush+0xd2/0x110 include/trace/events/tlb.h:38
 trace_tlb_flush+0xf3/0x170 include/trace/events/tlb.h:38
 switch_mm_irqs_off+0x68b/0xbc0 arch/x86/mm/tlb.c:642
 context_switch kernel/sched/core.c:5392 [inline]
 __schedule+0xd2b/0x5d00 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6837
 syslog_print+0x214/0x5d0 kernel/printk/printk.c:1582
 do_syslog+0x3be/0x6a0 kernel/printk/printk.c:1734
 __do_sys_syslog kernel/printk/printk.c:1826 [inline]
 __se_sys_syslog kernel/printk/printk.c:1824 [inline]
 __x64_sys_syslog+0x74/0xb0 kernel/printk/printk.c:1824
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f70c5278fa7
Code: Unable to access opcode bytes at 0x7f70c5278f7d.
RSP: 002b:00007ffcd7812ff8 EFLAGS: 00000206 ORIG_RAX: 0000000000000067
RAX: ffffffffffffffda RBX: 00007f70c54174a0 RCX: 00007f70c5278fa7
RDX: 00000000000003ff RSI: 00007f70c54174a0 RDI: 0000000000000002
RBP: 0000000000000000 R08: 0000000000000003 R09: 7abf98d885e43ab6
R10: 0000000000004000 R11: 0000000000000206 R12: 00007f70c54174a0
R13: 00007f70c5407212 R14: 00007f70c5417666 R15: 00007f70c5417666
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

