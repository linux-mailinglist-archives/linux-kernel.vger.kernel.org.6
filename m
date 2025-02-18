Return-Path: <linux-kernel+bounces-518885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FB3A395D3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30846178116
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D98C22AE59;
	Tue, 18 Feb 2025 08:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLCR26Kq"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CFF22CBF4;
	Tue, 18 Feb 2025 08:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867890; cv=none; b=is3mnb1J+7lrKOxjw2ruC2gTS3zcaB32aa7+JXdDRBWVtdpTjSgyQHy8Qy9WPmjwqqjpesutnLpZGVHU6ruBtMrM63Rx4HA9IEGavzEyD9v8yc3ZQy2pvfTuFl5JiwhPWyP7o23bvGaglF9/EhXsvIDJl4Um3eFQF1PbeJVNLsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867890; c=relaxed/simple;
	bh=bXgdrj/lgzgHfGKjw+d3UblqoDc9qGQB/+FFAVBHcXI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gB1AkF5Dby1wa0/GJQCkZkksUb7didC0D8r8jZDVP7DVY/wRpXJrcHumqIvdDTaeJgPh0MN9HyGka181gkehnwtjwcfcdEeFHCInEfkoCP9AvIU90R6fP3kqZjwsEcDgreDHpBSgiCp5HpG8t0oJ6GUD6YmlkMMH5oaqk6/HcCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLCR26Kq; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22128b7d587so34296845ad.3;
        Tue, 18 Feb 2025 00:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739867887; x=1740472687; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nq/n56KCvsRvP7RYqZR5KNoKdAwdBSr5LyDPMrsCm94=;
        b=SLCR26KqbN1EeQqSlH6H3NQMtS+xkm1xTtFAcJWFERJBMSSiaKFZrK1P0s8/enaGha
         ZURtCAuEFEWksPBYd223gH3u/dcJcBVaTX/jGrOVcpAENpe6+cnMi54rP93kX9tUZf2c
         gdSGS6qIBKiKwXWq243CwThHUD2MGDCJ2sSh932Bpo6EAnoF2stVA5p3kWfsX2T8C5iz
         d3E3t5cw5we8pisFjxQuLVIrOEADYHHUCEqVq2vAho/ylsdJT0TXdxKRXFdVYQAeM120
         NFBqPyvN4/9KS/RYal7oFLXHxLQ4ANK78Y4xjcjC05OuSDuUJ0XGgsOkE5R0q2qcGaSR
         UHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739867887; x=1740472687;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nq/n56KCvsRvP7RYqZR5KNoKdAwdBSr5LyDPMrsCm94=;
        b=nwqQaPF/1R2Hri83NK29fQ8FSrdX+SlKvBDduW6B6fUL8cbEg3X9abhFtOwRBfvVLs
         PtDUhu2FN2N7g5OtCw9cD9MiOlV6Wq6KjQmxNgPslHR4gtHp121Qy/4D0n2AoSSmk/vR
         DgpBsMf5wA2gXvMNMwbc21vQx+Tv6O5JqX2VZC2MgRhUdzzC4Mx7R9FeMFb2MfSlRCjh
         CdTYbYukZnYaqP6oT/nxg4DqQP8Cv7w1rMeu8wWTLWWbg7BN2uvWj0S8Z3yVeYDdVseC
         fja0pbVItkwpGbgByEjFRN1JPvvj0UJO5KZ0ezZ/AXr0DowPSrPQIN73ZJXBlCVFMoYr
         2sug==
X-Forwarded-Encrypted: i=1; AJvYcCUK94RSqWmXBz7oARWEKrEuGAlxT5fFeXLjIoSQafncIO1EEfdqcF7Tpm0sU7eD0/XmogqIspghAdU/+s8=@vger.kernel.org, AJvYcCWj2z9EBvTQlITI3nqjfhVXtPno5D61SO7P+Vzkr3EvfradYk0oA6ixnLpiNXWSq7gxUrrL96qvPiFo/0Eh@vger.kernel.org, AJvYcCXQxrl7rQ42XjfhliL90yPKhT6Dc0o5p0Pr+wlexkcKd9/D7xWWxXl6pZBcf3K2AvbW+pwb9rcfKLel@vger.kernel.org, AJvYcCXv7rSzambHYiqELM0IUGwZDHrhIW8oPzuY8S3l++LiwbgQZsFxJPwHLkpgSci+ope14822wFIX/5MmSaU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc7NWe8sL9s0ByxLqa67VL4rUsGQBsG85/I6U639c787RUKZsw
	jzEcZid03ylHlRLF/aHvWq4yqeNctDU+Y4sy0SILFNfl2W19Rjzz7N2FDsUt
X-Gm-Gg: ASbGnctO7IzZB0WaS0DX21l4uDxYE7nONYXEGkT0k81at3SUD41N5llEsbTb4agh2W2
	EcA2vFJ58xGBv6v3ZlEdkys3fmt1lEGabvdboXhsP7ZZAiz85SAeO1rHUMqCbrlFBFVFJ9jiWqP
	qnnEDlufSd4GIqsAV+EOiDMLWx489+Bj3bEDMcaETR8u6kFlq281VYA/NMtoZNkzwPmeBY9Lv6D
	pFigUjEeRoCiZuyJXdpXfSUwosAjwRMHkz8mfRnx09FqLN0GperuRWvILMw3wqKPNtkcAxBBYPE
	8PJW2hJQ1+Vyh6hYgDNDWiZ5lmZ5h+W7HWkjNiS0p3S/ZglDQVzPbsdLLDYydLXZbmrRnGfny4u
	HvAD08f7w/w==
X-Google-Smtp-Source: AGHT+IHc+3+Y6pYMIhjesT1d2RpgN7fPqWm6UpDrcbTpkkzy2YO8Dtln+mC5fD/udDbNi12XN6/LOQ==
X-Received: by 2002:a05:6a00:1707:b0:732:288b:c049 with SMTP id d2e1a72fcca58-73261784015mr19657706b3a.1.1739867886809;
        Tue, 18 Feb 2025 00:38:06 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ae1ee4febb2sm787325a12.51.2025.02.18.00.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:38:06 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Tue, 18 Feb 2025 18:35:51 +1000
Subject: [PATCH v2 17/29] ASoC: tas2764: Crop SDOUT zero-out mask based on
 BCLK ratio
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250218-apple-codec-changes-v2-17-932760fd7e07@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2949;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=Or2McYkdE4gYAmum1CTJeeAbVQsNrcCt+ghAbMXAHKo=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOlb3BJtmYJ3GsbebQ3zuHy06MvRpXsuHv52bd/799svi
 k5xKZOc0VHKwiDGxSArpsiyoUnIY7YR281+kcq9MHNYmUCGMHBxCsBE3vMx/A9u09ho+zg31Ls+
 t/TEiekHilNu+rlsrxPrTdscKbKW9xQjwyHRzo+/3Z1+v5hnET01LNxue/ZWBfWF2m8+ivS7vjn
 fxQsA
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Martin Povišer <povik+lin@cutebit.org>

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2764.c | 56 +++++++++++++++++--------
 1 file changed, 39 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index 670c59e57997a7988af837bd58da695ad773ae14..39dc466bfbca35d50a5a93507260d59d30affab6 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -376,6 +376,44 @@ static int tas2764_hw_params(struct snd_pcm_substream *substream,
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
@@ -507,6 +545,7 @@ static int tas2764_set_dai_tdm_slot(struct snd_soc_dai *dai,
 static const struct snd_soc_dai_ops tas2764_dai_ops = {
 	.mute_stream = tas2764_mute,
 	.hw_params  = tas2764_hw_params,
+	.set_bclk_ratio = tas2764_set_bclk_ratio,
 	.set_fmt    = tas2764_set_fmt,
 	.set_tdm_slot = tas2764_set_dai_tdm_slot,
 	.no_capture_mute = 1,
@@ -714,23 +753,6 @@ static int tas2764_codec_probe(struct snd_soc_component *component)
 	if (ret < 0)
 		return ret;
 
-	if (tas2764->sdout_zero_mask) {
-		for (i = 0; i < 4; i++) {
-			ret = snd_soc_component_write(component, TAS2764_SDOUT_HIZ_1 + i,
-						      (tas2764->sdout_zero_mask >> (i * 8)) & 0xff);
-
-			if (ret < 0)
-				return ret;
-		}
-
-		ret = snd_soc_component_update_bits(component, TAS2764_SDOUT_HIZ_9,
-						    TAS2764_SDOUT_HIZ_9_FORCE_0_EN,
-						    TAS2764_SDOUT_HIZ_9_FORCE_0_EN);
-
-		if (ret < 0)
-			return ret;
-	}
-
 	if (tas2764->devid == DEVID_SN012776) {
 		ret = snd_soc_component_update_bits(component, TAS2764_PWR_CTRL,
 					TAS2764_PWR_CTRL_BOP_SRC,

-- 
2.48.1


