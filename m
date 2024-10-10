Return-Path: <linux-kernel+bounces-358902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A59B1998520
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60D902864E0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D8E1CB303;
	Thu, 10 Oct 2024 11:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZtOa91WW"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326781CC16E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728560069; cv=none; b=Y2m57wlfxz1dGUBGuWXA47yM6Nl0jh9Hukc2NM+cfbA5rtmvKeiFPEjZwn2KKyMCNdIykb1dXnm2KKz9DdLgX0MfBM+JldZHY6ERIok/oayd2UJEI84mjv7eVEQRDoZPUrRFbrF4ZYoDFcNQX1Uw20KNDKXus5JT91rjj4pLnl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728560069; c=relaxed/simple;
	bh=p++J5jDdayY9hU28M7/pcg9MrpkZxPTcO20YZjwEn6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pcLa8j4pe8dvgUHzUzviCTeXUHV/8rub9ukWRfFf/ankgteLWv6XhnM6TyS/fLZzMMXq+TiU8WG7DesrqiYHdzW3qbFLrSyVXhtdfI7F4VjT/+L5tjYd4vFG71eROEbUILa5qd6syUe4mq60ABkd9TYh3BNVELuVM60Wy8kjBa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZtOa91WW; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a93c1cc74fdso139081466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728560065; x=1729164865; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZScZ0+O1z+KD5ly1wGwp6XJNh1QIX+DiUm/Qzjn1DDQ=;
        b=ZtOa91WWZGwpZ+4DDZ/AJU37MR+VJKP/mrTjf4uWOtXhhCQgG/KtSOgptCtftuTJ3R
         i6PPmlRpqVVTck575zsLbHynYPwNWLpBpflN4hmp1QfeAg79wXHF9cpjwu4u3J8q4khA
         k/xlREfyoyYfZitkh4hvFd075MRkGN+yIKLV+rOFtIeNrnr4XGIqWrE7B79+6F9dB1Ui
         4KsdVDiRpfPm7Rd42wJAd2C3Gj3ZGen+jzf9WhkdyocucbxRaKw2HYAehfIJarJCSkGF
         8E6A6wzRzr9a73+0Uqno5XheYDUbIJcdb0S8QUycMipwNOCC2GBQbxIRA0of/K+3AvJT
         K7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728560065; x=1729164865;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZScZ0+O1z+KD5ly1wGwp6XJNh1QIX+DiUm/Qzjn1DDQ=;
        b=G3onmkYnxHvtjR9eKpBQ+4lYykERTJhPhPW8CQz6G2jD9SCWU3NhZoeIS//blTLVME
         JfKz/fSRsHdVeCGg2rteO8k+T4hAEfYyw45W3Ng7bJdUpI3KiMdMtrdUZxTC/z81dU8w
         zUmr11Bw7JVYywlzZ1lghO6F7LWsysnxj1jMLcZ+VNjUAYaKNCP4dxkzas4NG/gvr4eK
         JO1vcjUabyO704j2wOKvAEjXING4STOZjRZqcFMwyzxK6LRxzxe3oWNVZJA1YZU3ct9c
         /SXh7Jufpj4VI8C7YivDerhtceja/NzekLVx7VUJQqVnzVAydS7qOFhugKkkynvoPdcU
         Jm5w==
X-Forwarded-Encrypted: i=1; AJvYcCXHQUpZvMRxBEfuTY+mKNfgpkawz+jQuuj6Xx2pB4Gs0CcvwGfYo6HQjRzA0U+XpSRIttBIVObMAg/qdmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcMKUG8/948Fz5It/LOYmastKwEISjqv1rPOhHi7/sOZqRsVaW
	ho8R3An+g0an3XRN7ujp9/7JHL6ryViJRv6WjwpB+ZpGlelTTABiv8J0snamQ9A=
X-Google-Smtp-Source: AGHT+IGPbjmbOuudiYSl7s9WBi8ngVmIAJNEhV6kvE7fpNTobtjhLab6+DrMs8j68CZRmdtyA7IjSw==
X-Received: by 2002:a17:907:9810:b0:a99:4fce:c343 with SMTP id a640c23a62f3a-a998d1cb499mr538738466b.26.1728560065458;
        Thu, 10 Oct 2024 04:34:25 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f25406sm77619066b.69.2024.10.10.04.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 04:34:25 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Oct 2024 13:34:04 +0200
Subject: [PATCH RFC 26/28] ARM: entry: Move in-kernel hardirq tracing to C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-arm-generic-entry-v1-26-b94f451d087b@linaro.org>
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


