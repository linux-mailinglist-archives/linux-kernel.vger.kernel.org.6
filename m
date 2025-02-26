Return-Path: <linux-kernel+bounces-534597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85731A468EB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10D9E188A5DC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED60238D39;
	Wed, 26 Feb 2025 18:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y14BTrLI"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620BA2376F8
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593170; cv=none; b=hftmd81krXHSjFnQj5S0kPsvzBZk8YgTH/R7MvhdKrH8HWdygP+ZSCGxDUjzZJm/EHUxmGahXtGwrgWH3jXua6V245+D1g7EkBXbAfRBjt1a9ecKfDFPc74crwv7JGfJ+RYN0jpU/Vd3MFhS/XobrRsg2XiTOxouKpMnrkh5YYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593170; c=relaxed/simple;
	bh=psXXdozQ8cmMNoyhe6WfyX2b0xDHLMpW1n/cO6IYXms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RsA+HRh/LHMZgzYyEceHW4crJNtd3LeilXgQYLKyy39v4UrL65myLfxcZ1s+/C10q5Q2JdOgY9zFOtzsL4hhx/xeBWAO+8LciFBIfp0tNgvXEt6hCjQAL4J1iDCmXgpeV/aGvbRtURBSyJ5bJ6ditw2VnQf4SiHj4Lx8/pG/WL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y14BTrLI; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5fcd124dd1cso45653eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740593164; x=1741197964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i67t7Mkp4mM65QsMQr6CC8tvD3rsmoWgTylULSSsfnA=;
        b=Y14BTrLI/+NNRF26y+PcBafGjlgHKUESxhnYNTFKznxvOVDfgVys4XQhhDpbzH3hwg
         WRyp3XR83+F72up6PNfR9QgudIcs20vmVrYgyE/QLg15qB08yjnVBERimsgah5vGQ7x3
         f84WE2BjJusk9eBQqb8mlhFeP2xeOyqlxt8RmMXD4TGKbL0XRnwL/ejW55d4oHjVvQhg
         C3PhDWlnvAhbYQ7BNXvaXqc09RmGCUhipYKUMsw90fhKkaPnkSvX2YBXtIGXESEVVTk1
         gPm8FcvPG2+ZX8kCDH6Yj6IOJylkzna3MN67rCoCmKyC9nnfyfZJ9Ai8ZJriQIH4OGoI
         SLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740593164; x=1741197964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i67t7Mkp4mM65QsMQr6CC8tvD3rsmoWgTylULSSsfnA=;
        b=qZPngj4fEsFdDfeZYltotJ3riR8jGGhor/TP2FSpJoWoBoAscc12DVsIT1+fB7I6Gq
         V0C6mnnWPJQJ/x96imsBkAIJcOY0vWjxIWM5q1f9pk6wNC6WiJrct5271uxaoQoybIDY
         CWuLkYSlaz+3T61VswL02LSnLbXd2wfJlShgo0ycExD/cXW3t2jMnFxS60v7SqcTmMQ5
         HnwzqlHcdTpZKODRUBQ8T2VEdCeijTNvPKZJUAQABzlTC4bk4sUdISaDYlkxMx0jo9+5
         R+kstmDdPrTuTR0jw2DAfIg5ZCswa3WmEFZf8VoUFVjIrsG8q8PHcJH0gqsZ19btuCw/
         mByQ==
X-Gm-Message-State: AOJu0YzK5Xc/pvAuFBv/wnhf4yd4a0vdbxaMSG4R1Wg7zz4q//5vbIPD
	sGhzk/KPYYk0vRxaEn7p7iWIReqX6Ums08/So/stBRnu9zQtYeMTt0bZ
X-Gm-Gg: ASbGncsBY3imjh7s0qNlhFVnFYbt549wn7ZRg1AuwgEJCI9Afc7u3hbX2YmcoLazfgR
	crezLWEPzkFUC3NgCk4kYiKjXq+vYjqW09I0MGEzDy7Ob9x5NRnJcHB0RxU1g1wkQg56WZ/9M2O
	2kYvvLFFqKWCl6LeBw23SHjwQ0oQIB/Mz+4pQHBhVp9upnf8raR9rdjFpQO3+oLFbaoY7IoXrxV
	Pkmq+AUITUDuZ5IffcC1uwB+WfBrLh7Pqlm1XJjz1BiDw2z53YTbtgozSnG959amj2D2UX6HeGI
	46gfWpU=
X-Google-Smtp-Source: AGHT+IGfB0j8B30jno4/9489+2Ky3OB7yEVBxj0NNkwtfe1ygCCxVdKI6KpFLN8URNPsn1c0wk6oeg==
X-Received: by 2002:a05:6820:1b83:b0:5fc:a89b:a33c with SMTP id 006d021491bc7-5fe9d676f86mr1945491eaf.4.1740593163953;
        Wed, 26 Feb 2025 10:06:03 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fe9428c8b3sm755069eaf.39.2025.02.26.10.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:06:03 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 08/11] x86/percpu: Move top_of_stack to percpu hot section
Date: Wed, 26 Feb 2025 13:05:27 -0500
Message-ID: <20250226180531.1242429-9-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226180531.1242429-1-brgerst@gmail.com>
References: <20250226180531.1242429-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional change.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/entry/entry_32.S        | 4 ++--
 arch/x86/entry/entry_64.S        | 6 +++---
 arch/x86/entry/entry_64_compat.S | 4 ++--
 arch/x86/include/asm/current.h   | 1 -
 arch/x86/include/asm/percpu.h    | 2 +-
 arch/x86/include/asm/processor.h | 8 ++++++--
 arch/x86/kernel/asm-offsets.c    | 1 -
 arch/x86/kernel/cpu/common.c     | 3 ++-
 arch/x86/kernel/process_32.c     | 4 ++--
 arch/x86/kernel/process_64.c     | 2 +-
 arch/x86/kernel/smpboot.c        | 2 +-
 arch/x86/kernel/vmlinux.lds.S    | 1 +
 12 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 20be5758c2d2..92c0b4a94e0a 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1153,7 +1153,7 @@ SYM_CODE_START(asm_exc_nmi)
 	 * is using the thread stack right now, so it's safe for us to use it.
 	 */
 	movl	%esp, %ebx
-	movl	PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %esp
+	movl	PER_CPU_VAR(cpu_current_top_of_stack), %esp
 	call	exc_nmi
 	movl	%ebx, %esp
 
@@ -1217,7 +1217,7 @@ SYM_CODE_START(rewind_stack_and_make_dead)
 	/* Prevent any naive code from trying to unwind to our caller. */
 	xorl	%ebp, %ebp
 
-	movl	PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %esi
+	movl	PER_CPU_VAR(cpu_current_top_of_stack), %esi
 	leal	-TOP_OF_KERNEL_STACK_PADDING-PTREGS_SIZE(%esi), %esp
 
 	call	make_task_dead
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 33a955aa01d8..9baf32a7a118 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -92,7 +92,7 @@ SYM_CODE_START(entry_SYSCALL_64)
 	/* tss.sp2 is scratch space. */
 	movq	%rsp, PER_CPU_VAR(cpu_tss_rw + TSS_sp2)
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rsp
-	movq	PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %rsp
+	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 
 SYM_INNER_LABEL(entry_SYSCALL_64_safe_stack, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
@@ -1166,7 +1166,7 @@ SYM_CODE_START(asm_exc_nmi)
 	FENCE_SWAPGS_USER_ENTRY
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdx
 	movq	%rsp, %rdx
-	movq	PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %rsp
+	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 	UNWIND_HINT_IRET_REGS base=%rdx offset=8
 	pushq	5*8(%rdx)	/* pt_regs->ss */
 	pushq	4*8(%rdx)	/* pt_regs->rsp */
@@ -1484,7 +1484,7 @@ SYM_CODE_START_NOALIGN(rewind_stack_and_make_dead)
 	/* Prevent any naive code from trying to unwind to our caller. */
 	xorl	%ebp, %ebp
 
-	movq	PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %rax
+	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rax
 	leaq	-PTREGS_SIZE(%rax), %rsp
 	UNWIND_HINT_REGS
 
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index ed0a5f2dc129..a45e1125fc6c 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -57,7 +57,7 @@ SYM_CODE_START(entry_SYSENTER_compat)
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
 	popq	%rax
 
-	movq	PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %rsp
+	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 
 	/* Construct struct pt_regs on stack */
 	pushq	$__USER_DS		/* pt_regs->ss */
@@ -193,7 +193,7 @@ SYM_CODE_START(entry_SYSCALL_compat)
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rsp
 
 	/* Switch to the kernel stack */
-	movq	PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %rsp
+	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 
 SYM_INNER_LABEL(entry_SYSCALL_compat_safe_stack, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index 6fad5a4c21d7..3d1b123c2ee3 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -14,7 +14,6 @@ struct task_struct;
 
 struct pcpu_hot {
 	struct task_struct	*current_task;
-	unsigned long		top_of_stack;
 };
 
 DECLARE_PER_CPU_CACHE_HOT(struct pcpu_hot, pcpu_hot);
diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 7cb4f64b2e60..044410462d36 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -554,7 +554,7 @@ do {									\
  * it is accessed while this_cpu_read_stable() allows the value to be cached.
  * this_cpu_read_stable() is more efficient and can be used if its value
  * is guaranteed to be valid across CPUs.  The current users include
- * pcpu_hot.current_task and pcpu_hot.top_of_stack, both of which are
+ * pcpu_hot.current_task and cpu_current_top_of_stack, both of which are
  * actually per-thread variables implemented as per-CPU variables and
  * thus stable for the duration of the respective task.
  */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 54fce8d7504d..b4d51de071f2 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -427,6 +427,10 @@ DECLARE_PER_CPU_CACHE_HOT(bool, hardirq_stack_inuse);
 DECLARE_PER_CPU_CACHE_HOT(struct irq_stack *, softirq_stack_ptr);
 #endif
 
+DECLARE_PER_CPU_CACHE_HOT(unsigned long, cpu_current_top_of_stack);
+/* const-qualified alias provided by the linker. */
+DECLARE_PER_CPU_CACHE_HOT(const unsigned long __percpu_seg_override, const_cpu_current_top_of_stack);
+
 #ifdef CONFIG_X86_64
 static inline unsigned long cpu_kernelmode_gs_base(int cpu)
 {
@@ -552,9 +556,9 @@ static __always_inline unsigned long current_top_of_stack(void)
 	 *  entry trampoline.
 	 */
 	if (IS_ENABLED(CONFIG_USE_X86_SEG_SUPPORT))
-		return this_cpu_read_const(const_pcpu_hot.top_of_stack);
+		return this_cpu_read_const(const_cpu_current_top_of_stack);
 
-	return this_cpu_read_stable(pcpu_hot.top_of_stack);
+	return this_cpu_read_stable(cpu_current_top_of_stack);
 }
 
 static __always_inline bool on_thread_stack(void)
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 6fae88f8ae1e..54ace808defd 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -107,7 +107,6 @@ static void __used common(void)
 	OFFSET(TSS_sp0, tss_struct, x86_tss.sp0);
 	OFFSET(TSS_sp1, tss_struct, x86_tss.sp1);
 	OFFSET(TSS_sp2, tss_struct, x86_tss.sp2);
-	OFFSET(X86_top_of_stack, pcpu_hot, top_of_stack);
 	OFFSET(X86_current_task, pcpu_hot, current_task);
 #if IS_ENABLED(CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64)
 	/* Offset for fields in aria_ctx */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 01f33fb86f05..fc059e9c8867 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2016,7 +2016,6 @@ __setup("clearcpuid=", setup_clearcpuid);
 
 DEFINE_PER_CPU_CACHE_HOT(struct pcpu_hot, pcpu_hot) = {
 	.current_task	= &init_task,
-	.top_of_stack	= TOP_OF_INIT_STACK,
 };
 EXPORT_PER_CPU_SYMBOL(pcpu_hot);
 EXPORT_PER_CPU_SYMBOL(const_pcpu_hot);
@@ -2024,6 +2023,8 @@ EXPORT_PER_CPU_SYMBOL(const_pcpu_hot);
 DEFINE_PER_CPU_CACHE_HOT(int, __preempt_count) = INIT_PREEMPT_COUNT;
 EXPORT_PER_CPU_SYMBOL(__preempt_count);
 
+DEFINE_PER_CPU_CACHE_HOT(unsigned long, cpu_current_top_of_stack) = TOP_OF_INIT_STACK;
+
 #ifdef CONFIG_X86_64
 /*
  * Note: Do not make this dependant on CONFIG_MITIGATION_CALL_DEPTH_TRACKING
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 0917c7f25720..3afb2428bedb 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -190,13 +190,13 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	arch_end_context_switch(next_p);
 
 	/*
-	 * Reload esp0 and pcpu_hot.top_of_stack.  This changes
+	 * Reload esp0 and cpu_current_top_of_stack.  This changes
 	 * current_thread_info().  Refresh the SYSENTER configuration in
 	 * case prev or next is vm86.
 	 */
 	update_task_stack(next_p);
 	refresh_sysenter_cs(next);
-	this_cpu_write(pcpu_hot.top_of_stack,
+	this_cpu_write(cpu_current_top_of_stack,
 		       (unsigned long)task_stack_page(next_p) +
 		       THREAD_SIZE);
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 93de583c05d1..f68da7b7e50c 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -669,7 +669,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	 * Switch the PDA and FPU contexts.
 	 */
 	raw_cpu_write(pcpu_hot.current_task, next_p);
-	raw_cpu_write(pcpu_hot.top_of_stack, task_top_of_stack(next_p));
+	raw_cpu_write(cpu_current_top_of_stack, task_top_of_stack(next_p));
 
 	switch_fpu_finish(next_p);
 
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index c10850ae6f09..15e054f4cbf6 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -851,7 +851,7 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
 
 #ifdef CONFIG_X86_32
 	/* Stack for startup_32 can be just as for start_secondary onwards */
-	per_cpu(pcpu_hot.top_of_stack, cpu) = task_top_of_stack(idle);
+	per_cpu(cpu_current_top_of_stack, cpu) = task_top_of_stack(idle);
 #endif
 	return 0;
 }
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 7586a9be8c59..85032c085af2 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -44,6 +44,7 @@ ENTRY(phys_startup_64)
 
 jiffies = jiffies_64;
 const_pcpu_hot = pcpu_hot;
+const_cpu_current_top_of_stack = cpu_current_top_of_stack;
 
 #if defined(CONFIG_X86_64)
 /*
-- 
2.48.1


