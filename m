Return-Path: <linux-kernel+bounces-530968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1913A43A7F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF5F3B3D49
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198F52698AF;
	Tue, 25 Feb 2025 09:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vuJkRB2f"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE0B269808
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477333; cv=none; b=Iblwnylc8bnOuJRQ6ufo96atpEIzunrpCuAR1AQ6b4vjktt7nbd43Rw0WzPik2EkMXdVevB87LmzpTicvaBHCQ7Y5lnfltskl81LkhC4MpduhQhcjORWoy7K5Po9XbwdnKW59iKA62gaDbumK062oOFCVDdwSiQUuWnER0Hx/l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477333; c=relaxed/simple;
	bh=VRNz3ZLBzn0Qq8dlDRAbgJ3JgliMtfalkGTG4vw4Tfk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oSwPkar4Xf+MyzFIDAf4qYUZxyJHfwvscvRngXmNFTKWDwNnIrSS4fy2KTFja1WleoOoILaPIxgcF6Hh6e64nJQwGfy0SPKcPfUK65gBj69Hpc/HO/hBD7+GvLvzAfEDibQi3kwJiWzT2KWk7bn6/ssuOwwYspRI9K/m1ReI93U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vuJkRB2f; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-548430564d9so3040222e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477330; x=1741082130; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8L1+xbNej+7+BbJW1uipXHwDEUpYT2HP3XoeW+FBwgo=;
        b=vuJkRB2fBiIFeN13s5faljfnOS7b36quHIri8MltPjXtTMCi3H3nxXU2s0rXdmPHNM
         9sTNuDfzzlqtEauwqhynqgp5/Rrg1lWqJYho6mVJRZRyAhDLrCKHVq0ldDKNsKY/rJtD
         75lG0Gto8wfGkYKuN/8d+AO0vOn1w8vaVOW75+VZ17TY7T5LefXb63esw9Z4bgMvXhZe
         rVM1R66NDEldBEni3I2Djy11IV/RXiSbH8BjfDLyuV9S95OiT9eFbXzyRCxZJ68QHZAx
         fTWO5eiaJ+LKvGCBtTyyvvhELpAJTJjt1SwIxLa0ch5EWpb4+CGgoPIK/3e76BPi39gL
         wtBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477330; x=1741082130;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8L1+xbNej+7+BbJW1uipXHwDEUpYT2HP3XoeW+FBwgo=;
        b=L4a1XO8mturtLqZUffhF9CHLjXpHiV3XlwJA17Zsvs+wBjIPMqWXp0uxP3X0hPugdj
         Vfq6nuWmfzbb0MZQMs82F0hh+XbsjjaU+eqj4fsXwCxYVXyqPWec1E+uNaJ8v2S3gzTS
         nBns+T930o+5prLUJ2000a10mLQOljd5IyL9CWWvUvt9xaOeW/SpDLnHdYcwU5zHuOQE
         a/MfuF9XnL7nRW59cPDL6ZJndmCg3DSyvfMT8n5yLgqHfi5rV+OjRP61jD2azVrto2zh
         fjWhExWUiqJQC2rr41Xt930rnFctLLeYRxuyZ4PrLu1xOj6dRM07v0ZOYfOio9atEHBF
         gDNQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4z4kNC3OR8SPOzm4QTpQ17hCAHvwAq0hPOPNrU4bBKBGFxvkNFWlN3QbQQ1qbnDYSLykQBKWD6Ff+0LM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaYd9PVEa9C4LJIv9e7+Q8I4w7u8BDCNVLetaHPM2sxxSLXLn1
	ol4YNAP4IFOqD2GcCEgSvNK8n/JHSM2Na7zPVIK74gwztSdHN3iJKkfG5Tal+5k=
X-Gm-Gg: ASbGncv65cUnkUCKt5fPc6zmY63BcCILPVP1tmzbr6/Ay+ZhSFj6c/j8aHXQxlChNIj
	BqZ9vCQ/JeUMOeuLk7FpIWVIeLk9pbkj1SwgQbLCGkclBptjicNO+paDJ+xLbj0Gd4W8gmW9OAW
	gfG64NPyDq/Bn5rXsdWnBNiRWH0sThkZsQ0nEo/b4qWaFwl4gpgbXcFLaIAfhHBhMri+2j6qoza
	++AHhhgmLuQuBWRs/zwgGCio7KoG4C5qzMQ6oYquV/hy9z6CveMV6rT8JlEHWkTvrHgyz045Kuh
	lqMgnw55DNPP+Z8bbUwP4euYPh0iQxHVe+QQ
X-Google-Smtp-Source: AGHT+IF7xfl9B7/xJ8k+iPG9dONRxwPTx8ewhI6YDPJcZwPMf++LnRv+shbC0/r1nL1MG22ob6N9GA==
X-Received: by 2002:a05:6512:3d8a:b0:545:ea9:1a11 with SMTP id 2adb3069b0e04-54839129bc3mr6152301e87.5.1740477329613;
        Tue, 25 Feb 2025 01:55:29 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b261esm132867e87.24.2025.02.25.01.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:55:29 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 10:55:13 +0100
Subject: [PATCH v5 26/31] ARM: entry: Move in-kernel hardirq tracing to C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-arm-generic-entry-v5-26-2f02313653e5@linaro.org>
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


