Return-Path: <linux-kernel+bounces-183209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 544AE8C95EA
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 20:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AD77281858
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 18:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F4274BF5;
	Sun, 19 May 2024 18:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ITvAlqXN"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEFB7352F
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 18:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716144168; cv=none; b=O4LTAir5dAzeJ7Y5yhiMB01atqy1i8Ma+V4vcWaNBpUKd4+xtTJRv2gXSPJ5L3CikxV6/3c8cHRN65LriX0JEWBKjNtV9pT5mtcLGbkmIJ/YHNO5Mhq6fJH8IxIAxQgjILDbvXjCUd6eqS2NfDS8wRB1/UahCs4PoG9QlhfkyRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716144168; c=relaxed/simple;
	bh=qtoYw3fdVhclXTClljRbEBWK7+OTsR0mSt+0Br6IjhU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jSi6Edsfg2QEQw2fzMQtv6CYs+U6wfk7ZMEDb68FCF95q93I8L5tlYhuTZXZsiifT97wB9fmCT8dczUx7J3hOL3NP6g0YZgg5kTfrc/5O3pg6FMxSWlM8kMZrf/2797SANYgs6VO/kfuQ2lmssjUpocEr2bZYY9dGfbR4O5dupY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ITvAlqXN; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-571be483ccaso6556099a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 11:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716144165; x=1716748965; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M7SjlJl42p0vv40zj9mQVcZTHeMqcgXlSP/MvwIgG+g=;
        b=ITvAlqXNeJKSYFpZjGnC0DJGykjJNC4MMHaqH4JajCGzEiU4Q7N33GRCE8gPyTRTtf
         21RWgvfYZV0IeYuIl5bi203v0opGUZtcfSY0jfilVH7l+HD7P61jX1B3+8ggLWeWJQJt
         N+UhsxQnbvQhv4pP74lXvqjxiw/YU+pg71gUXlEpWYHf2HkmKRogmzl33v2zY3oJ75IU
         nG6k4GSDLDYPabel4iKMYWPvLbALLcPVKBzlPMwmTn3WTfOKtXxfi29EokfybUkQ0ZJY
         pctl8DURCOZXXmtN1pTEAyUl2C5egN+dvuL45Z4l1+8EcHw6/msWgUAyOmTQKWznD9f6
         QwYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716144165; x=1716748965;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M7SjlJl42p0vv40zj9mQVcZTHeMqcgXlSP/MvwIgG+g=;
        b=ZZYIMOeI9t1eu1GEFv+EMx70WSfaXbt9WWULavEIXe9DQ+KgX9hVO5D8WUT699XgH9
         LPhc2er6S1e5hkcur6yLBKYqsTLcjky+LztTjJ+q6HanNVsIT9IJoQ+WYb+0CNSWmdZN
         jy7D+ppEs5M4HEn6PskkTNGF1kkSzL01qa9J0IdPXRDgPiKg0iEqVVkXjWNWK1VrfcP7
         ERZGKT8ZScpSXsqcPN64v7NBnhWLMjDsn02q5ypu4mjQgoZ0CwaxBMXkOOJScXKZrb7G
         yGCxlu71+Kigwep9IuAZSpmVp6fH2sQAqgf0BVcvy0i4wBVj0xoN61tTxKtaQi9yFRfk
         /wkw==
X-Forwarded-Encrypted: i=1; AJvYcCVkfO0KlOTT3ZJROwm2bq9yI6+JLkjzDGgI6ewoLxtZav8XGB/+X9DaK9kPcULNkjE3nqD/gys3uC6kR03WbT6aVRdcbbCQXuECdlSB
X-Gm-Message-State: AOJu0YyFxfxA7F5az/2p+uy+MlmK0X7oSr9Ach1ILv39gVjKvB0fm4mY
	RdkDi0psSQYL8OMxLuiS/XmLy95gM6mc8tt5ybOIA7Cg8st2UfOwyGtekYZFU3E=
X-Google-Smtp-Source: AGHT+IEsFEpdSqOAM6J5qyzDUCJneEXJ3Ysf7DmgHnwA7qHARRDxO2SQ1UpJZcz+0tw+btI581FdDA==
X-Received: by 2002:a50:c359:0:b0:574:fe5f:4f79 with SMTP id 4fb4d7f45d1cf-574fe5f5348mr6793830a12.24.1716144164805;
        Sun, 19 May 2024 11:42:44 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-575313d97desm1789397a12.41.2024.05.19.11.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 11:42:44 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 19 May 2024 20:42:21 +0200
Subject: [PATCH 6/8] dt-bindings: mfd: syscon: Split and enforce
 documenting MFD children
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240519-dt-bindings-mfd-syscon-split-v1-6-aaf996e2313a@linaro.org>
References: <20240519-dt-bindings-mfd-syscon-split-v1-0-aaf996e2313a@linaro.org>
In-Reply-To: <20240519-dt-bindings-mfd-syscon-split-v1-0-aaf996e2313a@linaro.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lars Povlsen <lars.povlsen@microchip.com>, 
 Steen Hegelund <Steen.Hegelund@microchip.com>, 
 Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
 Nishanth Menon <nm@ti.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11415;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=qtoYw3fdVhclXTClljRbEBWK7+OTsR0mSt+0Br6IjhU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmSkgVnvLOsAJbHLJZCtbySDycWCqH0kFau5Quu
 6kHj0zLHKyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZkpIFQAKCRDBN2bmhouD
 11QlEACYNX//aIKpWxoPYETKQidjY/01vwBwUZEG3iDc/egKhwD2iVfGd0rm6KjUtPJhvdtZAnP
 fYeCYFMi9Lri8n7rvQFpDAm7PLaiGyL0+U0gq5RIj7JYkXwoxVPfFGoXv+MJQZypBBZwJ/qjK0U
 3/YY2b3dJgwNBg3jQQvKxHQJaInhAijErYzdTFydtQomLKu5T4t73Ru/DduOLdSqEv1pofdcdg7
 7ncFXrD7zoxDSC2E0yUvua44Uv4wigxUweERoCJeWvQ8vdLlcIc4d5RroOuCLsX6At7owc5N8xs
 bNI75Le0SoUU4Isqk1mEhEHB+lYuWx8nZEVyyhay3/7xcWDnxlao4ICn8LfDTNrWq0KPEFnRaKB
 N0lLM2rRnkJ5V7XCK9Wzssuv9oKZbirV3M+J95ZplRoXldvrPKmgqvdwnaDMWjzkR3JgiwdCfSE
 bjdiO7w8n8Q6Np9PdQ3DnT7ha/rliYae3kculV9a8FMiOaKc7AgilHdtePkXVPTUXMiayc10wd5
 tYx0OQsKfvNIrtRMXoOyEz6VAxjX0K6VWjr4kauUpfbJrEKTdlmbTsK7irRWNBhUBe23lWr1dPC
 1dY0Sn/+w2ynLy6N54QC1G3Ez5J4hib7NBVB2+c96ynOLH5QvRspEOb80cCgSgTLkzY+xw1Vvpr
 wpkAzYsUZ8Em3Ew==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Simple syscon nodes can be documented in common syscon.yaml, however
devices with simple-mfd compatible, thus with some children, should have
their own schema listing these children.  Such listing makes the binding
specific, allows better validation (so the incorrect child would not
appear in the simple-mfd node) and actually enforces repeated rule for
simple-mfd devices:

  "simple-mfd" is only for simple devices, where the children do not
  depend on the parent.

Currently the syscon+simple-mfd binding is quite broad and allows
any child or property, thus above rule cannot be enforced.

Split the syscon.yaml binding into:
1. Common syscon properties, used potentially by many bindings.
2. Simple syscon devices (NO simple-mfd!).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on:
1. https://lore.kernel.org/r/20240510123018.3902184-1-robh@kernel.org
2. Previous patches in the series.
---
 .../devicetree/bindings/mfd/syscon-common.yaml     |  72 +++++++
 Documentation/devicetree/bindings/mfd/syscon.yaml  | 212 +++++++++------------
 2 files changed, 162 insertions(+), 122 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/syscon-common.yaml b/Documentation/devicetree/bindings/mfd/syscon-common.yaml
new file mode 100644
index 000000000000..c3ff3a7afce3
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/syscon-common.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/syscon-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: System Controller Registers R/W Common Properties
+
+description: |
+  System controller node represents a register region containing a set
+  of miscellaneous registers. The registers are not cohesive enough to
+  represent as any specific type of device. The typical use-case is
+  for some other node's driver, or platform-specific code, to acquire
+  a reference to the syscon node (e.g. by phandle, node path, or
+  search using a specific compatible value), interrogate the node (or
+  associated OS driver) to determine the location of the registers,
+  and access the registers directly.
+
+maintainers:
+  - Lee Jones <lee@kernel.org>
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - syscon
+
+  required:
+    - compatible
+
+properties:
+  compatible:
+    contains:
+      const: syscon
+    minItems: 2
+    maxItems: 5  # Should be enough
+
+  reg:
+    maxItems: 1
+
+  reg-io-width:
+    description: |
+      The size (in bytes) of the IO accesses that should be performed
+      on the device.
+    enum: [1, 2, 4, 8]
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: simple-mfd
+    then:
+      properties:
+        compatible:
+          minItems: 3
+          maxItems: 5
+
+additionalProperties: true
+
+examples:
+  - |
+    syscon: syscon@1c00000 {
+        compatible = "allwinner,sun8i-h3-system-controller", "syscon";
+        reg = <0x01c00000 0x1000>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index b17fa0487178..70e3961bc96f 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/mfd/syscon.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: System Controller Registers R/W
+title: System Controller Devices
 
 description: |
   System controller node represents a register region containing a set
@@ -19,122 +19,99 @@ description: |
 maintainers:
   - Lee Jones <lee@kernel.org>
 
-select:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - syscon
-
-  required:
-    - compatible
-
 properties:
   compatible:
-    anyOf:
-      - items:
-          - enum:
-              - al,alpine-sysfabric-service
-              - allwinner,sun8i-a83t-system-controller
-              - allwinner,sun8i-h3-system-controller
-              - allwinner,sun8i-v3s-system-controller
-              - allwinner,sun50i-a64-system-controller
-              - altr,l3regs
-              - altr,sdr-ctl
-              - amd,pensando-elba-syscon
-              - amlogic,meson-mx-assist
-              - amlogic,meson-mx-bootrom
-              - amlogic,meson8-analog-top
-              - amlogic,meson8b-analog-top
-              - amlogic,meson8-pmu
-              - amlogic,meson8b-pmu
-              - apm,xgene-csw
-              - apm,xgene-efuse
-              - apm,xgene-mcb
-              - apm,xgene-rb
-              - apm,xgene-scu
-              - atmel,sama5d2-sfrbu
-              - atmel,sama5d3-nfc-io
-              - atmel,sama5d3-sfrbu
-              - atmel,sama5d4-sfrbu
-              - axis,artpec6-syscon
-              - brcm,cru-clkset
-              - brcm,sr-cdru
-              - brcm,sr-mhb
-              - cirrus,ep7209-syscon1
-              - cirrus,ep7209-syscon2
-              - cirrus,ep7209-syscon3
-              - cnxt,cx92755-uc
-              - freecom,fsg-cs2-system-controller
-              - fsl,imx93-aonmix-ns-syscfg
-              - fsl,imx93-wakeupmix-syscfg
-              - fsl,ls1088a-reset
-              - fsl,vf610-anatop
-              - fsl,vf610-mscm-cpucfg
-              - hisilicon,dsa-subctrl
-              - hisilicon,hi6220-sramctrl
-              - hisilicon,hip04-ppe
-              - hisilicon,pcie-sas-subctrl
-              - hisilicon,peri-subctrl
-              - hpe,gxp-sysreg
-              - loongson,ls1b-syscon
-              - loongson,ls1c-syscon
-              - lsi,axxia-syscon
-              - marvell,armada-3700-cpu-misc
-              - marvell,armada-3700-nb-pm
-              - marvell,armada-3700-avs
-              - marvell,armada-3700-usb2-host-misc
-              - marvell,dove-global-config
-              - mediatek,mt2701-pctl-a-syscfg
-              - mediatek,mt2712-pctl-a-syscfg
-              - mediatek,mt6397-pctl-pmic-syscfg
-              - mediatek,mt8135-pctl-a-syscfg
-              - mediatek,mt8135-pctl-b-syscfg
-              - mediatek,mt8173-pctl-a-syscfg
-              - mediatek,mt8365-syscfg
-              - microchip,lan966x-cpu-syscon
-              - microchip,sam9x60-sfr
-              - microchip,sama7g5-ddr3phy
-              - mscc,ocelot-cpu-syscon
-              - mstar,msc313-pmsleep
-              - nuvoton,ma35d1-sys
-              - nuvoton,wpcm450-shm
-              - rockchip,px30-qos
-              - rockchip,rk3036-qos
-              - rockchip,rk3066-qos
-              - rockchip,rk3128-qos
-              - rockchip,rk3228-qos
-              - rockchip,rk3288-qos
-              - rockchip,rk3368-qos
-              - rockchip,rk3399-qos
-              - rockchip,rk3568-qos
-              - rockchip,rk3588-qos
-              - rockchip,rv1126-qos
-              - st,spear1340-misc
-              - stericsson,nomadik-pmu
-              - starfive,jh7100-sysmain
-              - ti,am62-usb-phy-ctrl
-              - ti,am62p-cpsw-mac-efuse
-              - ti,am654-dss-oldi-io-ctrl
-              - ti,j784s4-pcie-ctrl
-              - ti,keystone-pllctrl
-
-          - const: syscon
-
-      - contains:
-          const: syscon
-        minItems: 2
-        maxItems: 5  # Should be enough
+    items:
+      - enum:
+          - al,alpine-sysfabric-service
+          - allwinner,sun8i-a83t-system-controller
+          - allwinner,sun8i-h3-system-controller
+          - allwinner,sun8i-v3s-system-controller
+          - allwinner,sun50i-a64-system-controller
+          - altr,l3regs
+          - altr,sdr-ctl
+          - amd,pensando-elba-syscon
+          - amlogic,meson-mx-assist
+          - amlogic,meson-mx-bootrom
+          - amlogic,meson8-analog-top
+          - amlogic,meson8b-analog-top
+          - amlogic,meson8-pmu
+          - amlogic,meson8b-pmu
+          - apm,xgene-csw
+          - apm,xgene-efuse
+          - apm,xgene-mcb
+          - apm,xgene-rb
+          - apm,xgene-scu
+          - atmel,sama5d2-sfrbu
+          - atmel,sama5d3-nfc-io
+          - atmel,sama5d3-sfrbu
+          - atmel,sama5d4-sfrbu
+          - axis,artpec6-syscon
+          - brcm,cru-clkset
+          - brcm,sr-cdru
+          - brcm,sr-mhb
+          - cirrus,ep7209-syscon1
+          - cirrus,ep7209-syscon2
+          - cirrus,ep7209-syscon3
+          - cnxt,cx92755-uc
+          - freecom,fsg-cs2-system-controller
+          - fsl,imx93-aonmix-ns-syscfg
+          - fsl,imx93-wakeupmix-syscfg
+          - fsl,ls1088a-reset
+          - fsl,vf610-anatop
+          - fsl,vf610-mscm-cpucfg
+          - hisilicon,dsa-subctrl
+          - hisilicon,hi6220-sramctrl
+          - hisilicon,hip04-ppe
+          - hisilicon,pcie-sas-subctrl
+          - hisilicon,peri-subctrl
+          - hpe,gxp-sysreg
+          - loongson,ls1b-syscon
+          - loongson,ls1c-syscon
+          - lsi,axxia-syscon
+          - marvell,armada-3700-cpu-misc
+          - marvell,armada-3700-nb-pm
+          - marvell,armada-3700-avs
+          - marvell,armada-3700-usb2-host-misc
+          - marvell,dove-global-config
+          - mediatek,mt2701-pctl-a-syscfg
+          - mediatek,mt2712-pctl-a-syscfg
+          - mediatek,mt6397-pctl-pmic-syscfg
+          - mediatek,mt8135-pctl-a-syscfg
+          - mediatek,mt8135-pctl-b-syscfg
+          - mediatek,mt8173-pctl-a-syscfg
+          - mediatek,mt8365-syscfg
+          - microchip,lan966x-cpu-syscon
+          - microchip,sam9x60-sfr
+          - microchip,sama7g5-ddr3phy
+          - mscc,ocelot-cpu-syscon
+          - mstar,msc313-pmsleep
+          - nuvoton,ma35d1-sys
+          - nuvoton,wpcm450-shm
+          - rockchip,px30-qos
+          - rockchip,rk3036-qos
+          - rockchip,rk3066-qos
+          - rockchip,rk3128-qos
+          - rockchip,rk3228-qos
+          - rockchip,rk3288-qos
+          - rockchip,rk3368-qos
+          - rockchip,rk3399-qos
+          - rockchip,rk3568-qos
+          - rockchip,rk3588-qos
+          - rockchip,rv1126-qos
+          - st,spear1340-misc
+          - stericsson,nomadik-pmu
+          - starfive,jh7100-sysmain
+          - ti,am62-usb-phy-ctrl
+          - ti,am62p-cpsw-mac-efuse
+          - ti,am654-dss-oldi-io-ctrl
+          - ti,j784s4-pcie-ctrl
+          - ti,keystone-pllctrl
+      - const: syscon
 
   reg:
     maxItems: 1
 
-  reg-io-width:
-    description: |
-      The size (in bytes) of the IO accesses that should be performed
-      on the device.
-    enum: [1, 2, 4, 8]
-
   resets:
     maxItems: 1
 
@@ -143,18 +120,9 @@ required:
   - reg
 
 allOf:
-  - if:
-      properties:
-        compatible:
-          contains:
-            const: simple-mfd
-    then:
-      properties:
-        compatible:
-          minItems: 3
-          maxItems: 5
+  - $ref: syscon-common.yaml#
 
-additionalProperties: true
+unevaluatedProperties: false
 
 examples:
   - |

-- 
2.43.0


