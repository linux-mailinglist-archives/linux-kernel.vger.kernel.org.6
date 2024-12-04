Return-Path: <linux-kernel+bounces-430799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA999E35B7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7AC281A12
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5D91AF0DC;
	Wed,  4 Dec 2024 08:41:58 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994E8197A7E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 08:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733301717; cv=none; b=tSBdNF1s/CEDpkXqtJb+XvNgP4sXQu10OGq8qyt4HteE9NTsi/JoATLPFCmWCqC0hnnRef16oat6d5wrl7csIVTCk9YkOayUDlpR7e0embPZCoL+cDKOBI1iee3Ppzco/gQjaq8Ati7za7uUq+vKDdgsJn+bLOql66qPkQAxaiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733301717; c=relaxed/simple;
	bh=HmWIQY8UvLn4ZJL4fWAa2j1as79ANb/9HDtSpGAmaug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r6I4TZHNy34U7lZtbM5uRWkcfZ1fFCXaiSbNiHi0QGXUOQDnEWt8M4SD7q0kn1Pxrb5sm3zgAldkrsYnbxXCpyUa+ejGw0q4XR5DYFrC+5q5Zg3IFCCh+wM0tMuSLNeVsKCQ2RbWa1ftPp9TcpIPdreuyOLEe9BLO8GnMJUPVlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tIkx7-0001I8-45; Wed, 04 Dec 2024 09:41:45 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tIkx5-001cUP-15;
	Wed, 04 Dec 2024 09:41:44 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tIkx6-004puB-01;
	Wed, 04 Dec 2024 09:41:44 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH net-next v2 10/10] net: usb: lan78xx: Improve error handling in dataport and multicast writes
Date: Wed,  4 Dec 2024 09:41:42 +0100
Message-Id: <20241204084142.1152696-11-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241204084142.1152696-1-o.rempel@pengutronix.de>
References: <20241204084142.1152696-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Update `lan78xx_dataport_write` and `lan78xx_deferred_multicast_write`
to:
- Handle errors during register read/write operations.
- Exit immediately on errors and log them using `%pe` for clarity.
- Avoid silent failures by propagating error codes properly.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/lan78xx.c | 67 ++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 22 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 2ae9565b5044..d5f6367d3714 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1371,7 +1371,7 @@ static int lan78xx_dataport_wait_not_busy(struct lan78xx_net *dev)
 
 		ret = lan78xx_read_reg(dev, DP_SEL, &dp_sel);
 		if (unlikely(ret < 0))
-			return -EIO;
+			return ret;
 
 		if (dp_sel & DP_SEL_DPRDY_)
 			return 0;
@@ -1381,44 +1381,51 @@ static int lan78xx_dataport_wait_not_busy(struct lan78xx_net *dev)
 
 	netdev_warn(dev->net, "%s timed out", __func__);
 
-	return -EIO;
+	return -ETIMEDOUT;
 }
 
 static int lan78xx_dataport_write(struct lan78xx_net *dev, u32 ram_select,
 				  u32 addr, u32 length, u32 *buf)
 {
 	struct lan78xx_priv *pdata = (struct lan78xx_priv *)(dev->data[0]);
-	u32 dp_sel;
 	int i, ret;
 
-	if (usb_autopm_get_interface(dev->intf) < 0)
-		return 0;
+	ret = usb_autopm_get_interface(dev->intf);
+	if (ret < 0)
+		return ret;
 
 	mutex_lock(&pdata->dataport_mutex);
 
 	ret = lan78xx_dataport_wait_not_busy(dev);
 	if (ret < 0)
-		goto done;
+		goto dataport_write;
 
-	ret = lan78xx_read_reg(dev, DP_SEL, &dp_sel);
-
-	dp_sel &= ~DP_SEL_RSEL_MASK_;
-	dp_sel |= ram_select;
-	ret = lan78xx_write_reg(dev, DP_SEL, dp_sel);
+	ret = lan78xx_update_reg(dev, DP_SEL, DP_SEL_RSEL_MASK_, ram_select);
+	if (ret < 0)
+		goto dataport_write;
 
 	for (i = 0; i < length; i++) {
 		ret = lan78xx_write_reg(dev, DP_ADDR, addr + i);
+		if (ret < 0)
+			goto dataport_write;
 
 		ret = lan78xx_write_reg(dev, DP_DATA, buf[i]);
+		if (ret < 0)
+			goto dataport_write;
 
 		ret = lan78xx_write_reg(dev, DP_CMD, DP_CMD_WRITE_);
+		if (ret < 0)
+			goto dataport_write;
 
 		ret = lan78xx_dataport_wait_not_busy(dev);
 		if (ret < 0)
-			goto done;
+			goto dataport_write;
 	}
 
-done:
+dataport_write:
+	if (ret < 0)
+		netdev_warn(dev->net, "dataport write failed %pe", ERR_PTR(ret));
+
 	mutex_unlock(&pdata->dataport_mutex);
 	usb_autopm_put_interface(dev->intf);
 
@@ -1454,23 +1461,39 @@ static void lan78xx_deferred_multicast_write(struct work_struct *param)
 	struct lan78xx_priv *pdata =
 			container_of(param, struct lan78xx_priv, set_multicast);
 	struct lan78xx_net *dev = pdata->dev;
-	int i;
+	int i, ret;
 
 	netif_dbg(dev, drv, dev->net, "deferred multicast write 0x%08x\n",
 		  pdata->rfe_ctl);
 
-	lan78xx_dataport_write(dev, DP_SEL_RSEL_VLAN_DA_, DP_SEL_VHF_VLAN_LEN,
-			       DP_SEL_VHF_HASH_LEN, pdata->mchash_table);
+	ret = lan78xx_dataport_write(dev, DP_SEL_RSEL_VLAN_DA_,
+				     DP_SEL_VHF_VLAN_LEN,
+				     DP_SEL_VHF_HASH_LEN, pdata->mchash_table);
+	if (ret < 0)
+		goto multicast_write_done;
 
 	for (i = 1; i < NUM_OF_MAF; i++) {
-		lan78xx_write_reg(dev, MAF_HI(i), 0);
-		lan78xx_write_reg(dev, MAF_LO(i),
-				  pdata->pfilter_table[i][1]);
-		lan78xx_write_reg(dev, MAF_HI(i),
-				  pdata->pfilter_table[i][0]);
+		ret = lan78xx_write_reg(dev, MAF_HI(i), 0);
+		if (ret < 0)
+			goto multicast_write_done;
+
+		ret = lan78xx_write_reg(dev, MAF_LO(i),
+					pdata->pfilter_table[i][1]);
+		if (ret < 0)
+			goto multicast_write_done;
+
+		ret = lan78xx_write_reg(dev, MAF_HI(i),
+					pdata->pfilter_table[i][0]);
+		if (ret < 0)
+			goto multicast_write_done;
 	}
 
-	lan78xx_write_reg(dev, RFE_CTL, pdata->rfe_ctl);
+	ret = lan78xx_write_reg(dev, RFE_CTL, pdata->rfe_ctl);
+
+multicast_write_done:
+	if (ret < 0)
+		netdev_warn(dev->net, "multicast write failed %pe", ERR_PTR(ret));
+	return;
 }
 
 static void lan78xx_set_multicast(struct net_device *netdev)
-- 
2.39.5


