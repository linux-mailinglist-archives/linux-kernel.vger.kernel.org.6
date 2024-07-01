Return-Path: <linux-kernel+bounces-235875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A365091DAAD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9D01F22FCD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC53B84A30;
	Mon,  1 Jul 2024 08:53:53 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9FD81749
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719824033; cv=none; b=kS4uFphBWWkKBMi8TQMfXyFmWUfjE2ivJynO4m0CTFjwbP+umIEA/ERiNOpGrbsaX5fZPSuZNIUqmto1rzirZdHQS5wJxTWfmy/gC6zKIscRBXwakxhIEiE1TIttGwOA07j/GQApUqEJucrw5FXyootsVTOp0O6eHT49Tw01enU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719824033; c=relaxed/simple;
	bh=5aS9mvQ/Irljen8wjikG89TM/g9nsYb8aM4QkYtKZPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QEjy9u//Tdb9PVXjkrDOu9BH1QOwsf6ViH1TAz60S66RL50Sa/HShJgFRJ9xpsFVH35bqOyrna48pziE9vTLD0xBDEibcsuf5lPvMPA+7ua2Xww1Qmvck9vOc5WD1EsAsrueibxaRhfK9Tqu2iou8r+b22MFi0oBAQmgrbJhROc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sOCnB-0006bE-92; Mon, 01 Jul 2024 10:53:45 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sOCnA-006Kdp-KC; Mon, 01 Jul 2024 10:53:44 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sOCnA-00ClWO-1m;
	Mon, 01 Jul 2024 10:53:44 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: [PATCH net-next v2 3/3] net: dsa: microchip: lan937x: disable VPHY support
Date: Mon,  1 Jul 2024 10:53:43 +0200
Message-Id: <20240701085343.3042567-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240701085343.3042567-1-o.rempel@pengutronix.de>
References: <20240701085343.3042567-1-o.rempel@pengutronix.de>
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

From: Lucas Stach <l.stach@pengutronix.de>

As described by the microchip article "LAN937X - The required
configuration for the external MAC port to operate at RGMII-to-RGMII
1Gbps link speed." [1]:

"When VPHY is enabled, the auto-negotiation process following IEEE 802.3
standard will be triggered and will result in RGMII-to-RGMII signal
failure on the interface because VPHY will try to poll the PHY status
that is not available in the scenario of RGMII-to-RGMII connection
(normally the link partner is usually an external processor).

Note that when VPHY fails on accessing PHY registers, it will fall back
to 100Mbps speed, it indicates disabling VPHY is optional if you only
need the port to link at 100Mbps speed.

Again, VPHY must and can only be disabled by writing VPHY_DISABLE bit in
the register below as there is no strapping pin for the control."

This patch was tested on LAN9372, so far it seems to not to affect VPHY
based clock crossing optimization for the ports with integrated PHYs.

[1]: https://microchip.my.site.com/s/article/LAN937X-The-required-configuration-for-the-external-MAC-port-to-operate-at-RGMII-to-RGMII-1Gbps-link-speed

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v2:
- reword the comment and link microchip article
---
 drivers/net/dsa/microchip/lan937x_main.c | 3 +++
 drivers/net/dsa/microchip/lan937x_reg.h  | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index eaa862eb6b265..0606796b14856 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -390,6 +390,9 @@ int lan937x_setup(struct dsa_switch *ds)
 	lan937x_cfg(dev, REG_SW_GLOBAL_OUTPUT_CTRL__1,
 		    (SW_CLK125_ENB | SW_CLK25_ENB), true);
 
+	/* Disable global VPHY support. Related to CPU interface only? */
+	ksz_rmw32(dev, REG_SW_CFG_STRAP_OVR, SW_VPHY_DISABLE, SW_VPHY_DISABLE);
+
 	return 0;
 }
 
diff --git a/drivers/net/dsa/microchip/lan937x_reg.h b/drivers/net/dsa/microchip/lan937x_reg.h
index 7ecada9240233..2f22a9d01de36 100644
--- a/drivers/net/dsa/microchip/lan937x_reg.h
+++ b/drivers/net/dsa/microchip/lan937x_reg.h
@@ -37,6 +37,10 @@
 #define SW_CLK125_ENB			BIT(1)
 #define SW_CLK25_ENB			BIT(0)
 
+/* 2 - PHY Control */
+#define REG_SW_CFG_STRAP_OVR		0x0214
+#define SW_VPHY_DISABLE			BIT(31)
+
 /* 3 - Operation Control */
 #define REG_SW_OPERATION		0x0300
 
-- 
2.39.2


