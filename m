Return-Path: <linux-kernel+bounces-518872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C51AA3959A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CD5F176B39
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E46D22B59F;
	Tue, 18 Feb 2025 08:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCtzRc5r"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CA722C322;
	Tue, 18 Feb 2025 08:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867796; cv=none; b=Ya3lE+Aeb3hKjsD7CUMjmJQIKWP4pudyeJrhobJT8gGd2KJzHbGSZcwBbXxvn+nornr9sjSlx4ppcTTOUgVePDh3+XMrxjBybiB510NvgEfWSqhtrKvKZ2RKUPqcZKW4DF3bYcgTGDop6QvXmXWRNZeTChwYBs2/CMw8a9cPZhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867796; c=relaxed/simple;
	bh=ibUQWT0CBsGobzHnhQBolv7HNIIYAkN7Qt+Kz+xkT7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iUxZ+kl0+9N461k/iyp5D5aaap2cOk9gKnqhMKWbJ+o0idqyd4PLq0cDiY/ePvIo00olJvaqz9GtYaTUd9xg9ZjS+aSjkZWwmgJBdi4pEVYNYp7mwTASw2bEYWQw30mjzUeQEQroimCJB7OPLp7OERyI/YH6VTofNSrfkjlqgCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCtzRc5r; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2212a930001so47178855ad.0;
        Tue, 18 Feb 2025 00:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739867794; x=1740472594; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T/JJHVuhOmU2flaa9vpPAAtoFcuf4Ywj04vQWrR/12g=;
        b=aCtzRc5rw53yM6Bkz+Fvwu6oSVTj5stYCmHhEAd/sVKaDaKkY9vvuvG5js/x/t1T0w
         X+mmMNbNpg93b6CgyUTFmPPqbG5eVaIIpjE/3Y88oPSEGEzzWdMR3JdslnmkZOvHaz2d
         C3dRRvJjW/YvQFgVNIw58kUvjErQVxbCF+P1rR+pN4R1lk1cQ+Z78EprnDxj4IXAEW8/
         NE92MiXG21nusrl3B9hSiHWORk1SKvftWXF6i+A8apfdx0+sQmZny0a/m6AmJxH55wtC
         NDC2DOnDrvPVVaOp8VUX8PNFaYK9XbpudEqO/msDigwR9BbAOTwxTtb28netOgDqzCbD
         18Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739867794; x=1740472594;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/JJHVuhOmU2flaa9vpPAAtoFcuf4Ywj04vQWrR/12g=;
        b=NyZ/E3N435B/81c3gJaN8+yMIaRIwCvHYMuxjfruASmFejhE90qesGFXH+T7DZuLwv
         ValLPsiQoMBRDPHOwCiF3zsIkan0TvQwqCVQAkWWlLjN2I176VBemAnCfAEynjH20z1d
         t/x/x83w+M6sAr6yIUCkjtJFeDq1Ia2ywy6m+hnrtacchVfTiMtcS5gGfIKqJE4Vg2H6
         oGwoIlPYT7zZJvPgO5m9TDt0nxXdmd5n+4ruUy1oQm9jM7FV8yHrmkTpSrBJjigbudyc
         kPMq22F86Fk8DTDlp972uhx/3cxLOWiktoQDC1Vz1CE+GeeEtIUxMld6gpok3XinfxS8
         uTZw==
X-Forwarded-Encrypted: i=1; AJvYcCWmQEBCSSzqIw3j8Sd6cfwnmaCucXz50h1lC6u7Pg2R0PjwoIlY1xjuSVZy5eGVDbNe/GYyrRm6SAnv@vger.kernel.org, AJvYcCXSl/OjFhO4ppqtuMSIINf/2hPVooR7OoN734sZItBG3iqzTrgkntvyg/VJQWA+ZUwipFZhka7ezRM0pXw=@vger.kernel.org, AJvYcCXiqHFv2IQWLLL/E3zEPPIlz4wF7mKSNmeVyWprzp5P71NuUOvHyKQiTXkn9bMcRUXobBKX5qVsrduGjYC/@vger.kernel.org, AJvYcCXz0syOjEh0EdDwxpflvVs6G6FQSDWPgeeaTJMDZeGBPeMioXyKdc5Il207FsYiaJN9qxiKqK+ocepk7hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpM4fTGFkzgg0Idu634HMSo2Gxdt2RXWZZvGKNERWYctkuexkh
	DEI+YzF4BKjhsUYKVliW5gEiFVM7ZKTcL0ggTh6QasRA3r139ad7RnLfVap5
X-Gm-Gg: ASbGncuo2UMhMHcuMMyxdkW8jVWLi0zxmoCUG1zYoZCMHwhcammVLgfVrN+oTeDAOAz
	JIJzI6zyeBejUd5qKVHO42y9ulfgxz15dwc6ZIWj6LzTj1sAQNaEl8EWmBBPGknICOnTc1a7CrU
	5c81AwJxOUjbPWS2C8U2GtXwJtHbfDBzDgH3uJV8cSNqTKtoYpebPdzOsuTl0/Hc95vkheib16l
	e6iLNRnvmwhWsQYuyT0bRJrxJ2pWMvmHy4VjBo9ME5ml9bh/qLaW+4c/fN67Auqnh4bcLLNqYRY
	aDwD9YqTZXCbTqHSQXEx1lT4Xp/JAnkBNQs9VgGz2z0dLHkgSzPHWouMMlrd/MtWzwVTk3JEgqJ
	nfWmE9RDXkQ==
X-Google-Smtp-Source: AGHT+IHcWo5xUjZQAMy9H5EeCHYZu+Ch7Btpe9yzB7SSeoHfzR+37KEI17lVH6KxzdQAjB5O8rh2DQ==
X-Received: by 2002:a05:6a21:898c:b0:1ee:aa06:1a47 with SMTP id adf61e73a8af0-1eeaa06a294mr12315448637.2.1739867794138;
        Tue, 18 Feb 2025 00:36:34 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ae1ee4febb2sm787325a12.51.2025.02.18.00.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:36:33 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Tue, 18 Feb 2025 18:35:39 +1000
Subject: [PATCH v2 05/29] ASoC: tas2764: Extend driver to SN012776
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250218-apple-codec-changes-v2-5-932760fd7e07@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3943;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=6sstN5QNTZo6/ITwAmCbNhHYlrr8szvxp01qrMCZpUw=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOlb3OIdT87vvTGhNbqz/4jklsq+E6pLmNZbtD7/xZ/DY
 MH+9snkjlIWBjEuBlkxRZYNTUIes43YbvaLVO6FmcPKBDKEgYtTACYy4z0jw+Ka/Wf2FvV9LrTl
 rlg+zVepq2qCpF8i736J/3N108Qr+hgZ2tU9Nuit/Ctqz32982KiZ4jcW4NpWe/kP6nfuh3TsfQ
 KOwA=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Martin Povišer <povik+lin@cutebit.org>

SN012776 is a speaker amp chip found in Apple's 2021 laptops. It appears
similar and more-or-less compatible to TAS2764. Extend the TAS2764
driver with some SN012776 specifics and configure the chip assuming
it's in one of the Apple machines.

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2764.c | 42 +++++++++++++++++++++++--
 sound/soc/codecs/tas2764.h |  3 ++
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index d482cd194c08c5c443b82c665de7a6d96531ef2e..cda75b7f270377dd7af1b163d38fe2f28e1f7484 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -14,6 +14,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/regmap.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/slab.h>
 #include <sound/soc.h>
 #include <sound/pcm.h>
@@ -23,6 +24,11 @@
 
 #include "tas2764.h"
 
+enum tas2764_devid {
+	DEVID_TAS2764  = 0,
+	DEVID_SN012776 = 1
+};
+
 struct tas2764_priv {
 	struct snd_soc_component *component;
 	struct gpio_desc *reset_gpio;
@@ -30,7 +36,8 @@ struct tas2764_priv {
 	struct regmap *regmap;
 	struct device *dev;
 	int irq;
-	
+	enum tas2764_devid devid;
+
 	int v_sense_slot;
 	int i_sense_slot;
 
@@ -526,10 +533,16 @@ static struct snd_soc_dai_driver tas2764_dai_driver[] = {
 	},
 };
 
+static uint8_t sn012776_bop_presets[] = {
+	0x01, 0x32, 0x02, 0x22, 0x83, 0x2d, 0x80, 0x02, 0x06,
+	0x32, 0x46, 0x30, 0x02, 0x06, 0x38, 0x40, 0x30, 0x02,
+	0x06, 0x3e, 0x37, 0x30, 0xff, 0xe6
+};
+
 static int tas2764_codec_probe(struct snd_soc_component *component)
 {
 	struct tas2764_priv *tas2764 = snd_soc_component_get_drvdata(component);
-	int ret;
+	int ret, i;
 
 	tas2764->component = component;
 
@@ -578,6 +591,23 @@ static int tas2764_codec_probe(struct snd_soc_component *component)
 	if (ret < 0)
 		return ret;
 
+	if (tas2764->devid == DEVID_SN012776) {
+		ret = snd_soc_component_update_bits(component, TAS2764_PWR_CTRL,
+					TAS2764_PWR_CTRL_BOP_SRC,
+					TAS2764_PWR_CTRL_BOP_SRC);
+		if (ret < 0)
+			return ret;
+
+		for (i = 0; i < ARRAY_SIZE(sn012776_bop_presets); i++) {
+			ret = snd_soc_component_write(component,
+						TAS2764_BOP_CFG0 + i,
+						sn012776_bop_presets[i]);
+
+			if (ret < 0)
+				return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -707,6 +737,11 @@ static int tas2764_i2c_probe(struct i2c_client *client)
 	if (!tas2764)
 		return -ENOMEM;
 
+	if (device_is_compatible(&client->dev, "ti,sn012776"))
+		tas2764->devid = DEVID_SN012776;
+	else
+		tas2764->devid = DEVID_TAS2764;
+
 	tas2764->dev = &client->dev;
 	tas2764->irq = client->irq;
 	i2c_set_clientdata(client, tas2764);
@@ -743,7 +778,8 @@ MODULE_DEVICE_TABLE(i2c, tas2764_i2c_id);
 
 #if defined(CONFIG_OF)
 static const struct of_device_id tas2764_of_match[] = {
-	{ .compatible = "ti,tas2764" },
+	{ .compatible = "ti,tas2764",  },
+	{ .compatible = "ti,sn012776", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, tas2764_of_match);
diff --git a/sound/soc/codecs/tas2764.h b/sound/soc/codecs/tas2764.h
index d13ecae9c9c2f57853db70bb1eef2380f6fec45c..fa2ac38de78b457263be2e72e02a9a3c47c2762f 100644
--- a/sound/soc/codecs/tas2764.h
+++ b/sound/soc/codecs/tas2764.h
@@ -29,6 +29,7 @@
 #define TAS2764_PWR_CTRL_ACTIVE		0x0
 #define TAS2764_PWR_CTRL_MUTE		BIT(0)
 #define TAS2764_PWR_CTRL_SHUTDOWN	BIT(1)
+#define TAS2764_PWR_CTRL_BOP_SRC	BIT(7)
 
 #define TAS2764_VSENSE_POWER_EN		3
 #define TAS2764_ISENSE_POWER_EN		4
@@ -110,4 +111,6 @@
 #define TAS2764_INT_CLK_CFG             TAS2764_REG(0x0, 0x5c)
 #define TAS2764_INT_CLK_CFG_IRQZ_CLR    BIT(2)
 
+#define TAS2764_BOP_CFG0                TAS2764_REG(0X0, 0x1d)
+
 #endif /* __TAS2764__ */

-- 
2.48.1


