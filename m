Return-Path: <linux-kernel+bounces-437639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4939E965D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C022809E4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F7A22FE23;
	Mon,  9 Dec 2024 13:08:08 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DB61C5CA6
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 13:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749683; cv=none; b=DXrSdoibbP+Bdp5/7LHaZX3jgGNa1q8M4uvhYffPR1RYr0PDlrMFiKqiWVUXzhJW7d1Oai3lOujHOzJ55fakpg/wUNCfg03H7vAynwg3a12jtHQkPVVdbVSWXNlCKp0OGMJVBlOcOlsii67/6BvULw45dbII4+YQKSANA3VPEyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749683; c=relaxed/simple;
	bh=84clEU0P/5CbvPrnaLag9WOQh/98lXhngHyQ/rKGNEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LtuIU5dQyvA5AUy/n2qY5L8F+bABZN1RNQLNouBZVf3DetJMsg96Bgp/FH+OOpqRQZrfBm1bQqPHgAOaVu8qVdnH/sP+7Xgmyv2Gp+++DrrZjR1CCj20ilmc1RKmVwQfg0JX0TWNrEYtDfsPAp0IQIInYb7IOXPrWLIRzDF8AtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tKdUP-0004R9-PK; Mon, 09 Dec 2024 14:07:53 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tKdUN-002W7I-1U;
	Mon, 09 Dec 2024 14:07:52 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tKdUO-002wws-0X;
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
Subject: [PATCH net-next v1 01/11] net: usb: lan78xx: Add error handling to lan78xx_setup_irq_domain
Date: Mon,  9 Dec 2024 14:07:41 +0100
Message-Id: <20241209130751.703182-2-o.rempel@pengutronix.de>
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

Update `lan78xx_setup_irq_domain` to handle errors in
`lan78xx_read_reg`.  Return the error code immediately if the read
operation fails, ensuring proper error propagation during IRQ domain
setup.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index d5f6367d3714..070b21baffaf 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2445,7 +2445,10 @@ static int lan78xx_setup_irq_domain(struct lan78xx_net *dev)
 
 	mutex_init(&dev->domain_data.irq_lock);
 
-	lan78xx_read_reg(dev, INT_EP_CTL, &buf);
+	ret = lan78xx_read_reg(dev, INT_EP_CTL, &buf);
+	if (ret < 0)
+		return ret;
+
 	dev->domain_data.irqenable = buf;
 
 	dev->domain_data.irqchip = &lan78xx_irqchip;
-- 
2.39.5


