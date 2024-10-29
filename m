Return-Path: <linux-kernel+bounces-386758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EF99B47AB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 109342820C1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D8D20CCEB;
	Tue, 29 Oct 2024 10:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vlvyoGdT"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D6A20CCC3
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730199203; cv=none; b=M7wQ13XiBWeVsaJ3gCaYrV724u2sdRqslK6A1W1Qve3ZZ6B74+PTvcnPfeR4T+W2bVG7+pFDe8XcVGR4XdT7h5LO+ib55My23Xm4LP4vhaKsGJdHCOsJJF1xLCQV6/zXrBmegCZ+66tuyscF36ndlqhOz0kVtfzae/y3VLSiQcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730199203; c=relaxed/simple;
	bh=gNYk/dXXFiwzPEzltOa8cVyir3PP8qKub1uE6+vi5oc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oXkS3WAM/nOSgn/5zwwFZYpFUEPR3npUy2VxEHMf0calqeJaivuKGYmRcjvrKi9PrinH6iZecgtpgVzTnzaxx12VZoUoaZPdzXBu689uh3Q7+B6Ho8zyt0Zw9vamXPNhW/1FS4LIl+LcT+H9I+kVmaf0fLFhqbrtF1YJsOqtO+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vlvyoGdT; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53b1fbb8be5so5153948e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730199200; x=1730804000; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KWToKPY4NC+RvNbtP48N7l0nt4O+1hLmMWZz8WN9xgg=;
        b=vlvyoGdT/6inWjBvopQ40FtIfrioAMh2T0Cv3uxRratNMTaQMbQh4o1WOhKIHQk+6A
         beYVjOJVrDsedriQI1C8Xl+7SPlwVf0v0OZAKIcBTnAFjU7EXsDUhHJTUo8u5K02V5PL
         O+Kax4bPFmsE1g1OW1k89q6PHIaPZvsaWQDWRCU0OMBpH+3W0CE7PwOc1YVivVN5uzL6
         5/56GJAsmuILLvfCYvfz9i3MQ+QFRVdz6CjfyXhTCDt3QCv4kUKIo/d2vwhf0JVMyGqP
         cxlkX5vTQvParV0j8J86QUPj4IlbF4JW3p+8cbf/z7W6m8CY4cBs122Xqq32TrMr3B1p
         uqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730199200; x=1730804000;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWToKPY4NC+RvNbtP48N7l0nt4O+1hLmMWZz8WN9xgg=;
        b=QgNgRVX6pRR8Jpjt1wc0Zkg198Pe4r42eHbEj2TB5tL22MYvCUmf2t0uqQK5tEPikA
         lInC9xuJq0Zp++g31t6YyFvDtAA+RDTU2tx7vYgXVTapT+PuDP2Z6MCLys3gULylIWDR
         7kEd0y7gFq5yYy/zPhXHx3rKzl0C3SubqZNPasBub+3ZtpES98pZplACbBBIq09+6BQh
         OeIR3yw/ijPZSAx4szp6WSXPPW7xHE12a5TFxQFGJce52GIn85xm853vgX++HePwjJO7
         gx3LfHGb4GCJGmnIG6fesSHiYKgbbuRq/RaVXEZIbC4cqL3BTgddON+oQQlzkHyCAfT5
         JQTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKt5mozd8bL8hKNZDobHkT7GYdsVqmRbX5C4cVdayv/O84qwQxLvw2mjXnFk5hMWnxs5DmalLrz9msSo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxISYzcS5+zpjBIc4yDC6NlxMmUV+W3K1Ami90hbJt/yGuofNAV
	+npb/0qNW31uNqYRfAEVLZBj+ZAPhKcG1Ix/Ylv7bJ5IEDKLkUHz/+9TqtJRcF0=
X-Google-Smtp-Source: AGHT+IGGG5g/5+zGZjyROy/Yc3vo9dh2CvJXvwozTq1krbIQXNKWoJVtmLAen7EpI2bSFn7YNTEMaA==
X-Received: by 2002:a05:6512:6ce:b0:539:8ee8:749e with SMTP id 2adb3069b0e04-53b491f773dmr589492e87.3.1730199199721;
        Tue, 29 Oct 2024 03:53:19 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e12452fsm1351307e87.73.2024.10.29.03.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:53:17 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 29 Oct 2024 11:52:58 +0100
Subject: [PATCH RFC v2 18/28] ARM: entry: Drop the superfast
 ret_fast_syscall
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-arm-generic-entry-v2-18-573519abef38@linaro.org>
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
index 3559e0a9f5e0..dddbd6ba1eb9 100644
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
2.46.2


