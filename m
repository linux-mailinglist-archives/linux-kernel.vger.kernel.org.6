Return-Path: <linux-kernel+bounces-265927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B8193F7C5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 387631C20A96
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A0918D4A4;
	Mon, 29 Jul 2024 14:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bU3JUNgk"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485BF155342;
	Mon, 29 Jul 2024 14:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262899; cv=none; b=GwzWsnYq4rtKCWulXHz/HB5+COhi80dgo86NwNmc8/DaR1DinV7FFrpW95JyL1Cwr+zI88N6yjdwip5I5ZrbneGi5mopyzUeXD/3YIEI3cM/RDM195Z18sTJ5tASsD2A/aTxg/46/gj7NYoYmI28xQAwXj+HKtfpcX7VOPQeCfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262899; c=relaxed/simple;
	bh=r1/o0ZpD2s4W36oH1G6fvDGnRurZP3VHkF0V9MGkaAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FR5lWtyhR/U6FZgqC073uRw+7nQRuWmyTxaFnX3ycFHbquAVK1Mkwd6G05a8zU8GMs1s+4KavEco5ABxuRQYH+z7kvR2lhpMHUsh4t7Fhth9u3gDCZ3lHJf5jbYDfQdo9T9KPTlgA+yexTHCtD+LCbskh7+MSj9AaR2pN9QlnvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bU3JUNgk; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 7689B24000E;
	Mon, 29 Jul 2024 14:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722262896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ns1shNAo8zEhYUmPszlirWDSVtM9okYPzpFYT+pVz24=;
	b=bU3JUNgkUqlPbva+MXU/zy03oMGduuv8HCfdDpHuhWLsxfmKt8R7+/fkPzomjdJR4ldOcA
	s9hMJyDCmz8Jgyu+MCCShzE+KGMdqhNu04MAvjUZfegG7KDoG5J2HtqpMeTT020fVODxSt
	3KVe6ASotboK2wxWrqcrAZubbvShOlcsLg5klpd6/Tl2u6dCumawkOI29E27/XGiGdcDHC
	Jz1ZmUb7K920ZdODD8EL2wCA14tCFdrrhPRwr6T5QIfqs5ZVi1nDD1ZEJljgWnnII+gblg
	TEk35pAl1Lz/LXF1OLmRdMRlJgHZrZpDUPAg9Z5iIBmCApvq0hEj0LXr1MYgzg==
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
Subject: [PATCH v1 29/36] soc: fsl: cpm1: qmc: Handle RPACK initialization
Date: Mon, 29 Jul 2024 16:20:58 +0200
Message-ID: <20240729142107.104574-30-herve.codina@bootlin.com>
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


