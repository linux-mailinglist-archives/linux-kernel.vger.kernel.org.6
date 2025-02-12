Return-Path: <linux-kernel+bounces-511018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5064DA324CA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA2201678E8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36ECE20F09F;
	Wed, 12 Feb 2025 11:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OrXCLZvZ"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8364920E706
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359405; cv=none; b=cAp1q2D298w8Vpes90g9haQPm+zVLbyZJXsDWL2zr1dX5nrb2HjuWjqzU8TDfs1EzU4tLH7O0fAufu4JpPB5wBPfjqv/4TfAR+5HD4FSCGDX6svGKa/fLbL7mAs9vQhB1cYFLikL6RJganMeTJX7a39gdAy3eWzQrMPkhfP/VT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359405; c=relaxed/simple;
	bh=QsEh4Kq3Nh4Enz/jpo47A8dhwzkGmSSaMao58QTOPb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UnuX/P430u8LRuACCkpdy24dfsPXwmpo7baApL3hdmFBorSvyjl2Nr+yF7Ep4Gcl8V4RSRpIcaJEDAvGF9kfG5jo3uTDx2MvL9xBdi5H+ZUp92iMTog4ta/Hx/RP2nMAdulv/E+Ky7xESX9W7KB575zz2Y4SHTTlPVegyQRu8JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OrXCLZvZ; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30227c56b11so68280571fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739359402; x=1739964202; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0l4jcdIT0+K6QMNd0VK8RPhMVALn2TkHG1rRCOsPTks=;
        b=OrXCLZvZJs2OjZQT3VZpr2u96WraQLIFlQ0nQHLd7cffxPYZV3/DtfuoHxVJyvd3Gn
         EQ9YRxZwSXWSETIXbLQ4+SNfXuYCpvE0pdmTy7ZN+RbgrNXV6FelVYUfCa+0q5RIJImy
         KeZan0okkaytPyBlqb78BKzhvXsLzFPrkuwBPkHewDbk9597nE/UQc2VVR0v7nrJX4UO
         L3i/pwY5v9Mob275s9eV4rBEdW6g4U3JNyWoR3WN69G0Zv6fTfs4ZXJ0qxT9OmWu+NT6
         FE1iHueCZeMQqcOmegaL5XZMmcuuK9DNO1xEJjbUkpmtwUJi3rrRaDjIBPe4MTx5Pk2O
         pAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739359402; x=1739964202;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0l4jcdIT0+K6QMNd0VK8RPhMVALn2TkHG1rRCOsPTks=;
        b=OXwfF2lgdeNCB/gY+7CG0GTTTJ+Txv9audlxuyQLv1eR4XS9Oxkq5VyyrtFlaegqgy
         qS9jlwQk3nhZc6Kj5As4oB2i2IucYKnAeLIIGKYHidXsk/S4nDNFQAZuO7WxO3ORix/q
         9pAW/F8/u9X1H71WAkr4joJolpAoFdcTagT5cLnRtfKJeZHlG43qErTW40X5vrKp7MW+
         YCkEPeC83fyJuGR86L3NqV+lSCCEPQncqbxadT8YL/V3u/7ot6eUHdapaZku33iN8hvu
         hmxDgkfKoDEFZyKNlxMwiORmZiYNmBwRIgP7cRf5PctlyqA0eoOC+boRr0isesvQxHr+
         mSOw==
X-Forwarded-Encrypted: i=1; AJvYcCWatK9EKpAUz5OeBRcZIsv9qfxnUBPUrTMQIPKp6iix0+dFlVYUIIRNr5hYSRTAh9Z7wE91XGER5t8ymO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEVrquy602jn+jopDtfBrhDgNIea9l/ddCEbuItVi3E/J9VlH0
	iJRgkzbd30yhPxsl6fVFi2izDHCbTTDjmrmPLDeBsbPWx6EXwaoVoJ/I7A3qQwM=
X-Gm-Gg: ASbGncsp51afzJ7VyDphkmLO7qHIb7Nk021hxAuI1RGDK+CBNa+n/RLbT7swRyoUL6W
	olbz8k++e0y6k6fdgfMdf2w1qt+IbjsQdfUEyu3MSTQW6RMb1mLXkHF5IE+jBL5wG4XILB/jwzE
	FDXR9QGIGrIZc4wj4wHW7fd+Ga1zLT3orRSW9Kb0RQCSQEpxoqYfYIouaatEb7bGZFCNugJtBtH
	vpGldA4FL078b4GHppSc47qT726plxQUpo/5uh+e1Hv7s7OUe0a6VPm9ZOJ8R3k7q58rqAZaYw1
	ZEsYXSew8GEg2+j4y2uOuMDFdw==
X-Google-Smtp-Source: AGHT+IE0MOK5A4Hgs6x7f54TlSM9Gy9GRZ5jq57qtCi8sQldGDST9iVi2gYFwCJT4+05NjX+kZxcDQ==
X-Received: by 2002:a2e:a909:0:b0:307:e302:a34 with SMTP id 38308e7fff4ca-3090500af87mr9903901fa.20.1739359401620;
        Wed, 12 Feb 2025 03:23:21 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307de1a6531sm18310511fa.45.2025.02.12.03.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:23:21 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 12 Feb 2025 12:23:09 +0100
Subject: [PATCH v4 15/31] ARM: entry: Separate call path for syscall SWI
 entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-arm-generic-entry-v4-15-a457ff0a61d6@linaro.org>
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
index e26f369375ca3cf762f92fb499657a666b223ca2..e259b074caef75c7f777b18199623f07bebee5b4 100644
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
index c71110126fc105fc6ac2d6cb0f5f399b4c8b1548..6edf362ab1e1035dafebf6fb7c55db71462c1eae 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -403,14 +403,6 @@ ENDPROC(__fiq_abt)
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
@@ -430,7 +422,7 @@ ENDPROC(__fiq_abt)
 	.align	5
 __dabt_usr:
 	usr_entry uaccess=0
-	usr_entry_enter
+	asm_irqentry_enter_from_user_mode save = 0
 	kuser_cmpxchg_check
 	mov	r2, sp
 	dabt_helper
@@ -441,7 +433,7 @@ ENDPROC(__dabt_usr)
 	.align	5
 __irq_usr:
 	usr_entry
-	usr_entry_enter
+	asm_irqentry_enter_from_user_mode save = 0
 	kuser_cmpxchg_check
 	irq_handler from_user=1
 	get_thread_info tsk
@@ -455,7 +447,7 @@ ENDPROC(__irq_usr)
 	.align	5
 __und_usr:
 	usr_entry uaccess=0
-	usr_entry_enter
+	asm_irqentry_enter_from_user_mode save = 0
 
 	@ IRQs must be enabled before attempting to read the instruction from
 	@ user space since that could cause a page/translation fault if the
@@ -480,7 +472,7 @@ ENDPROC(__und_usr)
 	.align	5
 __pabt_usr:
 	usr_entry
-	usr_entry_enter
+	asm_irqentry_enter_from_user_mode save = 0
 	mov	r2, sp				@ regs
 	pabt_helper
  UNWIND(.fnend		)
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index ff1dd3169346f3770cad6b7e218f5d74ffc646fe..14b2495cae3c2f95b0dfecd849b4e16ec143dbe9 100644
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
index 8b2e8ea66c1376759d6c0c14aad8728895b3ff1e..1973947c7ad753fccd694b3ef334fba1326f58b6 100644
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
2.48.1


