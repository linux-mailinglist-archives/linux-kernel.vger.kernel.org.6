Return-Path: <linux-kernel+bounces-527597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC370A40D04
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 07:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 348CE3BDF68
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 06:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F9A1C84CC;
	Sun, 23 Feb 2025 06:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uzymO+eJ"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C03F4414
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 06:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740293366; cv=none; b=h6U0NAeFGqRYzi9FQz+0kXuKk6w4kSCAmeAXKxciX3PlL1TsBG0ubDiYpjlzP7o06S/XumdBKck8E6bQO3TDsRXSzCOt4JQCODrSBQ1k3ji9uir4JdDLxF8pDEKEJcC6BM0P+VQv86a2Dcw7QmGEQ5Vw6kkKOYs1uLYgDTo+7b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740293366; c=relaxed/simple;
	bh=IrXufjhrtURNRtePzuFrUi3VXTx9hYR1zzTLpU4TGdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nLJyIGygDKSIEBrzMhT7Wd3TT8ZP+Maa5HK5iTLjlxtGo6VlyPlTgsK5uqQw1B+stVzN2yDW3hJB1urV3Do1KHq7F9ySPZ6N3cSgcttlJ8k0wvZwpOHbIZvFU/6aMMzoCiQd2O+tOXGFdx2DknDBd+51EIeyAq8G2oDPsr3WE68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uzymO+eJ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-439950a45daso20551205e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 22:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740293363; x=1740898163; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HHaUx5KktsdgA0Sl0DqP/e15F+R/KAQTbOxMnc+xT7Q=;
        b=uzymO+eJHvCq+g91XzlN3Z7qwVg7jrG2oF7uVZcLlUoOA+igLqSg7pVYhSiyfUkHMe
         SbFqW6rr3CQhLWfv9bFyQVc76GelRkrQh1E5uJkrET8t7x582KUgsDd1zlue/rMqwHYG
         VNdFztttk8biCcfDWQOzq2/p3nLr44IrEvqywd5qiFQsxrnlsUHlOYOOktlSK7/BlcbX
         rIWXl7PCQAW+coSV5RvWd647R+u+V3BFCpYM34u6jcGu+3TOY43Nz7cypHi4JjkpKNLI
         mNwVP1uFyHiyL7R/0pqVxnvl7ipGvw1yhpcZuHgWSu67pkEfrJE0iPhMj77+C615WLi3
         aLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740293363; x=1740898163;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HHaUx5KktsdgA0Sl0DqP/e15F+R/KAQTbOxMnc+xT7Q=;
        b=AsyiRXsQVYqnrfBC1dmDjY5kSy6NbiZ9C9HQTzmxUAv/S3/bPluuNowxLfpsN4Rlua
         7bj95oeVK1cM3wQP9G8Yo0xj2MO6u+LqSIpz6MW9x3PdE+GtiCIrrANMRifXrpFZ8hc3
         C2KCdemf7WXkKtBAouK+Z8fUi5UTAdbNQicPaoklZ1kUikwTSLIJ+8p4aQkkJ6Rza3Xc
         mqkgzk7rO5swIp1YZeISTEY8FI37KIAEa53c7i5tYBK7HpPddrWfjIRHrwG63yM7y6cX
         KW+g15VcOSsMIkRKYLHa0kYNvGF0sOnRELT2kjAiPw50zPsXK7GejlAYausZBXdtr75a
         8vTA==
X-Forwarded-Encrypted: i=1; AJvYcCVzu938cn1gC0S9lMyaUPiDLfKMDzPCqD9mIZ3KisD2iVeLuFgdFnjvIsXnB/ySHuDyYzzlWhi4Z25t+W4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfx2WxO+mZIu2j2bbtooO1nObRqpfn3htkOvZZVfPyq6ohEIo5
	TJ3WBV4Wbo63JX+eBll/ur0AB8mN6zQ24Y3meqg/t3Lw/Wzi95KXtye+zRc4UZg=
X-Gm-Gg: ASbGncuW2pXVNDEg5KaPhe3sUNxGOrFExAVfvEU9i/EGWJgRiuUh5UBD1cr3Y/jlibO
	hvMvbaEx9oiM29+tIckCGwNRjLxidXHDryYmOA++QQzRp2/05qMPncWzVfiwqlCUNTE14CrxsIp
	wehgCLABK+TuZfqLpdcfFWhtbqgEoPDfZRwKE7loDhY3xij7gagxv6KV6HJ0kEBJNfAeEtIBnkS
	AHrPIyvchr3IAVJalqkalORoX1P6mngkbH093k5NBtK+4SxbcFfmOULMmBx5dYIKvt1C4a35Xaf
	961qytPLPYaaBwuEhzUVF2FV4XL/8lE3rbiiTH0nK8PdLrUVBw5VCIqTlrZ1AVBTCms7VNeLvlp
	niNvxdA==
X-Google-Smtp-Source: AGHT+IGXGcm4VljijD4pXFk056tlsVgzjM+6og539uN649E+iow88gvaZwo/9ZveWnY2W90sEPVm2g==
X-Received: by 2002:a5d:598c:0:b0:38f:48ee:ddb1 with SMTP id ffacd0b85a97d-38f6e95d5e2mr10084368f8f.18.1740293362786;
        Sat, 22 Feb 2025 22:49:22 -0800 (PST)
Received: from ta2.c.googlers.com (169.178.77.34.bc.googleusercontent.com. [34.77.178.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f64b0f565sm9517570f8f.51.2025.02.22.22.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 22:49:22 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Sun, 23 Feb 2025 06:49:17 +0000
Subject: [PATCH] mtd: spi-nor: explicitly include <linux/math64.h>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250223-snor-math64-v1-1-8c7653111356@linaro.org>
X-B4-Tracking: v=1; b=H4sIAOzEumcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyNj3eK8/CLd3MSSDDMTXYsUixSzlCQj80QTIyWgjoKi1LTMCrBp0bG
 1tQB6XFgNXQAAAA==
To: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740293361; l=1375;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=IrXufjhrtURNRtePzuFrUi3VXTx9hYR1zzTLpU4TGdQ=;
 b=crKQ/XDwuTSl008vBr29zYajmXhqcWOZjEjHLb7QU0d8jFL6mrUsGKME6beiK8SuBxYsPd9RI
 U6zsF201b9UCH1O3HoG93JVWpC27CZ3Yrhf4dptkHXvGBsJXJGp1TBP
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

swp and otp drivers use div_u64 and div64_u64 and rely on implicit
inclusion if <linux/math64.h>.

It is good practice to directly include all headers used, it avoids
implicit dependencies and spurious breakage if someone rearranges
headers and causes the implicit include to vanish.

Include the missing header.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
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


