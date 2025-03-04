Return-Path: <linux-kernel+bounces-545106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B03CDA4E935
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08F7C189E58B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265F1290BCA;
	Tue,  4 Mar 2025 17:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zgH5+x53"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8517628D0AE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107940; cv=none; b=pSjBJAd163ku67wNAQFtIFfSpkMYgb9NKYec5zFQeHq5UiIdBKwdINFrKI3tdsloqPfvKshvyi3GqJ7AhLLkzSgZ5tU3SQ2ZiHsgDSw/Kf9igKvvRbbZiJTYwllBjwzNeFrBxvhU1p2mKPS1yBQA90dARa2FxmokpClzllY7BSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107940; c=relaxed/simple;
	bh=bdvX1BNhSG2fpjHo2VIxHhZrYGN28llP3/MopMlEtfo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LTy3gaizYIqKG5TsechVw4pBAf8mzDolG+3ZQarDlvpzZ7J3bkef1+PrJGZ+0oKmecy7WEE5fbMuuV8tB+wepoQHFlMA3Kd3gbAMqS9fYlulIlWTU86p8Gfal4bIyiNO9PnqiRuvZJbZufo2a9ZzNDBa7y8X+ChzerIaMiQGx/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zgH5+x53; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac0cc83e9adso20066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 09:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741107934; x=1741712734; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D0DbxfKxGvd2WW4HNIqxG+j4XJyJfuCMmLSYkWj7Rsc=;
        b=zgH5+x53GgY567EAqrqQQRqhEWpQo4fbGGD9KCWkD13ACPz0pLbH0oILvZkJP/nOZy
         3YVf4fEp8SBgheguN4RmtUYH+sS+Dput4mpcyDGPR/mkh08N+fdLLuiKbJHIDLHxQMcJ
         JuWy8ukcyWnUriTTB0ZlqmmSWiU9bPn88QAqT+Vnnfdg8cdZWm0ZSH8VXxVCLUuQ5M58
         KVR1eVChRiJZNLjExmO+1aDTcBvfKiVJsVyz/zn1vJlCzqafEFVPUkbjByDTx1dXDbp6
         hE9aZNR5sxcQRuzbjNlVfad39mh04vBdFVRdPYhfYhrkHbCiETHwOOYzquwiqDsRykp7
         4JHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107934; x=1741712734;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0DbxfKxGvd2WW4HNIqxG+j4XJyJfuCMmLSYkWj7Rsc=;
        b=ZuSuP9fC5ySU9ViAkr9o5brZfSLRaLb/r/frSogl/3PZS0KDDW75qhR3OVCDQbDQxJ
         SlTYqv2EO7TLxEKXFUbH7q2+WPtuxnknZFlsZEkuCFS7IhIXekYyfhaTwbc9PU+nRPIU
         soYH8MOF2e0twmmpO8CtNijCDrscrZ2Z4M0idlOupxUurtu+K2f2eETMLsJDewEDPmil
         TCSkVmrej9PgYa2BQR71mPpaDFLiTgkJSa1dgQA7Toxfz/IKYHFH0nujacW1MIEulugC
         /wbuGfMC8O1Fjzo9y6Qs3OF0UWjAsUAQIm4RHDrmqqH6AcAXNdzcUD/fP4n5TWnWlYZY
         yN0A==
X-Gm-Message-State: AOJu0YwJP6eDwBdi6ySdcj4R5bQLCSpDGicUuGeK9Oh7MsM82IRMcrre
	WvYFx86ssqQ4juC5dz7meynQNMJKKzLFnho01J9piQpJtiAa7ayNnmiu11r97Ng=
X-Gm-Gg: ASbGnctl3EYut13j/TEMWz9tXVlDequBC91SQdUmnvCJgJ4PUtluHH89hXagxO0QCPk
	943Txm8J67eG8t9+VzZKszncyMd7h7oBeuwBDXbbePF6luAKb0TsWjnCWSLyv6nJjJllfBWdTqV
	mOxErnOYKLI1IMBopskikJPMGlpddRlxub7B6P5uNJk9O//zIxzw9yme68CV52pN11AZkfaSkZ2
	mvHbXKEm1C8wJ16uyMucWBPRkdolEO3fo1t6mMOOIsYWGu1lX15qx1kcNtRysV1TuRxKe0R1az8
	rMfZSCiguHSySjcBosA3mNHYIwNM00JaXuoCgq9uYze8P6eGZn/KwYHuR2NR26Pd1taHnUyCpsG
	ep1hgtrmbQlD8kNw1FcfC6TZq1aJo
X-Google-Smtp-Source: AGHT+IGsdjvAcycMp31oFEdsdwWFqJQmXbxtDBoL5DRz6SC3HgSNRmbkL1ZXNDzmFm2b5aF1OyYNnA==
X-Received: by 2002:a17:906:c150:b0:abf:4a62:6e5b with SMTP id a640c23a62f3a-ac1f0e60023mr427555766b.5.1741107934486;
        Tue, 04 Mar 2025 09:05:34 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf795ba15esm367589066b.131.2025.03.04.09.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 09:05:34 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 04 Mar 2025 17:05:33 +0000
Subject: [PATCH v2 05/16] rtc: ep93xx: drop needless struct ep93xx_rtc::rtc
 member
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-rtc-cleanups-v2-5-d4689a71668c@linaro.org>
References: <20250304-rtc-cleanups-v2-0-d4689a71668c@linaro.org>
In-Reply-To: <20250304-rtc-cleanups-v2-0-d4689a71668c@linaro.org>
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
 Dianlong Li <long17.cool@163.com>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-amlogic@lists.infradead.org, 
 llvm@lists.linux.dev, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

The memory pointed to by the ::rtc member is managed via devres, and
no code in this driver uses it past _probe().

We can drop it from the structure and just use a local temporary
variable, reducing runtime memory consumption by a few bytes.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/rtc/rtc-ep93xx.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-ep93xx.c b/drivers/rtc/rtc-ep93xx.c
index 1fdd20d01560ef4fae2b996cf366b4f812329225..dcdcdd06f30d1ff6d0939f6bcad2c17c03c5a65e 100644
--- a/drivers/rtc/rtc-ep93xx.c
+++ b/drivers/rtc/rtc-ep93xx.c
@@ -28,7 +28,6 @@
 
 struct ep93xx_rtc {
 	void __iomem	*mmio_base;
-	struct rtc_device *rtc;
 };
 
 static int ep93xx_rtc_get_swcomp(struct device *dev, unsigned short *preload,
@@ -123,6 +122,7 @@ static const struct attribute_group ep93xx_rtc_sysfs_files = {
 static int ep93xx_rtc_probe(struct platform_device *pdev)
 {
 	struct ep93xx_rtc *ep93xx_rtc;
+	struct rtc_device *rtc;
 	int err;
 
 	ep93xx_rtc = devm_kzalloc(&pdev->dev, sizeof(*ep93xx_rtc), GFP_KERNEL);
@@ -135,18 +135,18 @@ static int ep93xx_rtc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, ep93xx_rtc);
 
-	ep93xx_rtc->rtc = devm_rtc_allocate_device(&pdev->dev);
-	if (IS_ERR(ep93xx_rtc->rtc))
-		return PTR_ERR(ep93xx_rtc->rtc);
+	rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
 
-	ep93xx_rtc->rtc->ops = &ep93xx_rtc_ops;
-	ep93xx_rtc->rtc->range_max = U32_MAX;
+	rtc->ops = &ep93xx_rtc_ops;
+	rtc->range_max = U32_MAX;
 
-	err = rtc_add_group(ep93xx_rtc->rtc, &ep93xx_rtc_sysfs_files);
+	err = rtc_add_group(rtc, &ep93xx_rtc_sysfs_files);
 	if (err)
 		return err;
 
-	return devm_rtc_register_device(ep93xx_rtc->rtc);
+	return devm_rtc_register_device(rtc);
 }
 
 static const struct of_device_id ep93xx_rtc_of_ids[] = {

-- 
2.48.1.711.g2feabab25a-goog


