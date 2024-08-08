Return-Path: <linux-kernel+bounces-278981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 854B294B757
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B70CE1C23051
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A0018C919;
	Thu,  8 Aug 2024 07:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jmH/p9dc"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC6018A6C0;
	Thu,  8 Aug 2024 07:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101117; cv=none; b=LHIphoT6+r3fsTgCiVYRY1PQyec/mFqizNjFfdflOnV1cwSWKj7NZanfB6T27H9o801dMIMcWkIH9QWfCO8rLFFJdnowTFQC/Su3m+ww1hxs9vRfyPaylLI2x/FxP0/iYPxML3UYCUte9TXIKRsF9E60wVLAusD/L4jFdht36x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101117; c=relaxed/simple;
	bh=GKkfyc4hjyRdwPY0DtvO6HF/PkMY18v3bIsnth4Ixy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=esjKaXHkdtCCVB1luxt0mOHogrh6NbqYiuAPWNq0zU5UvqTUNS8jhrSnNUL5POdDXLMSKyMZ71E3qCHi8O0nDJrOv5fWA3G1rl6fyIWT97FUbU8SSYUaKEQGHxwwwgU4/csngUOlIBhAj3jMmz8xabc/NbPHmtqaUO0lSUSsqwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jmH/p9dc; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 9DDF2C000B;
	Thu,  8 Aug 2024 07:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723101113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PujWEEqVrHtZSSAKi2FwKGenicKUYocXZABNhblP/pE=;
	b=jmH/p9dcVg+hH1/DKo62k72CzWiJoK/TyyYOI8qT6qXNNQfg+WySuJHrUBlGKETRG98v5t
	mtrw3MKTI/KYaJj4TmfH75arD8yhOf6g67Wzx7mMnAB8KargQuB721Q0+R4j6uFGvjB+/S
	FeUBDJs1QPMT8r9m/JHAh2vtFGz/D9EfLnrgdS3E7Off64Uktdsm4PC+3hbIFAxIhw6cHJ
	DtwOYtBmosk+ijjilIIB7NSLvRSxaWrhmQJC5LOpUMwVuDDbOKNezVuFEhWgeU14iD1vo0
	D12EqV/RA9oyJwJFjuqZHEVuDnfhDhk+7fAGvi+u3cgNf3a1O9mk+PLodKug2A==
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
Subject: [PATCH v2 19/36] soc: fsl: cpm1: qmc: Fix blank line and spaces
Date: Thu,  8 Aug 2024 09:11:12 +0200
Message-ID: <20240808071132.149251-20-herve.codina@bootlin.com>
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

checkpatch.pl raises the following issues
  CHECK: Please don't use multiple blank lines
  CHECK: Alignment should match open parenthesis

Fix them.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/qmc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index e2ac3e59bb79..44bd9b949770 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -274,7 +274,6 @@ static void qmc_setbits32(void __iomem *addr, u32 set)
 	qmc_write32(addr, qmc_read32(addr) | set);
 }
 
-
 int qmc_chan_get_info(struct qmc_chan *chan, struct qmc_chan_info *info)
 {
 	struct tsa_serial_info tsa_info;
@@ -1411,7 +1410,7 @@ static int qmc_setup_chan(struct qmc *qmc, struct qmc_chan *chan)
 		qmc_write32(chan->s_param + QMC_SPE_ZDSTATE, 0x00000080);
 		qmc_write16(chan->s_param + QMC_SPE_MFLR, 60);
 		qmc_write16(chan->s_param + QMC_SPE_CHAMR,
-			QMC_SPE_CHAMR_MODE_HDLC | QMC_SPE_CHAMR_HDLC_IDLM);
+			    QMC_SPE_CHAMR_MODE_HDLC | QMC_SPE_CHAMR_HDLC_IDLM);
 	}
 
 	/* Do not enable interrupts now. They will be enabled later */
@@ -1604,7 +1603,6 @@ static int qmc_probe(struct platform_device *pdev)
 	if (IS_ERR(qmc->scc_regs))
 		return PTR_ERR(qmc->scc_regs);
 
-
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "scc_pram");
 	if (!res)
 		return -EINVAL;
@@ -1650,7 +1648,7 @@ static int qmc_probe(struct platform_device *pdev)
 	 */
 	qmc->bd_size = (nb_chans * (QMC_NB_TXBDS + QMC_NB_RXBDS)) * sizeof(cbd_t);
 	qmc->bd_table = dmam_alloc_coherent(qmc->dev, qmc->bd_size,
-		&qmc->bd_dma_addr, GFP_KERNEL);
+					    &qmc->bd_dma_addr, GFP_KERNEL);
 	if (!qmc->bd_table) {
 		dev_err(qmc->dev, "Failed to allocate bd table\n");
 		ret = -ENOMEM;
@@ -1663,7 +1661,7 @@ static int qmc_probe(struct platform_device *pdev)
 	/* Allocate the interrupt table */
 	qmc->int_size = QMC_NB_INTS * sizeof(u16);
 	qmc->int_table = dmam_alloc_coherent(qmc->dev, qmc->int_size,
-		&qmc->int_dma_addr, GFP_KERNEL);
+					     &qmc->int_dma_addr, GFP_KERNEL);
 	if (!qmc->int_table) {
 		dev_err(qmc->dev, "Failed to allocate interrupt table\n");
 		ret = -ENOMEM;
@@ -1711,7 +1709,7 @@ static int qmc_probe(struct platform_device *pdev)
 
 	/* Enable interrupts */
 	qmc_write16(qmc->scc_regs + SCC_SCCM,
-		SCC_SCCE_IQOV | SCC_SCCE_GINT | SCC_SCCE_GUN | SCC_SCCE_GOV);
+		    SCC_SCCE_IQOV | SCC_SCCE_GINT | SCC_SCCE_GUN | SCC_SCCE_GOV);
 
 	ret = qmc_finalize_chans(qmc);
 	if (ret < 0)
-- 
2.45.0


