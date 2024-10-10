Return-Path: <linux-kernel+bounces-358894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B368D998516
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 747B2283FCB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9931CB314;
	Thu, 10 Oct 2024 11:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="siX9NnM9"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455A81C9EDE
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728560056; cv=none; b=PklK7T6BzL7UBTnOVsYVJWMUeQ8xVJpCzLuvOKyWZbm44ptS9LMQa9jExLdtB2I80Wb69Y2yHAzxiAFUejy1Q+l3qewxFFCYEQ9LQAdl2I41H5n5A5H7T2/A0cTP51MqjW/hGRtOX/3LQxWEmSWHUCDWJcEfaSz5bJKZjWFAy6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728560056; c=relaxed/simple;
	bh=gNYk/dXXFiwzPEzltOa8cVyir3PP8qKub1uE6+vi5oc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=er8jm/o5Gphft8/iROvSRVaWEo40TLq6XTIyVhfNd8l/cn9xIklpreneMqSwrGTUEmZxiw17+PANEyhDefjJI8LIWpxHnudvImfsPH2yUOOaDaNUgSz3CvZYt6q/OiC3tk+6iEPpXdrdueyhd/cBURsOGAYafoNahA252lFt7UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=siX9NnM9; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a998a5ca499so116930966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728560054; x=1729164854; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KWToKPY4NC+RvNbtP48N7l0nt4O+1hLmMWZz8WN9xgg=;
        b=siX9NnM9rN+yZssPIsmHClgQdK3E1rRA2moqgKICk1QwRHFjKn58DbjA5ROIghb4VO
         p7fyBL2KxKgv7RXef+xtY9EyuMAzBw8FyUMYjeiVwYWIvinAynuUzPvlj0W4QUMytFjW
         hH9oTIA2IlmCviRnK7c0TJCSHc2nDEWO9TbAiHfoEthUzMUeRWLs11vE06h5mbdDNZQ3
         WVNfjI+7a2hqnfAPHOQjObDmVOTofZARByNGcPL6p4rGvkivC1zN/7Ugg9iWkUxm6MHp
         mjXVFtNG2x0T18zXxhnFmQZ0mDIGnAZ2cpBNtMrTsGhKyk779EDatAxiZAotjPxPw6RU
         qRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728560054; x=1729164854;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWToKPY4NC+RvNbtP48N7l0nt4O+1hLmMWZz8WN9xgg=;
        b=vjptisc/t/uP0d2SDhKUgZ0LxF5uW7jqCpMpiDDQgk3lQvnwb62x4yevJTRc6XeD/8
         ek6GyByDfZIQCvRuG2o2gR2716fujFuBKe5n2g3EAd7j+3VQLhHGJWxncGHLCBqHzyUN
         AQb8qBvTVFL3d4AQiboIrpwT8wQADnlxl5x11H8b7BI3xpG2PUDrriWjqS2fXm8VZYyJ
         vA9lzvRID8LOEdnjtYYoD5wQXzQL8sh++qSCOJbmZiJYKgmKtbSsYmlmTAmv37L4i44Q
         B6C2z4nY8JEaLfvx3CmYhEyNTjvemAeVQGmbbc8sH6NuIlmuOXJVbMUvp1d4BfuoxNMZ
         EwBA==
X-Forwarded-Encrypted: i=1; AJvYcCVc4iJrtT2DP25Fn24EC0Y/KzEDUYTjlSMAKiaanb8UrXTjiwo0kbYOINBrImWJaff1w9aHPmUHmkLLRZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAVHmX/RLogW9z6Ty471HBVD+AgIOMbFUjcg/5SKLVt/xIkhWO
	yo7jPqi1uCxNHkdqEqrdo2uYzQCVi18LPFAn3lsbGJX/z2WLv9iWBUXjxHcWXrw=
X-Google-Smtp-Source: AGHT+IFDPzLaonbakRRWJT+0QxQclhlzU2yW7uKOVcDb6pVGDrHLXlnDxsO6QIKMg9pncKslUeaLQA==
X-Received: by 2002:a17:907:3fa5:b0:a99:75ba:baa8 with SMTP id a640c23a62f3a-a998d1fa613mr557910666b.31.1728560053677;
        Thu, 10 Oct 2024 04:34:13 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f25406sm77619066b.69.2024.10.10.04.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 04:34:13 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Oct 2024 13:33:56 +0200
Subject: [PATCH RFC 18/28] ARM: entry: Drop the superfast ret_fast_syscall
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-arm-generic-entry-v1-18-b94f451d087b@linaro.org>
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


