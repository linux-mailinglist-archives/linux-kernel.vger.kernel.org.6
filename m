Return-Path: <linux-kernel+bounces-321370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E7F9719B9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7994C1C23127
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD391B7909;
	Mon,  9 Sep 2024 12:44:00 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AA21B5ECA
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 12:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725885839; cv=none; b=Mn6x5zvLKQ0w6EmiVHeA5U3xD+dF6TwI6U4japK/HK5WNp4dLEUIvkyhlBU7iJJLXj8MX0Mk7tV6TwtnRo3bBUsScw47/you6589MxdUnDo0Duwz7VgAoL3UHzsZpJ7k2IC1s6XPi4OAaEX/M5akhRD1urr2nYzlxSFwH2ndYlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725885839; c=relaxed/simple;
	bh=5ZfasuGQecKmB6utM0JJ6TbCaRt7dGK+/kI3kvv6TpU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X0A0hWZAD6WpgZ6cUG7widVMcuUsnuwAmYuhO3oRb+uSdHwOSYvKklRxh2zZkfxRDP648S+2gjgiMSR/+/XxMn1723dDgClN7HJmQa8Ud1iY2AClhp6OeUGTxzk3L/z65Ua9EAw4JRM1NKAAsi1uGaSvv8xubQZerRF+pW+cc2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sndk8-0001rD-Jx; Mon, 09 Sep 2024 14:43:44 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sndk6-006elL-PE; Mon, 09 Sep 2024 14:43:42 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sndk6-00BuMo-2H;
	Mon, 09 Sep 2024 14:43:42 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org
Subject: [PATCH net-next v2 0/2] net: phy: Support master-slave config via device tree
Date: Mon,  9 Sep 2024 14:43:39 +0200
Message-Id: <20240909124342.2838263-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
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

This patch series adds support for configuring the master/slave role of
PHYs via the device tree. A new `master-slave` property is introduced in
the device tree bindings, allowing PHYs to be forced into either master
or slave mode. This is particularly necessary for Single Pair Ethernet
(SPE) PHYs (1000/100/10Base-T1), where hardware strap pins may not be
available or correctly configured, but it is applicable to all PHY
types.

Oleksij Rempel (2):
  dt-bindings: net: ethernet-phy: Add master-slave role property for SPE
    PHYs
  net: phy: Add support for master-slave role configuration via device
    tree

 .../devicetree/bindings/net/ethernet-phy.yaml | 14 +++++++++
 drivers/net/phy/phy-core.c                    | 29 +++++++++++++++++++
 drivers/net/phy/phy_device.c                  |  3 ++
 include/linux/phy.h                           |  1 +
 4 files changed, 47 insertions(+)

--
2.39.2


