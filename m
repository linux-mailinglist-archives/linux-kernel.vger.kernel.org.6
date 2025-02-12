Return-Path: <linux-kernel+bounces-511021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F88AA324D7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E4667A498E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A63210F6B;
	Wed, 12 Feb 2025 11:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xlyGAHVi"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FD320FA94
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359408; cv=none; b=mgGSLUXMvGMnrvnwfDf4gSqsY3R9WyAGajL7THVacFJDoMNq1JNK1cWwbf9xUXM5qX8cXlhjhhwicfaP4YM+RaX0MhFgtpIwwmUa1xgKksOdRyCmlQpAW3amXLUP4YAe8tXa7dmAru3Hya5Czq8xaD6VCCjWEBrDOYWcMJ1mRiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359408; c=relaxed/simple;
	bh=6f7zBuKhRiAQ/x1F76wPwIaqznd7DT1I5iskhJXpWuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C2aVLb7fpEbyCMYxxh5gHqtzoL/qgiuF38bvj3azGGoIXj60xV9V5ApfnKl4ZxKkyQ0bUf31779l1gEbyrWBkGfHETOmqkIbULAjABrclxlmca99up50vn1SlLVaW8uFmc/jNoMRuwtK1CupBLlk+q70+vD3uPNVy+OlcfzrpiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xlyGAHVi; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30613802a04so65149971fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739359405; x=1739964205; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kElQgdyrfkPgzICs9KEd5Is5KMXf1IbQ9ph46r/iv/o=;
        b=xlyGAHVimpGuIsMIPGlMwWCxEs0JS3fiFnDwp0lCzel/o83+iC4ZO0yDZgjEnHHgqU
         gUIzixHvcYVyEwINDfZ4VruK4A5z8tvdDKakBk20CxqkrU5S11ZNboOzFaT0ZPE5hgEK
         fNKNBGCrJGdYnuQLCch1aFEl9qAzgRW1VC/VIG7vLlHp9UnxrUJBatQbDlsjJbrNxg5y
         xbg+KUYiBEHYEMXMr0H/eZYycbJ5NN2sgZho+fTjpTsV7fxjYTEn9lW04h0vtjtZMX2d
         0RUXgYP7/IEjHvWv+U6GLUXXIO4yr1wkjKHOYEaNE+mKZwHhYAWDX1rxzIGSV+BjeCd9
         DGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739359405; x=1739964205;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kElQgdyrfkPgzICs9KEd5Is5KMXf1IbQ9ph46r/iv/o=;
        b=EVwLJMgKJWVSkZaVhIEoHn1Eikfm/tP/4c1rOGhnKjdVT7bOROoxdys7YNfNISt3ik
         NY2T0dMKPRAb5yyp6YGpRwHI3WaRedeSDiFotX2tnkzh3Sa5uBrR24WYTN59D2Jsgpb1
         MC+g6DhqleSd+VprKK7OvErWiUFeCqYZ+/ht3OkQAk5BHIuJ2YV3xbMrmEAQqBTsAF85
         RwbK2f5fKIV1oxau0c/QgSe0Tj9PHQZ3US0QiBibRhE2+tnCqiEuT1spKpKgtaCL38HI
         Q2z1rwStKlAk8aTClN4ICyxMuV5y+qxk+fQMpA+e/TzNsAE7ZuxOwqQAJ9ApAZUEOS+B
         5tDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBq/43qH3jAcmDmBmHMewh48Nb1Jv5KPSVYCGdImz2uYZgZNSMoF2rynYJBvb0GmRgXgNL3Ch7ogMxzf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFKknJr0FqwuAdvVSVBYFc7WXW8m59z2WhgfHOpdFYg/ZnkLZn
	SIKPklVIzXvinG5mzBRaJ4s+y4qTROQ2xDRyjo5aNqGOZLHMGqbDSNuUiCPhi0E=
X-Gm-Gg: ASbGnctbD5HMBqmPPGwz5ZuXyftpaiUNDIzK8ewJika7QFCiA8B6fpJin9PzHLULmAq
	Jclwh0k8KghRv2ro3b3XysFZ2ufetyKMt+/wBUI1iYs1PY34DMX/txy5cGAU+LVVrQ6fyShBBeW
	iay0Ij6RN+C75YylMYTlrwjz+FuGUlu2lVwPX6gI3OqhAQ37s7EzgRC2DOBIbHeaTmg7/v98fHf
	YU0UTm4upaXw29STDT3UZfq3GCcejMCOhXbAK1eM3XIOg/0q8/1WmyFa0NefAAtRPZ0GDcl0umL
	1+x6W17cGxf6I+AowacXMLcZ6Q==
X-Google-Smtp-Source: AGHT+IE/lLojbQa5ylZyujHSAywjLKA0KHvd1gHdqbGhs1YJlJx+LEqW8/3kRM9xKQQzC/5ig+Neww==
X-Received: by 2002:a05:651c:1a0a:b0:308:e587:ca79 with SMTP id 38308e7fff4ca-309037c1998mr10011751fa.11.1739359404686;
        Wed, 12 Feb 2025 03:23:24 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307de1a6531sm18310511fa.45.2025.02.12.03.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:23:24 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 12 Feb 2025 12:23:12 +0100
Subject: [PATCH v4 18/31] ARM: entry: Drop the superfast ret_fast_syscall
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-arm-generic-entry-v4-18-a457ff0a61d6@linaro.org>
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

When not using any irqflags tracing, context tracking or rseq
debugging, the ARM kernel uses a "superfast" ret_fast_syscall
with a very few assembly instructions.

With generic entry, such local optimizations are not really
possible, we need to call C unconditionally and take the
(hopefully small) overhead.

With generic entry in C, most of the tracing (etc) calls are
replaced by stubs and optimized out by the compiler.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/entry-common.S | 29 +----------------------------
 1 file changed, 1 insertion(+), 28 deletions(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 3559e0a9f5e079f1af91392bf000d39f9b45906c..dddbd6ba1eb9fcbc2c0d81f24e1a9b3231558d7f 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -30,34 +30,8 @@ saved_pc	.req	lr
 
 	.section .entry.text,"ax",%progbits
 	.align	5
-#if !(IS_ENABLED(CONFIG_TRACE_IRQFLAGS) || IS_ENABLED(CONFIG_CONTEXT_TRACKING_USER) || \
-	IS_ENABLED(CONFIG_DEBUG_RSEQ))
 /*
- * This is the fast syscall return path.  We do as little as possible here,
- * such as avoiding writing r0 to the stack.  We only use this path if we
- * have tracing, context tracking and rseq debug disabled - the overheads
- * from those features make this path too inefficient.
- */
-ret_fast_syscall:
- UNWIND(.fnstart	)
- UNWIND(.cantunwind	)
-	disable_irq_notrace			@ disable interrupts
-	ldr	r1, [tsk, #TI_FLAGS]		@ re-check for syscall tracing
-	movs	r1, r1, lsl #16
-	bne	fast_work_pending
-
-	restore_user_regs fast = 0, offset = S_OFF
- UNWIND(.fnend		)
-ENDPROC(ret_fast_syscall)
-
-	/* Ok, we need to do extra processing, enter the slow path. */
-fast_work_pending:
-	add	sp, sp, #(S_R0 + S_OFF)
-	/* fall through to work_pending */
-#else
-/*
- * The "replacement" ret_fast_syscall for when tracing, context tracking,
- * or rseq debug is enabled.  As we will need to call out to some C functions,
+ * As we will need to call out to some C functions,
  * we save r0 first to avoid needing to save registers around each C function
  * call.
  */
@@ -75,7 +49,6 @@ ret_fast_syscall:
 ENDPROC(ret_fast_syscall)
 
 	/* Slower path - fall through to work_pending */
-#endif
 
 	tst	r1, #_TIF_SYSCALL_WORK
 	beq	slow_work_pending

-- 
2.48.1


