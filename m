Return-Path: <linux-kernel+bounces-381482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8E59AFFBE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F7551F25153
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C089206060;
	Fri, 25 Oct 2024 10:09:06 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60B61DD0CB
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850945; cv=none; b=ps3GbdF45ND8q6/P5Mova64ZWEX6pxlnPcP27JOclejzFPhiFmp2sipErsjR6QZPL/xtv5YM7sQEw1iWzftBMXGLiEytmladLplc6lkJC6YKd2pEqi8p4G/slZWJwMA1Cs5S+p+W+0//2zHQQByRP1wyoq7wLFClxGW3FZ9kqPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850945; c=relaxed/simple;
	bh=n0JOFGOTPnC4O0tJjAXj36qW/w2SrVqcqljKADOnDNk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IJpA+76kMDMlfLeTtultlBbyUTzRZ17ivNHy9CubqKJAZCNWNrAiACxF5yr8/8Oi8hs5KwjxC0DvgoUrqJXIIi8hUJcFC4iu++dPaOYuVDflCSHzQ++lnOXMxTPOPwQ6z38gSC0cg253V20E398I2dgG1eugFa6Wm4Guravc+Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XZdjq0g7Xz1T91t;
	Fri, 25 Oct 2024 18:06:55 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id 495EF1400E3;
	Fri, 25 Oct 2024 18:08:59 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 25 Oct
 2024 18:08:57 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <oleg@redhat.com>, <linux@armlinux.org.uk>, <will@kernel.org>,
	<mark.rutland@arm.com>, <catalin.marinas@arm.com>, <sstabellini@kernel.org>,
	<maz@kernel.org>, <tglx@linutronix.de>, <peterz@infradead.org>,
	<luto@kernel.org>, <kees@kernel.org>, <wad@chromium.org>,
	<akpm@linux-foundation.org>, <samitolvanen@google.com>, <arnd@arndb.de>,
	<ojeda@kernel.org>, <rppt@kernel.org>, <hca@linux.ibm.com>,
	<aliceryhl@google.com>, <samuel.holland@sifive.com>, <paulmck@kernel.org>,
	<aquini@redhat.com>, <petr.pavlu@suse.com>, <ruanjinjie@huawei.com>,
	<viro@zeniv.linux.org.uk>, <rmk+kernel@armlinux.org.uk>, <ardb@kernel.org>,
	<wangkefeng.wang@huawei.com>, <surenb@google.com>,
	<linus.walleij@linaro.org>, <yangyj.ee@gmail.com>, <broonie@kernel.org>,
	<mbenes@suse.cz>, <puranjay@kernel.org>, <pcc@google.com>,
	<guohanjun@huawei.com>, <sudeep.holla@arm.com>,
	<Jonathan.Cameron@huawei.com>, <prarit@redhat.com>, <liuwei09@cestc.cn>,
	<dwmw@amazon.co.uk>, <oliver.upton@linux.dev>, <kristina.martsenko@arm.com>,
	<ptosi@google.com>, <frederic@kernel.org>, <vschneid@redhat.com>,
	<thiago.bauermann@linaro.org>, <joey.gouly@arm.com>,
	<liuyuntao12@huawei.com>, <leobras@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<xen-devel@lists.xenproject.org>
Subject: [PATCH -next v4 19/19] arm64: entry: Convert to generic entry
Date: Fri, 25 Oct 2024 18:07:00 +0800
Message-ID: <20241025100700.3714552-20-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025100700.3714552-1-ruanjinjie@huawei.com>
References: <20241025100700.3714552-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg200008.china.huawei.com (7.202.181.35)

Currently, x86, Riscv, Loongarch use the generic entry. Convert arm64
to use the generic entry infrastructure from kernel/entry/*.
The generic entry makes maintainers' work easier and codes more elegant.

The changes are below:
 - Remove TIF_SYSCALL_* flag, _TIF_WORK_MASK, _TIF_SYSCALL_WORK
 - Remove syscall_trace_enter/exit() and use generic identical functions.

Tested ok with following test cases on Qemu cortex-a53 and HiSilicon
Kunpeng-920:
 - Perf tests.
 - Different `dynamic preempt` mode switch.
 - Pseudo NMI tests.
 - Stress-ng CPU stress test.
 - MTE test case in Documentation/arch/arm64/memory-tagging-extension.rst
   and all test cases in tools/testing/selftests/arm64/mte/* (Only Qemu).

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/Kconfig                    |   2 +-
 arch/arm64/include/asm/entry-common.h |  85 ++++++++++++++++++++++
 arch/arm64/include/asm/syscall.h      |   6 +-
 arch/arm64/include/asm/thread_info.h  |  23 +-----
 arch/arm64/kernel/ptrace.c            | 101 --------------------------
 arch/arm64/kernel/signal.c            |   2 +-
 arch/arm64/kernel/syscall.c           |  18 +++--
 7 files changed, 103 insertions(+), 134 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 4545017cfd01..89d46d0fb18b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -146,7 +146,7 @@ config ARM64
 	select GENERIC_CPU_DEVICES
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_EARLY_IOREMAP
-	select GENERIC_IRQ_ENTRY
+	select GENERIC_ENTRY
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IOREMAP
 	select GENERIC_IRQ_IPI
diff --git a/arch/arm64/include/asm/entry-common.h b/arch/arm64/include/asm/entry-common.h
index 1cc9d966a6c3..04a31b4fc4fd 100644
--- a/arch/arm64/include/asm/entry-common.h
+++ b/arch/arm64/include/asm/entry-common.h
@@ -10,6 +10,11 @@
 #include <asm/mte.h>
 #include <asm/stacktrace.h>
 
+enum ptrace_syscall_dir {
+	PTRACE_SYSCALL_ENTER = 0,
+	PTRACE_SYSCALL_EXIT,
+};
+
 #define ARCH_EXIT_TO_USER_MODE_WORK (_TIF_MTE_ASYNC_FAULT | _TIF_FOREIGN_FPSTATE)
 
 static __always_inline void arch_exit_to_user_mode_work(struct pt_regs *regs,
@@ -61,4 +66,84 @@ static inline bool arch_irqentry_exit_need_resched(void)
 
 #define arch_irqentry_exit_need_resched arch_irqentry_exit_need_resched
 
+static inline unsigned long arch_pre_report_syscall_entry(struct pt_regs *regs)
+{
+	unsigned long saved_reg;
+	int regno;
+
+	/*
+	 * We have some ABI weirdness here in the way that we handle syscall
+	 * exit stops because we indicate whether or not the stop has been
+	 * signalled from syscall entry or syscall exit by clobbering a general
+	 * purpose register (ip/r12 for AArch32, x7 for AArch64) in the tracee
+	 * and restoring its old value after the stop. This means that:
+	 *
+	 * - Any writes by the tracer to this register during the stop are
+	 *   ignored/discarded.
+	 *
+	 * - The actual value of the register is not available during the stop,
+	 *   so the tracer cannot save it and restore it later.
+	 *
+	 * - Syscall stops behave differently to seccomp and pseudo-step traps
+	 *   (the latter do not nobble any registers).
+	 */
+	regno = (is_compat_task() ? 12 : 7);
+	saved_reg = regs->regs[regno];
+	regs->regs[regno] = PTRACE_SYSCALL_ENTER;
+
+	return saved_reg;
+}
+
+#define arch_pre_report_syscall_entry arch_pre_report_syscall_entry
+
+static inline void arch_post_report_syscall_entry(struct pt_regs *regs,
+						  unsigned long saved_reg, long ret)
+{
+	int regno = (is_compat_task() ? 12 : 7);
+
+	if (ret)
+		forget_syscall(regs);
+
+	regs->regs[regno] = saved_reg;
+}
+
+#define arch_post_report_syscall_entry arch_post_report_syscall_entry
+
+static inline unsigned long arch_pre_report_syscall_exit(struct pt_regs *regs,
+							 unsigned long work)
+{
+	unsigned long saved_reg;
+	int regno;
+
+	/* See comment for arch_pre_report_syscall_entry() */
+	regno = (is_compat_task() ? 12 : 7);
+	saved_reg = regs->regs[regno];
+	regs->regs[regno] = PTRACE_SYSCALL_EXIT;
+
+	if (report_single_step(work)) {
+		/*
+		 * Signal a pseudo-step exception since we are stepping but
+		 * tracer modifications to the registers may have rewound the
+		 * state machine.
+		 */
+		regs->regs[regno] = saved_reg;
+	}
+
+	return saved_reg;
+}
+
+#define arch_pre_report_syscall_exit arch_pre_report_syscall_exit
+
+static inline void arch_post_report_syscall_exit(struct pt_regs *regs,
+						 unsigned long saved_reg,
+						 unsigned long work)
+{
+	int regno = (is_compat_task() ? 12 : 7);
+
+	if (!report_single_step(work))
+		regs->regs[regno] = saved_reg;
+}
+
+#define arch_post_report_syscall_exit arch_post_report_syscall_exit
+
 #endif /* _ASM_ARM64_ENTRY_COMMON_H */
diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index ab8e14b96f68..9891b15da4c3 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -85,7 +85,9 @@ static inline int syscall_get_arch(struct task_struct *task)
 	return AUDIT_ARCH_AARCH64;
 }
 
-int syscall_trace_enter(struct pt_regs *regs);
-void syscall_trace_exit(struct pt_regs *regs);
+static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
+{
+	return false;
+}
 
 #endif	/* __ASM_SYSCALL_H */
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 1114c1c3300a..543fdb00d713 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -43,6 +43,7 @@ struct thread_info {
 	void			*scs_sp;
 #endif
 	u32			cpu;
+	unsigned long		syscall_work;   /* SYSCALL_WORK_ flags */
 };
 
 #define thread_saved_pc(tsk)	\
@@ -64,11 +65,6 @@ void arch_setup_new_exec(void);
 #define TIF_UPROBE		4	/* uprobe breakpoint or singlestep */
 #define TIF_MTE_ASYNC_FAULT	5	/* MTE Asynchronous Tag Check Fault */
 #define TIF_NOTIFY_SIGNAL	6	/* signal notifications exist */
-#define TIF_SYSCALL_TRACE	8	/* syscall trace active */
-#define TIF_SYSCALL_AUDIT	9	/* syscall auditing */
-#define TIF_SYSCALL_TRACEPOINT	10	/* syscall tracepoint for ftrace */
-#define TIF_SECCOMP		11	/* syscall secure computing */
-#define TIF_SYSCALL_EMU		12	/* syscall emulation active */
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
 #define TIF_FREEZE		19
 #define TIF_RESTORE_SIGMASK	20
@@ -87,28 +83,13 @@ void arch_setup_new_exec(void);
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_FOREIGN_FPSTATE	(1 << TIF_FOREIGN_FPSTATE)
-#define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
-#define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
-#define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
-#define _TIF_SECCOMP		(1 << TIF_SECCOMP)
-#define _TIF_SYSCALL_EMU	(1 << TIF_SYSCALL_EMU)
-#define _TIF_UPROBE		(1 << TIF_UPROBE)
-#define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
+#define _TIF_UPROBE            (1 << TIF_UPROBE)
 #define _TIF_32BIT		(1 << TIF_32BIT)
 #define _TIF_SVE		(1 << TIF_SVE)
 #define _TIF_MTE_ASYNC_FAULT	(1 << TIF_MTE_ASYNC_FAULT)
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 #define _TIF_TSC_SIGSEGV	(1 << TIF_TSC_SIGSEGV)
 
-#define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
-				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
-				 _TIF_UPROBE | _TIF_MTE_ASYNC_FAULT | \
-				 _TIF_NOTIFY_SIGNAL)
-
-#define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
-				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
-				 _TIF_SYSCALL_EMU)
-
 #ifdef CONFIG_SHADOW_CALL_STACK
 #define INIT_SCS							\
 	.scs_base	= init_shadow_call_stack,			\
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 6ea303ab9e22..0f642ed4dbe4 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -42,9 +42,6 @@
 #include <asm/traps.h>
 #include <asm/system_misc.h>
 
-#define CREATE_TRACE_POINTS
-#include <trace/events/syscalls.h>
-
 struct pt_regs_offset {
 	const char *name;
 	int offset;
@@ -2285,104 +2282,6 @@ long arch_ptrace(struct task_struct *child, long request,
 	return ptrace_request(child, request, addr, data);
 }
 
-enum ptrace_syscall_dir {
-	PTRACE_SYSCALL_ENTER = 0,
-	PTRACE_SYSCALL_EXIT,
-};
-
-static void report_syscall_enter(struct pt_regs *regs)
-{
-	int regno;
-	unsigned long saved_reg;
-
-	/*
-	 * We have some ABI weirdness here in the way that we handle syscall
-	 * exit stops because we indicate whether or not the stop has been
-	 * signalled from syscall entry or syscall exit by clobbering a general
-	 * purpose register (ip/r12 for AArch32, x7 for AArch64) in the tracee
-	 * and restoring its old value after the stop. This means that:
-	 *
-	 * - Any writes by the tracer to this register during the stop are
-	 *   ignored/discarded.
-	 *
-	 * - The actual value of the register is not available during the stop,
-	 *   so the tracer cannot save it and restore it later.
-	 *
-	 * - Syscall stops behave differently to seccomp and pseudo-step traps
-	 *   (the latter do not nobble any registers).
-	 */
-	regno = (is_compat_task() ? 12 : 7);
-	saved_reg = regs->regs[regno];
-	regs->regs[regno] = PTRACE_SYSCALL_ENTER;
-
-	if (ptrace_report_syscall_entry(regs))
-		forget_syscall(regs);
-	regs->regs[regno] = saved_reg;
-}
-
-static void report_syscall_exit(struct pt_regs *regs)
-{
-	int regno;
-	unsigned long saved_reg;
-
-	/* See comment for report_syscall_enter() */
-	regno = (is_compat_task() ? 12 : 7);
-	saved_reg = regs->regs[regno];
-	regs->regs[regno] = PTRACE_SYSCALL_EXIT;
-
-	if (!test_thread_flag(TIF_SINGLESTEP)) {
-		ptrace_report_syscall_exit(regs, 0);
-		regs->regs[regno] = saved_reg;
-	} else {
-		regs->regs[regno] = saved_reg;
-
-		/*
-		 * Signal a pseudo-step exception since we are stepping but
-		 * tracer modifications to the registers may have rewound the
-		 * state machine.
-		 */
-		ptrace_report_syscall_exit(regs, 1);
-	}
-}
-
-int syscall_trace_enter(struct pt_regs *regs)
-{
-	unsigned long flags = read_thread_flags();
-
-	if (flags & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE)) {
-		report_syscall_enter(regs);
-		if (flags & _TIF_SYSCALL_EMU)
-			return NO_SYSCALL;
-	}
-
-	/* Do the secure computing after ptrace; failures should be fast. */
-	if (secure_computing() == -1)
-		return NO_SYSCALL;
-
-	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
-		trace_sys_enter(regs, regs->syscallno);
-
-	audit_syscall_entry(regs->syscallno, regs->orig_x0, regs->regs[1],
-			    regs->regs[2], regs->regs[3]);
-
-	return regs->syscallno;
-}
-
-void syscall_trace_exit(struct pt_regs *regs)
-{
-	unsigned long flags = read_thread_flags();
-
-	audit_syscall_exit(regs);
-
-	if (flags & _TIF_SYSCALL_TRACEPOINT)
-		trace_sys_exit(regs, syscall_get_return_value(current, regs));
-
-	if (flags & (_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP))
-		report_syscall_exit(regs);
-
-	rseq_syscall(regs);
-}
-
 /*
  * SPSR_ELx bits which are always architecturally RES0 per ARM DDI 0487D.a.
  * We permit userspace to set SSBS (AArch64 bit 12, AArch32 bit 23) which is
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 04b20c2f6cda..4965cb80e67e 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -8,8 +8,8 @@
 
 #include <linux/cache.h>
 #include <linux/compat.h>
+#include <linux/entry-common.h>
 #include <linux/errno.h>
-#include <linux/irq-entry-common.h>
 #include <linux/kernel.h>
 #include <linux/signal.h>
 #include <linux/freezer.h>
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index c442fcec6b9e..ea818e3d597b 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -2,6 +2,7 @@
 
 #include <linux/compiler.h>
 #include <linux/context_tracking.h>
+#include <linux/entry-common.h>
 #include <linux/errno.h>
 #include <linux/nospec.h>
 #include <linux/ptrace.h>
@@ -65,14 +66,15 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
 	choose_random_kstack_offset(get_random_u16());
 }
 
-static inline bool has_syscall_work(unsigned long flags)
+static inline bool has_syscall_work(unsigned long work)
 {
-	return unlikely(flags & _TIF_SYSCALL_WORK);
+	return unlikely(work & SYSCALL_WORK_ENTER);
 }
 
 static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 			   const syscall_fn_t syscall_table[])
 {
+	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
 	unsigned long flags = read_thread_flags();
 
 	regs->orig_x0 = regs->regs[0];
@@ -106,7 +108,7 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 		return;
 	}
 
-	if (has_syscall_work(flags)) {
+	if (has_syscall_work(work)) {
 		/*
 		 * The de-facto standard way to skip a system call using ptrace
 		 * is to set the system call to -1 (NO_SYSCALL) and set x0 to a
@@ -124,7 +126,7 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 		 */
 		if (scno == NO_SYSCALL)
 			syscall_set_return_value(current, regs, -ENOSYS, 0);
-		scno = syscall_trace_enter(regs);
+		scno = syscall_trace_enter(regs, regs->syscallno, work);
 		if (scno == NO_SYSCALL)
 			goto trace_exit;
 	}
@@ -136,14 +138,14 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 	 * check again. However, if we were tracing entry, then we always trace
 	 * exit regardless, as the old entry assembly did.
 	 */
-	if (!has_syscall_work(flags) && !IS_ENABLED(CONFIG_DEBUG_RSEQ)) {
-		flags = read_thread_flags();
-		if (!has_syscall_work(flags) && !(flags & _TIF_SINGLESTEP))
+	if (!has_syscall_work(work) && !IS_ENABLED(CONFIG_DEBUG_RSEQ)) {
+		work = READ_ONCE(current_thread_info()->syscall_work);
+		if (!has_syscall_work(work) && !report_single_step(work))
 			return;
 	}
 
 trace_exit:
-	syscall_trace_exit(regs);
+	syscall_exit_work(regs, work);
 }
 
 void do_el0_svc(struct pt_regs *regs)
-- 
2.34.1


