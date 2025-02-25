Return-Path: <linux-kernel+bounces-530959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4DDA43A79
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7058D16FC8C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124182686AD;
	Tue, 25 Feb 2025 09:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eAPyeLs0"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C5F267F6A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477324; cv=none; b=IbbNhx5+2R1lfiGRxuYbRR6GC50qI0HumI6ghT6l8J22WlkZpA7XhH1raXKOZc/xRx1kIRZJnQ63ObbhaDHQCeS0hrY3KD9DDO8IrrRVz34HQNFMdBC7YUo7dh9Vl/jHNfiwmvH1FUlfqz09QlDGDNbpAgA6Jo0X/A1Im0Ch79w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477324; c=relaxed/simple;
	bh=6f7zBuKhRiAQ/x1F76wPwIaqznd7DT1I5iskhJXpWuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oJv0TkBJfU4rauwptYqUpUYTF1vbie/cE4y0lTm0yicHd88XNPfsjL/ImZbfALWJjOTTAar4X1dMVhZ5KLoB9XrIicNDgqbJ3P+4VMJhXK5J23GuS2n2pgYNhJRjvMJ2m5TOn5GiDSm0YFLyNerY8zbVXx3BRgzhkivYP+ksew8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eAPyeLs0; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54622940ef7so6100333e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477321; x=1741082121; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kElQgdyrfkPgzICs9KEd5Is5KMXf1IbQ9ph46r/iv/o=;
        b=eAPyeLs0RUOppCyXtBsRpr1VSqCXn3DUhduxmFgwmEX92VwfoSS8aKDVVpP2XGfu9m
         lDyK4vBWBomTtRT77Hg7ATmFkvG0RDW2HLC2u3L0F1+UDiX8BHzPECz/syORzLoUYhgH
         q0AaKcoFZau4rNyCuC8s+NJI2CMcKEuvq3gaG9Ertd3Gsxeka+FmTXe/Z7P8Cao+IYBE
         jcX8iDLGxHJg7S4u7tp2DTwULAcXjF/qvAPCAmvloOjmK2yj3WghX5CPfbFiHq3IbBI5
         vtavNbpSCy4Qw3o4IQwRZunqo5G6njhB0InpkFIocd56Rw+HZy8701z67UMfXoemwhDb
         YOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477321; x=1741082121;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kElQgdyrfkPgzICs9KEd5Is5KMXf1IbQ9ph46r/iv/o=;
        b=N5XIKHrPl2qWjLfyQlZldrLcnGnurP32Set4Il31RbgXkCEOadKt849YugiljP58/O
         ID6u/YuF1qg3evVWORGeveyiel2gZiB43heUXY5Pk38sCOdAMqZmMbodFz7RdmCxFwym
         SdjiQNWeRero2kd+bIdnpAaw8Z7wkJxGYdt6PU60esWizvmJKoSOsxtWsJsu/Q19ftHf
         FZg7t0weFajMU/biv17Ews8HeB1lmoic/kiV1Y9gA+UuD/kck9T9Itcf2HtM8y/WuAzd
         4iN8O3kqEXePtMsZ2p2fyZUDXA+c1rjAVGAh9eMdd8L3w7iQ8oeoBaUIM2SjNCSd0Guo
         j9tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWppCSeAVWPy+LNzuAA1yNMnvz1xkR9he7w4FBOwI7sD/Yx/6weJBGtTF/iHuQasDhqfOyvrBu3wsCczS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU4QmTCYH4wO9YpZxZH9RWF1x+RMg4OEljkIUmDQc7cuy1wdIT
	AHasKxei3IpLV3DN7m/68MtKK7Cwc6pBN8bjCNr0XAHidsRXZjLTQ+gwN8XcfBE=
X-Gm-Gg: ASbGncs2HnMYWmE3IfWy12ox26RFVvh2EaYLCkmmx0qc+fODmzaCFsEEvkM2NjHMRmY
	yAb+yJoUAriI3gLmH/ad4v7k+hpe7Pf8wc1zyATVtnkZ1AnQ1P8zo8Hcd6esSws7ObuhQuYgj6w
	Lf5RSeUUbudcTvoMWM8HwFrEY8wg49YaNiei+cISjywwfnTDI+a8DARbIL9HzZVdSZFMpk59FIX
	M7wGMal4b9vV00CQa1Vu2MnK14IG57Vtg1GSaWeDhDmd3WFE0vs4heT+EV8fooLuqzWVVmVEMEE
	zR2ypRSj9OGbRQD47DcBm0bLW0c+K+Dsxk41
X-Google-Smtp-Source: AGHT+IE7t84m4BCM4TmWOCmFQFqdsr7GUqDmKXu9j93tWoANi+DXx582k3Ij4BI18U0vfQc//0bwWQ==
X-Received: by 2002:a05:6512:3186:b0:545:f9c:a80f with SMTP id 2adb3069b0e04-54838edd978mr5618553e87.1.1740477320805;
        Tue, 25 Feb 2025 01:55:20 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b261esm132867e87.24.2025.02.25.01.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:55:20 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 10:55:05 +0100
Subject: [PATCH v5 18/31] ARM: entry: Drop the superfast ret_fast_syscall
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-arm-generic-entry-v5-18-2f02313653e5@linaro.org>
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


