Return-Path: <linux-kernel+bounces-396155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BE19BC8AF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E7DE1F22D1E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2861C1CFEDB;
	Tue,  5 Nov 2024 09:10:08 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A631C3025
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730797807; cv=none; b=SQCwGRBU28NfsdVulZ2jEd+07CK+JS3wssXwEul0BLPc27aWRaO1op90Z2Y807nhSGby8o0IYRiW9VXdM0Q4dgQ1W9zpKE4l84ZVhpU2+aklZ9kiOZc+jgdze2uhwkijiZ+ERx6P8i/VnT/Tnymt0KTc64+JZqHM9PXkzxVwyUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730797807; c=relaxed/simple;
	bh=s78LXm8oVlRxWfFmr0IdFkBYHf7fRypjYC9GfgbS9lI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h9WAMSJklSpq6oQCjySQ1e8hCpshVvRqXAFhr3swpPUdg468P5K0R0KoVeMmSFnt/85wWLFlEMatAH8LMB5KI7/dJwNazzwFxUP/QBjwsg6clq9WpUtHTIjzKyo+Rjui15dvPs8EvHjLlbOfSJiGv90oZ2vh2VqBVwbbhqFfyu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1t8FZL-0003oL-Rq; Tue, 05 Nov 2024 10:09:47 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t8FZK-0027YS-18;
	Tue, 05 Nov 2024 10:09:46 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t8FZK-002ofR-0s;
	Tue, 05 Nov 2024 10:09:46 +0100
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
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org,
	Marek Vasut <marex@denx.de>
Subject: [PATCH net-next v3 0/6] Side MDIO Support for LAN937x Switches
Date: Tue,  5 Nov 2024 10:09:38 +0100
Message-Id: <20241105090944.671379-1-o.rempel@pengutronix.de>
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

This patch set introduces support for an internal MDIO bus in LAN937x
switches, enabling the use of a side MDIO channel for PHY management
while keeping SPI as the main interface for switch configuration.

changes v3:
- add "net: dsa: microchip: parse PHY config from device tree" patch

other changelogs are added to separate patches.

Oleksij Rempel (6):
  dt-bindings: net: dsa: ksz: add internal MDIO bus description
  dt-bindings: net: dsa: ksz: add mdio-parent-bus property for internal
    MDIO
  net: dsa: microchip: Refactor MDIO handling for side MDIO access
  net: dsa: microchip: cleanup error handling in ksz_mdio_register
  net: dsa: microchip: add support for side MDIO interface in LAN937x
  net: dsa: microchip: parse PHY config from device tree

 .../bindings/net/dsa/microchip,ksz.yaml       |  20 ++
 drivers/net/dsa/microchip/ksz_common.c        | 260 ++++++++++++++++--
 drivers/net/dsa/microchip/ksz_common.h        |  59 ++++
 drivers/net/dsa/microchip/lan937x.h           |   2 +
 drivers/net/dsa/microchip/lan937x_main.c      | 226 +++++++++++++--
 drivers/net/dsa/microchip/lan937x_reg.h       |   4 +
 6 files changed, 539 insertions(+), 32 deletions(-)

--
2.39.5


