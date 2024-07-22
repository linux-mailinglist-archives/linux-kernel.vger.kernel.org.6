Return-Path: <linux-kernel+bounces-258748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFDF938C5B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E426B2823C1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E994116C861;
	Mon, 22 Jul 2024 09:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="mXjs2XZ9"
Received: from smtpout145.security-mail.net (smtpout145.security-mail.net [85.31.212.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F004916EB5E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.31.212.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641431; cv=none; b=KZBpq2KcKGYmtGwTQ0+EKnH6HlLAfCA6MKIeIMLHX3dj2VJ/5tLvxb2uOOnqmESjuHmr5GFmcOLIxoxf9/CyS0cBCC20iQYwoeam5Kvlhb5/nNLmyk8EJJNyaUPRC2dONiaWpgoCA5FVMDpVqyQ8An7nj83rBt62gimUgTLuaas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641431; c=relaxed/simple;
	bh=ueplDH8FmOwuHw0oGeEXZslFcpVWycsk0pYHbIwg814=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UbyzcvYsKpVcAwfOzXjrXMDEtOuviB8laBYojbS9FMuMmYziieNREASy64EC6rBQ5CXN6cN3uGmt2uY+pC6y8p9M/q7bfN2Qcq9JTpxjXzvwwtbRmKW2wjbDdjyYOlbYnsrwyHbmlio2xTR9jF7riwO4qZHOOnYzbYYbxTGG1lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=mXjs2XZ9; arc=none smtp.client-ip=85.31.212.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx405.security-mail.net [127.0.0.1])
	by fx405.security-mail.net (Postfix) with ESMTP id 80668336046
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:43:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1721641427;
	bh=ueplDH8FmOwuHw0oGeEXZslFcpVWycsk0pYHbIwg814=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mXjs2XZ94YMHurnc8iVfjCUbI7aPDTc6dSTgFpMumAl++V8rCvIKkbzYMs1MLGC3r
	 RDGrJjFPG8jjynLHCYbMhc5N2MEsgt2yTKn5ul/Xg82typ44j6hRFMrt8bv9OiLKS0
	 k6M+KIUUQs5gTzBR4y6KYd583riKBKMHar4pike4=
Received: from fx405 (fx405.security-mail.net [127.0.0.1]) by
 fx405.security-mail.net (Postfix) with ESMTP id 477FE336006; Mon, 22 Jul
 2024 11:43:47 +0200 (CEST)
Received: from srvsmtp.lin.mbt.kalray.eu (unknown [217.181.231.53]) by
 fx405.security-mail.net (Postfix) with ESMTPS id 74871335FF6; Mon, 22 Jul
 2024 11:43:46 +0200 (CEST)
Received: from junon.lan.kalrayinc.com (unknown [192.168.37.161]) by
 srvsmtp.lin.mbt.kalray.eu (Postfix) with ESMTPS id 3802240317; Mon, 22 Jul
 2024 11:43:46 +0200 (CEST)
X-Secumail-id: <15aa3.669e29d2.7154c.0>
From: ysionneau@kalrayinc.com
To: linux-kernel@vger.kernel.org
Cc: Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Yann Sionneau <ysionneau@kalrayinc.com>, Clement
 Leger <clement@clement-leger.fr>, Guillaume Thouvenin <thouveng@gmail.com>,
 Julien Villette <julien.villette@gmail.com>
Subject: [RFC PATCH v3 28/37] kvx: Add misc common routines
Date: Mon, 22 Jul 2024 11:41:39 +0200
Message-ID: <20240722094226.21602-29-ysionneau@kalrayinc.com>
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

Add some misc common routines for kvx, including: asm-offsets routines,
futex functions, i/o memory access functions.

Co-developed-by: Clement Leger <clement@clement-leger.fr>
Signed-off-by: Clement Leger <clement@clement-leger.fr>
Co-developed-by: Guillaume Thouvenin <thouveng@gmail.com>
Signed-off-by: Guillaume Thouvenin <thouveng@gmail.com>
Co-developed-by: Jonathan Borne <jborne@kalrayinc.com>
Signed-off-by: Jonathan Borne <jborne@kalrayinc.com>
Co-developed-by: Julian Vetter <jvetter@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
Co-developed-by: Julien Villette <julien.villette@gmail.com>
Signed-off-by: Julien Villette <julien.villette@gmail.com>
Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
---

Notes:
V1 -> V2: no changes

V2 -> V3: typo, indent, function renamed.
---
 arch/kvx/include/asm/futex.h  | 140 ++++++++++++++++++++++++++++++
 arch/kvx/include/asm/io.h     |  34 ++++++++
 arch/kvx/kernel/asm-offsets.c | 155 ++++++++++++++++++++++++++++++++++
 arch/kvx/kernel/io.c          |  96 +++++++++++++++++++++
 4 files changed, 425 insertions(+)
 create mode 100644 arch/kvx/include/asm/futex.h
 create mode 100644 arch/kvx/include/asm/io.h
 create mode 100644 arch/kvx/kernel/asm-offsets.c
 create mode 100644 arch/kvx/kernel/io.c

diff --git a/arch/kvx/include/asm/futex.h b/arch/kvx/include/asm/futex.h
new file mode 100644
index 0000000000000..15e2a74fa7b43
--- /dev/null
+++ b/arch/kvx/include/asm/futex.h
@@ -0,0 +1,140 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2018-2023 Kalray Inc.
+ * Authors:
+ *      Clement Leger <cleger@kalray.eu>
+ *      Yann Sionneau <ysionneau@kalray.eu>
+ *      Jonathan Borne <jborne@kalray.eu>
+ *
+ * Part of code is taken from RiscV port
+ */
+
+#ifndef _ASM_KVX_FUTEX_H
+#define _ASM_KVX_FUTEX_H
+
+#ifdef __KERNEL__
+
+#include <linux/futex.h>
+#include <linux/uaccess.h>
+
+#define __futex_atomic_op(insn, ret, oldval, uaddr, oparg) \
+{ \
+	__enable_user_access();			\
+	__asm__ __volatile__ (			\
+	"	fence\n"			\
+	"	;;\n"				\
+	"1:	lwz $r63 = 0[%[u]]\n"		\
+	"	;;\n"				\
+	"	" insn "\n"			\
+	"	;;\n"				\
+	"	acswapw 0[%[u]] = $r62r63\n"	\
+	"	;;\n"				\
+	"	cb.deqz $r62? 1b\n"		\
+	"	;;\n"				\
+	"	copyd %[ov] = $r63\n"		\
+	"	;;\n"				\
+	"2:\n"					\
+	"	.section .fixup,\"ax\"\n"	\
+	"3:	make %[r] = 2b\n"		\
+	"	;;\n"				\
+	"	make %[r] = %[e]\n"		\
+	"	igoto %[r]\n"			\
+	"	;;\n"				\
+	"	.previous\n"			\
+	"	.section __ex_table,\"a\"\n"	\
+	"	.align 8\n"			\
+	"	.dword 1b,3b\n"			\
+	"	.dword 2b,3b\n"			\
+	"	.previous\n"			\
+	: [r] "+r" (ret), [ov] "+r" (oldval)	\
+	: [u] "r" (uaddr),			\
+	  [op] "r" (oparg), [e] "i" (-EFAULT)	\
+	: "r62", "r63", "memory");		\
+	__disable_user_access();		\
+}
+
+static inline int
+arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
+{
+	int oldval = 0, ret = 0;
+
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
+	switch (op) {
+	case FUTEX_OP_SET: /* *(int *)UADDR = OPARG; */
+		__futex_atomic_op("copyd $r62 = %[op]",
+				  ret, oldval, uaddr, oparg);
+		break;
+	case FUTEX_OP_ADD: /* *(int *)UADDR += OPARG; */
+		__futex_atomic_op("addw $r62 = $r63, %[op]",
+				  ret, oldval, uaddr, oparg);
+		break;
+	case FUTEX_OP_OR: /* *(int *)UADDR |= OPARG; */
+		__futex_atomic_op("orw $r62 = $r63, %[op]",
+				  ret, oldval, uaddr, oparg);
+		break;
+	case FUTEX_OP_ANDN: /* *(int *)UADDR &= ~OPARG; */
+		__futex_atomic_op("andnw $r62 = %[op], $r63",
+				  ret, oldval, uaddr, oparg);
+		break;
+	case FUTEX_OP_XOR:
+		__futex_atomic_op("xorw $r62 = $r63, %[op]",
+				  ret, oldval, uaddr, oparg);
+		break;
+	default:
+		ret = -ENOSYS;
+	}
+
+	if (!ret)
+		*oval = oldval;
+
+	return ret;
+}
+
+static inline int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
+						u32 oldval, u32 newval)
+{
+	int ret = 0;
+
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
+	__enable_user_access();
+	__asm__ __volatile__ (
+	"	fence\n"			/* commit previous stores  */
+	"	copyd $r63 = %[ov]\n"		/* init "expect" with ov   */
+	"	copyd $r62 = %[nv]\n"		/* init "update" with nv   */
+	"	;;\n"
+	"1:    acswapw 0[%[u]] = $r62r63\n"
+	"      ;;\n"
+	"      cb.dnez $r62? 3f\n"		/* if acswap ok -> return  */
+	"      ;;\n"
+	"2:    lws $r63 = 0[%[u]]\n"		/* fail -> load old value  */
+	"      ;;\n"
+	"      compw.ne $r62 = $r63, %[ov]\n"	/* check if equal to "old" */
+	"      ;;\n"
+	"      cb.deqz $r62? 1b\n"		/* if not equal, try again */
+	"      ;;\n"
+	"3:\n"
+	"      .section .fixup,\"ax\"\n"
+	"4:    make %[r] = 3b\n"
+	"      ;;\n"
+	"      make %[r] = %[e]\n"
+	"      igoto %[r]\n"			/* goto 3b		   */
+	"      ;;\n"
+	"      .previous\n"
+	"      .section __ex_table,\"a\"\n"
+	"      .align 8\n"
+	"      .dword 1b,4b\n"
+	"      .dword 2b,4b\n"
+	".previous\n"
+	: [r] "+r" (ret)
+	: [ov] "r" (oldval), [nv] "r" (newval),
+	  [e] "i" (-EFAULT), [u] "r" (uaddr)
+	: "r62", "r63", "memory");
+	__disable_user_access();
+	*uval = oldval;
+	return ret;
+}
+
+#endif
+#endif /* _ASM_KVX_FUTEX_H */
diff --git a/arch/kvx/include/asm/io.h b/arch/kvx/include/asm/io.h
new file mode 100644
index 0000000000000..c5e458c59bbb2
--- /dev/null
+++ b/arch/kvx/include/asm/io.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_IO_H
+#define _ASM_KVX_IO_H
+
+#include <linux/types.h>
+
+#include <asm/page.h>
+#include <asm/pgtable.h>
+
+#define _PAGE_IOREMAP _PAGE_KERNEL_DEVICE
+
+/*
+ * String version of I/O memory access operations.
+ */
+extern void __memcpy_fromio(void *to, const volatile void __iomem *from,
+			    size_t count);
+extern void __memcpy_toio(volatile void __iomem *to, const void *from,
+			  size_t count);
+extern void __memset_io(volatile void __iomem *dst, int c, size_t count);
+
+#define memset_io(c, v, l)	__memset_io((c), (v), (l))
+#define memcpy_fromio(a, c, l)	__memcpy_fromio((a), (c), (l))
+#define memcpy_toio(c, a, l)	__memcpy_toio((c), (a), (l))
+
+#include <asm-generic/io.h>
+
+extern int devmem_is_allowed(unsigned long pfn);
+
+#endif	/* _ASM_KVX_IO_H */
diff --git a/arch/kvx/kernel/asm-offsets.c b/arch/kvx/kernel/asm-offsets.c
new file mode 100644
index 0000000000000..39312f9e64270
--- /dev/null
+++ b/arch/kvx/kernel/asm-offsets.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Guillaume Thouvenin
+ *            Yann Sionneau
+ */
+
+#include <linux/preempt.h>
+#include <linux/thread_info.h>
+#include <linux/kbuild.h>
+#include <linux/stddef.h>
+#include <linux/sched.h>
+#include <linux/bug.h>
+
+#include <asm/processor.h>
+#include <asm/ptrace.h>
+#include <asm/page.h>
+#include <asm/fixmap.h>
+#include <asm/page_size.h>
+#include <asm/pgtable.h>
+#include <asm/ptrace.h>
+#include <asm/tlb_defs.h>
+#include <asm/mmu_stats.h>
+#include <asm/stacktrace.h>
+
+int asm_offsets(void);
+
+int asm_offsets(void)
+{
+	BUILD_BUG_ON(sizeof(struct pt_regs) != PT_REGS_STRUCT_EXPECTED_SIZE);
+	/*
+	 * For stack alignment purposes we must make sure the pt_regs size is
+	 * a mutliple of stack_align
+	 */
+	BUILD_BUG_ON(!IS_ALIGNED(sizeof(struct pt_regs), STACK_ALIGNMENT));
+
+	/* Check that user_pt_regs size matches the beginning of pt_regs */
+	BUILD_BUG_ON((offsetof(struct user_regs_struct, spc) + sizeof(uint64_t)) !=
+		     sizeof(struct user_regs_struct));
+
+	DEFINE(FIX_GDB_MEM_BASE_IDX, FIX_GDB_BARE_DISPLACED_MEM_BASE);
+
+	/*
+	 * We allocate a pt_regs on the stack when entering the kernel.  This
+	 * ensures the alignment is sane.
+	 */
+	DEFINE(PT_SIZE_ON_STACK, sizeof(struct pt_regs));
+	DEFINE(TI_FLAGS_SIZE, sizeof(unsigned long));
+	DEFINE(QUAD_REG_SIZE, 4 * sizeof(uint64_t));
+
+	/*
+	 * When restoring registers, we do not want to restore r12
+	 * right now since this is our stack pointer. Allow to save
+	 * only $r13 by using this offset.
+	 */
+	OFFSET(PT_R12, pt_regs, r12);
+	OFFSET(PT_R13, pt_regs, r13);
+	OFFSET(PT_TP, pt_regs, tp);
+	OFFSET(PT_R14R15, pt_regs, r14);
+	OFFSET(PT_R16R17, pt_regs, r16);
+	OFFSET(PT_R18R19, pt_regs, r18);
+	OFFSET(PT_FP, pt_regs, fp);
+	OFFSET(PT_SPS, pt_regs, sps);
+
+	/* Quad description */
+	OFFSET(PT_Q0, pt_regs, r0);
+	OFFSET(PT_Q4, pt_regs, r4);
+	OFFSET(PT_Q8, pt_regs, r8);
+	OFFSET(PT_Q12, pt_regs, r12);
+	OFFSET(PT_Q16, pt_regs, r16);
+	OFFSET(PT_Q20, pt_regs, r20);
+	OFFSET(PT_Q24, pt_regs, r24);
+	OFFSET(PT_Q28, pt_regs, r28);
+	OFFSET(PT_Q32, pt_regs, r32);
+	OFFSET(PT_Q36, pt_regs, r36);
+	OFFSET(PT_R38, pt_regs, r38);
+	OFFSET(PT_Q40, pt_regs, r40);
+	OFFSET(PT_Q44, pt_regs, r44);
+	OFFSET(PT_Q48, pt_regs, r48);
+	OFFSET(PT_Q52, pt_regs, r52);
+	OFFSET(PT_Q56, pt_regs, r56);
+	OFFSET(PT_Q60, pt_regs, r60);
+	OFFSET(PT_CS_SPC_SPS_ES, pt_regs, cs);
+	OFFSET(PT_LC_LE_LS_RA, pt_regs, lc);
+	OFFSET(PT_ILR, pt_regs, ilr);
+	OFFSET(PT_ORIG_R0, pt_regs, orig_r0);
+
+	/*
+	 * Flags in thread info
+	 */
+	OFFSET(TASK_TI_FLAGS, task_struct, thread_info.flags);
+
+	/*
+	 * Stack pointer
+	 */
+	OFFSET(TASK_THREAD_KERNEL_SP, task_struct, thread.kernel_sp);
+
+	/*
+	 * Offsets to save registers in switch_to using quads
+	 */
+	OFFSET(CTX_SWITCH_RA_SP_R18_R19, task_struct, thread.ctx_switch.ra);
+	OFFSET(CTX_SWITCH_Q20, task_struct, thread.ctx_switch.r20);
+	OFFSET(CTX_SWITCH_Q24, task_struct, thread.ctx_switch.r24);
+	OFFSET(CTX_SWITCH_Q28, task_struct, thread.ctx_switch.r28);
+	OFFSET(CTX_SWITCH_FP, task_struct, thread.ctx_switch.fp);
+
+#ifdef CONFIG_ENABLE_TCA
+	OFFSET(CTX_SWITCH_TCA_REGS, task_struct, thread.ctx_switch.tca_regs[0]);
+	OFFSET(CTX_SWITCH_TCA_REGS_SAVED, task_struct,
+					thread.ctx_switch.tca_regs_saved);
+	DEFINE(TCA_REG_SIZE, sizeof(struct tca_reg));
+#endif
+
+	/* Save area offset */
+	OFFSET(TASK_THREAD_SAVE_AREA, task_struct, thread.save_area);
+
+	/* Fast tlb refill defines */
+	OFFSET(TASK_ACTIVE_MM, task_struct, active_mm);
+	OFFSET(MM_PGD, mm_struct, pgd);
+#ifdef CONFIG_KVX_DEBUG_ASN
+	OFFSET(MM_CTXT_ASN, mm_struct, context.asn);
+#endif
+
+#ifdef CONFIG_KVX_MMU_STATS
+	DEFINE(MMU_REFILL_SIZE, sizeof(struct mmu_refill_stats));
+
+	OFFSET(MMU_STATS_REFILL_USER_OFF, mmu_stats,
+	       refill[MMU_REFILL_TYPE_USER]);
+	OFFSET(MMU_STATS_REFILL_KERNEL_OFF, mmu_stats,
+	       refill[MMU_REFILL_TYPE_KERNEL]);
+	OFFSET(MMU_STATS_REFILL_KERNEL_DIRECT_OFF, mmu_stats,
+	       refill[MMU_REFILL_TYPE_KERNEL_DIRECT]);
+	OFFSET(MMU_STATS_CYCLES_BETWEEN_REFILL_OFF, mmu_stats,
+	       cycles_between_refill);
+	OFFSET(MMU_STATS_LAST_REFILL, mmu_stats, last_refill);
+
+	OFFSET(TASK_THREAD_ENTRY_TS, task_struct, thread.trap_entry_ts);
+#endif
+
+	DEFINE(ASM_PGDIR_SHIFT, PGDIR_SHIFT);
+	DEFINE(ASM_PMD_SHIFT, PMD_SHIFT);
+
+	DEFINE(ASM_PGDIR_BITS, PGDIR_BITS);
+	DEFINE(ASM_PMD_BITS, PMD_BITS);
+	DEFINE(ASM_PTE_BITS, PTE_BITS);
+
+	DEFINE(ASM_PTRS_PER_PGD, PTRS_PER_PGD);
+	DEFINE(ASM_PTRS_PER_PMD, PTRS_PER_PMD);
+	DEFINE(ASM_PTRS_PER_PTE, PTRS_PER_PTE);
+
+	DEFINE(ASM_TLB_PS, TLB_DEFAULT_PS);
+
+	return 0;
+}
diff --git a/arch/kvx/kernel/io.c b/arch/kvx/kernel/io.c
new file mode 100644
index 0000000000000..0922c1d6d0f7b
--- /dev/null
+++ b/arch/kvx/kernel/io.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * derived from arch/arm/kernel/io.c
+ *
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#include <linux/export.h>
+#include <linux/types.h>
+#include <linux/io.h>
+
+#define REPLICATE_BYTE_MASK	0x0101010101010101
+
+/*
+ * Copy data from IO memory space to "real" memory space.
+ */
+void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
+{
+	while (count && !IS_ALIGNED((unsigned long)from, 8)) {
+		*(u8 *)to = __raw_readb(from);
+		from++;
+		to++;
+		count--;
+	}
+
+	while (count >= 8) {
+		*(u64 *)to = __raw_readq(from);
+		from += 8;
+		to += 8;
+		count -= 8;
+	}
+
+	while (count) {
+		*(u8 *)to = __raw_readb(from);
+		from++;
+		to++;
+		count--;
+	}
+}
+EXPORT_SYMBOL(__memcpy_fromio);
+
+/*
+ * Copy data from "real" memory space to IO memory space.
+ */
+void __memcpy_toio(volatile void __iomem *to, const void *from, size_t count)
+{
+	while (count && !IS_ALIGNED((unsigned long)to, 8)) {
+		__raw_writeb(*(u8 *)from, to);
+		from++;
+		to++;
+		count--;
+	}
+
+	while (count >= 8) {
+		__raw_writeq(*(u64 *)from, to);
+		from += 8;
+		to += 8;
+		count -= 8;
+	}
+
+	while (count) {
+		__raw_writeb(*(u8 *)from, to);
+		from++;
+		to++;
+		count--;
+	}
+}
+EXPORT_SYMBOL(__memcpy_toio);
+
+/*
+ * "memset" on IO memory space.
+ */
+void __memset_io(volatile void __iomem *dst, int c, size_t count)
+{
+	u64 qc = __builtin_kvx_sbmm8(c, REPLICATE_BYTE_MASK);
+
+	while (count && !IS_ALIGNED((unsigned long)dst, 8)) {
+		__raw_writeb(c, dst);
+		dst++;
+		count--;
+	}
+
+	while (count >= 8) {
+		__raw_writeq(qc, dst);
+		dst += 8;
+		count -= 8;
+	}
+
+	while (count) {
+		__raw_writeb(c, dst);
+		dst++;
+		count--;
+	}
+}
+EXPORT_SYMBOL(__memset_io);
-- 
2.45.2






