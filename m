Return-Path: <linux-kernel+bounces-511027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6CCA324DA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F751888F05
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625512135B7;
	Wed, 12 Feb 2025 11:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wqsq4tfj"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC50D211713
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359414; cv=none; b=meWh4Equ2qiqRt8L4awo6R6PAApkBYpEztYw5Ai95AGDbbIr3i70mH+/odPDrDcrhCzb+bhdfHuB3XV3TDFP4SRvDYCOXSH6UpDueeKB8bjP5ziZ7UhVReNxnoleZKdRq/NyLu6vaQ0mVH30ZklOlWCXRVRPTC9OLdSuRIyYtIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359414; c=relaxed/simple;
	bh=Z+Wrfq7Yv7rlYd2Kd88tzeM0tTIuCh/X1bFizJhotL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JKv7eVhF9MoWJGHprw/5PMRYjsEvehjMohhkvB9VgHiQGwAXhE3t4j5AVegWUsecNxt+E5alCx7mFmKRejGJ+1m5XZ9GJnrnRpo3ntvAM2stxu2x3wJvi2b5zfAcwzJCrN8kT3tYFN2+MFybo7k1oSGe8w6AO8fqf//2XkMdr9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wqsq4tfj; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-308ec50eb3dso33315501fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739359411; x=1739964211; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B1th+DnYZSKT2go08vz+Ftvr7FlZ7mKXRvbFUdOlbPI=;
        b=wqsq4tfjmeD/es38tsVqqGsqkm1YsbFx9WlW9iDS/gGGm3G9SG9zoDHfPSpVJikLo7
         u0xNz2b3CNmpNPVGemGxFOMt6et0UDIvs4m/Tk5uRGJquM3/Zq/ctGnAJOTKUXaj+v2w
         +4dhKrDPAYf8SyCSNKHPjS7jG7KYfyRspqeZtVGN6d+u1MbkOF9joUPo8YfR1AogkogY
         2SHDj+ei6nLZ4XHL05zrTavlSK1qS9ZR9F0AImavP4RA0oFba6qIUbCVH5+mgjgmAfxf
         Rx+fWkNEJqbPSrIIsuHwqONyDvQ4VQIlnv7Sd0QaM3B0vI/aEMrcjr164rH7IGyWejGr
         PhJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739359411; x=1739964211;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B1th+DnYZSKT2go08vz+Ftvr7FlZ7mKXRvbFUdOlbPI=;
        b=YSUCl6uPRQsaYc/1bYzOAQ4+3U1ukinWNQtFXZZ+hrpcVUDEax8VGvRhVUcDApmD/p
         QRg0VOLo7xRnqaVVplBwpMot/fXX7QHYgCrG01wSkpGOKtXkna4ljuEm+0/vg/YmFkYS
         HpWJ1baF9d6ZjC2Wus4y6lWPQ7gzpqOgCpj02f6OzjLdzR4+PdK9AfMG1ErQhn2SvM6m
         wLUR4x0eUr3RPBHPqVbJGQGzms2vSAC1DNfkDPwKapmsw5SV239ohV+eN3WdHewPKIXM
         hyVPWHOOSEC1U2OOBlj6MOdZxcOjr013/O8UkmTdI+ns5hZFphfGotX1OgWNcJtzepdP
         TgPA==
X-Forwarded-Encrypted: i=1; AJvYcCU2O55LsgrLM+Momx6CA2xIiZUEMhTaOss8y84aUa76JECEvvNO2dGOgg1redVyam9B373czH+3/9UCg+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0XkZMcMIvCV27ffjZLsFggiUOnTH8OfoCtgsh+V3S+mTqbQry
	ognACpHhG69lipNzihQMdoJD17lp5vemNCIBXQ1ReCq7YgIMfHLT6u8TVewRqSE=
X-Gm-Gg: ASbGncvy9/IL5MVn6LmHgIo0pq0YfEsQ3dMscKiLGtDi/OwEf2uyxDE/JtknZsPfkkQ
	Wxet8Jc6A0p/RlvIOcYiunr3Q6dScXQyhJ3qiS2qAX/j1OO5kkP0RJQnZnodEe/wsFnnaJYiIUn
	dolNji0Bl/oD5FXTvEY5eFFb0vkGLoF4fWAbzZ3reE6E3en/yQjahilzJHoTjPQ7zS6zRZa2m86
	rz58HFNZ4olRMhT8o0JyXXeUOMabfyJzdr14DDLVx1wNUr5sI5U8M+BUSo15BWg0I4ktF7YvHog
	5G/5qLm1ejZ+nOq6de4xio4ldQ==
X-Google-Smtp-Source: AGHT+IH0PjnzWpFgj3aInaPvyhRs2W2GlVVhEZ9bNbf1pRiBVZ5r7dcyK4H7rv4O7JS5XNCNKpDFKg==
X-Received: by 2002:a2e:a58a:0:b0:308:fd11:7705 with SMTP id 38308e7fff4ca-3090363079amr11272811fa.2.1739359410842;
        Wed, 12 Feb 2025 03:23:30 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307de1a6531sm18310511fa.45.2025.02.12.03.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:23:30 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 12 Feb 2025 12:23:18 +0100
Subject: [PATCH v4 24/31] ARM: entry: Complete syscall and IRQ transition
 to C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-arm-generic-entry-v4-24-a457ff0a61d6@linaro.org>
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

This moves over the last few lines of assembly to C. The
subtle change is that in return to userspace from syscall
(SWI) or interrupt, we need to call do_work_pending()
as soon as the thread flags are != 0, just checking for
work with _TIF_SYSCALL_WORK is not enough (the machine will
freeze if we do that).

This is because do_work_pending() does not just handle
work: it handles _TIF_NEED_RESCHED, _TIF_SIGPENDING,
_TIF_NOTIFY_SIGNAL and _TIF_UPROBE as well.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/entry-common.S | 13 +------------
 arch/arm/kernel/entry.c        | 19 +++++++++++++------
 arch/arm/kernel/signal.c       |  3 +--
 3 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index e2ac6d3216b6828d948d60c424ff95ccdad12331..6b0f86786a7d9e656ecbe8c741f2edbcbafd2915 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -61,12 +61,7 @@ ENTRY(ret_to_user)
 	enable_irq_notrace			@ enable interrupts
 	mov	r0, sp				@ 'regs'
 	bl	syscall_exit_to_user_mode
-	ldr	r1, [tsk, #TI_FLAGS]
-	movs	r1, r1, lsl #16
-	beq	1f
-	mov	r0, sp				@ 'regs'
-	bl	do_work_pending
-1:
+
 #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
 	bl	stackleak_erase_on_task_stack
 #endif
@@ -74,12 +69,6 @@ ENTRY(ret_to_user)
 ENDPROC(ret_to_user)
 
 ENTRY(ret_to_user_from_irq)
-	ldr	r1, [tsk, #TI_FLAGS]
-	movs	r1, r1, lsl #16
-	beq	no_work_pending
-	mov	r0, sp				@ 'regs'
-	bl	do_work_pending
-no_work_pending:
 	asm_irqentry_exit_to_user_mode
 
 #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
diff --git a/arch/arm/kernel/entry.c b/arch/arm/kernel/entry.c
index 88a7a699306ab61153d57333c26266b9161f5466..d7fdb9df33312dd2a914b59512b701748f33b597 100644
--- a/arch/arm/kernel/entry.c
+++ b/arch/arm/kernel/entry.c
@@ -6,11 +6,6 @@
 #include <linux/irqflags.h>
 #include <linux/rseq.h>
 
-static inline bool has_syscall_work(unsigned long flags)
-{
-	return unlikely(flags & _TIF_SYSCALL_WORK);
-}
-
 long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
 {
 	trace_hardirqs_on();
@@ -28,7 +23,11 @@ void syscall_exit_to_user_mode(struct pt_regs *regs)
 
 	rseq_syscall(regs);
 	local_irq_disable();
-	if (has_syscall_work(flags))
+	/*
+	 * It really matters that we check for flags != 0 and not
+	 * just for pending work here!
+	 */
+	if (flags)
 		do_work_pending(regs, flags);
 
 	trace_hardirqs_on();
@@ -45,6 +44,14 @@ noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
 
 noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
 {
+	unsigned long flags = read_thread_flags();
+
+	/*
+	 * It really matters that we check for flags != 0 and not
+	 * just for pending work here!
+	 */
+	if (flags)
+		do_work_pending(regs, flags);
 	trace_hardirqs_on();
 	/* This context tracking call has inverse naming */
 	user_enter_callable();
diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 03b20637a2e1ca6f327223c9132915a97a9c4697..a39ee14ec5b70b3738ecef537709326ef1e8217c 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -598,8 +598,7 @@ static void arch_do_signal_or_restart(struct pt_regs *regs)
 	return;
 }
 
-asmlinkage void
-do_work_pending(struct pt_regs *regs, unsigned int thread_flags)
+void do_work_pending(struct pt_regs *regs, unsigned int thread_flags)
 {
 	/*
 	 * The assembly code enters us with IRQs off, but it hasn't

-- 
2.48.1


