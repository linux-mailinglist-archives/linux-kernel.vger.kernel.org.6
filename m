Return-Path: <linux-kernel+bounces-511026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF44A324D9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91B261888D5B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75478212FB3;
	Wed, 12 Feb 2025 11:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wAniZGDW"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2482116E5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359413; cv=none; b=QjvTMKCz3dUozZe4zkquMhndLD2C+zakmkvug3FfOArKtkEDiTTtA3cyGRM04rOnGqzx3CuPYYYRZmGU0Qe0kSH8tdO4P8o1NLcY0OONA2UEQdFa8uMRaosreLCX/DKxFSTlNcQ/P9h9Gx2rQS2btrPbAznM+B2zCqr9Pc3WVDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359413; c=relaxed/simple;
	bh=mJo/s1lXwqzSj2v+NNK3w6LLVHD5ckMvXtVwbrlja0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AcxsbMKd7vVnI9Pa10FdHjATuc3lD10m7e94pe8SeIgoXECQPRWZQSSkq2G4il/TovTIBUysh/a7sxMOSoLoDT0U7PrGg2uL0CNU/UWPQTDD3jfHLQcUmVr/qhN/uNYFMSSQbjVMYaZXdM62uPycNCvWwVN85dHhZnSEa9ROLkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wAniZGDW; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30797730cbdso65113091fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739359410; x=1739964210; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XZE98juq0oGv0Xstj1U7TzgmKhYjLwozMlzxeXVPHlA=;
        b=wAniZGDWX/LzdjrhdU0Z3SZT0JzF+j+rTFksQOaiF6YWP1lDDxr1nBztdtGbHM3G4a
         u/YXlbcKRS6oMQC0P8cWhIZ5LW6sNUWfnE+tsIhyZQQUqeZdN/Fd9FfeJ5mT+iKrVvsH
         JwYMOWueVHCEnILkje73fmhBUTPpC49qiLYVgBDkuGIj48EMTZ4alA4b2UClZLMIuDid
         soRg1AUfmXRqa8c+d45TkKzPaElSWw93sHs/7dzHTJCkXV/+WZtKahRhzuEiM/ZudNeY
         +BIc8Rn+vzpgeETqYpF5lbu1/vNTb6NSyn06LU3FZHa/jyT5YEp7U2HpjLL7k0u08kR0
         qhiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739359410; x=1739964210;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZE98juq0oGv0Xstj1U7TzgmKhYjLwozMlzxeXVPHlA=;
        b=oACG92VckE7w8eDl027HlkRlojwDltmNjfuoqhItp+2PfAI/uiwbyRdxkDZU8SPEmG
         LJVaHDiI5DCNleXeBX4EAAWyiHrH/RGvaFaCps8bhSkEJcby4adzX2NgFZ93CaBZAs6p
         roNXB/oMiTGTOvznv4pzi5cR4Tz4DfI48BPthR7uTA9UFC0quwIG+lwLFs52k0ec+q0j
         7qcEQceYBBvYu/8iJs/iC+hGL1lpVQOteM+oL0aLmO3l3n07Vbx9MW22NtDshYEAi92D
         4VUfWCUpGE6//u7ASDYmhqnK36+/FWZ6P7cbounFxZvbrop1C+LUhfoLmetCgK7jLenJ
         rlKw==
X-Forwarded-Encrypted: i=1; AJvYcCURrKHFKMwrUdXp/o46AHFcR8DYV2oH3jFjB0BfLJkWxtLK+vPrUMPHfJxBlklKJsjq2tznfBHU+yjMKEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9xGdoHiEXL/FPqHDhyQzDAegJ3nKd9mcTfGTOWKLXwyo7laB4
	7+2pE6LVjjhMEhd0UbprAJuHma/5ZsEkoSSDbqS0IdBjvcc3jh+NSFSrGhWOHN8=
X-Gm-Gg: ASbGncswHxKEfDr1GBNfUCv2t3OhvjCMkofAtT5Sb7K2oKVE0pqtc9VN1m7rpiOUXjx
	6YRBRvh8bbZh76oxtSE1TzBUzDiGgONh9oyx1ur+b+u7eq0iUDy1TI2f9pVDBd2zGaF+Mh6xry+
	ES1+Dp4/T9kPoQMQH1gp9mOSezWcHPtghdtrpORpZwFH+L64Qe/MWn2BX4FE7nbIV00KIljleIH
	UBDnB9X8xbdlkDJx1jPwweI+5l5ScRNfze/qqG2/Dzp+Y3yTnRCjVnnqmnPDfVwuko/YkI6SYgw
	AZKoqcUizofpQBgMQ6z49bH6qw==
X-Google-Smtp-Source: AGHT+IHrTlZ5pCNMcRck2dAefduLfG8aeY2J1acA2/5dWt4A8Fi7HvaayN1bzLZYfwPYvudmJmpuSw==
X-Received: by 2002:a2e:be86:0:b0:306:124c:69d5 with SMTP id 38308e7fff4ca-309037615d5mr11191991fa.34.1739359409801;
        Wed, 12 Feb 2025 03:23:29 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307de1a6531sm18310511fa.45.2025.02.12.03.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:23:29 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 12 Feb 2025 12:23:17 +0100
Subject: [PATCH v4 23/31] ARM: entry: Stop exiting syscalls like IRQs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-arm-generic-entry-v4-23-a457ff0a61d6@linaro.org>
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

The syscalls are issued as software interrupts, and to this point
they were sharing code with the other exception handlers, but
this does not work with generic entry.

Make syscall_exit_to_user_mode do what irqentry_exit_to_user_mode
does at it's tail, and drop the invocations of
irqentry_exit_to_user_mode from the syscall path so that these
are now exception-exclusive.

Split ret_to_user and ret_to_user_from_irq into two distinct
execution paths.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/entry-common.S | 14 ++++++++++++--
 arch/arm/kernel/entry.c        |  4 ++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 5385574c4339714f3d8b5ab6894f27466b89f932..e2ac6d3216b6828d948d60c424ff95ccdad12331 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -42,7 +42,6 @@ ret_fast_syscall:
 	/* do_rseq_syscall needs interrupts enabled. */
 	mov	r0, sp				@ 'regs'
 	bl	syscall_exit_to_user_mode
-	asm_irqentry_exit_to_user_mode
 
 #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
 	bl	stackleak_erase_on_task_stack
@@ -62,6 +61,18 @@ ENTRY(ret_to_user)
 	enable_irq_notrace			@ enable interrupts
 	mov	r0, sp				@ 'regs'
 	bl	syscall_exit_to_user_mode
+	ldr	r1, [tsk, #TI_FLAGS]
+	movs	r1, r1, lsl #16
+	beq	1f
+	mov	r0, sp				@ 'regs'
+	bl	do_work_pending
+1:
+#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
+	bl	stackleak_erase_on_task_stack
+#endif
+	restore_user_regs
+ENDPROC(ret_to_user)
+
 ENTRY(ret_to_user_from_irq)
 	ldr	r1, [tsk, #TI_FLAGS]
 	movs	r1, r1, lsl #16
@@ -76,7 +87,6 @@ no_work_pending:
 #endif
 	restore_user_regs
 ENDPROC(ret_to_user_from_irq)
-ENDPROC(ret_to_user)
 
 /*
  * This is how we return from a fork.
diff --git a/arch/arm/kernel/entry.c b/arch/arm/kernel/entry.c
index 0e3960844b94b14325eb00ce7dd791b36c43ac3c..88a7a699306ab61153d57333c26266b9161f5466 100644
--- a/arch/arm/kernel/entry.c
+++ b/arch/arm/kernel/entry.c
@@ -30,6 +30,10 @@ void syscall_exit_to_user_mode(struct pt_regs *regs)
 	local_irq_disable();
 	if (has_syscall_work(flags))
 		do_work_pending(regs, flags);
+
+	trace_hardirqs_on();
+	/* This context tracking call has inverse naming */
+	user_enter_callable();
 }
 
 noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)

-- 
2.48.1


