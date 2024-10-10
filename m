Return-Path: <linux-kernel+bounces-358901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4789D99851F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF4611F22DD1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1EB1CC174;
	Thu, 10 Oct 2024 11:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uOi84F2v"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C7A1CB53B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728560066; cv=none; b=XyvQhh0tO6c3fcW2TpBcDacgVdTBLuVj1oxst/PBZq4S8yrfEsVXyQjhnDAkfD6OJd71uk2xD0d3w/nhRcRfJ3A2uxAGEzs48DT7RcHdoUWInQ0/+lF41CRm/AiJJv+RY+27tBEHxevEAK27qzBr0uzbG2Vv0e/0dFgXKJrCL2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728560066; c=relaxed/simple;
	bh=pM9plyuaboA4oYUAVGKr/KBZR4661Ija+Nu2nTY/g5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kEOm47htgXtnZrQKSPg61Hl5jZnKq4N3/N0zYH2I6uKbEfI439pcSIrzu+KXNCQyx80WwfY0u4PTW6RlIuPuBvlu05c1hdRKVcv2DpYsHL3m67r2whA02kuHZ+sRuY/fyBsX428Gc9lk38FkSDMGMCLf1IKmO/mdDElzu7Wgi1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uOi84F2v; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9982159d98so132498566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728560063; x=1729164863; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y1Hv1gsrpr1we4HbxlxxqJW/y8rgdVZEtXO9KHxWDAg=;
        b=uOi84F2vjQrzznL/V2mC57q3XXYZwrhxToJ4KRl9Lc4Y7RwM4X0MhB3ssj8Joqkf/4
         V6XLl9u6AfS6zd+Vbm5XZsu3tNteass4YUZ1e6pZ2QnpWKHvenxiULfITtmmRor3XqVS
         vJYbP1pq6iSZM+nScvbR8mPdxqpYMeOQ71rvcWhTdMrKC5Nm+JLDXO1wQdwWe/tJ/ZmY
         8F6WjTkxZJ0AdznZSwx9nsSxmNtm/cVcgSqh94r0tMEZcONX2oaPPjY6GJilpeI0478V
         gOfsBA0mS7A0InSU9W+UbD5MriYQNAd/aB5aK7rMjT+Asc9MJ9rDRoUd4EQmfaxeaWIJ
         Etaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728560063; x=1729164863;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y1Hv1gsrpr1we4HbxlxxqJW/y8rgdVZEtXO9KHxWDAg=;
        b=JaSGR4szJVAqyWE6ARDB705g2u/B+HI+cmLrb9qDUo5eWkHkM9GDGyl1mfGeTFhCer
         5b1Y9yrWWcyixDeBJOupBleoW90x2jqD6KLuFT2x65KJnifAcGqpuS+jegIcuuUpPGAG
         6k2wRNhEgO+r4wVFYeWY4FFgDI3rl4XFe8ikbjra5hTsHvsGt+bYi3LxBN5rjbNv50Mv
         AZt01jbMo734mm7xaAL5/booybQNK7xzlFPvJCflDBL2FoDCOPFbH0AM5QdQYGoGSzhs
         RBn02uI5EaPVxXQfCSNC2J7Cd4+4mQz7V+RxZggoy6YSrDD0+DjUEt+/qoVsv1KsjPJg
         +sPg==
X-Forwarded-Encrypted: i=1; AJvYcCWNYLal/B1wDBFzEvO+M/Y3bFcYUU8PfOXB18zlUYeoDUheoqoXWzgBcr+pXpPQ2xJDs50CXbmJFve4DZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2S7zky0AFjWdodV2LoyGrsGhIgXQuQzyZLJWdN7I0TITsD6ez
	gkIKfmm3BtxWyWf87wIxvQEHoNOGxiiPqZmnsH4mIY2a7zK5MzHEPKkqNfUFhlM=
X-Google-Smtp-Source: AGHT+IHJRHiR4KzKVHqPedhfFs92LdPjHSU6zPVuDKN5K3YQhsffs0YsSzQJndzJhUDXQSRYclCqMA==
X-Received: by 2002:a17:907:e648:b0:a99:5985:bf39 with SMTP id a640c23a62f3a-a998d117e0amr515807466b.13.1728560063234;
        Thu, 10 Oct 2024 04:34:23 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f25406sm77619066b.69.2024.10.10.04.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 04:34:22 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Oct 2024 13:34:02 +0200
Subject: [PATCH RFC 24/28] ARM: entry: Complete syscall and IRQ transition
 to C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-arm-generic-entry-v1-24-b94f451d087b@linaro.org>
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


