Return-Path: <linux-kernel+bounces-386760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FF29B47AD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84E531C22930
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BD320E00A;
	Tue, 29 Oct 2024 10:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wqeYGmZh"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E7F208990
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730199206; cv=none; b=BLHh2aI05Y6UH6sm99iqfUaNuit7ao6V92Tu9GN+n53PNu1xSFXmPHohXBBVwTRGnHJqp1fn+KUTnM8xlt/tI8oXMEGkz2fCyCHPSJWC1iseqwV4lLywoHxfAFPoSfWS2Hc0vl1Us7+1amUTBNr65ploPTOQnB/SJmiLnoiISoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730199206; c=relaxed/simple;
	bh=U7+/gc2e2KuWRZx3ryccMQNU5ZCqQa+rXx8yeFy3Nh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NjRCI0kWhaG3bHX3CS04ibwwv6NV6qznBHNUIg8QledDbEI7Dzr1HJrzG0e3Zu6Fw/jH/N4y4b9hNClQ4gT0ZAeXnq0NrGGCENX+uwesj0hqlgNU/1yL4DCPdicG44MFlgz9YorAEYvih5aC/lsZeE2kTtnsvJT0g0qrjxasLtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wqeYGmZh; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539f0f9ee49so5633242e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730199203; x=1730804003; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hWWOf9VRKfs2/tqyRJcdO75r8/gLb8BcoV6DE9Ay3YY=;
        b=wqeYGmZhkBmx+JKiBU/6fwO2+uOEUnY1Wglfg860BHfqB4FAB+FTdrvr7mVLdA9mFM
         kKQtTBF3kj35Sd31qLKKpfDGm2FRBTTdG0bAUvPLo9n3+3U6NnnS447NKOhAmuODb3qR
         xHNKd4WS1aicOLm16LEl4viXxHTddIgPGjsP9WphwHtHYKAizldAi8j9xRtxLkcD6OT9
         oDFJpgpADLytklgN04/oRtwhSeGQHtPnKRkfnXzqtIXQPVWQlaf2fpdJ4uZmoR+ld/fE
         YGL+gLOsePMX2MKnEJ4klFVOmCg8QZzVNb2Gf6Cgv94yIVfjhXLsI0adaOW88tVCOUkl
         0xog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730199203; x=1730804003;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hWWOf9VRKfs2/tqyRJcdO75r8/gLb8BcoV6DE9Ay3YY=;
        b=kGZzKUFOlqto9hqwrxUeNdDnqLHrLVAv5yJaTzNm4w+Db8lNBfT97Ss7mKqW3bhSFG
         8ebvr3EWW9kdAhF66sCCVezn4zz1v07+Gmf2xRoOWosOybFmzKxRB19wouUJNYQi+pzp
         VAdomGYqUWX8f4oHpNVchrSEX89ErMd3vwqD3o++j6HaAQQVJVP1fdQTCRnzMkoaMjso
         osvZFRr1HzJnse71e9uOz+K/d9nAru6uCYkzwc3rbzjNhj+6oQ1DfjucwwWfYUImUAIn
         mZCXdBwUm9ZQfEXf0oLXMA08e3BcwFqhKcxwQhfv4tKJWciiNSssdCFAFR4ZxgrRL/7e
         AsqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq26kbOcC+IjkzdQSUPdFNd9o1YBzJHvwzxlgAorzk/YMQYnHlSlFqvw/qdB0bhH86YoTmNzLWpCoGDac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7eeICny75YQj0YKAwRHESIcDVPjz/oZBn6ZDUpd6LMtgzglqb
	B6BZghJ5xY/Povu/qZ05lnZc1rNvoqnmntG7HXiK71LwDELuKbXOqJdj6E+5RPA=
X-Google-Smtp-Source: AGHT+IGYokcfvTEQUjshtOgXGdmRS2U3eH+gIN/8bmikMfR0LXUeM0vzogR0GFUwOUcsWs1HgXxhYQ==
X-Received: by 2002:a05:6512:3084:b0:539:fed8:321 with SMTP id 2adb3069b0e04-53b34a31cdbmr4939668e87.51.1730199202995;
        Tue, 29 Oct 2024 03:53:22 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e12452fsm1351307e87.73.2024.10.29.03.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:53:21 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 29 Oct 2024 11:53:00 +0100
Subject: [PATCH RFC v2 20/28] ARM: entry: Untangle ret_fast_syscall/to_user
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-arm-generic-entry-v2-20-573519abef38@linaro.org>
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

The return to userspace is a bit hard to follow. To prepare
the ground for further refactorings we rewrite the functions
to ret_fast_syscall and ret_to_user are mostly stand-alone
symbols.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/entry-common.S | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index d27e34d7e97a..ece921571714 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -44,20 +44,23 @@ ret_fast_syscall:
 	bl	syscall_exit_to_user_mode
 	ldr	r1, [tsk, #TI_FLAGS]		@ re-check for syscall tracing
 	movs	r1, r1, lsl #16
-	beq	no_work_pending
- UNWIND(.fnend		)
-ENDPROC(ret_fast_syscall)
-
-	/* Slower path - fall through to work_pending */
+	beq	2f
 
 	tst	r1, #_TIF_SYSCALL_WORK
-	beq	slow_work_pending
+	beq	1f
+
 	b	ret_to_user
 
-slow_work_pending:
-	mov	r0, sp				@ 'regs'
+1:	mov	r0, sp				@ 'regs'
 	bl	do_work_pending
-	b	no_work_pending
+
+2:	asm_irqentry_exit_to_user_mode
+
+#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
+	bl	stackleak_erase_on_task_stack
+#endif
+	restore_user_regs
+ UNWIND(.fnend		)
 ENDPROC(ret_fast_syscall)
 
 /*
@@ -74,7 +77,9 @@ ENTRY(ret_to_user)
 ENTRY(ret_to_user_from_irq)
 	ldr	r1, [tsk, #TI_FLAGS]
 	movs	r1, r1, lsl #16
-	bne	slow_work_pending
+	beq	no_work_pending
+	mov	r0, sp				@ 'regs'
+	bl	do_work_pending
 no_work_pending:
 	asm_irqentry_exit_to_user_mode
 

-- 
2.46.2


