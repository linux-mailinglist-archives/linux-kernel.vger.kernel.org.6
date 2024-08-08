Return-Path: <linux-kernel+bounces-278988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A192594B768
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BAD0286722
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EB918E75F;
	Thu,  8 Aug 2024 07:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WEAGftdR"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7291918CC0E;
	Thu,  8 Aug 2024 07:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101122; cv=none; b=t14z94lsa6bCMNndTR/jvApSW6fB99TFSiXZfuwwS3rm55U4bp2T9elxbfZ0F5DkdG6R424zu0Ince98NncEVzFY6Q1RvG6OIkzEPztCICjEuIDpvBUm1z78ttYmAS0FBCi0mBozj1yozaK1J79ow4wd+D7Go/v0uWTQD0Ys5yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101122; c=relaxed/simple;
	bh=LtqGl5AOuWL8E/8ipCCGCvyY7n4HvSCODe9qy2f3bvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+kHSEKt5pFFqNh4LMHCSydG80Qvtv801j3dRMRDAKCj0ieJYmKiIhQxgCNiYaMi/7uiYLgJcRsqL4t75MQmf/UKgSSr7jOcaMLrIw8+bktIF4Rxo5qdqGqeOkkjEAjX0Tdr4Zxl8oMG1BDU9r3WI5IFxL4c0g1Daukt+4hu+iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WEAGftdR; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 3BCD1C0008;
	Thu,  8 Aug 2024 07:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723101117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uj6MLd6KFTJCdXGfBKX12l8E7lzam+wSv5WhfHx4wCU=;
	b=WEAGftdRVIAHdJQ1N2ynPABMJJSFoQBOAg7rIRtoQ0ZbAy92S+ngpyq7NVpcvaJEW6tq3W
	Te8v4uBz0TtNmqn1LgMA/fX4CBNoOPNkxnBBTBbEfih9VWzxRsQ4aFO3nrc35DtA1HDYox
	RjkGS7tpHi3AoklfukNSVSWzkYySlYfe22hk6Y8MG5ywhwg43Nme8MShDc23QmyWa0jaFQ
	SPCOoZ7YrhyQPTKx4R0uIEptomep3Cv3TIl1QRQFUcV04P857yCZn/z0GGP74KDj0cuEDY
	0ASHkQnIArWM71n1/VNWOqJkBYPZv+cBq6Y0C1oR8CC56GJJAitcWLfDNLKwEw==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Li Yang <leoyang.li@nxp.com>,
	Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 25/36] soc: fsl: cpm1: qmc: Re-order probe() operations
Date: Thu,  8 Aug 2024 09:11:18 +0200
Message-ID: <20240808071132.149251-26-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240808071132.149251-1-herve.codina@bootlin.com>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Current code handles CPM1 version of QMC. In the QUICC Engine (QE)
version, some operations done at probe() need to be done in a different
order.

In order to prepare the support for the QE version, changed the sequence
of operation done at probe():
- Retrieve the tsa_serial earlier, before initializing resources.
- Group SCC initialisation and do this initialization when it is really
  needed in the probe() sequence.

Having the QE compatible sequence in the CPM1 version does not lead to
any issue and works correctly without any regressions.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/qmc.c | 54 +++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index 85fc86f91806..8dd0f8fc7b08 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -1614,6 +1614,12 @@ static int qmc_probe(struct platform_device *pdev)
 	}
 	INIT_LIST_HEAD(&qmc->chan_head);
 
+	qmc->tsa_serial = devm_tsa_serial_get_byphandle(qmc->dev, np, "fsl,tsa-serial");
+	if (IS_ERR(qmc->tsa_serial)) {
+		return dev_err_probe(qmc->dev, PTR_ERR(qmc->tsa_serial),
+				     "Failed to get TSA serial\n");
+	}
+
 	qmc->scc_regs = devm_platform_ioremap_resource_byname(pdev, "scc_regs");
 	if (IS_ERR(qmc->scc_regs))
 		return PTR_ERR(qmc->scc_regs);
@@ -1630,33 +1636,13 @@ static int qmc_probe(struct platform_device *pdev)
 	if (IS_ERR(qmc->dpram))
 		return PTR_ERR(qmc->dpram);
 
-	qmc->tsa_serial = devm_tsa_serial_get_byphandle(qmc->dev, np, "fsl,tsa-serial");
-	if (IS_ERR(qmc->tsa_serial)) {
-		return dev_err_probe(qmc->dev, PTR_ERR(qmc->tsa_serial),
-				     "Failed to get TSA serial\n");
-	}
-
-	/* Connect the serial (SCC) to TSA */
-	ret = tsa_serial_connect(qmc->tsa_serial);
-	if (ret) {
-		dev_err(qmc->dev, "Failed to connect TSA serial\n");
-		return ret;
-	}
-
 	/* Parse channels informationss */
 	ret = qmc_of_parse_chans(qmc, np);
 	if (ret)
-		goto err_tsa_serial_disconnect;
+		return ret;
 
 	nb_chans = qmc_nb_chans(qmc);
 
-	/* Init GMSR_H and GMSR_L registers */
-	qmc_write32(qmc->scc_regs + SCC_GSMRH,
-		    SCC_GSMRH_CDS | SCC_GSMRH_CTSS | SCC_GSMRH_CDP | SCC_GSMRH_CTSP);
-
-	/* enable QMC mode */
-	qmc_write32(qmc->scc_regs + SCC_GSMRL, SCC_GSMRL_MODE_QMC);
-
 	/*
 	 * Allocate the buffer descriptor table
 	 * 8 rx and 8 tx descriptors per channel
@@ -1666,8 +1652,7 @@ static int qmc_probe(struct platform_device *pdev)
 					    &qmc->bd_dma_addr, GFP_KERNEL);
 	if (!qmc->bd_table) {
 		dev_err(qmc->dev, "Failed to allocate bd table\n");
-		ret = -ENOMEM;
-		goto err_tsa_serial_disconnect;
+		return -ENOMEM;
 	}
 	memset(qmc->bd_table, 0, qmc->bd_size);
 
@@ -1679,8 +1664,7 @@ static int qmc_probe(struct platform_device *pdev)
 					     &qmc->int_dma_addr, GFP_KERNEL);
 	if (!qmc->int_table) {
 		dev_err(qmc->dev, "Failed to allocate interrupt table\n");
-		ret = -ENOMEM;
-		goto err_tsa_serial_disconnect;
+		return -ENOMEM;
 	}
 	memset(qmc->int_table, 0, qmc->int_size);
 
@@ -1699,18 +1683,32 @@ static int qmc_probe(struct platform_device *pdev)
 
 	ret = qmc_init_tsa(qmc);
 	if (ret)
-		goto err_tsa_serial_disconnect;
+		return ret;
 
 	qmc_write16(qmc->scc_pram + QMC_GBL_QMCSTATE, 0x8000);
 
 	ret = qmc_setup_chans(qmc);
 	if (ret)
-		goto err_tsa_serial_disconnect;
+		return ret;
 
 	/* Init interrupts table */
 	ret = qmc_setup_ints(qmc);
 	if (ret)
-		goto err_tsa_serial_disconnect;
+		return ret;
+
+	/* Connect the serial (SCC) to TSA */
+	ret = tsa_serial_connect(qmc->tsa_serial);
+	if (ret) {
+		dev_err(qmc->dev, "Failed to connect TSA serial\n");
+		return ret;
+	}
+
+	/* Init GMSR_H and GMSR_L registers */
+	qmc_write32(qmc->scc_regs + SCC_GSMRH,
+		    SCC_GSMRH_CDS | SCC_GSMRH_CTSS | SCC_GSMRH_CDP | SCC_GSMRH_CTSP);
+
+	/* enable QMC mode */
+	qmc_write32(qmc->scc_regs + SCC_GSMRL, SCC_GSMRL_MODE_QMC);
 
 	/* Disable and clear interrupts,  set the irq handler */
 	qmc_write16(qmc->scc_regs + SCC_SCCM, 0x0000);
-- 
2.45.0


