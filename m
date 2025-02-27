Return-Path: <linux-kernel+bounces-536233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043DCA47D37
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA42E7AB00E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5331922E418;
	Thu, 27 Feb 2025 12:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpjlYSPb"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28F422E004;
	Thu, 27 Feb 2025 12:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658157; cv=none; b=SACMLVKh0Gfy05jdfFZcG7S2g9DZYa7CVn6HL80V+aGwMbXqn2USa4IXs22Qjb0zcubLcmfk0ZEu5vFA3Ua8bVJOiaxnlliGfbHPeKRi3Wn4a5TsGsCu+cQw1dygtcvTvBbdnbwPSvUzbgXHMHc58RyHgcwNM3eIXMOCekaQrE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658157; c=relaxed/simple;
	bh=F2DrIfGW2/9U4Q7MP0XR4JLpgNdMCG9EqZakypUdbbY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d4ClsHbDszfn1xVJyzmtcmB1aHg/14NvvuzvLIkNXYuOMDcLcwB9uONiqIjHUcC9qP8sUOtc8rk1y7r7xf1G6ieCN5FIEWWdiZhp4g/EOHdp3gVoW/sNsDBZ80eo+/RlZeBBqsOnVjBZtMRon05kM6pVn/coi5+QucCTkaoEbAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpjlYSPb; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22128b7d587so14783165ad.3;
        Thu, 27 Feb 2025 04:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740658155; x=1741262955; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=++pOxyjV7NsBqQX8JUt+QgPYmuOaE7kjoGyFm9ECaww=;
        b=fpjlYSPbgODxxNp12BYq1W4WvYiHfZxE+hnYpZjppKhM/KmoQBzXWNct85zBjsdCBL
         5RqiMsJT6BKcXLaEewHTCJeJYa/NXeAhw+KrJWu2wYQjeA0eQtBs4EQRVe7Qbc0JceAZ
         FeDxRSkd50ksMCwCZ9mmzfkQfz48DQtaOtSEq/er8BAeVW6/Qje++PSbCe6MRhRqQkrY
         p+kBslDwy52a+EirygHc3AJE1iXD4ZruNJfe+a9SBsthdF8bBD2bRl2sx1AwqSWoXdpp
         +dTp/jOW54CuX9czhpz1ICaz6V1Y5Sslz+1v+mlxhdMTnr5Gf5Mdw8wX+Z51fDKsjCOG
         ChNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740658155; x=1741262955;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++pOxyjV7NsBqQX8JUt+QgPYmuOaE7kjoGyFm9ECaww=;
        b=SMaonzdEIs0b+WCzQ6n08wNZM24g3Fhc5Wr1+ouC6bNx6rw4j7gdhcMdFMk+fhloHT
         TsUVtKPfVW88CFoaUB1pIHSbTlN7h8TlTD/ekle8G+HY7qrmPAZz8ptR605/sYTndrXf
         npcUoPUxveAahig3QcT0zKfVbhtvhBdSjUAQKJPCEvNWMJK7zx292cXeOVGNoy38bLyg
         XWcgoAQ2XF2FZI3UEwI/ybUo/ahVtm5YF1FI4wYpnkXAjz+2+qg5+svAfmXEt3gqp5uG
         e5x6PEFPJkDKHjBNzAM7rkW5fFcLlAq3f27AXOHmPpuFfcctr2+QtmjP+2HQ6EWa8Gsc
         l7yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUE8ChHyFAMSzHNnsbQYDnOL3vRikS70b1MDMZyVhTOhaL1CwvcZ3FNESIDiCObGPet6BUK/Qjpuqq8NY=@vger.kernel.org, AJvYcCUXce4v3LqBPOkInypm5kFH6ti9NIwes8DTuPI7OZHFuRRw5LBLEKewzMWlWZBUZPHATrnsTQNIvjEH6nE=@vger.kernel.org, AJvYcCUjBpujfhvy5aIMOf+0lM+30fnNQ3Odq5BSK7mV84A+AjDqdKkmQP6BHDLx8Lyx4y0I/TxBtScusj0v@vger.kernel.org, AJvYcCXVvIWX/PzzoYo6kBV4tXt75WvQVV06NBI0NrERkVTXrmLvVoRAwtGIx1LXd5cBCdZObbsLBaH04g57T+Bp@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9/iGhSyPjG3914fg0lDzqRzCPbcyBpO9yEDZ2PfIKa1jy7NZ+
	6Og66lK6tc/mfSrllD2loDZH4srUA7CvTIX5H9GgptP19I33jeKE
X-Gm-Gg: ASbGncuYiwOoLHtHYUl7NajpTIZRUh4S9cyAAaqmTzBIlLbG6d+kLEud94onFN0ehac
	C9qqAjZ1cXntzQeAbcXLGC5dH7lOzgX5NwHCyAxd6BlpEj7BMQ4+5WrTX+CJQh7PbPtVbdTfdhx
	tmnKy+4kMEJ63wGMOQqKkhJhAoXA7r1DZHozboOkrICjwM/jPmceebXxAup+a4MU0tEU/HeAIxM
	o7XnLUCN0nGzj44xOHCTOcZ6u9QQanuCMCM2Z7tVbBA6y2xBPvDlpvFYhq2yogMU8QGpNXb9Pcz
	C0fzyDWSi0w3Z9CjuN748Ep0U50Tyzx3uZXsnE8VQ5R7Qm7wQVSb+YfblFWZ1b3OJSb4IE6z84J
	JEhNOMs5ul/JQX7N5DbLe
X-Google-Smtp-Source: AGHT+IG8X0dhuBFQIzNUsv+4ZcqoLGmfAbMbOzcssF/1zKQwJNQCo9iVI1o5amOtj8awa3nUaRERBg==
X-Received: by 2002:a05:6a20:7488:b0:1e1:a75a:c452 with SMTP id adf61e73a8af0-1f10ad33597mr12264774637.19.1740658155233;
        Thu, 27 Feb 2025 04:09:15 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de19cdasm1074217a12.24.2025.02.27.04.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:09:14 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Thu, 27 Feb 2025 22:07:30 +1000
Subject: [PATCH v3 03/20] ASoC: tas2764: Extend driver to SN012776
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250227-apple-codec-changes-v3-3-cbb130030acf@gmail.com>
References: <20250227-apple-codec-changes-v3-0-cbb130030acf@gmail.com>
In-Reply-To: <20250227-apple-codec-changes-v3-0-cbb130030acf@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3988;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=nDjwUi7dJ2EmO3q2jQ+Aw3u//e8xOzpHKb8CsrpivsM=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOkHQk+GykqUSsgy7/2rP724+/zm2/7nsrQ6zN5Mu/JP9
 +PcQFnWjlIWBjEuBlkxRZYNTUIes43YbvaLVO6FmcPKBDKEgYtTACay2IeR4dfMPc2/r/JeXHdX
 9bddpApb7qSTixm71yV/fJEtlR720J6R4f352BtnGY6/tXKryrrX94JJNFl/u5nLteTtQemmvdr
 f2QE=
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
 sound/soc/codecs/tas2764.c | 43 +++++++++++++++++++++++--
 sound/soc/codecs/tas2764.h |  3 ++
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index c0a1d0c2a93890105a169717a7fb75ec05f93146..d9b4f898789fa9b59c94c97e3b130950b88c3a76 100644
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
 
@@ -533,10 +540,16 @@ static struct snd_soc_dai_driver tas2764_dai_driver[] = {
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
 
@@ -585,6 +598,27 @@ static int tas2764_codec_probe(struct snd_soc_component *component)
 	if (ret < 0)
 		return ret;
 
+	switch (tas2764->devid) {
+	case DEVID_SN012776:
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
+		break;
+	default:
+		break;
+	}
+
 	return 0;
 }
 
@@ -716,6 +750,8 @@ static int tas2764_i2c_probe(struct i2c_client *client)
 	if (!tas2764)
 		return -ENOMEM;
 
+	tas2764->devid = (enum tas2764_devid)of_device_get_match_data(&client->dev);
+
 	tas2764->dev = &client->dev;
 	tas2764->irq = client->irq;
 	i2c_set_clientdata(client, tas2764);
@@ -752,7 +788,8 @@ MODULE_DEVICE_TABLE(i2c, tas2764_i2c_id);
 
 #if defined(CONFIG_OF)
 static const struct of_device_id tas2764_of_match[] = {
-	{ .compatible = "ti,tas2764" },
+	{ .compatible = "ti,tas2764",  .data = (void *)DEVID_TAS2764 },
+	{ .compatible = "ti,sn012776", .data = (void *)DEVID_SN012776 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, tas2764_of_match);
diff --git a/sound/soc/codecs/tas2764.h b/sound/soc/codecs/tas2764.h
index 9490f2686e38919a726e649884d9b6ad761493a2..69c0f91cb423986f7f0ded0b2160927f024d957d 100644
--- a/sound/soc/codecs/tas2764.h
+++ b/sound/soc/codecs/tas2764.h
@@ -29,6 +29,7 @@
 #define TAS2764_PWR_CTRL_ACTIVE		0x0
 #define TAS2764_PWR_CTRL_MUTE		BIT(0)
 #define TAS2764_PWR_CTRL_SHUTDOWN	BIT(1)
+#define TAS2764_PWR_CTRL_BOP_SRC	BIT(7)
 
 #define TAS2764_VSENSE_POWER_EN		3
 #define TAS2764_ISENSE_POWER_EN		4
@@ -116,4 +117,6 @@
 #define TAS2764_INT_CLK_CFG             TAS2764_REG(0x0, 0x5c)
 #define TAS2764_INT_CLK_CFG_IRQZ_CLR    BIT(2)
 
+#define TAS2764_BOP_CFG0                TAS2764_REG(0X0, 0x1d)
+
 #endif /* __TAS2764__ */

-- 
2.48.1


