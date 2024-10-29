Return-Path: <linux-kernel+bounces-386755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F339B47A7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7FEB1C228AC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C81120C48F;
	Tue, 29 Oct 2024 10:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oOaNqpnj"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FC020C46B
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730199198; cv=none; b=Spe0i1biodJ6xePbYFQE/MecKCgBRcWsRTcsg1BqOZ/1mmQnLOaCRiQ4t7ey3YuUdhBbZ8CFUnj4OSnBHfT7UPHRdlroc8keDdsJNG9/Z/BEfB/+CS3AqIZ3ZRi8Pz6ZA1H6Gob4pM5+JAyqceXqUQmJTF42FRwITDA/F05v0Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730199198; c=relaxed/simple;
	bh=GNeY2LQCUhc09WZjjbVfkXZmlZISRGueBzk8RTdV3Hg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B35G23/dGqVLQFFWI/4H3/dttsJ7YKU62k47ayt26crBhBNW2qXaXYcW3I0rAA3pVSYY36oYYwajtspJ7eED9JwFy1rnxdwNlFev6WyVnqGlm3URXeJQ75WTpOEk/zzTpn80knvjX8+oQGYguXQWqAxasuu6+Rj5kmV1DA520s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oOaNqpnj; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53b13ea6b78so8220997e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730199193; x=1730803993; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qPx4kMCDrheeY8xWYJ0qE47ahtpfJ0dLdCDyA5qyaAo=;
        b=oOaNqpnj0lz/3hdWN79LNDKUJfps2FEMpQPvX4ERCgTSbgt8r59u2hoz7uVjG8TFDj
         yqeYDI5/l8H0l4xoj5h+OXHvpcbHqwK/btlZ/MMUBS+H1qmQCF1AvMKpmW60xe27m5GM
         i4DdrjxPpyOMGKVCtNW7hVwEJkVwh1lZx/KaGeKyx1Ao7JMBxI6sJ2oQ25coEP+96vxi
         /2Mlf/urX82v2uhqzTqZXffkYzJriFn/g7TBc5EZ9zMQTvItZ45pRLfgukomY52BAwaI
         Sjb4CtXYIjV9pLkRZqZl4y9rJGRhArvck/3uwuWX4tpWpzlktBUO2EpC5d5lxChwroHk
         Ur0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730199193; x=1730803993;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPx4kMCDrheeY8xWYJ0qE47ahtpfJ0dLdCDyA5qyaAo=;
        b=LBVlMj8nOc8HwgdIuyfSVxiugH+vTz9rOfG4JEWY2H+uexWkyMvpJWJEQZ09rFgk08
         NCHor0YN13tuF+Fmpwrx1QnzwZxNdOwl2TCIvofKNp0AFb2MB1ZnRgiMHxgCzkmsIQ8q
         OhDFdLvAQYf8r9i8YcWIpB5aVDmMXHoIdC5txWGsEYA8ygiKqACMU9gNTaV1zOo1c28/
         IYebGlrTo8oBRmy3tuAAWeDCZvktyszueBJAF5A48xgcm6dZGa5iHCUvwdz2DR/p/m87
         NwUASTnVyIf47hHUl5CRMQCgSwyVp0iBeyCDhLVBUYBypXtr4AoyHlKbqPd9Ewwuz4ia
         la3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1L34HFhpXnimdSvhaGlZ7O2MCi7q6v0YoIbhdIgL6qRVuU/GnkBSMWlC2Qw72+Bv1vkHX19DXg9M9Ozc=@vger.kernel.org
X-Gm-Message-State: AOJu0YymxiKkRpZTwrFipusvLV+agiqfClarseGANUiET/CE+XN4xi68
	7+zAj6s1CeexaGqs93x1SHFX/Gx1kXcmH5xsK8+Cy4r1ZU5h6rQE7BIoycJheTw=
X-Google-Smtp-Source: AGHT+IHn5Jo6MxlNJU5iIOZUqab7EQOi+XN5sQRY1pjOsF1gVhbe2i3K7M96BCHGCpFL++J60EFYIg==
X-Received: by 2002:a05:6512:a93:b0:535:6925:7a82 with SMTP id 2adb3069b0e04-53b3491e2c7mr8892647e87.41.1730199193203;
        Tue, 29 Oct 2024 03:53:13 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e12452fsm1351307e87.73.2024.10.29.03.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:53:12 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 29 Oct 2024 11:52:55 +0100
Subject: [PATCH RFC v2 15/28] ARM: entry: Separate call path for syscall
 SWI entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-arm-generic-entry-v2-15-573519abef38@linaro.org>
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

The syscalls (SWIs, software interrupts) are deviating from how
any other interrupts are handled as they enable the IRQs again
while processing the syscall, while "hard" IRQs disable all
interrupts until they are handled.

Break out syscall_enter_from_user_mode() into its own function
and call it instead of irqentry_enter_from_user_mode().

As we are moving toward generic entry, we use the signature
from the generic function.

As the generic function requires the syscall number to be
determined, we move the call down below the code that
figures out the syscall number, the only practical effect
should be that interrupts are re-enabled a few instructions
later.

As we move the trace_hardirqs_on/off() calls into C, we can
just get rid of the helper macro usr_entry_enter again and
call asm_irqentry_enter_from_user_mode directly.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/include/asm/entry.h   |  1 +
 arch/arm/kernel/entry-armv.S   | 16 ++++------------
 arch/arm/kernel/entry-common.S | 18 +++++++++++++-----
 arch/arm/kernel/entry.c        | 14 ++++++++++++++
 4 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/arch/arm/include/asm/entry.h b/arch/arm/include/asm/entry.h
index e26f369375ca..e259b074caef 100644
--- a/arch/arm/include/asm/entry.h
+++ b/arch/arm/include/asm/entry.h
@@ -8,6 +8,7 @@ struct pt_regs;
  * These are copies of generic entry headers so we can transition
  * to generic entry once they are semantically equivalent.
  */
+long syscall_enter_from_user_mode(struct pt_regs *regs, long);
 void irqentry_enter_from_user_mode(struct pt_regs *regs);
 void irqentry_exit_to_user_mode(struct pt_regs *regs);
 
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index be2df297ec0a..0328860475e1 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -402,14 +402,6 @@ ENDPROC(__fiq_abt)
 	zero_fp
 	.endm
 
-	/* Called after usr_entry for everything except FIQ */
-	.macro	usr_entry_enter
-#ifdef CONFIG_TRACE_IRQFLAGS
-	bl	trace_hardirqs_off
-#endif
-	asm_irqentry_enter_from_user_mode save = 0
-	.endm
-
 	.macro	kuser_cmpxchg_check
 #if !defined(CONFIG_CPU_32v6K) && defined(CONFIG_KUSER_HELPERS)
 #ifndef CONFIG_MMU
@@ -429,7 +421,7 @@ ENDPROC(__fiq_abt)
 	.align	5
 __dabt_usr:
 	usr_entry uaccess=0
-	usr_entry_enter
+	asm_irqentry_enter_from_user_mode save = 0
 	kuser_cmpxchg_check
 	mov	r2, sp
 	dabt_helper
@@ -440,7 +432,7 @@ ENDPROC(__dabt_usr)
 	.align	5
 __irq_usr:
 	usr_entry
-	usr_entry_enter
+	asm_irqentry_enter_from_user_mode save = 0
 	kuser_cmpxchg_check
 	irq_handler from_user=1
 	get_thread_info tsk
@@ -454,7 +446,7 @@ ENDPROC(__irq_usr)
 	.align	5
 __und_usr:
 	usr_entry uaccess=0
-	usr_entry_enter
+	asm_irqentry_enter_from_user_mode save = 0
 
 	@ IRQs must be enabled before attempting to read the instruction from
 	@ user space since that could cause a page/translation fault if the
@@ -479,7 +471,7 @@ ENDPROC(__und_usr)
 	.align	5
 __pabt_usr:
 	usr_entry
-	usr_entry_enter
+	asm_irqentry_enter_from_user_mode save = 0
 	mov	r2, sp				@ regs
 	pabt_helper
  UNWIND(.fnend		)
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index ff1dd3169346..14b2495cae3c 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -109,8 +109,6 @@ ENTRY(ret_to_user_from_irq)
 	movs	r1, r1, lsl #16
 	bne	slow_work_pending
 no_work_pending:
-	asm_trace_hardirqs_on save = 0
-
 	asm_irqentry_exit_to_user_mode save = 0
 
 #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
@@ -189,9 +187,6 @@ ENTRY(vector_swi)
 	reload_current r10, ip
 	zero_fp
 	alignment_trap r10, ip, cr_alignment
-	asm_trace_hardirqs_on save=0
-	enable_irq_notrace
-	asm_irqentry_enter_from_user_mode save = 0
 
 	/*
 	 * Get the system call number.
@@ -256,6 +251,19 @@ ENTRY(vector_swi)
 #else
 	str	scno, [tsk, #TI_ABI_SYSCALL]
 #endif
+
+	/*
+	 * Calling out to C to be careful to save and restore registers.
+	 * This call could modify the syscall number. scno is r7 so we
+	 * do not save and restore r7.
+	 */
+	mov	r0, sp				@ regs
+	mov	r1, scno
+	push	{r4 - r6, r8 - r10, lr}
+	bl	syscall_enter_from_user_mode
+	pop	{r4 - r6, r8 - r10, lr}
+	mov	scno, r0
+
 	mov	r1, sp				@ put regs into r1
 	stmdb	sp!, {r4, r5}			@ push fifth and sixth args
 	mov	r0, tbl
diff --git a/arch/arm/kernel/entry.c b/arch/arm/kernel/entry.c
index 8b2e8ea66c13..1973947c7ad7 100644
--- a/arch/arm/kernel/entry.c
+++ b/arch/arm/kernel/entry.c
@@ -1,15 +1,29 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <asm/entry.h>
 #include <linux/context_tracking.h>
+#include <linux/irqflags.h>
+
+long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
+{
+	trace_hardirqs_on();
+	local_irq_enable();
+	/* This context tracking call has inverse naming */
+	user_exit_callable();
+
+	/* This will optionally be modified later */
+	return syscall;
+}
 
 noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
 {
+	trace_hardirqs_off();
 	/* This context tracking call has inverse naming */
 	user_exit_callable();
 }
 
 noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
 {
+	trace_hardirqs_on();
 	/* This context tracking call has inverse naming */
 	user_enter_callable();
 }

-- 
2.46.2


