Return-Path: <linux-kernel+bounces-265917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DED93F7AD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 183BC1F22488
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645E818754F;
	Mon, 29 Jul 2024 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GmfMwSrm"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6446B16E895;
	Mon, 29 Jul 2024 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262892; cv=none; b=DOnG5JrOwZpHsPjeWFGPNnS6zhx3i5B5LxJtp0ioSNkoDZVXF6DFY75qnaXahOHrrf/NqhxwguO6lWJoYl7SoR+wbjob9j2iAeZfCAoOWKkHp6efiL5MRJ6WGPuPqGlsPxRaBcYdQ7A1K0SeHH30KGlEOSXs/i5jtxJc3smkcLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262892; c=relaxed/simple;
	bh=GKkfyc4hjyRdwPY0DtvO6HF/PkMY18v3bIsnth4Ixy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1bQnKyqtRLqt3iFIoIzxCpDMp4orueQv01YbSsXwN9LeQgw0m4qg/Unp4u8yC5EEdnpAS+54lPWs6VQNLiT0MJbKRMKDEr4suRQUZf1yB/wDzis/buj7em+Ch4pBNzyWs1NY7QO7J86mJRTvjhV+RvPvxlqxEw+VaQfH7bS/bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GmfMwSrm; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 56E5D240012;
	Mon, 29 Jul 2024 14:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722262889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PujWEEqVrHtZSSAKi2FwKGenicKUYocXZABNhblP/pE=;
	b=GmfMwSrmUzjKDB2KO2si9H0exlkk+DtbTzD1Bxm7JRKX55Qp5GnuJ0Y8h1DfD+jFFNyI3I
	LbLDBM6PFs+xN1aplU80g07MQzZPazP1t7aQxFxYqv2qGxNBFq31PmsNdpq+Rl9/VsB3Sb
	5n9DNkIi6aenRrUL1wdbxgopjCdeoxr88b5j/d/S2sLuJUO1HWdqIc3bcHFI8yqA9mkbE9
	HfNSy6f4VCbi7K6kKVLOznyjBycD86WJml27Wfyd+inO4Ixtebw7JRRdW+Mzw/f7xOuIuo
	U37UDoxwk+byK8kgBBIOeAk1HTcW8kY/Jxjn/ILLS77g76o6uvcSgk1aLCn74Q==
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
Subject: [PATCH v1 19/36] soc: fsl: cpm1: qmc: Fix blank line and spaces
Date: Mon, 29 Jul 2024 16:20:48 +0200
Message-ID: <20240729142107.104574-20-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240729142107.104574-1-herve.codina@bootlin.com>
References: <20240729142107.104574-1-herve.codina@bootlin.com>
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


