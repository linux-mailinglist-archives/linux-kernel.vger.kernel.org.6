Return-Path: <linux-kernel+bounces-386766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D94C9B47B3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FBD91C20A1B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F095C209666;
	Tue, 29 Oct 2024 10:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WLNCzxAJ"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096FB2076A8
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730199219; cv=none; b=UYupqJ9sjno87z3Aq0MPKnAJQ9LizmatmSefGR7abxNehJpNw3Hw5wFiRMiCpEvaBuAMDP8vkEvtl0RFjvdkOOfjyfA0bnej7P/By74670x6rOwpdYpQvSqLjYphW4JxLT0GnsQ8BdUhQbD1J+aulS1Y72twSb0bGiwlLvVQLb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730199219; c=relaxed/simple;
	bh=p++J5jDdayY9hU28M7/pcg9MrpkZxPTcO20YZjwEn6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qxolrndMhftUaTYUS5U52KSLSdONAcUA5lPiOp/DU8YFWQk08wo/MyFC1enZT7bKTorBSTgEVcm3/vQ2hxfB2B+GhSM7vFkqB4+A61sBR1jKzGGMouO3SPa3x9L4FSFvsqoE2/6+ejNeNHrE/qpqQgMsOYApXp53KJQ72Vrabg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WLNCzxAJ; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539f6e1f756so5518583e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730199215; x=1730804015; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZScZ0+O1z+KD5ly1wGwp6XJNh1QIX+DiUm/Qzjn1DDQ=;
        b=WLNCzxAJw381+jUh66ndCHEcVC+2L+JyxOYBd1ifdn3b8V9WjSsumG+dtmAfZ1iCml
         s+oKGTgqDOoGpzaZZAf17e2jEWJR8Brq7rhEzYFYMFac+TlcpiIfppXH6t5A/M4btlxy
         dYhZXWfOWzs8+o0oRCT9HTltjXlAWSpdeeqN/9i2dA/cOAKuJgA7RiSqb7IYuYJzlCT6
         3oV/L1A4L4047Yximk28vBvEau2ewwSoT/itFhBPSR3Mf4Rb43gE9kTuiyE+7LG3FSai
         ViIf16kW0rcJ8VqmzWSsVPT211AWWrupdNgJmiQJSrOAxBLrMzBqcsVYk/8TVpvDVwTg
         qYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730199215; x=1730804015;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZScZ0+O1z+KD5ly1wGwp6XJNh1QIX+DiUm/Qzjn1DDQ=;
        b=XHy+2e/d/j54+V1cyleW9G+zY7o9Tv3Lxiwkr5Gw1BupsnY9bXMTEPaDNdjnqsXu1p
         NXEyu5KgkbRCSm5qREiyDeN44hptmZ7ekOvLdjLDBRKsGd1ye0nKKGJltv96zLCRRNIW
         f8jaFbdTdG2xwx3VX8qqkJKD3PtHZ1fVHAcfzBcoLGn/X+HKjgmW6Rszykib25A7lzzu
         a3llmuV5UE1jfT/g/N283LRrYJZaaqNZOQleu0w+LxN3BHwJS1gPRp9KuaPqTgQzzzao
         GOh4NufmkEoUubhdnIkHODxzcrgEK4RTJCBML5idUk+dL2Wd+a1Lu5QWK2zix9e++cy4
         +kwg==
X-Forwarded-Encrypted: i=1; AJvYcCWoNdb4ATO/yMcWUKtm8ndshLgIsMGPHmxklWSOphPJp3tmAL46cQDL2KxDIzjTFzKXMJrmhBnVb/mG8t0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLcdmv0jkX+fKJbmWUvNADAHrI1vGcxPcVSiIP/s1BLVR5w+19
	oExx++qSs7FmMMyEBQfAO+2V9msQpeLL15YxTOS/XrJpo3irCHlwaVdaB/+e/zA=
X-Google-Smtp-Source: AGHT+IFuQtccSquVaHeIkt6pIsoMJv+xdK5WssF0bBYkK4KjihYMKnkM5Ythh/2t9kCbB2W6mYSllQ==
X-Received: by 2002:a05:6512:a92:b0:539:fd10:f07b with SMTP id 2adb3069b0e04-53b34b39774mr5544494e87.55.1730199215170;
        Tue, 29 Oct 2024 03:53:35 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e12452fsm1351307e87.73.2024.10.29.03.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:53:34 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 29 Oct 2024 11:53:06 +0100
Subject: [PATCH RFC v2 26/28] ARM: entry: Move in-kernel hardirq tracing to
 C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-arm-generic-entry-v2-26-573519abef38@linaro.org>
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

Move the code tracing hardirqs on/off into the C callbacks
for irqentry_enter_from_kernel_mode() and
irqentry_exit_to_kernel_mode().

The semantic difference occurred is that we alsways check
the PSR_I_BIT to determine if (hard) interrupts were enabled
or not. The assembly has a tweak to avoid this if we are
exiting an IRQ since it is obvious that IRQs must have been
enabled to get there, but for simplicity we just check it
for all exceptions.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/entry-armv.S   | 13 ++++---------
 arch/arm/kernel/entry-header.S | 19 ++-----------------
 arch/arm/kernel/entry.c        |  5 +++++
 3 files changed, 11 insertions(+), 26 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 21b11fe199cb..600375f6f5d8 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -157,7 +157,7 @@ ENDPROC(__und_invalid)
 #define SPFIX(code...)
 #endif
 
-	.macro	svc_entry, stack_hole=0, trace=1, uaccess=1, overflow_check=1
+	.macro	svc_entry, stack_hole=0 uaccess=1, overflow_check=1
  UNWIND(.fnstart		)
 	sub	sp, sp, #(SVC_REGS_SIZE + \stack_hole)
  THUMB(	add	sp, r1		)	@ get SP in a GPR without
@@ -207,11 +207,6 @@ ENDPROC(__und_invalid)
 	mov	r0, sp				@ 'regs'
 	bl	irqentry_enter_from_kernel_mode
 
-	.if \trace
-#ifdef CONFIG_TRACE_IRQFLAGS
-	bl	trace_hardirqs_off
-#endif
-	.endif
 	.endm
 
 	.align	5
@@ -238,7 +233,7 @@ __irq_svc:
 	blne	svc_preempt
 #endif
 
-	svc_exit r5, irq = 1			@ return from exception
+	svc_exit r5				@ return from exception
  UNWIND(.fnend		)
 ENDPROC(__irq_svc)
 
@@ -302,7 +297,7 @@ ENDPROC(__pabt_svc)
 
 	.align	5
 __fiq_svc:
-	svc_entry trace=0
+	svc_entry
 	mov	r0, sp				@ struct pt_regs *regs
 	bl	handle_fiq_as_nmi
 	svc_exit_via_fiq
@@ -320,7 +315,7 @@ ENDPROC(__fiq_svc)
 @
 	.align 5
 __fiq_abt:
-	svc_entry trace=0
+	svc_entry
 
  ARM(	msr	cpsr_c, #ABT_MODE | PSR_I_BIT | PSR_F_BIT )
  THUMB( mov	r0, #ABT_MODE | PSR_I_BIT | PSR_F_BIT )
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index 49a9c5cf6fd5..cfaf14d71378 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -199,26 +199,11 @@
 	.endm
 
 
-	.macro	svc_exit, rpsr, irq = 0
-	.if	\irq != 0
-	@ IRQs already off
-#ifdef CONFIG_TRACE_IRQFLAGS
-	@ The parent context IRQs must have been enabled to get here in
-	@ the first place, so there's no point checking the PSR I bit.
-	bl	trace_hardirqs_on
-#endif
-	.else
+	.macro	svc_exit, rpsr
+
 	@ IRQs off again before pulling preserved data off the stack
 	disable_irq_notrace
 
-#ifdef CONFIG_TRACE_IRQFLAGS
-	tst	\rpsr, #PSR_I_BIT
-	bleq	trace_hardirqs_on
-	tst	\rpsr, #PSR_I_BIT
-	blne	trace_hardirqs_off
-#endif
-	.endif
-
 	mov	r0, sp				@ 'regs'
 	bl	irqentry_exit_to_kernel_mode
 
diff --git a/arch/arm/kernel/entry.c b/arch/arm/kernel/entry.c
index 674b5adcec00..1e1284cc4cae 100644
--- a/arch/arm/kernel/entry.c
+++ b/arch/arm/kernel/entry.c
@@ -59,8 +59,13 @@ noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
 
 noinstr void irqentry_enter_from_kernel_mode(struct pt_regs *regs)
 {
+	trace_hardirqs_off();
 }
 
 noinstr void irqentry_exit_to_kernel_mode(struct pt_regs *regs)
 {
+	if (interrupts_enabled(regs))
+		trace_hardirqs_on();
+	else
+		trace_hardirqs_off();
 }

-- 
2.46.2


