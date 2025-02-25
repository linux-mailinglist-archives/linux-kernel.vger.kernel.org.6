Return-Path: <linux-kernel+bounces-530951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 647CEA43A74
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C99317D5FA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4EE267AEE;
	Tue, 25 Feb 2025 09:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OLI9+2f/"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCCC2676E9
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477315; cv=none; b=IfBSrjHj3T+VgefPYtl1xymRZQnocJ/6zmj0e2WrZBvzuZ1nPaFrEcBCzAlZIPBiM1zztYCRwkg6j6cMFtw4QCsWwIOCEWnAhxbFfUy2TjQa8Zf04RVADzAEIJIkB6PGAW3gdcsc8zf2jkEsPsGazKgFcJ6IzJyRyuoSJQH/s9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477315; c=relaxed/simple;
	bh=NlFGyDqKyhRPmpPMwIP/jihNWikR562MB5e5yJWNB0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LpW5wmvYCOApm5/rYs5g9hM1GKBuJdRuuPNyXBEazEo/mz4yberPNHrU0g8nf9vJ5pVf2k5q2O+qwgeXHD8aKixi6RAwcE3t63Ag4Hvu3YD0lH9DPw6coKEG8usPmHnPKbZcxkCD5MXGSk4WycbmEPutTxQ4fiNJTV/zs5wkK5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OLI9+2f/; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54527a7270eso5408099e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477311; x=1741082111; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QZ+1V9qTPsDzOzqvLQMw/vPgzhrwZ5TSLeEMjw/aHNM=;
        b=OLI9+2f/O5Xe4OioU0905Fh/wuXGb1X/cIeRXaePLB7i3z3MVa4mbYy0YZm4nDEVFP
         TkG55M1HXYgUZynMVGHGqRlywGI9m7lrZv15+GgMK6hmBDg0yYMXJHgO7wQkkQjrsGCP
         +Vn5g6Hwk3o+7uPmN+rnvThoMkNqBqDm0JEK19kvZ6757/cTbg7hW2VKu1cs2DRdIoPy
         M+EBwbs/8Uf638uc0+adHgZhUS69/J3T45941Gz742bmMYrRmYoScHK9tRaavPMkd/a/
         J1RcRfUKOinzRK9qlu5M8pZni0RW7FeCXlTqi+E+UMlkVAGuhlYeTVeElM7q3ka9YG3p
         6lAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477311; x=1741082111;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZ+1V9qTPsDzOzqvLQMw/vPgzhrwZ5TSLeEMjw/aHNM=;
        b=jjpkEODgzDOltC/2unbuzYMWuOHsDGC4eQ+KK2Ni/RQDRAoSnuN2K8+sXuF8DBgwm9
         bM9FysDOCi7yq0bwPTOZzI2SwtNrYyNZuM7MJRgfDeFQGXs9OS3SPARDCeA1ryeRSVj3
         G6Rufd5WJ/98BSQOi+WjNAY1NnHnFtQl+Ymdk1OlSwjI9uipejosKh54DWAFNa5X9OM2
         jgO5fPaof6h3tsGjf3vFkVIyFgCdex+x4HLQw66y+S/YNlanngz/7s0jhwy+WB/bTG5P
         uFch7XK4owHl5cc7NDgxtmeOyJck2GfXVmxPDpgXtAoEpcB6M5wtOJBG/sFMEDYuqj3a
         xbDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCtxmC6b25L2dDJ1jcjk0ko9/VvcXOkH7/d8/TWy1J99wwacGziYT2efwAbX3gtYPd9x5259Tp/8X6j+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7cmmSWS3an6D0bUk5JezWA97rr+gTAl8wJdmduo5Q/xeQq62l
	1Xj14xobQUSTSBoxRjtBgr4Q6IbSnEpH/wHZBYuTmQw7dE7/EXDUMvZyOAImc5k=
X-Gm-Gg: ASbGncs8pnifJcWobiU/cmDNLoyg9ePN3aDgfj01bsYMG6WKQNX6I/qLpxbnHeWCr57
	+MpcwEefLQC4vYnkt74tanuu556q+BNk7n8L9R+8UHN+plRToiYm3QdAe967BjBzzPTfabvJGBR
	NQnGB2UlMLfZ5weJnBJnsXFRe02tgApH7wzT0EBgfChHZl5jcG620TN7lal4Jfbb60aICY79/zp
	LP9vIFkN02JIrIBXwMnLHj4Lr777xqp9Ts6rAiFxpVxDhcgfUl0veSfKgpcqZHgl9vJZ1wvszUT
	iVEJ38ar1R9ZR4X3IMn9yoPgugVdnd7/ywMq
X-Google-Smtp-Source: AGHT+IFDeQ/M9ZOCtIWpnUI5fVFHuPS9quPNejIMQ+9GozsbWKhR8saTISbNhtUaShSnwrshkm2CXg==
X-Received: by 2002:a19:ca14:0:b0:549:39b1:65c5 with SMTP id 2adb3069b0e04-54939b16f10mr3456e87.47.1740477311051;
        Tue, 25 Feb 2025 01:55:11 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b261esm132867e87.24.2025.02.25.01.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:55:10 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 10:54:57 +0100
Subject: [PATCH v5 10/31] ARM: entry: move all tracing invocation to C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-arm-generic-entry-v5-10-2f02313653e5@linaro.org>
References: <20250225-arm-generic-entry-v5-0-2f02313653e5@linaro.org>
In-Reply-To: <20250225-arm-generic-entry-v5-0-2f02313653e5@linaro.org>
To: Dmitry Vyukov <dvyukov@google.com>, Oleg Nesterov <oleg@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Kees Cook <kees@kernel.org>, 
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Jinjie Ruan <ruanjinjie@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
 Ard Biesheuvel <ardb@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.2

The traced invocation of syscall is rewritten in C, moving
over also the call to syscall_trace_exit() to C.

To do this we cannot have invoke_syscall_trace_asm() be a
leaf call, which is the mechanism we hithereto relied on
to make sure the stack is pulled back to the state we were
at before we called out to the code written in C.

Push the registers potentially used by C on the stack, and
make a copy of the two stack-pushed syscall arguments
on the top of the stack before invoking the syscall and
then drop these copied arguments and pop back the
registers before returning from invoke_syscall_trace_asm().

As we are now calling from and returning to C, we no
longer need to pass the regs pointer around so drop it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/include/asm/syscall.h |  2 +-
 arch/arm/kernel/entry-common.S | 32 +++++++++++++++-----------------
 arch/arm/kernel/ptrace.c       |  2 +-
 arch/arm/kernel/syscall.c      | 30 +++++++++++++++++++++---------
 4 files changed, 38 insertions(+), 28 deletions(-)

diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
index 66067d165ba3fbbe0f840a89ae396eb1a311bacc..cb0073c4151bf70a82d15e17a95b6b6f48b245d6 100644
--- a/arch/arm/include/asm/syscall.h
+++ b/arch/arm/include/asm/syscall.h
@@ -20,7 +20,7 @@
 extern const unsigned long sys_call_table[];
 
 int invoke_syscall(void *table, struct pt_regs *regs, int scno, void *retp);
-int invoke_syscall_trace(void *table, struct pt_regs *regs, void *retp);
+void invoke_syscall_trace(void *table, struct pt_regs *regs);
 
 static inline int syscall_get_nr(struct task_struct *task,
 				 struct pt_regs *regs)
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 8baab7f97f59c434396f30b08ddd3029c5f9c0e5..dbc947d301ec11bb13007cb4bb161c035ede5c10 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -296,22 +296,11 @@ ENDPROC(vector_swi)
 __sys_trace:
 	add	r1, sp, #S_R0 + S_OFF		@ pointer to regs
 	mov	r0, tbl
-	badr	r2, __sys_trace_return
 	bl	invoke_syscall_trace
-	cmp	r0, #-1
-	bne	__sys_trace_return
-	add	sp, sp, #S_OFF			@ restore stack
-
-__sys_trace_return_nosave:
-	enable_irq_notrace
-	mov	r0, sp
-	bl	syscall_trace_exit
+	add	sp, sp, #S_OFF			@ restore stack pointer
 	b	ret_to_user
 
-__sys_trace_return:
-	str	r0, [sp, #S_R0 + S_OFF]!	@ save returned r0
-	mov	r0, sp
-	bl	syscall_trace_exit
+__sys_trace_return_nosave:
 	b	ret_to_user
 
 	.macro	syscall_table_start, sym
@@ -437,18 +426,27 @@ SYM_FUNC_END(invoke_syscall_asm)
  * r0: syscall table
  * r1: regs
  * r2: syscall number
- * r3: pointer to return function
  */
 SYM_TYPED_FUNC_START(invoke_syscall_trace_asm)
 #ifdef CONFIG_CPU_SPECTRE
 	csdb
 #endif
+	/* Save registers because we are being called from C */
+	push	{r4 - r10, lr}
 	mov	tbl, r0
+	/* Make space to copy the two syscall stack arguments */
+	sub	sp, sp, #S_OFF
 	mov	scno, r2
-	mov	lr, r3				@ return address
-	ldmia	r1, {r0 - r6}			@ reload r0-r6
-	stmia	sp, {r4, r5}			@ update stack arguments
+	badr	lr, __invoke_syscall_trace_ret	@ return right here
+	ldmia	r1, {r0 - r6}			@ reload r0-r6 from regs
+	stmia	sp, {r4, r5}			@ copy stack arguments
 	ldr	pc, [tbl, scno, lsl #2]		@ call sys_* routine
+__invoke_syscall_trace_ret:
+	/* Drop the copied stack arguments */
+	add	sp, sp, #S_OFF
+	pop	{r4 - r10, lr}
+ ARM(	mov	pc, lr		)
+ THUMB(	bx	lr		)
 SYM_FUNC_END(invoke_syscall_trace_asm)
 
 #ifdef CONFIG_OABI_COMPAT
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 07b0daf47441f1f76a8af416acc74fa5ed770403..ac7b98ae47249b4a00fc1cb871bb2d309bfd8c88 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -888,7 +888,7 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 	return scno;
 }
 
-asmlinkage void syscall_trace_exit(struct pt_regs *regs)
+void syscall_trace_exit(struct pt_regs *regs)
 {
 	/*
 	 * Audit the syscall before anything else, as a debugger may
diff --git a/arch/arm/kernel/syscall.c b/arch/arm/kernel/syscall.c
index 377e16c8c53c8e809e3f8b157a889ef115d5c043..e90f04f35b3485968a1e9046cf0889f56cca92e5 100644
--- a/arch/arm/kernel/syscall.c
+++ b/arch/arm/kernel/syscall.c
@@ -18,23 +18,35 @@ __visible int invoke_syscall(void *table, struct pt_regs *regs, int scno, void *
 	return sys_ni_syscall();
 }
 
-int invoke_syscall_trace_asm(void *table, struct pt_regs *regs, int scno, void *retp);
+int invoke_syscall_trace_asm(void *table, struct pt_regs *regs, int scno);
 __ADDRESSABLE(invoke_syscall_trace_asm);
 
-__visible int invoke_syscall_trace(void *table, struct pt_regs *regs, void *retp)
+__visible void invoke_syscall_trace(void *table, struct pt_regs *regs)
 {
 	int scno;
+	int ret;
 
 	scno = syscall_trace_enter(regs);
 	if (scno == -1)
-		return -1;
+		goto trace_exit_nosave;
 
-	if (scno < NR_syscalls)
-		/* Doing this with return makes sure the stack gets pop:ed */
-		return invoke_syscall_trace_asm(table, regs, scno, retp);
+	if (scno < NR_syscalls) {
+		ret = invoke_syscall_trace_asm(table, regs, scno);
+		goto trace_exit_save;
+	}
 
-	if (scno >= __ARM_NR_BASE)
-		return arm_syscall(scno, regs);
+	if (scno >= __ARM_NR_BASE) {
+		ret = arm_syscall(scno, regs);
+		goto trace_exit_save;
+	}
 
-	return sys_ni_syscall();
+	ret = sys_ni_syscall();
+
+trace_exit_save:
+	/* Save return value from syscall */
+	regs->ARM_r0 = ret;
+
+trace_exit_nosave:
+	local_irq_enable();
+	syscall_trace_exit(regs);
 }

-- 
2.48.1


