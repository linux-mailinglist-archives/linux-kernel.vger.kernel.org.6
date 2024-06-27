Return-Path: <linux-kernel+bounces-232311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7148B91A6AD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 199671F2652D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59ED415ECE8;
	Thu, 27 Jun 2024 12:39:32 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE2A15A85D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719491971; cv=none; b=BW7bTlaTWkmOXbEYzyPMeF+0aITrdW8k0LLVe9yhpbTnhXag6aZhk8y4OSbhuw8WqV3+aFHfRIce3Kc2BsreJ8CgEcixNv5NCIe/06b4KT3DvCwFSHOYcGA6owl7X1AmV4Rb2nzZHfzd2x0evEzPS43vHDvasLOV0ICww4rv1Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719491971; c=relaxed/simple;
	bh=EqB6SmNdeXubFO++XFjnHXgMkng6+TrWjBXTPnVGYUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YWyuxEOIEQKew7diaFYHuQRL31nNlNN3zFn8tUe6sJq9M0reyrG61KZZVJex0Lx1w5oN/5wd8UJj/YlXJtHRUwtlZ9hdR+S1soZIhWEe2hgfgJtNo605MxKKFeg6S1T2pJDMst/oEldkdslAlc6eNijI3c6/aWcOVR8KAa29GFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sMoPC-00015D-7f; Thu, 27 Jun 2024 14:39:14 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sMoPA-005Mwu-QG; Thu, 27 Jun 2024 14:39:12 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sMoPA-000xBz-2M;
	Thu, 27 Jun 2024 14:39:12 +0200
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
Subject: [PATCH net-next v1 3/3] net: dsa: microchip: lan937x: disable VPHY output
Date: Thu, 27 Jun 2024 14:39:11 +0200
Message-Id: <20240627123911.227480-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240627123911.227480-1-o.rempel@pengutronix.de>
References: <20240627123911.227480-1-o.rempel@pengutronix.de>
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

While the documented VPHY out-of-reset configuration should autonegotiate
the maximum supported link speed on the CPU interface, that doesn't work
on RGMII links, where the VPHY negotiates 100MBit speed. This causes the
RGMII TX interface to run with a wrong clock rate.

Disable the VPHY output altogether, so it doesn't interfere with the
CPU interface configuration set via fixed-link. The VPHY is a compatibility
functionality to be able to attach network drivers without fixed-link
support to the switch, which generally should not be needed with linux
network drivers.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/lan937x_main.c | 3 +++
 drivers/net/dsa/microchip/lan937x_reg.h  | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index b6ef48a655735..9cd3ff38ed66b 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -400,6 +400,9 @@ int lan937x_setup(struct dsa_switch *ds)
 	lan937x_cfg(dev, REG_SW_GLOBAL_OUTPUT_CTRL__1,
 		    (SW_CLK125_ENB | SW_CLK25_ENB), true);
 
+	/* disable VPHY output*/
+	ksz_rmw32(dev, REG_SW_CFG_STRAP_OVR, SW_VPHY_DISABLE, SW_VPHY_DISABLE);
+
 	return 0;
 }
 
diff --git a/drivers/net/dsa/microchip/lan937x_reg.h b/drivers/net/dsa/microchip/lan937x_reg.h
index e36bcb155f545..be553e23a964e 100644
--- a/drivers/net/dsa/microchip/lan937x_reg.h
+++ b/drivers/net/dsa/microchip/lan937x_reg.h
@@ -37,6 +37,10 @@
 #define SW_CLK125_ENB			BIT(1)
 #define SW_CLK25_ENB			BIT(0)
 
+/* 2 - PHY Control */
+#define REG_SW_CFG_STRAP_OVR		0x214
+#define SW_VPHY_DISABLE			BIT(31)
+
 /* 3 - Operation Control */
 #define REG_SW_OPERATION		0x0300
 
-- 
2.39.2


