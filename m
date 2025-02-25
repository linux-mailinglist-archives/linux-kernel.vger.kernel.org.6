Return-Path: <linux-kernel+bounces-530958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 909D8A43A73
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 836F83A797F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30399268694;
	Tue, 25 Feb 2025 09:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LIb8C4q0"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8F82627F5
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477323; cv=none; b=unhKDDP2MwI/iIcHdIGbsreH3ml64beA/1PU/4qyPKU426vHkogPBBhsefhcn9UDyAkJ4mp6ppD2HeurOvxfQmyCn/6g+O8+N8GUKzrsWJ4AV399Q/WkWAYTxosknS0jiVL8RtvHDk7wdPwnguWNYKFbHJEC+esA8ChmVSZzDYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477323; c=relaxed/simple;
	bh=UUr52Es2hedBYSKenm4TK98x7/B8OkpHksvY28zdaBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bnYgj9KUu9iYoHV0O2EmUcj6Bpe/7yRc9h/YyVKISDplF2Ko1YAmFitubi4q4SNmqsEk+/GbSkjFJn0c717u9TWteZ8Q8K1VTyPYjdHVyK4OL9QIFWiGY/YI8CbRpXI1B0nhho9enYh1/RPccAuOe3Gi3zPeVOWKjawwLpl3xMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LIb8C4q0; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5452e6f2999so5747385e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477320; x=1741082120; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0KMIzffvEsBK43v+gCyDeKdrTwv9xJqaffLfxp2Y9ec=;
        b=LIb8C4q0Gajz3qHF6ghedX+eOT6ZNIAJBDBBj1qa+MRxrW9eWZV0TE1VNPVBYJPpAt
         T6Dvc77iQ/uoSw0pNrFrwPG8i66EvADsvVhn33MOpJ3cXrDSGWcmiVhaRvokaNBvc2eA
         OxCLF2tPZ/z8qxKzYmCUtFn7410ZNPOJJjPLQ47UCeITFvCEefeTnJ9Gmi3N7PJl2dQN
         qhAnqNyxq3A3RoDuCQmGEbSmgMpJElE4ee4dGtAin+Gt/f2mADrGMurrvXuUElj8p7+q
         s0qjWggB/Bgv0hsWThg6EVWVWiaAe6LnGxsFwHpUX6A+SLQM1NymGRyJO6VUt3/cnW6N
         8baA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477320; x=1741082120;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KMIzffvEsBK43v+gCyDeKdrTwv9xJqaffLfxp2Y9ec=;
        b=qvLuJ1cpKWTm3zTxsCCasea+TeWk9ugalnYKqe4MIxt77sEvmVZg72ry0/WOMu966j
         v1qinNrjP6Plh7Mk/QBd5mki0lFfgwfvuNXq/4gxgArr0odoynUFEf7xULypaBNIcS1p
         EflOmV8WVVAKaK0DfsFRvZI3q5Q+JVMtKb1Fnz7hC9l7Wq2kl2KCx7qZmRsMLPLyU27e
         1DRSVa1g3lBQPgS6q1wLLXX6EEQPbIhsNSJ+wKwjQ0VZVKInqcXyoCKCELpS1R+0K0Cg
         JUw/WFI1IJdnej95ltJ0Fo+MIXE5nzQVi6gfFMsJj5cpkpt7MHvowe7n0wddSKSXtziz
         5yAA==
X-Forwarded-Encrypted: i=1; AJvYcCVqR9FErJxKYFiuElb8o2UMLuBc9fN6O56Y8vTVok0Pqs8gT9pMJYCwImBH2Q0E1Uqs8umUavahxc36o/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBPK+x485QFmmUKOPYl9d6/jF6OmWslrEPrPFbcF51byYXH1Rq
	x7bUyocLk47FhoFUAgZDk8HcZt/gfd/OgQBjgw6AkjnUSW0/4QzxPh4mqTL2yvM=
X-Gm-Gg: ASbGncsqz8oV37VJ8CoBsuSoz003cHfeBTOAHl6u+DBTWW6kob0Wp+KEGRW0g7AdGxg
	ttvQn8rVGa7JbNQWRkJTcR7+UAQK+nHhYjr/n3xAbkEmvGrqn/Om3ItzVTkhpF4zGUqyhGjXtVj
	T53PtMZCBJQeEqjBTMLEUW+mQSI5pUh8JK7fJqgiMZm1BCGZKR2Ljgo6mNf8/7N+ATku/hLSmvo
	+kXa2sKuMdzcqICJwdEy6RekaPenT2lmYLgntTV5q1qdd7TeEhypA+lz4feKioSnviZXc8xIWdS
	SIWpOTjMCtYXI6yy/kxY3aCc1GU6Qo8nWQU8
X-Google-Smtp-Source: AGHT+IFQbbLnCCyj6FgNCwGxulDwvPP6jZb6g7kcFOt1Jz/gH3uLa0VdebmCRshYEfTm6zK7LqNLZQ==
X-Received: by 2002:a05:6512:6d0:b0:545:93b:30c3 with SMTP id 2adb3069b0e04-548510cf94emr1053860e87.18.1740477319703;
        Tue, 25 Feb 2025 01:55:19 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b261esm132867e87.24.2025.02.25.01.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:55:19 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 10:55:04 +0100
Subject: [PATCH v5 17/31] ARM: entry: Implement syscall_exit_to_user_mode()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-arm-generic-entry-v5-17-2f02313653e5@linaro.org>
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


