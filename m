Return-Path: <linux-kernel+bounces-233139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 106BC91B2C3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 01:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8EA51F2191F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 23:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D331A38F4;
	Thu, 27 Jun 2024 23:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="XXz+a+a6"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD8E1A2C34;
	Thu, 27 Jun 2024 23:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719531070; cv=none; b=d7cxEL4pEAa0C/xe2uWmtpmls5k2qWu+K/SeLJFQjpVoSurKeErljYFx3uQzOlehgQYA6Km+XFDAKKn5PBCPs7ufZxA4y1/fnBlzC/jDvhflDlREiyFAu83rRkqnPQkXTT6W0dtmvjal9cC80I1pFVxW0npo5JjheZeJ0AxD4qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719531070; c=relaxed/simple;
	bh=AZoGkoAdsxulyS4+UxFUqv44sLLbuy9KS1D6OsoJqPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GKy/TyE6qWVJthHcw/+98DHvFbVOV8fZJEb7XT6g1IlQPzj1unCqk2W94x+3uCWkcHeeG2RTmX7DcPmX1PGFAlfsrYlP0JlYJ6o5FH1SRsoP+QDnE4xQsIKnwcj8XaUTNll3QP81rAEO+ChlWEtpKlEjxCP6Y/ZpJa0r05YQy0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=XXz+a+a6; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 099118851E;
	Fri, 28 Jun 2024 01:31:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719531064;
	bh=4fEHdJjs1SpcSe5ouDCWC+X86QN5baJmT2JoBwn5kNM=;
	h=From:To:Cc:Subject:Date:From;
	b=XXz+a+a6WPc9a3RF+YxVadPdhfGlHM6FvYSjwE7dwwkeWH44Gr8QZBqpWnduXWGOY
	 1H703t6Pr/L25f90tChHfkPJaCJ1liXbXLkq40GGwMPWX2nVD7LlFItY0NfqLrhnTX
	 Ume6PDfiwL/Fm3cEbxj80uNrA+Sl58nzSWu4chalkYeV1OL5i0EfrdL+Pe1ziWQQsN
	 hJ8iVg40jzs1haqmY9/+xMsmIQSup4H59zIlExSMJSqrIV6vIMPBEKOLbxWezHWcK9
	 +3AkmxM4ZjLX3abL1XouAUiaAVW24VcZSt7RAZccvv0t7wWNyNUaEHC/p8XpqzfxAH
	 CKyiOzn6JWNrg==
From: Marek Vasut <marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marex@denx.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@dh-electronics.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: imx8mp: Update Fast ethernet PHY MDIO addresses to match DH i.MX8MP DHCOM rev.200
Date: Fri, 28 Jun 2024 01:30:09 +0200
Message-ID: <20240627233045.80551-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The production DH i.MX8MP DHCOM SoM rev.200 uses updated PHY MDIO addresses
for the Fast ethernet PHYs. Update the base SoM DT to cater for this change.
Prototype rev.100 SoM was never publicly available and was manufactured in
limited series, anything currently available is rev.200 or newer, so it is
safe to update the DT this way.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: kernel@dh-electronics.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
V2: Update the commit message, rev.100 SoM was a prototype that is not available
---
 arch/arm64/boot/dts/freescale/imx8mp-dhcom-som.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-dhcom-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-dhcom-som.dtsi
index 848df53c48685..4f7721a44daaa 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-dhcom-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-dhcom-som.dtsi
@@ -110,14 +110,14 @@ mdio {
 		#size-cells = <0>;
 
 		/* Up to one of these two PHYs may be populated. */
-		ethphy0f: ethernet-phy@0 { /* SMSC LAN8740Ai */
+		ethphy0f: ethernet-phy@1 { /* SMSC LAN8740Ai */
 			compatible = "ethernet-phy-id0007.c110",
 				     "ethernet-phy-ieee802.3-c22";
 			interrupt-parent = <&gpio3>;
 			interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
 			pinctrl-0 = <&pinctrl_ethphy0>;
 			pinctrl-names = "default";
-			reg = <0>;
+			reg = <1>;
 			reset-assert-us = <1000>;
 			reset-deassert-us = <1000>;
 			reset-gpios = <&ioexp 4 GPIO_ACTIVE_LOW>;
@@ -156,14 +156,14 @@ mdio {
 		#size-cells = <0>;
 
 		/* Up to one PHY may be populated. */
-		ethphy1f: ethernet-phy@1 { /* SMSC LAN8740Ai */
+		ethphy1f: ethernet-phy@2 { /* SMSC LAN8740Ai */
 			compatible = "ethernet-phy-id0007.c110",
 				     "ethernet-phy-ieee802.3-c22";
 			interrupt-parent = <&gpio4>;
 			interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
 			pinctrl-0 = <&pinctrl_ethphy1>;
 			pinctrl-names = "default";
-			reg = <1>;
+			reg = <2>;
 			reset-assert-us = <1000>;
 			reset-deassert-us = <1000>;
 			reset-gpios = <&gpio4 2 GPIO_ACTIVE_LOW>;
-- 
2.43.0


