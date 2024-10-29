Return-Path: <linux-kernel+bounces-386757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E23839B47A9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 110341C22828
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4255E20CCDB;
	Tue, 29 Oct 2024 10:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="obEJfyzH"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425DA20C494
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730199202; cv=none; b=Vxq1memV8q35uPz24++yqGklcu9VKmkYWyFe6n6dv0kNA9uAnEpahWIFX8zbFYrpMIEpNmRk9B8N0XD68hCLBz0Z3byUl4OoJ4pso6T/u4mSE2xHTuWTEXRULrGEUh82hfBDy12eNNimJOOtDYXWwep0Fz6DhKL7T4yZ5EOiKO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730199202; c=relaxed/simple;
	bh=xji/pcLoEPAUztYWn3ikVISlaHvrDnwTx4BX+5Les5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LwdiUmwc/wRe4o/pO1phJKw421JlXyczMuSXqHLDOGV+X1RQJAqF9BWeLpjPh1yBcIWC8T0DYt9SEh9yLwFVI+4J+EdtjnqYTxF3WMCeUa0kijMsyETnhFf8eTKaLUROrvxk/L28GjxYMd4BCKp8qEkxBGeyJvv0rF2tY3XxmaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=obEJfyzH; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539f0f9ee49so5633150e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730199197; x=1730803997; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hNYBR6ZSh2a4w1mSh6FqJlsw/BqZTd6AKV7VHjOwsQw=;
        b=obEJfyzHD/xjJtjhV4KFQ0QlMRl2/OO48Qy2dYBJC6fOy4fhKRnjtPhwrpY9IilZ8U
         cFTrbYVWzb5U9C8EEjGY16dOLyNkh+NGNC73dEbb7lUTOVrz2Sgkai6UaZtY3MzRQVKP
         9cX+vfmm9x3iNlpckWrV3l/2kJD/7fjFaPOHBhCeoURKihuF9h9KSBtDOejfaBdVdVcc
         rGyhvjY5u+LBth8abxt97tBskem/NFTDxAriWhjgKLs5pth7lAIPRhBfoKpGRBEqLP8V
         HoBgaGuFMu3R3hCXy69Xx4qNfqUqM6XwrRDjF+gzh1Q0EJOjPDKus49PZBtO0RnC9K+l
         0cnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730199197; x=1730803997;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hNYBR6ZSh2a4w1mSh6FqJlsw/BqZTd6AKV7VHjOwsQw=;
        b=gMO+cuyPkp2m2HiNSO+Gh3v84RLCc8FSsBhiNKQBt4ZciwmpkdeDrGJatD6qho8UFw
         HoZokkYP3Z+4NzwoRE5WHMx7WUOKWkuDHKq0CHQ9siA6kgeb7AERadFgfhstMlm8x5Cz
         tieBR5f6vVD0CgmHhRo35qNNkP0te1Xfe4iZ1ouwXmg5jUky9jqlUD4jdI9pkqeMMAFf
         bsi6Ma00W+1oxusibXX5VYrRcs9fpGU7dnVFd2Basz9xYw8jGtEZHjVosK1QZsjjbYbz
         MgNBtA+pswSNVKJPhsx6o78kOME/jKc2ik7dzD+cGa89ZiaM3vQwF3CiQz5LL+iPcOXr
         m56A==
X-Forwarded-Encrypted: i=1; AJvYcCUFcUe0Zw8E9iWFdSIHj0i7uDES5ZFXzaiFZQ+/2pcIe3ae7muW3qNP1qiLtltKa8sGWkc92s1faCCpKRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeKt1a1lJY5K75I1sx26qu50oiR5wms9i6c+l/fpuccd3BxsGM
	tLrCHcMotsqdzq/PeBn8rncExvBiaZdwYGk1mOgygyKpDBDEyeEyREtwChBOvocDR8B5OZym66s
	B
X-Google-Smtp-Source: AGHT+IHwQ1phmvi3b9piBcu57BfZXRkpJE1sq4dj92irBFwN0Et4RdmdKsOnmQgjI8ng74r87rZoaQ==
X-Received: by 2002:a05:6512:3091:b0:539:ea7a:7688 with SMTP id 2adb3069b0e04-53b348b9130mr4630936e87.1.1730199197317;
        Tue, 29 Oct 2024 03:53:17 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e12452fsm1351307e87.73.2024.10.29.03.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:53:16 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 29 Oct 2024 11:52:57 +0100
Subject: [PATCH RFC v2 17/28] ARM: entry: Implement
 syscall_exit_to_user_mode()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-arm-generic-entry-v2-17-573519abef38@linaro.org>
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

Mirroring syscall_enter_from_user_mode() we create the sibling
call syscall_exit_to_user_mode() and start to move some stuff
over from assembly, first the rseq call and the interrupt
disablement.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/include/asm/entry.h   |  1 +
 arch/arm/include/asm/signal.h  |  1 -
 arch/arm/kernel/entry-common.S | 10 ++--------
 arch/arm/kernel/entry.c        |  8 ++++++++
 arch/arm/kernel/signal.c       |  7 -------
 5 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/arch/arm/include/asm/entry.h b/arch/arm/include/asm/entry.h
index e259b074caef..8b8cc9a1eefb 100644
--- a/arch/arm/include/asm/entry.h
+++ b/arch/arm/include/asm/entry.h
@@ -9,6 +9,7 @@ struct pt_regs;
  * to generic entry once they are semantically equivalent.
  */
 long syscall_enter_from_user_mode(struct pt_regs *regs, long);
+void syscall_exit_to_user_mode(struct pt_regs *regs);
 void irqentry_enter_from_user_mode(struct pt_regs *regs);
 void irqentry_exit_to_user_mode(struct pt_regs *regs);
 
diff --git a/arch/arm/include/asm/signal.h b/arch/arm/include/asm/signal.h
index 7acccc96840c..bb753cd3e29f 100644
--- a/arch/arm/include/asm/signal.h
+++ b/arch/arm/include/asm/signal.h
@@ -23,7 +23,6 @@ typedef struct {
 
 #include <asm/sigcontext.h>
 
-void do_rseq_syscall(struct pt_regs *regs);
 void do_work_pending(struct pt_regs *regs, unsigned int thread_flags);
 
 #endif
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index df564388905e..3559e0a9f5e0 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -65,12 +65,9 @@ ret_fast_syscall:
  UNWIND(.fnstart	)
  UNWIND(.cantunwind	)
 	add	sp, sp, #(S_R0 + S_OFF)
-#if IS_ENABLED(CONFIG_DEBUG_RSEQ)
 	/* do_rseq_syscall needs interrupts enabled. */
 	mov	r0, sp				@ 'regs'
-	bl	do_rseq_syscall
-#endif
-	disable_irq_notrace			@ disable interrupts
+	bl	syscall_exit_to_user_mode
 	ldr	r1, [tsk, #TI_FLAGS]		@ re-check for syscall tracing
 	movs	r1, r1, lsl #16
 	beq	no_work_pending
@@ -97,13 +94,10 @@ ENDPROC(ret_fast_syscall)
  * do_work_pending() will update this state if necessary.
  */
 ENTRY(ret_to_user)
-#if IS_ENABLED(CONFIG_DEBUG_RSEQ)
 	/* do_rseq_syscall needs interrupts enabled. */
 	enable_irq_notrace			@ enable interrupts
 	mov	r0, sp				@ 'regs'
-	bl	do_rseq_syscall
-#endif
-	disable_irq_notrace			@ disable interrupts
+	bl	syscall_exit_to_user_mode
 ENTRY(ret_to_user_from_irq)
 	ldr	r1, [tsk, #TI_FLAGS]
 	movs	r1, r1, lsl #16
diff --git a/arch/arm/kernel/entry.c b/arch/arm/kernel/entry.c
index 1973947c7ad7..472338047337 100644
--- a/arch/arm/kernel/entry.c
+++ b/arch/arm/kernel/entry.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <asm/entry.h>
+#include <asm/signal.h>
 #include <linux/context_tracking.h>
 #include <linux/irqflags.h>
+#include <linux/rseq.h>
 
 long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
 {
@@ -14,6 +16,12 @@ long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
 	return syscall;
 }
 
+void syscall_exit_to_user_mode(struct pt_regs *regs)
+{
+	rseq_syscall(regs);
+	local_irq_disable();
+}
+
 noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
 {
 	trace_hardirqs_off();
diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 7b1a16e86b23..03b20637a2e1 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -659,13 +659,6 @@ struct page *get_signal_page(void)
 	return page;
 }
 
-#ifdef CONFIG_DEBUG_RSEQ
-asmlinkage void do_rseq_syscall(struct pt_regs *regs)
-{
-	rseq_syscall(regs);
-}
-#endif
-
 /*
  * Compile-time assertions for siginfo_t offsets. Check NSIG* as well, as
  * changes likely come with new fields that should be added below.

-- 
2.46.2


