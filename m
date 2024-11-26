Return-Path: <linux-kernel+bounces-422448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 218149D99CC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 15:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B199B16696D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 14:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1527F1D47AF;
	Tue, 26 Nov 2024 14:40:33 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC736BE46
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732632032; cv=none; b=Qi+0qjYS1uhUDPJw33XQRiUFHN9gv7ewGmj/7NOg0gzgcrT/7eCaCy4sD5j+mdck8Z1gKRvnYFiyYrkX3TEnW2StUBNGfreztQCwdsaBQlCFeBYa3xq+IYz93eGR6KiSuhlrmPSrQ6+OYN35gNTgIdBx/RORLIdCGjIPN/r7Lpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732632032; c=relaxed/simple;
	bh=7dMcKtmmIjf0qCkQRVpzwZjDcHQorWMAeVwp1Zn9jqw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VsAsy8g+qbvaKVsBOVdvfD/8x/xQI8ubYDqwSQkSFPNXKDIxa1TMZbTUH8YvBGWqvMoZx5I4pYalMVkVVitBdBM6arbqVTwG7fEWvhe9CGZiw/+caza5YtXgcb5Vh/2gMH2mp5bxd/wBUW5XbYaX8875yZZgd61dIQGp1dVpMG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8419aa81d6aso194642239f.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 06:40:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732632030; x=1733236830;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VUh5ue/XRym6gNIfE7RKmnEPLKAYA4F3RWM+7tzpaH4=;
        b=aFIPBjL5jyELpvbC9J/DVqBl5FhmlMI5X/xPGTYL9uN9shKBxAxXdou4NBnD2fMHXk
         L9Ruw/QTJfx7yCAHDeQl2epDqHHpZSqLlfFi/nU8wlY+yTduvPkWZKCrUFJkWu6k38Wm
         7pJg7NwlWX6IEeSLHnnSqiaM0jO66PWF6bzD+xd0+GAodcjNWwhT8VcK3dmjp8EItGA9
         dwWYMAH7XlUr34TC7xQ5nZ0hRf01fOrcHoWB5lZaHldCiIrWBuxnO7oG6Huk9BgkPUsg
         A+pRAJh3cm1YrSqcvMrhcC9GBUM7TFT6Ce495J/vBln5WJf+R1NISaSa6WQppXrSVv4h
         h0vg==
X-Gm-Message-State: AOJu0YwDZdeD9HxAPeqCAj1De0ZWnlf2zpTkynMDR42pLsOCc1wG4Q4N
	03z7XQYpG7cAR0gjln4ZjseRqUQl5dHfeqLElclDtkgnPdEw6/FGsBNKMeXai1gwUE0wDA2r19O
	rieierfGWpF8qI4ebg7i5FuI9NNytSd992GT3tVb2yeqY391ujlHrcVc=
X-Google-Smtp-Source: AGHT+IF1ocAPFuWeD4rOxjtt8N43CFj/Ks2i2QTOqJlONDrOrU5KE6Y1N9ygb8+0G3pP6ZyhQUlTWEtirzaiPURP3HvSfgG2sQWK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160c:b0:3a7:7a68:44e2 with SMTP id
 e9e14a558f8ab-3a79aeacd6dmr192042525ab.15.1732632030077; Tue, 26 Nov 2024
 06:40:30 -0800 (PST)
Date: Tue, 26 Nov 2024 06:40:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6745ddde.050a0220.1286eb.001a.GAE@google.com>
Subject: [syzbot] [kernel?] KASAN: wild-memory-access Read in rto_push_irq_work_func
From: syzbot <syzbot+c2df1ce81db95611698a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    59b723cd2adb Linux 6.12-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17e2f630580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=11254d3590b16717
dashboard link: https://syzkaller.appspot.com/bug?extid=c2df1ce81db95611698a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/18cd6bff403e/disk-59b723cd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/79241ecdd1c5/vmlinux-59b723cd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/66ecbfab6b13/bzImage-59b723cd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c2df1ce81db95611698a@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: wild-memory-access in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: wild-memory-access in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: wild-memory-access in __lock_acquire+0xc8b/0x2050 kernel/locking/lockdep.c:5172
Read of size 8 at addr 1fffffff87715c68 by task syz.0.1/6002

CPU: 0 UID: 0 PID: 6002 Comm: syz.0.1 Not tainted 6.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_report+0xe8/0x550 mm/kasan/report.c:491
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 __lock_acquire+0xc8b/0x2050 kernel/locking/lockdep.c:5172
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
 raw_spin_rq_lock_nested+0xb0/0x140 kernel/sched/core.c:606
 raw_spin_rq_lock kernel/sched/sched.h:1505 [inline]
 rto_push_irq_work_func+0x86/0x350 kernel/sched/rt.c:2259
 irq_work_single+0x136/0x240 kernel/irq_work.c:221
 irq_work_run_list kernel/irq_work.c:252 [inline]
 irq_work_run+0x18b/0x350 kernel/irq_work.c:261
 __sysvec_irq_work+0xb8/0x430 arch/x86/kernel/irq_work.c:22
 instr_sysvec_irq_work arch/x86/kernel/irq_work.c:17 [inline]
 sysvec_irq_work+0x9e/0xc0 arch/x86/kernel/irq_work.c:17
 </IRQ>
 <TASK>
 asm_sysvec_irq_work+0x1a/0x20 arch/x86/include/asm/idtentry.h:738
RIP: 0010:finish_task_switch+0x1ea/0x870 kernel/sched/core.c:5202
Code: c9 50 e8 79 00 0c 00 48 83 c4 08 4c 89 f7 e8 4d 39 00 00 e9 de 04 00 00 4c 89 f7 e8 50 ad 6c 0a e8 0b 5a 38 00 fb 48 8b 5d c0 <48> 8d bb f8 15 00 00 48 89 f8 48 c1 e8 03 49 be 00 00 00 00 00 fc
RSP: 0018:ffffc900034e6b88 EFLAGS: 00000282
RAX: 86403ade1ffdd400 RBX: ffff8880300d8000 RCX: ffffffff9a3d4903
RDX: dffffc0000000000 RSI: ffffffff8c0acaa0 RDI: ffffffff8c610820
RBP: ffffc900034e6bd0 R08: ffffffff901d08ef R09: 1ffffffff203a11d
R10: dffffc0000000000 R11: fffffbfff203a11e R12: 1ffff110170c7f14
R13: dffffc0000000000 R14: ffff8880b863ea80 R15: ffff8880b863f8a0
 context_switch kernel/sched/core.c:5331 [inline]
 __schedule+0x1857/0x4c30 kernel/sched/core.c:6690
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:7012
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:unwind_get_return_address+0x9/0x90 arch/x86/kernel/unwind_orc.c:365
Code: ff ff e8 ea e1 85 0a 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 41 57 41 56 53 <48> 89 fb 49 be 00 00 00 00 00 fc ff df 48 89 f8 48 c1 e8 03 42 0f
RSP: 0018:ffffc900034e6f80 EFLAGS: 00000202
RAX: 0000000080000001 RBX: ffffc900034e6fa0 RCX: 0000000080000000
RDX: dffffc0000000000 RSI: ffffc900034e0000 RDI: ffffc900034e6fa0
RBP: ffffc900034e7030 R08: ffffc900034e7790 R09: ffffc900034e6ff0
R10: dffffc0000000000 R11: fffff5200069ce00 R12: ffff8880300d8000
R13: ffffffff818092c0 R14: ffffc900034e7080 R15: 0000000000000000
 arch_stack_walk+0xfd/0x150 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 save_stack+0xfb/0x1f0 mm/page_owner.c:156
 __set_page_owner+0x92/0x800 mm/page_owner.c:320
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x303f/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 vm_area_alloc_pages mm/vmalloc.c:3568 [inline]
 __vmalloc_area_node mm/vmalloc.c:3646 [inline]
 __vmalloc_node_range_noprof+0xa2b/0x13f0 mm/vmalloc.c:3828
 alloc_thread_stack_node kernel/fork.c:315 [inline]
 dup_task_struct+0x444/0x8c0 kernel/fork.c:1116
 copy_process+0x5d1/0x3d50 kernel/fork.c:2204
 kernel_clone+0x226/0x8f0 kernel/fork.c:2786
 __do_sys_clone3 kernel/fork.c:3090 [inline]
 __se_sys_clone3+0x2d8/0x360 kernel/fork.c:3069
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f85d55b2779
Code: 68 07 00 48 8d 3d ec 68 07 00 e8 92 28 f6 ff 66 90 b8 ea ff ff ff 48 85 ff 74 2c 48 85 d2 74 27 49 89 c8 b8 b3 01 00 00 0f 05 <48> 85 c0 7c 18 74 01 c3 31 ed 48 83 e4 f0 4c 89 c7 ff d2 48 89 c7
RSP: 002b:00007ffe381a0b08 EFLAGS: 00000206 ORIG_RAX: 00000000000001b3
RAX: ffffffffffffffda RBX: 00007f85d55350a0 RCX: 00007f85d55b2779
RDX: 00007f85d55350a0 RSI: 0000000000000058 RDI: 00007ffe381a0b50
RBP: 00007f85d632b6c0 R08: 00007f85d632b6c0 R09: 00007ffe381a0c37
R10: 0000000000000008 R11: 0000000000000206 R12: ffffffffffffffa8
R13: 000000000000006e R14: 00007ffe381a0b50 R15: 00007ffe381a0c38
 </TASK>
==================================================================
----------------
Code disassembly (best guess):
   0:	c9                   	leave
   1:	50                   	push   %rax
   2:	e8 79 00 0c 00       	call   0xc0080
   7:	48 83 c4 08          	add    $0x8,%rsp
   b:	4c 89 f7             	mov    %r14,%rdi
   e:	e8 4d 39 00 00       	call   0x3960
  13:	e9 de 04 00 00       	jmp    0x4f6
  18:	4c 89 f7             	mov    %r14,%rdi
  1b:	e8 50 ad 6c 0a       	call   0xa6cad70
  20:	e8 0b 5a 38 00       	call   0x385a30
  25:	fb                   	sti
  26:	48 8b 5d c0          	mov    -0x40(%rbp),%rbx
* 2a:	48 8d bb f8 15 00 00 	lea    0x15f8(%rbx),%rdi <-- trapping instruction
  31:	48 89 f8             	mov    %rdi,%rax
  34:	48 c1 e8 03          	shr    $0x3,%rax
  38:	49                   	rex.WB
  39:	be 00 00 00 00       	mov    $0x0,%esi
  3e:	00 fc                	add    %bh,%ah


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

