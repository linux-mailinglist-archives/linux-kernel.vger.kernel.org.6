Return-Path: <linux-kernel+bounces-188519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C0E8CE2F9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 11:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C9528319D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD31412A17B;
	Fri, 24 May 2024 09:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yKggM8Xt"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A1112A16C;
	Fri, 24 May 2024 09:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716541544; cv=none; b=YvfvK/+JWX53FKI1stKG/kuWJ1FAXWqnUGnB7bwKwAK81oASgC6/6w5Q40NlWgNHLXyGtwoVlWTAQ4trZFTiWAtCRncGsZOcUPILmiCI506MFk+aKTucBEQWBtfoDsUiESM8JF6dW1MHY9280IE751aduce9ReiQFg+lx9Muy1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716541544; c=relaxed/simple;
	bh=Q/Uw6WEGSallc3jLEE3Dd1x41ZPtMdh5xBHsTVLNlF8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XBdItUfKlqI+swOMRunRgz5eFXBGjEDdDVm1xMRjk2GObsIK0rU4/GH3a1qDM5Q9NzeRT2k2xmRuNaRxHEFC0Hpd53Cw4GOa5bt9lfaoQ5VBbzc8oZr4GjJqLewr4Xu37c2uSogAQ4TUAGU8bqvOA0h2coSr7nMBxCDySs2bP/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yKggM8Xt; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44O95OUs054192;
	Fri, 24 May 2024 04:05:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716541524;
	bh=UTX6g2sDmelnKTRflKA1XZXjDb9sjp/VvCPo+/ywmQY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=yKggM8XtpqZigSYQHEf1GjBal/vgrsiGSm9C8+BNmhj4ltg76//fXnj2XXpMYTAQL
	 Vowb0oRdxmPfnXRDLXMeUpq0o38xvApWgo3/aUd6z2HodsOBmgzrE9hISc6QiXKwuI
	 yKB78s1L+YSthHeEF7S0tWNI+RP4NpZTBMEZLMig=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44O95OI6028582
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 May 2024 04:05:24 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 24
 May 2024 04:05:24 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 24 May 2024 04:05:23 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44O95F7G017455;
	Fri, 24 May 2024 04:05:20 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3 1/7] arm64: dts: ti: k3-j722s-main: Add support for SERDES0
Date: Fri, 24 May 2024 14:35:08 +0530
Message-ID: <20240524090514.152727-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240524090514.152727-1-s-vadapalli@ti.com>
References: <20240524090514.152727-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Ravi Gunasekaran <r-gunasekaran@ti.com>

AM62P's DT source files are reused for J722S inorder to
avoid duplication of nodes. But J722S has additional
peripherals that are not present in AM62P.

Introduce a -main.dtsi to define such additional main
domain peripherals and define the SERDES0 node.

Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
v2:
https://lore.kernel.org/r/20240513114443.16350-2-r-gunasekaran@ti.com/
Changes since v2:
- Renamed serdes0_ln_ctrl to serdes_ln_ctrl to keep the format
  consistent across SoCs where a single node is sufficient to
  represent the Lane-Muxing for all instances of the Serdes.

v1:
https://lore.kernel.org/r/20240429120932.11456-2-r-gunasekaran@ti.com/
Changes since v1:
- Newly introduced k3-j722s-main.dtsi to add main domain peripherals
  that are additionally present in J722S.
- Used generic node names - renamed "clock-cmnrefclk" to "clk-0",
  "wiz@f000000" to "phy@f000000"

 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 64 +++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
new file mode 100644
index 000000000000..0dac8f1e1291
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
+	serdes_ln_ctrl: mux-controller@4080 {
+		compatible = "reg-mux";
+		reg = <0x4080 0x4>;
+		#mux-control-cells = <1>;
+		mux-reg-masks = <0x0 0x3>; /* SERDES0 lane0 select */
+	};
+};
-- 
2.40.1


