Return-Path: <linux-kernel+bounces-216379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C4E909EAF
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 19:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E561C209FD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 17:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28C839FFB;
	Sun, 16 Jun 2024 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fr3gZpJI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C9B29428
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718558390; cv=none; b=mFJUeS+ryVxlIjsfsMXesxlPaA7n8FCQYjnVYDaRgFK8SV3AVyplarpyzPhwt4XROyBuUpP0qlcWgKXmTVyutT3m76Y0dxfeseLncI9VKfJMLaDVQ4AhHNOJrohfvI5c/T/H7Qxj/2MzwB4AcJDpEiQVt+y4S/EemkKnIXqpMJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718558390; c=relaxed/simple;
	bh=Pd+tiD1d1gKrweB2fH2zKG5W19i1XxJlZfBI9MyqDG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cr4MqWNS2as5UVM1x6d8n7/BVmyCqtPbvUXO4KXX257GSie/9UgLmlVURCTh6u1vV71VNP1kYUxZa2GnVkcoxdkA/eZGukSSzZSTyFE+RDcmPmnvxRgwu23GH5EaXoOVEW6Gb0zM5G4LFYfdFyR4mRJWRO9LAf8qi19JnpaDn6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fr3gZpJI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D620C4AF1D;
	Sun, 16 Jun 2024 17:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718558389;
	bh=Pd+tiD1d1gKrweB2fH2zKG5W19i1XxJlZfBI9MyqDG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fr3gZpJIF+mNWTE/k8gjb6h8WqjKYJ5XHk32WwBuZc8BBz2lyf54J0u3VdCN3acew
	 /hXcpsTrkkeyioYogaABM3hRLgX5jMh5nyo541LwzOl7nqgg3xPNdowHIgpz8vh0HJ
	 YLvDhpEBndaex5SskayRd60TjumzaeTGrse3Ahb5p+qNy2ITuhWY3988dww4zuyzZk
	 0apSPidmNpl3UzXFVrJ6T0ByZcogNbLLpOmVo0JXxhNKvlOYtriq5F2wEgGdo/vHEf
	 WZB0ITPpZX0Cl86QiYJt+EuWMOtmg/0mElBaj+f0gMl1wJkgDK/pbZmRWjq78KK68u
	 X5vBu6LEFW/kw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anton Blanchard <antonb@tenstorrent.com>,
	Cyril Bur <cyrilbur@tenstorrent.com>
Subject: [PATCH 1/6] riscv: Improve exception and system call latency
Date: Mon, 17 Jun 2024 01:05:48 +0800
Message-ID: <20240616170553.2832-2-jszhang@kernel.org>
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

From: Anton Blanchard <antonb@tenstorrent.com>

Many CPUs implement return address branch prediction as a stack. The
RISCV architecture refers to this as a return address stack (RAS). If
this gets corrupted then the CPU will mispredict at least one but
potentally many function returns.

There are two issues with the current RISCV exception code:

- We are using the alternate link stack (x5/t0) for the indirect branch
  which makes the hardware think this is a function return. This will
  corrupt the RAS.

- We modify the return address of handle_exception to point to
  ret_from_exception. This will also corrupt the RAS.

Testing the null system call latency before and after the patch:

Visionfive2 (StarFive JH7110 / U74)
baseline: 189.87 ns
patched:  176.76 ns

Lichee pi 4a (T-Head TH1520 / C910)
baseline: 666.58 ns
patched:  636.90 ns

Just over 7% on the U74 and just over 4% on the C910.

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
Signed-off-by: Cyril Bur <cyrilbur@tenstorrent.com>
---
 arch/riscv/kernel/entry.S      | 17 ++++++++++-------
 arch/riscv/kernel/stacktrace.c |  4 ++--
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 68a24cf9481a..c933460ed3e9 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -88,7 +88,6 @@ SYM_CODE_START(handle_exception)
 	call riscv_v_context_nesting_start
 #endif
 	move a0, sp /* pt_regs */
-	la ra, ret_from_exception
 
 	/*
 	 * MSB of cause differentiates between
@@ -97,7 +96,8 @@ SYM_CODE_START(handle_exception)
 	bge s4, zero, 1f
 
 	/* Handle interrupts */
-	tail do_irq
+	call do_irq
+	j ret_from_exception
 1:
 	/* Handle other exceptions */
 	slli t0, s4, RISCV_LGPTR
@@ -105,11 +105,14 @@ SYM_CODE_START(handle_exception)
 	la t2, excp_vect_table_end
 	add t0, t1, t0
 	/* Check if exception code lies within bounds */
-	bgeu t0, t2, 1f
-	REG_L t0, 0(t0)
-	jr t0
-1:
-	tail do_trap_unknown
+	bgeu t0, t2, 3f
+	REG_L t1, 0(t0)
+2:	jalr t1
+	j ret_from_exception
+3:
+
+	la t1, do_trap_unknown
+	j 2b
 SYM_CODE_END(handle_exception)
 ASM_NOKPROBE(handle_exception)
 
diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 528ec7cc9a62..5eb3d135b717 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -16,7 +16,7 @@
 
 #ifdef CONFIG_FRAME_POINTER
 
-extern asmlinkage void ret_from_exception(void);
+extern asmlinkage void handle_exception(void);
 
 static inline int fp_is_valid(unsigned long fp, unsigned long sp)
 {
@@ -70,7 +70,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 			fp = frame->fp;
 			pc = ftrace_graph_ret_addr(current, NULL, frame->ra,
 						   &frame->ra);
-			if (pc == (unsigned long)ret_from_exception) {
+			if (pc == (unsigned long)handle_exception) {
 				if (unlikely(!__kernel_text_address(pc) || !fn(arg, pc)))
 					break;
 
-- 
2.43.0


