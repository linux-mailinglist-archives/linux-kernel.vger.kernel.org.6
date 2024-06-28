Return-Path: <linux-kernel+bounces-233838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9239891BE05
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C19121C218C7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B053F156C70;
	Fri, 28 Jun 2024 12:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="z/UT7+T/"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C868481A4
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 12:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719576100; cv=none; b=s7/8jdUjzhTfZRFaBOFzxV80PIk6H6nybWdapNUlrCwz89Jm/lG1GAnIKgJeyKvF+k9vKZymu2/Pf3enGyjj+Xg9ugDIj15B5nUjYE+xq1xaWEOeMpZLHUO1viGJ7AsnuetnGNyvzjYdrH86YvHBF9a/exrrv8Hlms8iIt7+rMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719576100; c=relaxed/simple;
	bh=FL0t0m2M/0DHO8Vt+eyL9AVi2FKenLJkknNMn/z5lcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ALhIq9SXEAgdbmitxq79tPOuH3d6q/RDM4HTwxwBgoiODek27qhRGjNnkHsx4ZgfMlrIPsgBio4x7DYd2Sf399udAuY7vw2PpftiGyDu7PuP2Rog4FNQIfT7H/HtpmpNQG2QC07kbVUy+8YXQyVF6RSRUW4wB9MklsxbuagEhhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=z/UT7+T/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so3382985e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 05:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719576096; x=1720180896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nlz+Gu51Kc+D7SoDZ5PKnSpVHKmOE/JB0x93VS7SH9E=;
        b=z/UT7+T/djfYr+UtwA5FBhVMrR7FIuo7JDtet1LVHwzhN2iT5uEmx/aygXQJVYto96
         3E+j426xzEJ2irCjd9suw5t5I79ev02MRB9Aokna2XTpZQ9u75GPM0tOpoi8Pn1YMXw3
         ogzBLStUCQbkr58bkKCgZc31dg/Bbfyg1sJk7xXso3sKWogwasuzUln/fJnE+d3i2TxB
         LRDzA/LhQRwKMOrpqrCm7t0YsX6p7Kam9xqyNsVfsRo88jAxR6IlVjSwt66lBicHCY3q
         NUcaiKocxEecmjsVyvG74sfhp5wDbk3QeL+jH/U/AKpn3fYvMY32Khjd8FT9NE2aDLZv
         lcOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719576096; x=1720180896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nlz+Gu51Kc+D7SoDZ5PKnSpVHKmOE/JB0x93VS7SH9E=;
        b=QCgiV2hjjYmK7AGY5cuqp43D2WNyF8N4yzfnAP6NXyYN7JRioOUHkyJPtShOepll7W
         b0PR8RcTdOS1VbvnKlskT193pw+2DA+6/AoHINh5emhSnlSgu2UTR6W15LSGCtgNYlrO
         B/cbF5RGxJOdP4a75m3YZZnljdmG6JtmGSffGM66y0EqkmlYlN0wHryUu+FNhnmnHMOP
         N2rJaQ7JJYobJwtOuXuenFPmjc89EjD4i9M5e3zTzQ3xfILH5ArKpLeOGeX0mC6cjdwD
         jn2LC+YydnRugl8zyHyxapY/E1ZtIMidKNTR2dfix/jyKTfEAggyvLUjxd9P02jm1pTu
         cE/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVXlh9MCC2VmAPGMPhNNtZ2U60oE/VkkUgT2LzkwklAXgBHbdj2odEJScnX6P9ROWBcmvjp2lrDiFVZGezbmeRT+tqe/DIHqVHRge5K
X-Gm-Message-State: AOJu0YxHMjEF57GhtwG7iQgNruxKNBFQmuqvtlmKxGtv4RKmGMXwJ6Sy
	PXu+hlwBpwWEnHNPCJcoHaoUnfrVwo2SD9rJPzch/OLA1po9AtzhJ2Deul231Q8=
X-Google-Smtp-Source: AGHT+IGnnpnq4/OM+D0bZdq7wWGW3f0id1NXDn5h8qDIyoueI0eYNYf+ncaN48k8u/4+DDzGPp7D9A==
X-Received: by 2002:a05:600c:1546:b0:422:fdb:efb3 with SMTP id 5b1f17b1804b1-4256d5016d4mr11992955e9.12.1719576096141;
        Fri, 28 Jun 2024 05:01:36 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:78b7:4c75:7e6e:807f])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3675a10307bsm2109771f8f.94.2024.06.28.05.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 05:01:35 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: soc-utils: allow sample rate up to 768kHz for the dummy dai
Date: Fri, 28 Jun 2024 14:01:29 +0200
Message-ID: <20240628120130.2015665-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

The dummy DAI should allow any (reasonable) rates possible.
Make the rate continuous for dummy and set range from 5512Hz to 768kHz

The change is mostly cosmetic as dummy is skipped when setting
the hwparams.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/soc-utils.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index 11ba89c6b83c..303823dc45d7 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -144,7 +144,6 @@ static const struct snd_soc_component_driver dummy_codec = {
 	.endianness		= 1,
 };
 
-#define STUB_RATES	SNDRV_PCM_RATE_8000_384000
 #define STUB_FORMATS	(SNDRV_PCM_FMTBIT_S8 | \
 			SNDRV_PCM_FMTBIT_U8 | \
 			SNDRV_PCM_FMTBIT_S16_LE | \
@@ -198,14 +197,18 @@ static struct snd_soc_dai_driver dummy_dai = {
 		.stream_name	= "Playback",
 		.channels_min	= 1,
 		.channels_max	= 384,
-		.rates		= STUB_RATES,
+		.rates		= SNDRV_PCM_RATE_CONTINUOUS,
+		.rate_min	= 5512,
+		.rate_max	= 768000,
 		.formats	= STUB_FORMATS,
 	},
 	.capture = {
 		.stream_name	= "Capture",
 		.channels_min	= 1,
 		.channels_max	= 384,
-		.rates = STUB_RATES,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
+		.rate_min	= 5512,
+		.rate_max	= 768000,
 		.formats = STUB_FORMATS,
 	 },
 	.ops = &dummy_dai_ops,
-- 
2.43.0


