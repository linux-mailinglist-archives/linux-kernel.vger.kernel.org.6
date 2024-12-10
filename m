Return-Path: <linux-kernel+bounces-439291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4019EAD46
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4F1188D092
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6DD212D8A;
	Tue, 10 Dec 2024 09:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UhhRy9UR"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2A4212D86
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733824368; cv=none; b=RQCveyDtHUDogAf1xCJs/lE52RPdYdktC6MnWDDsaNzjesDb8Digtc3PJI7uhiFLx7rNN3zt0jm4eYy0/o0XiT/aahPhSr2ovfcSQkXvozJ7JDy71pnEAUwVXC9zx1Nq4thzmaZ8ED608pHNs56kw615Ac+r8t8LSl7fBgeXxPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733824368; c=relaxed/simple;
	bh=jqf3HirAHpuB7o6rlp3DRFn4sLucen2HrDMhDDwpDHc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vc1ivJ6Zl8k2Mu+Yr5frTdGwd3nrWiOjBOJtqORJCTMmbv5IJdFVxFF5JBW7kKBzIFj1hXqANL8g1q6TN/jJHfxyon9raDX1Z65agjk0mrSkN354DzQJN8h9BqMFsjH2btgAK1pskWiF1O7yvrBYqgE8+gv3dqzV7ulD5NnZyzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UhhRy9UR; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-728e81257bfso67120b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733824366; x=1734429166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t+0ylcaf3df6oTNxzBCSCm+khMzNCcfrqIl/EDVqDqw=;
        b=UhhRy9URlc+YZO2Hw8RbZW0P+m2n+msn+5UUoPkTu1yvwjtEgmL5MuJ0XwTfOtSVs6
         9VICX6Klfthkc2VEcX1ovMkM/lZdFgkvyVQuzQ+LClAUNEhaHUosAfXyuYVWvYa3RSyB
         0ydg8+XXGyYkbBlXGdu9BwC3IcDqzqF0Ay5kNqTI9vlwv6ODYzcusCQr5hJKMiJzZcM0
         eTCNifSEfVVNELa0qe0qJiWN3KxfkD5xUT6T+G3zVSEdbVd+djqXSxdLdvIXQs4Wm7LI
         pfJp9WRpznhjqSGi9PjI/xZ91zXuXcBsNJSnslJCstMu4jwBjy2QQuaWQCWZfN0yzHwC
         JNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733824366; x=1734429166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+0ylcaf3df6oTNxzBCSCm+khMzNCcfrqIl/EDVqDqw=;
        b=c5K56R35Oi8iKQkxluZYQ/xgQxL2pRL3ndkCANYPpiwN0PZD/eBejfOVLZiAUhXzBA
         R2Ihi2q+5W9XVo5LD+HUFb9srtzYsmqmlqv6pi3kBdtmpYII7QpWRwKXwyRuhlQvtxr3
         ljcblPKyUbcrPgrwV18bz2rgz4NL9CFogK+ULVfhFJ3P2w0zDLcUBz4uO6FRiJxPiZ+g
         +pcrzLZ10kcH4Fp9DiBvuHqO342hTq5DUsd3Hnwi5Vn87m6KuLjFtetxwK+hc81t4of6
         Y4U9GF4MJcqolyD1o8cTiGDd6pVtrI+T23CgqS8WD6u3FuoT/Jd1wTE+zJe62HXtIPFF
         v1Tw==
X-Forwarded-Encrypted: i=1; AJvYcCWe1x9lb4Du26PHXVc6pUM3IOWRTIsD0ChnXO0MSH5AhGqR32kFHpHuTs2Zc6gdIDk1z9x3JXjuY2atztM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ncwIoo5R43GMviK3wrW69V1KEh3YdsdHRnR7XT1tiLyelNRv
	+MDjPKCagw22UG2B6MKAdwEOFVHOKJON7B5dvCFKJ5aZLjWuJhhuEOpThagXxpE=
X-Gm-Gg: ASbGnctghXolAJFSDWOCoQQNC6Sj1vQWPzKFV9+39OsbhxA7WyyrKeWvkKBl36z4igK
	V2OZTr1BLoekrJkhJzgPwyT0nijg1JkQtMU78eolOH+0a/+g1kZUDzTvydBilbayC9Cb3EGOMgn
	VqAsBxdfahuwgHxRKD7YaaXrDJ47fwnKyIXKV8unAaNCPdukHj/RlRhHtdlJn5KrTPSf6T64v13
	qBQakKzs2WKl33ay4XnkduPL+4+AtnI9ONkSlTC0N937RV7qX9EmDiqk9TkVwa1Ub5A7qQnwEAh
	M8SGNsQT3xZ7
X-Google-Smtp-Source: AGHT+IEsK3bjqICM8YdFKuXBFohvlaKks5UxBEJEOlZmyQW56P/wQLBIoN1S6QTX3wQ955GG/JCIRg==
X-Received: by 2002:a05:6a21:6d9f:b0:1e0:d32f:24e2 with SMTP id adf61e73a8af0-1e187132ecfmr27154944637.38.1733824366302;
        Tue, 10 Dec 2024 01:52:46 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725cc7fcfc1sm5789703b3a.92.2024.12.10.01.52.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Dec 2024 01:52:46 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: akpm@linux-foundation.org,
	dianders@chromium.org,
	song@kernel.org,
	john.ogness@linutronix.de,
	liusong@linux.alibaba.com,
	joel.granados@kernel.org,
	yaoma@linux.alibaba.com,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH] watchdog: output this_cpu when printing hard LOCKUP
Date: Tue, 10 Dec 2024 17:52:38 +0800
Message-Id: <20241210095238.63444-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When printing "Watchdog detected hard LOCKUP on cpu", also output
the detecting CPU. It's more intuitive.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 kernel/watchdog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 262691ba62b7a..718e8c6fbe277 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -190,7 +190,7 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 		 * with printk_cpu_sync_get_irqsave() that we can still at least
 		 * get the message about the lockup out.
 		 */
-		pr_emerg("Watchdog detected hard LOCKUP on cpu %d\n", cpu);
+		pr_emerg("CPU%u: Watchdog detected hard LOCKUP on cpu %u\n", this_cpu, cpu);
 		printk_cpu_sync_get_irqsave(flags);
 
 		print_modules();
-- 
2.39.2


