Return-Path: <linux-kernel+bounces-403422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E42A39C357F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 01:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04BBD1C2178E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 00:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE39F9FE;
	Mon, 11 Nov 2024 00:47:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313FD137930;
	Mon, 11 Nov 2024 00:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731286065; cv=none; b=C9yiDf6CeQH++6XtdaJZ7AZA/4E9T8ON0LDlKU3GpKNdx6TyOCZZtqEZ5w5JVi602aYf/0KbLu2VsHDAKcqbqdfrWtNgWQBLHxtQgMavPYOXx6UZPOio37x+1JLaUfNbot5p7rgmdPXjm1uHQqgRkJ+Ux/Nn7LlB+tGpOeEpwuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731286065; c=relaxed/simple;
	bh=EN6jiVQR7bKb3A/8zF1CoXsGMuq/UW5yGgrprlmnyfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2eh4TeB21H+5/PhatCP3pRO+6sNmMTFPd7JkbCpIPcwQyeHL5CLJyAQ4VkfbOV0pL37Uz9zNcvd4FDE3a+fc53qRdRiG3Ez4Diwr1WGpT9L4msP4NYhZMEPMyfBBkE5MiqQZpKhduaNc8JFnSjmiB53dWrHInkI/gXDewUnv8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD5211480;
	Sun, 10 Nov 2024 16:48:13 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D46823F66E;
	Sun, 10 Nov 2024 16:47:41 -0800 (PST)
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
	Icenowy Zheng <uwu@icenowy.me>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] dt-bindings: clk: sunxi-ng: add compatible for the A523 PRCM-CCU
Date: Mon, 11 Nov 2024 00:47:20 +0000
Message-ID: <20241111004722.10130-6-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241111004722.10130-1-andre.przywara@arm.com>
References: <20241111004722.10130-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Allwinner A523/T527 SoCs have four CCUs, this adds the binding for
the PRCM R_CCU.

Add the new compatible string, along with the required input clock
lists. There is now an extra input clock (PLL_AUDIO), so add this to the
list of allowed clocks and required it for the A523 PRCM CCU.
Also add the DT binding headers, listing all the clocks with their ID
numbers.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../clock/allwinner,sun4i-a10-ccu.yaml        | 76 ++++++++++++-------
 include/dt-bindings/clock/sun55i-a523-r-ccu.h | 36 +++++++++
 include/dt-bindings/reset/sun55i-a523-r-ccu.h | 25 ++++++
 3 files changed, 109 insertions(+), 28 deletions(-)
 create mode 100644 include/dt-bindings/clock/sun55i-a523-r-ccu.h
 create mode 100644 include/dt-bindings/reset/sun55i-a523-r-ccu.h

diff --git a/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml b/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
index 451a18de1b6c1..791dc333be74d 100644
--- a/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
+++ b/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
@@ -46,6 +46,7 @@ properties:
       - allwinner,sun50i-h616-ccu
       - allwinner,sun50i-h616-r-ccu
       - allwinner,sun55i-a523-ccu
+      - allwinner,sun55i-a523-r-ccu
       - allwinner,suniv-f1c100s-ccu
       - nextthing,gr8-ccu
 
@@ -59,6 +60,7 @@ properties:
       - description: Low Frequency Oscillator (usually at 32kHz)
       - description: Internal Oscillator
       - description: Peripherals PLL
+      - description: Audio PLL
 
   clock-names:
     minItems: 2
@@ -67,6 +69,7 @@ properties:
       - const: losc
       - const: iosc
       - const: pll-periph
+      - const: pll-audio
 
 required:
   - "#clock-cells"
@@ -80,54 +83,71 @@ if:
   properties:
     compatible:
       enum:
-        - allwinner,sun8i-a83t-r-ccu
-        - allwinner,sun8i-h3-r-ccu
-        - allwinner,sun20i-d1-r-ccu
-        - allwinner,sun50i-a64-r-ccu
-        - allwinner,sun50i-a100-r-ccu
-        - allwinner,sun50i-h6-r-ccu
-        - allwinner,sun50i-h616-r-ccu
+        - allwinner,sun55i-a523-r-ccu
 
 then:
   properties:
     clocks:
-      minItems: 4
-      maxItems: 4
+      minItems: 5
+      maxItems: 5
 
     clock-names:
-      minItems: 4
-      maxItems: 4
+      minItems: 5
+      maxItems: 5
 
 else:
   if:
     properties:
       compatible:
         enum:
-          - allwinner,sun20i-d1-ccu
-          - allwinner,sun50i-a100-ccu
-          - allwinner,sun50i-h6-ccu
-          - allwinner,sun50i-h616-ccu
-          - allwinner,sun55i-a523-ccu
+          - allwinner,sun8i-a83t-r-ccu
+          - allwinner,sun8i-h3-r-ccu
+          - allwinner,sun20i-d1-r-ccu
+          - allwinner,sun50i-a64-r-ccu
+          - allwinner,sun50i-a100-r-ccu
+          - allwinner,sun50i-h6-r-ccu
+          - allwinner,sun50i-h616-r-ccu
 
   then:
     properties:
       clocks:
-        minItems: 3
-        maxItems: 3
+        minItems: 4
+        maxItems: 4
 
       clock-names:
-        minItems: 3
-        maxItems: 3
+        minItems: 4
+        maxItems: 4
 
   else:
-    properties:
-      clocks:
-        minItems: 2
-        maxItems: 2
-
-      clock-names:
-        minItems: 2
-        maxItems: 2
+    if:
+      properties:
+        compatible:
+          enum:
+            - allwinner,sun20i-d1-ccu
+            - allwinner,sun50i-a100-ccu
+            - allwinner,sun50i-h6-ccu
+            - allwinner,sun50i-h616-ccu
+            - allwinner,sun55i-a523-ccu
+
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 3
+
+        clock-names:
+          minItems: 3
+          maxItems: 3
+
+    else:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+
+        clock-names:
+          minItems: 2
+          maxItems: 2
 
 additionalProperties: false
 
diff --git a/include/dt-bindings/clock/sun55i-a523-r-ccu.h b/include/dt-bindings/clock/sun55i-a523-r-ccu.h
new file mode 100644
index 0000000000000..b738054f1576b
--- /dev/null
+++ b/include/dt-bindings/clock/sun55i-a523-r-ccu.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (C) 2024 Arm Ltd.
+ */
+
+#ifndef _DT_BINDINGS_CLK_SUN55I_A523_R_CCU_H_
+#define _DT_BINDINGS_CLK_SUN55I_A523_R_CCU_H_
+
+#define CLK_R_AHB		0
+#define CLK_R_APB0		1
+#define CLK_R_APB1		2
+#define CLK_R_TIMER0		3
+#define CLK_R_TIMER1		4
+#define CLK_R_TIMER2		5
+#define CLK_BUS_R_TIMER		6
+#define CLK_BUS_R_TWD		7
+#define CLK_R_PWMCTRL		8
+#define CLK_BUS_R_PWMCTRL	9
+#define CLK_BUS_R_SPI		10
+#define CLK_BUS_R_SPINLOCK	11
+#define CLK_BUS_R_MSGBOX	12
+#define CLK_BUS_R_UART0		13
+#define CLK_BUS_R_UART1		14
+#define CLK_BUS_R_I2C0		15
+#define CLK_BUS_R_I2C1		16
+#define CLK_BUS_R_I2C2		17
+#define CLK_BUS_R_PPU0		18
+#define CLK_BUS_R_PPU1		19
+#define CLK_BUS_R_CPU_BIST	20
+#define CLK_R_IR_RX		21
+#define CLK_BUS_R_IR_RX		22
+#define CLK_BUS_R_DMA		23
+#define CLK_BUS_R_RTC		24
+#define CLK_BUS_R_CPUCFG	25
+
+#endif /* _DT_BINDINGS_CLK_SUN55I_A523_R_CCU_H_ */
diff --git a/include/dt-bindings/reset/sun55i-a523-r-ccu.h b/include/dt-bindings/reset/sun55i-a523-r-ccu.h
new file mode 100644
index 0000000000000..dd6fbb372e190
--- /dev/null
+++ b/include/dt-bindings/reset/sun55i-a523-r-ccu.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (C) 2024 Arm Ltd.
+ */
+
+#ifndef _DT_BINDINGS_RST_SUN55I_A523_R_CCU_H_
+#define _DT_BINDINGS_RST_SUN55I_A523_R_CCU_H_
+
+#define RST_BUS_R_TIMER		0
+#define RST_BUS_R_TWD		1
+#define RST_BUS_R_PWMCTRL	2
+#define RST_BUS_R_SPI		3
+#define RST_BUS_R_SPINLOCK	4
+#define RST_BUS_R_MSGBOX	5
+#define RST_BUS_R_UART0		6
+#define RST_BUS_R_UART1		7
+#define RST_BUS_R_I2C0		8
+#define RST_BUS_R_I2C1		9
+#define RST_BUS_R_I2C2		10
+#define RST_BUS_R_PPU1		11
+#define RST_BUS_R_IR_RX		12
+#define RST_BUS_R_RTC		13
+#define RST_BUS_R_CPUCFG	14
+
+#endif /* _DT_BINDINGS_RST_SUN55I_A523_R_CCU_H_ */
-- 
2.46.2


