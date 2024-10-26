Return-Path: <linux-kernel+bounces-382948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B869B156C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 08:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE0CDB21DAE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 06:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BE917BB03;
	Sat, 26 Oct 2024 06:36:02 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1230813792B
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 06:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729924561; cv=none; b=j/Rt0dYz3BhtCsWTdiXOL8aFIGbnh/OiI/2082SgDGYaBwKCB3tzowPwS55mVMLpMpt8NwwAz/Uxu3BamXjt4wEBiQ5UKTW0YzaxfBsic+cr63Gzmz8SuGhL5dOIzf7jzZT2vlJrtMz585dlHzfAFUkf4bFPPGZm51o82pbjYAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729924561; c=relaxed/simple;
	bh=PyA6XkLuW//YJHuLU9e9e+Uvse6PTMXkl5C2E+oqirI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n9aQKN9ZUcMZTZnYjC7VyJ3u+T7UF9uoHA3NrSK243BcCnK0BuoWfvLOELrCbig5XQ8rRR3DlDbzUnncsDeFblejTn/sr7HF3IMifcgpYdI+y1j2pFXVg7/PmUwYUaQs3Of8Ncq62FopekJtwAAOvsBh4FHW3HXXum5gpbwPhlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1t4aOj-0006kD-1l; Sat, 26 Oct 2024 08:35:41 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t4aOh-000UfO-0Y;
	Sat, 26 Oct 2024 08:35:39 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t4aOh-00AVyn-0E;
	Sat, 26 Oct 2024 08:35:39 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org
Subject: [PATCH net-next v1 4/5] net: dsa: microchip: cleanup error handling in ksz_mdio_register
Date: Sat, 26 Oct 2024 08:35:37 +0200
Message-Id: <20241026063538.2506143-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241026063538.2506143-1-o.rempel@pengutronix.de>
References: <20241026063538.2506143-1-o.rempel@pengutronix.de>
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

Replace repeated cleanup code with a single error path using a label.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz_common.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index bcd963191cb25..f08fa52dd1387 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2339,8 +2339,8 @@ static int ksz_mdio_register(struct ksz_device *dev)
 
 	bus = devm_mdiobus_alloc(ds->dev);
 	if (!bus) {
-		of_node_put(mdio_np);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto put_mdio_node;
 	}
 
 	if (dev->dev_ops->mdio_bus_preinit) {
@@ -2385,10 +2385,8 @@ static int ksz_mdio_register(struct ksz_device *dev)
 
 	if (dev->irq > 0) {
 		ret = ksz_irq_phy_setup(dev);
-		if (ret) {
-			of_node_put(mdio_np);
-			return ret;
-		}
+		if (ret)
+			goto put_mdio_node;
 	}
 
 	ret = devm_of_mdiobus_register(ds->dev, bus, mdio_np);
-- 
2.39.5


