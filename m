Return-Path: <linux-kernel+bounces-187516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED158CD2D0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 728D21C20DCA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2256714AD24;
	Thu, 23 May 2024 12:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PYpmFGSj"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74C51474BC
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 12:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716468657; cv=none; b=jVruXIWNm+1DoHQ+I7BNHW/wTh99HuC/6UabuZsUzZ9TiqyHHfdVeCXcyZdBGq3urDgJ2FOfv6YhMPqzshOq42tVRZHHQYH8HPfNzDSw4IVxh8o94iNOpLse5JCD1cxq5WIzhDMQ+e8LxlVV0FBZd2Ci9kGHEvLtj5lTDIMTCAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716468657; c=relaxed/simple;
	bh=fUX77Iy2RBOSUqDLII16TlK4LyQa2FvQEq1BpJUqio0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BB8P5oJQvHCH0P3TO0LFWDi+AvdCgVvau72kz4eruOuArZXPgZBqCXZOTZvcxKlwQsBP3QUjb6T6gvtDUGOclFBmHmTYTPJqfrO9Y4xCrGK0s4dSu7EhtS2jp1BoKeezNz6EGDyIMKIdanA/4a5A7oswfUcsfTdJfxbdOwQCoEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PYpmFGSj; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4202dd90dcfso18744655e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 05:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716468654; x=1717073454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=61bWma0l/TUZdl+2r1laibsSrbas4+96Do3Z1xzZ5/M=;
        b=PYpmFGSj9vAUMlkYXA6+4OQpG61TgSNor6Msu64GbDrrLGWZrJydvVmbzr54pYwnWV
         GayFyE/tzKAGTqIJYKB2YxvjHE5gyIt2AunqdvdAImH9lQ4o3uG8HH8mHdvmZj3+l6K0
         7Fhw6eD/buDikao5pRujbFqRsdhbQcCjF/+EGRZE/8QEyip+P/rNsQy9ADDhTZv7oQBT
         S2jLjwKtjMXcy8Oa7jtyE4aDipbcghIExJ6QT6kZhnreq8BnXkiijbcD0hRpLrgK8L1s
         FqqpEUUEkQlBleATuho0lEnBqncvwJ2He7DEM2tALj1ajn6mb7GQyGSbKBT+1MK26y1C
         N/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716468654; x=1717073454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=61bWma0l/TUZdl+2r1laibsSrbas4+96Do3Z1xzZ5/M=;
        b=WPwhdF+wrV7Vz6scIN3WK/nQl+LAI7t2+Etln/gR04A856fJPIbvAWP/YUjcafcTN6
         jXkVEHMlPvFqHpe8XCIufTur47ANfg9MxI/6k1LniL1uhGgsuIjnPqibXT6Dcvz0TCQJ
         jliT2XK5cNlqDY4RBPx8xtCca9YQq5O2zS3ExGaw1Suq0Nb0rjDRHRexl/g4kJBKjx6b
         1Q//REsm8Xb5ur2n/axEfrMKWw+/2DZhDf+1Am40inDxZR99b/XNYar/fz06ISfhCIJS
         zhWvsS5y7nEN5YD3IZiOrM81mWAUYGstRZRAIKReNHTyEo5rGaS7UArMqq0leq+YavjA
         mfTA==
X-Forwarded-Encrypted: i=1; AJvYcCXWXxl9pIEU1h8uqs4XTTAoa40OWMLBYo542of+HIhQSO3oHUzsnJ0uqaYbb4vmbjTUzKbzq4jhy7unknZ/iKgkd/UCu67enQre7PdR
X-Gm-Message-State: AOJu0YwtCYZAdVDwJkK1suSBJA6CxP4dppix1F6Hz0IdiRKbmow/jfKs
	RKLs8yrpa9cD/UHZByNtoOQNAJYIg2NCNvgmnIFbQG5GBNIFdmfw+gS4x4rXrls=
X-Google-Smtp-Source: AGHT+IGc8BWYW+8SifhsXfZEgTjT+KA0BK3BWMbkeaZz/ScE7su1IG7AXzDslPYcvYkucM46O0u2kA==
X-Received: by 2002:a05:600c:6a88:b0:41f:e7ac:cc72 with SMTP id 5b1f17b1804b1-420fd378638mr33099415e9.40.1716468654070;
        Thu, 23 May 2024 05:50:54 -0700 (PDT)
Received: from krzk-bin.. ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f1410csm24513215e9.15.2024.05.23.05.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 05:50:53 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: codecs: wcd939x: Unify define used for MIC bias VOUT registers
Date: Thu, 23 May 2024 14:50:49 +0200
Message-ID: <20240523125049.43713-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All four microphone bias registers have similar layout: VOUT control
mask is exactly the same.  Use one define, just like older driver
wcd938x is doing, to make the code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

I spotted one more similar change as I did some minutes ago. This
depends on:

https://lore.kernel.org/all/20240523104228.36263-3-krzysztof.kozlowski@linaro.org/
---
 sound/soc/codecs/wcd939x.c | 17 ++++++-----------
 sound/soc/codecs/wcd939x.h |  5 +----
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/wcd939x.c b/sound/soc/codecs/wcd939x.c
index 770bc2f35ba7..72d8a6a35052 100644
--- a/sound/soc/codecs/wcd939x.c
+++ b/sound/soc/codecs/wcd939x.c
@@ -1933,7 +1933,6 @@ static int wcd939x_mbhc_micb_adjust_voltage(struct snd_soc_component *component,
 					    int req_volt, int micb_num)
 {
 	struct wcd939x_priv *wcd939x = snd_soc_component_get_drvdata(component);
-	unsigned int micb_vout_ctl_field;
 	unsigned int micb_reg, cur_vout_ctl, micb_en;
 	int req_vout_ctl;
 	int ret = 0;
@@ -1941,19 +1940,15 @@ static int wcd939x_mbhc_micb_adjust_voltage(struct snd_soc_component *component,
 	switch (micb_num) {
 	case MIC_BIAS_1:
 		micb_reg = WCD939X_ANA_MICB1;
-		micb_vout_ctl_field = WCD939X_MICB1_VOUT_CTL;
 		break;
 	case MIC_BIAS_2:
 		micb_reg = WCD939X_ANA_MICB2;
-		micb_vout_ctl_field = WCD939X_MICB2_VOUT_CTL;
 		break;
 	case MIC_BIAS_3:
 		micb_reg = WCD939X_ANA_MICB3;
-		micb_vout_ctl_field = WCD939X_MICB1_VOUT_CTL;
 		break;
 	case MIC_BIAS_4:
 		micb_reg = WCD939X_ANA_MICB4;
-		micb_vout_ctl_field = WCD939X_MICB2_VOUT_CTL;
 		break;
 	default:
 		return -EINVAL;
@@ -1971,7 +1966,7 @@ static int wcd939x_mbhc_micb_adjust_voltage(struct snd_soc_component *component,
 	micb_en = snd_soc_component_read_field(component, micb_reg,
 					       WCD939X_MICB_ENABLE);
 	cur_vout_ctl = snd_soc_component_read_field(component, micb_reg,
-						    micb_vout_ctl_field);
+						    WCD939X_MICB_VOUT_CTL);
 
 	req_vout_ctl = wcd939x_get_micb_vout_ctl_val(req_volt);
 	if (req_vout_ctl < 0) {
@@ -1994,7 +1989,7 @@ static int wcd939x_mbhc_micb_adjust_voltage(struct snd_soc_component *component,
 					      MICB_BIAS_PULL_DOWN);
 
 	snd_soc_component_write_field(component, micb_reg,
-				      micb_vout_ctl_field, req_vout_ctl);
+				      WCD939X_MICB_VOUT_CTL, req_vout_ctl);
 
 	if (micb_en == MICB_BIAS_ENABLE) {
 		snd_soc_component_write_field(component, micb_reg,
@@ -2912,13 +2907,13 @@ static int wcd939x_set_micbias_data(struct wcd939x_priv *wcd939x)
 		return -EINVAL;
 
 	regmap_update_bits(wcd939x->regmap, WCD939X_ANA_MICB1,
-			   WCD939X_MICB1_VOUT_CTL, vout_ctl_1);
+			   WCD939X_MICB_VOUT_CTL, vout_ctl_1);
 	regmap_update_bits(wcd939x->regmap, WCD939X_ANA_MICB2,
-			   WCD939X_MICB2_VOUT_CTL, vout_ctl_2);
+			   WCD939X_MICB_VOUT_CTL, vout_ctl_2);
 	regmap_update_bits(wcd939x->regmap, WCD939X_ANA_MICB3,
-			   WCD939X_MICB3_VOUT_CTL, vout_ctl_3);
+			   WCD939X_MICB_VOUT_CTL, vout_ctl_3);
 	regmap_update_bits(wcd939x->regmap, WCD939X_ANA_MICB4,
-			   WCD939X_MICB4_VOUT_CTL, vout_ctl_4);
+			   WCD939X_MICB_VOUT_CTL, vout_ctl_4);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/wcd939x.h b/sound/soc/codecs/wcd939x.h
index 383a79316439..756f497a337c 100644
--- a/sound/soc/codecs/wcd939x.h
+++ b/sound/soc/codecs/wcd939x.h
@@ -92,9 +92,8 @@
 #define WCD939X_MBHC_BTN7_VTH	GENMASK(7, 2)
 #define WCD939X_ANA_MICB1				   (0x3022)
 #define WCD939X_MICB_ENABLE	GENMASK(7, 6)
-#define WCD939X_MICB1_VOUT_CTL	GENMASK(5, 0)
+#define WCD939X_MICB_VOUT_CTL	GENMASK(5, 0)
 #define WCD939X_ANA_MICB2				   (0x3023)
-#define WCD939X_MICB2_VOUT_CTL	GENMASK(5, 0)
 #define WCD939X_ANA_MICB2_RAMP				   (0x3024)
 #define WCD939X_MICB2_RAMP_RAMP_ENABLE	BIT(7)
 #define WCD939X_MICB2_RAMP_MB2_IN2P_SHORT_ENABLE	BIT(6)
@@ -102,9 +101,7 @@
 #define WCD939X_MICB2_RAMP_SHIFT_CTL	GENMASK(4, 2)
 #define WCD939X_MICB2_RAMP_USB_MGDET_MICB2_RAMP	GENMASK(1, 0)
 #define WCD939X_ANA_MICB3				   (0x3025)
-#define WCD939X_MICB3_VOUT_CTL	GENMASK(5, 0)
 #define WCD939X_ANA_MICB4				   (0x3026)
-#define WCD939X_MICB4_VOUT_CTL	GENMASK(5, 0)
 #define WCD939X_BIAS_CTL				   (0x3028)
 #define WCD939X_BIAS_VBG_FINE_ADJ			   (0x3029)
 #define WCD939X_LDOL_VDDCX_ADJUST			   (0x3040)
-- 
2.43.0


