Return-Path: <linux-kernel+bounces-317240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFF796DB58
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FF1F1C24E43
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE98F19F469;
	Thu,  5 Sep 2024 14:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mjNgSb58"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A5119E7F6
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725545619; cv=none; b=FiianiDm2ASarpvLwC+ApALNARF7DYR3ajzlkTmLDmxoYkGmJW4LOwd362aeq38hzZX/gI6b8a31CgOB1UVtdxpiNiFyG48QnRNdC1FdAFZiZR13R3VeKK8eylYADtH1aoY/UqNJt5MuA7BurwRKn7UtPfJNNP1FrOrdQLjDYs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725545619; c=relaxed/simple;
	bh=JlFXCBTD6wmPGs3Xc+eBXJCnNEzFsRasRZacDAmL1po=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q5Df7anX8v43Wvu4xW9saM94QG5BNPVEsRctfbmOC1j1fxEwKWqsRNyPKfuDbjM89akqH6a48Fez33Li/H/FnVZEDdZvy2pI8JPcEtVkYkrc+qGZECy9T4/bYVBM7ZHYjhfeSTZlPYbJdVbkzT2Gl8bSFIpbUv4q9Kbac7VGAkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mjNgSb58; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42c79deb7c4so6808965e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 07:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725545615; x=1726150415; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EZ4OWj1M1ZpMsgNdFCjWDSBf4jaOw7GENdrNyJWLeh4=;
        b=mjNgSb58RvsGP1YPnH1kvID+xhTT+00ncOTZIpNpKBo2yC4RLzjSnaAUt/bVwLOBJh
         5wfpm6eNDTrYy/W9DKJHVq2wg9npLvtwSt+eXauuHZ9RbRrBtc1Vj4q6qLM1g2Zzjc8X
         ksOXTs8eSHGOae1WpmXnABkyZn7cRO1UyMU9h+QDkc8/tDlYZf3joN6XLCo7bstt9AwE
         lUW9J20pWSsaJW10NZnjv2tJPMr/VQ33JP3N7rBoiqHXpwjb4khi7lKQ7tQ2D7Ajy8F0
         FzW8KTadi2A2fG9IyX1UPeIEevoasENsPsKW4HKCg5ts/QaaCHDZeXxP5S+D19sxBkc9
         QWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725545615; x=1726150415;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZ4OWj1M1ZpMsgNdFCjWDSBf4jaOw7GENdrNyJWLeh4=;
        b=mge+njWL851oRjCtQ2hGaHwofwTQLtD0n4ymV4zAEXZ8rjSZ2gC0Gz4QeA1JSpkeRE
         /fhBbw0Z0RTVmZR1rLG8Vhuv23aF9hvb95xfRzf6WRp5dS7cDdGO0ErUlljBxOg8RVfj
         K5wA/pWJ29ExSiW/g1teEx0IzHQ4r3T1JYINx9O4G+l+4WJH/+g3PxXjJiWnpApEf6R/
         EN6NgLVKZuu36L24E1ac1r/m4v363r+d9r/07e5F1duhKLGkQlz9d99cRM9xz6VQc9Sz
         L5W/f191GQJIelh9uWCctXdu9aurDa1pK9/3gVO8JRchddY821B1jMTizxo2YHpXMENr
         x6lQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCDjcTh1l/qhy2O7BN0oUC2mDvCMgFuhNiJz1sHWZ6CIXb8G1Do7G6dtflYoadXcoe6lsuvxwv3LQo7GQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnO8NOaoPIMuuDyiBlCGCleGa5G2mTujcioZ2kOMAX04SCkzf7
	vPlk1sDHjOCszCsoGeF0NhiQzIZP1Hhr5jRzSPS2TYHG3oMRaS5enC2vO6aTCvM=
X-Google-Smtp-Source: AGHT+IFQfpi2p18CVl/s3bTmgrKQh6HdDCkB/ZnyhlaiBCzX95JZK0PtErVMddC8kBx8lcb0js+0/g==
X-Received: by 2002:adf:9b86:0:b0:374:becb:d9de with SMTP id ffacd0b85a97d-374bf1c7963mr11972286f8f.44.1725545614620;
        Thu, 05 Sep 2024 07:13:34 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:4763:343b:23f3:f45])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3749ef81146sm19514621f8f.82.2024.09.05.07.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 07:13:34 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 05 Sep 2024 16:12:54 +0200
Subject: [PATCH 03/13] ALSA: emu10k1: drop SNDRV_PCM_RATE_KNOT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-alsa-12-24-128-v1-3-8371948d3921@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2791; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=JlFXCBTD6wmPGs3Xc+eBXJCnNEzFsRasRZacDAmL1po=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBm2bx/F8WSx9SFo+Mm9aAwm5w5LTGeCtAOKiZNf
 Pbdd3RViiaJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZtm8fwAKCRDm/A8cN/La
 hTO8EACfpShxFfUfKBhcVOFgGnGLNcUrNcxHpvHeMT6YKdbtHho2dcF4RxIgzZdG3+MPzTgKCsW
 qKwzGfpKhAFRS6wz5tGK2UDhdk9tmZbGfUuW6KsvzNurvkxqxjpLh6jkrxbwhOlIIj+gSeIsihV
 1RzUbnyNg04AeMAF12l3PCpFSDVgbG/0/gxVUZJx36yb1cvmXRleVELUnsz+i8WZls+5AtDZkE9
 jtQsHRZyN5VXTEqPk7THy7bb6rstqW6VdH0/jPmShDW6iTIvQCj5p8a0HpoQd+/K9aiYYjlqOdm
 aqK+TDzCsgimu0ca4dqsAkGaSZty17/RfWigRs9LBY5l20spNTAO/JIrXatmZqYlarMJjKNKPqO
 CEF4exBkSiDErgJkF6us0XqfEr+iNGXQ87/u8K8uN5+WbFHv4ynZDkpkXALb6BQFlB0aCCW4cAb
 oOiDds2ZlszM5mDHqjnYAO5vk3Sme/eAsXFMp6UlcqgJ8cq03VUPPJncB3iDzZrp/84D+/wzsZc
 9AQkvBpyzPJyMenwxVTwPk9xpACxwpyZXwcgBdQ1xynVrzwLyUe38AV6DW3kPzeky8TxBY/eZ1i
 OV1dJqvbu8GAQ8b0IjB7E9YlEFZq0QpqCANP9bBuHv0scQAgZlA615zxiwoWpWzpc5DHYUDAnZp
 LIBw1U57xD093jg==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

The custom rate constraint lists were necessary to support 12kHz and 24kHz.
These rates are now available through SNDRV_PCM_RATE_12000 and
SNDRV_PCM_RATE_24000.

Use them and drop the custom rate constraint rules.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/pci/emu10k1/emupcm.c | 31 +++++--------------------------
 1 file changed, 5 insertions(+), 26 deletions(-)

diff --git a/sound/pci/emu10k1/emupcm.c b/sound/pci/emu10k1/emupcm.c
index 7f4c1b38d6ec..1bf6e3d652f8 100644
--- a/sound/pci/emu10k1/emupcm.c
+++ b/sound/pci/emu10k1/emupcm.c
@@ -147,16 +147,6 @@ static const struct snd_pcm_hw_constraint_list hw_constraints_capture_buffer_siz
 	.mask = 0
 };
 
-static const unsigned int capture_rates[8] = {
-	8000, 11025, 16000, 22050, 24000, 32000, 44100, 48000
-};
-
-static const struct snd_pcm_hw_constraint_list hw_constraints_capture_rates = {
-	.count = 8,
-	.list = capture_rates,
-	.mask = 0
-};
-
 static unsigned int snd_emu10k1_capture_rate_reg(unsigned int rate)
 {
 	switch (rate) {
@@ -174,16 +164,6 @@ static unsigned int snd_emu10k1_capture_rate_reg(unsigned int rate)
 	}
 }
 
-static const unsigned int audigy_capture_rates[9] = {
-	8000, 11025, 12000, 16000, 22050, 24000, 32000, 44100, 48000
-};
-
-static const struct snd_pcm_hw_constraint_list hw_constraints_audigy_capture_rates = {
-	.count = 9,
-	.list = audigy_capture_rates,
-	.mask = 0
-};
-
 static unsigned int snd_emu10k1_audigy_capture_rate_reg(unsigned int rate)
 {
 	switch (rate) {
@@ -207,17 +187,16 @@ static void snd_emu10k1_constrain_capture_rates(struct snd_emu10k1 *emu,
 {
 	if (emu->card_capabilities->emu_model &&
 	    emu->emu1010.word_clock == 44100) {
-		// This also sets the rate constraint by deleting SNDRV_PCM_RATE_KNOT
 		runtime->hw.rates = SNDRV_PCM_RATE_11025 | \
 				    SNDRV_PCM_RATE_22050 | \
 				    SNDRV_PCM_RATE_44100;
 		runtime->hw.rate_min = 11025;
 		runtime->hw.rate_max = 44100;
-		return;
+	} else if (emu->audigy) {
+		runtime->hw.rates = SNDRV_PCM_RATE_8000_48000 |
+				    SNDRV_PCM_RATE_12000 |
+				    SNDRV_PCM_RATE_24000;
 	}
-	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
-				   emu->audigy ? &hw_constraints_audigy_capture_rates :
-						 &hw_constraints_capture_rates);
 }
 
 static void snd_emu1010_constrain_efx_rate(struct snd_emu10k1 *emu,
@@ -1053,7 +1032,7 @@ static const struct snd_pcm_hardware snd_emu10k1_capture =
 				 SNDRV_PCM_INFO_RESUME |
 				 SNDRV_PCM_INFO_MMAP_VALID),
 	.formats =		SNDRV_PCM_FMTBIT_S16_LE,
-	.rates =		SNDRV_PCM_RATE_8000_48000 | SNDRV_PCM_RATE_KNOT,
+	.rates =		SNDRV_PCM_RATE_8000_48000 | SNDRV_PCM_RATE_24000,
 	.rate_min =		8000,
 	.rate_max =		48000,
 	.channels_min =		1,

-- 
2.45.2


