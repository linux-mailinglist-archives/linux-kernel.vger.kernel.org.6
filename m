Return-Path: <linux-kernel+bounces-530965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF23A43A85
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 282F9169E92
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC09C26561F;
	Tue, 25 Feb 2025 09:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q3ixEoFq"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A120268FF0
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477331; cv=none; b=jp8rYtQBGf/PExIFFqXUN8fPZRdlplkuHAuBldUNbfUJIjwo2Jd08hmUcGh96aQ12IAMc9kQKJ7YQpN1MjTpRINSAA1z4+9CqHlPo7/FKg5hAmg4LeH4f6LPAenwG1MyQEW1Xf3hRR9MEVPmXM9KjDCuobVI7CvO+0Npc6py0ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477331; c=relaxed/simple;
	bh=Z+Wrfq7Yv7rlYd2Kd88tzeM0tTIuCh/X1bFizJhotL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qeh9qrG1/fooChuyfJwPjEGzeqm0CEP/2api4PIyIC9LhLrrlpI7kAsAXrznTCEwvBb7igw/MznpQbbqzBY2r27TNwSjk8IMqPxN4ok2LnqpioQ3wiz42tjm8T9+R1h4TMKAvS15F0jUlkyRaxFwLYt9mk5IzMFY6Jy+ZPocPtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q3ixEoFq; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5452efeb87aso5417804e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477327; x=1741082127; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B1th+DnYZSKT2go08vz+Ftvr7FlZ7mKXRvbFUdOlbPI=;
        b=Q3ixEoFq1PBTv5iSfg9VfGOnFo1CcL4jEDZZE+OdQrazS22SsJ4sgZCKTa7UtZZC40
         Vq4HXx6nuM9G+e1DkBi4kN/LijtOrnd9hw6ZWLvNq86tvI+ahc9HDFKORxjF/TQWnI16
         YJxlmOncxi9ij4j+RS1I8k5ttNEjgDf15cCUpWjjq6efw00eWpSC5AqgKOS8ap4M8093
         pUy2xYH9yzDLtMNBEjaWao5P7kNV88Fibfy+J2ATQmwjuW2956soQ7GWEMgJKOifH7lB
         ruXL1sQwL6s4zRoWRsnRLvjfJpKaqSHv2R96FG1dik3LPbQKVgRZOxAohgxQe6/k5HQN
         Yu3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477327; x=1741082127;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B1th+DnYZSKT2go08vz+Ftvr7FlZ7mKXRvbFUdOlbPI=;
        b=MePax/yhmhGd9sPyfInw87x4Vri+IWwrYIAsPrzpAAWqJnjBX1YwWAio7H+Ny+pJSJ
         5Fmhv9NnKjlbfUnbXzIhzq9KLtMU/gQAOS0qw7O96BEY7p0MIf2Gl+9TfFDaz3U/Bbyt
         aT9511VK6iVq19bTNBrwopHtUP73prICZxXUTud29ycA045bRbQC11S5+6K8t7fV5HMs
         IIy61MNkw2oH6TRdaTPymX/UAUsUDGNwU3vs5jSGj3r7ghwOeyZ9kDOmIAwc38LcuLtW
         lkQ89CvwgUa4R58OBBRfaj34/uzGi9h6WIEIhS4WGQVOSzDkRi9oFEl5VSKCo7798l/5
         eNZg==
X-Forwarded-Encrypted: i=1; AJvYcCXYEgjYWTAhEsNXfAc+YpDOtYUqUaRPuB6AbfqNuR7h/b7USFfeAAMPZf4kOgkqkXL0+JjZXnyHXoCD1g0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY8GINiYvKmak1lgwBSbnc5O/8c+5O0Jd1xx6nWLn9J6e7uboP
	5nhOewhnC7nMzRx1Y3XHVn/7pzejPHF/3PNLZnFs3AYOEBUkzrf4iWrOinO9BNU=
X-Gm-Gg: ASbGnctVPW1Au2Ipghzg9I5h8mgR+DKide8vP9OySadgh0yAFlf790G/2//J7abghvR
	wo48FRrn/I23YPFNjdv6YnwKcl/gmFdBhRHyL91IMhgpHPtHv+ff8Elb62SaOdRiiQ474Qz5ewL
	GyUlspFlO3vIF9lSPf6FsHX+mY/NPovq1/1avxijE/8sGVAmt0eb55uYDL4vtc9wINUQSdSVM7w
	j9GSHqn4PIuPklXpNUJCe2UTcazVq9ZlkFwgtmY0ngZgvRvsb5t2wCE594TqEL2TFzHo46BvAnB
	uTXo+KeDDFZE3THCTRQFISi5oUHU6wISsHMR
X-Google-Smtp-Source: AGHT+IFJojS9YcdzZoZZ2a4fWY6El/OS+wlvMSzdOOSRtg7jEpLZV7xetDwt8bSZ007hZm6HmPnT8g==
X-Received: by 2002:a05:6512:3b86:b0:545:fad:a747 with SMTP id 2adb3069b0e04-54838ee28e2mr6423382e87.5.1740477327533;
        Tue, 25 Feb 2025 01:55:27 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b261esm132867e87.24.2025.02.25.01.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:55:26 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 10:55:11 +0100
Subject: [PATCH v5 24/31] ARM: entry: Complete syscall and IRQ transition
 to C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-arm-generic-entry-v5-24-2f02313653e5@linaro.org>
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


