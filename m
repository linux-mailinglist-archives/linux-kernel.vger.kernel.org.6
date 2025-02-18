Return-Path: <linux-kernel+bounces-518746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C56D4A393FA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76D427A3B8C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 07:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA69B1DB92E;
	Tue, 18 Feb 2025 07:42:55 +0000 (UTC)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A4D1D90DB;
	Tue, 18 Feb 2025 07:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739864575; cv=none; b=u5CggY0FAnZRRKzPixA9lLNee89qq0peXfqGGQE1zodOXU9MgAodOwyW8FTq4SWImMEtJd3yThyeGrGk1CuNxoa7UGDDHWavhpkNjs0rd3l7TR+2jdoY8q0bBy3WYgZUX7feZ/CTLbQRFAtt/YoDEXKhl/1KW5QMseSycaEDU50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739864575; c=relaxed/simple;
	bh=Q6wLscQqeWRJh+Q1dOBzi81fOEiUEOnX7LP3mZdrAw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a57Q2yTEgTpOzSUcr7B/Y+chPNmsTF55lr26ASynpmkyUR0zSJlq7h+jx1SmrzsW+3dQewMNHwLwPQ/PV01UYm5jKld3IhGGJNsHgZqVmVGSlBowXKXgS1lW7YbgE+PwOtrN3fZw7QP/m58fBDcdnJT/u8jSiMiuyAbvKmO2/6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:52604 helo=and-HP-Z4..)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tkIFn-00G0MD-2w;
	Tue, 18 Feb 2025 08:42:51 +0100
From: Andrej Picej <andrej.picej@norik.com>
To: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: [PATCH v3 09/15] arm64: dts: imx8mm: move bulk of rtc properties to carrierboards
Date: Tue, 18 Feb 2025 08:41:50 +0100
Message-Id: <20250218074156.807214-10-andrej.picej@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250218074156.807214-1-andrej.picej@norik.com>
References: <20250218074156.807214-1-andrej.picej@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

From: Yannic Moog <y.moog@phytec.de>

Move properties from SoM's dtsi to carrierboard's dts as they are
actually defined by the carrier board design.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
Changes in v3:
- no change
---
 .../boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts   | 10 ++++++++++
 arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi  | 10 ----------
 .../boot/dts/freescale/imx8mm-phygate-tauri-l.dts      | 10 ++++++++++
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts
index 7aaf705c7e47..17e5dd40b5d7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts
@@ -221,6 +221,10 @@ &pcie_phy {
 
 /* RTC */
 &rv3028 {
+	interrupt-parent = <&gpio1>;
+	interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+	pinctrl-0 = <&pinctrl_rtc>;
+	pinctrl-names = "default";
 	aux-voltage-chargeable = <1>;
 	trickle-resistor-ohms = <3000>;
 	wakeup-source;
@@ -410,6 +414,12 @@ MX8MM_IOMUXC_SD2_RESET_B_GPIO2_IO19	0x40
 		>;
 	};
 
+	pinctrl_rtc: rtcgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x1c0
+		>;
+	};
+
 	pinctrl_tpm: tpmgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_SD1_STROBE_GPIO2_IO11      0x140
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi
index cced82226c6d..672baba4c8d0 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi
@@ -301,10 +301,6 @@ eeprom@51 {
 	/* RTC */
 	rv3028: rtc@52 {
 		compatible = "microcrystal,rv3028";
-		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
-		interrupt-parent = <&gpio1>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_rtc>;
 		reg = <0x52>;
 	};
 };
@@ -377,12 +373,6 @@ MX8MM_IOMUXC_I2C1_SCL_GPIO5_IO14		0x1e0
 		>;
 	};
 
-	pinctrl_rtc: rtcgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x1c0
-		>;
-	};
-
 	pinctrl_sn65dsi83: sn65dsi83grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10		0x0
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l.dts b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l.dts
index c9bf4ac254bb..755cf9cacd22 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l.dts
@@ -215,6 +215,10 @@ &pwm4 {
 
 /* RTC */
 &rv3028 {
+	interrupt-parent = <&gpio1>;
+	interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+	pinctrl-0 = <&pinctrl_rtc>;
+	pinctrl-names = "default";
 	aux-voltage-chargeable = <1>;
 	trickle-resistor-ohms = <3000>;
 	wakeup-source;
@@ -395,6 +399,12 @@ MX8MM_IOMUXC_SD2_RESET_B_GPIO2_IO19     0x40
 		>;
 	};
 
+	pinctrl_rtc: rtcgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x1c0
+		>;
+	};
+
 	pinctrl_tempsense: tempsensegrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_SAI3_TXFS_GPIO4_IO31	0x00
-- 
2.34.1


