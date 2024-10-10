Return-Path: <linux-kernel+bounces-358880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FEE998508
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98231F27093
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5011C4612;
	Thu, 10 Oct 2024 11:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="obBaYvyS"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51AF1C3F28
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728560031; cv=none; b=fw2XkPiRVT6+ibDXyPNhbN7GiXvn4IRs+YStjbNQZtK1QHLA3utr9QGUjNiQI6g+CwyAW4hxU15/BvAUUsmj71OidMzJobpj+b//TTxAXi0ZSA1k/9fZLemkG7eOQ2IMwRSgNZurQExKEwwmbpZsY+kYMUhtXrX0dvInEnJ5pYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728560031; c=relaxed/simple;
	bh=F4l5jY4Wqe+bOqNg1KeOS2Pb/rQnbpWuqlfxyr64WII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j+C7O/nKQHPETAPUfMjNlJWrY0ZqiS7nvDc52647nRX27zUmKRO6WDNtkQnSwz1eGkO+vxYhEX80884wYRimuHl2x4xndq3BaCeN1lEf2AgRZYIJfAqgLvoVCZmCbWXWXU+tQCFa+UgENQPGGA/VDShgKdzm2qV5MsuhAf5XsMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=obBaYvyS; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c903f5bd0eso1046351a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728560028; x=1729164828; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OxEtYMLSB1QX4C5qcE83rstSx0FEcAVbxyG1Gu9/c1s=;
        b=obBaYvySisvaa6lKRRxFTPets1IJkbEA/05bbdXKi5kdLXiYGHL67J2uEHianpqVjX
         9C8R6W2SXJmIrmnE8wq4oqzNau+LtNVw/anXlYq92UoZtI0BgdP+MGiaJ65w+ixl0Kjb
         AggvSuAU7FmQkeMnGJLhPeTD2CLfPRN/7pbFwMdQzuIvMCGqAx8nnk7pwZ5GNglT0D5H
         HA/e0JpkXIgStxwMZ0eApsqAXtlmR9Afp59LNAeZI/oG32KJbe4pTYRBRo7/uwLBth3+
         0OMyWMqKH4SYHUDs0WVnSlIeTCGr8/DLBZD1jmmYnln4Ewvb5BHStKgVJ6rwO+YHA7e6
         cuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728560028; x=1729164828;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OxEtYMLSB1QX4C5qcE83rstSx0FEcAVbxyG1Gu9/c1s=;
        b=Um0oB7MUIOqupQYWvKQSCsb3QBolj7OnYyMXrln+9dTRTAXyK+cjD3fmx4xmFZ7JXI
         EOvgQzwH+xSpbjaNLS8PNYou3UuvzkXgJ0iAKbM5+UQ5xWQu7K3Q0b7UJ7iL0B2h2Hcz
         nPv4g60UaKFhpN0K2WilqrJK7J2CMcXWGRGgHiBShOfSYl8EF5l1EvHC7+KJJ31zhlwJ
         ihCG7zfJTV89ttADHZaDuAU4wEh7tZN4gnM3S+eNRKKEDIOIUTgZFxksQOEgP1YcKJwa
         59G7CuIX/ggm6iByNnE1omicCPJa+MmMlaHdPBL3m7DBdv/xi1qaFpqQU9fr4ijUXm0G
         oB3A==
X-Forwarded-Encrypted: i=1; AJvYcCXnqpox4ib/FbaQNI0g70GO9kFgsix0ZD1EDhTs5bz8mCFgHAaVooMbnEIQnubv5OvRJ+EmXrzQOHYIa4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6yI5qDK4M8uJXsOSQAqNo41JE5AFhl47Gd418CU8/ajx2KNWL
	P9T7+MrF1XYsT3cKxqCA2khif316B8Axue4H89+y0kQB5umOzhrox0QlwKH9Dh0=
X-Google-Smtp-Source: AGHT+IGmKNJPIbWGBVZJfO8+b8zw8XAoQP29rf5wbFh2YjSEj93didfv6G/hdQTs2PTJu3Y9jhUpkw==
X-Received: by 2002:a17:907:360d:b0:a99:adc1:1432 with SMTP id a640c23a62f3a-a99adc11551mr84023666b.65.1728560028080;
        Thu, 10 Oct 2024 04:33:48 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f25406sm77619066b.69.2024.10.10.04.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 04:33:46 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Oct 2024 13:33:41 +0200
Subject: [PATCH RFC 03/28] ARM: entry: Skip ret_slow_syscall label
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-arm-generic-entry-v1-3-b94f451d087b@linaro.org>
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

Don't introduce this extra label anymore now that we have
a clearly defined entry point for ret_to_user.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/entry-common.S | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index f379c852dcb7..2f93c2f6d5b8 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -102,7 +102,6 @@ ENDPROC(ret_fast_syscall)
  * do_work_pending() will update this state if necessary.
  */
 ENTRY(ret_to_user)
-ret_slow_syscall:
 #if IS_ENABLED(CONFIG_DEBUG_RSEQ)
 	/* do_rseq_syscall needs interrupts enabled. */
 	enable_irq_notrace			@ enable interrupts
@@ -136,7 +135,7 @@ ENTRY(ret_from_fork)
 	badrne	lr, 1f
 	retne	r5
 1:	get_thread_info tsk
-	b	ret_slow_syscall
+	b	ret_to_user
 ENDPROC(ret_from_fork)
 
 /*=============================================================================
@@ -310,13 +309,13 @@ __sys_trace_return_nosave:
 	enable_irq_notrace
 	mov	r0, sp
 	bl	syscall_trace_exit
-	b	ret_slow_syscall
+	b	ret_to_user
 
 __sys_trace_return:
 	str	r0, [sp, #S_R0 + S_OFF]!	@ save returned r0
 	mov	r0, sp
 	bl	syscall_trace_exit
-	b	ret_slow_syscall
+	b	ret_to_user
 
 	.macro	syscall_table_start, sym
 	.equ	__sys_nr, 0

-- 
2.46.2


