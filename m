Return-Path: <linux-kernel+bounces-284260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D5494FF0A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DFDB1C2096C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DA413A40D;
	Tue, 13 Aug 2024 07:43:48 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467C812D214;
	Tue, 13 Aug 2024 07:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723535027; cv=none; b=r0M0SBUn2t4aAEki7r/67zCm7DIHKKiLLhZ68NQ0MHCxOh7LoCmEnMOgHk4KFRws5wQ1kTGczDeVnZZk8RLgxGuSwXMoJOHPNNrx6CwSsK6X1fu0gLww6MSD4LGEC6ofSava5A94DAvOVCnSU99+l7/y+SgwKed6NBQ9VYeEJ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723535027; c=relaxed/simple;
	bh=CVBx+W6TLdjMUGMg9fR/4/zxYtvSPg0a973K0nBxzXg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bJSI139M/UV1C2WGG7mv/N5ffONeS3YRQgy2/sn6RBuQcCxoCQiA5ETAG5jI5Z5RAQn28c9nzTEtYPHfFslljBdnnyGtT5jtc70wRYwVR+7SIfOTvD7KDex7DT+bD9MTqz6gmZMqlVhfi5UgIxFjZIutyKnN6R69n0DZrHt9luo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 13 Aug
 2024 15:43:40 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 13 Aug 2024 15:43:40 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <tglx@linutronix.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<kevin_chen@aspeedtech.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>
Subject: [PATCH v1 1/2] dt-bindings: interrupt-controller: Add support for ASPEED AST27XX INTC
Date: Tue, 13 Aug 2024 15:43:37 +0800
Message-ID: <20240813074338.969883-2-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240813074338.969883-1-kevin_chen@aspeedtech.com>
References: <20240813074338.969883-1-kevin_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The ASPEED AST27XX interrupt controller(INTC) combines 32 interrupt
sources into 1 interrupt into GIC from CPU die to CPU die.
The INTC design contains soc0_intc and soc1_intc module doing hand shake
between CPU die and IO die INTC.

In soc0_intc11, each bit represent 1 GIC_SPI interrupt from soc1_intcX.
In soc1_intcX, each bit represent 1 device interrupt in IO die.

By soc1_intcX in IO die, AST27XX INTC combines 32 interrupt sources to
1 interrupt source in soc0_intc11 in CPU die, which achieve the
interrupt passing between the different die in AST27XX.
---
 .../aspeed,ast2700-intc.yaml                  | 120 ++++++++++++++++++
 1 file changed, 120 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
new file mode 100644
index 000000000000..93d7141bf9f9
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
@@ -0,0 +1,120 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed Interrupt Controller driver
+
+description:
+  These bindings are for the Aspeed interrupt controller. The AST2700
+  SoC families include a legacy register layout before a re-designed
+  layout, but the bindings do not prescribe the use of one or the other.
+
+maintainers:
+  - Kevin Chen <kevin_chen@aspeedtech.com>
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+        - enum:
+          - aspeed,ast2700-intc-ic
+          - aspeed,ast2700-intc-icv2
+        description: |
+          Use "aspeed,ast2700-intc-ic" for soc1 INTC in IO die
+          Use "aspeed,ast2700-intc-icv2" for soc0 INTC in CPU die
+
+  interrupt-controller: true
+
+  interrupts-extended:
+    minItems: 1
+    maxItems: 3
+    description:
+      Specifies which contexts are connected to the INTC, with "-1" specifying
+      that a context is not present. Each node pointed to should be a
+      aspeed,ast2700-intc-ic or aspeed,ast2700-intc-icv2 nodes which are pointed
+      to gic node.
+
+  "#address-cells":
+    const: 2
+  "#size-cells":
+    const: 2
+
+  '#interrupt-cells':
+    const: 2
+    description: |
+      The first cell cell is the interrupt source IRQ number, and the second cell
+      is the trigger type as defined in interrupt.txt in this directory.
+
+  reg:
+    minItems: 1
+    maxItems: 2
+    description: |
+      The first cell cell is the interrupt enable register, and the second cell
+      is the status register.
+
+  ranges: true
+
+  interrupts:
+    minItems: 1
+    maxItems: 10
+    description: |
+      Interrupt source of the CPU interrupts. In soc0_intc in CPU die INTC each bit
+      represent soc1_intc interrupt source. soc0_intc take care 10 interrupt source
+      from soc1_intc0~5 and ltpi0/1_soc1_intc0/1.
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - '#interrupt-cells'
+
+additionalProperties: false
+
+example:
+  - |
+    soc0_intc: interrupt-controller@12100000 {
+      compatible = "simple-mfd";
+      reg = <0 0x12100000 0 0x4000>;
+      #address-cells = <2>;
+      #size-cells = <2>;
+      ranges = <0x0 0x0 0x0 0x12100000 0x0 0x4000>;
+
+      soc0_intc11: interrupt-controller@1b00 {
+        compatible = "aspeed,ast2700-intc-icv2";
+        interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
+        #interrupt-cells = <2>;
+        interrupt-controller;
+        reg = <0x0 0x1b00 0x0 0x10>;
+      };
+    };
+
+  - |
+    soc1_intc: interrupt-controller@14c18000 {
+      compatible = "simple-mfd";
+      reg = <0 0x14c18000 0 0x400>;
+      #address-cells = <2>;
+      #size-cells = <2>;
+      ranges = <0x0 0x0 0x0 0x14c18000 0x0 0x400>;
+
+      soc1_intc0: interrupt-controller@100 {
+       compatible = "aspeed,ast2700-intc-ic";
+        interrupts-extended = <&soc0_intc11 0 IRQ_TYPE_LEVEL_HIGH>;
+        #interrupt-cells = <2>;
+        interrupt-controller;
+        reg = <0x0 0x100 0x0 0x10>;
+      };
+    };
-- 
2.34.1


