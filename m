Return-Path: <linux-kernel+bounces-511030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65210A324E8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E20A167B9D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F53A2101AD;
	Wed, 12 Feb 2025 11:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iKdPCz3S"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE867214A88
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359417; cv=none; b=IWtvhSrXI4momqq3I4ww2aZ9Bbyu3rLTNFpt9MiWRdW6SPXCDXTbuUdzAaCvBQgdCH3pj/JYqI9JR69ta5rglECA5NozX8mtehuMVU8dgoDwd6ir99wlYOf+EKrXQLFbsUQzFKKSvkQ6CGsoY51mW5cCJoSNOeCBrVvKYsHd4k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359417; c=relaxed/simple;
	bh=RRy9IfHS8ViSPW/Yi1kyEfOO/viJ3F6e0+y9lZRUOlM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fyv1djkwdWbgdEUNXNr2pWL+WUT0+4Xi4GkBOuLn9pBKOWEJGLdgyNN5aIr3RmA0VFXrQK0/NKGwJYFiTlGDbif0cTNpTSD0fk0UM+sTw9MJAFtykigOP38pIWVdvD15z8lUtStLlqrt8q6yYf7MnZB7W+aqEcmAULl5PPaAjBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iKdPCz3S; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3078fb1fa28so61476531fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739359414; x=1739964214; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PgPYwUz2C3jq2K678fDOOKopXFthUCF1z0KBZvQ8kgo=;
        b=iKdPCz3SUm7huVK4BxMBfG4rzqtjzNiirxIx0Lao1jXtCtUGWR3gSFb2hwBNMTKwfu
         J41OHdbKiH1ToeftzdB4p2Le5I9jgMw+LHnO7GAgJxCYlIAzhatHvm+t9RqH4KBLFpJN
         bxAuGxGbUXE8wqNMlHpUHR6k1zePG4Yae9K1VtnP/vJY9QAKFGNM3sPlm/PCk2K8muaT
         IDQYHDbfa2a7YXe3pSUEFQfSZqYkr1wDLbYMiclsYPJNGSLf1nKiM1M3xQiw0aUsJw+9
         iXFVgGmZ8A2z/GmbOTBV4qSbNUUBmTm+vwjU5uR6DmwcosydxXf71McbhKIxxuqYD1Ir
         1KeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739359414; x=1739964214;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PgPYwUz2C3jq2K678fDOOKopXFthUCF1z0KBZvQ8kgo=;
        b=q5gi5nOfAk24z1ZXRuOkglY1w5qHdTn0vLVeMXawieGacToNO3MpgbfOZzMHTwEdHb
         6CmF4lt/G8SKwomuqTsBZDMltBMTrq3LaU35X3V7lSqBCNopwQwyRHTG5kTKLPcpnPmb
         ktRsdb4g53YkLzsMISjHEMO+IiCo0XvwrcwXg0hVFJNTkoSP38CcCrtKh1KoBPVnmKN3
         4E0KBSg2QCEP7/Bu6Cm3r8fwr9uasML0BrZ/VYpvvuxfqeJA0kctxqqUrMpEGEriFtNL
         gMBntYtjL1e0Bi07NQGBK0T/vS/+HXFcIjBuLqbjLHOWx8K6x1B4vp05UKK7dm1jpRQi
         pkwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWg3hSyZPL0Q5YsXnK2ZoQXDyWeIu9QtiYTazmmbFGXARex45soqkIc1Wba2RZAYvqOASag78Wn34dRHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YybLNoRDjmOOmCqVrN5cN6NYadRpzf7n6o1aYt46NrIGQV+U+8W
	zOCXNn9ZyhKgJ30MzAgTPpOg52vE0h2D/sSRzgNntPrGj2Tn3oooPTcBahnkiUs=
X-Gm-Gg: ASbGncv00RJvkEpWpGbfBpfvvaoEQ1Pu/DH5ejGYjoqVnGGTI47v0/1HBO8lWjPZfAX
	VxzUkum+sFpX+b+h6B2AuJVGIKw6M31cOlTq8WuPo1TvrOga4lCTswFWr2LEQwTj6gDgRK+qh/T
	KWEGIwTOJzAozmRzx4P8kSc/OzmM6mRKeCuNKLl2p6X3fm+Mzp2czywNlo87lKsO+ErMYKUjUDu
	g0a3nX5S0JS+s5s5rjQy/r45tyupYeRC5MdXy8DwPQHpGmYVVgO9k2J5bqhTCCgO06TYALegqlK
	+3Ry/VjpiYMM+LP16qLDi5mpUQ==
X-Google-Smtp-Source: AGHT+IGF2XSQHUsYlAH9QvRI7MOgHMAfLQ2S1iDSbZ5eNFwUYo7EQJgkizHhQjqYAo/v6F8JXXJM2Q==
X-Received: by 2002:a2e:bc84:0:b0:308:ffa1:8915 with SMTP id 38308e7fff4ca-309037ac73fmr9166291fa.5.1739359413983;
        Wed, 12 Feb 2025 03:23:33 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307de1a6531sm18310511fa.45.2025.02.12.03.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:23:33 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 12 Feb 2025 12:23:21 +0100
Subject: [PATCH v4 27/31] ARM: irq: Add irqstack helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-arm-generic-entry-v4-27-a457ff0a61d6@linaro.org>
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

Add a helper to dispatch IRQ execution to the IRQ stack:
call_on_irq_stack() so we can explicitly issue handle_irq()
on the IRQ stack from a C program.

Cc: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/irq.c | 6 ++++++
 arch/arm/kernel/irq.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index e1993e28a9ecfd80b55b2677253ac582467e6c14..f99d6b24d8ff56f901e4a817c61a1e57b7e532cc 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -43,6 +43,7 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
 
+#include "irq.h"
 #include "reboot.h"
 
 unsigned long irq_err_count;
@@ -71,6 +72,11 @@ static void __init init_irq_stacks(void)
 	}
 }
 
+void call_on_irq_stack(void (*fn)(void *), void *arg)
+{
+	call_with_stack(fn, arg, __this_cpu_read(irq_stack_ptr));
+}
+
 #ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 static void ____do_softirq(void *arg)
 {
diff --git a/arch/arm/kernel/irq.h b/arch/arm/kernel/irq.h
new file mode 100644
index 0000000000000000000000000000000000000000..80dd5bfe6403d68fc62fab30666d5645748d329f
--- /dev/null
+++ b/arch/arm/kernel/irq.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+void call_on_irq_stack(void (*fn)(void *), void *arg);

-- 
2.48.1


