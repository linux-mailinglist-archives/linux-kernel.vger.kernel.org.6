Return-Path: <linux-kernel+bounces-386764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 108DB9B47B1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 330F21C2145A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC4E20E334;
	Tue, 29 Oct 2024 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nlf3+Klt"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9733420E30F
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730199213; cv=none; b=ipN1eGIuFMAsen8Ap9yzuVCRDTFPMx121+xJR5d3Dnjj9OsVhLpD+J7/ZIZwDqQvxMaul3ynX5MYg5XW8RyymDfkIglimBXJP3LgXssZP1MC5NHWoXLUkTNKaZGZeDUHnG/Q0X4hjNkbR+stLW3b6xT2wXr/7Elusv01h0f1T2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730199213; c=relaxed/simple;
	bh=pM9plyuaboA4oYUAVGKr/KBZR4661Ija+Nu2nTY/g5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ms5f5TNNBG3eDdv/4hOWxXR1+GK0xA56TXFAAH/wAAA5j8IkRYfgulZ1VHq6a2x2JguYQxFteOhF3uxG2AxJFAuuHTBvTtwxwGmgU+7uvGoozY5z1TUQ0Y8mrD0j3DWHwuYiOTbIWW4SFNNPjmvRUyGRJMvJChV4sFR3mBovf2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nlf3+Klt; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539e3f35268so6247856e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730199210; x=1730804010; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y1Hv1gsrpr1we4HbxlxxqJW/y8rgdVZEtXO9KHxWDAg=;
        b=nlf3+KltBZBGbKJr8f80nly8GrmSdrEGnKa4+uMRFp4zU2F2A00zzBTbqCcsBjvTx3
         lc0AKYSFQGE+fegefqpFkWR33zv3C53EdCxvwdmmeo9DsctZ6brIsWQtMX5W+VjT2opX
         L5I0v0cqGlPIQYFyaw0hYcwd25M9KGZCxezXvKBe9JNIxHZmofKcwjcFZ0r8w0PNVF7T
         8ze/EUmiGxIak2FPlOEvm3RqoVqFVpCx2UVp4fjlGCu8d/GVXPAZm7FH+PVvdGqcQCw+
         l8meUvZUEnGRVWGa+jQYPZnSw9roJPVgpubb4PY+P7lKiEcGT0yzSBOepYJELlaTCf2l
         KtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730199210; x=1730804010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y1Hv1gsrpr1we4HbxlxxqJW/y8rgdVZEtXO9KHxWDAg=;
        b=aUb66hU+b9lTDXjSdOWrzbyt8I0nRHMWUK71pfTuvaU9py1lXK9ktm5wh8PTPNSixs
         A3HPULq9LQPmmpWYdDuqw7EUpgzveUkG8PsgebkPs3+Zw5f7xVFS8NtjpqPw/UNksjwR
         E8XABIMXRCu/EEn4bFxYTaBqGNxWK9/GWG7mcs7Z/13JhGVwk/5v/ftu+3jWhaEd2thL
         Rcxpl99olk7er/GFTF4vFswhB7YDDErtJagwlCKqPnQdYa4ZGYDZPx8hLwpKH1Cs7iO7
         PS8OdywRFAkkiZ6d9igkaHOFiLPNySYS0fD4JPQR/Jh53fB0MgTKRKu8jZuX8ev5YzS1
         p/rg==
X-Forwarded-Encrypted: i=1; AJvYcCXoGLQUPnC/BIaAudDqwKtYfr/SCixBip0PyAa/FlBHV8crDaF9+N5nAQKzJL3MXWhREsgwqmIcPkBZwdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWQslrgvG3Co9m0feFV/aSkiweqe3ATYTZ4Gyr8zISEUprd9kI
	aZOXWr4LM53xWmUeNNT+Gy1Bv5npUdU6LvK57euGxJfBwg4BctL+urvNuUhCbLA=
X-Google-Smtp-Source: AGHT+IESV034VK8PKLncc0cgi0pz3sqYxwxxzlGeXGgL9emDXp4QopwrVEL+WsUUoIebBL3YXi7/Ow==
X-Received: by 2002:a05:6512:1252:b0:53b:1fc6:3cef with SMTP id 2adb3069b0e04-53b3491ccfamr4773281e87.37.1730199209505;
        Tue, 29 Oct 2024 03:53:29 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e12452fsm1351307e87.73.2024.10.29.03.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:53:28 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 29 Oct 2024 11:53:04 +0100
Subject: [PATCH RFC v2 24/28] ARM: entry: Complete syscall and IRQ
 transition to C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-arm-generic-entry-v2-24-573519abef38@linaro.org>
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
index e2ac6d3216b6..6b0f86786a7d 100644
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
index 88a7a699306a..d7fdb9df3331 100644
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
index 03b20637a2e1..a39ee14ec5b7 100644
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
2.46.2


