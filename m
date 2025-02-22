Return-Path: <linux-kernel+bounces-527431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5D2A40B21
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 20:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E98987036FE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 19:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28122212B10;
	Sat, 22 Feb 2025 19:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vwb+ABQm"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7692144B4
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 19:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740251216; cv=none; b=bJyG+RA0pWvU4oy4C1Q3I4L4WGLsspnK1gc1t+EgzTBEkwG0ou8l2SrJJTpTTNgQG1isS1dYLoVjsE1dXLX9qrasLf8+WdBtu7A/QQlpPTUCc6Seel4NXSvioX3MB/aOKYgtqA97BkfBBCOMfg8+E9taWeKJigz3+U0PtORmdZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740251216; c=relaxed/simple;
	bh=rqn9vf/rFqcaqJHERZsjgjCV7XrUGnFtJMkvM0Gtn2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYVtONsEMjHXIQCFsaQ0Jrf26Tubik63YEOglKwvkD66DxZbqIoITMi3g6XMel/jOhz4yTe2W6H+OnKdDIllyczGNRAt9fcrSg25f8OibnDAnZewJ64xuUtc4g66r5kSQMERZUYI5o6XDcSW9bM0/cxLGTvIFYQGBcaVc714g/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vwb+ABQm; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6dd420f82e2so45510436d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 11:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740251213; x=1740856013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eM0qCn4hMa/3nh37POynWdLdE6cWMXbQzyt+go2OAM0=;
        b=Vwb+ABQmbvUO5mTWZ8+E+7v1yPVu9FXvoKfIiDe1AFmZezF+chEAXqW7hFvJ4cjPq1
         yPoE2dPJlPJksVSUgxmwbDydiNdyOOw0zt1poKSsKrbOfkKz4pombq9XnnpS0N4aejaO
         HA04yrld2r5Y5w3YjVk+2wbNxIjgbsHqkWRWzlBY5DSgzg6jDKQl40KbtETac4lMqit9
         474kSTOVnsfMdyFwwvkdpp/dVGIgHfePZy3UG+YyHCoKPpdS+nZisZHEwYes8+5oZSmp
         NXbN2VJwVYLcRdjN7B/zBrd3Fi5iKvbtg+B+YOg+Ims964bEt/QBbb3gcsswIC19KOT2
         W7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740251213; x=1740856013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eM0qCn4hMa/3nh37POynWdLdE6cWMXbQzyt+go2OAM0=;
        b=UN3VGGqCWozrc3WfzFE+ue6H79igFujsgOCmIxGFmyRZz5dCK6EREXNaOeSVWbAahp
         u32B0hVg7FZAS98LA9oGfOqOF1KUYQtLEcCLFyxTBs619DuQ7aZQHOTEbM7/vlRwNTI8
         dqoeLSKFiBLzRKCAv1kkzltHa0oZCK6WWB+ccxFKebZ4cJ8WAZpmk8zgb3VJ38iiHvOe
         LYr51U3jMVik0H9xhPCwGC4w0OsUkAvrXC28QgWmyGP52wYU+hxEGa+gqpsuuGrNdRlP
         6MTZELKu744L5EHp1yQR/ORQ1pvJGITJ4eA6IhS+RsgL9eFOHwZfr53251rgZMvr20wL
         tJVg==
X-Gm-Message-State: AOJu0YysZfCunQrZAledCO7RLkGqrH92KbxfX1zZoJBc5ST28xRMrD1/
	fK9jCrSn39MyROpltQaW2zArMxMMIfTEh2n6viYw3BBBRyHSaRDKW+uF
X-Gm-Gg: ASbGncsdk4vDStvhu+tx68UykCzj1jxhqL6lIC1REBnl9SceO4PwAJKp13TQvHkiorN
	Df/9DLYA9LP2aoDzOgJq5dKJwfwv2ilaBmHqq8M8/1pszbLyz/sZ+rNc7Tcs+9vERqbrKaNsVdK
	DNaNnnrCWjZW1A7Ywy39qC/guad02kDSNIJzZ+TfgLfLGa+XTqyWUvaxgLGXzgdW5cBBlEB6JsW
	HNY/qQi9QTARvdcEgKQ7we/Zztam1E6Ujq79q4fTPtxfv1BE4coecU0XJ0IM8sFtxazydoaIyja
	C3i6lQA=
X-Google-Smtp-Source: AGHT+IHOSVZDtWbxUzpe4yZeHv9123lo75UA34aQk0Paqi7JHlohpEpMMUA00IZx1vaueRoksz/ZUA==
X-Received: by 2002:a05:6214:252c:b0:6e6:6a82:497e with SMTP id 6a1803df08f44-6e6ae7f5844mr103147806d6.10.1740251212993;
        Sat, 22 Feb 2025 11:06:52 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0b1ef73b8sm550185285a.65.2025.02.22.11.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 11:06:51 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Brian Gerst <brgerst@gmail.com>
Subject: [RFC PATCH 08/11] x86/irq: Move irq stacks to percpu hot section
Date: Sat, 22 Feb 2025 14:06:20 -0500
Message-ID: <20250222190623.262689-9-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250222190623.262689-1-brgerst@gmail.com>
References: <20250222190623.262689-1-brgerst@gmail.com>
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
 arch/x86/include/asm/current.h   | 10 ----------
 arch/x86/include/asm/irq_stack.h | 12 ++++++------
 arch/x86/include/asm/processor.h |  7 +++++++
 arch/x86/kernel/dumpstack_32.c   |  4 ++--
 arch/x86/kernel/dumpstack_64.c   |  2 +-
 arch/x86/kernel/irq.c            |  5 +++++
 arch/x86/kernel/irq_32.c         | 12 +++++++-----
 arch/x86/kernel/irq_64.c         |  6 +++---
 arch/x86/kernel/process_64.c     |  2 +-
 9 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index 6de46e2ae2b6..043888c258bd 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -13,17 +13,7 @@
 struct task_struct;
 
 struct pcpu_hot {
-	union {
-		struct {
-			void			*hardirq_stack_ptr;
-#ifdef CONFIG_X86_64
-			bool			hardirq_stack_inuse;
-#else
-			void			*softirq_stack_ptr;
-#endif
-		};
 		u8	pad[64];
-	};
 };
 static_assert(sizeof(struct pcpu_hot) == 64);
 
diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stack.h
index 562a547c29a5..735c3a491f60 100644
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -116,7 +116,7 @@
 	ASM_CALL_ARG2
 
 #define call_on_irqstack(func, asm_call, argconstr...)			\
-	call_on_stack(__this_cpu_read(pcpu_hot.hardirq_stack_ptr),	\
+	call_on_stack(__this_cpu_read(hardirq_stack_ptr),		\
 		      func, asm_call, argconstr)
 
 /* Macros to assert type correctness for run_*_on_irqstack macros */
@@ -135,7 +135,7 @@
 	 * User mode entry and interrupt on the irq stack do not	\
 	 * switch stacks. If from user mode the task stack is empty.	\
 	 */								\
-	if (user_mode(regs) || __this_cpu_read(pcpu_hot.hardirq_stack_inuse)) { \
+	if (user_mode(regs) || __this_cpu_read(hardirq_stack_inuse)) {	\
 		irq_enter_rcu();					\
 		func(c_args);						\
 		irq_exit_rcu();						\
@@ -146,9 +146,9 @@
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
 
@@ -212,9 +212,9 @@
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
index 1505cb1d09a8..9dde4ffed917 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -420,6 +420,13 @@ struct irq_stack {
 	char		stack[IRQ_STACK_SIZE];
 } __aligned(IRQ_STACK_SIZE);
 
+DECLARE_PER_CPU_HOT(struct irq_stack *, hardirq_stack_ptr);
+#ifdef CONFIG_X86_64
+DECLARE_PER_CPU_HOT(bool, hardirq_stack_inuse);
+#else
+DECLARE_PER_CPU_HOT(struct irq_stack *, softirq_stack_ptr);
+#endif
+
 DECLARE_PER_CPU_HOT(unsigned long, cpu_current_top_of_stack);
 /* const-qualified alias provided by the linker. */
 DECLARE_PER_CPU_HOT(const unsigned long, const_cpu_current_top_of_stack);
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
index 1b51d5c05583..262e477b4651 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -34,6 +34,11 @@ EXPORT_PER_CPU_SYMBOL(irq_stat);
 DEFINE_PER_CPU_HOT(u16, softirq_pending);
 EXPORT_PER_CPU_SYMBOL(softirq_pending);
 
+DEFINE_PER_CPU_HOT(struct irq_stack *, hardirq_stack_ptr);
+#ifdef CONFIG_X86_64
+DEFINE_PER_CPU_HOT(bool, hardirq_stack_inuse);
+#endif
+
 atomic_t irq_err_count;
 
 /*
diff --git a/arch/x86/kernel/irq_32.c b/arch/x86/kernel/irq_32.c
index dc1049c01f9b..dd7d9ba87bd0 100644
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -52,6 +52,8 @@ static inline int check_stack_overflow(void) { return 0; }
 static inline void print_stack_overflow(void) { }
 #endif
 
+DEFINE_PER_CPU_HOT(struct irq_stack *, softirq_stack_ptr);
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
index 56bdeecd8ee0..4834e317e568 100644
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -50,7 +50,7 @@ static int map_irq_stack(unsigned int cpu)
 		return -ENOMEM;
 
 	/* Store actual TOS to avoid adjustment in the hotpath */
-	per_cpu(pcpu_hot.hardirq_stack_ptr, cpu) = va + IRQ_STACK_SIZE - 8;
+	per_cpu(hardirq_stack_ptr, cpu) = va + IRQ_STACK_SIZE - 8;
 	return 0;
 }
 #else
@@ -63,14 +63,14 @@ static int map_irq_stack(unsigned int cpu)
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
index 1517314da34a..13893ec03d85 100644
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


