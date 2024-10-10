Return-Path: <linux-kernel+bounces-358897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FE699851A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D281C2859A5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5821CB51C;
	Thu, 10 Oct 2024 11:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SXwnFi0u"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02931C460D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728560060; cv=none; b=hN5LRF5lQAw4Ph0wXHSL/XFk484d1v9WG1wUqwUWNqvH2caTFigcrwVbag+7gSayYs58maD8T1AF71GonCh8l/yxymsDHFQ9U7Va02b/FUpioKZy6PSthyT+6YyJo+RPvIx+1jQNing1s5WGDo12yXh53x1WNgrg2VdcNH0FQt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728560060; c=relaxed/simple;
	bh=Qsa08BehM4uts93sI8Y9iubQvhsHZG2Sg6J31UXi3tM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=prHWxGYNq5DYtrgbonmIlIjAEQiOUdW2dDPdInDSm6NwuXuLp3mS0iQ1qfJEl0Y/HO2e2ZHAOC6EXgdf3tsWiD2hjGtSDu8MLnRunl13+UjPqQ6k6zZWdOYjEa8Q6wJ9oChBr2CAzn5eEDtnQTg6xj0F2j2NPp7Vi8Ujv+s7n3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SXwnFi0u; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9951fba3b4so129047766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728560055; x=1729164855; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4s7yTStZNPQghs61B8MN+wTLfopUv2dudvbP9oK+hzk=;
        b=SXwnFi0uylzXjvpfj8+NWPiSuc17ow80y/xIqTJ8WKz3N/JuLvOoHJfhBIsXQPo0Yr
         8NZp1SrfXJzaO3uhfvCFyikG9iikcZC7eEgfJ8LV9rtJAbQYtwCBSvcc8+HNYTZfegE6
         6Zy4NzeP1955inT1p8J+StMdbjQcbHKnHIUmf6ph/AZkzCNBVMF3TfxQe+1ipnyPAAwx
         CoNV8qxXP//ED7b2NBDAO4a84XHWw4a8ZGqTgWhB035FBQVmi+q84MaAzFXusG1Ynv7g
         05QprQRikL/ElRuc5lDGS76VgHJOCIp3O4+hCiQO3rainf/nidpsT011Gjhvol0QOxTq
         TDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728560055; x=1729164855;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4s7yTStZNPQghs61B8MN+wTLfopUv2dudvbP9oK+hzk=;
        b=Rdagh9IZ5mQ/tH1SlzKurLYt2zzvsMS4RyZ+9Dx4sJKGWhxnyRH0QovyoIlFzWJCoz
         EM66VXoKzZj92lIG1OzjNEb33nf/ssYfazYgcHK0ZBwP7PiULJVpDLksKnf3Er2cRb8V
         UrQYGoC1EZE++R/5lvESzoknE4opsxanBcGwBtt3XBU8waPO+HXEBs86NPd9dVcu/2TW
         eP6AIhAg0UvYzn0UkiQb29wQxquV06v3Fvu4jPHSPk6Yr4sqQC6LVH/QtvKb+Lee8qGj
         jFBF6C1cGK+C43OOFIy8/GchSgIsOyNPxlCSbj3yECkXEd/24B+9USMo+9i6Mzslm+/W
         0vgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+GpgL/c0FI3yO+E4nTfzaF0PXRZTl0cJGECXLpZaYITRCH1fnHp8C0R4sQkF8AFerNowaLThFNyiNpMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfopxuvwj7yoKrvEa50ZcNkeZ09mohI9wGo1WoMU9H/DclNAO1
	vT+lIxLwfIHQcQUydU3Gw+Jz6dFvCgOE55Z3zg9FQIYoCQzwq0InFUiiDgQmwww=
X-Google-Smtp-Source: AGHT+IG4ChkXSJOOJVtKgVJOl19DQS8X/tzmbK2e58/g2XwPHPYY2o/CB6c01S2WX4Js3ghS2dg9FA==
X-Received: by 2002:a17:907:8688:b0:a99:76a4:7052 with SMTP id a640c23a62f3a-a998d34db43mr548587466b.65.1728560054756;
        Thu, 10 Oct 2024 04:34:14 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f25406sm77619066b.69.2024.10.10.04.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 04:34:14 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Oct 2024 13:33:57 +0200
Subject: [PATCH RFC 19/28] ARM: entry: Remove fast and offset register
 restore
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-arm-generic-entry-v1-19-b94f451d087b@linaro.org>
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
index 09ce1be1f677..bd468d58dc02 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -496,7 +496,7 @@ __fiq_usr:
 	mov	r0, sp				@ struct pt_regs *regs
 	bl	handle_fiq_as_nmi
 	get_thread_info tsk
-	restore_user_regs fast = 0, offset = 0
+	restore_user_regs
  UNWIND(.fnend		)
 ENDPROC(__fiq_usr)
 
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index dddbd6ba1eb9..d27e34d7e97a 100644
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
index 50c0b55adc74..51c7f93c1ded 100644
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
2.46.2


