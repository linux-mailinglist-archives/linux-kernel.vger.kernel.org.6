Return-Path: <linux-kernel+bounces-321538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D35971BD2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF2D2846A8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF371BDAA7;
	Mon,  9 Sep 2024 13:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SpU23G7J"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07AC1BD518
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 13:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889924; cv=none; b=fTAiP0lQw8L4KR2x7xs9QrajcSXO6RYrwxRljq+Xa64E/NewyvTSCnULzqKQ+6zNCfh8v/Oh/qRfX9rGpOhaWhHdkIOakS8NCXl0YDYKwfoyMwXzm877knSQUDHNnPjmd0qX22zWj9+hJSEXnJex22pnF2FQr2p2s0OgpkqL2yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889924; c=relaxed/simple;
	bh=30I+hQDkibrC4fpctSIcG7hdlAaMTfnXmLnvdZibnpU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oomXw3o8QZWS0O1zy8LiY1jAARbhHOlxfYYKWpw+nE0b7dA8ETlCnwmNMNUSgoiz24Cpj+Ly0+z0BIUj/OiiVMwokTSXGVpxt0It5FPMWWjpHs1kTidkcH7depUyhlM4p2SWSHAxCPIFO2LnH1rDgVDK9z8C3kaRsJ77QTIrv1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SpU23G7J; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c255eab93dso416863a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 06:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725889920; x=1726494720; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Qz5yF8W3jl1pLAFz+0oNTHhctIS0pggkjmDEQxrtgU=;
        b=SpU23G7JvwPVip2PWQ5P8j1Q/c4+OFN9lP5fidFKUJ8ariFjLySEXNeDSh8mmNpSsI
         DI+3XUMeOJMhF6SuSncLC5sHie+N4D+nRp+6GqPxivlKbCGfLr+kQAJbtfQsS1CrpPfW
         knk5NqKqQgErLgGGGYsg3Eg6R66fM7+CjVrl5a3n7JsYtF5HK68xAviRKNlLH1q+PJGv
         HHXNGQRTWd9HPFK/e1DKKqGjQMeAallamqjWo93MspWYZ4NKkmotQ1yJXIeoNcOrwDKT
         74HZGezE24NpCyMdaHxgCed9vHe6gLmXRXqwdvitljWsay5xakCKXENBdI+dPDcknnCp
         qOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725889920; x=1726494720;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Qz5yF8W3jl1pLAFz+0oNTHhctIS0pggkjmDEQxrtgU=;
        b=G8deEQQajmnLbs1ArfCwBlFtjEBVuRHPJ4yhB9DHjtsX3oECDtToGwxtSp1fYyHAY4
         77R6Gpx6n1zngISDRJVbTeziV45j529EKPVf8ymr7dF8Oq1ofJjNm+fcyouX1iqE6dfL
         7uQozLnLr/DMqpzpIxXghH/pl1686XMNaWdVGWtjljKsDAEiyQz0yqjfUP5zJt47Haho
         mmie9qxYcBTrigXKAbQtL+fp+mif0wI/GLoMNMBCHbcfuuUNYgk4gap1KKN4ALOraL3w
         BURlRyj6xizuP8Y3Z+aKQSJ1LE7pJk1DRPv0yZbP+/6ep8jUyjih3bVTQJUgw7tlGgjY
         JjsQ==
X-Gm-Message-State: AOJu0YyaJHT82zwNzeLvUoJZW1f/KzWFxJgLyvZV6il2ys01Qt6O3O88
	53nCqSKXGusKmj5mdSYySs5d1BC8buC7HAiKHQQwUX5qb2HEHa7BcjVzffUGSdY=
X-Google-Smtp-Source: AGHT+IHSuAevAtPCygtpKBvr/DQWy/NsHdMyERpLS/rDXi0gGwd6VC/KF5cHqYfeuGYHkbx6t4QX+w==
X-Received: by 2002:a17:907:3f9b:b0:a8d:2623:dd19 with SMTP id a640c23a62f3a-a8d2623e2b7mr190904166b.14.1725889920059;
        Mon, 09 Sep 2024 06:52:00 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25cf3ad6sm345344566b.148.2024.09.09.06.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:51:59 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 09 Sep 2024 15:51:26 +0200
Subject: [PATCH 15/17] regulator: hi6421v530: Drop unused 'eco_microamp'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240909-regulator-const-v1-15-8934704a5787@linaro.org>
References: <20240909-regulator-const-v1-0-8934704a5787@linaro.org>
In-Reply-To: <20240909-regulator-const-v1-0-8934704a5787@linaro.org>
To: Support Opensource <support.opensource@diasemi.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2350;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=30I+hQDkibrC4fpctSIcG7hdlAaMTfnXmLnvdZibnpU=;
 b=kA0DAAoBwTdm5oaLg9cByyZiAGbe/WWgVe4Femx5zZkMkuSdYYU3T+Lo1v/39prjIzLzFC2Rk
 okCMwQAAQoAHRYhBN3SYig9ERsjO264qME3ZuaGi4PXBQJm3v1lAAoJEME3ZuaGi4PXrZ4P/jA0
 sscxqGelVqRBLU11Sgi+WZRl0920k7u9YS+qTqrF3B/ixnO5gkeFkh4TidRddSqKEWj+bKpdvWa
 A985jl1aSp2A42gfSWC7SYcXBpCgXKPR3E5di6RpAUS2Msj8yuwD7dJudEhah6wq+pYlfCNcI3t
 gdcDxs6cY8+kbdmCsRWXDs8X6PqojXuAlNlKPH9FrQolgKicOVgYfXvyQQrBFRcCrrFHgpPyhZT
 QMQ4Y+Vcxj5WAg057JH9m2BMVVmcUppJSaBoc1Yz1EN3ZNTm/OZY9lDFywruf24uW6wlZHz22NX
 RmmZIeW1AUBK7ZpSDY1/R74lzoVOH4CDNVotkjknx06o7Tme2QRHyUQdhghK73hGa4ojfkfM8sT
 QJ5FWuKNPfujqXIuKg8+xL2slkkJ+UJXYHL1SsIbNzNaulZXEXiO+TAJzDcChJskzf4NE/BRG9G
 jRPXYkMladjtkLEgp0jvX8Jg88lqSaM5XodDAyrrr/qjRcWLaFpKb4NIG8dViOlRndyg6o+pT0o
 kZWiKXuuzuoTtzqisFHhoSOsmDWPwmBHu2SSsFqQ0oG8eOsi3v+jwn46ji9DwGcvQu79QkLAOFq
 32/amHyTfCBs9oqbF7lZOKOeBYNkW88NZysVNbLHkW52ifnuyjykX+2B4b/QR4BpGZTi4B2bPRP
 fQWF8
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The hi6421v530_regulator_info.eco_microamp is assigned once and never
used again.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/regulator/hi6421v530-regulator.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/hi6421v530-regulator.c b/drivers/regulator/hi6421v530-regulator.c
index 23924ff0c7b2..a9c6c077f50d 100644
--- a/drivers/regulator/hi6421v530-regulator.c
+++ b/drivers/regulator/hi6421v530-regulator.c
@@ -21,12 +21,10 @@
  * struct hi6421v530_regulator_info - hi6421v530 regulator information
  * @desc: regulator description
  * @mode_mask: ECO mode bitmask of LDOs; for BUCKs, this masks sleep
- * @eco_microamp: eco mode load upper limit (in uA), valid for LDOs only
  */
 struct hi6421v530_regulator_info {
 	struct regulator_desc rdesc;
 	u8 mode_mask;
-	u32 eco_microamp;
 };
 
 /* HI6421v530 regulators */
@@ -68,10 +66,9 @@ static const struct regulator_ops hi6421v530_ldo_ops;
  * emask - enable mask
  * odelay - off/on delay time in uS
  * ecomask - eco mode mask
- * ecoamp - eco mode load uppler limit in uA
  */
 #define HI6421V530_LDO(_ID, v_table, vreg, vmask, ereg, emask,		\
-		   odelay, ecomask, ecoamp) {				\
+		   odelay, ecomask) {					\
 	.rdesc = {							\
 		.name		 = #_ID,				\
 		.of_match        = of_match_ptr(#_ID),			\
@@ -90,22 +87,21 @@ static const struct regulator_ops hi6421v530_ldo_ops;
 		.off_on_delay	 = odelay,				\
 	},								\
 	.mode_mask	= ecomask,					\
-	.eco_microamp	= ecoamp,					\
 }
 
 /* HI6421V530 regulator information */
 
 static struct hi6421v530_regulator_info hi6421v530_regulator_info[] = {
 	HI6421V530_LDO(LDO3, ldo_3_voltages, 0x061, 0xf, 0x060, 0x2,
-		   20000, 0x6, 8000),
+		   20000, 0x6),
 	HI6421V530_LDO(LDO9, ldo_9_11_voltages, 0x06b, 0x7, 0x06a, 0x2,
-		   40000, 0x6, 8000),
+		   40000, 0x6),
 	HI6421V530_LDO(LDO11, ldo_9_11_voltages, 0x06f, 0x7, 0x06e, 0x2,
-		   40000, 0x6, 8000),
+		   40000, 0x6),
 	HI6421V530_LDO(LDO15, ldo_15_16_voltages, 0x077, 0x7, 0x076, 0x2,
-		   40000, 0x6, 8000),
+		   40000, 0x6),
 	HI6421V530_LDO(LDO16, ldo_15_16_voltages, 0x079, 0x7, 0x078, 0x2,
-		   40000, 0x6, 8000),
+		   40000, 0x6),
 };
 
 static unsigned int hi6421v530_regulator_ldo_get_mode(

-- 
2.43.0


