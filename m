Return-Path: <linux-kernel+bounces-543043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C52DA4D0DF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0483AE848
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2671ACEDC;
	Tue,  4 Mar 2025 01:30:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9582113AA2F;
	Tue,  4 Mar 2025 01:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741051846; cv=none; b=aR2EL5jIFVv3B1s7Ugrs/Hl+94GrTUhjJv/NMrPY+lPRqeZqLOiAT195rG4DRyz5zIeI41vSKTMEEs9uSTbSY4tPYgWMznnsZqM9gves28R/q20SRXRKRjdLESQVFLu1KYW5GcyGocLuIoO7PHJDTn/M/oViYLTR3tK8QahcIxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741051846; c=relaxed/simple;
	bh=6FRj0IQoQLhrlXw0PbzI3/6i+POXVHewBQ07zrvOUJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nsRKVpxybQXhcyomBdMJCBI0MbB9ltsLCdzF0Nwg73jfjmQ64W5TGVvaUVZyvT5x5XfpJH/U3wf794y4lz9gXj58YrTqH9Ibwqt7RXVNQtow+JQH9PHX/4VCJAsf03Y7CFr3b+10FZSzyHH3B+U5WFMk3DVwcszvCqp1KHf8HM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4274FEC;
	Mon,  3 Mar 2025 17:30:57 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FA8A3F673;
	Mon,  3 Mar 2025 17:30:42 -0800 (PST)
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
Subject: [PATCH v3 05/15] dt-bindings: clk: sunxi-ng: add compatible for the A523 PRCM-CCU
Date: Tue,  4 Mar 2025 01:27:55 +0000
Message-ID: <20250304012805.28594-6-andre.przywara@arm.com>
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
the PRCM R_CCU.

Add the new compatible string, along with the required input clock
lists. There is now an extra input clock (PLL_AUDIO), so add this to the
list of allowed clocks and required it for the A523 PRCM CCU.
Also add the DT binding headers, listing all the clocks with their ID
numbers.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../clock/allwinner,sun55i-a523-ccu.yaml      | 23 +++++++++++-
 include/dt-bindings/clock/sun55i-a523-r-ccu.h | 37 +++++++++++++++++++
 include/dt-bindings/reset/sun55i-a523-r-ccu.h | 25 +++++++++++++
 3 files changed, 83 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/clock/sun55i-a523-r-ccu.h
 create mode 100644 include/dt-bindings/reset/sun55i-a523-r-ccu.h

diff --git a/Documentation/devicetree/bindings/clock/allwinner,sun55i-a523-ccu.yaml b/Documentation/devicetree/bindings/clock/allwinner,sun55i-a523-ccu.yaml
index 2eacaeaeabac7..a64a35b423736 100644
--- a/Documentation/devicetree/bindings/clock/allwinner,sun55i-a523-ccu.yaml
+++ b/Documentation/devicetree/bindings/clock/allwinner,sun55i-a523-ccu.yaml
@@ -19,17 +19,18 @@ properties:
   compatible:
     enum:
       - allwinner,sun55i-a523-ccu
+      - allwinner,sun55i-a523-r-ccu
 
   reg:
     maxItems: 1
 
   clocks:
     minItems: 4
-    maxItems: 4
+    maxItems: 5
 
   clock-names:
     minItems: 4
-    maxItems: 4
+    maxItems: 5
 
 required:
   - "#clock-cells"
@@ -61,6 +62,24 @@ then:
         - const: iosc
         - const: losc-fanout
 
+else:
+  properties:
+    clocks:
+      items:
+        - description: High Frequency Oscillator (usually at 24MHz)
+        - description: Low Frequency Oscillator (usually at 32kHz)
+        - description: Internal Oscillator
+        - description: Peripherals PLL
+        - description: Audio PLL
+
+    clock-names:
+      items:
+        - const: hosc
+        - const: losc
+        - const: iosc
+        - const: pll-periph
+        - const: pll-audio
+
 additionalProperties: false
 
 examples:
diff --git a/include/dt-bindings/clock/sun55i-a523-r-ccu.h b/include/dt-bindings/clock/sun55i-a523-r-ccu.h
new file mode 100644
index 0000000000000..365647499b9ab
--- /dev/null
+++ b/include/dt-bindings/clock/sun55i-a523-r-ccu.h
@@ -0,0 +1,37 @@
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
+#define CLK_R_SPI		10
+#define CLK_BUS_R_SPI		11
+#define CLK_BUS_R_SPINLOCK	12
+#define CLK_BUS_R_MSGBOX	13
+#define CLK_BUS_R_UART0		14
+#define CLK_BUS_R_UART1		15
+#define CLK_BUS_R_I2C0		16
+#define CLK_BUS_R_I2C1		17
+#define CLK_BUS_R_I2C2		18
+#define CLK_BUS_R_PPU0		19
+#define CLK_BUS_R_PPU1		20
+#define CLK_BUS_R_CPU_BIST	21
+#define CLK_R_IR_RX		22
+#define CLK_BUS_R_IR_RX		23
+#define CLK_BUS_R_DMA		24
+#define CLK_BUS_R_RTC		25
+#define CLK_BUS_R_CPUCFG	26
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
2.46.3


