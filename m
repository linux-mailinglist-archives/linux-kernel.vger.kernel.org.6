Return-Path: <linux-kernel+bounces-530971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 898CEA43A82
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F09E61895807
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D8426A0C1;
	Tue, 25 Feb 2025 09:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nIAxIyUM"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9AA266196
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477338; cv=none; b=HbWJamW32Fw5lexs/tGjKmH8q0NAWGfgWHl/GS7pOsMejAP1Eiy7PZyyxmwYD1XNEVQLuoT7/pQEHQyNzeo/9bFbSzrDLiwztE8pebp4b9035NJaKliePbT/T8XKny+pgnog2ME1lYEmhW1Jt3cfd4jsE8jexx1P7MG08+M9xeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477338; c=relaxed/simple;
	bh=mZJOXWfu791srRnVf30GNB51gYy1b2GWyvvBBPfxfVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SD0TxaT5uP5Bzj4wYTY8CjkqMLzhUA58XCNzrkUVBmFMzDaW62vRyJfO2MRhzORH8FPwlNF5WcDjxNFQ2es/OsJQrtTTnjfYT6Hpy2kIVcS6pDU4AobtIhh6CebdlsnFZ5D8+/WF4Z0Llg/qBYs82+RxwGdzo4QIEqscBY01XdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nIAxIyUM; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5461dab4bfdso6457536e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477334; x=1741082134; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BLyynCt450Utx2Z4sB12bYa6WPePLKZjdTj9AHDawWQ=;
        b=nIAxIyUMyGVjHLsCbhA8YFmwEdw9zWowKgCAoczShpEIyTsY9VgAm2k5ZBI4JLvFy6
         nZQXXSToBfh9geAoLJP5tAwrLYFx8LAVzyfQKUgLcco7zRaHg1fLCOZ7z2F5pA1ftTCG
         RlhFdqj8UF1laJm4szkFI9klsr+y7OauxPbwbR4CmuThb5axAQRCQxRuGmSxTEkhDMwa
         XlXeFNpl3L9khSYonJosh9mC19iLQzwLduZ/N82G7lpYtv1GPBdCJJAWMPuonWzef6D8
         lv3yL+s7O6LM90MYMZMWlxPgiTFfLtf7MZSy/pX3mZO1MJSj06wuQjMDZ3KSotBqhkbQ
         JqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477334; x=1741082134;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLyynCt450Utx2Z4sB12bYa6WPePLKZjdTj9AHDawWQ=;
        b=dSHNcuckkdpNnuGgFOaXCTdD5CD7Lk94m2D4I3Zy5Q17tnKpIoPFiqTu2CmK+rZsRn
         1Ks0wyXq7tDtSpfz+k7bfgffdSdDetXBCbPeHd8OMksGz+C+/xHUWo5Gfk18vQfpeWvO
         YcjDGn47Gn12S8fHtYl1hhaCp7qRgGVH6bTvNCc1+eULyYqwIcQFw+ho1S2TPtZ+uMVh
         IuNohOSyl5Rd6TqbXxycc2f/iUboBv6r4Frz8JF7lBE7BXqs1auyUDUOHl+D1LNI3Ysr
         +vTkSuGAP5HvyL13eYqw78Pnnt5oX6gYZ4LKeOEmhzton/Fku9igNFzNxCaMGTkCq76n
         T65w==
X-Forwarded-Encrypted: i=1; AJvYcCX8MvQdbBLjnQ8fnUrbRXeiM1nnSZC990QWtKiZ9KylYU1S/ijFsrpaWankbpCoHYhetsbxyjctp0Ha7Oc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTPYvhXZAwaVuCFa7JhsFCmG4eqkIvNKnQ4PTN234kIooRtrVk
	ZJbWGIj3sOR4F0RnGDCRVTby3ezB0T6+TXr/Yt0O7bOTmU2lGDTCnwz2F9fY2LQ=
X-Gm-Gg: ASbGncvbtRYz/j2bcoIpLNFlEmaZE8039c51KXxOxe6M6CsogZH6oYK+LBdqa/8OFB2
	dhW1wFWwl3l4i5E7CrF7wo2kZpsvdyFATj7NKm/P0AqwALInKsju1eYECdEWkOCSFaJhb4V4tvV
	TuTckpQHsQDYRq1azguZztUm4mqvJwstSFMFUQu8iGcFBudXH/pUnZKwwI7uARdSedRLuPO+yHY
	9bwtmjqGBGmHUw4lwcLwHuNHvW8MswTtCLAYAiox4EZzDubcXtdTl0uD995vy92i2zsQEfeK0NX
	5ODMHUx4vNyOEuzg82xageBitdOqcq+nt1ug
X-Google-Smtp-Source: AGHT+IHp3UDsNY1OdXjOXmJRnD8oRCpL6CgaUimOK/pVgJHgRaGWijdZG0cBnNzC1r8eEV5WV+PGEA==
X-Received: by 2002:a05:6512:68b:b0:545:cd5:84d9 with SMTP id 2adb3069b0e04-54838ee7b55mr6011950e87.12.1740477334328;
        Tue, 25 Feb 2025 01:55:34 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b261esm132867e87.24.2025.02.25.01.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:55:33 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 10:55:17 +0100
Subject: [PATCH v5 30/31] ARM: entry: Block IRQs in early IRQ context
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-arm-generic-entry-v5-30-2f02313653e5@linaro.org>
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


