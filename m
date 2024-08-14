Return-Path: <linux-kernel+bounces-286376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4985E951A3B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0019E1F215CD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1351B29B7;
	Wed, 14 Aug 2024 11:41:19 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE021B150F;
	Wed, 14 Aug 2024 11:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635678; cv=none; b=E74DISnn/TweMMpTlb/B+0z/tVhzGFZXytmSracRhV+svQF3G7q2WzpaqqyVv1BISCHD3XaT30rFFIxqCZ9QzjquT4DlHBraRdfSpVz51/S/opjdUz0qB1PffUs6qSVPHiC10uY/ctedxZyPqThPfDv3t3HFcljt+SxLmQ3lghA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635678; c=relaxed/simple;
	bh=plQkBDhUPuz8qOadhsy1ZDkT4es2cfut7LKpTQ1aUe0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N7knfW4LTtB2c5dQzs37ulHaujeURnp8kHueKc/mUkCeFozO4AOyzmNUnC0nSBgr6+eyV6o+/2yh7+EmD3fJHuewyItNKeK9oJ4i7PPHWt5BYVp8Wj5Y8fslq4/17iJVCVJjU84bgZotKafz7886f6xgQjCVcyxYPIIbGG1gTW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 14 Aug
 2024 19:41:08 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 14 Aug 2024 19:41:08 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <tglx@linutronix.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<kevin_chen@aspeedtech.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>
Subject: [PATCH v2 1/2] dt-bindings: interrupt-controller: Add support for ASPEED AST27XX INTC
Date: Wed, 14 Aug 2024 19:41:05 +0800
Message-ID: <20240814114106.2809876-3-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240814114106.2809876-1-kevin_chen@aspeedtech.com>
References: <20240814114106.2809876-1-kevin_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The ASPEED AST27XX interrupt controller(INTC) contain second level and
third level interrupt controller. The third level INTC combines 32 interrupt
sources into 1 interrupt into parent interrupt controller. The second
level INTC doing hand shake with third level INTC.
---
 .../aspeed,ast2700-intc.yaml                  | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
new file mode 100644
index 000000000000..9a76d5c3b66b
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
@@ -0,0 +1,71 @@
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
+    minItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+
+  interrupts:
+    minItems: 1
+    maxItems: 10
+    description:
+      It contains two types of interrupt controller. The first type is multiple
+      interrupt sources into parent interrupt controller. The second type is 
+      1 interrupt source to parent interrupt controller.
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
+          compatible = "aspeed,ast2700-intc-ic";
+          reg = <0 0x12101b00 0 0x10>;
+          #interrupt-cells = <2>;
+          interrupt-controller;
+          interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
+                       <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
+                       <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
+                       <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
+                       <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+                       <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
+                       <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
+                       <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
+                       <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
+                       <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
-- 
2.34.1


