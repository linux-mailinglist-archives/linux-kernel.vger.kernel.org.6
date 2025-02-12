Return-Path: <linux-kernel+bounces-511023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9640A324DC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A73F7A20CD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4551521147C;
	Wed, 12 Feb 2025 11:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BVBKjr2v"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EA42101AD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359410; cv=none; b=R2BKLE04lyVoIPYwd9kEJaifqHLsobEXYgR1chtR7ceIzvJFcO5HokwOyGO+2Vedth0UAKXbL5W3UCYVivWe+CckUAy+jTktRfA5cAUQoF6FV2Ia6dNec8Nw8jpzn5UHE6AHLDk6chvJVuY051IBhKJTeTXoR8+tCL+n1mz8lYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359410; c=relaxed/simple;
	bh=KX7L2dj8FdPfM34FoyLp2Zt4Q5Ia48cTxoohJeqgi1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vu99hIMM8cku5PIcxARH2FHLUU0nsgLejVB2qF2TieNpGAyNqBq+fTXyZ0mkhymyPlsHxRConUYncS24cL4rKmnEuJpP6om7YiWJBHJg6eyWHOunEadCwHIbJ0igCuZUBwzYxalxEbh7wIy4Tcen5MK31WnZeNNm9U3+8hpM164=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BVBKjr2v; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30227c56b11so68281251fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739359407; x=1739964207; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hLPL0cxSmhQjzTuSazqL5ULZpLc4BXlPwpKFYiv7qfk=;
        b=BVBKjr2vpL4iYhA2qBrtfnEGRfTQWdBV1VSflnoHZ6Y1Dh/cvdczGyBfIg0b+jgjHp
         kbRIY7v5xDOMgVaiwwA/FNT0Z9GnQYJRl3yAzs/27mYpPnKI3UtsOg/THnp07G0vwLKe
         E7O/Vp7VKd5wUUPRSNOeI7aFMjBdFz9XhSuM8gNuNaJEzkKDtLHz6jBOc1k1nJthImvx
         XxdfIx13wmEsL+xF4dDKTcSSBss2jEvIf1d6m7dn/mlsBVxZeN6oS6xsYXA+AqIK895b
         yGE7eltk9dQVH01leRK8yV7Hj8fRt0t/RWQhQ6TbN29EL99PB+jLQeYTfzvNKT6v+26S
         Ld2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739359407; x=1739964207;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLPL0cxSmhQjzTuSazqL5ULZpLc4BXlPwpKFYiv7qfk=;
        b=PGsMKfFVjUSGTOeD55PHSPHfYE+jqJSIEPZetyusDFwxhFupni58XTSZx2PLaCFn3X
         kIcDeAQoFfLNJfRX8OlYSxMNfRcqx+JmaLkOxV3LrFYb6WHhlWAYcqmpVvKlJCNwOaVA
         YIIrxwjmRaBWbvx+RfFqmXgW4xbzvq5xEUXEHfFPTjr0j6MHQziMZFQ7okB3ntPScAZo
         qittS9x5EX/qz8SJHwppfFtRkx3ISMTva3AuP5HmQ4rQ5KrLCKfnkPmQmuAjinb0fEf3
         PctGjrYy4ubJ4DbZxAcRjI1z35IKFDX0zuUonToJPCzWLCR7B78oKcnrC2VtURnD9j+V
         m54A==
X-Forwarded-Encrypted: i=1; AJvYcCWo2gHx8sPE2D5JI0SvQ5Gh82lBjSOqs/ZbrIMgtoj5HUcTJ5lGVaJ8Gxco136Kqw1tba03E/4j1iPjGf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz81yBUoJwOvWxTN0chta+r20/fOWwyZLVHAAn5J7jDIuaW1d65
	JWhriwIy5bAvfg4iwTHoALj3B13J8CMdSI2Wq6PxZ3VyaCR3jk13ck9y53xGfQ0=
X-Gm-Gg: ASbGncs4Y+X8l1Oop8NFx69XPzN/kPdZSwwWggiCr0+hOjRxgDqSKVeME0dYmkH+Lk6
	SqTxk2ZlDIh1qNzmMSqjPqMPKi0cETw87xRh2UJFxwknDsvn6u9sNDhwMyG86SFa6HrdUl5ySOh
	If3wIawAAla+hyzT5+39xPEudxQ3Ro5DXx0b5mqY2Y4CG/0BmOA1M3iFSsg5h5f1/PEqoEDoE5Q
	jLw84nIctmOkU+uhWIWS6Ysi31UAtEN2CS3s3br/2fC0gnEjg18yxKj73ifjIsSZwgMjYSsocnx
	NHVqWXwmTf/gR27zGiOS1JDPFA==
X-Google-Smtp-Source: AGHT+IHQpMybVh2UGY3q+b/5gNXwdYp/Tf5GyuWxuwv3bDkab39Fdfp6CaiE28gYUS4P0fFCrwjZ/A==
X-Received: by 2002:a05:651c:1991:b0:2ff:c3a2:f408 with SMTP id 38308e7fff4ca-30904fe65b4mr8430881fa.12.1739359406796;
        Wed, 12 Feb 2025 03:23:26 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307de1a6531sm18310511fa.45.2025.02.12.03.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:23:26 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 12 Feb 2025 12:23:14 +0100
Subject: [PATCH v4 20/31] ARM: entry: Untangle ret_fast_syscall/to_user
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-arm-generic-entry-v4-20-a457ff0a61d6@linaro.org>
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

The return to userspace is a bit hard to follow. To prepare
the ground for further refactorings we rewrite the functions
to ret_fast_syscall and ret_to_user are mostly stand-alone
symbols.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/entry-common.S | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index d27e34d7e97a079d62e7b778cf7cf97c302e4763..ece9215717143427de7572a18a6dbe620a9193e9 100644
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
2.48.1


