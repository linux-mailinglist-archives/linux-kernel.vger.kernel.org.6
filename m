Return-Path: <linux-kernel+bounces-422449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F279D99D4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 15:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2195B22ED5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 14:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CDA1D5CDD;
	Tue, 26 Nov 2024 14:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4oW6OskR"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AAB1D5171
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732632162; cv=none; b=U/0QI3aSD5VRsTzYIn6xwyKvuUj8KDMCG7cZ2+vg880y3/PAlq1IxbFWam1z4NaIfEfLr7bH1IaBmMgUM6F+TIVmnUK2QdW+AO+HpWTUedT+vD4Cvlnw+9NmT+uumJfZiJrS7p8FR7c+7vWJL2BMHm9a8pTAHfkismJFhirdfqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732632162; c=relaxed/simple;
	bh=j0T96dD6xbL5EDFXXQFN2XHfqDDtrEleXyOQHms9RGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RJs9iUcVKyok/y2Cg5sp/+pxnRr6LpsoPdkvpLFtEsR3jpGR2zlzfy8uFB1Y7cAqCK5T/WeBxeG6rwDH/roBS09wxqQk9y7twNCVPPv/8fL5M3XahtYAWUy/gon6/pAq3mmC53k0FYmGNR8Fw0IXE1X9m89C1c0U0dsI33Xo+Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4oW6OskR; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ff64e5d31bso53449231fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 06:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732632158; x=1733236958; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7INKxNsoBODRTMJd+3iJToNOHtOpmi4eft+zJd41a8=;
        b=4oW6OskRUvvTnFFlVZ+nhljD7s7Mwn1btLgryltMYetQ/acjFXxE9GgGGt62+tuLnH
         rkw3XajSO6KLq/p4LPbV/e0boCqB4LCXbkbZierUkS7qyzx8xABnVmOQzbBk7h4ndYyu
         VTmN4RMx9vd1LhdL9F1BgFGViA804JvTaY1Mk+mgv8BPOAdiLvUFxRgll7czabwdy389
         GsPwuTA7+FFRjhYnA5uPWJWzkTZL3W2BIX8QsemMkBimCNMjGc5R8qoV0wewbM4DY/UU
         zY98aLn5MYaq77tgle45NRYXRBbSNn1O7qhsr6AamVbm+oqSTIiRMl8qbMzh0Y5mBFxS
         uRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732632158; x=1733236958;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y7INKxNsoBODRTMJd+3iJToNOHtOpmi4eft+zJd41a8=;
        b=GZ+0z1ykpnvfZqvgwd42kN2qY0Q3BdDLdTfFXlG4Q4TZIXdFHnypOiut8lFgIV/5X3
         8W/6NuNBxIQS+2NAEbabuiWAotkWM3c4YJZJHRA/xcmU/CpSniMaGf6NjaaWHe+rwJ7+
         RkviYcfsZR13SKmtVgLkDtEYVoaZYBVYxKHSmSulHCRy7HVccHomRWOSfNJUlsxZcIK5
         4Kk+h5oIoKsCDzMFrdV7c9nmMFAUAjvpDyFND2sQWpbneCtyvcPE5QwOIVxCB3cBle5J
         +gCSHjpBR2TKNg22LltAnEqeSl7jzJFQgODpAUpkSTX73AtI6YgrKt9skLJT2kQpYCoG
         J3XA==
X-Gm-Message-State: AOJu0YwenFXZWvXGL/zi/CYDo9+46ZkqGK/PDvAfKaULFg5HOufKdUu/
	GNXaXfWSGiILtlKnk9j75uuoYLBVShi0C3QPT/23L7Y54cieHU53f2uitYq451osVCQ8WlQNp2H
	Ea4vb85yBw89vg+/plkNbI7tqgBELJ1ySAuHD
X-Gm-Gg: ASbGnctVN0fu+SMGfHmVi1Df6IdATxnrItOKdtfQXcU9dQLFXQE3Ee8scs4ystMGlSB
	JRXSTJYEtt2OLamLYZrqYVdHOYwzAxUb2QUG3k98qeyPoHxDJMDO1BzEroMew8w==
X-Google-Smtp-Source: AGHT+IHS6n78Cl1GwbvftzfJ3pWRVTCaqEx+Whjz+XQMuhnnh5zX2CzWSGGV8erP7MDqzabpCvwPCmvsJURrgVv0FFg=
X-Received: by 2002:a2e:a803:0:b0:2f9:cc40:6afe with SMTP id
 38308e7fff4ca-2ffa7106890mr82169991fa.14.1732632158090; Tue, 26 Nov 2024
 06:42:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6745ddde.050a0220.1286eb.001a.GAE@google.com>
In-Reply-To: <6745ddde.050a0220.1286eb.001a.GAE@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 26 Nov 2024 15:42:26 +0100
Message-ID: <CACT4Y+ZDyET-JR3cHXL8srwUwSiq0jr+jysH3oD4aLcHXyvwGw@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] KASAN: wild-memory-access Read in rto_push_irq_work_func
To: syzbot <syzbot+c2df1ce81db95611698a@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Nov 2024 at 15:40, syzbot
<syzbot+c2df1ce81db95611698a@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    59b723cd2adb Linux 6.12-rc6
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17e2f630580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=11254d3590b16717
> dashboard link: https://syzkaller.appspot.com/bug?extid=c2df1ce81db95611698a
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

WARNING: locking bug in rto_push_irq_work_func
also happened several times in a similar stack:
https://lore.kernel.org/all/670daf6e.050a0220.d9b66.014a.GAE@google.com/T/
https://syzkaller.appspot.com/bug?extid=da051a9137a15fa8ecdf

It starts looking suspicious.


> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/18cd6bff403e/disk-59b723cd.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/79241ecdd1c5/vmlinux-59b723cd.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/66ecbfab6b13/bzImage-59b723cd.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c2df1ce81db95611698a@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: wild-memory-access in instrument_atomic_read include/linux/instrumented.h:68 [inline]
> BUG: KASAN: wild-memory-access in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
> BUG: KASAN: wild-memory-access in __lock_acquire+0xc8b/0x2050 kernel/locking/lockdep.c:5172
> Read of size 8 at addr 1fffffff87715c68 by task syz.0.1/6002
>
> CPU: 0 UID: 0 PID: 6002 Comm: syz.0.1 Not tainted 6.12.0-rc6-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_report+0xe8/0x550 mm/kasan/report.c:491
>  kasan_report+0x143/0x180 mm/kasan/report.c:601
>  kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
>  instrument_atomic_read include/linux/instrumented.h:68 [inline]
>  _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
>  __lock_acquire+0xc8b/0x2050 kernel/locking/lockdep.c:5172
>  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
>  _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
>  raw_spin_rq_lock_nested+0xb0/0x140 kernel/sched/core.c:606
>  raw_spin_rq_lock kernel/sched/sched.h:1505 [inline]
>  rto_push_irq_work_func+0x86/0x350 kernel/sched/rt.c:2259
>  irq_work_single+0x136/0x240 kernel/irq_work.c:221
>  irq_work_run_list kernel/irq_work.c:252 [inline]
>  irq_work_run+0x18b/0x350 kernel/irq_work.c:261
>  __sysvec_irq_work+0xb8/0x430 arch/x86/kernel/irq_work.c:22
>  instr_sysvec_irq_work arch/x86/kernel/irq_work.c:17 [inline]
>  sysvec_irq_work+0x9e/0xc0 arch/x86/kernel/irq_work.c:17
>  </IRQ>
>  <TASK>
>  asm_sysvec_irq_work+0x1a/0x20 arch/x86/include/asm/idtentry.h:738
> RIP: 0010:finish_task_switch+0x1ea/0x870 kernel/sched/core.c:5202
> Code: c9 50 e8 79 00 0c 00 48 83 c4 08 4c 89 f7 e8 4d 39 00 00 e9 de 04 00 00 4c 89 f7 e8 50 ad 6c 0a e8 0b 5a 38 00 fb 48 8b 5d c0 <48> 8d bb f8 15 00 00 48 89 f8 48 c1 e8 03 49 be 00 00 00 00 00 fc
> RSP: 0018:ffffc900034e6b88 EFLAGS: 00000282
> RAX: 86403ade1ffdd400 RBX: ffff8880300d8000 RCX: ffffffff9a3d4903
> RDX: dffffc0000000000 RSI: ffffffff8c0acaa0 RDI: ffffffff8c610820
> RBP: ffffc900034e6bd0 R08: ffffffff901d08ef R09: 1ffffffff203a11d
> R10: dffffc0000000000 R11: fffffbfff203a11e R12: 1ffff110170c7f14
> R13: dffffc0000000000 R14: ffff8880b863ea80 R15: ffff8880b863f8a0
>  context_switch kernel/sched/core.c:5331 [inline]
>  __schedule+0x1857/0x4c30 kernel/sched/core.c:6690
>  preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:7012
>  irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
> RIP: 0010:unwind_get_return_address+0x9/0x90 arch/x86/kernel/unwind_orc.c:365
> Code: ff ff e8 ea e1 85 0a 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 41 57 41 56 53 <48> 89 fb 49 be 00 00 00 00 00 fc ff df 48 89 f8 48 c1 e8 03 42 0f
> RSP: 0018:ffffc900034e6f80 EFLAGS: 00000202
> RAX: 0000000080000001 RBX: ffffc900034e6fa0 RCX: 0000000080000000
> RDX: dffffc0000000000 RSI: ffffc900034e0000 RDI: ffffc900034e6fa0
> RBP: ffffc900034e7030 R08: ffffc900034e7790 R09: ffffc900034e6ff0
> R10: dffffc0000000000 R11: fffff5200069ce00 R12: ffff8880300d8000
> R13: ffffffff818092c0 R14: ffffc900034e7080 R15: 0000000000000000
>  arch_stack_walk+0xfd/0x150 arch/x86/kernel/stacktrace.c:26
>  stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
>  save_stack+0xfb/0x1f0 mm/page_owner.c:156
>  __set_page_owner+0x92/0x800 mm/page_owner.c:320
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
>  prep_new_page mm/page_alloc.c:1545 [inline]
>  get_page_from_freelist+0x303f/0x3190 mm/page_alloc.c:3457
>  __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
>  alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
>  vm_area_alloc_pages mm/vmalloc.c:3568 [inline]
>  __vmalloc_area_node mm/vmalloc.c:3646 [inline]
>  __vmalloc_node_range_noprof+0xa2b/0x13f0 mm/vmalloc.c:3828
>  alloc_thread_stack_node kernel/fork.c:315 [inline]
>  dup_task_struct+0x444/0x8c0 kernel/fork.c:1116
>  copy_process+0x5d1/0x3d50 kernel/fork.c:2204
>  kernel_clone+0x226/0x8f0 kernel/fork.c:2786
>  __do_sys_clone3 kernel/fork.c:3090 [inline]
>  __se_sys_clone3+0x2d8/0x360 kernel/fork.c:3069
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f85d55b2779
> Code: 68 07 00 48 8d 3d ec 68 07 00 e8 92 28 f6 ff 66 90 b8 ea ff ff ff 48 85 ff 74 2c 48 85 d2 74 27 49 89 c8 b8 b3 01 00 00 0f 05 <48> 85 c0 7c 18 74 01 c3 31 ed 48 83 e4 f0 4c 89 c7 ff d2 48 89 c7
> RSP: 002b:00007ffe381a0b08 EFLAGS: 00000206 ORIG_RAX: 00000000000001b3
> RAX: ffffffffffffffda RBX: 00007f85d55350a0 RCX: 00007f85d55b2779
> RDX: 00007f85d55350a0 RSI: 0000000000000058 RDI: 00007ffe381a0b50
> RBP: 00007f85d632b6c0 R08: 00007f85d632b6c0 R09: 00007ffe381a0c37
> R10: 0000000000000008 R11: 0000000000000206 R12: ffffffffffffffa8
> R13: 000000000000006e R14: 00007ffe381a0b50 R15: 00007ffe381a0c38
>  </TASK>
> ==================================================================
> ----------------
> Code disassembly (best guess):
>    0:   c9                      leave
>    1:   50                      push   %rax
>    2:   e8 79 00 0c 00          call   0xc0080
>    7:   48 83 c4 08             add    $0x8,%rsp
>    b:   4c 89 f7                mov    %r14,%rdi
>    e:   e8 4d 39 00 00          call   0x3960
>   13:   e9 de 04 00 00          jmp    0x4f6
>   18:   4c 89 f7                mov    %r14,%rdi
>   1b:   e8 50 ad 6c 0a          call   0xa6cad70
>   20:   e8 0b 5a 38 00          call   0x385a30
>   25:   fb                      sti
>   26:   48 8b 5d c0             mov    -0x40(%rbp),%rbx
> * 2a:   48 8d bb f8 15 00 00    lea    0x15f8(%rbx),%rdi <-- trapping instruction
>   31:   48 89 f8                mov    %rdi,%rax
>   34:   48 c1 e8 03             shr    $0x3,%rax
>   38:   49                      rex.WB
>   39:   be 00 00 00 00          mov    $0x0,%esi
>   3e:   00 fc                   add    %bh,%ah
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/syzkaller-bugs/6745ddde.050a0220.1286eb.001a.GAE%40google.com.

