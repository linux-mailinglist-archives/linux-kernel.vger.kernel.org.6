Return-Path: <linux-kernel+bounces-530963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4659EA43A80
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE486174FD1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C0C268FFF;
	Tue, 25 Feb 2025 09:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DPPMdwqV"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D2F267B6B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477329; cv=none; b=qZ73MoaeGBSishvP2FvGwRvRlfHD6+zc/t4u/ayLr/ACRDPd1RPcinqma3EnCPXIrZ4JdRFu3j9g0pPEQvGYNVJp6aQGg5aKwkOlDvFsNoU1CxyQ8K+upMduAMkLxZR3tw0l0ITrpLmwWLBLvkJDXctRm39PMrI+S2+uk1sLWmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477329; c=relaxed/simple;
	bh=CbbJpPkrV6dNgQPp6Cy/N2J2rfd+TtKERU6VuN6qhwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ns3x8ioEzNmjSiO3ncBHhWFdggv/9EM37L/myATsl7fAzEs1q76KDip92QycFBq2J/tZwdkeIVxxCAo0e6ntuwgqMg6MXigY24f0WCeB5gSRbFKxI82ivHaDY572wb4qvpQAsUBIP6s6nwkAjs/IZtKsmA1qKjdHY7cmYbLfr9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DPPMdwqV; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5452ca02bdbso5043881e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477325; x=1741082125; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0l05ZDEo5bKH98lcf/z2wVpVbfg6jDUAnt9TMH5HSeU=;
        b=DPPMdwqVHmwPpIfC+udgeeIdbGkVRGg3URrMdg05UB02cq8ma79kCkKe9leg61WkdC
         o1I1HUYOSAnEeyCeyXmQMUAY6udskQnoFowKHPI4TsYM4ZVC2ErSIBNN4llK717D+2lk
         Sr1F1zc4oVgDYn3IPKVaDevc7i7hvx2E3eY/W07WtAXIbqOM+brYouwai3SfJ1PkPLK6
         HhEynViJF0kyhFLzwxEkxMF85NGshuzBaLlAe/RIqpyIIvVrQO75zFSedyR84agdljG1
         qkGhH+nhOcSh0FuWiyAS/hSO4QbITwGKCPTUdq2brdNM4pTH7A/3biVoFIJCY3T9zs7S
         EP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477325; x=1741082125;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0l05ZDEo5bKH98lcf/z2wVpVbfg6jDUAnt9TMH5HSeU=;
        b=B/jyBkj5pG7fv9djFRx27ml+N85pw9qDUqEp8pFQgWgyO52cicAAQ9J+AoHyuz2nJZ
         Dfc8nM4SMYkFifriUhSpr8zYuUQY8//NZoC0VWNyyQAFQFtTs3jw0YyBvELCwJ0TG2iy
         nzjxfN4y5A3fi/EXtzWkr7C6rl8Qz8e9aaeTjORNhVV+j07r5Yth6mSB7cuHj3EPY+dA
         eVWBqeJKbEI7/ibe5zDFmBYGCouuL05MexGc1Ik7gbnFuladZ5oS72/5V0xL19qLKGV+
         sF2Fxres+BBzZsbzaLNCYy7PAlojg0Q7nzm+wyIVE69bFja7GDSqyZTjG8V9feYOjHZi
         65XA==
X-Forwarded-Encrypted: i=1; AJvYcCXifqhaB/sqglEpaxFrDolT9K8PJmLkm/ZW+zqCVekzzYlE1NLEAqgJ22Cg7ExDdxZRsu0UYsqSpApot14=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1HzWJBaojwXt/prejMZ483Rg5EZdiBDyIc47FZF4S7LX8rwif
	ukFyWIrh4WHfVz3FCafL1lxTcB5hhKe+I6vKQQOQvB3cIB7BUMAw7vcvH5/BfVU=
X-Gm-Gg: ASbGnct3wfZl6qx5y0F0fB4hewud29o4BtPvTiZRrfrnGR4S3NszX/LiT4I33Sxc6ph
	ydMym/dKlUtSplsB3RRd50fq5ohPqUKlF93oP+wifzNfAsJnc8ynTn39tK/PbyNEork6n8Z6Oxl
	bNiJE6mk5WPihM8+WLs7FATKGZTJEjZsdmsPP97Cjwd02gQ3z8IP/k60iHm0snlYvhg4svgjQe7
	DhtCATT9z9sC0afjIGAulifTmquCK1qVXbdjLc8gGOLN4gMaA6z9G1A2gDcpNBBiIoV7zPF8Nnt
	UC5UWGyzDtS/EhlOx0iBTirUFvnZ3dl9ER60
X-Google-Smtp-Source: AGHT+IGv9PupW5hC43RAbr/CGZZGm/FFBN/oPYbjQj0aMhZodLXr8EOafbq0GSLZY9dixj7FM743WQ==
X-Received: by 2002:a05:6512:15a7:b0:545:a2f:22ba with SMTP id 2adb3069b0e04-548510eb0b2mr957604e87.37.1740477325442;
        Tue, 25 Feb 2025 01:55:25 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b261esm132867e87.24.2025.02.25.01.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:55:24 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 10:55:09 +0100
Subject: [PATCH v5 22/31] ARM: entry: Move work processing to C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-arm-generic-entry-v5-22-2f02313653e5@linaro.org>
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


