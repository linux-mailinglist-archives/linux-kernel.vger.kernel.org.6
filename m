Return-Path: <linux-kernel+bounces-231983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E754D91A11D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6455D1F22ACA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 08:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD5281727;
	Thu, 27 Jun 2024 08:09:39 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975176EB56
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 08:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719475778; cv=none; b=uWQRY2ZMl82nBN97TT4TXHcQRbK5tbUBRcA1hpYZYdsqsFIgdL5LkzAxYZ5Qlvex6g/HhAdZ7Mxci26CJoRaHsohq77vLxCBfZHic3YZafBFediPSuBSLmbE+FwRMTyaC8qvsM1lQzATPII/HliGLVvNNe3FNXtsJstXY9lTTfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719475778; c=relaxed/simple;
	bh=EgLKeT6641PYmctBh8JLWey9td+G6VxSXBqn082e0Nw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DrYhxWbfMuDQESj+urzXfxPClGkSpoCbXFkzdM+sDWphb2iVannDIZcZaQeZZqGeRlu/py/zVy1i0E97dwqBxOeiicM978+77ZS/0rVTUP9Hz0pONOV66TgTgVO8Zu0n6K+jGfZ2ZK35GOXirGIt9skijRXTwPQjQwTuZbekiEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4W8rhc0WWxz1T4Tr;
	Thu, 27 Jun 2024 16:05:04 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 5797918007E;
	Thu, 27 Jun 2024 16:09:29 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 27 Jun
 2024 16:09:28 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <luto@kernel.org>,
	<kees@kernel.org>, <wad@chromium.org>, <ruanjinjie@huawei.com>,
	<rostedt@goodmis.org>, <arnd@arndb.de>, <ardb@kernel.org>,
	<broonie@kernel.org>, <mark.rutland@arm.com>, <rick.p.edgecombe@intel.com>,
	<leobras@redhat.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 2/3] arm64: Prepare to switch to generic entry
Date: Thu, 27 Jun 2024 16:12:08 +0800
Message-ID: <20240627081209.3511918-3-ruanjinjie@huawei.com>
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

Prepare to switch to generic entry for arm64:

 - Implement regs_irqs_disabled() using interrupts_enabled() macro.

 - Make on_thread_stack() compatible with generic entry.

 - Split report_syscall() to report_syscall_enter() and
   report_syscall_exit() to make it clear to switch to generic entry.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2:
- Refactor report_syscall().
- Update the commit message.
---
 arch/arm64/include/asm/ptrace.h     |  5 +++++
 arch/arm64/include/asm/stacktrace.h |  5 ++++-
 arch/arm64/kernel/ptrace.c          | 29 ++++++++++++++++++++---------
 3 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 47ec58031f11..1857748ff017 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -360,6 +360,11 @@ static inline unsigned long regs_get_kernel_argument(struct pt_regs *regs,
 	return 0;
 }
 
+static inline int regs_irqs_disabled(struct pt_regs *regs)
+{
+	return !interrupts_enabled(regs);
+}
+
 /* We must avoid circular header include via sched.h */
 struct task_struct;
 int valid_user_regs(struct user_pt_regs *regs, struct task_struct *task);
diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index 66ec8caa6ac0..36bc1831f906 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -57,7 +57,10 @@ static inline bool on_task_stack(const struct task_struct *tsk,
 	return stackinfo_on_stack(&info, sp, size);
 }
 
-#define on_thread_stack()	(on_task_stack(current, current_stack_pointer, 1))
+static __always_inline bool on_thread_stack(void)
+{
+	return on_task_stack(current, current_stack_pointer, 1);
+}
 
 #ifdef CONFIG_VMAP_STACK
 DECLARE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack);
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 0d022599eb61..60fd85d5119d 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -2184,7 +2184,7 @@ enum ptrace_syscall_dir {
 	PTRACE_SYSCALL_EXIT,
 };
 
-static void report_syscall(struct pt_regs *regs, enum ptrace_syscall_dir dir)
+static void report_syscall_enter(struct pt_regs *regs)
 {
 	int regno;
 	unsigned long saved_reg;
@@ -2207,13 +2207,24 @@ static void report_syscall(struct pt_regs *regs, enum ptrace_syscall_dir dir)
 	 */
 	regno = (is_compat_task() ? 12 : 7);
 	saved_reg = regs->regs[regno];
-	regs->regs[regno] = dir;
+	regs->regs[regno] = PTRACE_SYSCALL_ENTER;
 
-	if (dir == PTRACE_SYSCALL_ENTER) {
-		if (ptrace_report_syscall_entry(regs))
-			forget_syscall(regs);
-		regs->regs[regno] = saved_reg;
-	} else if (!test_thread_flag(TIF_SINGLESTEP)) {
+	if (ptrace_report_syscall_entry(regs))
+		forget_syscall(regs);
+	regs->regs[regno] = saved_reg;
+}
+
+static void report_syscall_exit(struct pt_regs *regs)
+{
+	int regno;
+	unsigned long saved_reg;
+
+	/* See comment for report_syscall_enter() */
+	regno = (is_compat_task() ? 12 : 7);
+	saved_reg = regs->regs[regno];
+	regs->regs[regno] = PTRACE_SYSCALL_EXIT;
+
+	if (!test_thread_flag(TIF_SINGLESTEP)) {
 		ptrace_report_syscall_exit(regs, 0);
 		regs->regs[regno] = saved_reg;
 	} else {
@@ -2233,7 +2244,7 @@ int syscall_trace_enter(struct pt_regs *regs)
 	unsigned long flags = read_thread_flags();
 
 	if (flags & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE)) {
-		report_syscall(regs, PTRACE_SYSCALL_ENTER);
+		report_syscall_enter(regs);
 		if (flags & _TIF_SYSCALL_EMU)
 			return NO_SYSCALL;
 	}
@@ -2261,7 +2272,7 @@ void syscall_trace_exit(struct pt_regs *regs)
 		trace_sys_exit(regs, syscall_get_return_value(current, regs));
 
 	if (flags & (_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP))
-		report_syscall(regs, PTRACE_SYSCALL_EXIT);
+		report_syscall_exit(regs);
 
 	rseq_syscall(regs);
 }
-- 
2.34.1


