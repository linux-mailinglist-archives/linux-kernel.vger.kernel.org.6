Return-Path: <linux-kernel+bounces-536246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A62A47D29
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498A41890CD1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A42B22C35E;
	Thu, 27 Feb 2025 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMsMAh9p"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0183922D783;
	Thu, 27 Feb 2025 12:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658243; cv=none; b=EEvkfY2xoDfVvkWvzgTnzRvhaCgUOlnL8+SysS2HQuGX0r9nFmwYyubBaCQHFIUUZq5qtOD203X5chxXQ2pWeSKxpH8EZaSYL4BRQND0CTbUHGOegICwL4Bv790VnDblBVv29TfSsGjXVattu/JfHrOXdPX+irlW3DewWvXck+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658243; c=relaxed/simple;
	bh=BFI0z9ztuM8NgUtm2zrZ0APxtSUaayFxbNwUmSkAGdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m6DsD1rJZCmxpdeSTsBCSmNfzt85uZSIjUWHFEGbWjzJFdM3T4fZLZqsuxoXWnGOXAQtgd8uFiIPLHhrgt+bxZ0p5YpdoqikHcAQe6KVnGpG6PFObGXnoaOOwYkl4206k1nk/wRb3UTBeK7vyOLaexGg46bC0tmwbuRBMEXmOpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMsMAh9p; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220f4dd756eso15514975ad.3;
        Thu, 27 Feb 2025 04:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740658241; x=1741263041; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y0QY69BHYfqhQl9VSrO9JG2JgXmRpNHQh/P+Lu952WQ=;
        b=lMsMAh9pm+2jX1UgeGwIMqP9Jq/K009aBzvfzt199pzPYo7AL1Bdh9FdmEv2PxAJ+D
         pcSj7+kPJp2car26B0J3OX5EJ7laIe0n6KaWJEGHYStZkz92gJVFS6pR7F3o4ap2DLdK
         s5I/euBKHH8ylHYQW2Jh+6Wj35fdKB+BXVpdNpw4eFhN24nxi4fnatmqY1KdKZNayKXG
         +BXLZ3Hit3Zr/9S5nxJvubI5moM698SFjqQcMNADs5WXS8q6FSW9XT+LopIj5/8FoWjV
         3c3B2aM6CI+ixNEdAV46qkwJVBAPhurWpbhD8QY00FJ43VnM+hTrBmd6bZH97/metttr
         nNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740658241; x=1741263041;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0QY69BHYfqhQl9VSrO9JG2JgXmRpNHQh/P+Lu952WQ=;
        b=Kctyp4YUI9fym8ZAKdEAODWROIDlhUMmeF5Cn9U/Ye2suHwsmmnsH4hCupAMSzzUJe
         iqdks4ok0DukAamv3tiWgCY9BTtvXRrnSgGVhN4w2IbVrIwpRSWtepHDgh/narDmJoWi
         c11+fXW0dGTxD4+OxEFhVvzbrR+cQgmwtXfhMe380VWPiWB4WjPAOyq59mAQPyYsNXBp
         dhcMcmAKZsaRk8qtyaNX+4f4P5kdlVvdiZxP+jYEjUld9P8lJxu7QhCzajQjZ4spGCUR
         9r7103lqFUufg9T6KNun+Y0b5MFL2gT1Tl/crqKomtQNnWgmV6OgwwOTBMxtyEnPmHFk
         g/kg==
X-Forwarded-Encrypted: i=1; AJvYcCVYqGp97YlAd8eGFJwcX319Mdo+841F6DcTTG5HIRucBFyqpkzdKJTCZKRboo46+axih/q3AFJihC1/NGY=@vger.kernel.org, AJvYcCVqelkjDAc6tGwn9P6uQ4bKHYA00EhTk4F3dMMy2m9omHbpZMocy4AmfXFAnsPGhld1dYRZQ+pPk01wMYo=@vger.kernel.org, AJvYcCW3Gi2Z36mE/5cE3pcQZWSwYSUbi/wHLWnLoSKt3cA9TKVVQ8N5GRLAdfpBwBCmmu8uNLzDSxPP2/v/@vger.kernel.org, AJvYcCWcue8F3xe7f7gRdeHKNOhMdYvQvv8IubMPcvPbh+yck2kwNzA9Z7EeEAGX+SYY+fd4k1vD7gIeugQCJagd@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj4IW77DpVl/WnMrW7l/Y5g/wBVpIA8RTd50uuddBsHYLUf9n2
	4tnhW+sIETlcXriypl3rwPIUmNjg9B4KEnpzfwTurLyrsyYKBl1G
X-Gm-Gg: ASbGncuvEsQvWHIIJ8yRYvi81zs4pk+fN6gwT8BVvQCY0u3rlCaLWnINAnPbexpKLOk
	1FZ4pZfoRiz7iXK+HIMtsamAF/H+6+Jnt2CKRHF08kgteBZJP2M5QJA+JS6A1lK7LKAGqt326xm
	rMrWw55hizU6/biRHkAKw7T+zyf4XQFYQnlc5N9IA7bnCUlyjaQf1+RgD5cHXqsEZeDz8N+aKIZ
	BxILNP0Cy4ZYDziF1/LdlFlZbszIGkSze/djvXcxRG4U6iZTA72syRUqXihhcUdt3EWWnXtrMWg
	Lcezy28FN6jAXjqcdP1yM+k5MWeEMxipbTONN2iN4DRQj3Ga3WKv/3w1x9z68DKCv2zAs6lsU64
	XkrSth09icULqfDQmVOcM
X-Google-Smtp-Source: AGHT+IGZTvBMjPdbxJa384Mb2cBWuad7YJyZy5010Lq0PTkXQwxsWk7/O8DSuEOsr5dODlA/SMx4cA==
X-Received: by 2002:a05:6a21:6daa:b0:1ee:c8e7:203a with SMTP id adf61e73a8af0-1f0fc99ca0cmr18970116637.40.1740658241174;
        Thu, 27 Feb 2025 04:10:41 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de19cdasm1074217a12.24.2025.02.27.04.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:10:40 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Thu, 27 Feb 2025 22:07:41 +1000
Subject: [PATCH v3 14/20] ASoC: tas2764: Crop SDOUT zero-out mask based on
 BCLK ratio
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250227-apple-codec-changes-v3-14-cbb130030acf@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2333;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=vGfDkW4Egl/oMYM5+yihBufFvY7DijByBLP6WRUag7M=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOkHQk8ftGIt7J7RuFWzwDR8s/37IGvbprRv295dZhOKN
 jkt+XJbRykLgxgXg6yYIsuGJiGP2UZsN/tFKvfCzGFlAhnCwMUpABOZvYjhf6HefcMnE7T5k7dN
 XOgnWXx9wvyaPZ5lHxcJ7+uLLNxjYs7IsPDBvrbMBVtssi3ebNv6+Irw0vl7TfSPctU9P/Pq59q
 jQlwA
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Martin Povišer <povik+lin@cutebit.org>

As per the datasheet, SDOUT bits must be zeroed out if the
corresponding TDM slot is invalid for a given clock ratio.

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2764.c | 39 +++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index b42bd5a50ee566ee83755d4ed7e2071b60951457..2a787baaff5342e09cdfbf7939b0d635433f27ac 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -374,6 +374,44 @@ static int tas2764_hw_params(struct snd_pcm_substream *substream,
 	return tas2764_set_samplerate(tas2764, params_rate(params));
 }
 
+static int tas2764_write_sdout_zero_mask(struct tas2764_priv *tas2764, int bclk_ratio)
+{
+	struct snd_soc_component *component = tas2764->component;
+	int nsense_slots = bclk_ratio / 8;
+	u32 cropped_mask;
+	int i, ret;
+
+	if (!tas2764->sdout_zero_mask)
+		return 0;
+
+	cropped_mask = tas2764->sdout_zero_mask & GENMASK(nsense_slots - 1, 0);
+
+	for (i = 0; i < 4; i++) {
+		ret = snd_soc_component_write(component, TAS2764_SDOUT_HIZ_1 + i,
+					      (cropped_mask >> (i * 8)) & 0xff);
+
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = snd_soc_component_update_bits(component, TAS2764_SDOUT_HIZ_9,
+					    TAS2764_SDOUT_HIZ_9_FORCE_0_EN,
+					    TAS2764_SDOUT_HIZ_9_FORCE_0_EN);
+
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int tas2764_set_bclk_ratio(struct snd_soc_dai *dai, unsigned int ratio)
+{
+	struct snd_soc_component *component = dai->component;
+	struct tas2764_priv *tas2764 = snd_soc_component_get_drvdata(component);
+
+	return tas2764_write_sdout_zero_mask(tas2764, ratio);
+}
+
 static int tas2764_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct snd_soc_component *component = dai->component;
@@ -513,6 +551,7 @@ static int tas2764_set_dai_tdm_slot(struct snd_soc_dai *dai,
 static const struct snd_soc_dai_ops tas2764_dai_ops = {
 	.mute_stream = tas2764_mute,
 	.hw_params  = tas2764_hw_params,
+	.set_bclk_ratio = tas2764_set_bclk_ratio,
 	.set_fmt    = tas2764_set_fmt,
 	.set_tdm_slot = tas2764_set_dai_tdm_slot,
 	.no_capture_mute = 1,

-- 
2.48.1


