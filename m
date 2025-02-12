Return-Path: <linux-kernel+bounces-511029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BD7A324DD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E97211888E84
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9636223C38C;
	Wed, 12 Feb 2025 11:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k+w1Dgl9"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC0E21324E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359416; cv=none; b=cDZoqunjFBTjJqMk6QE1//Z7FZF11QzkNXlLKfoWtHpc8MPNAyTl225GHmz0/tKsCtj0B40UaVdu/UhgHpyWiEGK+90jDc0SAC307ENGPH0qI5XLZkPCOt3RqW9uguLTplF6zITGGT7EpHBKf/Zfl0HjqO/zVfFwUTd5L2CJMw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359416; c=relaxed/simple;
	bh=VRNz3ZLBzn0Qq8dlDRAbgJ3JgliMtfalkGTG4vw4Tfk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YKMigSZgKpc2P074yHVvuwr0fxiNY0Z+YN7TGX9J1/iLbZTXIBOy3rhgy7rJ8EvDNMkBr23tZmd7saHcOikKLqSZ5WioA8CjFN0xgbr6xnS33hSfvUvmm23I9J7a5SFtkIoB3lHZsKnxpE4SD6Ytip6vyA3Nd78nr7zSd+WmVRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k+w1Dgl9; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-307d1ab59c6so61921431fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739359413; x=1739964213; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8L1+xbNej+7+BbJW1uipXHwDEUpYT2HP3XoeW+FBwgo=;
        b=k+w1Dgl9W4FdP1xFnxn3+hWqD53mLhW4WSCrMudACpx2mxzEPxU9PXX4rbEzT5ccpz
         v1Ub4XhC4cYuAxqRLKioEN03s1ESe4b1lLzlxrsNKFcuipWHxMojBBBOsIuMuOVrimKd
         98TXEzQHaX1DTlpdNsUbC8K0Z55zzqBKHCwXz3QDWBGRzygkQb4tBPHfbsFRADtdIFzh
         UZtLQuDuarIzlvZWTa+I7w95UVVLUotjxojVhier0fuu7gAdYdVqWXiGeZSroyXFpc3Y
         uN5e+Eda1Q4Xe9vwWLHEi2e3IstGLKcTUPD35lMAkfadYRwntvIt6fApSyQ2Q/Xj1geR
         cDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739359413; x=1739964213;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8L1+xbNej+7+BbJW1uipXHwDEUpYT2HP3XoeW+FBwgo=;
        b=UpHCj2C2hutPljz9jZuiH8szukyocwd6YCF7gHoYva8V/lopFPf5fIarqwDrO56L1t
         YAORAR++kToKZTosnVVAg6wII/7aBn0esd2vUtRiSD3LHxKz8cPZs43rU4fTUb7pMGnT
         kPeQeKS9jWPqAeL7vIF1KUei2Iu6FVg+cYRKlJ3TDTbnDRmCxL8autraomEsZZGXqBNF
         a5J6WYfEpXyO+xXCQS08vKJVi5zjV73vULAbAUWS/zxtyER7aFBeS25L6O0vtyvgY6yZ
         NtyBgpaeSXxrq+NbimGGcHXtcdeeK7FSucL3dHAd17uVaEMrYEQSmfJzObyq533MdhPI
         R3WA==
X-Forwarded-Encrypted: i=1; AJvYcCWp5cJOPgQOR8PACHOOFUl65Sy3yvPxy9thknoIEZN8dH6GEK+oP/a60k0BvuwpqbekbZYRjIvj26GeVfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBJlCb1lQpEen7ml5mcChS1NcCv6VX/fvwBJciKXVL9njO9KzH
	7gBiTSh/X8+kt4rjR9WinqOxq6O6AV2eLJdXsXoLKuovbUC/PZWrQOP4XJnJX7U=
X-Gm-Gg: ASbGncu1dFaWME2PEE6bg1J4pum47bYWqJ59YqFwKRCiZ+diQLXlk+GVpWjGTVzyXP2
	RLHaUTWWiM0g0qmKKrp6OLYPOX5gXrcbPNmkR6vzmYOug5QNV2OBo2HeXiS6uzieXrffted5+/9
	Ou+iXSnVS0CQtwVz7gFoMahykHJ9aDjWFVvgFQ9k+x+8vjbI3thtapdsDwRb8XP12XA8DHXkEjh
	WXInM8on/+7iP+0AXaaU/vb5n6eiMvSoKgnod1JpDhIr2lHlPlgbHuKg8pNVldZZLqaRcGi7Nnu
	m6CB6WxU4WVBNyePRnZ/QTwaDw==
X-Google-Smtp-Source: AGHT+IGztsILaaYaXNkeSXwRXUmkpO930r7CtwcGUJLwBA+MhfurzFmeCaR5cjXsMc204D4O1MAizg==
X-Received: by 2002:a2e:be22:0:b0:302:3003:97e with SMTP id 38308e7fff4ca-309036dbf25mr11765111fa.30.1739359412849;
        Wed, 12 Feb 2025 03:23:32 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307de1a6531sm18310511fa.45.2025.02.12.03.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:23:32 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 12 Feb 2025 12:23:20 +0100
Subject: [PATCH v4 26/31] ARM: entry: Move in-kernel hardirq tracing to C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-arm-generic-entry-v4-26-a457ff0a61d6@linaro.org>
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
index f64c4cc8beda6bcd469e6ff1a1f337d52dbbaf9c..2a789c8834b93475c32dcb6ba5854e24ddd8d6e9 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -158,7 +158,7 @@ ENDPROC(__und_invalid)
 #define SPFIX(code...)
 #endif
 
-	.macro	svc_entry, stack_hole=0, trace=1, uaccess=1, overflow_check=1
+	.macro	svc_entry, stack_hole=0 uaccess=1, overflow_check=1
  UNWIND(.fnstart		)
 	sub	sp, sp, #(SVC_REGS_SIZE + \stack_hole)
  THUMB(	add	sp, r1		)	@ get SP in a GPR without
@@ -208,11 +208,6 @@ ENDPROC(__und_invalid)
 	mov	r0, sp				@ 'regs'
 	bl	irqentry_enter_from_kernel_mode
 
-	.if \trace
-#ifdef CONFIG_TRACE_IRQFLAGS
-	bl	trace_hardirqs_off
-#endif
-	.endif
 	.endm
 
 	.align	5
@@ -239,7 +234,7 @@ __irq_svc:
 	blne	svc_preempt
 #endif
 
-	svc_exit r5, irq = 1			@ return from exception
+	svc_exit r5				@ return from exception
  UNWIND(.fnend		)
 ENDPROC(__irq_svc)
 
@@ -303,7 +298,7 @@ ENDPROC(__pabt_svc)
 
 	.align	5
 __fiq_svc:
-	svc_entry trace=0
+	svc_entry
 	mov	r0, sp				@ struct pt_regs *regs
 	bl	handle_fiq_as_nmi
 	svc_exit_via_fiq
@@ -321,7 +316,7 @@ ENDPROC(__fiq_svc)
 @
 	.align 5
 __fiq_abt:
-	svc_entry trace=0
+	svc_entry
 
  ARM(	msr	cpsr_c, #ABT_MODE | PSR_I_BIT | PSR_F_BIT )
  THUMB( mov	r0, #ABT_MODE | PSR_I_BIT | PSR_F_BIT )
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index 49a9c5cf6fd5fbb917f2ada6c0d6cc400b7d3fb3..cfaf14d71378ba14bbb2a42cd36d48a23838eee1 100644
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
index 674b5adcec0001b7d075d6936bfb4e318cb7ce74..1e1284cc4caed6e602ce36e812d535e6fe324f34 100644
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
2.48.1


