Return-Path: <linux-kernel+bounces-258025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948FE938246
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 19:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5139D281BC6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 17:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F33148FE5;
	Sat, 20 Jul 2024 17:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4ztOcRF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCEB148848
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 17:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721496413; cv=none; b=n5s36FRgWS0cwqnUZ9F3XCh6ngXqCxG6K9Kg5mnBTPCTR1jwf1kQKuy3qiAhjBeI160lG/ldmXFuuU86GEKZ59XhSA/wLs+kcisez94asQwVb7DYaJJGjSPD5ltFl/N+rh3LW4PigK7EpuSzIpo/Um5BAXjyvTSlSU/NUiKzofg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721496413; c=relaxed/simple;
	bh=98NBtrS/SMiq12hZfID75Yi7wQQ0UoZjx4bDe8JfM7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cYmMkCXl1O5UEOVkr5HjnPbbHfi8qsWm7rWqoDe97/jolnPAiwqFpkJvHUbudBoV8OKUNnjYU5QeHZK5MogSGpgxqsOizpAkBgn//NDyu9VReQi0sBhbqyVGXNd+wVdi/ONI+TFWaOxfoSxKSO3YOI06wjYypqlZlwEwMMTvpVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4ztOcRF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCCC0C4AF0E;
	Sat, 20 Jul 2024 17:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721496413;
	bh=98NBtrS/SMiq12hZfID75Yi7wQQ0UoZjx4bDe8JfM7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N4ztOcRFtt/L8y27kj71vaMp/hVPX2rJ4XGAvHs2lK82jNMi7tHf63+X4gZ6ikrOL
	 5NCdG91/FjCSWTnPZu0DN4v81Pr99PSPEt+JF4DRdNQlGLiu3drOFFWs/9qycQOl09
	 9S9DDIlttmYex+ufURu9cwx76Gvu24azkKA5HYf1gCU4spDsZIOu9s9gPYIR9j2uC0
	 xdJEajhAV4WWiKPviJXA/F4ibDbR3WgZbCf/uHvyP34sUPLkD+DPo6wvU01GaZUIlr
	 mDcqR/ITjGxO1s+H2Ms9xAScH0925ep10jddLPR8UESmKdZSnh2QJbMouFH8zx5gfH
	 p0Ijsu6L28aJg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Clement Leger <cleger@rivosinc.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] riscv: traps: remove __visible annotation
Date: Sun, 21 Jul 2024 01:12:27 +0800
Message-ID: <20240720171232.1753-3-jszhang@kernel.org>
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

Commit f307307992bf ("riscv: for C functions called only from assembly,
mark with __visible") resolve sparse warnings for C functions called
only by assembly code by adding __visible annotations instead of
adding prototypes. But after commit 030f1dfa8550 ("riscv: traps: Fix no
prototype warnings"), prototypes were added. So the __visible
annotations are not needed any more, remove them.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/kernel/traps.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 84dff89f435d..3d1f84cb6eac 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -147,7 +147,7 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
 #define __trap_section noinstr
 #endif
 #define DO_ERROR_INFO(name, signo, code, str)					\
-asmlinkage __visible __trap_section void name(struct pt_regs *regs)		\
+asmlinkage __trap_section void name(struct pt_regs *regs)			\
 {										\
 	if (user_mode(regs)) {							\
 		irqentry_enter_from_user_mode(regs);				\
@@ -167,7 +167,7 @@ DO_ERROR_INFO(do_trap_insn_misaligned,
 DO_ERROR_INFO(do_trap_insn_fault,
 	SIGSEGV, SEGV_ACCERR, "instruction access fault");
 
-asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *regs)
+asmlinkage __trap_section void do_trap_insn_illegal(struct pt_regs *regs)
 {
 	bool handled;
 
@@ -198,7 +198,7 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
 DO_ERROR_INFO(do_trap_load_fault,
 	SIGSEGV, SEGV_ACCERR, "load access fault");
 
-asmlinkage __visible __trap_section void do_trap_load_misaligned(struct pt_regs *regs)
+asmlinkage __trap_section void do_trap_load_misaligned(struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
@@ -219,7 +219,7 @@ asmlinkage __visible __trap_section void do_trap_load_misaligned(struct pt_regs
 	}
 }
 
-asmlinkage __visible __trap_section void do_trap_store_misaligned(struct pt_regs *regs)
+asmlinkage __trap_section void do_trap_store_misaligned(struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
@@ -294,7 +294,7 @@ static void handle_break(struct pt_regs *regs)
 		die(regs, "Kernel BUG");
 }
 
-asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
+asmlinkage __trap_section void do_trap_break(struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
@@ -311,7 +311,7 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
 	}
 }
 
-asmlinkage __visible __trap_section  __no_stack_protector
+asmlinkage __trap_section  __no_stack_protector
 void do_trap_ecall_u(struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
@@ -355,7 +355,7 @@ void do_trap_ecall_u(struct pt_regs *regs)
 }
 
 #ifdef CONFIG_MMU
-asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
+asmlinkage noinstr void do_page_fault(struct pt_regs *regs)
 {
 	irqentry_state_t state = irqentry_enter(regs);
 
-- 
2.43.0


