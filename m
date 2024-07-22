Return-Path: <linux-kernel+bounces-258755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30446938C66
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83424B21A04
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC0D170826;
	Mon, 22 Jul 2024 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="lM23Y7oQ"
Received: from smtpout42.security-mail.net (smtpout42.security-mail.net [85.31.212.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC2D16F0D6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.31.212.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641436; cv=none; b=bfYAs1sxAur2BMOvEqIF8HksLTolmhOFmV+wkXxyNFra725aQRgrxK7lHOWBG+jTFaPQLut0XCCu00mbO6A7LrQXLUSFTZazRI1zuNNTbzGAFbmnhAIc4uosLI/33ELy976PtDFaqsw5bA9R3fT4OavGJbVokYMDXbmbfbCrB2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641436; c=relaxed/simple;
	bh=FBe5Uuw5SfUjNBt/sxJT44FNRpJhs/lZU+FiDDZ0mgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FqKk8xzgo0Km7w8ki5POtDgcpb+0eBn42YjXiT6pbzaRffPMnAN6ltbGczLnRDnPOeZpepQ4vaoBSjrqGrTo4Y/R+WyXAgorzu2XQvdbbHP56h/7ZGDUnMzJcG4wDrmB8fDKW/Hr673WtY4+//b5XnVfAEazFmLg7HLxb2F4kfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=lM23Y7oQ; arc=none smtp.client-ip=85.31.212.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx302.security-mail.net (Postfix) with ESMTP id A745A80BD8A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:43:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1721641431;
	bh=FBe5Uuw5SfUjNBt/sxJT44FNRpJhs/lZU+FiDDZ0mgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lM23Y7oQK+AeQyzvhjikYoAxQUJe9hzXRS0bPHNxe6lexxT5UWen1+t4GhUhzWJEG
	 6q6uGoWcemzckOcfA5rUkmp64EGwSdHziyoECg8SDuyWZkN56wNI6uTF9oQYyrmnfP
	 jOuuZytoN/YNfslPtxOzZwD1wiZRBRNnV0vZWBM8=
Received: from fx302 (localhost [127.0.0.1]) by fx302.security-mail.net
 (Postfix) with ESMTP id 7A74E80B55D; Mon, 22 Jul 2024 11:43:51 +0200 (CEST)
Received: from srvsmtp.lin.mbt.kalray.eu (unknown [217.181.231.53]) by
 fx302.security-mail.net (Postfix) with ESMTPS id E499F80B27D; Mon, 22 Jul
 2024 11:43:50 +0200 (CEST)
Received: from junon.lan.kalrayinc.com (unknown [192.168.37.161]) by
 srvsmtp.lin.mbt.kalray.eu (Postfix) with ESMTPS id ACC4C40317; Mon, 22 Jul
 2024 11:43:50 +0200 (CEST)
X-Secumail-id: <ae50.669e29d6.e2494.0>
From: ysionneau@kalrayinc.com
To: linux-kernel@vger.kernel.org
Cc: Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Yann Sionneau <ysionneau@kalrayinc.com>, Clement
 Leger <clement@clement-leger.fr>, Guillaume Thouvenin <thouveng@gmail.com>,
 Marius Gligor <mgligor@kalrayinc.com>
Subject: [RFC PATCH v3 32/37] kvx: Add debugging related support
Date: Mon, 22 Jul 2024 11:41:43 +0200
Message-ID: <20240722094226.21602-33-ysionneau@kalrayinc.com>
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

Add kvx support for debugging

Co-developed-by: Clement Leger <clement@clement-leger.fr>
Signed-off-by: Clement Leger <clement@clement-leger.fr>
Co-developed-by: Guillaume Thouvenin <thouveng@gmail.com>
Signed-off-by: Guillaume Thouvenin <thouveng@gmail.com>
Co-developed-by: Julian Vetter <jvetter@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
Co-developed-by: Marius Gligor <mgligor@kalrayinc.com>
Signed-off-by: Marius Gligor <mgligor@kalrayinc.com>
Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
---

Notes:
V1 -> V2: No changes
V2 -> V3:
- remove useless do { } while (0) for one-line macro
- change function arg order related to struct pt_regs
  because of 'generic entry' usage
- improved comments for patch_insns_percpu
---
 arch/kvx/include/asm/debug.h      |  36 ++++++
 arch/kvx/include/asm/insns.h      |  16 +++
 arch/kvx/include/asm/insns_defs.h | 185 ++++++++++++++++++++++++++++++
 arch/kvx/kernel/break_hook.c      |  76 ++++++++++++
 arch/kvx/kernel/debug.c           |  54 +++++++++
 arch/kvx/kernel/insns.c           | 166 +++++++++++++++++++++++++++
 6 files changed, 533 insertions(+)
 create mode 100644 arch/kvx/include/asm/debug.h
 create mode 100644 arch/kvx/include/asm/insns.h
 create mode 100644 arch/kvx/include/asm/insns_defs.h
 create mode 100644 arch/kvx/kernel/break_hook.c
 create mode 100644 arch/kvx/kernel/debug.c
 create mode 100644 arch/kvx/kernel/insns.c

diff --git a/arch/kvx/include/asm/debug.h b/arch/kvx/include/asm/debug.h
new file mode 100644
index 0000000000000..6eea3fafde5e8
--- /dev/null
+++ b/arch/kvx/include/asm/debug.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef __ASM_KVX_DEBUG_HOOK_H_
+#define __ASM_KVX_DEBUG_HOOK_H_
+
+/**
+ * enum debug_ret - Break return value
+ * @DEBUG_HOOK_HANDLED: Hook handled successfully
+ * @DEBUG_HOOK_IGNORED: Hook call has been ignored
+ */
+enum debug_ret {
+	DEBUG_HOOK_HANDLED = 0,
+	DEBUG_HOOK_IGNORED = 1,
+};
+
+/**
+ * struct debug_hook - Debug hook description
+ * @node: List node
+ * @handler: handler called on debug entry
+ * @mode: Hook mode (user/kernel)
+ */
+struct debug_hook {
+	struct list_head node;
+	int (*handler)(struct pt_regs *regs, u64 ea);
+	u8 mode;
+};
+
+void debug_handler(struct pt_regs *regs, u64 ea);
+void debug_hook_register(struct debug_hook *dbg_hook);
+void debug_hook_unregister(struct debug_hook *dbg_hook);
+
+#endif /* __ASM_KVX_DEBUG_HOOK_H_ */
diff --git a/arch/kvx/include/asm/insns.h b/arch/kvx/include/asm/insns.h
new file mode 100644
index 0000000000000..36a9e8335ce88
--- /dev/null
+++ b/arch/kvx/include/asm/insns.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_INSNS_H
+#define _ASM_KVX_INSNS_H
+
+int kvx_insns_write_nostop(u32 *insns, u8 insns_len, u32 *insn_addr);
+
+int kvx_insns_write(u32 *insns, unsigned long insns_len, u32 *addr);
+
+int kvx_insns_read(u32 *insns, unsigned long insns_len, u32 *addr);
+
+#endif
diff --git a/arch/kvx/include/asm/insns_defs.h b/arch/kvx/include/asm/insns_defs.h
new file mode 100644
index 0000000000000..806fb10b62a9c
--- /dev/null
+++ b/arch/kvx/include/asm/insns_defs.h
@@ -0,0 +1,185 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Guillaume Thouvenin
+ */
+
+#ifndef __ASM_KVX_INSNS_DEFS_H_
+#define __ASM_KVX_INSNS_DEFS_H_
+
+#include <linux/bits.h>
+
+#ifndef __ASSEMBLY__
+static inline int check_signed_imm(long long imm, int bits)
+{
+	long long min, max;
+
+	min = -BIT_ULL(bits - 1);
+	max = BIT_ULL(bits - 1) - 1;
+	if (imm < min || imm > max)
+		return 1;
+
+	return 0;
+}
+#endif /* __ASSEMBLY__ */
+
+#define BITMASK(bits)		(BIT_ULL(bits) - 1)
+
+#define KVX_INSN_SYLLABLE_WIDTH 4
+
+#define IS_INSN(__insn, __mnemo) \
+	((__insn & KVX_INSN_ ## __mnemo ## _MASK_0) == \
+	 KVX_INSN_ ## __mnemo ## _OPCODE_0)
+
+#define INSN_SIZE(__insn) \
+	(KVX_INSN_ ## __insn ## _SIZE * KVX_INSN_SYLLABLE_WIDTH)
+
+/* Values for general registers */
+#define KVX_REG_R0	0
+#define KVX_REG_R1	1
+#define KVX_REG_R2	2
+#define KVX_REG_R3	3
+#define KVX_REG_R4	4
+#define KVX_REG_R5	5
+#define KVX_REG_R6	6
+#define KVX_REG_R7	7
+#define KVX_REG_R8	8
+#define KVX_REG_R9	9
+#define KVX_REG_R10	10
+#define KVX_REG_R11	11
+#define KVX_REG_R12	12
+#define KVX_REG_SP	12
+#define KVX_REG_R13	13
+#define KVX_REG_TP	13
+#define KVX_REG_R14	14
+#define KVX_REG_FP	14
+#define KVX_REG_R15	15
+#define KVX_REG_R16	16
+#define KVX_REG_R17	17
+#define KVX_REG_R18	18
+#define KVX_REG_R19	19
+#define KVX_REG_R20	20
+#define KVX_REG_R21	21
+#define KVX_REG_R22	22
+#define KVX_REG_R23	23
+#define KVX_REG_R24	24
+#define KVX_REG_R25	25
+#define KVX_REG_R26	26
+#define KVX_REG_R27	27
+#define KVX_REG_R28	28
+#define KVX_REG_R29	29
+#define KVX_REG_R30	30
+#define KVX_REG_R31	31
+#define KVX_REG_R32	32
+#define KVX_REG_R33	33
+#define KVX_REG_R34	34
+#define KVX_REG_R35	35
+#define KVX_REG_R36	36
+#define KVX_REG_R37	37
+#define KVX_REG_R38	38
+#define KVX_REG_R39	39
+#define KVX_REG_R40	40
+#define KVX_REG_R41	41
+#define KVX_REG_R42	42
+#define KVX_REG_R43	43
+#define KVX_REG_R44	44
+#define KVX_REG_R45	45
+#define KVX_REG_R46	46
+#define KVX_REG_R47	47
+#define KVX_REG_R48	48
+#define KVX_REG_R49	49
+#define KVX_REG_R50	50
+#define KVX_REG_R51	51
+#define KVX_REG_R52	52
+#define KVX_REG_R53	53
+#define KVX_REG_R54	54
+#define KVX_REG_R55	55
+#define KVX_REG_R56	56
+#define KVX_REG_R57	57
+#define KVX_REG_R58	58
+#define KVX_REG_R59	59
+#define KVX_REG_R60	60
+#define KVX_REG_R61	61
+#define KVX_REG_R62	62
+#define KVX_REG_R63	63
+
+/* Value for bitfield parallel */
+#define KVX_INSN_PARALLEL_EOB	0x0
+#define KVX_INSN_PARALLEL_NONE	0x1
+
+#define KVX_INSN_PARALLEL(__insn)       (((__insn) >> 31) & 0x1)
+
+#define KVX_INSN_MAKE_IMM64_SIZE 3
+#define KVX_INSN_MAKE_IMM64_W64_CHECK(__val) \
+	(check_signed_imm(__val, 64))
+#define KVX_INSN_MAKE_IMM64_MASK_0 0xff030000
+#define KVX_INSN_MAKE_IMM64_OPCODE_0 0xe0000000
+#define KVX_INSN_MAKE_IMM64_SYLLABLE_0(__rw, __w64) \
+	(KVX_INSN_MAKE_IMM64_OPCODE_0 | (((__rw) & 0x3f) << 18) | (((__w64) & 0x3ff) << 6))
+#define KVX_INSN_MAKE_IMM64_MASK_1 0xe0000000
+#define KVX_INSN_MAKE_IMM64_OPCODE_1 0x80000000
+#define KVX_INSN_MAKE_IMM64_SYLLABLE_1(__w64) \
+	(KVX_INSN_MAKE_IMM64_OPCODE_1 | (((__w64) >> 10) & 0x7ffffff))
+#define KVX_INSN_MAKE_IMM64_SYLLABLE_2(__p, __w64) \
+	(((__p) << 31) | (((__w64) >> 37) & 0x7ffffff))
+#define KVX_INSN_MAKE_IMM64(__buf, __p, __rw, __w64) \
+do { \
+	(__buf)[0] = KVX_INSN_MAKE_IMM64_SYLLABLE_0(__rw, __w64); \
+	(__buf)[1] = KVX_INSN_MAKE_IMM64_SYLLABLE_1(__w64); \
+	(__buf)[2] = KVX_INSN_MAKE_IMM64_SYLLABLE_2(__p, __w64); \
+} while (0)
+
+#define KVX_INSN_ICALL_SIZE 1
+#define KVX_INSN_ICALL_MASK_0 0x7ffc0000
+#define KVX_INSN_ICALL_OPCODE_0 0xfdc0000
+#define KVX_INSN_ICALL_SYLLABLE_0(__p, __rz) \
+	(KVX_INSN_ICALL_OPCODE_0 | ((__p) << 31) | ((__rz) & 0x3f))
+#define KVX_INSN_ICALL(__buf, __p, __rz) \
+	(__buf)[0] = KVX_INSN_ICALL_SYLLABLE_0(__p, __rz);
+
+#define KVX_INSN_IGOTO_SIZE 1
+#define KVX_INSN_IGOTO_MASK_0 0x7ffc0000
+#define KVX_INSN_IGOTO_OPCODE_0 0xfd80000
+#define KVX_INSN_IGOTO_SYLLABLE_0(__p, __rz) \
+	(KVX_INSN_IGOTO_OPCODE_0 | ((__p) << 31) | ((__rz) & 0x3f))
+#define KVX_INSN_IGOTO(__buf, __p, __rz) \
+	(__buf)[0] = KVX_INSN_IGOTO_SYLLABLE_0(__p, __rz);
+
+#define KVX_INSN_CALL_SIZE 1
+#define KVX_INSN_CALL_PCREL27_CHECK(__val) \
+	(((__val) & BITMASK(2)) || check_signed_imm((__val) >> 2, 27))
+#define KVX_INSN_CALL_MASK_0 0x78000000
+#define KVX_INSN_CALL_OPCODE_0 0x18000000
+#define KVX_INSN_CALL_SYLLABLE_0(__p, __pcrel27) \
+	(KVX_INSN_CALL_OPCODE_0 | ((__p) << 31) | (((__pcrel27) >> 2) & 0x7ffffff))
+#define KVX_INSN_CALL(__buf, __p, __pcrel27) \
+	(__buf)[0] = KVX_INSN_CALL_SYLLABLE_0(__p, __pcrel27);
+
+#define KVX_INSN_GOTO_SIZE 1
+#define KVX_INSN_GOTO_PCREL27_CHECK(__val) \
+	(((__val) & BITMASK(2)) || check_signed_imm((__val) >> 2, 27))
+#define KVX_INSN_GOTO_MASK_0 0x78000000
+#define KVX_INSN_GOTO_OPCODE_0 0x10000000
+#define KVX_INSN_GOTO_SYLLABLE_0(__p, __pcrel27) \
+	(KVX_INSN_GOTO_OPCODE_0 | ((__p) << 31) | (((__pcrel27) >> 2) & 0x7ffffff))
+#define KVX_INSN_GOTO(__buf, __p, __pcrel27) \
+	(__buf)[0] = KVX_INSN_GOTO_SYLLABLE_0(__p, __pcrel27);
+
+#define KVX_INSN_NOP_SIZE 1
+#define KVX_INSN_NOP_MASK_0 0x7f03f000
+#define KVX_INSN_NOP_OPCODE_0 0x7f03f000
+#define KVX_INSN_NOP_SYLLABLE_0(__p) \
+	(KVX_INSN_NOP_OPCODE_0 | ((__p) << 31))
+#define KVX_INSN_NOP(__buf, __p) \
+	(__buf)[0] = KVX_INSN_NOP_SYLLABLE_0(__p);
+
+#define KVX_INSN_SET_SIZE 1
+#define KVX_INSN_SET_MASK_0 0x7ffc0000
+#define KVX_INSN_SET_OPCODE_0 0xfc00000
+#define KVX_INSN_SET_SYLLABLE_0(__p, __systemT3, __rz) \
+	(KVX_INSN_SET_OPCODE_0 | ((__p) << 31) | (((__systemT3) & 0x1ff) << 6) | ((__rz) & 0x3f))
+#define KVX_INSN_SET(__buf, __p, __systemT3, __rz) \
+	(__buf)[0] = KVX_INSN_SET_SYLLABLE_0(__p, __systemT3, __rz);
+
+#endif /* __ASM_KVX_INSNS_DEFS_H_ */
diff --git a/arch/kvx/kernel/break_hook.c b/arch/kvx/kernel/break_hook.c
new file mode 100644
index 0000000000000..a517b40804419
--- /dev/null
+++ b/arch/kvx/kernel/break_hook.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#include <linux/list.h>
+#include <linux/rculist.h>
+#include <linux/spinlock.h>
+#include <linux/rcupdate.h>
+
+#include <asm/traps.h>
+#include <asm/processor.h>
+#include <asm/break_hook.h>
+
+static DEFINE_SPINLOCK(debug_hook_lock);
+static LIST_HEAD(user_break_hook);
+static LIST_HEAD(kernel_break_hook);
+
+void kvx_skip_break_insn(struct pt_regs *regs)
+{
+	regs->spc += KVX_BREAK_INSN_SIZE;
+}
+
+int break_hook_handler(struct pt_regs *regs, uint64_t es)
+{
+	int (*fn)(struct pt_regs *regs, struct break_hook *brk_hook) = NULL;
+	struct break_hook *tmp_hook, *hook = NULL;
+	struct list_head *list;
+	unsigned long flags;
+	u32 idx;
+
+	if (trap_sfri(es) != KVX_TRAP_SFRI_SET ||
+	    trap_sfrp(es) != KVX_SFR_VSFR0)
+		return BREAK_HOOK_ERROR;
+
+	idx = trap_gprp(es);
+	list = user_mode(regs) ? &user_break_hook : &kernel_break_hook;
+
+	local_irq_save(flags);
+	list_for_each_entry_rcu(tmp_hook, list, node) {
+		if (idx == tmp_hook->id) {
+			hook = tmp_hook;
+			break;
+		}
+	}
+	local_irq_restore(flags);
+
+	if (!hook)
+		return BREAK_HOOK_ERROR;
+
+	fn = hook->handler;
+	return fn(regs, hook);
+}
+
+void break_hook_register(struct break_hook *brk_hook)
+{
+	struct list_head *list;
+
+	if (brk_hook->mode == MODE_USER)
+		list = &user_break_hook;
+	else
+		list = &kernel_break_hook;
+
+	spin_lock(&debug_hook_lock);
+	list_add_rcu(&brk_hook->node, list);
+	spin_unlock(&debug_hook_lock);
+}
+
+void break_hook_unregister(struct break_hook *brk_hook)
+{
+	spin_lock(&debug_hook_lock);
+	list_del_rcu(&brk_hook->node);
+	spin_unlock(&debug_hook_lock);
+	synchronize_rcu();
+}
diff --git a/arch/kvx/kernel/debug.c b/arch/kvx/kernel/debug.c
new file mode 100644
index 0000000000000..cdd9286684a15
--- /dev/null
+++ b/arch/kvx/kernel/debug.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#include <linux/entry-common.h>
+#include <linux/list.h>
+#include <linux/rculist.h>
+#include <linux/spinlock.h>
+#include <linux/rcupdate.h>
+
+#include <asm/debug.h>
+
+static DEFINE_SPINLOCK(debug_hook_lock);
+static LIST_HEAD(user_debug_hook);
+static LIST_HEAD(kernel_debug_hook);
+
+static struct list_head *debug_hook_list(bool user_mode)
+{
+	return user_mode ? &user_debug_hook : &kernel_debug_hook;
+}
+
+void debug_handler(struct pt_regs *regs, u64 ea)
+{
+	int ret;
+	struct debug_hook *hook;
+	struct list_head *list = debug_hook_list(user_mode(regs));
+
+	list_for_each_entry_rcu(hook, list, node) {
+		ret = hook->handler(regs, ea);
+		if (ret == DEBUG_HOOK_HANDLED)
+			return;
+	}
+
+	panic("Entered debug but no requester !");
+}
+
+void debug_hook_register(struct debug_hook *dbg_hook)
+{
+	struct list_head *list = debug_hook_list(dbg_hook->mode == MODE_USER);
+
+	spin_lock(&debug_hook_lock);
+	list_add_rcu(&dbg_hook->node, list);
+	spin_unlock(&debug_hook_lock);
+}
+
+void debug_hook_unregister(struct debug_hook *dbg_hook)
+{
+	spin_lock(&debug_hook_lock);
+	list_del_rcu(&dbg_hook->node);
+	spin_unlock(&debug_hook_lock);
+	synchronize_rcu();
+}
diff --git a/arch/kvx/kernel/insns.c b/arch/kvx/kernel/insns.c
new file mode 100644
index 0000000000000..dfdf33dfbce3a
--- /dev/null
+++ b/arch/kvx/kernel/insns.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Yann Sionneau
+ *            Marius Gligor
+ *            Guillaume Thouvenin
+ */
+
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/atomic.h>
+#include <linux/cpumask.h>
+#include <linux/uaccess.h>
+#include <linux/stop_machine.h>
+
+#include <asm/cacheflush.h>
+#include <asm/insns_defs.h>
+#include <asm/fixmap.h>
+
+struct insns_patch {
+	atomic_t cpu_count;
+	u32 *addr;
+	u32 *insns;
+	unsigned long insns_len;
+};
+
+static void *insn_patch_map(void *addr)
+{
+	unsigned long uintaddr = (uintptr_t) addr;
+	bool module = !core_kernel_text(uintaddr);
+	struct page *page;
+
+	if (module && IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
+		page = vmalloc_to_page(addr);
+	else
+		return addr;
+
+	BUG_ON(!page);
+	return (void *)set_fixmap_offset(FIX_TEXT_PATCH, page_to_phys(page) +
+			(uintaddr & ~PAGE_MASK));
+}
+
+static void insn_patch_unmap(void)
+{
+	clear_fixmap(FIX_TEXT_PATCH);
+}
+
+int kvx_insns_write_nostop(u32 *insns, u8 insns_len, u32 *insn_addr)
+{
+	unsigned long current_insn_addr = (unsigned long) insn_addr;
+	unsigned long len_remain = insns_len;
+	unsigned long next_insn_page, patch_len;
+	void *map_patch_addr;
+	int ret = 0;
+
+	do {
+		/* Compute next upper page boundary */
+		next_insn_page = (current_insn_addr + PAGE_SIZE) & PAGE_MASK;
+
+		patch_len = min(next_insn_page - current_insn_addr, len_remain);
+		len_remain -= patch_len;
+
+		/* Map & patch insns */
+		map_patch_addr = insn_patch_map((void *) current_insn_addr);
+		ret = copy_to_kernel_nofault(map_patch_addr, insns, patch_len);
+		if (ret)
+			break;
+
+		insns = (void *) insns + patch_len;
+		current_insn_addr = next_insn_page;
+
+	} while (len_remain);
+
+	insn_patch_unmap();
+
+	/*
+	 * Flush & invalidate L2 + L1 icache to reload instructions from memory
+	 * L2 wbinval is necessary because we write through DEVICE cache policy
+	 * mapping which is uncached therefore L2 is bypassed
+	 */
+	wbinval_icache_range(virt_to_phys(insn_addr), insns_len);
+
+	return ret;
+}
+
+/* This function is called by all CPUs in parallel */
+static int patch_insns_percpu(void *data)
+{
+	struct insns_patch *ip = data;
+	unsigned long insn_addr = (unsigned long) ip->addr;
+	int ret;
+
+	/* Only the first CPU writes the instruction(s) */
+	if (atomic_inc_return(&ip->cpu_count) == 1) {
+
+		/*
+		 * This will write the instruction(s) through uncached mapping
+		 * and then inval all PE L1d$ lines.
+		 * It will after Invalid current PE L1i$ lines.
+		 * Therefore cache coherency is handled for the calling CPU.
+		 */
+		ret = kvx_insns_write_nostop(ip->insns, ip->insns_len,
+					     insn_addr);
+		/*
+		 * Increment once more to signal that instructions have been written
+		 * to memory.
+		 */
+		atomic_inc(&ip->cpu_count);
+
+		return ret;
+	}
+
+	/*
+	 * Synchronization point: remaining CPUs need to wait for the first
+	 * CPU to complete patching the instruction(s).
+	 * The completion is signaled when the counter reaches
+	 * `num_online_cpus + 1`: meaning that every CPU has entered this
+	 * function and the first CPU has completed its operations.
+	 */
+	while (atomic_read(&ip->cpu_count) <= num_online_cpus())
+		cpu_relax();
+
+	/*
+	 * Other CPUs simply invalidate their L1 I-cache to reload
+	 * from memory. Their L1 D-cache have
+	 * already been invalidated by the kvx_insns_write_nostop() call.
+	 */
+	l1_inval_icache_range(insn_addr, insn_addr + ip->insns_len);
+	return 0;
+}
+
+/**
+ * kvx_insns_write() Patch instructions at a specified address
+ * @insns: Instructions to be written at @addr
+ * @insns_len: Size of instructions to patch
+ * @addr: Address of the first instruction to patch
+ */
+int kvx_insns_write(u32 *insns, unsigned long insns_len, u32 *addr)
+{
+	struct insns_patch ip = {
+		.cpu_count = ATOMIC_INIT(0),
+		.addr = addr,
+		.insns = insns,
+		.insns_len = insns_len
+	};
+
+	if (!insns_len)
+		return -EINVAL;
+
+	if (!IS_ALIGNED((unsigned long) addr, KVX_INSN_SYLLABLE_WIDTH))
+		return -EINVAL;
+
+	/*
+	 * Function name is a "bit" misleading. while being named
+	 * stop_machine, this function does not stop the machine per se
+	 * but execute the provided function on all CPU in a safe state.
+	 */
+	return stop_machine(patch_insns_percpu, &ip, cpu_online_mask);
+}
+
+int kvx_insns_read(u32 *insns, unsigned long insns_len, u32 *addr)
+{
+	l1_inval_dcache_range((unsigned long)addr, insns_len);
+	return copy_from_kernel_nofault(insns, addr, insns_len);
+}
-- 
2.45.2






