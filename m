Return-Path: <linux-kernel+bounces-447292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2839F3025
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBCBF7A1D68
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D9B204F84;
	Mon, 16 Dec 2024 12:09:57 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6962046A6
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734350997; cv=none; b=VM+/yQ1BYCVnUGukAIjw9mWpjIISBKLhLccTY/7uyFHiQ1nvPYRJ09y7AIwR7PCxCnHTMNuCkWX3GhSyXv0BRRuYCa6vZMGehCN0ekTkbX27jhV7znKrheoLZ6onwxWoiCifuKhfr0iKsMzxbfiXo318BjyfKzc0d4k93Puqeng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734350997; c=relaxed/simple;
	bh=HG96b/psQssvqbO5CnyvMgZMRAFESvWwHNiJG+gNET8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FmAEnBhGua49h1LN8hFrJN5wfvMEQr0xUoJc2uG7EtGdd9rRZLMQPb78oUXuNVi7z6WJ+bOsJom7dLpxnnk9rKZlcAzElAuSjKZy/VSKwjjtl0Th2HgZFvecaada58vIrrIyF5HlOV3pVkiLCYPcDJl5TVK9sTWmGGoJSi2AI8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tN9v1-0001C1-9G; Mon, 16 Dec 2024 13:09:47 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tN9uw-003h1g-26;
	Mon, 16 Dec 2024 13:09:43 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tN9ux-0075tV-17;
	Mon, 16 Dec 2024 13:09:43 +0100
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
Subject: [PATCH net-next v1 0/6] lan78xx: Preparations for PHYlink
Date: Mon, 16 Dec 2024 13:09:35 +0100
Message-Id: <20241216120941.1690908-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
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

This patch set is a third part of the preparatory work for migrating
the lan78xx USB Ethernet driver to the PHYlink framework. During
extensive testing, I observed that resetting the USB adapter can lead to
various read/write errors. While the errors themselves are acceptable,
they generate excessive log messages, resulting in significant log spam.
This set improves error handling to reduce logging noise by addressing
errors directly and returning early when necessary.

Oleksij Rempel (6):
  net: usb: lan78xx: Add error handling to lan78xx_get_regs
  net: usb: lan78xx: Use ETIMEDOUT instead of ETIME in lan78xx_stop_hw
  net: usb: lan78xx: Use action-specific label in lan78xx_mac_reset
  net: usb: lan78xx: rename phy_mutex to mdiobus_mutex
  net: usb: lan78xx: remove PHY register access from ethtool get_regs
  net: usb: lan78xx: Improve error handling in WoL operations

 drivers/net/usb/lan78xx.c | 73 +++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 33 deletions(-)

--
2.39.5


