Return-Path: <linux-kernel+bounces-520163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43640A3A681
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 852F61780ED
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EF71E5217;
	Tue, 18 Feb 2025 18:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FvhT1M73"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2E81E51E0;
	Tue, 18 Feb 2025 18:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739904915; cv=none; b=N6lX2SILrT+WIwoocN7njKzJcJAVDZyjkWS5FeBKm+pMnffGKr/X8GI1ILtEu5qxlryHEd21PHkZ/IFuU5WEbgSSG5ZeKszGhB4uD7UzM45UIh2AMMcsSFQ/ZD4Mv9vVaa/08EyMr4IU0KPo9M3IR1KLprJlbS+DyAfvCvJnPko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739904915; c=relaxed/simple;
	bh=5TmJAiZBN90TOu4q/jkNIQcsUGmjWFWHXB+2deRRvNw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZkUVbojkeoNrLc/tFAClhZeMQdP8+ZmjYPNdY8EXNirgG1RFnYGn/8lM8NmKKzv5/eShONb1JcsLJegS4V639oU2kwIj6TDU67QjIcDytVzOp3HydzL0dy5spcSLfClp4hrJXY8SJDcEBGY99AO7cH1kfRELvMYStZP6Wptkku8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FvhT1M73; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51IIt4b2060601
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 12:55:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1739904904;
	bh=+mzZWC6x4HtKvt8lE1i3uuPpKisVzmzGwWeB1THsahc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=FvhT1M73oH/+1EmkvOkolL6mdvR/7BPV+5JmGpRcdIV+mQEwXmIOx5stvHxjyv3At
	 OAhSnGAH2Jx7+mYJBAIfxgjH7EU7Nr6ZKDYLdS5nTkKTYetNG3TAVT0Tz/8tMZQhrr
	 MKOKl/q3P3YzUGFAvw4PL//SMa5exESltZbzZWvA=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51IIt4fN061082
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Feb 2025 12:55:04 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Feb 2025 12:55:04 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Feb 2025 12:55:04 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51IIsrxa123821;
	Tue, 18 Feb 2025 12:55:01 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <linux-kernel@vger.kernel.org>, <jai.luthra@linux.dev>,
        <y-abhilashchandra@ti.com>, <vaishnav.a@ti.com>
Subject: [PATCH 2/5] arm64: dts: ti: k3-j722s-main: Add CSI2RX nodes
Date: Wed, 19 Feb 2025 00:24:49 +0530
Message-ID: <20250218185452.600797-3-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250218185452.600797-1-vaishnav.a@ti.com>
References: <20250218185452.600797-1-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

J722S has 4 CSI2RX receiver instances with external DPHY. The first CSI2RX
instance node is derived from the AM62P common dtsi, Add the nodes for the
subsequent three instances and keep them disabled.

TRM (12.6 Camera Peripherals): https://www.ti.com/lit/zip/sprujb3

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 183 ++++++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
index f8e4424f3bb7..e69e9b34c0a4 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
@@ -154,6 +154,189 @@ usb1: usb@31200000 {
 		};
 	};
 
+	ti_csi2rx1: ticsi2rx@30122000 {
+		compatible = "ti,j721e-csi2rx-shim";
+		reg = <0x00 0x30122000 0x00 0x1000>;
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		dmas = <&main_bcdma_csi 0 0x5100 0>;
+		dma-names = "rx0";
+		power-domains = <&k3_pds 247 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+
+		cdns_csi2rx1: csi-bridge@30121000 {
+			compatible = "ti,j721e-csi2rx", "cdns,csi2rx";
+			reg = <0x00 0x30121000 0x00 0x1000>;
+			clocks = <&k3_clks 247 0>, <&k3_clks 247 3>, <&k3_clks 247 0>,
+				 <&k3_clks 247 0>, <&k3_clks 247 4>, <&k3_clks 247 4>;
+			clock-names = "sys_clk", "p_clk", "pixel_if0_clk",
+				      "pixel_if1_clk", "pixel_if2_clk", "pixel_if3_clk";
+			phys = <&dphy1>;
+			phy-names = "dphy";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				csi1_port0: port@0 {
+					reg = <0>;
+					status = "disabled";
+				};
+
+				csi1_port1: port@1 {
+					reg = <1>;
+					status = "disabled";
+				};
+
+				csi1_port2: port@2 {
+					reg = <2>;
+					status = "disabled";
+				};
+
+				csi1_port3: port@3 {
+					reg = <3>;
+					status = "disabled";
+				};
+
+				csi1_port4: port@4 {
+					reg = <4>;
+					status = "disabled";
+				};
+			};
+		};
+	};
+
+	ti_csi2rx2: ticsi2rx@30142000 {
+		compatible = "ti,j721e-csi2rx-shim";
+		reg = <0x00 0x30142000 0x00 0x1000>;
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		power-domains = <&k3_pds 248 TI_SCI_PD_EXCLUSIVE>;
+		dmas = <&main_bcdma_csi 0 0x5200 0>;
+		dma-names = "rx0";
+		status = "disabled";
+
+		cdns_csi2rx2: csi-bridge@30141000 {
+			compatible = "ti,j721e-csi2rx", "cdns,csi2rx";
+			reg = <0x00 0x30141000 0x00 0x1000>;
+			clocks = <&k3_clks 248 0>, <&k3_clks 248 3>, <&k3_clks 248 0>,
+				 <&k3_clks 248 0>, <&k3_clks 248 4>, <&k3_clks 248 4>;
+			clock-names = "sys_clk", "p_clk", "pixel_if0_clk",
+				      "pixel_if1_clk", "pixel_if2_clk", "pixel_if3_clk";
+			phys = <&dphy2>;
+			phy-names = "dphy";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				csi2_port0: port@0 {
+					reg = <0>;
+					status = "disabled";
+				};
+
+				csi2_port1: port@1 {
+					reg = <1>;
+					status = "disabled";
+				};
+
+				csi2_port2: port@2 {
+					reg = <2>;
+					status = "disabled";
+				};
+
+				csi2_port3: port@3 {
+					reg = <3>;
+					status = "disabled";
+				};
+
+				csi2_port4: port@4 {
+					reg = <4>;
+					status = "disabled";
+				};
+			};
+		};
+	};
+
+	ti_csi2rx3: ticsi2rx@30162000 {
+		compatible = "ti,j721e-csi2rx-shim";
+		reg = <0x00 0x30162000 0x00 0x1000>;
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		dmas = <&main_bcdma_csi 0 0x5300 0>;
+		dma-names = "rx0";
+		power-domains = <&k3_pds 249 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+
+		cdns_csi2rx3: csi-bridge@30161000 {
+			compatible = "ti,j721e-csi2rx", "cdns,csi2rx";
+			reg = <0x00 0x30161000 0x00 0x1000>;
+			clocks = <&k3_clks 249 0>, <&k3_clks 249 3>, <&k3_clks 249 0>,
+				 <&k3_clks 249 0>, <&k3_clks 249 4>, <&k3_clks 249 4>;
+			clock-names = "sys_clk", "p_clk", "pixel_if0_clk",
+				      "pixel_if1_clk", "pixel_if2_clk", "pixel_if3_clk";
+			phys = <&dphy3>;
+			phy-names = "dphy";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				csi3_port0: port@0 {
+					reg = <0>;
+					status = "disabled";
+				};
+
+				csi3_port1: port@1 {
+					reg = <1>;
+					status = "disabled";
+				};
+
+				csi3_port2: port@2 {
+					reg = <2>;
+					status = "disabled";
+				};
+
+				csi3_port3: port@3 {
+					reg = <3>;
+					status = "disabled";
+				};
+
+				csi3_port4: port@4 {
+					reg = <4>;
+					status = "disabled";
+				};
+			};
+		};
+	};
+
+	dphy1: phy@30130000 {
+		compatible = "cdns,dphy-rx";
+		reg = <0x00 0x30130000 0x00 0x1100>;
+		#phy-cells = <0>;
+		power-domains = <&k3_pds 251 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	dphy2: phy@30150000 {
+		compatible = "cdns,dphy-rx";
+		reg = <0x00 0x30150000 0x00 0x1100>;
+		#phy-cells = <0>;
+		power-domains = <&k3_pds 252 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	dphy3: phy@30170000 {
+		compatible = "cdns,dphy-rx";
+		reg = <0x00 0x30170000 0x00 0x1100>;
+		#phy-cells = <0>;
+		power-domains = <&k3_pds 253 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
 	main_r5fss0: r5fss@78400000 {
 		compatible = "ti,am62-r5fss";
 		#address-cells = <1>;
-- 
2.34.1


