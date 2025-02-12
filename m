Return-Path: <linux-kernel+bounces-511025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE359A324D5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF382167F8B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601B7211A28;
	Wed, 12 Feb 2025 11:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MXfv303M"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC85C211468
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359412; cv=none; b=QGONOknoUKQkqB/2Ktvi1UFwoGQE2XHfAqS+a2Rrm1h5Z2QWPPKdJPvHLqdQy2YAMeoZPt6Lq97s8Z3KF/U8hbjbwCrkE07ZUndUn/w6TtnSpIw0wfwQcdvlPStVfzuXIAMIFh7jB6amGVFwSCYw9zuWT9gJ2K6YqmHD78fEgC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359412; c=relaxed/simple;
	bh=CbbJpPkrV6dNgQPp6Cy/N2J2rfd+TtKERU6VuN6qhwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i5o4RR/A3HaaP7jC9tgoQQkv3Wwz8XVfCOjXb6WvJFf8rON6UBjorsYsnJcCXfncdtBl4GsepE5BmdrpaAnLgANp3W76/9eQFYuJSbDpezdoWQrej1Hvlm3MC0Cw83Dz62CdZO53aMUdkfIF9uDXtrNJZ2Wi3mueHXEQJLXLqn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MXfv303M; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3076262bfc6so71661361fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739359409; x=1739964209; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0l05ZDEo5bKH98lcf/z2wVpVbfg6jDUAnt9TMH5HSeU=;
        b=MXfv303M5PpWLGn5qBcH76Es3T3CFuahe6+f2ktrBdwg5w7mpTjclonRXGjYguhvyy
         BXyTQt194KnOG71ULVZFOYpUY0zCQJICXduDUP34XaSwf5IMblpgcicHHXNa2mhyOz+z
         Kie/P7E84z0Y9jdq5nLN5cq8Qf4yYWi+vt9CdfbLO9ODgd3E8tZN7NHc3ZVqiuqN9Abi
         lGD7Ny25zniwr0P0jxawnIMLqp51IMarVUS0AGKzo/DZ+VNdzg532dXPiC4I+0gVweUA
         BqnHQ9NCyPE+SIxNEo4ssN7/c2TSpD70vPe7qJux9/zbJKYXpTdVkhkxcScembztClNK
         YgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739359409; x=1739964209;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0l05ZDEo5bKH98lcf/z2wVpVbfg6jDUAnt9TMH5HSeU=;
        b=MyNXRmSWfuH0WdUnS32VBI/3J0YlDjWZkV/eliWeOhoU44GluwfDw9okCi9A9pJ8rt
         SNSlx1wJLPqbAhCIwoJ4b9zW1+zrTcsmg+OUqnbOFKqcjc0cUC4op++7RItzcxj/pzhf
         mbpQKle76Fqf9jI6PK+ClaZoMVaWGRU4SCahIuVoHBHgSZUL+EJw3M+KsWsx8q4OC+6e
         NPTxnPtNM6255FRkYVTVp0nhAzMYWJ+ao4QgberSWLX/7H34/hqBIAS+cGhKWNz76kHB
         zUl/u5iSQlL5JGprKU1p3B93kNKZE6VdrF1dkc0viZ+UhAKZ9ffQrXRZGZ9Ov+DzJn0L
         w5Mg==
X-Forwarded-Encrypted: i=1; AJvYcCU/S3Fsmjd/JX2umTAcQZk0kF9o/TF4TYPKGYqQGen+I7MZ9+MitVl0ooizvzYOzPwOUJnwxY/qBwHgF8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc/vgIZS075bxPo+dhQ/oZbJeRvWR7Y2jPgaNIJF4/kSSk/ofo
	Sqq5pf3zU8WLW31D3yj/p95gs6lFgHCajXyuONXrruoHI8O2pO8RW5DfuRDZrTU=
X-Gm-Gg: ASbGncvPd9mHK3K+h3S82NTgLTYTEDKCUJRzqErtZJMcp6Fba0pMgBARn15wBrUeVQ1
	XAfZjMvDHf9KORi6WSJ3Q2Rx2i/vA3i7hiuekaPXhW8Yj1cyS4J21qqTuMV6oEMb6WsyD/JD0ld
	lLDlor9t01Ms8LulAfhZF1Fn3s0FtHVEc7SkR0+qYAvnB4n/G8+k33n5UAyu1oNgvhwsF4ySRGW
	tZkIwNLIwsfBI01BzmysGkEQVXxE3XaGLEQEliQEBTLx73BE3uakJaeHjjneP+xxW2fW2f/b7+/
	xJH59TRa2ER5ndW6juMhU4VHIg==
X-Google-Smtp-Source: AGHT+IGSxmUmsIGZU6BTQUkSp0x8dKEvIYRNw21ZDleo+Ua51tS+VPbbp2jic1YKzEdrANQKDuDojQ==
X-Received: by 2002:a2e:bcc7:0:b0:307:2b3e:a4a9 with SMTP id 38308e7fff4ca-3090366fe24mr12618001fa.20.1739359408813;
        Wed, 12 Feb 2025 03:23:28 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307de1a6531sm18310511fa.45.2025.02.12.03.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:23:28 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 12 Feb 2025 12:23:16 +0100
Subject: [PATCH v4 22/31] ARM: entry: Move work processing to C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-arm-generic-entry-v4-22-a457ff0a61d6@linaro.org>
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

At the end of a syscall software interrupt and every time we exit
an interrupt handler we check if there is work to do, i.e. if the
current thread (userspace or kernel daemon) has set the
_TIF_SYSCALL_WORK flag.

Move this processing over to the C entry code.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/entry-common.S | 14 +-------------
 arch/arm/kernel/entry.c        | 10 ++++++++++
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 33bc9e7c5b32f62474724f1d47f97af24dba53bf..5385574c4339714f3d8b5ab6894f27466b89f932 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -42,19 +42,7 @@ ret_fast_syscall:
 	/* do_rseq_syscall needs interrupts enabled. */
 	mov	r0, sp				@ 'regs'
 	bl	syscall_exit_to_user_mode
-	ldr	r1, [tsk, #TI_FLAGS]		@ re-check for syscall tracing
-	movs	r1, r1, lsl #16
-	beq	2f
-
-	tst	r1, #_TIF_SYSCALL_WORK
-	beq	1f
-
-	b	2f
-
-1:	mov	r0, sp				@ 'regs'
-	bl	do_work_pending
-
-2:	asm_irqentry_exit_to_user_mode
+	asm_irqentry_exit_to_user_mode
 
 #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
 	bl	stackleak_erase_on_task_stack
diff --git a/arch/arm/kernel/entry.c b/arch/arm/kernel/entry.c
index 47233804733752aef0f2fec6f54badeab18e98d0..0e3960844b94b14325eb00ce7dd791b36c43ac3c 100644
--- a/arch/arm/kernel/entry.c
+++ b/arch/arm/kernel/entry.c
@@ -1,10 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <asm/entry.h>
+#include <asm/ptrace.h>
 #include <asm/signal.h>
 #include <linux/context_tracking.h>
 #include <linux/irqflags.h>
 #include <linux/rseq.h>
 
+static inline bool has_syscall_work(unsigned long flags)
+{
+	return unlikely(flags & _TIF_SYSCALL_WORK);
+}
+
 long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
 {
 	trace_hardirqs_on();
@@ -18,8 +24,12 @@ long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
 
 void syscall_exit_to_user_mode(struct pt_regs *regs)
 {
+	unsigned long flags = read_thread_flags();
+
 	rseq_syscall(regs);
 	local_irq_disable();
+	if (has_syscall_work(flags))
+		do_work_pending(regs, flags);
 }
 
 noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)

-- 
2.48.1


