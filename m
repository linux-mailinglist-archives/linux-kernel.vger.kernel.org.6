Return-Path: <linux-kernel+bounces-430792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7DC9E35A8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075BF16572E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04D7198A05;
	Wed,  4 Dec 2024 08:41:53 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC756196434
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 08:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733301713; cv=none; b=Lo6g3xMGWu6i0U29QbbX4gcnpUHMY3nIqc1TwM5/X6qDrswOMGdYClKPZfYbZRBuQlh6wHpieIpQ2Pa9bkRh4YFyugmwyABvsjzcOnaF2CbK6Xyu8hmuiv98srbLOdRcefrXLj1YbjVEplAWo5jqhrYausUKe7zotgdSNsBQ8ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733301713; c=relaxed/simple;
	bh=IKDPfExthKtx+seYruE/9nS6YGL3LxsWsGO3Vnufd+w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pG9+bp3wvMOBUq2eO3YySsw1DEba5iLPXsTZ428/vv+2wVKUFAtM0n+Rq1f0hmYr8jFvzuve0c6pwcf9+AOw0GW7eTVZbeIaHDxnzQrsqCPxK8c3MvLy0Noxl9odv/YxeDh8DoiZeDXdyw8RghrZHd7htcb/EKeCPihkQ7vQMAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tIkx7-0001Hz-42; Wed, 04 Dec 2024 09:41:45 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tIkx5-001cU6-0H;
	Wed, 04 Dec 2024 09:41:43 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tIkx5-004psV-2X;
	Wed, 04 Dec 2024 09:41:43 +0100
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
Subject: [PATCH net-next v2 00/21] lan78xx: Preparations for PHYlink
Date: Wed,  4 Dec 2024 09:41:32 +0100
Message-Id: <20241204084142.1152696-1-o.rempel@pengutronix.de>
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

changes v2:
- split the patch set.

This patch set is part of the preparatory work for migrating the lan78xx
USB Ethernet driver to the PHYlink framework. During extensive testing,
I observed that resetting the USB adapter can lead to various read/write
errors. While the errors themselves are acceptable, they generate
excessive log messages, resulting in significant log spam. This set
improves error handling to reduce logging noise by addressing errors
directly and returning early when necessary.

Key highlights of this series include:
- Enhanced error handling to reduce log spam while preserving the
  original error values, avoiding unnecessary overwrites.
- Improved error reporting using the `%pe` specifier for better clarity
  in log messages.
- Removal of redundant and problematic PHY fixups for LAN8835 and
  KSZ9031, with detailed explanations in the respective patches.
- Cleanup of code structure, including unified `goto` labels for better
  readability and maintainability, even in simple editors.

Oleksij Rempel (10):
  net: usb: lan78xx: Remove LAN8835 PHY fixup
  net: usb: lan78xx: Remove KSZ9031 PHY fixup
  net: usb: lan78xx: move functions to avoid forward definitions
  net: usb: lan78xx: Improve error reporting with %pe specifier
  net: usb: lan78xx: Fix error handling in MII read/write functions
  net: usb: lan78xx: Improve error handling in EEPROM and OTP operations
  net: usb: lan78xx: Add error handling to lan78xx_init_ltm
  net: usb: lan78xx: Add error handling to set_rx_max_frame_length and
    set_mtu
  net: usb: lan78xx: Add error handling to lan78xx_irq_bus_sync_unlock
  net: usb: lan78xx: Improve error handling in dataport and multicast
    writes

 drivers/net/usb/lan78xx.c | 785 +++++++++++++++++++++-----------------
 1 file changed, 433 insertions(+), 352 deletions(-)

--
2.39.5


