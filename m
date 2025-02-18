Return-Path: <linux-kernel+bounces-518900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF058A395CE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86BBA18833BC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EEB233159;
	Tue, 18 Feb 2025 08:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6wEtX8G"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FA2233155;
	Tue, 18 Feb 2025 08:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867975; cv=none; b=ddDOPq5rMYfN4Fa0tV7fc47nuNSlEuYXqT5F46YQGNzy0JmJrq84WzrbJYh6+7izzGC5/67soL7h28cY4B+1vJXucFpJcfjzU0f2sSx2bw7kdTYa/7/QE/zKT1CfTknO9bqmQ+2IHzJtQygrZaFdH5CU5mw2a8MaEMyXe0d6VAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867975; c=relaxed/simple;
	bh=xL4Wq1MztELkfR32srCSOzemACum2SwmdSt0xzOdiwI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cnLx0lbPqsIGglTqhlp47gjYLJrAKN8mFEC8sLkz12p0UmEGcjHOEbgln56Lo1zHtKDR26ZEm6MmOPTL8C3Bhtk/Yl7EFjJwsa2+HVMeyoZ8E5R42HeV5hD6QOTbtsRb+TT0zIXZ2QEIAS8d9C9osYDai1wdfrk2GnjETKbiDPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6wEtX8G; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f61b01630so95447285ad.1;
        Tue, 18 Feb 2025 00:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739867973; x=1740472773; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q97oAOdthGO/p0Zom664cpZtrfzDgfle1urqDzqfUqc=;
        b=F6wEtX8GWpebFe+aXNLysPLXicg8KiqOeYmVj/Mg/XoFmrH7mmsczYUwWj+Ub/DsiR
         pl7N25iPJS5UIogG3xC8BH3RiaSqlYvQ76UhSCXZJN1/8AHM9FJnD91qhlX68bBFIRap
         I2IiXKV7PrVl03zyVnu7bK2jULajV1G8XHH0nL6xOxmbhEeIgtoxQHKS1m+1Kbcx43e4
         pCzrO7gbsbrtB0pkPYT49kyNF0N42rUuW/oJ4PTbKB30RmrDTtdSKmPAHQs93X2mkjRW
         ecmXXKdlJMd//Pw+MRJZjTOUYfkfUvmGgZdb8deG9+uRrL1fnhg40vvS9xOOq0d9RqDK
         vpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739867973; x=1740472773;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q97oAOdthGO/p0Zom664cpZtrfzDgfle1urqDzqfUqc=;
        b=ablXDqKsJ8mVElHbXy82uxz5QDF7Xb3anPmLB4VOGHBOc/e3tJqBNhLF9LWVDrXA4z
         V/4p27TbTnxhsyrQnhxFNIokWVJweOwYZxwdO5/xrwZG2uWFZyAcU/ieccuJdvdUJaBG
         3VnObilwGwjUkFZeb3SVmkqi60lbGjEnkT3AV9LrsZduwmg39jpq56giEx7FagZJj3Fp
         HJfQ7gWecw+BxxX/RmaVTr7831FGXqDf3kg2Q2KYE4vsjKITwWKhFGjonzCK0xjWXj5G
         M3Uy1RcWFm2PRjN87SIb0++40BTK35KpEMedqyCF4XrkDFggb8awoq6/tqFPAZFJhucq
         CgSw==
X-Forwarded-Encrypted: i=1; AJvYcCUV/D0g6txra3A+/BP3i6kRXmgXl+yivfY9KElqYcT8ExyvvveV/1YKx5OrQ/EBXkYd8aJM1RHxHoJTeoej@vger.kernel.org, AJvYcCUwI9GT+pNztyl7Gi3f3cbIyjZxxeo8V+34H9uEfTqLMeCH5GpY22WWalN2xSvPdwCGcHLjrrfdhXo0xhM=@vger.kernel.org, AJvYcCV5CHQUC7BmfUHUVnVr3TrDJ471Nm6j56FvxYif3o0dw7tm2h//FNGqj/RSMVuHiZNEQr8pzvf/KqfUSEs=@vger.kernel.org, AJvYcCVdLT+iF40XWxfomIDXQqPL/WGrN2vH5WJJwleuMQ4FkjiuVGFX8j9+2P+tH7f1n4a6QoBWlWy1iwcp@vger.kernel.org
X-Gm-Message-State: AOJu0YyQhQ5Kc2Q9bpMOxY+1W5zIhXcECjyboXNW150ZR4uDmmzwxHGH
	x5tqgEYpAvD9K+mWxaZuvwaTyJYaXdZADEA5I64dyWTH/qjhd1R6fPiwErLG
X-Gm-Gg: ASbGnctECebpNoprOp16u9qIe5dq57FF/XXCoLzsdYoV6hZih7zcxvPSGCbKM42sSyW
	0eHFAYQblKd5yg16YKqTIzzTNk94GOVDP+RRDK2tiK1wq9sYSp+z7F0ucuaWDpq1UHJjXdKrzzm
	+/KlDyLpk1PZSHvneZRti/vDI71taoOzGp+phxwObPkCGt2sb5x6XCarACR7gjij4GTwY6EGB/J
	2HGXYV2sNb3NNX6YGq3rfKpyOfN2kX0N188SHNBWejGrzxHvvRIwfUqCH/LmsrfkA5vb+ADXeAh
	Nt28gd/+uZUdss98PhQXocYPdKtGLSrl1ISTAq2WlRM0lVuch+dmzS6tJgLDhmJ2bWjRlUpeZZG
	M8TV3SVLmdw==
X-Google-Smtp-Source: AGHT+IHnISboFrM7dhx6z6/HdMGgdO43ZJyjRqDtP0gC2IfA0XVKBKQpFUuOgCSuA4rTU2RzRpg0Kw==
X-Received: by 2002:a05:6a21:3288:b0:1ee:395c:18b4 with SMTP id adf61e73a8af0-1ee6c639006mr30555104637.10.1739867972988;
        Tue, 18 Feb 2025 00:39:32 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ae1ee4febb2sm787325a12.51.2025.02.18.00.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:39:32 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Tue, 18 Feb 2025 18:36:02 +1000
Subject: [PATCH v2 28/29] ASoC: tas2764: Set the SDOUT polarity correctly
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-apple-codec-changes-v2-28-932760fd7e07@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2647;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=nP8CBSYu6p+IA9UVl0Kv9ceqcGVIhoP8fVpl5EAKgJ4=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOlb3JJ1P51XMJ4ZuyP8xZmHik9UPoduFJsV0CWwK7DpV
 +cNO4HwjlIWBjEuBlkxRZYNTUIes43YbvaLVO6FmcPKBDKEgYtTACZSPIfhf73qF8YExlTv6Qv9
 ju7dJxwq8Gj+4fl7Gn+4L3qXP4F7ihDDXynWE8vqbyxIaL2oysL069jDEMuDPz7cUN78MP7dovU
 S7YwA
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Hector Martin <marcan@marcan.st>

TX launch polarity needs to be the opposite of RX capture polarity, to
generate the right bit slot alignment.

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2764.c | 10 +++++++++-
 sound/soc/codecs/tas2764.h |  6 ++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index 7d6cb29a749e234b325e253985eb0feac6f44934..e559724c84a34c5ee2eb08f60ada4f8acd131226 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -427,7 +427,7 @@ static int tas2764_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct snd_soc_component *component = dai->component;
 	struct tas2764_priv *tas2764 = snd_soc_component_get_drvdata(component);
-	u8 tdm_rx_start_slot = 0, asi_cfg_0 = 0, asi_cfg_1 = 0;
+	u8 tdm_rx_start_slot = 0, asi_cfg_0 = 0, asi_cfg_1 = 0, asi_cfg_4 = 0;
 	int ret;
 
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
@@ -436,12 +436,14 @@ static int tas2764_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		fallthrough;
 	case SND_SOC_DAIFMT_NB_NF:
 		asi_cfg_1 = TAS2764_TDM_CFG1_RX_RISING;
+		asi_cfg_4 = TAS2764_TDM_CFG4_TX_FALLING;
 		break;
 	case SND_SOC_DAIFMT_IB_IF:
 		asi_cfg_0 ^= TAS2764_TDM_CFG0_FRAME_START;
 		fallthrough;
 	case SND_SOC_DAIFMT_IB_NF:
 		asi_cfg_1 = TAS2764_TDM_CFG1_RX_FALLING;
+		asi_cfg_4 = TAS2764_TDM_CFG4_TX_RISING;
 		break;
 	}
 
@@ -451,6 +453,12 @@ static int tas2764_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	if (ret < 0)
 		return ret;
 
+	ret = snd_soc_component_update_bits(component, TAS2764_TDM_CFG4,
+					    TAS2764_TDM_CFG4_TX_MASK,
+					    asi_cfg_4);
+	if (ret < 0)
+		return ret;
+
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		asi_cfg_0 ^= TAS2764_TDM_CFG0_FRAME_START;
diff --git a/sound/soc/codecs/tas2764.h b/sound/soc/codecs/tas2764.h
index 786d81eb5b1e71bad094ef94e4b56e8f7c910285..4a419c11d4b08eebb915762db00af5c06ff3dd42 100644
--- a/sound/soc/codecs/tas2764.h
+++ b/sound/soc/codecs/tas2764.h
@@ -84,6 +84,12 @@
 #define TAS2764_TDM_CFG3_RXS_SHIFT	0x4
 #define TAS2764_TDM_CFG3_MASK		GENMASK(3, 0)
 
+/* TDM Configuration Reg4 */
+#define TAS2764_TDM_CFG4		TAS2764_REG(0X0, 0x0d)
+#define TAS2764_TDM_CFG4_TX_MASK	BIT(0)
+#define TAS2764_TDM_CFG4_TX_RISING	0x0
+#define TAS2764_TDM_CFG4_TX_FALLING	BIT(0)
+
 /* TDM Configuration Reg5 */
 #define TAS2764_TDM_CFG5		TAS2764_REG(0X0, 0x0e)
 #define TAS2764_TDM_CFG5_VSNS_MASK	BIT(6)

-- 
2.48.1


