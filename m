Return-Path: <linux-kernel+bounces-232131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B1591A3E7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3816F285391
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681D714D28B;
	Thu, 27 Jun 2024 10:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a6HYjf/2"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3CF149DE1
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 10:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719484372; cv=none; b=ThD2sIxNeR+p5+oafrqubSiJVvES63d9Vh8jtTNzPnRSltFP4Y8gPW1mjRsXtOOfS4FBUWGrOZR00uGURFaJrMz4anwCFjcFnlstZveM5IxmbTJrMzRCyvjDdKRP+MNKHtR93XCTbiE7jNQmE45TAIrJDVnt7UyNJQafSYSH1HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719484372; c=relaxed/simple;
	bh=UL3bMBSC7fZLJ+OmlKYjrtZduFHkkJzaAM5VOgAMneA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VuH8v3rg+v6kiz3DYN0v6xwTcMeuUkBi9iwVplyueisoSA/a47pxZORX7nCL+we/kuaMxz8gY1G/AxV1/HhHIHC6FUfj/aLHWeDdDp/GYfuTWD9fkYfFQa8bkFCM6e8E0zQq29lRAkAvtDgiFrEP/hWBOlHexdaGURJxTpDABVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a6HYjf/2; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-366e70d0330so1614777f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 03:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719484368; x=1720089168; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRiVLfyw86NkzbonvH4WCz23BCZLJebDCKU+AP0xtKo=;
        b=a6HYjf/2XU2nLzJdoOt38RoquVi839gxKB/AHj1O0wbwv+gLh4yJ1eV98fU1HUiQCH
         XfylX5LMiTGAw/4EjsUUVdrxvhfcKD8h8nV5joGihdcwx5H/th6u/k1oL/WvlB+Mf6UU
         uc0Rh7lMDHe+OCtDZYE0AdW2fxA3c+OmvNqutwLQX4xpQISPusqkki2rDB7CtaZBbKRW
         A98rB7jdMxmBlRYlq9sWfgKGwNj7Rd/Y/Jkx/dfz3rx2ZHY0IcSmDDiS7Uce2tDzMfC3
         5f4e2mT0fNNvVQJpGkUDn/1NpcWPz46fR8KFuZCYehnoneHGc5VJocGJ54c/PNIrs7DW
         cObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719484368; x=1720089168;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRiVLfyw86NkzbonvH4WCz23BCZLJebDCKU+AP0xtKo=;
        b=OP+ikMdWAUXaJGxgehX72jYdcgEJm15qaF6oNGL4Xz/MvlU3AzyYwTboUKSs3WUERb
         w329IV42vG2jQqkfXfy9t9GakMOhbAYlO5GxTdNChzluzxiDvRG6ofR1X0TAok4B0Srd
         NpHpcIpeftFG72lTE/m2Sg9kvmK3VPgF+qfiBKW77P8j4RBtEo01ha4vP8b3tTs4ZmJs
         hUJoXxXmgcRDaJwQsregEHyhWy9Cxiul5eEwAI8MvICT4TI/KbJ+u4CoKPB9p0Iy/usF
         gOji1B1yCmC/yManmuRLxIx92aH8IozwB9z3EywtCaDH+WnpBhNpGKP38b+S3hb6uYS8
         /MyA==
X-Forwarded-Encrypted: i=1; AJvYcCUDYtSA/eswVvQcBZWmvhPSXoTA3jB3b4rqMF4RWzHHDT6W1uCG3YiVXgleRb5LX8MmbMIb/3s0rSsV4DXK8zSTC/wQm6iOsQ3IUlk+
X-Gm-Message-State: AOJu0YxSCO2kjaitTMFj1UGYGa+FnN/OaSqVEx7CEUg4CU+ocJlAzERm
	D9jqTh3wH6c+yB5xP4JfgT98iGHBXGt12Rc7ZDEjeJH8jkuDsdPFvMFronmw0M0=
X-Google-Smtp-Source: AGHT+IG2lFcWwoWZMveLDhCCCWvJfSVenWOD1F5xlyqkeUd/2YVIsdCwJKvozlxdGDb3OkE3iKTyeA==
X-Received: by 2002:a05:6000:1009:b0:35f:1d40:82fa with SMTP id ffacd0b85a97d-366e949758bmr7805494f8f.18.1719484368232;
        Thu, 27 Jun 2024 03:32:48 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367435852afsm1384352f8f.53.2024.06.27.03.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 03:32:47 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 27 Jun 2024 12:32:22 +0200
Subject: [PATCH v4 6/7] dt-bindings: mfd: syscon: Split and enforce
 documenting MFD children
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-dt-bindings-mfd-syscon-split-v4-6-dc6699a9f3e4@linaro.org>
References: <20240627-dt-bindings-mfd-syscon-split-v4-0-dc6699a9f3e4@linaro.org>
In-Reply-To: <20240627-dt-bindings-mfd-syscon-split-v4-0-dc6699a9f3e4@linaro.org>
To: Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Jacky Huang <ychuang3@nuvoton.com>, 
 Shan-Chun Hung <schung@nuvoton.com>, 
 Khuong Dinh <khuong@os.amperecomputing.com>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chuanhua Lei <lchuanhua@maxlinear.com>, 
 Rahul Tanwar <rtanwar@maxlinear.com>, 
 Lars Povlsen <lars.povlsen@microchip.com>, 
 Steen Hegelund <Steen.Hegelund@microchip.com>, 
 Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
 Nishanth Menon <nm@ti.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15073;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=UL3bMBSC7fZLJ+OmlKYjrtZduFHkkJzaAM5VOgAMneA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmfT+/FfK+ytBzfzBqwCGPx5LWK7VWiiwBXiFOY
 bYk0VRsfc+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZn0/vwAKCRDBN2bmhouD
 18izD/wPHmcjKYkC5WuGoV3U3DqYOD8fDYSSrpAE/KKY+K6QthTefENsL87Ma8kpBed3PA28iQm
 3YbtmrasN3JGChG0fj1cPOh3CkPlgmldOHQ+FZB18EwuZ/BPv+zR8P4rfj3ifjEQJwAwXtCbZJA
 IAC5rkpv7FXSFq8r8adFYbyaoYI8q4m8iAzx/w1jTs2O2bDZG99mG7Wp0oxKLfqRGt9l5Fzj6Bl
 bnoT327RTGQko7pmlSZdEU1p9ooPJTqpmtcfGY8AGHI2FSsCEwBZ9emDP4gwy93BOEQ+lzn+7Er
 n0vieoDkY/8NmgxgyGdaU+VIyh3H4uv456PgiPXecyrjetTjERJXF/zRKquFy1/t8N/E29Xm7xX
 SZRZ+p87je3DeKTRLSjaQBybYhNV0HMpQRc4D5QFYK1+LqK3Lb02IQKDBfNkOnBxwweMC6/M77l
 vYM8lrWcV+TD0q0071LrMDkaYS82xt7G2VcpO4sf9nUi5OaJ9wBnodwrC3RZ27iudfQuVgf3AH+
 GgZO3StsJYKvWAsly9skj2PP6hEzoAEh3GKgqwVybfdUUldujpxIEx4L7wo0dDdzthTuweXEpPY
 GOwmuC+phzU1Kro/Ek7Icm0+OIAFas4BuFeB8jMfWdTJpij88/qfbQ5CL7u5XijZjK5s+wqXTtn
 /EtOaFeS8AoCvVw==
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

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Cc: Maxime Ripard <maxime@cerno.tech>

Depends on:
1. Patch in MFD: https://lore.kernel.org/all/171828959006.2643902.8308227314531523435.b4-ty@kernel.org/
2. Previous patches in the series.
---
 .../devicetree/bindings/mfd/syscon-common.yaml     |  71 +++++
 Documentation/devicetree/bindings/mfd/syscon.yaml  | 297 +++++++++++++--------
 2 files changed, 252 insertions(+), 116 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/syscon-common.yaml b/Documentation/devicetree/bindings/mfd/syscon-common.yaml
new file mode 100644
index 000000000000..451cbad467a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/syscon-common.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/syscon-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: System Controller Registers R/W Common Properties
+
+description:
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
+        const: syscon
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
+    description:
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
index 0f6fd1a41dd8..aa1c2608d326 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/mfd/syscon.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: System Controller Registers R/W
+title: System Controller Devices
 
 description: |
   System controller node represents a register region containing a set
@@ -19,124 +19,198 @@ description: |
 maintainers:
   - Lee Jones <lee@kernel.org>
 
+# Need a select with all compatibles listed for compatibility with older
+# dtschema (<2024.02), so this will not be selected for other schemas having
+# syscon fallback.
 select:
   properties:
     compatible:
       contains:
         enum:
-          - syscon
-
+          - al,alpine-sysfabric-servic
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
+          - ti,am62-opp-efuse-table
+          - ti,am62-usb-phy-ctrl
+          - ti,am625-dss-oldi-io-ctrl
+          - ti,am62p-cpsw-mac-efuse
+          - ti,am654-dss-oldi-io-ctrl
+          - ti,j784s4-pcie-ctrl
+          - ti,keystone-pllctrl
   required:
     - compatible
 
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
-              - ti,am62-opp-efuse-table
-              - ti,am62-usb-phy-ctrl
-              - ti,am625-dss-oldi-io-ctrl
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
+          - ti,am62-opp-efuse-table
+          - ti,am62-usb-phy-ctrl
+          - ti,am625-dss-oldi-io-ctrl
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
 
@@ -145,18 +219,9 @@ required:
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


