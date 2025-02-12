Return-Path: <linux-kernel+bounces-511020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40618A324D2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 762FC7A4948
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A148A2101A1;
	Wed, 12 Feb 2025 11:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ivlORzEM"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B840120F089
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359407; cv=none; b=D72vrxyWlR2vONxXOl1gq+LMMdHnB7qjD4lQup2k/swGosZzQSyZEQUwZP3XjAdjzC/aufthn/nQKz5tZZcTNlcqVwlV6sLlOiYUYuL0dfSI4oq/IN9yqg0RTPhhdkMKahX+sZrS1eugIR/jltdMHA84Z7jgMswtQ4R3Hrr+0iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359407; c=relaxed/simple;
	bh=UUr52Es2hedBYSKenm4TK98x7/B8OkpHksvY28zdaBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G3Z/2kop4HKFZTwfEmb5MmEsBSpp13JIF64Jjmq73+TdWmTUgbK5MWFS7gf+gE5Lb0UdSPjDjWjlbnsT/Cf2kiIicKAoXmWc7nzX3KHFM3skoJv+WMnozY3vu6J2Y6bMiMo+wafDpi4xxiuqNceUFws6NYmrOcmiXqRr0wFoZRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ivlORzEM; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30761be8fa7so60302261fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739359404; x=1739964204; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0KMIzffvEsBK43v+gCyDeKdrTwv9xJqaffLfxp2Y9ec=;
        b=ivlORzEMEZ962eHlC+T5859cX98N3j7FqqLcekMI4Rm9XX8zFYzPoYGddHOnESk35B
         pZien9SzkKQfB8SYSW1MLeVXq+K3pIYF4zDmgvW3/HILOz7UMsuwDTwt+DFrkmm2Pyd8
         CYJZyYLDE8QjTOo2dkEQJcLLau0dMF4vZll23dkzSMv+pzBjXsF16f6kQK/ox7jR8bFE
         wiSWOUr+F0qunsVgBWbnR8Sn6cReLf6oxgVJkGsWRvwmJtMB9A9vBjGXnQAEHMXZKYdI
         Igc7LgnDREtp4tr1h7gPfoIidXzKopZFbpWl3NrrgdnsPuMijzgwHGAci5SfjlPK/k1i
         ymvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739359404; x=1739964204;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KMIzffvEsBK43v+gCyDeKdrTwv9xJqaffLfxp2Y9ec=;
        b=up9DZd7oPxZXU9Hw470PjI6/T1m7tGOozZOrE8s+nTS77uTwD+aPx+2LzwLIM1yCst
         IHf/vwp4CNr0qv8XzGnB+AiOcgLWBcaN4daN1eDvEW7Jhxul3mBOyJFT3SbORjb2Krd0
         Z4DXD30JAz+Y9ib5jfstRqZ1Cok7mkrrLC8bSIjyxxnKkN0Gftuf9RREDpAMzej/qOBo
         F7MHuxu++INNTFLRWm2EqdUThBYDh3Pqqt37Co4N6dbmW0HLpzX77AzG3ifiK1Erth6H
         +Ah7uJvnMUq5Ma4MEquoh3Ll8B9d3gCxVGimQFioEBgBFwyHvrD0C7ykNVfib2mLM1Ce
         Z8kA==
X-Forwarded-Encrypted: i=1; AJvYcCX3pNlIzmUY5qlM7T6qJ1lY9nro9HXd4rZ50DB3ofOR3gQIsAHEh7STILSQqmf1mSjNScJKhY1M0ph76m0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLx9AbBd6KQIpHjK6uL8Cm/p8vErLFsy72AePcB1xaY4HStp2R
	IUEbGJovSL9m8a9j1Lw8jt+cbhUd93EQM8sFS7IWYICFgduG72RAhrTe9xptQtg=
X-Gm-Gg: ASbGncvRxPzNzTDH7pyz6wcNGJdYQDDKaNM1KeWiYz0R036srWov8uUACKTub3NhG+6
	l7Psjx4yhOXSsTegiDgcy7qq93vmm2VMQCPL0SJmKsj2ou0w8G1vOuyP3V8rcI2xgstHJRN/AIZ
	QsXDnT4mW5css2kVFm0WdNE1EhtsFsNoBJ3xPiwZcTM/U+R11nBzQlPW48G/u+7YsA99sMh4uB1
	SzOpXpEkwPl3zXxsezY4rjMfeR+n9S6UJKOEozvSBcbQ3CHPqkGW6NSv2AzBqUmDq2qnw0ruh7f
	fShaqJ3eWi2lL7jQ3Au2pR7Uyw==
X-Google-Smtp-Source: AGHT+IF3FbVuyAVSXE6FSKtFUxtJ6fX5M5a69TIwSs1mwLT4jbjl8bopzEgPtqY5QadYENn8IcrBjg==
X-Received: by 2002:a2e:a916:0:b0:308:eb05:9d3e with SMTP id 38308e7fff4ca-309036dc200mr10746881fa.23.1739359403613;
        Wed, 12 Feb 2025 03:23:23 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307de1a6531sm18310511fa.45.2025.02.12.03.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:23:23 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 12 Feb 2025 12:23:11 +0100
Subject: [PATCH v4 17/31] ARM: entry: Implement syscall_exit_to_user_mode()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-arm-generic-entry-v4-17-a457ff0a61d6@linaro.org>
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
index e259b074caef75c7f777b18199623f07bebee5b4..8b8cc9a1eefbd00dd75d4e344576fc184a413768 100644
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
index 7acccc96840c8a17744cc3f2894f19d142aba4fd..bb753cd3e29fc54186543c48b2aee7b221301a37 100644
--- a/arch/arm/include/asm/signal.h
+++ b/arch/arm/include/asm/signal.h
@@ -23,7 +23,6 @@ typedef struct {
 
 #include <asm/sigcontext.h>
 
-void do_rseq_syscall(struct pt_regs *regs);
 void do_work_pending(struct pt_regs *regs, unsigned int thread_flags);
 
 #endif
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index df564388905ee019cd5553f8b37e678da59e3222..3559e0a9f5e079f1af91392bf000d39f9b45906c 100644
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
index 1973947c7ad753fccd694b3ef334fba1326f58b6..47233804733752aef0f2fec6f54badeab18e98d0 100644
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
index 7b1a16e86b236575efdc29cda9b751e8e2a3f64e..03b20637a2e1ca6f327223c9132915a97a9c4697 100644
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
2.48.1


