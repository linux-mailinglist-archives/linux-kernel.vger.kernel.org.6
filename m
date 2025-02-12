Return-Path: <linux-kernel+bounces-511019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25980A324CC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BEE8167AE6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9B420FAAC;
	Wed, 12 Feb 2025 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xosLuXFO"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984B420F063
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359406; cv=none; b=FTCOTNI6uEXZbziMHY8wI7qf40MXAfqw83o/7a7PrdLnP8ZGCwWZlxUlalu6XAq6+/UjHYAWq9d43nUktbOSsKBPlvBLq2dNEmmFoi1ljQl1bqxnZA9yOk7ONJbu4TKOtWnEHNXp09Cs15olKZbIvkRK8Pz5G0MwjPxvZL1Cyh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359406; c=relaxed/simple;
	bh=yLAVHOLvwqsi9en7ghFTQoRLGB+8xrjaFpRIXfNOxb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ehqlrb6OwmE6X0dAa68AtMM3+gUTlkVWS0u31lvnRJDRO6tWSD6Ex42/pLVsNSUhHZGcF8pMAQAku+jpiWn4Uy25T8t0DaA3ZVPcRWJK0OGBx4O6Jrmzn/qV+sGI+xYrxOqRNTmhW68+6iHrLY5R5IKTHcnYVrxU/dFoeHmB2j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xosLuXFO; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30797730cbdso65111581fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739359403; x=1739964203; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ggLp2N6nIh1N25l9qqVFGy2pp6+E0t6/i4rH9zHeAXo=;
        b=xosLuXFOun/zQ8aFcmwFhXbk9i3CTPRJdS7xPjRukjrFnazNxp6vATjCAIh7V99X3C
         P5rxgl3+FRFt3bvRwi3JA+CQj0D1RIjO3rRqvXJfYbFdiiw7Ougf5SL229LKFTy1oQVz
         x3OPmIGvkSaAsMXQSe0iL+uXWc6fry6dB61PDkMphDiX6lOAZoCvm6vrmoPDUayVFVn9
         VAPKeEocKY8A8gf/YQNZQMVJa0iWu2r9o1R6nsil4xqmn/qpV2UlJfbLyQC3W5bEk4EJ
         X2lIidyr3HqcM8Z4XwUBrRERPa6AQnVS7gADy3eF88agCrCL0Tnyygl5Vyg1gDS0sBXZ
         RiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739359403; x=1739964203;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ggLp2N6nIh1N25l9qqVFGy2pp6+E0t6/i4rH9zHeAXo=;
        b=kc7S1vVLxyEXzlvQwWm3Tw/18NWwnnTS4r2mIFqnqjnYJLNu46IxBb5I0kSyeENepy
         uZPUEzQVuq9MZ12dGH1Uv5FFw0q8hN3TODUjLDPf+wVCQ3hLQoFMvnThY0YPgy7iyc6X
         JxJaNsbkkS4pxzoUtJOjS/d0WvTR7tuakeYx/3ghrfF8aCcK00+CxOo9TkdtM8PSH2aS
         zfQnMZIjzIXslEth5cZ+lbIMOwV37Awt0hj3H265isp9UOL2/W7K/Edm/Hcxo7EJn1cn
         4/jBZvNAY3/D+Hy4oZ5XpKJ2pGt4qAMp69acy+TXiMPuFAdBZ5EEJIRP3chSu3jZrraf
         QiWA==
X-Forwarded-Encrypted: i=1; AJvYcCVCMNWPlyIr7EUQgUFnUHHNEMS5Tc9sR+ZzSYY1rnHY/tXwyMFfjTfw1liCEwEuvZ7kdvZjTcsfHCYvUTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHPKcOsLQZIcb+FYZrXpYVwBDeLIsuVI7TC5vQvKK/xu+8rEor
	y+im8sZty5iDTOGasoR1OfuTrp9EiKLr8JzueGEqxuB6kI+NJ7I1n5+KveVn4mM=
X-Gm-Gg: ASbGnctljxbUYjj92tkk4vWD16ph9rDFfJ07imv9QsHXL/xkwySxMCUIwNtpzYEpX0s
	CCukZe2eJ4RTcYoLdF6MhkPmzAcNqMDrQ0RDo5UY6wcJjqkUSHbzlVHC/ix8CDyDr9/uFEkL7IN
	hlam++4M2a3tUslZWF9iY9/32mB77bQJtkgJtnUMNNAP6TibtACzLpBlGkacjHEUAJY3Z8OfWDR
	ReNhIJBOLOSHhofo/dMe5CSVoZMnn41EPLjKiJO8rrsLoLhAU19nAQwR3HcTUW56MHlkoLqMKs9
	I4XSAsOI/OQGVgYzs2swNa/b1w==
X-Google-Smtp-Source: AGHT+IE++2ckcXtWyXX7JU0MwX+37DcqZEVj69OKEYC5Hko3s34PTk0ej3SG2in6uu2FQAzgMWO6uA==
X-Received: by 2002:a05:651c:503:b0:308:f4cc:952e with SMTP id 38308e7fff4ca-309036b51c0mr12255951fa.11.1739359402652;
        Wed, 12 Feb 2025 03:23:22 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307de1a6531sm18310511fa.45.2025.02.12.03.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:23:22 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 12 Feb 2025 12:23:10 +0100
Subject: [PATCH v4 16/31] ARM: entry: Drop argument to asm_irqentry macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-arm-generic-entry-v4-16-a457ff0a61d6@linaro.org>
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


