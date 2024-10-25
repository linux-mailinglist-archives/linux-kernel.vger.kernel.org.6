Return-Path: <linux-kernel+bounces-381479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 471339AFFBA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 061F6287F61
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D59A205E0F;
	Fri, 25 Oct 2024 10:09:02 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EF0205157
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850942; cv=none; b=MMx3fhi2A8kkkWmHEZnF11kcfq2iTJGG/CWEwSJg9wgYbFS1m2tTUaqTeRe09RTreOnW7D5o9lX9NE1EEw5vlfYwjMWKqapJY+VYVcF47WSVDwdDJNSYE+Dr800JAizJkDSDgSEO3QN/jTBtxRNJ4q/PT8RhYWvcfJYprVjmD2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850942; c=relaxed/simple;
	bh=46RExitV472pd59R1PjKmNcyBwRiPJfRlpxtPE0cMfY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oq6DtpN7KQ5nwn1cocEtZgiWd699jJl8I6TZE0p2fZkQ+BoeKHuYfJ+t8AjrRfeOqQ+Iv4w88gnUQbCGLLGp7+7Bi/oKS/J+I+DNDYQJchK8SGr1WG5+eiBTYbkszbRkS5sI+F/NmrFXPXsggLzPvYq0ZOn29X+/sB38qVgGV/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XZdjm2S6Hz1T8p8;
	Fri, 25 Oct 2024 18:06:52 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id 8ADF81800A5;
	Fri, 25 Oct 2024 18:08:56 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 25 Oct
 2024 18:08:54 +0800
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
Subject: [PATCH -next v4 17/19] entry: Add syscall arch functions to use generic syscall for arm64
Date: Fri, 25 Oct 2024 18:06:58 +0800
Message-ID: <20241025100700.3714552-18-ruanjinjie@huawei.com>
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

Add some syscall arch functions to support arm64 to use generic syscall
code, which do not affect existing architectures that use generic entry:

 - arch_pre/post_report_syscall_entry/exit().

Also make syscall_exit_work() not static and move report_single_step() to
thread_info.h, which can be used by arm64 later.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Suggested-by: Kevin Brodsky <kevin.brodsky@arm.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 include/linux/entry-common.h  |   1 +
 include/linux/thread_info.h   |  13 +++++
 kernel/entry/syscall-common.c | 100 ++++++++++++++++++++++++++++++----
 3 files changed, 103 insertions(+), 11 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 1ae3143d4b12..39a2d41af05e 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -178,4 +178,5 @@ void syscall_exit_to_user_mode_work(struct pt_regs *regs);
  */
 void syscall_exit_to_user_mode(struct pt_regs *regs);
 
+void syscall_exit_work(struct pt_regs *regs, unsigned long work);
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
diff --git a/kernel/entry/syscall-common.c b/kernel/entry/syscall-common.c
index 0eb036986ad4..73f87d09e04e 100644
--- a/kernel/entry/syscall-common.c
+++ b/kernel/entry/syscall-common.c
@@ -17,6 +17,49 @@ static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
 	}
 }
 
+/**
+ * arch_pre_report_syscall_entry - Architecture specific work before
+ *				   report_syscall_entry().
+ *
+ * Invoked from syscall_trace_enter() to prepare for ptrace_report_syscall_entry().
+ * Defaults to NOP.
+ *
+ * The main purpose is for saving a general purpose register clobbered
+ * in the tracee.
+ */
+static inline unsigned long arch_pre_report_syscall_entry(struct pt_regs *regs);
+
+#ifndef arch_pre_report_syscall_entry
+static inline unsigned long arch_pre_report_syscall_entry(struct pt_regs *regs)
+{
+	return 0;
+}
+#endif
+
+/**
+ * arch_post_report_syscall_entry - Architecture specific work after
+ *			            report_syscall_entry().
+ *
+ * Invoked from syscall_trace_enter() after calling ptrace_report_syscall_entry().
+ * Defaults to NOP.
+ *
+ * The main purpose is for restoring a general purpose register clobbered
+ * in the trace saved in arch_pre_report_syscall_entry(), also it can
+ * do something arch-specific according to the return value of
+ * ptrace_report_syscall_entry().
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
 long syscall_trace_enter(struct pt_regs *regs, long syscall,
 				unsigned long work)
 {
@@ -34,7 +77,9 @@ long syscall_trace_enter(struct pt_regs *regs, long syscall,
 
 	/* Handle ptrace */
 	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
+		unsigned long saved_reg = arch_pre_report_syscall_entry(regs);
 		ret = ptrace_report_syscall_entry(regs);
+		arch_post_report_syscall_entry(regs, saved_reg, ret);
 		if (ret || (work & SYSCALL_WORK_SYSCALL_EMU))
 			return -1L;
 	}
@@ -71,20 +116,50 @@ noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
 	instrumentation_end();
 }
 
-/*
- * If SYSCALL_EMU is set, then the only reason to report is when
- * SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
- * instruction has been already reported in syscall_enter_from_user_mode().
+/**
+ * arch_pre_report_syscall_exit - Architecture specific work before
+ *				  report_syscall_exit().
+ *
+ * Invoked from syscall_exit_work() to prepare for ptrace_report_syscall_exit().
+ * Defaults to NOP.
+ *
+ * The main purpose is for saving a general purpose register clobbered
+ * in the trace.
  */
-static inline bool report_single_step(unsigned long work)
-{
-	if (work & SYSCALL_WORK_SYSCALL_EMU)
-		return false;
+static inline unsigned long arch_pre_report_syscall_exit(struct pt_regs *regs,
+							     unsigned long work);
 
-	return work & SYSCALL_WORK_SYSCALL_EXIT_TRAP;
+#ifndef arch_pre_report_syscall_exit
+static inline unsigned long arch_pre_report_syscall_exit(struct pt_regs *regs,
+							     unsigned long work)
+{
+	return 0;
 }
+#endif
+
+/**
+ * arch_post_report_syscall_exit - Architecture specific work after
+ *			           report_syscall_exit().
+ *
+ * Invoked from syscall_exit_work() after calling ptrace_report_syscall_exit().
+ * Defaults to NOP.
+ *
+ * The main purpose is for restoring a general purpose register clobbered
+ * in the trace saved in arch_pre_report_syscall_exit().
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
 
-static void syscall_exit_work(struct pt_regs *regs, unsigned long work)
+void syscall_exit_work(struct pt_regs *regs, unsigned long work)
 {
 	bool step;
 
@@ -107,8 +182,11 @@ static void syscall_exit_work(struct pt_regs *regs, unsigned long work)
 		trace_sys_exit(regs, syscall_get_return_value(current, regs));
 
 	step = report_single_step(work);
-	if (step || work & SYSCALL_WORK_SYSCALL_TRACE)
+	if (step || work & SYSCALL_WORK_SYSCALL_TRACE) {
+		unsigned long saved_reg = arch_pre_report_syscall_exit(regs, work);
 		ptrace_report_syscall_exit(regs, step);
+		arch_post_report_syscall_exit(regs, saved_reg, work);
+	}
 }
 
 /*
-- 
2.34.1


