Return-Path: <linux-kernel+bounces-258733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F372938C37
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 448CF281CC5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33C516D319;
	Mon, 22 Jul 2024 09:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="eOIwzr6x"
Received: from smtpout43.security-mail.net (smtpout43.security-mail.net [85.31.212.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D32516C87F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.31.212.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641416; cv=none; b=bDiZ4AhuqUDVez7NEjufwLRvX3fdSiFoFJNeyCNayJFM8UJr0tejSwtZKr2JXXgUoBIJCFP3IaYov1PTAdAoq3SwH3sftEEbKW7USlWPd5LQ91Lv8bj15M2UQNR7FuK5LUI34RnqB8QBTm0zau1Bw03rte9nZe8n/iiWjfhRdUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641416; c=relaxed/simple;
	bh=UcCsqCyIJf3Irw5xvHzO1XtqpQa7ACfzmsz56nw050M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c99dVx6s+40oWcaN7FH1o4pJ9AoRXLvC8i59sIDZoM8TtxpOCeJ/ZchBdfCqYO9twKtldv4BxDPtU1A3+aBy3gPfxxcH+tza8VzLy8eu106dUZkc9LMy7s80/v0fctqI7rpObcThzcPv6JqbhYXQXS1x97HFsOGODfxNX/qUff0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=eOIwzr6x; arc=none smtp.client-ip=85.31.212.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx303.security-mail.net [127.0.0.1])
	by fx303.security-mail.net (Postfix) with ESMTP id C179A30ED87
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:43:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1721641412;
	bh=UcCsqCyIJf3Irw5xvHzO1XtqpQa7ACfzmsz56nw050M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eOIwzr6xNTbmS+EEnYhlkmwRJORMkHosHjjnrQFf+cSxg4lMy/lQq5GdNSWTJrcnI
	 YrhQ5z26z56nUjhk7cbB40wIb2mvG7Bmc2LDQfXWGJ5EXWpmow/f51f383QlhXnGzL
	 F6M3bY5NZyrPI3sBEEbzqWwD9fvlRpPv4oB+Wnrc=
Received: from fx303 (fx303.security-mail.net [127.0.0.1]) by
 fx303.security-mail.net (Postfix) with ESMTP id 8CADC30EBEE; Mon, 22 Jul
 2024 11:43:32 +0200 (CEST)
Received: from srvsmtp.lin.mbt.kalray.eu (unknown [217.181.231.53]) by
 fx303.security-mail.net (Postfix) with ESMTPS id CE5D430EB14; Mon, 22 Jul
 2024 11:43:31 +0200 (CEST)
Received: from junon.lan.kalrayinc.com (unknown [192.168.37.161]) by
 srvsmtp.lin.mbt.kalray.eu (Postfix) with ESMTPS id 9993640317; Mon, 22 Jul
 2024 11:43:31 +0200 (CEST)
X-Secumail-id: <16424.669e29c3.cb630.0>
From: ysionneau@kalrayinc.com
To: linux-kernel@vger.kernel.org
Cc: Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Yann Sionneau <ysionneau@kalrayinc.com>, Clement
 Leger <clement@clement-leger.fr>, Guillaume Thouvenin <thouveng@gmail.com>,
 Luc Michel <luc@lmichel.fr>, Marius Gligor <mgligor@kalrayinc.com>
Subject: [RFC PATCH v3 18/37] kvx: Add exception/interrupt handling
Date: Mon, 22 Jul 2024 11:41:29 +0200
Message-ID: <20240722094226.21602-19-ysionneau@kalrayinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722094226.21602-1-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

From: Yann Sionneau <ysionneau@kalrayinc.com>

Add the exception and interrupt handling machanism for basic kvx
support.

Co-developed-by: Clement Leger <clement@clement-leger.fr>
Signed-off-by: Clement Leger <clement@clement-leger.fr>
Co-developed-by: Guillaume Thouvenin <thouveng@gmail.com>
Signed-off-by: Guillaume Thouvenin <thouveng@gmail.com>
Co-developed-by: Julian Vetter <jvetter@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
Co-developed-by: Luc Michel <luc@lmichel.fr>
Signed-off-by: Luc Michel <luc@lmichel.fr>
Co-developed-by: Marius Gligor <mgligor@kalrayinc.com>
Signed-off-by: Marius Gligor <mgligor@kalrayinc.com>
Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
---

Notes:
V1 -> V2: removed ipi.h headers and driver
V2 -> V3:
- Use generic entry/exit for exception routines:
  - adapt struct pt_regs arguments order for gen. entry
  - arch_enter_from_user_mode/arch_exit_to_user_mode_prepare:
    - use generic entry hooks for dame irq checks
  - introduce do_debug, do_syscall, do_hwtrap
- remove do_IRQ and use generic_handle_arch_irq instead
- add cpu.c containing kvx_of_parent_cpuid()
  - needed by core_intc driver
- typos
---
 arch/kvx/include/asm/break_hook.h   |  69 +++++++
 arch/kvx/include/asm/bug.h          |  67 +++++++
 arch/kvx/include/asm/entry-common.h |  52 ++++++
 arch/kvx/include/asm/hw_irq.h       |  14 ++
 arch/kvx/include/asm/irqflags.h     |  58 ++++++
 arch/kvx/include/asm/stacktrace.h   |  46 +++++
 arch/kvx/include/asm/traps.h        |  79 ++++++++
 arch/kvx/kernel/cpu.c               |  24 +++
 arch/kvx/kernel/dame_handler.c      | 113 +++++++++++
 arch/kvx/kernel/irq.c               |  52 ++++++
 arch/kvx/kernel/traps.c             | 278 ++++++++++++++++++++++++++++
 11 files changed, 852 insertions(+)
 create mode 100644 arch/kvx/include/asm/break_hook.h
 create mode 100644 arch/kvx/include/asm/bug.h
 create mode 100644 arch/kvx/include/asm/entry-common.h
 create mode 100644 arch/kvx/include/asm/hw_irq.h
 create mode 100644 arch/kvx/include/asm/irqflags.h
 create mode 100644 arch/kvx/include/asm/stacktrace.h
 create mode 100644 arch/kvx/include/asm/traps.h
 create mode 100644 arch/kvx/kernel/cpu.c
 create mode 100644 arch/kvx/kernel/dame_handler.c
 create mode 100644 arch/kvx/kernel/irq.c
 create mode 100644 arch/kvx/kernel/traps.c

diff --git a/arch/kvx/include/asm/break_hook.h b/arch/kvx/include/asm/break_hook.h
new file mode 100644
index 0000000000000..011441b0076a0
--- /dev/null
+++ b/arch/kvx/include/asm/break_hook.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef __ASM_KVX_BREAK_HOOK_H_
+#define __ASM_KVX_BREAK_HOOK_H_
+
+#include <linux/types.h>
+
+#include <asm/sfr_defs.h>
+#include <asm/insns_defs.h>
+
+/*
+ * The following macros define the different causes of break:
+ * We use the `set $vsfr0 = $rXX` instruction which will raise a trap into the
+ * debugger. The trapping instruction is read and decoded to extract the source
+ * register number. The source register number is used to differentiate the
+ * trap cause.
+ */
+#define BREAK_CAUSE_BUG		KVX_REG_R1
+#define BREAK_CAUSE_KGDB_DYN	KVX_REG_R2
+#define BREAK_CAUSE_KGDB_COMP	KVX_REG_R3
+#define BREAK_CAUSE_BKPT	KVX_REG_R63
+
+/**
+ * enum break_ret - Break return value
+ * @BREAK_HOOK_HANDLED: Hook handled successfully
+ * @BREAK_HOOK_ERROR: Hook was not handled
+ */
+enum break_ret {
+	BREAK_HOOK_HANDLED = 0,
+	BREAK_HOOK_ERROR = 1,
+};
+
+/*
+ * The following macro assembles a `set` instruction targeting $vsfr0
+ * using the source register whose number is __id.
+ */
+#define KVX_BREAK_INSN(__id) \
+	KVX_INSN_SET_SYLLABLE_0(KVX_INSN_PARALLEL_EOB, KVX_SFR_VSFR0, __id)
+
+#define KVX_BREAK_INSN_SIZE (KVX_INSN_SET_SIZE * KVX_INSN_SYLLABLE_WIDTH)
+
+struct pt_regs;
+
+/**
+ * struct break_hook - Break hook description
+ * @node: List node
+ * @handler: handler called when break matches this hook
+ * @imm: Immediate value expected for break insn
+ * @mode: Hook mode (user/kernel)
+ */
+struct break_hook {
+	struct list_head node;
+	int (*handler)(struct pt_regs *regs, struct break_hook *brk_hook);
+	u8 id;
+	u8 mode;
+};
+
+void kvx_skip_break_insn(struct pt_regs *regs);
+
+void break_hook_register(struct break_hook *brk_hook);
+void break_hook_unregister(struct break_hook *brk_hook);
+
+int break_hook_handler(struct pt_regs *regs, u64 es);
+
+#endif /* __ASM_KVX_BREAK_HOOK_H_ */
diff --git a/arch/kvx/include/asm/bug.h b/arch/kvx/include/asm/bug.h
new file mode 100644
index 0000000000000..62f556b00d5a2
--- /dev/null
+++ b/arch/kvx/include/asm/bug.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_BUG_H
+#define _ASM_KVX_BUG_H
+
+#include <linux/compiler.h>
+#include <linux/const.h>
+#include <linux/types.h>
+
+#include <asm/break_hook.h>
+
+#ifdef CONFIG_GENERIC_BUG
+
+#define BUG_INSN	KVX_BREAK_INSN(BREAK_CAUSE_BUG)
+
+#define __BUG_ENTRY_ADDR	".dword 1b"
+
+#ifdef CONFIG_DEBUG_BUGVERBOSE
+#define __BUG_ENTRY_LAST_MEMBER		flags
+#define __BUG_ENTRY			\
+	__BUG_ENTRY_ADDR "\n\t"		\
+	".dword %0\n\t"			\
+	".short %1\n\t"
+#else
+#define __BUG_ENTRY_LAST_MEMBER		file
+#define __BUG_ENTRY			\
+	__BUG_ENTRY_ADDR "\n\t"
+#endif
+
+#define BUG()							\
+do {								\
+	__asm__ __volatile__ (					\
+		"1:\n\t"					\
+			".word " __stringify(BUG_INSN) "\n"	\
+			".pushsection __bug_table,\"a\"\n\t"	\
+		"2:\n\t"					\
+			__BUG_ENTRY				\
+			".fill 1, %2, 0\n\t"			\
+			".popsection"				\
+		:						\
+		: "i" (__FILE__), "i" (__LINE__),		\
+		  "i" (sizeof(struct bug_entry) -		\
+		  offsetof(struct bug_entry, __BUG_ENTRY_LAST_MEMBER))); \
+	unreachable();						\
+} while (0)
+
+#else /* CONFIG_GENERIC_BUG */
+#define BUG()								\
+do {									\
+	__asm__ __volatile__ (".word " __stringify(BUG_INSN) "\n");	\
+	unreachable();							\
+} while (0)
+#endif /* CONFIG_GENERIC_BUG */
+
+#define HAVE_ARCH_BUG
+
+struct pt_regs;
+
+void die(struct pt_regs *regs, unsigned long ea, const char *str);
+
+#include <asm-generic/bug.h>
+
+#endif /* _ASM_KVX_BUG_H */
diff --git a/arch/kvx/include/asm/entry-common.h b/arch/kvx/include/asm/entry-common.h
new file mode 100644
index 0000000000000..8c4b6d3241391
--- /dev/null
+++ b/arch/kvx/include/asm/entry-common.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Julian Vetter
+ */
+#ifndef _ASM_KVX_ENTRY_COMMON_H
+#define _ASM_KVX_ENTRY_COMMON_H
+
+#include <asm/sfr.h>
+#include <asm/stacktrace.h>
+
+static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs)
+{
+	unsigned long ilr;
+
+	/*
+	 * Make sure DAMEs trigged by user space are reflected in $ILR
+	 * (interrupts pending) bits
+	 */
+	__builtin_kvx_barrier();
+
+	ilr = kvx_sfr_get(ILR);
+
+	if (ilr & KVX_SFR_ILR_IT16_MASK) {
+		if (user_mode(regs))
+			force_sig_fault(SIGBUS, BUS_ADRERR,
+					(void __user *) NULL);
+		else
+			panic("DAME error encountered while in kernel!\n");
+	}
+}
+
+#define arch_enter_from_user_mode arch_enter_from_user_mode
+
+static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
+						  unsigned long ti_work)
+{
+	unsigned long ilr;
+
+	__builtin_kvx_barrier();
+
+	ilr = kvx_sfr_get(ILR);
+
+	if (ilr & KVX_SFR_ILR_IT16_MASK)
+		panic("DAME error encountered while in kernel!\n");
+}
+
+#define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
+
+#define on_thread_stack()	(on_task_stack(current, current_stack_pointer))
+
+#endif /* _ASM_KVX_ENTRY_COMMON_H */
diff --git a/arch/kvx/include/asm/hw_irq.h b/arch/kvx/include/asm/hw_irq.h
new file mode 100644
index 0000000000000..f073dba3b1c54
--- /dev/null
+++ b/arch/kvx/include/asm/hw_irq.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * derived from arch/mips/include/asm/ide.h
+ *
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_HW_IRQ_H
+#define _ASM_KVX_HW_IRQ_H
+
+void kvx_init_core_irq(void);
+
+#endif	/* _ASM_KVX_HW_IRQ_H */
diff --git a/arch/kvx/include/asm/irqflags.h b/arch/kvx/include/asm/irqflags.h
new file mode 100644
index 0000000000000..681c890b3fcdf
--- /dev/null
+++ b/arch/kvx/include/asm/irqflags.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_IRQFLAGS_H
+#define _ASM_KVX_IRQFLAGS_H
+
+#include <linux/types.h>
+
+#include <asm/sfr.h>
+
+static inline notrace unsigned long arch_local_save_flags(void)
+{
+	return kvx_sfr_get(PS) & (1 << KVX_SFR_PS_IE_SHIFT);
+}
+
+static inline notrace unsigned long arch_local_irq_save(void)
+{
+	unsigned long flags = arch_local_save_flags();
+
+	kvx_sfr_set_field(PS, IE, 0);
+
+	return flags;
+}
+
+static inline notrace void arch_local_irq_restore(unsigned long flags)
+{
+	/* If flags are set, interrupt are enabled), set the IE bit */
+	if (flags)
+		kvx_sfr_set_field(PS, IE, 1);
+	else
+		kvx_sfr_set_field(PS, IE, 0);
+}
+
+static inline notrace void arch_local_irq_enable(void)
+{
+	kvx_sfr_set_field(PS, IE, 1);
+}
+
+static inline notrace void arch_local_irq_disable(void)
+{
+	kvx_sfr_set_field(PS, IE, 0);
+}
+
+static inline notrace bool arch_irqs_disabled_flags(unsigned long flags)
+{
+	return (flags & (1 << KVX_SFR_PS_IE_SHIFT)) == 0;
+}
+
+static inline notrace bool arch_irqs_disabled(void)
+{
+	return arch_irqs_disabled_flags(kvx_sfr_get(PS));
+}
+
+
+#endif	/* _ASM_KVX_IRQFLAGS_H */
diff --git a/arch/kvx/include/asm/stacktrace.h b/arch/kvx/include/asm/stacktrace.h
new file mode 100644
index 0000000000000..75112e733ebd4
--- /dev/null
+++ b/arch/kvx/include/asm/stacktrace.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_STACKTRACE_H
+#define _ASM_KVX_STACKTRACE_H
+
+#include <linux/sched/task_stack.h>
+
+/**
+ * Structure of a frame on the stack
+ */
+struct stackframe {
+	unsigned long fp;	/* Next frame pointer */
+	unsigned long ra;	/* Return address */
+};
+
+static inline bool on_task_stack(struct task_struct *tsk, unsigned long sp)
+{
+	unsigned long low = (unsigned long) task_stack_page(tsk);
+	unsigned long high = low + THREAD_SIZE;
+
+	if (sp < low || sp >= high)
+		return false;
+
+	return true;
+}
+
+void show_stacktrace(struct task_struct *task, struct pt_regs *regs,
+		     const char *loglvl);
+
+
+void walk_stackframe(struct task_struct *task, struct stackframe *frame,
+		     bool (*fn)(unsigned long, void *, const char *), void *arg,
+		     const char *loglvl);
+
+static inline void start_stackframe(struct stackframe *frame,
+				    unsigned long fp,
+				    unsigned long pc)
+{
+	frame->fp = fp;
+	frame->ra = pc;
+}
+#endif /* _ASM_KVX_STACKTRACE_H */
diff --git a/arch/kvx/include/asm/traps.h b/arch/kvx/include/asm/traps.h
new file mode 100644
index 0000000000000..7d59bade058f2
--- /dev/null
+++ b/arch/kvx/include/asm/traps.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Guillaume Thouvenin
+ *            Marius Gligor
+ */
+
+#ifndef _ASM_KVX_TRAPS_H
+#define _ASM_KVX_TRAPS_H
+
+#include <asm/sfr.h>
+
+#define KVX_TRAP_RESET          0x0
+#define KVX_TRAP_OPCODE         0x1
+#define KVX_TRAP_PRIVILEGE      0x2
+#define KVX_TRAP_DMISALIGN      0x3
+#define KVX_TRAP_PSYSERROR      0x4
+#define KVX_TRAP_DSYSERROR      0x5
+#define KVX_TRAP_PDECCERROR     0x6
+#define KVX_TRAP_DDECCERROR     0x7
+#define KVX_TRAP_PPARERROR      0x8
+#define KVX_TRAP_DPARERROR      0x9
+#define KVX_TRAP_PSECERROR      0xA
+#define KVX_TRAP_DSECERROR      0xB
+#define KVX_TRAP_NOMAPPING      0xC
+#define KVX_TRAP_PROTECTION     0xD
+#define KVX_TRAP_WRITETOCLEAN   0xE
+#define KVX_TRAP_ATOMICTOCLEAN  0xF
+#define KVX_TRAP_TPAR           0x10
+#define KVX_TRAP_DOUBLE_ECC     0x11
+#define KVX_TRAP_VSFR           0x12
+#define KVX_TRAP_PL_OVERFLOW    0x13
+
+#define KVX_TRAP_COUNT          0x14
+
+#define KVX_TRAP_SFRI_NOT_BCU	0
+#define KVX_TRAP_SFRI_GET	1
+#define KVX_TRAP_SFRI_IGET	2
+#define KVX_TRAP_SFRI_SET	4
+#define KVX_TRAP_SFRI_WFXL	5
+#define KVX_TRAP_SFRI_WFXM	6
+#define KVX_TRAP_SFRI_RSWAP	7
+
+/* Access type on memory trap */
+#define KVX_TRAP_RWX_FETCH	1
+#define KVX_TRAP_RWX_WRITE	2
+#define KVX_TRAP_RWX_READ	4
+#define KVX_TRAP_RWX_ATOMIC	6
+
+#ifndef __ASSEMBLY__
+
+typedef void (*trap_handler_func) (struct pt_regs *regs, uint64_t es,
+				   uint64_t ea);
+
+#define trap_cause(__es) kvx_sfr_field_val(__es, ES, HTC)
+
+#define trap_sfri(__es) \
+	kvx_sfr_field_val((__es), ES, SFRI)
+
+#define trap_gprp(__es) \
+	kvx_sfr_field_val((__es), ES, GPRP)
+
+#define trap_sfrp(__es) \
+	kvx_sfr_field_val((__es), ES, SFRP)
+
+#ifdef CONFIG_MMU
+extern void do_page_fault(struct pt_regs *regs, uint64_t es, uint64_t ea);
+extern void do_writetoclean(struct pt_regs *regs, uint64_t es, uint64_t ea);
+#endif
+
+void user_do_sig(struct pt_regs *regs, int signo, int code, unsigned long addr);
+void do_debug(struct pt_regs *regs, u64 ea);
+void do_hwtrap(struct pt_regs *regs, uint64_t es, uint64_t ea);
+void do_syscall(struct pt_regs *regs);
+
+#endif /* __ASSEMBLY__ */
+
+#endif
diff --git a/arch/kvx/kernel/cpu.c b/arch/kvx/kernel/cpu.c
new file mode 100644
index 0000000000000..b8412be1e4134
--- /dev/null
+++ b/arch/kvx/kernel/cpu.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Kalray Inc.
+ * Author(s): Yann Sionneau
+ */
+
+#include <linux/of.h>
+#include <linux/processor.h>
+
+int kvx_of_parent_cpuid(struct device_node *node, unsigned long *cpuid)
+{
+	for (; node; node = node->parent) {
+		if (of_device_is_compatible(node, "kalray,kv3-pe")) {
+			*cpuid = (unsigned long)of_get_cpu_hwid(node, 0);
+			if (*cpuid == ~0UL) {
+				pr_warn("Found CPU without CPU ID\n");
+				return -ENODEV;
+			}
+			return 0;
+		}
+	}
+
+	return -1;
+}
diff --git a/arch/kvx/kernel/dame_handler.c b/arch/kvx/kernel/dame_handler.c
new file mode 100644
index 0000000000000..ce190bee82113
--- /dev/null
+++ b/arch/kvx/kernel/dame_handler.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#include <linux/of.h>
+#include <linux/bug.h>
+#include <linux/init.h>
+#include <linux/of_irq.h>
+#include <linux/hardirq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/interrupt.h>
+#include <linux/cpuhotplug.h>
+#include <linux/sched/signal.h>
+
+static unsigned int kvx_dame_irq;
+
+static const char *error_str[KVX_SFR_ES_ITI_WIDTH] = {
+	"PSE",
+	"PILSY",
+	"PILDE",
+	"PILPA",
+	"DSE",
+	"DILSY",
+	"DILDE",
+	"DILPA",
+	"DDEE",
+	"DSYE"
+};
+
+static irqreturn_t dame_irq_handler(int irq, void *dev_id)
+{
+	int bit;
+	struct pt_regs *regs = get_irq_regs();
+	unsigned long error_status = kvx_sfr_field_val(regs->es, ES, ITI);
+
+	if (error_status) {
+		pr_err("Memory Error:\n");
+		for_each_set_bit(bit, &error_status, KVX_SFR_ES_ITI_WIDTH)
+			pr_err("- %s\n", error_str[bit]);
+	}
+
+	/*
+	 * If the DAME happened in user mode, we can handle it properly
+	 * by killing the user process.
+	 * Otherwise, if we are in kernel, we are fried...
+	 */
+	if (user_mode(regs))
+		force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *) NULL);
+	else
+		die(regs, 0, "DAME error encountered while in kernel !!!!\n");
+
+	return IRQ_HANDLED;
+}
+
+static int kvx_dame_starting_cpu(unsigned int cpu)
+{
+	enable_percpu_irq(kvx_dame_irq, IRQ_TYPE_NONE);
+
+	return 0;
+}
+
+static int kvx_dame_dying_cpu(unsigned int cpu)
+{
+	disable_percpu_irq(kvx_dame_irq);
+
+	return 0;
+}
+
+static int __init dame_handler_init(void)
+{
+	struct device_node *dame_node;
+	int ret;
+
+	dame_node = of_find_compatible_node(NULL, NULL,
+					    "kalray,kvx-dame-handler");
+	if (!dame_node) {
+		pr_err("Failed to find dame handler device tree node\n");
+		return -ENODEV;
+	}
+
+	kvx_dame_irq = irq_of_parse_and_map(dame_node, 0);
+	of_node_put(dame_node);
+
+	if (!kvx_dame_irq) {
+		pr_err("Failed to parse dame irq\n");
+		return -ENODEV;
+	}
+
+	ret = request_percpu_irq(kvx_dame_irq, dame_irq_handler, "dame",
+				 &kvx_dame_irq);
+	if (ret) {
+		pr_err("Failed to request dame irq\n");
+		return -ENODEV;
+	}
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+				"kvx/dame_handler:online",
+				kvx_dame_starting_cpu,
+				kvx_dame_dying_cpu);
+	if (ret <= 0) {
+		pr_err("Failed to setup cpuhp\n");
+		return ret;
+	}
+
+	pr_info("DAME handler registered\n");
+
+	return 0;
+}
+
+core_initcall(dame_handler_init);
diff --git a/arch/kvx/kernel/irq.c b/arch/kvx/kernel/irq.c
new file mode 100644
index 0000000000000..f0f243eb20130
--- /dev/null
+++ b/arch/kvx/kernel/irq.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#include <linux/irqdomain.h>
+#include <linux/irqflags.h>
+#include <linux/irqchip.h>
+#include <linux/bitops.h>
+#include <linux/init.h>
+
+#define IT_MASK(__it) (KVX_SFR_ILL_ ## __it ## _MASK)
+#define IT_LEVEL(__it, __level) \
+	(__level##ULL << KVX_SFR_ILL_ ## __it ## _SHIFT)
+
+/*
+ * Early Hardware specific Interrupt setup
+ * - Called very early (start_kernel -> setup_arch -> setup_processor)
+ * - Needed for each CPU
+ */
+void kvx_init_core_irq(void)
+{
+	/*
+	 * On KVX, the kernel only cares about the following ITs:
+	 * - IT0: Timer 0
+	 * - IT2: Watchdog
+	 * - IT4: APIC IT 1
+	 * - IT24: IPI
+	 */
+	uint64_t mask = IT_MASK(IT0) | IT_MASK(IT2) | IT_MASK(IT4) |
+			IT_MASK(IT24);
+
+	/*
+	 * Specific priorities for ITs:
+	 * - Watchdog has the highest priority: 3
+	 * - Timer has priority: 2
+	 * - APIC entries have the lowest priority: 1
+	 */
+	uint64_t value = IT_LEVEL(IT0, 0x2) | IT_LEVEL(IT2, 0x3) |
+			IT_LEVEL(IT4, 0x1) | IT_LEVEL(IT24, 0x1);
+
+	kvx_sfr_set_mask(ILL, mask, value);
+
+	/* Set core level to 0 */
+	kvx_sfr_set_field(PS, IL, 0);
+}
+
+void __init init_IRQ(void)
+{
+	irqchip_init();
+}
diff --git a/arch/kvx/kernel/traps.c b/arch/kvx/kernel/traps.c
new file mode 100644
index 0000000000000..d8f5732f5367b
--- /dev/null
+++ b/arch/kvx/kernel/traps.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Guillaume Thouvenin
+ *            Marius Gligor
+ */
+
+#include <linux/context_tracking.h>
+#include <linux/entry-common.h>
+#include <linux/init.h>
+#include <linux/irqdomain.h>
+#include <linux/irqflags.h>
+#include <linux/kdebug.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/ptrace.h>
+#include <linux/sched/task_stack.h>
+#include <linux/sched/debug.h>
+#include <linux/uaccess.h>
+
+#include <asm/break_hook.h>
+#include <asm/debug.h>
+#include <asm/ptrace.h>
+#include <asm/stacktrace.h>
+#include <asm/syscall.h>
+#include <asm/traps.h>
+
+int show_unhandled_signals = 1;
+
+static DEFINE_SPINLOCK(die_lock);
+
+static trap_handler_func trap_handler_table[KVX_TRAP_COUNT] = { NULL };
+
+/* Trap names associated to the trap numbers */
+static const char * const trap_name[] = {
+	"RESET",
+	"OPCODE",
+	"PRIVILEGE",
+	"DMISALIGN",
+	"PSYSERROR",
+	"DSYSERROR",
+	"PDECCERROR",
+	"DDECCERROR",
+	"PPARERROR",
+	"DPARERROR",
+	"PSECERROR",
+	"DSECERROR",
+	/* MMU related traps */
+	"NOMAPPING",
+	"PROTECTION",
+	"WRITETOCLEAN",
+	"ATOMICTOCLEAN",
+	"TPAR",
+	"DOUBLE_ECC",
+	"VSFR",
+	"PL_OVERFLOW"
+};
+
+void die(struct pt_regs *regs, unsigned long ea, const char *str)
+{
+	static int die_counter;
+	int ret;
+
+	oops_enter();
+
+	spin_lock_irq(&die_lock);
+	console_verbose();
+	bust_spinlocks(1);
+
+	pr_emerg("%s [#%d]\n", str, ++die_counter);
+	print_modules();
+	show_regs(regs);
+
+	if (!user_mode(regs))
+		show_stacktrace(NULL, regs, KERN_EMERG);
+
+	ret = notify_die(DIE_OOPS, str, regs, ea, 0, SIGSEGV);
+
+	bust_spinlocks(0);
+	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
+	spin_unlock_irq(&die_lock);
+	oops_exit();
+
+	if (in_interrupt())
+		panic("Fatal exception in interrupt");
+	if (panic_on_oops)
+		panic("Fatal exception");
+	if (ret != NOTIFY_STOP)
+		make_task_dead(SIGSEGV);
+}
+
+void user_do_sig(struct pt_regs *regs, int signo, int code, unsigned long addr)
+{
+	struct task_struct *tsk = current;
+
+	if (show_unhandled_signals && unhandled_signal(tsk, signo)
+	    && printk_ratelimit()) {
+		pr_info("%s[%d]: unhandled signal %d code 0x%x at 0x%lx",
+			tsk->comm, task_pid_nr(tsk), signo, code, addr);
+		print_vma_addr(KERN_CONT " in ", instruction_pointer(regs));
+		pr_cont("\n");
+		show_regs(regs);
+	}
+	if (signo == SIGKILL) {
+		force_sig(signo);
+		return;
+	}
+	force_sig_fault(signo, code, (void __user *) addr);
+}
+
+static void do_trap_error(struct pt_regs *regs, int signo, int code,
+			  unsigned long addr, const char *str)
+{
+	if (user_mode(regs)) {
+		user_do_sig(regs, signo, code, addr);
+	} else {
+		if (!fixup_exception(regs))
+			die(regs, addr, str);
+	}
+}
+
+static void panic_or_kill(uint64_t es, uint64_t ea, struct pt_regs *regs,
+			  int signo, int sigcode)
+{
+	if (user_mode(regs)) {
+		user_do_sig(regs, signo, sigcode, ea);
+		return;
+	}
+
+	pr_alert(CUT_HERE "ERROR: TRAP %s received at 0x%.16llx\n",
+		 trap_name[trap_cause(es)], regs->spc);
+	die(regs, ea, "Oops");
+	make_task_dead(SIGKILL);
+}
+
+int is_valid_bugaddr(unsigned long pc)
+{
+	/*
+	 * Since the bug was reported, this means that the break hook handling
+	 * already check the faulting instruction so there is no need for
+	 * additionnal check here. This is a BUG for sure.
+	 */
+	return 1;
+}
+
+static int bug_break_handler(struct pt_regs *regs, struct break_hook *brk_hook)
+{
+	enum bug_trap_type type;
+
+	type = report_bug(regs->spc, regs);
+	switch (type) {
+	case BUG_TRAP_TYPE_NONE:
+		return BREAK_HOOK_ERROR;
+	case BUG_TRAP_TYPE_WARN:
+		break;
+	case BUG_TRAP_TYPE_BUG:
+		die(regs, regs->spc, "Kernel BUG");
+		break;
+	}
+
+	/* Skip over break insn if we survived ! */
+	kvx_skip_break_insn(regs);
+
+	return BREAK_HOOK_HANDLED;
+}
+
+static struct break_hook bug_break_hook = {
+	.handler = bug_break_handler,
+	.id = BREAK_CAUSE_BUG,
+	.mode = MODE_KERNEL,
+};
+
+#define GEN_TRAP_HANDLER(__name, __sig, __code) \
+static void __name ## _trap_handler(struct pt_regs *regs, uint64_t es, \
+				    uint64_t ea) \
+{ \
+	panic_or_kill(es, ea, regs, __sig, __code); \
+}
+
+GEN_TRAP_HANDLER(default, SIGKILL, SI_KERNEL);
+GEN_TRAP_HANDLER(privilege, SIGILL, ILL_PRVREG);
+GEN_TRAP_HANDLER(dmisalign, SIGBUS, BUS_ADRALN);
+GEN_TRAP_HANDLER(syserror, SIGBUS, BUS_ADRERR);
+GEN_TRAP_HANDLER(opcode, SIGILL, ILL_ILLOPC);
+
+static void register_trap_handler(unsigned int trap_nb, trap_handler_func fn)
+{
+
+	if (trap_nb >= KVX_TRAP_COUNT || fn == NULL)
+		panic("Failed to register handler #%d\n", trap_nb);
+
+	trap_handler_table[trap_nb] = fn;
+}
+
+static void do_vsfr_fault(struct pt_regs *regs, uint64_t es, uint64_t ea)
+{
+	if (break_hook_handler(regs, es) == BREAK_HOOK_HANDLED)
+		return;
+
+	panic_or_kill(es, ea, regs, SIGILL, ILL_PRVREG);
+}
+
+void __init trap_init(void)
+{
+	int i;
+
+	break_hook_register(&bug_break_hook);
+
+	for (i = 0; i < KVX_TRAP_COUNT; i++)
+		register_trap_handler(i, default_trap_handler);
+#ifdef CONFIG_MMU
+	register_trap_handler(KVX_TRAP_NOMAPPING, do_page_fault);
+	register_trap_handler(KVX_TRAP_PROTECTION, do_page_fault);
+	register_trap_handler(KVX_TRAP_WRITETOCLEAN, do_writetoclean);
+#endif
+
+	register_trap_handler(KVX_TRAP_PSYSERROR, syserror_trap_handler);
+	register_trap_handler(KVX_TRAP_DSYSERROR, syserror_trap_handler);
+	register_trap_handler(KVX_TRAP_PRIVILEGE, privilege_trap_handler);
+	register_trap_handler(KVX_TRAP_OPCODE, opcode_trap_handler);
+	register_trap_handler(KVX_TRAP_DMISALIGN, dmisalign_trap_handler);
+	register_trap_handler(KVX_TRAP_VSFR, do_vsfr_fault);
+}
+
+void do_debug(struct pt_regs *regs, u64 ea)
+{
+	irqentry_state_t state = irqentry_enter(regs);
+
+	debug_handler(regs, ea);
+
+	irqentry_exit(regs, state);
+}
+
+void do_hwtrap(struct pt_regs *regs, uint64_t es, uint64_t ea)
+{
+	irqentry_state_t state = irqentry_enter(regs);
+
+	int htc = trap_cause(es);
+	trap_handler_func trap_handler = trap_handler_table[htc];
+
+	/* Normal traps are between 0 and 15 */
+	if (unlikely(htc >= KVX_TRAP_COUNT)) {
+		pr_err("Invalid trap %d !\n", htc);
+		goto done;
+	}
+
+	/* If irqs were enabled in the preempted context, reenable them */
+	if (!regs_irqs_disabled(regs))
+		local_irq_enable();
+
+	trap_handler(regs, es, ea);
+
+	local_irq_disable();
+
+done:
+	irqentry_exit(regs, state);
+}
+
+void do_syscall(struct pt_regs *regs)
+{
+	if (user_mode(regs)) {
+		long syscall = (regs->es & KVX_SFR_ES_SN_MASK) >> KVX_SFR_ES_SN_SHIFT;
+
+		syscall = syscall_enter_from_user_mode(regs, syscall);
+
+		syscall_handler(regs, (ulong)syscall);
+
+		syscall_exit_to_user_mode(regs);
+	} else {
+		irqentry_state_t state = irqentry_nmi_enter(regs);
+
+		do_trap_error(regs, SIGILL, ILL_ILLTRP, regs->spc,
+			      "Oops - scall from PL2");
+
+		irqentry_nmi_exit(regs, state);
+	}
+}
-- 
2.45.2






