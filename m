Return-Path: <linux-kernel+bounces-386762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C35D9B47AF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EC161C21151
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0111E20E305;
	Tue, 29 Oct 2024 10:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FcAYGfJP"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E61120E014
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730199210; cv=none; b=Yk9FYuK4TtgsQ55XW9e6XP6d5TgugOtYzbKkJFCNLMlJpF0z5Ni5GVNIIv1Lj6ikBNmMsxwAgkG6+6TOcqLMjD+7cWFu/q8LMFpfn0rlGiLo86DlDst39zs4/JLv8jm3+fKnuSSZ3wnTeQm3SSOAk2jbD8KKmw87UECKTGa6Rxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730199210; c=relaxed/simple;
	bh=oB6HP3SopbCX1pJb2/iEaIAmUOMLymz+4GahfTzk35I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FRk9WqZW4kTG45/y+pmmKKus+RuElQKO7n3L94lfJH3XpJrDXyr20u6MkEnB8kLXvyiZ+3bakXgWMzbUla+WGFRK2mSb8rUXu8dVXS1KQ9u62GGSQng/h7q44jLCemLrDZahxnJDiOPqDg4Th3PiBzv7RNzR/Tm+0nhqv7/d9Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FcAYGfJP; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539fb49c64aso8788780e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730199206; x=1730804006; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gi2KcUYCbZkPlsUdwrNEo9QLrpmnXM+YJIWNYO7+o8Y=;
        b=FcAYGfJPUM/gV2aR//C+h5LPdiRvm4sXYCKjpr3mn/EJ6n2jpeR/+07Ll7w49Gv41s
         QxuvySA05TTBKC0stEjm4BqLNFUgZGFW0Y0MwQjczAQOtrUQO/rta1iUKHeOgU5XG1uq
         XL7IQdriZc723SeltD8c39bTEcnyZUzDjAh6LsGWSvstw7R1RJAsXAkvZRPhAZ/xtAsc
         ILGXTByCCXzwtTlRXpny+jvwFtvOE4LYoVkSoZeo7sSTGBEJZpQAsjhmIVoKdm1wXECz
         gt0uecEQqMukMwqY7Twtz7I5SWvfVvBDIOkc1QeN684no3ahGqeqRPmPT9RWoKKmObrW
         cyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730199206; x=1730804006;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gi2KcUYCbZkPlsUdwrNEo9QLrpmnXM+YJIWNYO7+o8Y=;
        b=Ir2gN69gjKTdZh95dDTQ//IU9V5TiMwQpQMxVdcc9UDdXJI9Hk2/APF3MOdfiQKfEF
         QXkrFa3pxciest+h0zY1hNJ+XFDmxg/99mfkuWlW238Jy6PfeS6ASn2Kylqs2Rxnlgh5
         Wayczyz8SYFmuQRGHLn9FOU6zpRGkGaYZacPYsLv+etcfgMO/5JEF2zOvmEMgAaKqtfY
         U81AjRGTifgjBxsr3NEvOkijNTky7kd8PQzR8GWdlfsiyRTvACU0gYFHn8w6aFRvbFsA
         VJNx9CXFqyO3zXH62WXAVnGHy8wgSe6H9l/qOf07flPgrEUWY7RPIx/Z1OXP60UpWBuW
         DIRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXalIPVQq5YMEWY1oftRy/eO7kX51aZRrxgKiji1CX1a+2jfoEUjJAscRz9MfkjV3EuUWjQHGC5+3ts8nQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtSyS9Uu8GcNNX0IGYFz76KIbYVKYWCowrTIRTYn/LNgRWRwEu
	gq1nXID9k2w+AP3FpObs/5uJwmzwFver2XJBwOWXc/ID1cL0vn+hp0xsL2HTmOg=
X-Google-Smtp-Source: AGHT+IFLoqBuIKnwUObAl1tJTS1Bn4dPHs461dC4/LHdcT9FwMkp5b3gbbvcN/LNXtk6xKOfbTGsmQ==
X-Received: by 2002:a05:6512:3c9f:b0:539:93b2:1380 with SMTP id 2adb3069b0e04-53b34921b15mr9500411e87.48.1730199206270;
        Tue, 29 Oct 2024 03:53:26 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e12452fsm1351307e87.73.2024.10.29.03.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:53:25 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 29 Oct 2024 11:53:02 +0100
Subject: [PATCH RFC v2 22/28] ARM: entry: Move work processing to C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-arm-generic-entry-v2-22-573519abef38@linaro.org>
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
index 33bc9e7c5b32..5385574c4339 100644
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
index 472338047337..0e3960844b94 100644
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
2.46.2


