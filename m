Return-Path: <linux-kernel+bounces-542379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 737A5A4C952
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 315793B86C7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AADE25FA0D;
	Mon,  3 Mar 2025 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9Quz0Br"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C172C25F989
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020809; cv=none; b=CqfaUyGjaaSkT32GP00Rm74FVf/BWD/Vv0c6vBDxkIEuFlUWZPAFPNAbSQLxrtW0Fc8WsIEeKBYDKVJX7qsMc9FRTM4xInLvEuYaNC1xHC2tpGwXKCttILGc3dUMqbNHCUYNPI2c5A4RvgpfSXEyBJoeZbAGxLknfRl2X/y6bVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020809; c=relaxed/simple;
	bh=Qa9rbS11nQ3ULYiX0zFMnX0VY4BRsXfO39BzwlEKLp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4RtbNLZ38WXH3pVDqB/I++LwdIFzAWi4FpTERV6azJB/Nj1PmITp+pXJ2CdNlCRqsiu8I5lg7MOx4y6S1lKlvbLALhTU56K+i0AI8sfj4IGi6jYB623v0/v2QVJmb7TPOgJ7zBLTDXy3IZ1U8ezScP94oTD9BBWZiRrEAfXnZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9Quz0Br; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c3cb761402so17347285a.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741020806; x=1741625606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+Ges8AFZBJaJk/QGwDEBI1qSGnch2qFY9doOlyO4a4=;
        b=A9Quz0BrJQthf8wpH11n4SyffavneGyEsFIeRGns7JbyrmuQq0LkRMjqqzHODJ3S32
         hS7r6kQKbSOAj+w0C1vQGeE/0ZMXUZezV/2iOod5frbUkm9BAquyileU5sY/1ccxdxMC
         9S2A0j3Ip7dZxiNmn1WMU0MIaQcXat59jX86xruUEHCUELyINEx108I+enRC276ECKBG
         qzNfPeTAY0rPp78yDFW1NkOevZroCLbkX8baIb6PVMH49zKW+EFBDCoRZJ4ipLuzleR+
         bcdWPMe2df6oUXjK4gLWkRpjRHtDsfCTkf/KVVIHXEg0xLDfesHzySRVZKPEz3qSG9Js
         xMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741020806; x=1741625606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O+Ges8AFZBJaJk/QGwDEBI1qSGnch2qFY9doOlyO4a4=;
        b=WgKPNWsk8e4epn17KMPizc8vhoshIu/I23H8RtwiY5dLnLD8bAhCWAdp8hDcN5V+17
         XSiDxeyrsU01WCxd5f7yaEWZPHY6yEbWm6S2Oz5T98uVEnba04UqjuWuIYkvpfbtcaZu
         FLl6Zvg0qmM/EeURfcg9o1hWsv6jT77iL8/NIsPX5WY85Zab8A/JmW4AVFnv4cdlVbO5
         MuMm9jCmCzpZBbx7pWRLEdKkJQhpTWFY6eB+UsEUwPGghqq5A5lawefy1asFGOOFRp0k
         LQCOWgaQy6RKCuhl6CdY94NNieu+s6bFhEREn9HxOJin+e9tv8N8vTjcYt9vDBE3eSC6
         fUPA==
X-Gm-Message-State: AOJu0YyX1VHump/duz18zzyWPUcw6boUU6BnYEHDnNNOSZXOG0k2u7jk
	q7dKKVhBPzi7BOpj20IPICmxA0cJPIjvyspgUOUMIT7UKCISNBuQWIiz
X-Gm-Gg: ASbGnct2wy3ljzSDKvVdFEkwuP9KHlSTTDMC8PxEMAT+yQ7bv+bYaMFTcCQgv/P1ZsZ
	Rel5sshhXRTemF9cPSHmg21n6yxvQsYvcTD30891SSiYmEhP0IfBZ7bTqCnpNIo97H41+90Hgsb
	Ylw7MQ8CJdv4qbRt/horYy5zDAz7ZcE4mLVFCRPAuwDmo2o7nyjsTjJVchfQB0hUbAIvOYZiDp1
	Taw8r+kMXSRXWITFRBdPDCQSe6W3RZGewVtkDqkZrY6s3mhnBvvhtBD/pqGB5C+1e/S+uDakGpi
	4/HU0vuLtiO2vYnKKYaNvJ50+g==
X-Google-Smtp-Source: AGHT+IEQGJjHx0IRKzF1BO7sDCFo5HAad462T1g3FuN+Ywu+ucmRpETBqLWaZGTjzKtlTSSNe8eOPQ==
X-Received: by 2002:a05:620a:462c:b0:7c0:abe0:ce40 with SMTP id af79cd13be357-7c39c4992a1mr2060863985a.5.1741020805992;
        Mon, 03 Mar 2025 08:53:25 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976cc9cdsm54730936d6.88.2025.03.03.08.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:53:24 -0800 (PST)
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
Subject: [PATCH v3 08/11] x86/percpu: Move top_of_stack to percpu hot section
Date: Mon,  3 Mar 2025 11:52:43 -0500
Message-ID: <20250303165246.2175811-9-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303165246.2175811-1-brgerst@gmail.com>
References: <20250303165246.2175811-1-brgerst@gmail.com>
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
 arch/x86/include/asm/processor.h | 9 +++++++--
 arch/x86/kernel/asm-offsets.c    | 1 -
 arch/x86/kernel/cpu/common.c     | 3 ++-
 arch/x86/kernel/process_32.c     | 4 ++--
 arch/x86/kernel/process_64.c     | 2 +-
 arch/x86/kernel/smpboot.c        | 2 +-
 arch/x86/kernel/vmlinux.lds.S    | 1 +
 12 files changed, 22 insertions(+), 17 deletions(-)

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
index 49d3b222fe99..f40bdf97d390 100644
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
@@ -1168,7 +1168,7 @@ SYM_CODE_START(asm_exc_nmi)
 	FENCE_SWAPGS_USER_ENTRY
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdx
 	movq	%rsp, %rdx
-	movq	PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %rsp
+	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 	UNWIND_HINT_IRET_REGS base=%rdx offset=8
 	pushq	5*8(%rdx)	/* pt_regs->ss */
 	pushq	4*8(%rdx)	/* pt_regs->rsp */
@@ -1486,7 +1486,7 @@ SYM_CODE_START_NOALIGN(rewind_stack_and_make_dead)
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
index 60390a019ca9..1ca290ba6f77 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -549,7 +549,7 @@ do {									\
  * it is accessed while this_cpu_read_stable() allows the value to be cached.
  * this_cpu_read_stable() is more efficient and can be used if its value
  * is guaranteed to be valid across CPUs.  The current users include
- * pcpu_hot.current_task and pcpu_hot.top_of_stack, both of which are
+ * pcpu_hot.current_task and cpu_current_top_of_stack, both of which are
  * actually per-thread variables implemented as per-CPU variables and
  * thus stable for the duration of the respective task.
  */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 9203cecb7695..60f1c803b6c1 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -427,6 +427,11 @@ DECLARE_PER_CPU_CACHE_HOT(bool, hardirq_stack_inuse);
 DECLARE_PER_CPU_CACHE_HOT(struct irq_stack *, softirq_stack_ptr);
 #endif
 
+DECLARE_PER_CPU_CACHE_HOT(unsigned long, cpu_current_top_of_stack);
+/* const-qualified alias provided by the linker. */
+DECLARE_PER_CPU_CACHE_HOT(const unsigned long __percpu_seg_override,
+			  const_cpu_current_top_of_stack);
+
 #ifdef CONFIG_X86_64
 static inline unsigned long cpu_kernelmode_gs_base(int cpu)
 {
@@ -552,9 +557,9 @@ static __always_inline unsigned long current_top_of_stack(void)
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
index f051fc90b44b..a771aa77f05e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2051,7 +2051,6 @@ __setup("setcpuid=", setup_setcpuid);
 
 DEFINE_PER_CPU_CACHE_HOT(struct pcpu_hot, pcpu_hot) = {
 	.current_task	= &init_task,
-	.top_of_stack	= TOP_OF_INIT_STACK,
 };
 EXPORT_PER_CPU_SYMBOL(pcpu_hot);
 EXPORT_PER_CPU_SYMBOL(const_pcpu_hot);
@@ -2059,6 +2058,8 @@ EXPORT_PER_CPU_SYMBOL(const_pcpu_hot);
 DEFINE_PER_CPU_CACHE_HOT(int, __preempt_count) = INIT_PREEMPT_COUNT;
 EXPORT_PER_CPU_SYMBOL(__preempt_count);
 
+DEFINE_PER_CPU_CACHE_HOT(unsigned long, cpu_current_top_of_stack) = TOP_OF_INIT_STACK;
+
 #ifdef CONFIG_X86_64
 /*
  * Note: Do not make this dependant on CONFIG_MITIGATION_CALL_DEPTH_TRACKING
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 2bdab416298c..8ec44acb863b 100644
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
index 3a8f967a0c79..04da741dffd2 100644
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
index 582016967587..83ec0e90c98e 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -852,7 +852,7 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
 
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


