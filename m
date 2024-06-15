Return-Path: <linux-kernel+bounces-215777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0A09096E3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 10:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4CAE1F24F45
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 08:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E295182C3;
	Sat, 15 Jun 2024 08:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tZlGK7eI"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807F4D502;
	Sat, 15 Jun 2024 08:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718439429; cv=none; b=RhKYCCP3hKfs0dhwLc3U2Uz9CdO6FEw03yB5WR9tzfHrWjj4TCodQmbCEK8mfAI168/DwJdhclZNoiC/9uSju6rRFPyPogu56UwTLC3WJUSpOZ1O0QkDnbz1LyT9xfI2lW1RReVlblgOMbk/JdBWNBmcvOk4bypZyiiUE+Vkn84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718439429; c=relaxed/simple;
	bh=YP9AMhOg2JILUt4lPxVwMcEO36p6C+EXwlfJwYk0+Ko=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vDSxQwyz7rOEfFMHkEvuVVFh1UI+c/92L8XZvHrDV5aNJ96Yi+ubCV3gEoAkK2WlDPsNF7DB8wohnT1YZsE/nXTPC8a8PmxwFZwTo84DtQ2u5tmjNmwmVJKlOijK/yYsfQxGgCSge9JSvMQT5P51VK3YWN8Wbw+QcfcageBFfPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tZlGK7eI; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45F8GeIE102773;
	Sat, 15 Jun 2024 03:16:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718439400;
	bh=wYV0w24FLbCMNWLBLOQScHdj5lLyqEpYd5opKjq9pi4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=tZlGK7eI0CCXEekWn6MhTVN3prvDPm/9yrJ1uVSbIzMerGR9CwYglJ8LKw9DvwpwH
	 Y946dxYUMKqBwI3gAyraU5eIowX+U05dCBFfsEQ59FWaSBJhF/Wqn1Alb9/QRdIAgZ
	 /leUfA6PmAMzseLpJkHP0iEZtIHDN81wCSIl9JoY=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45F8GeDJ063961
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 15 Jun 2024 03:16:40 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 15
 Jun 2024 03:16:40 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 15 Jun 2024 03:16:40 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45F8G1Qc024463;
	Sat, 15 Jun 2024 03:16:36 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v7 8/8] arm64: dts: ti: k3-am62p-j722s: Move SoC-specific node properties
Date: Sat, 15 Jun 2024 13:46:00 +0530
Message-ID: <20240615081600.3602462-9-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240615081600.3602462-1-s-vadapalli@ti.com>
References: <20240615081600.3602462-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Certain device-tree node properties of shared device-tree nodes are
different between the AM62P and J722S SoCs. To avoid overriding the
properties and to avoid redefining the nodes in the k3-{soc}-main.dtsi
having such SoC specific properties, move the properties to the SoC
specific k3-{soc}-main.dtsi files.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
This patch has been introduced in this series and hence doesn't have a
Changelog. This patch replaces the v6 patch:
arm64: dts: ti: k3-j722s: Move MAIN domain overrides to k3-j722s-main.dtsi
based on Roger's suggestion at:
https://lore.kernel.org/r/d4c33ee4-1e91-40e5-90c8-bd793bcf34ff@kernel.org/

 .../dts/ti/k3-am62p-j722s-common-main.dtsi    |  5 -----
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi     | 17 +++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi     | 17 +++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j722s.dtsi          | 19 -------------------
 4 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
index 870c95081ef5..e787f9386eb5 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
@@ -8,10 +8,8 @@
 &cbass_main {
 	oc_sram: sram@70000000 {
 		compatible = "mmio-sram";
-		reg = <0x00 0x70000000 0x00 0x10000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
-		ranges = <0x00 0x00 0x70000000 0x10000>;
 	};
 
 	gic500: interrupt-controller@1800000 {
@@ -92,7 +90,6 @@ inta_main_dmss: interrupt-controller@48000000 {
 			msi-controller;
 			ti,sci = <&dmsc>;
 			ti,sci-dev-id = <28>;
-			ti,interrupt-ranges = <5 69 35>;
 			ti,unmapped-event-sources = <&main_bcdma>, <&main_pktdma>;
 		};
 
@@ -539,7 +536,6 @@ main_gpio0: gpio@600000 {
 			     <193>, <194>, <195>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
-		ti,ngpio = <92>;
 		ti,davinci-gpio-unbanked = <0>;
 		power-domains = <&k3_pds 77 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 77 0>;
@@ -556,7 +552,6 @@ main_gpio1: gpio@601000 {
 			     <183>, <184>, <185>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
-		ti,ngpio = <52>;
 		ti,davinci-gpio-unbanked = <0>;
 		power-domains = <&k3_pds 78 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 78 0>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
index 9caab7db5440..f8a7f0cbd327 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
@@ -32,3 +32,20 @@ usb1: usb@31100000 {
 		};
 	};
 };
+
+&oc_sram {
+	reg = <0x00 0x70000000 0x00 0x10000>;
+	ranges = <0x00 0x00 0x70000000 0x10000>;
+};
+
+&inta_main_dmss {
+	ti,interrupt-ranges = <5 69 35>;
+};
+
+&main_gpio0 {
+	ti,ngpio = <92>;
+};
+
+&main_gpio1 {
+	ti,ngpio = <52>;
+};
diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
index b16f3a7cb109..228c6c89245c 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
@@ -171,3 +171,20 @@ pcie0_ctrl: pcie0-ctrl@4070 {
 		reg = <0x4070 0x4>;
 	};
 };
+
+&oc_sram {
+	reg = <0x00 0x70000000 0x00 0x40000>;
+	ranges = <0x00 0x00 0x70000000 0x40000>;
+};
+
+&inta_main_dmss {
+	ti,interrupt-ranges = <7 71 21>;
+};
+
+&main_gpio0 {
+	ti,ngpio = <87>;
+};
+
+&main_gpio1 {
+	ti,ngpio = <73>;
+};
diff --git a/arch/arm64/boot/dts/ti/k3-j722s.dtsi b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
index 705b99e35f05..14c6c6a332ef 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
@@ -232,22 +232,3 @@ cbass_wakeup: bus@b00000 {
 
 /* Include J722S specific peripherals */
 #include "k3-j722s-main.dtsi"
-
-/* Main domain overrides */
-
-&inta_main_dmss {
-	ti,interrupt-ranges = <7 71 21>;
-};
-
-&main_gpio0 {
-	ti,ngpio = <87>;
-};
-
-&main_gpio1 {
-	ti,ngpio = <73>;
-};
-
-&oc_sram {
-	reg = <0x00 0x70000000 0x00 0x40000>;
-	ranges = <0x00 0x00 0x70000000 0x40000>;
-};
-- 
2.40.1


