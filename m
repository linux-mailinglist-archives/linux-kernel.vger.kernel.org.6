Return-Path: <linux-kernel+bounces-205463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F858FFC6C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC899B25722
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39BA15250B;
	Fri,  7 Jun 2024 06:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="G6RGWMKW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="sEtMLIlz"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86BF3E47B;
	Fri,  7 Jun 2024 06:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742859; cv=none; b=M31brCQ/oTv4w55E1/R7uTEu15kOGXjz8/nLJbYD0NYTX452R5O5vAMH5fMXoRyEQ7PLjKNKhBKa/cT8C/PA912k30RVtuKeJBb4wdZY23NRNjSAz8SL/F6a7TOeaIrwpVI/YulJXNUy1jchf+k8HE6qcmSSbS8VFB8bpABSkTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742859; c=relaxed/simple;
	bh=Omad5yDDU+nmYWwiQc6CMFFpZTAtOlIS1TauVskhZoA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o1sW3d9s3jJKzJ2MWd8OUFoZ6KQh72ckpAl/mgtYscyabhN9GgdVT0e1+7IDkVSQOjzcVBcsMo4oPU0IBvbYEy1PTAQi22r0muUuztsCZQRx/CwNV5wvUkDnZEHtJzRmRkL0YTxHze4F+YWRB9gMQzz7LM+cz0VbxB9zNvcAAfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=G6RGWMKW; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=sEtMLIlz reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1717742855; x=1749278855;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pLjUTnmktrf31eI6S08bckIh0RmCDrrQkUrxpZLOGbw=;
  b=G6RGWMKWgIFZj2KoZKn6oEGnkeBCyDaR+bG4arjzQjfeG/smp0S/eZg3
   VXXOFjQ14ZxZ7hO3iGimLeQOwqIOZiM0LneRtsvMkXwEuDzETBhK27xkc
   wvVjo7eFQca2D3Rmih9KRTx0eLorfJLXnCPM5MS64qwIuitJ+lhzzlt2H
   1x+wCKbASPtEhhWUVNYcUiOGQTWrf8ERO84bZWHSak/3NhK1D0FrGQKKN
   YANgSCk+W1cYOeHvVtp5YYMV0zcRuXmFybz3N1W7WHly7Ax/9jpOfDapc
   VtB6LqNra1o/yQqTQSVdBMMu+K/53CCJVTTb5v+j2BQeM3mgKMTIzMYkw
   g==;
X-CSE-ConnectionGUID: UOq3MMEURiy+gE8RilkJKw==
X-CSE-MsgGUID: ZknLSp+/TficsUqDNxSZ0A==
X-IronPort-AV: E=Sophos;i="6.08,220,1712613600"; 
   d="scan'208";a="37274621"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 07 Jun 2024 08:47:32 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DC1D1170735;
	Fri,  7 Jun 2024 08:47:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1717742848; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=pLjUTnmktrf31eI6S08bckIh0RmCDrrQkUrxpZLOGbw=;
	b=sEtMLIlzB0Uskik3b9hVS2zaN7+W6nG7v33MAwjnROU4+MZw2bK3CRAy1GI0OIEOYecpRv
	xhOTlW1cf0Q6CsqZoiHEewasNdoB3BymgdvGWf3Z1vMEhqk7BDnKVoLVulablgoQAvvOgB
	m4NDqJTxnRiuc9QA3O/OPi3C9TvN40ya17eofj+LVSxtabp/AKwNxJhlSEzAVL2eIPJQ2Q
	ajofl8aVYiURF4Z5Ai3AGcqfSg0f/BQiVvAj2G6I1DKgbgOBQlzCxF3yD3vzqFSTdX40jl
	4hAl/IqmJqwSeq6MxROUfuIyW13zwJqh0w2G2EGL0cX2r2HeKU94CaxbruzepA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Frank Li <Frank.Li@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] [WIP] Initial DC0/LVDS0 subsystem files
Date: Fri,  7 Jun 2024 08:47:13 +0200
Message-Id: <20240607064714.2242082-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6638616.G0QQBjFxQf@steina-w>
References: <6638616.G0QQBjFxQf@steina-w>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

---
Current WIP ported from downstream kernel. Still a lot of TODOs
and missing parts.
It's the same approach as imx8-ss-lsio.dtsi and friends which are supposed
to be included inside the DT root node, not at the end.

 .../boot/dts/freescale/imx8-ss-lvds0.dtsi     | 574 ++++++++++++++++++
 1 file changed, 574 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi
new file mode 100644
index 0000000000000..8ad13962925d0
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi
@@ -0,0 +1,574 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * Copyright 2019 NXP
+ */
+
+mipi_ipg_clk: clock-mipi-ipg {
+	compatible = "fixed-clock";
+	#clock-cells = <0>;
+	clock-frequency = <120000000>;
+	clock-output-names = "mipi_ipg_clk";
+};
+
+mipi_pll_div2_clk: clock-mipi-div2-pll {
+	compatible = "fixed-clock";
+	#clock-cells = <0>;
+	clock-frequency = <432000000>;
+	clock-output-names = "mipi_pll_div2_clk";
+};
+
+lvds_subsys: bus@56200000 {
+	compatible = "simple-bus";
+	reg = <0x56200000 0x100000>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges;
+
+	lvds0_subsys: bus@56220000 {
+		compatible = "simple-bus";
+		reg = <0x56220000 0x30000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		interrupt-parent = <&irqsteer_mipi_lvds0>;
+
+		irqsteer_mipi_lvds0: irqsteer@56220000 {
+			compatible = "fsl,imx8qxp-irqsteer", "fsl,imx-irqsteer";
+			reg = <0x56220000 0x1000>;
+			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			interrupt-parent = <&gic>;
+			#interrupt-cells = <1>;
+			fsl,channel = <0>;
+			fsl,num-irqs = <32>;
+			clocks = <&mipi0_lis_lpcg 0>;
+			clock-names = "ipg";
+			power-domains = <&pd IMX_SC_R_MIPI_0>;
+		};
+
+		mipi_lvds0_csr: syscon@56221000 {
+			compatible = "fsl,imx8qxp-mipi-lvds-csr", "syscon", "simple-mfd";
+			reg = <0x56221000 0x1000>;
+			clocks = <&mipi_lvds0_di_mipi_lvds_regs_lpcg IMX_LPCG_CLK_4>;
+			clock-names = "ipg";
+			status = "disabled";
+
+			mipi_lvds0_pxl2dpi: pxl2dpi {
+				compatible = "fsl,imx8qxp-pxl2dpi";
+				fsl,sc-resource = <IMX_SC_R_MIPI_0>;
+				power-domains = <&pd IMX_SC_R_MIPI_0>;
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						#address-cells = <1>;
+						#size-cells = <0>;
+						reg = <0>;
+
+						mipi_lvds_0_pxl2dpi_dc0_pixel_link0: endpoint@0 {
+							reg = <0>;
+							remote-endpoint = <&dc0_pixel_link0_mipi_lvds_0_pxl2dpi>;
+						};
+
+						// mipi_lvds_0_pxl2dpi_dc0_pixel_link1: endpoint@1 {
+						// 	reg = <1>;
+						// 	remote-endpoint = <&dc0_pixel_link1_mipi_lvds_0_pxl2dpi>;
+						// };
+					};
+
+					port@1 {
+						#address-cells = <1>;
+						#size-cells = <0>;
+						reg = <1>;
+
+						mipi_lvds_0_pxl2dpi_mipi_lvds_0_ldb_ch0: endpoint@0 {
+							reg = <0>;
+							remote-endpoint = <&mipi_lvds_0_ldb_ch0_mipi_lvds_0_pxl2dpi>;
+						};
+
+						// mipi_lvds_0_pxl2dpi_mipi_lvds_0_ldb_ch1: endpoint@1 {
+						// 	reg = <1>;
+						// 	remote-endpoint = <&mipi_lvds_0_ldb_ch1_mipi_lvds_0_pxl2dpi>;
+						// };
+					};
+				};
+			};
+
+			mipi_lvds_0_ldb: ldb {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx8qxp-ldb";
+				clocks = <&clk IMX_SC_R_LVDS_0 IMX_SC_PM_CLK_MISC2>,
+					 <&clk IMX_SC_R_LVDS_0 IMX_SC_PM_CLK_BYPASS>;
+				clock-names = "pixel", "bypass";
+				assigned-clocks = <&clk IMX_SC_R_LVDS_0 IMX_SC_PM_CLK_MISC2>;
+				assigned-clock-parents = <&clk IMX_SC_R_LVDS_0 IMX_SC_PM_CLK_BYPASS>;
+				power-domains = <&pd IMX_SC_R_LVDS_0>;
+				status = "disabled";
+
+				channel@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+					phys = <&mipi_lvds_0_phy>;
+					phy-names = "lvds_phy";
+
+					port@0 {
+						reg = <0>;
+
+						mipi_lvds_0_ldb_ch0_mipi_lvds_0_pxl2dpi: endpoint {
+							remote-endpoint = <&mipi_lvds_0_pxl2dpi_mipi_lvds_0_ldb_ch0>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						/* ... */
+					};
+				};
+
+				// channel@1 {
+				// 	#address-cells = <1>;
+				// 	#size-cells = <0>;
+				// 	reg = <1>;
+				// 	phys = <&mipi_lvds_0_phy>;
+				// 	phy-names = "lvds_phy";
+
+				// 	port@0 {
+				// 		reg = <0>;
+
+				// 		mipi_lvds_0_ldb_ch1_mipi_lvds_0_pxl2dpi: endpoint {
+				// 			remote-endpoint = <&mipi_lvds_0_pxl2dpi_mipi_lvds_0_ldb_ch1>;
+				// 		};
+				// 	};
+
+				// 	port@1 {
+				// 		reg = <1>;
+
+				// 		/* ... */
+				// 	};
+				// };
+			};
+		};
+
+		mipi0_lis_lpcg: clock-controller@56223000 {
+			compatible = "fsl,imx8qxp-lpcg";
+			reg = <0x56223000 0x4>;
+			#clock-cells = <1>;
+			clocks = <&mipi_ipg_clk>;
+			clock-indices = <IMX_LPCG_CLK_4>;
+			clock-output-names = "mipi0_lis_lpcg_ipg_clk";
+			power-domains = <&pd IMX_SC_R_MIPI_0>;
+		};
+
+		mipi_lvds0_di_mipi_lvds_regs_lpcg: clock-controller@56223004 {
+			compatible = "fsl,imx8qxp-lpcg";
+			reg = <0x56223004 0x4>;
+			#clock-cells = <1>;
+			clocks = <&mipi_ipg_clk>;
+			clock-indices = <IMX_LPCG_CLK_4>;
+			clock-output-names = "mipi_lvds0_di_mipi_lvds_regs_lpcg_ipg_clk";
+			power-domains = <&pd IMX_SC_R_MIPI_0>;
+		};
+
+		mipi0_pwm_lpcg: clock-controller@5622300c {
+			compatible = "fsl,imx8qxp-lpcg";
+			reg = <0x5622300c 0x4>;
+			#clock-cells = <1>;
+			clocks = <&clk IMX_SC_R_MIPI_0_PWM_0 IMX_SC_PM_CLK_PER>,
+				 <&mipi_ipg_clk>,
+				 <&mipi_ipg_clk>;
+			clock-indices = <IMX_LPCG_CLK_0 IMX_LPCG_CLK_4 IMX_LPCG_CLK_1>;
+			clock-output-names = "mipi0_pwm_lpcg_clk",
+					     "mipi0_pwm_lpcg_ipg_clk",
+					     "mipi0_pwm_lpcg_32k_clk";
+			power-domains = <&pd IMX_SC_R_MIPI_0_PWM_0>;
+		};
+
+		mipi0_i2c0_lpcg: clock-controller@56223010 {
+			compatible = "fsl,imx8qxp-lpcg";
+			reg = <0x56223010 0x4>;
+			#clock-cells = <1>;
+			clocks = <&clk IMX_SC_R_MIPI_0_I2C_0 IMX_SC_PM_CLK_PER>,
+				 <&mipi_ipg_clk>;
+			clock-indices = <IMX_LPCG_CLK_0 IMX_LPCG_CLK_4>;
+			clock-output-names = "mipi0_i2c0_lpcg_clk",
+					     "mipi0_i2c0_lpcg_ipg_clk";
+			power-domains = <&pd IMX_SC_R_MIPI_0_I2C_0>;
+		};
+
+		mipi0_i2c1_lpcg: clock-controller@56223014 {
+			compatible = "fsl,imx8qxp-lpcg";
+			reg = <0x56223014 0x4>;
+			#clock-cells = <1>;
+			clocks = <&clk IMX_SC_R_MIPI_0_I2C_1 IMX_SC_PM_CLK_PER>,
+				 <&mipi_ipg_clk>;
+			clock-indices = <IMX_LPCG_CLK_0 IMX_LPCG_CLK_4>;
+			clock-output-names = "mipi0_i2c1_lpcg_clk",
+					     "mipi0_i2c1_lpcg_ipg_clk";
+			power-domains = <&pd IMX_SC_R_MIPI_0_I2C_1>;
+		};
+
+		pwm_mipi_lvds0: pwm@56224000 {
+			compatible = "fsl,imx8qxp-pwm", "fsl,imx27-pwm";
+			reg = <0x56224000 0x1000>;
+			clocks = <&mipi0_pwm_lpcg 0>,
+				 <&mipi0_pwm_lpcg 1>,
+				 <&mipi0_pwm_lpcg 2>;
+			clock-names = "per", "ipg", "32k";
+			assigned-clocks = <&clk IMX_SC_R_MIPI_0_PWM_0 IMX_SC_PM_CLK_PER>;
+			assigned-clock-rates = <24000000>;
+			#pwm-cells = <3>;
+			power-domains = <&pd IMX_SC_R_MIPI_0_PWM_0>;
+			status = "disabled";
+		};
+
+		i2c0_mipi_lvds0: i2c@56226000 {
+			compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
+			reg = <0x56226000 0x1000>;
+			interrupts = <8>;
+			clocks = <&mipi0_i2c0_lpcg 0>,
+				 <&mipi0_i2c0_lpcg 1>;
+			clock-names = "per", "ipg";
+			assigned-clocks = <&clk IMX_SC_R_MIPI_0_I2C_0 IMX_SC_PM_CLK_PER>;
+			assigned-clock-rates = <24000000>;
+			power-domains = <&pd IMX_SC_R_MIPI_0_I2C_0>;
+			status = "disabled";
+		};
+
+		mipi_lvds_0_phy: phy@56228300 {
+			compatible = "fsl,imx8qxp-mipi-dphy";
+			reg = <0x56228300 0x100>;
+			clocks = <&clk IMX_SC_R_LVDS_0 IMX_SC_PM_CLK_MISC3>;
+			clock-names = "phy_ref";
+			assigned-clocks = <&clk IMX_SC_R_LVDS_0 IMX_SC_PM_CLK_MISC3>;
+			assigned-clock-parents = <&clk IMX_SC_R_LVDS_0 IMX_SC_PM_CLK_BYPASS>;
+			#phy-cells = <0>;
+			fsl,syscon = <&mipi_lvds0_csr>;
+			power-domains = <&pd IMX_SC_R_MIPI_0>;
+		};
+
+		/* TODO MIPI DSI0 */
+	};
+
+	// mipi0_dsi_host: dsi_host@56228000 {
+	// 	#address-cells = <1>;
+	// 	#size-cells = <0>;
+	// 	compatible = "fsl,imx8qx-nwl-dsi";
+	// 	reg = <0x56228000 0x300>;
+	// 	clocks = <&clk IMX_SC_R_MIPI_0 IMX_SC_PM_CLK_PER>,
+	// 		 <&clk IMX_SC_R_MIPI_0 IMX_SC_PM_CLK_BYPASS>,
+	// 		 <&clk IMX_SC_R_MIPI_0 IMX_SC_PM_CLK_PHY>,
+	// 		 <&clk IMX_SC_R_MIPI_0 IMX_SC_PM_CLK_MST_BUS>,
+	// 		 <&clk IMX_SC_R_MIPI_0 IMX_SC_PM_CLK_SLV_BUS>,
+	// 		 <&mipi_pll_div2_clk>;
+	// 	clock-names = "pixel",
+	// 		      "bypass",
+	// 		      "phy_ref",
+	// 		      "tx_esc",
+	// 		      "rx_esc",
+	// 		      "phy_parent";
+	// 	interrupts = <16>;
+	// 	power-domains = <&pd IMX_SC_R_MIPI_0>;
+	// 	phys = <&mipi0_dphy>;
+	// 	phy-names = "dphy";
+	// 	csr = <&lvds_region1>;
+	// 	use-disp-ss;
+	// 	status = "disabled";
+
+	// 	ports {
+	// 		#address-cells = <1>;
+	// 		#size-cells = <0>;
+
+	// 		mipi0_in: port@0 {
+	// 			#address-cells = <1>;
+	// 			#size-cells = <0>;
+
+	// 			reg = <0>;
+	// 			mipi0_dsi_in: endpoint@0 {
+	// 				reg = <0>;
+	// 				remote-endpoint = <&dpu_disp0_mipi_dsi>;
+	// 			};
+	// 		};
+	// 	};
+	// };
+
+	lvds1_subsys: bus@56240000 {
+		compatible = "simple-bus";
+		reg = <0x56240000 0x30000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		interrupt-parent = <&irqsteer_mipi_lvds1>;
+
+		irqsteer_mipi_lvds1: irqsteer@56240000 {
+			compatible = "fsl,imx8qxp-irqsteer", "fsl,imx-irqsteer";
+			reg = <0x56240000 0x1000>;
+			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			interrupt-parent = <&gic>;
+			#interrupt-cells = <1>;
+			fsl,channel = <0>;
+			fsl,num-irqs = <32>;
+			clocks = <&mipi1_lis_lpcg 0>;
+			clock-names = "ipg";
+			power-domains = <&pd IMX_SC_R_MIPI_1>;
+		};
+
+		mipi_lvds1_csr: syscon@56241000 {
+			compatible = "fsl,imx8qxp-mipi-lvds-csr", "syscon", "simple-mfd";
+			reg = <0x56241000 0x1000>;
+			clocks = <&mipi_lvds1_di_mipi_lvds_regs_lpcg IMX_LPCG_CLK_4>;
+			clock-names = "ipg";
+			status = "disabled";
+
+			mipi_lvds1_pxl2dpi: pxl2dpi {
+				compatible = "fsl,imx8qxp-pxl2dpi";
+				fsl,sc-resource = <IMX_SC_R_MIPI_1>;
+				power-domains = <&pd IMX_SC_R_MIPI_1>;
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						#address-cells = <1>;
+						#size-cells = <0>;
+						reg = <0>;
+
+						mipi_lvds_1_pxl2dpi_dc0_pixel_link0: endpoint@0 {
+							reg = <0>;
+							remote-endpoint = <&dc0_pixel_link0_mipi_lvds_1_pxl2dpi>;
+						};
+
+						// mipi_lvds_1_pxl2dpi_dc0_pixel_link1: endpoint@1 {
+						// 	reg = <1>;
+						// 	remote-endpoint = <&dc0_pixel_link1_mipi_lvds_1_pxl2dpi>;
+						// };
+					};
+
+					port@1 {
+						#address-cells = <1>;
+						#size-cells = <0>;
+						reg = <1>;
+
+						mipi_lvds_1_pxl2dpi_mipi_lvds_1_ldb_ch0: endpoint@0 {
+							reg = <0>;
+							remote-endpoint = <&mipi_lvds_1_ldb_ch0_mipi_lvds_1_pxl2dpi>;
+						};
+
+						// mipi_lvds_1_pxl2dpi_mipi_lvds_1_ldb_ch1: endpoint@1 {
+						// 	reg = <1>;
+						// 	remote-endpoint = <&mipi_lvds_1_ldb_ch1_mipi_lvds_1_pxl2dpi>;
+						// };
+					};
+				};
+			};
+
+			mipi_lvds_1_ldb: ldb {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx8qxp-ldb";
+				clocks = <&clk IMX_SC_R_LVDS_1 IMX_SC_PM_CLK_MISC2>,
+					 <&clk IMX_SC_R_LVDS_1 IMX_SC_PM_CLK_BYPASS>;
+				clock-names = "pixel", "bypass";
+				assigned-clocks = <&clk IMX_SC_R_LVDS_1 IMX_SC_PM_CLK_MISC2>;
+				assigned-clock-parents = <&clk IMX_SC_R_LVDS_1 IMX_SC_PM_CLK_BYPASS>;
+				power-domains = <&pd IMX_SC_R_LVDS_1>;
+				status = "disabled";
+
+				channel@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+					phys = <&mipi_lvds_1_phy>;
+					phy-names = "lvds_phy";
+
+					port@0 {
+						reg = <0>;
+
+						mipi_lvds_1_ldb_ch0_mipi_lvds_1_pxl2dpi: endpoint {
+							remote-endpoint = <&mipi_lvds_1_pxl2dpi_mipi_lvds_1_ldb_ch0>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						/* ... */
+					};
+				};
+
+				// channel@1 {
+				// 	#address-cells = <1>;
+				// 	#size-cells = <0>;
+				// 	reg = <1>;
+				// 	phys = <&mipi_lvds_1_phy>;
+				// 	phy-names = "lvds_phy";
+
+				// 	port@0 {
+				// 		reg = <0>;
+
+				// 		mipi_lvds_1_ldb_ch1_mipi_lvds_1_pxl2dpi: endpoint {
+				// 			remote-endpoint = <&mipi_lvds_1_pxl2dpi_mipi_lvds_1_ldb_ch1>;
+				// 		};
+				// 	};
+
+				// 	port@1 {
+				// 		reg = <1>;
+
+				// 		/* ... */
+				// 	};
+				// };
+			};
+		};
+
+		mipi1_lis_lpcg: clock-controller@56243000 {
+			compatible = "fsl,imx8qxp-lpcg";
+			reg = <0x56243000 0x4>;
+			#clock-cells = <1>;
+			clocks = <&mipi_ipg_clk>;
+			clock-indices = <IMX_LPCG_CLK_4>;
+			clock-output-names = "mipi1_lis_lpcg_ipg_clk";
+			power-domains = <&pd IMX_SC_R_MIPI_1>;
+		};
+
+		mipi_lvds1_di_mipi_lvds_regs_lpcg: clock-controller@56243004 {
+			compatible = "fsl,imx8qxp-lpcg";
+			reg = <0x56243004 0x4>;
+			#clock-cells = <1>;
+			clocks = <&mipi_ipg_clk>;
+			clock-indices = <IMX_LPCG_CLK_4>;
+			clock-output-names = "mipi_lvds1_di_mipi_lvds_regs_lpcg_ipg_clk";
+			power-domains = <&pd IMX_SC_R_MIPI_1>;
+		};
+
+		mipi1_pwm_lpcg: clock-controller@5624300c {
+			compatible = "fsl,imx8qxp-lpcg";
+			reg = <0x5624300c 0x4>;
+			#clock-cells = <1>;
+			clocks = <&clk IMX_SC_R_MIPI_1_PWM_0 IMX_SC_PM_CLK_PER>,
+				 <&mipi_ipg_clk>,
+				 <&mipi_ipg_clk>;
+			clock-indices = <IMX_LPCG_CLK_0 IMX_LPCG_CLK_4 IMX_LPCG_CLK_1>;
+			clock-output-names = "mipi1_pwm_lpcg_clk",
+					     "mipi1_pwm_lpcg_ipg_clk",
+					     "mipi1_pwm_lpcg_32k_clk";
+			power-domains = <&pd IMX_SC_R_MIPI_1_PWM_0>;
+		};
+
+		mipi1_i2c0_lpcg: clock-controller@56243010 {
+			compatible = "fsl,imx8qxp-lpcg";
+			reg = <0x56243010 0x4>;
+			#clock-cells = <1>;
+			clocks = <&clk IMX_SC_R_MIPI_1_I2C_0 IMX_SC_PM_CLK_PER>,
+				 <&mipi_ipg_clk>;
+			clock-indices = <IMX_LPCG_CLK_0 IMX_LPCG_CLK_4>;
+			clock-output-names = "mipi1_i2c0_lpcg_clk",
+					     "mipi1_i2c0_lpcg_ipg_clk";
+			power-domains = <&pd IMX_SC_R_MIPI_1_I2C_0>;
+		};
+
+		mipi1_i2c1_lpcg: clock-controller@56243014 {
+			compatible = "fsl,imx8qxp-lpcg";
+			reg = <0x56243014 0x4>;
+			#clock-cells = <1>;
+			clocks = <&clk IMX_SC_R_MIPI_1_I2C_1 IMX_SC_PM_CLK_PER>,
+				 <&mipi_ipg_clk>;
+			clock-indices = <IMX_LPCG_CLK_0 IMX_LPCG_CLK_4>;
+			clock-output-names = "mipi1_i2c1_lpcg_clk",
+					     "mipi1_i2c1_lpcg_ipg_clk";
+			power-domains = <&pd IMX_SC_R_MIPI_1_I2C_1>;
+		};
+
+		pwm_mipi_lvds1: pwm@56244000 {
+			compatible = "fsl,imx8qxp-pwm", "fsl,imx27-pwm";
+			reg = <0x56244000 0x1000>;
+			clocks = <&mipi1_pwm_lpcg 0>,
+				 <&mipi1_pwm_lpcg 1>,
+				 <&mipi1_pwm_lpcg 2>;
+			clock-names = "per", "ipg", "32k";
+			assigned-clocks = <&clk IMX_SC_R_MIPI_1_PWM_0 IMX_SC_PM_CLK_PER>;
+			assigned-clock-rates = <24000000>;
+			#pwm-cells = <3>;
+			power-domains = <&pd IMX_SC_R_MIPI_1_PWM_0>;
+			status = "disabled";
+		};
+
+		i2c0_mipi_lvds1: i2c@56246000 {
+			compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
+			reg = <0x56246000 0x1000>;
+			interrupts = <8>;
+			clocks = <&mipi1_i2c0_lpcg 0>,
+				 <&mipi1_i2c0_lpcg 1>;
+			clock-names = "per", "ipg";
+			assigned-clocks = <&clk IMX_SC_R_MIPI_1_I2C_0 IMX_SC_PM_CLK_PER>;
+			assigned-clock-rates = <24000000>;
+			power-domains = <&pd IMX_SC_R_MIPI_1_I2C_0>;
+			status = "disabled";
+		};
+
+		mipi_lvds_1_phy: phy@56248300 {
+			compatible = "fsl,imx8qxp-mipi-dphy";
+			reg = <0x56248300 0x100>;
+			clocks = <&clk IMX_SC_R_LVDS_1 IMX_SC_PM_CLK_MISC3>;
+			clock-names = "phy_ref";
+			assigned-clocks = <&clk IMX_SC_R_LVDS_1 IMX_SC_PM_CLK_MISC3>;
+			assigned-clock-parents = <&clk IMX_SC_R_LVDS_1 IMX_SC_PM_CLK_BYPASS>;
+			#phy-cells = <0>;
+			fsl,syscon = <&mipi_lvds1_csr>;
+			power-domains = <&pd IMX_SC_R_MIPI_1>;
+		};
+
+		/* TODO MIPI DSI1 */
+	};
+
+	// mipi1_dsi_host: dsi_host@56248000 {
+	// 	#address-cells = <1>;
+	// 	#size-cells = <0>;
+	// 	compatible = "fsl,imx8qx-nwl-dsi";
+	// 	reg = <0x56248000 0x300>;
+	// 	clocks = <&clk IMX_SC_R_MIPI_1 IMX_SC_PM_CLK_PER>,
+	// 		 <&clk IMX_SC_R_MIPI_1 IMX_SC_PM_CLK_BYPASS>,
+	// 		 <&clk IMX_SC_R_MIPI_1 IMX_SC_PM_CLK_PHY>,
+	// 		 <&clk IMX_SC_R_MIPI_1 IMX_SC_PM_CLK_MST_BUS>,
+	// 		 <&clk IMX_SC_R_MIPI_1 IMX_SC_PM_CLK_SLV_BUS>,
+	// 		 <&mipi_pll_div2_clk>;
+	// 	clock-names = "pixel",
+	// 		      "bypass",
+	// 		      "phy_ref",
+	// 		      "tx_esc",
+	// 		      "rx_esc",
+	// 		      "phy_parent";
+	// 	interrupts = <16>;
+	// 	power-domains = <&pd IMX_SC_R_MIPI_1>;
+	// 	phys = <&mipi1_dphy>;
+	// 	phy-names = "dphy";
+	// 	csr = <&lvds_region2>;
+	// 	use-disp-ss;
+	// 	status = "disabled";
+
+	// 	ports {
+	// 		#address-cells = <1>;
+	// 		#size-cells = <0>;
+
+	// 		mipi1_in: port@0 {
+	// 			#address-cells = <1>;
+	// 			#size-cells = <0>;
+
+	// 			reg = <0>;
+	// 			mipi1_dsi_in: endpoint@0 {
+	// 				reg = <0>;
+	// 				remote-endpoint = <&dpu_disp1_mipi_dsi>;
+	// 			};
+	// 		};
+	// 	};
+	// };
+
+};
-- 
2.34.1


