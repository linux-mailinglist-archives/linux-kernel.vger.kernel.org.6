Return-Path: <linux-kernel+bounces-445167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A105B9F1245
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA64F16AF75
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4DE1E5739;
	Fri, 13 Dec 2024 16:32:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6351C143722;
	Fri, 13 Dec 2024 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734107552; cv=none; b=bpW/ilMoNRDWb3uFjVkjz8EAjns+ZELrG7G2JbDcKWJL5mWzMPc4lnWvcIph9bAvNye64HR2dwbT3N8T5BCdcFtH4hmAqgU0+S8sPG2CD1pzTpkHH895Yf6WmlpdSdswu6lQodcuq/1qfW+6YlwCx8YTI+yxxktrfmdymz5b6Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734107552; c=relaxed/simple;
	bh=7QmUuOLjrlvo8JEWxRoxx5QtErFo+QDPyop3apnkrr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VrJPzh5oFnbP2UEXV4mRhhQae1jniMIbJLaMsX+9XVeylwMYPZ2imYLrDjTAGwKbqhVeW1ApX7gpWUk/GYPndv4tY7sA9/RWesgRYRtjQv6d5FwlAXHs/cFIEMOWxx1gW4U5jRrHAGDTq60c6Ah7xEaNcMp3/wSNTFZ+a0bmqwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB7DE1762;
	Fri, 13 Dec 2024 08:32:57 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA0E13F5A1;
	Fri, 13 Dec 2024 08:32:28 -0800 (PST)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vincenzo.frascino@arm.com
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH 3/8] arm64: dts: morello: Add support for common functionalities
Date: Fri, 13 Dec 2024 16:32:16 +0000
Message-ID: <20241213163221.3626261-4-vincenzo.frascino@arm.com>
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

The Morello Platform (soc) and the Fixed Virtual Platfom (fvp) share
some functionalities that have conveniently been included in
morello.dtsi to avoid duplication.

Introduce morello.dtsi.

Note: Morello fvp will be introduced with a future patch series.

Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/boot/dts/arm/morello.dtsi | 112 +++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)
 create mode 100644 arch/arm64/boot/dts/arm/morello.dtsi

diff --git a/arch/arm64/boot/dts/arm/morello.dtsi b/arch/arm64/boot/dts/arm/morello.dtsi
new file mode 100644
index 000000000000..9d84a0840c5b
--- /dev/null
+++ b/arch/arm64/boot/dts/arm/morello.dtsi
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * Copyright (c) 2020-2024, Arm Limited. All rights reserved.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "arm,morello";
+
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		serial0 = &soc_uart0;
+	};
+
+	gic: interrupt-controller@2c010000 {
+		compatible = "arm,gic-v3";
+		#address-cells = <2>;
+		#interrupt-cells = <3>;
+		#size-cells = <2>;
+		ranges;
+		interrupt-controller;
+	};
+
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	spe-pmu {
+		compatible = "arm,statistical-profiling-extension-v1";
+		interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	mailbox: mhu@45000000 {
+		compatible = "arm,mhu-doorbell", "arm,primecell";
+		reg = <0x0 0x45000000 0x0 0x1000>;
+		interrupts = <GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "mhu-lpri-rx",
+				  "mhu-hpri-rx";
+		#mbox-cells = <2>;
+		mbox-name = "ARM-MHU";
+		clocks = <&soc_refclk50mhz>;
+		clock-names = "apb_pclk";
+	};
+
+	sram: sram@45200000 {
+		compatible = "mmio-sram";
+		reg = <0x0 0x06000000 0x0 0x8000>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x0 0x06000000 0x8000>;
+
+		cpu_scp_hpri0: scp-sram@0 {
+			compatible = "arm,scmi-shmem";
+			reg = <0x0 0x80>;
+		};
+
+		cpu_scp_hpri1: scp-sram@80 {
+			compatible = "arm,scmi-shmem";
+			reg = <0x80 0x80>;
+		};
+	};
+
+	soc_refclk50mhz: refclk50mhz {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <50000000>;
+		clock-output-names = "apb_pclk";
+	};
+
+	soc_refclk85mhz: refclk85mhz {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <85000000>;
+		clock-output-names = "iofpga:aclk";
+	};
+
+	soc_uartclk:  uartclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <50000000>;
+		clock-output-names = "uartclk";
+	};
+
+	soc_uart0: serial@2a400000 {
+		compatible = "arm,pl011", "arm,primecell";
+		reg = <0x0 0x2a400000 0x0 0x1000>;
+		interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&soc_uartclk>, <&soc_refclk50mhz>;
+		clock-names = "uartclk", "apb_pclk";
+		status = "okay";
+	};
+};
-- 
2.43.0


