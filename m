Return-Path: <linux-kernel+bounces-212872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CE8906769
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B17BBB295ED
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED9913E3F9;
	Thu, 13 Jun 2024 08:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZV4SBzjn"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E6113E03B;
	Thu, 13 Jun 2024 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718268426; cv=none; b=Qt+uhucukiFTj7l8RAkPWS+ooRYFNQb2LeAi5BiMz7K1vN9KYhQtu/vys9pfuGLSvXKp05OF64wx+A3BWb90vKFTXYG9hMWWcEE3hC3qQcoV/FRSmQyyeKoUndiIF7cjV+f4qsJE6ipy4IwdCNdWZo3PAWUPP645klO+2NddlBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718268426; c=relaxed/simple;
	bh=7cTfU0NzG4EQ73KLfyQ5mMxgJ/9Ax3Um1XAQjism0x0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W2epbFbzHghXCcqt23CoEWp2OWB/ngFjCh662hXf72rzbvJP/8Os5ajidRfPrbhdsGNM6aiBQbxRlVr0selyjU2LQYgGFc6GNYOIQUZY/ifNCL76BlNemiacz4pUNvBarJikwF09IP1UVLmmbEaYDFgWGGkzSzlfwdC3MDOIbII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZV4SBzjn; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6f253a06caso94566366b.1;
        Thu, 13 Jun 2024 01:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718268423; x=1718873223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CEwTUZlBDBOuLF/YpPCjybp6G8vWfidbX5dtN7b7RA=;
        b=ZV4SBzjnV9+AwGTakM2YDQ1Vvp9GbqH1JuPDLFEfYZg2eviAVP7YVaAUaYGW0ZRPCX
         WJFM1MCOZxZNVMGa0gkTlcn5hCzYUMqkFSn6/VfOc5lgSR8UnxePa6cibRy8RNkShu2T
         HptpuY8f+EGz4q5tVR///YWiACFaT7KtR9PjRqEyX3qORNTGCONXm7D+qEqOBwzlaAoL
         MjzhQy04NBBVklxJPtAxU0Ow7GSZCNJkT8jROyetAQgjoRGtWk/m8ciRmzbHjHSnp2AR
         vYTEkNmvzsYhkdL5rpsKRlMRlCL+gXZWYLVNoeeP3AR4WgC7G48KiocHLMxnB+Ac47kn
         6sQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718268423; x=1718873223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4CEwTUZlBDBOuLF/YpPCjybp6G8vWfidbX5dtN7b7RA=;
        b=GTlMKdP8oWqcZBzzEW0KonDzMkJoiTFeVE+mntad2qtZc3j6zeF/F5sFtKIMS8F3Zf
         ZkFlsX6Hy+EASren9xdBVhkqjlvTZnf+rzM879IJwgbLQEFbI0+YpRDmo3SZi2Ozh1So
         np4/onEKIW2QfMJoPnO5WyLRWv02sts4Nf4a/j5mKIXFHWWhoGzjZ+uU77i6e5tw8dkD
         FJui0LZC/6VUE8TbN7WelSHkucvl6m4gYuYaRSRihmFNz04FJAY731R5Xzf+pq3UTWFL
         NvsolZ1OioHdFSIVH74dhnyDHfzonKq2WOlLWcG2YsWLIcWCgvvsTr7RC1Oi5HCAyRpI
         w2Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUcJ0jddBWC7kgWV9aBuqm6wU3eRJoL4met+DOIj66mZ+5Qfot3pklEJrHnpcCT/SrMejdV0bHLJZezMMqeuRDaDl7UwYZCB+W3jJ3u
X-Gm-Message-State: AOJu0YwfD9SkRseHpjgZZjD5qwbeD6vo+wVVlOT87jUNOw5L6lzjShB1
	dbyBK08fo7YdD1O4bEymlKSnhsxNwaTgiiVsuFDeeVmetKwhgYcr
X-Google-Smtp-Source: AGHT+IHD68zIcX1XZw4+ce22ZWsZXStN7p7QMpvIuUboTuQbkKFMtrJiGWaZHH78gds6l45c3bAJkA==
X-Received: by 2002:a17:907:72cb:b0:a6f:5259:72e0 with SMTP id a640c23a62f3a-a6f525973camr208690766b.25.1718268423010;
        Thu, 13 Jun 2024 01:47:03 -0700 (PDT)
Received: from andrejs-nb.. (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56dd2daasm48364266b.97.2024.06.13.01.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 01:47:02 -0700 (PDT)
From: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: [PATCH v2 3/3] ASoC: nau8822: add MCLK support
Date: Thu, 13 Jun 2024 10:46:52 +0200
Message-Id: <20240613084652.13113-4-andrejs.cainikovs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613084652.13113-1-andrejs.cainikovs@gmail.com>
References: <20240613084652.13113-1-andrejs.cainikovs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

This change adds MCLK clock handling directly within driver.
When used in combination with simple-audio-card, and mclk-fs is set,
simple-audio-card will change MCLK frequency before configuring PLL.
In some cases, however, MCLK reference clock should be static (see [1]),
which means it needs to be moved away from simple-audio-card.

[1]: https://lore.kernel.org/all/ZfBdxrzX3EnPuGOn@ediswmail9.ad.cirrus.com/

Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
---
 sound/soc/codecs/nau8822.c | 48 ++++++++++++++++++++++++++++++++++----
 sound/soc/codecs/nau8822.h |  1 +
 2 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/nau8822.c b/sound/soc/codecs/nau8822.c
index 5f9f0953aa2f..e1cbaf8a944d 100644
--- a/sound/soc/codecs/nau8822.c
+++ b/sound/soc/codecs/nau8822.c
@@ -14,6 +14,7 @@
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
@@ -773,11 +774,26 @@ static int nau8822_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 {
 	struct snd_soc_component *component = dai->component;
 	struct nau8822 *nau8822 = snd_soc_component_get_drvdata(component);
+	unsigned long mclk_freq;
 
 	nau8822->div_id = clk_id;
 	nau8822->sysclk = freq;
+
+	if (nau8822->mclk) {
+		mclk_freq = clk_get_rate(nau8822->mclk);
+		if (mclk_freq != freq) {
+			int ret = nau8822_set_pll(dai, NAU8822_CLK_MCLK,
+				NAU8822_CLK_MCLK, mclk_freq, freq);
+			if (ret) {
+				dev_err(component->dev, "Failed to set PLL\n");
+				return ret;
+			}
+			nau8822->div_id = NAU8822_CLK_PLL;
+		}
+	}
+
 	dev_dbg(component->dev, "master sysclk %dHz, source %s\n", freq,
-		clk_id == NAU8822_CLK_PLL ? "PLL" : "MCLK");
+		nau8822->div_id == NAU8822_CLK_PLL ? "PLL" : "MCLK");
 
 	return 0;
 }
@@ -848,7 +864,7 @@ static int nau8822_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_component *component = dai->component;
 	struct nau8822 *nau8822 = snd_soc_component_get_drvdata(component);
-	int val_len = 0, val_rate = 0;
+	int div = 0, val_len = 0, val_rate = 0;
 	unsigned int ctrl_val, bclk_fs, bclk_div;
 
 	/* make BCLK and LRC divide configuration if the codec as master. */
@@ -915,8 +931,10 @@ static int nau8822_hw_params(struct snd_pcm_substream *substream,
 	/* If the master clock is from MCLK, provide the runtime FS for driver
 	 * to get the master clock prescaler configuration.
 	 */
-	if (nau8822->div_id == NAU8822_CLK_MCLK)
-		nau8822_config_clkdiv(dai, 0, params_rate(params));
+	if (nau8822->div_id != NAU8822_CLK_MCLK)
+		div = nau8822->pll.mclk_scaler;
+
+	nau8822_config_clkdiv(dai, div, params_rate(params));
 
 	return 0;
 }
@@ -940,17 +958,34 @@ static int nau8822_mute(struct snd_soc_dai *dai, int mute, int direction)
 static int nau8822_set_bias_level(struct snd_soc_component *component,
 				 enum snd_soc_bias_level level)
 {
+	struct nau8822 *nau8822 = snd_soc_component_get_drvdata(component);
+
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		break;
 
 	case SND_SOC_BIAS_PREPARE:
+		if (nau8822->mclk &&
+			snd_soc_component_get_bias_level(component) != SND_SOC_BIAS_ON) {
+			int ret = clk_prepare_enable(nau8822->mclk);
+
+			if (ret) {
+				dev_err(component->dev,
+					"Failed to enable MCLK: %d\n", ret);
+				return ret;
+			}
+		}
+
 		snd_soc_component_update_bits(component,
 			NAU8822_REG_POWER_MANAGEMENT_1,
 			NAU8822_REFIMP_MASK, NAU8822_REFIMP_80K);
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
+		if (nau8822->mclk &&
+			snd_soc_component_get_bias_level(component) != SND_SOC_BIAS_OFF)
+			clk_disable_unprepare(nau8822->mclk);
+
 		snd_soc_component_update_bits(component,
 			NAU8822_REG_POWER_MANAGEMENT_1,
 			NAU8822_IOBUF_EN | NAU8822_ABIAS_EN,
@@ -1127,6 +1162,11 @@ static int nau8822_i2c_probe(struct i2c_client *i2c)
 	}
 	i2c_set_clientdata(i2c, nau8822);
 
+	nau8822->mclk = devm_clk_get_optional(&i2c->dev, "mclk");
+	if (IS_ERR(nau8822->mclk))
+		return dev_err_probe(&i2c->dev, PTR_ERR(nau8822->mclk),
+			"Error getting mclk\n");
+
 	nau8822->regmap = devm_regmap_init_i2c(i2c, &nau8822_regmap_config);
 	if (IS_ERR(nau8822->regmap)) {
 		ret = PTR_ERR(nau8822->regmap);
diff --git a/sound/soc/codecs/nau8822.h b/sound/soc/codecs/nau8822.h
index 6ecd46e45923..13fe0a091e9e 100644
--- a/sound/soc/codecs/nau8822.h
+++ b/sound/soc/codecs/nau8822.h
@@ -215,6 +215,7 @@ struct nau8822_pll {
 struct nau8822 {
 	struct device *dev;
 	struct regmap *regmap;
+	struct clk *mclk;
 	struct nau8822_pll pll;
 	int sysclk;
 	int div_id;
-- 
2.34.1


