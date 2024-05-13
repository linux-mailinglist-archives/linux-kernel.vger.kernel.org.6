Return-Path: <linux-kernel+bounces-177516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FD38C4009
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 13:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E9022862E0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 11:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FAD14F9CB;
	Mon, 13 May 2024 11:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OoZJWQlG"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50CD14F11E;
	Mon, 13 May 2024 11:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715600706; cv=none; b=VsrLlEHepXKMLy1gCrKNUR0blLVSOj+MquUfFnFFwgLa6i/YeYubSHlBCsM8dP4MwuqXJ6Lt+8ICqae9ops4DJZ2VqnC2U+HVHeWnw4VhFWoP+f1OGhM/3nj1LvlIf5PIuQ4/vBwUue2ByMG2NYfBkUSLdZs246qEBhCQBgX3Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715600706; c=relaxed/simple;
	bh=+K+qMf8HKNCuAcmVsyBoIuDdQZM0gusbVubGxjdQqto=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fiUm/orUW/Olmkm1kQ1iMNkKkcgB54Wf1EPe9FLnNKyqedRdj4PRtxYe9sAA5yA0tgKA6KQoaqfkswNx4dOyH6Gomer7Rbwm7fWZHJ+4ASlQ48hx1Vln1MNB22o5aWO8itS4d44ldJDPffyye7RePuY8C6ziZNwdepF5bsoq3GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OoZJWQlG; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44DBivNQ128581;
	Mon, 13 May 2024 06:44:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715600697;
	bh=cmP4OIqVwuoJxreKScP9pKojrzsuE5hZ62E68/daiBM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=OoZJWQlGDXklC5ik4h1SKyhMxRA9dmshzABN6yv36tyemomCaM3MLuaI6LQot4iZ0
	 raDMJA+La15H1d3BhTzMS1SYVbxzxmY/LSyQkQ4LdWJEa8ZlCzIfe5a4vpJTdF1wco
	 jMGvJhNQPBgl7Q9vVDxKguDAhcO7JDKaYmV3ZcDw=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44DBivfF002095
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 May 2024 06:44:57 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 13
 May 2024 06:44:57 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 13 May 2024 06:44:57 -0500
Received: from uda0500640.dal.design.ti.com (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44DBiiZi086026;
	Mon, 13 May 2024 06:44:53 -0500
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <robh@kernel.org>,
        <rogerq@kernel.org>
CC: <kristo@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <srk@ti.com>, <r-gunasekaran@ti.com>, <s-vadapalli@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/3] arm64: dts: ti: k3-j722s-main: Redefine USB1 node description
Date: Mon, 13 May 2024 17:14:42 +0530
Message-ID: <20240513114443.16350-3-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240513114443.16350-1-r-gunasekaran@ti.com>
References: <20240513114443.16350-1-r-gunasekaran@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

USB1 controller on J722S and AM62P are from different vendors.
Redefine the USB1 node description for J722S by deleting the
node inherited from AM62P dtsi.

Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---
Changes since v1:
----------------
* The entire node which was added in k3-j722s.dtsi in v1 in now moved
  to k3-j722s-main.dtsi as USB is a main domain peripheral

* Used generic node names - renamed "cdns-usb@f920000" to "usb@f920000"

v1: https://lore.kernel.org/all/20240429120932.11456-1-r-gunasekaran@ti.com/

 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 39 +++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
index 1fd88cc8545f..54f37aff0eca 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
@@ -6,6 +6,13 @@
 
 #include <dt-bindings/phy/phy-ti.h>
 
+/*
+ * USB1 controller on AM62P and J722S are of different IP.
+ * Delete AM62P's USBSS1 node definition and redefine it for J722S.
+ */
+
+/delete-node/ &usbss1;
+
 / {
 	serdes_refclk: clk-0 {
 		compatible = "fixed-clock";
@@ -52,6 +59,38 @@
 			status = "disabled"; /* Needs lane config */
 		};
 	};
+
+	usbss1: usb@f920000 {
+		compatible = "ti,j721e-usb";
+		reg = <0x00 0x0f920000 0x00 0x100>;
+		power-domains = <&k3_pds 278 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 278 3>, <&k3_clks 278 1>;
+		clock-names = "ref", "lpm";
+		assigned-clocks = <&k3_clks 278 3>; /* USB2_REFCLK */
+		assigned-clock-parents = <&k3_clks 278 4>; /* HF0SC0 */
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		status = "disabled";
+
+		usb1: usb@31200000{
+			compatible = "cdns,usb3";
+			reg = <0x00 0x31200000 0x00 0x10000>,
+			      <0x00 0x31210000 0x00 0x10000>,
+			      <0x00 0x31220000 0x00 0x10000>;
+			reg-names = "otg",
+				    "xhci",
+				    "dev";
+			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>, /* irq.0 */
+				     <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>, /* irq.6 */
+				     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>; /* otgirq */
+			interrupt-names = "host",
+					  "peripheral",
+					  "otg";
+			maximum-speed = "super-speed";
+			dr_mode = "otg";
+		};
+	};
 };
 
 &main_conf {
-- 
2.17.1


