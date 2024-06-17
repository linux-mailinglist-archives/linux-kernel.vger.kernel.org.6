Return-Path: <linux-kernel+bounces-216993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2929090A972
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BDBC1F218AA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1E71922F3;
	Mon, 17 Jun 2024 09:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zhfMv+GP"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705BD190049
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 09:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718616120; cv=none; b=ArMFLnoylJoC7GA3g0WdwX4RBc3BQUwqioyBMro24syz6oM4PvMfJh4R4KcFxzloeJtSikCiYizg0k7rYLh3bUfdkZOqVPeKiBkyMvPaJSaRv3XkNe3zFSt09aii7N2SEldZqYuJzzyOjhRMqoLXNJtfvmTlg751GXt+gaW3EAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718616120; c=relaxed/simple;
	bh=eAgTCVGAV6EPOAUmy1VIh5I91Q873BoEU8+USCkssMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Moa6NTaAUxWpAj5jkZhZf8UTVYy/7egaVzHHw2x2jkgIlUqZID3sq8f4cibVJI9qb7RZ4UNosvUg3ojeOvbkdJNZBLO2dOFvry590i+1Me71C3smkx2hg4k27nKy48MUWqNVM8NFu3nzSahF9mipmI8WIBlq/hmKQMEtA8DGEt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zhfMv+GP; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6f176c5c10so485168466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 02:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718616117; x=1719220917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aM9IPnP8/0YXyiArT21pvUePu652PEvGsnn6Iiq8wUk=;
        b=zhfMv+GPEpzymowAepfMSEiCJLe9Pk3dL5lFyovBHNTBJ1jcVDcgGYGQE0PPPKBZDk
         Kw+WEWXZjIRx9hau7+aZ4/vnFfe8TFcV3sJZE/NoTW4SPvlyTwbueUl5SsA1HJL++HWx
         pQa1b0ZPhmFSwOU1gQjf2nojhN+vBcZwZ5kq/EFQ5Rp4WvtAiyQ0BnqmPnH8J8KBthMU
         IMcWL3imNIDHwvMfi2gNUeOmLB/dEi+of5Cs9SjBQkfRXjz4Vv94hsGA2/etnWJRJ2mC
         gHdDS55Pc4UJX3eoD3K4KyEQ86yRpYdLYzQNJdYeed8tTnJ+yUQkWjhlCP69WH0YBOx5
         SwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718616117; x=1719220917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aM9IPnP8/0YXyiArT21pvUePu652PEvGsnn6Iiq8wUk=;
        b=fsWRv3lFAd5iHLxYwQeHzOmey4qXPpkRAe7InCkqBZ9tVYr1mjVdSO5La+RvBAF98P
         hoRwPsh2zqTxzmVYXvKVR8l6Gk6pblQY1DzrlolKvj3iDvCYwtUeE60WWFZUBYjukf0/
         7/Kuf26TmLZJ8gW402kFukvFi4aFQXSjV2qMOhlk6dmOpsSbLxEoupvx/iALCo5MHWqR
         8CUJbCytiO+uvllTvgB9OsiSck3/lmn7D+rI5fjGv5N/hoEKhvlmtQmYqk5ql0xXjj/3
         nATXU6RduIE9xtLhhE/Ysu11rQ6TeRQh8XiN0h+ZlB9KeCn/gJde5mg0n+yATSzAJw+a
         hEOA==
X-Forwarded-Encrypted: i=1; AJvYcCVS51qQ5tKL1dPgY9341PyWI5hCcIhgSARol2PbZ5xHDzLvvWB/x368fEcgaOXe0PWzywP0HaloE+8OSxFLG6ZicWINpjzXDwIbH49c
X-Gm-Message-State: AOJu0YzNvxj6GwxlIgwVGVlzkmqtl17CL3lqsouwA3BD50iCBBxBb+3c
	O4iYLNUO1gTy2edTr3+nh2n2EJNc1AWvYxL20FcHi7AnP5yqRMLyFpvgLzzncMU=
X-Google-Smtp-Source: AGHT+IEanYWlM3d9JWU/5k+2u3LYtdAAule1YY6wqrXPIyG+saueZDyCnhT1fyYflEFvgm3euf5OSg==
X-Received: by 2002:a17:906:c1cc:b0:a6f:513a:a65 with SMTP id a640c23a62f3a-a6f60d3cdf9mr594368066b.33.1718616116790;
        Mon, 17 Jun 2024 02:21:56 -0700 (PDT)
Received: from krzk-bin.. ([78.10.207.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56ed359bsm497944966b.137.2024.06.17.02.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 02:21:56 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ASoC: Constify DAI ops auto_selectable_formats
Date: Mon, 17 Jun 2024 11:21:52 +0200
Message-ID: <20240617092152.244981-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617092152.244981-1-krzysztof.kozlowski@linaro.org>
References: <20240617092152.244981-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The static arrays passed as 'auto_selectable_formats' are not modified
by the drivers nor by the core code, so make it const for code safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/ak4613.c          | 2 +-
 sound/soc/codecs/da7213.c          | 2 +-
 sound/soc/codecs/hdmi-codec.c      | 2 +-
 sound/soc/codecs/idt821034.c       | 2 +-
 sound/soc/codecs/pcm3168a.c        | 2 +-
 sound/soc/codecs/peb2466.c         | 2 +-
 sound/soc/generic/test-component.c | 2 +-
 sound/soc/sh/fsi.c                 | 2 +-
 sound/soc/sh/rcar/core.c           | 2 +-
 sound/soc/soc-utils.c              | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/ak4613.c b/sound/soc/codecs/ak4613.c
index 73fb35560e51..551738abd1a5 100644
--- a/sound/soc/codecs/ak4613.c
+++ b/sound/soc/codecs/ak4613.c
@@ -753,7 +753,7 @@ static int ak4613_dai_trigger(struct snd_pcm_substream *substream, int cmd,
  *	SND_SOC_DAIFMT_CBC_CFC
  *	SND_SOC_DAIFMT_CBP_CFP
  */
-static u64 ak4613_dai_formats =
+static const u64 ak4613_dai_formats =
 	SND_SOC_POSSIBLE_DAIFMT_I2S	|
 	SND_SOC_POSSIBLE_DAIFMT_LEFT_J;
 
diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index a2b328f3b39f..f3ef6fb55304 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -1720,7 +1720,7 @@ static int da7213_set_component_pll(struct snd_soc_component *component,
  *	SND_SOC_DAIFMT_CBC_CFC
  *	SND_SOC_DAIFMT_CBP_CFP
  */
-static u64 da7213_dai_formats =
+static const u64 da7213_dai_formats =
 	SND_SOC_POSSIBLE_DAIFMT_I2S	|
 	SND_SOC_POSSIBLE_DAIFMT_LEFT_J	|
 	SND_SOC_POSSIBLE_DAIFMT_RIGHT_J	|
diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index d3abb7ce2153..74caae52e127 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -715,7 +715,7 @@ static int hdmi_codec_mute(struct snd_soc_dai *dai, int mute, int direction)
  * For example,
  *	${LINUX}/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
  */
-static u64 hdmi_codec_formats =
+static const u64 hdmi_codec_formats =
 	SND_SOC_POSSIBLE_DAIFMT_NB_NF	|
 	SND_SOC_POSSIBLE_DAIFMT_NB_IF	|
 	SND_SOC_POSSIBLE_DAIFMT_IB_NF	|
diff --git a/sound/soc/codecs/idt821034.c b/sound/soc/codecs/idt821034.c
index 2cc7b9166e69..cb7a68c799f8 100644
--- a/sound/soc/codecs/idt821034.c
+++ b/sound/soc/codecs/idt821034.c
@@ -860,7 +860,7 @@ static int idt821034_dai_startup(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static u64 idt821034_dai_formats[] = {
+static const u64 idt821034_dai_formats[] = {
 	SND_SOC_POSSIBLE_DAIFMT_DSP_A	|
 	SND_SOC_POSSIBLE_DAIFMT_DSP_B,
 };
diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index 3c0e0fdbfc5c..fac0617ab95b 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -562,7 +562,7 @@ static int pcm3168a_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static u64 pcm3168a_dai_formats[] = {
+static const u64 pcm3168a_dai_formats[] = {
 	/*
 	 * Select below from Sound Card, not here
 	 *	SND_SOC_DAIFMT_CBC_CFC
diff --git a/sound/soc/codecs/peb2466.c b/sound/soc/codecs/peb2466.c
index 5dec69be0acb..76ee7e3f4d9b 100644
--- a/sound/soc/codecs/peb2466.c
+++ b/sound/soc/codecs/peb2466.c
@@ -814,7 +814,7 @@ static int peb2466_dai_startup(struct snd_pcm_substream *substream,
 					  &peb2466_sample_bits_constr);
 }
 
-static u64 peb2466_dai_formats[] = {
+static const u64 peb2466_dai_formats[] = {
 	SND_SOC_POSSIBLE_DAIFMT_DSP_A	|
 	SND_SOC_POSSIBLE_DAIFMT_DSP_B,
 };
diff --git a/sound/soc/generic/test-component.c b/sound/soc/generic/test-component.c
index e4967540a2e1..e9e5e235a8a6 100644
--- a/sound/soc/generic/test-component.c
+++ b/sound/soc/generic/test-component.c
@@ -189,7 +189,7 @@ static int test_dai_bespoke_trigger(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static u64 test_dai_formats =
+static const u64 test_dai_formats =
 	/*
 	 * Select below from Sound Card, not auto
 	 *	SND_SOC_POSSIBLE_DAIFMT_BP_FP
diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index 84601ba43b7d..087e379aa3bc 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -1713,7 +1713,7 @@ static int fsi_dai_hw_params(struct snd_pcm_substream *substream,
  *	SND_SOC_DAIFMT_CBC_CFC
  *	SND_SOC_DAIFMT_CBP_CFP
  */
-static u64 fsi_dai_formats =
+static const u64 fsi_dai_formats =
 	SND_SOC_POSSIBLE_DAIFMT_I2S	|
 	SND_SOC_POSSIBLE_DAIFMT_LEFT_J	|
 	SND_SOC_POSSIBLE_DAIFMT_NB_NF	|
diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 6bc7027ed4db..63b3c8bf0fde 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1061,7 +1061,7 @@ static int rsnd_soc_dai_prepare(struct snd_pcm_substream *substream,
 	return rsnd_dai_call(prepare, io, priv);
 }
 
-static u64 rsnd_soc_dai_formats[] = {
+static const u64 rsnd_soc_dai_formats[] = {
 	/*
 	 * 1st Priority
 	 *
diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index d05e712c9518..20135a8359bf 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -163,7 +163,7 @@ static const struct snd_soc_component_driver dummy_codec = {
  *	SND_SOC_POSSIBLE_DAIFMT_CBC_CFP
  *	SND_SOC_POSSIBLE_DAIFMT_CBC_CFC
  */
-static u64 dummy_dai_formats =
+static const u64 dummy_dai_formats =
 	SND_SOC_POSSIBLE_DAIFMT_I2S	|
 	SND_SOC_POSSIBLE_DAIFMT_RIGHT_J	|
 	SND_SOC_POSSIBLE_DAIFMT_LEFT_J	|
-- 
2.43.0


