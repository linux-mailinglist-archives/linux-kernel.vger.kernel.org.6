Return-Path: <linux-kernel+bounces-283051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A0494EC5E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D831F22D41
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6D317A5A5;
	Mon, 12 Aug 2024 12:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="7GjosLsL"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE7417276D;
	Mon, 12 Aug 2024 12:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464457; cv=none; b=DYz4A+yG8c078XZPv7RHwuA7RL6pL/AcAFE56V5f4R9/Wl3K6aNIgrBaKtuEHAPqntNXd9D5s6deJjwVEE+cBpq0+3kC0n1qZv2BYtX9I37SiD/dbO1ELxpqnV3TYokK+gf9hRJfO7zKQiwDxfZ86WPa1GqRv7JBAHj1oKvSMwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464457; c=relaxed/simple;
	bh=DrZXoccelXuGM6LzklzTAHpX14RIG0c7mWLHeM+CpsE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vxql8llN/RLhbZJnPMRskdD43AOUSVP5B8Or0EMfKdC+eHTy5GIGwg9vuxo4GLVrpC+ZlfSnqhKlIZ9aOeiIKEeQPt0LppLujUzKEIwfJdC8LdUGlYhj4BUcisU+NW0b3DTMMvBg+o+yvqNoOaompBOKkOOhu7qcrpFhlhlJC2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=7GjosLsL; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47C7ca6J007051;
	Mon, 12 Aug 2024 14:07:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	h5HXIbUSNNhcd6hKVNeBWDZe8/3tsZjbkAvBXFdJUrI=; b=7GjosLsLboXGunkT
	LlSz7gpkmiKVCFBsKL5P4DyKhE/GBp6kDvM0l9ESo4MT8YgHcn1G7torIeA29Lv4
	9VK8CgoLq6jzrD5NWzm0ZctFUuZmLIS7g+7rytmlV3YEGIAyfuWEX9MZcD6CciQ1
	Wprag2z0J4zJdmCrGGyOqtzmgt1meB72bKn7C7trskqvTishgZl1HQ0m+psFERTT
	n5boz7sofm0c9DBOw9u3xL4vtj1sieS/Q1g+BkYZ5C66rNfMIZaQ7WlRSPKB1vc0
	45JrZDdj3RSnBmoc9KaOf7pWF/WY2GWDsxkgEatTOKpgbPmtZRNgLBq1tk89nZsU
	q4le4Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 40xhs0ch87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 14:07:06 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 045CE4002D;
	Mon, 12 Aug 2024 14:07:02 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 512EF25AF06;
	Mon, 12 Aug 2024 14:06:12 +0200 (CEST)
Received: from localhost (10.129.178.198) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 12 Aug
 2024 14:06:12 +0200
From: Christian Bruel <christian.bruel@foss.st.com>
To: <vkoul@kernel.org>, <kishon@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <p.zabel@pengutronix.de>
CC: <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <fabrice.gasnier@foss.st.com>,
        Christian Bruel <christian.bruel@foss.st.com>
Subject: [PATCH 2/5] dt-bindings: phy: Add STM32MP25 COMBOPHY bindings
Date: Mon, 12 Aug 2024 14:05:26 +0200
Message-ID: <20240812120529.3564390-3-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812120529.3564390-1-christian.bruel@foss.st.com>
References: <20240812120529.3564390-1-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_02,2024-08-12_01,2024-05-17_01

Document the bindings for STM32 COMBOPHY interface, used to support
the PCIe and USB3 stm32mp25 drivers.
Following entries can be used to tune caracterisation parameters
 - st,output-micro-ohms and st,output-vswing-microvolt bindings entries
to tune the impedance and voltage swing using discrete simulation results
 - st, phy_rx0_eq register to set the internal rx equalizer filter value.

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 .../bindings/phy/st,stm32-combophy.yaml       | 178 ++++++++++++++++++
 1 file changed, 178 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/st,stm32-combophy.yaml

diff --git a/Documentation/devicetree/bindings/phy/st,stm32-combophy.yaml b/Documentation/devicetree/bindings/phy/st,stm32-combophy.yaml
new file mode 100644
index 0000000000000..6a53ab834b2a7
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/st,stm32-combophy.yaml
@@ -0,0 +1,178 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/st,stm32-combophy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STM32MP25 USB3/PCIe COMBOPHY
+
+maintainers:
+  - Christian Bruel <christian.bruel@foss.st.com>
+
+description: |
+  Single lane PHY shared (exclusive) between the USB3 and PCIe controllers.
+  Supports 5Gbit/s for USB3 and PCIe gen2 or 2.5Gbit/s for PCIe gen1.
+
+properties:
+  compatible:
+    const: st,stm32mp25-combophy
+
+  reg:
+    maxItems: 1
+
+  st,syscfg:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: Phandle to the SYSCON entry required for configuring PCIe
+      or USB3.
+
+  "#phy-cells":
+    const: 1
+    description: |
+      The cells contain the following arguments.
+
+      - description: The PHY type
+          enum:
+            - PHY_TYPE_USB3
+            - PHY_TYPE_PCIE
+
+  clocks:
+    anyOf:
+      - description: apb-clk Bus clock mandatory to access registers.
+      - description: ker-clk Internal RCC reference clock for USB3 or PCIe
+      - description: pad-clk Optional on board clock input for PCIe only. Typically an
+                     external 100Mhz oscillator wired on dedicated CLKIN pad. Used as reference
+                     clock input instead of the ker-clk
+
+  clock-names:
+    oneOf:
+      - items:
+          - const: apb-clk
+          - const: ker-clk
+
+      - items:
+          - const: apb-clk
+          - const: ker-clk
+          - const: pad-clk
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: phy-rst
+
+  power-domains:
+    maxItems: 1
+
+  st,ssc-on:
+    type: boolean
+    description:
+      A boolean property whose presence indicates that the SSC for common clock
+      needs to be set.
+
+  st,rx_equalizer:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 7
+    default: 2
+    description:
+      A 3 bit value describing internal filter settings for the RX equalizer.
+
+  st,output-micro-ohms:
+    minimum: 3999000
+    maximum: 6090000
+    default: 4968000
+    description:
+      A value property to tune the Single Ended Output Impedance, simulations results
+      at 25C for a VDDP=0.8V. The hardware accepts discrete values in this range.
+
+  st,output-vswing-microvolt:
+    minimum: 442000
+    maximum: 803000
+    default: 803000
+    description:
+      A value property in microvolt to tune the Single Ended Output Voltage Swing to change the
+      Vlo, Vhi for a VDDP = 0.8V. The hardware accepts discrete values in this range.
+
+  wakeup-source: true
+
+  interrupts:
+    maxItems: 1
+    description: interrupt used for wakeup
+
+  access-controllers:
+    minItems: 1
+    maxItems: 2
+
+required:
+  - compatible
+  - reg
+  - st,syscfg
+  - '#phy-cells'
+  - resets
+  - reset-names
+  - clocks
+  - clock-names
+
+allOf:
+  - if:
+      required:
+        - wakeup-source
+    then:
+      anyOf:
+        - required: [interrupts]
+        - required: [interrupts-extended]
+
+additionalProperties: false
+
+examples:
+  - |
+    // Example 1: COMBOPHY configured to use internal reference clock
+    #include <dt-bindings/clock/st,stm32mp25-rcc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/reset/st,stm32mp25-rcc.h>
+
+    combophy_internal: phy@480c0000 {
+        compatible = "st,stm32mp25-combophy";
+        reg = <0x480c0000 0x1000>;
+        #phy-cells = <1>;
+        clocks = <&rcc CK_BUS_USB3PCIEPHY>, <&rcc CK_KER_USB3PCIEPHY>;
+        clock-names = "apb-clk", "ker-clk";
+        resets = <&rcc USB3PCIEPHY_R>;
+        reset-names = "phy-rst";
+        st,syscfg = <&syscfg>;
+        access-controllers = <&rifsc 67>;
+        power-domains = <&CLUSTER_PD>;
+        wakeup-source;
+        interrupts-extended = <&exti1 45 IRQ_TYPE_EDGE_FALLING>;
+    };
+
+  - |
+    // Example 2: COMBOPHY configured to use extrenal 100MHz reference clock
+    // on CLKIN pad for PCIe
+    #include <dt-bindings/clock/st,stm32mp25-rcc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/reset/st,stm32mp25-rcc.h>
+
+    clocks {
+        pad_clk: pad-clk {
+            #clock-cells = <0>;
+            compatible = "fixed-clock";
+            clock-frequency = <100000000>;
+        };
+    };
+
+    combophy_pad: phy@480c0000 {
+        compatible = "st,stm32mp25-combophy";
+        reg = <0x480c0000 0x1000>;
+        #phy-cells = <1>;
+        clocks = <&rcc CK_BUS_USB3PCIEPHY>, <&rcc CK_KER_USB3PCIEPHY>, <&pad_clk>;
+        clock-names = "apb-clk", "ker-clk", "pad-clk";
+        resets = <&rcc USB3PCIEPHY_R>;
+        reset-names = "phy-rst";
+        st,syscfg = <&syscfg>;
+        access-controllers = <&rifsc 67>;
+        power-domains = <&CLUSTER_PD>;
+        wakeup-source;
+        interrupts-extended = <&exti1 45 IRQ_TYPE_EDGE_FALLING>;
+    };
+...
-- 
2.34.1


