Return-Path: <linux-kernel+bounces-367115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE8399FEC7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 04:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 602BB286E0D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 02:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE64916D4EF;
	Wed, 16 Oct 2024 02:24:28 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D894D15C145;
	Wed, 16 Oct 2024 02:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729045468; cv=none; b=Ljaep3OHGc4VbR1G1bkJV8vJrb+sHHtqz5ndrVaHX7BTV2dnaPCM+mrqkAEqgmT2GamIuqXcRnpYCUUgz5xApH4BoYHe01dRzdoECllyMM3FjLGAlVtILhSvKnFDW/bymu11w0anhKG7yU0+MTTiMr12fz7l0KTzdqCjnXSLgjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729045468; c=relaxed/simple;
	bh=zrwVXml+JOUbr+OKJIsPp1E1mRIpgRThJpYBYvaKkSA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O5dzB8MAjoBxc3mzs5UmcOx9+GW5ggxqhFNf8RrrSlMN1FfKg/OPh1lmENzh67O/sYlFC3xLXVdUOf920wi/BaNLqVXefuxprszRY/MyP147p7FftBuuAZb5b3hDAIl4Ri0AAKXk9QF6fjQ4E6GDJaUT0hSQSd1AMSjJRnjYV2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 16 Oct
 2024 10:24:14 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 16 Oct 2024 10:24:14 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <tglx@linutronix.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<kevin_chen@aspeedtech.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>
Subject: [PATCH v4 1/2] dt-bindings: interrupt-controller: Add support for ASPEED AST27XX INTC
Date: Wed, 16 Oct 2024 10:24:09 +0800
Message-ID: <20241016022410.1154574-2-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241016022410.1154574-1-kevin_chen@aspeedtech.com>
References: <20241016022410.1154574-1-kevin_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The ASPEED AST27XX interrupt controller(INTC) contains second level and
third level interrupt controller.

INTC0:
The second level INTC, which used to assert GIC if interrupt in INTC1 asserted.

INTC1_x:
The third level INTC, which used to assert INTC0 if interrupt in modules
of INTC asserted.

The relationship is like the following:
  +-----+   +-------+     +---------+---module0
  | GIC |---| INTC0 |--+--| INTC1_0 |---module1
  |     |   |       |  |  |         |---...
  +-----+   +-------+  |  +---------+---module31
                       |
                       |   +---------+---module0
                       +---| INTC1_1 |---module1
                       |   |         |---...
                       |   +---------+---module31
                      ...
                       |   +---------+---module0
                       +---| INTC1_5 |---module1
                           |         |---...
                           +---------+---module31

Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
---
 .../aspeed,ast2700-intc.yaml                  | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
new file mode 100644
index 000000000000..55636d06a674
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed AST2700 Interrupt Controller
+
+description:
+  This interrupt controller hardware is second level interrupt controller that
+  is hooked to a parent interrupt controller. It's useful to combine multiple
+  interrupt sources into 1 interrupt to parent interrupt controller.
+
+maintainers:
+  - Kevin Chen <kevin_chen@aspeedtech.com>
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2700-intc-ic
+
+  reg:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+    description:
+      The first cell is the IRQ number, the second cell is the trigger
+      type as defined in interrupt.txt in this directory.
+
+  interrupts:
+    maxItems: 6
+    description: |
+      Depend to which INTC0 or INTC1 used.
+      INTC0 and INTC1 are two kinds of interrupt controller with enable and raw
+      status registers for use.
+      INTC0 is used to assert GIC if interrupt in INTC1 asserted.
+      INTC1 is used to assert INTC0 if interrupt of modules asserted.
+      +-----+   +-------+     +---------+---module0
+      | GIC |---| INTC0 |--+--| INTC1_0 |---module2
+      |     |   |       |  |  |         |---...
+      +-----+   +-------+  |  +---------+---module31
+                           |
+                           |   +---------+---module0
+                           +---| INTC1_1 |---module2
+                           |   |         |---...
+                           |   +---------+---module31
+                          ...
+                           |   +---------+---module0
+                           +---| INTC1_5 |---module2
+                               |         |---...
+                               +---------+---module31
+
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - '#interrupt-cells'
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        interrupt-controller@12101b00 {
+            compatible = "aspeed,ast2700-intc-ic";
+            reg = <0 0x12101b00 0 0x10>;
+            #interrupt-cells = <2>;
+            interrupt-controller;
+            interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
-- 
2.34.1


