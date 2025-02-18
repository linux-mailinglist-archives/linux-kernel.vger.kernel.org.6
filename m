Return-Path: <linux-kernel+bounces-518875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A02AA395BB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95E0B3A42C7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D6B22F178;
	Tue, 18 Feb 2025 08:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATJYt9Xs"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF6322CBF3;
	Tue, 18 Feb 2025 08:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867820; cv=none; b=LeYEEFB+4twQwieI3WuOkszi12/UKvrZW1L9UfgDxs1cny+AJuxIuvR7qaE9B2jlDo4VBmELRZBuobN0kP+7bBnk4X7t0aF+8nC8Qjh8DOQF0Ca2LNepTPdzoN2gFRrl+TMjd1Vn73P963pRMz2OF5mZ+o9wb30oH1aIG9Gzkho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867820; c=relaxed/simple;
	bh=kXVqm3Bcan36F2GLj/Gjs15SCdXWtkLPAjRDAFl/lgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WuWSJYuuxBtAWOTvFlxj+QvtYy5zR3Uj38z1IwEEhkbpLIRNqr4TjRJG0pD7t7DCejf805Ez2HtqVFgjwgYbFfsNw6UhpxIg9SfRxLWd5taGOEddNenjjlLm9gQEiAFhqhX82CkXazvxIbY4XtU3vaG3jRFpl8Pbbm48nLT1J6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATJYt9Xs; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2f833af7a09so7519961a91.2;
        Tue, 18 Feb 2025 00:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739867817; x=1740472617; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HAEDHeJBFJU8F7o0MW5ekN1Mf8cimeNpcsWtMaG5SxA=;
        b=ATJYt9Xs7dTg+6i9q7AebeZZKaNS4Im5CvSk7UhalL55aXiPSZDPoJ946Cs+w36YU/
         1i4mgkyQjk6x7neD+WzvYOAwffEz+2jtq3M4msdw6uRPJgfYt7XPDqy9go1T1ywQLyxE
         vrQORfzYzZTgeSuNO8ki8MnL7Sx3RSwVdRrDLajqHH/9NgUgDQZVb+hEfYCvqgxwxePX
         o2qhYGywvfTmVCtinpADuslOzXJMuXk5/n/XHsu6B6z0NKsRh1TwkcuQFuD5rLhnazQw
         m2Bs8GZ0VIQsGDyU0bIDNSX+m8AKYwcCASNSakiuqFfYLdqCNhyh2mVbXK9WtQLhaDEK
         nCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739867817; x=1740472617;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAEDHeJBFJU8F7o0MW5ekN1Mf8cimeNpcsWtMaG5SxA=;
        b=gvs05xz2IBnAkjSj1Vc9u7M2Pdaa5453sCGZ+b7r6oUHvAJTSNFfYOUbAlOKQ2v1/E
         uXwJ/N88JmHJNn6wW08afE14F27fNwsK9M7Wiqsrr0lmq16TCQm8iGvCsT+eWLeMQhAm
         5buMSEHyc9GYiJJklzmFV6w3uZkOiBnY9BGnZLH8MfDn7G121nCl1v6Gf8ETFaoBpDPx
         JzOfLklIsi8lN5E5raDPpV4sYOvVWmVuWPEOL5sJNAhEBIr2AOz4W77EP5WbfBRXS+bE
         eYB1kE0O4nVK4Qk1JFUeWGuCyvKQQziJLbry0NBEslYDjlMlaXFE/F1jsu/AIdSzzR3L
         ZMCA==
X-Forwarded-Encrypted: i=1; AJvYcCUh0Bj5CmV/VGUkSXTGmGj11x4/UM6pbwLLa00A9tgsOhV09RqiKWd9/ecnxV0IKxE1UajpLkh7bIzyzLw=@vger.kernel.org, AJvYcCV5fciLKxVwmDFty+WrKjXWujliarozynhau9tc9GhP/c0gs/PBzNaykKWvV4Ez4aJUNKWqUUFLQB/C@vger.kernel.org, AJvYcCVFw8vI/Sa5eS8CRcCxRFL0PySb9Sou38lhs7uYR9rk2Clu9tfBrpHmwet27HjWCqiHOhQNP5fCpij9TQA=@vger.kernel.org, AJvYcCWNOvknPfFJeVV0z/GmZ+hVRipSgKPXQlDq1HYe8yfS4RoRzlXXP6URsobogDSfveuBivpkZrZa4dMOvWxr@vger.kernel.org
X-Gm-Message-State: AOJu0YzXBG9cZGSkuuIAhI0Tp//5jznHc6BG4H76phfnJMZwodEERQrR
	pkr0+ShgAUPBn35Y1phtyto6DqvM7Mv4DIDyBk8O8RZzyTwqMkz6TojXoRG8
X-Gm-Gg: ASbGncudconx03YgSKX32zvPZZFnCHJsRSjGUlSx7rxi71JmJLAo080gyNHNi5IcHpq
	Ptzh3ay8ToHJ/8CvAsyUEzgwmOml743WGCvW/NxnxiO57n2ZwDXtOqgJaw6JEy4Vms4j3AvlVRp
	eqeTgnlQkP+y8+mPx/gxKg9KWJEdhOi0nDlOVOjplFIrk+gqExe7RJJTX6+Un+EoCu9cbb3i2K/
	WWSCoPxUAnIgOoE4RyeHBL5SJiMNqC/DBlfgsQnjWFfbkBqwtWfuSorVcKEmyUBBnoU1XbQGZT/
	bwVbNHgzvYhd+ZGFAmvAldewd0Hr7Ffn8xY6rVNKh3PlhWuuaQEfsKS4aRTlF01+ysEpEzgbrGK
	+om1DmpfAAQ==
X-Google-Smtp-Source: AGHT+IEGVkr4uFnIT1ArBItTEiiwZqVM8VInmErOXWHBzyb4CQeDACNMc4MkmQE5a4/KLKMElV4UFw==
X-Received: by 2002:a05:6a00:1a89:b0:725:cfa3:bc6b with SMTP id d2e1a72fcca58-732617757c7mr24590236b3a.3.1739867817472;
        Tue, 18 Feb 2025 00:36:57 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ae1ee4febb2sm787325a12.51.2025.02.18.00.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:36:57 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Tue, 18 Feb 2025 18:35:42 +1000
Subject: [PATCH v2 08/29] ASoC: tas2770: Fix and redo I/V sense TDM slot
 setting logic
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250218-apple-codec-changes-v2-8-932760fd7e07@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3887;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=9oD673IPZ5uFrCCPftVCE6wRdPUQVoC5LK9O/3Xdq78=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOlb3BKyD/xhvqzM22Y/raN7a6vWtPybfjdPM9nHZge6n
 dpcyXCko5SFQYyLQVZMkWVDk5DHbCO2m/0ilXth5rAygQxh4OIUgImYuTMy/A94uYNJSbpPLObp
 zt4FkQlXapgEmi3s6vlF0vmObVjUzPDf88nuyCopddOulWEnvb0tnr2/fKNlnv0hE/+Dly54h/t
 zAQA=
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

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2770.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index 4a86fcec0c1ecab45b9ebcdfc90c78f3290c6fa6..7f219df8be7046912bf3ef452f75c17b5118bcf6 100644
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


