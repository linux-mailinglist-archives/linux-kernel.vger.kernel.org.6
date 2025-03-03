Return-Path: <linux-kernel+bounces-542378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DC9A4C911
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03DE0174494
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC4125F99A;
	Mon,  3 Mar 2025 16:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpZ5PfmD"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060E125F961
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020807; cv=none; b=ktoPVWc/1RBiRCvLm2u5qVdQPg+dS6WEryWHuQie1GEMY9Jo2a/xjYxneltsTGjB3vrCPWfdBXFAzJt/l5EjRNFz3chipj3Mpx6y5JiG8skFdgM5hhQe559/DUe8FiKwIam+5A5vJ69fENuxgitPeSrT71po+DTRzXDX3kaSBV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020807; c=relaxed/simple;
	bh=A+l+hoR2IeyWEqsJeLmBzlIukxl12Att0NLJaH3RYwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iAQFKmGbwlN06DXPlBtjmcaBUoolHh9OrbJ9McxW8NS+fWJZfYS4bEUtDgg73DMHsc5oMIyOmkFaM+7TpTMsxDw2oxnQYK82JBrALgYEFT+rnqyi83xUAFg6gn9kBBE6xy/l7e4sZAvJJ72WIshD69CXzqxJilPdno1Fpyr2vwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpZ5PfmD; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e8992f9a45so33356716d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741020804; x=1741625604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c37x08hTKlDAT1EL3+ji6o6B0AZmhiaBFIwDXnwiew8=;
        b=VpZ5PfmDCwktN8nTAJ4WBMUu8EOPblP8uOHIHYLiTcXVqMu48K8mo+StbR5AZemFyi
         bjf80Ko0VRWuI/N+Y4HwJEgyGH1oeKJRSvtdGx9GfL7l0k+QHQlDQanbbDebSdydUuI9
         6NPmX3f1CHgT/7n9Dr1X/g0to1FRu5aBS07dwcfsM84AonC1ekKDBICW8HsaY9z+twg/
         D7a25vPKeHE80h/jd4sONy6HJlIBp80vUpVtrQ5cIGzbCXJLEko41Ef7OESp3tOAfzNe
         PTTcb3btj84dGrGMS9bT7qNwaOFH0yrFq0UHhZHvMEgNbQBFImAX1mYOMFor/RpItyPL
         CjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741020804; x=1741625604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c37x08hTKlDAT1EL3+ji6o6B0AZmhiaBFIwDXnwiew8=;
        b=O1NMY76yfXr+CV6Jf8XodtbFaDhoT3LKoM0ckpKq5KXpuJF2whe69Gvte3+kr8UH+Z
         9DnTK6QcUBoy7ZITctukGj9sihYiVjCQNqaur9m6+FXhCgNpOmvYB8XwuUy6lqfNJybw
         1MgZeBKMFRDtpQgMldzsZCXsrpr8O4f2UfbZHxqrey66q1N54stVJYqcEqACy+ztJz4l
         LcHF1eeenTWjf9SP5k7Q2UyGOVc5dzWsOTaWc0P1YoSwCeC9UWmNOyN4cd24gtVB8kys
         8rLXs/1Ekrca8okcDTgGxbdJMHhKSQJ5D6YnLZ7BzkrqRF/R2Jt5ob1WVblQKG7j3MIY
         Yy4Q==
X-Gm-Message-State: AOJu0YwE3tc1qyiXCZKuV48tj9pAIm2KybzwUMcs/gyJ0CqAVxV2gqDd
	6VENcg92qaQUqGOKI+cl1eE/Qh3e4Br5dXJl1Wx4VNK5vpIDd+QWptbn
X-Gm-Gg: ASbGncu5WhLYCN5sNOarN3KdcaMnQ+eo48BtEqBvCMLCKXK7nN+7f63O5ZFa6NrbZSC
	qkN9y2yN0HiGGHTz8cS18dtxgBJNLx2x9QjF8ILCx6yJnXmRqJaygiM/7Kl/CqqxbMtSG4+Vz+G
	THgHZBY6vW7evyGTegC6T+Sbj8Jhk0XCC2zNorcP3TFFg199kBrjWjEGBRmoL2nphZgY5HD/jrC
	oUwAdBhfnx8rfc485f+VZhkQFSHIt/P8q2Vot8xZ8xW2INoq7fP4vmEz8srAGvb01PKD6K53W3I
	mHgNPPSSxoR4fmvgzmn8+g+pyg==
X-Google-Smtp-Source: AGHT+IGWWZHHlQUDQC1c/ndgMPf9SnnXcmPX3NGUhVz3YvH6Kj4AmYuCSsKlALqHvpO6trM2SXv5yg==
X-Received: by 2002:a05:6214:2462:b0:6e6:5aa2:4e4a with SMTP id 6a1803df08f44-6e8a0d700e5mr221809956d6.28.1741020804077;
        Mon, 03 Mar 2025 08:53:24 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976cc9cdsm54730936d6.88.2025.03.03.08.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:53:22 -0800 (PST)
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
Subject: [PATCH v3 07/11] x86/irq: Move irq stacks to percpu hot section
Date: Mon,  3 Mar 2025 11:52:42 -0500
Message-ID: <20250303165246.2175811-8-brgerst@gmail.com>
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
 arch/x86/include/asm/current.h   |  6 ------
 arch/x86/include/asm/irq_stack.h | 12 ++++++------
 arch/x86/include/asm/processor.h |  7 +++++++
 arch/x86/kernel/dumpstack_32.c   |  4 ++--
 arch/x86/kernel/dumpstack_64.c   |  2 +-
 arch/x86/kernel/irq.c            |  2 ++
 arch/x86/kernel/irq_32.c         | 12 +++++++-----
 arch/x86/kernel/irq_64.c         |  7 ++++---
 arch/x86/kernel/process_64.c     |  2 +-
 9 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index f153c77853de..6fad5a4c21d7 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -15,12 +15,6 @@ struct task_struct;
 struct pcpu_hot {
 	struct task_struct	*current_task;
 	unsigned long		top_of_stack;
-	void			*hardirq_stack_ptr;
-#ifdef CONFIG_X86_64
-	bool			hardirq_stack_inuse;
-#else
-	void			*softirq_stack_ptr;
-#endif
 };
 
 DECLARE_PER_CPU_CACHE_HOT(struct pcpu_hot, pcpu_hot);
diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stack.h
index 8e56a07aef70..3ce0314eaf7c 100644
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -117,7 +117,7 @@
 	ASM_CALL_ARG2
 
 #define call_on_irqstack(func, asm_call, argconstr...)			\
-	call_on_stack(__this_cpu_read(pcpu_hot.hardirq_stack_ptr),	\
+	call_on_stack(__this_cpu_read(hardirq_stack_ptr),		\
 		      func, asm_call, argconstr)
 
 /* Macros to assert type correctness for run_*_on_irqstack macros */
@@ -136,7 +136,7 @@
 	 * User mode entry and interrupt on the irq stack do not	\
 	 * switch stacks. If from user mode the task stack is empty.	\
 	 */								\
-	if (user_mode(regs) || __this_cpu_read(pcpu_hot.hardirq_stack_inuse)) { \
+	if (user_mode(regs) || __this_cpu_read(hardirq_stack_inuse)) {	\
 		irq_enter_rcu();					\
 		func(c_args);						\
 		irq_exit_rcu();						\
@@ -147,9 +147,9 @@
 		 * places. Invoke the stack switch macro with the call	\
 		 * sequence which matches the above direct invocation.	\
 		 */							\
-		__this_cpu_write(pcpu_hot.hardirq_stack_inuse, true);	\
+		__this_cpu_write(hardirq_stack_inuse, true);		\
 		call_on_irqstack(func, asm_call, constr);		\
-		__this_cpu_write(pcpu_hot.hardirq_stack_inuse, false);	\
+		__this_cpu_write(hardirq_stack_inuse, false);		\
 	}								\
 }
 
@@ -213,9 +213,9 @@
  */
 #define do_softirq_own_stack()						\
 {									\
-	__this_cpu_write(pcpu_hot.hardirq_stack_inuse, true);		\
+	__this_cpu_write(hardirq_stack_inuse, true);			\
 	call_on_irqstack(__do_softirq, ASM_CALL_ARG0);			\
-	__this_cpu_write(pcpu_hot.hardirq_stack_inuse, false);		\
+	__this_cpu_write(hardirq_stack_inuse, false);			\
 }
 
 #endif
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index a969bea1ed07..9203cecb7695 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -420,6 +420,13 @@ struct irq_stack {
 	char		stack[IRQ_STACK_SIZE];
 } __aligned(IRQ_STACK_SIZE);
 
+DECLARE_PER_CPU_CACHE_HOT(struct irq_stack *, hardirq_stack_ptr);
+#ifdef CONFIG_X86_64
+DECLARE_PER_CPU_CACHE_HOT(bool, hardirq_stack_inuse);
+#else
+DECLARE_PER_CPU_CACHE_HOT(struct irq_stack *, softirq_stack_ptr);
+#endif
+
 #ifdef CONFIG_X86_64
 static inline unsigned long cpu_kernelmode_gs_base(int cpu)
 {
diff --git a/arch/x86/kernel/dumpstack_32.c b/arch/x86/kernel/dumpstack_32.c
index b4905d5173fd..722fd712e1cf 100644
--- a/arch/x86/kernel/dumpstack_32.c
+++ b/arch/x86/kernel/dumpstack_32.c
@@ -37,7 +37,7 @@ const char *stack_type_name(enum stack_type type)
 
 static bool in_hardirq_stack(unsigned long *stack, struct stack_info *info)
 {
-	unsigned long *begin = (unsigned long *)this_cpu_read(pcpu_hot.hardirq_stack_ptr);
+	unsigned long *begin = (unsigned long *)this_cpu_read(hardirq_stack_ptr);
 	unsigned long *end   = begin + (THREAD_SIZE / sizeof(long));
 
 	/*
@@ -62,7 +62,7 @@ static bool in_hardirq_stack(unsigned long *stack, struct stack_info *info)
 
 static bool in_softirq_stack(unsigned long *stack, struct stack_info *info)
 {
-	unsigned long *begin = (unsigned long *)this_cpu_read(pcpu_hot.softirq_stack_ptr);
+	unsigned long *begin = (unsigned long *)this_cpu_read(softirq_stack_ptr);
 	unsigned long *end   = begin + (THREAD_SIZE / sizeof(long));
 
 	/*
diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index f05339fee778..6c5defd6569a 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -134,7 +134,7 @@ static __always_inline bool in_exception_stack(unsigned long *stack, struct stac
 
 static __always_inline bool in_irq_stack(unsigned long *stack, struct stack_info *info)
 {
-	unsigned long *end = (unsigned long *)this_cpu_read(pcpu_hot.hardirq_stack_ptr);
+	unsigned long *end = (unsigned long *)this_cpu_read(hardirq_stack_ptr);
 	unsigned long *begin;
 
 	/*
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 83a5252a473c..81f9b78e0f7b 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -36,6 +36,8 @@ EXPORT_PER_CPU_SYMBOL(irq_stat);
 DEFINE_PER_CPU_CACHE_HOT(u16, __softirq_pending);
 EXPORT_PER_CPU_SYMBOL(__softirq_pending);
 
+DEFINE_PER_CPU_CACHE_HOT(struct irq_stack *, hardirq_stack_ptr);
+
 atomic_t irq_err_count;
 
 /*
diff --git a/arch/x86/kernel/irq_32.c b/arch/x86/kernel/irq_32.c
index dc1049c01f9b..48a27cde9635 100644
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -52,6 +52,8 @@ static inline int check_stack_overflow(void) { return 0; }
 static inline void print_stack_overflow(void) { }
 #endif
 
+DEFINE_PER_CPU_CACHE_HOT(struct irq_stack *, softirq_stack_ptr);
+
 static void call_on_stack(void *func, void *stack)
 {
 	asm volatile("xchgl	%%ebx,%%esp	\n"
@@ -74,7 +76,7 @@ static inline int execute_on_irq_stack(int overflow, struct irq_desc *desc)
 	u32 *isp, *prev_esp, arg1;
 
 	curstk = (struct irq_stack *) current_stack();
-	irqstk = __this_cpu_read(pcpu_hot.hardirq_stack_ptr);
+	irqstk = __this_cpu_read(hardirq_stack_ptr);
 
 	/*
 	 * this is where we switch to the IRQ stack. However, if we are
@@ -112,7 +114,7 @@ int irq_init_percpu_irqstack(unsigned int cpu)
 	int node = cpu_to_node(cpu);
 	struct page *ph, *ps;
 
-	if (per_cpu(pcpu_hot.hardirq_stack_ptr, cpu))
+	if (per_cpu(hardirq_stack_ptr, cpu))
 		return 0;
 
 	ph = alloc_pages_node(node, THREADINFO_GFP, THREAD_SIZE_ORDER);
@@ -124,8 +126,8 @@ int irq_init_percpu_irqstack(unsigned int cpu)
 		return -ENOMEM;
 	}
 
-	per_cpu(pcpu_hot.hardirq_stack_ptr, cpu) = page_address(ph);
-	per_cpu(pcpu_hot.softirq_stack_ptr, cpu) = page_address(ps);
+	per_cpu(hardirq_stack_ptr, cpu) = page_address(ph);
+	per_cpu(softirq_stack_ptr, cpu) = page_address(ps);
 	return 0;
 }
 
@@ -135,7 +137,7 @@ void do_softirq_own_stack(void)
 	struct irq_stack *irqstk;
 	u32 *isp, *prev_esp;
 
-	irqstk = __this_cpu_read(pcpu_hot.softirq_stack_ptr);
+	irqstk = __this_cpu_read(softirq_stack_ptr);
 
 	/* build the stack frame on the softirq stack */
 	isp = (u32 *) ((char *)irqstk + sizeof(*irqstk));
diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
index 56bdeecd8ee0..ca78dce39361 100644
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -26,6 +26,7 @@
 #include <asm/io_apic.h>
 #include <asm/apic.h>
 
+DEFINE_PER_CPU_CACHE_HOT(bool, hardirq_stack_inuse);
 DEFINE_PER_CPU_PAGE_ALIGNED(struct irq_stack, irq_stack_backing_store) __visible;
 
 #ifdef CONFIG_VMAP_STACK
@@ -50,7 +51,7 @@ static int map_irq_stack(unsigned int cpu)
 		return -ENOMEM;
 
 	/* Store actual TOS to avoid adjustment in the hotpath */
-	per_cpu(pcpu_hot.hardirq_stack_ptr, cpu) = va + IRQ_STACK_SIZE - 8;
+	per_cpu(hardirq_stack_ptr, cpu) = va + IRQ_STACK_SIZE - 8;
 	return 0;
 }
 #else
@@ -63,14 +64,14 @@ static int map_irq_stack(unsigned int cpu)
 	void *va = per_cpu_ptr(&irq_stack_backing_store, cpu);
 
 	/* Store actual TOS to avoid adjustment in the hotpath */
-	per_cpu(pcpu_hot.hardirq_stack_ptr, cpu) = va + IRQ_STACK_SIZE - 8;
+	per_cpu(hardirq_stack_ptr, cpu) = va + IRQ_STACK_SIZE - 8;
 	return 0;
 }
 #endif
 
 int irq_init_percpu_irqstack(unsigned int cpu)
 {
-	if (per_cpu(pcpu_hot.hardirq_stack_ptr, cpu))
+	if (per_cpu(hardirq_stack_ptr, cpu))
 		return 0;
 	return map_irq_stack(cpu);
 }
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 4ca73ddfb30b..3a8f967a0c79 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -614,7 +614,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	int cpu = smp_processor_id();
 
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ENTRY) &&
-		     this_cpu_read(pcpu_hot.hardirq_stack_inuse));
+		     this_cpu_read(hardirq_stack_inuse));
 
 	if (!test_tsk_thread_flag(prev_p, TIF_NEED_FPU_LOAD))
 		switch_fpu_prepare(prev_p, cpu);
-- 
2.48.1


