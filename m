Return-Path: <linux-kernel+bounces-183828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D46768C9EAA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 16:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8FCCB22123
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 14:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CC413440F;
	Mon, 20 May 2024 14:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ysaVtROb"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358B85337F
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 14:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716214813; cv=none; b=h4yf+HcBhu3/jO3xPv+3MMoFZXLKLb5ZGEOYopq7HvS/ZhmS6dTLjr5DGnk6K5z93eaVJ910KZYidbhg9ES8uzym7GwdNVuf6wwxBjLGfoA0/VmVi5zaNBd7RwVHuJd+8mAImwEphd0ok34K5Rw5igBlqDBaanEFdSJF/4FDOYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716214813; c=relaxed/simple;
	bh=BQrXQQTyaxGZ3PSkUrwn5zNtXxGEe2/vXi521zgodPM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nh+SFoBfYDfvfwuRQWVevSvVe6shsZ72GK1CiAlfewI1fMT/ZKseqZArd07LqEwtYn1DFKiA9wIGX9JFj+zfOMT9x2FQ2uBoE+U0yx8Swl06qg1dUpOGJkh2UIvvA2154lArb0IStx9SLd8tbBYE/a7zejODSVHEPXNlpTIFClY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ysaVtROb; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-420180b58c5so18910555e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 07:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716214809; x=1716819609; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zCmZJRRayag6o4GxgnAbuVjFLecTARmQ0KdgUsO8Ydw=;
        b=ysaVtRObLkReZi/jRNLOMCLEktOzN9Vwp9j4HLprxCcpQmTm/UL5aGTTQN2/wtCIGB
         cLKyyWDv15DdiS/4L8dxy7d15MdxudLPEPAdzuxSXfYcCMfb3GKj3YxzLhpskzG/8cXo
         sXdCb39E3UQgAj+PTNovUyv3g5O11nGqLqsNyZLF6MhIt2QjBzMS2m8oyrb30OB2GFWV
         RdwAqIUF43uzVX8cIsolfSCEVGsBRFZZys2BBZITxSDYqrmEqplWxCF3iyk+LtLDlSys
         /CaGPRSK7xmafEi5lLoy8uxSdeVzpYcB3io+/8ZeVt6mD6rVf+WoR3kfTI/vT93pRjsz
         5jXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716214809; x=1716819609;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zCmZJRRayag6o4GxgnAbuVjFLecTARmQ0KdgUsO8Ydw=;
        b=o5KFista7srnFD3fZGC+ZHi/Oe4C1U8d0f1RHbEzkyGnH5pgsLetYEiKb8NdGNi3/3
         iCAiys8HdZPk1hDVR1V+o7MoVlbj52nP5cjN27RCtGGrIW4e8ZJpHRTJQASUOo5z2x4e
         UXxe7bpUskjT1o7MaGpmx7USf6Aas/srz+C26aNldsEeTRXSvj0X2t/q8qaFZ+W9vDAD
         0Itf8+v0eYR7fckFC6G1eagxQYjBX5ffljF2av56bchtr7nMk1zI8lW5s6ki7vxgs2Vu
         qQQrCp+P01RCF++KS9bVtppHX1tTfGNrCs6Qr3XWIfvaEC8NFOuI55tN2Aks1Iub4kml
         adQA==
X-Forwarded-Encrypted: i=1; AJvYcCU+qe8uvWdI6dCeMIP0MWdEQcv1rJZKJrT9UMeEjsLIun2KKcBdIIsJQT4GMuoUNo4DD6cG/JIkaRTsl8paax46vUgDpB6Qb3HAXgfs
X-Gm-Message-State: AOJu0YyRDb3U/ezMfBw2bEil+zkXkD6a14+J4MQ5axWWfcJ//UcEPanl
	MReaZitIt/iw0QhW84RoY0oPCvIVw6GpPa49NoLfhVs09YZSR52RWUtKPxwPdcM=
X-Google-Smtp-Source: AGHT+IHGA1qZi8BCksF79z/Rm+AMK4VQrjozLRrZ73UZBqcf5Z4LbCoplPZXhDUNk+WzYge2lwZU4A==
X-Received: by 2002:a05:600c:3582:b0:41b:143b:5c2d with SMTP id 5b1f17b1804b1-41feac55195mr226931615e9.28.1716214809472;
        Mon, 20 May 2024 07:20:09 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee962esm421612625e9.31.2024.05.20.07.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 07:20:08 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 20 May 2024 16:19:56 +0200
Subject: [PATCH v4 1/4] ASoC: Constify channel mapping array arguments in
 set_channel_map()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240520-asoc-x1e80100-4-channel-mapping-v4-1-f657159b4aad@linaro.org>
References: <20240520-asoc-x1e80100-4-channel-mapping-v4-0-f657159b4aad@linaro.org>
In-Reply-To: <20240520-asoc-x1e80100-4-channel-mapping-v4-0-f657159b4aad@linaro.org>
To: James Schulman <james.schulman@cirrus.com>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10100;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=BQrXQQTyaxGZ3PSkUrwn5zNtXxGEe2/vXi521zgodPM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmS1wS3bHQiGQB0LU8H76joCn0St7UMGjM6zTjc
 0f7nQet2lSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZktcEgAKCRDBN2bmhouD
 1xkyD/wP6Dh59WJdt2bKucHbUMasaDij2viWAX1HjjXES524H9QrpyS/533Q3QQUH6XogNvg805
 PdNWfEVKMW03V+/P4/VFgIJS2bVt/5H+YCN0RPenzQFjg4sJdLvrYxaR50UEdjkovLOk/zZAoOX
 s45IgMjt4PyBZvy1lvxG60+WNt/b1ys0inEV7BT+6lE1gl7OMK0x+ffJflOKQRjf1AKtoyEc0sE
 K6LTIVusTEfmXe14LS0AIG6sdpFX8zLQflpEFWH1dUZlKX14cY+44XPWrhkjygq3RfdR9Qrl2Ul
 JLygF23AoyuYYLRGgfzb5WlLbF1toki9aOS4cFX5gwi16ZRHig101rmigIVG9Cc+Tr00kXEhKaD
 I8z8lOcPDsXJ+L8df7NHq94emZfzjtQiUZp95qv8vdMA7eAc0IpJlRp3H7rkLOYQidsMGabP6al
 m/jM9YuGZADshCfjkkK6QPbQXd5RyYGKMmnn68HUzp3mNcqQTytBW5/hYRH7FsQ6OsszKZPKHkn
 p8WzLViFKkg/HvvErFz8Yj2qUG8biVwdrYE9TKYQ2YA2oYKxHYPc4zf2rdHcVM+5g79+rNPeKQg
 k7HKkHajRfF/VyAAHU5fqv78Jrlicy+WZGrhvbGzb4q6nIAzu3wlnMZOfOK1G8OQFX8MYHMEwRh
 SauJhdb0mR2gGJQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

There is no need for implementations of DAI set_channel_map() to modify
contents of passed arrays with actual channel mapping.  Additionally,
the caller keeps full ownership of the array.

Constify these pointer arguments so the code will be safer and easier to
read (documenting the caller's ownership).

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changes in v2/v3/v4:
1. None
---
 include/sound/cs35l41.h                 |  4 ++--
 include/sound/soc-dai.h                 |  8 ++++----
 sound/soc/codecs/adau7118.c             |  6 ++++--
 sound/soc/codecs/cs35l41-lib.c          |  4 ++--
 sound/soc/codecs/cs35l41.c              |  3 ++-
 sound/soc/codecs/max98504.c             |  6 ++++--
 sound/soc/codecs/wcd9335.c              |  6 ++++--
 sound/soc/codecs/wcd934x.c              |  6 ++++--
 sound/soc/qcom/qdsp6/q6afe-dai.c        | 16 ++++++++++------
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c |  6 ++++--
 sound/soc/soc-dai.c                     |  4 ++--
 11 files changed, 42 insertions(+), 27 deletions(-)

diff --git a/include/sound/cs35l41.h b/include/sound/cs35l41.h
index bb70782d15d0..43c6a9ef8d9f 100644
--- a/include/sound/cs35l41.h
+++ b/include/sound/cs35l41.h
@@ -896,8 +896,8 @@ int cs35l41_test_key_lock(struct device *dev, struct regmap *regmap);
 int cs35l41_otp_unpack(struct device *dev, struct regmap *regmap);
 int cs35l41_register_errata_patch(struct device *dev, struct regmap *reg, unsigned int reg_revid);
 int cs35l41_set_channels(struct device *dev, struct regmap *reg,
-			 unsigned int tx_num, unsigned int *tx_slot,
-			 unsigned int rx_num, unsigned int *rx_slot);
+			 unsigned int tx_num, const unsigned int *tx_slot,
+			 unsigned int rx_num, const unsigned int *rx_slot);
 int cs35l41_gpio_config(struct regmap *regmap, struct cs35l41_hw_cfg *hw_cfg);
 void cs35l41_configure_cs_dsp(struct device *dev, struct regmap *reg, struct cs_dsp *dsp);
 int cs35l41_set_cspl_mbox_cmd(struct device *dev, struct regmap *regmap,
diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index adcd8719d343..15ef268c9845 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -188,8 +188,8 @@ int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
 	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width);
 
 int snd_soc_dai_set_channel_map(struct snd_soc_dai *dai,
-	unsigned int tx_num, unsigned int *tx_slot,
-	unsigned int rx_num, unsigned int *rx_slot);
+	unsigned int tx_num, const unsigned int *tx_slot,
+	unsigned int rx_num, const unsigned int *rx_slot);
 
 int snd_soc_dai_set_tristate(struct snd_soc_dai *dai, int tristate);
 
@@ -305,8 +305,8 @@ struct snd_soc_dai_ops {
 		unsigned int tx_mask, unsigned int rx_mask,
 		int slots, int slot_width);
 	int (*set_channel_map)(struct snd_soc_dai *dai,
-		unsigned int tx_num, unsigned int *tx_slot,
-		unsigned int rx_num, unsigned int *rx_slot);
+		unsigned int tx_num, const unsigned int *tx_slot,
+		unsigned int rx_num, const unsigned int *rx_slot);
 	int (*get_channel_map)(struct snd_soc_dai *dai,
 			unsigned int *tx_num, unsigned int *tx_slot,
 			unsigned int *rx_num, unsigned int *rx_slot);
diff --git a/sound/soc/codecs/adau7118.c b/sound/soc/codecs/adau7118.c
index a663d37e5776..abc4764697a5 100644
--- a/sound/soc/codecs/adau7118.c
+++ b/sound/soc/codecs/adau7118.c
@@ -121,8 +121,10 @@ static const struct snd_soc_dapm_widget adau7118_widgets[] = {
 };
 
 static int adau7118_set_channel_map(struct snd_soc_dai *dai,
-				    unsigned int tx_num, unsigned int *tx_slot,
-				    unsigned int rx_num, unsigned int *rx_slot)
+				    unsigned int tx_num,
+				    const unsigned int *tx_slot,
+				    unsigned int rx_num,
+				    const unsigned int *rx_slot)
 {
 	struct adau7118_data *st =
 		snd_soc_component_get_drvdata(dai->component);
diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index e9993a39f7d0..1702f26049d3 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -936,8 +936,8 @@ int cs35l41_register_errata_patch(struct device *dev, struct regmap *reg, unsign
 EXPORT_SYMBOL_GPL(cs35l41_register_errata_patch);
 
 int cs35l41_set_channels(struct device *dev, struct regmap *reg,
-			 unsigned int tx_num, unsigned int *tx_slot,
-			 unsigned int rx_num, unsigned int *rx_slot)
+			 unsigned int tx_num, const unsigned int *tx_slot,
+			 unsigned int rx_num, const unsigned int *rx_slot)
 {
 	unsigned int val, mask;
 	int i;
diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index cb25c33cc9b9..1688c2c688f0 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -673,7 +673,8 @@ static const struct snd_soc_dapm_route cs35l41_audio_map[] = {
 };
 
 static int cs35l41_set_channel_map(struct snd_soc_dai *dai, unsigned int tx_n,
-				   unsigned int *tx_slot, unsigned int rx_n, unsigned int *rx_slot)
+				   const unsigned int *tx_slot,
+				   unsigned int rx_n, const unsigned int *rx_slot)
 {
 	struct cs35l41_private *cs35l41 = snd_soc_component_get_drvdata(dai->component);
 
diff --git a/sound/soc/codecs/max98504.c b/sound/soc/codecs/max98504.c
index 93412b966b33..6b6a7ece4cec 100644
--- a/sound/soc/codecs/max98504.c
+++ b/sound/soc/codecs/max98504.c
@@ -220,8 +220,10 @@ static int max98504_set_tdm_slot(struct snd_soc_dai *dai,
 	return 0;
 }
 static int max98504_set_channel_map(struct snd_soc_dai *dai,
-		unsigned int tx_num, unsigned int *tx_slot,
-		unsigned int rx_num, unsigned int *rx_slot)
+				    unsigned int tx_num,
+				    const unsigned int *tx_slot,
+				    unsigned int rx_num,
+				    const unsigned int *rx_slot)
 {
 	struct max98504_priv *max98504 = snd_soc_dai_get_drvdata(dai);
 	struct regmap *map = max98504->regmap;
diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index deb15b95992d..42a99978fe5a 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -1983,8 +1983,10 @@ static int wcd9335_trigger(struct snd_pcm_substream *substream, int cmd,
 }
 
 static int wcd9335_set_channel_map(struct snd_soc_dai *dai,
-				   unsigned int tx_num, unsigned int *tx_slot,
-				   unsigned int rx_num, unsigned int *rx_slot)
+				   unsigned int tx_num,
+				   const unsigned int *tx_slot,
+				   unsigned int rx_num,
+				   const unsigned int *rx_slot)
 {
 	struct wcd9335_codec *wcd;
 	int i;
diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index de870c7819ca..fcad2c9fba55 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -1923,8 +1923,10 @@ static int wcd934x_trigger(struct snd_pcm_substream *substream, int cmd,
 }
 
 static int wcd934x_set_channel_map(struct snd_soc_dai *dai,
-				   unsigned int tx_num, unsigned int *tx_slot,
-				   unsigned int rx_num, unsigned int *rx_slot)
+				   unsigned int tx_num,
+				   const unsigned int *tx_slot,
+				   unsigned int rx_num,
+				   const unsigned int *rx_slot)
 {
 	struct wcd934x_codec *wcd;
 	int i;
diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index a9c4f896a7df..7d9628cda875 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -172,8 +172,8 @@ static int q6tdm_set_tdm_slot(struct snd_soc_dai *dai,
 }
 
 static int q6tdm_set_channel_map(struct snd_soc_dai *dai,
-				unsigned int tx_num, unsigned int *tx_slot,
-				unsigned int rx_num, unsigned int *rx_slot)
+				unsigned int tx_num, const unsigned int *tx_slot,
+				unsigned int rx_num, const unsigned int *rx_slot)
 {
 
 	struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
@@ -250,8 +250,10 @@ static int q6tdm_hw_params(struct snd_pcm_substream *substream,
 }
 
 static int q6dma_set_channel_map(struct snd_soc_dai *dai,
-				 unsigned int tx_num, unsigned int *tx_ch_mask,
-				 unsigned int rx_num, unsigned int *rx_ch_mask)
+				 unsigned int tx_num,
+				 const unsigned int *tx_ch_mask,
+				 unsigned int rx_num,
+				 const unsigned int *rx_ch_mask)
 {
 
 	struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
@@ -407,8 +409,10 @@ static int q6afe_dai_prepare(struct snd_pcm_substream *substream,
 }
 
 static int q6slim_set_channel_map(struct snd_soc_dai *dai,
-				unsigned int tx_num, unsigned int *tx_slot,
-				unsigned int rx_num, unsigned int *rx_slot)
+				  unsigned int tx_num,
+				  const unsigned int *tx_slot,
+				  unsigned int rx_num,
+				  const unsigned int *rx_slot)
 {
 	struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
 	struct q6afe_port_config *pcfg = &dai_data->port_config[dai->id];
diff --git a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
index 68a38f63a2db..6bfbb52345e1 100644
--- a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
+++ b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
@@ -25,8 +25,10 @@ struct q6apm_lpass_dai_data {
 };
 
 static int q6dma_set_channel_map(struct snd_soc_dai *dai,
-				 unsigned int tx_num, unsigned int *tx_ch_mask,
-				 unsigned int rx_num, unsigned int *rx_ch_mask)
+				 unsigned int tx_num,
+				 const unsigned int *tx_ch_mask,
+				 unsigned int rx_num,
+				 const unsigned int *rx_ch_mask)
 {
 
 	struct q6apm_lpass_dai_data *dai_data = dev_get_drvdata(dai->dev);
diff --git a/sound/soc/soc-dai.c b/sound/soc/soc-dai.c
index fefe394dce72..03afd5efb24c 100644
--- a/sound/soc/soc-dai.c
+++ b/sound/soc/soc-dai.c
@@ -304,8 +304,8 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_tdm_slot);
  * configure the relationship between channel number and TDM slot number.
  */
 int snd_soc_dai_set_channel_map(struct snd_soc_dai *dai,
-				unsigned int tx_num, unsigned int *tx_slot,
-				unsigned int rx_num, unsigned int *rx_slot)
+				unsigned int tx_num, const unsigned int *tx_slot,
+				unsigned int rx_num, const unsigned int *rx_slot)
 {
 	int ret = -ENOTSUPP;
 

-- 
2.43.0


