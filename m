Return-Path: <linux-kernel+bounces-518877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5778A395C1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 767A23A7D68
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7F322DF9A;
	Tue, 18 Feb 2025 08:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CObM7REs"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E639722B8CA;
	Tue, 18 Feb 2025 08:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867835; cv=none; b=ZalMXwuhplCAWHWswy4Pvf9goGfqqJKqfcP4rdNEdt8LB0is/89QgQd6KJ5TfCX/M9J2vL9ydD5Kp2xBjTJ7kAsmHG3ZMWzhWPkrVy2B4/A98OZuvwv0l5gWIGCKnCs9qtd/SQnrHNzaIT/VAzskYAWcUCsOSDiMSmaHa8nUCmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867835; c=relaxed/simple;
	bh=b2j7CSiACw8SRnoO0dJf/ZnIOm1P9PRFDL2lbTQvzF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RMRRd+GZJw+2Z54qYMQgW5pFwg6+qm3wCZhpTTMWhjGVh8U1lWucVvSffmmH4IpqXkWd5sVNqNbfNoH77bwTFRGdY5wox/yf38+yrDRr3IN0A8GoQPGPfACfAN/wfyPDIAukzlXQBjsT2tFZycUUNKrisY5XEix7xlUqR6tgYME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CObM7REs; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2211acda7f6so44041245ad.3;
        Tue, 18 Feb 2025 00:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739867833; x=1740472633; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SZXOZtJRNcMxbwvAxDPYaBnHs3AWQQ3XLqmgpymYN0k=;
        b=CObM7REsaWu2wV3QVP6sehOa/vEUVcJSSGqZu+1XnPfa3IXPAiIOL6hwBRVaB64A31
         i9PwzCttGy7ZKZTr5Kmo01wQ/Pbb6woxe26kNJiE9Fb14pZuvJCZ3ymdqdI+DXTEqsbN
         48psAeLxg2P98h1EqPuBVOU92ERHfo5nfu513kRAra7BcFJ6BhTbpCJOT/1e+WNCeyD8
         S6NN1tk9x9/YpBaXY41dx7uyS2B0z95cex0o2Y+l5+QeaDtE3Iye7ZmJ3+eF1NJuejDi
         4DX6liCV/LpBgOQJyzoBQjhd3PAx+py084MvbplYsSzlI1xzxPUps4acOi1qVfihtLCG
         KCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739867833; x=1740472633;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZXOZtJRNcMxbwvAxDPYaBnHs3AWQQ3XLqmgpymYN0k=;
        b=bQmd6V6NLQS0Xezo4QY8lVShK8STBUz9X4gnIxcWzbs4zbB2poIPqm6G2EyDxby7OZ
         DmSxOaZnxnshAtNz49+mifyhJvz8RGp2dXkuDll6jVV8AzTTMD89OQ+ElHgSU4uL2AfP
         Px6ZwO6jA+jVYvXoSZETIgsDhSLDOtZ6seH5hDovzk2xQ+SUfSy8AgpUpkHRHyUo7jlD
         BHQHDu2twizc+8JwslcZd1VXTq8NultWPKfyYB3r+mEQVEKqrP4IO/cu84DgNRb2PN9L
         0gYpB5G9D/7lN7oUyvvRq0I2Ot6p53ag+iCzatsyAFTMWUaI0ST5VgMR4fTDNsaYXGef
         Kw8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7Z5DRoExtTm966bJcCAcLGnMLVMv1AQDHpj+2yJYD9Nsi8oQPik+jdFRk6+cnj1sUFD7ZjmREtSsFjjlH@vger.kernel.org, AJvYcCUlFV4Lbq1hxvQzpKm+h563Aj+PJNmlNCYvAw0fEbFI+tIQubCcQMVTQuvg23PZ5n0A1FHQdj+UYIrK6VQ=@vger.kernel.org, AJvYcCVjompPJGrogZawAN3PCFSvIJMxk1vH9LPXiKCiccNoK1ZUMZ70VNEdjw/lhliZtsRGPN7AVx7rSB/f@vger.kernel.org, AJvYcCWbJgYUgznXnjwTuWFwNY7tHi4M0jA7bEcBaDNoEsD8Z0A8vZ262gxDOspbPqrUL4XgMSxhCh2DWOlVWo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS6yGKU/7pZqyjmfNFy0vDqRpVaXoPCtnjCPqofuuWSTVJ5wp3
	TtCOetgx/v0nqBKo4ZLe63SaWbgybgFRRGkg3U8U1eHKbsQ/LXaGLoJV5ll4
X-Gm-Gg: ASbGnctG59i7n9D5UwVEJW9o9+iIr8p04TgZb5wmXoD9B/r5sDD0IrFOqxkMXYNSsxZ
	UbQg9CiwKIyL32yNPU9HKK0a3wp5j3wUZwFDcfK1mI7SBFo4kn18SQ92/+RXrSWj7oP59fhCqOp
	VCLO1DzCFO3BcULKA6/wsScvDnK3VwkvMdkwcx1Ds2QBR7sPPJIR51ogfxEPD6hiFOajgqdcYO8
	dXuHuf9iKn2X3fbraa6Jyr7NZgEIIg0E1HagR7UOZlVVUZQRRWaRVBelEl4LrA6TIsIJ9W6QT6e
	52oE0JyWB7xSjnNYueSg4x4l/LiiGEHxDy5Qgg3028u3RejQUxC5JAud7DofV59LuzlGYIomp0Z
	jeromRbKOIw==
X-Google-Smtp-Source: AGHT+IHjc8Lzg5/Ok3MfsQ+QSDaYu/Z/31zh5KduSVebpMli7UVfvUjcknrjjiFtN5LTobyfTkKrww==
X-Received: by 2002:a05:6a20:43a0:b0:1ee:7c7d:e66a with SMTP id adf61e73a8af0-1ee8cb7d7c6mr23485293637.23.1739867833047;
        Tue, 18 Feb 2025 00:37:13 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ae1ee4febb2sm787325a12.51.2025.02.18.00.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:37:12 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Tue, 18 Feb 2025 18:35:44 +1000
Subject: [PATCH v2 10/29] ASoC: tas2764: Configure zeroing of SDOUT slots
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250218-apple-codec-changes-v2-10-932760fd7e07@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2906;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=PzSwXh+q2KiuxDXck4Zpp204WMC77HTyEOvTgAp6ZAQ=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOlb3BIKOmbxRy58W+SSu6LwWrB+9NaDO16LSe9VfCQ8n
 WH6Kca3HaUsDGJcDLJiiiwbmoQ8Zhux3ewXqdwLM4eVCWQIAxenAEzk7hpGhtaezGnV7Uw23N9a
 P2scj79Zv2Wdy1+GU73796z9No3vqB4jw5JYp+W/+yzkFVIqfPhEDk1WOKPyMOircc9s/7bNDvk
 z2AE=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Martin Povišer <povik+lin@cutebit.org>

The codec has an option to zero out certain TDM slots on its SDOUT
output according to a preconfigured mask (otherwise the output is, for
the duration of unused slots, in a Hi-Z state). Configure this feature
based on a mask read from the devicetree.

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2764.c | 23 +++++++++++++++++++++++
 sound/soc/codecs/tas2764.h | 11 +++++++++++
 2 files changed, 34 insertions(+)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index e4003a724c8c09303882ee36fc11133cf5c78b57..a2b7d0352d4f636c2bf7185715c0f1143ba8150e 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -40,6 +40,7 @@ struct tas2764_priv {
 
 	int v_sense_slot;
 	int i_sense_slot;
+	u32 sdout_zero_mask;
 
 	bool dac_powered;
 	bool unmuted;
@@ -594,6 +595,23 @@ static int tas2764_codec_probe(struct snd_soc_component *component)
 	if (ret < 0)
 		return ret;
 
+	if (tas2764->sdout_zero_mask) {
+		for (i = 0; i < 4; i++) {
+			ret = snd_soc_component_write(component, TAS2764_SDOUT_HIZ_1 + i,
+						      (tas2764->sdout_zero_mask >> (i * 8)) & 0xff);
+
+			if (ret < 0)
+				return ret;
+		}
+
+		ret = snd_soc_component_update_bits(component, TAS2764_SDOUT_HIZ_9,
+						    TAS2764_SDOUT_HIZ_9_FORCE_0_EN,
+						    TAS2764_SDOUT_HIZ_9_FORCE_0_EN);
+
+		if (ret < 0)
+			return ret;
+	}
+
 	if (tas2764->devid == DEVID_SN012776) {
 		ret = snd_soc_component_update_bits(component, TAS2764_PWR_CTRL,
 					TAS2764_PWR_CTRL_BOP_SRC,
@@ -736,6 +754,11 @@ static int tas2764_parse_dt(struct device *dev, struct tas2764_priv *tas2764)
 	if (ret)
 		tas2764->v_sense_slot = 2;
 
+	ret = fwnode_property_read_u32(dev->fwnode, "ti,sdout-force-zero-mask",
+				       &tas2764->sdout_zero_mask);
+	if (ret)
+		tas2764->sdout_zero_mask = 0;
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/tas2764.h b/sound/soc/codecs/tas2764.h
index b814715b41ff6e9a714c30ae204e7792351428b6..00296b8b1f7584e7520bd6ed749a09681f16ea09 100644
--- a/sound/soc/codecs/tas2764.h
+++ b/sound/soc/codecs/tas2764.h
@@ -117,4 +117,15 @@
 
 #define TAS2764_BOP_CFG0                TAS2764_REG(0X0, 0x1d)
 
+#define TAS2764_SDOUT_HIZ_1		TAS2764_REG(0x1, 0x3d)
+#define TAS2764_SDOUT_HIZ_2		TAS2764_REG(0x1, 0x3e)
+#define TAS2764_SDOUT_HIZ_3		TAS2764_REG(0x1, 0x3f)
+#define TAS2764_SDOUT_HIZ_4		TAS2764_REG(0x1, 0x40)
+#define TAS2764_SDOUT_HIZ_5		TAS2764_REG(0x1, 0x41)
+#define TAS2764_SDOUT_HIZ_6		TAS2764_REG(0x1, 0x42)
+#define TAS2764_SDOUT_HIZ_7		TAS2764_REG(0x1, 0x43)
+#define TAS2764_SDOUT_HIZ_8		TAS2764_REG(0x1, 0x44)
+#define TAS2764_SDOUT_HIZ_9		TAS2764_REG(0x1, 0x45)
+#define TAS2764_SDOUT_HIZ_9_FORCE_0_EN	BIT(7)
+
 #endif /* __TAS2764__ */

-- 
2.48.1


