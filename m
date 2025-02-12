Return-Path: <linux-kernel+bounces-511006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A542CA324BB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 440EA3A2299
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF72220B21C;
	Wed, 12 Feb 2025 11:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I1WqzBER"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EC020ADD8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359394; cv=none; b=dMOL/xbrflTT9Vtv8OnUYpAE7+qgW6wGM7V0904qsWe7L9BI9yi++qnyGaZdmcTtEVTQLyTdwmnXT3gdHVu/a0dXjEqPhzaZeGcYmlux1sAxE9l9mPc/cBRg0GJYJXke1SIRPwmhfrIxiKEMt5cgjPu8g7FtTcNknTZ7npNdt3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359394; c=relaxed/simple;
	bh=e2Y7p8dyN9eqj7U5017bQRwN6g3lLgcIgAe2Fqj3P7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cabTt9iIuAQy0pBlwW5FhVcizd6RfzIJc5se6kLNBchy4s7eNSsTUa6HaDagWOivpHOJJyEyiipu5w2Qp+XlgNA8F+clAJAzOgYk6hx9RAExkbiU1rfo7XASbOFxHnpcj+vb/oiI0jFQYVOAw+IK7t9Ej2qKwe5fuUosrKq88Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I1WqzBER; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-307325f2436so61492111fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739359390; x=1739964190; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7LU1Mx0M1JJLQ6X7nOndn1GNJ7UBsOKiHS90jS7YqHQ=;
        b=I1WqzBER/sn25WPgjCITGMM1ahNXA7wQQ0kmBjB7svEiHlfqo8Ka8GBLtUpc6M26fK
         RGG9QOlsYQiW+n8OawC14IBI3mhbOlBdrclzdJywmDBqXTtRpEDlcaPC7qbT201vSLmz
         s7CW5UZkLWYmTMrsjJBgoKo1INVcyQ1C5LmnnJ5lP8QPBD3BgQ+RIt/03fvDXZ/S5c+B
         rPirYIjZz6unT1Zhq/NqI0bETuuCmpAg0RkMW96UYHSuF+RCiOTfqoMoC9ONybUx5aHF
         O0WYTAVJoW9qEIas+83YWRpP3th9hizaUtJCJbQ77AotGRFGxPNvp+MfIAdKrJ25ZQvk
         ZZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739359390; x=1739964190;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LU1Mx0M1JJLQ6X7nOndn1GNJ7UBsOKiHS90jS7YqHQ=;
        b=eE5vBzZO8awnroPTc/JVRnnzNrt1iTj3DLlPLBtMtp5qesG05TdGtPNODsIQ8O6/2k
         6qpn+mPXg7ygeaYTONEEgLG4PR30HajhDbRFSRvQU90Fbn8oHXtCKORDo9p34sgyWqm7
         8qh6zHWFt4HYbffqSajtKGIsB6E/7KCG0tblSZf+LccBEiTbUDWxC495BnhDtBdx9PBK
         nHaJ0WRf/yMmPpZGlyjN3GxUGg3IBk8hLkkP9wlzAKB0gbe4KtfNZrRNdq0WSnt0lrLm
         Z1XhJIFaC1e+DafNduYpNyUCkL77p+A5BqXDVoCmHaCH/uyns+vZOwllr+RNlVRqWOZ4
         5liw==
X-Forwarded-Encrypted: i=1; AJvYcCVxQP+A2UE1vWCtlFJiWH2tMlTRjCdXcQWN15ZROoL5mVomaApcRPf2XzGzIBcv91yKA9cMhozYwrJ62pA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3F5+7OJsqAY4BtCeFK/eW38XrMb1JIZFSi3ARrdD2l2UpGq7Q
	1bYX3kyiA8nCS/nQS4zXAFY2AOqL39rB7gSMNtcdrlA/GGdaLkPPsCH83QpMnzg=
X-Gm-Gg: ASbGncsivRCLXDPAZLA7nctp0coKX4bmg/dPw9f+DbDKsg0hQEpvem54HLIM4gws3Yw
	cqdyZaVgGG1yvv2CllbJHZ6197w/OYssd1qm+xP1lGVsGgwTwVQvBfN3ILT2CmCYMiD54WNOYsQ
	wut8AqUoNy1mA39tIk7kk98bUvBlANl/rbV9bVCviYpBvnogsK4Cmo4k8Kv/+2WuB99eaj1yYCq
	26kPIR06JmWSmzlhElmNzKGD+S1//tEXYLjcqp/tBCDetdNMSWVsZ365kUj49PNiImXQmKGHa1N
	+mwfa2jkNn1+TpZ1djs+EUWZWQ==
X-Google-Smtp-Source: AGHT+IFszoZ8SBA/9FJsuY6Uu27qPFJKW5beQGmqgaj/FjRsBLL1NiJEufHRTdvsslQRkUBHSfB1ow==
X-Received: by 2002:a05:651c:198d:b0:308:f01f:182c with SMTP id 38308e7fff4ca-309036b453emr11165271fa.12.1739359389988;
        Wed, 12 Feb 2025 03:23:09 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307de1a6531sm18310511fa.45.2025.02.12.03.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:23:09 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 12 Feb 2025 12:22:58 +0100
Subject: [PATCH v4 04/31] ARM: process: Rewrite ret_from_fork i C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-arm-generic-entry-v4-4-a457ff0a61d6@linaro.org>
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

Move the direct assembly call to schedule_tail() and the
call starting a kernel thread into a C version of ret_from_fork()
in process.c and rename the old ret_from_fork to ret_from_fork_asm
following the pattern in x86.

Leave a comment on what we will do when we get to switching to
generic entry with this as a base.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/include/asm/switch_to.h |  4 ++++
 arch/arm/kernel/entry-common.S   | 22 +++++++++++++++-------
 arch/arm/kernel/process.c        | 24 ++++++++++++++++++++++--
 3 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/switch_to.h b/arch/arm/include/asm/switch_to.h
index 9372348516ce9b80fa713966943d0bc622e86066..18d084aff5a4faa7cc5e40d48fbc4aa97a89b0c6 100644
--- a/arch/arm/include/asm/switch_to.h
+++ b/arch/arm/include/asm/switch_to.h
@@ -17,6 +17,10 @@
 #define __complete_pending_tlbi()
 #endif
 
+asmlinkage void ret_from_fork_asm(void);
+__visible void ret_from_fork(struct task_struct *prev, struct pt_regs *regs,
+			     int (*fn)(void *), void *fn_arg);
+
 /*
  * switch_to(prev, next) should switch from task `prev' to `next'
  * `prev' will never be the same as `next'.  schedule() itself
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 2f93c2f6d5b8fdf6aaf3dda0192bde144fcf238d..df6961a1006b7a0f3522728812bf52ccb849e511 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -5,6 +5,7 @@
  *  Copyright (C) 2000 Russell King
  */
 
+#include <linux/cfi_types.h>
 #include <asm/assembler.h>
 #include <asm/unistd.h>
 #include <asm/ftrace.h>
@@ -128,15 +129,22 @@ ENDPROC(ret_to_user)
 /*
  * This is how we return from a fork.
  */
-ENTRY(ret_from_fork)
-	bl	schedule_tail
-	cmp	r5, #0
-	movne	r0, r4
-	badrne	lr, 1f
-	retne	r5
+SYM_TYPED_FUNC_START(ret_from_fork_asm)
+	/*
+	 * ret_from_fork() expects:
+	 * r0: prev
+	 * r1: regs
+	 * r2: fn() for kernel process or NULL
+	 * r3: fn_arg for kernel process or N/A
+	 */
+	mov	r1, sp
+	mov	r2, r5
+	mov	r3, r4
+	bl	ret_from_fork
+	mov	r0, #0
 1:	get_thread_info tsk
 	b	ret_to_user
-ENDPROC(ret_from_fork)
+SYM_FUNC_END(ret_from_fork_asm)
 
 /*=============================================================================
  * SWI handler
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index e16ed102960cb01d625e2ccc484f238b824b03b3..81c1c3f988344185917cf4e53d0d8ee47ae912f4 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -29,6 +29,7 @@
 #include <asm/processor.h>
 #include <asm/thread_notify.h>
 #include <asm/stacktrace.h>
+#include <asm/switch_to.h>
 #include <asm/system_misc.h>
 #include <asm/mach/time.h>
 #include <asm/tls.h>
@@ -230,7 +231,26 @@ void flush_thread(void)
 	thread_notify(THREAD_NOTIFY_FLUSH, thread);
 }
 
-asmlinkage void ret_from_fork(void) __asm__("ret_from_fork");
+/* The assembly stub sets up the parameters and calls ret_from_fork() */
+asmlinkage void ret_from_fork_asm(void) __asm__("ret_from_fork_asm");
+
+__visible void ret_from_fork(struct task_struct *prev, struct pt_regs *regs,
+				     int (*fn)(void *), void *fn_arg)
+{
+	schedule_tail(prev);
+
+	/* Is this a kernel thread? */
+	if (unlikely(fn)) {
+		fn(fn_arg);
+		/*
+		 * A kernel thread is allowed to return here after successfully
+		 * calling kernel_execve().  Exit to userspace to complete the
+		 * execve() syscall.
+		 */
+	}
+
+	/* syscall_exit_to_user_mode(regs); here once we switch to generic entry */
+}
 
 int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
@@ -263,7 +283,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		thread->cpu_context.r5 = (unsigned long)args->fn;
 		childregs->ARM_cpsr = SVC_MODE;
 	}
-	thread->cpu_context.pc = (unsigned long)ret_from_fork;
+	thread->cpu_context.pc = (unsigned long)ret_from_fork_asm;
 	thread->cpu_context.sp = (unsigned long)childregs;
 
 	clear_ptrace_hw_breakpoint(p);

-- 
2.48.1


