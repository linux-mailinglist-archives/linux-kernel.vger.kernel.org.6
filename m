Return-Path: <linux-kernel+bounces-317246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B0A96DB6A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FF4F283F00
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F51F1A0720;
	Thu,  5 Sep 2024 14:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IeeGPUWt"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22871A0719
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 14:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725545625; cv=none; b=f5m5a5j0BFYf+bNPSmEMWWzND7UGh+MFdyk1lQeyOiIN64+g215OyRfn265IzMNzxJEDDgrXcmH+MhJjJaiwmCfLlrSwe4XLpDaKghiblcDxwsULVwX7AChJ+qBEd8wpVaLgwIbUFN4BiVqvqd4LNe41vY8UhE5XPJmPHzX1BuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725545625; c=relaxed/simple;
	bh=drSScU2kqBTHjL0A8KzaYHR+/F7xoFGHMQYfWWJ7pnE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iIicoUwOYFHCPzLoZKnn3wdLOTsvHtxnXcQt1wLZHUWFGC3md2h8rtb3xBHI32VqwVou2PLp4wKNp7UhSKQ6WfqAEzrR8R7cZu9RXyyhtotKUHQayDVnXu7jSRx46yJA3PhvysXz8FK6GGzBskwLYd+vWmWiUWE3MuhPSvpn7t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IeeGPUWt; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42bb6d3e260so7142195e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 07:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725545622; x=1726150422; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fLGY2r4E5D5nEZeix2orNxNRil3E6loR/QGg/DpFo+A=;
        b=IeeGPUWt+6sL46ALmmGSTdXNNgIDwJZjovngMzktz06eOSHsB8aWUWSOwKCeuh61x9
         L4/+08ngESMLssoTbpk2LY4urj7UTd3lfTbSA/ATGWESBoM2sdvRBbFn6XJZtqOLSGL+
         rK9GvEI7kd4NDGAbTME2lSGbkziEGZSWFP6Dh1/Qke2ggcLmxZNI/KvEcAK7IckeSggp
         zjGjcufmxLGGSbyUaHFgcUQMarW+y9gOpLJyY2jt4DNwKOh+38hMlDPx3Ib7X8LjlptJ
         QE7PrvFaNZ0vdTqkmBEWgRRPHn1UORFBwKmXvHPwS/rJ4jD+QYS+ffW/5zfL7IxFjIEn
         fevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725545622; x=1726150422;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fLGY2r4E5D5nEZeix2orNxNRil3E6loR/QGg/DpFo+A=;
        b=Vsu9t5o+WtvVQBNSp3B3NYa+l2RM/4ZaDBHSQjRE5NygwlCR3SCIwOyT6GAMpAb7+Y
         +O1VfB8KLufF50iH0NGovtmlAQ1cNH298QNzD93pEKJb33WCpqetgJqH7Uu3x5jKlRIQ
         nIic9dxEw8BKdXiQTD8oaifZmIuZzrTYiJeei0QXFXHhrBRw5m1gangMjcNoilja+3cz
         QjyRMtxtSypC5/a6l541u4P36PhORu1dXMoj75rFWosFKQTuRKqteijj4/Ojp/1vEbDV
         2IVrt6LY0029VfamFpaqv4gX24s1n77IADu5v/bdIh1KIYqePQQ2ixj5U9pJMxV5T+5d
         FT2g==
X-Forwarded-Encrypted: i=1; AJvYcCUAy9yVAdNTmnI34vCm70rL8aiua6fTxpwpt3VS2jyeFYn7B2kgw1TQZKQX2CrZL3cad0aXs0FMSV/TqeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YznxWXl7vjnDBpm0hOs2hG8sYdwKk+jH+AnP+q0UZSzRdU9KKIQ
	NNWUvfnnAB1tBK2R8hguPLODRgzPHnZTgl9me2HFQ9SYSLDaYxJXjwXMgVVIK0w=
X-Google-Smtp-Source: AGHT+IEGRCC4e+BbZUypR7krz2a4gQq1qGWOiNgWFE+vKhBXsfkEaZmALu0yOYGqYwZOJmoKA993YQ==
X-Received: by 2002:a05:600c:3d92:b0:42b:afbb:171b with SMTP id 5b1f17b1804b1-42be48fa9e7mr115228615e9.35.1725545621670;
        Thu, 05 Sep 2024 07:13:41 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:4763:343b:23f3:f45])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3749ef81146sm19514621f8f.82.2024.09.05.07.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 07:13:41 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 05 Sep 2024 16:13:00 +0200
Subject: [PATCH 09/13] ASoC: Intel: avs: drop SNDRV_PCM_RATE_KNOT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-alsa-12-24-128-v1-9-8371948d3921@baylibre.com>
References: <20240905-alsa-12-24-128-v1-0-8371948d3921@baylibre.com>
In-Reply-To: <20240905-alsa-12-24-128-v1-0-8371948d3921@baylibre.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Cezary Rojewski <cezary.rojewski@intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Liam Girdwood <liam.r.girdwood@linux.intel.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com, alsa-devel@alsa-project.org, 
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2545; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=drSScU2kqBTHjL0A8KzaYHR+/F7xoFGHMQYfWWJ7pnE=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBm2byF5Z7tNiZhe6e816749oi0zUTNuNg77PRA8
 jsKC/9KehyJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZtm8hQAKCRDm/A8cN/La
 hbCND/9QmZRemz2Otghu3R9RnK3p2ChrnyTSdSBbVXRpvQu/8ZIqU4Co8aEGyMpZhAzh+ZuourF
 QXKy8b8BOGlBLpuvtssdH83C857coUohvv9CGY5KiaznFQNnFAFO8G9pLCGrmLnSktHRYT3E6UE
 RNKE9tQXZNDwele7SVDxFKC5H5cmBcOBo35DAhZUCC159eSbvPmJ2LRb1eHgVwEHA4+u+uaKH0B
 7FxNeK3JSYRbXU6Bic8nvp8GBMwYUvqahENbQG/vqG4FZqpHuXfVXwqcCJYfTLtVo6CgJhbb3KN
 xFgGKl5P9noIkOjIsK2TcWjCgQvCx2k05xiBjiwIHLQjVxuSSCULF0dp1uT8462NSn5Wlq/a72o
 WuVevmzC5mcpPSm7VVTmxDgBEsyoQfydLTw0p67qMvlBQGEBv0MKgEAp0GFgxu5dX4NmYQmvgi8
 Noo9s1SYgOHLvx38mjsM4MfZ8hQ2KUBiAhVIZwrxY3prg+t55nyv7hrbebTdEeXXacxmkb+0/HH
 UeGw9nMm8XZggMrqc4OkHYSVSL+X30tj2m8zbuyEkpVrOnM5jZqRku0n/p8muHSAaXrH3gXFW7Q
 K1e/20qPKuebTTG9S/YrlyLCQBL1VzQF4nQfwwFaXHlvwGUO5F5toZYfcCK451E5lTMSAxb1Csb
 oFNIoD886sMAeSA==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

The custom rate constraint list was necessary to support 12kHz, 24kHz and
128kHz. These rates are now available through SNDRV_PCM_RATE_12000,
SNDRV_PCM_RATE_24000 and SNDRV_PCM_RATE_128000.

Use them and drop the custom rate constraint rule.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/intel/avs/pcm.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/sound/soc/intel/avs/pcm.c b/sound/soc/intel/avs/pcm.c
index c76b86254a8b..afc0fc74cf94 100644
--- a/sound/soc/intel/avs/pcm.c
+++ b/sound/soc/intel/avs/pcm.c
@@ -471,16 +471,6 @@ static int hw_rule_param_size(struct snd_pcm_hw_params *params, struct snd_pcm_h
 static int avs_pcm_hw_constraints_init(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	static const unsigned int rates[] = {
-		8000, 11025, 12000, 16000,
-		22050, 24000, 32000, 44100,
-		48000, 64000, 88200, 96000,
-		128000, 176400, 192000,
-	};
-	static const struct snd_pcm_hw_constraint_list rate_list = {
-		.count = ARRAY_SIZE(rates),
-		.list = rates,
-	};
 	int ret;
 
 	ret = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
@@ -492,10 +482,6 @@ static int avs_pcm_hw_constraints_init(struct snd_pcm_substream *substream)
 	if (ret < 0)
 		return ret;
 
-	ret = snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE, &rate_list);
-	if (ret < 0)
-		return ret;
-
 	/* Adjust buffer and period size based on the audio format. */
 	snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_SIZE, hw_rule_param_size, NULL,
 			    SNDRV_PCM_HW_PARAM_FORMAT, SNDRV_PCM_HW_PARAM_CHANNELS,
@@ -1332,7 +1318,9 @@ static const struct snd_soc_dai_driver i2s_dai_template = {
 		.channels_min	= 1,
 		.channels_max	= 8,
 		.rates		= SNDRV_PCM_RATE_8000_192000 |
-				  SNDRV_PCM_RATE_KNOT,
+				  SNDRV_PCM_RATE_12000 |
+				  SNDRV_PCM_RATE_24000 |
+				  SNDRV_PCM_RATE_128000,
 		.formats	= SNDRV_PCM_FMTBIT_S16_LE |
 				  SNDRV_PCM_FMTBIT_S32_LE,
 		.subformats	= SNDRV_PCM_SUBFMTBIT_MSBITS_20 |
@@ -1343,7 +1331,9 @@ static const struct snd_soc_dai_driver i2s_dai_template = {
 		.channels_min	= 1,
 		.channels_max	= 8,
 		.rates		= SNDRV_PCM_RATE_8000_192000 |
-				  SNDRV_PCM_RATE_KNOT,
+				  SNDRV_PCM_RATE_12000 |
+				  SNDRV_PCM_RATE_24000 |
+				  SNDRV_PCM_RATE_128000,
 		.formats	= SNDRV_PCM_FMTBIT_S16_LE |
 				  SNDRV_PCM_FMTBIT_S32_LE,
 		.subformats	= SNDRV_PCM_SUBFMTBIT_MSBITS_20 |

-- 
2.45.2


