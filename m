Return-Path: <linux-kernel+bounces-341449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D65A98803D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80676B2451D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53AF18893E;
	Fri, 27 Sep 2024 08:23:24 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C642189B91;
	Fri, 27 Sep 2024 08:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727425404; cv=none; b=fOFbfN3sPooKF8tgx2x07XbT4uGxY12hKwp0O4PWA9LuY6TuXlhhMlG9Z2Xmzv8UuLPKGLDISAZRz45W9TPe4qNhet3Z0vI+CIfAP6+8YUSWbUsRAq1cZ+n4Y2BAX3U0pcZrE0pivFT70Il5h73AUwwcUmCm+7H8Kh31I5W6WUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727425404; c=relaxed/simple;
	bh=uAZu7jgOYOp5A+s3eueNH7j+KtpbzDNYf4Ayr4G5EaY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=hNtQ3xJenvXGQjrXV+5zpjfo2PhaXUTnvMDPNdc+07LI0CZMqG2Wxfhok9C6tV9jeRDxMCSahwu+1RcQbZSvuHvY3xKuYlf0vGofIwhID2eCopxW88McuqhOc1DN6E9fOCD9DfXYtMRE1Fl+vpngbevCozwaRL7Bh779QBJHicM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EC9A2201A2A;
	Fri, 27 Sep 2024 10:23:15 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B0453201A52;
	Fri, 27 Sep 2024 10:23:15 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 18AAD183DC03;
	Fri, 27 Sep 2024 16:23:14 +0800 (+08)
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
Subject: [PATCH 3/3] ASoC: fsl_micfil: Enable micfil error interrupt
Date: Fri, 27 Sep 2024 16:00:31 +0800
Message-Id: <1727424031-19551-4-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1727424031-19551-1-git-send-email-shengjiu.wang@nxp.com>
References: <1727424031-19551-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Enable micfil error interrupt, in the error handler,
FIFO state and OUT state need to be cleared.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_micfil.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 6ecf46e9ac4c..0930d8c9b8d7 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -651,7 +651,7 @@ static int fsl_micfil_trigger(struct snd_pcm_substream *substream, int cmd,
 
 		/* Enable the module */
 		ret = regmap_set_bits(micfil->regmap, REG_MICFIL_CTRL1,
-				      MICFIL_CTRL1_PDMIEN);
+				      MICFIL_CTRL1_PDMIEN | MICFIL_CTRL1_ERREN);
 		if (ret)
 			return ret;
 
@@ -667,7 +667,7 @@ static int fsl_micfil_trigger(struct snd_pcm_substream *substream, int cmd,
 
 		/* Disable the module */
 		ret = regmap_clear_bits(micfil->regmap, REG_MICFIL_CTRL1,
-					MICFIL_CTRL1_PDMIEN);
+					MICFIL_CTRL1_PDMIEN | MICFIL_CTRL1_ERREN);
 		if (ret)
 			return ret;
 
@@ -940,6 +940,7 @@ static bool fsl_micfil_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case REG_MICFIL_STAT:
+	case REG_MICFIL_FIFO_STAT:
 	case REG_MICFIL_DATACH0:
 	case REG_MICFIL_DATACH1:
 	case REG_MICFIL_DATACH2:
@@ -948,6 +949,7 @@ static bool fsl_micfil_volatile_reg(struct device *dev, unsigned int reg)
 	case REG_MICFIL_DATACH5:
 	case REG_MICFIL_DATACH6:
 	case REG_MICFIL_DATACH7:
+	case REG_MICFIL_OUT_STAT:
 	case REG_MICFIL_VERID:
 	case REG_MICFIL_PARAM:
 	case REG_MICFIL_VAD0_STAT:
@@ -1024,6 +1026,8 @@ static irqreturn_t micfil_err_isr(int irq, void *devid)
 {
 	struct fsl_micfil *micfil = (struct fsl_micfil *)devid;
 	struct platform_device *pdev = micfil->pdev;
+	u32 fifo_stat_reg;
+	u32 out_stat_reg;
 	u32 stat_reg;
 
 	regmap_read(micfil->regmap, REG_MICFIL_STAT, &stat_reg);
@@ -1040,6 +1044,14 @@ static irqreturn_t micfil_err_isr(int irq, void *devid)
 				  MICFIL_STAT_LOWFREQF, MICFIL_STAT_LOWFREQF);
 	}
 
+	regmap_read(micfil->regmap, REG_MICFIL_FIFO_STAT, &fifo_stat_reg);
+	regmap_write_bits(micfil->regmap, REG_MICFIL_FIFO_STAT,
+			  fifo_stat_reg, fifo_stat_reg);
+
+	regmap_read(micfil->regmap, REG_MICFIL_OUT_STAT, &out_stat_reg);
+	regmap_write_bits(micfil->regmap, REG_MICFIL_OUT_STAT,
+			  out_stat_reg, out_stat_reg);
+
 	return IRQ_HANDLED;
 }
 
-- 
2.34.1


