Return-Path: <linux-kernel+bounces-530945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72888A43A6C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D56361672A3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE62266B41;
	Tue, 25 Feb 2025 09:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bqRSA5fN"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B09326463E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477308; cv=none; b=IUxsAWg3F+57s0jFPoKErWk4Sf6RyJEFiCZQSE7f3ttscapZHT0/DfOCtbCenDgrtAkhrRhuSLrUmdE4CYaHp6Uh5Rst2wOy55JEW/t99jFCoRASK1SqIuf7hLWdHSOt+QiBOPG0qehJFqdXNOLIoGyYCiCYFQHW5Kezsp/KrSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477308; c=relaxed/simple;
	bh=e2Y7p8dyN9eqj7U5017bQRwN6g3lLgcIgAe2Fqj3P7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jPmrR6TQCK7iF+htJtmVnBuMNRnvOfDAYUvrV8JFDl5Ww99RFisWgU4b/xj1v0cNfmHrZ5F79gJ5VV11A6ThjT4g5DbsnD0T8IRNWdC4OIRP2Upx142F4+jvLMdwI85EUpnEV/Eh6EWSK+7lP0GsTgldXhxRtHV//yKIKYlc4Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bqRSA5fN; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30761be8fa8so58400491fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477304; x=1741082104; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7LU1Mx0M1JJLQ6X7nOndn1GNJ7UBsOKiHS90jS7YqHQ=;
        b=bqRSA5fN6E8krWpqOd8VGZEpqTQ7cM4dVr8AJab1pVot4biW3btcFoBErbF0QqlGp7
         XfAnnuvmy7zQIhl/YDRk44CxQfMtPTj7Hz8iB9kYxZzuS+uF6Fpr04RxFugfBkGuxZaF
         qAveVEQQ5W85JDJ2lSIPo53GwVl8JwT3Bv30FDAc3LMuAVBO9hEwy5O1o0E5+f+oTLm9
         GhVcm45eNSXtna+4rgkW6twBPTvgpDs1rrVmCNWYyFp7Zi/DDjR8YjHeMzLSQeidQHG6
         R4MQ6c1h+LSeEcJBVFzAkVjmFZXvM9dFkbZXLxXnBYKfGN9Zp6eazSD63Dupxoq59FQ1
         gEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477304; x=1741082104;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LU1Mx0M1JJLQ6X7nOndn1GNJ7UBsOKiHS90jS7YqHQ=;
        b=xErKmuYt51JlNbksxVTecm+rsx1ej60dKfUu3g8Wjg76LYGtei2D4gAxYes2e2+2H2
         dzgqH1k6uTNydzpfY4Jc/iUWduiUM7251yvwC/hOtZusg3grsuLr/zIIyN3XBKw4mMG4
         GVTmkiqGCkseVIWYJiuV26sg5oq5n+1HPqtov3zEM0uyLod83dXgvr+KPdAhaoP21YYO
         jhJ4+VF8HiK94/MxwPY62LwPfvEkRbYzDvfUZQ4CRIquDHPAGRFylex7TG1ZPLEcXjWX
         IXFgWps9OzDriTsKKxKtZk61wFWjX+CeCGutAlQOOg52KuVxQqWhSouBxb6aErxHUbOX
         ywjg==
X-Forwarded-Encrypted: i=1; AJvYcCUBqKV+f6d0x/5tr5BiueikmeU+iuHxuPFsvDIVTlvj5XI6/ee1VkGcQwW/3ImSCtGhjPzh/j7hiGClVT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YymmlKzLX+NKe/NuLCD7MglQxHOXZ9+Nbi1O9HPiIuA+MEgiQ1C
	a1q9Awo2CtmniNmC71mmf88jZJFp5HZk1W2CCTKAyN2AIQSNdzWhoddSYBgrCUw=
X-Gm-Gg: ASbGncsFB2KGJ9KH0OjZ0fYZh25CCj7XzPgbyg8m5XtNS0VQQdssE6pQFri9UnJ8ipO
	wIuZTj/PDxiLbHz7u+l2oPKN9UMDI9PrCNr5IucwDUioXViQ/FTwwsplSZPJ4OEyJIUfShkO7dV
	ds11bfwVxyzu/1Q8F83EifLRoVE3kgW3PDwkUb0zSMKftXp1pzZHuUnQWEzBdGRK1f9NbVZTkje
	u9ZDbZmqPmsgLtjuo5ElpNMizJMIdqpmzo0G7iFOMVU14VucY1qInQ3DNNK40virQ8bN8kP7QlU
	vB0fcHuKG3IzAU30UWLX5ATmxlEO51QII/qO
X-Google-Smtp-Source: AGHT+IFtzOWDVP2t0fNNEuMAk2DHjCVRvoPLmi06C6RBehYosOgRfNKzND5MSNgjwgco26/R488VhA==
X-Received: by 2002:a05:6512:104e:b0:546:2ff9:1542 with SMTP id 2adb3069b0e04-548510ef882mr775478e87.53.1740477304323;
        Tue, 25 Feb 2025 01:55:04 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b261esm132867e87.24.2025.02.25.01.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:55:03 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 10:54:51 +0100
Subject: [PATCH v5 04/31] ARM: process: Rewrite ret_from_fork i C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-arm-generic-entry-v5-4-2f02313653e5@linaro.org>
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


