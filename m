Return-Path: <linux-kernel+bounces-518873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDB4A3959B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF0A51668C2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE47B22CBCA;
	Tue, 18 Feb 2025 08:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qjo775h0"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAF322B8D0;
	Tue, 18 Feb 2025 08:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867804; cv=none; b=CdoBLtzz+ryHCMOa957Rki4jEPeYLwKDQBzB89nz7O+p6XwAOd7b2v4ya3Gk5EnCpLQr9jhmwhE6HUQ0/GSOcu/IcCUB9KUR/zMkLjcjQpQfh6xlFmTKlUgZYT1kSD7tUAuQgJM81gE+gyOSuX69hJU1JqLX1yQTgl3WeAXAWx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867804; c=relaxed/simple;
	bh=ZLfqHGEmmRxWDvQqbGo0nvLtr+jQRIPyVh/jCgvqHm8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DuxHuxX1tBlJv4EDvoGUiSniGxr7p4Lo8LWTRLgSPx4T0HmVliRsuZTVqlnpsOkw/J7jzAT1Dnvt+k3iu7Hg/7rKnReZAcjRLBNWg/49OVRTNMhKOK4cRmWK6sZeGWid5weZc8a6Ci9YeUxN5mIxku9AvSHV1MwFRBKr7nx+pj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qjo775h0; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220c8eb195aso106168815ad.0;
        Tue, 18 Feb 2025 00:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739867802; x=1740472602; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ln6BBxQvoa3BwbYmzNm0cxjw8OAeHcLG9Mi/U3fzc+8=;
        b=Qjo775h0ubFpbQ+1ku+Iet6j4fo//wf6QJ2ki/wV6vYL63ojrbulFYM6Zyyj9azndp
         xDdQpPbxwVAkTkCerah4z+w5zyi0c8sC4MeMgWe6hNMODCPfNy3paVh4dG+8ntmdkyZD
         B8FcdLLRPkWIkRvzGL/iK7/ash4O/T/F19fBw34rvaYvFO5/EwOzMtFB+55DN5/9w3KI
         J0wjnu9kK2032PDCg5kEalQQl6gXvw4GZVGdo8PR2netmidmHaXRd0xj9nfNep0FnOTW
         auvrrG/4+bVo9m9FVO+KwGW3FGoDCdh2Hanjh5pHo8l17LHefAzvlhEy92yzWUklBQpL
         THgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739867802; x=1740472602;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ln6BBxQvoa3BwbYmzNm0cxjw8OAeHcLG9Mi/U3fzc+8=;
        b=CV3aCjC+iZZqSdqlFSqaWTzdNA+gjIoaHHNTNKUWRqkfVfbrDMl3YIPg8C0f0xG7wj
         WIPrnlQalgBQd3xG3vJWQeESIzcTppTuTarf8hDh2qTBvebbg/MHay+sv2EROCP6FHfp
         lCzohsIkSWEpQ4fY2iTvriVdMVB5u82zUu4q9Xx5N524wMxkv4ESG12+mNeU8k+wv2Yb
         CC7fg5TGqRhVxm7xkA5N5J4j+JJQ0Jzc7PtuXqzkV9T0AvLeo5M36iKr4QPU5C5RuSFr
         Ba4EqU30L/ehcPZjirTISErZgg26B/sp38mg93jDkPonASESnvy230JQ0q3h7CTD8ko7
         TYzA==
X-Forwarded-Encrypted: i=1; AJvYcCUa3WDVYW/I96PcBLK7mrJt7hIj8nZIjue/POEaI2cNxQ1XvVXm9B3slUxdpN7zG0KFk/0gArutLgsz@vger.kernel.org, AJvYcCWiaIuLsV0t68uNZSGOID+mEcazgTC0uTdiQbdMog6BkDC3KkF5CSskNYO/5pxg+Y1XdYOv3n3LbnTOBGg=@vger.kernel.org, AJvYcCXOPNEymsY2Ss27s3wHlvPL8fQtCTaMg1Ojh7GVanmdWPI50T1otiL4/JWRxREsF6pZGjVhb6ML3fjYh8s=@vger.kernel.org, AJvYcCXdAJdTS/MTH1Rlc6AQw3RZUiU9kRRa9RtmXAdIT5Y82Cf8rLio2YmodpRk2dqhoi3mo21+5sskPn4eYC5a@vger.kernel.org
X-Gm-Message-State: AOJu0YwPLbDZQXYB9Stx4Ol7OIezlu2DnGdJ73H88ImBy7Ll8zrpj148
	3bvh2IxUqrRaWKG2Na1obFs3bnGsTYECusuGOECo5wIXXtzVuHb3F0MOZX2m
X-Gm-Gg: ASbGnct2/P1V7Z7VEofs+Wgen3r1KnKYX36UyHCKlgjgSgvsLpdTRzRrwt3yNnZMze4
	9REMCcC3V+jnm+2yN/Gid8Ws49qfkQZ6STedVqYVKvT7sw3IyumXWap2lHgq4XYTXnhGiQ1TBHB
	ic7jA9+Sz/JabqkZWTdef07USwVof34gaRSnu3NBGEIu3EhdiRszuUT0wyVLysudYGDJrOR/oZr
	xe1Cf7AbghfVBnZbA4VhF4EECI0R6Q8t5WIkFub1IU54vFwT9xOI13+wlmfXRvkJh9RgTyR66fM
	J98WDU7hgCFiA7vxeR0dsVzDfuPJOP7mjn1vZNExyXV3Aqi6BfRPA/UFAL6OI5JE0nz1PtkWZwh
	onl008m3B9g==
X-Google-Smtp-Source: AGHT+IGMRtRZg0Gc9H3HwG54sh1h0dYs9F/qv3aNYDQGeqt+afKytli0IykEtcy4SHr1bGklOsV/0A==
X-Received: by 2002:a05:6a00:198c:b0:732:1840:8382 with SMTP id d2e1a72fcca58-7326144b0b3mr21937466b3a.0.1739867801963;
        Tue, 18 Feb 2025 00:36:41 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ae1ee4febb2sm787325a12.51.2025.02.18.00.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:36:41 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Tue, 18 Feb 2025 18:35:40 +1000
Subject: [PATCH v2 06/29] ASoC: tas2764: Add control concerning overcurrent
 events
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250218-apple-codec-changes-v2-6-932760fd7e07@gmail.com>
References: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
In-Reply-To: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Dan Murphy <dmurphy@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shi Fu <shifu0704@thundersoft.com>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
 Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-hwmon@vger.kernel.org, 
 Neal Gompa <neal@gompa.dev>, James Calligeros <jcalligeros99@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2014;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=x9ToLkkem0IkKdzxIQq2uXS0i2qLVjJ6tDhcGqRC18k=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOlb3OLnPKg68/OoqOP7V1+6X9Y8OHyEf3ew30KduqsvL
 iecOz1vQkcpC4MYF4OsmCLLhiYhj9lGbDf7RSr3wsxhZQIZwsDFKQAT+T2f4Z9R4aEjDoLhqaym
 //J0nnj7xfSc2WhkczqhK3/ym0M3GCwZ/hfPDi7RZ9107PsspQkqGnfLJa9xasy6+Vubu/vwjKz
 UYm4A
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Martin Povišer <povik+lin@cutebit.org>

Add control to expose the option of autoretry behavior on overcurrent
events in the codec.

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2764.c | 9 +++++++++
 sound/soc/codecs/tas2764.h | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index cda75b7f270377dd7af1b163d38fe2f28e1f7484..05d025ffc567fac25110fbde2ca19337b8ee329d 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -623,12 +623,21 @@ static SOC_ENUM_SINGLE_DECL(
 	tas2764_hpf_enum, TAS2764_DC_BLK0,
 	TAS2764_DC_BLK0_HPF_FREQ_PB_SHIFT, tas2764_hpf_texts);
 
+static const char * const tas2764_oce_texts[] = {
+	"Disable", "Retry",
+};
+
+static SOC_ENUM_SINGLE_DECL(
+	tas2764_oce_enum, TAS2764_MISC_CFG1,
+	TAS2764_MISC_CFG1_OCE_RETRY_SHIFT, tas2764_oce_texts);
+
 static const struct snd_kcontrol_new tas2764_snd_controls[] = {
 	SOC_SINGLE_TLV("Speaker Volume", TAS2764_DVC, 0,
 		       TAS2764_DVC_MAX, 1, tas2764_playback_volume),
 	SOC_SINGLE_TLV("Amp Gain Volume", TAS2764_CHNL_0, 1, 0x14, 0,
 		       tas2764_digital_tlv),
 	SOC_ENUM("HPF Corner Frequency", tas2764_hpf_enum),
+	SOC_ENUM("OCE Handling", tas2764_oce_enum),
 };
 
 static const struct snd_soc_component_driver soc_component_driver_tas2764 = {
diff --git a/sound/soc/codecs/tas2764.h b/sound/soc/codecs/tas2764.h
index fa2ac38de78b457263be2e72e02a9a3c47c2762f..b814715b41ff6e9a714c30ae204e7792351428b6 100644
--- a/sound/soc/codecs/tas2764.h
+++ b/sound/soc/codecs/tas2764.h
@@ -44,6 +44,10 @@
 
 #define TAS2764_CHNL_0  TAS2764_REG(0X0, 0x03)
 
+/* Miscellaneous */
+#define TAS2764_MISC_CFG1		TAS2764_REG(0x0, 0x06)
+#define TAS2764_MISC_CFG1_OCE_RETRY_SHIFT  5
+
 /* TDM Configuration Reg0 */
 #define TAS2764_TDM_CFG0		TAS2764_REG(0X0, 0x08)
 #define TAS2764_TDM_CFG0_SMP_MASK	BIT(5)

-- 
2.48.1


