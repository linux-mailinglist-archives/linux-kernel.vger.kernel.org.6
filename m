Return-Path: <linux-kernel+bounces-511033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D04B5A324E3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D623A0601
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CBE253B58;
	Wed, 12 Feb 2025 11:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rM/uvM0X"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F41820B1ED
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359421; cv=none; b=EjvDuW23wI8iLqikVSLX8MY+sZFMe7bvsP38LFSQPbmDNUb+zZH6sWX5Iwb7sM9qJAVRZVEyUN89uSaBxJ0+N9s8zkslvwwdliAHfzA/aCaWpOMUhskDcwms+og81MfKgNq6lqR95GQSh+R2KVvA90eoUsYXUHQfc0o6y6eFvkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359421; c=relaxed/simple;
	bh=mZJOXWfu791srRnVf30GNB51gYy1b2GWyvvBBPfxfVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ErmbfQZOK4ZdL2AMs67JHlNaQNE8RI1MH1qtM2IKO24u/sfBUVuC25fENFmenSiy7kopW44iFg/tLtUG47iktVWyKiqEeNL5QfCr0D2gjaYsraWIU9THNqn253kk4PTNgpViwKTFPvRNz5S5A3Fs/ooeK0DdSO1yFmssbAh7cmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rM/uvM0X; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-307bc125e2eso62131441fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739359418; x=1739964218; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BLyynCt450Utx2Z4sB12bYa6WPePLKZjdTj9AHDawWQ=;
        b=rM/uvM0X6VdOs5xfzl9A6ngRyfBqOZn50FQKbUcbftKGL71qs31ghXbOLEuaLbK7LI
         H8RAfJr3Nv6ZTjMUvg//1d46EyZlM4v/kowebVBzq7Al6Nzrtwvi10l6msSF023JXPyH
         4UBTcReGI+zuO65MvT3ys6ANeVoO9TTLgOBjdAoXYKSgHjl1J8IHuFuSVV1KZkoHI5zu
         xlq9umk8thjnECjWi9h+r3SoVbCv/DJ3U3WB+K6Srvql6Q2vDVUw9Cm1dSAg7227Bz1i
         LfDP97qBrAQySOiY7+JRYV9HH4SipvUfRfAIqwqFPTaBieu5oy8E2Tb8rK/HTwvecBvA
         eUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739359418; x=1739964218;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLyynCt450Utx2Z4sB12bYa6WPePLKZjdTj9AHDawWQ=;
        b=Aa3TbPXeDTuCOLkX4KoHxsYuscYLAovJxz+mjFdxLmgbttVSwt95efnsFlm1Yclwje
         go5Ykuk21ub9gULDhmKEJ+yuuOHbpzrZC+Mhiktnkxi4x7etTFcttg9OfHpYI83O+KNK
         pwEhV11XdtywAq7wNjTC8ZW/uchonwnl7b26vGN/vMi00BAJaT0yf/BmY1OqzWQhwVmg
         vR4XIkmQ46pfEzf9gt5LKdQvmQhAat9HiuaAG1DQeTTzfQ/9whneGW4BMYksuZ0OC1dJ
         NWKbzv1UaV4ionLUUIYVUGLpFfWhNOsdiTXIOxTFL286wQI16I5KQ3BFEU+sxX99pm+f
         9YvA==
X-Forwarded-Encrypted: i=1; AJvYcCWU2R0i60Ia5CnTNV7Hc97zfiUe3EaOc5fbhyuKZekdJ6Ww6xE30niuMbc4jG2otnzG3Yl9hirx8Zr4s48=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkTJ0cMDmzl6FFGhCngsKax+mAUK8kwlNE2I1eNP52W2kUM4Q8
	6aylomtEjnNZNaASD3Z2HvsGCSu8bKYBaI9Zd2YxKnmVwdazsVccbvs3xuG1uYs=
X-Gm-Gg: ASbGnctoZnoBiKoJeXLq3EW2v1SprA6OXbsPP3icno+Uhff0ZvFA7VP18GWd5vTPXBV
	Rp+IElYmD+LW2/2xZl3P5d2PI29VvymBRicAvjM2iv1Yun/3IZStWhdTJcamML+v2cAmJ0MOeQQ
	O//IIccujJ2rtPzDK7SWhSb+NF5j1pOaKvVaQcG2Lay1cn8Z0+Gx2jF4u5UVoWsR2wL9ltBN/wT
	fFUIJFOMplzLUogt8H1VxFH/qO8K8tYM2h5wOPd8CgK0saePZpOeIzhC89jqG3vsBOg0t9kCrBr
	QZU28zTNfwuftZwiZRU4Zvv5XQ==
X-Google-Smtp-Source: AGHT+IHK2ire6eSOXUjIyEB1DADW6wNdjzmfwgrMquJUSGQom2k6V3tykQc82oC2UKLm7kJWGSeVIQ==
X-Received: by 2002:a05:651c:1b06:b0:2fa:cdd1:4f16 with SMTP id 38308e7fff4ca-3090364236dmr12530571fa.14.1739359417574;
        Wed, 12 Feb 2025 03:23:37 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307de1a6531sm18310511fa.45.2025.02.12.03.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:23:36 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 12 Feb 2025 12:23:24 +0100
Subject: [PATCH v4 30/31] ARM: entry: Block IRQs in early IRQ context
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-arm-generic-entry-v4-30-a457ff0a61d6@linaro.org>
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

When dabt, pabt or und exceptions occur on ARM, ordinary
interrupts (IRQs) can still happen. This isn't nice for the
kernels context tracker, which expect (when using generic
entry at least) that any nested IRQs happens
between irqentry_enter() and irqentry_exit(), else it
thinks something is fishy.

This change blocks interrupts in the pabt, dabt, und and
abt exception paths (all of them really) by unconditionally
setting PSR_I_BIT in the early exception handler, until
after context has been established with irqentry_enter()
and before it is exited with irqentry_exit(). Inside the
context-tracked exception handler we enable IRQs again,
and once we leave it we disable them while exiting the
exception.

The local_irq_disable() in bad_mode() can be dropped
since we are now disabling IRQs in the early assembly
exception handler for all exceptions.

This seems like not perfect: it seems an interrupt
could still occur right before CPSR is set, or right after
the userspace registers are restored in ret_from_exception.
I would like to know if there is some
way to set up these exceptions to inherently block IRQs
when handled, until we explicitly allow them between
irqentry_enter() and irqentry_exit() or if this is simply
the best we can do on ARM for these exceptions to make the
context tracker happy.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/entry-armv.S |  6 +-----
 arch/arm/kernel/entry.c      | 18 ++++++++++++++++++
 arch/arm/kernel/traps.c      |  1 -
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index ae2f952beea7611f0abc7bd299fc944335a21219..3dae35b0bb3f440ecaf157a45687bf4690fb8f88 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -416,11 +416,6 @@ ENDPROC(__irq_usr)
 __und_usr:
 	usr_entry uaccess=0
 
-	@ IRQs must be enabled before attempting to read the instruction from
-	@ user space since that could cause a page/translation fault if the
-	@ page table was modified by another CPU.
-	enable_irq
-
 	tst	r5, #PSR_T_BIT			@ Thumb mode?
 	mov	r1, #2				@ set insn size to 2 for Thumb
 	bne	0f				@ handle as Thumb undef exception
@@ -847,6 +842,7 @@ vector_\name:
 	@
 	mrs	r0, cpsr
 	eor	r0, r0, #(\mode ^ SVC_MODE | PSR_ISETSTATE)
+	orr	r0, r0, #PSR_I_BIT
 	msr	spsr_cxsf, r0
 
 	@
diff --git a/arch/arm/kernel/entry.c b/arch/arm/kernel/entry.c
index 01e4339ccdb4951e04a89fb91ad7c6e1991e09af..3881670e0987ee40be6fff32f412edcf4f3ec80a 100644
--- a/arch/arm/kernel/entry.c
+++ b/arch/arm/kernel/entry.c
@@ -17,8 +17,18 @@ noinstr asmlinkage void arm_und_handler(struct pt_regs *regs)
 {
 	irqentry_state_t state = irqentry_enter(regs);
 
+	/*
+	 * IRQs must be enabled before attempting to read the instruction from
+	 * user space since that could cause a page/translation fault if the
+	 * page table was modified by another CPU.
+	 */
+
+	local_irq_enable();
+
 	do_undefinstr(regs);
 
+	local_irq_disable();
+
 	irqentry_exit(regs, state);
 }
 
@@ -27,8 +37,12 @@ noinstr asmlinkage void arm_dabt_handler(unsigned long addr, unsigned int fsr,
 {
 	irqentry_state_t state = irqentry_enter(regs);
 
+	local_irq_enable();
+
 	do_DataAbort(addr, fsr, regs);
 
+	local_irq_disable();
+
 	irqentry_exit(regs, state);
 }
 
@@ -37,8 +51,12 @@ noinstr asmlinkage void arm_pabt_handler(unsigned long addr, unsigned int ifsr,
 {
 	irqentry_state_t state = irqentry_enter(regs);
 
+	local_irq_enable();
+
 	do_PrefetchAbort(addr, ifsr, regs);
 
+	local_irq_disable();
+
 	irqentry_exit(regs, state);
 }
 
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index d3a689bd05955f1ae46a6341e456bb097e831311..b2eaab9cc4977c448f77faa4e6bc22a0749d1f9c 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -515,7 +515,6 @@ asmlinkage void bad_mode(struct pt_regs *regs, int reason)
 	pr_crit("Bad mode in %s handler detected\n", handler[reason]);
 
 	die("Oops - bad mode", regs, 0);
-	local_irq_disable();
 	panic("bad mode");
 }
 

-- 
2.48.1


