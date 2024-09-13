Return-Path: <linux-kernel+bounces-327800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5A7977B59
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 10:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4B21F21A7A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF001D6C7D;
	Fri, 13 Sep 2024 08:40:54 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E166F1D6C5F
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 08:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726216854; cv=none; b=i72eLYar6woTD62/kxLJumTCU4Yz4zAOGZwpinwkt1B2FyVZwdP3rh9iqZKS3qeACPHtbBndIyv8e3mxaPzM+TuqIW/JvxAz9930PpuHSdmO3FG/+S7xhfs8zvr0Z1zXLHJmwU90Pjp+IKiV0oMzlNlFTliYcPgZU9gmkRklJAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726216854; c=relaxed/simple;
	bh=bodaKALT9TM72QCQde0I+7qUFSBBobplX4Jvc2+Rz9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aY/ltv9MErIBRQIt6V5T7bbh77g+EZaJhlvyptNNycGsQnXNtP7Uoif4G1RdtuVqnt+R0jd6UyRaza5Mo4fWUgO2tGutyi6I4O5h9BEXYk+hIrhPzGbiDVhEQ5cJzpuACWQE+kj1OZOUNGpOqyhteRoZqfw5lg8uNNmdZq51bas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sp1qr-0005n8-L3; Fri, 13 Sep 2024 10:40:25 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sp1qp-007a7Y-SH; Fri, 13 Sep 2024 10:40:23 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sp1qp-00E1uS-2b;
	Fri, 13 Sep 2024 10:40:23 +0200
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
Subject: [PATCH net-next v3 1/2] dt-bindings: net: ethernet-phy: Add timing-role role property for ethernet PHYs
Date: Fri, 13 Sep 2024 10:40:21 +0200
Message-Id: <20240913084022.3343903-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240913084022.3343903-1-o.rempel@pengutronix.de>
References: <20240913084022.3343903-1-o.rempel@pengutronix.de>
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

This patch introduces a new `timing-role` property in the device tree
bindings for configuring the master/slave role of PHYs. This is
essential for scenarios where hardware strap pins are unavailable or
incorrectly configured.

The `timing-role` property supports the following values:
- `force-master`: Forces the PHY to operate as a master (clock source).
- `force-slave`: Forces the PHY to operate as a slave (clock receiver).
- `prefer-master`: Prefers the PHY to be master but allows negotiation.
- `prefer-slave`: Prefers the PHY to be slave but allows negotiation.

The terms "master" and "slave" are retained in this context to align
with the IEEE 802.3 standards, where they are used to describe the roles
of PHY devices in managing clock signals for data transmission. In
particular, the terms are used in specifications for 1000Base-T and
MultiGBASE-T PHYs, among others. Although there is an effort to adopt
more inclusive terminology, replacing these terms could create
discrepancies between the Linux kernel and the established standards,
documentation, and existing hardware interfaces.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v3:
- rename "master-slave" to "timing-role"
changes v2:
- use string property instead of multiple flags
---
 .../devicetree/bindings/net/ethernet-phy.yaml | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index d9b62741a2259..da9eaa811d70f 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -158,6 +158,27 @@ properties:
       Mark the corresponding energy efficient ethernet mode as
       broken and request the ethernet to stop advertising it.
 
+  timing-role:
+    $ref: /schemas/types.yaml#/definitions/string
+    enum:
+      - force-master
+      - force-slave
+      - prefer-master
+      - prefer-slave
+    description: |
+      Specifies the timing role of the PHY in the network link. This property is
+      required for setups where the role must be explicitly assigned via the
+      device tree due to limitations in hardware strapping or incorrect strap
+      configurations.
+      It is applicable to Single Pair Ethernet (1000/100/10Base-T1) and other
+      PHY types, including 1000Base-T, where it controls whether the PHY should
+      be a master (clock source) or a slave (clock receiver).
+
+      - 'force-master': The PHY is forced to operate as a master.
+      - 'force-slave': The PHY is forced to operate as a slave.
+      - 'prefer-master': Prefer the PHY to be master but allow negotiation.
+      - 'prefer-slave': Prefer the PHY to be slave but allow negotiation.
+
   pses:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     maxItems: 1
-- 
2.39.2


