Return-Path: <linux-kernel+bounces-527598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31832A40D07
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 07:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9697A3BDF91
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 06:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974121D7E47;
	Sun, 23 Feb 2025 06:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mys2WTGj"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFD14414
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 06:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740293476; cv=none; b=cya/jhJQrMESedxA3e1iqnKCo/ekFK5zvDBk7fWQgotePwIixAue8DdlT+Hf1u2ZpwACR/yQT/ac/jEaS+HfV0tHZRQ8NR84KsY7nRGSywSkIG3VgwrupFa7nGuNl56ZWK1+AsI38p1LKcL0wyShj03yc4XwQklaZjfVs2fy8mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740293476; c=relaxed/simple;
	bh=TiTiQy9fLGmd0hKyx7X3r4Y22u/yWIg9kNt45XGhIDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pgRLkc6sXkRUAcFrRg3tH7bpl+6mHcTFmFzb2p1g1Etde71bnQ812Pb8YSKwMZXnWeaNLJZkD/IvQ04e2EERuqRgsAyF5FHUIKhEqoCF2aGMHCwUWTDPxh/rKE6QSRWsH4YfcJzdnBfM7J68B8cui9WXklPC8ImSuYe6v2sx6TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mys2WTGj; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-438a39e659cso21663675e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 22:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740293472; x=1740898272; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wf9IOjBQ3147jp76ze9JeJiEVzCwi5QU/DzJ1ulfNfM=;
        b=mys2WTGjkxKOrEjE4CfxHyRXqoBMKQHQ57+ZVcCnEfqOTL+Il4mLp4k6XXVY2ahMfO
         jJpfAkqBHqJYv2l/uY6A1w93G2uG/GJDvL/Ksg0TC2jSo7NAzdpiKlZsXxIMatmUYJrE
         M7hWGOJJ8hJrevo8N80E6Na+stdgmJgKw7x1uN9+DuWmWvZBdWZ5zhqyhCFjPdADRkcy
         CBmQq4FIyus/KEnAOEOzlJbB0iPYXM/NM4+6RSpPBWyw1DCvnK3epvS8J7rxwV0o69bw
         gYx33vmlLIxxnhE2BI3rbyEYDIS9SDHyJLdPPm3qQUcbuzyHMPQ/oEwYfbZnNmAHUmke
         5N9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740293472; x=1740898272;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wf9IOjBQ3147jp76ze9JeJiEVzCwi5QU/DzJ1ulfNfM=;
        b=aN5H/hm/aXKlHMMV4/TkisL62CLlKbdE9KpdXbMSuSf8o4WN6n6UrZkIeRXLYOFA7s
         fqwwoNJWM0OoACxDZ2rSuJvv3avREU2w5XItFUqJNLpLegMh/IxyoEoKWVQa771w3mlT
         u5okEr48ksfQYKDORe0s5FxoK0tTX9XX0VoNz0tre8VKifupRzNyfn4iJdbusCpm8jTH
         xAzaXIi/VRpmvm3EHYZ5Ip3kuS+5wk1lykRLsHimi9CR5R0fVJvAP+JAtj+idlix6mXz
         HasUfthj+SOcWxW26TKkrzvMPWY7sbaC7vFZJGZZRiObWpPUfieAiIcZZ6HoLQ/gNfAJ
         4TIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1pHKxE/N6cQI5l6YUgqhWSe59Sw3so/H0mVtXFA8m+fYWCmt3lO3QLX7lFwTEW3lVNrYeBBwOeiTSONo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeNZLjJLp74aQQsBeYmh1uNeFfYKPI9tv7d4nqcbF2qXW39C4L
	rUIHxhOe2+LkDXrcbJtdBDBQ73qHoByL5gAufxLC3EfW16klI7C2cw0qjfhvZHU=
X-Gm-Gg: ASbGncsSLhAqp3t9aqeY7VvrXQZitlpO0GqddIU4YEftJCQ2RcVWeAGXQyULrxV0TD9
	Ijs6EeCTc1Mqc5AODLMhgV6lpu0nYXYlO6etVzT+ObqnQ0YMmTTaYy4GFNQXyHW/WuBwX5hb6fC
	x/olwUBe32zvUq/x58jPqhiGa/is7z5I7osKlpHgnjZaHiEQRR7CX31r70rtytm1iKRPWjoHaXM
	s9BBJkgj0uWrNU+j2I298/u63ige54hbEjKwLOFC8rRqwB69w4ogyWxBeLWN4mfz2bkLdvVOxA9
	78ZwjDiDHnN9/Fe5GkP9S7hLsEcwhC0ewpOKMZbqpH4K57y+scJC3Asvc8Pq88Xe/pXlPVftYWG
	EdkNelw==
X-Google-Smtp-Source: AGHT+IE0OLuFGVI5dKmS0jsudLxiGBBLypYvwDHB/8sXl1IwFDl/fYKFthNKHHKb91Nism9Vcl2cbA==
X-Received: by 2002:a05:6000:1541:b0:38d:d767:364 with SMTP id ffacd0b85a97d-38f70789915mr6307201f8f.13.1740293472502;
        Sat, 22 Feb 2025 22:51:12 -0800 (PST)
Received: from ta2.c.googlers.com (169.178.77.34.bc.googleusercontent.com. [34.77.178.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b4491sm27673755f8f.7.2025.02.22.22.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 22:51:12 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Sun, 23 Feb 2025 06:51:10 +0000
Subject: [PATCH v2] mtd: spi-nor: explicitly include <linux/math64.h>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250223-snor-math64-v2-1-6f0313eea331@linaro.org>
X-B4-Tracking: v=1; b=H4sIAF7FumcC/23MQQ6CMBCF4auQWVvDTKEQV97DsKi0wiTakilpN
 IS7W1m7/F/yvg2SF/YJLtUG4jMnjqEEnSoYZxsmr9iVBqqprYm0SiGKetl1No3qXe+Mu1NnG4L
 yWMQ/+H1ot6H0zGmN8jnwjL/1v5NRoerHzrQaEXVrrk8OVuI5ygTDvu9fjVi/6acAAAA=
To: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740293471; l=1527;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=TiTiQy9fLGmd0hKyx7X3r4Y22u/yWIg9kNt45XGhIDE=;
 b=GxCTwY5144l5jdjB8PIutHJngVtP8t9EQD7nJx+bWJHmycy0DqOZGDxZz+oDmfaV9Sj16C3RN
 XIfg3gXJFhOAXSUF7RmsdyyTKrdyVT9ySxayHZGhCMbD0pxxSkuZrsd
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

swp and otp drivers use div_u64 and div64_u64 and rely on implicit
inclusion of <linux/math64.h>.

It is good practice to directly include all headers used, it avoids
implicit dependencies and spurious breakage if someone rearranges
headers and causes the implicit include to vanish.

Include the missing header.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
Changes in v2:
- fix typo in commit message s/if/of/.
- Link to v1: https://lore.kernel.org/r/20250223-snor-math64-v1-1-8c7653111356@linaro.org
---
 drivers/mtd/spi-nor/otp.c | 1 +
 drivers/mtd/spi-nor/swp.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/otp.c b/drivers/mtd/spi-nor/otp.c
index 9a729aa3452d..7d0b145d78d8 100644
--- a/drivers/mtd/spi-nor/otp.c
+++ b/drivers/mtd/spi-nor/otp.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/log2.h>
+#include <linux/math64.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/spi-nor.h>
 
diff --git a/drivers/mtd/spi-nor/swp.c b/drivers/mtd/spi-nor/swp.c
index e48c3cff247a..9c9328478d8a 100644
--- a/drivers/mtd/spi-nor/swp.c
+++ b/drivers/mtd/spi-nor/swp.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2005, Intec Automation Inc.
  * Copyright (C) 2014, Freescale Semiconductor, Inc.
  */
+#include <linux/math64.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/spi-nor.h>
 

---
base-commit: 03e7bb864d9a9efca02743d4a9fab8f3d0b00407
change-id: 20250223-snor-math64-8d8d6db27a42

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>


