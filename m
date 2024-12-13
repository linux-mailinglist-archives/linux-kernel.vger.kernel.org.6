Return-Path: <linux-kernel+bounces-445034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6569F1020
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CCAB28342E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1121EE029;
	Fri, 13 Dec 2024 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ac93QuPz"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81211EC019
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101905; cv=none; b=UbMXJwwYBQqZw4kl6HjJyTSRm/RDm/NzIVsNJA+yFClfc9FmRgph8f4N4xYSwATXfUDiE9z4zknvsJ9+Rgiz9loSaZER+4Ep867N/N3fxmX4emM36r/YdJ0MDZg4vV3nXSAUT7qGVodfekiJjPyMk59+ZayJng1EgUWsKT7/e8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101905; c=relaxed/simple;
	bh=u84ym6n/fXoo6ecjCuKAXs4qruznKdtHsEHdBV/R6yY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vb7MTeSQSgfHycHVvu14DLbbpR/EmNkb6vH6Zh1urzGR9/JfrPosr5/gc0320HYAXceikxWgSEkhlacHIzBI6SOVPosEBlYFQcVMYYXjJO56srFa1IOp8GbmjiH5NodPV7dVrMURaiv9E9eOJKjjOliGySbvubG9CtLe3qvtldk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ac93QuPz; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3cf094768so2784387a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734101902; x=1734706702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4qEMLxfX1BseC/FdkMrRBTdE/BHic3wsmzo5oEqfeQ=;
        b=Ac93QuPzJPuk9p8cSUj7fkjPj3JFdUbMSwGduJuhYxFnUhCWOh5lurVuR1fJcPH0wf
         FB4lWmek0uIXg37fmA+hHVEGHMVfAOIsPn0hMMOKkvFexw3MfoNfYKlbXy4y17QSHsvv
         zavzMBCAD5y9YAqgG0zplWbPci10AQqFAUVf62BFhbSBSiqcJxu8H0AE/u/jtG8FIwsA
         YGwpiuaGoLWOAacozOgenNv5DM26xXedQ8wGcZrnHQSIOpdixfW1WJPM24i4jaQ+XJ0i
         EIkhmBUgDL3IUWvES2TMDmQ8qyKewXeX9ISc5IREdMtMupHypO+C4ONFOdQDLLIjyrRS
         nz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734101902; x=1734706702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4qEMLxfX1BseC/FdkMrRBTdE/BHic3wsmzo5oEqfeQ=;
        b=X20jmvIxlVviS8twMt3hVicX9QOnTpluo9ca16q9AwmVsUCp6IuNCtjQ/5e6S0ulcx
         PmqoUl7mpwvGa6b/WUDCiBw9tQvg6yaaaFdYM3St/yR9LL4uKiYU398hklXQ90vgSCPI
         5TdfB/CLWuIagMvldf84UwVw8U7razkHdyI4xablltHiNkPs7+DCJXuW2pUtir1Qsw8e
         d7Yz0fCiIi90OXmwLlzuACtDh04sDtHAR1Mmz+kiGoJ0RpOCHt8uHRdDfMmnkGfhVt74
         cqvYYFaqPJi02kcckJOscCTbwH4GBBrqhP17vQgNLwf2MYwf7FolA3cZOVKy9JIDPZbF
         U0Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUlv+c6Ta68nDmt3ytnwhNUtcyaT7Fpad2RgymyqWX3o4+yeTGq1P3vLfi+BBTWMUmQX9lRsCdxcGyGHTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXwcUBPZUuJz+wyPglQTXT7UQSVbnnSoHo/wxlookrIge/NasP
	ZTEg7Q/S90m+igE79LUuTG2suKcbNDpir+XNmN02joXoBRmbvGU3
X-Gm-Gg: ASbGnctr/e0qBIi8DGXyf+gKc7QT+x3wd5thQAyzlWibZQNsic8vmNSq6XNn3Gm5c5T
	LlBsxB/27geGk3FVDAL3lG5RXzOrrLWcYkIyw/tvP8QiEhbIZRoxAOQIeBpkVtuytkBZHQcq6kk
	1KMlCx1j3HsL0tBtnHd0QZNesWYlCK0uWOBeejfQvoxNlcijpDm5K15tauvUuB4txdB6fVf2fxb
	BWs/i9xNEqxdZsAfLBsBibOu12YJ9lOA37dEPMxka/BnVrLbKG7kERSdUD1wWc+qA==
X-Google-Smtp-Source: AGHT+IFFvoMSIBChWgea1OnryG31unMF7LtnV6rYFz6R55l7bdMGVY5c0jGGqI8Y+CKjTdPlJAQFJQ==
X-Received: by 2002:a05:6402:50cb:b0:5d0:d5af:d417 with SMTP id 4fb4d7f45d1cf-5d63c2e9df2mr2151151a12.1.1734101901967;
        Fri, 13 Dec 2024 06:58:21 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3cedbb8fesm10048424a12.22.2024.12.13.06.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 06:58:21 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 2/3] irqchip/gic: Correct declaration of *percpu_base pointer in union gic_base
Date: Fri, 13 Dec 2024 15:57:53 +0100
Message-ID: <20241213145809.2918-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241213145809.2918-1-ubizjak@gmail.com>
References: <20241213145809.2918-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

percpu_base is used in various percpu functions that expect variable in
__percpu address space. Correct the declaration of percpu_base to

void __iomem * __percpu *percpu_base;

to declare the variable as __percpu pointer.

The patch fixes several sparse warnings:

irq-gic.c:1172:44: warning: incorrect type in assignment (different address spaces)
irq-gic.c:1172:44:    expected void [noderef] __percpu *[noderef] __iomem *percpu_base
irq-gic.c:1172:44:    got void [noderef] __iomem *[noderef] __percpu *
...
irq-gic.c:1184:26: warning: incorrect type in initializer (different address spaces)
irq-gic.c:1184:26:    expected void const [noderef] __percpu *__vpp_verify
irq-gic.c:1184:26:    got void [noderef] __percpu *[noderef] __iomem *
...
irq-gic.c:1184:71: warning: incorrect type in assignment (different address spaces)
irq-gic.c:1184:71:    expected void [noderef] __percpu *
irq-gic.c:1184:71:    got void [noderef] __iomem *
...
irq-gic.c:1231:43: warning: incorrect type in argument 1 (different address spaces)
irq-gic.c:1231:43:    expected void [noderef] __percpu *__pdata
irq-gic.c:1231:43:    got void [noderef] __percpu *[noderef] __iomem *percpu_base

There were no changes in the resulting object files.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-gic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 8fae6dc01024..6503573557fd 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -64,7 +64,7 @@ static void gic_check_cpu_features(void)
 
 union gic_base {
 	void __iomem *common_base;
-	void __percpu * __iomem *percpu_base;
+	void __iomem * __percpu *percpu_base;
 };
 
 struct gic_chip_data {
-- 
2.42.0


