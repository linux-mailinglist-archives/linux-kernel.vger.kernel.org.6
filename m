Return-Path: <linux-kernel+bounces-258770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 971AF938C8A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA4CA1C23826
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8C5176AAE;
	Mon, 22 Jul 2024 09:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="cp1uhP3b"
Received: from smtpout36.security-mail.net (smtpout36.security-mail.net [85.31.212.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A15016C6B2
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.31.212.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641510; cv=none; b=Im7Meym9spchJWg2vn1SuoBJzaaCJDEvlnso9JKQGdhpJzKwphahc+X7ZXjBwxsfQwbGmjDY/C1IsgoOWhEeVJtABo7PgZJJa9+iITH8TREgZXdG+jtKIdXHp332TEEdHjHVc5QjXeXvR8kRGcgPX9Et5PpKIBo1PUL0LsrNVW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641510; c=relaxed/simple;
	bh=4lRyF64RkHBX5ZQZLMQSwUqK2UfA044YgCciOeNOMbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qtuGiImJZST8JqMXF3WgPyBCKaXQsFasmPoW1vjkkY0p6YXR04JBTwbEcA3HqHJpejW1KvIi1azJDAuBP/XoT7MMOn2jOlTRPBLTq5EXbiHgXwsNGA2A9Bm6+huc11GtbrfsH2BB2foNB2ii6/516N56hQ6DyucGKMRJCoePnyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=cp1uhP3b; arc=none smtp.client-ip=85.31.212.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx306.security-mail.net [127.0.0.1])
	by fx306.security-mail.net (Postfix) with ESMTP id AD7B435D031
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:43:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1721641417;
	bh=4lRyF64RkHBX5ZQZLMQSwUqK2UfA044YgCciOeNOMbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cp1uhP3bH6qQlwuvH/ckiNgyqrCFKjSjWPmfXuA/lAyxmksFRoqKrTOVjIVv9kY0x
	 Eszq7A6jNhOXEp2s3mCiYIKfAGLINwdif61EFB06WvxSt9HO9Do/kfmWkNAWOO17O6
	 xIw9HAcrEerzH2UXvT9LyS0cft0h2FOCz5B/bnCw=
Received: from fx306 (fx306.security-mail.net [127.0.0.1]) by
 fx306.security-mail.net (Postfix) with ESMTP id 80C2735CFE2; Mon, 22 Jul
 2024 11:43:37 +0200 (CEST)
Received: from srvsmtp.lin.mbt.kalray.eu (unknown [217.181.231.53]) by
 fx306.security-mail.net (Postfix) with ESMTPS id DD24D35CF9F; Mon, 22 Jul
 2024 11:43:36 +0200 (CEST)
Received: from junon.lan.kalrayinc.com (unknown [192.168.37.161]) by
 srvsmtp.lin.mbt.kalray.eu (Postfix) with ESMTPS id A3FD740317; Mon, 22 Jul
 2024 11:43:36 +0200 (CEST)
X-Secumail-id: <b979.669e29c8.da915.0>
From: ysionneau@kalrayinc.com
To: linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Christian
 Brauner <brauner@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Yann Sionneau <ysionneau@kalrayinc.com>, Clement
 Leger <clement@clement-leger.fr>, Guillaume Thouvenin <thouveng@gmail.com>,
 Marius Gligor <mgligor@kalrayinc.com>, Vincent Chardon
 <vincent.chardon@elsys-design.com>, linux-riscv@lists.infradead.org
Subject: [RFC PATCH v3 23/37] kvx: Add process management
Date: Mon, 22 Jul 2024 11:41:34 +0200
Message-ID: <20240722094226.21602-24-ysionneau@kalrayinc.com>
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

Add process management support for kvx, including: thread info
definition, context switch and process tracing.

Co-developed-by: Clement Leger <clement@clement-leger.fr>
Signed-off-by: Clement Leger <clement@clement-leger.fr>
Co-developed-by: Guillaume Thouvenin <thouveng@gmail.com>
Signed-off-by: Guillaume Thouvenin <thouveng@gmail.com>
Co-developed-by: Julian Vetter <jvetter@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
Co-developed-by: Marius Gligor <mgligor@kalrayinc.com>
Signed-off-by: Marius Gligor <mgligor@kalrayinc.com>
Co-developed-by: Vincent Chardon <vincent.chardon@elsys-design.com>
Signed-off-by: Vincent Chardon <vincent.chardon@elsys-design.com>
Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
---

Notes:
V1 -> V2: no change

V2 -> V3: Updated to use generic entry/exit syscall_work flag, etc.
---
 arch/kvx/include/asm/current.h     |  22 +++
 arch/kvx/include/asm/ptrace.h      | 217 +++++++++++++++++++++++++++
 arch/kvx/include/asm/switch_to.h   |  18 +++
 arch/kvx/include/asm/thread_info.h |  72 +++++++++
 arch/kvx/include/uapi/asm/ptrace.h | 114 ++++++++++++++
 arch/kvx/kernel/process.c          | 195 ++++++++++++++++++++++++
 arch/kvx/kernel/ptrace.c           | 233 +++++++++++++++++++++++++++++
 arch/kvx/kernel/stacktrace.c       | 177 ++++++++++++++++++++++
 8 files changed, 1048 insertions(+)
 create mode 100644 arch/kvx/include/asm/current.h
 create mode 100644 arch/kvx/include/asm/ptrace.h
 create mode 100644 arch/kvx/include/asm/switch_to.h
 create mode 100644 arch/kvx/include/asm/thread_info.h
 create mode 100644 arch/kvx/include/uapi/asm/ptrace.h
 create mode 100644 arch/kvx/kernel/process.c
 create mode 100644 arch/kvx/kernel/ptrace.c
 create mode 100644 arch/kvx/kernel/stacktrace.c

diff --git a/arch/kvx/include/asm/current.h b/arch/kvx/include/asm/current.h
new file mode 100644
index 0000000000000..b5fd0f076ec99
--- /dev/null
+++ b/arch/kvx/include/asm/current.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_CURRENT_H
+#define _ASM_KVX_CURRENT_H
+
+#include <asm/percpu.h>
+#include <asm/sfr.h>
+
+struct task_struct;
+
+static __always_inline struct task_struct *get_current(void)
+{
+	return (struct task_struct *) kvx_sfr_get(SR);
+}
+
+#define current get_current()
+
+#endif	/* _ASM_KVX_CURRENT_H */
diff --git a/arch/kvx/include/asm/ptrace.h b/arch/kvx/include/asm/ptrace.h
new file mode 100644
index 0000000000000..87254045ff54f
--- /dev/null
+++ b/arch/kvx/include/asm/ptrace.h
@@ -0,0 +1,217 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Marius Gligor
+ *            Yann Sionneau
+ */
+
+#ifndef _ASM_KVX_PTRACE_H
+#define _ASM_KVX_PTRACE_H
+
+#include <asm/types.h>
+#include <asm/sfr.h>
+#include <uapi/asm/ptrace.h>
+
+#define GPR_COUNT	64
+#define SFR_COUNT	9
+#define VIRT_COUNT	1
+
+#define ES_SYSCALL	0x3
+
+#define KVX_HW_BREAKPOINT_COUNT		2
+#define KVX_HW_WATCHPOINT_COUNT		1
+
+#define REG_SIZE	sizeof(u64)
+
+/**
+ * When updating pt_regs structure, this size must be updated.
+ * This is the expected size of the pt_regs struct.
+ * It ensures the structure layout from gcc is the same as the one we
+ * expect in order to do packed load (load/store octuple) in assembly.
+ * Conclusion: never put sizeof(pt_regs) in here or we lose this check
+ * (build time check done in asm-offsets.c via BUILD_BUG_ON)
+ */
+#define PT_REGS_STRUCT_EXPECTED_SIZE \
+			((GPR_COUNT + SFR_COUNT + VIRT_COUNT) * REG_SIZE + \
+			2 * REG_SIZE) /* Padding for stack alignment */
+
+/**
+ * Saved register structure. Note that we should save only the necessary
+ * registers.
+ * When you modify it, please read carefully the comment above.
+ * Moreover, you will need to modify user_pt_regs to match the beginning
+ * of this struct 1:1
+ */
+struct pt_regs {
+	/* GPR */
+	uint64_t r0;
+	uint64_t r1;
+	uint64_t r2;
+	uint64_t r3;
+	uint64_t r4;
+	uint64_t r5;
+	uint64_t r6;
+	uint64_t r7;
+	uint64_t r8;
+	uint64_t r9;
+	uint64_t r10;
+	uint64_t r11;
+	union {
+		uint64_t r12;
+		uint64_t sp;
+	};
+	union {
+		uint64_t r13;
+		uint64_t tp;
+	};
+	union {
+		uint64_t r14;
+		uint64_t fp;
+	};
+	uint64_t r15;
+	uint64_t r16;
+	uint64_t r17;
+	uint64_t r18;
+	uint64_t r19;
+	uint64_t r20;
+	uint64_t r21;
+	uint64_t r22;
+	uint64_t r23;
+	uint64_t r24;
+	uint64_t r25;
+	uint64_t r26;
+	uint64_t r27;
+	uint64_t r28;
+	uint64_t r29;
+	uint64_t r30;
+	uint64_t r31;
+	uint64_t r32;
+	uint64_t r33;
+	uint64_t r34;
+	uint64_t r35;
+	uint64_t r36;
+	uint64_t r37;
+	uint64_t r38;
+	uint64_t r39;
+	uint64_t r40;
+	uint64_t r41;
+	uint64_t r42;
+	uint64_t r43;
+	uint64_t r44;
+	uint64_t r45;
+	uint64_t r46;
+	uint64_t r47;
+	uint64_t r48;
+	uint64_t r49;
+	uint64_t r50;
+	uint64_t r51;
+	uint64_t r52;
+	uint64_t r53;
+	uint64_t r54;
+	uint64_t r55;
+	uint64_t r56;
+	uint64_t r57;
+	uint64_t r58;
+	uint64_t r59;
+	uint64_t r60;
+	uint64_t r61;
+	uint64_t r62;
+	uint64_t r63;
+
+	/* SFR */
+	uint64_t lc;
+	uint64_t le;
+	uint64_t ls;
+	uint64_t ra;
+
+	uint64_t cs;
+	uint64_t spc;
+
+	uint64_t sps;
+	uint64_t es;
+
+	uint64_t ilr;
+
+	/* "Virtual" registers */
+	uint64_t orig_r0;
+
+	/* Padding for stack alignment (see STACK_ALIGN) */
+	uint64_t padding[2];
+
+	/**
+	 * If you add some fields, please read carefully the comment for
+	 * PT_REGS_STRUCT_EXPECTED_SIZE.
+	 */
+};
+
+#define pl(__reg) kvx_sfr_field_val(__reg, PS, PL)
+
+#define MODE_KERNEL	0
+#define MODE_USER	1
+
+/* Privilege level is relative in $sps, so 1 indicates current PL + 1 */
+#define user_mode(regs)	(pl((regs)->sps) == MODE_USER)
+#define es_ec(regs) kvx_sfr_field_val(regs->es, ES, EC)
+#define es_sysno(regs) kvx_sfr_field_val(regs->es, ES, SN)
+
+#define debug_dc(es) kvx_sfr_field_val((es), ES, DC)
+
+/* ptrace */
+#define PTRACE_GET_HW_PT_REGS		20
+#define PTRACE_SET_HW_PT_REGS		21
+#define PTRACE_SYSEMU			22
+#define PTRACE_SYSEMU_SINGLESTEP	23
+#define arch_has_single_step()		1
+
+#define DEBUG_CAUSE_BREAKPOINT		0
+#define DEBUG_CAUSE_WATCHPOINT		1
+#define DEBUG_CAUSE_STEPI		2
+#define DEBUG_CAUSE_DSU_BREAK		3
+
+static inline void enable_single_step(struct pt_regs *regs)
+{
+	regs->sps |= KVX_SFR_PS_SME_MASK;
+}
+
+static inline void disable_single_step(struct pt_regs *regs)
+{
+	regs->sps &= ~KVX_SFR_PS_SME_MASK;
+}
+
+static inline bool in_syscall(struct pt_regs const *regs)
+{
+	return es_ec(regs) == ES_SYSCALL;
+}
+
+static inline unsigned long get_current_sp(void)
+{
+	register const unsigned long current_sp __asm__ ("$r12");
+
+	return current_sp;
+}
+
+extern char *user_scall_rt_sigreturn_end;
+extern char *user_scall_rt_sigreturn;
+
+static inline unsigned long instruction_pointer(struct pt_regs *regs)
+{
+	return regs->spc;
+}
+
+static inline long regs_return_value(struct pt_regs *regs)
+{
+	return regs->r0;
+}
+
+static inline unsigned long user_stack_pointer(struct pt_regs *regs)
+{
+	return regs->sp;
+}
+
+static inline int regs_irqs_disabled(struct pt_regs *regs)
+{
+	return !(regs->sps & KVX_SFR_PS_IE_MASK);
+}
+
+#endif	/* _ASM_KVX_PTRACE_H */
diff --git a/arch/kvx/include/asm/switch_to.h b/arch/kvx/include/asm/switch_to.h
new file mode 100644
index 0000000000000..b08521741ea78
--- /dev/null
+++ b/arch/kvx/include/asm/switch_to.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_SWITCH_TO_H
+#define _ASM_KVX_SWITCH_TO_H
+
+struct task_struct;
+
+/* context switching is now performed out-of-line in switch_to.S */
+extern struct task_struct *__switch_to(struct task_struct *prev,
+				       struct task_struct *next);
+
+#define switch_to(prev, next, last) ((last) = __switch_to((prev), (next)))
+
+#endif	/* _ASM_KVX_SWITCH_TO_H */
diff --git a/arch/kvx/include/asm/thread_info.h b/arch/kvx/include/asm/thread_info.h
new file mode 100644
index 0000000000000..4ecee40ef84c8
--- /dev/null
+++ b/arch/kvx/include/asm/thread_info.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Guillaume Thouvenin
+ */
+
+#ifndef _ASM_KVX_THREAD_INFO_H
+#define _ASM_KVX_THREAD_INFO_H
+
+
+#include <asm/page.h>
+
+/*
+ * Size of the kernel stack for each process.
+ */
+#define THREAD_SIZE_ORDER	2
+#define THREAD_SIZE		(PAGE_SIZE << THREAD_SIZE_ORDER)
+
+/*
+ * Thread information flags
+ *   these are process state flags that various assembly files may need to
+ *   access
+ *   - pending work-to-be-done flags are in LSW
+ *   - other flags in MSW
+ */
+#define TIF_NOTIFY_RESUME	1	/* resumption notification requested */
+#define TIF_SIGPENDING		2	/* signal pending */
+#define TIF_NEED_RESCHED	3	/* rescheduling necessary */
+#define TIF_SINGLESTEP		4	/* restore singlestep on return to user mode */
+#define TIF_UPROBE		5	/* uprobe breakpoint or singlestep */
+#define TIF_RESTORE_SIGMASK	9
+#define TIF_NOTIFY_SIGNAL	10	/* signal notifications exist */
+#define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
+#define TIF_MEMDIE		17	/* is terminating due to OOM killer */
+
+#define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
+#define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
+#define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
+#define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
+#define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
+
+#ifndef __ASSEMBLY__
+/*
+ * We are using THREAD_INFO_IN_TASK so this struct is almost useless
+ * please prefer adding fields in thread_struct (processor.h) rather
+ * than here.
+ * This struct is merely a remnant of distant times where it was placed
+ * on the stack to avoid large task_struct.
+ *
+ * cf https://lwn.net/Articles/700615/
+ */
+struct thread_info {
+	unsigned long	flags;		/* low level flags */
+	int		preempt_count;
+#ifdef CONFIG_SMP
+	u32		cpu;		/* current CPU */
+#endif
+	unsigned long	syscall_work;	/* SYSCALL_WORK_ flags */
+};
+
+#define INIT_THREAD_INFO(tsk)			\
+{						\
+	.flags		= 0,			\
+	.preempt_count	= INIT_PREEMPT_COUNT,	\
+}
+
+/* Get the current stack pointer from C */
+register unsigned long current_stack_pointer asm("$sp") __used;
+
+#endif /* __ASSEMBLY__*/
+#endif /* _ASM_KVX_THREAD_INFO_H */
diff --git a/arch/kvx/include/uapi/asm/ptrace.h b/arch/kvx/include/uapi/asm/ptrace.h
new file mode 100644
index 0000000000000..50db5310704f0
--- /dev/null
+++ b/arch/kvx/include/uapi/asm/ptrace.h
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Yann Sionneau
+ */
+
+#ifndef _UAPI_ASM_KVX_PTRACE_H
+#define _UAPI_ASM_KVX_PTRACE_H
+
+#include <linux/types.h>
+/*
+ * User-mode register state for core dumps, ptrace, sigcontext
+ *
+ * This decouples struct pt_regs from the userspace ABI.
+ * The struct user_regs_struct must form a prefix of struct pt_regs.
+ */
+struct user_regs_struct {
+	/* GPR */
+	unsigned long r0;
+	unsigned long r1;
+	unsigned long r2;
+	unsigned long r3;
+	unsigned long r4;
+	unsigned long r5;
+	unsigned long r6;
+	unsigned long r7;
+	unsigned long r8;
+	unsigned long r9;
+	unsigned long r10;
+	unsigned long r11;
+	union {
+		unsigned long r12;
+		unsigned long sp;
+	};
+	union {
+		unsigned long r13;
+		unsigned long tp;
+	};
+	union {
+		unsigned long r14;
+		unsigned long fp;
+	};
+	unsigned long r15;
+	unsigned long r16;
+	unsigned long r17;
+	unsigned long r18;
+	unsigned long r19;
+	unsigned long r20;
+	unsigned long r21;
+	unsigned long r22;
+	unsigned long r23;
+	unsigned long r24;
+	unsigned long r25;
+	unsigned long r26;
+	unsigned long r27;
+	unsigned long r28;
+	unsigned long r29;
+	unsigned long r30;
+	unsigned long r31;
+	unsigned long r32;
+	unsigned long r33;
+	unsigned long r34;
+	unsigned long r35;
+	unsigned long r36;
+	unsigned long r37;
+	unsigned long r38;
+	unsigned long r39;
+	unsigned long r40;
+	unsigned long r41;
+	unsigned long r42;
+	unsigned long r43;
+	unsigned long r44;
+	unsigned long r45;
+	unsigned long r46;
+	unsigned long r47;
+	unsigned long r48;
+	unsigned long r49;
+	unsigned long r50;
+	unsigned long r51;
+	unsigned long r52;
+	unsigned long r53;
+	unsigned long r54;
+	unsigned long r55;
+	unsigned long r56;
+	unsigned long r57;
+	unsigned long r58;
+	unsigned long r59;
+	unsigned long r60;
+	unsigned long r61;
+	unsigned long r62;
+	unsigned long r63;
+
+	/* SFR */
+	unsigned long lc;
+	unsigned long le;
+	unsigned long ls;
+	unsigned long ra;
+
+	unsigned long cs;
+	unsigned long spc;
+};
+
+/* TCA registers structure exposed to user */
+struct user_tca_regs {
+	struct {
+		__u64 x;
+		__u64 y;
+		__u64 z;
+		__u64 t;
+	} regs[48];
+};
+
+#endif /* _UAPI_ASM_KVX_PTRACE_H */
diff --git a/arch/kvx/kernel/process.c b/arch/kvx/kernel/process.c
new file mode 100644
index 0000000000000..181e45cfe7480
--- /dev/null
+++ b/arch/kvx/kernel/process.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Guillaume Thouvenin
+ *            Marius Gligor
+ *            Yann Sionneau
+ */
+
+#include <linux/elf.h>
+#include <linux/sched.h>
+#include <linux/ptrace.h>
+#include <linux/printk.h>
+#include <linux/sched/debug.h>
+#include <linux/sched/task_stack.h>
+#include <linux/hw_breakpoint.h>
+
+#include <asm/ptrace.h>
+#include <asm/processor.h>
+#include <asm/ptrace.h>
+#include <asm/uaccess.h>
+#include <asm/stacktrace.h>
+
+#if defined(CONFIG_STACKPROTECTOR)
+#include <linux/stackprotector.h>
+unsigned long __stack_chk_guard __read_mostly;
+EXPORT_SYMBOL(__stack_chk_guard);
+#endif
+
+#define SCALL_NUM_EXIT	"0xfff"
+
+void arch_cpu_idle(void)
+{
+	wait_for_interrupt();
+	local_irq_enable();
+}
+
+void show_regs(struct pt_regs *regs)
+{
+
+	int in_kernel = 1;
+	unsigned short i, reg_offset;
+	void *ptr;
+
+	show_regs_print_info(KERN_DEFAULT);
+
+	if (user_mode(regs))
+		in_kernel = 0;
+
+	pr_info("\nmode: %s\n"
+	       "    PC: %016llx    PS: %016llx\n"
+	       "    CS: %016llx    RA: %016llx\n"
+	       "    LS: %016llx    LE: %016llx\n"
+	       "    LC: %016llx\n\n",
+	       in_kernel ? "kernel" : "user",
+	       regs->spc, regs->sps,
+	       regs->cs, regs->ra, regs->ls, regs->le, regs->lc);
+
+	/* GPR */
+	ptr = regs;
+	ptr += offsetof(struct pt_regs, r0);
+	reg_offset = offsetof(struct pt_regs, r1) -
+		     offsetof(struct pt_regs, r0);
+
+	/**
+	 * Display all the 64 GPRs assuming they are ordered correctly
+	 * in the pt_regs struct...
+	 */
+	for (i = 0; i < GPR_COUNT; i += 2) {
+		pr_info("    R%d: %016llx    R%d: %016llx\n",
+			 i, *(uint64_t *)ptr,
+			 i + 1, *(uint64_t *)(ptr + reg_offset));
+		ptr += reg_offset * 2;
+	}
+
+	pr_info("\n\n");
+}
+
+/**
+ * Prepare a thread to return to userspace
+ */
+void start_thread(struct pt_regs *regs,
+			unsigned long pc, unsigned long sp)
+{
+	/* Remove MMUP bit (user is not privilege in current virtual space) */
+	u64 clear_bit = KVX_SFR_PS_MMUP_MASK | KVX_SFR_PS_SME_MASK |
+			KVX_SFR_PS_SMR_MASK;
+	regs->spc = pc;
+	regs->sp = sp;
+	regs->sps = kvx_sfr_get(PS);
+
+	regs->sps &= ~clear_bit;
+
+	/* Set privilege level to +1 (relative) */
+	regs->sps &= ~KVX_SFR_PS_PL_MASK;
+	regs->sps |= (1 << KVX_SFR_PS_PL_SHIFT);
+}
+
+int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
+{
+	struct pt_regs *regs, *childregs = task_pt_regs(p);
+	unsigned long clone_flags = args->flags;
+	unsigned long usp = args->stack;
+	unsigned long tls = args->tls;
+
+	/* p->thread holds context to be restored by __switch_to() */
+	if (unlikely(args->fn)) {
+		/* Kernel thread */
+		memset(childregs, 0, sizeof(struct pt_regs));
+
+		p->thread.ctx_switch.r20 = (uint64_t)args->fn;
+		p->thread.ctx_switch.r21 = (uint64_t)args->fn_arg;
+		p->thread.ctx_switch.ra =
+				(unsigned long) ret_from_kernel_thread;
+	} else {
+		regs = current_pt_regs();
+
+		/* Copy current process registers */
+		*childregs = *regs;
+
+		/* Store tracing status in r20 to avoid computing it
+		 * in assembly
+		 */
+		p->thread.ctx_switch.r20 = 0;
+
+
+		childregs->r0 = 0; /* Return value of fork() */
+		/* Set stack pointer if any */
+		if (usp)
+			childregs->sp = usp;
+
+		/* Set a new TLS ?  */
+		if (clone_flags & CLONE_SETTLS)
+			childregs->r13 = tls;
+	}
+
+	p->thread.ctx_switch.ra = (unsigned long) ret_from_fork;
+	p->thread.kernel_sp =
+		(unsigned long) (task_stack_page(p) + THREAD_SIZE);
+	p->thread.ctx_switch.sp = (unsigned long) childregs;
+
+	return 0;
+}
+
+void release_thread(struct task_struct *dead_task)
+{
+}
+
+void flush_thread(void)
+{
+
+}
+
+static bool find_wchan(unsigned long pc, void *arg, const char *loglvl)
+{
+	unsigned long *p = arg;
+
+	/*
+	 * If the pc is in a scheduler function (waiting), then, this is the
+	 * address where the process is currently stuck. Note that scheduler
+	 * functions also include lock functions. This functions are
+	 * materialized using annotations to put them in special text sections.
+	 */
+	if (!in_sched_functions(pc)) {
+		*p = pc;
+		return true;
+	}
+
+	return false;
+}
+
+/*
+ * __get_wchan is called to obtain "schedule()" caller function address.
+ */
+unsigned long __get_wchan(struct task_struct *p)
+{
+	unsigned long pc = 0;
+	struct stackframe frame;
+
+	/*
+	 * We need to obtain the task stack since we don't want the stack to
+	 * move under our feet.
+	 */
+	if (!try_get_task_stack(p))
+		return 0;
+
+	start_stackframe(&frame, thread_saved_reg(p, fp),
+			 thread_saved_reg(p, ra));
+	walk_stackframe(p, &frame, find_wchan, &pc, KERN_DEFAULT);
+
+	put_task_stack(p);
+
+	return pc;
+}
+
diff --git a/arch/kvx/kernel/ptrace.c b/arch/kvx/kernel/ptrace.c
new file mode 100644
index 0000000000000..48167235ac642
--- /dev/null
+++ b/arch/kvx/kernel/ptrace.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * derived from arch/riscv/kernel/ptrace.c
+ *
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Marius Gligor
+ *            Clement Leger
+ */
+
+#include <linux/sched.h>
+#include <linux/sched.h>
+#include <linux/audit.h>
+#include <linux/irqflags.h>
+#include <linux/thread_info.h>
+#include <linux/context_tracking.h>
+#include <linux/uaccess.h>
+#include <linux/syscalls.h>
+#include <linux/signal.h>
+#include <linux/regset.h>
+#include <linux/hw_breakpoint.h>
+
+#include <asm/ptrace.h>
+#include <asm/syscall.h>
+#include <asm/break_hook.h>
+#include <asm/debug.h>
+#include <asm/cacheflush.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/syscalls.h>
+
+#define HW_PT_CMD_GET_CAPS	0
+#define HW_PT_CMD_GET_PT	1
+#define HW_PT_CMD_SET_RESERVE	0
+#define HW_PT_CMD_SET_ENABLE	1
+
+#define FROM_GDB_CMD_MASK 3
+#define FROM_GDB_HP_TYPE_SHIFT 2
+#define FROM_GDB_HP_TYPE_MASK 4
+#define FROM_GDB_WP_TYPE_SHIFT 3
+#define FROM_GDB_WP_TYPE_MASK 0x18
+#define FROM_GDB_HP_IDX_SHIFT 5
+
+#define hw_pt_cmd(addr) ((addr) & FROM_GDB_CMD_MASK)
+#define hw_pt_is_bkp(addr) ((((addr) & FROM_GDB_HP_TYPE_MASK) >> \
+			     FROM_GDB_HP_TYPE_SHIFT) == KVX_HW_BREAKPOINT_TYPE)
+#define get_hw_pt_wp_type(addr) ((((addr) & FROM_GDB_WP_TYPE_MASK)) >> \
+				 FROM_GDB_WP_TYPE_SHIFT)
+#define get_hw_pt_idx(addr) ((addr) >> FROM_GDB_HP_IDX_SHIFT)
+#define get_hw_pt_addr(data) ((data)[0])
+#define get_hw_pt_len(data) ((data)[1] >> 1)
+#define hw_pt_is_enabled(data) ((data)[1] & 1)
+
+enum kvx_regset {
+	REGSET_GPR,
+#ifdef CONFIG_ENABLE_TCA
+	REGSET_TCA,
+#endif
+};
+
+void ptrace_disable(struct task_struct *child)
+{
+	/* nothing to do */
+}
+
+static int kvx_gpr_get(struct task_struct *target,
+			 const struct user_regset *regset,
+			 struct membuf to)
+{
+	return membuf_write(&to, task_pt_regs(target),
+			    sizeof(struct user_regs_struct));
+}
+
+static int kvx_gpr_set(struct task_struct *target,
+			 const struct user_regset *regset,
+			 unsigned int pos, unsigned int count,
+			 const void *kbuf, const void __user *ubuf)
+{
+	struct pt_regs *regs = task_pt_regs(target);
+
+	return user_regset_copyin(&pos, &count, &kbuf, &ubuf, regs, 0, -1);
+}
+
+#ifdef CONFIG_ENABLE_TCA
+static int kvx_tca_reg_get(struct task_struct *target,
+			 const struct user_regset *regset,
+			 struct membuf to)
+{
+	struct ctx_switch_regs *ctx_regs = &target->thread.ctx_switch;
+	struct tca_reg *regs = ctx_regs->tca_regs;
+	int ret;
+
+	if (!ctx_regs->tca_regs_saved)
+		ret = membuf_zero(&to, sizeof(*regs));
+	else
+		ret = membuf_write(&to, regs, sizeof(*regs));
+
+	return ret;
+}
+
+static int kvx_tca_reg_set(struct task_struct *target,
+			 const struct user_regset *regset,
+			 unsigned int pos, unsigned int count,
+			 const void *kbuf, const void __user *ubuf)
+{
+	struct ctx_switch_regs *ctx_regs = &target->thread.ctx_switch;
+	struct tca_reg *regs = ctx_regs->tca_regs;
+	int ret = 0;
+
+	if (!ctx_regs->tca_regs_saved)
+		user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
+					  0, -1);
+	else
+		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, regs,
+					 0, -1);
+
+	return ret;
+}
+#endif
+
+static const struct user_regset kvx_user_regset[] = {
+	[REGSET_GPR] = {
+		.core_note_type = NT_PRSTATUS,
+		.n = ELF_NGREG,
+		.size = sizeof(elf_greg_t),
+		.align = sizeof(elf_greg_t),
+		.regset_get = &kvx_gpr_get,
+		.set = &kvx_gpr_set,
+	},
+#ifdef CONFIG_ENABLE_TCA
+	[REGSET_TCA] = {
+		.core_note_type = NT_KVX_TCA,
+		.n = TCA_REG_COUNT,
+		.size = sizeof(struct tca_reg),
+		.align = sizeof(struct tca_reg),
+		.regset_get = &kvx_tca_reg_get,
+		.set = &kvx_tca_reg_set,
+	},
+#endif
+};
+
+static const struct user_regset_view user_kvx_view = {
+	.name = "kvx",
+	.e_machine = EM_KVX,
+	.regsets = kvx_user_regset,
+	.n = ARRAY_SIZE(kvx_user_regset)
+};
+
+const struct user_regset_view *task_user_regset_view(struct task_struct *task)
+{
+	return &user_kvx_view;
+}
+
+long arch_ptrace(struct task_struct *child, long request,
+		unsigned long addr, unsigned long data)
+{
+	return ptrace_request(child, request, addr, data);
+}
+
+static int kvx_bkpt_handler(struct pt_regs *regs, struct break_hook *brk_hook)
+{
+	/* Unexpected breakpoint */
+	if (!(current->ptrace & PT_PTRACED))
+		return BREAK_HOOK_ERROR;
+
+	/* deliver the signal to userspace */
+	force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *) regs->spc);
+
+	return BREAK_HOOK_HANDLED;
+}
+
+static void kvx_stepi(struct pt_regs *regs)
+{
+	/* deliver the signal to userspace */
+	force_sig_fault(SIGTRAP, TRAP_TRACE, (void __user *) regs->spc);
+}
+
+void user_enable_single_step(struct task_struct *child)
+{
+	struct pt_regs *regs = task_pt_regs(child);
+
+	enable_single_step(regs);
+}
+
+void user_disable_single_step(struct task_struct *child)
+{
+	struct pt_regs *regs = task_pt_regs(child);
+
+	disable_single_step(regs);
+}
+
+/**
+ * Main debug handler called by the _debug_handler routine in entry.S
+ * This handler will perform the required action
+ * @es: Exception Syndrome register value
+ * @ea: Exception Address register
+ * @regs: pointer to registers saved when enter debug
+ */
+static int ptrace_debug_handler(struct pt_regs *regs, u64 ea)
+{
+
+	int debug_cause = debug_dc(regs->es);
+
+	switch (debug_cause) {
+	case DEBUG_CAUSE_STEPI:
+		kvx_stepi(regs);
+		break;
+	default:
+		break;
+	}
+
+	return DEBUG_HOOK_HANDLED;
+}
+
+static struct debug_hook ptrace_debug_hook = {
+	.handler = ptrace_debug_handler,
+	.mode = MODE_USER,
+};
+
+static struct break_hook bkpt_break_hook = {
+	.id = BREAK_CAUSE_BKPT,
+	.handler = kvx_bkpt_handler,
+	.mode = MODE_USER,
+};
+
+static int __init arch_init_breakpoint(void)
+{
+	break_hook_register(&bkpt_break_hook);
+	debug_hook_register(&ptrace_debug_hook);
+
+	return 0;
+}
+
+postcore_initcall(arch_init_breakpoint);
diff --git a/arch/kvx/kernel/stacktrace.c b/arch/kvx/kernel/stacktrace.c
new file mode 100644
index 0000000000000..4a6952157b19b
--- /dev/null
+++ b/arch/kvx/kernel/stacktrace.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Vincent Chardon
+ */
+
+#include <linux/context_tracking.h>
+#include <linux/kallsyms.h>
+#include <linux/printk.h>
+#include <linux/sched/debug.h>
+#include <linux/init.h>
+
+#include <asm/stacktrace.h>
+#include <asm/ptrace.h>
+
+#define STACK_SLOT_PER_LINE		4
+#define STACK_MAX_SLOT_PRINT		(STACK_SLOT_PER_LINE * 8)
+
+static int notrace unwind_frame(struct task_struct *task,
+				struct stackframe *frame)
+{
+	unsigned long fp = frame->fp;
+
+	/* Frame pointer must be aligned on 8 bytes */
+	if (fp & 0x7)
+		return -EINVAL;
+
+	if (!task)
+		task = current;
+
+	if (!on_task_stack(task, fp))
+		return -EINVAL;
+
+	frame->fp = READ_ONCE_NOCHECK(*(unsigned long *)(fp));
+	frame->ra = READ_ONCE_NOCHECK(*(unsigned long *)(fp + 8));
+
+	/*
+	 * When starting, we set the frame pointer to 0, hence end of
+	 * frame linked list is signal by that
+	 */
+	if (!frame->fp)
+		return -EINVAL;
+
+	return 0;
+}
+
+void notrace walk_stackframe(struct task_struct *task, struct stackframe *frame,
+			     bool (*fn)(unsigned long, void *, const char *),
+			     void *arg, const char *loglvl)
+{
+	unsigned long addr;
+	int ret;
+
+	while (1) {
+		addr = frame->ra;
+
+		if (fn(addr, arg, loglvl))
+			break;
+
+		ret = unwind_frame(task, frame);
+		if (ret)
+			break;
+	}
+}
+
+#ifdef CONFIG_STACKTRACE
+static bool append_stack_addr(unsigned long pc, void *arg, const char *loglvl)
+{
+	struct stack_trace *trace;
+
+	trace = (struct stack_trace *)arg;
+	if (trace->skip == 0) {
+		trace->entries[trace->nr_entries++] = pc;
+		if (trace->nr_entries == trace->max_entries)
+			return true;
+	} else {
+		trace->skip--;
+	}
+
+	return false;
+}
+
+/*
+ * Save stack-backtrace addresses into a stack_trace buffer.
+ */
+void save_stack_trace(struct stack_trace *trace)
+{
+	struct stackframe frame;
+
+	trace->nr_entries = 0;
+	/* We want to skip this function and the caller */
+	trace->skip += 2;
+
+	start_stackframe(&frame, (unsigned long) __builtin_frame_address(0),
+			 (unsigned long) save_stack_trace);
+	walk_stackframe(current, &frame, append_stack_addr, trace,
+			KERN_DEFAULT);
+}
+EXPORT_SYMBOL(save_stack_trace);
+#endif /* CONFIG_STACKTRACE */
+
+static bool print_pc(unsigned long pc, void *arg, const char *loglvl)
+{
+	unsigned long *skip = arg;
+
+	if (*skip == 0)
+		print_ip_sym(loglvl, pc);
+	else
+		(*skip)--;
+
+	return false;
+}
+
+void show_stacktrace(struct task_struct *task, struct pt_regs *regs,
+		     const char *loglvl)
+{
+	struct stackframe frame;
+	unsigned long skip = 0;
+
+	/* Obviously, we can't backtrace on usermode ! */
+	if (regs && user_mode(regs))
+		return;
+
+	if (!task)
+		task = current;
+
+	if (!try_get_task_stack(task))
+		return;
+
+	if (regs) {
+		start_stackframe(&frame, regs->fp, regs->spc);
+	} else if (task == current) {
+		/* Skip current function and caller */
+		skip = 2;
+		start_stackframe(&frame,
+				 (unsigned long) __builtin_frame_address(0),
+				 (unsigned long) show_stacktrace);
+	} else {
+		/* task blocked in __switch_to */
+		start_stackframe(&frame,
+				 thread_saved_reg(task, fp),
+				 thread_saved_reg(task, ra));
+	}
+
+	pr_cont("%sCall Trace:\n", loglvl);
+	walk_stackframe(task, &frame, print_pc, &skip, loglvl);
+
+	put_task_stack(task);
+}
+
+/*
+ * If show_stack is called with a non-null task, then the task will have been
+ * claimed with try_get_task_stack by the caller. If task is NULL or current
+ * then there is no need to get task stack since it's our current stack...
+ */
+void show_stack(struct task_struct *task, unsigned long *sp, const char *loglvl)
+{
+	int i = 0;
+
+	if (!sp)
+		sp = (unsigned long *) get_current_sp();
+
+	printk("%sStack dump (@%p):\n", loglvl, sp);
+	for (i = 0; i < STACK_MAX_SLOT_PRINT; i++) {
+		if (kstack_end(sp))
+			break;
+
+		if (i && (i % STACK_SLOT_PER_LINE) == 0)
+			pr_cont("\n\t");
+
+		pr_cont("%016lx ", *sp++);
+	}
+	pr_cont("\n");
+
+	show_stacktrace(task, NULL, loglvl);
+}
-- 
2.45.2






