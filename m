Return-Path: <linux-kernel+bounces-278982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFFC94B759
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB15C2865B5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680F718C929;
	Thu,  8 Aug 2024 07:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Pgf5Qw6D"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1E018A934;
	Thu,  8 Aug 2024 07:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101117; cv=none; b=a00MYXxSgDpUN7MXjZMm6NSmqubq7/6UohHAtetvhMneZJUwcDm94+9Wq042TJ4qb/avoFrAcDvrzZzwACskoSrboPoNxwgYJzQemsv82V+3s7lJgIbib8Euvz1AxkcrNeJqpOaGfAToJpOdMNDVNsuiZcHDbJDMbA2dB77ScFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101117; c=relaxed/simple;
	bh=RuyLvw/h+OQQyELNwgwUqFWsLnM0a4DzBBIRdu/rvnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYe3tvR1b0zXs0pBIWtmbcHRzNcbuc1FsVFheR/BcTuzgVU6FIzXBy1qIfYv9eGpnV3y52rBRhcDbz4m5G/YQ6HqfasTSu/BK+ACgJdl0ecXXmrKP9MM+r9VTN9YVghcEa5zM/joG7KP1qPdM20O7NjdByH+VTEvWpuA4+NtA5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Pgf5Qw6D; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 603F2C0004;
	Thu,  8 Aug 2024 07:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723101114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FjqvInV++CElrxkmHy5Fprr8fbtF8RDwM+F8J2U6FCo=;
	b=Pgf5Qw6DP4Nb2S9kBDwXwOYAsOIn6OxZSGWjYy5qWu5+GyyFURmbxhKuYUfsAKAOK3N3mZ
	DcI9soaRI6zULMiU8yJSrDG7jDG4Dy5Yb4qzq0crwLDLQRxuUeZkddmykalom9c/GojClx
	ljqPQkb9xAftkoyzBCyMdtByuWAvfSnaUkqSsWNOlZmy5KpPAG9qveL6IYNtryWF+0Tv9e
	Hm4QdcuZv53Xghq43l/CaOnHy88oSfQ6BzEDyIT2NIQ2y0KpyKq/aUkKl2/jZwtyU7MA5O
	gl7TFhe/hwTdi6UGJkENy+kmGrRBZl51aOeL0Cn96r+oukBE2ouy1p3Y3NCNRg==
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
Subject: [PATCH v2 20/36] soc: fsl: cpm1: qmc: Remove unneeded parenthesis
Date: Thu,  8 Aug 2024 09:11:13 +0200
Message-ID: <20240808071132.149251-21-herve.codina@bootlin.com>
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


