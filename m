Return-Path: <linux-kernel+bounces-278985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4CE94B761
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19E0D286D83
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5DF189BBE;
	Thu,  8 Aug 2024 07:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eeSe8PTP"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8599218C92A;
	Thu,  8 Aug 2024 07:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101120; cv=none; b=e/TnKC9cFjAUubaiBNqqvFNdVwuOt2aRi6I1jtVlHsL6X7JROusQWtGTiiYgl1bzEp2Am0Bz9qQtQJaVmMRbGiC94EyP2RKnLyDA5VAJLqUOlpHXnrN/YibQf062OUVJkmYS2W11L2kattDJEvmG9DBG3dFrpFcAQg6Oj1BXt2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101120; c=relaxed/simple;
	bh=BOxdAJwKbtckHb9i20QEJKhExlzOMGgeudSAupoZLeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQ1yn+y8wip1TD3N/ZMGhoVLr+Yy54qbYFAL077NYZeApajy1wXMhX6rmTBfnjcJj3Aavo7ILVOMY8yBoD6eNL1YRk6yxNhYpWi7MOVjz3T88rsEfKOffku4cfvY+g0z3Q7KUFl273hjg5IHf03y8qhCBkz259LxvlD1cBDFOzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eeSe8PTP; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 76184C0005;
	Thu,  8 Aug 2024 07:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723101117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QMfEiRmSRkX/pBoCz01B9PXrobVJrcp4KetogWxNR/M=;
	b=eeSe8PTPXkafLDHJvAu2phzDE3jdJhcH2qG41WYx1a54Bq1624AlDE1GYIgEu0M/vaG5Ik
	DOnzERj4C5MPCPq4XftgbhPRIUOj1aVHW8SAl3HhJ2W5PIR9/gHyapKNfyyQjH8O+Xsa9B
	hbBj8Ul8m4yxQ2haqVKXhWYszRmQMR5nHTqEK/F7jkVz/COmi1Y0/5bcWFfEVXuDWkwZL5
	E5kI4lt8xyQfPEQREcOBf/q3rkHTGquExuLEb5y2CaB8DiS1Ji43nXyjweUjwEosNsb43S
	urJ2phrz8xrVxGGYsafWv7EHiI4/2zXk7fYv4wbChgLP5WIxAw2etJNCwOQHiw==
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
Subject: [PATCH v2 24/36] soc: fsl: cpm1: qmc: Introduce qmc_data structure
Date: Thu,  8 Aug 2024 09:11:17 +0200
Message-ID: <20240808071132.149251-25-herve.codina@bootlin.com>
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

Current code handles CPM1 version of QMC. Some hardcoded values are used
several times to initialize the QMC state machine. In the QUICC Engine
(QE) version of QMC, these values are different.

In order to prepare the support for the QE version of QMC and avoid the
copy of the hardcoded values, introduce the qmc_data structure to define
these version specific values.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/qmc.c | 69 ++++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 23 deletions(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index 3736a8e4575e..85fc86f91806 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -215,8 +215,17 @@ struct qmc_chan {
 	bool	is_rx_stopped;
 };
 
+struct qmc_data {
+	u32 tstate; /* Initial TSTATE value */
+	u32 rstate; /* Initial RSTATE value */
+	u32 zistate; /* Initial ZISTATE value */
+	u32 zdstate_hdlc; /* Initial ZDSTATE value (HDLC mode) */
+	u32 zdstate_transp; /* Initial ZDSTATE value (Transparent mode) */
+};
+
 struct qmc {
 	struct device *dev;
+	const struct qmc_data *data;
 	struct tsa_serial *tsa_serial;
 	void __iomem *scc_regs;
 	void __iomem *scc_pram;
@@ -543,11 +552,11 @@ int qmc_chan_read_submit(struct qmc_chan *chan, dma_addr_t addr, size_t length,
 	/* Restart receiver if needed */
 	if (chan->is_rx_halted && !chan->is_rx_stopped) {
 		/* Restart receiver */
-		if (chan->mode == QMC_TRANSPARENT)
-			qmc_write32(chan->s_param + QMC_SPE_ZDSTATE, 0x18000080);
-		else
-			qmc_write32(chan->s_param + QMC_SPE_ZDSTATE, 0x00000080);
-		qmc_write32(chan->s_param + QMC_SPE_RSTATE, 0x31000000);
+		qmc_write32(chan->s_param + QMC_SPE_ZDSTATE,
+			    chan->mode == QMC_TRANSPARENT ?
+				chan->qmc->data->zdstate_transp :
+				chan->qmc->data->zdstate_hdlc);
+		qmc_write32(chan->s_param + QMC_SPE_RSTATE, chan->qmc->data->rstate);
 		chan->is_rx_halted = false;
 	}
 	chan->rx_pending++;
@@ -971,11 +980,11 @@ static int qmc_chan_start_rx(struct qmc_chan *chan)
 	}
 
 	/* Restart the receiver */
-	if (chan->mode == QMC_TRANSPARENT)
-		qmc_write32(chan->s_param + QMC_SPE_ZDSTATE, 0x18000080);
-	else
-		qmc_write32(chan->s_param + QMC_SPE_ZDSTATE, 0x00000080);
-	qmc_write32(chan->s_param + QMC_SPE_RSTATE, 0x31000000);
+	qmc_write32(chan->s_param + QMC_SPE_ZDSTATE,
+		    chan->mode == QMC_TRANSPARENT ?
+			chan->qmc->data->zdstate_transp :
+			chan->qmc->data->zdstate_hdlc);
+	qmc_write32(chan->s_param + QMC_SPE_RSTATE, chan->qmc->data->rstate);
 	chan->is_rx_halted = false;
 
 	chan->is_rx_stopped = false;
@@ -1121,8 +1130,8 @@ static void qmc_chan_reset_tx(struct qmc_chan *chan)
 		    qmc_read16(chan->s_param + QMC_SPE_TBASE));
 
 	/* Reset TSTATE and ZISTATE to their initial value */
-	qmc_write32(chan->s_param + QMC_SPE_TSTATE, 0x30000000);
-	qmc_write32(chan->s_param + QMC_SPE_ZISTATE, 0x00000100);
+	qmc_write32(chan->s_param + QMC_SPE_TSTATE, chan->qmc->data->tstate);
+	qmc_write32(chan->s_param + QMC_SPE_ZISTATE, chan->qmc->data->zistate);
 
 	spin_unlock_irqrestore(&chan->tx_lock, flags);
 }
@@ -1393,11 +1402,11 @@ static int qmc_setup_chan(struct qmc *qmc, struct qmc_chan *chan)
 	val = ((chan->id * (QMC_NB_TXBDS + QMC_NB_RXBDS)) + QMC_NB_TXBDS) * sizeof(cbd_t);
 	qmc_write16(chan->s_param + QMC_SPE_RBASE, val);
 	qmc_write16(chan->s_param + QMC_SPE_RBPTR, val);
-	qmc_write32(chan->s_param + QMC_SPE_TSTATE, 0x30000000);
-	qmc_write32(chan->s_param + QMC_SPE_RSTATE, 0x31000000);
-	qmc_write32(chan->s_param + QMC_SPE_ZISTATE, 0x00000100);
+	qmc_write32(chan->s_param + QMC_SPE_TSTATE, chan->qmc->data->tstate);
+	qmc_write32(chan->s_param + QMC_SPE_RSTATE, chan->qmc->data->rstate);
+	qmc_write32(chan->s_param + QMC_SPE_ZISTATE, chan->qmc->data->zistate);
 	if (chan->mode == QMC_TRANSPARENT) {
-		qmc_write32(chan->s_param + QMC_SPE_ZDSTATE, 0x18000080);
+		qmc_write32(chan->s_param + QMC_SPE_ZDSTATE, chan->qmc->data->zdstate_transp);
 		qmc_write16(chan->s_param + QMC_SPE_TMRBLR, 60);
 		val = QMC_SPE_CHAMR_MODE_TRANSP;
 		if (chan->is_reverse_data)
@@ -1407,7 +1416,7 @@ static int qmc_setup_chan(struct qmc *qmc, struct qmc_chan *chan)
 		if (ret)
 			return ret;
 	} else {
-		qmc_write32(chan->s_param + QMC_SPE_ZDSTATE, 0x00000080);
+		qmc_write32(chan->s_param + QMC_SPE_ZDSTATE, chan->qmc->data->zdstate_hdlc);
 		qmc_write16(chan->s_param + QMC_SPE_MFLR, 60);
 		qmc_write16(chan->s_param + QMC_SPE_CHAMR,
 			    QMC_SPE_CHAMR_MODE_HDLC | QMC_SPE_CHAMR_HDLC_IDLM);
@@ -1535,11 +1544,12 @@ static void qmc_irq_gint(struct qmc *qmc)
 			/* Restart the receiver if needed */
 			spin_lock_irqsave(&chan->rx_lock, flags);
 			if (chan->rx_pending && !chan->is_rx_stopped) {
-				if (chan->mode == QMC_TRANSPARENT)
-					qmc_write32(chan->s_param + QMC_SPE_ZDSTATE, 0x18000080);
-				else
-					qmc_write32(chan->s_param + QMC_SPE_ZDSTATE, 0x00000080);
-				qmc_write32(chan->s_param + QMC_SPE_RSTATE, 0x31000000);
+				qmc_write32(chan->s_param + QMC_SPE_ZDSTATE,
+					    chan->mode == QMC_TRANSPARENT ?
+						chan->qmc->data->zdstate_transp :
+						chan->qmc->data->zdstate_hdlc);
+				qmc_write32(chan->s_param + QMC_SPE_RSTATE,
+					    chan->qmc->data->rstate);
 				chan->is_rx_halted = false;
 			} else {
 				chan->is_rx_halted = true;
@@ -1597,6 +1607,11 @@ static int qmc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	qmc->dev = &pdev->dev;
+	qmc->data = of_device_get_match_data(&pdev->dev);
+	if (!qmc->data) {
+		dev_err(qmc->dev, "Missing match data\n");
+		return -EINVAL;
+	}
 	INIT_LIST_HEAD(&qmc->chan_head);
 
 	qmc->scc_regs = devm_platform_ioremap_resource_byname(pdev, "scc_regs");
@@ -1752,8 +1767,16 @@ static void qmc_remove(struct platform_device *pdev)
 	tsa_serial_disconnect(qmc->tsa_serial);
 }
 
+static const struct qmc_data qmc_data_cpm1 = {
+	.tstate = 0x30000000,
+	.rstate = 0x31000000,
+	.zistate = 0x00000100,
+	.zdstate_hdlc = 0x00000080,
+	.zdstate_transp = 0x18000080,
+};
+
 static const struct of_device_id qmc_id_table[] = {
-	{ .compatible = "fsl,cpm1-scc-qmc" },
+	{ .compatible = "fsl,cpm1-scc-qmc", .data = &qmc_data_cpm1 },
 	{} /* sentinel */
 };
 MODULE_DEVICE_TABLE(of, qmc_id_table);
-- 
2.45.0


