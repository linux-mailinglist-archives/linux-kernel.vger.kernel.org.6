Return-Path: <linux-kernel+bounces-233866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCED91BE79
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDAA21C21D6E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68044158D69;
	Fri, 28 Jun 2024 12:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TQaDi+Fs"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB361586FE
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 12:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719577482; cv=none; b=P4FoAkwWoYWw0HRziiugxR+HPTuaWPiFxlqFU7VVN3dY7qzgMftHoWUmbDz1t9jzJEzh8uIt7toJQJnMJJ6/Wa46UTiSUeVWlUXoz2ADY+eeI78lW5WrvTOSlctQ16nJdQkSWGvbfm4z1zQbD1DpjdWTAaLWqabTcJwhd/vbMrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719577482; c=relaxed/simple;
	bh=sciaPAJqEgX1NHQM4wEWy3GtvEwtZw9xH14CYUn5eV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZh2DtVvkqiJsfOodyLiy7/C82I5//pQ+LRKCqqegOJ2SkYLpAokOTGfvz6T/Mb+PSEv87jRGfo9C7mlxX2hxsXJxrBMjj5C9oqTJbn2ihfzwn9VDAMQZLN6wsXh9lEK+Yj61h3nFfcvoOF7M+KnsJ7Gwgx3fYcj9494DKzAG8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TQaDi+Fs; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-362bc731810so454161f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 05:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719577479; x=1720182279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hW3lP4hCIw/t+/Lvw7tibKaBu1RE1UvWiqJ7tmwsGo=;
        b=TQaDi+FsADQftnuL/mzWFf2QaeCEEwKNstceK03N7jEIK3VbzyScOJkQEA4GwvkwEO
         T2HV+LUKAfw2KUnl8TOR55YB9KCWV5/CyOVuF1uqiaCdkaKTW8ZACEmNBFAw/kFDS7R7
         uY5Tk1LPKyCQmWtso4rzaj/IDDXtY16UVqaifM/uwU2WL4FQWpaXURz1OwYV3oh99/nI
         vaGHNXEwWoL0oIqyiv0AY10we/qzNLFNiqBq8EDNm57MPF9wo8vUDVSlQwmYwCM98ekr
         /Wk7zAdTjw8tYgxTtww8bMLDqNxkxZa3UKPncupm4ZKgQY4RREWsxx8VjAuGBd5oOHsA
         Y+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719577479; x=1720182279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hW3lP4hCIw/t+/Lvw7tibKaBu1RE1UvWiqJ7tmwsGo=;
        b=GKXh/uMH7YnaQY4tLqtbnkQdQCU24RdO75fben/uBgID/tH1HdO7ZwqZYCKJY2EJyA
         0nx3kNsJV3yUJQshjzwfqO5U6V8PyEbHZyFbFMevHaIi/5VbVSc5i+yrI2D60tCueWXN
         uqlml//Wj7P9cOF+cj4q+p3yaON1bqyEWQK8h7wi3GfVK4AVP1/OxmP1J8S/x9KGEfCY
         sT+TCISbU7pvrInHlyStRjtBMUyKXHSVHFj3ysmwi9fOF+4Lf2mTOpyt6EclVcZ8PFXs
         /Wk7jnRHIbeS5gEgl/eZUA/pTNQHkrg5kHXH0gK7lJyA7vvxiOAch/HFzTotbg9s19mu
         aBqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCMe7IiEkYwJiPw5ci4urp4qr6o4sl/idIUuRWZ9Axs8u7+KSGaWVEsV/XX0/j2xtn1prCPf/UOPOvaHqJeWvRmO8T1dVfnvzi313O
X-Gm-Message-State: AOJu0YxYUjVm1SvibTZoQ7tY60VCgIohz/94C0z5f3twF0ZbCZW1LVKA
	Xx/KlkKqnI6rd0IkYAatlcZ/4bHh1YzSphzL8g+hL743hBIPUBaqlhJUN/FSjgs=
X-Google-Smtp-Source: AGHT+IFCBRrgEPYiJUK/9y0AlZTM7uvye/PRdCItIPgKpi1qBz5asnELoxu7K+MOu68SHYidDVADkg==
X-Received: by 2002:a05:6000:1bd1:b0:363:598:524f with SMTP id ffacd0b85a97d-366e94d6928mr13084226f8f.31.1719577479529;
        Fri, 28 Jun 2024 05:24:39 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:78b7:4c75:7e6e:807f])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3675a0cd623sm2179013f8f.16.2024.06.28.05.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 05:24:38 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ASoC: spdif: extend supported rates to 768kHz
Date: Fri, 28 Jun 2024 14:23:08 +0200
Message-ID: <20240628122429.2018059-4-jbrunet@baylibre.com>
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

IEC958-3 defines sampling rate up to 768 kHz.
Such rates maybe used with high bandwidth IEC958 links, such as eARC.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/spdif_receiver.c    | 3 ++-
 sound/soc/codecs/spdif_transmitter.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/spdif_receiver.c b/sound/soc/codecs/spdif_receiver.c
index 862e0b654a1c..310123d2bb5f 100644
--- a/sound/soc/codecs/spdif_receiver.c
+++ b/sound/soc/codecs/spdif_receiver.c
@@ -28,7 +28,8 @@ static const struct snd_soc_dapm_route dir_routes[] = {
 	{ "Capture", NULL, "spdif-in" },
 };
 
-#define STUB_RATES	SNDRV_PCM_RATE_8000_192000
+#define STUB_RATES	(SNDRV_PCM_RATE_8000_768000 | \
+			 SNDRV_PCM_RATE_128000)
 #define STUB_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
 			SNDRV_PCM_FMTBIT_S20_3LE | \
 			SNDRV_PCM_FMTBIT_S24_LE  | \
diff --git a/sound/soc/codecs/spdif_transmitter.c b/sound/soc/codecs/spdif_transmitter.c
index 736518921555..db51a46e689d 100644
--- a/sound/soc/codecs/spdif_transmitter.c
+++ b/sound/soc/codecs/spdif_transmitter.c
@@ -21,7 +21,8 @@
 
 #define DRV_NAME "spdif-dit"
 
-#define STUB_RATES	SNDRV_PCM_RATE_8000_192000
+#define STUB_RATES	(SNDRV_PCM_RATE_8000_768000 | \
+			 SNDRV_PCM_RATE_128000)
 #define STUB_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
 			SNDRV_PCM_FMTBIT_S20_3LE | \
 			SNDRV_PCM_FMTBIT_S24_LE  | \
-- 
2.43.0


