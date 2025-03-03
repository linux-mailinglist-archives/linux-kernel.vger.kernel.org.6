Return-Path: <linux-kernel+bounces-542895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C88A4CF2A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75B801895656
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 23:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE6423A9AB;
	Mon,  3 Mar 2025 23:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Uq9cujKJ"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A62B1EA7D7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 23:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741043942; cv=none; b=nd4ZaPufn1z/hYO21aPobws1nmxPJhHVcVtuKd1OwfFQK2fEiZM0xNaQWHqcmcrVXCM+NaePsym+ypUL3Q94ux1oqUzf84otwbdbgldEgtn43w4o9AAMNmlTFgwPNWwf9y+zsKB3nn4xOR9tfxQpwxTQJ1qvtvjDitutwaTklec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741043942; c=relaxed/simple;
	bh=rdxTNm1Q/Jtiew4OmAXH1C4+Z7190ygukoNySpMBPOU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XrgZ2paY8I4CSNmq1yhyB8gzxelVJV2rFuEGODs2QaMYsu8ejYCyDc2zW3mngfVZmdYA40jcOhxY2yVboS7vITPa7e23BzCdLjOtH36lTtOzLIhIuphAZkvbXQJedruri2Hq3gaX9zNre/ra9oWD3NKusqVCm7w3zos4UFOgr7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Uq9cujKJ; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741043928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C1jW4gD3g//7iiyAupUANeDgbhoWm0/YCVVSeZwon5Q=;
	b=Uq9cujKJSdUm6O/5PHXGhJn2TXoBPx9jMCxCH9GL+PT9My33TDj8cmHWZxMm9MOZ0Z8r7/
	S8/ECX9bwpfozMg9b8MRXw/wPHvQZpmkx1lURApaV0NRjfSTUM9E+5Z7s18R4JLKDcFijD
	Lh2HkUWuFxtirPfvryG5phvSjqvg2zY=
From: Sean Anderson <sean.anderson@linux.dev>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next] net: cadence: macb: Synchronize standard stats
Date: Mon,  3 Mar 2025 18:18:32 -0500
Message-Id: <20250303231832.1648274-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The new stats calculations add several additional calls to
macb/gem_update_stats() and accesses to bp->hw_stats. These are
protected by a spinlock since commit fa52f15c745c ("net: cadence: macb:
Synchronize stats calculations"), which was applied in parallel. Add
some locking now that the net has been merged into net-next.

Fixes: f6af690a295a ("net: cadence: macb: Report standard stats")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/net/ethernet/cadence/macb_main.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 6c462de81f20..b5797c1ac0a4 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3253,9 +3253,11 @@ static void macb_get_pause_stats(struct net_device *dev,
 	struct macb *bp = netdev_priv(dev);
 	struct macb_stats *hwstat = &bp->hw_stats.macb;
 
+	spin_lock_irq(&bp->stats_lock);
 	macb_update_stats(bp);
 	pause_stats->tx_pause_frames = hwstat->tx_pause_frames;
 	pause_stats->rx_pause_frames = hwstat->rx_pause_frames;
+	spin_unlock_irq(&bp->stats_lock);
 }
 
 static void gem_get_pause_stats(struct net_device *dev,
@@ -3264,9 +3266,11 @@ static void gem_get_pause_stats(struct net_device *dev,
 	struct macb *bp = netdev_priv(dev);
 	struct gem_stats *hwstat = &bp->hw_stats.gem;
 
+	spin_lock_irq(&bp->stats_lock);
 	gem_update_stats(bp);
 	pause_stats->tx_pause_frames = hwstat->tx_pause_frames;
 	pause_stats->rx_pause_frames = hwstat->rx_pause_frames;
+	spin_unlock_irq(&bp->stats_lock);
 }
 
 static void macb_get_eth_mac_stats(struct net_device *dev,
@@ -3275,6 +3279,7 @@ static void macb_get_eth_mac_stats(struct net_device *dev,
 	struct macb *bp = netdev_priv(dev);
 	struct macb_stats *hwstat = &bp->hw_stats.macb;
 
+	spin_lock_irq(&bp->stats_lock);
 	macb_update_stats(bp);
 	mac_stats->FramesTransmittedOK = hwstat->tx_ok;
 	mac_stats->SingleCollisionFrames = hwstat->tx_single_cols;
@@ -3290,6 +3295,7 @@ static void macb_get_eth_mac_stats(struct net_device *dev,
 	mac_stats->FramesLostDueToIntMACRcvError = hwstat->rx_overruns;
 	mac_stats->InRangeLengthErrors = hwstat->rx_length_mismatch;
 	mac_stats->FrameTooLongErrors = hwstat->rx_oversize_pkts;
+	spin_unlock_irq(&bp->stats_lock);
 }
 
 static void gem_get_eth_mac_stats(struct net_device *dev,
@@ -3298,6 +3304,7 @@ static void gem_get_eth_mac_stats(struct net_device *dev,
 	struct macb *bp = netdev_priv(dev);
 	struct gem_stats *hwstat = &bp->hw_stats.gem;
 
+	spin_lock_irq(&bp->stats_lock);
 	gem_update_stats(bp);
 	mac_stats->FramesTransmittedOK = hwstat->tx_frames;
 	mac_stats->SingleCollisionFrames = hwstat->tx_single_collision_frames;
@@ -3320,6 +3327,7 @@ static void gem_get_eth_mac_stats(struct net_device *dev,
 	mac_stats->BroadcastFramesReceivedOK = hwstat->rx_broadcast_frames;
 	mac_stats->InRangeLengthErrors = hwstat->rx_length_field_frame_errors;
 	mac_stats->FrameTooLongErrors = hwstat->rx_oversize_frames;
+	spin_unlock_irq(&bp->stats_lock);
 }
 
 /* TODO: Report SQE test errors when added to phy_stats */
@@ -3329,8 +3337,10 @@ static void macb_get_eth_phy_stats(struct net_device *dev,
 	struct macb *bp = netdev_priv(dev);
 	struct macb_stats *hwstat = &bp->hw_stats.macb;
 
+	spin_lock_irq(&bp->stats_lock);
 	macb_update_stats(bp);
 	phy_stats->SymbolErrorDuringCarrier = hwstat->rx_symbol_errors;
+	spin_unlock_irq(&bp->stats_lock);
 }
 
 static void gem_get_eth_phy_stats(struct net_device *dev,
@@ -3339,8 +3349,10 @@ static void gem_get_eth_phy_stats(struct net_device *dev,
 	struct macb *bp = netdev_priv(dev);
 	struct gem_stats *hwstat = &bp->hw_stats.gem;
 
+	spin_lock_irq(&bp->stats_lock);
 	gem_update_stats(bp);
 	phy_stats->SymbolErrorDuringCarrier = hwstat->rx_symbol_errors;
+	spin_unlock_irq(&bp->stats_lock);
 }
 
 static void macb_get_rmon_stats(struct net_device *dev,
@@ -3350,10 +3362,12 @@ static void macb_get_rmon_stats(struct net_device *dev,
 	struct macb *bp = netdev_priv(dev);
 	struct macb_stats *hwstat = &bp->hw_stats.macb;
 
+	spin_lock_irq(&bp->stats_lock);
 	macb_update_stats(bp);
 	rmon_stats->undersize_pkts = hwstat->rx_undersize_pkts;
 	rmon_stats->oversize_pkts = hwstat->rx_oversize_pkts;
 	rmon_stats->jabbers = hwstat->rx_jabbers;
+	spin_unlock_irq(&bp->stats_lock);
 }
 
 static const struct ethtool_rmon_hist_range gem_rmon_ranges[] = {
@@ -3374,6 +3388,7 @@ static void gem_get_rmon_stats(struct net_device *dev,
 	struct macb *bp = netdev_priv(dev);
 	struct gem_stats *hwstat = &bp->hw_stats.gem;
 
+	spin_lock_irq(&bp->stats_lock);
 	gem_update_stats(bp);
 	rmon_stats->undersize_pkts = hwstat->rx_undersized_frames;
 	rmon_stats->oversize_pkts = hwstat->rx_oversize_frames;
@@ -3392,6 +3407,7 @@ static void gem_get_rmon_stats(struct net_device *dev,
 	rmon_stats->hist_tx[4] = hwstat->tx_512_1023_byte_frames;
 	rmon_stats->hist_tx[5] = hwstat->tx_1024_1518_byte_frames;
 	rmon_stats->hist_tx[6] = hwstat->tx_greater_than_1518_byte_frames;
+	spin_unlock_irq(&bp->stats_lock);
 	*ranges = gem_rmon_ranges;
 }
 
-- 
2.35.1.1320.gc452695387.dirty


