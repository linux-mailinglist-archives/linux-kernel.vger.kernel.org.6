Return-Path: <linux-kernel+bounces-404382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DFE9C4336
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9507B28BEF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833831A42C4;
	Mon, 11 Nov 2024 16:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liifgJYA"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377E61A256E;
	Mon, 11 Nov 2024 16:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731344167; cv=none; b=pRicxgl9+6qimrz59tV9R/V+/t6nf0ykS+uc337ioLUT+m9vt96L0WRzCSccC8s+nY8lEveS7uZfwDrYZoNMKKK4K+MDLBpOJZh7PsnFDru7A34IDOe3sd8iQ2n1GmyjIoSkTwKHrj/LLUrhAYt39IatGVhW/7EkhwH9g+GOGL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731344167; c=relaxed/simple;
	bh=GO5aSQ4UwyOlMXLzUsIbxvE6Gor/9I12CLAiYV7yBd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+p4CHDByevTz6nSlOQZHNhRX6Go0KyuExgsJCwP5R5w/sjvFv/+gZq/+3VTW2MOgv6D4aqr8mvBMccW6Acj2qpn9oGu+jrz/JFH3rcrEOCdNq0Aikp5DwX2Ry0K1CyhKKgarr2VozDHdHMjxhsqB5uNxkb9xSykKxaw/bRpL6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=liifgJYA; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539e8607c2aso5299278e87.3;
        Mon, 11 Nov 2024 08:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731344164; x=1731948964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+Q3XwignOREPSIds84RjtpG+Fky7bPoezx4NsmrbSc=;
        b=liifgJYA1OyDhF4ajQouoIcJNYqf7tZsF39fcf1RUAUGzerFTcvESmvlD26Q0I5KTN
         1PWiLGq6NwvfSYYDmvOgLnOYXlMAUM8HvcG//z0bW6yAikLuaVkWAxJio4Y+qi9LDdhN
         AXDjWlOTxQpKfLeMO1iNJEGLG/6JgP0QtVDbchbDJP6YXL4HmZt/zho2qA8bYWkIfnAa
         ISH/6MOItiX5IQvRigWY0HOeTBJTNYRcYXUdZnIhJ1mZS+4MdVhNj1xdpyQOt9Yv5ezP
         uK0AR104lbXLeb0Dd93npv14fq8RyjRbA94idbW3mVn6CaqabJ45u5kml/nRtD9Ng9WV
         aOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731344164; x=1731948964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+Q3XwignOREPSIds84RjtpG+Fky7bPoezx4NsmrbSc=;
        b=wBe+rxLkjc6ki3JcV3HSp/Riqik008PppKcXevu6CwjNHc07j2uI9ku9xlpKAqdf22
         0AReflAAnVDfcx30ItsE3tOEC/Z9C9mt656tA3uiEeoEIp346Ct29oLpwLnMX7aRRW22
         8MtHcVmTW6WuyjYjypv/LaqAxzt7CaaXasDlOo2L/a9Nhb3jsKnPRONVrJLT1UutYaHF
         wXsfS/+tz3LzRauO6vxvWr6eavQ50yu91qUf60DjPssMQzA6ovQHg+aHFpou0tqZl82P
         WKgjYLvfssbxjukDtoWAJBbvEe+d6eDIQGsDC9qQZEsVHhvJLhpsuPf78bfrOZQXhSP2
         2jqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzcGpcHovUNFRYMh+hFrJONps5/xsR22sxJFaUM43JTmqfMXXgjAacnR4r2/lwbAQjY3BVC6bIU8rDn8tObc1M@vger.kernel.org, AJvYcCWzN94DFMvinf5Bn6rtgE7t/3uj2puY251r6KDV6fSiuhpAK46ux8Ez/TLAilCH1A8MEptftSIsbRHWjzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjsXyuUxYwRS6ds/6mJbvbyujPP0lTeVuy4ImUzhuwEc/xe9+S
	xnjPCVZxp481kAEyppQWIydGIUIJ/1Enk7UgMLR00gojVNCpK16WlnT/MUUr
X-Google-Smtp-Source: AGHT+IGTVIBZ001X2A47u65/h7kXIx7wTYYbJhZz0Pv22iqQ4Lq7f4suNjhPPU3TWq1X0o6RVDNa6A==
X-Received: by 2002:a05:6512:158e:b0:53b:1fea:ba96 with SMTP id 2adb3069b0e04-53d862eb0fdmr6231906e87.50.1731344163728;
        Mon, 11 Nov 2024 08:56:03 -0800 (PST)
Received: from localhost.localdomain (c90-142-33-119.bredband.tele2.se. [90.142.33.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826a7387sm1624737e87.140.2024.11.11.08.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 08:56:03 -0800 (PST)
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
Subject: [PATCH 1/3] ASoC: sun4i-spdif: Add clock multiplier settings
Date: Mon, 11 Nov 2024 17:55:29 +0100
Message-ID: <20241111165600.57219-2-codekipper@gmail.com>
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

From: George Lander <lander@jagmn.com>

There have been intermittent issues with the SPDIF output on H3
and H2+ devices which has been fixed by setting the s_clk to 4
times the audio pll.
Add a quirk for the clock multiplier as not every supported SoC
requires it. Without the multiplier, the audio at normal sampling
rates was distorted and did not play at higher sampling rates.

Fixes: 1bd92af877ab ("ASoC: sun4i-spdif: Add support for the H3 SoC")
Signed-off-by: George Lander <lander@jagmn.com>
Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-spdif.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index 0aa4164232464..7cf623cbe9ed4 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -176,6 +176,7 @@ struct sun4i_spdif_quirks {
 	unsigned int reg_dac_txdata;
 	bool has_reset;
 	unsigned int val_fctl_ftx;
+	unsigned int mclk_multiplier;
 };
 
 struct sun4i_spdif_dev {
@@ -313,6 +314,7 @@ static int sun4i_spdif_hw_params(struct snd_pcm_substream *substream,
 	default:
 		return -EINVAL;
 	}
+	mclk *= host->quirks->mclk_multiplier;
 
 	ret = clk_set_rate(host->spdif_clk, mclk);
 	if (ret < 0) {
@@ -347,6 +349,7 @@ static int sun4i_spdif_hw_params(struct snd_pcm_substream *substream,
 	default:
 		return -EINVAL;
 	}
+	mclk_div *= host->quirks->mclk_multiplier;
 
 	reg_val = 0;
 	reg_val |= SUN4I_SPDIF_TXCFG_ASS;
@@ -540,24 +543,28 @@ static struct snd_soc_dai_driver sun4i_spdif_dai = {
 static const struct sun4i_spdif_quirks sun4i_a10_spdif_quirks = {
 	.reg_dac_txdata	= SUN4I_SPDIF_TXFIFO,
 	.val_fctl_ftx   = SUN4I_SPDIF_FCTL_FTX,
+	.mclk_multiplier = 1,
 };
 
 static const struct sun4i_spdif_quirks sun6i_a31_spdif_quirks = {
 	.reg_dac_txdata	= SUN4I_SPDIF_TXFIFO,
 	.val_fctl_ftx   = SUN4I_SPDIF_FCTL_FTX,
 	.has_reset	= true,
+	.mclk_multiplier = 1,
 };
 
 static const struct sun4i_spdif_quirks sun8i_h3_spdif_quirks = {
 	.reg_dac_txdata	= SUN8I_SPDIF_TXFIFO,
 	.val_fctl_ftx   = SUN4I_SPDIF_FCTL_FTX,
 	.has_reset	= true,
+	.mclk_multiplier = 4,
 };
 
 static const struct sun4i_spdif_quirks sun50i_h6_spdif_quirks = {
 	.reg_dac_txdata = SUN8I_SPDIF_TXFIFO,
 	.val_fctl_ftx   = SUN50I_H6_SPDIF_FCTL_FTX,
 	.has_reset      = true,
+	.mclk_multiplier = 1,
 };
 
 static const struct of_device_id sun4i_spdif_of_match[] = {
-- 
2.47.0


