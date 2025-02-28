Return-Path: <linux-kernel+bounces-538643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D81C0A49B61
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB81F174FFE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24310270EB9;
	Fri, 28 Feb 2025 14:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aHZl1Ad4"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B6F26B96A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740751648; cv=none; b=rPcn3sRpQ5bzJLg6tUWM3gSgtVtVwjVy8DQDwX6/cbP2yfh3PFlOf7CpMz0b5lZICu0mGMjcAHzDQk0ueEPVpwW0OKIP7dfAtw3yfDqgHGUski0NtMSpmZciZMbWZybc+zimYizGH+AckYg/iFgpuLYZgGKueLkr53e+iV9sRQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740751648; c=relaxed/simple;
	bh=bdvX1BNhSG2fpjHo2VIxHhZrYGN28llP3/MopMlEtfo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yn8bETLkjeLhXnBGnMGFhWv5Yw2HgtEPeScqL/MEnkU5OjEQuVLlgpBOnjhgsKaiWwSVWfBIZMdrN1NSbESFXRIBcfEUpYxeRUAtqMilnFmmKGnbt4JurYAJOSAYLwDCcY9DKqL/eoDQomIHES2DDmRYu/viqMr8XbGKGaBPubA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aHZl1Ad4; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5ded1395213so3473751a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 06:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740751645; x=1741356445; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D0DbxfKxGvd2WW4HNIqxG+j4XJyJfuCMmLSYkWj7Rsc=;
        b=aHZl1Ad4ompIcur2hu0an/nxVD3UiTx08uuAx9RxwiUJSD8uNxXGbECXAZKfMIlMsl
         fuca+nN4dNQzmapwQI2U9IskXO9UIKHA+UDiOBXfn0chFNjjStaUEgCJ9r8rJxS3Dv+m
         ivtjvL1oK5v9Jg+h4GQFt0ZB/gBHt3UH7ZS25VsqpDPKwv8QkjMrszryqKZAAZZ5Soxj
         pBqCwMEODoNSRthPKRw1J1F2jTjiGy0V3Oss+LvVfYZnBRfLLLagqml4pnvoApOvIsyL
         gCz3YqCCdN3rIyQ6hoyMUAUMKlBoJdEGZPqWERrOfU0uMRuce5FnJ8U9hesUpA34Os1d
         RHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740751645; x=1741356445;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0DbxfKxGvd2WW4HNIqxG+j4XJyJfuCMmLSYkWj7Rsc=;
        b=thcxcAQBUbz9EdrzbSOQPWzlZvwDnkaRcg+6es1o1w+0fvqWCSp1RZxZAEitBB8gXt
         ZCXsLY9fK/Az8NBfKFm9MahDE1LvtVFQ+VdyndxOCNuH6DZ0zcO2zwjN2WLzjGR6bsbj
         kY6cX+B+k+Q6svmPJIo5elYbqUGVdyFKt1zrELaM/mkw7A6fzp2vz+7m8H64tZP/Pzmz
         BqAtqeKc/bHceHxm12OvZjhHIFV8lZ+cZXP4fbkuagnsj9w8ctaewRBhyEUcagp/zBDK
         6XmAogU1cn34I0ECQnVdJiHOx3I0ZbgNNdiXlG/Ha3c0T0pXGgmsdZdkHC0C05Dsyn6S
         ya2A==
X-Gm-Message-State: AOJu0Yw8PXn7SZhepdEzAEDJiFZC2NNDBTCmogRGNpkBxZ+VpG0T+grw
	QWyE6NEQKt0S+ctqCOlIE+XaDnxm4Lpgc8ERP8J6FvxRR6IdTnQfFew8UDvwnLQ=
X-Gm-Gg: ASbGncsPc0Xutm37QYYctGKcNYzo9L3fr11OWbBo/0zxyXrOtGV4K4uD3KyFTB7JwFX
	vgNcsvcX06eE6HrrWUuiv7Q2hQYkDVg6O7jU6+eCnsvvNvHweEchYy7iZ9AFtl10d/XfUmk3LMv
	qI0Vny/HHPyeMyFM5eHSFqt7EI30plvchq0kgq4EtAopsgNdsxbGABz+o5iM9572LXtQnZL1ITu
	/LXIRXqMKQBdun/gJ5m6u2ggyvCVVxSqAILfvlSI5hgi7BkNReGkqjWE1lG7OeRr6K2jeBvouKP
	MIxMB1KJ1/0BtqJ2ZfUOZp+0QE49Io1a2soCK89JmK37Um5LXHJ27OJksNco5bLHZgwi6Yr6xpN
	D75TBmBdjPA==
X-Google-Smtp-Source: AGHT+IFjP5A5it0oOhAqjGMiq+zBlLn6/wyStXZ9TEpg3CsfQx18Ux73fzaAw5ZlIGleu7roV3QB1Q==
X-Received: by 2002:a05:6402:84d:b0:5df:5188:11cc with SMTP id 4fb4d7f45d1cf-5e4d6b702a7mr2552045a12.20.1740751645245;
        Fri, 28 Feb 2025 06:07:25 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb51f9sm2550839a12.55.2025.02.28.06.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:07:24 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 28 Feb 2025 14:07:18 +0000
Subject: [PATCH 05/18] rtc: ep93xx: drop needless struct ep93xx_rtc::rtc
 member
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250228-rtc-cleanups-v1-5-b44cec078481@linaro.org>
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


