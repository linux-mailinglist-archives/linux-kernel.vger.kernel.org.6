Return-Path: <linux-kernel+bounces-324706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE8E974FF2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 001D71C20F99
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EA3186E29;
	Wed, 11 Sep 2024 10:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="v8IXRzs3"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8F9183CDC;
	Wed, 11 Sep 2024 10:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726051306; cv=none; b=gS3y8aajKR3hpNJC1OG4QG1pPJTbeLa6npIyYApu34jugSAk+0Gg/TfNYG8LkvfNpEscfoqVKnO+H6n0nD8gXLUzc44lGGFu98eEs6JN1A3zdBdag86vw0++stoJWUoWsFBjrs9VQrMGnb08STFoqQObeR7xLegWNUoj0RyGKY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726051306; c=relaxed/simple;
	bh=X4RNJ1pzOn8EvMABuKVJGxX1rq8RKgWui7K/V4VRJVQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XD14cYrekVn+2DhOamaq7GYK9+RfrPBbSZ72yx0pPNJSULMhYZXQtQMwflcw+ID2d50TSf/GFiFMeogwtfWil2OSs+eNoMMA/GbiuWPRKlVmkKHUvAEsJyOtvwpspb1TH++wNp066llvp2al3xQuJdYn+qt01uIOltu5yvaCRBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=v8IXRzs3; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48B7l14C010650;
	Wed, 11 Sep 2024 12:41:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	q+QeicHCp2ZWykwX9Szi74CPZHnZAUYBRGjXyMFb5hk=; b=v8IXRzs3aiXHBdwx
	1+MUkvaAX/5QBGdmgTIXh8MtOfNx+fe1RQCfZ3agLmfWnb5C24oy+Tyh/fmgmoBF
	DTGxkwdUUhQlQFg0jNU8HfPXvva/tAZpKjFRjNE3hs74rh/tf3OGMXJl6YzRWF8z
	uz2KRf6AckcMR++mVObT7ZGj89er6tUYhYwK8HuqITuvwlo9VKmIOL6B18wnGJRS
	dJyazBSDydtufxDHxLaRZm8T19OuODZ782Cwi1Jt3xY7/XyhyXCkdBfmRVIvZwDE
	4u+bgY3Ze1JA3m4N9f+f+6sIFifg4OaOjnTZ6ownVgJSj1Di4v9p46wx9cN4QDWT
	30lwJg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 41gyaae81n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 12:41:26 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6099E400BB;
	Wed, 11 Sep 2024 12:40:16 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9665D265092;
	Wed, 11 Sep 2024 12:37:38 +0200 (CEST)
Received: from localhost (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 11 Sep
 2024 12:37:38 +0200
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
Subject: [PATCH v7 1/5] dt-bindings: phy: Add STM32MP25 COMBOPHY bindings
Date: Wed, 11 Sep 2024 12:37:25 +0200
Message-ID: <20240911103729.2980431-2-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911103729.2980431-1-christian.bruel@foss.st.com>
References: <20240911103729.2980431-1-christian.bruel@foss.st.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Document the bindings for STM32 COMBOPHY interface, used to support
the PCIe and USB3 stm32mp25 drivers.
Following entries can be used to tune caracterisation parameters
 - st,output-micro-ohms and st,output-vswing-microvolt bindings entries
to tune the impedance and voltage swing using discrete simulation results
 - st,rx-equalizer register to set the internal rx equalizer filter value.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 .../bindings/phy/st,stm32mp25-combophy.yaml   | 119 ++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/st,stm32mp25-combophy.yaml

diff --git a/Documentation/devicetree/bindings/phy/st,stm32mp25-combophy.yaml b/Documentation/devicetree/bindings/phy/st,stm32mp25-combophy.yaml
new file mode 100644
index 000000000000..a2e82c0bb56b
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/st,stm32mp25-combophy.yaml
@@ -0,0 +1,119 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/st,stm32mp25-combophy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STM32MP25 USB3/PCIe COMBOPHY
+
+maintainers:
+  - Christian Bruel <christian.bruel@foss.st.com>
+
+description:
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
+  "#phy-cells":
+    const: 1
+
+  clocks:
+    minItems: 2
+    items:
+      - description: apb Bus clock mandatory to access registers.
+      - description: ker Internal RCC reference clock for USB3 or PCIe
+      - description: pad Optional on board clock input for PCIe only. Typically an
+                     external 100Mhz oscillator wired on dedicated CLKIN pad. Used as reference
+                     clock input instead of the ker
+
+  clock-names:
+    minItems: 2
+    items:
+      - const: apb
+      - const: ker
+      - const: pad
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: phy
+
+  power-domains:
+    maxItems: 1
+
+  wakeup-source: true
+
+  interrupts:
+    maxItems: 1
+    description: interrupt used for wakeup
+
+  access-controllers:
+    maxItems: 1
+    description: Phandle to the rifsc device to check access right.
+
+  st,ssc-on:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      A property whose presence indicates that the Spread Spectrum Clocking is active.
+
+  st,rx-equalizer:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 7
+    default: 2
+    description:
+      A 3 bit value to tune the RX fixed equalizer setting for optimal eye compliance
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
+required:
+  - compatible
+  - reg
+  - "#phy-cells"
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/st,stm32mp25-rcc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/reset/st,stm32mp25-rcc.h>
+
+    phy@480c0000 {
+        compatible = "st,stm32mp25-combophy";
+        reg = <0x480c0000 0x1000>;
+        #phy-cells = <1>;
+        clocks = <&rcc CK_BUS_USB3PCIEPHY>, <&rcc CK_KER_USB3PCIEPHY>;
+        clock-names = "apb", "ker";
+        resets = <&rcc USB3PCIEPHY_R>;
+        reset-names = "phy";
+        access-controllers = <&rifsc 67>;
+        power-domains = <&CLUSTER_PD>;
+        wakeup-source;
+        interrupts-extended = <&exti1 45 IRQ_TYPE_EDGE_FALLING>;
+    };
-- 
2.34.1


