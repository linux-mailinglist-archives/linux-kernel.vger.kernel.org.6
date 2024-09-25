Return-Path: <linux-kernel+bounces-339130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 437F798609E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBADC1F26ABA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BCD335D3;
	Wed, 25 Sep 2024 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XvQra+l3"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367DC1DFCF
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 13:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727270169; cv=none; b=e7GQZX5hNCKuA6J05X55HmupWe+B51VC7uaKguJB/IL84yLh6HOXKRFaeh0j0lHoksgpSKvb9/5DzKFhtxUqcbv8AQcHu5vJFBj6SrNOYGfSRAMajDxbXQSn+Z60Y1R7USJpZ5Z3PSJDfFZTnvpOOMw/ZFt/HMJlk4hEhmFqCWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727270169; c=relaxed/simple;
	bh=vrz0MK2qD5RVa2GkSJQYBkV3QwkLcnrtJ/PfJTsHZws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=elO1o0R9Q04y5w1czDxbrVTG8MUhqKng42b1C9SguccTeR24Sx+vz+Eyc/QAQYyo/5In2AYPiY7YpuRwGhlew4qnIUP0iPVHXJWyJQ2vX4gnPPcjc+ImrIeInYOyV7IysPiY9HAaO4CADKMum7XU+IeNpmqB5NGksSWyKzHAoYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XvQra+l3; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7db4c1a54easo3868926a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 06:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727270167; x=1727874967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15RDYprpYdVhDy/xasnvQ0QTcvqD5okomEeH5wWj5p8=;
        b=XvQra+l3pxKPDJdNmG8PBVQv3cvtbw93XOopdq3YafgZdKLoPIyccB4sVm3WZLToHn
         pY0X3VOJPkEhD4W6rfV+ysLJRYvwKfYv01tkXRGMHjYm046xjYpEfEymJnQH2YoyWzkx
         uADpBfg5O11kU/I05uai4qzZAJUeuk8Ie1tJKCASwgrKWMTY+FLQf8OEULnJ0HI8svBq
         HZXOPQEqWSKQ+2NRwoTPEzoNgQZkxlfr7maq4yQT0e+TYNDGmkrlk5I29dqThPy3dWSB
         TPLTHv0MNrE2NY2vpxewTV/H2Vp18t1Nfuhr4dgbyFYqRBT5flUI5qiBUamL4wv+fIjC
         NZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727270167; x=1727874967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15RDYprpYdVhDy/xasnvQ0QTcvqD5okomEeH5wWj5p8=;
        b=mDfyQvvn/9dX6605Pp3+D459dT+KjD6Fy8ok91CGjfUdO7BfdwbfJ4nwlqMXPwPLVi
         nnU4weGPITIi/Ei+TH+t8w+gAjkCt0y8hMix3pIOmYyO+TOyMdmgX8B7Hk1bl40aRAne
         ritfBzJJJvwFjGZTUa5WGY8/W3ZrN8HqD/aFlatwrIiwA4oDCPU85ykGmessKqkEOFIh
         h9D/GdQ9X198ulCeORd/3ap9KXM3uto2xQM3RVC2oP7thqRgK+cAtTdWKAuqeRFfgrqg
         c84n6e/DlG8VVHoHjT+RNBimz70Vs5Wb3lVEy8jaEUlmUy2N8Am1KrQ47B7yXj1420jt
         /RGA==
X-Forwarded-Encrypted: i=1; AJvYcCVlmpynNovOI1VFTyPl7YIk8ZvtCeVNiTNcoQxxnZ4aXSxBPeO9OsyWRE/S4cchJmMIIFxRItxDk+t6rto=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvbE1zyMOS3K2zeJy1Ilir4ky3WCrrxRDLqgqsESLbchGjfZPR
	say7CkJSHuqPdkvLf2gQO78q5NgNZntvsky4C4LIRO3xOWiamqY21ZEl8t5pxZZ7SYQl9cdXIYG
	ao0o=
X-Google-Smtp-Source: AGHT+IHrc/NFnCU0Jc8kKvBO4HGrGQnJ5mkWbHJg29150ArLk5WBYVhRTMj6KqfkBUTSy+sPobbYAA==
X-Received: by 2002:a17:90a:5589:b0:2da:7b8b:ea0d with SMTP id 98e67ed59e1d1-2e06ae26087mr2605527a91.8.1727270167269;
        Wed, 25 Sep 2024 06:16:07 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1e09e2sm1479465a91.32.2024.09.25.06.16.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Sep 2024 06:16:07 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	andy.chiu@sifive.com,
	guoren@kernel.org,
	christoph.muellner@vrull.eu,
	ajones@ventanamicro.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lihangjing@bytedance.com,
	dengliang.1214@bytedance.com,
	xieyongji@bytedance.com,
	chaiwen.cc@bytedance.com,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH v3 2/2] riscv: Use Zawrs to accelerate IPI to idle cpu
Date: Wed, 25 Sep 2024 21:15:47 +0800
Message-Id: <20240925131547.42396-3-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240925131547.42396-1-luxu.kernel@bytedance.com>
References: <20240925131547.42396-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When sending IPI to a cpu which has entered idle state using Zawrs
extension, there is no need to send a physical software interrupt.
Instead, we can write the IPI information to the address reserved by
target cpu, which will wake it from WRS.NTO. Then the target cpu can
handle the IPI directly without falling into traditional interrupt
handling routine.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/processor.h | 14 +++++++
 arch/riscv/include/asm/smp.h       | 14 +++++++
 arch/riscv/kernel/process.c        | 65 +++++++++++++++++++++++++++++-
 arch/riscv/kernel/smp.c            | 51 ++++++++++++++++++-----
 4 files changed, 131 insertions(+), 13 deletions(-)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index d0dcdb7e7392..0dbc9390c3b2 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -164,6 +164,20 @@ static inline void wrs_nto(unsigned long *addr)
 			: : "memory");
 }
 
+static inline void wrs_nto_if(int *addr, int val)
+{
+	int prev;
+
+	__asm__ __volatile__(
+			"lr.w %[p], %[a]\n\t"
+			"bne %[p], %[v], 1f\n\t"
+			ZAWRS_WRS_NTO "\n\t"
+			"1:\n\t"
+			: [p] "=&r" (prev), [a] "+A" (*addr)
+			: [v] "r" (val)
+			: "memory");
+}
+
 extern phys_addr_t dma32_phys_limit;
 
 struct device_node;
diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index 7ac80e9f2288..8f2dfbf20e89 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -19,6 +19,20 @@ extern unsigned long boot_cpu_hartid;
 
 #include <linux/jump_label.h>
 
+enum ipi_message_type {
+	IPI_RESCHEDULE,
+	IPI_CALL_FUNC,
+	IPI_CPU_STOP,
+	IPI_CPU_CRASH_STOP,
+	IPI_IRQ_WORK,
+	IPI_TIMER,
+	IPI_MAX
+};
+
+int ipi_virq_base_get(void);
+
+irqreturn_t handle_IPI(int irq, void *data);
+
 /*
  * Mapping between linux logical cpu index and hartid.
  */
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 77769965609e..975b3f28e8c8 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -16,6 +16,7 @@
 #include <linux/ptrace.h>
 #include <linux/uaccess.h>
 #include <linux/static_call.h>
+#include <linux/hardirq.h>
 
 #include <asm/unistd.h>
 #include <asm/processor.h>
@@ -27,6 +28,7 @@
 #include <asm/cpuidle.h>
 #include <asm/vector.h>
 #include <asm/cpufeature.h>
+#include <asm/smp.h>
 
 #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_PER_TASK)
 #include <linux/stackprotector.h>
@@ -36,6 +38,8 @@ EXPORT_SYMBOL(__stack_chk_guard);
 
 extern asmlinkage void ret_from_fork(void);
 
+DEFINE_PER_CPU(atomic_t, idle_ipi_mask);
+
 static __cpuidle void default_idle(void)
 {
 	/*
@@ -47,6 +51,16 @@ static __cpuidle void default_idle(void)
 	wait_for_interrupt();
 }
 
+static __cpuidle void default_idle_enter(void)
+{
+	/* Do nothing */
+}
+
+static __cpuidle void default_idle_exit(void)
+{
+	/* Do nothing */
+}
+
 static __cpuidle void wrs_idle(void)
 {
 	/*
@@ -55,10 +69,42 @@ static __cpuidle void wrs_idle(void)
 	 * to entering WRS.NTO.
 	 */
 	mb();
+#ifdef CONFIG_SMP
+	wrs_nto_if(&this_cpu_ptr(&idle_ipi_mask)->counter, BIT(IPI_MAX));
+#else
 	wrs_nto(&current_thread_info()->flags);
+#endif
+}
+
+static __cpuidle void wrs_idle_enter(void)
+{
+#ifdef CONFIG_SMP
+	atomic_set(this_cpu_ptr(&idle_ipi_mask), BIT(IPI_MAX));
+#endif
+}
+
+static __cpuidle void wrs_idle_exit(void)
+{
+#ifdef CONFIG_SMP
+	int pending;
+	unsigned long flags;
+	enum ipi_message_type ipi;
+
+	local_irq_save(flags);
+	pending = atomic_xchg_relaxed(this_cpu_ptr(&idle_ipi_mask), 0);
+	for (ipi = IPI_RESCHEDULE; ipi < IPI_MAX; ipi++)
+		if (pending & BIT(ipi)) {
+			irq_enter();
+			handle_IPI(ipi_virq_base_get() + ipi, NULL);
+			irq_exit();
+		}
+	local_irq_restore(flags);
+#endif
 }
 
 DEFINE_STATIC_CALL_NULL(riscv_idle, default_idle);
+DEFINE_STATIC_CALL_NULL(riscv_idle_enter, default_idle_enter);
+DEFINE_STATIC_CALL_NULL(riscv_idle_exit, default_idle_exit);
 
 void __cpuidle cpu_do_idle(void)
 {
@@ -70,13 +116,28 @@ void __cpuidle arch_cpu_idle(void)
 	cpu_do_idle();
 }
 
+void __cpuidle arch_cpu_idle_enter(void)
+{
+	static_call(riscv_idle_enter)();
+}
+
+void __cpuidle arch_cpu_idle_exit(void)
+{
+	static_call(riscv_idle_exit)();
+}
+
 void __init select_idle_routine(void)
 {
 	if (IS_ENABLED(CONFIG_RISCV_ZAWRS_IDLE) &&
-			riscv_has_extension_likely(RISCV_ISA_EXT_ZAWRS))
+			riscv_has_extension_likely(RISCV_ISA_EXT_ZAWRS)) {
 		static_call_update(riscv_idle, wrs_idle);
-	else
+		static_call_update(riscv_idle_enter, wrs_idle_enter);
+		static_call_update(riscv_idle_exit, wrs_idle_exit);
+	} else {
 		static_call_update(riscv_idle, default_idle);
+		static_call_update(riscv_idle_enter, default_idle_enter);
+		static_call_update(riscv_idle_exit, default_idle_exit);
+	}
 }
 
 int set_unalign_ctl(struct task_struct *tsk, unsigned int val)
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 8e6eb64459af..6e7d41ed4144 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -26,16 +26,6 @@
 #include <asm/cacheflush.h>
 #include <asm/cpu_ops.h>
 
-enum ipi_message_type {
-	IPI_RESCHEDULE,
-	IPI_CALL_FUNC,
-	IPI_CPU_STOP,
-	IPI_CPU_CRASH_STOP,
-	IPI_IRQ_WORK,
-	IPI_TIMER,
-	IPI_MAX
-};
-
 unsigned long __cpuid_to_hartid_map[NR_CPUS] __ro_after_init = {
 	[0 ... NR_CPUS-1] = INVALID_HARTID
 };
@@ -94,13 +84,47 @@ static inline void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
 }
 #endif
 
+#ifdef CONFIG_RISCV_ZAWRS_IDLE
+DECLARE_PER_CPU(atomic_t, idle_ipi_mask);
+#endif
+
 static void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op)
 {
+#ifdef CONFIG_RISCV_ZAWRS_IDLE
+	int cpu, val;
+
+	asm goto(ALTERNATIVE("j %l[no_zawrs]", "nop", 0, RISCV_ISA_EXT_ZAWRS, 1)
+			: : : : no_zawrs);
+
+	for_each_cpu(cpu, mask) {
+		val = atomic_fetch_or_relaxed(BIT(op), per_cpu_ptr(&idle_ipi_mask, cpu));
+		if (likely(!(val & BIT(IPI_MAX))))
+			__ipi_send_mask(ipi_desc[op], cpumask_of(cpu));
+	}
+
+	return;
+
+no_zawrs:
+#endif
 	__ipi_send_mask(ipi_desc[op], mask);
 }
 
 static void send_ipi_single(int cpu, enum ipi_message_type op)
 {
+#ifdef CONFIG_RISCV_ZAWRS_IDLE
+	int val;
+
+	asm goto(ALTERNATIVE("j %l[no_zawrs]", "nop", 0, RISCV_ISA_EXT_ZAWRS, 1)
+			: : : : no_zawrs);
+
+	val = atomic_fetch_or_relaxed(BIT(op), per_cpu_ptr(&idle_ipi_mask, cpu));
+	if (likely(!(val & BIT(IPI_MAX))))
+		__ipi_send_mask(ipi_desc[op], cpumask_of(cpu));
+
+	return;
+
+no_zawrs:
+#endif
 	__ipi_send_mask(ipi_desc[op], cpumask_of(cpu));
 }
 
@@ -111,7 +135,7 @@ void arch_irq_work_raise(void)
 }
 #endif
 
-static irqreturn_t handle_IPI(int irq, void *data)
+irqreturn_t handle_IPI(int irq, void *data)
 {
 	int ipi = irq - ipi_virq_base;
 
@@ -323,3 +347,8 @@ void arch_smp_send_reschedule(int cpu)
 	send_ipi_single(cpu, IPI_RESCHEDULE);
 }
 EXPORT_SYMBOL_GPL(arch_smp_send_reschedule);
+
+int ipi_virq_base_get(void)
+{
+	return ipi_virq_base;
+}
-- 
2.20.1


