Return-Path: <linux-kernel+bounces-358895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68452998517
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2389E286CB3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0DE1CB31A;
	Thu, 10 Oct 2024 11:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bewWdoek"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425121C4603
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728560057; cv=none; b=DzYbVxqM2V2jMpqb6LP5jvwcF/eATu49zG0IrtF1QhOpbxuomWLUFLb0NHycNtyeXPmueyvwYcJ8VEUvzL1hnm0dgDvYoGpsmJPsFxaVIYXDPHXWeTjhOsuU7Vw1rOmfGWraT6QhywpFX8w/bs570IQc8V9FPNw9E7cEbPY2Hl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728560057; c=relaxed/simple;
	bh=xji/pcLoEPAUztYWn3ikVISlaHvrDnwTx4BX+5Les5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tn+09vJx7lPA3FThmHHPboo6ZadZ9q6mjw842mb1fY/xPAWvXdfBGZHfpkzKrNtucLKJaxK8RrKQSDheb5AoYUJDxpFJx1YFw2mjhmDi1PzzFRHq/MBudQ254JUnmUmE5yNNYiKu4a+CHXRAq+GWIrC0gM5/f2uUUI7Pn7m833g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bewWdoek; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a993302fa02so131327366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728560053; x=1729164853; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hNYBR6ZSh2a4w1mSh6FqJlsw/BqZTd6AKV7VHjOwsQw=;
        b=bewWdoekEME/CtnGopmLKnTvnOcFa0NWLDJina4kg3ol+2gG49F2GrEZHPhhJd99rV
         76tncRoSvus2Kag4R7+Ci3wTBPTe2akBUu6VzSPgp1PmMJswTiit7NfkZo2RdncNdRh9
         3vyFQVIKR7a6VPV3rKYDTVkUb0rv/kBdm1w6S49gavzxAXlgkMMZKahQ1Iq8Ngk5AI9N
         wJQxEMt7K1OWM/SWc1PLGuX8Lk5M/KiuhL16hN5nXvOF4qvf75rbnCpWVyeTid9xZihk
         H7KEog03HSqU2Kjidl4YpPaVlJKQ5Sb3Pa9FrfTdEAdW4b1SwJ1Q20+mFC2VBPrJMu5N
         dGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728560053; x=1729164853;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hNYBR6ZSh2a4w1mSh6FqJlsw/BqZTd6AKV7VHjOwsQw=;
        b=FflyOzNU7JwTv+glIT2hzyHsKJWeysK7j6sf54b74O/nf7DHdSXIuTS32EILheUGGM
         FzBlJfFqQGKNoAzuXvqjNLsMqtdqtNYpkWcVdKDMxNYTqbO1oYXBYK/pSrgy3zM8wJp+
         VvYczXEgZPJDCbX9ioL8smiBajOcRwFhYpPUMY/E351zj1senZepf5rii+oicXC7mZDw
         a54CtueaVPKXSnua5HkYTgWbHth8howLcBmycWahODvjCUN7cQJqnZWiOwFjek5eriGE
         Yhd+/3xUpzbldY7mGWEQLpip8uu0WavvdeMaFdb7wxcOtuRqyfcce7dRSjOnpTV6UXq3
         ycgw==
X-Forwarded-Encrypted: i=1; AJvYcCUpuCbSWe8i+XGkExpPzF03sFRMxO6x9S6OX/4BvnCgycGx06qw8rqpN7MbQzCfnw7s+gaG3CjM0sRk4C0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs3JYxVDvJVOj0XvgQRdV/g8N50XYPJGwxoNso+WcSasVXMQV9
	oO+qmWyv21yiAx/nSwDp8WE2XdxdY5KhWKKqaFGPoo8SWtC0EZuR0NKhutF5C8c=
X-Google-Smtp-Source: AGHT+IHL5fhjnV7jrHCiVi1KTSPjzJB1MdYFxv8NsvHT8D9zQW+FbMo3EZMj/2II5YwtAlSsYXswMA==
X-Received: by 2002:a17:906:d259:b0:a99:42e7:21f with SMTP id a640c23a62f3a-a998d224f32mr538373366b.37.1728560052587;
        Thu, 10 Oct 2024 04:34:12 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f25406sm77619066b.69.2024.10.10.04.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 04:34:12 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Oct 2024 13:33:55 +0200
Subject: [PATCH RFC 17/28] ARM: entry: Implement
 syscall_exit_to_user_mode()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-arm-generic-entry-v1-17-b94f451d087b@linaro.org>
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


