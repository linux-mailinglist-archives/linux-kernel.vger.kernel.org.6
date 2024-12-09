Return-Path: <linux-kernel+bounces-437645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8040E9E9660
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20DA8282A77
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E331B4259;
	Mon,  9 Dec 2024 13:08:08 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573521C5CD8
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 13:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749686; cv=none; b=Qizm0eB75tFz59f98SYfxMy/jTg7kXrmnzcjoEYwaOBWUje4GGccZMZyyoKyCqzwCYMZiJhZD/U28+2ZAOwBxlG/avfr9WSuD7zNLl0dqGOvQLQnTnQiT2LZJZxdgBB/Ou99W/tbr9SMzxSSmazxPeHZ9H49IizFsxyrESjOvTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749686; c=relaxed/simple;
	bh=P4TjaIKGSZHezFy00zzFiYLSOnURtxLh21+nrJq0HhU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rJJPO5Rc7JNruzF9UxKcnPCrVQuQ/ekGhwVgRuk2JZkxcvkpwL+d0gDyDmwD++9cCq5mN/S0pyGN/+IS70NU1XnMuD+wI2uKL43ChvTTtcDHDPm2Z92QJ17nyp03d+6BdRiuGJYECQ9ss5szETBCLOqgI3bx2ZkHazNfgomdit8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tKdUT-0004RF-Ou; Mon, 09 Dec 2024 14:07:57 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tKdUN-002W7O-1s;
	Mon, 09 Dec 2024 14:07:52 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tKdUO-002wxk-0n;
	Mon, 09 Dec 2024 14:07:52 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH net-next v1 06/11] net: usb: lan78xx: Fix return value handling in lan78xx_set_features
Date: Mon,  9 Dec 2024 14:07:46 +0100
Message-Id: <20241209130751.703182-7-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241209130751.703182-1-o.rempel@pengutronix.de>
References: <20241209130751.703182-1-o.rempel@pengutronix.de>
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

Update `lan78xx_set_features` to correctly return the result of
`lan78xx_write_reg`. This ensures that errors during register writes
are propagated to the caller.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index b6e6c090a072..2966f7e63617 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2837,9 +2837,7 @@ static int lan78xx_set_features(struct net_device *netdev,
 
 	spin_unlock_irqrestore(&pdata->rfe_ctl_lock, flags);
 
-	lan78xx_write_reg(dev, RFE_CTL, pdata->rfe_ctl);
-
-	return 0;
+	return lan78xx_write_reg(dev, RFE_CTL, pdata->rfe_ctl);
 }
 
 static void lan78xx_deferred_vlan_write(struct work_struct *param)
-- 
2.39.5


