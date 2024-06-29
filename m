Return-Path: <linux-kernel+bounces-234863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EFC91CBBF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 10:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43E2B1F21F8E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 08:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4860A3B1AC;
	Sat, 29 Jun 2024 08:53:21 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFE22D058
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 08:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719651200; cv=none; b=qd6TBvsAaX+ssr8kcIxXtqVaPeaUCMAwVJp9BN4mxhD5lXhaljbh1mJcT81G04rHcTSYso4//wdth9Zff7STeq8mm5K1OCWyBJ4N+hvePKacrHhhd3u3Tg2jMlTT4MpkegUp6SutmnvQ7hrWHxo0SPQZU/JF+305ZwOHM0o+80U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719651200; c=relaxed/simple;
	bh=0CYiT+ttepjPsLpAANO32YJNJcHPR+T401XVa30u1Y0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B48Xi/gF0aMWijibkBQKyk6W7tjw4S06+3JvdP3nEAproSaFl3M/nFWrJldPnKvj9Bmfc1ZcFjDhgeBOyVojf/eYKxoYD7k+6h7Ic7QrAT4msShcClhDGm2c1fHD3cTvew4Qu3NDtjuz0IZ780RUYmF0RPObDhGL//TE/qf4N/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WB5ZC1WQ2zjXYm;
	Sat, 29 Jun 2024 16:48:51 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 361DF180089;
	Sat, 29 Jun 2024 16:53:14 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 29 Jun
 2024 16:53:13 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <luto@kernel.org>,
	<kees@kernel.org>, <wad@chromium.org>, <ruanjinjie@huawei.com>,
	<rostedt@goodmis.org>, <arnd@arndb.de>, <ardb@kernel.org>,
	<broonie@kernel.org>, <mark.rutland@arm.com>, <rick.p.edgecombe@intel.com>,
	<leobras@redhat.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 1/3] entry: Add some arch funcs to support arm64 to use generic entry
Date: Sat, 29 Jun 2024 16:55:59 +0800
Message-ID: <20240629085601.470241-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240629085601.470241-1-ruanjinjie@huawei.com>
References: <20240629085601.470241-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi100008.china.huawei.com (7.221.188.57)

Add some arch functions to support arm64 to use generic entry, which do not
affect existing architectures that use generic entry:

 - arch_prepare/post_report_syscall_entry/exit().

 - arch_enter_from_kernel_mode(), arch_exit_to_kernel_mode_prepare().

 - arch_irqentry_exit_need_resched() to support architecture-related
   need_resched() check logic.

Also make syscall_exit_work() not static and move report_single_step() to
thread_info.h, which can be used by arm64 later.

x86 and Riscv compilation test ok after this patch.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
---
v3:
- Make the arch funcs not use __weak as Thomas suggested.
- Make arch_forget_syscall() folded in arch_post_report_syscall_entry().
- __always_inline -> inline.
- Move report_single_step() to thread_info.h for arm64
- Add Suggested-by.
- Update the commit message.

v2:
- Fix a bug that not call arch_post_report_syscall_entry() in
  syscall_trace_enter() if ptrace_report_syscall_entry() return not zero.
- Update the commit message.
---
 include/linux/entry-common.h | 90 ++++++++++++++++++++++++++++++++++++
 include/linux/thread_info.h  | 13 ++++++
 kernel/entry/common.c        | 37 +++++++--------
 3 files changed, 122 insertions(+), 18 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index b0fb775a600d..2aea23ca9d66 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -290,6 +290,94 @@ static __always_inline void arch_exit_to_user_mode(void);
 static __always_inline void arch_exit_to_user_mode(void) { }
 #endif
 
+/**
+ * arch_enter_from_kernel_mode - Architecture specific check work.
+ */
+static inline void arch_enter_from_kernel_mode(struct pt_regs *regs);
+
+#ifndef arch_enter_from_kernel_mode
+static inline void arch_enter_from_kernel_mode(struct pt_regs *regs) { }
+#endif
+
+/**
+ * arch_exit_to_kernel_mode_prepare - Architecture specific final work before
+ *				      exit to kernel mode.
+ */
+static inline void arch_exit_to_kernel_mode_prepare(struct pt_regs *regs);
+
+#ifndef arch_exit_to_kernel_mode_prepare
+static inline void arch_exit_to_kernel_mode_prepare(struct pt_regs *regs) { }
+#endif
+
+/**
+ * arch_prepare_report_syscall_entry - Architecture specific work before
+ *			               report_syscall_entry().
+ */
+static inline unsigned long arch_prepare_report_syscall_entry(struct pt_regs *regs);
+
+#ifndef arch_prepare_report_syscall_entry
+static inline unsigned long arch_prepare_report_syscall_entry(struct pt_regs *regs)
+{
+	return 0;
+}
+#endif
+
+/**
+ * arch_post_report_syscall_entry - Architecture specific work after
+ *			            report_syscall_entry().
+ */
+static inline void arch_post_report_syscall_entry(struct pt_regs *regs,
+						  unsigned long saved_reg,
+						  long ret);
+
+#ifndef arch_post_report_syscall_entry
+static inline void arch_post_report_syscall_entry(struct pt_regs *regs,
+						  unsigned long saved_reg,
+						  long ret)
+{
+}
+#endif
+
+/**
+ * arch_prepare_report_syscall_exit - Architecture specific work before
+ *			              report_syscall_exit().
+ */
+static inline unsigned long arch_prepare_report_syscall_exit(struct pt_regs *regs,
+							     unsigned long work);
+
+#ifndef arch_prepare_report_syscall_exit
+static inline unsigned long arch_prepare_report_syscall_exit(struct pt_regs *regs,
+							     unsigned long work)
+{
+	return 0;
+}
+#endif
+
+/**
+ * arch_post_report_syscall_exit - Architecture specific work after
+ *			           report_syscall_exit().
+ */
+static inline void arch_post_report_syscall_exit(struct pt_regs *regs,
+						 unsigned long saved_reg,
+						 unsigned long work);
+
+#ifndef arch_post_report_syscall_exit
+static inline void arch_post_report_syscall_exit(struct pt_regs *regs,
+						 unsigned long saved_reg,
+						 unsigned long work)
+{
+}
+#endif
+
+/**
+ * arch_irqentry_exit_need_resched - Architecture specific need resched function
+ */
+static inline bool arch_irqentry_exit_need_resched(void);
+
+#ifndef arch_irqentry_exit_need_resched
+static inline bool arch_irqentry_exit_need_resched(void) { return true; }
+#endif
+
 /**
  * arch_do_signal_or_restart -  Architecture specific signal delivery function
  * @regs:	Pointer to currents pt_regs
@@ -552,4 +640,6 @@ irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs);
  */
 void noinstr irqentry_nmi_exit(struct pt_regs *regs, irqentry_state_t irq_state);
 
+void syscall_exit_work(struct pt_regs *regs, unsigned long work);
+
 #endif
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 9ea0b28068f4..062de9666ef3 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -55,6 +55,19 @@ enum syscall_work_bit {
 #define SYSCALL_WORK_SYSCALL_AUDIT	BIT(SYSCALL_WORK_BIT_SYSCALL_AUDIT)
 #define SYSCALL_WORK_SYSCALL_USER_DISPATCH BIT(SYSCALL_WORK_BIT_SYSCALL_USER_DISPATCH)
 #define SYSCALL_WORK_SYSCALL_EXIT_TRAP	BIT(SYSCALL_WORK_BIT_SYSCALL_EXIT_TRAP)
+
+/*
+ * If SYSCALL_EMU is set, then the only reason to report is when
+ * SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
+ * instruction has been already reported in syscall_enter_from_user_mode().
+ */
+static inline bool report_single_step(unsigned long work)
+{
+	if (work & SYSCALL_WORK_SYSCALL_EMU)
+		return false;
+
+	return work & SYSCALL_WORK_SYSCALL_EXIT_TRAP;
+}
 #endif
 
 #include <asm/thread_info.h>
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 90843cc38588..cd76391ffcb9 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -28,6 +28,7 @@ static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
 long syscall_trace_enter(struct pt_regs *regs, long syscall,
 				unsigned long work)
 {
+	unsigned long saved_reg;
 	long ret = 0;
 
 	/*
@@ -42,8 +43,10 @@ long syscall_trace_enter(struct pt_regs *regs, long syscall,
 
 	/* Handle ptrace */
 	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
+		saved_reg = arch_prepare_report_syscall_entry(regs);
 		ret = ptrace_report_syscall_entry(regs);
-		if (ret || (work & SYSCALL_WORK_SYSCALL_EMU))
+		arch_post_report_syscall_entry(regs, saved_reg, ret);
+		if (ret || work & SYSCALL_WORK_SYSCALL_EMU)
 			return -1L;
 	}
 
@@ -133,21 +136,9 @@ __always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 	return ti_work;
 }
 
-/*
- * If SYSCALL_EMU is set, then the only reason to report is when
- * SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
- * instruction has been already reported in syscall_enter_from_user_mode().
- */
-static inline bool report_single_step(unsigned long work)
-{
-	if (work & SYSCALL_WORK_SYSCALL_EMU)
-		return false;
-
-	return work & SYSCALL_WORK_SYSCALL_EXIT_TRAP;
-}
-
-static void syscall_exit_work(struct pt_regs *regs, unsigned long work)
+void syscall_exit_work(struct pt_regs *regs, unsigned long work)
 {
+	unsigned long saved_reg;
 	bool step;
 
 	/*
@@ -169,8 +160,11 @@ static void syscall_exit_work(struct pt_regs *regs, unsigned long work)
 		trace_sys_exit(regs, syscall_get_return_value(current, regs));
 
 	step = report_single_step(work);
-	if (step || work & SYSCALL_WORK_SYSCALL_TRACE)
+	if (step || work & SYSCALL_WORK_SYSCALL_TRACE) {
+		saved_reg = arch_prepare_report_syscall_exit(regs, work);
 		ptrace_report_syscall_exit(regs, step);
+		arch_post_report_syscall_exit(regs, saved_reg, work);
+	}
 }
 
 /*
@@ -244,6 +238,8 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 		return ret;
 	}
 
+	arch_enter_from_kernel_mode(regs);
+
 	/*
 	 * If this entry hit the idle task invoke ct_irq_enter() whether
 	 * RCU is watching or not.
@@ -307,7 +303,7 @@ void raw_irqentry_exit_cond_resched(void)
 		rcu_irq_exit_check_preempt();
 		if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
 			WARN_ON_ONCE(!on_thread_stack());
-		if (need_resched())
+		if (need_resched() && arch_irqentry_exit_need_resched())
 			preempt_schedule_irq();
 	}
 }
@@ -332,7 +328,12 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 	/* Check whether this returns to user mode */
 	if (user_mode(regs)) {
 		irqentry_exit_to_user_mode(regs);
-	} else if (!regs_irqs_disabled(regs)) {
+		return;
+	}
+
+	arch_exit_to_kernel_mode_prepare(regs);
+
+	if (!regs_irqs_disabled(regs)) {
 		/*
 		 * If RCU was not watching on entry this needs to be done
 		 * carefully and needs the same ordering of lockdep/tracing
-- 
2.34.1


