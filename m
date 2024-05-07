Return-Path: <linux-kernel+bounces-171043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014EF8BDF13
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC4CA283F95
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DD314EC55;
	Tue,  7 May 2024 09:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lxrlZp/P"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1588314E2FA;
	Tue,  7 May 2024 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715075761; cv=none; b=CNgXOTVSYMa4EIxyjU9oS8RGm0NBYG89njlB7RcPIPKigWsUo22XGWleRHepMQrfzjmMsd/vAPrJ3ZcA2L+o95Okw6sAJ/BXMHM1bzHOzFW5ijmdgr0dheXnsMyC21GtbjesEKaN/L+bdVoyEnzUFRt+DhpxLXAAgXpDPNn39Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715075761; c=relaxed/simple;
	bh=8J6lUtHO4CW+t1QgcFlfw7wnFePnuGGZemBJyW1l0IY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pCiPnQtUtZd1W+ZXbv/JMMKKFlclLG/FPlUpyU8Fox5YTiAPBct5L+Mqrln2+w4oLL1/4dzup+mGnx7u+rnGZ90LcdTjmK107m6RLSVoefUwg8YgOHDUiBMiBL19o86q4TDxQmLtu+p7R4FsvcM0PvdNzo/ywKLsxMKkYYxPW/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lxrlZp/P; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4479trRi057015;
	Tue, 7 May 2024 04:55:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715075753;
	bh=3guGtqT06dY4965aloh0sOEeWGeoW6RJqpn/W1YsL8g=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=lxrlZp/PgqWenlL6F8QWFcqXh7ivg1FHCuoL2ECZl0QskKg4ok+0wDtRyKskWxNTI
	 buDrXmfAXxaJS9rWfgFdFsG1I+diViLAqMuyM95sHzANWgU6k14uo/nzgxjTgpp6tl
	 xe9NsXa78vjM+tHQpBGR40prWVEDZcfM0CmKqvTA=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4479tr9B067849
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 May 2024 04:55:53 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 May 2024 04:55:53 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 May 2024 04:55:53 -0500
Received: from uda0500640.dal.design.ti.com (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4479tjn8007273;
	Tue, 7 May 2024 04:55:49 -0500
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <srk@ti.com>, <rogerq@kernel.org>,
        <r-gunasekaran@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/2] arm64: dts: ti: k3-j784s4-main: Add support for USB
Date: Tue, 7 May 2024 15:25:44 +0530
Message-ID: <20240507095545.8210-2-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240507095545.8210-1-r-gunasekaran@ti.com>
References: <20240507095545.8210-1-r-gunasekaran@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Matt Ranostay <mranostay@ti.com>

Add support for the USB 3.0 controller

Signed-off-by: Matt Ranostay <mranostay@ti.com>
Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---
Changes since v1:
----------------
* Node name 'cdns-usb' renamed to 'usb' 

Changes since v1:
----------------
* No change

v2: https://lore.kernel.org/all/20240506052044.8228-2-r-gunasekaran@ti.com/
v1: https://lore.kernel.org/all/20240502053615.29514-2-r-gunasekaran@ti.com/

 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index 6a4554c6c9c1..0401043791f8 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -75,6 +75,13 @@
 				      <J784S4_SERDES4_LANE2_EDP_LANE2>,
 				      <J784S4_SERDES4_LANE3_EDP_LANE3>;
 		};
+
+		usb_serdes_mux: mux-controller@4000 {
+			compatible = "reg-mux";
+			reg = <0x4000 0x4>;
+			#mux-control-cells = <1>;
+			mux-reg-masks = <0x0 0x8000000>; /* USB0 to SERDES0 lane 3 mux */
+		};
 	};
 
 	gic500: interrupt-controller@1800000 {
@@ -568,6 +575,38 @@
 		status = "disabled";
 	};
 
+	usbss0: usb@4104000 {
+		bootph-all;
+		compatible = "ti,j721e-usb";
+		reg = <0x00 0x4104000 0x00 0x100>;
+		dma-coherent;
+		power-domains = <&k3_pds 398 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 398 21>, <&k3_clks 398 2>;
+		clock-names = "ref", "lpm";
+		assigned-clocks = <&k3_clks 398 21>;    /* USB2_REFCLK */
+		assigned-clock-parents = <&k3_clks 398 22>; /* HFOSC0 */
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		status = "disabled"; /* Needs lane config */
+
+		usb0: usb@6000000 {
+			bootph-all;
+			compatible = "cdns,usb3";
+			reg = <0x00 0x6000000 0x00 0x10000>,
+			      <0x00 0x6010000 0x00 0x10000>,
+			      <0x00 0x6020000 0x00 0x10000>;
+			reg-names = "otg", "xhci", "dev";
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,  /* irq.0 */
+				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>, /* irq.6 */
+				     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>; /* otgirq.0 */
+			interrupt-names = "host",
+					  "peripheral",
+					  "otg";
+		};
+	};
+
 	main_i2c0: i2c@2000000 {
 		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
 		reg = <0x00 0x02000000 0x00 0x100>;
-- 
2.17.1


