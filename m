Return-Path: <linux-kernel+bounces-358881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD636998509
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492CD1F27135
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959031C5788;
	Thu, 10 Oct 2024 11:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kq2qMXyE"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6A31C4616
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728560034; cv=none; b=qki3yZatpqLNTSfoeYGC1dG+uSmOOfcHQu1Qe2/GZGOF4PNSeu9+D59YB62Qm2bcuBwibrDYjZZcbJnSS0T9IVgl8QUx44u7Z7IRfRsMyC/HS0r6pHjRCm6PdDT+0uXxiN6PwvxOHj4wDOyltDbPKymRh0jHa6nV4azXwNOOFVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728560034; c=relaxed/simple;
	bh=HgpuQCGct+VCXYretZz57uSNbkNJ0GIymihuDxTTfNw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cE2YHY9FjUdBzOzgEaNJEQOR1WklqudfmwrD2z/Nb/r2vNgljHtlfpzmYp9lRDKi2HcMdKhEmkbl7+7q4IEHp7FPPwxIw0Qr7CKkhZm5sOKdgIiASXNB/YwzpDCDD0gpzFno5443QDHDPAfQZ9ChLFiH65jxAdni1ArnK7C87jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kq2qMXyE; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fac6b3c220so12352001fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728560030; x=1729164830; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TDl9iLJ9IcIQCUiDPdY7G7jOst94Sq4L5J+um8W/x4k=;
        b=kq2qMXyEtyL9KuI9wUVnuxiIUf0sWEap56hCMBAAMQZVRQI9YZXZ7TO0YJJnd7QTWE
         MV1ZdNN9h7Uzw4X8mIU2x4Y54CMPJsNXW5lZiiMIh52OU25hWP+UextpcoTKWrxej7Vy
         3QF84z36b2H8wMeZMfTccoAo/xZl79xozVsNmlh/SF5UgC7ik4QGXSzdoSzs04KkXAvv
         j1jyIllFF1EA+h/KX9Uls+mxJHUY6P5vc81GYiy1xE6VY5oOzgi9QYNfOCRXvmuunecC
         mijvzoSrtwPJIHhLLECRdKIPso1RTadni4L23zxjeq+d5Dko7dQ6bJajJYmy5u4lXQnx
         ZiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728560030; x=1729164830;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TDl9iLJ9IcIQCUiDPdY7G7jOst94Sq4L5J+um8W/x4k=;
        b=xH3vdtmh7CyLtzYUaY7cvSJ5It4vAWiSLDirQuc0l6agHYwPTGR8iOyOl5HEQxmyCs
         udkpjMus/zMT91tglYioFASJum0O4mtQwS+XClx+CHfOhuupcma5Gn7dkl/nZjr6FTSJ
         K4mUbuiKxh9ZCVBsAVeVZ1dUK16FUdAWOCYldazNecHeS8HvQ+V6NsigLzXOvINBL6Gx
         GbsLead8TbIijztwc676w39JCs7LzF7BkY/keD9wvDY0zdE/qxfshfZ+iFzIqyRnN0/x
         lQOT5st4+I2qcqAxN1djZ+mgoeRXDkWCTns0HxEy415u0TegBU2LPZG/J1I9Icveow/d
         ODsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUnpwmBsnYBnVvedmR747VBBGB1nXkyKM7MxODi1G+DKxyr/G58//kfpwIh1talrNX4wTU3aLMPiPgEqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQko9yjoqaBRaZ2kvAcyijLblnx65DwyCWWHklD3A6EmrxcOjs
	QvnPEr/j2hYKv4yQbVDP3E/fpehiIGQQYcqpkPHVZwjn8BcosQL4/w1RpaUc9nk=
X-Google-Smtp-Source: AGHT+IFYXNUhaWmpiLq2q8xgds0Kykd3WYlCfTU5AddMN69mncHRj5KixgWaFupTNP5HEIlSrViaww==
X-Received: by 2002:a2e:b8cb:0:b0:2f3:f1ee:2256 with SMTP id 38308e7fff4ca-2fb18807a65mr56092621fa.44.1728560030103;
        Thu, 10 Oct 2024 04:33:50 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f25406sm77619066b.69.2024.10.10.04.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 04:33:48 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Oct 2024 13:33:42 +0200
Subject: [PATCH RFC 04/28] ARM: process: Rewrite ret_from_fork i C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-arm-generic-entry-v1-4-b94f451d087b@linaro.org>
References: <20241010-arm-generic-entry-v1-0-b94f451d087b@linaro.org>
In-Reply-To: <20241010-arm-generic-entry-v1-0-b94f451d087b@linaro.org>
To: Oleg Nesterov <oleg@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
 Will Drewry <wad@chromium.org>, Frederic Weisbecker <frederic@kernel.org>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Jinjie Ruan <ruanjinjie@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
 Ard Biesheuvel <ardb@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.0

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
index 9372348516ce..18d084aff5a4 100644
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
index 2f93c2f6d5b8..df6961a1006b 100644
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
index e16ed102960c..81c1c3f98834 100644
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
2.46.2


