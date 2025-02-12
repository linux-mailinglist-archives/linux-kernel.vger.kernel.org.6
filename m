Return-Path: <linux-kernel+bounces-511022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D090A324CF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC392167BE4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDD020AF7D;
	Wed, 12 Feb 2025 11:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YL2Jqv6P"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C035B210185
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359409; cv=none; b=Wkgbjz/lFtguNetK6GfWbYtFyQDBG7GMr2XgHWGrNrkbfsk6Oy+aURTGKoibNBh5Shwtw/DlVoO2PuOysDISwzRQQfMVOYqVnsbHA/5Fa+moBXd/H6UxZFTaOGrk6lETFiStTyzipDfWd2c204q3CG8CZpKTGzbhGktRq8Cq6ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359409; c=relaxed/simple;
	bh=UHzcNNHxwFWGv8vEtBqZ0RLUWXweMBley6ciSj/Iipg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=juE8EEbfzfsy9UUr0OTh73Bq5zepRESvmYeEfZFul2guG7yfS7I0tiJ/WS8Kn9ULRQyPRd/sQT+rGTCSaKhJMFMERnKomTuB7BIrkfF3Rhe+HGAYvYdowPeqU49Q5Z5NeKaSGtPNLlhmm8gRpUPma2VyOq0/CdnXaM+cvhw9PUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YL2Jqv6P; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-308f53aef4fso23625031fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739359406; x=1739964206; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SK4XvykyJ6Zn+vIxSK9vSx/zpAi4l4ILYAtxYCxqygE=;
        b=YL2Jqv6Pg66hGJTsj2/O2DFWdxADGlKWX5xlQghEQ2er0IYYlF58fSBcoHVKyWd0wi
         fkXnR9zkmjqTC8mYBxbdQqhPpz1IskS5/lzSdoNRO3FQg77ZhTLdnoan9kiM4HARUeF7
         Sg5i4xXuXe8vcZ46Nv4neYy4gZHfDc0NOLeUZYyFdNE2tn2LCqkBC/uZPRLZ2WfFNhJA
         fM6HQslEd121O36PMEvehjirANKabCIXg/h9hnPXxUqz1BJ5PXIk1zyfemjKoEf3chAo
         RbP9LAh+T9ANFl6t4DpDnXJeyoLvt3mpvbESGP6Y9+TbIm19LZEjTOMbzOfK12yRIOOl
         R5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739359406; x=1739964206;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SK4XvykyJ6Zn+vIxSK9vSx/zpAi4l4ILYAtxYCxqygE=;
        b=VAZpLpK88XGaKxhdMNoIswTg+L5gHKarfwv/PX1/ecwoRWWMbZY0K0XwZxUptMOzpc
         aNlSI6UyKIYoxS6QIlvn+z/OjGokrupHcHAfIfHOZjGDVA2NkBOQ3R2w4rBtl7erK9oU
         eGOAHDuYykJ5AvF5BLJ4kkiHCN7n0fGi0QncwqiGnzBLGXMU6ERGcBDpqdW5KEyM+NW8
         EqEcEj+qdFEMLG8z4OHFYCPMtS/2Wj9gVSrR50esA/dZozRJUFCtu+6BY2BlzwQ3/a8W
         jj42/nO+WVoQU2Henc451drZOIEB4UbX6nMEMu2/oWhqVZnjckX2CTne7r4XK4Ib+zM2
         9lGA==
X-Forwarded-Encrypted: i=1; AJvYcCV/0//BVkEWDr+Q2ruNzJHbQ3yqyKpvoscLtsTwCrjixQCmsu4vZ5eRKYIw+T/nAkRhnNCQKXaBXPCDq+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIu7W2wVzSNdlxYCfBdVavhNcclTQBUKfb4djDKK+rGPGp6pjs
	cLc4bw3wHETCS0s4KbNOeF+A++ai5P9E6SroUcqX0bKAFmUP/ANKI/NGRg2/jZI=
X-Gm-Gg: ASbGnctoeoPlejSAgPcvVGUuoKgF4DAadt618tq/ujem2oXxBQDNSlkwTMhC97Mqtmc
	RJ5dOVNHnYuP0k05Kja8HuhAq55XtWJf/xkY0DVxhAgKTWR4Ly6i3ZK0BYOIkQDiFPDawLt3rf+
	M7LoJRK84nT408QUo0WruCc1acwLTC5ucTfkBNWhkiiS5PyiO6jWgwrlbIxIJeBVa12DY+L6sd2
	HUAGb4xUUF0FG3+ANCTos5LhTQ1kYmC9SHNw14U2HM0ZeRtJjSFB+AEUsJMw594UbLZgfL+quX9
	2zfvFnAIS4/GizP+zOv2F5oAEg==
X-Google-Smtp-Source: AGHT+IGZGX3RxfrWPejP/YO09nPgCO79pvl584D11RVURMnv/+ySzxg9C6vPdPm/xocAoi8IjTVcCQ==
X-Received: by 2002:a2e:be87:0:b0:308:f0c9:c4cf with SMTP id 38308e7fff4ca-309036f2cd8mr10642481fa.33.1739359405778;
        Wed, 12 Feb 2025 03:23:25 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307de1a6531sm18310511fa.45.2025.02.12.03.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:23:25 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 12 Feb 2025 12:23:13 +0100
Subject: [PATCH v4 19/31] ARM: entry: Remove fast and offset register
 restore
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-arm-generic-entry-v4-19-a457ff0a61d6@linaro.org>
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


