Return-Path: <linux-kernel+bounces-534595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F5FA468E8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9920173A80
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE14223373B;
	Wed, 26 Feb 2025 18:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNU/ELfL"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FB1233156
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593165; cv=none; b=oxpXxPbLCL+3lLyTusWzr7y0HVwpcKNcRow5w+G/jGPNauUxjymt/Yvw9fIuIAVAiDfDyvXLH926piq17IuyRY1MNT0NKZ0RlfoNMvrhyk6WpNuDIbnTWJ75bClM3INnGvMU1j55xJ+4kVj5ktOeSUzNRjcyFkQT/SOijMlBpw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593165; c=relaxed/simple;
	bh=sa1XYqYkQjBHHrGwa2+ng3XNpCyhBC9elduphKiYq+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vC0MyLvOnuKz6oJ16eV/HnFWJXaPGPZvr3lZEH6sRHYiO5YjgqPeknd88eNqvqmcSqj9MHHctZawkgDPjA3ovo7WJAMcI9/hCnDue5abQBLPCzXCPVhwgrKmcYMpkJCOKUVCFzZ8/om9M0o9xEXLN1IkwsWn0tDyJfLzIg9ErxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNU/ELfL; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3f41091f7c5so66861b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740593161; x=1741197961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xVVRQ21On+BgakJYPRhPKh5ZN4qUIiROQsAFkbaQCk=;
        b=QNU/ELfLjIUJRb7dq8mrfVqtTEwb5rrliawq6fcWmr6Sk0LpLq/qdpyyxP9vUe6ljp
         M3LMAKhcb4+aS9lvZmuV1KA2weZ58l7CotL2vrWHTzJe6/AwRRlphzsZCkk809R0aJtV
         K5aP12D8IcjclpnUYoEhBwLUqvnouP954huMm71tqs8AMGJEiHIdWX/RWto0XIfWTvY9
         lcj9S7ExGOkKxjrTjYJf/0GEyt7GDMH5buV9Phlzc3X2JK+sUdLr7ssoHwwop0ApGXKU
         GuzIc9luX36RRGo3sxhYH79R96HlY10xZrGGr5Ogzr2tLwS9KfrisEEcskfkQk1K1GbU
         CJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740593161; x=1741197961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xVVRQ21On+BgakJYPRhPKh5ZN4qUIiROQsAFkbaQCk=;
        b=fFfhXreX3Hhk2p4aChIzxI1mLn8BrDA76Wf/jTe34qV+2cMrI7v7Xd8kHlJ4YEw3hY
         lmRkh/o96Ta7jF8kq4pRJOFzooeqFBdT82z6orFuIZVlKo2H8O0N8m5iLy5hlaKNL4Ge
         gpLW/+vzmK2Vb8iK6GF9520Gxb9k8oIlKfnULkdyGeYoSfBx0huG5sCtUjWoNiVWvKqE
         pRC0P6WlPP8uoXZLaviPD2HOHfS0Q8D5fHRA8O2h8PchAxWanoibqmqOqazApDGQoQQI
         UUccl7G5EECEFiw6UfENsp/Jn6Ip24FRo9xZMiokTja0/Jov35nDWuqg1PI5elobn8gi
         JCcw==
X-Gm-Message-State: AOJu0YzXPA1IdbZexqk03gtc6bNDQV4PxgUN6jFoX0xS5qFQbeSWc9Z/
	qCHp4gLzr7vPkQTk8FVb+iyx+OnU4S/5xUMjJLS14cR6fK/YLYnnIeQz
X-Gm-Gg: ASbGncvYOddSLR3aaD+7pdMtZBiUd9+mGGet/sV1uBYyZ9vnL76neT0iW6iuIUWxkgL
	GQrixN1+zozjrOv+9cqZPAhssJIdpD7QvF7i+GeDv8op7oKNydQIO82ypqaRxbBsYHT6xYyREn6
	WyoU8t+Oe1o9ebRhaOomSRvJyrWr2X428yAayc1X2dzLUuZ51X6PaALyO7qMsMDhx+MS0AsobP3
	2c/x7Ch91ggUe8ziVL2764q0bWPQWXaaZ1AAFdGeF9QdFQBbUN/TDrcEKfzIVSTyF6X26uh1zOy
	ksq0fxA=
X-Google-Smtp-Source: AGHT+IF/OyQpb5vYBiNBBumEKTg0F3GGpztYbLdZjY2Lx0rIKNaUvukD5+tMDHcH0hmapPA2QRaxjQ==
X-Received: by 2002:a05:6808:2e89:b0:3f4:2274:3cbb with SMTP id 5614622812f47-3f425a5a56emr13475742b6e.3.1740593161194;
        Wed, 26 Feb 2025 10:06:01 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fe9428c8b3sm755069eaf.39.2025.02.26.10.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:06:00 -0800 (PST)
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
Subject: [PATCH v2 07/11] x86/irq: Move irq stacks to percpu hot section
Date: Wed, 26 Feb 2025 13:05:26 -0500
Message-ID: <20250226180531.1242429-8-brgerst@gmail.com>
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
 arch/x86/include/asm/current.h   |  6 ------
 arch/x86/include/asm/irq_stack.h | 12 ++++++------
 arch/x86/include/asm/processor.h |  7 +++++++
 arch/x86/kernel/dumpstack_32.c   |  4 ++--
 arch/x86/kernel/dumpstack_64.c   |  2 +-
 arch/x86/kernel/irq.c            |  5 +++++
 arch/x86/kernel/irq_32.c         | 12 +++++++-----
 arch/x86/kernel/irq_64.c         |  6 +++---
 arch/x86/kernel/process_64.c     |  2 +-
 9 files changed, 32 insertions(+), 24 deletions(-)

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
index b3d153730f63..54fce8d7504d 100644
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
index 474af15ae017..2cd2064457b1 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -34,6 +34,11 @@ EXPORT_PER_CPU_SYMBOL(irq_stat);
 DEFINE_PER_CPU_CACHE_HOT(u16, __softirq_pending);
 EXPORT_PER_CPU_SYMBOL(__softirq_pending);
 
+DEFINE_PER_CPU_CACHE_HOT(struct irq_stack *, hardirq_stack_ptr);
+#ifdef CONFIG_X86_64
+DEFINE_PER_CPU_CACHE_HOT(bool, hardirq_stack_inuse);
+#endif
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
index 226472332a70..93de583c05d1 100644
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


