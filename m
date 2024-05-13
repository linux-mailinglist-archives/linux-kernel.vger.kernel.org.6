Return-Path: <linux-kernel+bounces-177514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CDE8C4005
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 13:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEEFCB237C0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 11:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0C414D2B2;
	Mon, 13 May 2024 11:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZG00S7Ib"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB2614C58A;
	Mon, 13 May 2024 11:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715600701; cv=none; b=cHUBUa1lZ1n025/M3g0+schks1tyAUO/wcqKeO1mOclJgGaeXs2GN1XCorVxAP2NsdDPBkAtW3Ncopl7EWhk5XhcTXSk4W3BKEMQ35oJZD+zb/SG/PlxzoFSdpvGUQJzgBubB6HdHjlUtSv5882dWTXKrBCHX3KJAOx3O/f+7eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715600701; c=relaxed/simple;
	bh=P6YnmEhWSK1fGtRlqUQFTnOvu1mUBDpmWoFsKM/oklU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ER4QO+S0Uv311CB5Lq0Ot5DDA8j0SFKFHCBC5+2e4ItxPdqFDJXDN2+ntxIMKgeZh5XnQgyG+VEw25jbvlu/WWsb6eRxrKvuu8S9H8SCjRQRtDaEjeTizk8y6fcP2WW+viAr5yEj0BPEjRKGsLQOlkDTcuTiPI3M0pwvKkxsIvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZG00S7Ib; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44DBir8K106181;
	Mon, 13 May 2024 06:44:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715600693;
	bh=xLaxHkTgfKR3NuNoAwYQ0NKBtG4coec1Hji8POGoKYU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ZG00S7IbzcGliDZazsvN6cvujeajwhmB3m617PZ/WXnEdDWJc/+n67JPnUsRtUudF
	 mcoCi6vEAwE8KTsZ5RQEJOlAjSU3kAZmMan/JeXbgt5QO/mSlUdIdGnPjegrJDa5fk
	 YZiV63+Xkm0gxhP1S+2BNZu9c4BH9opA/sG9Jr1Y=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44DBiqaN020199
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 May 2024 06:44:53 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 13
 May 2024 06:44:52 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 13 May 2024 06:44:52 -0500
Received: from uda0500640.dal.design.ti.com (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44DBiiZh086026;
	Mon, 13 May 2024 06:44:48 -0500
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <robh@kernel.org>,
        <rogerq@kernel.org>
CC: <kristo@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <srk@ti.com>, <r-gunasekaran@ti.com>, <s-vadapalli@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/3] arm64: dts: ti: k3-j722s-main: Add support for SERDES0
Date: Mon, 13 May 2024 17:14:41 +0530
Message-ID: <20240513114443.16350-2-r-gunasekaran@ti.com>
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

AM62P's DT source files are reused for J722S inorder to
avoid duplication of nodes. But J722S has additional
peripherals that are not present in AM62P.

Introduce a -main.dtsi to define such additional main
domain peripherals and define the SERDES0 node.

Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---
Changes since v1:
----------------
* Newly introduced k3-j722s-main.dtsi to add main domain
  peripherals that are additionally present in J722S

* Used generic node names - renamed "clock-cmnrefclk" to "clk-0",
  "wiz@f000000" to "phy@f000000"

v1: https://lore.kernel.org/all/20240429120932.11456-1-r-gunasekaran@ti.com/

 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 64 +++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
new file mode 100644
index 000000000000..1fd88cc8545f
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Device Tree file for the J722S main domain peripherals
+ * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <dt-bindings/phy/phy-ti.h>
+
+/ {
+	serdes_refclk: clk-0 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+};
+
+&cbass_main {
+	serdes_wiz0: phy@f000000 {
+		compatible = "ti,am64-wiz-10g";
+		ranges = <0x0f000000 0x0 0x0f000000 0x00010000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		power-domains = <&k3_pds 279 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 279 0>, <&k3_clks 279 1>, <&serdes_refclk>;
+		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
+		num-lanes = <1>;
+		#reset-cells = <1>;
+		#clock-cells = <1>;
+
+		assigned-clocks = <&k3_clks 279 1>;
+		assigned-clock-parents = <&k3_clks 279 5>;
+
+		serdes0: serdes@f000000 {
+			compatible = "ti,j721e-serdes-10g";
+			reg = <0x0f000000 0x00010000>;
+			reg-names = "torrent_phy";
+			resets = <&serdes_wiz0 0>;
+			reset-names = "torrent_reset";
+			clocks = <&serdes_wiz0 TI_WIZ_PLL0_REFCLK>,
+				 <&serdes_wiz0 TI_WIZ_PHY_EN_REFCLK>;
+			clock-names = "refclk", "phy_en_refclk";
+			assigned-clocks = <&serdes_wiz0 TI_WIZ_PLL0_REFCLK>,
+					  <&serdes_wiz0 TI_WIZ_PLL1_REFCLK>,
+					  <&serdes_wiz0 TI_WIZ_REFCLK_DIG>;
+			assigned-clock-parents = <&k3_clks 279 1>,
+						 <&k3_clks 279 1>,
+						 <&k3_clks 279 1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#clock-cells = <1>;
+
+			status = "disabled"; /* Needs lane config */
+		};
+	};
+};
+
+&main_conf {
+	serdes0_ln_ctrl: mux-controller@4080 {
+		compatible = "reg-mux";
+		reg = <0x4080 0x4>;
+		#mux-control-cells = <1>;
+		mux-reg-masks = <0x0 0x3>; /* SERDES0 lane0 select */
+	};
+};
-- 
2.17.1


