Return-Path: <linux-kernel+bounces-258026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 814F6938247
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 19:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AD5B1F2135D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 17:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8837B149006;
	Sat, 20 Jul 2024 17:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZRNKnrr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6704148FF5
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 17:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721496415; cv=none; b=E/AlmyFifxQ00B1lUVBWjt5RVrsmaS2nvsOQOvd9hgezLA1f26GDRQEpd3pL71AD1MzuctxEHU6jPwWtkhRIGoAYnWp9KzzgvEGZ02N1mfuTat9UV3sK0sfLIH2qEFL6Ilkfegyy6azJ32LKbZL/KROwYMdWXFPbYPwAon4BX/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721496415; c=relaxed/simple;
	bh=4mfzfBuI5w4GYD/fit9dlYuOHBy27wsKPXlA84/NLtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+WEp7y6Uw0/paKvyfWvjAFz7k3q6fGi+vbaBtKngoqXs36GLQV9GmAG4asGFNMfHgICVn1tXBCqCWIRGYJlBONVLsZkerTwSf9zwZCIujAZbSs+aLToFHel0iQq4JJnr23RZi2ObNX5DQ5oCc70EfXEpEM+/1obuuURnsJ13rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZRNKnrr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB94C2BD10;
	Sat, 20 Jul 2024 17:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721496415;
	bh=4mfzfBuI5w4GYD/fit9dlYuOHBy27wsKPXlA84/NLtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZZRNKnrrt4f/JLNrILzEZrulIdE1aK+z6WCFBcwfHrbArWJN0twEMJCpU2bLeGbAI
	 NtpPhOx7V1C0D9fA69dZVbLiLHFmCxJ5XrRFZMsmLaxQGrA/WxoMrFqj8BKRTUGYD+
	 BRk/DejhE0/KW2u1qtzZ2BIAbH70++8IIqJkge0xK7HFDllRajPwGv6CEEHMi9tvjF
	 S4oadAj6SUTqlcoF7aj0zCQk1g6xQ6mZ2SFJYhul9K4/0De+LJFXDR6TIYG8ggc/sm
	 W8n7CfwJBgEp0qrbvT80b1o9fj1o6y1mU7tlpnJMFuU1END+IPmxoIO5u85qNsuaU+
	 HNaox/Kg5Uwpg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Clement Leger <cleger@rivosinc.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] riscv: convert bottom half of exception handling to C
Date: Sun, 21 Jul 2024 01:12:28 +0800
Message-ID: <20240720171232.1753-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240720171232.1753-1-jszhang@kernel.org>
References: <20240720171232.1753-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For readability, maintainability and future scalability, convert the
bottom half of the exception handling to C.

Mostly the assembly code is converted to C in a relatively
straightforward manner.

However, there are two modifications I need to mention:

1. the cause I.E the CSR_CAUSE value is passed to do_traps() via. 2nd
param, do_traps() doesn't get it from pt_regs because this way an extra
memory load is needed, the exception handling sits in hot code path,
every instruction matters.

2.To cope with SIFIVE_CIP_453 errata, it looks like we don't need
alternative mechanism any more after the asm->c conversion. Just
replace the excp_vect_table two entries.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/errata/sifive/errata.c       | 25 ++++++++---
 arch/riscv/include/asm/asm-prototypes.h |  1 +
 arch/riscv/include/asm/errata_list.h    |  5 +--
 arch/riscv/kernel/entry.S               | 57 +------------------------
 arch/riscv/kernel/traps.c               | 37 ++++++++++++++++
 5 files changed, 61 insertions(+), 64 deletions(-)

diff --git a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/sifive/errata.c
index 716cfedad3a2..bbba99f207ca 100644
--- a/arch/riscv/errata/sifive/errata.c
+++ b/arch/riscv/errata/sifive/errata.c
@@ -10,9 +10,14 @@
 #include <linux/bug.h>
 #include <asm/patch.h>
 #include <asm/alternative.h>
+#include <asm/csr.h>
 #include <asm/vendorid_list.h>
 #include <asm/errata_list.h>
 
+extern void (*excp_vect_table[])(struct pt_regs *regs);
+extern void sifive_cip_453_insn_fault_trp(struct pt_regs *regs);
+extern void sifive_cip_453_page_fault_trp(struct pt_regs *regs);
+
 struct errata_info_t {
 	char name[32];
 	bool (*check_func)(unsigned long  arch_id, unsigned long impid);
@@ -20,6 +25,9 @@ struct errata_info_t {
 
 static bool errata_cip_453_check_func(unsigned long  arch_id, unsigned long impid)
 {
+	if (!IS_ENABLED(CONFIG_ERRATA_SIFIVE_CIP_453))
+		return false;
+
 	/*
 	 * Affected cores:
 	 * Architecture ID: 0x8000000000000007
@@ -51,10 +59,6 @@ static bool errata_cip_1200_check_func(unsigned long  arch_id, unsigned long imp
 }
 
 static struct errata_info_t errata_list[ERRATA_SIFIVE_NUMBER] = {
-	{
-		.name = "cip-453",
-		.check_func = errata_cip_453_check_func
-	},
 	{
 		.name = "cip-1200",
 		.check_func = errata_cip_1200_check_func
@@ -62,11 +66,20 @@ static struct errata_info_t errata_list[ERRATA_SIFIVE_NUMBER] = {
 };
 
 static u32 __init_or_module sifive_errata_probe(unsigned long archid,
-						unsigned long impid)
+						unsigned long impid,
+						unsigned int stage)
 {
 	int idx;
 	u32 cpu_req_errata = 0;
 
+	if (stage == RISCV_ALTERNATIVES_BOOT) {
+		if (IS_ENABLED(CONFIG_MMU) &&
+		    errata_cip_453_check_func(archid, impid)) {
+			excp_vect_table[EXC_INST_ACCESS] = sifive_cip_453_insn_fault_trp;
+			excp_vect_table[EXC_INST_PAGE_FAULT] = sifive_cip_453_page_fault_trp;
+		}
+	}
+
 	for (idx = 0; idx < ERRATA_SIFIVE_NUMBER; idx++)
 		if (errata_list[idx].check_func(archid, impid))
 			cpu_req_errata |= (1U << idx);
@@ -99,7 +112,7 @@ void sifive_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
 	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
 		return;
 
-	cpu_req_errata = sifive_errata_probe(archid, impid);
+	cpu_req_errata = sifive_errata_probe(archid, impid, stage);
 
 	for (alt = begin; alt < end; alt++) {
 		if (alt->vendor_id != SIFIVE_VENDOR_ID)
diff --git a/arch/riscv/include/asm/asm-prototypes.h b/arch/riscv/include/asm/asm-prototypes.h
index cd627ec289f1..c6691e9032dd 100644
--- a/arch/riscv/include/asm/asm-prototypes.h
+++ b/arch/riscv/include/asm/asm-prototypes.h
@@ -55,5 +55,6 @@ DECLARE_DO_ERROR_INFO(do_trap_break);
 asmlinkage void handle_bad_stack(struct pt_regs *regs);
 asmlinkage void do_page_fault(struct pt_regs *regs);
 asmlinkage void do_irq(struct pt_regs *regs);
+asmlinkage void do_traps(struct pt_regs *regs, unsigned long cause);
 
 #endif /* _ASM_RISCV_PROTOTYPES_H */
diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index 7c8a71a526a3..95b79afc4061 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -17,9 +17,8 @@
 #endif
 
 #ifdef CONFIG_ERRATA_SIFIVE
-#define	ERRATA_SIFIVE_CIP_453 0
-#define	ERRATA_SIFIVE_CIP_1200 1
-#define	ERRATA_SIFIVE_NUMBER 2
+#define	ERRATA_SIFIVE_CIP_1200 0
+#define	ERRATA_SIFIVE_NUMBER 1
 #endif
 
 #ifdef CONFIG_ERRATA_THEAD
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 81dec627a8d4..37c3c2068fef 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -83,36 +83,10 @@ SYM_CODE_START(handle_exception)
 	/* Load the kernel shadow call stack pointer if coming from userspace */
 	scs_load_current_if_task_changed s5
 
-#ifdef CONFIG_RISCV_ISA_V_PREEMPTIVE
-	move a0, sp
-	call riscv_v_context_nesting_start
-#endif
 	move a0, sp /* pt_regs */
-
-	/*
-	 * MSB of cause differentiates between
-	 * interrupts and exceptions
-	 */
-	bge s4, zero, 1f
-
-	/* Handle interrupts */
-	call do_irq
+	move a1, s4 /* cause */
+	call do_traps
 	j ret_from_exception
-1:
-	/* Handle other exceptions */
-	slli t0, s4, RISCV_LGPTR
-	la t1, excp_vect_table
-	la t2, excp_vect_table_end
-	add t0, t1, t0
-	/* Check if exception code lies within bounds */
-	bgeu t0, t2, 3f
-	REG_L t1, 0(t0)
-2:	jalr t1
-	j ret_from_exception
-3:
-
-	la t1, do_trap_unknown
-	j 2b
 SYM_CODE_END(handle_exception)
 ASM_NOKPROBE(handle_exception)
 
@@ -329,33 +303,6 @@ SYM_FUNC_START(__switch_to)
 	ret
 SYM_FUNC_END(__switch_to)
 
-#ifndef CONFIG_MMU
-#define do_page_fault do_trap_unknown
-#endif
-
-	.section ".rodata"
-	.align LGREG
-	/* Exception vector table */
-SYM_DATA_START_LOCAL(excp_vect_table)
-	RISCV_PTR do_trap_insn_misaligned
-	ALT_INSN_FAULT(RISCV_PTR do_trap_insn_fault)
-	RISCV_PTR do_trap_insn_illegal
-	RISCV_PTR do_trap_break
-	RISCV_PTR do_trap_load_misaligned
-	RISCV_PTR do_trap_load_fault
-	RISCV_PTR do_trap_store_misaligned
-	RISCV_PTR do_trap_store_fault
-	RISCV_PTR do_trap_ecall_u /* system call */
-	RISCV_PTR do_trap_ecall_s
-	RISCV_PTR do_trap_unknown
-	RISCV_PTR do_trap_ecall_m
-	/* instruciton page fault */
-	ALT_PAGE_FAULT(RISCV_PTR do_page_fault)
-	RISCV_PTR do_page_fault   /* load page fault */
-	RISCV_PTR do_trap_unknown
-	RISCV_PTR do_page_fault   /* store page fault */
-SYM_DATA_END_LABEL(excp_vect_table, SYM_L_LOCAL, excp_vect_table_end)
-
 #ifndef CONFIG_MMU
 SYM_DATA_START(__user_rt_sigreturn)
 	li a7, __NR_rt_sigreturn
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 3d1f84cb6eac..3eaa7c72f2be 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -390,6 +390,43 @@ asmlinkage void noinstr do_irq(struct pt_regs *regs)
 	irqentry_exit(regs, state);
 }
 
+void (*excp_vect_table[])(struct pt_regs *regs) __ro_after_init = {
+	do_trap_insn_misaligned,	/*  0 Instruction address misaligned */
+	do_trap_insn_fault,		/*  1 Instruction access fault */
+	do_trap_insn_illegal,		/*  2 Illegal instruction */
+	do_trap_break,			/*  3 Breakpoint */
+	do_trap_load_misaligned,	/*  4 Load address misaligned */
+	do_trap_load_fault,		/*  5 Load access fault */
+	do_trap_store_misaligned,	/*  6 Store/AMO address misaligned */
+	do_trap_store_fault,		/*  7 Store/AMO access fault */
+	do_trap_ecall_u,		/*  8 Environment call from U-mode */
+	do_trap_ecall_s,		/*  9 Environment call from S-mode */
+	do_trap_unknown,		/* 10 Reserved */
+	do_trap_ecall_m,		/* 11 Environment call from M-mode */
+#ifdef CONFIG_MMU
+	do_page_fault,			/* 12 Instruciton page fault */
+	do_page_fault,			/* 13 Load page fault */
+	do_trap_unknown,		/* 14 Reserved */
+	do_page_fault,			/* 15 Store/AMO page fault */
+#endif
+};
+
+asmlinkage void noinstr do_traps(struct pt_regs *regs, unsigned long cause)
+{
+#ifdef CONFIG_RISCV_ISA_V_PREEMPTIVE
+	riscv_v_context_nesting_start(regs);
+#endif
+	if (cause & CAUSE_IRQ_FLAG) {
+		do_irq(regs);
+	} else {
+		if (cause >= ARRAY_SIZE(excp_vect_table)) {
+			do_trap_unknown(regs);
+			return;
+		}
+		excp_vect_table[cause](regs);
+	}
+}
+
 #ifdef CONFIG_GENERIC_BUG
 int is_valid_bugaddr(unsigned long pc)
 {
-- 
2.43.0


