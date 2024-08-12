Return-Path: <linux-kernel+bounces-283696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEFC94F7DF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A2BC1F217C9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5926197A6E;
	Mon, 12 Aug 2024 20:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hs+PySwP"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5D7194A5B
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 20:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723493101; cv=none; b=BPrIGsqkL68QW8d8jllfvBKarEyg36BtSWdCkRsnlzZ/gyGWhzrQsUKYXyrZQ6KvuI8YqVFDZqC9Jh+48fApJQ4vSPEaRJ0PhEy0oUVYNLt4Dkjd1dFXUJucu97weCdlvSLGczzwmP74A6ubkBbSIeYrmh4mUd0gJ3r1Gdb4y8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723493101; c=relaxed/simple;
	bh=8qR+RPbRj58Zhnq3zUHzpHGAhsBzQSvSR/dJjhTLJIA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HhMF2jycE53gQGusZumeAzKyxg0w5ijtuWTtXzxFNEpmcNWmuUyBegxRO4Gb5bQlbrM0bh/ZSc6jxVZEGSsdlhBPdV2D+OnumOPdT3eTW1zHr7HxupDIEJtz+ERA/iwDprSbVA8MU8H9worZdo1ow6f5/dkUpJaAUwrQ+ZFWj3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hs+PySwP; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723493097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zANh4vceacIX4TWJ6+rU9HLMP5zVjL0NeNhMa3hIyN8=;
	b=hs+PySwPtDmxd9V49Zz3wqM8t8s2mSoqgcy6QyaqFkIgoAFHdVnu1Mh74PGNRMcpabgSPE
	/RPJMnX/CbQo4L/80awF/xK+j3/pCUdHs/5j8VbAubieKC0z0FaiN4NXIOK86OegJjrC6F
	0vmDkIf7M4v2v+M8Q/AzA5Um1HmvWT0=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Michal Simek <michal.simek@amd.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-arm-kernel@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Ariane Keller <ariane.keller@tik.ee.ethz.ch>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next 2/4] net: xilinx: axienet: Fix dangling multicast addresses
Date: Mon, 12 Aug 2024 16:04:35 -0400
Message-Id: <20240812200437.3581990-3-sean.anderson@linux.dev>
In-Reply-To: <20240812200437.3581990-1-sean.anderson@linux.dev>
References: <20240812200437.3581990-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

If a multicast address is removed but there are still some multicast
addresses, that address would remain programmed into the frame filter.
Fix this by explicitly setting the enable bit for each filter.

Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  1 +
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 21 ++++++++-----------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index 0d5b300107e0..03fef656478e 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -170,6 +170,7 @@
 #define XAE_UAW0_OFFSET		0x00000700 /* Unicast address word 0 */
 #define XAE_UAW1_OFFSET		0x00000704 /* Unicast address word 1 */
 #define XAE_FMI_OFFSET		0x00000708 /* Filter Mask Index */
+#define XAE_FFE_OFFSET		0x0000070C /* Frame Filter Enable */
 #define XAE_AF0_OFFSET		0x00000710 /* Address Filter 0 */
 #define XAE_AF1_OFFSET		0x00000714 /* Address Filter 1 */
 
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index e664611c29cf..1bcabb016ca9 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -433,7 +433,7 @@ static int netdev_set_mac_address(struct net_device *ndev, void *p)
  */
 static void axienet_set_multicast_list(struct net_device *ndev)
 {
-	int i;
+	int i = 0;
 	u32 reg, af0reg, af1reg;
 	struct axienet_local *lp = netdev_priv(ndev);
 
@@ -455,7 +455,6 @@ static void axienet_set_multicast_list(struct net_device *ndev)
 		reg &= ~XAE_FMI_PM_MASK;
 		axienet_iow(lp, XAE_FMI_OFFSET, reg);
 
-		i = 0;
 		netdev_for_each_mc_addr(ha, ndev) {
 			if (i >= XAE_MULTICAST_CAM_TABLE_NUM)
 				break;
@@ -474,6 +473,7 @@ static void axienet_set_multicast_list(struct net_device *ndev)
 			axienet_iow(lp, XAE_FMI_OFFSET, reg);
 			axienet_iow(lp, XAE_AF0_OFFSET, af0reg);
 			axienet_iow(lp, XAE_AF1_OFFSET, af1reg);
+			axienet_iow(lp, XAE_FFE_OFFSET, 1);
 			i++;
 		}
 	} else {
@@ -481,18 +481,15 @@ static void axienet_set_multicast_list(struct net_device *ndev)
 		reg &= ~XAE_FMI_PM_MASK;
 
 		axienet_iow(lp, XAE_FMI_OFFSET, reg);
-
-		for (i = 0; i < XAE_MULTICAST_CAM_TABLE_NUM; i++) {
-			reg = axienet_ior(lp, XAE_FMI_OFFSET) & 0xFFFFFF00;
-			reg |= i;
-
-			axienet_iow(lp, XAE_FMI_OFFSET, reg);
-			axienet_iow(lp, XAE_AF0_OFFSET, 0);
-			axienet_iow(lp, XAE_AF1_OFFSET, 0);
-		}
-
 		dev_info(&ndev->dev, "Promiscuous mode disabled.\n");
 	}
+
+	for (; i < XAE_MULTICAST_CAM_TABLE_NUM; i++) {
+		reg = axienet_ior(lp, XAE_FMI_OFFSET) & 0xFFFFFF00;
+		reg |= i;
+		axienet_iow(lp, XAE_FMI_OFFSET, reg);
+		axienet_iow(lp, XAE_FFE_OFFSET, 0);
+	}
 }
 
 /**
-- 
2.35.1.1320.gc452695387.dirty


