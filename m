Return-Path: <linux-kernel+bounces-235979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB46C91DBFC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 449972807BB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CA112D74E;
	Mon,  1 Jul 2024 10:02:39 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE7012C7FD
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 10:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719828159; cv=none; b=gmnI6e+KRpXGHaVW46AyeyK2lm540F26YT4skYl410/RV9e/zmet++4bFTofH2l3xUjy0lRER9zRqrDo7ajJ9ZXX23spPVstk19YLKnxNVC4qHdXKOdMp6MGer1Qiro+/iPB4th4KOnvx6WRxeEdQdNno+Do0vwnQBVBVSG0PDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719828159; c=relaxed/simple;
	bh=l0PG+9fzewN/NNN8GKb4U64bcvtaTZGXu7yfWtj0MXw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=X5zCsDxja3U1Gvlg8tMeLFY/SxH+l1faLVf+zJI1zlrA999oVk59yjxHOodWNzlyR+HIOYWsZkpEYSw2gF4CA+55oEZd+BfoA+flKRE3EDh9L0EjbMWZR446X+QPCFpZ1WSBbfM+TqTPB/OREtui9xODV43ddTX3YM4oK69YErs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f61f4c998bso298779339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 03:02:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719828157; x=1720432957;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MTngTwgvE0HJeWZF/ux8gdixuOt/+voiobc996Ttus=;
        b=lZnjrgRszAoN6z/LrlOzhEiGvgz4jBpSyBjfvyBE2xS5sOlgceboBaiR9K4rzN/WeL
         IYZPwDgdnkySlihUKrOqRQCDOfSbnqzwEJjOVGWVd2cQJ5iiV9p3wWMGXnYGL/aDDxgc
         q7GyCKoD8ab1+wrJBH+LYhCS/NuGsyXG/IRJoFv4ghISNAzSYk8LMw2dgDdIdwzRNh9q
         cNGQtZubavE8pSi3BpmySfrqBOWETcfaqUf+3csgc9sVuTWBnAr4WHWrcD4zTihNsR7V
         60PCulaxxcOSdt4NB4GC0E8wW5mqgV7HnEsXI7R8753TgO0yqbKGTE1XVfxmBhlNA+i1
         mkAA==
X-Gm-Message-State: AOJu0YzWFBkyA4ozeTnla+654AgtwPQboDpi21Sw5isndfGu4jL42Scq
	qM542ESmvte9smFm/RdcNRoiDhW0lUkNemjwQZY5bhcABUhrRw4FXU2+TIzdJ8685ycLUu2Bky8
	H7X9eFTTlvBr9DsPzhrp4sRf92Rh8Jc2wroGfeesXdwk0AdyeUyem0h8=
X-Google-Smtp-Source: AGHT+IELxsAFxo78z3vNsCSworVSR0BBswPfmW5xztWKxoLX3RM9m73So1rjRpcJKO2Q8UVwzDMC+aXhw+cMzJ05sEbhttZUF1F0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4104:b0:4b9:ad20:51f7 with SMTP id
 8926c6da1cb9f-4bbb6b98278mr383722173.1.1719828156592; Mon, 01 Jul 2024
 03:02:36 -0700 (PDT)
Date: Mon, 01 Jul 2024 03:02:36 -0700
In-Reply-To: <000000000000be1f530615efc5ca@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000594f61061c2cb2c0@google.com>
Subject: Re: [syzbot] [PATCH] kernel/bpf: enable BPF bytecode call parsing for
 uninit value
From: syzbot <syzbot+c33bff5d5da1391df027@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] kernel/bpf: enable BPF bytecode call parsing for uninit va=
lue
Author: wojciech.gladysz@infogain.com

#syz test: https://linux.googlesource.com/linux/kernel/git/torvalds/linux e=
478cf26c556e4ab572ab0ab2306c986901dcd61

Some syzkaller repros create BPF code that passes as an argument to map
functions a pointer to uninitialized map key on bpf program stack. So far
handling calls to map functions did not check for not/initialized
pointed to values with some comments that it was not possible to tell the
pointer use be read or write op. This led to KMSAN report in a case of
reading not initialized map key.
The fix assumes ARG_PTR_TO_MAP_KEY arguments to map function calls from
BPF byte code are always of read type. For read access the value pointed
to by map key pointer is expected to be initialized. Otherwise the BPF
bytecode will not load.

You may want to add an STX line to your repro.c to init stack value
pointed to by R2 BPF register and adjust memcpy lenght:

  memcpy((void*)0x20000458,
         "\x00\x00\x00\x00\x00\x00\x00\x00"	// ...
	 "\xb7\x08\x00\x00\x00\x00\x00\x00"	// ALU64_MOV_K
	 "\x1f\x00\x00\x00\x00\x00\x00\x00"	// SUB_X?
	 "\xbf\xa2\x00\x00\x00\x00\x00\x00"	// ALU64_MOV_X
	 "\x07\x02\x00\x00\xf8\xff\xff\xff"	// ALU(64)_ADD_{K,X}
         "\x7a\x02\x00\x00\xef\xbe\xad\xde"	// *** STX ***
	 "\xb7\x03\x00\x00\x00\x00\x00\x00"	// ALU64_MOV_K
	 "\xb7\x04\x00\x00\x00\x00\x00\x00"	// ALU64_MOV_K
	 "\x85\x00\x00\x00\xc3\x00\x00\x00"	// CALL
	 "\x95", 73);				// EXIT

Syzbot report

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
BUG: KMSAN: uninit-value in __htab_map_lookup_elem kernel/bpf/hashtab.c:691=
 [inline]
BUG: KMSAN: uninit-value in htab_lru_percpu_map_lookup_percpu_elem+0x3f8/0x=
630 kernel/bpf/hashtab.c:2343
 __htab_map_lookup_elem kernel/bpf/hashtab.c:691 [inline]
 htab_lru_percpu_map_lookup_percpu_elem+0x3f8/0x630 kernel/bpf/hashtab.c:23=
43
 ____bpf_map_lookup_percpu_elem kernel/bpf/helpers.c:133 [inline]
 bpf_map_lookup_percpu_elem+0x67/0x90 kernel/bpf/helpers.c:130
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
 __bpf_prog_run32+0xb2/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x116/0x300 kernel/trace/bpf_trace.c:2420
 __bpf_trace_kfree+0x29/0x40 include/trace/events/kmem.h:94
 trace_kfree include/trace/events/kmem.h:94 [inline]
 kfree+0x6a5/0xa30 mm/slub.c:4377
 security_task_free+0x115/0x150 security/security.c:3032
 __put_task_struct+0x17f/0x730 kernel/fork.c:976
 put_task_struct include/linux/sched/task.h:138 [inline]
 delayed_put_task_struct+0x8a/0x280 kernel/exit.c:229
 rcu_do_batch kernel/rcu/tree.c:2196 [inline]
 rcu_core+0xa59/0x1e70 kernel/rcu/tree.c:2471
 rcu_core_si+0x12/0x20 kernel/rcu/tree.c:2488
 __do_softirq+0x1c0/0x7d7 kernel/softirq.c:554
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:633 [inline]
 irq_exit_rcu+0x6a/0x130 kernel/softirq.c:645
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline=
]
 sysvec_apic_timer_interrupt+0x83/0x90 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1f/0x30 arch/x86/include/asm/idtentry.h:=
702
 __msan_metadata_ptr_for_load_8+0x31/0x40 mm/kmsan/instrumentation.c:92
 filter_irq_stacks+0x60/0x1a0 kernel/stacktrace.c:397
 stack_depot_save_flags+0x2c/0x6e0 lib/stackdepot.c:609
 stack_depot_save+0x12/0x20 lib/stackdepot.c:685
 __msan_poison_alloca+0x106/0x1b0 mm/kmsan/instrumentation.c:285
 arch_local_save_flags arch/x86/include/asm/irqflags.h:67 [inline]
 arch_local_irq_save arch/x86/include/asm/irqflags.h:103 [inline]
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
 _raw_spin_lock_irqsave+0x35/0xc0 kernel/locking/spinlock.c:162
 remove_wait_queue+0x36/0x270 kernel/sched/wait.c:54
 do_wait+0x34a/0x530 kernel/exit.c:1640
 kernel_wait4+0x2ab/0x480 kernel/exit.c:1790
 __do_sys_wait4 kernel/exit.c:1818 [inline]
 __se_sys_wait4 kernel/exit.c:1814 [inline]
 __x64_sys_wait4+0x14e/0x310 kernel/exit.c:1814
 x64_sys_call+0x6e6/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:62
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable stack created at:
 __bpf_prog_run32+0x43/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x116/0x300 kernel/trace/bpf_trace.c:2420

CPU: 0 PID: 5018 Comm: strace-static-x Not tainted 6.9.0-rc3-syzkaller-0035=
5-g7efd0a74039f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 03/27/2024
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

Reported-by: syzbot+c33bff5d5da1391df027@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3Dc33bff5d5da1391df027
Link: https://lore.kernel.org/all/0000000000003bf1a0061ad85f3c@google.com/T=
/
Signed-off-by: Wojciech G=C5=82adysz <wojciech.gladysz@infogain.com>
---
 kernel/bpf/verifier.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 36ef8e96787e..13a9c2e2908a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7146,8 +7146,8 @@ static int check_stack_range_initialized(
 		 * reads. However, if raw_mode is not set, we'll do extra
 		 * checks below.
 		 */
-		bounds_check_type =3D BPF_WRITE;
-		clobber =3D true;
+		clobber =3D !meta || meta->raw_mode;
+		bounds_check_type =3D clobber ? BPF_WRITE : BPF_READ;
 	} else {
 		bounds_check_type =3D BPF_READ;
 	}
@@ -7230,8 +7230,7 @@ static int check_stack_range_initialized(
 		stype =3D &state->stack[spi].slot_type[slot % BPF_REG_SIZE];
 		if (*stype =3D=3D STACK_MISC)
 			goto mark;
-		if ((*stype =3D=3D STACK_ZERO) ||
-		    (*stype =3D=3D STACK_INVALID && env->allow_uninit_stack)) {
+		if (*stype =3D=3D STACK_ZERO) {
 			if (clobber) {
 				/* helper can write anything into the stack */
 				*stype =3D STACK_MISC;
@@ -8748,6 +8747,8 @@ static int check_func_arg(struct bpf_verifier_env *en=
v, u32 arg,
 		meta->map_uid =3D reg->map_uid;
 		break;
 	case ARG_PTR_TO_MAP_KEY:
+		/* always mark read access */
+		meta->raw_mode =3D false;
 		/* bpf_map_xxx(..., map_ptr, ..., key) call:
 		 * check that [key, key + map->key_size) are within
 		 * stack limits and initialized
@@ -8763,7 +8764,7 @@ static int check_func_arg(struct bpf_verifier_env *en=
v, u32 arg,
 		}
 		err =3D check_helper_mem_access(env, regno,
 					      meta->map_ptr->key_size, false,
-					      NULL);
+					      meta);
 		break;
 	case ARG_PTR_TO_MAP_VALUE:
 		if (type_may_be_null(arg_type) && register_is_null(reg))
--=20
2.35.3


