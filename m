Return-Path: <linux-kernel+bounces-386750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACFA9B47A1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A063280575
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117BC207A25;
	Tue, 29 Oct 2024 10:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dnRxapY/"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54762076C4
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730199188; cv=none; b=gRkv613yYGWTWjCkDHZRliwGsbX9zji4ytUbLteJr1fANRK91AdTvZRDlOVzGbi7maoGtge+jgcIqJC0D7sy10+Vatf/d4ciwKVZ9KTm2xnMSamO/zlvWRxBApey30EyA+JCT6ZkOyk5DICTzOZ+6rr4a5y3IQlkyhQCTeEU1w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730199188; c=relaxed/simple;
	bh=qkK3Y6eLdgBo76rzyOTfD4ef26pREyX7JWY2zTE4baU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u7kz2LN11L6/sYl3OIcHi+pC4PUdwEYB6utCOXxFMbo6+3UWdwgtl2S6Ql2lWEGd07X/kB1tkK6fA6Fs+Qd+qyDx+h3xksmkpTUU7kN+yX3hL/WmvoufUUbrwkBLUzO402ggFMT5Bi5jKrmmIv5YJnToheJRG/7Bid4GuExu1Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dnRxapY/; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539e4b7409fso5072544e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730199184; x=1730803984; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HAeVmp86zd6G4zC8AXuoLcHe5Kdpm6JlP18N2B6Kh/4=;
        b=dnRxapY/qRiCD+KIt66YGtsGzBX7gjU2RydehDOfPJTllBOh5L76YiUyTRQqqMZ/03
         9RAATHUEQXcldObGBCHQ/u2/0FBmjFcGO4alWjLrPymaAJu03R6oBfKS+qc03tWfwhau
         oHTffRUMdmIi+nSxeeJVvCJMYgrdNskJcrmsF15Iwop5aEPCKYHHAdkBfar0Lm2sn98p
         iPR3GCW2Wx4RtDpOGy/v1itQbRYPDlA8MBQ27M38co+oG3XvIHTN+hBLLSB0BuV8fn0W
         7W9E5pF3XtXRxtFxsP6X7YPqL9BqBLMcVvmECuiA5itGmFm5huFM6v6UzRfAEE6ueUEO
         p/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730199184; x=1730803984;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAeVmp86zd6G4zC8AXuoLcHe5Kdpm6JlP18N2B6Kh/4=;
        b=N8QQTgRqBzkMj06b+YaWhH2C49Z6aHciyrKYTnq/J8+mq9cZExWcpzfFIVAwjOQlEY
         ZIEMvl5xrUIOe1Uhu9ALNsvDqUa9Il+Ca8M79fpkE82BaN8nKFHAOIrnnXL2gKIZgT+R
         C216Tm+7smoTVWNAEgdLPjxBNEYaYBrfjwRskZmHBeI0KLExo1cuyJbvyv/jNmS483Wj
         h77OACosB6vd3DpNQoqWTMA+tZpIXu737QvRytJivPsETJ4G4VUBJub+aM6BCpm6Vnlf
         nwbkzqHm0Sde6Z/9KAbCQ13VeVf3TLsKHhLp5KT+u8LnMkw3VFUASDPbmHlsu++r9cVy
         k1WA==
X-Forwarded-Encrypted: i=1; AJvYcCXJndVrmSdvQ91XGyOAruuOtq+qi2xLS7SQNwp0XQKBHvHgS4kWRZ20plsQb8sUIjh5x65ZhO4GSaLMtqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzxaeXfV2Vrmv/WiohUfaoa8WguEjPLs7gcWdJTgp87ObW9IJv
	xKjTp2RIWu+LYNhvizwYNJ/HY4nlz44s2sQ8xj00edPa37ocHDAReh7t6cipeoM=
X-Google-Smtp-Source: AGHT+IFefyGlbbRKMfUFrz0xvxG/5dLGzWVofaMM/165xooZgf0Xpl0v+lfmrHJRxGbEyXi2pOzvbQ==
X-Received: by 2002:a05:6512:696:b0:539:fcf0:268e with SMTP id 2adb3069b0e04-53b4922ad58mr608713e87.14.1730199183928;
        Tue, 29 Oct 2024 03:53:03 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e12452fsm1351307e87.73.2024.10.29.03.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:53:02 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 29 Oct 2024 11:52:50 +0100
Subject: [PATCH RFC v2 10/28] ARM: entry: move all tracing invocation to C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-arm-generic-entry-v2-10-573519abef38@linaro.org>
References: <20241029-arm-generic-entry-v2-0-573519abef38@linaro.org>
In-Reply-To: <20241029-arm-generic-entry-v2-0-573519abef38@linaro.org>
To: Oleg Nesterov <oleg@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
 Will Drewry <wad@chromium.org>, Frederic Weisbecker <frederic@kernel.org>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Jinjie Ruan <ruanjinjie@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
 Ard Biesheuvel <ardb@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.0

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
index 66067d165ba3..cb0073c4151b 100644
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
index 8baab7f97f59..dbc947d301ec 100644
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
index 07b0daf47441..ac7b98ae4724 100644
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
index 815312f7b254..3ee367958298 100644
--- a/arch/arm/kernel/syscall.c
+++ b/arch/arm/kernel/syscall.c
@@ -17,22 +17,34 @@ __visible int invoke_syscall(void *table, struct pt_regs *regs, int scno, void *
 	return sys_ni_syscall();
 }
 
-int invoke_syscall_trace_asm(void *table, struct pt_regs *regs, int scno, void *retp);
+int invoke_syscall_trace_asm(void *table, struct pt_regs *regs, int scno);
 
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
2.46.2


