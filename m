Return-Path: <linux-kernel+bounces-358892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 040AA998514
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 754041F262DB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130F61BE23D;
	Thu, 10 Oct 2024 11:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UWLHPC7X"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975741C3F2C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728560051; cv=none; b=I8Hv2fAgTTQ63awBAfsEHDPa+HuhPwDC6KfkqJSpjjFbEdteskt5FAOwO5jvpZNyJt+CY5hgYPgi1rcC4KET4Fz0eTRABact1b/xfZ7rpVJMzEAGA5i7BjdBIRHWck9sYhplvQlAl8Sps5MvqROYPizuDiXUtWH2k+loPuLVk9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728560051; c=relaxed/simple;
	bh=GNeY2LQCUhc09WZjjbVfkXZmlZISRGueBzk8RTdV3Hg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r0kQtzudiH2NnB8tdMDtxcqM45dwF6rF6hjgVUbY6GpYZrtY2rpWTk7+cwYFsmk3lwfyCMuRuogWsL9ErLCrsr3c/GB3UIpX+toq1DpxgVVaIZh+BJC9Y/L8MdMLsOD8iG8SuC0aF04xeYZilbwr4D4ATtAkh+1pxAalyZ5/MIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UWLHPC7X; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a993302fa02so131315666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728560048; x=1729164848; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qPx4kMCDrheeY8xWYJ0qE47ahtpfJ0dLdCDyA5qyaAo=;
        b=UWLHPC7XwJaA5c9ffiQ0UdHdk5k7PbVLi6YynewmuHz/MzAZ+04MeB743dXFAfeQS+
         mkD2XvY8x1EoMf5Oo8PeozYXQvPbdCoB+4+9jy88h1gn1TnXHGCgbTmqE8hbx4PZwtoL
         y4kjhyNMP0d5oRTt5kxrvMTHU73I1/TjpeH6t1uQ427ufL5Mv7Vwaw9iePFfdmJA62nv
         JE8UrAc2rj/51p9arHDsUNFSO12EtX8T6Sq/2tRRjugdN5pB20IClZZoAbFhM9yD3uxf
         aN94jTIzz3djqiBj/umTCOQMMizkt5MdQqST3IIB9RyN8Y2pTMPassXTjx4gpUsuULb7
         wgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728560048; x=1729164848;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPx4kMCDrheeY8xWYJ0qE47ahtpfJ0dLdCDyA5qyaAo=;
        b=I2VnbbPFptCdi9ZuvO0JRtmg57oYJoK0sBvXg0+lOtgtabaqUEUZwG5OeuNl38c/Tm
         xvtXp3B+UzyBsFCq0vN7RGP4teREU+l+HvRwclJarRxOHqFCqkg9oTmC4ipHc6ZZ/Xu6
         SwbsXqb2PTfT4Al83bLVrKTJnJRuUk+WC+YtyK8qV88v872FfM2C5qx4SHpnKwTv6rQK
         agOQUbawyIDC8VSevzkL0zBwUCdEQKi0PiGwkAegdrD5bNtanEAf/fezGUNO+v/A7GJO
         fKyeAiFYf5dWuIytvtZCzJSzLTRdY+yvVDK136g5StT6yZkMVHZHlr8C569hTew9dQeD
         VJSA==
X-Forwarded-Encrypted: i=1; AJvYcCV6ZGHFZfrEVqJDlv9xC8xhwRXHnjag4rfNj/3PWD5geZpgV7gApkVE7oPJUJyXf6l7vbv4ChDKCEolqP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YynuUSUEK5Y6rq2ELttubeuGU4eSEK8Tn5JxyiRyepsmkqfVM9o
	WYgkeWl3uNjSKMlTzNnYPdr70qNHkTV8+zfVRL+4kvLPzsIEY3LoXkTYlizwiKo=
X-Google-Smtp-Source: AGHT+IEPVi1mk+/SGvuJTkVQs54hGFUGD5KsWVr2ppK+fAaiWlRn48WKs9o66a2GQRtPuO9/UgXQ1w==
X-Received: by 2002:a17:907:7da0:b0:a99:4e17:cdf2 with SMTP id a640c23a62f3a-a998d329a02mr518892266b.46.1728560047912;
        Thu, 10 Oct 2024 04:34:07 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f25406sm77619066b.69.2024.10.10.04.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 04:34:07 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Oct 2024 13:33:53 +0200
Subject: [PATCH RFC 15/28] ARM: entry: Separate call path for syscall SWI
 entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-arm-generic-entry-v1-15-b94f451d087b@linaro.org>
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


