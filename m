Return-Path: <linux-kernel+bounces-187348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E66F8CD083
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7FF1C2263C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B37144D2D;
	Thu, 23 May 2024 10:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UQtSelnk"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF88142621
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 10:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716460966; cv=none; b=ORdXoVyWijp+wFMFGooSDIHEi0rmUac5gg6REHf1KiLI9jw6YNvGbUoqZdpPIo6lpD6kyEvYGoM2FnmlWvS7ULkA/sXqTdteFTEdS04cNF3Sg7BzyqlU7IaFmEWjxLCzWL4n1W1/i4gfj055j3nUappAQGicV4qp8G++Gw7rZsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716460966; c=relaxed/simple;
	bh=UBeuVMZQYYhKbOOdHR3ji3rEEx2lEwD6H/stYiw6k2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fd3wkYPhaOe6tg6NHVbobwmLSyEx66LUxbR1DqFyvJMavy1OJPUSmXY5/eG0qzoUGMT9ktQ0zQThPuTX6r1lrN4clVSAcL9B0Iu/lNiNgTXWEiTKadirbOVIq23zE/FSeiFqxpzx602PlvmspW6acX94B2xJTidOudSnFNiLPLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UQtSelnk; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-354df3ee1a9so1533859f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 03:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716460963; x=1717065763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6eeiO4mrF2NxAeMZaGpIfzMOBeas/sv1NyjRZNd0RGU=;
        b=UQtSelnk8HfCNf+J+eXm/yR7bTOiDE6cGLbBmmF/WJAieJwZ5PsJhcnxx9yrN8FpTk
         TNQYm+wQn5jdM3NApK3RJVXodDwKfV0rlrCRXaHLBnikE82VYL/spaV/6jDEupuxj6DS
         2xxpzc2EKeDEoG8s+D9Azkr8zCXkwSQhREXTzoBEMK0XAm0pZ9FQ5ayz2SbC5Lqrb/0v
         AtgZTwtDKSVuwr5+8bcDB01ExwaHhLmNReGjf8HJUHHRmW60m73yv07sBFUv1LuRRCba
         1dDmLIrAFZgCi1ZxSakqgKUB2dhAVYabmMkmyD5yWTaX4Js3rzboSmutHsV2vr3vaLSM
         qheQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716460963; x=1717065763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6eeiO4mrF2NxAeMZaGpIfzMOBeas/sv1NyjRZNd0RGU=;
        b=HhpSrcnt22/ye3UIR7s3iJYjsZpp2ruypg2YAF4BfnV9LeH5L2uAyEwIX3X5jMYAY7
         xpFV1qgbmTSGi9oGxDD2CnEnhKPtk5rhaPPdJ0AFbdau0pFB4fn4LLqgx0ApAXDARD6s
         szHWckMcfOIqMrmVlrgVzmEpT+vnDwPbgBsSUGhS0AR6mrlHr1pzFNsC/vqkvAEPp1/t
         IxmNa29Rv5hKXF4CVD6gCckcQeIBsgaJ31h9HfH5nZ4/z9gQCUnvGyTKAB0BHedVfFA8
         bdaKoZt6gqSBIvcqamj6UsbZNi7M+fSoWvj4WOEXLbeRmhx5Uzv5hjC2IAGLntyqguFQ
         BsRw==
X-Forwarded-Encrypted: i=1; AJvYcCUqSLaPStPgJ4JyQzzP/p2lXtOuaqqQu58X6cZ1sTAx40fF2Y4QBagCbl18tGs38PwzKaM5XLO+SBt1X+c6fZ7SaxTm3l2iNbMU2YbC
X-Gm-Message-State: AOJu0YwvNVK/Cve0pPo4JgQ22LT8w/7fiAHrh0wxpkrsZeUL6lz64BZC
	NMtBRcWIGrTCBmbgWQwVZM+fc9H1YAsVNE02P9vCapnySgxf0bl2EKViPZt4TH0=
X-Google-Smtp-Source: AGHT+IHauVnydROWiyfWJYVQbHgk2jJlm5kHJRz5F5WwNcqbjHQHSgkJaViOe+FqQo/zxtZgHkV5TA==
X-Received: by 2002:a5d:668a:0:b0:354:f5f2:198b with SMTP id ffacd0b85a97d-354f5f21a02mr1882007f8f.46.1716460963119;
        Thu, 23 May 2024 03:42:43 -0700 (PDT)
Received: from krzk-bin.. ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35501491c40sm516038f8f.28.2024.05.23.03.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 03:42:42 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/4] ASoC: codecs: wcd939x: Unify define used for MIC bias registers
Date: Thu, 23 May 2024 12:42:27 +0200
Message-ID: <20240523104228.36263-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523104228.36263-1-krzysztof.kozlowski@linaro.org>
References: <20240523104228.36263-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All four microphone bias registers have similar layout: enable mask is
exactly the same.  Use one define, just like older driver wcd938x is
doing, to make the code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not tested on hardware, but functionally code should be the same.
---
 sound/soc/codecs/wcd939x.c | 36 +++++++++++++++++-------------------
 sound/soc/codecs/wcd939x.h |  5 +----
 2 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/sound/soc/codecs/wcd939x.c b/sound/soc/codecs/wcd939x.c
index c49894aad8a5..201592c728c3 100644
--- a/sound/soc/codecs/wcd939x.c
+++ b/sound/soc/codecs/wcd939x.c
@@ -1268,25 +1268,20 @@ static int wcd939x_micbias_control(struct snd_soc_component *component,
 {
 	struct wcd939x_priv *wcd939x = snd_soc_component_get_drvdata(component);
 	int micb_index = micb_num - 1;
-	u16 micb_field;
 	u16 micb_reg;
 
 	switch (micb_num) {
 	case MIC_BIAS_1:
 		micb_reg = WCD939X_ANA_MICB1;
-		micb_field = WCD939X_MICB1_ENABLE;
 		break;
 	case MIC_BIAS_2:
 		micb_reg = WCD939X_ANA_MICB2;
-		micb_field = WCD939X_MICB2_ENABLE;
 		break;
 	case MIC_BIAS_3:
 		micb_reg = WCD939X_ANA_MICB3;
-		micb_field = WCD939X_MICB3_ENABLE;
 		break;
 	case MIC_BIAS_4:
 		micb_reg = WCD939X_ANA_MICB4;
-		micb_field = WCD939X_MICB4_ENABLE;
 		break;
 	default:
 		dev_err(component->dev, "%s: Invalid micbias number: %d\n",
@@ -1300,7 +1295,8 @@ static int wcd939x_micbias_control(struct snd_soc_component *component,
 		if (wcd939x->pullup_ref[micb_index] == 1 &&
 		    wcd939x->micb_ref[micb_index] == 0)
 			snd_soc_component_write_field(component, micb_reg,
-						      micb_field, MICB_BIAS_PULL_UP);
+						      WCD939X_MICB_ENABLE,
+						      MICB_BIAS_PULL_UP);
 		break;
 	case MICB_PULLUP_DISABLE:
 		if (wcd939x->pullup_ref[micb_index] > 0)
@@ -1308,7 +1304,8 @@ static int wcd939x_micbias_control(struct snd_soc_component *component,
 		if (wcd939x->pullup_ref[micb_index] == 0 &&
 		    wcd939x->micb_ref[micb_index] == 0)
 			snd_soc_component_write_field(component, micb_reg,
-						      micb_field, MICB_BIAS_DISABLE);
+						      WCD939X_MICB_ENABLE,
+						      MICB_BIAS_DISABLE);
 		break;
 	case MICB_ENABLE:
 		wcd939x->micb_ref[micb_index]++;
@@ -1345,7 +1342,8 @@ static int wcd939x_micbias_control(struct snd_soc_component *component,
 			snd_soc_component_write_field(component,
 						WCD939X_MICB4_TEST_CTL_2,
 						WCD939X_TEST_CTL_2_IBIAS_LDO_DRIVER, true);
-			snd_soc_component_write_field(component, micb_reg, micb_field,
+			snd_soc_component_write_field(component, micb_reg,
+						      WCD939X_MICB_ENABLE,
 						      MICB_BIAS_ENABLE);
 			if (micb_num == MIC_BIAS_2)
 				wcd_mbhc_event_notify(wcd939x->wcd_mbhc,
@@ -1362,7 +1360,8 @@ static int wcd939x_micbias_control(struct snd_soc_component *component,
 		if (wcd939x->micb_ref[micb_index] == 0 &&
 		    wcd939x->pullup_ref[micb_index] > 0)
 			snd_soc_component_write_field(component, micb_reg,
-						      micb_field, MICB_BIAS_PULL_UP);
+						      WCD939X_MICB_ENABLE,
+						      MICB_BIAS_PULL_UP);
 		else if (wcd939x->micb_ref[micb_index] == 0 &&
 			 wcd939x->pullup_ref[micb_index] == 0) {
 			if (micb_num  == MIC_BIAS_2)
@@ -1370,7 +1369,8 @@ static int wcd939x_micbias_control(struct snd_soc_component *component,
 						      WCD_EVENT_PRE_MICBIAS_2_OFF);
 
 			snd_soc_component_write_field(component, micb_reg,
-						      micb_field, MICB_BIAS_DISABLE);
+						      WCD939X_MICB_ENABLE,
+						      MICB_BIAS_DISABLE);
 			if (micb_num  == MIC_BIAS_2)
 				wcd_mbhc_event_notify(wcd939x->wcd_mbhc,
 						      WCD_EVENT_POST_MICBIAS_2_OFF);
@@ -1873,7 +1873,7 @@ static bool wcd939x_mbhc_micb_en_status(struct snd_soc_component *component, int
 	if (micb_num == MIC_BIAS_2) {
 		u8 val;
 
-		val = FIELD_GET(WCD939X_MICB2_ENABLE,
+		val = FIELD_GET(WCD939X_MICB_ENABLE,
 				snd_soc_component_read(component, WCD939X_ANA_MICB2));
 		if (val == MICB_BIAS_ENABLE)
 			return true;
@@ -1935,7 +1935,7 @@ static int wcd939x_mbhc_micb_adjust_voltage(struct snd_soc_component *component,
 					    int req_volt, int micb_num)
 {
 	struct wcd939x_priv *wcd939x = snd_soc_component_get_drvdata(component);
-	unsigned int micb_en_field, micb_vout_ctl_field;
+	unsigned int micb_vout_ctl_field;
 	unsigned int micb_reg, cur_vout_ctl, micb_en;
 	int req_vout_ctl;
 	int ret = 0;
@@ -1943,22 +1943,18 @@ static int wcd939x_mbhc_micb_adjust_voltage(struct snd_soc_component *component,
 	switch (micb_num) {
 	case MIC_BIAS_1:
 		micb_reg = WCD939X_ANA_MICB1;
-		micb_en_field = WCD939X_MICB1_ENABLE;
 		micb_vout_ctl_field = WCD939X_MICB1_VOUT_CTL;
 		break;
 	case MIC_BIAS_2:
 		micb_reg = WCD939X_ANA_MICB2;
-		micb_en_field = WCD939X_MICB2_ENABLE;
 		micb_vout_ctl_field = WCD939X_MICB2_VOUT_CTL;
 		break;
 	case MIC_BIAS_3:
 		micb_reg = WCD939X_ANA_MICB3;
-		micb_en_field = WCD939X_MICB3_ENABLE;
 		micb_vout_ctl_field = WCD939X_MICB1_VOUT_CTL;
 		break;
 	case MIC_BIAS_4:
 		micb_reg = WCD939X_ANA_MICB4;
-		micb_en_field = WCD939X_MICB4_ENABLE;
 		micb_vout_ctl_field = WCD939X_MICB2_VOUT_CTL;
 		break;
 	default:
@@ -1975,7 +1971,7 @@ static int wcd939x_mbhc_micb_adjust_voltage(struct snd_soc_component *component,
 	 * micbias.
 	 */
 	micb_en = snd_soc_component_read_field(component, micb_reg,
-					       micb_en_field);
+					       WCD939X_MICB_ENABLE);
 	cur_vout_ctl = snd_soc_component_read_field(component, micb_reg,
 						    micb_vout_ctl_field);
 
@@ -1996,14 +1992,16 @@ static int wcd939x_mbhc_micb_adjust_voltage(struct snd_soc_component *component,
 
 	if (micb_en == MICB_BIAS_ENABLE)
 		snd_soc_component_write_field(component, micb_reg,
-					      micb_en_field, MICB_BIAS_PULL_DOWN);
+					      WCD939X_MICB_ENABLE,
+					      MICB_BIAS_PULL_DOWN);
 
 	snd_soc_component_write_field(component, micb_reg,
 				      micb_vout_ctl_field, req_vout_ctl);
 
 	if (micb_en == MICB_BIAS_ENABLE) {
 		snd_soc_component_write_field(component, micb_reg,
-					      micb_en_field, MICB_BIAS_ENABLE);
+					      WCD939X_MICB_ENABLE,
+					      MICB_BIAS_ENABLE);
 		/*
 		 * Add 2ms delay as per HW requirement after enabling
 		 * micbias
diff --git a/sound/soc/codecs/wcd939x.h b/sound/soc/codecs/wcd939x.h
index 807cf3113d20..383a79316439 100644
--- a/sound/soc/codecs/wcd939x.h
+++ b/sound/soc/codecs/wcd939x.h
@@ -91,10 +91,9 @@
 #define WCD939X_ANA_MBHC_BTN7				   (0x3021)
 #define WCD939X_MBHC_BTN7_VTH	GENMASK(7, 2)
 #define WCD939X_ANA_MICB1				   (0x3022)
-#define WCD939X_MICB1_ENABLE	GENMASK(7, 6)
+#define WCD939X_MICB_ENABLE	GENMASK(7, 6)
 #define WCD939X_MICB1_VOUT_CTL	GENMASK(5, 0)
 #define WCD939X_ANA_MICB2				   (0x3023)
-#define WCD939X_MICB2_ENABLE	GENMASK(7, 6)
 #define WCD939X_MICB2_VOUT_CTL	GENMASK(5, 0)
 #define WCD939X_ANA_MICB2_RAMP				   (0x3024)
 #define WCD939X_MICB2_RAMP_RAMP_ENABLE	BIT(7)
@@ -103,10 +102,8 @@
 #define WCD939X_MICB2_RAMP_SHIFT_CTL	GENMASK(4, 2)
 #define WCD939X_MICB2_RAMP_USB_MGDET_MICB2_RAMP	GENMASK(1, 0)
 #define WCD939X_ANA_MICB3				   (0x3025)
-#define WCD939X_MICB3_ENABLE	GENMASK(7, 6)
 #define WCD939X_MICB3_VOUT_CTL	GENMASK(5, 0)
 #define WCD939X_ANA_MICB4				   (0x3026)
-#define WCD939X_MICB4_ENABLE	GENMASK(7, 6)
 #define WCD939X_MICB4_VOUT_CTL	GENMASK(5, 0)
 #define WCD939X_BIAS_CTL				   (0x3028)
 #define WCD939X_BIAS_VBG_FINE_ADJ			   (0x3029)
-- 
2.43.0


