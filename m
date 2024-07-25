Return-Path: <linux-kernel+bounces-261722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 559E993BB53
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 05:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03A1C285297
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 03:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CF317C8B;
	Thu, 25 Jul 2024 03:48:42 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F34233CA;
	Thu, 25 Jul 2024 03:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721879322; cv=none; b=bhLF1HA+NjQj6P9bCfBysR7dGETxxw530WsRUsHH2PoMfLQTrvk2fuI+JW//h87oxBnh9Q9SGFhQzIijCbQTbBepFc/8jbNmieWL5zBpOW6qQYKweIaC+P4WMQJUXBkClRtpZk0u1OpmM5rIw0v2JK+58UwccszBThircvr7ZfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721879322; c=relaxed/simple;
	bh=EyDmCsB+rlaknj5yPLW/sti7muC19st9eo8Ju/3pAy4=;
	h=From:To:Subject:Date:Message-Id; b=AhF3dt3mpV7mcN2uMsuF6wE78lIYlECZn1M0IjySqcTfC8eTw7AALlRNuGW5/y6/4esfYraTtW6Hh3R6QghIMBvvyXPUcD642eYCQQwhBp7hvSJgUJgKRHtm61Wd6c7tLTBLeJNBnjk0yIjaVu5fNRCTI+kRrcOMPO1M1PIhAOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BFD061A038B;
	Thu, 25 Jul 2024 05:48:31 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 68D8F1A05AA;
	Thu, 25 Jul 2024 05:48:31 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 19DC7183AD09;
	Thu, 25 Jul 2024 11:48:30 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	elinor.montmasson@savoirfairelinux.com,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl-asoc-card: Dynamically allocate memory for snd_soc_dai_link_components
Date: Thu, 25 Jul 2024 11:22:53 +0800
Message-Id: <1721877773-5229-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The static snd_soc_dai_link_components cause conflict for multiple
instances of this generic driver. For example, when there is
wm8962 and SPDIF case enabled together, the contaminated
snd_soc_dai_link_components will cause another device probe fail.

Fixes: 6d174cc4f224 ("ASoC: fsl-asoc-card: merge spdif support from imx-spdif.c")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 46 ++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 82df887b3af5..f6c3aeff0d8e 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -306,27 +306,12 @@ static int be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
-SND_SOC_DAILINK_DEFS(hifi,
-	DAILINK_COMP_ARRAY(COMP_EMPTY()),
-	DAILINK_COMP_ARRAY(COMP_EMPTY(), COMP_EMPTY()),
-	DAILINK_COMP_ARRAY(COMP_EMPTY()));
-
-SND_SOC_DAILINK_DEFS(hifi_fe,
-	DAILINK_COMP_ARRAY(COMP_EMPTY()),
-	DAILINK_COMP_ARRAY(COMP_DUMMY()),
-	DAILINK_COMP_ARRAY(COMP_EMPTY()));
-
-SND_SOC_DAILINK_DEFS(hifi_be,
-	DAILINK_COMP_ARRAY(COMP_EMPTY()),
-	DAILINK_COMP_ARRAY(COMP_EMPTY(), COMP_EMPTY()));
-
 static const struct snd_soc_dai_link fsl_asoc_card_dai[] = {
 	/* Default ASoC DAI Link*/
 	{
 		.name = "HiFi",
 		.stream_name = "HiFi",
 		.ops = &fsl_asoc_card_ops,
-		SND_SOC_DAILINK_REG(hifi),
 	},
 	/* DPCM Link between Front-End and Back-End (Optional) */
 	{
@@ -335,7 +320,6 @@ static const struct snd_soc_dai_link fsl_asoc_card_dai[] = {
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
 		.dynamic = 1,
-		SND_SOC_DAILINK_REG(hifi_fe),
 	},
 	{
 		.name = "HiFi-ASRC-BE",
@@ -345,7 +329,6 @@ static const struct snd_soc_dai_link fsl_asoc_card_dai[] = {
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
 		.no_pcm = 1,
-		SND_SOC_DAILINK_REG(hifi_be),
 	},
 };
 
@@ -637,6 +620,7 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	struct platform_device *cpu_pdev;
 	struct fsl_asoc_card_priv *priv;
 	struct device *codec_dev[2] = { NULL, NULL };
+	struct snd_soc_dai_link_component *dlc;
 	const char *codec_dai_name[2];
 	const char *codec_dev_name[2];
 	u32 asrc_fmt = 0;
@@ -717,7 +701,35 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 
 	memcpy(priv->dai_link, fsl_asoc_card_dai,
 	       sizeof(struct snd_soc_dai_link) * ARRAY_SIZE(priv->dai_link));
+	/*
+	 * "Default ASoC DAI Link": 1 cpus, 2 codecs, 1 platforms
+	 * "DPCM Link Front-End":  1 cpus, 1 codecs (dummy), 1 platforms
+	 * "DPCM Link Back-End": 1 cpus, 2 codecs
+	 * totally 10 components
+	 */
+	dlc = devm_kcalloc(&pdev->dev, 10, sizeof(*dlc), GFP_KERNEL);
+	if (!dlc) {
+		ret = -ENOMEM;
+		goto asrc_fail;
+	}
+
+	priv->dai_link[0].cpus = &dlc[0];
+	priv->dai_link[0].num_cpus = 1;
+	priv->dai_link[0].codecs = &dlc[1];
 	priv->dai_link[0].num_codecs = 1;
+	priv->dai_link[0].platforms = &dlc[3];
+	priv->dai_link[0].num_platforms = 1;
+
+	priv->dai_link[1].cpus = &dlc[4];
+	priv->dai_link[1].num_cpus = 1;
+	priv->dai_link[1].codecs = &dlc[5];
+	priv->dai_link[1].num_codecs = 0; /* dummy */
+	priv->dai_link[1].platforms = &dlc[6];
+	priv->dai_link[1].num_platforms = 1;
+
+	priv->dai_link[2].cpus = &dlc[7];
+	priv->dai_link[2].num_cpus = 1;
+	priv->dai_link[2].codecs = &dlc[8];
 	priv->dai_link[2].num_codecs = 1;
 
 	priv->card.dapm_routes = audio_map;
-- 
2.34.1


