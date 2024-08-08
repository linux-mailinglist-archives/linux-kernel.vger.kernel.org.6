Return-Path: <linux-kernel+bounces-278989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B2994B76E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 344D8286743
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBAC18EFC8;
	Thu,  8 Aug 2024 07:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JicI+5bd"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0A618DF91;
	Thu,  8 Aug 2024 07:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101123; cv=none; b=mmLVzTV1UkVfwXh6KgXJbWNOc49SFXOJB/Dv8Ca6H/XWla3y7Bsi7kjADobQzkZVQKKdnFY1VaYzoVja4nRINkgwNcYUYSjt/xZJfA9R291053DoKs1Re5kGDl2te4MyssDBLSswT8sHu/n4zOaGmoVZ2kiVSZ3K0vD800Ihi1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101123; c=relaxed/simple;
	bh=lQwww2sMG43GN3dpVyBvKu0qUAv07i/VR3RHC+yfQ/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1TZ4UGRhpMRbSmjYMEpVRwfuDI2sPF1nhWaE92cwkBn2CxTodO9u/SbtaZ0sgBcRsqzi1rkd0XaIWFeq0eOaPgQqDWjAoMahf6HfdcMKQC1eZE3Q4f4qKJbpx/OqgwB9itgRhhMs4lPvk7ynGubMoOQsy9CtwkkYVil20mhxik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JicI+5bd; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id C163AC0009;
	Thu,  8 Aug 2024 07:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723101119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q0ALEqS0/8Af8b8qGfb/mhvY12MduAyn1Em0H/DF/dY=;
	b=JicI+5bdD7ifuOqelm49xP3TdT/oZe1Emn6j28/9NHUlcq3BLH+MYNR0xXJ27DQwelxuEp
	0yMnlQIIMG+Grtq8Y6Px2T5jtDhM23tkSYZtswGcOXVF7lxTXddfGM2KWsvf97i9Ju589E
	Uk02yq4vGn7xoG5GMnvOI+rQEt/+Kzb+Qryw6pi/y3LwSa+gsK7Ne1h7Kc7AzrGl41OUCd
	timNcaCv5uUQSGabNVzbHc5hqfsTAtor86iS3Cj87syv0ScFca/AvMszJcnxWN/GOdrn+M
	dPPRNXmNmerO/EgzJ0wGiFYYH5/Afb7fjrE0uZNa+nG/5kXWkEWXogfpR4lL+w==
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
Subject: [PATCH v2 27/36] soc: fsl: cpm1: qmc: Introduce qmc_{init,exit}_xcc() and their CPM1 version
Date: Thu,  8 Aug 2024 09:11:20 +0200
Message-ID: <20240808071132.149251-28-herve.codina@bootlin.com>
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

Current code handles the CPM1 version of QMC and initialize the QMC used
SCC. The QUICC Engine (QE) version uses an UCC (Unified Communication
Controllers) instead of the SCC (Serial Communication Controllers) used
in the CPM1 version. These controllers serve the same purpose and are
used in the same way but their inializations are slightly different.

In order to prepare the support for QE version of QMC, introduce
qmc_init_xcc() to initialize theses controllers (UCC in QE and SCC in
CPM1) and isolate the CPM1 specific SCC initialization in a specific
function.

Also introduce qmc_exit_xcc() for consistency to revert operations done
in qmc_init_xcc().

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/qmc.c | 66 +++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 21 deletions(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index eacc7dd2be53..b95227378f97 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -1621,6 +1621,41 @@ static int qmc_init_resources(struct qmc *qmc, struct platform_device *pdev)
 	return qmc_cpm1_init_resources(qmc, pdev);
 }
 
+static int qmc_cpm1_init_scc(struct qmc *qmc)
+{
+	u32 val;
+	int ret;
+
+	/* Connect the serial (SCC) to TSA */
+	ret = tsa_serial_connect(qmc->tsa_serial);
+	if (ret)
+		return dev_err_probe(qmc->dev, ret, "Failed to connect TSA serial\n");
+
+	/* Init GMSR_H and GMSR_L registers */
+	val = SCC_GSMRH_CDS | SCC_GSMRH_CTSS | SCC_GSMRH_CDP | SCC_GSMRH_CTSP;
+	qmc_write32(qmc->scc_regs + SCC_GSMRH, val);
+
+	/* enable QMC mode */
+	qmc_write32(qmc->scc_regs + SCC_GSMRL, SCC_GSMRL_MODE_QMC);
+
+	/* Disable and clear interrupts */
+	qmc_write16(qmc->scc_regs + SCC_SCCM, 0x0000);
+	qmc_write16(qmc->scc_regs + SCC_SCCE, 0x000F);
+
+	return 0;
+}
+
+static int qmc_init_xcc(struct qmc *qmc)
+{
+	return qmc_cpm1_init_scc(qmc);
+}
+
+static void qmc_exit_xcc(struct qmc *qmc)
+{
+	/* Disconnect the serial from TSA */
+	tsa_serial_disconnect(qmc->tsa_serial);
+}
+
 static int qmc_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -1711,29 +1746,18 @@ static int qmc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/* Connect the serial (SCC) to TSA */
-	ret = tsa_serial_connect(qmc->tsa_serial);
-	if (ret) {
-		dev_err(qmc->dev, "Failed to connect TSA serial\n");
+	/* Init SCC */
+	ret = qmc_init_xcc(qmc);
+	if (ret)
 		return ret;
-	}
 
-	/* Init GMSR_H and GMSR_L registers */
-	qmc_write32(qmc->scc_regs + SCC_GSMRH,
-		    SCC_GSMRH_CDS | SCC_GSMRH_CTSS | SCC_GSMRH_CDP | SCC_GSMRH_CTSP);
-
-	/* enable QMC mode */
-	qmc_write32(qmc->scc_regs + SCC_GSMRL, SCC_GSMRL_MODE_QMC);
-
-	/* Disable and clear interrupts,  set the irq handler */
-	qmc_write16(qmc->scc_regs + SCC_SCCM, 0x0000);
-	qmc_write16(qmc->scc_regs + SCC_SCCE, 0x000F);
+	/* Set the irq handler */
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-		goto err_tsa_serial_disconnect;
+		goto err_exit_xcc;
 	ret = devm_request_irq(qmc->dev, irq, qmc_irq_handler, 0, "qmc", qmc);
 	if (ret < 0)
-		goto err_tsa_serial_disconnect;
+		goto err_exit_xcc;
 
 	/* Enable interrupts */
 	qmc_write16(qmc->scc_regs + SCC_SCCM,
@@ -1761,8 +1785,8 @@ static int qmc_probe(struct platform_device *pdev)
 err_disable_intr:
 	qmc_write16(qmc->scc_regs + SCC_SCCM, 0);
 
-err_tsa_serial_disconnect:
-	tsa_serial_disconnect(qmc->tsa_serial);
+err_exit_xcc:
+	qmc_exit_xcc(qmc);
 	return ret;
 }
 
@@ -1776,8 +1800,8 @@ static void qmc_remove(struct platform_device *pdev)
 	/* Disable interrupts */
 	qmc_write16(qmc->scc_regs + SCC_SCCM, 0);
 
-	/* Disconnect the serial from TSA */
-	tsa_serial_disconnect(qmc->tsa_serial);
+	/* Exit SCC */
+	qmc_exit_xcc(qmc);
 }
 
 static const struct qmc_data qmc_data_cpm1 = {
-- 
2.45.0


