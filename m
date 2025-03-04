Return-Path: <linux-kernel+bounces-543042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19451A4D0D9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9CA87A25B3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0068A13B29B;
	Tue,  4 Mar 2025 01:30:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D52417C7CA;
	Tue,  4 Mar 2025 01:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741051844; cv=none; b=ebUFW0PreIrTN9BG98qI0Eq9n1tV3npZGDIjqz9mQxi9zmDfV0AGU4z/a9sX2LhQIAD6zFVQ6zBETl8z0G0rZtVy6UlyFwVeVb84S0D1JklKHH5MyU02aZJh12n+nI/syd4z4wU208y2HLDnj+Eui0e371oN1nmQf8pFH2OkKJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741051844; c=relaxed/simple;
	bh=9njmWGde5Hy1SIzWOJiOrv7Fioe6AFCnvMNOCCiYS2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sK8+h+FN9Symgf7DpDpLZq5AOc/uzHfVS8UaFRVm22WjZYIM6ubb1Z2zubLzPAXilNoruSoQ9vefHd/Ps+pelujRHkiH9qgP5AERZYMK1NrlwPNaJhA7XMgWGCeRqfS6l90W1guvUxQ46i3OmY7sKWxH67EC+toz2tzjC6JId7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB3491C25;
	Mon,  3 Mar 2025 17:30:55 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFE3A3F673;
	Mon,  3 Mar 2025 17:30:39 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/15] dt-bindings: clk: sunxi-ng: document Allwinner A523 CCU
Date: Tue,  4 Mar 2025 01:27:54 +0000
Message-ID: <20250304012805.28594-5-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250304012805.28594-1-andre.przywara@arm.com>
References: <20250304012805.28594-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Allwinner A523/T527 SoCs have four CCUs, this adds the binding for
the main CCU.

The source clock list differs in some annoying details, and folding this
into the existing Allwinner CCU clock binding document gets quite
unwieldy, so create a new document for these CCUs.
Add the new compatible string, along with the required input clock
lists. This conditionally describes the input clock list, to make for
an easier patch adding the other CCUs.

Also add the DT binding headers, listing all the clocks with their ID
numbers.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../clock/allwinner,sun55i-a523-ccu.yaml      |  77 +++++++
 include/dt-bindings/clock/sun55i-a523-ccu.h   | 189 ++++++++++++++++++
 include/dt-bindings/reset/sun55i-a523-ccu.h   |  88 ++++++++
 3 files changed, 354 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun55i-a523-ccu.yaml
 create mode 100644 include/dt-bindings/clock/sun55i-a523-ccu.h
 create mode 100644 include/dt-bindings/reset/sun55i-a523-ccu.h

diff --git a/Documentation/devicetree/bindings/clock/allwinner,sun55i-a523-ccu.yaml b/Documentation/devicetree/bindings/clock/allwinner,sun55i-a523-ccu.yaml
new file mode 100644
index 0000000000000..2eacaeaeabac7
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/allwinner,sun55i-a523-ccu.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/allwinner,sun55i-a523-ccu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner A523 Clock Control Unit
+
+maintainers:
+  - Andre Przywara <andre.przywara@arm.com>
+
+properties:
+  "#clock-cells":
+    const: 1
+
+  "#reset-cells":
+    const: 1
+
+  compatible:
+    enum:
+      - allwinner,sun55i-a523-ccu
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 4
+    maxItems: 4
+
+  clock-names:
+    minItems: 4
+    maxItems: 4
+
+required:
+  - "#clock-cells"
+  - "#reset-cells"
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+if:
+  properties:
+    compatible:
+      enum:
+        - allwinner,sun55i-a523-ccu
+
+then:
+  properties:
+    clocks:
+      items:
+        - description: High Frequency Oscillator (usually at 24MHz)
+        - description: Low Frequency Oscillator (usually at 32kHz)
+        - description: Internal Oscillator
+        - description: Low Frequency Oscillator fanout
+
+    clock-names:
+      items:
+        - const: hosc
+        - const: losc
+        - const: iosc
+        - const: losc-fanout
+
+additionalProperties: false
+
+examples:
+  - |
+    ccu: clock@2001000 {
+        compatible = "allwinner,sun55i-a523-ccu";
+        reg = <0x2001000 0x1000>;
+        clocks = <&osc24M>, <&osc32k>, <&iosc>, <&r_ccu 2>;
+        clock-names = "hosc", "losc", "iosc", "losc-fanout";
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+    };
+
+...
diff --git a/include/dt-bindings/clock/sun55i-a523-ccu.h b/include/dt-bindings/clock/sun55i-a523-ccu.h
new file mode 100644
index 0000000000000..c8259ac5ada7a
--- /dev/null
+++ b/include/dt-bindings/clock/sun55i-a523-ccu.h
@@ -0,0 +1,189 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (C) 2024 Arm Ltd.
+ */
+
+#ifndef _DT_BINDINGS_CLK_SUN55I_A523_CCU_H_
+#define _DT_BINDINGS_CLK_SUN55I_A523_CCU_H_
+
+#define CLK_PLL_DDR0		0
+#define CLK_PLL_PERIPH0_4X	1
+#define CLK_PLL_PERIPH0_2X	2
+#define CLK_PLL_PERIPH0_800M	3
+#define CLK_PLL_PERIPH0_480M	4
+#define CLK_PLL_PERIPH0_600M	5
+#define CLK_PLL_PERIPH0_400M	6
+#define CLK_PLL_PERIPH0_300M	7
+#define CLK_PLL_PERIPH0_200M	8
+#define CLK_PLL_PERIPH0_160M	9
+#define CLK_PLL_PERIPH0_150M	10
+#define CLK_PLL_PERIPH1_4X	11
+#define CLK_PLL_PERIPH1_2X	12
+#define CLK_PLL_PERIPH1_800M	13
+#define CLK_PLL_PERIPH1_480M	14
+#define CLK_PLL_PERIPH1_600M	15
+#define CLK_PLL_PERIPH1_400M	16
+#define CLK_PLL_PERIPH1_300M	17
+#define CLK_PLL_PERIPH1_200M	18
+#define CLK_PLL_PERIPH1_160M	19
+#define CLK_PLL_PERIPH1_150M	20
+#define CLK_PLL_GPU		21
+#define CLK_PLL_VIDEO0_8X	22
+#define CLK_PLL_VIDEO0_4X	23
+#define CLK_PLL_VIDEO0_3X	24
+#define CLK_PLL_VIDEO1_8X	25
+#define CLK_PLL_VIDEO1_4X	26
+#define CLK_PLL_VIDEO1_3X	27
+#define CLK_PLL_VIDEO2_8X	28
+#define CLK_PLL_VIDEO2_4X	29
+#define CLK_PLL_VIDEO2_3X	30
+#define CLK_PLL_VIDEO3_8X	31
+#define CLK_PLL_VIDEO3_4X	32
+#define CLK_PLL_VIDEO3_3X	33
+#define CLK_PLL_VE		34
+#define CLK_PLL_AUDIO0_4X	35
+#define CLK_PLL_AUDIO0_2X	36
+#define CLK_PLL_AUDIO0		37
+#define CLK_PLL_NPU_4X		38
+#define CLK_PLL_NPU_2X		39
+#define CLK_PLL_NPU		40
+#define CLK_AHB			41
+#define CLK_APB0		42
+#define CLK_APB1		43
+#define CLK_MBUS		44
+#define CLK_DE			45
+#define CLK_BUS_DE		46
+#define CLK_DI			47
+#define CLK_BUS_DI		48
+#define CLK_G2D			49
+#define CLK_BUS_G2D		50
+#define CLK_GPU			51
+#define CLK_BUS_GPU		52
+#define CLK_CE			53
+#define CLK_BUS_CE		54
+#define CLK_BUS_CE_SYS		55
+#define CLK_VE			56
+#define CLK_BUS_VE		57
+#define CLK_BUS_DMA		58
+#define CLK_BUS_MSGBOX		59
+#define CLK_BUS_SPINLOCK	60
+#define CLK_HSTIMER0		61
+#define CLK_HSTIMER1		62
+#define CLK_HSTIMER2		63
+#define CLK_HSTIMER3		64
+#define CLK_HSTIMER4		65
+#define CLK_HSTIMER5		66
+#define CLK_BUS_HSTIMER		67
+#define CLK_BUS_DBG		68
+#define CLK_BUS_PWM0		69
+#define CLK_BUS_PWM1		70
+#define CLK_IOMMU		71
+#define CLK_BUS_IOMMU		72
+#define CLK_DRAM		73
+#define CLK_MBUS_DMA		74
+#define CLK_MBUS_VE		75
+#define CLK_MBUS_CE		76
+#define CLK_MBUS_CSI		77
+#define CLK_MBUS_ISP		78
+#define CLK_MBUS_EMAC1		79
+#define CLK_BUS_DRAM		80
+#define CLK_NAND0		81
+#define CLK_NAND1		82
+#define CLK_BUS_NAND		83
+#define CLK_MMC0		84
+#define CLK_MMC1		85
+#define CLK_MMC2		86
+#define CLK_BUS_SYSDAP		87
+#define CLK_BUS_MMC0		88
+#define CLK_BUS_MMC1		89
+#define CLK_BUS_MMC2		90
+#define CLK_BUS_UART0		91
+#define CLK_BUS_UART1		92
+#define CLK_BUS_UART2		93
+#define CLK_BUS_UART3		94
+#define CLK_BUS_UART4		95
+#define CLK_BUS_UART5		96
+#define CLK_BUS_UART6		97
+#define CLK_BUS_UART7		98
+#define CLK_BUS_I2C0		99
+#define CLK_BUS_I2C1		100
+#define CLK_BUS_I2C2		101
+#define CLK_BUS_I2C3		102
+#define CLK_BUS_I2C4		103
+#define CLK_BUS_I2C5		104
+#define CLK_BUS_CAN		105
+#define CLK_SPI0		106
+#define CLK_SPI1		107
+#define CLK_SPI2		108
+#define CLK_SPIFC		109
+#define CLK_BUS_SPI0		110
+#define CLK_BUS_SPI1		111
+#define CLK_BUS_SPI2		112
+#define CLK_BUS_SPIFC		113
+#define CLK_EMAC0_25M		114
+#define CLK_EMAC1_25M		115
+#define CLK_BUS_EMAC0		116
+#define CLK_BUS_EMAC1		117
+#define CLK_IR_RX		118
+#define CLK_BUS_IR_RX		119
+#define CLK_IR_TX		120
+#define CLK_BUS_IR_TX		121
+#define CLK_GPADC0		122
+#define CLK_GPADC1		123
+#define CLK_BUS_GPADC0		124
+#define CLK_BUS_GPADC1		125
+#define CLK_BUS_THS		126
+#define CLK_USB_OHCI0		127
+#define CLK_USB_OHCI1		128
+#define CLK_BUS_OHCI0		129
+#define CLK_BUS_OHCI1		130
+#define CLK_BUS_EHCI0		131
+#define CLK_BUS_EHCI1		132
+#define CLK_BUS_OTG		133
+#define CLK_BUS_LRADC		134
+#define CLK_PCIE_AUX		135
+#define CLK_BUS_DISPLAY0_TOP	136
+#define CLK_BUS_DISPLAY1_TOP	137
+#define CLK_HDMI_24M		138
+#define CLK_HDMI_CEC_32K	139
+#define CLK_HDMI_CEC		140
+#define CLK_BUS_HDMI		141
+#define CLK_MIPI_DSI0		142
+#define CLK_MIPI_DSI1		143
+#define CLK_BUS_MIPI_DSI0	144
+#define CLK_BUS_MIPI_DSI1	145
+#define CLK_TCON_LCD0		146
+#define CLK_TCON_LCD1		147
+#define CLK_TCON_LCD2		148
+#define CLK_COMBOPHY_DSI0	149
+#define CLK_COMBOPHY_DSI1	150
+#define CLK_BUS_TCON_LCD0	151
+#define CLK_BUS_TCON_LCD1	152
+#define CLK_BUS_TCON_LCD2	153
+#define CLK_TCON_TV0		154
+#define CLK_TCON_TV1		155
+#define CLK_BUS_TCON_TV0	156
+#define CLK_BUS_TCON_TV1	157
+#define CLK_EDP			158
+#define CLK_BUS_EDP		159
+#define CLK_LEDC		160
+#define CLK_BUS_LEDC		161
+#define CLK_CSI_TOP		162
+#define CLK_CSI_MCLK0		163
+#define CLK_CSI_MCLK1		164
+#define CLK_CSI_MCLK2		165
+#define CLK_CSI_MCLK3		166
+#define CLK_BUS_CSI		167
+#define CLK_ISP			168
+#define CLK_DSP			169
+#define CLK_FANOUT_24M		170
+#define CLK_FANOUT_12M		171
+#define CLK_FANOUT_16M		172
+#define CLK_FANOUT_25M		173
+#define CLK_FANOUT_27M		174
+#define CLK_FANOUT_PCLK		175
+#define CLK_FANOUT0		176
+#define CLK_FANOUT1		177
+#define CLK_FANOUT2		178
+
+#endif /* _DT_BINDINGS_CLK_SUN55I_A523_CCU_H_ */
diff --git a/include/dt-bindings/reset/sun55i-a523-ccu.h b/include/dt-bindings/reset/sun55i-a523-ccu.h
new file mode 100644
index 0000000000000..e1e4c5f4cdd89
--- /dev/null
+++ b/include/dt-bindings/reset/sun55i-a523-ccu.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (c) 2024 Arm Ltd.
+ */
+
+#ifndef _DT_BINDINGS_RST_SUN55I_A523_CCU_H_
+#define _DT_BINDINGS_RST_SUN55I_A523_CCU_H_
+
+#define RST_MBUS		0
+#define RST_BUS_NSI		1
+#define RST_BUS_DE		2
+#define RST_BUS_DI		3
+#define RST_BUS_G2D		4
+#define RST_BUS_SYS		5
+#define RST_BUS_GPU		6
+#define RST_BUS_CE		7
+#define RST_BUS_SYS_CE		8
+#define RST_BUS_VE		9
+#define RST_BUS_DMA		10
+#define RST_BUS_MSGBOX		11
+#define RST_BUS_SPINLOCK	12
+#define RST_BUS_CPUXTIMER	13
+#define RST_BUS_DBG		14
+#define RST_BUS_PWM0		15
+#define RST_BUS_PWM1		16
+#define RST_BUS_DRAM		17
+#define RST_BUS_NAND		18
+#define RST_BUS_MMC0		19
+#define RST_BUS_MMC1		20
+#define RST_BUS_MMC2		21
+#define RST_BUS_SYSDAP		22
+#define RST_BUS_UART0		23
+#define RST_BUS_UART1		24
+#define RST_BUS_UART2		25
+#define RST_BUS_UART3		26
+#define RST_BUS_UART4		27
+#define RST_BUS_UART5		28
+#define RST_BUS_UART6		29
+#define RST_BUS_UART7		30
+#define RST_BUS_I2C0		31
+#define RST_BUS_I2C1		32
+#define RST_BUS_I2C2		33
+#define RST_BUS_I2C3		34
+#define RST_BUS_I2C4		35
+#define RST_BUS_I2C5		36
+#define RST_BUS_CAN		37
+#define RST_BUS_SPI0		38
+#define RST_BUS_SPI1		39
+#define RST_BUS_SPI2		40
+#define RST_BUS_SPIFC		41
+#define RST_BUS_EMAC0		42
+#define RST_BUS_EMAC1		43
+#define RST_BUS_IR_RX		44
+#define RST_BUS_IR_TX		45
+#define RST_BUS_GPADC0		46
+#define RST_BUS_GPADC1		47
+#define RST_BUS_THS		48
+#define RST_USB_PHY0		49
+#define RST_USB_PHY1		50
+#define RST_BUS_OHCI0		51
+#define RST_BUS_OHCI1		52
+#define RST_BUS_EHCI0		53
+#define RST_BUS_EHCI1		54
+#define RST_BUS_OTG		55
+#define RST_BUS_3		56
+#define RST_BUS_LRADC		57
+#define RST_BUS_PCIE_USB3	58
+#define RST_BUS_DISPLAY0_TOP	59
+#define RST_BUS_DISPLAY1_TOP	60
+#define RST_BUS_HDMI_MAIN	61
+#define RST_BUS_HDMI_SUB	62
+#define RST_BUS_MIPI_DSI0	63
+#define RST_BUS_MIPI_DSI1	64
+#define RST_BUS_TCON_LCD0	65
+#define RST_BUS_TCON_LCD1	66
+#define RST_BUS_TCON_LCD2	67
+#define RST_BUS_TCON_TV0	68
+#define RST_BUS_TCON_TV1	69
+#define RST_BUS_LVDS0		70
+#define RST_BUS_LVDS1		71
+#define RST_BUS_EDP		72
+#define RST_BUS_VIDEO_OUT0	73
+#define RST_BUS_VIDEO_OUT1	74
+#define RST_BUS_LEDC		75
+#define RST_BUS_CSI		76
+#define RST_BUS_ISP		77
+
+#endif /* _DT_BINDINGS_RST_SUN55I_A523_CCU_H_ */
-- 
2.46.3


