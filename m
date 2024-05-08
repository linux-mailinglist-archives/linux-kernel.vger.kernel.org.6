Return-Path: <linux-kernel+bounces-172896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A1C8BF845
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72C8C1F24C2B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 08:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA1845957;
	Wed,  8 May 2024 08:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GUifNWdA"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AD72747B
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715156203; cv=none; b=PQlUudublOuDY/nQoF7bHAWUM4NKwNxkN6h9XFVfS8/6DIbzHVJWFhn5IA/lanidP0iwt1NB6k7g7YQ0r8UnaWEfP6H06BPRufCPgXAHyqOMGXKq98tgo81kpDj1UsqSBuIqGwRw3AMlIcf+zCEauhLQ5Zm7QwBboGolVLQi9H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715156203; c=relaxed/simple;
	bh=HZ5c05lASDGke6zV6oGSp7GtVTkm9nQ4CbvayqlVq5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EVVgHlIT6CshnGKgjqZfGw5Nyo8MpWx2AHSSJ2DSU57k24gzNZffG1r/8PP36X1w9VUYqTza3SgzxYPBixWV3rW7sFH4pQ/tnZ8UzhhjFkHNiTFfJ05ARLdPUDZ/eUS8Zvte2HOw2aOS7XQoMQ78ATHSMu8yxOUz/PowmeWs16U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GUifNWdA; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59a17fcc6bso940681066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 01:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715156200; x=1715761000; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0LwDR/uj963neDfuvigHcDzvEI8lpRkCIvqpr3ctsbs=;
        b=GUifNWdATX03PF165ZYiIzkjoM1j/STDJCAvjtcbOb1aYj+W/MYaMpWYNjGkw0X967
         IZxuNWYttHzxMvAhQpSF+9NJxMpPTnU3Q+rxhAxMWuLYECkQ03zNOrt8A0I+Cwl2xwp7
         bxovSdb99bGfRP0LimaeJPmN1+K5jfwUye30K7f9UW0xQdKMDSM6zmPzgTm8XR+g4TY7
         EWC+BbquakvsFiDLhNnLNMrslwV3ADtVRjFoynSvU9Bq4uCXK2ztfRoY0g/jOiV0L9WG
         Ju8lOdBbNLm/41NcQtMGmnb3jHZhFYdTRfItXof8TlGBCCoJgfMf/CDmLN7IFLj7dJQP
         P4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715156200; x=1715761000;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0LwDR/uj963neDfuvigHcDzvEI8lpRkCIvqpr3ctsbs=;
        b=F4mlXuIItmkvcTqgsLUKc8bcocc78dk+CeTpqMilke3sJHOAEK40d9h1PU564KpdIq
         64TM+MGc/XOfJJdztoRuwAES83IiBFMqb2zPUSc5EFm+fXdj3kD38AhpJvxb0bxgmf9w
         i1g23FYUhrUwp8rWQXtCKELVpKzzJD9u4THKvT5T/rdg5DXCjj12OM6v/hLP3Z8deU3g
         4hTyRdPDYUG4vgaoxtMToSxZ60ZVEfsC6Ounsov8f3+ztE85s2ov8ofp144PUORUeN80
         Y3eU9Pd7qo2spFKUuvI5kYLhPDzgxGkjiMSaQAkA+QxyE9dyS9nH2cSJQI78cU/lTYND
         G16A==
X-Forwarded-Encrypted: i=1; AJvYcCXGrhH91SDMDcboO/mUTuPZwau2wYvSE3Z/jkDLwePmFuVHUL0qhW4m4gQoua12MMQK0WuQrCzd9U5vZYGfKW1Ykwj4R6Ehv4jYzFgF
X-Gm-Message-State: AOJu0Yy2SlmmBoN4oYVNLdMoDusEFbrxyHLBFiAS9H1KJBT6kjJ3CAC8
	0DX6PHEoPOMcpt6Yf8MJXl25swWb2hHgp3Kp54K+6FZMXPUXWJLkaHj82Hj8N6o=
X-Google-Smtp-Source: AGHT+IFObuqnHNAZx3tIfH6k17QV8p4TQzZlUFXl/C0j8YnL6NYLHT142nQn12hW7zd9PdMUhzCNRg==
X-Received: by 2002:a17:906:16d8:b0:a59:a0c1:2624 with SMTP id a640c23a62f3a-a59fb968db2mr107669366b.39.1715156199807;
        Wed, 08 May 2024 01:16:39 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id va28-20020a17090711dc00b00a59b87dd0d7sm4564734ejb.147.2024.05.08.01.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 01:16:39 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 08 May 2024 10:16:27 +0200
Subject: [PATCH v2 1/4] ASoC: Constify channel mapping array arguments in
 set_channel_map()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240508-asoc-x1e80100-4-channel-mapping-v2-1-ccef9a66a572@linaro.org>
References: <20240508-asoc-x1e80100-4-channel-mapping-v2-0-ccef9a66a572@linaro.org>
In-Reply-To: <20240508-asoc-x1e80100-4-channel-mapping-v2-0-ccef9a66a572@linaro.org>
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
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10038;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=HZ5c05lASDGke6zV6oGSp7GtVTkm9nQ4CbvayqlVq5o=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmOzThPDEa3Y144bYqYosGCjC/SAw0gTeweR2Id
 aEVzLem9f2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZjs04QAKCRDBN2bmhouD
 1+yNEACRYti+q8Z0fVyDZbDn8FGaexH1ORpc4CR2JCGcC+4xcoB+ytKpUrD2PVU3CwbgRmKCvl7
 dbVYXOkFBoUGSkRZuu1JWmv1Ed7kGlKbplaXhZzcQVD7PqlYe5tfOKBV3mVC8CYf8HGC1ngeuen
 iuB/dy2CHbjK3eIMQ9LxPilN9hDitxnPgpOAGXlrVYD3eyZ4m1z3gkn6DJZAemKBmLA1Vkbe7Je
 0ExKdRHDz9PJrI2LbUfVsMOL+wykRJNPQALyv0ZS9/qRXQvWob1d1XlwlQ0CtNCeHCNDcyX8UJz
 cUY8glVhVn9mozHqP9lDZKKaUy92IkG5VR0iJ0Wky5IqmBn8zmgkhEe8tWxtZ59Zu2RyXvWLAqk
 a3yPbFNTVOgN4BKSIVXk1+J9YVa6M1iQ+g97BpAoT9B4iz5UjMXauH3D4QWtFp3JBwogKsG04/c
 SlPZPM9AI4EqfCEJnw8d+J38cwB3WFC7ILVBsIPD0KMDAy/OEekGA3JLrvzUdZBwbGOvimnsQla
 JNQ/PPRRvs+0uCt3EVQCRv1Om1uFPGYaDHUNkXZsWFn3LAFB9EYtAuik/LPvDNGsT2kx43IW3YO
 fl/5i5Zz2bOidPnMHwbo7BAAF+HhEH5HXc3TLBdH2mw18MII16TsLaT8b47UGlQqncMiAcgwsn/
 62YkmriK3XYlCxQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

There is no need for implementations of DAI set_channel_map() to modify
contents of passed arrays with actual channel mapping.  Additionally,
the caller keeps full ownership of the array.

Constify these pointer arguments so the code will be safer and easier to
read (documenting the caller's ownership).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
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


