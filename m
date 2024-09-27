Return-Path: <linux-kernel+bounces-341448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F2E98803A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62F2B282EBB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652E6189F37;
	Fri, 27 Sep 2024 08:23:23 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644AC17E44F;
	Fri, 27 Sep 2024 08:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727425403; cv=none; b=DDMFVaipvCTLfeC/wxYhlWzsO8rQpKJHb3QKjBXKGmogVu6kNRa1d0NsF/fj50JL+ban+Fet1f3CkwpBS6wJmQxDYrBaxPx76v1iamCsqaXeOKeuU7wsE9VILKRnnP/1c5HUADxjMLF2y86aIccwMjSN/OWfENewygc1GfsxGU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727425403; c=relaxed/simple;
	bh=1/MpVD+7+dOCpQgXs3U4X3eSEUe5h3A8K/qR3gDuJRU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=CnHFGE6VTACmDwd/5sGQ3BUwsHa+Oz+olTwzo0JZ9Q3i3vWvAf3NPKHEnmTFUqKWNCvWkT3rKt2GgLQ0Ck/N8B4IR7teLl3jA5476j//90V2hI764scup/6Q50KVhoHgdpFu0ZXsj3X9xZSW6qBk0zCrwJEzrpz7kwxo769mErU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6814A1A1B60;
	Fri, 27 Sep 2024 10:23:14 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 379251A1B45;
	Fri, 27 Sep 2024 10:23:14 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id ED3DA183DC02;
	Fri, 27 Sep 2024 16:23:12 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ASoC: fsl_micfil: Add mclk enable flag
Date: Fri, 27 Sep 2024 16:00:30 +0800
Message-Id: <1727424031-19551-3-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1727424031-19551-1-git-send-email-shengjiu.wang@nxp.com>
References: <1727424031-19551-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Previously the mclk is enabled in probe() stage, which
is not necessary. Move mclk enablement to hw_params()
and mclk disablement to hw_free() will be more efficient.
'mclk_flag' is used for this case.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_micfil.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index c347cb3a4712..6ecf46e9ac4c 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -58,6 +58,7 @@ struct fsl_micfil {
 	int vad_detected;
 	struct fsl_micfil_verid verid;
 	struct fsl_micfil_param param;
+	bool mclk_flag;  /* mclk enable flag */
 };
 
 struct fsl_micfil_soc_data {
@@ -693,7 +694,6 @@ static int fsl_micfil_reparent_rootclk(struct fsl_micfil *micfil, unsigned int s
 	clk = micfil->mclk;
 
 	/* Disable clock first, for it was enabled by pm_runtime */
-	clk_disable_unprepare(clk);
 	fsl_asoc_reparent_pll_clocks(dev, clk, micfil->pll8k_clk,
 				     micfil->pll11k_clk, ratio);
 	ret = clk_prepare_enable(clk);
@@ -730,6 +730,8 @@ static int fsl_micfil_hw_params(struct snd_pcm_substream *substream,
 	if (ret)
 		return ret;
 
+	micfil->mclk_flag = true;
+
 	ret = clk_set_rate(micfil->mclk, rate * clk_div * osr * 8);
 	if (ret)
 		return ret;
@@ -764,6 +766,17 @@ static int fsl_micfil_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int fsl_micfil_hw_free(struct snd_pcm_substream *substream,
+			      struct snd_soc_dai *dai)
+{
+	struct fsl_micfil *micfil = snd_soc_dai_get_drvdata(dai);
+
+	clk_disable_unprepare(micfil->mclk);
+	micfil->mclk_flag = false;
+
+	return 0;
+}
+
 static int fsl_micfil_dai_probe(struct snd_soc_dai *cpu_dai)
 {
 	struct fsl_micfil *micfil = dev_get_drvdata(cpu_dai->dev);
@@ -806,6 +819,7 @@ static const struct snd_soc_dai_ops fsl_micfil_dai_ops = {
 	.startup	= fsl_micfil_startup,
 	.trigger	= fsl_micfil_trigger,
 	.hw_params	= fsl_micfil_hw_params,
+	.hw_free	= fsl_micfil_hw_free,
 };
 
 static struct snd_soc_dai_driver fsl_micfil_dai = {
@@ -1279,7 +1293,8 @@ static int fsl_micfil_runtime_suspend(struct device *dev)
 
 	regcache_cache_only(micfil->regmap, true);
 
-	clk_disable_unprepare(micfil->mclk);
+	if (micfil->mclk_flag)
+		clk_disable_unprepare(micfil->mclk);
 	clk_disable_unprepare(micfil->busclk);
 
 	return 0;
@@ -1294,10 +1309,12 @@ static int fsl_micfil_runtime_resume(struct device *dev)
 	if (ret < 0)
 		return ret;
 
-	ret = clk_prepare_enable(micfil->mclk);
-	if (ret < 0) {
-		clk_disable_unprepare(micfil->busclk);
-		return ret;
+	if (micfil->mclk_flag) {
+		ret = clk_prepare_enable(micfil->mclk);
+		if (ret < 0) {
+			clk_disable_unprepare(micfil->busclk);
+			return ret;
+		}
 	}
 
 	regcache_cache_only(micfil->regmap, false);
-- 
2.34.1


