Return-Path: <linux-kernel+bounces-233864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEA791BE77
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F5231F21D66
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77555158866;
	Fri, 28 Jun 2024 12:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3EBTitZu"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E488315689A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 12:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719577480; cv=none; b=jneWTxH+Epp4fMvVgoVp4LRhz9MV/7CXcQDCeujQ+ANZvscIF2nFQ1B+StMNN4Egoq+sZ0JjrpemqziCohW9q7s5H2cSFQ922SuzqkxwozueEpc1lclagXScjFirCyQKDj5Ytnc1jRlAE4iDug8uzGM7ioaRIAQt5Ln1XnHzH+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719577480; c=relaxed/simple;
	bh=b27QyUJ5iOMLnb1ywUx1HGcm5LsMzNtf07lcBa/92Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thOlnHCLJVbfUGdRhn/7Ol/878y3VMrmkWs3YQz7eNZ5SKKljkjwH3zUN7HJ1S+DHZ4+6RCl0mf8srubrmijw2NdbhJlHG3G0wLrjYG0Jy23tbHZGU8pcBnZblTassVqSyOOrEEi2ldQLvY0uNdOgySPyEu9medhsznKxcWwmU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3EBTitZu; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-366df217347so394072f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 05:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719577477; x=1720182277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnFOU1sbIqgovk5xhdHMfKNOv2vMSdFoRWRnoLUU7uY=;
        b=3EBTitZueSjtCWbDr3C+DgAprV/X4UnLcM43NnHWcSqVxco+HcL0QdJ732Sd6OYVgl
         BMagorq2aKDeIOB+QkB6p3lNfFTjyoWTRjDcOgBLdivqsNw+xGtSpH9dKZjzZj5Gua9h
         uE+Qx6h8RW59+VxiCTR11kslt5a8pUiIwckn7p7fR0TMfMsyj/yeyNrkiK4eSl2po8ux
         5slXOJq4DA0s24MHrzuzkUT9LGkehJNMZ4+Oipdtui2tellxjm9IwMtKN7nCWu8fSqNP
         iVNx5t0wrdie12mbrg2sxVqBUpi1mF88lDu7ut1Bk2wvEETvkUg/m+mIhlrXHPAX/jKe
         Udgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719577477; x=1720182277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lnFOU1sbIqgovk5xhdHMfKNOv2vMSdFoRWRnoLUU7uY=;
        b=PNcwhx2HCdEhHegeSPaWt0vtyPGnEpll1J+11W9NLqZ562NAV48IfRBHMCovtK/Ezx
         9BoxJzrBmvjlCGKigjkotb3ZTlGHW9SEr1zJz8nIsj+5cG6evQ2HZFosg4vfcjE+4C/N
         SPDilGBoIRG4GP/fHlbpoxy87qni/td4i2+1+U2KdvMCSt+9LjdSjtwdYzNdCrdCsRc9
         C3SoVWZAw+3bkzvsVYYBu2l8+nELaSnl/AiApDrnjaQp7ex5CoymL7u/hUgrDFKvJ4Nd
         tVKcD+UiZtgKP/ff1SJVL+/moh1WQNxtCpdsR1oi0HP9dbeQJs+K9f9sJe91PAb0d8lU
         jW+w==
X-Forwarded-Encrypted: i=1; AJvYcCVugzWEpKbwkNH9ctNzSYo4SRSIGifdxJvXvKVWkuTDBe5m9bwHax+xf60PakB/Ka+1VQaRVwiUusKlG5c+RvVw4JBkhJODxnk0MYO1
X-Gm-Message-State: AOJu0YzHuUj0dNw0tHbqsZ2tmqR9rQXJyTY6ZA9xvX82d1wPLQkRnnV4
	3GYqv5Xi/9U+oy0m1uXFeIgakH17MWNSFJsmCMI24uSUFpE5+ZKGyPEPysTPrcU=
X-Google-Smtp-Source: AGHT+IHcx4P02qa9MVJ93L8rnvMkCnp9jNt5pVErQKhpVoNe+nIx6+jrMgw0cTPvYrDqw0YMkFWn9A==
X-Received: by 2002:adf:e682:0:b0:367:5280:a40a with SMTP id ffacd0b85a97d-3675280a593mr2487589f8f.42.1719577477194;
        Fri, 28 Jun 2024 05:24:37 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:78b7:4c75:7e6e:807f])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3675a0cd623sm2179013f8f.16.2024.06.28.05.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 05:24:36 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ALSA: pcm: add support for 128kHz sample rate
Date: Fri, 28 Jun 2024 14:23:06 +0200
Message-ID: <20240628122429.2018059-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240628122429.2018059-1-jbrunet@baylibre.com>
References: <20240628122429.2018059-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

The usual sample rate possible on an SPDIF link are
32k, 44.1k, 48k, 88.2k, 96k, 172.4k and 192k.

With higher bandwidth variant, such as eARC, and the introduction of 8
channels mode, the spdif frame rate may be multiplied by 4. This happens
when the interface use an IEC958_SUBFRAME format.

The spdif 8 channel mode rate list is:
128k, 176.4k, 192k, 352.8k, 384k, 705.4k and 768k.

All are already supported by ASLA expect for the 128kHz one.
Add support for it but do not insert it the SNDRV_PCM_RATE_8000_192000
macro. Doing so would silently add 128k support to a lot of HW which
probably do not support it.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 include/sound/pcm.h     | 13 +++++++------
 sound/core/pcm_native.c |  6 +++---
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 3edd7a7346da..9cda92b34eda 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -116,12 +116,13 @@ struct snd_pcm_ops {
 #define SNDRV_PCM_RATE_64000		(1U<<8)		/* 64000Hz */
 #define SNDRV_PCM_RATE_88200		(1U<<9)		/* 88200Hz */
 #define SNDRV_PCM_RATE_96000		(1U<<10)	/* 96000Hz */
-#define SNDRV_PCM_RATE_176400		(1U<<11)	/* 176400Hz */
-#define SNDRV_PCM_RATE_192000		(1U<<12)	/* 192000Hz */
-#define SNDRV_PCM_RATE_352800		(1U<<13)	/* 352800Hz */
-#define SNDRV_PCM_RATE_384000		(1U<<14)	/* 384000Hz */
-#define SNDRV_PCM_RATE_705600		(1U<<15)	/* 705600Hz */
-#define SNDRV_PCM_RATE_768000		(1U<<16)	/* 768000Hz */
+#define SNDRV_PCM_RATE_128000		(1U<<11)	/* 128000Hz */
+#define SNDRV_PCM_RATE_176400		(1U<<12)	/* 176400Hz */
+#define SNDRV_PCM_RATE_192000		(1U<<13)	/* 192000Hz */
+#define SNDRV_PCM_RATE_352800		(1U<<14)	/* 352800Hz */
+#define SNDRV_PCM_RATE_384000		(1U<<15)	/* 384000Hz */
+#define SNDRV_PCM_RATE_705600		(1U<<16)	/* 705600Hz */
+#define SNDRV_PCM_RATE_768000		(1U<<17)	/* 768000Hz */
 
 #define SNDRV_PCM_RATE_CONTINUOUS	(1U<<30)	/* continuous range */
 #define SNDRV_PCM_RATE_KNOT		(1U<<31)	/* supports more non-continuous rates */
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 521ba56392a0..87eeb9b7f54a 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2410,13 +2410,13 @@ static int snd_pcm_hw_rule_sample_bits(struct snd_pcm_hw_params *params,
 	return snd_interval_refine(hw_param_interval(params, rule->var), &t);
 }
 
-#if SNDRV_PCM_RATE_5512 != 1 << 0 || SNDRV_PCM_RATE_192000 != 1 << 12
+#if SNDRV_PCM_RATE_5512 != 1 << 0 || SNDRV_PCM_RATE_768000 != 1 << 17
 #error "Change this table"
 #endif
 
 static const unsigned int rates[] = {
-	5512, 8000, 11025, 16000, 22050, 32000, 44100,
-	48000, 64000, 88200, 96000, 176400, 192000, 352800, 384000, 705600, 768000
+	5512, 8000, 11025, 16000, 22050, 32000, 44100, 48000, 64000, 88200,
+	96000, 128000, 176400, 192000, 352800, 384000, 705600, 768000,
 };
 
 const struct snd_pcm_hw_constraint_list snd_pcm_known_rates = {
-- 
2.43.0


