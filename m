Return-Path: <linux-kernel+bounces-551757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3B3A5706A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01E45172020
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FB8242912;
	Fri,  7 Mar 2025 18:24:45 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154E024113E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 18:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741371885; cv=none; b=T16OaPZIHSNDHGaipAu6d03JLwRAhJlBBNj6uy2lI4lwziaPY0rOmy/cEzYVy+f2FDQn4bEPMHZyIfxLxX4OnhLInAoqnYH5v4w7OCb7xbHNrcJbR8cB8drvKwrbHtrLvLyHlq6KH0T76EqFFr/Ph0eSa4lyTXh311UCKVlelxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741371885; c=relaxed/simple;
	bh=3zQODCj91Annb2ILv14PDvD0wf3PPVRbsDlLrs7AMhk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mqQSf7YVKkykVzpal8y8PlwFeIa0EXNOaadCzKa2iqy0U3yZPfG47sqNLoJPfiJVHFjsWHde66UxSBDAQBMm8HzWN3sgXWUa2/+HV6owjgF6NLpSaPBZEBW4KslGg0D8vs8xoM+UXniqLxGadkZJ7tYm1G9PLvKKN+3JXkL+6b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tqcN9-0005mZ-4x; Fri, 07 Mar 2025 19:24:35 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tqcN7-004X2R-1U;
	Fri, 07 Mar 2025 19:24:33 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tqcN7-008I88-1E;
	Fri, 07 Mar 2025 19:24:33 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH net-next v2 0/7] Convert LAN78xx to PHYLINK
Date: Fri,  7 Mar 2025 19:24:25 +0100
Message-Id: <20250307182432.1976273-1-o.rempel@pengutronix.de>
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

This patch series refactors the LAN78xx USB Ethernet driver to use the
PHYLINK API.

Oleksij Rempel (7):
  net: usb: lan78xx: Convert to PHYlink for improved PHY and MAC
    management
  net: usb: lan78xx: Move fixed PHY cleanup to lan78xx_unbind()
  net: usb: lan78xx: Improve error handling for PHY init path
  net: usb: lan78xx: Use ethtool_op_get_link to reflect current link
    status
  net: usb: lan78xx: port link settings to phylink API
  net: usb: lan78xx: Transition get/set_pause to phylink
  net: usb: lan78xx: Integrate EEE support with phylink LPI API

 drivers/net/usb/lan78xx.c | 827 +++++++++++++++++++-------------------
 1 file changed, 412 insertions(+), 415 deletions(-)

--
2.39.5


