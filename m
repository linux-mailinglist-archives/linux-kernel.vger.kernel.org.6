Return-Path: <linux-kernel+bounces-223671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D69A91168F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 01:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC37E283687
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 23:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20831153506;
	Thu, 20 Jun 2024 23:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eej2cq7X"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19E714D70E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 23:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718925226; cv=none; b=ZXruXEU4fRZyAWBvYwq6OOUI+GWOJaRZpZ5Dm2frYOaW5d+3Fw9CK8JDvYn8wQdcYcHZ9MX4UiLMFNNPgEwJipGbapL/vgH4HsU87mZPgS1ID5+4mLBCeJxg0qAGpn3P/daltyIia5QgUNDjVtIpcK7NUpFHvHkGJGESiMzZ+Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718925226; c=relaxed/simple;
	bh=voI/H6TF7EA0lAJZzYE8tRGijdTZkwmqvJoOJbix1bE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iChBJyCkRQiHMjK0GC9CHuF3pGbSnYaEpOx5z4EmnRJfaUIYpaIrQmj5j/zJyBUmrvKIqLwIlq+t7yvfmzVW6Bw7XXKnCRHlJ/JfM59zTjvpR6cMlepw1s1LxU4wqPWV1ooi2Wau6Yk44QuPOWgkt4NViEPdq7iilIVpi4j3wKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eej2cq7X; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f99555c922so803987a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 16:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718925223; x=1719530023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cJgtDYRGnxNR5uxsP8R2aMDXQF4TAj9PgQdzrH0jxc=;
        b=eej2cq7XYG8Ik10gqgI3xWhQhqA+rpPstrL7bzo6/HlI3M6ePNkIIVdaL7nVDNNXUp
         rrNyIi8ZZWoeLfND/aZCGwpHOEpbbTue1UWoi/XzJQRU1goJeZUY2F1zYBBusU1Me60Y
         QXeUuQEpOmAXL/YLZoQdGG6cjIjDebCZNlclwHwH/XJxiflHLr/RBtiQljCxaMZ+9jaK
         b3od2k5vTGHkZBNPT4bfxDE6S2vh4dBup19pB5eLiskkeGo1PZhjLpMjJPDM2fmvhE7I
         OPlea33X6cEBgBhnyfP9geedEsYq29ajC/8CKu6+DLDkbB7Zn4Tq8aC/P8FGANuan7Bz
         Qf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718925223; x=1719530023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3cJgtDYRGnxNR5uxsP8R2aMDXQF4TAj9PgQdzrH0jxc=;
        b=KesmIff28WRK+gohVvI1bRh1ufb/bCD+5e/AtxF78swR3HSAbVB0cuBrEtWQmQVd5U
         42AxI00w9one8kmrYc9Cimkr1UvwOqeb9seSP/pHmxYRL+q35cjGfnJv96Dz7Ea8PivR
         e3T+momd6gJKbHcFNte9Rl4z7I2JfaDCxurkpj8U3MV4dwsEEQZLAJ1vhqgXFq3c/A1e
         kelZ7IrzmDv2QW7/YiBnCUSYLio94mzsDOtX6UoXEWsarprUEtn/XD8Jk7wZvEnfXlCm
         nZiC6lg90OjEljSGhFQDb0udBuUMDcTHECLLFChiSDYF+1w3bMiLqdbKFGPpQdlZA6nV
         Eh7A==
X-Forwarded-Encrypted: i=1; AJvYcCWvZ3aB7sfezHLd8fLF8+9dcNdN5WNl9yhCaMfD9CbD1HFHONJx6ykWXzhJMXrsRx/Ql0O4+qWeWeNkH2onvHE+RFZOqp84GzEG/wSX
X-Gm-Message-State: AOJu0YxeOIey0DM/W+pZex8x9YsfgKnc2tCkVIS6ZtqzLUJDet1gc/te
	cTf5xbey+6XZqVOZmcNoJ3mYQHNmh10nGipSrn1oh9DDWYz9OTUl+y/v0n2S43w=
X-Google-Smtp-Source: AGHT+IFo/CfULEDzNMn3svBf7fPxTFvjTmzdPpeV1CFsheF7Pw04fqkYLYCT/ue0ZcXoBsHBHlK0pA==
X-Received: by 2002:a9d:7409:0:b0:6f9:a523:403f with SMTP id 46e09a7af769-70073f20008mr7815451a34.22.1718925223095;
        Thu, 20 Jun 2024 16:13:43 -0700 (PDT)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7009c60a4b1sm90529a34.47.2024.06.20.16.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 16:13:42 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Anand Moon <linux.amoon@gmail.com>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-samsung-soc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] hwrng: exynos: Implement bus clock control
Date: Thu, 20 Jun 2024 18:13:37 -0500
Message-Id: <20240620231339.1574-5-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240620231339.1574-1-semen.protsenko@linaro.org>
References: <20240620231339.1574-1-semen.protsenko@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some SoCs like Exynos850 might require the SSS bus clock (PCLK) to be
enabled in order to access TRNG registers. Add and handle the optional
PCLK clock accordingly to make it possible.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Anand Moon <linux.amoon@gmail.com>
---
Changes in v3:
  - Added missing '\n' in dev_err_probe()
  - Added R-b tag from Krzysztof
  - Added R-b tag from Anand

Changes in v2:
  - Used devm_clk_get_optional_enabled() to avoid calling
    clk_prepare_enable() for PCLK

 drivers/char/hw_random/exynos-trng.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/exynos-trng.c b/drivers/char/hw_random/exynos-trng.c
index 997bd22f4498..6ef2ee6c9804 100644
--- a/drivers/char/hw_random/exynos-trng.c
+++ b/drivers/char/hw_random/exynos-trng.c
@@ -47,7 +47,8 @@
 struct exynos_trng_dev {
 	struct device	*dev;
 	void __iomem	*mem;
-	struct clk	*clk;
+	struct clk	*clk;	/* operating clock */
+	struct clk	*pclk;	/* bus clock */
 	struct hwrng	rng;
 };
 
@@ -141,6 +142,13 @@ static int exynos_trng_probe(struct platform_device *pdev)
 		goto err_clock;
 	}
 
+	trng->pclk = devm_clk_get_optional_enabled(&pdev->dev, "pclk");
+	if (IS_ERR(trng->pclk)) {
+		ret = dev_err_probe(&pdev->dev, PTR_ERR(trng->pclk),
+				    "Could not get pclk\n");
+		goto err_clock;
+	}
+
 	ret = devm_hwrng_register(&pdev->dev, &trng->rng);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register hwrng device.\n");
-- 
2.39.2


