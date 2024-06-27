Return-Path: <linux-kernel+bounces-231982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A17991A11E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDB8FB20DE7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 08:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405558121B;
	Thu, 27 Jun 2024 08:09:39 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55826BFB0
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 08:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719475778; cv=none; b=g7xfZLAZ4pT/0xl8DCkd8fIeFPciUYSUPMii8BiVzh13r1M6W0WTTgV4gwSXqBn5oxD5j08AHXPIM3CfLZfN8KGwcmBpshwJ2/qVhNRwn0WwPkUrk2lQIuEjKd1xv/+4ZDcExT2i0L5kfAWaYSAJncNP5D13RIwa8gAylSK48PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719475778; c=relaxed/simple;
	bh=CjcxAeIv3EWt4OmF1BS4re4MDHk4tiNE8NQeoR7xGE4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z+4uZUSpMXfX5tPeTQTxnJLJZz8iC+0l8szKTjFNTMxkpD1FcyGTMsOUbkBJvpbP9zyrjUQmFf7mHN99I7ogT+WLJezQwkaFad66nVpSbupl7RM7X0xHcJo0LMc5jPM//Fm35Zudarg/4QvUhwwf2POg+vYJNs63CSoX3KbZzYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W8rhZ2nbkzZgZ2;
	Thu, 27 Jun 2024 16:05:02 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id CB39F180064;
	Thu, 27 Jun 2024 16:09:27 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 27 Jun
 2024 16:09:27 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <luto@kernel.org>,
	<kees@kernel.org>, <wad@chromium.org>, <ruanjinjie@huawei.com>,
	<rostedt@goodmis.org>, <arnd@arndb.de>, <ardb@kernel.org>,
	<broonie@kernel.org>, <mark.rutland@arm.com>, <rick.p.edgecombe@intel.com>,
	<leobras@redhat.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 1/3] entry: Add some arch funcs to support arm64 to use generic entry
Date: Thu, 27 Jun 2024 16:12:07 +0800
Message-ID: <20240627081209.3511918-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627081209.3511918-1-ruanjinjie@huawei.com>
References: <20240627081209.3511918-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi100008.china.huawei.com (7.221.188.57)

Add some arch functions to support arm64 to use generic entry, which do not
affect existing architectures that use generic entry:

 - arch_prepare/post_report_syscall_entry/exit().

 - arch_enter_from_kernel_mode(), arch_exit_to_kernel_mode_prepare().

 - arch_irqentry_exit_need_resched() to support architecture-related
   need_resched() check logic.

Also make report_single_step() and syscall_exit_work() not static, which
can be used by arm64 later.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2:
- Fix a bug that not call arch_post_report_syscall_entry() in
  syscall_trace_enter() if ptrace_report_syscall_entry() return not zero.
- Update the commit message.
---
 include/linux/entry-common.h | 51 ++++++++++++++++++++++++++++++++++++
 kernel/entry/common.c        | 48 ++++++++++++++++++++++++++++-----
 2 files changed, 93 insertions(+), 6 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index b0fb775a600d..1be4c3d91995 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -84,6 +84,18 @@ static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs);
 static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs) {}
 #endif
 
+static __always_inline void arch_enter_from_kernel_mode(struct pt_regs *regs);
+
+#ifndef arch_enter_from_kernel_mode
+static __always_inline void arch_enter_from_kernel_mode(struct pt_regs *regs) {}
+#endif
+
+static __always_inline void arch_exit_to_kernel_mode_prepare(struct pt_regs *regs);
+
+#ifndef arch_exit_to_kernel_mode_prepare
+static __always_inline void arch_exit_to_kernel_mode_prepare(struct pt_regs *regs) {}
+#endif
+
 /**
  * enter_from_user_mode - Establish state when coming from user mode
  *
@@ -298,6 +310,42 @@ static __always_inline void arch_exit_to_user_mode(void) { }
  */
 void arch_do_signal_or_restart(struct pt_regs *regs);
 
+/**
+ * arch_irqentry_exit_need_resched - Architecture specific need resched function
+ */
+bool arch_irqentry_exit_need_resched(void);
+
+/**
+ * arch_prepare_report_syscall_entry - Architecture specific report_syscall_entry()
+ * prepare function
+ */
+unsigned long arch_prepare_report_syscall_entry(struct pt_regs *regs);
+
+/**
+ * arch_post_report_syscall_entry - Architecture specific report_syscall_entry()
+ * post function
+ */
+void arch_post_report_syscall_entry(struct pt_regs *regs, unsigned long saved_reg);
+
+/**
+ * arch_prepare_report_syscall_exit - Architecture specific report_syscall_exit()
+ * prepare function
+ */
+unsigned long arch_prepare_report_syscall_exit(struct pt_regs *regs, unsigned long work);
+
+/**
+ * arch_post_report_syscall_exit - Architecture specific report_syscall_exit()
+ * post function
+ */
+void arch_post_report_syscall_exit(struct pt_regs *regs, unsigned long saved_reg,
+				   unsigned long work);
+
+/**
+ * arch_forget_syscall - Architecture specific function called if
+ * ptrace_report_syscall_entry() return nonzero
+ */
+void arch_forget_syscall(struct pt_regs *regs);
+
 /**
  * exit_to_user_mode_loop - do any pending work before leaving to user space
  */
@@ -552,4 +600,7 @@ irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs);
  */
 void noinstr irqentry_nmi_exit(struct pt_regs *regs, irqentry_state_t irq_state);
 
+bool report_single_step(unsigned long work);
+void syscall_exit_work(struct pt_regs *regs, unsigned long work);
+
 #endif
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 90843cc38588..625b63e947cb 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -25,9 +25,14 @@ static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
 	}
 }
 
+unsigned long __weak arch_prepare_report_syscall_entry(struct pt_regs *regs) { return 0; }
+void __weak arch_post_report_syscall_entry(struct pt_regs *regs, unsigned long saved_reg) { }
+void __weak arch_forget_syscall(struct pt_regs *regs) { };
+
 long syscall_trace_enter(struct pt_regs *regs, long syscall,
 				unsigned long work)
 {
+	unsigned long saved_reg;
 	long ret = 0;
 
 	/*
@@ -42,8 +47,13 @@ long syscall_trace_enter(struct pt_regs *regs, long syscall,
 
 	/* Handle ptrace */
 	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
+		saved_reg = arch_prepare_report_syscall_entry(regs);
 		ret = ptrace_report_syscall_entry(regs);
-		if (ret || (work & SYSCALL_WORK_SYSCALL_EMU))
+		if (ret)
+			arch_forget_syscall(regs);
+
+		arch_post_report_syscall_entry(regs, saved_reg);
+		if (ret || work & SYSCALL_WORK_SYSCALL_EMU)
 			return -1L;
 	}
 
@@ -138,7 +148,7 @@ __always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
  * SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
  * instruction has been already reported in syscall_enter_from_user_mode().
  */
-static inline bool report_single_step(unsigned long work)
+inline bool report_single_step(unsigned long work)
 {
 	if (work & SYSCALL_WORK_SYSCALL_EMU)
 		return false;
@@ -146,8 +156,22 @@ static inline bool report_single_step(unsigned long work)
 	return work & SYSCALL_WORK_SYSCALL_EXIT_TRAP;
 }
 
-static void syscall_exit_work(struct pt_regs *regs, unsigned long work)
+unsigned long __weak arch_prepare_report_syscall_exit(struct pt_regs *regs,
+						      unsigned long work)
+{
+	return 0;
+}
+
+void __weak arch_post_report_syscall_exit(struct pt_regs *regs,
+					  unsigned long saved_reg,
+					  unsigned long work)
+{
+
+}
+
+void syscall_exit_work(struct pt_regs *regs, unsigned long work)
 {
+	unsigned long saved_reg;
 	bool step;
 
 	/*
@@ -169,8 +193,11 @@ static void syscall_exit_work(struct pt_regs *regs, unsigned long work)
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
@@ -244,6 +271,8 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 		return ret;
 	}
 
+	arch_enter_from_kernel_mode(regs);
+
 	/*
 	 * If this entry hit the idle task invoke ct_irq_enter() whether
 	 * RCU is watching or not.
@@ -300,6 +329,8 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 	return ret;
 }
 
+bool __weak arch_irqentry_exit_need_resched(void) { return true; }
+
 void raw_irqentry_exit_cond_resched(void)
 {
 	if (!preempt_count()) {
@@ -307,7 +338,7 @@ void raw_irqentry_exit_cond_resched(void)
 		rcu_irq_exit_check_preempt();
 		if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
 			WARN_ON_ONCE(!on_thread_stack());
-		if (need_resched())
+		if (need_resched() && arch_irqentry_exit_need_resched())
 			preempt_schedule_irq();
 	}
 }
@@ -332,7 +363,12 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
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


