Return-Path: <linux-kernel+bounces-216384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 778FE909EB4
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 19:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18DB32817C9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 17:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC6561FE4;
	Sun, 16 Jun 2024 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMToKE0f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8B660269
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718558397; cv=none; b=M/IOfto61JCmiuM4RpDRYpu4aLwnsj3fJeLUqhy11VAFGMkvKqd2/5wxTfE5hCFnSRhD56vPrYnx3S0IVdm8cARHfea3XhbeZpU0b9Ztrl6Q7rMOA91BoQojiNMIUZkjWQJyDa9KInjdLBf2F+yFUHVAMO+tow3l+D1ctVmAHW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718558397; c=relaxed/simple;
	bh=E3GXEIZD9yn8wjrqGOzrCdvgMio8fL8UM/D6vQXKlWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejxeKVa8xlEt9KTy5a2sZKi13Fw5FApMfo2EyvDHJnIyQjIcoINoA9XDl8hzGMn8IJuTWtX2Jnaaj1BBw3vB56mOPN+N/E4Gi5x30VBJ+0Yjk+qqQaXhZeffwX3hLNU23ImlaUzZsWxQ8rUX921xcDC/ek3JHEgnt+u1dqPDDnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMToKE0f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81587C4AF4D;
	Sun, 16 Jun 2024 17:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718558397;
	bh=E3GXEIZD9yn8wjrqGOzrCdvgMio8fL8UM/D6vQXKlWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qMToKE0fdCNS9u9oH3qr8ZrWlxfAlYo0h0NIawg2WKdqHq7P0ptMQCHq4PMX0+qnR
	 A6hc2daFhj2lvMPafkx6EfsLRX6X4ycBeMofZ0Xyohq4lMTJp9T8yhT6JNN9b2Crlo
	 0xcn7yW8+ApwXbnC42MxyfrXPbi9KZQ8e5T5sTotRSH9bnI6+8y1Sc4XsJZU9wZVed
	 qLFJTr+mkMm9B1hYHu/eCZ5yEaS+msrYvc1XR3+TRaofVH7adIPR/+PxOIEO3xt1oL
	 W3okdmcySYO/JjHSzgiit1EjiVBV5gyUwm711EXhnl040rKgqi26+Zzy9kf2Jf22s1
	 Xqo0an8m8DQHw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] riscv: remove asmlinkage from updated functions
Date: Mon, 17 Jun 2024 01:05:53 +0800
Message-ID: <20240616170553.2832-7-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240616170553.2832-1-jszhang@kernel.org>
References: <20240616170553.2832-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the callers of these functions have moved into C, they no longer
need the asmlinkage annotation. Remove it

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/include/asm/asm-prototypes.h |  6 +++---
 arch/riscv/kernel/traps.c               | 16 ++++++++--------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/include/asm/asm-prototypes.h b/arch/riscv/include/asm/asm-prototypes.h
index 81a1f27fa54f..70b86a825922 100644
--- a/arch/riscv/include/asm/asm-prototypes.h
+++ b/arch/riscv/include/asm/asm-prototypes.h
@@ -37,7 +37,7 @@ asmlinkage void riscv_v_context_nesting_end(struct pt_regs *regs);
 
 #endif /* CONFIG_RISCV_ISA_V */
 
-#define DECLARE_DO_ERROR_INFO(name)	asmlinkage void name(struct pt_regs *regs)
+#define DECLARE_DO_ERROR_INFO(name)	void name(struct pt_regs *regs)
 
 DECLARE_DO_ERROR_INFO(do_trap_unknown);
 DECLARE_DO_ERROR_INFO(do_trap_insn_misaligned);
@@ -53,8 +53,8 @@ DECLARE_DO_ERROR_INFO(do_trap_ecall_m);
 DECLARE_DO_ERROR_INFO(do_trap_break);
 
 asmlinkage void handle_bad_stack(struct pt_regs *regs);
-asmlinkage void do_page_fault(struct pt_regs *regs);
-asmlinkage void do_irq(struct pt_regs *regs);
+void do_page_fault(struct pt_regs *regs);
+void do_irq(struct pt_regs *regs);
 asmlinkage void do_traps(struct pt_regs *regs);
 
 #endif /* _ASM_RISCV_PROTOTYPES_H */
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index b44d4a8d4083..ddca8e74fb72 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -147,7 +147,7 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
 #define __trap_section noinstr
 #endif
 #define DO_ERROR_INFO(name, signo, code, str)					\
-asmlinkage __visible __trap_section void name(struct pt_regs *regs)		\
+__visible __trap_section void name(struct pt_regs *regs)			\
 {										\
 	if (user_mode(regs)) {							\
 		irqentry_enter_from_user_mode(regs);				\
@@ -167,7 +167,7 @@ DO_ERROR_INFO(do_trap_insn_misaligned,
 DO_ERROR_INFO(do_trap_insn_fault,
 	SIGSEGV, SEGV_ACCERR, "instruction access fault");
 
-asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *regs)
+__visible __trap_section void do_trap_insn_illegal(struct pt_regs *regs)
 {
 	bool handled;
 
@@ -198,7 +198,7 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
 DO_ERROR_INFO(do_trap_load_fault,
 	SIGSEGV, SEGV_ACCERR, "load access fault");
 
-asmlinkage __visible __trap_section void do_trap_load_misaligned(struct pt_regs *regs)
+__visible __trap_section void do_trap_load_misaligned(struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
@@ -219,7 +219,7 @@ asmlinkage __visible __trap_section void do_trap_load_misaligned(struct pt_regs
 	}
 }
 
-asmlinkage __visible __trap_section void do_trap_store_misaligned(struct pt_regs *regs)
+__visible __trap_section void do_trap_store_misaligned(struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
@@ -294,7 +294,7 @@ void handle_break(struct pt_regs *regs)
 		die(regs, "Kernel BUG");
 }
 
-asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
+__visible __trap_section void do_trap_break(struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
@@ -311,7 +311,7 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
 	}
 }
 
-asmlinkage __visible __trap_section  __no_stack_protector
+__visible __trap_section  __no_stack_protector
 void do_trap_ecall_u(struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
@@ -355,7 +355,7 @@ void do_trap_ecall_u(struct pt_regs *regs)
 }
 
 #ifdef CONFIG_MMU
-asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
+__visible noinstr void do_page_fault(struct pt_regs *regs)
 {
 	irqentry_state_t state = irqentry_enter(regs);
 
@@ -378,7 +378,7 @@ static void noinstr handle_riscv_irq(struct pt_regs *regs)
 	irq_exit_rcu();
 }
 
-asmlinkage void noinstr do_irq(struct pt_regs *regs)
+void noinstr do_irq(struct pt_regs *regs)
 {
 	irqentry_state_t state = irqentry_enter(regs);
 
-- 
2.43.0


