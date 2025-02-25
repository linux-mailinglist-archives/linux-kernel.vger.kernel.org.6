Return-Path: <linux-kernel+bounces-530969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 286CCA43A7E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3DB1891044
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0B3269CE4;
	Tue, 25 Feb 2025 09:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ak+6+jnv"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8906F269826
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477334; cv=none; b=Dxbx9LUmpsY4Ne//rnJHKpqymsEh+1zdyTqmgyUDm9/5T2FehqY+qg7uW9awVfHbToiTdh7yWi5k8cWG7LYXioqON2UB8t/nm+LSItIFWW/tLIaisqJKrzjOBf2xDtm2tFG1bVgOKAqGFx7bOW1GqNYtwxzrBTmFwqLr1nrFv+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477334; c=relaxed/simple;
	bh=RRy9IfHS8ViSPW/Yi1kyEfOO/viJ3F6e0+y9lZRUOlM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bp7NCQqb7r5FeN4NEVV+E69uP4LrIUZIPvtizwSkdG5FGItiffqczlAd9LIgOgrULLRDfiekFhfaVMAlqVL8c9boGPLZjBfCC5hEc8DchX8omVu1hTxFIxvhRjXzwMUykWbzYL2jieTIceZrPrnaHlZ3lD3ydHC9N31i0s4SbhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ak+6+jnv; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-543e4bbcd86so6219072e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477331; x=1741082131; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PgPYwUz2C3jq2K678fDOOKopXFthUCF1z0KBZvQ8kgo=;
        b=Ak+6+jnvdzsJhnwXWAaomXqlxhXNUk6TMeRS9g7uaGyjQxDS2KmUQvh7EvltTH4BfM
         20ziCLTtEI8HP3Flh7mu8qJ58zRgQnH0K4AWZ5d3eO5OOIIxqUjdjjDjdSGrT0wDk4KT
         vpl2V42SrBQuav07ZKB1LTOh7npTHk7RfClU5GGo32m2bFHAgho9GXQIVhsRRcTywe5r
         eHjJByFOrxnkC9JoGzQtOOM898o1Q7OjLsHWyh/2rpVVu8n15/6ELFzXEhz+GdNC6W8B
         UsRynY0qEoTN15hF11ibeiuxEM8mvSdaiWoetS+OYJv9d3+MqVKpSdgm2DLaBSnqCVpi
         ju+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477331; x=1741082131;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PgPYwUz2C3jq2K678fDOOKopXFthUCF1z0KBZvQ8kgo=;
        b=wu4MYCqghqg8ItZf2sUupx3iat4Bp9ma9tB4l8Q5gHIMUS4FyvS/R1ZmY4SVqYGIGh
         hiEhl+JgMxtrDB2nxm+ZOic0i0jWGFQbtK90NoP6y8sTNwG1Ily86uxS/BSLYUqWwAez
         c/OEoivtJNmA3TutfSOhOXkpErDVe5y8KCMbXd0Y2+rfhLILj6J+m8s4TUrbmPyFPUYQ
         ygb1miiSisZYIubetNyYhp3uMorFWYnzLbk0vNukWmWaSaNzlHXEaRh98RjpbPmDIc8m
         AWKDrBRCOx8h767hupcEWlABJdiKaK5nURmO3IWPG+k83hNZn6hFvv+xB9zShH8FZHME
         5tLw==
X-Forwarded-Encrypted: i=1; AJvYcCVWLIwalAZ68kQvjbD0NUqYm0gY3513lLIQCb3/y4TMqHVeaTUDVCy81zw3Bhj/ssBOfPXAaB3VnMPfo8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcd3JpDoVW36IG+74DKWJBJ9rcPSRrSfhKsDbxaVYk6tda9bST
	SGHlj7/gXm91FCU6uyUGwUBCMFUqF69W65tKpvuhEXdwxPXRPVlTzUonxYvqPOs=
X-Gm-Gg: ASbGncuEkplIb0g46GbKWvHE5qSAM1XKwDBctQ3SxTIUJOSbbPbbzDdvFP81DVTnRzC
	8kJtS95faz7EGULoxoYiurYg0iMe++v+9SViXwbIYSxz5FLFd1nV8sCEFJw/IbGhR5nkFJPXvlb
	skZa2aGzBIoUhy2D1zK6xJ2KZgbUfgMb4WcsVVGWZhjvsBLc10A9qh7VeH4OTi+qkTcXtz0W1F2
	sFYwv+YcADgPG+VbnVCNdVZkHhlhF57i9+d2SnlCYBAPimPaByLzv0ykfM7oY2u0x3WseL52jJn
	8uBPnzHIkSQfSK4GrGsnGlr4NaHBZefQsMUQ
X-Google-Smtp-Source: AGHT+IHrYBKEgwrOsqtabCf77riVA6wTLLPZltwvy4MPKuhYyJsmmbuvXTyEaXfB9oGzNDCBGFjJZw==
X-Received: by 2002:a05:6512:3093:b0:545:2f9b:7589 with SMTP id 2adb3069b0e04-54838f79d15mr5814906e87.50.1740477330711;
        Tue, 25 Feb 2025 01:55:30 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b261esm132867e87.24.2025.02.25.01.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:55:30 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 10:55:14 +0100
Subject: [PATCH v5 27/31] ARM: irq: Add irqstack helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-arm-generic-entry-v5-27-2f02313653e5@linaro.org>
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


