Return-Path: <linux-kernel+bounces-334569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D7F97D8FA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 19:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD9191C20A66
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 17:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E9E17A924;
	Fri, 20 Sep 2024 17:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Bl+cPe3k"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC9426AF3
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 17:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726852931; cv=none; b=S8Ncg7mOuyXe+716TDnGQJGk4LrgqAmBFdzU28kefdmVsADZR3yZ1iswLkKIoHHLIIB31g3Jr+Yho5SpOIOWIdWi853mv4SfH2uwPSnqSKcgldxihKb4ZcTxrd+JPBFu++zOx0KcJYc9DDUgV1DjevOOP+RQR7B4iU+STxg9hJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726852931; c=relaxed/simple;
	bh=XuRTGQdHsl+o5fZjArZvReYmvRnEztE4lrWGf0F3hAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nsPWg+nvnWMcrAyf+34k7+P+Axct+FKdBCxCpyyKnoS9f5eNarnaOZruRRYOAv9CyuVW4fM2H/f7L3PsEl4TXuhuTA7H1aKv9bI9hyMW+nETKrG7qiaG1e5wy+JTbsE5/bz4Cmh3WSOWVFDn97jbc/uFBn+aKuHoXCX/lZszLLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Bl+cPe3k; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-374b25263a3so1441999f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 10:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726852927; x=1727457727; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3WyFAU3gZP69K4KqX0oXP5fhiwrGt91LVaFOF0C2rxA=;
        b=Bl+cPe3kSuY7JgrrHiNK94IFjvL47uRBftUucspRwUVLnTS+H08peRiTzBbpaEzUkZ
         0TdeXLqUV83friZMcJ6U4rNPYI0S36Hvr21XhONKK6ksZPYg40sd2r4nDOCRUJVtVoyI
         KVh5azMswr0lH4D4tOmyUb2x8Er0V0ZtjOfitsk4x5m+JaMS4906v9BuO9JNmwh4npuN
         FjV7vjk742+7t/+/xdbvSCmfn6tJfTEhUlvyf5lRFUWkrDe1Y1ESDH8btKCDqJkvP3Tc
         Ph3/5htlAQw4g4hoMptMiNw2Vtm11g6kPtSa8PoKGVHP8nS0IX962H1NRPdtyADBQ/si
         4ZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726852927; x=1727457727;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3WyFAU3gZP69K4KqX0oXP5fhiwrGt91LVaFOF0C2rxA=;
        b=Y7Dqrnieza4RrcgcE5nGTlzRc5TKmSuypjnmmRP8iaiWzlAqdFd9llomfvVobmpOEg
         iKEQFaOCQ5UQ8lt7KrIEwInQ535AG7Dc3cO4IIOEtvVM8W2DvfnhBHoB9Fw31nOk9E1l
         rV5boD9iybcYMxnYCCHOgxh1WEWgrYE7gsI65o63T5T5UHZB9P3gJ76pZEBaSQoAuxoY
         pDcF29y2twBpcWnyPMqradQmFo19p1Os2x63pLTJKSv4624+FUWzcBBayFYEoPVD4GHJ
         F9R2w7s86+ZY0DNsZl9/9kfqCH11QqNKCeZZEUmoMdONBgND0AyRgRlizCRFmkXI3KTt
         yxEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzv6bbvRTqBR+If6te5YEEkz8YV8go5ZnFMJIg7Pyafnson65f3sMGnKh1Js1/Jsz3TbJzlceUy2OWgLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2iG2palLLuKDFvmgHeOfe4BAoN28gcz407VfI49zD5jeeyBdg
	LDnBpDWSbDh6WdRdUTIDoCxfHQxmugDOrz8tDwuq/ClVGJlzJBIITs8OcLQRwyg=
X-Google-Smtp-Source: AGHT+IG7KNVfLQ90kEjbHLvaQHSRq9HiHZ+WNfDBFH1yjqQ1U84p9Dmob7LgtM7MyRrR7k9+SWYCNQ==
X-Received: by 2002:a5d:414f:0:b0:374:fa0a:773c with SMTP id ffacd0b85a97d-37a4235a6a8mr1830952f8f.47.1726852927493;
        Fri, 20 Sep 2024 10:22:07 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:8e69:83a7:a29a:ba83])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-378e72e4b60sm18110432f8f.24.2024.09.20.10.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 10:22:07 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 20 Sep 2024 19:22:05 +0200
Subject: [PATCH] ASoC: meson: axg-iface: set continuous rates
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-asoc-axg-iface-continuous-v1-1-6075d7db0e61@baylibre.com>
X-B4-Tracking: v=1; b=H4sIADyv7WYC/x3MwQqDMAyA4VeRnA10XcG5VxkesphqLu1ophTEd
 7d4/A7/f4BJUTF4dwcU2dU0p4ZH3wGvlBZBnZvBOx/c6B2SZUaqC2okFuSc/pq2vBl+x8CR/DM
 MrwFa/ysStd7vz3SeF22zkTZrAAAA
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2591; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=XuRTGQdHsl+o5fZjArZvReYmvRnEztE4lrWGf0F3hAA=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBm7a89BkCMGZ9R9vS12+/O4OWsWm2IeNTlYXTjA
 OBEK50SSiCJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZu2vPQAKCRDm/A8cN/La
 hUUKEACdGs9IkUiuT3NuUdcgARGZxXhvgtpDwX3qH9I4Bu6xiQy6gckFPpc3CudFn+265183SsF
 YCRsK6YHyVos8rAVXQiEEeqvibbaTBX74GR2QRTYGEyuRYxLsfQK2TfNQEgqOIn0271Bem+Dxjz
 cLZLovFr6w3xJVRal6Vqzv1WaIut/FooIAOhtU93WcqmOJFY9jtKh2LqWRFRKsLKfI5FxAMsdhd
 toV9l1uo5+I9Ie/heDKE2ZJTXf6HKUfAG04eKWLnQ2AGvcpZmbbZU34JiuRr3HKmbZg2Z7YT5Ta
 4nkDhfPJMggVClHZAAvLXFjQEOhdWkDB12anRG+v56jhW4f3gwWHS8DIswzn65BE2O/aT291a0s
 xwe10pn2FzvqoRkFbTUprKnfkZYR9iM3kwPik712VgkIvAOjQdggQ1YHRUrl3+3EoWI9pEJLjmG
 zW/HLr0ajk6V46YL0RWPKDfAdsO9RaN9B931SQ34uE60YB+ik28WhY076G5mMP0wwZDPPtvzcaQ
 3s1evkSxNC+Cz52yBMS/YlBJzBRWudPzFSq7rdSmRTMqLSHGXl9B77Q7RGc6c9gHxMGlwPsjREo
 n2jLti9zZFAmonNzSZCTRoMYbUQz+x/v6JMIVu+HSsJw/fCSq35gpBxKdQDiNzrP5TUE0jyePWm
 mm0bVeF1h6JYfew==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

The axg TDM HW does not depend on a selected set of rates.
The hardware itself, just takes an input clock and work with it, regardless
of its rate. In this way, the rates TDM can take are continuous.

What might force the use of specific rate are the PLL available as clock
and/or the codecs facing the TDM HW. Either way, this constraint does not
belong in the TDM interface driver.

Allow any rate as far as TDM is concerned by setting
SNDRV_PCM_RATE_CONTINUOUS with an interval it has been tested with.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-tdm-interface.c | 12 +++++++++---
 sound/soc/meson/axg-tdm.h           |  2 --
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/soc/meson/axg-tdm-interface.c b/sound/soc/meson/axg-tdm-interface.c
index 62057c71f742..09103eef2a97 100644
--- a/sound/soc/meson/axg-tdm-interface.c
+++ b/sound/soc/meson/axg-tdm-interface.c
@@ -442,14 +442,18 @@ static const struct snd_soc_dai_driver axg_tdm_iface_dai_drv[] = {
 			.stream_name	= "Playback",
 			.channels_min	= 1,
 			.channels_max	= AXG_TDM_CHANNEL_MAX,
-			.rates		= AXG_TDM_RATES,
+			.rates		= SNDRV_PCM_RATE_CONTINUOUS,
+			.rate_min	= 5512,
+			.rate_max	= 768000,
 			.formats	= AXG_TDM_FORMATS,
 		},
 		.capture = {
 			.stream_name	= "Capture",
 			.channels_min	= 1,
 			.channels_max	= AXG_TDM_CHANNEL_MAX,
-			.rates		= AXG_TDM_RATES,
+			.rates		= SNDRV_PCM_RATE_CONTINUOUS,
+			.rate_min	= 5512,
+			.rate_max	= 768000,
 			.formats	= AXG_TDM_FORMATS,
 		},
 		.id = TDM_IFACE_PAD,
@@ -461,7 +465,9 @@ static const struct snd_soc_dai_driver axg_tdm_iface_dai_drv[] = {
 			.stream_name	= "Loopback",
 			.channels_min	= 1,
 			.channels_max	= AXG_TDM_CHANNEL_MAX,
-			.rates		= AXG_TDM_RATES,
+			.rates		= SNDRV_PCM_RATE_CONTINUOUS,
+			.rate_min	= 5512,
+			.rate_max	= 768000,
 			.formats	= AXG_TDM_FORMATS,
 		},
 		.id = TDM_IFACE_LOOPBACK,
diff --git a/sound/soc/meson/axg-tdm.h b/sound/soc/meson/axg-tdm.h
index 1a17f546ce6e..acfcd48f8a00 100644
--- a/sound/soc/meson/axg-tdm.h
+++ b/sound/soc/meson/axg-tdm.h
@@ -15,8 +15,6 @@
 
 #define AXG_TDM_NUM_LANES	4
 #define AXG_TDM_CHANNEL_MAX	128
-#define AXG_TDM_RATES		(SNDRV_PCM_RATE_5512 |		\
-				 SNDRV_PCM_RATE_8000_768000)
 #define AXG_TDM_FORMATS		(SNDRV_PCM_FMTBIT_S8 |		\
 				 SNDRV_PCM_FMTBIT_S16_LE |	\
 				 SNDRV_PCM_FMTBIT_S20_LE |	\

---
base-commit: cd87a98b53518e44cf3c1a7c1c07c869ce33bf83
change-id: 20240920-asoc-axg-iface-continuous-b94cfa234787

Best regards,
-- 
Jerome


