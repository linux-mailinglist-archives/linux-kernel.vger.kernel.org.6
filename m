Return-Path: <linux-kernel+bounces-278991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A3E94B772
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8739A1C235EA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610C418F2E3;
	Thu,  8 Aug 2024 07:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HhHKjZTN"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F5E18E740;
	Thu,  8 Aug 2024 07:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101124; cv=none; b=lGMJF6l2sXLS2jDYrGF89uiYoA/7zdrV02jdxIhGx2p/iZ/yKedXpFtEXy79Zk8cYgvXwv+a5jIVD06GBexQpaYEpodu605iTzSosZQCfbjEa4X9qEdZ9jmYhAV9V4ckA0J7AQNBkwZffh0ii/ijH4yRczQi7858GQKb5JASVRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101124; c=relaxed/simple;
	bh=r1/o0ZpD2s4W36oH1G6fvDGnRurZP3VHkF0V9MGkaAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OoHmaZEIai+NBQ4Xo7kFCOdIkSP6CMIbrEhKh3147cqRNZm7X1mlmXYzIsiREt/ei082B1HQANbIxyxfdUAvWO331RdM4JMoZv1x6Hf/y9yXqn/+rn88njA/bS24LOafmhV60pfmCGarp2yDh4rXE2r8V7YKKYnxgWNItGxXEds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HhHKjZTN; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 51B8AC000B;
	Thu,  8 Aug 2024 07:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723101120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ns1shNAo8zEhYUmPszlirWDSVtM9okYPzpFYT+pVz24=;
	b=HhHKjZTN3TIWxgS9BA+NzIJH9M0Nw1IJKYJ3QvoNPHSduDj0Na/SmlST0OLz7qYRiuX2PD
	3HOyFQiPPMnFnEufReTfQuPQ2U/CuW6FKWjpxr8SwTjljWAWRjqzP3yuuuft75lyzgTQK7
	zKGxCjYi09J7rP3bG2Vv3HE8xqzOzdHIYPz6okN6VIqVj6bJvoXu1eb4OHekfsSOBO7tY1
	idbrXx8U7sQGpegZ7pmXz9h+CR/E9IkkqTjoD4bhjQgAqgZnJJ3Qv8PApwBMa/VrkfuSYC
	6OU/Sn737ElhQ8S8GKpYkimjX3CJCf2fHuQKpgZM8vl+MO6sJT6wG0sr8wJCjQ==
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
Subject: [PATCH v2 29/36] soc: fsl: cpm1: qmc: Handle RPACK initialization
Date: Thu,  8 Aug 2024 09:11:22 +0200
Message-ID: <20240808071132.149251-30-herve.codina@bootlin.com>
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

Current code handles the CPM1 version of QMC, RPACK does not need to
be initialized. This is not the case in the QUICC Engine (QE) version.

In preparation of the support for QE, initialize the RPACK register
when the receiver is initialized and each time it is restarted.

This additional RPACK initialization has no impact in the CPM1 version
of QMC.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/qmc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index 272da250a763..63af2608c3cd 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -221,6 +221,7 @@ struct qmc_data {
 	u32 zistate; /* Initial ZISTATE value */
 	u32 zdstate_hdlc; /* Initial ZDSTATE value (HDLC mode) */
 	u32 zdstate_transp; /* Initial ZDSTATE value (Transparent mode) */
+	u32 rpack; /* Initial RPACK value */
 };
 
 struct qmc {
@@ -552,6 +553,7 @@ int qmc_chan_read_submit(struct qmc_chan *chan, dma_addr_t addr, size_t length,
 	/* Restart receiver if needed */
 	if (chan->is_rx_halted && !chan->is_rx_stopped) {
 		/* Restart receiver */
+		qmc_write32(chan->s_param + QMC_SPE_RPACK, chan->qmc->data->rpack);
 		qmc_write32(chan->s_param + QMC_SPE_ZDSTATE,
 			    chan->mode == QMC_TRANSPARENT ?
 				chan->qmc->data->zdstate_transp :
@@ -980,6 +982,7 @@ static int qmc_chan_start_rx(struct qmc_chan *chan)
 	}
 
 	/* Restart the receiver */
+	qmc_write32(chan->s_param + QMC_SPE_RPACK, chan->qmc->data->rpack);
 	qmc_write32(chan->s_param + QMC_SPE_ZDSTATE,
 		    chan->mode == QMC_TRANSPARENT ?
 			chan->qmc->data->zdstate_transp :
@@ -1405,6 +1408,7 @@ static int qmc_setup_chan(struct qmc *qmc, struct qmc_chan *chan)
 	qmc_write32(chan->s_param + QMC_SPE_TSTATE, chan->qmc->data->tstate);
 	qmc_write32(chan->s_param + QMC_SPE_RSTATE, chan->qmc->data->rstate);
 	qmc_write32(chan->s_param + QMC_SPE_ZISTATE, chan->qmc->data->zistate);
+	qmc_write32(chan->s_param + QMC_SPE_RPACK, chan->qmc->data->rpack);
 	if (chan->mode == QMC_TRANSPARENT) {
 		qmc_write32(chan->s_param + QMC_SPE_ZDSTATE, chan->qmc->data->zdstate_transp);
 		qmc_write16(chan->s_param + QMC_SPE_TMRBLR, 60);
@@ -1544,6 +1548,8 @@ static void qmc_irq_gint(struct qmc *qmc)
 			/* Restart the receiver if needed */
 			spin_lock_irqsave(&chan->rx_lock, flags);
 			if (chan->rx_pending && !chan->is_rx_stopped) {
+				qmc_write32(chan->s_param + QMC_SPE_RPACK,
+					    chan->qmc->data->rpack);
 				qmc_write32(chan->s_param + QMC_SPE_ZDSTATE,
 					    chan->mode == QMC_TRANSPARENT ?
 						chan->qmc->data->zdstate_transp :
@@ -1810,6 +1816,7 @@ static const struct qmc_data qmc_data_cpm1 = {
 	.zistate = 0x00000100,
 	.zdstate_hdlc = 0x00000080,
 	.zdstate_transp = 0x18000080,
+	.rpack = 0x00000000,
 };
 
 static const struct of_device_id qmc_id_table[] = {
-- 
2.45.0


