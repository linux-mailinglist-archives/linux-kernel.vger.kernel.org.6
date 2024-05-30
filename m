Return-Path: <linux-kernel+bounces-194800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC188D4243
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 02:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 380C11C21047
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 00:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565FD1799D;
	Thu, 30 May 2024 00:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="eTedO9Zk"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54F9DDDA
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 00:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717028262; cv=none; b=YgojpL/TlnzelwhK1wlJAMSJ8Cd6QEWVT2TWyJIROnbph6DGAsn6j2OQDbEASKsSsL382XfJL/bSsN/IQuCpT6g1VOQUyhoGXEO68picClslPlHXZDUCYQkXWDBkDR9yCsupv7tHaM/h7wsS9dKv4cLpXR5k8FsSh0/CO1jZirM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717028262; c=relaxed/simple;
	bh=OWoekbHvQ7nOQqARlv7LYoja5CkxjRX5DxERn5kyNN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kil5q+ftAljBQxZSgk10/OjPnTtuVB8qJmRNnfFDbvjzjpfm1nE0zqopiTr0PslLW8R6uaLR4QpZ55EWAWRHLpUcHtzqRPEYBydHd8QzLFCxLmHi/X4B7Z9tsHrMsJmVQBVM/RonI2VmUXwLeSIVm5vniITd/HbhDL77zgHwVJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=eTedO9Zk; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2c1a9b151bcso236063a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 17:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1717028260; x=1717633060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xM/ESoaJ23Br0UgFTe6IQH0BbO+2q0cmF/lAEmoPXas=;
        b=eTedO9ZkjaXCu93173RqYLBHk/fIPKjBOBGMSoTg1hf4+nd7VMWvTQXutnWxOjkJ3h
         BwqFr/YjIPniJZRYJa2hiMcLTu8kOYcTblQWhJr63tVaIC01p7l4pFTmUUs8xnpvqo70
         Jse73caE5sVrYqPbmRt7rgLLsg6Csbxbf2xWQiw08gsgEEuj9NlDaZjJzb1ozyFLNREj
         yae+c5zmm8FFPqMAD7zdoBcWVJIULJK+2vvo/x2ys0Cf8MrHDAbYVsHk25WjYXBaiSL1
         0sAHXSY4Gmg4YmQcRyXgKe9h3VKWSyGbhSJIz7IMD2rbET6sqFyZlowMpwBlbmSV1h9t
         gvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717028260; x=1717633060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xM/ESoaJ23Br0UgFTe6IQH0BbO+2q0cmF/lAEmoPXas=;
        b=XoyGlRmu5oO6gCCZ7Ge1SBxJGoce+ATHvwPXqQJ3Q0xkVdtQhA5TtdR0SwaLvDWGA0
         s/KTNugn/Ot2v4VlEILtaN37gWNSfCvfxQvDiJo5KM3UMkIDxJ8Yi80FhG19P0dx0G0n
         Ir1ZXe8seAADrRzAH7aW+A91TWpIhPVyOLVmi3i0tzN9lzQgFj1Fj458UfbbXYdHQOsN
         qZxlkj5RUezrCVpaIToqcahc4pw3sBbbzkcIZMIJ9AA+mcQE6uupn1YyUf1T4qg3VE+a
         iZj2HCrZUBEdkI2VqkCHpvtA+b12sTCMlsjquHBawbnCo3TXo/8SEm8VoDKAVfYmBNmu
         XK0g==
X-Gm-Message-State: AOJu0Yz/T5NQcJkLQP1mYwSGPfUPos55UvlQqd0AVulipzPTyI5o+/rV
	1iSyFfd0qbEA503A0x2bKIvEw5lYb/oTPl/tqD5c+EwhI78PktvcePOuVetwzfU=
X-Google-Smtp-Source: AGHT+IGL+E/7b54TqXhjg4b7i20AFCS38QG/+9WHYKtBzXAhSy55KZzGAnUPFX5KV7QGVTHOSWayRQ==
X-Received: by 2002:a17:90a:be11:b0:2bf:bb85:edc1 with SMTP id 98e67ed59e1d1-2c1abc79fd1mr668298a91.40.1717028260094;
        Wed, 29 May 2024 17:17:40 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a776e206sm432171a91.20.2024.05.29.17.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 17:17:39 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-kernel@vger.kernel.org,
	Andy Chiu <andy.chiu@sifive.com>,
	linux-riscv@lists.infradead.org,
	Matthew Bystrin <dev.mbstr@gmail.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 4/4] riscv: entry: Save a frame record for exceptions
Date: Wed, 29 May 2024 17:15:59 -0700
Message-ID: <20240530001733.1407654-5-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240530001733.1407654-1-samuel.holland@sifive.com>
References: <20240530001733.1407654-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This follows the frame pointer ABI and allows stack traces to cross
exception boundaries without a special case in the stack walking code.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/include/asm/processor.h  |  9 +++++++--
 arch/riscv/include/asm/ptrace.h     |  5 +++++
 arch/riscv/include/asm/stacktrace.h |  5 -----
 arch/riscv/kernel/asm-offsets.c     |  6 +++---
 arch/riscv/kernel/entry.S           | 16 ++++++++++------
 arch/riscv/kernel/head.S            |  6 ++----
 arch/riscv/kernel/stacktrace.c      |  9 ---------
 7 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 68c3432dc6ea..ccbb1e363c7f 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -144,9 +144,14 @@ static inline void arch_thread_struct_whitelist(unsigned long *offset,
 	.align_ctl = PR_UNALIGN_NOPRINT,		\
 }
 
+#ifdef CONFIG_FRAME_POINTER
+#define EXCEPTION_FRAME_SIZE ALIGN(sizeof(struct pt_regs) + sizeof(struct stackframe), STACK_ALIGN)
+#else
+#define EXCEPTION_FRAME_SIZE ALIGN(sizeof(struct pt_regs), STACK_ALIGN)
+#endif
+
 #define task_pt_regs(tsk)						\
-	((struct pt_regs *)(task_stack_page(tsk) + THREAD_SIZE		\
-			    - ALIGN(sizeof(struct pt_regs), STACK_ALIGN)))
+	((struct pt_regs *)(task_stack_page(tsk) + THREAD_SIZE - EXCEPTION_FRAME_SIZE))
 
 #define KSTK_EIP(tsk)		(task_pt_regs(tsk)->epc)
 #define KSTK_ESP(tsk)		(task_pt_regs(tsk)->sp)
diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptrace.h
index b5b0adcc85c1..f475f6acec49 100644
--- a/arch/riscv/include/asm/ptrace.h
+++ b/arch/riscv/include/asm/ptrace.h
@@ -12,6 +12,11 @@
 
 #ifndef __ASSEMBLY__
 
+struct stackframe {
+	unsigned long fp;
+	unsigned long ra;
+};
+
 struct pt_regs {
 	unsigned long epc;
 	unsigned long ra;
diff --git a/arch/riscv/include/asm/stacktrace.h b/arch/riscv/include/asm/stacktrace.h
index b1495a7e06ce..3019558f747c 100644
--- a/arch/riscv/include/asm/stacktrace.h
+++ b/arch/riscv/include/asm/stacktrace.h
@@ -6,11 +6,6 @@
 #include <linux/sched.h>
 #include <asm/ptrace.h>
 
-struct stackframe {
-	unsigned long fp;
-	unsigned long ra;
-};
-
 extern void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 				    bool (*fn)(void *, unsigned long), void *arg);
 extern void dump_backtrace(struct pt_regs *regs, struct task_struct *task,
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index 84c056f5ee09..582b52713e93 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -477,10 +477,10 @@ void asm_offsets(void)
 	);
 
 	/*
-	 * We allocate a pt_regs on the stack when entering the kernel.  This
-	 * ensures the alignment is sane.
+	 * We allocate a pt_regs and possibly a stackframe on the stack when
+	 * entering the kernel. This ensures the alignment is sane.
 	 */
-	DEFINE(PT_SIZE_ON_STACK, ALIGN(sizeof(struct pt_regs), STACK_ALIGN));
+	DEFINE(EXCEPTION_FRAME_SIZE, EXCEPTION_FRAME_SIZE);
 
 	OFFSET(KERNEL_MAP_VIRT_ADDR, kernel_mapping, virt_addr);
 	OFFSET(SBI_HART_BOOT_TASK_PTR_OFFSET, sbi_hart_boot_data, task_ptr);
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index bd1c5621df45..cdb58ce32cbb 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -33,7 +33,7 @@ SYM_CODE_START(handle_exception)
 	REG_S sp, TASK_TI_KERNEL_SP(tp)
 
 #ifdef CONFIG_VMAP_STACK
-	addi sp, sp, -(PT_SIZE_ON_STACK)
+	addi sp, sp, -EXCEPTION_FRAME_SIZE
 	srli sp, sp, THREAD_SHIFT
 	andi sp, sp, 0x1
 	bnez sp, handle_kernel_stack_overflow
@@ -43,7 +43,7 @@ SYM_CODE_START(handle_exception)
 .Lsave_context:
 	REG_S sp, TASK_TI_USER_SP(tp)
 	REG_L sp, TASK_TI_KERNEL_SP(tp)
-	addi sp, sp, -(PT_SIZE_ON_STACK)
+	addi sp, sp, -EXCEPTION_FRAME_SIZE
 	REG_S x1,  PT_RA(sp)
 	REG_S x3,  PT_GP(sp)
 	REG_S x5,  PT_T0(sp)
@@ -83,6 +83,12 @@ SYM_CODE_START(handle_exception)
 	/* Load the kernel shadow call stack pointer if coming from userspace */
 	scs_load_current_if_task_changed s5
 
+#ifdef CONFIG_FRAME_POINTER
+	REG_S	ra, (EXCEPTION_FRAME_SIZE + STACKFRAME_RA)(sp)
+	REG_S	s0, (EXCEPTION_FRAME_SIZE + STACKFRAME_FP)(sp)
+	addi	s0, sp, EXCEPTION_FRAME_SIZE
+#endif
+
 #ifdef CONFIG_RISCV_ISA_V_PREEMPTIVE
 	move a0, sp
 	call riscv_v_context_nesting_start
@@ -136,7 +142,7 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
 	bnez t0, 1f
 
 	/* Save unwound kernel stack pointer in thread_info */
-	addi t0, sp, PT_SIZE_ON_STACK
+	addi t0, sp, EXCEPTION_FRAME_SIZE
 	REG_S t0, TASK_TI_KERNEL_SP(tp)
 
 	/* Save the kernel shadow call stack pointer */
@@ -192,14 +198,12 @@ SYM_CODE_START_LOCAL(handle_kernel_stack_overflow)
 	/* we reach here from kernel context, sscratch must be 0 */
 	csrrw x31, CSR_SCRATCH, x31
 	asm_per_cpu sp, overflow_stack, x31
-	li x31, OVERFLOW_STACK_SIZE
+	li x31, OVERFLOW_STACK_SIZE - EXCEPTION_FRAME_SIZE
 	add sp, sp, x31
 	/* zero out x31 again and restore x31 */
 	xor x31, x31, x31
 	csrrw x31, CSR_SCRATCH, x31
 
-	addi sp, sp, -(PT_SIZE_ON_STACK)
-
 	//save context to overflow stack
 	REG_S x1,  PT_RA(sp)
 	REG_S x3,  PT_GP(sp)
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 4236a69c35cb..09ee5e6c2a98 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -290,9 +290,8 @@ SYM_CODE_START(_start_kernel)
 
 	/* Initialize page tables and relocate to virtual addresses */
 	la tp, init_task
-	la sp, init_thread_union + THREAD_SIZE
+	la sp, init_thread_union + THREAD_SIZE - EXCEPTION_FRAME_SIZE
 	XIP_FIXUP_OFFSET sp
-	addi sp, sp, -PT_SIZE_ON_STACK
 	scs_load_init_stack
 #ifdef CONFIG_BUILTIN_DTB
 	la a0, __dtb_start
@@ -310,8 +309,7 @@ SYM_CODE_START(_start_kernel)
 	call .Lsetup_trap_vector
 	/* Restore C environment */
 	la tp, init_task
-	la sp, init_thread_union + THREAD_SIZE
-	addi sp, sp, -PT_SIZE_ON_STACK
+	la sp, init_thread_union + THREAD_SIZE - EXCEPTION_FRAME_SIZE
 	scs_load_current
 
 #ifdef CONFIG_KASAN
diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 528ec7cc9a62..6be8f8942f6b 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -16,8 +16,6 @@
 
 #ifdef CONFIG_FRAME_POINTER
 
-extern asmlinkage void ret_from_exception(void);
-
 static inline int fp_is_valid(unsigned long fp, unsigned long sp)
 {
 	unsigned long low, high;
@@ -70,13 +68,6 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 			fp = frame->fp;
 			pc = ftrace_graph_ret_addr(current, NULL, frame->ra,
 						   &frame->ra);
-			if (pc == (unsigned long)ret_from_exception) {
-				if (unlikely(!__kernel_text_address(pc) || !fn(arg, pc)))
-					break;
-
-				pc = ((struct pt_regs *)sp)->epc;
-				fp = ((struct pt_regs *)sp)->s0;
-			}
 		}
 
 	}
-- 
2.44.1


