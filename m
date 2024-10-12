Return-Path: <linux-kernel+bounces-362112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE0099B13B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 08:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3A4B283DF6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 06:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B521113A26B;
	Sat, 12 Oct 2024 06:15:42 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C784315F;
	Sat, 12 Oct 2024 06:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728713742; cv=none; b=iVpemR99a16Id7gzKejLtHor0TmfpHt3XH8QPvK6s8z6K7z8OzN4nlGymKzw1sQjGTMh+RHX2YmfeKwsQK7XbFYlXP9C2x4xcXeGzSWym7KVhHzYZ03PzhGRvVHqkTQPKyEHVmXEyACUAbDXn+WubfSsYftQA7utcWcpiRf9EGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728713742; c=relaxed/simple;
	bh=wD11ZTz7KkX2Fk4aL4w4jaz8sIAuYj56c2UMcXZZ1qw=;
	h=From:To:Subject:Date:Message-Id; b=ucXbqPtG26k+0MO0vmT0NXcJEyZ3xS85dhyb9xNYdgcQ0MveFii7k7QX0mxSAnsKlxQ+mUZ+nLDrvwsMF08rlIB/sZZHeIsSdtiQvDJmEaB8Mt/lLWVYRTRPjEv+6qq8sQ/9VmyKvvl880c7wUOLXGAAPERK+arhJ6diywi3lAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 918A2200C27;
	Sat, 12 Oct 2024 08:15:33 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5929A20067F;
	Sat, 12 Oct 2024 08:15:33 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C29D91939EA1;
	Sat, 12 Oct 2024 14:15:31 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_mqs: Support accessing registers by scmi interface
Date: Sat, 12 Oct 2024 13:52:10 +0800
Message-Id: <1728712330-4389-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On i.MX95, the MQS module in Always-on (AON) domain only can
be accessed by System Controller Management Interface (SCMI)
MISC Protocol. So define a specific regmap_config for the case.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_mqs.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/sound/soc/fsl/fsl_mqs.c b/sound/soc/fsl/fsl_mqs.c
index 145f9ca15e43..0513e9e8402e 100644
--- a/sound/soc/fsl/fsl_mqs.c
+++ b/sound/soc/fsl/fsl_mqs.c
@@ -6,6 +6,7 @@
 // Copyright 2019 NXP
 
 #include <linux/clk.h>
+#include <linux/firmware/imx/sm.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/mfd/syscon.h>
@@ -74,6 +75,29 @@ struct fsl_mqs {
 #define FSL_MQS_RATES	(SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)
 #define FSL_MQS_FORMATS	SNDRV_PCM_FMTBIT_S16_LE
 
+static int fsl_mqs_sm_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct fsl_mqs *mqs_priv = context;
+	int num = 1;
+
+	if (IS_ENABLED(CONFIG_IMX_SCMI_MISC_DRV) &&
+	    mqs_priv->soc->ctrl_off == reg)
+		return scmi_imx_misc_ctrl_get(SCMI_IMX_CTRL_MQS1_SETTINGS, &num, val);
+
+	return -EINVAL;
+};
+
+static int fsl_mqs_sm_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct fsl_mqs *mqs_priv = context;
+
+	if (IS_ENABLED(CONFIG_IMX_SCMI_MISC_DRV) &&
+	    mqs_priv->soc->ctrl_off == reg)
+		return scmi_imx_misc_ctrl_set(SCMI_IMX_CTRL_MQS1_SETTINGS, val);
+
+	return -EINVAL;
+};
+
 static int fsl_mqs_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params,
 			     struct snd_soc_dai *dai)
@@ -188,6 +212,13 @@ static const struct regmap_config fsl_mqs_regmap_config = {
 	.cache_type = REGCACHE_NONE,
 };
 
+static const struct regmap_config fsl_mqs_sm_regmap = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_read = fsl_mqs_sm_read,
+	.reg_write = fsl_mqs_sm_write,
+};
+
 static int fsl_mqs_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -219,6 +250,16 @@ static int fsl_mqs_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "failed to get gpr regmap\n");
 			return PTR_ERR(mqs_priv->regmap);
 		}
+	} else if (mqs_priv->soc->type == TYPE_REG_SM) {
+		mqs_priv->regmap = devm_regmap_init(&pdev->dev,
+						    NULL,
+						    mqs_priv,
+						    &fsl_mqs_sm_regmap);
+		if (IS_ERR(mqs_priv->regmap)) {
+			dev_err(&pdev->dev, "failed to init regmap: %ld\n",
+				PTR_ERR(mqs_priv->regmap));
+			return PTR_ERR(mqs_priv->regmap);
+		}
 	} else {
 		regs = devm_platform_ioremap_resource(pdev, 0);
 		if (IS_ERR(regs))
-- 
2.34.1


