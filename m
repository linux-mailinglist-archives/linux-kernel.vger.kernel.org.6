Return-Path: <linux-kernel+bounces-258029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E3E93824A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 19:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56C551F21407
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 17:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54D1149C6C;
	Sat, 20 Jul 2024 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mo1NidTg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27160149C59
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721496421; cv=none; b=Ou2mu+zUyOidKoKcaxNmElGW4p6aM8FoF0snZ+3h7XDVoqxvIBGTuqxQufAxpm6SY6MTh5lKU7Z8Y3htBESuhp8UugYCPG2Xa1DDSXq44IJv6/nANvOiqjcwXJvQbKN5cIY7mlj133xmoe23WVsYuTary6J9TdjxcmMkdnaddjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721496421; c=relaxed/simple;
	bh=Y6v1+nAyzX6PLWXUQO4fYkr+VRI6pL0daNUbphTp9Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RCh0+j4b4qenlPET4HywE/7Qh8+yR9YUDKQ3CHX5dxQmSyHXONRpJbwPl/+kKFCXMDIvRacWrAS+ebr7ENaBwaM47ecYpsSZcTa9/0/RYhSYgouAZnhS1KoIg+tmmpeV6EZJke8pUK8MpEisxDcNSu+NH5maOZvOHcuFoDKX5ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mo1NidTg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE32C4AF0A;
	Sat, 20 Jul 2024 17:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721496421;
	bh=Y6v1+nAyzX6PLWXUQO4fYkr+VRI6pL0daNUbphTp9Ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mo1NidTgWe4gaqa1uhLGqnaHg5Lw0GfB7cXA2DLf78lDSt9LMzySiZAzXFuGsfTu9
	 FDnJOOoFjIyPazatV3Ug8h0PqPHAkHPAcbvSGjrokipmTMPAQPnsJNRxgmP9G3jtKp
	 MIKNSf0+s9SB+anrQYQRRYASrqCfnBEjAQRZiEeXxxfhsWctjs48eSrv2aVoiQNa/z
	 5dWVUwW5P89QqGsHHrOtoPHWxsR2Hhz7Hfzc2PYU4YNM+wPvG7RrCNXi5myMqD4Q1T
	 DoGnsRlzagv7bVnSzB5Yv4w0Mbd7pmz1IgPTotQOcVwqR/3+BHuCm5OYoOX91TtLSn
	 Hdvj0BPDY6Ofg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Clement Leger <cleger@rivosinc.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] riscv: staticalize and remove asmlinkage from updated functions
Date: Sun, 21 Jul 2024 01:12:31 +0800
Message-ID: <20240720171232.1753-7-jszhang@kernel.org>
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

Now that the callers of these functions have moved into C, they
are only called in trap.c and no longer need the asmlinkage
annotation. So make them static and remove asmlinkage from them.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/include/asm/asm-prototypes.h | 19 +------------------
 arch/riscv/kernel/kernel_mode_vector.c  |  2 +-
 arch/riscv/kernel/traps.c               | 16 ++++++++--------
 3 files changed, 10 insertions(+), 27 deletions(-)

diff --git a/arch/riscv/include/asm/asm-prototypes.h b/arch/riscv/include/asm/asm-prototypes.h
index c6691e9032dd..067e93e3b400 100644
--- a/arch/riscv/include/asm/asm-prototypes.h
+++ b/arch/riscv/include/asm/asm-prototypes.h
@@ -31,30 +31,13 @@ void xor_regs_5_(unsigned long bytes, unsigned long *__restrict p1,
 		 const unsigned long *__restrict p5);
 
 #ifdef CONFIG_RISCV_ISA_V_PREEMPTIVE
-asmlinkage void riscv_v_context_nesting_start(struct pt_regs *regs);
+void riscv_v_context_nesting_start(struct pt_regs *regs);
 asmlinkage void riscv_v_context_nesting_end(struct pt_regs *regs);
 #endif /* CONFIG_RISCV_ISA_V_PREEMPTIVE */
 
 #endif /* CONFIG_RISCV_ISA_V */
 
-#define DECLARE_DO_ERROR_INFO(name)	asmlinkage void name(struct pt_regs *regs)
-
-DECLARE_DO_ERROR_INFO(do_trap_unknown);
-DECLARE_DO_ERROR_INFO(do_trap_insn_misaligned);
-DECLARE_DO_ERROR_INFO(do_trap_insn_fault);
-DECLARE_DO_ERROR_INFO(do_trap_insn_illegal);
-DECLARE_DO_ERROR_INFO(do_trap_load_fault);
-DECLARE_DO_ERROR_INFO(do_trap_load_misaligned);
-DECLARE_DO_ERROR_INFO(do_trap_store_misaligned);
-DECLARE_DO_ERROR_INFO(do_trap_store_fault);
-DECLARE_DO_ERROR_INFO(do_trap_ecall_u);
-DECLARE_DO_ERROR_INFO(do_trap_ecall_s);
-DECLARE_DO_ERROR_INFO(do_trap_ecall_m);
-DECLARE_DO_ERROR_INFO(do_trap_break);
-
 asmlinkage void handle_bad_stack(struct pt_regs *regs);
-asmlinkage void do_page_fault(struct pt_regs *regs);
-asmlinkage void do_irq(struct pt_regs *regs);
 asmlinkage void do_traps(struct pt_regs *regs, unsigned long cause);
 
 #endif /* _ASM_RISCV_PROTOTYPES_H */
diff --git a/arch/riscv/kernel/kernel_mode_vector.c b/arch/riscv/kernel/kernel_mode_vector.c
index 6afe80c7f03a..a6995429ddf5 100644
--- a/arch/riscv/kernel/kernel_mode_vector.c
+++ b/arch/riscv/kernel/kernel_mode_vector.c
@@ -152,7 +152,7 @@ static int riscv_v_start_kernel_context(bool *is_nested)
 }
 
 /* low-level V context handling code, called with irq disabled */
-asmlinkage void riscv_v_context_nesting_start(struct pt_regs *regs)
+void riscv_v_context_nesting_start(struct pt_regs *regs)
 {
 	int depth;
 
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 3eaa7c72f2be..dc1bc84cfe15 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -147,7 +147,7 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
 #define __trap_section noinstr
 #endif
 #define DO_ERROR_INFO(name, signo, code, str)					\
-asmlinkage __trap_section void name(struct pt_regs *regs)			\
+static __trap_section void name(struct pt_regs *regs)				\
 {										\
 	if (user_mode(regs)) {							\
 		irqentry_enter_from_user_mode(regs);				\
@@ -167,7 +167,7 @@ DO_ERROR_INFO(do_trap_insn_misaligned,
 DO_ERROR_INFO(do_trap_insn_fault,
 	SIGSEGV, SEGV_ACCERR, "instruction access fault");
 
-asmlinkage __trap_section void do_trap_insn_illegal(struct pt_regs *regs)
+static __trap_section void do_trap_insn_illegal(struct pt_regs *regs)
 {
 	bool handled;
 
@@ -198,7 +198,7 @@ asmlinkage __trap_section void do_trap_insn_illegal(struct pt_regs *regs)
 DO_ERROR_INFO(do_trap_load_fault,
 	SIGSEGV, SEGV_ACCERR, "load access fault");
 
-asmlinkage __trap_section void do_trap_load_misaligned(struct pt_regs *regs)
+static __trap_section void do_trap_load_misaligned(struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
@@ -219,7 +219,7 @@ asmlinkage __trap_section void do_trap_load_misaligned(struct pt_regs *regs)
 	}
 }
 
-asmlinkage __trap_section void do_trap_store_misaligned(struct pt_regs *regs)
+static __trap_section void do_trap_store_misaligned(struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
@@ -294,7 +294,7 @@ static void handle_break(struct pt_regs *regs)
 		die(regs, "Kernel BUG");
 }
 
-asmlinkage __trap_section void do_trap_break(struct pt_regs *regs)
+static __trap_section void do_trap_break(struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
@@ -311,7 +311,7 @@ asmlinkage __trap_section void do_trap_break(struct pt_regs *regs)
 	}
 }
 
-asmlinkage __trap_section  __no_stack_protector
+static __trap_section  __no_stack_protector
 void do_trap_ecall_u(struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
@@ -355,7 +355,7 @@ void do_trap_ecall_u(struct pt_regs *regs)
 }
 
 #ifdef CONFIG_MMU
-asmlinkage noinstr void do_page_fault(struct pt_regs *regs)
+static noinstr void do_page_fault(struct pt_regs *regs)
 {
 	irqentry_state_t state = irqentry_enter(regs);
 
@@ -378,7 +378,7 @@ static void noinstr handle_riscv_irq(struct pt_regs *regs)
 	irq_exit_rcu();
 }
 
-asmlinkage void noinstr do_irq(struct pt_regs *regs)
+static void noinstr do_irq(struct pt_regs *regs)
 {
 	irqentry_state_t state = irqentry_enter(regs);
 
-- 
2.43.0


