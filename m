Return-Path: <linux-kernel+bounces-437635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0D69E966C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB60188388F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1101C5CCB;
	Mon,  9 Dec 2024 13:08:03 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542771C5CA8
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 13:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749682; cv=none; b=TkftyF9Rv/eABkVLq+rjUt7VshuFqWR2kCWo56OnxGpism9WQDqhOh+VN6olgL5RR6UyvmLC7RDXLcj0jZvXYMD0Z5jJ14sfbrA9LOvxQxx3ugIkr94pZ2iqoERFk/PAijFWv+yQRUn6VYFe7m1q/0E9uyQjpm8guyXVvgseGOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749682; c=relaxed/simple;
	bh=T4r5FGidFDsRUMmlpRvTUjhC9fAyg9vx234rsbBtpLc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UCmB71LscU0DapdJADTdB2UNTbjFEm3IpAGo5H2guk1AmkriMFZjkotWOM7jGJbuvl0C4lM211B/+bBGeiVJNvIuSY42ULV6GPosLVxDcRRFBTa/YwFzk7n7/DCxZsTydsFSpVOd8NdonhkvxVnU2BWVDTNB6ZlSF6MS/iGxibA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tKdUP-0004R8-PL; Mon, 09 Dec 2024 14:07:53 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tKdUN-002W7H-1Q;
	Mon, 09 Dec 2024 14:07:52 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tKdUO-002wwi-0S;
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
Subject: [PATCH net-next v1 00/11] lan78xx: Preparations for PHYlink
Date: Mon,  9 Dec 2024 14:07:40 +0100
Message-Id: <20241209130751.703182-1-o.rempel@pengutronix.de>
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

This patch set is a second part of the preparatory work for migrating
the lan78xx USB Ethernet driver to the PHYlink framework. During
extensive testing, I observed that resetting the USB adapter can lead to
various read/write errors. While the errors themselves are acceptable,
they generate excessive log messages, resulting in significant log spam.
This set improves error handling to reduce logging noise by addressing
errors directly and returning early when necessary.

Oleksij Rempel (11):
  net: usb: lan78xx: Add error handling to lan78xx_setup_irq_domain
  net: usb: lan78xx: Add error handling to lan78xx_init_mac_address
  net: usb: lan78xx: Add error handling to lan78xx_set_mac_addr
  net: usb: lan78xx: Add error handling to lan78xx_get_regs
  net: usb: lan78xx: Simplify lan78xx_update_reg
  net: usb: lan78xx: Fix return value handling in lan78xx_set_features
  net: usb: lan78xx: Use ETIMEDOUT instead of ETIME in lan78xx_stop_hw
  net: usb: lan78xx: Use function-specific label in lan78xx_mac_reset
  net: usb: lan78xx: Improve error handling in lan78xx_phy_wait_not_busy
  net: usb: lan78xx: Rename lan78xx_phy_wait_not_busy to
    lan78xx_mdiobus_wait_not_busy
  net: usb: lan78xx: Improve error handling in WoL operations

 drivers/net/usb/lan78xx.c | 137 +++++++++++++++++++++++++-------------
 1 file changed, 89 insertions(+), 48 deletions(-)

--
2.39.5


