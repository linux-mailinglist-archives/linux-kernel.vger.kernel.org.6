Return-Path: <linux-kernel+bounces-214855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3739D908B23
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 13:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 503411C21D6E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 11:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18154195F00;
	Fri, 14 Jun 2024 11:57:46 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BA31DFED
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 11:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718366265; cv=none; b=DF3gGplLL0Qtv+YaaD84skUtqxquHbmsPikgUS8hhqtIAoqtJYCdgB9m2U8eTV48P+/pu61Z5c5K8yVCcTyPWCTsaCk5CGYIgKomoad+LIhyn9sn0TKyDcLFBIHAAkD0MxVyfC3gykRbpqc6s1rgcXhjKVk7xJzjpk8ExhOpXHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718366265; c=relaxed/simple;
	bh=De2tXSqEJRz/R1op2ZEtSXCpJqMb/34xHy2YwCujUIM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=i55MYADFSUN0prYY3ZwYVCUf2jywfb0rAF8yV1GeqX2cPMyKh8MiLwuOd00/h1Ck3Ca1jZwxaHYVEdKPetXDwDZNHoddcI46XrRbIPsmmucVOwxzsEEHyh4NybjAZ1j4JXKPkCwdz09S/qjGtgDcuQeW4C3zj+6oUyBMiZZoFSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-37596e877e9so24182945ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 04:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718366263; x=1718971063;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPzn42lp4zcRSu6J2gtceiJRAGpMoZR9woctyboCggk=;
        b=vYL70mwzYnLsidddFHv9w52MOe1H3r/kuL1orhA4ce2LVQtHRO8atUjYp1EhHdXzBk
         Z4mSJG+xWxi/mZGiqnqp6+kwevcqaA50Jm5Nx9Ie8aBx12satZ12vkl+0H9XwwcHGJ2M
         IWiueMfGg0z1WBonkSTFCAy4P3krWGR4BevJNEvMegVZMWROCsXySijRaChSsglENgcG
         Agrb5+bOal01Yuce7pL7zzvrhT+R5bZslGC35hzTNNK28mA5bQmt2JRSSi3QiP8iOPtH
         UwCSMZDfyUCME4aD7/7xOnIly+z0wgKG9TKR+2FQZJ/H5x9bnj2AxHj9lDRtqc3Q01N2
         eeAg==
X-Gm-Message-State: AOJu0YzZ+QNu/PHlwD/49TLhFpuSngLLWt6pHcx5fYDOqcX6pWXcK6vz
	k1lz0OZDNQzWFmMNpYND3QBgI8YYlMMjYSkvmYv8fTQ36o/D9+wm9y68jhQMzfzW+kqwuv0VBa9
	uxXMdNf3bGRgKKi8PGyW6fK/vF2QhVAXicaKwG7Gv8smUOne/3uaM3mg=
X-Google-Smtp-Source: AGHT+IGbA6VV113S7dPR9QDDQdYsaQNnuEp2Fv6O+Q4Xd14kYdvLURB0VL0RQ5UEBsRmILNY55RTI59CKXLFzh2QL4l3ZxExgytC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c28:b0:374:5d81:9135 with SMTP id
 e9e14a558f8ab-375e0c818b5mr1317645ab.0.1718366263171; Fri, 14 Jun 2024
 04:57:43 -0700 (PDT)
Date: Fri, 14 Jun 2024 04:57:43 -0700
In-Reply-To: <0000000000004cf0fe06160c8d71@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b5ee68061ad85218@google.com>
Subject: Re: [syzbot] [PATCH] kernel/bpf: KMSAN: uninit-value
From: syzbot <syzbot+0a079d6ef3831217a230@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] kernel/bpf: KMSAN: uninit-value
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


