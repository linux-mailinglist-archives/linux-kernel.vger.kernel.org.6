Return-Path: <linux-kernel+bounces-358893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40630998515
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 629701C2377B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937521C3F2C;
	Thu, 10 Oct 2024 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JHZLuh0Q"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C46A1C9EBD
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728560054; cv=none; b=UFUGg+WYqiD2SjtbeCTyNJt9UD73jd7G+Ru+r7W1TXMS5GtbUQPVBJEKFyTB07feYERz7Wn3dvI6Rgi5CeGmZQRHKB3kIIHuFy+Le0X0IZffkUnsvCcVi2xaBuUircft1rGlFXVapcJgzt4XvFU6lPQ0NyVfTMDbPL/kA99zEYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728560054; c=relaxed/simple;
	bh=CpGlIrf5p+st0iXrAuSSydMx9vVrjXfwmalBa4qqxa4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z8al2ImLFR1XwHnYcoTmhYpNUpfou8jhEVvru4k6Rg6DMvuzqWA8KKkzzOrtoAIu+dN4P0f31q1zPFhg7D3ErJb4T6yLgoVMb3K8jUUVKzIRxcFK1ODGWr7WFV+dpwGSSLKCJc6sLLPXpXxDTgCbOMD0Q42cHZj4Js7AEUGBlR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JHZLuh0Q; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a995f56ea2dso132029566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728560051; x=1729164851; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JNSBA39L+uD3IEP0aKHjk6mvKlXPMhygyF+Shfug/O4=;
        b=JHZLuh0QMsOpu0imoIhu3PhzNXsQXyOW21PoZScNA9vhgOlguTedh32Sgntz9APDKv
         kMkpkpB3JVxfHDP6UwLdYxBPm08HkL7Dmw1EEhZzJDMZEDsJaSTEP0WTNmLSPIwPjKPN
         JDZiciiC5PLnISLr4iIWM9FMaTndDFIFdfvby6YuXUKpHhgCi9T1AQy3rH5sZJc+s0ux
         s3g9XV7rXkuOB6XRiSwzG0zIT5k+XQGQ5MikWxVjbDJJe9vjKl8jkfkEU1w8hOwNo2wI
         VUVKLS6p1KbpMZGuOHj8/mUTqnV2cqLBMJiraItuXWg45dKR6rB+UoiMRhiL89/S8IjI
         s6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728560051; x=1729164851;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JNSBA39L+uD3IEP0aKHjk6mvKlXPMhygyF+Shfug/O4=;
        b=ngMZoz7PbxbDSLSwiDVcH3MKQ4MCCRogTgkg2R7RsRn0BpOK8OR+Ht+yPKuvm7LDrP
         vh0bhNMFx7gROO13ZXLUpDiv97Y/RFitz52IESZP35IqSgHnYGbNRyhxllLqGfOAIYjZ
         4cx8N+G5HItpVA4nQFJulvdu+MS9k/aPm2DRqPUPo1Tj4rpqpLbOq5KGCkyNaGuot3Wl
         B0EjXjOolUU7liyFUylpavajxoIzK+G50Gux0B6cWblAb2XxfjXmNNiK3UzWTZEwNADs
         lKXn6wuyQ0t2tPe5CZLKtuCTivCrGkMQjcnVJR6Qx15ouKF6+V8rtNcS7jo9jKEO6ZKI
         I58g==
X-Forwarded-Encrypted: i=1; AJvYcCXx5d7fk9V5nl94Rb/U3CGjhlWLMqnWQAWLFp7JQx97hHOSKrOXJSOxVuMrSySufR2ZhXpqDXfZfFlj0DM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGmNRJLSbeXhpmDoeMkhzrfoYRRpfc5dGhpshO18qqT9U0anbo
	q1ulaJ9qRz53bkT6+AINwQgrq9Jqim6ixmXoDiYIA8R6qK7KO/B6ccQYu7KbO7M=
X-Google-Smtp-Source: AGHT+IE5VMKxvHaqB8TM4UQMzMj1+qpZY8SgS8d9OXFElPL9iiC2IKmw/Xc8WMoNH9f/aynvyMEWdg==
X-Received: by 2002:a17:907:e65c:b0:a99:5773:3612 with SMTP id a640c23a62f3a-a998d202140mr531002866b.36.1728560049978;
        Thu, 10 Oct 2024 04:34:09 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f25406sm77619066b.69.2024.10.10.04.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 04:34:08 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Oct 2024 13:33:54 +0200
Subject: [PATCH RFC 16/28] ARM: entry: Drop argument to asm_irqentry macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-arm-generic-entry-v1-16-b94f451d087b@linaro.org>
References: <20241010-arm-generic-entry-v1-0-b94f451d087b@linaro.org>
In-Reply-To: <20241010-arm-generic-entry-v1-0-b94f451d087b@linaro.org>
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


