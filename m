Return-Path: <linux-kernel+bounces-538642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D63DAA49B57
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A9AE7A91CD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E480726FDAB;
	Fri, 28 Feb 2025 14:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="duu4VZEP"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E5F26E17F
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740751648; cv=none; b=CGh7euax5BdWjfPwN/bllDo0VP8+ozg3tzIQR+OCP6Fwr2cfFsfAfcA+wembTg+ZO3ulE5B4a1zaVl8wgj4y9M387jaXlIJ7P9n+ZDMy8Ga2Q4mCRdvMutErE3cSc33nVSCibOk6DrYMuFcGxdZS7RtMOesWtW2dQ2VQchFhSvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740751648; c=relaxed/simple;
	bh=ako7uKkoy0pcKOqw3JaomEgmXiZMMPwkguXI68dLj6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eUY5LuuFOVUbW3PR/K1fAcIDLh1iYaOFUTISlNWEAshe4Rhcty2MrWcFxHtyQfPIDqTgvuzYaQ4zDdnjhSZ/3weAxghfgZXURNLWV2DeJyIEz7n4rB3MLGId7Wq4iswKtIkIt0IVMcfG6gKhBR9ZTn0ZJCKGVG/7GAjSiSGsKf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=duu4VZEP; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abbb12bea54so401343866b.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 06:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740751645; x=1741356445; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PnUvUu9cMY/Mxw4Q1sllPthcln3NtgGY7cjKJANyPvk=;
        b=duu4VZEPZ8sGv25ffQJ+1bdz7r6wTagwsUflJFWNZhlu4PyYNBlvdwtqL85JQZ/66C
         pnbLUZCNHKvbwF4bHYLVonu4tX5SPwbXrV3IIKNh+gQOpW+EnMFnxjekQtQY0ww9WTJp
         C6tIMdiC7L9O4aTkd5mgj5wQlb+dVsbMdhS5fYVFma2u7QYSM1+0Kn3DNjRHBA8lA05w
         JH3gd5VC3kH3Vy8wRRS2CXNIPeqL9yBhk7EtAFoxQO/I+uYTKe3wXMsfEyIpCEQpXeEn
         Mqf+frzpnRT3kQBZ5+LEdVv+MeqIquLzOd4fT5q6LHiZKaReub3O2fC7RrV8a4M8Z+D3
         P/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740751645; x=1741356445;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnUvUu9cMY/Mxw4Q1sllPthcln3NtgGY7cjKJANyPvk=;
        b=oe8fy+BKyGtQACaT9L+SCwYIgh2U3/mjOULmLYbJuE8iutgNcfNlTrOZHFkLCROpq6
         ZO+prs02CXU3gvh4EMYZlvxIfr6m8T2X+uVTGrLx1Gpznfd5dEv5oLyrIWvseVOIn6zR
         2P66OsoHeij8BlsAGma+tTFDBxr/cwPYDN2oP5LWNJ9sGCq0JcnuRlSQ3nNUkEj8n6Jc
         l9I6SlkuZ3oa0uYoqHzHKxkEIIVXv1BkzaSL/4cHrSM4gbq4tHihODC8zhJV3K7zVzyN
         nN6OPhe2nG/Fva4atY86WCSEnhareJp5QmWLt5D8BY8Oe3vluOiK6jnceeKg5P7PnQNG
         rG2A==
X-Gm-Message-State: AOJu0Ywy0urB1gG2YZQyCHwq4q1yrSvmUw1PBxBpEqneLBRLmJiE1Dvw
	iV8aEvLBiTYCT8mRC6QyxQeAWPLWgO4CEVa7dIj0zwG4D9snBZX5uED4kflBHmQ=
X-Gm-Gg: ASbGncuI0uv3SpuEZ/DrlAWT8U5pHL/MnEAZA6uQEHvxS7ASyeNBnjDPYiy+1X2Fw+1
	nK46aWTcq1nGi0H8aAWoUFCXz9x14fBrwN41KkH2F7/aiqHMXg3s0vJFdRzFwslMACDU8H6ZHnU
	MuZ8nYKRH3DplHi/zoD/95AZGwAtrxoE9qg3ACRUvY4UOkv8k9K0sUo2wTxivCO8lJWjSyhg4f4
	BRjwIR0Tx77+SMySbEdfWkjnv/trVE9hWZYvY1TrKukMwu+6uM9rL8nGLuppfhsh4+Ca7BSjvfk
	wWXXa8W0iRu3owZAVYfiQNh/r+juNtWQcvwZ29csu8ZkO/CqpD64/BwIpfcvIm9JEfpvcPolvQR
	k7moSIkp/nw==
X-Google-Smtp-Source: AGHT+IFpdib5eLXvAKlYp3fUyW87rQ1IfZ8GEMoJsXuLGkDw56XS2aTZMwaUmenZ5apuVJAYF/Nggw==
X-Received: by 2002:a17:907:c018:b0:ab7:fc9a:28e2 with SMTP id a640c23a62f3a-abf2681f8f2mr377695266b.47.1740751644708;
        Fri, 28 Feb 2025 06:07:24 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb51f9sm2550839a12.55.2025.02.28.06.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:07:24 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 28 Feb 2025 14:07:17 +0000
Subject: [PATCH 04/18] rtc: ds2404: drop needless struct ds2404::rtc member
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250228-rtc-cleanups-v1-4-b44cec078481@linaro.org>
References: <20250228-rtc-cleanups-v1-0-b44cec078481@linaro.org>
In-Reply-To: <20250228-rtc-cleanups-v1-0-b44cec078481@linaro.org>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 =?utf-8?q?T=C3=B3th_J=C3=A1nos?= <gomba007@gmail.com>, 
 Dianlong Li <long17.cool@163.com>
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-amlogic@lists.infradead.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

The memory pointed to by the ::rtc member is managed via devres, and
no code in this driver uses it past _probe().

We can drop it from the structure and just use a local temporary
variable, reducing runtime memory consumption by a few bytes.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/rtc/rtc-ds2404.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-ds2404.c b/drivers/rtc/rtc-ds2404.c
index 3231fd9f61da49bdaf00e46486fc34836094ee78..217694eca36c3432a8db3b874374e347eeb802d9 100644
--- a/drivers/rtc/rtc-ds2404.c
+++ b/drivers/rtc/rtc-ds2404.c
@@ -31,7 +31,6 @@ struct ds2404 {
 	struct gpio_desc *rst_gpiod;
 	struct gpio_desc *clk_gpiod;
 	struct gpio_desc *dq_gpiod;
-	struct rtc_device *rtc;
 };
 
 static int ds2404_gpio_map(struct ds2404 *chip, struct platform_device *pdev)
@@ -182,6 +181,7 @@ static const struct rtc_class_ops ds2404_rtc_ops = {
 static int rtc_probe(struct platform_device *pdev)
 {
 	struct ds2404 *chip;
+	struct rtc_device *rtc;
 	int retval = -EBUSY;
 
 	chip = devm_kzalloc(&pdev->dev, sizeof(struct ds2404), GFP_KERNEL);
@@ -190,9 +190,9 @@ static int rtc_probe(struct platform_device *pdev)
 
 	chip->dev = &pdev->dev;
 
-	chip->rtc = devm_rtc_allocate_device(&pdev->dev);
-	if (IS_ERR(chip->rtc))
-		return PTR_ERR(chip->rtc);
+	rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
 
 	retval = ds2404_gpio_map(chip, pdev);
 	if (retval)
@@ -200,10 +200,10 @@ static int rtc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, chip);
 
-	chip->rtc->ops = &ds2404_rtc_ops;
-	chip->rtc->range_max = U32_MAX;
+	rtc->ops = &ds2404_rtc_ops;
+	rtc->range_max = U32_MAX;
 
-	retval = devm_rtc_register_device(chip->rtc);
+	retval = devm_rtc_register_device(rtc);
 	if (retval)
 		return retval;
 

-- 
2.48.1.711.g2feabab25a-goog


