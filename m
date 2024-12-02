Return-Path: <linux-kernel+bounces-427002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F619DFB1B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FDA9B22748
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 07:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD5E1FA244;
	Mon,  2 Dec 2024 07:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="EoN2Rgbh"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325851F9F5D;
	Mon,  2 Dec 2024 07:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733124087; cv=none; b=A4somyUba5u9XhhYtDxCjvHBayVsIdKSGMwtOsRXv9JPlfMr8FpZtQSKd6Y4thyS1BgWNhFQKBUDiqDmxe3HL0vbiL1JUSxGRLExOu3pRt2mYheCXgk2g08OsAp6kkr48/BrJTEia6MIInwz2u5LFyi4vmkFNquJSx+pV9lz9BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733124087; c=relaxed/simple;
	bh=cr74MPzlg0vgsT4tx60RQNtoGEhJm4+oJz5W38vC4cI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DaD6svnqqkMX40EYq3yi+Qk+RXKJBMys0T2JrTIvLUf8NtlMNe4RjAqD0VypH7w3jlRtoYOCdTmupRHIavjfY3eA0EZiEp2IuvjxoY3nKqj8jChiGceQjfGc8TAbxNbMVdYfajp1u8D3jwRFHHJAq6CnN82or5V2ZYwhBwB6+kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=EoN2Rgbh; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=rF86hPgASe36tDhPu57qGl4irorvhPrOkYViQu3caaY=; b=EoN2RgbhCBnbE09c/jBpePIMot
	nkBCXH6Wpq6g3Iw3B0Kw0VWuQAe69LkX0Eqvcx+UwjoU5kzFAyIVFBXGXItNjjWQmDhl61HrqF0Cb
	4Gt6hTirU+Ie3iB6tmSh0J7/fdhypUPabbtIWXSJh6VQSBbQafg5ZfdCnnKMejVT3kaM9L11BSi0u
	UrOIp4yeYM6dSRFav4/pJSd/BLMUFC1bi3Je4rY+ygv9nWBqvLTx71hSK+Z1PYiVYfiKkyai+8NVz
	Lryb7cHL/cfmMX5YkPl+tM5TfnYgA6ryAdoHlAEsBqe8GlTQ+O77s4nSa8R6GdL+xFuyUSzI6mT+2
	2v6KkF2Q==;
Received: from [89.212.21.243] (port=53766 helo=and-HP-Z4..)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tI0kF-007Bva-2C;
	Mon, 02 Dec 2024 08:21:23 +0100
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
Subject: [PATCH v2 09/15] arm64: dts: imx8mm: move bulk of rtc properties to carrierboards
Date: Mon,  2 Dec 2024 08:20:46 +0100
Message-Id: <20241202072052.2195283-10-andrej.picej@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202072052.2195283-1-andrej.picej@norik.com>
References: <20241202072052.2195283-1-andrej.picej@norik.com>
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
Changes in v2:
 - also moved pinctrl settings to the carrier boards dts.
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


