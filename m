Return-Path: <linux-kernel+bounces-422436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3173D9D99B2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 15:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58165B26F24
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 14:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4081D5160;
	Tue, 26 Nov 2024 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="QZOv7Zt8";
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="Etyvz7Pg"
Received: from bayard.4d2.org (bayard.4d2.org [5.78.89.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A270A1D5CE3;
	Tue, 26 Nov 2024 14:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.78.89.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732631540; cv=none; b=ppX2/Vk6JC9e/YO8n5TbXg/Ao+78eCYA2WDMCUiADJ662dayrf42zZRZ72dnUH/cfDx5VKHT4yHxrB0+PwNB/Xgk1H/l2ofglPSRNuJODBidKnoSOYU+0ernyG7jvDszba8RjMvwL3mNe4xXflYZPgCy31tT9YQL5HuDTHOD8S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732631540; c=relaxed/simple;
	bh=FASFhvn6iKBVHNpEB38oQPt429dGXSLzhx8bGGoh8bI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bK8rZz34GbHL7+wlnqXmrM+IrWQA815H6j5dsbsYs9fGbLP/WOHCLcjZBnZ9XFQXrv4Gi0kx7YWn3ml/QR638ysFaxGp6K35XkHcsJuYL9ULX1b0KTmTSnLUL9ctWJazVcggyLT+0I5AuhObRWxplnlhusMv48A2Ff6K3GBEY1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org; spf=pass smtp.mailfrom=4d2.org; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=QZOv7Zt8; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=Etyvz7Pg; arc=none smtp.client-ip=5.78.89.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4d2.org
Received: from bayard.4d2.org (bayard.4d2.org [127.0.0.1])
	by bayard.4d2.org (Postfix) with ESMTP id EB3D2122FE1A;
	Tue, 26 Nov 2024 06:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1732631537; bh=FASFhvn6iKBVHNpEB38oQPt429dGXSLzhx8bGGoh8bI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QZOv7Zt8+jGt0lnFDnmNkJewtdjnar1bYeiOruMHk25Ng6mU0DL7cGnhr6nYbsUJY
	 x8//roonlHaK3AViMu/8/z3WXaTcdq5p+EhxOWYfLeDkic+pVPrM2HwpZ5o3U1apa7
	 fhl0CmpN7uPoNCZ3TekAPmmurz1DsTm3prCERPCThbD15k6cI/t4AT8uG7FTKGnWU0
	 auaZD3wnrgL1xdWPkRx/e4Z47kaZpa/IqoxWu72jMUR4m0pYCH9ntPdbIWWdZKkpxi
	 i0Uc+mZv9ZbFleyXH3xCCYHlzR5DpOmRNC1Pqj36h6m+mDncTDFZx8/Lv9Sj8DSP64
	 YozHJQeuq3TFw==
X-Virus-Scanned: amavisd-new at 4d2.org
Authentication-Results: bayard.4d2.org (amavisd-new); dkim=pass (2048-bit key)
 header.d=4d2.org
Received: from bayard.4d2.org ([127.0.0.1])
 by bayard.4d2.org (bayard.4d2.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vDvPZBvdtdcy; Tue, 26 Nov 2024 06:32:14 -0800 (PST)
Received: from localhost.localdomain (unknown [119.39.112.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: heylenay@4d2.org)
	by bayard.4d2.org (Postfix) with ESMTPSA id D7C19122FE1E;
	Tue, 26 Nov 2024 06:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1732631534; bh=FASFhvn6iKBVHNpEB38oQPt429dGXSLzhx8bGGoh8bI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Etyvz7PgM8GzeRmH0mobnN7swae6MXYAcBKcqyEXxt+fsswXm4j9t+peTywJLqc+9
	 A48CoCV5vhinEwV7ahrtRbk6Kq1NCnACTn+0MIgq4H3DayLEQY8c56lCtPsnfNGYCa
	 8p3hS1/d74KkIPhT6yWIaJaKdgxxVWTlCmZMcgOE55BNYpkvXzQvbxOzYEKpG7rfGP
	 LiOvsdjfjeoy4s42zYFmTzgG0is4XZ1H9XQTCj8Op6xwIpip7MezeSyf5Fa8BSk5YZ
	 nZcS/dQvTSuBc5UfycSzag47jsUMh7T/v2QCv4Gwi2aRPvwVpHcZHB+FBmEJcttLSC
	 SAJmPXslKhl8A==
From: Haylen Chu <heylenay@4d2.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Haylen Chu <heylenay@outlook.com>
Cc: linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Inochi Amaoto <inochiama@outlook.com>,
	Chen Wang <unicornxdotw@foxmail.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Haylen Chu <heylenay@4d2.org>
Subject: [PATCH v3 1/3] dt-bindings: clock: spacemit: Add clock controllers of Spacemit K1 SoC
Date: Tue, 26 Nov 2024 14:31:24 +0000
Message-ID: <20241126143125.9980-3-heylenay@4d2.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241126143125.9980-2-heylenay@4d2.org>
References: <20241126143125.9980-2-heylenay@4d2.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add definition for the clock controllers of Spacemit K1 SoC. The clock
tree is managed by several SoC parts thus different compatible strings
are introduced for each.

Signed-off-by: Haylen Chu <heylenay@4d2.org>
---
 .../bindings/clock/spacemit,k1-ccu.yaml       |  57 ++++
 include/dt-bindings/clock/spacemit,k1-ccu.h   | 246 ++++++++++++++++++
 2 files changed, 303 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/spacemit,k1-ccu.yaml
 create mode 100644 include/dt-bindings/clock/spacemit,k1-ccu.h

diff --git a/Documentation/devicetree/bindings/clock/spacemit,k1-ccu.yaml b/Documentation/devicetree/bindings/clock/spacemit,k1-ccu.yaml
new file mode 100644
index 000000000000..9a12ac29c6e2
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/spacemit,k1-ccu.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/spacemit,k1-ccu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Spacemit K1 SoC Clock Controller
+
+maintainers:
+  - Haylen Chu <heylenay@4d2.org>
+
+properties:
+  compatible:
+    enum:
+      - spacemit,k1-ccu-apbs
+      - spacemit,k1-ccu-mpmu
+      - spacemit,k1-ccu-apbc
+      - spacemit,k1-ccu-apmu
+
+  clocks:
+    maxItems: 4
+
+  clock-names:
+    items:
+      - const: osc_32k
+      - const: vctcxo_1m
+      - const: vctcxo_3m
+      - const: vctcxo_24m
+
+  spacemit,mpmu:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the syscon managing "Main PMU (MPMU)" registers. It is used to
+      check PLL lock status.
+
+  "#clock-cells":
+    const: 1
+    description:
+      See <dt-bindings/clock/spacemit,k1-ccu.h> for valid indices.
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - "#clock-cells"
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: spacemit,k1-ccu-apbs
+    then:
+      required:
+        - spacemit,mpmu
+
+additionalProperties: false
diff --git a/include/dt-bindings/clock/spacemit,k1-ccu.h b/include/dt-bindings/clock/spacemit,k1-ccu.h
new file mode 100644
index 000000000000..71760355b304
--- /dev/null
+++ b/include/dt-bindings/clock/spacemit,k1-ccu.h
@@ -0,0 +1,246 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2024 Haylen Chu <heylenay@outlook.com>
+ */
+
+#ifndef _DT_BINDINGS_SPACEMIT_CCU_H_
+#define _DT_BINDINGS_SPACEMIT_CCU_H_
+
+/*	APBS clocks	*/
+#define CLK_PLL1		0
+#define CLK_PLL2		1
+#define CLK_PLL3		2
+#define CLK_PLL1_D2		3
+#define CLK_PLL1_D3		4
+#define CLK_PLL1_D4		5
+#define CLK_PLL1_D5		6
+#define CLK_PLL1_D6		7
+#define CLK_PLL1_D7		8
+#define CLK_PLL1_D8		9
+#define CLK_PLL1_D11		10
+#define CLK_PLL1_D13		11
+#define CLK_PLL1_D23		12
+#define CLK_PLL1_D64		13
+#define CLK_PLL1_D10_AUD	14
+#define CLK_PLL1_D100_AUD	15
+#define CLK_PLL2_D1		16
+#define CLK_PLL2_D2		17
+#define CLK_PLL2_D3		18
+#define CLK_PLL2_D4		19
+#define CLK_PLL2_D5		20
+#define CLK_PLL2_D6		21
+#define CLK_PLL2_D7		22
+#define CLK_PLL2_D8		23
+#define CLK_PLL3_D1		24
+#define CLK_PLL3_D2		25
+#define CLK_PLL3_D3		26
+#define CLK_PLL3_D4		27
+#define CLK_PLL3_D5		28
+#define CLK_PLL3_D6		29
+#define CLK_PLL3_D7		30
+#define CLK_PLL3_D8		31
+#define CLK_PLL3_80		32
+#define CLK_PLL3_40		33
+#define CLK_PLL3_20		34
+#define CLK_APBS_NUM		35
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
+#define CLK_PLL1_351		15
+#define CLK_PLL1_409P6		16
+#define CLK_PLL1_204P8		17
+#define CLK_PLL1_491		18
+#define CLK_PLL1_245P76		19
+#define CLK_PLL1_614		20
+#define CLK_PLL1_47P26		21
+#define CLK_PLL1_31P5		22
+#define CLK_PLL1_819		23
+#define CLK_PLL1_1228		24
+#define CLK_SLOW_UART		25
+#define CLK_SLOW_UART1		26
+#define CLK_SLOW_UART2		27
+#define CLK_WDT			28
+#define CLK_RIPC		29
+#define CLK_I2S_SYSCLK		30
+#define CLK_I2S_BCLK		31
+#define CLK_APB			32
+#define CLK_WDT_BUS		33
+#define CLK_MPMU_NUM		34
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
+#define CLK_APBC_NUM		100
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
+#define CLK_PCIE0		28
+#define CLK_PCIE1		29
+#define CLK_PCIE2		30
+#define CLK_EMAC0_BUS		31
+#define CLK_EMAC0_PTP		32
+#define CLK_EMAC1_BUS		33
+#define CLK_EMAC1_PTP		34
+#define CLK_JPG			35
+#define CLK_CCIC2PHY		36
+#define CLK_CCIC3PHY		37
+#define CLK_CSI			38
+#define CLK_CAMM0		39
+#define CLK_CAMM1		40
+#define CLK_CAMM2		41
+#define CLK_ISP_CPP		42
+#define CLK_ISP_BUS		43
+#define CLK_ISP			44
+#define CLK_DPU_MCLK		45
+#define CLK_DPU_ESC		46
+#define CLK_DPU_BIT		47
+#define CLK_DPU_PXCLK		48
+#define CLK_DPU_HCLK		49
+#define CLK_DPU_SPI		50
+#define CLK_DPU_SPI_HBUS	51
+#define CLK_DPU_SPIBUS		52
+#define CLK_DPU_SPI_ACLK	53
+#define CLK_V2D			54
+#define CLK_EMMC_BUS		55
+#define CLK_APMU_NUM		56
+
+#endif /* _DT_BINDINGS_SPACEMIT_CCU_H_ */
-- 
2.47.0


