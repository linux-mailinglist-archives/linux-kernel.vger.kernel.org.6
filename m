Return-Path: <linux-kernel+bounces-231707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD2A919C7E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 03:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC0C286733
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 01:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1D74C8F;
	Thu, 27 Jun 2024 00:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="P1niESfD"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49342211C;
	Thu, 27 Jun 2024 00:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719449990; cv=none; b=s2m0HPbCm7si/zyICKx6M3/yGyzoU3xvYTfdHoGUKpnXia/W0JQ6PMmDqPtKqkO3Ju3nR94lDYeQSqvpe3j2vp9rN6qBElQlncUlxm93qYXvvqS8wAxTNP3mcFZvLHF6nEpltloFE4xUBg5KKNuOA/oSzO0noYFqMjoi544pCUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719449990; c=relaxed/simple;
	bh=9fYE1HBswViCYV0y+jxuGrMG4f2awfEsQnVMXDNZN3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YAJ+CUdEYccJdC0HzmLObEO/08CMz97ReEECp2pDJGX4EXhG7Shj2j6HhfH3ypX4C78uiIjoxAUFARBfHdrwH4yENcnWr5PZo16oYc/qc0XDkiawNTTHruD/rOTFaA8HYyqIYPC7G2YZZuQpz0nDn4VO3ezZ4r+sAuXn4Siz//Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=P1niESfD; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 1880688495;
	Thu, 27 Jun 2024 02:59:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719449981;
	bh=nRRMgVYz5K221YS3EHiDdmRYJ/Cn0uzB+xd7+Lhx9eU=;
	h=From:To:Cc:Subject:Date:From;
	b=P1niESfDnRF6termPh465JrMUGDWB2ib+XYW9uOtEH6gHeuqVoaxJOPKes8SSo3Im
	 dkvRrMqPkA0x2zhXnXMlTKDquDUOCm+0tlbzAVWvhEJtBbVD4mLau2cYBNN+PvqcPa
	 9tcamKLWu1BC5IgD/yADhvGdh+VYpjShhoRGF39GNHy5IYBnD7ShlTolTFUMxJID4w
	 5+Tn2/mcnv9vGIl/E9s7N+m9M8O9a1dUZQ6a8gA/lTlMCV7TnCf5mX3pVHY8DnDCSr
	 LuvoLf9eL240GBcn9wyG8gukuh2Wba7yx1XUf4gxdXUIWyv4gdVcNly4gUp9RJ6rsB
	 BP8Zk4zbS/KJA==
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
	kernel@dh-electronics.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mp: Update Fast ethernet PHY MDIO addresses to match DH i.MX8MP DHCOM rev.200
Date: Thu, 27 Jun 2024 02:58:33 +0200
Message-ID: <20240627005913.326662-1-marex@denx.de>
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
Cc: kernel@dh-electronics.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
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


