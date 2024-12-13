Return-Path: <linux-kernel+bounces-445168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C8B9F1243
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C877283808
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051EF1EB9E1;
	Fri, 13 Dec 2024 16:32:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D751E4908;
	Fri, 13 Dec 2024 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734107553; cv=none; b=b8tqsPUyOresDWuftL0ipSdI2KfS2ObPw8p53kLGfAbCt0XMJWiivdvUggu+EBXU2VR++qW6vX+Y+jBwkDvqUYQycxiNTENl2zPUNAV+qD2BLazxRBEXvL/tdoeg+ZoJAzXiROTqg2S5qY72Ul+0tBoSYuLsLc6s87sCk0SN3lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734107553; c=relaxed/simple;
	bh=ax1A1fq1ID9TsWzI1wWFDTaeGNPQgEt4Z2I8VkL4lX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EJCJ/2CNJ4aEh1cLwIqkw0jwJo+zXMV5Xk9TMCISEQM+Pvuye4XKwTaQCG0rchVhE8EhqUV7t5CUlw9wAiEFHCSi0p8Y+dlfNAM0T6qm/46d6rwsXDGlXZ/OWap3/G9Gtafm8OkbrK+tz/MCBC8z/Cg/NMvQ19f8XkUA4fid+vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F08101595;
	Fri, 13 Dec 2024 08:32:58 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0ABCE3F5A1;
	Fri, 13 Dec 2024 08:32:29 -0800 (PST)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vincenzo.frascino@arm.com
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH 4/8] arm64: dts: morello: Add support for soc dts
Date: Fri, 13 Dec 2024 16:32:17 +0000
Message-ID: <20241213163221.3626261-5-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213163221.3626261-1-vincenzo.frascino@arm.com>
References: <20241213163221.3626261-1-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Morello architecture is an experimental extension to Armv8.2-A,
which extends the AArch64 state with the principles proposed in
version 7 of the Capability Hardware Enhanced RISC Instructions
(CHERI) ISA.

Introduce Morello SoC dts.

Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/boot/dts/arm/morello-soc.dts | 267 ++++++++++++++++++++++++
 1 file changed, 267 insertions(+)
 create mode 100644 arch/arm64/boot/dts/arm/morello-soc.dts

diff --git a/arch/arm64/boot/dts/arm/morello-soc.dts b/arch/arm64/boot/dts/arm/morello-soc.dts
new file mode 100644
index 000000000000..3c5247121e4d
--- /dev/null
+++ b/arch/arm64/boot/dts/arm/morello-soc.dts
@@ -0,0 +1,267 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * Copyright (c) 2021-2024, Arm Limited. All rights reserved.
+
+ */
+
+/dts-v1/;
+#include "morello.dtsi"
+
+/ {
+	model = "Arm Morello System Development Platform";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		secure-firmware@ff000000 {
+			reg = <0 0xff000000 0 0x01000000>;
+			no-map;
+		};
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+		cpu0: cpu0@0 {
+			compatible = "arm,neoverse-n1";
+			reg = <0x0 0x0>;
+			device_type = "cpu";
+			enable-method = "psci";
+			clocks = <&scmi_dvfs 0>;
+		};
+		cpu1: cpu1@100 {
+			compatible = "arm,neoverse-n1";
+			reg = <0x0 0x100>;
+			device_type = "cpu";
+			enable-method = "psci";
+			clocks = <&scmi_dvfs 0>;
+		};
+		cpu2: cpu2@10000 {
+			compatible = "arm,neoverse-n1";
+			reg = <0x0 0x10000>;
+			device_type = "cpu";
+			enable-method = "psci";
+			clocks = <&scmi_dvfs 1>;
+		};
+		cpu3: cpu3@10100 {
+			compatible = "arm,neoverse-n1";
+			reg = <0x0 0x10100>;
+			device_type = "cpu";
+			enable-method = "psci";
+			clocks = <&scmi_dvfs 1>;
+		};
+	};
+
+	/* The first bank of memory, memory map is actually provided by UEFI. */
+	memory@80000000 {
+		device_type = "memory";
+		/* [0x80000000-0xffffffff] */
+		reg = <0x00000000 0x80000000 0x0 0x7F000000>;
+	};
+
+	memory@8080000000 {
+		device_type = "memory";
+		/* [0x8080000000-0x83f7ffffff] */
+		reg = <0x00000080 0x80000000 0x3 0x78000000>;
+	};
+
+	smmu_pcie: iommu@4f400000 {
+		compatible = "arm,smmu-v3";
+		reg = <0 0x4f400000 0 0x40000>;
+		interrupts = <GIC_SPI 235 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 237 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 40 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 236 IRQ_TYPE_EDGE_RISING>;
+		interrupt-names = "eventq", "gerror", "priq", "cmdq-sync";
+		msi-parent = <&its2 0>;
+		#iommu-cells = <1>;
+		dma-coherent;
+	};
+
+	pcie_ctlr: pcie@28c0000000 {
+		compatible = "pci-host-ecam-generic";
+		device_type = "pci";
+		reg = <0x28 0xC0000000 0 0x10000000>;
+		bus-range = <0 255>;
+		linux,pci-domain = <0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		dma-coherent;
+		ranges = <0x01000000 0x00 0x00000000 0x00 0x6F000000 0x00 0x00800000>,
+		     <0x02000000 0x00 0x60000000 0x00 0x60000000 0x00 0x0F000000>,
+			 <0x42000000 0x09 0x00000000 0x09 0x00000000 0x1F 0xC0000000>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &gic 0 0 0 169 IRQ_TYPE_LEVEL_HIGH>,
+			<0 0 0 2 &gic 0 0 0 170 IRQ_TYPE_LEVEL_HIGH>,
+			<0 0 0 3 &gic 0 0 0 171 IRQ_TYPE_LEVEL_HIGH>,
+			<0 0 0 4 &gic 0 0 0 172 IRQ_TYPE_LEVEL_HIGH>;
+		msi-map = <0 &its_pcie 0 0x10000>;
+		iommu-map = <0 &smmu_pcie 0 0x10000>;
+		status = "okay";
+	};
+
+	smmu_ccix: iommu@4f000000 {
+		compatible = "arm,smmu-v3";
+		reg = <0 0x4f000000 0 0x40000>;
+		interrupts = <GIC_SPI 228 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 230 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 41 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 229 IRQ_TYPE_EDGE_RISING>;
+		interrupt-names = "eventq", "gerror", "priq", "cmdq-sync";
+		msi-parent = <&its1 0>;
+		#iommu-cells = <1>;
+		dma-coherent;
+	};
+
+	ccix_pcie_ctlr: pcie@4fc0000000 {
+		compatible = "pci-host-ecam-generic";
+		device_type = "pci";
+		reg = <0x4F 0xC0000000 0 0x10000000>;
+		bus-range = <0 255>;
+		linux,pci-domain = <1>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		dma-coherent;
+		ranges = <0x01000000 0x00 0x00000000 0x00 0x7F000000 0x00 0x00800000>,
+		     <0x02000000 0x00 0x70000000 0x00 0x70000000 0x00 0x0F000000>,
+			 <0x42000000 0x30 0x00000000 0x30 0x00000000 0x1F 0xC0000000>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &gic 0 0 0 201 IRQ_TYPE_LEVEL_HIGH>,
+			<0 0 0 2 &gic 0 0 0 202 IRQ_TYPE_LEVEL_HIGH>,
+			<0 0 0 3 &gic 0 0 0 203 IRQ_TYPE_LEVEL_HIGH>,
+			<0 0 0 4 &gic 0 0 0 204 IRQ_TYPE_LEVEL_HIGH>;
+		msi-map = <0 &its_ccix 0 0x10000>;
+		iommu-map = <0 &smmu_ccix 0 0x10000>;
+		status = "okay";
+	};
+
+	smmu_dp: iommu@2ce00000 {
+		compatible = "arm,smmu-v3";
+		reg = <0 0x2ce00000 0 0x40000>;
+		interrupts = <GIC_SPI 76 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 80 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 78 IRQ_TYPE_EDGE_RISING>;
+		interrupt-names = "eventq", "gerror", "cmdq-sync";
+		#iommu-cells = <1>;
+	};
+
+	dp0: display@2cc00000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "arm,mali-d32", "arm,mali-d71";
+		reg = <0 0x2cc00000 0 0x20000>;
+		interrupts = <0 69 4>;
+		clocks = <&dpu_aclk>;
+		clock-names = "aclk";
+		iommus = <&smmu_dp 0>, <&smmu_dp 1>, <&smmu_dp 2>, <&smmu_dp 3>,
+			<&smmu_dp 8>;
+
+		pl0: pipeline@0 {
+			reg = <0>;
+			clocks = <&dpu_pixel_clk>;
+			clock-names = "pxclk";
+			port {
+				dp_pl0_out0: endpoint {
+					remote-endpoint = <&tda998x_0_input>;
+				};
+			};
+		};
+	};
+
+	i2c@1c0f0000 {
+		compatible = "cdns,i2c-r1p14";
+		reg = <0x0 0x1c0f0000 0x0 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-frequency = <100000>;
+		interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&dpu_aclk>;
+
+		hdmi_tx: hdmi-transmitter@70 {
+			compatible = "nxp,tda998x";
+			reg = <0x70>;
+			video-ports = <0x234501>;
+			port {
+				tda998x_0_input: endpoint {
+					remote-endpoint = <&dp_pl0_out0>;
+				};
+			};
+		};
+	};
+
+	dpu_aclk: dpu_aclk {
+		/* 77.1 MHz derived from 24 MHz reference clock */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <350000000>;
+		clock-output-names = "aclk";
+	};
+
+	dpu_pixel_clk: dpu-pixel-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <148500000>;
+		clock-output-names = "pxclk";
+	};
+
+	firmware {
+		scmi {
+			compatible = "arm,scmi";
+			mbox-names = "tx", "rx";
+			mboxes = <&mailbox 1 0>, <&mailbox 1 1>;
+			shmem = <&cpu_scp_hpri0>, <&cpu_scp_hpri1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			scmi_dvfs: protocol@13 {
+				reg = <0x13>;
+				#clock-cells = <1>;
+			};
+			scmi_clk: protocol@14 {
+				reg = <0x14>;
+				#clock-cells = <1>;
+			};
+		};
+	};
+};
+
+&gic {
+	reg = <0x0 0x30000000 0 0x10000>,	/* GICD */
+	      <0x0 0x300c0000 0 0x80000>;	/* GICR */
+	interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+
+	its1: msi-controller@30040000 {
+		compatible = "arm,gic-v3-its";
+		msi-controller;
+		#msi-cells = <1>;
+		reg = <0x0 0x30040000 0x0 0x20000>;
+	};
+
+	its2: msi-controller@30060000 {
+		compatible = "arm,gic-v3-its";
+		msi-controller;
+		#msi-cells = <1>;
+		reg = <0x0 0x30060000 0x0 0x20000>;
+	};
+
+	its_ccix: msi-controller@30080000 {
+		compatible = "arm,gic-v3-its";
+		msi-controller;
+		#msi-cells = <1>;
+		reg = <0x0 0x30080000 0x0 0x20000>;
+	};
+
+	its_pcie: msi-controller@300a0000 {
+		compatible = "arm,gic-v3-its";
+		msi-controller;
+		#msi-cells = <1>;
+		reg = <0x0 0x300a0000 0x0 0x20000>;
+	};
+};
-- 
2.43.0


