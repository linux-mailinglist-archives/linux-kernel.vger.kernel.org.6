Return-Path: <linux-kernel+bounces-188528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3828CE311
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 11:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE3401F22CAD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA053129E8A;
	Fri, 24 May 2024 09:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ir3HsukY"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674B0129E86;
	Fri, 24 May 2024 09:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716541821; cv=none; b=Ip5bhHX9yqxSzplchAm6KX3Or18s0Eq/56nXhqrxB7VBi0saF9L4cs0az6ZOOksEs9EYnsa5AWqCjtGQ6rNQVTNyE03ol5IO8dMftg5K04VRZTP+Du+VwypnNomQ4v1SFSRNU0TAiR06RKfIvAQlFfD+iy3aU2ddDqA2BtrLKAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716541821; c=relaxed/simple;
	bh=QgserOuBCjfdDMRxfRBELU3SDqIo+0NouR2Ibum/w/A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EclxxukINXbMte3Vyi/Q++fR4NVI4K0O1xTEMCg93shFpPAKRxrMqcGRe2OhrtwO5B89esl8n1soTHjb+olGSTW1+RtG4C0PfjVKGOPZc8FyZ/qVVDrZM5t+M1OI/p7BmaGfJPl+yG7RSJxdXU9M5k5dfDlR0KjKCMHwBGUejfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ir3HsukY; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44O95kcv030090;
	Fri, 24 May 2024 04:05:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716541546;
	bh=GXI/sDOl7VpBlMvsOcRGN+H5CO94FdPVQOL51p0NhD4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ir3HsukYVFIqx+HorK1nwUZIrXUXnWzcKC0+BnhNsJ6Kw6jy3QrUU+IxVb8Mb+1TE
	 hIMf99m+EfpDslUtjFbTc9pYThIBvV8qFVyy4HBxkXCs5PwbGO0rcw8jSZjaC7hBsh
	 SgXPH4i+9ppO4ByCQqijYI0Ubkv1y0zfHbWuoClA=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44O95kxR029731
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 May 2024 04:05:46 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 24
 May 2024 04:05:46 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 24 May 2024 04:05:46 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44O95F7L017455;
	Fri, 24 May 2024 04:05:42 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3 6/7] arm64: dts: ti: k3-j722s-main: Add WIZ1 and Serdes1 nodes
Date: Fri, 24 May 2024 14:35:13 +0530
Message-ID: <20240524090514.152727-7-s-vadapalli@ti.com>
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

The Serdes1 instance of Serdes on TI's J722S SoC is a 1 Lane Serdes with
the WIZ1 instance of the WIZ wrapper used for configuring the Serdes.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
Current patch is v1. No changelog.

 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 36 +++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
index 48b77e476c77..19a7e8413ad2 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
@@ -60,6 +60,42 @@ serdes0: serdes@f000000 {
 		};
 	};
 
+	serdes_wiz1: phy@f010000 {
+		compatible = "ti,am64-wiz-10g";
+		ranges = <0x0f010000 0x0 0x0f010000 0x00010000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		power-domains = <&k3_pds 280 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 280 0>, <&k3_clks 280 1>, <&serdes_refclk>;
+		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
+		num-lanes = <1>;
+		#reset-cells = <1>;
+		#clock-cells = <1>;
+
+		assigned-clocks = <&k3_clks 280 1>;
+		assigned-clock-parents = <&k3_clks 280 5>;
+
+		serdes1: serdes@f010000 {
+			compatible = "ti,j721e-serdes-10g";
+			reg = <0x0f010000 0x00010000>;
+			reg-names = "torrent_phy";
+			resets = <&serdes_wiz1 0>;
+			reset-names = "torrent_reset";
+			clocks = <&serdes_wiz1 TI_WIZ_PLL0_REFCLK>,
+				 <&serdes_wiz1 TI_WIZ_PHY_EN_REFCLK>;
+			clock-names = "refclk", "phy_en_refclk";
+			assigned-clocks = <&serdes_wiz1 TI_WIZ_PLL0_REFCLK>,
+					  <&serdes_wiz1 TI_WIZ_PLL1_REFCLK>,
+					  <&serdes_wiz1 TI_WIZ_REFCLK_DIG>;
+			assigned-clock-parents = <&k3_clks 280 1>,
+						 <&k3_clks 280 1>,
+						 <&k3_clks 280 1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#clock-cells = <1>;
+		};
+	};
+
 	usbss1: usb@f920000 {
 		compatible = "ti,j721e-usb";
 		reg = <0x00 0x0f920000 0x00 0x100>;
-- 
2.40.1


