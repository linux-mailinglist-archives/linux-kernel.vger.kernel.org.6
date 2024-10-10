Return-Path: <linux-kernel+bounces-358900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B8199851E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 425931C238DF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10461CC148;
	Thu, 10 Oct 2024 11:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OLW2V3Dz"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7E41CBEA8
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728560065; cv=none; b=jhYKYL/NEH8ceh2ZQo+sp/HD7iSf0cB8aVQd4FEZoYIbZkcIlXNr1YSM1ERKTUX0H60ad/Q6hkJCsC5ajWHu5JB2/8mJEAjRQrrpMcSddkouWUl8i24qpDRd1/tLwJWeRIkXKNhXKvw/Vazg5SzQCQudh/gnIMAqBVCO4+nUUYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728560065; c=relaxed/simple;
	bh=iM/dQm4bBW4OzU1EedLHO9rK90B09M3TWGeyZRpr9ek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CLp/La3hCM2Ar8GZ9A5+eOOeSuFoVDd48EvNP8kGdKfNKQ5gqvq+fYy9xTipQ8+aWjTT3EL3XFz/wMEoT9aC4u7N5qUE/dVVNf4Ct8CrlmnNKcTyUPZ21YmfrciIyolPuBh4HIWsoxKm3F1IAiTWTfQjCSNKYWvEwIycY8g5ags=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OLW2V3Dz; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a99422c796eso133963566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728560062; x=1729164862; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bckn3YFGIgJxyi6JuzR+D6XCfS8U3/QVQiTYkjNWbHI=;
        b=OLW2V3DzOLhZ3k3Hm4ty64ImRMcgL9oTfjheEv5h/UMFOe6Otv+ImKxFgzlgT/9CJ1
         sKbmd85b+D3a7WO97ar5AsOxD/o6MVS1/SdcJey6fq+DBUhEjc4J9hdCHVf88VsCXW2h
         4H+Ygf18IGO8cDYPDkNGuV94UYsdOK7s+s0vobPNW2QJKGV/HCoQLH6uNBubk+IwQiHn
         2UYOpTXxgNueYZe/D4F0xjrauxziHUGdbVuX1Be1sLm3SqqTkj5Q89VhKTQyzgh2A5vB
         YodDGvblBv2hDW434k01KWOb3cBuiFPM8IfYrecJZTUGN6UQCHQccq7VBx+xkLETZtIz
         YkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728560062; x=1729164862;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bckn3YFGIgJxyi6JuzR+D6XCfS8U3/QVQiTYkjNWbHI=;
        b=I3dX+4za5P9SqndaTLFK+sxODSA9tjdX3bXptCG4eo0sMCdK94PSZvDsKCBLIYH2i9
         bbH8j/LdWgjdx76VGWpZ/KDNkewNWUsrjZml8XQfJqxXhXjSjN724u9tUIH3E3IgVSB9
         Cf0yzIv6icRdAXviVpdh3yYd2GoFx3QbofQjceeBLBBWJpyNUL5rpMb/q/rcxzKF7/sb
         jEvD2f0s274UWQlU3wPF77tbDmLTLU/WN6PADBMES51d4KtLju3iX7Le+KxTZRljmrfl
         /MnzM1c1guTjuz82X/ZfBkydT9r7AKhbSQstsBGStfh3JzcCuksSzn1DqDsRrLKIMNlL
         8KCg==
X-Forwarded-Encrypted: i=1; AJvYcCUF95dW6PFFRHV7s4HngtRhuFCRI6lP5n00A++a50Wu9Op3Ygz+AJvgsqj2R/ilugsJrXPz+cidY8g/PWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1IHOYf6Ka6K01yqnqfkWZvK6T/gZqVy7FmkzkzKCXeiTHyPRY
	tZDnCvnPLOLZTP+tFg2HpFsqMtf28ZDfuWDTMfVrzWRtUvVzxp8WYRJ93LUWV7Q=
X-Google-Smtp-Source: AGHT+IFigyJ/4+OGI1gC8uCP0lgfYv0O7YK2EBVE6+TDguBMfdVneKhgbLHN8YNte2qxqNUZjO00NA==
X-Received: by 2002:a17:907:944d:b0:a99:5baf:12a4 with SMTP id a640c23a62f3a-a999e695b35mr298335366b.17.1728560062133;
        Thu, 10 Oct 2024 04:34:22 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f25406sm77619066b.69.2024.10.10.04.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 04:34:20 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Oct 2024 13:34:01 +0200
Subject: [PATCH RFC 23/28] ARM: entry: Stop exiting syscalls like IRQs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-arm-generic-entry-v1-23-b94f451d087b@linaro.org>
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

The syscalls are issued as software interrupts, and to this point
they were sharing code with the other exception handlers, but
this does not work with generic entry.

Make syscall_exit_to_user_mode do what irqentry_exit_to_user_mode
does at it's tail, and drop the invocations of
irqentry_exit_to_user_mode from the syscall path so that these
are now exception-exclusive.

Split ret_to_user and ret_to_user_from_irq into two distinct
execution paths.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/entry-common.S | 14 ++++++++++++--
 arch/arm/kernel/entry.c        |  4 ++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 5385574c4339..e2ac6d3216b6 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -42,7 +42,6 @@ ret_fast_syscall:
 	/* do_rseq_syscall needs interrupts enabled. */
 	mov	r0, sp				@ 'regs'
 	bl	syscall_exit_to_user_mode
-	asm_irqentry_exit_to_user_mode
 
 #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
 	bl	stackleak_erase_on_task_stack
@@ -62,6 +61,18 @@ ENTRY(ret_to_user)
 	enable_irq_notrace			@ enable interrupts
 	mov	r0, sp				@ 'regs'
 	bl	syscall_exit_to_user_mode
+	ldr	r1, [tsk, #TI_FLAGS]
+	movs	r1, r1, lsl #16
+	beq	1f
+	mov	r0, sp				@ 'regs'
+	bl	do_work_pending
+1:
+#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
+	bl	stackleak_erase_on_task_stack
+#endif
+	restore_user_regs
+ENDPROC(ret_to_user)
+
 ENTRY(ret_to_user_from_irq)
 	ldr	r1, [tsk, #TI_FLAGS]
 	movs	r1, r1, lsl #16
@@ -76,7 +87,6 @@ no_work_pending:
 #endif
 	restore_user_regs
 ENDPROC(ret_to_user_from_irq)
-ENDPROC(ret_to_user)
 
 /*
  * This is how we return from a fork.
diff --git a/arch/arm/kernel/entry.c b/arch/arm/kernel/entry.c
index 0e3960844b94..88a7a699306a 100644
--- a/arch/arm/kernel/entry.c
+++ b/arch/arm/kernel/entry.c
@@ -30,6 +30,10 @@ void syscall_exit_to_user_mode(struct pt_regs *regs)
 	local_irq_disable();
 	if (has_syscall_work(flags))
 		do_work_pending(regs, flags);
+
+	trace_hardirqs_on();
+	/* This context tracking call has inverse naming */
+	user_enter_callable();
 }
 
 noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)

-- 
2.46.2


