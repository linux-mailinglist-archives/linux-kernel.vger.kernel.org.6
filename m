Return-Path: <linux-kernel+bounces-536251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3559A47D38
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98D9F3A9A96
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E6722D7B8;
	Thu, 27 Feb 2025 12:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2RSV8il"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365F822D7BE;
	Thu, 27 Feb 2025 12:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658274; cv=none; b=E+Etr1GYITCDb4Ta8EppUqRx4jxv8DRLi5N/xl8munVqDU/AEEp/IQGt9MnbUlo6i30A6+/J29aGf9VdndMcqoWmXBQU1PYCHZYDcjKMYOxoBK5eYeak2pBg7opLKV549iK3NJovX8bAk98nNECkoLownGwI4dfLiQAe0Kn/RcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658274; c=relaxed/simple;
	bh=yZydHPNdGIYsVnf3K1xg5E1giRrWR5AHZC+gJLTWWDI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jXOB7kwLV8yJo2DJB1fCrcAKvWmIaYeod7JTxYGgDt/JooW0CH2zFKacWgARXlTW1JbjYKxoQfdLQWYEACY1XfiaIB1YwRkbaJOf5hHDCTdaPZHOSOAnobu0wA+bx9i0F9p0K+fCY3cMN9Ec1lPaTQZ0MzHuyrkblmdReQwSH3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2RSV8il; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220e83d65e5so13895995ad.1;
        Thu, 27 Feb 2025 04:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740658272; x=1741263072; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6MIMx3In11Gk8ks7z3N/b37m0dqaRTkRDgguGpWwk9w=;
        b=N2RSV8ilvA+kTW2YdVUfVG7yWVAoSZ8YDioLJDhmFjpaRK0s8XN1Jk6VJf1js6zzdN
         UJRAbynf27GomPBIrmATai3+mSTazp0U8uvsimL8v6ohBmet4x9VZalxC7XAtW1HJWC6
         a2KKgEzP/VNOM4yKfzZXNXFpaJFmWHHDMuia0HSzb/Eg9FsWiVBUczMURD21KdWqTVjk
         9QjdXUZ+jJwnAJ921v84uVTcD1UdHYyZhlY56vUGp0IK+0wbJaXpp2Lu6Lbqc+/9DgAf
         tbSMplY3nfcsP6ex1S4Z93b81Me7uJkx7A4qjCN+BV954yEph3XfQTuHMfEyQjwd/Kn2
         nY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740658272; x=1741263072;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MIMx3In11Gk8ks7z3N/b37m0dqaRTkRDgguGpWwk9w=;
        b=CksCIX9fdgxnCdTOsnI1jO61pujqEXlpLMIRNIxt9VSe3VervLP5t6+e0Wbbr7dia1
         eRsjgNwPX5wqqKGjeZRpA9KlqHQPWpl3rDqDfjZKkTzK0ywT33qgeoHGRPARI4Md3Xva
         C2LqLe8B9qYcuibdhtY0kiS+nNb1RlWVojMdSyO+s3cA8uPQ9CCIhha/LFRtXSUR9cLI
         Vwf/jIyi02qU83y3gw+1jZiu1hQ+y9ZFezpw+cjsAeoJ1AIUk+temoOGOAMsXAG1VOTL
         LSlVP08DdXg9g/G+aJ3u/YDMG8Mg0uPrIO4IgpXjwQOgL/aqyWQqpMOIt0AJpm0cLPY5
         hOmg==
X-Forwarded-Encrypted: i=1; AJvYcCUNCfErXQ3oMjtVmEB2MMv/xCO+DSpQ1+71EZXmnROCzK1NCl0J0OLOlCPSVSf7OdtNnQL57HVRcAvvLhU=@vger.kernel.org, AJvYcCUgX1zjOdWuzgXi3Kb7uz0C2ebuFKOieo1aVHY4yJZie8y7qsf7yjrXTzG+eK31t9meHmphcn8MMOKzS74=@vger.kernel.org, AJvYcCUojlDMWdhWh8Chs7avjf+kzVOP0MhieAlOxpW7U1LGslQBZT5oGZvJ2zZFSc4loshGaFhHMwyN4XjWDA5K@vger.kernel.org, AJvYcCWcF0WhH6y4/kuNrOfJp1lfv49AWVzxiUDhw0NFkGOxFlvC9OxvsXL0XrUE45b8ayvx/zGtq9NIaMRD@vger.kernel.org
X-Gm-Message-State: AOJu0YyEa3t39jHWMbOMGV6TZMcBOxJzPke3D5xHgwohinHLUFrD/fJn
	M/oME6oSrQ9/S5CkaEfJt5oGJFMwbTc5J5e3qOJR52ZwtwtUJxHj
X-Gm-Gg: ASbGncvSn1bodsX+nS38hqW9az5F+AW78zUc1zeSWpUTtKW4Zp8TCWqREMuYWz/35z/
	2lPNvPz7FaSxtBnVqnKoqXG7Mg49aM99uZgc9w+D4FaddTckcMbUKmZWr5NhT6fAduVuA6VDHCL
	4gpuRLSmcc2eO7+hchEXp9GnhURRP2LYPfNRiUfvX3Zb7dq5MAHFnfyEz5sDKsZpxycpv4VW9CH
	kPE6GMrVzttmT8287dsc1U8Roq8kn66hmNWHr26CsZkURF0VF2deV0vneD/wEhVJJzIrXac6Y5+
	A3omxyBoJBVsboadQUGZZ/PYSR4m7P6KsMkSm0/T3RpZq4vAceDt0r2SqTOQSWrkO3TtR+nHV7y
	BwhX/QTVrfhnsQjHyKk8m
X-Google-Smtp-Source: AGHT+IF8lzuWjspI3rZZ0uV71kzeqQ26k28SoHirl/vgYdWn55Xm/H8mpRaOkg0dIY3LwKc5KspWVQ==
X-Received: by 2002:a05:6a21:6d8a:b0:1ee:afa2:4e59 with SMTP id adf61e73a8af0-1f10ae73256mr14523491637.36.1740658272425;
        Thu, 27 Feb 2025 04:11:12 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de19cdasm1074217a12.24.2025.02.27.04.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:11:12 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Thu, 27 Feb 2025 22:07:45 +1000
Subject: [PATCH v3 18/20] ASoC: tas2770: Add zero-fill and pull-down
 controls
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-apple-codec-changes-v3-18-cbb130030acf@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3560;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=4TvbG9xciteBIsrWMUMKaDHyIsLMWBeBIr/XFRJjgig=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOkHQk/v4eC12p1fJPXYbPYBnmZ3a76vRyZ+bFN65L29a
 u6rwHfMHaUsDGJcDLJiiiwbmoQ8Zhux3ewXqdwLM4eVCWQIAxenAEzkEQMjQ4dGQsCuPqZPbAvl
 bne9lptaPk9sb3NxOdsVE4fJG0wWfGJkOND2a4uuvM/RtVwHLAo/v2plbm27Ke4aLvtQrXfblw2
 mvAA=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Hector Martin <marcan@marcan.st>

Expose the bits that control the behavior of the SDOUT pin when not
actively transmitting slot data. Zero-fill is useful when there is a
single amp on the SDOUT bus (e.g. Apple machines with mono speakers or a
single stereo pair, where L/R are on separate buses).

Pull-down is useful, though not perfect, when multiple amps share a
bus. It typically takes around 2 bits for the line to transition from
high to low after going Hi-Z, with the pull-down.

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2770.c | 17 +++++++++++++++++
 sound/soc/codecs/tas2770.h | 13 +++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index 787356a4f4256627a55e35c851a9e78a1cf29771..252c65ae839a28fdaf7aaa39faf49891905741a0 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -632,6 +632,20 @@ static int tas2770_codec_probe(struct snd_soc_component *component)
 			return ret;
 	}
 
+	ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG4,
+					    TAS2770_TDM_CFG_REG4_TX_FILL,
+					    tas2770->sdout_zfill ? 0 :
+					    TAS2770_TDM_CFG_REG4_TX_FILL);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_component_update_bits(component, TAS2770_DIN_PD,
+					    TAS2770_DIN_PD_SDOUT,
+					    tas2770->sdout_pd ?
+					    TAS2770_DIN_PD_SDOUT : 0);
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
 
@@ -771,6 +785,9 @@ static int tas2770_parse_dt(struct device *dev, struct tas2770_priv *tas2770)
 		tas2770->v_sense_slot = -1;
 	}
 
+	tas2770->sdout_pd = fwnode_property_read_bool(dev->fwnode, "ti,sdout-pull-down");
+	tas2770->sdout_zfill = fwnode_property_read_bool(dev->fwnode, "ti,sdout-zero-fill");
+
 	tas2770->sdz_gpio = devm_gpiod_get_optional(dev, "shutdown", GPIOD_OUT_HIGH);
 	if (IS_ERR(tas2770->sdz_gpio)) {
 		if (PTR_ERR(tas2770->sdz_gpio) == -EPROBE_DEFER)
diff --git a/sound/soc/codecs/tas2770.h b/sound/soc/codecs/tas2770.h
index f75f40781ab136cccbe1c272f7129ddd3e4a22a3..7da60d2746e8b03faa9d17319c4c41cad7f8cdbd 100644
--- a/sound/soc/codecs/tas2770.h
+++ b/sound/soc/codecs/tas2770.h
@@ -67,6 +67,14 @@
 #define TAS2770_TDM_CFG_REG3_RXS_SHIFT 0x4
 #define TAS2770_TDM_CFG_REG3_30_MASK  GENMASK(3, 0)
 #define TAS2770_TDM_CFG_REG3_30_SHIFT 0
+    /* TDM Configuration Reg4 */
+#define TAS2770_TDM_CFG_REG4  TAS2770_REG(0X0, 0x0E)
+#define TAS2770_TDM_CFG_REG4_TX_LSB_CFG BIT(7)
+#define TAS2770_TDM_CFG_REG4_TX_KEEPER_CFG BIT(6)
+#define TAS2770_TDM_CFG_REG4_TX_KEEPER BIT(5)
+#define TAS2770_TDM_CFG_REG4_TX_FILL BIT(4)
+#define TAS2770_TDM_CFG_REG4_TX_OFFSET_MASK GENMASK(3, 1)
+#define TAS2770_TDM_CFG_REG4_TX_EDGE_FALLING BIT(0)
     /* TDM Configuration Reg5 */
 #define TAS2770_TDM_CFG_REG5  TAS2770_REG(0X0, 0x0F)
 #define TAS2770_TDM_CFG_REG5_VSNS_MASK  BIT(6)
@@ -110,6 +118,9 @@
 #define TAS2770_TEMP_LSB  TAS2770_REG(0X0, 0x2A)
     /* Interrupt Configuration */
 #define TAS2770_INT_CFG  TAS2770_REG(0X0, 0x30)
+    /* Data In Pull-Down */
+#define TAS2770_DIN_PD  TAS2770_REG(0X0, 0x31)
+#define TAS2770_DIN_PD_SDOUT BIT(7)
     /* Misc IRQ */
 #define TAS2770_MISC_IRQ  TAS2770_REG(0X0, 0x32)
     /* Clock Configuration */
@@ -138,6 +149,8 @@ struct tas2770_priv {
 	struct device *dev;
 	int v_sense_slot;
 	int i_sense_slot;
+	bool sdout_pd;
+	bool sdout_zfill;
 	bool dac_powered;
 	bool unmuted;
 };

-- 
2.48.1


