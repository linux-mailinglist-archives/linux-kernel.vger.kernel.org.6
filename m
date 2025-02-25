Return-Path: <linux-kernel+bounces-530960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE7AA43A7B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A109172402
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608A5268C57;
	Tue, 25 Feb 2025 09:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NNkSXsUF"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D4026868A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477325; cv=none; b=uWJIKKLtsk1FXC22tWW5c8RZXXEWXBHdmDGJXZmteO1MdMssIknKUBw4JzIbl93jzqrp/M9gVLRjKwjFfCLTBXTugzsy/Q7174W62ATwhAq5SajHqrP46BI/P0uyaO6Qb5ktfMGd7DCVtr6vJfxD5VywiqH6pAoP5k3l00vS5/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477325; c=relaxed/simple;
	bh=UHzcNNHxwFWGv8vEtBqZ0RLUWXweMBley6ciSj/Iipg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HtHS+LlZss4na3HvXO+gcx7RpjYVsKrQ1gu4HSxXu64N1ueHZnK/j2sEKq2a0SzLuJLmou5drUSWsOA2JtH6LTNj9HxpK1s5wogEfQGN8g5RBNk7U1dCDTn1rRiA6nC18pF4atg7duXAzot34oH/co+YyRkOpIhXtoMAjzpybPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NNkSXsUF; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5461f2ca386so4627040e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477322; x=1741082122; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SK4XvykyJ6Zn+vIxSK9vSx/zpAi4l4ILYAtxYCxqygE=;
        b=NNkSXsUFO5+/tdwkkoJBjzR4lhnyOZZ2gXGIRWukdc8FESNZgmo1vZXAb29OwDlHFF
         rtCUrzJRsUyQLZ0WWD/hFV0qN+uL+uuAIyBW7T6dTafyGtwAEcwttc7nMRK7xpKyx+h9
         IBn9JZFbFBLZRcaH5y3fNeDJ6nVnqkpqz0oCWS6uQmuQOoknDuQTI62EY9mzgnUPOt1r
         MXuxVwm70PkRttRExNeff/yLTkug7ZOLf6qlo15iuGrFMM+F7cO9QN3iU9ipsB8rxPqX
         nc6EncnyuLCdJEdpybsY/tVB2ODCYsN/aX5v9AiTfYjnCRtFpxIaMssKAXkCW+iH0OlY
         w7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477322; x=1741082122;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SK4XvykyJ6Zn+vIxSK9vSx/zpAi4l4ILYAtxYCxqygE=;
        b=dkKz0BJuAttZP3TF0weB59mjT2HQL31vortyBR96Fw5XJ0FyVG2zprh5fK6ddXBoBP
         4lY8hubjZIUayEuWwMPRug9QF4xV2c3mmEpsBybiMUkJd0ig/hgCSjKjoNup3cQyc9kN
         Gdxz23f3Q9JRLMxZaVcLM+aKsOFtQ3rMzjmYzaSuy/K0U0JkqeHrYLdiOHwZbUzKkScY
         dfg8K65KyPhUChm9yCMooNWLqLBbhsVIbjpU5k3l/NJEA/zM8fy/WXjrIOE+8hZF6MRJ
         BiWhEipTBrlqDkpVB8alLxNIkMqNjZOrLEx3BbUtCW24yWQZFeC8CGMaRyAK+MS7VJKk
         eBtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhFERG7UY0dPq3pDzuR4sD/kZjCO9lXVoOlkXsSkwicVN2EdWpg78oVIuyde3wsutdPap1blk4hy+7vl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8FjvyTZ+ZBCbCFFAk+v3IG7zGlpz2my5wvH02KmgBKO6PwDjR
	4IokYJtQtKjLEkLtkUuEVMpa398v+xy/9JtN33FNy2nu2PNHg1s5ivmL7Y9xXz8=
X-Gm-Gg: ASbGncvS0jVBqHrFg7oepJsJ3ptMTWK2MJAj+//beCw2ZllFlY0wY2S1/BjOn6ymfN3
	YgPjbxOVXacbwlUHJFpPidqm50u/yI3nxeMVrv0Uc6DV8XjeYabAHIVTT33UYMurBG0kGJheBeZ
	8YeBxTBWolRUePmYWlWPR1wKlc2Jhg0ca8UDH0XCFYaGrLum7ZorhipaSjrEPSdaJjoH6VO5JR1
	dhjztWJmEH9Wcww7RIHr0r7cI2euiEPlhGt8PiYeA8Aqm5HfSdnGrT7ZFfkaKrL1WZ9ty0QGVc6
	EXGvJN02F9TrOCcIhuYhDnozlwBQp5lqzzut
X-Google-Smtp-Source: AGHT+IHCtJvTxVRz26fQjj6kCjgqj3b1/2GhW8qtHYMwDMQCiPhoAVv8hPhhcX8Zp/SFXBZFx0kpow==
X-Received: by 2002:a05:6512:3f17:b0:545:2ddf:1189 with SMTP id 2adb3069b0e04-5483912fc63mr6223975e87.6.1740477321934;
        Tue, 25 Feb 2025 01:55:21 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b261esm132867e87.24.2025.02.25.01.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:55:21 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 10:55:06 +0100
Subject: [PATCH v5 19/31] ARM: entry: Remove fast and offset register
 restore
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-arm-generic-entry-v5-19-2f02313653e5@linaro.org>
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

Now all remaining invocations of restore_user_regs has
fast = 0 and offset = 0 set, so drop these parameters
to the macro.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/entry-armv.S   |  2 +-
 arch/arm/kernel/entry-common.S |  2 +-
 arch/arm/kernel/entry-header.S | 29 +++++++++--------------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 460aa92c3c1f50de905550acf363c58f509bfe0a..3cd5a80b47758867d1db6c3971030370bca1551a 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -497,7 +497,7 @@ __fiq_usr:
 	mov	r0, sp				@ struct pt_regs *regs
 	bl	handle_fiq_as_nmi
 	get_thread_info tsk
-	restore_user_regs fast = 0, offset = 0
+	restore_user_regs
  UNWIND(.fnend		)
 ENDPROC(__fiq_usr)
 
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index dddbd6ba1eb9fcbc2c0d81f24e1a9b3231558d7f..d27e34d7e97a079d62e7b778cf7cf97c302e4763 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -81,7 +81,7 @@ no_work_pending:
 #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
 	bl	stackleak_erase_on_task_stack
 #endif
-	restore_user_regs fast = 0, offset = 0
+	restore_user_regs
 ENDPROC(ret_to_user_from_irq)
 ENDPROC(ret_to_user)
 
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index 50c0b55adc7421e7be123c9d00f94b1ebb93ff9e..51c7f93c1ded1db56f173c7aaed8094ef011ff5a 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -290,7 +290,7 @@
 	.endm
 
 
-	.macro	restore_user_regs, fast = 0, offset = 0
+	.macro	restore_user_regs
 #if defined(CONFIG_CPU_32v6K) && \
     (!defined(CONFIG_CPU_V6) || defined(CONFIG_SMP))
 #ifdef CONFIG_CPU_V6
@@ -309,8 +309,8 @@ ALT_UP_B(.L1_\@)
 #ifndef CONFIG_THUMB2_KERNEL
 	@ ARM mode restore
 	mov	r2, sp
-	ldr	r1, [r2, #\offset + S_PSR]	@ get calling cpsr
-	ldr	lr, [r2, #\offset + S_PC]!	@ get pc
+	ldr	r1, [r2, S_PSR]			@ get calling cpsr
+	ldr	lr, [r2, S_PC]!			@ get pc
 	tst	r1, #PSR_I_BIT | 0x0f
 	bne	1f
 	msr	spsr_cxsf, r1			@ save in spsr_svc
@@ -318,31 +318,24 @@ ALT_UP_B(.L1_\@)
 	@ We must avoid clrex due to Cortex-A15 erratum #830321
 	strex	r1, r2, [r2]			@ clear the exclusive monitor
 #endif
-	.if	\fast
-	ldmdb	r2, {r1 - lr}^			@ get calling r1 - lr
-	.else
 	ldmdb	r2, {r0 - lr}^			@ get calling r0 - lr
-	.endif
 	mov	r0, r0				@ ARMv5T and earlier require a nop
 						@ after ldm {}^
-	add	sp, sp, #\offset + PT_REGS_SIZE
+	add	sp, sp, #PT_REGS_SIZE
 	movs	pc, lr				@ return & move spsr_svc into cpsr
 1:	bug	"Returning to usermode but unexpected PSR bits set?", \@
 #elif defined(CONFIG_CPU_V7M)
 	@ V7M restore.
 	@ Note that we don't need to do clrex here as clearing the local
 	@ monitor is part of the exception entry and exit sequence.
-	.if	\offset
-	add	sp, #\offset
-	.endif
-	v7m_exception_slow_exit ret_r0 = \fast
+	v7m_exception_slow_exit ret_r0 = 0
 #else
 	@ Thumb mode restore
 	mov	r2, sp
-	load_user_sp_lr r2, r3, \offset + S_SP	@ calling sp, lr
-	ldr	r1, [sp, #\offset + S_PSR]	@ get calling cpsr
-	ldr	lr, [sp, #\offset + S_PC]	@ get pc
-	add	sp, sp, #\offset + S_SP
+	load_user_sp_lr r2, r3, S_SP		@ calling sp, lr
+	ldr	r1, [sp, S_PSR]			@ get calling cpsr
+	ldr	lr, [sp, S_PC]			@ get pc
+	add	sp, sp, S_SP
 	tst	r1, #PSR_I_BIT | 0x0f
 	bne	1f
 	msr	spsr_cxsf, r1			@ save in spsr_svc
@@ -350,11 +343,7 @@ ALT_UP_B(.L1_\@)
 	@ We must avoid clrex due to Cortex-A15 erratum #830321
 	strex	r1, r2, [sp]			@ clear the exclusive monitor
 
-	.if	\fast
-	ldmdb	sp, {r1 - r12}			@ get calling r1 - r12
-	.else
 	ldmdb	sp, {r0 - r12}			@ get calling r0 - r12
-	.endif
 	add	sp, sp, #PT_REGS_SIZE - S_SP
 	movs	pc, lr				@ return & move spsr_svc into cpsr
 1:	bug	"Returning to usermode but unexpected PSR bits set?", \@

-- 
2.48.1


