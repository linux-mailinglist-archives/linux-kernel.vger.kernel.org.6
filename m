Return-Path: <linux-kernel+bounces-331476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F7A97AD5C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06397284615
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC76E15D5B9;
	Tue, 17 Sep 2024 08:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lmPu2hRf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mtM1MHSy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3945B158559
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 08:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563255; cv=none; b=Ftk6O3lOd/4TMkyNh43pXn+sMlR19gybS7DzRlxFXqxrYYVkue0ji3fQ5i7BNMKWOQDX9JqkhHmF2vDuA80qZbtUOfrTMN+naScgxTlZ6rnpYLem27sl/Z3DKKEO3gn0/dHbb+GcQVZYx+lGJcIgIrDYcMqfxFfO+NEOY/TjaJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563255; c=relaxed/simple;
	bh=geVGY9X8yZTmR2GoQ2knMVUfrERJclccsDs1q7PjF2I=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=pLU8gBZOjmb33X6qwU2F75XX9h+ip9rdCaU8CzpMQ0w2LZ0iRwNYYuf/6PSK9LaqLA2J8rNv7Uar1vpCE9EhkyrHyCQy1pL3c0KRhDXfvdJdR9EfHBwPfr6XNgD44uJciCtsESq4iTwt1iOnqs48BdXxndHDyVamV/PIvtY9CTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lmPu2hRf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mtM1MHSy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726563246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=6nNTigOaGHVe0D9BY4Icl0vUQbgUuNA9JIcApsH4UtY=;
	b=lmPu2hRf4ker5HpbhHI08j4ewzqMvR0JcLlBpNYRb1Binm7pKTvDOm4dIBiI0DegESf2/D
	QqnIt+q0fbqxndZW+zw7gaFH0A8OaGIXm44YRZ2Q9iL3nEs5PUYGvwfQTU8PlM+zA2QwFh
	AyyVyRxRlxqC8iRZGyDYvOJ8ipc08oYEEaycfz+kqKCv5QM+rVUc5OeTgzqqorSLopfTkQ
	Wq5PjORiyBWMqmtJiNVdwxfGN0KxD0pOAzOCP4UjZzQAls870OfvFMGB5gUS2FB9Qx51V1
	tLF/ee5rgkPWNZ7CghqF0tEnR1mXArKRXxVq57P68iu3LNykDEobKAuSEIE+Aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726563246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=6nNTigOaGHVe0D9BY4Icl0vUQbgUuNA9JIcApsH4UtY=;
	b=mtM1MHSy9zPycje7YFZNQWkdDifT+bkKvYGOj0ib+Us2JvIXm2lEtZcViwGgZjC0CxDF6q
	MliVY4OLYM/hu+Bw==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/build for v6.12-rc1
References: <172656198112.2471820.6226852046770294674.tglx@xen13>
Message-ID: <172656198283.2471820.288980349418658549.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Sep 2024 10:54:05 +0200 (CEST)

Linus,

please pull the latest x86/build branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-2024-0=
9-17

up to:  ae94b263f5f6: x86: Ignore stack unwinding in KCOV

Updates for KCOV instrumentation on x86:

  - Prevent spurious KCOV coverage in common_interrupt()

  - Fixup the KCOV Makefile directive which got stale due to a source file
    rename

  - Exclude stack unwinding from KCOV as it creates large amounts of
    uninteresting coverage

  - Provide a self test to validate that KCOV coverage of the interrupt
    handling code starts not before preempt count got updated.

Thanks,

	tglx

------------------>
Dmitry Vyukov (4):
      x86/entry: Remove unwanted instrumentation in common_interrupt()
      kcov: Add interrupt handling self test
      module: Fix KCOV-ignored file name
      x86: Ignore stack unwinding in KCOV


 arch/x86/include/asm/hardirq.h  |  8 ++++++--
 arch/x86/include/asm/idtentry.h |  6 +++---
 arch/x86/kernel/Makefile        |  8 ++++++++
 kernel/kcov.c                   | 31 +++++++++++++++++++++++++++++++
 kernel/module/Makefile          |  2 +-
 lib/Kconfig.debug               |  8 ++++++++
 6 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index c67fa6ad098a..6ffa8b75f4cd 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -69,7 +69,11 @@ extern u64 arch_irq_stat(void);
 #define local_softirq_pending_ref       pcpu_hot.softirq_pending
=20
 #if IS_ENABLED(CONFIG_KVM_INTEL)
-static inline void kvm_set_cpu_l1tf_flush_l1d(void)
+/*
+ * This function is called from noinstr interrupt contexts
+ * and must be inlined to not get instrumentation.
+ */
+static __always_inline void kvm_set_cpu_l1tf_flush_l1d(void)
 {
 	__this_cpu_write(irq_stat.kvm_cpu_l1tf_flush_l1d, 1);
 }
@@ -84,7 +88,7 @@ static __always_inline bool kvm_get_cpu_l1tf_flush_l1d(void)
 	return __this_cpu_read(irq_stat.kvm_cpu_l1tf_flush_l1d);
 }
 #else /* !IS_ENABLED(CONFIG_KVM_INTEL) */
-static inline void kvm_set_cpu_l1tf_flush_l1d(void) { }
+static __always_inline void kvm_set_cpu_l1tf_flush_l1d(void) { }
 #endif /* IS_ENABLED(CONFIG_KVM_INTEL) */
=20
 #endif /* _ASM_X86_HARDIRQ_H */
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index d4f24499b256..ad5c68f0509d 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -212,8 +212,8 @@ __visible noinstr void func(struct pt_regs *regs,			\
 	irqentry_state_t state =3D irqentry_enter(regs);			\
 	u32 vector =3D (u32)(u8)error_code;				\
 									\
+	kvm_set_cpu_l1tf_flush_l1d();                                   \
 	instrumentation_begin();					\
-	kvm_set_cpu_l1tf_flush_l1d();					\
 	run_irq_on_irqstack_cond(__##func, regs, vector);		\
 	instrumentation_end();						\
 	irqentry_exit(regs, state);					\
@@ -250,7 +250,6 @@ static void __##func(struct pt_regs *regs);				\
 									\
 static __always_inline void instr_##func(struct pt_regs *regs)		\
 {									\
-	kvm_set_cpu_l1tf_flush_l1d();					\
 	run_sysvec_on_irqstack_cond(__##func, regs);			\
 }									\
 									\
@@ -258,6 +257,7 @@ __visible noinstr void func(struct pt_regs *regs)			\
 {									\
 	irqentry_state_t state =3D irqentry_enter(regs);			\
 									\
+	kvm_set_cpu_l1tf_flush_l1d();                                   \
 	instrumentation_begin();					\
 	instr_##func (regs);						\
 	instrumentation_end();						\
@@ -288,7 +288,6 @@ static __always_inline void __##func(struct pt_regs *regs=
);		\
 static __always_inline void instr_##func(struct pt_regs *regs)		\
 {									\
 	__irq_enter_raw();						\
-	kvm_set_cpu_l1tf_flush_l1d();					\
 	__##func (regs);						\
 	__irq_exit_raw();						\
 }									\
@@ -297,6 +296,7 @@ __visible noinstr void func(struct pt_regs *regs)			\
 {									\
 	irqentry_state_t state =3D irqentry_enter(regs);			\
 									\
+	kvm_set_cpu_l1tf_flush_l1d();                                   \
 	instrumentation_begin();					\
 	instr_##func (regs);						\
 	instrumentation_end();						\
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index a847180836e4..f7918980667a 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -35,6 +35,14 @@ KMSAN_SANITIZE_nmi.o					:=3D n
 # If instrumentation of the following files is enabled, boot hangs during
 # first second.
 KCOV_INSTRUMENT_head$(BITS).o				:=3D n
+# These are called from save_stack_trace() on debug paths,
+# and produce large amounts of uninteresting coverage.
+KCOV_INSTRUMENT_stacktrace.o				:=3D n
+KCOV_INSTRUMENT_dumpstack.o				:=3D n
+KCOV_INSTRUMENT_dumpstack_$(BITS).o			:=3D n
+KCOV_INSTRUMENT_unwind_orc.o				:=3D n
+KCOV_INSTRUMENT_unwind_frame.o				:=3D n
+KCOV_INSTRUMENT_unwind_guess.o				:=3D n
=20
 CFLAGS_irq.o :=3D -I $(src)/../include/asm/trace
=20
diff --git a/kernel/kcov.c b/kernel/kcov.c
index f0a69d402066..d9d4a0c04185 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -11,6 +11,7 @@
 #include <linux/fs.h>
 #include <linux/hashtable.h>
 #include <linux/init.h>
+#include <linux/jiffies.h>
 #include <linux/kmsan-checks.h>
 #include <linux/mm.h>
 #include <linux/preempt.h>
@@ -1058,6 +1059,32 @@ u64 kcov_common_handle(void)
 }
 EXPORT_SYMBOL(kcov_common_handle);
=20
+#ifdef CONFIG_KCOV_SELFTEST
+static void __init selftest(void)
+{
+	unsigned long start;
+
+	pr_err("running self test\n");
+	/*
+	 * Test that interrupts don't produce spurious coverage.
+	 * The coverage callback filters out interrupt code, but only
+	 * after the handler updates preempt count. Some code periodically
+	 * leaks out of that section and leads to spurious coverage.
+	 * It's hard to call the actual interrupt handler directly,
+	 * so we just loop here for a bit waiting for a timer interrupt.
+	 * We set kcov_mode to enable tracing, but don't setup the area,
+	 * so any attempt to trace will crash. Note: we must not call any
+	 * potentially traced functions in this region.
+	 */
+	start =3D jiffies;
+	current->kcov_mode =3D KCOV_MODE_TRACE_PC;
+	while ((jiffies - start) * MSEC_PER_SEC / HZ < 300)
+		;
+	current->kcov_mode =3D 0;
+	pr_err("done running self test\n");
+}
+#endif
+
 static int __init kcov_init(void)
 {
 	int cpu;
@@ -1077,6 +1104,10 @@ static int __init kcov_init(void)
 	 */
 	debugfs_create_file_unsafe("kcov", 0600, NULL, NULL, &kcov_fops);
=20
+#ifdef CONFIG_KCOV_SELFTEST
+	selftest();
+#endif
+
 	return 0;
 }
=20
diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index a10b2b9a6fdf..50ffcc413b54 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -5,7 +5,7 @@
=20
 # These are called from save_stack_trace() on slub debug path,
 # and produce insane amounts of uninteresting coverage.
-KCOV_INSTRUMENT_module.o :=3D n
+KCOV_INSTRUMENT_main.o :=3D n
=20
 obj-y +=3D main.o
 obj-y +=3D strict_rwx.o
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index a30c03a66172..270e367b3e6f 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2173,6 +2173,14 @@ config KCOV_IRQ_AREA_SIZE
 	  soft interrupts. This specifies the size of those areas in the
 	  number of unsigned long words.
=20
+config KCOV_SELFTEST
+	bool "Perform short selftests on boot"
+	depends on KCOV
+	help
+	  Run short KCOV coverage collection selftests on boot.
+	  On test failure, causes the kernel to panic. Recommended to be
+	  enabled, ensuring critical functionality works as intended.
+
 menuconfig RUNTIME_TESTING_MENU
 	bool "Runtime Testing"
 	default y


