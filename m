Return-Path: <linux-kernel+bounces-220135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7745D90DD0F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3F9B1F25B75
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E9D16F0DD;
	Tue, 18 Jun 2024 20:09:15 +0000 (UTC)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1760D16EB4C;
	Tue, 18 Jun 2024 20:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.161.129.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718741355; cv=none; b=Q9TS+dgL1Cep1TKUvh8FsZOiXx4EPfO5LrOlg4xp7D9NFh8rPmvlmAiX5oCm4lAjAbg+UT/RWMqpoAsbierSu6At/a5XZPhaQw8U7XPLeu0lMMkPjIZR6CCnssIe5shem/agkcloYm2lmDIN9UFSoUSUlQgZ31mXT+3KA6IiRGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718741355; c=relaxed/simple;
	bh=HusffwDsMPay0/AAIgmkfA00BgBP5M8pFivip4rJ6Wc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hCFek0iwZPpwBc1JpON6SzfXyeutHrXkVyoVBFN1Yj0Nx63oWg918A0gHzPkqq5p/FPN40Q9Jrpu2uRu+opmJf8qoBoxBXlA26/2GXDYA9iGefg1YoOQ3VS7/MEo24VOqcLwIjnS2ri3zxuMl3i9Z0j/ZXbCweD1UtwhSY2blCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; arc=none smtp.client-ip=108.161.129.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
	by finn.localdomain with esmtp (Exim 4.95)
	(envelope-from <tharvey@gateworks.com>)
	id 1sJf8c-00D7Xy-CC;
	Tue, 18 Jun 2024 20:09:06 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] arm64: dts: imx8mp-venice-gw74xx: add DP83867 configuration
Date: Tue, 18 Jun 2024 13:09:01 -0700
Message-Id: <20240618200900.1741251-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GW7400 has an onboard DP83867 RGMII GbE PHY:
 - add RGMII delay and FIFO configuration
 - add LED configuration required to use them via netdev trigger:
   two LED's (LED1 and LED2, skipping LED0).

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 .../dts/freescale/imx8mp-venice-gw74xx.dts    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
index a77e9a44d9fa..d765b7972841 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
@@ -9,6 +9,7 @@
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/phy/phy-imx8-pcie.h>
+#include <dt-bindings/net/ti-dp83867.h>
 
 #include "imx8mp.dtsi"
 
@@ -225,6 +226,29 @@ mdio {
 		ethphy0: ethernet-phy@0 {
 			compatible = "ethernet-phy-ieee802.3-c22";
 			reg = <0x0>;
+			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+			tx-fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+			rx-fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+
+			leds {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				led@1 {
+					reg = <1>;
+					color = <LED_COLOR_ID_AMBER>;
+					function = LED_FUNCTION_LAN;
+					default-state = "keep";
+				};
+
+				led@2 {
+					reg = <2>;
+					color = <LED_COLOR_ID_GREEN>;
+					function = LED_FUNCTION_LAN;
+					default-state = "keep";
+				};
+			};
 		};
 	};
 };
-- 
2.25.1


