Return-Path: <linux-kernel+bounces-265919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2624093F7B4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05851F20FC2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFA7188CAF;
	Mon, 29 Jul 2024 14:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="blT9bINO"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABF0186E2E;
	Mon, 29 Jul 2024 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262894; cv=none; b=IC1ZdKW/br53l7pRdeRa4oXPuLnPmokogo96QR0jE7MZL1AtF/q6R6LDiSkKZY1cVDJXURu+iLOEdsiCZv7owkWZsN9wONSdMaw4464rPvXC02TsjfweNp31VzK7uHrm58iBkIAi62QohVbd4YSMNdpGCpZObzbmIak5MDlWgP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262894; c=relaxed/simple;
	bh=RuyLvw/h+OQQyELNwgwUqFWsLnM0a4DzBBIRdu/rvnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ntEplR8gcMQv4DCCarEBfMHqW4aihi1RfTCbhVBZ3lPp/PR3M3ETUas0PlxJ7l62M7w8s0ULXl/9vE2i6S6B/ACVaWU9JK4cs1+e1YpVMN27pgzO9y3CPL1zodb8RZyd4hvrY4Ksf7GKtacGK/LmAYUAqrJLy4gZCyzpFOUO+Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=blT9bINO; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 20A06240009;
	Mon, 29 Jul 2024 14:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722262889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FjqvInV++CElrxkmHy5Fprr8fbtF8RDwM+F8J2U6FCo=;
	b=blT9bINO0h9Sj/5UKq8Mw6GMNM9k7Gk1dFojZrr8xeE79IMXP6NDEbdpw6a6Re4iCy1Mtp
	Um6oDqA7/qXTFnZy3OlcTjuumS1fMxU9KTcBWZo8oVRvAv8TQ/OlsFiP/1lvYePxRqVUC3
	kfaQTNLa/DFfOQFXaq5ZNSPfTFqyP1e93iKGWeLjgfbikqGApjsT3CNXtCRa9R66v40Djx
	Nl/fLi2KEimx3o4QG0gwy4ZO/noFQ6DFOdkviKDVNRgQCBurUKk86e3278ZjcikK8EWz5H
	IrlCFyfumX3GDAmFe/34iTOhcqMvIykiIVm5ttnmJmunHqd41lMNFuRpKXT+yA==
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
Subject: [PATCH v1 20/36] soc: fsl: cpm1: qmc: Remove unneeded parenthesis
Date: Mon, 29 Jul 2024 16:20:49 +0200
Message-ID: <20240729142107.104574-21-herve.codina@bootlin.com>
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

checkpatch.pl raises the following issue in several places
  CHECK: Unnecessary parenthesis around ...

Remove them.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/qmc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index 44bd9b949770..04466e735302 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -359,8 +359,8 @@ int qmc_chan_set_param(struct qmc_chan *chan, const struct qmc_chan_param *param
 
 	switch (param->mode) {
 	case QMC_HDLC:
-		if ((param->hdlc.max_rx_buf_size % 4) ||
-		    (param->hdlc.max_rx_buf_size < 8))
+		if (param->hdlc.max_rx_buf_size % 4 ||
+		    param->hdlc.max_rx_buf_size < 8)
 			return -EINVAL;
 
 		qmc_write16(chan->qmc->scc_pram + QMC_GBL_MRBLR,
@@ -1152,7 +1152,7 @@ static int qmc_check_chans(struct qmc *qmc)
 	if (ret)
 		return ret;
 
-	if ((info.nb_tx_ts > 64) || (info.nb_rx_ts > 64)) {
+	if (info.nb_tx_ts > 64 || info.nb_rx_ts > 64) {
 		dev_err(qmc->dev, "Number of TSA Tx/Rx TS assigned not supported\n");
 		return -EINVAL;
 	}
@@ -1161,7 +1161,7 @@ static int qmc_check_chans(struct qmc *qmc)
 	 * If more than 32 TS are assigned to this serial, one common table is
 	 * used for Tx and Rx and so masks must be equal for all channels.
 	 */
-	if ((info.nb_tx_ts > 32) || (info.nb_rx_ts > 32)) {
+	if (info.nb_tx_ts > 32 || info.nb_rx_ts > 32) {
 		if (info.nb_tx_ts != info.nb_rx_ts) {
 			dev_err(qmc->dev, "Number of TSA Tx/Rx TS assigned are not equal\n");
 			return -EINVAL;
-- 
2.45.0


