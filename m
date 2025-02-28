Return-Path: <linux-kernel+bounces-538641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D42A9A49B4F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8770F1897C2B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFD326F458;
	Fri, 28 Feb 2025 14:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FPyRRFEQ"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C2B26E166
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740751647; cv=none; b=MEYOkKCz3H3t66zh/ovPpFaUjhqA0WQsbQ+U093PfEd2BsNW9K0pW/iHKObvD/AhZoFdAetqUhKFxwfx0DX0dCdrTGV9Mn+0MRn9n5yxb+rz7lKgbiapt9cxMR/W+sijAinNKrQV2dCUVfwcWHyRKRT8gtOg9+vDkAyLxl748ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740751647; c=relaxed/simple;
	bh=ivQXoPCDvr4W65W9v8GXK5+RniJhnQQTUBGH5MrKnmo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KNBcYFDLiK6NdZCYPB72jriUCd0DmWFLTV6TlRGxo/nmFQB4ND/YdifEGr8B7GQpijcb5LzPhWGrShn6V3BwkCPau1AnSDnoDWRuFzvuXgxYLvX8TyhEMUKRLvl2nIgDnlEuISrO7rXL0h9Dh+Mm5FVxKJ3ugfAxOuqOiN+98NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FPyRRFEQ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5dedae49c63so3851606a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 06:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740751644; x=1741356444; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MzZ6ILzSkM4BJ8jDBuhIko6B+Jnu0p3f7pMZfR82Jo4=;
        b=FPyRRFEQU31TIcx+DX4zzOdOpzaJ1Oaa0XMP0rD4nenhV8jOMuxWuTzyyad3e2NLb7
         +ZEZI6rzCTA3AWBUGtLCg2WeqOoy79RQk8HjEzw5HJpxftDaMgkDze2+Ay5i51vBVM7f
         Dwvjk/+ajfkXSxJ4FEDpMNikjqliV4y935iv0CNGoZx4glfqqdyDiKDtNsA+jN4z/M9a
         ph3lZNAw+5X95JZe+LqJM0t7n1lUnfXSVPfcG10pGy6ChMzHJYhZgYjZHrvSCbu6uZPS
         sTgsHZojZiAH9NUyM5bRzr+CzKNqHjSfYfybIljX+hI4bysZoJQp05zFm1bMR71zVn2G
         rnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740751644; x=1741356444;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MzZ6ILzSkM4BJ8jDBuhIko6B+Jnu0p3f7pMZfR82Jo4=;
        b=wosxfwns0PE2s7J4OVMOaYplc8sPF0r/noLtG76+cfivOCQRi6pSZOU1FW+oVgYr4f
         A6w+QgUfYEohlha3A6b1xPDv4nQgrc7q4MwawIyjhoe0Z//aFqkAgoMhGANqn/j9oXhB
         dju3hXq3OW3jzuDoGH2Iz8yIrLu3zR4ak9Zu55vI4wtGBjkJTL4q+IY9rr2JiMyU7oE4
         VoS6vE14zc/lPS3ZUgpKlcTN0KoeID7vzXfSaVLJMEb561U9tO7iEFSQHpBu5gyR8Mzn
         hc3/MJZJ/L2fTRa3kyGL0VZRiI513hHqg45SODMQrH4b20hcMsGMOYthBKb6rOFZsGIM
         KvAw==
X-Gm-Message-State: AOJu0Yykq0JDSEKYRfEQV5siTTMgLYTiZsDHTwoj+soz3UDJ5IX4sDuY
	a8CeOT0zOjAWUqLQgKHJOkerf6kuCR/LuUUDSZSoqqe6yJnHfodsDyrpyFrQmaU=
X-Gm-Gg: ASbGncvb6Qtotr2TA0tVD3zaCoJeCPhM2OlQeNvYL2iA7S0rfOAAFntQp4ore5Oh/t9
	cY0IOHyaSFpPILGYHhVv79UlXaCHtP6O6vqni9hjn7mZNhn2E+QPX3ZGynDga0RTGcRx67Geu6p
	XlvF+NPWDonR4uD0FHPt58IQn/sOiEuaN9SJBRTR/6kVFVVVVEMdOZVQlder9KVsvvkVgdEVsLh
	j+v1WrO3TeFzf8yd9hgJkRFRK96/ODZYmYzuNPVtegPwj7uqyWone+IWYl9rOpWA6x+NJ8che1C
	SZ7O9gxjQAQQEmPXATUBruvvrtEJIH1fBsDygdLOkBzcUkeOqGkN4RorI05Pw/T7DKEky2/PQHx
	hxHXfKMXNIg==
X-Google-Smtp-Source: AGHT+IESLHMD1ALp0fl5UNtQkvu55XFyzsWGAW2ARn4G0KwygGU8Ail6xNyHqVhAMNH9i4466iKXaA==
X-Received: by 2002:a05:6402:848:b0:5dc:d10a:1be8 with SMTP id 4fb4d7f45d1cf-5e4d6b0e6c9mr2959043a12.19.1740751643974;
        Fri, 28 Feb 2025 06:07:23 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb51f9sm2550839a12.55.2025.02.28.06.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:07:23 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 28 Feb 2025 14:07:16 +0000
Subject: [PATCH 03/18] rtc: aspeed: drop needless struct
 aspeed_rtc::rtc_dev member
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250228-rtc-cleanups-v1-3-b44cec078481@linaro.org>
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

The memory pointed to by the ::rtc_dev member is managed via devres,
and no code in this driver uses it past _probe().

We can drop it from the structure and just use a local temporary
variable, reducing runtime memory consumption by a few bytes.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/rtc/rtc-aspeed.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-aspeed.c b/drivers/rtc/rtc-aspeed.c
index 880b015eebaf796f68ed82c29998f345e1fd418b..0d0053b52f9b90a61725bf29435bfc8071977f9e 100644
--- a/drivers/rtc/rtc-aspeed.c
+++ b/drivers/rtc/rtc-aspeed.c
@@ -8,7 +8,6 @@
 #include <linux/io.h>
 
 struct aspeed_rtc {
-	struct rtc_device *rtc_dev;
 	void __iomem *base;
 };
 
@@ -85,6 +84,7 @@ static const struct rtc_class_ops aspeed_rtc_ops = {
 static int aspeed_rtc_probe(struct platform_device *pdev)
 {
 	struct aspeed_rtc *rtc;
+	struct rtc_device *rtc_dev;
 
 	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
 	if (!rtc)
@@ -94,17 +94,17 @@ static int aspeed_rtc_probe(struct platform_device *pdev)
 	if (IS_ERR(rtc->base))
 		return PTR_ERR(rtc->base);
 
-	rtc->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
-	if (IS_ERR(rtc->rtc_dev))
-		return PTR_ERR(rtc->rtc_dev);
+	rtc_dev = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtc_dev))
+		return PTR_ERR(rtc_dev);
 
 	platform_set_drvdata(pdev, rtc);
 
-	rtc->rtc_dev->ops = &aspeed_rtc_ops;
-	rtc->rtc_dev->range_min = RTC_TIMESTAMP_BEGIN_1900;
-	rtc->rtc_dev->range_max = 38814989399LL; /* 3199-12-31 23:59:59 */
+	rtc_dev->ops = &aspeed_rtc_ops;
+	rtc_dev->range_min = RTC_TIMESTAMP_BEGIN_1900;
+	rtc_dev->range_max = 38814989399LL; /* 3199-12-31 23:59:59 */
 
-	return devm_rtc_register_device(rtc->rtc_dev);
+	return devm_rtc_register_device(rtc_dev);
 }
 
 static const struct of_device_id aspeed_rtc_match[] = {

-- 
2.48.1.711.g2feabab25a-goog


