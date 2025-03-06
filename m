Return-Path: <linux-kernel+bounces-549563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D84C6A553ED
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA270179EB9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636E427BF93;
	Thu,  6 Mar 2025 18:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="Jbq2Oe+K";
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="JoGcLgTs"
Received: from bayard.4d2.org (bayard.4d2.org [155.254.16.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA4F26B0AE;
	Thu,  6 Mar 2025 18:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.254.16.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741284003; cv=none; b=W9o17wX3mEInvXeDVxdMLiROqd3qhUYpsv2teCkZUhi2D+cD1lnLy2l87p42PAElwTmUfEGGeLL4QWr1TsXNZeof4hOtetBxU/iP5pqwoqm3l9xzHVxfzjwa8XTpVennRKxCKXDopuZiki39l9ByMixrvjSnA2gmUk8BnjFxnUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741284003; c=relaxed/simple;
	bh=pBpY3vSiCJ0IC8h4F+XRlrj+Tvn/Dd4xA1lbHaifk94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=drWt7xH0rG9jgBFINTsTS4hM0fdK1rOePlQXezzM4cnl+p6BSUZZPLT4Sw7gfK5Jg64ngyepar5o0uNl1ET99W/eORLnPTtL4YSbzGq06YZ4KZSWklp7eUaBPGXeHNI6MFG1YDrVzhECKPETsE7m69vhJNlE0WRzJVG2ZEQe4Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org; spf=pass smtp.mailfrom=4d2.org; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=Jbq2Oe+K; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=JoGcLgTs; arc=none smtp.client-ip=155.254.16.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4d2.org
Received: from bayard.4d2.org (bayard.4d2.org [127.0.0.1])
	by bayard.4d2.org (Postfix) with ESMTP id 42068EC59F5;
	Thu, 06 Mar 2025 09:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1741283994; bh=pBpY3vSiCJ0IC8h4F+XRlrj+Tvn/Dd4xA1lbHaifk94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jbq2Oe+KjwO1KT0BvCdCbfz48uo/yBHNy+pqecv6A+1OyT/k9rJy/BPncU3ThYyUF
	 CTEqKsHJ7+NkkOB59E7Y0ys4tJ4hsNfvHWqQ5YXt4EvipVhb+wlyHqQ7s8g0vyEA90
	 MFEB8s8xtgA4OqKSveIX69J2BA9yKHUIs8ITt3it0xUiXQjEcspOhtbTzD67NhaTNT
	 NLuKNkws1N59DGfHfk/36SsXPxmTamGh58vg9n+Fhbe+ybUltj+HR4YKB54djgru4P
	 +NqUpiq7oZ4d8uN4qWJf7I38c4T0olCgjdqZvuLstNjO0Mu1iiUHbF2i1lR5TouRCd
	 yMbt4IUboke8A==
X-Virus-Scanned: amavisd-new at 4d2.org
Authentication-Results: bayard.4d2.org (amavisd-new); dkim=pass (2048-bit key)
 header.d=4d2.org
Received: from bayard.4d2.org ([127.0.0.1])
 by bayard.4d2.org (bayard.4d2.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qDI-AcHUpMCP; Thu,  6 Mar 2025 09:59:52 -0800 (PST)
Received: from localhost.localdomain (unknown [183.217.80.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: heylenay@4d2.org)
	by bayard.4d2.org (Postfix) with ESMTPSA id 55A42EC59F6;
	Thu, 06 Mar 2025 09:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1741283992; bh=pBpY3vSiCJ0IC8h4F+XRlrj+Tvn/Dd4xA1lbHaifk94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JoGcLgTssZp7AUy1kLjjBySCN4vwwQ04wDg+p+WB4+uTzDcMR1YiLXPeI9mEArgvn
	 8NvdM+Po9xcb18N9mRLoSpokVQlgpMXmIIpqMo51O6A8RR5sPNXgkl1adyged7G7wP
	 YggDvLT5N1gFjvV3YBoxsuoc7q00g+PrHhTAknptFDM/CngUgejIn+fGTzR7g6uj7f
	 U4ahD9Aj7NSUA3fKGeI9nUXy7EnLuccqR4eIaXiLzJIGK259HDx90iQnJzc+v1mmGj
	 901nlKbn7LggGsCNu/q5onoyqI4aCFAFaCkHo1smnZcnAxf9dbH4MhHbVps3tigybF
	 55f70Tukz9sqw==
From: Haylen Chu <heylenay@4d2.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Haylen Chu <heylenay@outlook.com>,
	Yixun Lan <dlan@gentoo.org>
Cc: linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	spacemit@lists.linux.dev,
	Inochi Amaoto <inochiama@outlook.com>,
	Chen Wang <unicornxdotw@foxmail.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
	Haylen Chu <heylenay@4d2.org>
Subject: [PATCH v5 1/5] dt-bindings: soc: spacemit: Add spacemit,k1-syscon
Date: Thu,  6 Mar 2025 17:57:47 +0000
Message-ID: <20250306175750.22480-3-heylenay@4d2.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306175750.22480-2-heylenay@4d2.org>
References: <20250306175750.22480-2-heylenay@4d2.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document APMU, MPMU and APBC syscons found on Spacemit K1 SoC, which are
capable of generating clock and reset signals. Additionally, APMU and MPMU
manage power domains.

Signed-off-by: Haylen Chu <heylenay@4d2.org>
---
 .../soc/spacemit/spacemit,k1-syscon.yaml      |  80 +++++++
 include/dt-bindings/clock/spacemit,k1-ccu.h   | 210 ++++++++++++++++++
 2 files changed, 290 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
 create mode 100644 include/dt-bindings/clock/spacemit,k1-ccu.h

diff --git a/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml b/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
new file mode 100644
index 000000000000..07a6728e6f86
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/spacemit/spacemit,k1-syscon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Spacemit K1 SoC System Controller
+
+maintainers:
+  - Haylen Chu <heylenay@4d2.org>
+
+description:
+  System controllers found on Spacemit K1 SoC, which are capable of
+  clock, reset and power-management functions.
+
+properties:
+  compatible:
+    enum:
+      - spacemit,k1-syscon-apbc
+      - spacemit,k1-syscon-apmu
+      - spacemit,k1-syscon-mpmu
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 4
+
+  clock-names:
+    items:
+      - const: osc
+      - const: vctcxo_1m
+      - const: vctcxo_3m
+      - const: vctcxo_24m
+
+  "#clock-cells":
+    const: 1
+    description:
+      See <dt-bindings/clock/spacemit,k1-ccu.h> for valid indices.
+
+  "#power-domain-cells":
+    const: 1
+
+  "#reset-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - "#clock-cells"
+  - "#reset-cells"
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: spacemit,k1-syscon-apbc
+    then:
+      properties:
+        "#power-domain-cells": false
+    else:
+      required:
+        - "#power-domain-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    system-controller@d4050000 {
+        compatible = "spacemit,k1-syscon-mpmu";
+        reg = <0xd4050000 0x209c>;
+        clocks = <&osc>, <&vctcxo_1m>, <&vctcxo_3m>, <&vctcxo_24m>;
+        clock-names = "osc", "vctcxo_1m", "vctcxo_3m", "vctcxo_24m";
+        #clock-cells = <1>;
+        #power-domain-cells = <1>;
+        #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/spacemit,k1-ccu.h b/include/dt-bindings/clock/spacemit,k1-ccu.h
new file mode 100644
index 000000000000..1f8b01db44ca
--- /dev/null
+++ b/include/dt-bindings/clock/spacemit,k1-ccu.h
@@ -0,0 +1,210 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2024 Haylen Chu <heylenay@outlook.com>
+ */
+
+#ifndef _DT_BINDINGS_SPACEMIT_CCU_H_
+#define _DT_BINDINGS_SPACEMIT_CCU_H_
+
+/*	MPMU clocks	*/
+#define CLK_PLL1_307P2		0
+#define CLK_PLL1_76P8		1
+#define CLK_PLL1_61P44		2
+#define CLK_PLL1_153P6		3
+#define CLK_PLL1_102P4		4
+#define CLK_PLL1_51P2		5
+#define CLK_PLL1_51P2_AP	6
+#define CLK_PLL1_57P6		7
+#define CLK_PLL1_25P6		8
+#define CLK_PLL1_12P8		9
+#define CLK_PLL1_12P8_WDT	10
+#define CLK_PLL1_6P4		11
+#define CLK_PLL1_3P2		12
+#define CLK_PLL1_1P6		13
+#define CLK_PLL1_0P8		14
+#define CLK_PLL1_409P6		15
+#define CLK_PLL1_204P8		16
+#define CLK_PLL1_491		17
+#define CLK_PLL1_245P76		18
+#define CLK_PLL1_614		19
+#define CLK_PLL1_47P26		20
+#define CLK_PLL1_31P5		21
+#define CLK_PLL1_819		22
+#define CLK_PLL1_1228		23
+#define CLK_SLOW_UART		24
+#define CLK_SLOW_UART1		25
+#define CLK_SLOW_UART2		26
+#define CLK_WDT			27
+#define CLK_RIPC		28
+#define CLK_I2S_SYSCLK		29
+#define CLK_I2S_BCLK		30
+#define CLK_APB			31
+#define CLK_WDT_BUS		32
+
+/*	APBC clocks	*/
+#define CLK_UART0		0
+#define CLK_UART2		1
+#define CLK_UART3		2
+#define CLK_UART4		3
+#define CLK_UART5		4
+#define CLK_UART6		5
+#define CLK_UART7		6
+#define CLK_UART8		7
+#define CLK_UART9		8
+#define CLK_GPIO		9
+#define CLK_PWM0		10
+#define CLK_PWM1		11
+#define CLK_PWM2		12
+#define CLK_PWM3		13
+#define CLK_PWM4		14
+#define CLK_PWM5		15
+#define CLK_PWM6		16
+#define CLK_PWM7		17
+#define CLK_PWM8		18
+#define CLK_PWM9		19
+#define CLK_PWM10		20
+#define CLK_PWM11		21
+#define CLK_PWM12		22
+#define CLK_PWM13		23
+#define CLK_PWM14		24
+#define CLK_PWM15		25
+#define CLK_PWM16		26
+#define CLK_PWM17		27
+#define CLK_PWM18		28
+#define CLK_PWM19		29
+#define CLK_SSP3		30
+#define CLK_RTC			31
+#define CLK_TWSI0		32
+#define CLK_TWSI1		33
+#define CLK_TWSI2		34
+#define CLK_TWSI4		35
+#define CLK_TWSI5		36
+#define CLK_TWSI6		37
+#define CLK_TWSI7		38
+#define CLK_TWSI8		39
+#define CLK_TIMERS1		40
+#define CLK_TIMERS2		41
+#define CLK_AIB			42
+#define CLK_ONEWIRE		43
+#define CLK_SSPA0		44
+#define CLK_SSPA1		45
+#define CLK_DRO			46
+#define CLK_IR			47
+#define CLK_TSEN		48
+#define CLK_IPC_AP2AUD		49
+#define CLK_CAN0		50
+#define CLK_CAN0_BUS		51
+#define CLK_UART0_BUS		52
+#define CLK_UART2_BUS		53
+#define CLK_UART3_BUS		54
+#define CLK_UART4_BUS		55
+#define CLK_UART5_BUS		56
+#define CLK_UART6_BUS		57
+#define CLK_UART7_BUS		58
+#define CLK_UART8_BUS		59
+#define CLK_UART9_BUS		60
+#define CLK_GPIO_BUS		61
+#define CLK_PWM0_BUS		62
+#define CLK_PWM1_BUS		63
+#define CLK_PWM2_BUS		64
+#define CLK_PWM3_BUS		65
+#define CLK_PWM4_BUS		66
+#define CLK_PWM5_BUS		67
+#define CLK_PWM6_BUS		68
+#define CLK_PWM7_BUS		69
+#define CLK_PWM8_BUS		70
+#define CLK_PWM9_BUS		71
+#define CLK_PWM10_BUS		72
+#define CLK_PWM11_BUS		73
+#define CLK_PWM12_BUS		74
+#define CLK_PWM13_BUS		75
+#define CLK_PWM14_BUS		76
+#define CLK_PWM15_BUS		77
+#define CLK_PWM16_BUS		78
+#define CLK_PWM17_BUS		79
+#define CLK_PWM18_BUS		80
+#define CLK_PWM19_BUS		81
+#define CLK_SSP3_BUS		82
+#define CLK_RTC_BUS		83
+#define CLK_TWSI0_BUS		84
+#define CLK_TWSI1_BUS		85
+#define CLK_TWSI2_BUS		86
+#define CLK_TWSI4_BUS		87
+#define CLK_TWSI5_BUS		88
+#define CLK_TWSI6_BUS		89
+#define CLK_TWSI7_BUS		90
+#define CLK_TWSI8_BUS		91
+#define CLK_TIMERS1_BUS		92
+#define CLK_TIMERS2_BUS		93
+#define CLK_AIB_BUS		94
+#define CLK_ONEWIRE_BUS		95
+#define CLK_SSPA0_BUS		96
+#define CLK_SSPA1_BUS		97
+#define CLK_TSEN_BUS		98
+#define CLK_IPC_AP2AUD_BUS	99
+
+/*	APMU clocks	*/
+#define CLK_CCI550		0
+#define CLK_CPU_C0_HI		1
+#define CLK_CPU_C0_CORE		2
+#define CLK_CPU_C0_ACE		3
+#define CLK_CPU_C0_TCM		4
+#define CLK_CPU_C1_HI		5
+#define CLK_CPU_C1_CORE		6
+#define CLK_CPU_C1_ACE		7
+#define CLK_CCIC_4X		8
+#define CLK_CCIC1PHY		9
+#define CLK_SDH_AXI		10
+#define CLK_SDH0		11
+#define CLK_SDH1		12
+#define CLK_SDH2		13
+#define CLK_USB_P1		14
+#define CLK_USB_AXI		15
+#define CLK_USB30		16
+#define CLK_QSPI		17
+#define CLK_QSPI_BUS		18
+#define CLK_DMA			19
+#define CLK_AES			20
+#define CLK_VPU			21
+#define CLK_GPU			22
+#define CLK_EMMC		23
+#define CLK_EMMC_X		24
+#define CLK_AUDIO		25
+#define CLK_HDMI		26
+#define CLK_PMUA_ACLK		27
+#define CLK_PCIE0_MASTER	28
+#define CLK_PCIE0_SLAVE		29
+#define CLK_PCIE0_DBI		30
+#define CLK_PCIE1_MASTER	31
+#define CLK_PCIE1_SLAVE		32
+#define CLK_PCIE1_DBI		33
+#define CLK_PCIE2_MASTER	34
+#define CLK_PCIE2_SLAVE		35
+#define CLK_PCIE2_DBI		36
+#define CLK_EMAC0_BUS		37
+#define CLK_EMAC0_PTP		38
+#define CLK_EMAC1_BUS		39
+#define CLK_EMAC1_PTP		40
+#define CLK_JPG			41
+#define CLK_CCIC2PHY		42
+#define CLK_CCIC3PHY		43
+#define CLK_CSI			44
+#define CLK_CAMM0		45
+#define CLK_CAMM1		46
+#define CLK_CAMM2		47
+#define CLK_ISP_CPP		48
+#define CLK_ISP_BUS		49
+#define CLK_ISP			50
+#define CLK_DPU_MCLK		51
+#define CLK_DPU_ESC		52
+#define CLK_DPU_BIT		53
+#define CLK_DPU_PXCLK		54
+#define CLK_DPU_HCLK		55
+#define CLK_DPU_SPI		56
+#define CLK_DPU_SPI_HBUS	57
+#define CLK_DPU_SPIBUS		58
+#define CLK_DPU_SPI_ACLK	59
+#define CLK_V2D			60
+#define CLK_EMMC_BUS		61
+
+#endif /* _DT_BINDINGS_SPACEMIT_CCU_H_ */
-- 
2.48.1


