Return-Path: <linux-kernel+bounces-386763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8E89B47B0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 626CB281009
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4DC20E319;
	Tue, 29 Oct 2024 10:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JIUmOhCx"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC4320E034
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730199211; cv=none; b=EWCU2weDenwWAlZHKyuUQA62CPTSxAS8m8r/+5srRYb4AQSOu91FpqqfDoaGlp743GH1ek89SAey+2dUQMOoONQvyXgy4xjAmmgA1R7vrmTL2elxPeg+rV8u9H4QpKa7cNIg43RxfhnHAjjE122OAs7wt9yZooKo3ovg+gEEAXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730199211; c=relaxed/simple;
	bh=iM/dQm4bBW4OzU1EedLHO9rK90B09M3TWGeyZRpr9ek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pun/Dkc++ICSh4MtYHPnv32zojkOqI6fxndotDwsXGwT9ytNmX4u2t0e/xBu98MSKYQTc/95bcJM1U5U9mAB5XZHkTUcB9+R/in5PfxvkPExoT05RdaIiXR5x88KVv3YXlay+mHTN0I4nM55x4p2SeFouu4zhzgMZL6yyw2R9ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JIUmOhCx; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb5be4381dso50274271fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730199208; x=1730804008; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bckn3YFGIgJxyi6JuzR+D6XCfS8U3/QVQiTYkjNWbHI=;
        b=JIUmOhCxMREd1l7USzFDF3OSwQcTCbdIZtbXyk2YrFzA/Sy4UetepD8hHQgZP5i+sd
         UjHn7G8GA+h5456t1l9H2Z95eYgytOTOjLnV6qfoIbDVHDBX2zIHVvO5uy3QK3jFubJG
         DjJ1EBolHoKYm+wgBjgvJOVs3WlIY8QYorX7Tx2LWClCXzJJYC0lntbzo44TlgNHZyJa
         I4MUEzxgYACgG9Yjx9fvMnQnCxh+hl67TEEWsjf4ld1CDvBgo5+UZuwfreFdwOBYWMbn
         KkbpDcm82v3HAQYsrMMAgf4hfFh/Wvo9EbIQ0b+duDnv8wjT0FSWKwgVSj7AwhgwwJfQ
         qs9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730199208; x=1730804008;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bckn3YFGIgJxyi6JuzR+D6XCfS8U3/QVQiTYkjNWbHI=;
        b=mo//dJ6xj+JHlxvq5m3j0IdpCoYZDYMt4PDPv7AGHxMCZruF7lHNfDnneWnRyNj58O
         V+C9tP5qPGbwRi5Y3aY89fsrHLQI9suZyjGwbNIsPXI8pRLlrwSShcXq1VT6TOlRwIJz
         AHa8TGMvPyYWzaWU66Z26VSsENPuy7y13UKtKFtg3+2YfX1PqOrIY8TmRyf6biWOZmmR
         9yCm5coAyAQEUHHvNFRNyZO7UjhMGG90FB2+ZtvJpsckHdRmBDnZScyEIhON4ZgumJIb
         mS1EMPr77W0GxcrsiCF3ykc0Zq5HmIHR7YUi0ZjshM/jZ0CF4xoZ9HPPuf4ybfTups64
         ukLA==
X-Forwarded-Encrypted: i=1; AJvYcCXtYsWRuwZj2Z5zmZY9IyvIHER9jNnNnUOoWenN+X7yZ28uqt2h2cnL50bxvHKkiBkwEzVNCtGXCVkdkOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn0q3GOsBui4FQ9xIeV7t8qz2uSAmOXpcCoa61kOGsyMRdz+eE
	+TzvQx6QDkvP1/Q6XpcTmcV812I5uQZAc428b9Ayx6m73QV4HoIf2iDl0P2U02g=
X-Google-Smtp-Source: AGHT+IGgLkurQIqH+LeiVKuUnK882zQSAt0h3jg5bg57JzH8xBIm92K4anGF7sihxb5wM39FF6lmHQ==
X-Received: by 2002:a05:6512:3da3:b0:52e:76d5:9504 with SMTP id 2adb3069b0e04-53b348ec0c6mr5342333e87.3.1730199207896;
        Tue, 29 Oct 2024 03:53:27 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e12452fsm1351307e87.73.2024.10.29.03.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:53:26 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 29 Oct 2024 11:53:03 +0100
Subject: [PATCH RFC v2 23/28] ARM: entry: Stop exiting syscalls like IRQs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-arm-generic-entry-v2-23-573519abef38@linaro.org>
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

The syscalls are issued as software interrupts, and to this point
they were sharing code with the other exception handlers, but
this does not work with generic entry.

Make syscall_exit_to_user_mode do what irqentry_exit_to_user_mode
does at it's tail, and drop the invocations of
irqentry_exit_to_user_mode from the syscall path so that these
are now exception-exclusive.

Split ret_to_user and ret_to_user_from_irq into two distinct
execution paths.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/entry-common.S | 14 ++++++++++++--
 arch/arm/kernel/entry.c        |  4 ++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 5385574c4339..e2ac6d3216b6 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -42,7 +42,6 @@ ret_fast_syscall:
 	/* do_rseq_syscall needs interrupts enabled. */
 	mov	r0, sp				@ 'regs'
 	bl	syscall_exit_to_user_mode
-	asm_irqentry_exit_to_user_mode
 
 #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
 	bl	stackleak_erase_on_task_stack
@@ -62,6 +61,18 @@ ENTRY(ret_to_user)
 	enable_irq_notrace			@ enable interrupts
 	mov	r0, sp				@ 'regs'
 	bl	syscall_exit_to_user_mode
+	ldr	r1, [tsk, #TI_FLAGS]
+	movs	r1, r1, lsl #16
+	beq	1f
+	mov	r0, sp				@ 'regs'
+	bl	do_work_pending
+1:
+#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
+	bl	stackleak_erase_on_task_stack
+#endif
+	restore_user_regs
+ENDPROC(ret_to_user)
+
 ENTRY(ret_to_user_from_irq)
 	ldr	r1, [tsk, #TI_FLAGS]
 	movs	r1, r1, lsl #16
@@ -76,7 +87,6 @@ no_work_pending:
 #endif
 	restore_user_regs
 ENDPROC(ret_to_user_from_irq)
-ENDPROC(ret_to_user)
 
 /*
  * This is how we return from a fork.
diff --git a/arch/arm/kernel/entry.c b/arch/arm/kernel/entry.c
index 0e3960844b94..88a7a699306a 100644
--- a/arch/arm/kernel/entry.c
+++ b/arch/arm/kernel/entry.c
@@ -30,6 +30,10 @@ void syscall_exit_to_user_mode(struct pt_regs *regs)
 	local_irq_disable();
 	if (has_syscall_work(flags))
 		do_work_pending(regs, flags);
+
+	trace_hardirqs_on();
+	/* This context tracking call has inverse naming */
+	user_enter_callable();
 }
 
 noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)

-- 
2.46.2


