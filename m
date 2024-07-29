Return-Path: <linux-kernel+bounces-265905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A69993F78C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A7761C21E6F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DCF1598EE;
	Mon, 29 Jul 2024 14:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="P6VwFSKe"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A911553A7;
	Mon, 29 Jul 2024 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262885; cv=none; b=U5SPd1bscq+rZyAVyYqPSmwS1fvl/SUto/2TbJ51nVspfHJQHjSnf5lq7vls3iSERl5wu6SLyg2gN/J9jgaKrBp/KU9OeORFIWyzvBDtCZK7N+tJl1+h+M6YQnY63Yuj/5Y4v3sY387zH2748yjkhTskPrW3FULhL8V3R1+L+Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262885; c=relaxed/simple;
	bh=+NPBYd7bwIDLy9MPHMLKZ69cIM4+b+qR1ljLRdmToCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=li2TxtvbW76tUVWqTZaNOT5KHIDkRGQc9lIPUkQ3kuMbwKPnvDaY9PytDPspDhaSfAInC4fyrBqH9SjDXUYxLaymlg9e2omzcZKJdM7RtnfrCXwzOmCLlPAYFnZlKoY/FfT2/LuwigD1CT0BgNwHSBV5/HOs9aUrKGkBkLNebeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=P6VwFSKe; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 69F4024000E;
	Mon, 29 Jul 2024 14:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722262877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0UTWDzz2CSi9594bsioUgKxsyX0iygtz1joM8J6wTqE=;
	b=P6VwFSKeNFRSfHeZeDQlilHGy7HvfNNvRBUGGz5G2ghJ6QYYuNOxNc9KxoF2A9wggV60sp
	IstR9obpPlbrNbQqgyR6wAgj+hUQiePxAvur2b6Xb1t0gRefivdWpPjDxpF5hv7TwL9M3Y
	p0OZOMsWE4YV8Ih8CxBp+LGzi0ehR5JklSJoHAZxOMi0uWhrdAHuvm+ObabKR7jB9lx462
	PQVRUfpmUjCdRx2g9s+qgvqyw+z4K/sQJNMahkLv5FykBUtqy1EdnlcQAvhtDgmbmXk7dI
	/sJk8ToTtwmaAVdEedQ9doGLXQs3ilGKXwEsPa6qAlXu83SxT6Y2RWYO5Lgv2A==
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
Subject: [PATCH v1 02/36] soc: fsl: cpm1: qmc: Enable TRNSYNC only when needed
Date: Mon, 29 Jul 2024 16:20:31 +0200
Message-ID: <20240729142107.104574-3-herve.codina@bootlin.com>
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

The TRNSYNC feature is enabled whatever the number of time-slots used.
The feature is needed only when more than one time-slot is used.

Improve the driver enabling TRNSYNC only when it is needed.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/qmc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index bacabf731dcb..916395745850 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -889,6 +889,7 @@ EXPORT_SYMBOL(qmc_chan_stop);
 static int qmc_setup_chan_trnsync(struct qmc *qmc, struct qmc_chan *chan)
 {
 	struct tsa_serial_info info;
+	unsigned int w_rx, w_tx;
 	u16 first_rx, last_tx;
 	u16 trnsync;
 	int ret;
@@ -898,6 +899,14 @@ static int qmc_setup_chan_trnsync(struct qmc *qmc, struct qmc_chan *chan)
 	if (ret)
 		return ret;
 
+	w_rx = hweight64(chan->rx_ts_mask);
+	w_tx = hweight64(chan->tx_ts_mask);
+	if (w_rx <= 1 && w_tx <= 1) {
+		dev_dbg(qmc->dev, "only one or zero ts -> disable trnsync\n");
+		qmc_clrbits16(chan->s_param + QMC_SPE_CHAMR, QMC_SPE_CHAMR_TRANSP_SYNC);
+		return 0;
+	}
+
 	/* Find the first Rx TS allocated to the channel */
 	first_rx = chan->rx_ts_mask ? __ffs64(chan->rx_ts_mask) + 1 : 0;
 
@@ -911,6 +920,7 @@ static int qmc_setup_chan_trnsync(struct qmc *qmc, struct qmc_chan *chan)
 		trnsync |= QMC_SPE_TRNSYNC_TX((last_tx % info.nb_tx_ts) * 2);
 
 	qmc_write16(chan->s_param + QMC_SPE_TRNSYNC, trnsync);
+	qmc_setbits16(chan->s_param + QMC_SPE_CHAMR, QMC_SPE_CHAMR_TRANSP_SYNC);
 
 	dev_dbg(qmc->dev, "chan %u: trnsync=0x%04x, rx %u/%u 0x%llx, tx %u/%u 0x%llx\n",
 		chan->id, trnsync,
@@ -1378,7 +1388,7 @@ static int qmc_setup_chan(struct qmc *qmc, struct qmc_chan *chan)
 	if (chan->mode == QMC_TRANSPARENT) {
 		qmc_write32(chan->s_param + QMC_SPE_ZDSTATE, 0x18000080);
 		qmc_write16(chan->s_param + QMC_SPE_TMRBLR, 60);
-		val = QMC_SPE_CHAMR_MODE_TRANSP | QMC_SPE_CHAMR_TRANSP_SYNC;
+		val = QMC_SPE_CHAMR_MODE_TRANSP;
 		if (chan->is_reverse_data)
 			val |= QMC_SPE_CHAMR_TRANSP_RD;
 		qmc_write16(chan->s_param + QMC_SPE_CHAMR, val);
-- 
2.45.0


