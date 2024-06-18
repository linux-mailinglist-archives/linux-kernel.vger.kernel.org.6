Return-Path: <linux-kernel+bounces-219424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F12890D10E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D09301F21087
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CB419DF42;
	Tue, 18 Jun 2024 13:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infogain-com.20230601.gappssmtp.com header.i=@infogain-com.20230601.gappssmtp.com header.b="FBHsZcud"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9EA157E99
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 13:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715949; cv=none; b=fQ9gApccXwHlzN8ZAom4lhUB0uENd/0ey836F2nY0ZauVycGa/THNquV3miGlzOHxOt1u7i6ndz1LQz5PLeOkZkEldTP4rIIR0JRQEGERF84QRs/M+kztYF9OtJK4w5uFYjhcTgz5u3Hg7ufk9dgcSt1UBjWSIthbKsvVmP9iss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715949; c=relaxed/simple;
	bh=zdb+ho3pPIoPn8AAK/HbH3ZVdLbA+baUi0Wi9/xKYQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qX9eJoY+of3ipCy2HYvyb/oAqbMsMGJ3TMXbB25bMBRf8RK9gyR1Pf1Ap2uD2hOKAxbyH/Ko/nWt92Rwnob4Q1Rf1QG/4tlkwYZr+LdeLH/srzUYbHdMEWWb5QUVGI82WUw3vKGD7o+na+ebwEE+ha/0P76CaRhj4fZRJDgwd5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=infogain.com; spf=fail smtp.mailfrom=infogain.com; dkim=pass (2048-bit key) header.d=infogain-com.20230601.gappssmtp.com header.i=@infogain-com.20230601.gappssmtp.com header.b=FBHsZcud; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=infogain.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=infogain.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52bc29c79fdso7352424e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 06:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=infogain-com.20230601.gappssmtp.com; s=20230601; t=1718715945; x=1719320745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gurMlKoJebwFTS6t9Eq29wcOin62YgJXyKoM0uBnE4M=;
        b=FBHsZcudXm+nSnKPumiMM5ufZK5o8kVTjByMI6GtF5zCbqDv1A6qMwlgLc1ecLD37g
         eMblfg3QvrmpwzcPgESZv15bWiGslz+93SMkTmbfZw2Rx0G8Bla/qFrHIfRwwUOe42SZ
         4PcXUn/Qg5tEuPkVB50vnS1abQISHQ6JTea1vvTSystg4t2AeaTX1lFRJy6E5Z/RezuY
         N1ZAPke2rA8udXGWuDgaVtfFLxL1hLAzhyaN/oXQ9+37zd05FvmgIS0s103spZLroDj1
         ytNhM3xRo3j2+jT3PAbilH6wIbIucoUkFfNVa9cqm+57KzoAKU76llsMV/kaTV902/4r
         6kYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718715945; x=1719320745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gurMlKoJebwFTS6t9Eq29wcOin62YgJXyKoM0uBnE4M=;
        b=Hu6aAktRhZtdBv1V2v/yoGyUB8GxsmU9HH9oIBHPNPvrEyhhLJ7DVB0344NsESPxcK
         b/1zJbYdMpyHFjUBWwyAwqNFBR9lsOG5RJ8GrRsKgDOqNrzHfkO9O8L7mpVUt421ujGn
         SJuukyB0vxFQg8IRBfO7SePf4/dqn7Ab/gyXvQKXFbCOCt3ffM6twI9deDhbXeO3bxW/
         fUZCklcOYHRWztIyKVUgMtYXQmK90oCs1bp4FSC2BdC7RDmOCChfzxoiljCSLhSQQHMw
         3q/FqbvH+qyuNQve2d/1TbZe8kFoE2eeT2/Sax/pBWvwEpKYkpEqEAwxhuNZXs/tV8LH
         vFEg==
X-Forwarded-Encrypted: i=1; AJvYcCV7d5eP2WoJh9l1enY6/2T5wFg0X4N5eqBzJxKk+2ROv0v8yzTWDfW++SpmZWox4TZS8pyPBcYFNzv6bYpmA7cgPYCdF2OG6vNsWHq9
X-Gm-Message-State: AOJu0YyOMc5qOfpcTTsvqe7dRZqFVrd9J45tfjn00MJwPqlvtyLgq1U0
	F7C94kIZGgeSbHRlVrZidUcsiR0x4S+q9gYzBfSWLyROa8uwCFKNLl2J84O2IGM=
X-Google-Smtp-Source: AGHT+IH2yRatTfb0TtRcllAOOmTA1l+AXig7QD/iZo0/9sIm6a+Pi1e29hHWMkwuOFUVUSnJjG+G4w==
X-Received: by 2002:a05:6512:3f27:b0:52c:9ae0:beed with SMTP id 2adb3069b0e04-52ca6e92a3cmr12018362e87.52.1718715943664;
        Tue, 18 Jun 2024 06:05:43 -0700 (PDT)
Received: from localhost.localdomain ([37.109.150.105])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f427casm623020166b.176.2024.06.18.06.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 06:05:43 -0700 (PDT)
From: =?UTF-8?q?Wojciech=20G=C5=82adysz?= <wojciech.gladysz@infogain.com>
To: syzbot+1971e47e5210c718db3c@syzkaller.appspotmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	sdf@google.com,
	song@kernel.org,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev,
	=?UTF-8?q?Wojciech=20G=C5=82adysz?= <wojciech.gladysz@infogain.com>
Subject: [PATCH] kernel/bpf: enable BPF bytecode call parsing for uninit value
Date: Tue, 18 Jun 2024 15:05:18 +0200
Message-Id: <20240618130518.25884-1-wojciech.gladysz@infogain.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <0000000000008312ad06163b7225@google.com>
References: <0000000000008312ad06163b7225@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
pointed to by R2 BPF register and adjust memcpy length:

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

=====================================================
BUG: KMSAN: uninit-value in __htab_map_lookup_elem kernel/bpf/hashtab.c:691 [inline]
BUG: KMSAN: uninit-value in htab_lru_percpu_map_lookup_percpu_elem+0x3f8/0x630 kernel/bpf/hashtab.c:2343
 __htab_map_lookup_elem kernel/bpf/hashtab.c:691 [inline]
 htab_lru_percpu_map_lookup_percpu_elem+0x3f8/0x630 kernel/bpf/hashtab.c:2343
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
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x83/0x90 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1f/0x30 arch/x86/include/asm/idtentry.h:702
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

CPU: 0 PID: 5018 Comm: strace-static-x Not tainted 6.9.0-rc3-syzkaller-00355-g7efd0a74039f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
=====================================================

Reported-by: syzbot+1971e47e5210c718db3c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1971e47e5210c718db3c
Link: https://lore.kernel.org/all/0000000000008312ad06163b7225@google.com/T/
Signed-off-by: Wojciech Gładysz <wojciech.gladysz@infogain.com>
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
-		bounds_check_type = BPF_WRITE;
-		clobber = true;
+		clobber = !meta || meta->raw_mode;
+		bounds_check_type = clobber ? BPF_WRITE : BPF_READ;
 	} else {
 		bounds_check_type = BPF_READ;
 	}
@@ -7230,8 +7230,7 @@ static int check_stack_range_initialized(
 		stype = &state->stack[spi].slot_type[slot % BPF_REG_SIZE];
 		if (*stype == STACK_MISC)
 			goto mark;
-		if ((*stype == STACK_ZERO) ||
-		    (*stype == STACK_INVALID && env->allow_uninit_stack)) {
+		if (*stype == STACK_ZERO) {
 			if (clobber) {
 				/* helper can write anything into the stack */
 				*stype = STACK_MISC;
@@ -8748,6 +8747,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		meta->map_uid = reg->map_uid;
 		break;
 	case ARG_PTR_TO_MAP_KEY:
+		/* always mark read access */
+		meta->raw_mode = false;
 		/* bpf_map_xxx(..., map_ptr, ..., key) call:
 		 * check that [key, key + map->key_size) are within
 		 * stack limits and initialized
@@ -8763,7 +8764,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		}
 		err = check_helper_mem_access(env, regno,
 					      meta->map_ptr->key_size, false,
-					      NULL);
+					      meta);
 		break;
 	case ARG_PTR_TO_MAP_VALUE:
 		if (type_may_be_null(arg_type) && register_is_null(reg))
-- 
2.35.3


