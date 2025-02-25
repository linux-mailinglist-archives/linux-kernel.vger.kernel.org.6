Return-Path: <linux-kernel+bounces-530957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6CBA43A77
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C5C2178DCF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2062E267F79;
	Tue, 25 Feb 2025 09:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dQk309tl"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988D5263F42
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477322; cv=none; b=XYfd0XygV+LeIboFGKZoMAVCruc4wBRjnFXmSq2Mu+4MhK/qfzwzg7jiQOvT6JlGy12PpDFsQkMDnE1NWGEnOxp8r0Uz2Xx9864lb+YugBePVWn6okbnNM0MSFARqAL9k7kAxmpYq46TrapWXbRy503GC8CqSLZOAFv9jR0gYIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477322; c=relaxed/simple;
	bh=yLAVHOLvwqsi9en7ghFTQoRLGB+8xrjaFpRIXfNOxb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eSOP8UoLehBwRVES7bLrYUUz72KBhaBUPUCn9pjSXznYqxIU1hNQn/23hkxasOaIZw/TYVvmW1q+QreBHITT2UHFVYBGVdhO2DpVkNSP+s4QAMLvUjn/YlbnX2Nzw6yMVBOsGrkKJFXDHMozK/h2iIN2qUk/eakWCTSi0+jbKV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dQk309tl; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5461a485a72so5229550e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477319; x=1741082119; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ggLp2N6nIh1N25l9qqVFGy2pp6+E0t6/i4rH9zHeAXo=;
        b=dQk309tl0DpukVaFXBLY+XM6NLuVI8F6gs16Uhaq3PGGdJwXWJa8G/jvy533+mTE47
         81nDvhyhk4lQF6quF5poFc7tZUmZJlS2ZKkc6Og2C9Js0xHiJfNWhEbZOatnMXTC1S+t
         m0Fwa77WCcDGOgkXa4OFhcxLtvR50pObR+YrPSYChvb/zgh0eaSwW1EGaaKi27jjhWzd
         OA/ZH2DcN85xh048yPWJW6+XiJvi2+TfcSQF8kWO5oTbn+MsxvFF/r+w+6RUPEeH8Kyd
         6vg1bkb/TPIRsYpxp6zgMDGDj3+0WbzIUS4Mr3Rn8JH+UbCat+Wju1NU7SQS2/gnRX6M
         VF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477319; x=1741082119;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ggLp2N6nIh1N25l9qqVFGy2pp6+E0t6/i4rH9zHeAXo=;
        b=MmXwa1s97csx/0FTo8mI+0Ao+VJPAaO1sVrhsN2pQav8qekRqGP+14XyDF+Ig+EYU8
         toIhcNVBlqIwpTP2iNNiezLbISBKtKr6GPxUt4REa4GbK1ZDnw42yE3m4sIjYCj2n76I
         QFN5Vh269J/tg+Zqbw0umxsqn2c7KaogopJICUXTP+73WYGUxfemlKUmvBXPHX8yoN7t
         85iD++UloT3EPVsiMnA3n2azlmJfrRSMJK6WJXXYUPewjQNLUiPb9Ixi5w8JuFUQ/qDq
         V0Hrzi7fZmsgSMxiithmrAfjNWlHCQkIkn26FjExLBD78g+7b/5QLOm6aHiNx9oM5WK1
         V4Zw==
X-Forwarded-Encrypted: i=1; AJvYcCVSNB3nx2lwy/sdgrFnqsfuelg+iSY4TcMzgp6FFwgIZOHlLQbBHUbYZ2iENxNch+snemKilM9h8HhSbd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbiymHw/2a/B0MXFUibXsa7TY/asye5e26B/kIeBXXK1lajB2n
	ycCvqgt1e/TwbzLNAdtiEf99xoiE4rA4xzITLLcwMI7Ky6CQmnaaNt4HMEBIKO8=
X-Gm-Gg: ASbGncsckkPRq9KudT5ioHtNMo4FMe2qVYQtr2R5PIF0q4H0/uVAsKHmPC5FLL4s4lN
	7iSZrzQh2rDdF3jCxqp24Jn+T7igIa9LS27O4gIrt+2wecY8hcfz8I711IH70Cbo6wTF2QMs4xF
	U5QXZMmoLZlWFZjgD6mo1ErsTzNkg4P/Hh6j6dwMALbVc7Gc/q+u6xinR+zpJu7s4UEozxSxDi1
	BvmgoGjzJ8uS+4/E0i3OPnSsjtdo1jCS2Op6H0rzEEUKlYyHW2TxTtlzOoE2ibrPEbW90EzN+9k
	USyykwQQImOd6F782whKOTxitn0vUwb8BZtN
X-Google-Smtp-Source: AGHT+IHX3+a18efpxx2qbHXAhs4U0wbk1ul7gmrkFn8LxyQ+grE1C90J+pJbcS1vktIQA6he1PGJqw==
X-Received: by 2002:a05:6512:3f19:b0:545:646:7519 with SMTP id 2adb3069b0e04-54838d3d9d5mr6616063e87.0.1740477318630;
        Tue, 25 Feb 2025 01:55:18 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b261esm132867e87.24.2025.02.25.01.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:55:17 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 10:55:03 +0100
Subject: [PATCH v5 16/31] ARM: entry: Drop argument to asm_irqentry macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-arm-generic-entry-v5-16-2f02313653e5@linaro.org>
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

asm_irqentry_enter_from_user_mode and asm_irqentry_exit_to_user_mode
have a "save" argument that will save and restore registers before
the call to the C function.

Now all invocations set this argument to 0 so drop the surplus
code.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/entry-armv.S   |  8 ++++----
 arch/arm/kernel/entry-common.S |  2 +-
 arch/arm/kernel/entry-header.S | 18 ++----------------
 3 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 6edf362ab1e1035dafebf6fb7c55db71462c1eae..460aa92c3c1f50de905550acf363c58f509bfe0a 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -422,7 +422,7 @@ ENDPROC(__fiq_abt)
 	.align	5
 __dabt_usr:
 	usr_entry uaccess=0
-	asm_irqentry_enter_from_user_mode save = 0
+	asm_irqentry_enter_from_user_mode
 	kuser_cmpxchg_check
 	mov	r2, sp
 	dabt_helper
@@ -433,7 +433,7 @@ ENDPROC(__dabt_usr)
 	.align	5
 __irq_usr:
 	usr_entry
-	asm_irqentry_enter_from_user_mode save = 0
+	asm_irqentry_enter_from_user_mode
 	kuser_cmpxchg_check
 	irq_handler from_user=1
 	get_thread_info tsk
@@ -447,7 +447,7 @@ ENDPROC(__irq_usr)
 	.align	5
 __und_usr:
 	usr_entry uaccess=0
-	asm_irqentry_enter_from_user_mode save = 0
+	asm_irqentry_enter_from_user_mode
 
 	@ IRQs must be enabled before attempting to read the instruction from
 	@ user space since that could cause a page/translation fault if the
@@ -472,7 +472,7 @@ ENDPROC(__und_usr)
 	.align	5
 __pabt_usr:
 	usr_entry
-	asm_irqentry_enter_from_user_mode save = 0
+	asm_irqentry_enter_from_user_mode
 	mov	r2, sp				@ regs
 	pabt_helper
  UNWIND(.fnend		)
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 14b2495cae3c2f95b0dfecd849b4e16ec143dbe9..df564388905ee019cd5553f8b37e678da59e3222 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -109,7 +109,7 @@ ENTRY(ret_to_user_from_irq)
 	movs	r1, r1, lsl #16
 	bne	slow_work_pending
 no_work_pending:
-	asm_irqentry_exit_to_user_mode save = 0
+	asm_irqentry_exit_to_user_mode
 
 #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
 	bl	stackleak_erase_on_task_stack
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index fb5bb019199b2871e29e306a29bea8fdf47dd7f3..50c0b55adc7421e7be123c9d00f94b1ebb93ff9e 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -365,28 +365,14 @@ ALT_UP_B(.L1_\@)
  * Context tracking and other mode transitions. Used to instrument transitions
  * between user and kernel mode.
 */
-	.macro asm_irqentry_enter_from_user_mode, save = 1
-	.if	\save
-	stmdb   sp!, {r0-r3, ip, lr}
+	.macro asm_irqentry_enter_from_user_mode
 	mov	r0, sp				@ regs
 	bl	irqentry_enter_from_user_mode
-	ldmia	sp!, {r0-r3, ip, lr}
-	.else
-	mov	r0, sp				@ regs
-	bl	irqentry_enter_from_user_mode
-	.endif
 	.endm
 
-	.macro asm_irqentry_exit_to_user_mode, save = 1
-	.if	\save
-	stmdb   sp!, {r0-r3, ip, lr}
+	.macro asm_irqentry_exit_to_user_mode
 	mov	r0, sp				@ regs
 	bl	irqentry_exit_to_user_mode
-	ldmia	sp!, {r0-r3, ip, lr}
-	.else
-	mov	r0, sp				@ regs
-	bl	irqentry_exit_to_user_mode
-	.endif
 	.endm
 
 /*

-- 
2.48.1


