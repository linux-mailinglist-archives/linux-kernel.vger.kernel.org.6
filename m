Return-Path: <linux-kernel+bounces-322220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E3B9725EC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 01:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBE0CB23CFF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 23:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33BE1917C6;
	Mon,  9 Sep 2024 23:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="afkAHv+M"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC33190493
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 23:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725925948; cv=none; b=bAicz4sbrLq2ig7QVGrYDJcs6m9E/si/1Wm6oz3pTZW1Bo0tQC5LAogN6XXD45UJuv+FzAQAC2B9u3huCZ6rZkgMGzVr/Upr4RM0NVASrMm+foQB1iLMPasT4rkabVxlrOBtcGo7cep9KB7leg/oZP4BqlzybNGgphMbNc/yUJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725925948; c=relaxed/simple;
	bh=gr11jDcnAqqsrY+bAIlwgcFY4bYrXpMdGHhMyyqLGKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HC3RT59Kw587/RiuXyxWHfFvUV6xDxfmdo7DVujmvJ7nltuCcIR2tMQGyU/pB+lijqLdsTHgXDuxErU3oYVAU7+TIuNmaXIRtwYmhDc0yk0tFfhzJAMMaNVUBOm6vOIkWp0V4csRCW/pS4Rfd7UQ9tsjUfLW6Njjb9K0nBIk7SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=afkAHv+M; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725925942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RJdpdx91YG1zNlUWl852ey9iK3iuCbq4oAOQKlh44hg=;
	b=afkAHv+MeQvv+4DUqN76wtutiZ6PDOuK97AQ8aCDiVkc/d7ve9Li4YerTYmk2+s6rAZfVi
	OYSLrOAwkFJuzl5ou8sFrC6wkBGjMUTnuPtupcqp/lqE0yLNEvKgfsvfBgSjVl8zXh8Hcj
	W5vL2ipE0dpNz5KIIKZ8fZwtrlgNPDo=
From: Sean Anderson <sean.anderson@linux.dev>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [RFC PATCH net-next v2 5/6] net: xilinx: axienet: Get coalesce parameters from driver state
Date: Mon,  9 Sep 2024 19:52:07 -0400
Message-Id: <20240909235208.1331065-6-sean.anderson@linux.dev>
In-Reply-To: <20240909235208.1331065-1-sean.anderson@linux.dev>
References: <20240909235208.1331065-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The cr variables now contain the same values as the control registers
themselves. Extract/calculate the values from the variables instead of
saving the user-specified values. This allows us to remove some
bookeeping, and also lets the user know what the actual coalesce
settings are.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v2:
- New

 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  8 ---
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 70 +++++++++++++------
 2 files changed, 47 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index f0864cb8defe..33d05e55567e 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -533,10 +533,6 @@ struct skbuf_dma_descriptor {
  * @rxmem:	Stores rx memory size for jumbo frame handling.
  * @csum_offload_on_tx_path:	Stores the checksum selection on TX side.
  * @csum_offload_on_rx_path:	Stores the checksum selection on RX side.
- * @coalesce_count_rx:	Store the irq coalesce on RX side.
- * @coalesce_usec_rx:	IRQ coalesce delay for RX
- * @coalesce_count_tx:	Store the irq coalesce on TX side.
- * @coalesce_usec_tx:	IRQ coalesce delay for TX
  * @use_dmaengine: flag to check dmaengine framework usage.
  * @tx_chan:	TX DMA channel.
  * @rx_chan:	RX DMA channel.
@@ -617,10 +613,6 @@ struct axienet_local {
 	int csum_offload_on_tx_path;
 	int csum_offload_on_rx_path;
 
-	u32 coalesce_count_rx;
-	u32 coalesce_usec_rx;
-	u32 coalesce_count_tx;
-	u32 coalesce_usec_tx;
 	u8  use_dmaengine;
 	struct dma_chan *tx_chan;
 	struct dma_chan *rx_chan;
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 6bcb605aa67e..eb9600417d81 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -223,6 +223,13 @@ static void axienet_dma_bd_release(struct net_device *ndev)
 			  lp->rx_bd_p);
 }
 
+static u64 axienet_dma_rate(struct axienet_local *lp)
+{
+	if (lp->axi_clk)
+		return clk_get_rate(lp->axi_clk);
+	return 125000000; /* arbitrary guess if no clock rate set */
+}
+
 /**
  * axienet_calc_cr() - Calculate control register value
  * @lp: Device private data
@@ -243,12 +250,9 @@ static u32 axienet_calc_cr(struct axienet_local *lp, u32 count, u32 usec)
 	 * the first packet. Otherwise leave at 0 to disable delay interrupt.
 	 */
 	if (count > 1) {
-		u64 clk_rate = 125000000; /* arbitrary guess if no clock rate set */
+		u64 clk_rate = axienet_dma_rate(lp);
 		u32 timer;
 
-		if (lp->axi_clk)
-			clk_rate = clk_get_rate(lp->axi_clk);
-
 		/* 1 Timeout Interval = 125 * (clock period of SG clock) */
 		timer = DIV64_U64_ROUND_CLOSEST((u64)usec * clk_rate,
 						XAXIDMA_DELAY_SCALE);
@@ -261,6 +265,23 @@ static u32 axienet_calc_cr(struct axienet_local *lp, u32 count, u32 usec)
 	return cr;
 }
 
+/**
+ * axienet_cr_params() - Extract coalesce parameters from the CR
+ * @lp: Device private data
+ * @cr: The control register to parse
+ * @count: Number of packets before an interrupt
+ * @usec: Idle time (in usec) before an interrupt
+ */
+static void axienet_coalesce_params(struct axienet_local *lp, u32 cr,
+				    u32 *count, u32 *usec)
+{
+	u64 clk_rate = axienet_dma_rate(lp);
+	u64 timer = FIELD_GET(XAXIDMA_DELAY_MASK, cr);
+
+	*count = FIELD_GET(XAXIDMA_COALESCE_MASK, cr);
+	*usec = DIV64_U64_ROUND_CLOSEST(timer * XAXIDMA_DELAY_SCALE, clk_rate);
+}
+
 /**
  * axienet_dma_start - Set up DMA registers and start DMA operation
  * @lp:		Pointer to the axienet_local structure
@@ -2095,11 +2116,21 @@ axienet_ethtools_get_coalesce(struct net_device *ndev,
 			      struct netlink_ext_ack *extack)
 {
 	struct axienet_local *lp = netdev_priv(ndev);
+	u32 cr;
 
-	ecoalesce->rx_max_coalesced_frames = lp->coalesce_count_rx;
-	ecoalesce->rx_coalesce_usecs = lp->coalesce_usec_rx;
-	ecoalesce->tx_max_coalesced_frames = lp->coalesce_count_tx;
-	ecoalesce->tx_coalesce_usecs = lp->coalesce_usec_tx;
+	spin_lock_irq(&lp->rx_cr_lock);
+	cr = lp->rx_dma_cr;
+	spin_unlock_irq(&lp->rx_cr_lock);
+	axienet_coalesce_params(lp, cr,
+				&ecoalesce->rx_max_coalesced_frames,
+				&ecoalesce->rx_coalesce_usecs);
+
+	spin_lock_irq(&lp->tx_cr_lock);
+	cr = lp->tx_dma_cr;
+	spin_unlock_irq(&lp->tx_cr_lock);
+	axienet_coalesce_params(lp, cr,
+				&ecoalesce->tx_max_coalesced_frames,
+				&ecoalesce->tx_coalesce_usecs);
 	return 0;
 }
 
@@ -2140,15 +2171,12 @@ axienet_ethtools_set_coalesce(struct net_device *ndev,
 		return -EINVAL;
 	}
 
-	lp->coalesce_count_rx = ecoalesce->rx_max_coalesced_frames;
-	lp->coalesce_usec_rx = ecoalesce->rx_coalesce_usecs;
-	lp->coalesce_count_tx = ecoalesce->tx_max_coalesced_frames;
-	lp->coalesce_usec_tx = ecoalesce->tx_coalesce_usecs;
-
-	cr = axienet_calc_cr(lp, lp->coalesce_count_rx, lp->coalesce_usec_rx);
+	cr = axienet_calc_cr(lp, ecoalesce->rx_max_coalesced_frames,
+			     ecoalesce->rx_coalesce_usecs);
 	axienet_update_coalesce_rx(lp, cr, ~XAXIDMA_CR_RUNSTOP_MASK);
 
-	cr = axienet_calc_cr(lp, lp->coalesce_count_tx, lp->coalesce_usec_tx);
+	cr = axienet_calc_cr(lp, ecoalesce->tx_max_coalesced_frames,
+			     ecoalesce->tx_coalesce_usecs);
 	axienet_update_coalesce_tx(lp, cr, ~XAXIDMA_CR_RUNSTOP_MASK);
 	return 0;
 }
@@ -2936,14 +2964,10 @@ static int axienet_probe(struct platform_device *pdev)
 
 	spin_lock_init(&lp->rx_cr_lock);
 	spin_lock_init(&lp->tx_cr_lock);
-	lp->coalesce_count_rx = XAXIDMA_DFT_RX_THRESHOLD;
-	lp->coalesce_count_tx = XAXIDMA_DFT_TX_THRESHOLD;
-	lp->coalesce_usec_rx = XAXIDMA_DFT_RX_USEC;
-	lp->coalesce_usec_tx = XAXIDMA_DFT_TX_USEC;
-	lp->rx_dma_cr = axienet_calc_cr(lp, lp->coalesce_count_rx,
-					lp->coalesce_usec_rx);
-	lp->tx_dma_cr = axienet_calc_cr(lp, lp->coalesce_count_tx,
-					lp->coalesce_usec_tx);
+	lp->rx_dma_cr = axienet_calc_cr(lp, XAXIDMA_DFT_RX_THRESHOLD,
+					XAXIDMA_DFT_RX_USEC);
+	lp->tx_dma_cr = axienet_calc_cr(lp, XAXIDMA_DFT_TX_THRESHOLD,
+					XAXIDMA_DFT_TX_USEC);
 
 	ret = axienet_mdio_setup(lp);
 	if (ret)
-- 
2.35.1.1320.gc452695387.dirty


