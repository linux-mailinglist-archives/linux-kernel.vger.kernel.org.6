Return-Path: <linux-kernel+bounces-345398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263B498B5CB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A756FB20C42
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0DC1BD4E7;
	Tue,  1 Oct 2024 07:37:21 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3A921373
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 07:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727768241; cv=none; b=hFIWJ41roHy9NH30igxLIbgO2SfOc6ECtAcOr7UDHRvzeGfHzRhv/WwfTJ2TQBND+TlCCsJxAoHjldNWriovtju5ZJK8/k/fWwTNXa8uvmByvX6/udau1EMv+nOjlXeR6JlMw6dnxEalupF4C4KagJjx3Re7mzqHWE9Ax0lCqfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727768241; c=relaxed/simple;
	bh=9WvoJGBFvN9avF/K50FeTy3X1f/0FZg+ygaOvWgsgiA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sqzqVdLw3g49CpZPKZD2pi+F0Kr63yvb4wWsOXJWe9GLc1hkLKLXmRlXQZfpf/tiJbgKPz5NGTjl2sbrI6XDjPl5/RLBIIbKlv1rAMVtGg/hZatwNp10vLeIj+fVNLQ4uB87STg0Lcy5uw/cmrgLQoBUoxL4FfkEJNYspkHdhTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1svXRT-0006X0-74; Tue, 01 Oct 2024 09:37:07 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1svXRR-002p9q-Ib; Tue, 01 Oct 2024 09:37:05 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1svXRR-005pb2-1d;
	Tue, 01 Oct 2024 09:37:05 +0200
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
Subject: [PATCH net-next v4 0/2] net: phy: Support master-slave config via device tree
Date: Tue,  1 Oct 2024 09:37:02 +0200
Message-Id: <20241001073704.1389952-1-o.rempel@pengutronix.de>
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

This patch series adds support for configuring the master/slave role of
PHYs via the device tree. A new `master-slave` property is introduced in
the device tree bindings, allowing PHYs to be forced into either master
or slave mode. This is particularly necessary for Single Pair Ethernet
(SPE) PHYs (1000/100/10Base-T1), where hardware strap pins may not be
available or correctly configured, but it is applicable to all PHY
types.

changes v4:
- add Reviewed-by
- rebase against latest net-next

changes v3:
- rename  master-slave to timing-role
- add prefer-master/slave support

Oleksij Rempel (2):
  dt-bindings: net: ethernet-phy: Add timing-role role property for
    ethernet PHYs
  net: phy: Add support for PHY timing-role configuration via device
    tree

 .../devicetree/bindings/net/ethernet-phy.yaml | 21 ++++++++++++
 drivers/net/phy/phy-core.c                    | 33 +++++++++++++++++++
 drivers/net/phy/phy_device.c                  |  3 ++
 include/linux/phy.h                           |  1 +
 4 files changed, 58 insertions(+)

--
2.39.5


