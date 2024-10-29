Return-Path: <linux-kernel+bounces-386756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 639E59B47A8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 545951C228D6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A652920C487;
	Tue, 29 Oct 2024 10:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tJh/T5fp"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F49920C480
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730199200; cv=none; b=WHjkFSMpHWVXryMLQzOW5Pfo0jd2JNRiZ6aSxuV2IpSK0Xad/ruxJtcNU49nd7SU6j6x4y41f7cP5IkhU0OJxqsbntNFaH6gqNzeIz0pwJ576jhJtv/Ljj+ibLBjUXESpN2GeMOn1F5yZ3q9498UQnaqpMzfb833/N4x//Nykaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730199200; c=relaxed/simple;
	bh=CpGlIrf5p+st0iXrAuSSydMx9vVrjXfwmalBa4qqxa4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s0zf5NRkYhWMcZ0cwue1O7oUjE02XVfTkHVn8hxnkt3hG0sppgVV51As3pw68ky2tMI/q3w0Mz+7s8zasikU/7GTIdtDdxsdkr8mdrpPT1EU12j7+OrlgILwjpSyJbA5O+kzGzhOQsUaKZbqSwPVwT8IkDIDIn3T0jAFmMzZ5Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tJh/T5fp; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53b13ea6b78so8221054e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730199196; x=1730803996; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JNSBA39L+uD3IEP0aKHjk6mvKlXPMhygyF+Shfug/O4=;
        b=tJh/T5fptuE+SnLjw8VWhMeQhcaBUMmRsK/CATJuFduPuztA7KNSsdT5ihMK991bCk
         ZwolIVKk6cnLIvWssSYi0lzmCxjGR+ZLFdouxvX0fTAs1RymTd+RoCISul0uTWRuBcNk
         EbmH+di7x5biQkFDp6SXOAh0VJMowp5nFk98QFHGU/+mu9IMq7mzg0gBIvpXyCv5UwnK
         MhiFV+ABEsxGHGKMO/105TGXN5cSOCEFa2vNsxmIPf3YfRuEn5HZuM42LJ9RPxHe0Vyy
         TOBSMk0U1d9KWIIatUV0XgFmTxiJlHzo6+0oX5AlwBqLt/YLFkk4OKSvztFLmQu3msQN
         XVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730199196; x=1730803996;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JNSBA39L+uD3IEP0aKHjk6mvKlXPMhygyF+Shfug/O4=;
        b=fqV0OXPPRb7BS3RiHlWwHYJmeZQdi7DHkU57ZWKf8lhCygADH0mz9sbetUwz1g5z8n
         gDHxk+8+6MQHUHtyQqnPBXh0mGnZCuveJXvtYmashwmzqeF2d46UdjAjXe45QWkEFiKF
         htM4jJ7gjMa8PxDY+nAg9G8RQJA8nSFYGwQ/wzqHGj3I8ttn6tIxpFfD8xlgCjA1rj2k
         4b/xLRj31guxUs/I7x0Xe78vL6ZefAlp494d53WuQtuAqk/tXkgFsz2EGXZi5K9ZIlWv
         Od8VWZwygk/a8NmzSe5DWv24TIhhvU8ipWQxiaDqemn4phj8TJVD9N7QpwzwoNxFRxtx
         F0uA==
X-Forwarded-Encrypted: i=1; AJvYcCVO5/xH3lqRnyn7OCY+35r/iTeSNfIb62AUM/1+hDwRLPswy0FCFXqKvrNx5qMoy823lmr+htgyURYXHT8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdv3sy8QjXwHQRnVQ5gcFbKBoUEv42HkQTEhZwpe+joZC4MTQN
	quHroNgnVFSvJ8KCh6ChHTexpREx2uhbAH5Z8n2hUKgbuBXrGk2cs7/5D0P3vTI=
X-Google-Smtp-Source: AGHT+IHwhUbueHKfzusT1MGnoFMhY8X4pCN3hYae0P/kspX02WumWJCSxZicZBMwsoQhFKVcgb73SQ==
X-Received: by 2002:a05:6512:3c9f:b0:539:93b2:1380 with SMTP id 2adb3069b0e04-53b34921b15mr9499847e87.48.1730199195613;
        Tue, 29 Oct 2024 03:53:15 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e12452fsm1351307e87.73.2024.10.29.03.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:53:13 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 29 Oct 2024 11:52:56 +0100
Subject: [PATCH RFC v2 16/28] ARM: entry: Drop argument to asm_irqentry
 macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-arm-generic-entry-v2-16-573519abef38@linaro.org>
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
index 0328860475e1..09ce1be1f677 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -421,7 +421,7 @@ ENDPROC(__fiq_abt)
 	.align	5
 __dabt_usr:
 	usr_entry uaccess=0
-	asm_irqentry_enter_from_user_mode save = 0
+	asm_irqentry_enter_from_user_mode
 	kuser_cmpxchg_check
 	mov	r2, sp
 	dabt_helper
@@ -432,7 +432,7 @@ ENDPROC(__dabt_usr)
 	.align	5
 __irq_usr:
 	usr_entry
-	asm_irqentry_enter_from_user_mode save = 0
+	asm_irqentry_enter_from_user_mode
 	kuser_cmpxchg_check
 	irq_handler from_user=1
 	get_thread_info tsk
@@ -446,7 +446,7 @@ ENDPROC(__irq_usr)
 	.align	5
 __und_usr:
 	usr_entry uaccess=0
-	asm_irqentry_enter_from_user_mode save = 0
+	asm_irqentry_enter_from_user_mode
 
 	@ IRQs must be enabled before attempting to read the instruction from
 	@ user space since that could cause a page/translation fault if the
@@ -471,7 +471,7 @@ ENDPROC(__und_usr)
 	.align	5
 __pabt_usr:
 	usr_entry
-	asm_irqentry_enter_from_user_mode save = 0
+	asm_irqentry_enter_from_user_mode
 	mov	r2, sp				@ regs
 	pabt_helper
  UNWIND(.fnend		)
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 14b2495cae3c..df564388905e 100644
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
index fb5bb019199b..50c0b55adc74 100644
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
2.46.2


