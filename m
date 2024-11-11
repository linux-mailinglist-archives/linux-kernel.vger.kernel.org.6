Return-Path: <linux-kernel+bounces-404384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAD49C430E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84EA21F21082
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755A51A256E;
	Mon, 11 Nov 2024 16:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJYqlWzk"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D6A1A42A5;
	Mon, 11 Nov 2024 16:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731344170; cv=none; b=bEod3NLPypVhEC7gEDtYDVb7RSBHlSYlHkDIgDgP97/K93ecdpnbHbrmt9WOPedbIcxKgB7sU361XFCz0VpZtBRkpEvnsw5VIl2iNsGb1KyquYqDLexIknMVfrwFQN+X/V6brTZrXj2C1haX1bFFBEox44FFSwoGMQJN7odj4mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731344170; c=relaxed/simple;
	bh=3kLzdXkGZ0goZ7AL14qJZ24tx/PDfvKjSoul4AfIyWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIJ8jH14WlNYFA2265EO6TNIoKuy3RrZuI2phH+26n3zvPFwvY8VSfwJDyIHsrHP0X3H8LuWbVA7z0YsrbUdtTc8EhWNIoVZDtFRVg6VJsNFifDcGb673eSVbn7iEjehnIu9y0b/dNC97wYt/7wUd4tWvuinOBcrXUQQnub64KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJYqlWzk; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53a007743e7so5628800e87.1;
        Mon, 11 Nov 2024 08:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731344166; x=1731948966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGIyKdlKD2rjdr8nGTfStLxE86UsO3KrqZkzx50EpGg=;
        b=MJYqlWzk9CAAaGcNfTsVszqe6mFrTBTez7AXzIvjA0KiJ2VV1jskLmYzlWrfAW+wMK
         e1zIIvuRmsdLAwAKRPubgzrAv5aL5nmFWFIQU7tS/G1y9pzsyihYVgE62xG01/uQQw5u
         CxzRRGq8JWdC9e1K2yUsWfU7M/x/79O8+SNn72u1c8rkXqPQx8gqUqmV1xYsFTAbOiQh
         qe3DmIZTxS3RDd2OeEoIJaawos7CeYCB2K/X1NAhEoFV9sRx8kl/QVynaisxngS0JcQ8
         z2j3NJzkiYh4QDhVnckqs2hAWc9w4/LBh0R4wzXGj0BON5inU5Sqy9zLIBfy+Q14alV+
         FpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731344166; x=1731948966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGIyKdlKD2rjdr8nGTfStLxE86UsO3KrqZkzx50EpGg=;
        b=wAhitgozH/kYKChRNdctQ2vpEfXyoxr5pDgzNJV7Q+Ddgc0LpsTM0/Aynr7HocmUj+
         knFjlUAgb/UfuVSP1u8Xj8cCnde49AdVQ6rJR9SudUXIGNDwbrLUH2Pk0lpjMFR/P3PL
         Yk++5kFjlNpo+4/5/B5DakIJ+8eOyIjodduLBIzeE+5HtUTRaeJOytfOIULe/Io9sISm
         iRvFbFNJ9X3z4yFV4l0BVIC4yzRkZo/wc81GP49wb+kYpYIyXQGORHbJIIzrcuUZ5FTG
         EJa8NTJCC5Md0looW6dUKZadvCAjwkQud8MzaVf1joug1iOOlLWN0V+XMFaJM+x10n68
         PF8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV53OOtGT8HGE7hfNvRIRrkhwZ12wiBM4ovmK919AbkPaIuL/kUaU8IOTgoXA9iccJtDtuxejegaKuzbOk=@vger.kernel.org, AJvYcCVNa7JTLd1lEgswuVj9TWaMWxtR1YPaEq0OqKlS3BssLeW0wAM7XsZasrTKKC5p+57QY6TOmRH2QYOtmS+2HW20@vger.kernel.org
X-Gm-Message-State: AOJu0YwELH72N3hAT+O3NHVbc7fKhvmqL49hn+JNSg+ntQQWk/7Y6HTA
	CGKLHLcmuB6GQbklh8BPNQTddsgdSUbdBNAN3NomBBc11uTeHglenJB9927J
X-Google-Smtp-Source: AGHT+IFnmYnGoXcuYt3AhU6Y+aYhmeuhcBjoUc/SyewEzKh1ml1lrjiD9FwIjoozeWWRRSk/eMeAlQ==
X-Received: by 2002:a05:6512:6d1:b0:539:e873:6d7 with SMTP id 2adb3069b0e04-53d86228c57mr5864656e87.1.1731344166311;
        Mon, 11 Nov 2024 08:56:06 -0800 (PST)
Received: from localhost.localdomain (c90-142-33-119.bredband.tele2.se. [90.142.33.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826a7387sm1624737e87.140.2024.11.11.08.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 08:56:05 -0800 (PST)
From: codekipper@gmail.com
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@vger.kernel.org,
	linux-sunxi@googlegroups.com,
	linux-sunxi@lists.linux.dev,
	linux-sound@vger.kernel.org,
	lander@jagmn.com
Cc: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	andre.przywara@arm.com,
	wens@csie.org,
	u.kleine-koenig@baylibre.com,
	Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH 3/3] ASoC: sun4i-spdif: Add working 24bit audio support
Date: Mon, 11 Nov 2024 17:55:31 +0100
Message-ID: <20241111165600.57219-4-codekipper@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241111165600.57219-1-codekipper@gmail.com>
References: <20241111165600.57219-1-codekipper@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marcus Cooper <codekipper@gmail.com>

24 bit audio file can be detected by the alsa driver as S32_LE.
Add this format to what is supported and change the DMA address
width.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-spdif.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index 5a9407aaa1a19..41caf1795d09b 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -287,14 +287,17 @@ static int sun4i_spdif_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
+	host->dma_params_tx.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
 		fmt |= SUN4I_SPDIF_TXCFG_FMT16BIT;
+		host->dma_params_tx.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 		break;
 	case SNDRV_PCM_FORMAT_S20_3LE:
 		fmt |= SUN4I_SPDIF_TXCFG_FMT20BIT;
 		break;
 	case SNDRV_PCM_FORMAT_S24_LE:
+	case SNDRV_PCM_FORMAT_S32_LE:
 		fmt |= SUN4I_SPDIF_TXCFG_FMT24BIT;
 		break;
 	default:
@@ -526,9 +529,10 @@ static const struct regmap_config sun4i_spdif_regmap_config = {
 
 #define SUN4I_RATES	SNDRV_PCM_RATE_8000_192000
 
-#define SUN4I_FORMATS	(SNDRV_PCM_FORMAT_S16_LE | \
-				SNDRV_PCM_FORMAT_S20_3LE | \
-				SNDRV_PCM_FORMAT_S24_LE)
+#define SUN4I_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
+				SNDRV_PCM_FMTBIT_S20_3LE | \
+				SNDRV_PCM_FMTBIT_S24_LE | \
+				SNDRV_PCM_FMTBIT_S32_LE)
 
 static struct snd_soc_dai_driver sun4i_spdif_dai = {
 	.playback = {
-- 
2.47.0


