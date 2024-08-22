Return-Path: <linux-kernel+bounces-297557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2DB95BABD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55C671F247D3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF7E1CBE89;
	Thu, 22 Aug 2024 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xrOW7BOI"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BC61CDFD4
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 15:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724341293; cv=none; b=SMFA0xktSPJPtojUdrNWOX/xm8+K7VkInox42JcyuYOOwmy9Ph3dedqMgEEHQ2oCAFUWfH8807Fxe5LKG5HFmJwNll5b9kmNWRKTSK+3dNUhPSYzxvXr7Cd0qAFz0mfrSfXofas137RX7xvn0Uu1N25C00HFGrBI+deCWTof1tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724341293; c=relaxed/simple;
	bh=8/XFPh25xGSUZ1P8YK1SABWsinsK0clgjIwNTRAEvUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=azL4TAMb6mohlk5OZ2oW2VWDf0m0RkzJWQlx+GxIhbayBV8DWgJ4uBAkbGedWJBjK1c0Tjij72HbbMkeAhDg6NJ6iVzrpplGTAVpue2dAeCHD3O+1NLmFZf54njCmst94/lm3mb7/VTT+FPQ9cj8e+cgLK9lI8+NYdsDcpvaXDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xrOW7BOI; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724341290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6XRAKJklo9vBktdRNWOH6AnRZImaO00oA0lmHQ28GKY=;
	b=xrOW7BOICT3ZrLBwTKvk8/GDpheqAjKRKpfd4DQuOyY/9hRd4HODr+fhUFtTcfofIiPOBe
	6HRXugEyX/D8XI3SC0FjP4pPcGOS3/hNyA5GKzGKaKomNbOVHQCVJCmGK3Bb5HoTFWg54e
	IRFuzu8h4XY7bmXzoVyxqoxFqbakPM8=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Eric Dumazet <edumazet@google.com>,
	Michal Simek <michal.simek@amd.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v3 5/5] net: xilinx: axienet: Support IFF_ALLMULTI
Date: Thu, 22 Aug 2024 11:40:59 -0400
Message-Id: <20240822154059.1066595-6-sean.anderson@linux.dev>
In-Reply-To: <20240822154059.1066595-1-sean.anderson@linux.dev>
References: <20240822154059.1066595-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add support for IFF_ALLMULTI by configuring a single filter to match the
multicast address bit. This allows us to keep promiscuous mode disabled,
even when we have more than four multicast addresses. An even better
solution would be to "pack" addresses into the available CAM registers,
but that can wait for a future series.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Reviewed-by: Simon Horman <horms@kernel.org>
---

(no changes since v1)

 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  2 ++
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 34 +++++++++++--------
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index 5a7d6b872f5d..c301dd2ee083 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -175,6 +175,8 @@
 #define XAE_FFE_OFFSET		0x0000070C /* Frame Filter Enable */
 #define XAE_AF0_OFFSET		0x00000710 /* Address Filter 0 */
 #define XAE_AF1_OFFSET		0x00000714 /* Address Filter 1 */
+#define XAE_AM0_OFFSET		0x00000750 /* Frame Filter Mask Value Bytes 3-0 */
+#define XAE_AM1_OFFSET		0x00000754 /* Frame Filter Mask Value Bytes 7-4 */
 
 #define XAE_TX_VLAN_DATA_OFFSET 0x00004000 /* TX VLAN data table address */
 #define XAE_RX_VLAN_DATA_OFFSET 0x00008000 /* RX VLAN data table address */
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 5c4a5949a021..fe6a0e2e463f 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -437,18 +437,27 @@ static void axienet_set_multicast_list(struct net_device *ndev)
 	u32 reg, af0reg, af1reg;
 	struct axienet_local *lp = netdev_priv(ndev);
 
-	if (ndev->flags & (IFF_ALLMULTI | IFF_PROMISC) ||
-	    netdev_mc_count(ndev) > XAE_MULTICAST_CAM_TABLE_NUM) {
-		reg = axienet_ior(lp, XAE_FMI_OFFSET);
+	reg = axienet_ior(lp, XAE_FMI_OFFSET);
+	reg &= ~XAE_FMI_PM_MASK;
+	if (ndev->flags & IFF_PROMISC)
 		reg |= XAE_FMI_PM_MASK;
+	else
+		reg &= ~XAE_FMI_PM_MASK;
+	axienet_iow(lp, XAE_FMI_OFFSET, reg);
+
+	if (ndev->flags & IFF_ALLMULTI ||
+	    netdev_mc_count(ndev) > XAE_MULTICAST_CAM_TABLE_NUM) {
+		reg &= 0xFFFFFF00;
 		axienet_iow(lp, XAE_FMI_OFFSET, reg);
+		axienet_iow(lp, XAE_AF0_OFFSET, 1); /* Multicast bit */
+		axienet_iow(lp, XAE_AF1_OFFSET, 0);
+		axienet_iow(lp, XAE_AM0_OFFSET, 1); /* ditto */
+		axienet_iow(lp, XAE_AM1_OFFSET, 0);
+		axienet_iow(lp, XAE_FFE_OFFSET, 1);
+		i = 1;
 	} else if (!netdev_mc_empty(ndev)) {
 		struct netdev_hw_addr *ha;
 
-		reg = axienet_ior(lp, XAE_FMI_OFFSET);
-		reg &= ~XAE_FMI_PM_MASK;
-		axienet_iow(lp, XAE_FMI_OFFSET, reg);
-
 		netdev_for_each_mc_addr(ha, ndev) {
 			if (i >= XAE_MULTICAST_CAM_TABLE_NUM)
 				break;
@@ -461,24 +470,21 @@ static void axienet_set_multicast_list(struct net_device *ndev)
 			af1reg = (ha->addr[4]);
 			af1reg |= (ha->addr[5] << 8);
 
-			reg = axienet_ior(lp, XAE_FMI_OFFSET) & 0xFFFFFF00;
+			reg &= 0xFFFFFF00;
 			reg |= i;
 
 			axienet_iow(lp, XAE_FMI_OFFSET, reg);
 			axienet_iow(lp, XAE_AF0_OFFSET, af0reg);
 			axienet_iow(lp, XAE_AF1_OFFSET, af1reg);
+			axienet_iow(lp, XAE_AM0_OFFSET, 0xffffffff);
+			axienet_iow(lp, XAE_AM1_OFFSET, 0x0000ffff);
 			axienet_iow(lp, XAE_FFE_OFFSET, 1);
 			i++;
 		}
-	} else {
-		reg = axienet_ior(lp, XAE_FMI_OFFSET);
-		reg &= ~XAE_FMI_PM_MASK;
-
-		axienet_iow(lp, XAE_FMI_OFFSET, reg);
 	}
 
 	for (; i < XAE_MULTICAST_CAM_TABLE_NUM; i++) {
-		reg = axienet_ior(lp, XAE_FMI_OFFSET) & 0xFFFFFF00;
+		reg &= 0xFFFFFF00;
 		reg |= i;
 		axienet_iow(lp, XAE_FMI_OFFSET, reg);
 		axienet_iow(lp, XAE_FFE_OFFSET, 0);
-- 
2.35.1.1320.gc452695387.dirty


