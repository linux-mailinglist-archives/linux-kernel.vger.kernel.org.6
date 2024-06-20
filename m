Return-Path: <linux-kernel+bounces-222277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B11C890FF20
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C966E1C23881
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1781A3BD8;
	Thu, 20 Jun 2024 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JMOTMWHl"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E3E19DF6C;
	Thu, 20 Jun 2024 08:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873000; cv=none; b=YOtqQA4rITQGnjfnBQSTwFF4h/DUn6sFehSINF9Y9A2r9gZDd4lDGW4k2DVslbE2gNeKtwo9cQIST8ggQd/QKcu9QH8tuW3YbUMUUydrQxoWUQEgG3ow4sSm65wtkEehB41EPa9k6YNVG95M4GN0JXq7ywd6vN73cYFueIvypEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873000; c=relaxed/simple;
	bh=nVi64ptT3yeC9c3LdQUftdhINtCOQi2phyoQtm7QQOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hGzLsliYF11gLUDOaOMad6cJiVmnbTNDUhlMEHyEqHYJLbIeysC+ecC0MUT8aKUFEqN2AXf3Zv8mFIZV3jcZrevqTca4HlrXIlbqxcZmHpKeE9wTHtqLAsmRz7qEwoGYUvLeW36TjwNb24OSCbarGUAFqp92x0e7zl9nzb+60X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JMOTMWHl; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 240FB2000A;
	Thu, 20 Jun 2024 08:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718872997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XcZoHw1OxV6TsmAdg+08k1YhnLc5NmNZMePFnQJFI74=;
	b=JMOTMWHljpjCiEnj20gVflZbP5I0/oA0m5LI7Peo2g6KnbKgJM+tpDzkfM60wiK006X4rD
	fdJ+B7kHZfNdZ1wTM9N+lqNE0kDbAjNf7LysqWif9DsZBNhinrBuS5CUowXI5Dcg/pRLAs
	reYJFaKbfMDOSThnKTcGOB0PageUCGNZZXa2g9rAmdAt9+N5wIRGOYOkZJ1PETHJz3OJ2x
	qvVBt66rDKhQwnn0/bwwJ4qtm02pn5w51tXQQ9gyujkTyHeeWJ0BEqHIZi2CYAaPTwFMEQ
	zBMSXhdRBYeowrpIqM4FpapoCbb++LQHx6r8bgAie559o0HfGxskJl3NQnzICQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 06/10] ASoC: fsl: fsl_qmc_audio: Introduce qmc_dai_constraints_interleaved()
Date: Thu, 20 Jun 2024 10:42:53 +0200
Message-ID: <20240620084300.397853-7-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240620084300.397853-1-herve.codina@bootlin.com>
References: <20240620084300.397853-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Constraints are set by qmc_dai_startup(). These constraints are specific
to the interleaved mode.

With the future introduction of support for non-interleaved mode, a new
set of constraints will be set. To make the code clear and keep
qmc_dai_startup() simple, extract the current interleaved mode
constraints settings to a specific function.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 sound/soc/fsl/fsl_qmc_audio.c | 37 +++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/sound/soc/fsl/fsl_qmc_audio.c b/sound/soc/fsl/fsl_qmc_audio.c
index 36145f1ddbf1..f70c6c8eec4a 100644
--- a/sound/soc/fsl/fsl_qmc_audio.c
+++ b/sound/soc/fsl/fsl_qmc_audio.c
@@ -436,24 +436,14 @@ static int qmc_dai_hw_rule_capture_format_by_channels(struct snd_pcm_hw_params *
 	return qmc_dai_hw_rule_format_by_channels(qmc_dai, params, qmc_dai->nb_rx_ts);
 }
 
-static int qmc_dai_startup(struct snd_pcm_substream *substream,
-			   struct snd_soc_dai *dai)
+static int qmc_dai_constraints_interleaved(struct snd_pcm_substream *substream,
+					   struct qmc_dai *qmc_dai)
 {
-	struct qmc_dai_prtd *prtd = substream->runtime->private_data;
 	snd_pcm_hw_rule_func_t hw_rule_channels_by_format;
 	snd_pcm_hw_rule_func_t hw_rule_format_by_channels;
-	struct qmc_dai *qmc_dai;
 	unsigned int frame_bits;
 	int ret;
 
-	qmc_dai = qmc_dai_get_data(dai);
-	if (!qmc_dai) {
-		dev_err(dai->dev, "Invalid dai\n");
-		return -EINVAL;
-	}
-
-	prtd->qmc_dai = qmc_dai;
-
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
 		hw_rule_channels_by_format = qmc_dai_hw_rule_capture_channels_by_format;
 		hw_rule_format_by_channels = qmc_dai_hw_rule_capture_format_by_channels;
@@ -468,7 +458,7 @@ static int qmc_dai_startup(struct snd_pcm_substream *substream,
 				  hw_rule_channels_by_format, qmc_dai,
 				  SNDRV_PCM_HW_PARAM_FORMAT, -1);
 	if (ret) {
-		dev_err(dai->dev, "Failed to add channels rule (%d)\n", ret);
+		dev_err(qmc_dai->dev, "Failed to add channels rule (%d)\n", ret);
 		return ret;
 	}
 
@@ -476,7 +466,7 @@ static int qmc_dai_startup(struct snd_pcm_substream *substream,
 				  hw_rule_format_by_channels, qmc_dai,
 				  SNDRV_PCM_HW_PARAM_CHANNELS, -1);
 	if (ret) {
-		dev_err(dai->dev, "Failed to add format rule (%d)\n", ret);
+		dev_err(qmc_dai->dev, "Failed to add format rule (%d)\n", ret);
 		return ret;
 	}
 
@@ -484,13 +474,30 @@ static int qmc_dai_startup(struct snd_pcm_substream *substream,
 					   SNDRV_PCM_HW_PARAM_FRAME_BITS,
 					   frame_bits);
 	if (ret < 0) {
-		dev_err(dai->dev, "Failed to add frame_bits constraint (%d)\n", ret);
+		dev_err(qmc_dai->dev, "Failed to add frame_bits constraint (%d)\n", ret);
 		return ret;
 	}
 
 	return 0;
 }
 
+static int qmc_dai_startup(struct snd_pcm_substream *substream,
+			   struct snd_soc_dai *dai)
+{
+	struct qmc_dai_prtd *prtd = substream->runtime->private_data;
+	struct qmc_dai *qmc_dai;
+
+	qmc_dai = qmc_dai_get_data(dai);
+	if (!qmc_dai) {
+		dev_err(dai->dev, "Invalid dai\n");
+		return -EINVAL;
+	}
+
+	prtd->qmc_dai = qmc_dai;
+
+	return qmc_dai_constraints_interleaved(substream, qmc_dai);
+}
+
 static int qmc_dai_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params,
 			     struct snd_soc_dai *dai)
-- 
2.45.0


