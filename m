Return-Path: <linux-kernel+bounces-570985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60055A6B796
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B727817F3AC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8091F30A4;
	Fri, 21 Mar 2025 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="3C4Pz0QD"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855511F7575;
	Fri, 21 Mar 2025 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742549692; cv=none; b=hcC1Bj857aUPsGfP37MVuAjOWwG7+y3VAH8HO4ET1b3hn8zj4uJNCrRb5eI/VS24EEJ2Tkpa0ux/zDgkeVG4KqY+hUc6onRIlSaGq9b2B4oe8hdgCWUU8M/+PgeDZfm0EYkDv41qHtEOHKPe0D4SHMD0zOAINEL5bwoicyJhAc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742549692; c=relaxed/simple;
	bh=t7LKlXmm9Os6WweSaWIjEPkfKtxH+yvozurZfSOzu24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=O+rkWXpdou0nE4OdzVaerj7LQXx5AumXxV/PM1c9aSmY4qJShb18dLKgxNmxR3fdxcuhY8eZFYNyl0C2PGlI+3BK0kfggUJ88jl3uHNGGzO5ZIM36MMWBWeQ9VPefwZqXsyLvjJjtKKTVXR0tovlHHDk1EyYft2GAVJIPVofpY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=3C4Pz0QD; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L8EkM7031293;
	Fri, 21 Mar 2025 10:34:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	opPwArELHBfZj8x6WdNmF9SwLgcR2iGSRV/rg4Icygg=; b=3C4Pz0QDxQKKLe6D
	vCp4oIzriLId/P+Ccik6Dp9PEAsPE2TCaEkS2NR7Mb7PAJuS4hZMxNnImAazGjXg
	hUb1jV4UGpwZD7Pw45j2/SHZmJE2hrds+pv7v9EvEP+m4zRq0BUB2yLz7ZDTbSg2
	aoVQiDciFLJvBbnce8K5f4MOK8Dr3+g+gyolB2MZ0xHZA1BVCJy21r7SqSJKP3Qv
	FjNTKgjCVQNzoobVYv8Iwq4jl0NZ+hkzsB6nLw9nxcPekrkIYYF8rrs7XlzH2xMh
	66vK4eaI08S+y0xtDrpyHY7oGWfk/9/UVX6CfjVA8dsEhGlhwknLFjIpgaTkyAaC
	nD03+g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45gf26dh0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 10:34:24 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 186564005B;
	Fri, 21 Mar 2025 10:33:17 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5FC4A7BC8DA;
	Fri, 21 Mar 2025 10:32:27 +0100 (CET)
Received: from localhost (10.252.27.50) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Mar
 2025 10:32:27 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 21 Mar 2025 10:32:22 +0100
Subject: [PATCH v6 2/7] dt-bindings: memory-controllers: Add STM32 Octo
 Memory Manager controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250321-upstream_ospi_v6-v6-2-37bbcab43439@foss.st.com>
References: <20250321-upstream_ospi_v6-v6-0-37bbcab43439@foss.st.com>
In-Reply-To: <20250321-upstream_ospi_v6-v6-0-37bbcab43439@foss.st.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon
	<will@kernel.org>
CC: <christophe.kerello@foss.st.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Patrice Chotard
	<patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_03,2025-03-20_01,2024-11-22_01

Add bindings for STM32 Octo Memory Manager (OMM) controller.

OMM manages:
  - the muxing between 2 OSPI busses and 2 output ports.
    There are 4 possible muxing configurations:
      - direct mode (no multiplexing): OSPI1 output is on port 1 and OSPI2
        output is on port 2
      - OSPI1 and OSPI2 are multiplexed over the same output port 1
      - swapped mode (no multiplexing), OSPI1 output is on port 2,
        OSPI2 output is on port 1
      - OSPI1 and OSPI2 are multiplexed over the same output port 2
  - the split of the memory area shared between the 2 OSPI instances.
  - chip select selection override.
  - the time between 2 transactions in multiplexed mode.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 .../memory-controllers/st,stm32mp25-omm.yaml       | 227 +++++++++++++++++++++
 1 file changed, 227 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/st,stm32mp25-omm.yaml b/Documentation/devicetree/bindings/memory-controllers/st,stm32mp25-omm.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..2f8fa7569009369ebd077e4c6f4ab409a91838a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/st,stm32mp25-omm.yaml
@@ -0,0 +1,227 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/st,stm32mp25-omm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STM32 Octo Memory Manager (OMM)
+
+maintainers:
+  - Patrice Chotard <patrice.chotard@foss.st.com>
+
+description: |
+  The STM32 Octo Memory Manager is a low-level interface that enables an
+  efficient OCTOSPI pin assignment with a full I/O matrix (before alternate
+  function map) and multiplex of single/dual/quad/octal SPI interfaces over
+  the same bus. It Supports up to:
+    - Two single/dual/quad/octal SPI interfaces
+    - Two ports for pin assignment
+
+properties:
+  compatible:
+    const: st,stm32mp25-omm
+
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 1
+
+  ranges:
+    description: |
+      Reflects the memory layout with four integer values per OSPI instance.
+      Format:
+      <chip-select> 0 <registers base address> <size>
+    minItems: 2
+    maxItems: 2
+
+  reg:
+    items:
+      - description: OMM registers
+      - description: OMM memory map area
+
+  reg-names:
+    items:
+      - const: regs
+      - const: memory_map
+
+  memory-region:
+    description: |
+      Memory region shared between the 2 OCTOSPI instance.
+      One or two phandle to a node describing a memory mapped region
+      depending of child number.
+    minItems: 1
+    maxItems: 2
+
+  memory-region-names:
+    description: |
+      OCTOSPI instance's name to which memory region is associated
+    items:
+      enum: [ospi1, ospi2]
+    minItems: 1
+    maxItems: 2
+
+  clocks:
+    minItems: 3
+    maxItems: 3
+
+  clock-names:
+    items:
+      enum: [omm, ospi1, ospi2]
+    minItems: 3
+    maxItems: 3
+
+  resets:
+    minItems: 3
+    maxItems: 3
+
+  reset-names:
+    items:
+      enum: [omm, ospi1, ospi2]
+    minItems: 3
+    maxItems: 3
+
+  access-controllers:
+    maxItems: 1
+
+  st,syscfg-amcr:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: |
+      The Address Mapping Control Register (AMCR) is used to split the 256MB
+      memory map area shared between the 2 OSPI instance. The Octo Memory
+      Manager sets the AMCR depending of the memory-region configuration.
+      The memory split bitmask description is:
+        - 000: OCTOSPI1 (256 Mbytes), OCTOSPI2 unmapped
+        - 001: OCTOSPI1 (192 Mbytes), OCTOSPI2 (64 Mbytes)
+        - 010: OCTOSPI1 (128 Mbytes), OCTOSPI2 (128 Mbytes)
+        - 011: OCTOSPI1 (64 Mbytes), OCTOSPI2 (192 Mbytes)
+        - 1xx: OCTOSPI1 unmapped, OCTOSPI2 (256 Mbytes)
+    items:
+      - description: phandle to syscfg
+      - description: register offset within syscfg
+      - description: register bitmask for memory split
+
+  st,omm-req2ack-ns:
+    description: |
+      In multiplexed mode (MUXEN = 1), this field defines the time in
+      nanoseconds between two transactions.
+    default: 0
+
+  st,omm-cssel-ovr:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Configure the chip select selector override for the 2 OCTOSPIs.
+      - 0: OCTOSPI1 chip select send to NCS1 OCTOSPI2 chip select send to NCS1
+      - 1: OCTOSPI1 chip select send to NCS2 OCTOSPI2 chip select send to NCS1
+      - 2: OCTOSPI1 chip select send to NCS1 OCTOSPI2 chip select send to NCS2
+      - 3: OCTOSPI1 chip select send to NCS2 OCTOSPI2 chip select send to NCS2
+    minimum: 0
+    maximum: 3
+    default: 0
+
+  st,omm-mux:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Configure the muxing between the 2 OCTOSPIs busses and the 2 output ports.
+      - 0: direct mode
+      - 1: mux OCTOSPI1 and OCTOSPI2 to port 1
+      - 2: swapped mode
+      - 3: mux OCTOSPI1 and OCTOSPI2 to port 2
+    minimum: 0
+    maximum: 3
+    default: 0
+
+  power-domains:
+    maxItems: 1
+
+patternProperties:
+  ^spi@[a-f0-9]+$:
+    type: object
+    $ref: /schemas/spi/st,stm32mp25-ospi.yaml#
+    description: Required spi child node
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - st,syscfg-amcr
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/st,stm32mp25-rcc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/reset/st,stm32mp25-rcc.h>
+    ommanager@40500000 {
+      compatible = "st,stm32mp25-omm";
+      reg = <0x40500000 0x400>, <0x60000000 0x10000000>;
+      reg-names = "regs", "memory_map";
+      ranges = <0 0 0x40430000 0x400>,
+               <1 0 0x40440000 0x400>;
+      memory-region = <&mm_ospi1>, <&mm_ospi2>;
+      memory-region-names = "ospi1", "ospi2";
+      pinctrl-0 = <&ospi_port1_clk_pins_a
+                   &ospi_port1_io03_pins_a
+                   &ospi_port1_cs0_pins_a>;
+      pinctrl-1 = <&ospi_port1_clk_sleep_pins_a
+                   &ospi_port1_io03_sleep_pins_a
+                   &ospi_port1_cs0_sleep_pins_a>;
+      pinctrl-names = "default", "sleep";
+      clocks = <&rcc CK_BUS_OSPIIOM>,
+               <&scmi_clk CK_SCMI_OSPI1>,
+               <&scmi_clk CK_SCMI_OSPI2>;
+      clock-names = "omm", "ospi1", "ospi2";
+      resets = <&rcc OSPIIOM_R>,
+               <&scmi_reset RST_SCMI_OSPI1>,
+               <&scmi_reset RST_SCMI_OSPI2>;
+      reset-names = "omm", "ospi1", "ospi2";
+      access-controllers = <&rifsc 111>;
+      power-domains = <&CLUSTER_PD>;
+      #address-cells = <2>;
+      #size-cells = <1>;
+      st,syscfg-amcr = <&syscfg 0x2c00 0x7>;
+      st,omm-req2ack-ns = <0>;
+      st,omm-mux = <0>;
+      st,omm-cssel-ovr = <0>;
+
+      spi@40430000 {
+        compatible = "st,stm32mp25-ospi";
+        reg = <0 0 0x400>;
+        memory-region = <&mm_ospi1>;
+        interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
+        dmas = <&hpdma 2 0x62 0x00003121 0x0>,
+               <&hpdma 2 0x42 0x00003112 0x0>;
+        dma-names = "tx", "rx";
+        clocks = <&scmi_clk CK_SCMI_OSPI1>;
+        resets = <&scmi_reset RST_SCMI_OSPI1>, <&scmi_reset RST_SCMI_OSPI1DLL>;
+        access-controllers = <&rifsc 74>;
+        power-domains = <&CLUSTER_PD>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        st,syscfg-dlyb = <&syscfg 0x1000>;
+      };
+
+      spi@40440000 {
+        compatible = "st,stm32mp25-ospi";
+        reg = <1 0 0x400>;
+        memory-region = <&mm_ospi1>;
+        interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+        dmas = <&hpdma 3 0x62 0x00003121 0x0>,
+               <&hpdma 3 0x42 0x00003112 0x0>;
+        dma-names = "tx", "rx";
+        clocks = <&scmi_clk CK_KER_OSPI2>;
+        resets = <&scmi_reset RST_SCMI_OSPI2>, <&scmi_reset RST_SCMI_OSPI1DLL>;
+        access-controllers = <&rifsc 75>;
+        power-domains = <&CLUSTER_PD>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        st,syscfg-dlyb = <&syscfg 0x1000>;
+      };
+    };

-- 
2.25.1


