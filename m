Return-Path: <linux-kernel+bounces-233882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D9491BEA6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CD8B284198
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BCD158215;
	Fri, 28 Jun 2024 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RAnj/GYB"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E31156967
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 12:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719577997; cv=none; b=Gangeq1eS3L6JDPPjXJ8JQwvgSuclLXQ1Sb40kJF5aW+Msh1J2SuDdeG8l+EhJNvYtowcBx6v0nqvFYHe66gcTynhI6cDxu2ZBZBpuxufF1QY6cH52zzDE3s8OofLe1y30srEOoyQPHVXEhavSIEKn8cFOMWttPw4ThgMPdgEsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719577997; c=relaxed/simple;
	bh=sOvtDIcHqFb+rKIqyNMDLUrepY/Oa4wmuXrMcLcuz6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vGo+eif1B9+b7nTFwBioj1xRXLguMTptLqS21yr8iMw3thRloPLXVpsOirTUn1HcvY98a0faMfqc8Utnyx2Rhcaic0Hom8jdO1yhtFP3gvB0cekvfUOO6T+dbXsVw3dzcVVEPuU7DP1T0cm+2NSNu/Hum75yTLGnkHaPPZdlCRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RAnj/GYB; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ebe40673d8so6671771fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 05:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719577993; x=1720182793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ByitVlXA6nhfpW6PjFdoGZsiVDUb87dQzsQq5KJFjRU=;
        b=RAnj/GYB3pjf3s06eDH9VwuJ0RJ3xMtFvA+VOLw/125eLlSZzrRt7s5ByKlB5ecaAE
         mUS/HoO+LuOz+fpCFPlWz6aggmp20S59K8owNFsDVu0CUwWWZseQ52xykkSevgPBus6g
         gKbbYQGOsSP1sctByBgmfQ+vnl0vbsuzaRkTiQyDCTWM033O50K04IX8JxAtGZsEsRN3
         4vE/WCYrf72YgxBuOFdqV4AT0gc0ZcfQ/PtnoZqz7Ljw9NuwM2D9jm0CZuIu45YARUTS
         XgIAmo7s4Cj8DSy6Fws+UOUciooP1jZt25DL85t2GY7o48SaI9pdRJV4rlaSu5SNxLql
         j6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719577993; x=1720182793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ByitVlXA6nhfpW6PjFdoGZsiVDUb87dQzsQq5KJFjRU=;
        b=jWijM2P9gU5Xhbsuqg8fNY3wMKku7A8v/qj6hdS+o87EZvM8jfgRtCEOGMdQmeGAGQ
         6fi67baw+IlmmdrZOjU2p21r053WKZvK14jIcNakuRxbVBTHghg1gqE0xAVIDOkzd2B8
         S3zNTBuyyNRizNCE6TAjmns1axDrNMg7R2v46RMakIagi79SRP/nY8+Y+kUpz7GpdBCV
         NQ//gZiVFdqQO3m4LmolfZwE/igSF6AcCuRTZDBsz1FtX2KxeBFSslkVEt5kQ9DePz3C
         btS+XdK3M4el8+UQK70iSEFsV14KCkn1CN9pwQ4tXf81KTCPn964Eq9NzeZlBUAtOQe8
         XrcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDn0TJ0dR2QM6ZjAhF2vl+3I2p5lNmpreLSgAXhsb28VoPaFUUS6tjNwcROO/c5pabGfq2Ew2mQMOlhQUQkJt+DTFUuLTyXG9UCht+
X-Gm-Message-State: AOJu0YxF4MCfcoVdFd0mJQfrOLD13BUOH4/2pFh7WsTEBof7XwD7HINk
	+mLNecn1/IGC6Jdtr24ZfxWsLCNi/MZvxhFD97COde55C5VvkzS0/H0MGE60/Uw1Ak8U8aWiErB
	fOcs=
X-Google-Smtp-Source: AGHT+IHz/uNtBn4C3DHDM1aScnu28pMEPRreVGC8UWvz2fxy9dEUhXjjiQDtOaC24cz8ouavSZ1KUg==
X-Received: by 2002:a2e:720b:0:b0:2ec:4096:4bc6 with SMTP id 38308e7fff4ca-2ec5b318000mr95955161fa.7.1719577992700;
        Fri, 28 Jun 2024 05:33:12 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:78b7:4c75:7e6e:807f])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4256af59732sm33916715e9.11.2024.06.28.05.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 05:33:12 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-amlogic@lists.infradead.org,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: meson: tdm: add sample rate support up to 768kHz
Date: Fri, 28 Jun 2024 14:32:54 +0200
Message-ID: <20240628123256.2019224-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

Add support for 705.6kHz and 768kHz sample rates

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-fifo.c  | 2 +-
 sound/soc/meson/axg-frddr.c | 4 ++--
 sound/soc/meson/axg-tdm.h   | 2 +-
 sound/soc/meson/axg-toddr.c | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
index 59abe0b3c59f..7e6090af720b 100644
--- a/sound/soc/meson/axg-fifo.c
+++ b/sound/soc/meson/axg-fifo.c
@@ -32,7 +32,7 @@ static const struct snd_pcm_hardware axg_fifo_hw = {
 		 SNDRV_PCM_INFO_NO_PERIOD_WAKEUP),
 	.formats = AXG_FIFO_FORMATS,
 	.rate_min = 5512,
-	.rate_max = 384000,
+	.rate_max = 768000,
 	.channels_min = 1,
 	.channels_max = AXG_FIFO_CH_MAX,
 	.period_bytes_min = AXG_FIFO_BURST,
diff --git a/sound/soc/meson/axg-frddr.c b/sound/soc/meson/axg-frddr.c
index e97d43ae7fd2..e70c8c34c7db 100644
--- a/sound/soc/meson/axg-frddr.c
+++ b/sound/soc/meson/axg-frddr.c
@@ -112,7 +112,7 @@ static struct snd_soc_dai_driver axg_frddr_dai_drv = {
 		.channels_max	= AXG_FIFO_CH_MAX,
 		.rates		= SNDRV_PCM_RATE_CONTINUOUS,
 		.rate_min	= 5515,
-		.rate_max	= 384000,
+		.rate_max	= 768000,
 		.formats	= AXG_FIFO_FORMATS,
 	},
 	.ops		= &axg_frddr_ops,
@@ -189,7 +189,7 @@ static struct snd_soc_dai_driver g12a_frddr_dai_drv = {
 		.channels_max	= AXG_FIFO_CH_MAX,
 		.rates		= SNDRV_PCM_RATE_CONTINUOUS,
 		.rate_min	= 5515,
-		.rate_max	= 384000,
+		.rate_max	= 768000,
 		.formats	= AXG_FIFO_FORMATS,
 	},
 	.ops		= &g12a_frddr_ops,
diff --git a/sound/soc/meson/axg-tdm.h b/sound/soc/meson/axg-tdm.h
index daaca10fec9e..1a17f546ce6e 100644
--- a/sound/soc/meson/axg-tdm.h
+++ b/sound/soc/meson/axg-tdm.h
@@ -16,7 +16,7 @@
 #define AXG_TDM_NUM_LANES	4
 #define AXG_TDM_CHANNEL_MAX	128
 #define AXG_TDM_RATES		(SNDRV_PCM_RATE_5512 |		\
-				 SNDRV_PCM_RATE_8000_384000)
+				 SNDRV_PCM_RATE_8000_768000)
 #define AXG_TDM_FORMATS		(SNDRV_PCM_FMTBIT_S8 |		\
 				 SNDRV_PCM_FMTBIT_S16_LE |	\
 				 SNDRV_PCM_FMTBIT_S20_LE |	\
diff --git a/sound/soc/meson/axg-toddr.c b/sound/soc/meson/axg-toddr.c
index e03a6e21c1c6..03512da4092b 100644
--- a/sound/soc/meson/axg-toddr.c
+++ b/sound/soc/meson/axg-toddr.c
@@ -131,7 +131,7 @@ static struct snd_soc_dai_driver axg_toddr_dai_drv = {
 		.channels_max	= AXG_FIFO_CH_MAX,
 		.rates		= SNDRV_PCM_RATE_CONTINUOUS,
 		.rate_min	= 5515,
-		.rate_max	= 384000,
+		.rate_max	= 768000,
 		.formats	= AXG_FIFO_FORMATS,
 	},
 	.ops		= &axg_toddr_ops,
@@ -228,7 +228,7 @@ static struct snd_soc_dai_driver g12a_toddr_dai_drv = {
 		.channels_max	= AXG_FIFO_CH_MAX,
 		.rates		= SNDRV_PCM_RATE_CONTINUOUS,
 		.rate_min	= 5515,
-		.rate_max	= 384000,
+		.rate_max	= 768000,
 		.formats	= AXG_FIFO_FORMATS,
 	},
 	.ops		= &g12a_toddr_ops,
-- 
2.43.0


