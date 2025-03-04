Return-Path: <linux-kernel+bounces-545108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5CBA4E911
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56CD7420977
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA5B290BBA;
	Tue,  4 Mar 2025 17:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xQzxr+/i"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7822C28D049
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107941; cv=none; b=FcyT1D8pipPsRGK2ZUAGqTYUUyLmFlM1ZN+5DzCOqRxoU673b4MUjF5db6IYtd+fo1HQg/DOHJN/ImgKy8IPYHdUJDC9rIaz2SAWflD1+laeoqWUUHt1Az0V3ggZfIEjWTh8WE0s+xmpE547h3L9VDacxxOcU7vLXv1vBZNbJ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107941; c=relaxed/simple;
	bh=5X/V6j0KylZQYS62rYIRbOgl5vZsHZpGMMFoDJktKBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RfuirFs4EZqx9SBC3mgtppwuQKZIXEM5o3tp2T3qo9R7HfHi7tMkhlriIcIsdL7/ru3eNhok1cdGljeBjDCQurT1stOarmeZC/yp4r7+dKH6otm8EgwZZkpqD8MH71HI/EP9GyeqrbvunbsgFp6Sd9EN8SVZtwNGXQQ0qDf1cgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xQzxr+/i; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ab744d5e567so998012966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 09:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741107935; x=1741712735; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQ1rnmYNsg12IhA38qEJtyyMHRjZg5dsRkHMsIbiHfY=;
        b=xQzxr+/itgIRLv26IdzqbvN2KzIxpaBes8rvZIGhFUVBPxXQOcBugDgufa9uDOvCgg
         lWAHsyvVwG3IlvCkPdq2k99TqYN8FPvGtHm9y0MUKc1aLAeWgGk4PbLy4LkTg/I7y3rH
         1rkqFG6o+N+XTH1VEL2OSrgeK+hNYLH+yripsc+i49MEYZT91UXSbQD22qfp8uxJwbTX
         372emBqGRsl9yNXwyjzq2LBDYXqcT0ee+o4o3GskDqJaprn13m0JVldN7vrTEZz7f17L
         WaeMVWkaYIbanusqA0l1LddOTAYZ+WAGRQFfouLLVzwrmNcl/hg4ZRc+3dufDhPfhAfh
         BV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107935; x=1741712735;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQ1rnmYNsg12IhA38qEJtyyMHRjZg5dsRkHMsIbiHfY=;
        b=NHZxrnwonA/M6ldVRRYE/GlaVtkbIj7JF5frMXl6EsccbpNxdahzVRTkRZRLDdDwPt
         wiibFwHez6JkH5FcUccct0IYwKfIS6yHGvh7wnvIQLAxle5aEa4YqznT96R+rXvtg838
         e0AchQAv381YD1A45BnxPbcZvQASbQWCjrqekB/5Fp2TNHsoOsDSJR76Gw1AxIh3IKaS
         PbpOg+2LC6FUwkLp+Vpw+g/fDjHj9ir9hdyudzKwsJV5FtH2358i3xwZPSBNLBKc17LJ
         EtatgGgwgxypfu14+DnMgP25OKzjBKhVpPI7OpeFSclSOeYWLXe5FtAW0DfTIL9CL/tS
         1zmA==
X-Gm-Message-State: AOJu0YwcFBmB0IOnn0zBvNLIVsm9LUXGcbmR5ldJMkTNUzkJFJIM89Ka
	4QjcEPlfe4jIdltsTUOYjIEJO9bMMsHaHU1xrXKDNK5ZKkZuOH4Adq+V0BA03g4=
X-Gm-Gg: ASbGncseC+Urdn3zzB0H3g0hL1WoQSq47otG8gl0+eujYA5/Gd0VDmLSDTCaIoK9GpN
	6Yb+LpeZDNqJI4WFjHRsCHAsUPKKlmLCkEdGsV8QwfGc53wt37vzIBsJ/v+ENDFbIT+ezQ0eFh6
	s5JkdsVrcgR11X8vOqKIg+LCZACEyM1CFgDi6oXYSheOzJ2tuuN/bkzI++R4TYucoHEQNYmPhY0
	0+BVPH7Ei6hnJpEbRTLt4+rDuS/hDwXlsiOh12Mds6gA4BLrq2NTiAUqsD7shC4AZDL1YamOnZm
	SG9CUpnVzGzbl+UCTGsSPu+6OPZAZYTxVXmydkBg5DG6wVB9AReW5rQGcwbQmrRRmp/MRlTSctL
	omIe2u8zlX6oCsTsgbzJIEpMWiMlm
X-Google-Smtp-Source: AGHT+IEctYzZlVVwQPucj8CUHKEVuZPV8n583Yq6QohmEvkW8JU3S9SRTA4/uuDakASHnMKJ8bAleA==
X-Received: by 2002:a17:906:3814:b0:ac1:17fe:c74f with SMTP id a640c23a62f3a-ac1f11e6c1dmr291303166b.21.1741107935167;
        Tue, 04 Mar 2025 09:05:35 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf795ba15esm367589066b.131.2025.03.04.09.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 09:05:34 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 04 Mar 2025 17:05:34 +0000
Subject: [PATCH v2 06/16] rtc: ftrtc010: drop needless struct
 ftrtc010_rtc::rtc_dev member
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-rtc-cleanups-v2-6-d4689a71668c@linaro.org>
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

The memory pointed to by the ::rtc_dev member is managed via devres,
and no code in this driver uses it past _probe().

We can drop it from the structure and just use a local temporary
variable, reducing runtime memory consumption by a few bytes.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/rtc/rtc-ftrtc010.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-ftrtc010.c b/drivers/rtc/rtc-ftrtc010.c
index cb4a5d101f537e20a685bb022e6f6516b0df8271..02608d3784958e69ec0ecbdb9fcc8b333b19e7cc 100644
--- a/drivers/rtc/rtc-ftrtc010.c
+++ b/drivers/rtc/rtc-ftrtc010.c
@@ -28,7 +28,6 @@ MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" DRV_NAME);
 
 struct ftrtc010_rtc {
-	struct rtc_device	*rtc_dev;
 	void __iomem		*rtc_base;
 	int			rtc_irq;
 	struct clk		*pclk;
@@ -113,6 +112,7 @@ static int ftrtc010_rtc_probe(struct platform_device *pdev)
 	struct ftrtc010_rtc *rtc;
 	struct device *dev = &pdev->dev;
 	struct resource *res;
+	struct rtc_device *rtc_dev;
 	int ret;
 
 	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
@@ -160,29 +160,28 @@ static int ftrtc010_rtc_probe(struct platform_device *pdev)
 		goto err_disable_extclk;
 	}
 
-	rtc->rtc_dev = devm_rtc_allocate_device(dev);
-	if (IS_ERR(rtc->rtc_dev)) {
-		ret = PTR_ERR(rtc->rtc_dev);
+	rtc_dev = devm_rtc_allocate_device(dev);
+	if (IS_ERR(rtc_dev)) {
+		ret = PTR_ERR(rtc_dev);
 		goto err_disable_extclk;
 	}
 
-	rtc->rtc_dev->ops = &ftrtc010_rtc_ops;
+	rtc_dev->ops = &ftrtc010_rtc_ops;
 
 	sec  = readl(rtc->rtc_base + FTRTC010_RTC_SECOND);
 	min  = readl(rtc->rtc_base + FTRTC010_RTC_MINUTE);
 	hour = readl(rtc->rtc_base + FTRTC010_RTC_HOUR);
 	days = readl(rtc->rtc_base + FTRTC010_RTC_DAYS);
 
-	rtc->rtc_dev->range_min = (u64)days * 86400 + hour * 3600 +
-				  min * 60 + sec;
-	rtc->rtc_dev->range_max = U32_MAX + rtc->rtc_dev->range_min;
+	rtc_dev->range_min = (u64)days * 86400 + hour * 3600 + min * 60 + sec;
+	rtc_dev->range_max = U32_MAX + rtc_dev->range_min;
 
 	ret = devm_request_irq(dev, rtc->rtc_irq, ftrtc010_rtc_interrupt,
 			       IRQF_SHARED, pdev->name, dev);
 	if (unlikely(ret))
 		goto err_disable_extclk;
 
-	return devm_rtc_register_device(rtc->rtc_dev);
+	return devm_rtc_register_device(rtc_dev);
 
 err_disable_extclk:
 	clk_disable_unprepare(rtc->extclk);

-- 
2.48.1.711.g2feabab25a-goog


