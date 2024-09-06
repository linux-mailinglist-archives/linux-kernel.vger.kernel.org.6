Return-Path: <linux-kernel+bounces-319227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C16C96F97F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D726E1F23C1F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5621D4178;
	Fri,  6 Sep 2024 16:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZaeKQZcR"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EDC322A
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 16:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725640978; cv=none; b=Ker+7M4RHv+XoIDqsOpk/ydJfR5dgkDwDjfmgGqswPkNvh7sO0kJfaqijCfj3Ik35CJGBAZItQkNiZQm03sUKcCNiTazWollt58VxhuaC49P3KfPyDgEDc1cax9FN7sMYf01b6AOHrDvOPjJsExrE6fF8d7Aarw8fOlouT+gqqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725640978; c=relaxed/simple;
	bh=Mw9X2ej9Gzsv1x4EJbG40KPBoVgv/V0lpiSQFYr8c/0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FiUkO27kH3R/yYPagXfq5bxWLoGhQDerBd2xD3Fp7fvIZrppxFZHaFxMdrJFsB++joWlFkijfmTxyX0b1qEr35L9s4vO5hx843rHCHAJirG8WAn3zktv8bv9BetE3rmeAf60hkCYdbTyFhnKbDuGULT5ONtAols4sJZIQLPA8+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZaeKQZcR; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725640973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=26hmEVjqPvMfOUsqeRdpcSop94/F9v2U8MBQ172gA3c=;
	b=ZaeKQZcRaWw+tSLAHJflVFTyITIYEj9AFAakIbZiv0Hp8EO8qpEs59WlIBlYxojpn8JFrG
	oVEkvsjsr2iiYl2E+z/y3b41yRoHlFXgftsdMaTrfOrMgXCKwAT5TItknqLkS3siyegeqd
	3HDcWaqjGaOg9j9jrg/q1vgLEpIuG4w=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Andy Chiu <andy.chiu@sifive.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net v2] net: xilinx: axienet: Fix packet counting
Date: Fri,  6 Sep 2024 12:42:27 -0400
Message-Id: <20240906164227.505984-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

axienet_free_tx_chain returns the number of DMA descriptors it's
handled. However, axienet_tx_poll treats the return as the number of
packets. When scatter-gather SKBs are enabled, a single packet may use
multiple DMA descriptors, which causes incorrect packet counts. Fix this
by explicitly keepting track of the number of packets processed as
separate from the DMA descriptors.

Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v2:
- Only call napi_consume_skb with non-zero budget when force is false

 .../net/ethernet/xilinx/xilinx_axienet_main.c | 31 +++++++++++--------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 9aeb7b9f3ae4..556033849d55 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -670,21 +670,21 @@ static int axienet_device_reset(struct net_device *ndev)
  * @force:	Whether to clean descriptors even if not complete
  * @sizep:	Pointer to a u32 filled with the total sum of all bytes
  *		in all cleaned-up descriptors. Ignored if NULL.
- * @budget:	NAPI budget (use 0 when not called from NAPI poll)
+ * @budget:	NAPI budget (use INT_MAX when not called from NAPI poll)
  *
  * Would either be called after a successful transmit operation, or after
  * there was an error when setting up the chain.
- * Returns the number of descriptors handled.
+ * Returns the number of packets handled.
  */
 static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
 				 int nr_bds, bool force, u32 *sizep, int budget)
 {
 	struct axidma_bd *cur_p;
 	unsigned int status;
+	int i, packets = 0;
 	dma_addr_t phys;
-	int i;
 
-	for (i = 0; i < nr_bds; i++) {
+	for (i = 0; i < nr_bds && packets < budget; i++) {
 		cur_p = &lp->tx_bd_v[(first_bd + i) % lp->tx_bd_num];
 		status = cur_p->status;
 
@@ -701,8 +701,10 @@ static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
 				 (cur_p->cntrl & XAXIDMA_BD_CTRL_LENGTH_MASK),
 				 DMA_TO_DEVICE);
 
-		if (cur_p->skb && (status & XAXIDMA_BD_STS_COMPLETE_MASK))
-			napi_consume_skb(cur_p->skb, budget);
+		if (cur_p->skb && (status & XAXIDMA_BD_STS_COMPLETE_MASK)) {
+			napi_consume_skb(cur_p->skb, force ? 0 : budget);
+			packets++;
+		}
 
 		cur_p->app0 = 0;
 		cur_p->app1 = 0;
@@ -718,7 +720,13 @@ static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
 			*sizep += status & XAXIDMA_BD_STS_ACTUAL_LEN_MASK;
 	}
 
-	return i;
+	if (!force) {
+		lp->tx_bd_ci += i;
+		if (lp->tx_bd_ci >= lp->tx_bd_num)
+			lp->tx_bd_ci %= lp->tx_bd_num;
+	}
+
+	return packets;
 }
 
 /**
@@ -891,13 +899,10 @@ static int axienet_tx_poll(struct napi_struct *napi, int budget)
 	u32 size = 0;
 	int packets;
 
-	packets = axienet_free_tx_chain(lp, lp->tx_bd_ci, budget, false, &size, budget);
+	packets = axienet_free_tx_chain(lp, lp->tx_bd_ci, lp->tx_bd_num, false,
+					&size, budget);
 
 	if (packets) {
-		lp->tx_bd_ci += packets;
-		if (lp->tx_bd_ci >= lp->tx_bd_num)
-			lp->tx_bd_ci %= lp->tx_bd_num;
-
 		u64_stats_update_begin(&lp->tx_stat_sync);
 		u64_stats_add(&lp->tx_packets, packets);
 		u64_stats_add(&lp->tx_bytes, size);
@@ -1003,7 +1008,7 @@ axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 				netdev_err(ndev, "TX DMA mapping error\n");
 			ndev->stats.tx_dropped++;
 			axienet_free_tx_chain(lp, orig_tail_ptr, ii + 1,
-					      true, NULL, 0);
+					      true, NULL, INT_MAX);
 			return NETDEV_TX_OK;
 		}
 		desc_set_phys_addr(lp, phys, cur_p);
-- 
2.35.1.1320.gc452695387.dirty


