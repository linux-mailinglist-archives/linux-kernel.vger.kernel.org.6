Return-Path: <linux-kernel+bounces-386744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F7F9B4797
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADC0A1C227E8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD98E206E8D;
	Tue, 29 Oct 2024 10:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l0lR3nh1"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB512206E66
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730199178; cv=none; b=Ttlznk+W9DZ0dZdzvApb5lOoqUjKgEpiBkbRgeVLM+cK6gXbybr0gScH3wxOAMwZ8c/FCwXmWXzmeB3/7a2Jz7qKJFhiAmvAa6ZmFsE089GmcJRnJIg5M6PNnnGbi8cfN1vezXlEQL1ErXkTi2jwkztMthy6R6TdIhCH1yS8hOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730199178; c=relaxed/simple;
	bh=HgpuQCGct+VCXYretZz57uSNbkNJ0GIymihuDxTTfNw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LMM1mfmBSaFdq7Bigq09XpyHyT4WH3pXkY8mdaDk1oJXWmRD4tP6+/DkP5PLIHt81JQULZAPGyhshtnJmxjxP83dc3EsRzIFDfnxrViDBOKO+pBqiRPLpwRx2jVv7ZANHsCkPtZ3RMcfg5KpaE55mIwHK8KYcKMsyRx1HwPzcJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l0lR3nh1; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f53973fdso4452379e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730199174; x=1730803974; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TDl9iLJ9IcIQCUiDPdY7G7jOst94Sq4L5J+um8W/x4k=;
        b=l0lR3nh1gOYUzbe1vvR/i2BQJJaeJ9cffTrDrhsidHPPXGBdZJ9mKZJjEiD7jccmwC
         +l2QkriNAJssbSqpJtG7jCeeaH8qfTGZg4EK2mvrYYZJAswBxCJzHg3HfTNkulhVWMk2
         GqtvoOCZq5u7z9/p9i4Ho1jFBlLbhMzTqkvjKlCDj5Z2tnvCPvk3A5y7jVMXeJhodaxf
         MKb0qw+mW+ukor4re8cKSiCUtb/EEi9aSK7ccl1Oz/aYj2aAMnuSrvJWjEEheB3D1EvD
         StjfQpwfgLS+NIMp/xZhoyKc9kFFa55ORmz0yOXz00KNwP9aaTig3TDgGjQzd5vYtdnm
         em2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730199174; x=1730803974;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TDl9iLJ9IcIQCUiDPdY7G7jOst94Sq4L5J+um8W/x4k=;
        b=gl1/i6hFG0pkhzAxC8lAm10P24LT3UH51Ms+CwiTIgQ65fNFq2FegxO+9VgwyIeJV3
         8IE5qEx7l+KOl+ag4o1z6ZvqFuyzbKOZZUq6rDFtZj6amGPXAWGNtTC4fg4FIwLoMBzU
         8l+gWhXyQi6VFuKGadhN2i1QdyYLAwvSyB2TtBqrsylxnvEktxcC2gfQ8y/PZQtJGAEx
         dHnAsUQJltEqabKnnniTEAc1y+m2wmQ7Q8uqVKjUmq9VWfkQgyZoWXNQ37B0SSabO/3q
         fs9Yi/B3yu0UCBbBBSo8ANLQHOIEyRRFCbZAYqdkuw/rg8BCPH8quhNaKPeIWogeXGF2
         ombw==
X-Forwarded-Encrypted: i=1; AJvYcCVy1ZXyAk02+jkvT+srfzomJqCqeBmJ5GhZ53PdBRMIrycDL+mPqrA7GbnQ+Rni3qnuJM3507lXupGaHhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL3Fq79cLzKDwXh5vtbV6Xt4BXGhvKjd5ccD8y+mlLYUqj4Cxz
	0bhihq+CymGH9x3Psqk1SN2QAAn+T7q80vGnlgdjEtvNB+ZpRkT6YlFiMyJXI10=
X-Google-Smtp-Source: AGHT+IGfHm6faFqK8jdHk5n5plXPyzGC/TcHbEJEFWbtB3+ViWXDca9EpWy+Qw2QzBfYVVQTkU/ogQ==
X-Received: by 2002:a05:6512:2346:b0:539:e873:6d4 with SMTP id 2adb3069b0e04-53b4947e476mr663973e87.22.1730199173807;
        Tue, 29 Oct 2024 03:52:53 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e12452fsm1351307e87.73.2024.10.29.03.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:52:51 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 29 Oct 2024 11:52:44 +0100
Subject: [PATCH RFC v2 04/28] ARM: process: Rewrite ret_from_fork i C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-arm-generic-entry-v2-4-573519abef38@linaro.org>
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


