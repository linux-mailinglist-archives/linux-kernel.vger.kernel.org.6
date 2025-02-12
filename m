Return-Path: <linux-kernel+bounces-511013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CC5A324C3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49E9C16637D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F65620E313;
	Wed, 12 Feb 2025 11:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dbv44a/p"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F47D20E006
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359400; cv=none; b=n5Eh4HGRIpJDhY8V39OiFzWGnsSvUWYZFpHpuMVSzLNm/W3D0ELkT7sQFynoS3/9ZIljk1xMzCNHZmj0NhO676G3Ku+aueWhzsQQXNjf1wqV+WPjuATQ21xLc7jR8GT5Zwlqwm3u1TyQHs6PhQjh8XtJDDu+fH1dwbCMznH0N8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359400; c=relaxed/simple;
	bh=NlFGyDqKyhRPmpPMwIP/jihNWikR562MB5e5yJWNB0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A+nJOnY5l0T0R0xUt70fD1wf1WKEohSqycgk1/KZVSNDhUAGz0Cy2qarsfCjIDyJqqKxD0/TSRg5H7A7E/jSUg1B/WNdw4JJEWLvZc8jznwEbB/0LKlIxVRkqJh5YquxqFCa/qmEz4xbjuSRdG2kaqrBoHYWjFdilF5bhNQc0ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dbv44a/p; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-308f53aef4fso23623451fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739359396; x=1739964196; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QZ+1V9qTPsDzOzqvLQMw/vPgzhrwZ5TSLeEMjw/aHNM=;
        b=dbv44a/paWTpmBo7yeFCPfBhLHdF/ucTNdVqQs0HmMQ44fFHfqXc505w/GoTy41co1
         Ipjzj68AKnJdppkkiKlOyHVeo2HgY7b2Zpovjn2jMkCWt2K0s1splCxJ0+LX+Ksme5ms
         hhyDHPovKZwnhZegbT64p/YybF9xaNb5f0ARKOvw+od7nsZ2R692AajkrjblnUWbBxMt
         yaUDRuJvcW4AzMzehO8fTJvofJoIZaS2jEbv9rpYSaHV4FwL+6PV70BjZ+ydwA5vdKxz
         qBzfkDaMt33258+CCUqZOdGyY+OAQBI24IXCqngzjwHkz35BruvoZBE/8hHKcXaSMe+3
         Bsjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739359396; x=1739964196;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZ+1V9qTPsDzOzqvLQMw/vPgzhrwZ5TSLeEMjw/aHNM=;
        b=Ls21SM59PNDzS6pZ83UtxgdzuyYbipc/FRS2NHt7S95PLEuEYHUROQ+H1Gj0OIfo8g
         U8utpF6U0IAYgUzrKicgG/hosES7Z/Sb97wei8b5W6OFqiG/SZ962T0a9bcIu2UgW2ZU
         vGuL/gWGEdQY5lHLTJPwcG4yNZhulOdpmL0mESi/zK0el37E/rALX0/a6lb7dMxB7g5m
         FmzeTPeb3dK1hcEesT5Jl9V2ODfAZip9heVBtJbmYcx6qZsePGtK/7b6IB6Av3HdqSqM
         i9U0fmJofu1jlZsqZxgLIBkHc6vjcr7uB8j2IQEX5o8J1V37bd+90rbK1+J7MiB89Sww
         GVbQ==
X-Forwarded-Encrypted: i=1; AJvYcCX45IW5jpUQrS/3gB8hIr7P4wqi83zW6UGEwxDSn8HFdkEFdceEIh6y//A8N9heQ3TA0xkiPmiwznHtjDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyySqrFmCTok4FyLd1DxZPad5B0Tbwi58R7QfO9M5sMwhuMsMDO
	gZpzPaMMXACV3WNXM63cN9TILSrIUqIZJeXYZe8pT5TtGHrtdeLdzaf2+99ySs8=
X-Gm-Gg: ASbGncuLbDQYVNBLSJnC1JsNAM032amrpi2ZPdEBkSh7SSZzN+KjwQ7j/D+v/eulAYs
	1CGaMT7LwaRilj03TvtVIQg3+nc/tl0tXvFP8ZwzXj/+V9YmtZgolNXqQU6ZN3vBs0zxNbJKCea
	H6BcKF9am4ySNvgKlJTku2yPRrwHkRGMqxMhfa4mNgpMgciNn5mF5gElxZXD+f9xTpqH9P3Yz7n
	KK+pbcI8Ym0tcynOs5o7TZ+qsQW0/pmyst3NE6gh6n8D6O3QGZq4FPfRUJftUu18Vo38d42+7GA
	eLc4XECsPvst0CQBPIKsi7yO+w==
X-Google-Smtp-Source: AGHT+IEy2zhtjzr1xUwkwwU7OEnGwL574LYD2AIUrLmh4kmR8+NHxnHLbPnyZ0TB2gEDQ1t6v/qifw==
X-Received: by 2002:a2e:be22:0:b0:302:3003:97e with SMTP id 38308e7fff4ca-309036dbf25mr11761381fa.30.1739359396492;
        Wed, 12 Feb 2025 03:23:16 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307de1a6531sm18310511fa.45.2025.02.12.03.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:23:16 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 12 Feb 2025 12:23:04 +0100
Subject: [PATCH v4 10/31] ARM: entry: move all tracing invocation to C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-arm-generic-entry-v4-10-a457ff0a61d6@linaro.org>
References: <20250212-arm-generic-entry-v4-0-a457ff0a61d6@linaro.org>
In-Reply-To: <20250212-arm-generic-entry-v4-0-a457ff0a61d6@linaro.org>
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


