Return-Path: <linux-kernel+bounces-256907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0512693721E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 03:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A95E1F21A59
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 01:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0875664;
	Fri, 19 Jul 2024 01:54:28 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA37A32
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 01:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721354067; cv=none; b=dke2KF6seNiKyzvjD4Y0FCBgPCgDAE4p9OmtI9pVf3ZVSUJW7kPvEkiV3mO45odxLG7JVKMRH7L1imjkStXylo/DX96LQdDEuKu6YNIvgY0jsURy3x9fRrxuNTvABhCYMMrqjl5EMcI4Rlig41UeVfYcarRUO/I8vt2/GPgJzxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721354067; c=relaxed/simple;
	bh=kd3wmFbKJVYxwhUOTg8Vfk/WV7R7F8FS5dSYpuwdOaY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kHNTQKyjRnfEY6WTkoCqI1OZ+88cmgehaJfCVQWIxPo0O6TXPhRleyZd2wrwAQoON5tvY2xrSV3IC+pVpOLwgoA3W50ERJY3cn2dtwPxPY1HjKO9iQgwYzZlTi6Xg99/b7f0uzzxv1LeZ8Q4X3ka1Aj5C9Bfji/jRxIZkYJLDPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-37642e69d7eso20287705ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 18:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721354065; x=1721958865;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CAWnVNVq8zhws9asOND3xzdeoSUIjq4eLZc2q9S0e1E=;
        b=uo0j1mBtfOVv/cCIxS2AwExtbIywibLkOzYawBZiNM4a50Wq+qTzlgt6C2EekX9Wp6
         8akX5wM8mWyYSKyg8mQ8KxToDntdv+YlYyV+go/jkVsE+sVIbypE8HyyPo/iKPR5ZCqH
         1zqT9PRaqnvHGiw11CMJWLBIQjw+0blkflXkRQ+W6bWLeDXS3O90gMfDw1/iCmFubPo2
         Q4MfeQpek7LqAA1ZpIwPpoorpsuI3DOVfkI79o1emxSAsxk90/wHyETjKNDI9EMGWEVw
         ehsvQrs2AxPuB1Ne1Dp5DbXib1dRTBJUOBqwut8w4KYSb7FcO817rlrwPVBTSj5mIdxT
         7kDg==
X-Forwarded-Encrypted: i=1; AJvYcCWPfiLLc5+60Gi2gviPJZ/mFDv2vN87/zC6osFLk8BouGrkXSIetuFEmHvt6jb6DgQeRytSdAtW4MWCunoMv74qOUbrVyWPx55TvUWH
X-Gm-Message-State: AOJu0YzGy1M8wwHbLaBlE0jBfuDv78hJDfgDAhG0DtzHzMpENBf0Ph06
	yivZKWvjj89k75XmIB2AR//9MxsCu+r/jm/PZPk2XGI4PBh4sliKq2o6PWQQx4mcxUu8EuA2pd4
	GPoz5wLKdTggg3vyNr5OLMJoWe1f4svjrIBjEGrEI4NohEepB0oPw+PM=
X-Google-Smtp-Source: AGHT+IGv3Wku2HeDgQSqHGrDSGp0QzLbQvxMQqZY88opyjWPEiCXio21XaYcLgQj6fa8LGt9fZv1Wr8sciD9NUeJfodW9YITa40e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0d:b0:376:46d5:6583 with SMTP id
 e9e14a558f8ab-39558298e7dmr3515495ab.5.1721354064881; Thu, 18 Jul 2024
 18:54:24 -0700 (PDT)
Date: Thu, 18 Jul 2024 18:54:24 -0700
In-Reply-To: <0000000000005c8adb0619b025aa@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000091fc6d061d8ff9ee@google.com>
Subject: Re: [syzbot] [mm?] possible deadlock in try_to_wake_up (5)
From: syzbot <syzbot+4970d08867f5a5b0bb78@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    6caf9efaa169 selftests/bpf: Test sockmap redirect for AF_U..
git tree:       bpf
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1686bf4e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8e5f5ae13ab96e5e
dashboard link: https://syzkaller.appspot.com/bug?extid=4970d08867f5a5b0bb78
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1110fe79980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11bc4a1d980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/77deed4d9ec3/disk-6caf9efa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/70989dddc43c/vmlinux-6caf9efa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/16716af60ed3/bzImage-6caf9efa.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4970d08867f5a5b0bb78@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.10.0-syzkaller-04482-g6caf9efaa169 #0 Not tainted
------------------------------------------------------
syz-executor195/5341 is trying to acquire lock:
ffff88801728e418 (&p->pi_lock){-.-.}-{2:2}, at: class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:551 [inline]
ffff88801728e418 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0xb0/0x1470 kernel/sched/core.c:4051

but task is already holding lock:
ffff8880b9438798 (lock#9){+.+.}-{2:2}, at: local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
ffff8880b9438798 (lock#9){+.+.}-{2:2}, at: __mmap_lock_do_trace_acquire_returned+0x8f/0x630 mm/mmap_lock.c:237

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (lock#9){+.+.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5753
       local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
       __mmap_lock_do_trace_acquire_returned+0xa8/0x630 mm/mmap_lock.c:237
       __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inline]
       mmap_read_trylock include/linux/mmap_lock.h:164 [inline]
       stack_map_get_build_id_offset+0x9af/0x9d0 kernel/bpf/stackmap.c:141
       __bpf_get_stack+0x4ad/0x5a0 kernel/bpf/stackmap.c:449
       ____bpf_get_stack_raw_tp kernel/trace/bpf_trace.c:1997 [inline]
       bpf_get_stack_raw_tp+0x1a3/0x240 kernel/trace/bpf_trace.c:1987
       0xffffffffa0001d8e
       bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
       __bpf_prog_run include/linux/filter.h:691 [inline]
       bpf_prog_run include/linux/filter.h:698 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2406 [inline]
       bpf_trace_run2+0x2ec/0x540 kernel/trace/bpf_trace.c:2447
       trace_tlb_flush+0x118/0x140 include/trace/events/tlb.h:38
       switch_mm_irqs_off+0x7cb/0xae0
       context_switch kernel/sched/core.c:5172 [inline]
       __schedule+0x1079/0x4a60 kernel/sched/core.c:6529
       preempt_schedule_common+0x84/0xd0 kernel/sched/core.c:6708
       preempt_schedule+0xe1/0xf0 kernel/sched/core.c:6732
       preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk.S:12
       __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:160 [inline]
       _raw_spin_unlock_irq+0x44/0x50 kernel/locking/spinlock.c:202
       spin_unlock_irq include/linux/spinlock.h:401 [inline]
       ptrace_resume kernel/ptrace.c:866 [inline]
       ptrace_request+0x102d/0x2690 kernel/ptrace.c:1199
       arch_ptrace+0x2a4/0x3f0 arch/x86/kernel/ptrace.c:848
       __do_sys_ptrace kernel/ptrace.c:1285 [inline]
       __se_sys_ptrace+0x164/0x450 kernel/ptrace.c:1258
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&rq->__lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5753
       _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:560
       raw_spin_rq_lock kernel/sched/sched.h:1415 [inline]
       rq_lock kernel/sched/sched.h:1714 [inline]
       task_fork_fair+0x61/0x1e0 kernel/sched/fair.c:12710
       sched_cgroup_fork+0x37c/0x410 kernel/sched/core.c:4633
       copy_process+0x2217/0x3dc0 kernel/fork.c:2482
       kernel_clone+0x226/0x8f0 kernel/fork.c:2780
       user_mode_thread+0x132/0x1a0 kernel/fork.c:2858
       rest_init+0x23/0x300 init/main.c:712
       start_kernel+0x47a/0x500 init/main.c:1103
       x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:507
       x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:488
       common_startup_64+0x13e/0x147

-> #0 (&p->pi_lock){-.-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5136
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5753
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:551 [inline]
       try_to_wake_up+0xb0/0x1470 kernel/sched/core.c:4051
       rcu_read_unlock_special+0x3db/0x550 kernel/rcu/tree_plugin.h:665
       __rcu_read_unlock+0xa1/0x110 kernel/rcu/tree_plugin.h:436
       __mmap_lock_do_trace_acquire_returned+0x1f9/0x630 mm/mmap_lock.c:237
       __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inline]
       mmap_read_trylock include/linux/mmap_lock.h:164 [inline]
       vmf_anon_prepare mm/memory.c:3234 [inline]
       do_anonymous_page mm/memory.c:4451 [inline]
       do_pte_missing mm/memory.c:3895 [inline]
       handle_pte_fault+0x6f58/0x7090 mm/memory.c:5381
       __handle_mm_fault mm/memory.c:5524 [inline]
       handle_mm_fault+0x10df/0x1ba0 mm/memory.c:5689
       do_user_addr_fault arch/x86/mm/fault.c:1338 [inline]
       handle_page_fault arch/x86/mm/fault.c:1481 [inline]
       exc_page_fault+0x459/0x8c0 arch/x86/mm/fault.c:1539
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

other info that might help us debug this:

Chain exists of:
  &p->pi_lock --> &rq->__lock --> lock#9

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(lock#9);
                               lock(&rq->__lock);
                               lock(lock#9);
  lock(&p->pi_lock);

 *** DEADLOCK ***

3 locks held by syz-executor195/5341:
 #0: ffff888025543580 (&vma->vm_lock->lock){++++}-{3:3}, at: vma_start_read include/linux/mm.h:683 [inline]
 #0: ffff888025543580 (&vma->vm_lock->lock){++++}-{3:3}, at: lock_vma_under_rcu+0x2f9/0x6e0 mm/memory.c:5845
 #1: ffff8880121da798 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_trylock include/linux/mmap_lock.h:163 [inline]
 #1: ffff8880121da798 (&mm->mmap_lock){++++}-{3:3}, at: vmf_anon_prepare mm/memory.c:3234 [inline]
 #1: ffff8880121da798 (&mm->mmap_lock){++++}-{3:3}, at: do_anonymous_page mm/memory.c:4451 [inline]
 #1: ffff8880121da798 (&mm->mmap_lock){++++}-{3:3}, at: do_pte_missing mm/memory.c:3895 [inline]
 #1: ffff8880121da798 (&mm->mmap_lock){++++}-{3:3}, at: handle_pte_fault+0x57ad/0x7090 mm/memory.c:5381
 #2: ffff8880b9438798 (lock#9){+.+.}-{2:2}, at: local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
 #2: ffff8880b9438798 (lock#9){+.+.}-{2:2}, at: __mmap_lock_do_trace_acquire_returned+0x8f/0x630 mm/mmap_lock.c:237

stack backtrace:
CPU: 0 PID: 5341 Comm: syz-executor195 Not tainted 6.10.0-syzkaller-04482-g6caf9efaa169 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2186
 check_prev_add kernel/locking/lockdep.c:3133 [inline]
 check_prevs_add kernel/locking/lockdep.c:3252 [inline]
 validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5136
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5753
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:551 [inline]
 try_to_wake_up+0xb0/0x1470 kernel/sched/core.c:4051
 rcu_read_unlock_special+0x3db/0x550 kernel/rcu/tree_plugin.h:665
 __rcu_read_unlock+0xa1/0x110 kernel/rcu/tree_plugin.h:436
 __mmap_lock_do_trace_acquire_returned+0x1f9/0x630 mm/mmap_lock.c:237
 __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inline]
 mmap_read_trylock include/linux/mmap_lock.h:164 [inline]
 vmf_anon_prepare mm/memory.c:3234 [inline]
 do_anonymous_page mm/memory.c:4451 [inline]
 do_pte_missing mm/memory.c:3895 [inline]
 handle_pte_fault+0x6f58/0x7090 mm/memory.c:5381
 __handle_mm_fault mm/memory.c:5524 [inline]
 handle_mm_fault+0x10df/0x1ba0 mm/memory.c:5689
 do_user_addr_fault arch/x86/mm/fault.c:1338 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x459/0x8c0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7f16433ef7aa
Code: 5c 07 00 00 ba 12 00 00 00 bf 01 00 00 00 48 8d 35 a6 a8 07 00 e8 36 0a 03 00 b8 80 01 00 20 31 d2 66 0f ef c0 48 89 c7 31 c0 <c7> 04 25 c0 00 00 20 11 00 00 00 48 8d 35 bc a8 07 00 c7 04 25 c4
RSP: 002b:00007fff5d7914c0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f16434201e0
RDX: 0000000000000000 RSI: 00007f164346a03b RDI: 0000000020000180
RBP: 00000000000f4240 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 000000000000fa81
R13: 00007fff5d7914cc R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

