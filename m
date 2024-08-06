Return-Path: <linux-kernel+bounces-276000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD59948D14
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 455DF1F24C12
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CDF1C0DD1;
	Tue,  6 Aug 2024 10:47:43 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800421BE23B;
	Tue,  6 Aug 2024 10:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722941263; cv=none; b=HpbBOSwef3GwUyBOiG7zd9KSWaxHGSQnodLZ/84a1dMBPUsTymUsNZPJQ4wvbmCLYcvclt0nQ0NYZlMS8eBL96fdX2WcuAK+97mVk/EcrImEAJbttNjB7Pe9I7aW4nvmA704CZe20zqUzh7n8l6mSIhg0vQ1rip0wxkMS39oQmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722941263; c=relaxed/simple;
	bh=2SMCZU5LBJKXYfuPakXf2C//9G91D9i5Pc7TBGmm3M0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=fLcwEezStn3rwe7qwdOnIwaT6jd/jzDcGP3SiYRmXmuFEJwim3o380dE5fThjeIJAZJp2p3NX6viCeHqNHR12JUkAtZAFy+UpuRxfVJSABdmrzGZhK3QVL2Bw6AQvqPWiWrEmQzQgR4uXgBtX9MdYuyBLXR8Kt9i2muys3I2iBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E5525200E58;
	Tue,  6 Aug 2024 12:47:39 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AB6F3200E65;
	Tue,  6 Aug 2024 12:47:39 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id F1EFE1834898;
	Tue,  6 Aug 2024 18:47:37 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: vkoul@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 5/6] ASoC: fsl_asrc: register m2m platform device
Date: Tue,  6 Aug 2024 18:26:42 +0800
Message-Id: <1722940003-20126-6-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1722940003-20126-1-git-send-email-shengjiu.wang@nxp.com>
References: <1722940003-20126-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Register m2m platform device, that user can
use M2M feature.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_asrc.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 01e3af5b1bea..5d88abd905a5 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -1381,6 +1381,12 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 		goto err_pm_get_sync;
 	}
 
+	ret = fsl_asrc_m2m_init(asrc);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to init m2m device %d\n", ret);
+		return ret;
+	}
+
 	return 0;
 
 err_pm_get_sync:
@@ -1393,6 +1399,10 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 
 static void fsl_asrc_remove(struct platform_device *pdev)
 {
+	struct fsl_asrc *asrc = dev_get_drvdata(&pdev->dev);
+
+	fsl_asrc_m2m_exit(asrc);
+
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		fsl_asrc_runtime_suspend(&pdev->dev);
@@ -1494,10 +1504,29 @@ static int fsl_asrc_runtime_suspend(struct device *dev)
 	return 0;
 }
 
+static int fsl_asrc_suspend(struct device *dev)
+{
+	struct fsl_asrc *asrc = dev_get_drvdata(dev);
+	int ret;
+
+	fsl_asrc_m2m_suspend(asrc);
+	ret = pm_runtime_force_suspend(dev);
+	return ret;
+}
+
+static int fsl_asrc_resume(struct device *dev)
+{
+	struct fsl_asrc *asrc = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_force_resume(dev);
+	fsl_asrc_m2m_resume(asrc);
+	return ret;
+}
+
 static const struct dev_pm_ops fsl_asrc_pm = {
-	SET_RUNTIME_PM_OPS(fsl_asrc_runtime_suspend, fsl_asrc_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
+	RUNTIME_PM_OPS(fsl_asrc_runtime_suspend, fsl_asrc_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(fsl_asrc_suspend, fsl_asrc_resume)
 };
 
 static const struct fsl_asrc_soc_data fsl_asrc_imx35_data = {
@@ -1535,7 +1564,7 @@ static struct platform_driver fsl_asrc_driver = {
 	.driver = {
 		.name = "fsl-asrc",
 		.of_match_table = fsl_asrc_ids,
-		.pm = &fsl_asrc_pm,
+		.pm = pm_ptr(&fsl_asrc_pm),
 	},
 };
 module_platform_driver(fsl_asrc_driver);
-- 
2.34.1


