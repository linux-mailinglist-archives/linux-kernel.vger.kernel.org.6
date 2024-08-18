Return-Path: <linux-kernel+bounces-291205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C63955EF2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 22:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0E081F212F7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 20:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C68154C0D;
	Sun, 18 Aug 2024 20:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="vy6UZVBA"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E405200CD;
	Sun, 18 Aug 2024 20:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724013046; cv=none; b=ro43ZSja26E0GIuSsPRSoKva8gZ22hTrmgyhnKKUR0anDHNKKX7A6FDNmdIFcDCUxNi4pwnGoJUCCdDnv8YLQZKP4rf4boezwo8UQ7rRgbc/TfyLmdmSa4J/C6Pth80dLhLiG7UZUEuwJM0fw6qvWXtThCn3XXj6WaXNL3nMnPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724013046; c=relaxed/simple;
	bh=Hl6qAeZvINDhDu7tKwMdDNaKbGCCcI1IRwdD8boZ9Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MmNj+u4y95m/Np1gx2tbKwjd8zK7NKNZ9qmfWKw495hk/zTVP7iDwFDZ9EEHNksD2soxDLxfnJ8OEiAhJNWZ/L9vMqXx1x583XC1d+PgUB2c9WRf+mj8Ot2NbNT/oOsEiN59jc9r0jEVSi93kfDq/4T7aJaFFjKBh8/P4mPDHwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=vy6UZVBA; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 1B4C188327;
	Sun, 18 Aug 2024 22:30:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724013043;
	bh=7xIgYijK665mw+L20ZwNTLirHIg14AUnO12zxZjB2RQ=;
	h=From:To:Cc:Subject:Date:From;
	b=vy6UZVBAwi7B0sIhY7fHNZuclj2NiTKCYkcbkG6w9/EghWmM/dmHCSQR4ZUbsI1le
	 eBDgEtv8G0zlElh3UNKULjN0J14VCsuiXq2LqOYbebpaZUfW57zkzaVtQSebT1b5lv
	 Xs5bdY9TLOaPkCeUOiOLMDnhG3E7eYLyYOvDceZfQE2pc5Aj7UGu2Ayr7DNQ+wIX6K
	 E7E0Zb8pA0tNQotC3im9Bvzeg6pl3oKwSlPA99GG7iwNPETlD6un9FjgPV6JVYW1nT
	 sHl1JWihdezsyZrpkcBm33+S0wYm5Vz3B4YB4jxfa8Xx3C3xn6okj0gYJSEd8kEkCy
	 pEEtAhWVOalBA==
From: Marek Vasut <marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marex@denx.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mm: Update Data Modul i.MX8M Mini eDM SBC DT to rev.A01
Date: Sun, 18 Aug 2024 22:29:52 +0200
Message-ID: <20240818203029.96035-1-marex@denx.de>
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

Update the DT to match newest Data Modul i.MX8M Mini eDM SBC rev.A01
board which implements PHY changes. Keep some of the rev.900 PHY node
in the DT so that a DTO can be used to support rev.900 boards easily.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 .../freescale/imx8mm-data-modul-edm-sbc.dts   | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dts b/arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dts
index b1f2beb40a98f..472c584fb3bd2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dts
@@ -168,7 +168,7 @@ &fec1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec1>;
 	phy-mode = "rgmii-id";
-	phy-handle = <&fec1_phy>;
+	phy-handle = <&fec1_phy_bcm>;
 	phy-supply = <&buck4_reg>;
 	fsl,magic-packet;
 	status = "okay";
@@ -178,7 +178,7 @@ mdio {
 		#size-cells = <0>;
 
 		/* Atheros AR8031 PHY */
-		fec1_phy: ethernet-phy@0 {
+		fec1_phy_ath: ethernet-phy@0 {
 			compatible = "ethernet-phy-ieee802.3-c22";
 			reg = <0>;
 			/*
@@ -191,6 +191,7 @@ fec1_phy: ethernet-phy@0 {
 			reset-deassert-us = <10000>;
 			qca,keep-pll-enabled;
 			vddio-supply = <&vddio>;
+			status = "disabled";
 
 			vddio: vddio-regulator {
 				regulator-name = "VDDIO";
@@ -202,6 +203,20 @@ vddh: vddh-regulator {
 				regulator-name = "VDDH";
 			};
 		};
+
+		/* Broadcom BCM54213PE PHY */
+		fec1_phy_bcm: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+			/*
+			 * Dedicated ENET_INT# and ENET_WOL# signals are
+			 * unused, the PHY does not provide cable detect
+			 * interrupt.
+			 */
+			reset-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <10000>;
+		};
 	};
 };
 
-- 
2.43.0


