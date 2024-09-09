Return-Path: <linux-kernel+bounces-321742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E57971ECD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63EF82857E3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8827813CFBC;
	Mon,  9 Sep 2024 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="du//2mr3"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08A0136E28
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725898227; cv=none; b=N6P1Q2Kn3HxumhLvEFFB/7uIE+r/96EBTROFVHApkXE/jB5B/guO+VYphDHgfbRd0wtDSnm9CCis2WKYEqZyrJ7uSbyweZkAm3ZtvlYxm0+sfnW1L/Q0KR3GqIG9g+jMoEgX6VmzHkJBXiCXlBI7VTHzUDneSTdfJ6ninSRC/Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725898227; c=relaxed/simple;
	bh=b7r22GvWSGCQFisJ8HFSX0NCY7i61DaUNeKekj+WoQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WZ7QW1cDVd5DX8dbWWxISsvcaqFyHxPEHkKIkUtEmsx5J4/eSwstxvGcMy/COAKgWYg050p2NfrRlJr4/dmf8TY2zzlX5jWP60SnEzueqFF0z0l+pXROlFM/8xf0avU7t1mP3Ij//qM/djDBCRVysK4VD7Vio3BP5M4712bzQHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=du//2mr3; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725898224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tqlLT/Hh20witXiI7FRrOr1inVlCff2bwtrhyondFxg=;
	b=du//2mr3O0O9PxG9nGWD5CwEvtu5tqp/zl7s9xAgi/UhdCNIDX0jRYiQlFqCE1l8NIEKUa
	ds8wd6n1vdaCavzEWJxKAQsUnpLAXzvg1hNyZLtrD8Koj8iNEBklt+llZhWMQzCDOjazi1
	0e6/yDaZD//6i7QIrk54Tvwvx1COE+M=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v2 1/4] net: xilinx: axienet: Remove unused checksum variables
Date: Mon,  9 Sep 2024 12:10:13 -0400
Message-Id: <20240909161016.1149119-2-sean.anderson@linux.dev>
In-Reply-To: <20240909161016.1149119-1-sean.anderson@linux.dev>
References: <20240909161016.1149119-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

These variables are set but never used. Remove them.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---

(no changes since v1)

 drivers/net/ethernet/xilinx/xilinx_axienet.h      |  5 -----
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 12 ------------
 2 files changed, 17 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index c301dd2ee083..b9d2d7319220 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -527,8 +527,6 @@ struct skbuf_dma_descriptor {
  *		  supported, the maximum frame size would be 9k. Else it is
  *		  1522 bytes (assuming support for basic VLAN)
  * @rxmem:	Stores rx memory size for jumbo frame handling.
- * @csum_offload_on_tx_path:	Stores the checksum selection on TX side.
- * @csum_offload_on_rx_path:	Stores the checksum selection on RX side.
  * @coalesce_count_rx:	Store the irq coalesce on RX side.
  * @coalesce_usec_rx:	IRQ coalesce delay for RX
  * @coalesce_count_tx:	Store the irq coalesce on TX side.
@@ -606,9 +604,6 @@ struct axienet_local {
 	u32 max_frm_size;
 	u32 rxmem;
 
-	int csum_offload_on_tx_path;
-	int csum_offload_on_rx_path;
-
 	u32 coalesce_count_rx;
 	u32 coalesce_usec_rx;
 	u32 coalesce_count_tx;
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index fe6a0e2e463f..60ec430f3eb0 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -2631,38 +2631,26 @@ static int axienet_probe(struct platform_device *pdev)
 	if (!ret) {
 		switch (value) {
 		case 1:
-			lp->csum_offload_on_tx_path =
-				XAE_FEATURE_PARTIAL_TX_CSUM;
 			lp->features |= XAE_FEATURE_PARTIAL_TX_CSUM;
 			/* Can checksum TCP/UDP over IPv4. */
 			ndev->features |= NETIF_F_IP_CSUM;
 			break;
 		case 2:
-			lp->csum_offload_on_tx_path =
-				XAE_FEATURE_FULL_TX_CSUM;
 			lp->features |= XAE_FEATURE_FULL_TX_CSUM;
 			/* Can checksum TCP/UDP over IPv4. */
 			ndev->features |= NETIF_F_IP_CSUM;
 			break;
-		default:
-			lp->csum_offload_on_tx_path = XAE_NO_CSUM_OFFLOAD;
 		}
 	}
 	ret = of_property_read_u32(pdev->dev.of_node, "xlnx,rxcsum", &value);
 	if (!ret) {
 		switch (value) {
 		case 1:
-			lp->csum_offload_on_rx_path =
-				XAE_FEATURE_PARTIAL_RX_CSUM;
 			lp->features |= XAE_FEATURE_PARTIAL_RX_CSUM;
 			break;
 		case 2:
-			lp->csum_offload_on_rx_path =
-				XAE_FEATURE_FULL_RX_CSUM;
 			lp->features |= XAE_FEATURE_FULL_RX_CSUM;
 			break;
-		default:
-			lp->csum_offload_on_rx_path = XAE_NO_CSUM_OFFLOAD;
 		}
 	}
 	/* For supporting jumbo frames, the Axi Ethernet hardware must have
-- 
2.35.1.1320.gc452695387.dirty


