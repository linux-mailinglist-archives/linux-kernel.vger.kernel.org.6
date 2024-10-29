Return-Path: <linux-kernel+bounces-386859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D6D9B48BD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483DC1C227E4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABE420604D;
	Tue, 29 Oct 2024 11:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mThIllOu"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822E220513C;
	Tue, 29 Oct 2024 11:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730202874; cv=none; b=EH/r1bG+jofXgo5dqR8Lb1Etrn0EvHUBjKFUfBPG8U3qYTHzGD/dwwNQJaq21I2RqgEuMgK/ISl6+PScbm6BrdnF5g6pmxHW2H6qWaHKfRYKjl4u0+7arbGf8iOuUbnWIoXDw78gYJynkcjR3xBwq7gv+uyIrf6HiQlqyWoJNhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730202874; c=relaxed/simple;
	bh=xuwOCq9DyQPSbqo5LvZGNA2RGgvT6MVEwrrD7Ioj0/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXzyd08kK50hB8xtK1R8d846MlrstVi4Lc+U0xxshcnjHGLvJSAlb2koTIyToh7gp/xVB+l03qyWkzN8YU4UCvkmxAuISgo9Tf3C9uA5vjaF82FpAP8jm+frpGMWi+LRRioh9977R63NDAIYlamPdd+fcj8n+noVt3lXF1u1oPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mThIllOu; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BFDE51C0009;
	Tue, 29 Oct 2024 11:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730202865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=45yQt7jQVmAc/j0/6F9O+7BqEchGqjbIExy3yfZhK9I=;
	b=mThIllOu6ZEzYnVW+mb+DOrx441jivQ+KXvmJ2GNedD78i8Xi64tUIt0CepQ7vSDYYerq0
	XNDAnQjwsOksIPl/NrrA3L6Ddpa2867waA4FlPNgffWcFXzZKZuEYZqUOMVaLpJQ07J161
	z7OfUuqpWUFDzVvXB1Po3oqQyKJIrATPMo7bq42ljil6pz8l8YnKqFQiHWZGTID1tjmt1+
	fBgC0aBPuxo6EjTWcJGC+tm2QZhPhVNHT6jbDzeSz0I69Y6mPEiovlthHCHGDBX6HLAJQw
	U/nmPqyNOagqfy0a4xjDPPRYtYJj2vyCq6nT36KWGU56Ol4zZi9HTdGR/04sNA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/7] net: stmmac: Only update the auto-discovered PTP clock features
Date: Tue, 29 Oct 2024 12:54:11 +0100
Message-ID: <20241029115419.1160201-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029115419.1160201-1-maxime.chevallier@bootlin.com>
References: <20241029115419.1160201-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Some DWMAC variants such as dwmac1000 don't support disovering the
number of output pps and auxiliary snapshots. Allow these parameters to
be defined in default ptp_clock_info, and let them be updated only when
the feature discovery yielded a result.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 41581f516ea9..8ea2b4226234 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -303,8 +303,14 @@ void stmmac_ptp_register(struct stmmac_priv *priv)
 	if (priv->plat->has_gmac4 && priv->plat->clk_ptp_rate)
 		priv->plat->cdc_error_adj = (2 * NSEC_PER_SEC) / priv->plat->clk_ptp_rate;
 
-	priv->ptp_clock_ops.n_per_out = priv->dma_cap.pps_out_num;
-	priv->ptp_clock_ops.n_ext_ts = priv->dma_cap.aux_snapshot_n;
+	/* Update the ptp clock parameters based on feature discovery, when
+	 * available
+	 */
+	if (priv->dma_cap.pps_out_num)
+		priv->ptp_clock_ops.n_per_out = priv->dma_cap.pps_out_num;
+
+	if (priv->dma_cap.aux_snapshot_n)
+		priv->ptp_clock_ops.n_ext_ts = priv->dma_cap.aux_snapshot_n;
 
 	if (priv->plat->ptp_max_adj)
 		priv->ptp_clock_ops.max_adj = priv->plat->ptp_max_adj;
-- 
2.47.0


