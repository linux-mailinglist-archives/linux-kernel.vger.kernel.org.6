Return-Path: <linux-kernel+bounces-515815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAE0A36958
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787883B132A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597B01F5FA;
	Sat, 15 Feb 2025 00:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eP4rb3VH"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020A7151998;
	Sat, 15 Feb 2025 00:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739577836; cv=none; b=fMbtD6LO7YMddexHvSizj9wOI3J9ye+dKWGcRUbkJ4aR0XeXinLtyyAwrqEFv/bcmBba5mE/MQDwbS6SBzdKsglfHqauTnyGZqo8tDY5xTyHiCx855fwnUBVzCPckpbVMob6i0IF+W3TEAaarLSr+huZROEuNs2O/ZEoFEeHpDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739577836; c=relaxed/simple;
	bh=fAf1KAgaeIrxwZbwk9BO115UKgXcSqW2DO+wbz9KRpw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uikJHECrZEHOYlv3C359pZUGIfOh/w/MgJYk/tJKD06l7QWy+91T2bJ4h22wTeONPLRzE9+MYLi4LTZh/OPuoRMgLNQYoaoeMuLe7tvmhxwxTD0jfFTj+A88O4Y/gVrW3/WOu4Gclo1Jgg/W7/3IRuxx9LsZPhNJ9IfCLIDxLYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eP4rb3VH; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fc11834404so3513045a91.0;
        Fri, 14 Feb 2025 16:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739577834; x=1740182634; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XjN69dWvX0hG9h4EhLNZtQys+yGsXU0w3VyGLhW1vec=;
        b=eP4rb3VHiGS442c+U/Gm7iIaN8SmkUDA5XWKasqhWYffc+koVYUKTfz+nnUvbHbM7U
         IQOiZ+S4n0SE8eyNQdPvsolIuvCAsOIy2GvAl5/aVnH5dJs396RrvayrzB+iOe6V4h/R
         F4x0N1iZ6cv+sxWH/S37FDNRh7bQSBOAs3KUYb8n/AuzyaRifEcfcY0UTT4QDcJP0bQm
         tL+wOmfgYzww+/Fej6nF7Rl0hwoPZ/Q67z1nbg2ay4pzPmLWfAGnrPrToGEIONpi/Wtt
         89GtlkopnK+hiPClZHx8VMG7ZtlitezdlysnKJHw3edN9unJ6nsv2AuX7u8ae6W1Ago8
         98FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739577834; x=1740182634;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjN69dWvX0hG9h4EhLNZtQys+yGsXU0w3VyGLhW1vec=;
        b=q7ftWb4be+u+r/pzgWfJJlzK35TOLCbd98149zNeMHCzLSpdZtXpJRGRq5qOUwERZE
         lKyrQNOR7NL1hnaJKXcju24S0TmPzhcbH3Z0CVyHhgvB0kJPWyGb5rcZRLoxJqByICpF
         CYiGq5TgmQ78sGKU1E8iEvhG/KKJqZLmKyp1dTLEaKZe+/Cm2OOjoVdu1UW5aHaDireW
         K7FoEF6gSVSUiHPDKlwh1L4FqjHoLK3gbIMnJ0mYUhL/WOLEsxDbGR+ggsiPY5yTiRyP
         EmzXavTjV5q3s4h67l6S1EVyuk5oYmOdocP0OzVn8ZrKK5DSppWrdL2u/1olQxMba3MS
         iy6A==
X-Forwarded-Encrypted: i=1; AJvYcCUSkI7+kgFC1A6QPUku8Er30OC/1EmscemXMriblBlq8M73EwQbfN4CjfUD7oA6SwgIwD10WAjAH9GorDw=@vger.kernel.org, AJvYcCW2OAXDhYpQ4LilqDCKflQzL+DT38xZ//RNecnqBuAjTfUfQEfOpTPBRhAX7Wbs8/CxbaSaLN6utNGK@vger.kernel.org, AJvYcCWcQYz6z0J7gz1EkdJqoRAmUZt8APEjfa2qGkylWv29gZEGTsZKFaYae7qRloVmfekqtFxFA6zKsI2hM527@vger.kernel.org
X-Gm-Message-State: AOJu0YxFmV2WASGnwnuyZI3Nc7fdzWdhbqvkGwXYugSYO4ON1FdeseOC
	/Ve7ag170a2sZaPinWvNPDPvYe+KPJIAG/SeAB49DBFBTUuOR7GC
X-Gm-Gg: ASbGncswPPzRHjmHuy43Hn5/mcnDoKadfsBH9xKHc1j3Fe+mg9DMBuwWIHkMWMVw/Vz
	FHcGMG3jZhSlGl0fxaixCZYW87SuTh/1udbbHYQ+ap7F5KsmRJpujEBslfBq9FK4hEvQFfOXfB9
	VpRvTYIGvYaAHYlS6zQ6zJkqTAgb3aP57dj4us9z8iCdAhmOZP4qr4o/QBR+PYRj9xtvJ64bjqV
	dA36kpXYlQcgQp3IL4cnjakt/335j9SHA6+U60BPS+HvwqsR1sTayCE1shpPfTEVB+LRDtycXMS
	vP+lEvi1IfVBCfSDnMZg3IYoAM/GlOGNyzUY8b7NMzn+s6vrffKIUo4k1/ASQMU1OOpqJ3MIQCB
	llMY8/5aLjg==
X-Google-Smtp-Source: AGHT+IG8Y9dfFDg7fAsxSa/d9/xijgthnbv4dNrpx0e5/T2PydIYpo7CujjfmoaoePIUicpcVlYA3g==
X-Received: by 2002:a17:90b:17c1:b0:2f5:88bb:118 with SMTP id 98e67ed59e1d1-2fc41044ffemr1257114a91.22.1739577834169;
        Fri, 14 Feb 2025 16:03:54 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220f26ea127sm15071155ad.96.2025.02.14.16.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 16:03:53 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Sat, 15 Feb 2025 10:02:39 +1000
Subject: [PATCH 06/27] ASoC: tas2770: Fix and redo I/V sense TDM slot
 setting logic
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250215-apple-codec-changes-v1-6-723569b21b19@gmail.com>
References: <20250215-apple-codec-changes-v1-0-723569b21b19@gmail.com>
In-Reply-To: <20250215-apple-codec-changes-v1-0-723569b21b19@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Dan Murphy <dmurphy@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shi Fu <shifu0704@thundersoft.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
 Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, James Calligeros <jcalligeros99@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3845;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=Zkv+pd4IC2a5+XRrYg3ceXkPLMS+eYmm7VHJxks2gAY=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOnrb26N0Tec2n3GOWibmdL8lYv+X5dL1HTK/lBX7D11g
 q/IezWBjlIWBjEuBlkxRZYNTUIes43YbvaLVO6FmcPKBDKEgYtTACaicJ3hr+SiZRvdDolImi2c
 Nmdx5BKJN9d2MTcKuR1JVS0vZjdNbGL4nzXz407uk2VeP7mlGsveedtPjv7zjjN1lczHvrlqzXO
 82AA=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Martin Povišer <povik+lin@cutebit.org>

The former code sets the V slot from inside set_bitwidth according to
the bitwidth of the PCM format. That's wrong, since:

 * It overrides the V slot parsed from DT binding.

 * The V slot is set shifted behind the I slot by the length of the PCM
   bitwidth, but the PCM bitwidth has no assured relation to the TDM
   slot width.

Replace the former logic by setting up the I/V sense transmission only
in case of both I/V slots being specified in devicetree, and never
override those values. In case the slots are left unspecified, disable
the transmission completely.

There's an improbable case someone is relying on the old behavior, but
if so, that's a setup that only works by accident, and cannot be sanely
supported going forward. There's no indication anyone is consuming the
I/V sense data up to today, so break the former behavior.

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2770.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index 0c8a02ac2c0db10c449a68d9365e79576e24abba..35a4d5a4a3e0cf4f71f81fd59f44f075c59cdbc1 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -224,19 +224,16 @@ static int tas2770_set_bitwidth(struct tas2770_priv *tas2770, int bitwidth)
 		ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG2,
 						    TAS2770_TDM_CFG_REG2_RXW_MASK,
 						    TAS2770_TDM_CFG_REG2_RXW_16BITS);
-		tas2770->v_sense_slot = tas2770->i_sense_slot + 2;
 		break;
 	case SNDRV_PCM_FORMAT_S24_LE:
 		ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG2,
 						    TAS2770_TDM_CFG_REG2_RXW_MASK,
 						    TAS2770_TDM_CFG_REG2_RXW_24BITS);
-		tas2770->v_sense_slot = tas2770->i_sense_slot + 4;
 		break;
 	case SNDRV_PCM_FORMAT_S32_LE:
 		ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG2,
 						    TAS2770_TDM_CFG_REG2_RXW_MASK,
 						    TAS2770_TDM_CFG_REG2_RXW_32BITS);
-		tas2770->v_sense_slot = tas2770->i_sense_slot + 4;
 		break;
 
 	default:
@@ -246,11 +243,6 @@ static int tas2770_set_bitwidth(struct tas2770_priv *tas2770, int bitwidth)
 	if (ret < 0)
 		return ret;
 
-	ret = tas2770_set_ivsense_transmit(tas2770, tas2770->i_sense_slot,
-					   tas2770->v_sense_slot);
-	if (ret < 0)
-		return ret;
-
 	return 0;
 }
 
@@ -505,6 +497,7 @@ static int tas2770_codec_probe(struct snd_soc_component *component)
 {
 	struct tas2770_priv *tas2770 =
 			snd_soc_component_get_drvdata(component);
+	int ret;
 
 	tas2770->component = component;
 
@@ -516,6 +509,14 @@ static int tas2770_codec_probe(struct snd_soc_component *component)
 	tas2770_reset(tas2770);
 	regmap_reinit_cache(tas2770->regmap, &tas2770_i2c_regmap);
 
+	if (tas2770->i_sense_slot != -1 && tas2770->v_sense_slot != -1) {
+		ret = tas2770_set_ivsense_transmit(tas2770, tas2770->i_sense_slot,
+						   tas2770->v_sense_slot);
+
+		if (ret < 0)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -643,7 +644,7 @@ static int tas2770_parse_dt(struct device *dev, struct tas2770_priv *tas2770)
 		dev_info(tas2770->dev, "Property %s is missing setting default slot\n",
 			 "ti,imon-slot-no");
 
-		tas2770->i_sense_slot = 0;
+		tas2770->i_sense_slot = -1;
 	}
 
 	rc = fwnode_property_read_u32(dev->fwnode, "ti,vmon-slot-no",
@@ -652,7 +653,7 @@ static int tas2770_parse_dt(struct device *dev, struct tas2770_priv *tas2770)
 		dev_info(tas2770->dev, "Property %s is missing setting default slot\n",
 			 "ti,vmon-slot-no");
 
-		tas2770->v_sense_slot = 2;
+		tas2770->v_sense_slot = -1;
 	}
 
 	tas2770->sdz_gpio = devm_gpiod_get_optional(dev, "shutdown", GPIOD_OUT_HIGH);

-- 
2.48.1


