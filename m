Return-Path: <linux-kernel+bounces-194799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF54C8D4241
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 02:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A5C1F22673
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 00:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15638125D5;
	Thu, 30 May 2024 00:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="X4BPg2OC"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A85B65A
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 00:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717028261; cv=none; b=tnkY6Sx2hZVB7d1JNqJYT1qcTJnqUl4Ew9veIwVVKuLU00rGMmO1iZ7avdkQ5v6VWyUdv2J1PRqjVm8TcU6+IrAoEv87kZbuUX0KTj/Uf+1v0K3wBpM+0uVDTv7xivTPQy/q4mGH27aADyBKCzypBL9Y8blilTpXTDG7Dr4iZbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717028261; c=relaxed/simple;
	bh=fC8Q8kv+jQLtnd2td/CJByuS+Z0MO03bxK1RgmqlUOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+VUoosCv0S6kYUX0v3PHjZVej/lwFkPtgCpyl8jqXFLMQQxo1xmk3BQZo9tIhih6tMTBQ0SHMFZ3c6IMEL88Jt+5+L+EZyx3R8B2U8n15fmZJ92k+ttLrHS/YekYsR3Qu+B+YzxqdZaqAfRYcoFTKYe0ZXo+pccVFQXjUbrXkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=X4BPg2OC; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-68197edc2d3so267433a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 17:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1717028259; x=1717633059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VORirj/p8laQYqtwQSljZN4IPQTPn3tED4t61Nbfhh4=;
        b=X4BPg2OCyTmDICox4YCS/j5bBEIE3p1wSRYZDKvH3S0UHKxPgCaKJqpu23wNcHzIXn
         /zupx2Ca13MhVoqXgydgzcwBWCWVtxaEeLsydm3r+sncEBMxUZKbwuEz/mOuljJYEFK7
         93gDogn133BeWBmPlD+YzECtYJjzeEKvOGjdJxyVn65n9HW1KpesBJiovt18xi0zd7ri
         Cf68Pg8yTVI7Jyk64SyoWeNhgbhSXIU5Mgp4zYvFlgSLqxNuSUwAWmno6zmo9N7BNA9p
         X49pyuukmHn0J1dW6o7lxG/DqmIAhlC4d3uvmGO3QDgl8XR9CB7D1EV7oDwCYQ5x+5zZ
         ysAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717028259; x=1717633059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VORirj/p8laQYqtwQSljZN4IPQTPn3tED4t61Nbfhh4=;
        b=TauDpTGI5DtMbbdsSwKweOSJaSFmqQv3cJNUfK3dcyosX5FrogaPdHuvWk5K+X3+Qd
         oamV7TCob3Rb+DxBVTBZh/Xvfe4bxMOchAfvzqrUNt3x+tmN9RtF2C0D6u9dR/B/rbVJ
         Fr7YN+k1NEH1M6RRsVjCIU4FFngFV7dn9viEwVtJnyfyJQJctG7iMhS+I25DVuF8EFMD
         /QNGqK6VtVsPd+XNy8oSl2uqXunBdL30Vz5Fz6VRW5l5TTUDbPhEEFER+c7QDEYwqh0j
         3lmkk5zTT8d8OGaP4nMzo9nx2Ulw5Jhix9RdGx1UM5FVSI7kE8SmJf+IL5HDspwH23b0
         o8Aw==
X-Gm-Message-State: AOJu0YzNVMJvy7bTrDoBszW+l16ZDDQwVQFYBVkbxLTYmySwCBUe9DaF
	tfma8ZQsykvWE9X/3AtIajCORcXrO0ylH3i116GTMiN0EIv1WozKbZ7wDuvM+1c=
X-Google-Smtp-Source: AGHT+IFSmHA6v4nmJKFL/xqyz99p7ZxJlwInOFAA+iOduDMGY/Lg03JJ5ApeduhAHcnmMFHvH2XKWw==
X-Received: by 2002:a17:90a:65c1:b0:2bf:cf2d:67db with SMTP id 98e67ed59e1d1-2c1abc4317cmr647425a91.39.1717028258789;
        Wed, 29 May 2024 17:17:38 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a776e206sm432171a91.20.2024.05.29.17.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 17:17:38 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-kernel@vger.kernel.org,
	Andy Chiu <andy.chiu@sifive.com>,
	linux-riscv@lists.infradead.org,
	Matthew Bystrin <dev.mbstr@gmail.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 3/4] riscv: entry: Do not clobber the frame pointer
Date: Wed, 29 May 2024 17:15:58 -0700
Message-ID: <20240530001733.1407654-4-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240530001733.1407654-1-samuel.holland@sifive.com>
References: <20240530001733.1407654-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

s0 is reserved for the frame pointer, so it should not be used as a
temporary register. Clobbering the frame pointer breaks stack traces.

- In handle_exception() and ret_from_exception(), use a2 for the saved
  stack pointer. a2 is chosen because r2 is the stack pointer register.
- In ret_from_exception(), use s1 for the saved status CSR value. Avoid
  clobbering s1 in the privilege mode check so it does not need to be
  reloaded later in the function.
- Use s1 and s2 in ret_from_fork() instead of s0 and s1. The entire
  p->thread.s array is zeroed at the beginning of copy_thread(), so the
  registers do not need to be zeroed separately for kernel threads.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/kernel/entry.S   | 29 ++++++++++++++---------------
 arch/riscv/kernel/process.c |  5 ++---
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index d13d1aad7649..bd1c5621df45 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -58,13 +58,13 @@ SYM_CODE_START(handle_exception)
 	 */
 	li t0, SR_SUM | SR_FS_VS
 
-	REG_L s0, TASK_TI_USER_SP(tp)
+	REG_L a2, TASK_TI_USER_SP(tp)
 	csrrc s1, CSR_STATUS, t0
 	csrr s2, CSR_EPC
 	csrr s3, CSR_TVAL
 	csrr s4, CSR_CAUSE
 	csrr s5, CSR_SCRATCH
-	REG_S s0, PT_SP(sp)
+	REG_S a2, PT_SP(sp)
 	REG_S s1, PT_STATUS(sp)
 	REG_S s2, PT_EPC(sp)
 	REG_S s3, PT_BADADDR(sp)
@@ -125,19 +125,19 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
 	call riscv_v_context_nesting_end
 #endif
 
-	REG_L s0, PT_STATUS(sp)
+	REG_L s1, PT_STATUS(sp)
 #ifdef CONFIG_RISCV_M_MODE
 	/* the MPP value is too large to be used as an immediate arg for addi */
 	li t0, SR_MPP
-	and s0, s0, t0
+	and t0, s1, t0
 #else
-	andi s0, s0, SR_SPP
+	andi t0, s1, SR_SPP
 #endif
-	bnez s0, 1f
+	bnez t0, 1f
 
 	/* Save unwound kernel stack pointer in thread_info */
-	addi s0, sp, PT_SIZE_ON_STACK
-	REG_S s0, TASK_TI_KERNEL_SP(tp)
+	addi t0, sp, PT_SIZE_ON_STACK
+	REG_S t0, TASK_TI_KERNEL_SP(tp)
 
 	/* Save the kernel shadow call stack pointer */
 	scs_save_current
@@ -148,7 +148,6 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
 	 */
 	csrw CSR_SCRATCH, tp
 1:
-	REG_L a0, PT_STATUS(sp)
 	/*
 	 * The current load reservation is effectively part of the processor's
 	 * state, in the sense that load reservations cannot be shared between
@@ -169,7 +168,7 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
 	REG_L  a2, PT_EPC(sp)
 	REG_SC x0, a2, PT_EPC(sp)
 
-	csrw CSR_STATUS, a0
+	csrw CSR_STATUS, s1
 	csrw CSR_EPC, a2
 
 	REG_L x1,  PT_RA(sp)
@@ -207,13 +206,13 @@ SYM_CODE_START_LOCAL(handle_kernel_stack_overflow)
 	REG_S x5,  PT_T0(sp)
 	save_from_x6_to_x31
 
-	REG_L s0, TASK_TI_KERNEL_SP(tp)
+	REG_L a2, TASK_TI_KERNEL_SP(tp)
 	csrr s1, CSR_STATUS
 	csrr s2, CSR_EPC
 	csrr s3, CSR_TVAL
 	csrr s4, CSR_CAUSE
 	csrr s5, CSR_SCRATCH
-	REG_S s0, PT_SP(sp)
+	REG_S a2, PT_SP(sp)
 	REG_S s1, PT_STATUS(sp)
 	REG_S s2, PT_EPC(sp)
 	REG_S s3, PT_BADADDR(sp)
@@ -227,10 +226,10 @@ ASM_NOKPROBE(handle_kernel_stack_overflow)
 
 SYM_CODE_START(ret_from_fork)
 	call schedule_tail
-	beqz s0, 1f	/* not from kernel thread */
+	beqz s1, 1f	/* not from kernel thread */
 	/* Call fn(arg) */
-	move a0, s1
-	jalr s0
+	move a0, s2
+	jalr s1
 1:
 	move a0, sp /* pt_regs */
 	la ra, ret_from_exception
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index e4bc61c4e58a..5512c31e1256 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -208,8 +208,8 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		/* Supervisor/Machine, irqs on: */
 		childregs->status = SR_PP | SR_PIE;
 
-		p->thread.s[0] = (unsigned long)args->fn;
-		p->thread.s[1] = (unsigned long)args->fn_arg;
+		p->thread.s[1] = (unsigned long)args->fn;
+		p->thread.s[2] = (unsigned long)args->fn_arg;
 	} else {
 		*childregs = *(current_pt_regs());
 		/* Turn off status.VS */
@@ -219,7 +219,6 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		if (clone_flags & CLONE_SETTLS)
 			childregs->tp = tls;
 		childregs->a0 = 0; /* Return value of fork() */
-		p->thread.s[0] = 0;
 	}
 	p->thread.riscv_v_flags = 0;
 	if (has_vector())
-- 
2.44.1


