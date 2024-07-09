Return-Path: <linux-kernel+bounces-245845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6481892BA65
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92AD287D10
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EB915FA6B;
	Tue,  9 Jul 2024 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kOQvBcZl"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8824315ECC0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720530039; cv=none; b=eGiwc4EdIVYuYrY24BlqpUZHPlIeNebaR7fpmOkh1vx44/A2BbjKXKW3kexudcrNAEcEb1HgwtbA7nWXq1mhZ4EzK8WL5KgUXddlzusgLYTN3n+jS85bOqOjf7mAZKyHj4hZrMiwpOfr//w2rxc58wUoa5sOWbN7sRa1lMuMass=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720530039; c=relaxed/simple;
	bh=+k/lazfX5D4DO7g4zI2vHTllaVZsoH4j2XRnMTI6hrs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qefuPfe7C1GumPkxvS4ngSU/u/bOAffnX+DTQ5isuFeRhPe8QEgm9kGefDIQT98d0gWnfnrVoxY2HzqbXh8b59HUQ09RccCMrdK4Aot9Rk+akQglj03UvvqTCwfbIAA/f85j4sE2oAAxMv8aQbtIZUJLsnxPH3mkFIShFkl40lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kOQvBcZl; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a77e7420697so383406566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 06:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720530036; x=1721134836; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fKJKj4ePRCM54jEU3GVYM318cCZM40CyMC5+JEFGxVk=;
        b=kOQvBcZlkCELTcZyoQ9HurptaBE6081pIO/Ogt3+zcYDL39CsZVM3ETJcMKvgUpg8g
         JOzOjQTOl+477FhiC8QHqCtYqbcrZAnUqiKNY0oMtbmk20LcXy2E1KSqGWCmVc5TDYWS
         p6Opoarmb1u3wswcN3nsGItVAjlS4a70OPiOnWBTRJuk6CkxKQiOrfPssrrXTpNae4ci
         +/iJrQRVV2c8eZUszwKjT+MwrxzjNmKuEarSt3XSiJE31UQQWZARYZ2QF6hD9+b0d27N
         Vhwg+lw5OiqJ0G22fqnWkcKANeQmsjL7+31WvKnqgPJxcg9wCUrzrsimgMxYGw8iu+1+
         yx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720530036; x=1721134836;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fKJKj4ePRCM54jEU3GVYM318cCZM40CyMC5+JEFGxVk=;
        b=cPH8YfOBf0nm4V6ZDsc+RxyAs0/O2LbhxvYLLXv6FEd6cdPyqS/QNP8ONNm2FgA3QC
         vcpy+QtVvMxqjrVlhCamhAMNmtyiDQC9ittEuR34/V4G962MvRhzcaJFMvsxCmAzatnn
         VXaGcYUrWjGKZ55H4OKzJOEeGl8usHKkzDhAOP4nJGRaKR+EYru51P+43kwNyJX4Jz0n
         MLNlSZ3goYmxLTDWu3cxNozNUkIwRzzMsDMXrJkOjg0TYkokhhDtin/2GHP0F6QM4YrF
         joQ1FC5z3VNF4Y0ACv7cdRBtrK/ghKzVbEj6+yvKYX/e/vfTmltUrWNXA2IcSLc4WKFc
         HcNA==
X-Forwarded-Encrypted: i=1; AJvYcCX/l9iQ4KC9QYDvW///voIo1hLe0SHcImqVu70YWScvATskPlmHF3hvsazmVXZOUE7uNCZeSMf1JV6l+Zeqr+PBAWMn/g3enwLVNA1t
X-Gm-Message-State: AOJu0YwkZI0DJQ40Fnm2/SrY+hYOGbJz8ePCvXA0SW81vtWLwVpjBPJR
	7ztQxqNCHqJzSBU+XYyXGpOf7tt2xcxBgdZVSZk1SIoiiACMQwsZKXUFuJ8gE/g=
X-Google-Smtp-Source: AGHT+IFfkk9Ys5H4+GIS3Y5lPnmbtnsV3RBNMXH4S8d48mmpM+eZ7xVV/K5ZmahmLNMktfUV+pQZMg==
X-Received: by 2002:a17:906:36d3:b0:a6f:b58f:ae3c with SMTP id a640c23a62f3a-a780b6b1b96mr159741866b.26.1720530036104;
        Tue, 09 Jul 2024 06:00:36 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6e157bsm76643166b.80.2024.07.09.06.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 06:00:35 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 09 Jul 2024 14:59:42 +0200
Subject: [PATCH 12/12] thermal/drivers/generic-adc: simplify with
 dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-thermal-probe-v1-12-241644e2b6e0@linaro.org>
References: <20240709-thermal-probe-v1-0-241644e2b6e0@linaro.org>
In-Reply-To: <20240709-thermal-probe-v1-0-241644e2b6e0@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1014;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=+k/lazfX5D4DO7g4zI2vHTllaVZsoH4j2XRnMTI6hrs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmjTRG7Kse7IUgMVRX4NLV90g5K2qD30euBH5Pl
 gWGaMK8maKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZo00RgAKCRDBN2bmhouD
 18nEEACI7gxKJvuvASog8vwzRg+a3PvfwZZHrDeguyKmTBJ46V5YCiPTvPJWRVtWUqdAMUfcsAW
 IhEdMHzSmWOUHTcfTzDHc8O7vvAT8KCZjGFJ43RMUZb3he1BN3Hp06JDNSqEf43CuJg+v+5a545
 X5eNDx4RWWWh9zgEO9QzlypsgvXdE4LK4IPu1rs1ChmI8pswR04JWPcfOWCFhLuNGaByjtoPYQs
 U4lSOh77uqNdYjaSuxJa0xSdFyKJtxO0prRNorCSpZ3gV1xZv2zG82eAQk7TwM0bSgWEq7qg/2A
 YjlXyoPq9ql12lRZM+95d5OmHGaouY7kK+uWEDUBu+OcEtEizqh2+nieYVSapi1VlfMNRV3n9vq
 Pzq6vxcnyu4p4GjdKVYkG12RIcI5nLVWkuTA66ZwV5e4OSgs/JpkAok1I5ohrJjx8hL/JesxirT
 6KLStUBfXk6SIqMuRSdiPu0hiwweitRaR51TkzYUNaurLAyaOkorxIAoWsJOImpTw9lOp/7Qjbc
 i5DLWLYegu0qdnia+oFrLWRyZ6bLRZ/lRQgBvq04AViCRNSyKbaDwJ6CiHd1ZKotEHRNIQ+cRj+
 h7OhqavBXLHl7a8nYZlx08NNjImhGkT0HKk6NShnr2C+3pQXATuTFyePUpudMTQSEG0jiDqlcDj
 lMHGtvzQpjie/sw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Error handling in probe() can be a bit simpler with dev_err_probe().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/thermal/thermal-generic-adc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index d08bff91ac3d..ee3d0aa31406 100644
--- a/drivers/thermal/thermal-generic-adc.c
+++ b/drivers/thermal/thermal-generic-adc.c
@@ -131,12 +131,8 @@ static int gadc_thermal_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	gti->channel = devm_iio_channel_get(dev, "sensor-channel");
-	if (IS_ERR(gti->channel)) {
-		ret = PTR_ERR(gti->channel);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "IIO channel not found: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(gti->channel))
+		return dev_err_probe(dev, PTR_ERR(gti->channel), "IIO channel not found\n");
 
 	ret = gadc_thermal_read_linear_lookup_table(dev, gti);
 	if (ret < 0)

-- 
2.43.0


