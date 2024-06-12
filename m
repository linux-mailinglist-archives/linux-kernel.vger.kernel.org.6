Return-Path: <linux-kernel+bounces-211037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DD4904C60
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C6C41C20C99
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E32716D32C;
	Wed, 12 Jun 2024 07:07:54 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D1516C864;
	Wed, 12 Jun 2024 07:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176073; cv=none; b=RdKFasigJTJt9wJjMorkMWgszY5V07HAZUQaohfN3dWTf1BLW37fmE/Kn9K/khbhQAPWZymzsMYgsta83ouC4po60igp8HQQv3uHjkv+ZoC38TegNOF/HRQVRWyYpBpIfOgUwxz/omewD6S/bnakCfuR5CXrn6wzoZGLLbtWpzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176073; c=relaxed/simple;
	bh=o2rGzDo3YKlqQkaytlg9bu7jSVurFyAsDq+dZF2uQ0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=NXGvLRhaFD1f//fi7MtjZkcGZm34DDgCa/HFpgIuov2ihDJGys5wggR8QvLMRBDWnAemeVtU5ULbXJLBKwwDtXawZKvnwG0f/UtyDsvLQkw8rMy+jmqnEyk9JEEf4lQl245DBwPejBE93jgn9EE4LzmXfhdgfIQYFdfxhsLvzkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 884552018B5;
	Wed, 12 Jun 2024 08:57:49 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EE47820079D;
	Wed, 12 Jun 2024 08:57:48 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id ABEFB181D0FD;
	Wed, 12 Jun 2024 14:57:46 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: viorel.suman@nxp.com
Subject: [PATCH 3/3] ASoC: imx-audmix: Split capture device for audmix
Date: Wed, 12 Jun 2024 14:40:52 +0800
Message-Id: <1718174452-17596-4-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1718174452-17596-1-git-send-email-shengjiu.wang@nxp.com>
References: <1718174452-17596-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

There will be three devices for this sound card, hw:x,0 is
the playback device for one SAI, hw:x,1 is the playback device
for another SAI, hw:x,2 is the capture device for audmix
output. then capture device and playback device can be configured
with different master/slave mode.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/imx-audmix.c | 79 ++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 34 deletions(-)

diff --git a/sound/soc/fsl/imx-audmix.c b/sound/soc/fsl/imx-audmix.c
index 2aeb18397bcb..6fbcf33fd0de 100644
--- a/sound/soc/fsl/imx-audmix.c
+++ b/sound/soc/fsl/imx-audmix.c
@@ -140,6 +140,13 @@ static const struct snd_soc_ops imx_audmix_be_ops = {
 	.hw_params = imx_audmix_be_hw_params,
 };
 
+static const char *name[][3] = {
+	{"HiFi-AUDMIX-FE-0", "HiFi-AUDMIX-FE-1", "HiFi-AUDMIX-FE-2"},
+	{"sai-tx", "sai-tx", "sai-rx"},
+	{"AUDMIX-Playback-0", "AUDMIX-Playback-1", "CPU-Capture"},
+	{"CPU-Playback", "CPU-Playback", "AUDMIX-Capture-0"},
+};
+
 static int imx_audmix_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -150,7 +157,7 @@ static int imx_audmix_probe(struct platform_device *pdev)
 	struct imx_audmix *priv;
 	int i, num_dai, ret;
 	const char *fe_name_pref = "HiFi-AUDMIX-FE-";
-	char *be_name, *be_pb, *be_cp, *dai_name, *capture_dai_name;
+	char *be_name, *dai_name;
 
 	if (pdev->dev.parent) {
 		audmix_np = pdev->dev.parent->of_node;
@@ -183,6 +190,7 @@ static int imx_audmix_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	num_dai += 1;
 	priv->num_dai = 2 * num_dai;
 	priv->dai = devm_kcalloc(&pdev->dev, priv->num_dai,
 				 sizeof(struct snd_soc_dai_link), GFP_KERNEL);
@@ -196,7 +204,7 @@ static int imx_audmix_probe(struct platform_device *pdev)
 	if (!priv->dai_conf)
 		return -ENOMEM;
 
-	priv->num_dapm_routes = 3 * num_dai;
+	priv->num_dapm_routes = num_dai;
 	priv->dapm_routes = devm_kcalloc(&pdev->dev, priv->num_dapm_routes,
 					 sizeof(struct snd_soc_dapm_route),
 					 GFP_KERNEL);
@@ -211,8 +219,12 @@ static int imx_audmix_probe(struct platform_device *pdev)
 		if (!dlc)
 			return -ENOMEM;
 
-		ret = of_parse_phandle_with_args(audmix_np, "dais", NULL, i,
-						 &args);
+		if (i == num_dai - 1)
+			ret = of_parse_phandle_with_args(audmix_np, "dais", NULL, 0,
+							 &args);
+		else
+			ret = of_parse_phandle_with_args(audmix_np, "dais", NULL, i,
+							 &args);
 		if (ret < 0) {
 			dev_err(&pdev->dev, "of_parse_phandle_with_args failed\n");
 			return ret;
@@ -226,20 +238,14 @@ static int imx_audmix_probe(struct platform_device *pdev)
 		put_device(&cpu_pdev->dev);
 
 		dai_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s%s",
-					  fe_name_pref, args.np->full_name + 1);
+					  fe_name_pref, args.np->full_name);
 		if (!dai_name)
 			return -ENOMEM;
 
 		dev_info(pdev->dev.parent, "DAI FE name:%s\n", dai_name);
 
-		if (i == 0) {
+		if (i == num_dai - 1)
 			out_cpu_np = args.np;
-			capture_dai_name =
-				devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s %s",
-					       dai_name, "CPU-Capture");
-			if (!capture_dai_name)
-				return -ENOMEM;
-		}
 
 		/*
 		 * CPU == Platform
@@ -252,27 +258,23 @@ static int imx_audmix_probe(struct platform_device *pdev)
 		priv->dai[i].num_cpus = 1;
 		priv->dai[i].num_codecs = 1;
 		priv->dai[i].num_platforms = 1;
-
-		priv->dai[i].name = dai_name;
+		priv->dai[i].name = name[0][i];
 		priv->dai[i].stream_name = "HiFi-AUDMIX-FE";
 		priv->dai[i].cpus->of_node = args.np;
-		priv->dai[i].cpus->dai_name = dev_name(&cpu_pdev->dev);
+		priv->dai[i].cpus->dai_name = name[1][i];
+
 		priv->dai[i].dynamic = 1;
 		priv->dai[i].dpcm_playback = 1;
-		priv->dai[i].dpcm_capture = (i == 0 ? 1 : 0);
+		if (i == num_dai - 1) {
+			priv->dai[i].dpcm_capture = 1;
+			priv->dai[i].dpcm_playback = 0;
+		}
 		priv->dai[i].ignore_pmdown_time = 1;
 		priv->dai[i].ops = &imx_audmix_fe_ops;
 
 		/* Add AUDMIX Backend */
 		be_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
 					 "audmix-%d", i);
-		be_pb = devm_kasprintf(&pdev->dev, GFP_KERNEL,
-				       "AUDMIX-Playback-%d", i);
-		be_cp = devm_kasprintf(&pdev->dev, GFP_KERNEL,
-				       "AUDMIX-Capture-%d", i);
-		if (!be_name || !be_pb || !be_cp)
-			return -ENOMEM;
-
 		priv->dai[num_dai + i].cpus	= &dlc[1];
 		priv->dai[num_dai + i].codecs	= &snd_soc_dummy_dlc;
 
@@ -284,24 +286,33 @@ static int imx_audmix_probe(struct platform_device *pdev)
 		priv->dai[num_dai + i].cpus->dai_name = be_name;
 		priv->dai[num_dai + i].no_pcm = 1;
 		priv->dai[num_dai + i].dpcm_playback = 1;
-		priv->dai[num_dai + i].dpcm_capture  = 1;
+		if (i == num_dai - 1) {
+			priv->dai[num_dai + i].dpcm_capture  = 1;
+			priv->dai[num_dai + i].dpcm_playback  = 0;
+		}
 		priv->dai[num_dai + i].ignore_pmdown_time = 1;
 		priv->dai[num_dai + i].ops = &imx_audmix_be_ops;
 
 		priv->dai_conf[i].dlc.of_node = args.np;
 		priv->dai_conf[i].name_prefix = dai_name;
 
-		priv->dapm_routes[i].source =
-			devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s %s",
-				       dai_name, "CPU-Playback");
-		if (!priv->dapm_routes[i].source)
-			return -ENOMEM;
+		if (i == num_dai - 1) {
+			priv->dapm_routes[i].sink =
+				devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s %s",
+					       dai_name, name[2][i]);
+			if (!priv->dapm_routes[i].sink)
+				return -ENOMEM;
 
-		priv->dapm_routes[i].sink = be_pb;
-		priv->dapm_routes[num_dai + i].source   = be_pb;
-		priv->dapm_routes[num_dai + i].sink     = be_cp;
-		priv->dapm_routes[2 * num_dai + i].source = be_cp;
-		priv->dapm_routes[2 * num_dai + i].sink   = capture_dai_name;
+			priv->dapm_routes[i].source = name[3][i];
+		} else {
+			priv->dapm_routes[i].source =
+				devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s %s",
+					       dai_name, name[3][i]);
+			if (!priv->dapm_routes[i].source)
+				return -ENOMEM;
+
+			priv->dapm_routes[i].sink = name[2][i];
+		}
 	}
 
 	cpu_pdev = of_find_device_by_node(out_cpu_np);
-- 
2.34.1


