Return-Path: <linux-kernel+bounces-225375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BC0912FD2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 23:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E2A1F2518B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 21:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0C117CA01;
	Fri, 21 Jun 2024 21:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qc7V6RRb"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B2D17C227;
	Fri, 21 Jun 2024 21:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719007105; cv=none; b=UXMuuHeju+GdvIpHj5XmWXWOvtb3Re6JhRHQwm9iDjJ7a7K/AE6o1414xwcDQ+YAd9xwRdQ/4Ip/xcZ6ux7QEHSQCFZFWnxHIqc5ZnadS/xx45n/EI7K/8pphMmkVXDatwuqHX1FJDHt8YwFVmd3iRx/7Y9vyyJkHL1S7tw1j6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719007105; c=relaxed/simple;
	bh=jJMfsYsOQVE4hTuF5CJexDy5HfdTuewYLf5VbN37QiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DfRPAxnJDAA2ozPvnNpU+7o9QFyPHGsmzkTQSK4XEH3KGH3thVLc4WDR1K/yYbsfkbkT5CVxHpmqiP4qM1D0TmzCHihFn4yNDMKTsZYkLNdP1jRPZUKp1/rjtwfU6B8c7tymbrEEhPFy8RBs0tTmcxslIxLrbelNtQuh1WXi49A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qc7V6RRb; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719007096;
	bh=jJMfsYsOQVE4hTuF5CJexDy5HfdTuewYLf5VbN37QiE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qc7V6RRbXlQSIPlRThWM4j5DUcgGLNLO1J6TO5NotKxb6hYmpR1mPWJ9EM9PVJiio
	 2FdZ+rAOsYkleArEVyj1Uu/PK72IqQZDgMuEzFfQwO/x5VZoDLj6yXpjt+YttG5dhN
	 VmTfcqQBYl5tQDJCrIFmz+UeVEbHJzy6mkoCKXaFn5vK22H/u6m3NqNtiv4dirQiw5
	 buw8CSLj8mmAZ3fW1rM8YLlyGMYM3zPKQnEk2PZAJvo7yLqU1Gby0aiKCMbNFOuktC
	 YMkcHeqXH69CANXnKG1IwyE4TW9nV6qSwJrkvGE+yYZKRHzj0W/dNfxOn9Jau20fDZ
	 8qCQA2nl7kHGw==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BA89C37821E2;
	Fri, 21 Jun 2024 21:58:15 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 22 Jun 2024 00:57:19 +0300
Subject: [PATCH v2 2/5] dt-bindings: mfd: rk817: Merge support for RK809
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240622-rk809-fixes-v2-2-c0db420d3639@collabora.com>
References: <20240622-rk809-fixes-v2-0-c0db420d3639@collabora.com>
In-Reply-To: <20240622-rk809-fixes-v2-0-c0db420d3639@collabora.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Chris Zhong <zyw@rock-chips.com>, Zhang Qing <zhangqing@rock-chips.com>, 
 Chris Morgan <macromorgan@hotmail.com>, 
 Furkan Kardame <f.kardame@manjaro.org>, 
 Michael Riesch <michael.riesch@wolfvision.net>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.0

The Rockchip RK809 PMIC is compatible with RK817 and provides the same
capabilities, except for the battery charger manager.

There are also minor regulator related differences: BOOST and OTG_SWITCH
are specific to RK817, while DCDC_REG5, SWITCH_REG1 and SWITCH_REG2 are
provided RK809.

The current binding for RK809 doesn't document the audio codec
properties, although it has been already in use by several boards:
rk3566-quartz64-b, k3566-roc-pc, rk3568-evb1-v10, rk3568-lubancat-2,
rk3568-odroid-m1, rk3568-rock-3a.

Therefore dtbs_check fails for all of them:

  DTC_CHK arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dtb
  rk3568-rock-3a.dtb: pmic@20: '#sound-dai-cells', 'assigned-clock-parents', 'assigned-clocks', 'clock-names', 'clocks', 'codec' do not match any of the regexes: 'pinctrl-[0-9]+'
    from schema $id: http://devicetree.org/schemas/mfd/rockchip,rk809.yaml#

Additionally, the example in rockchip,rk809 binding is not able to
actually test the schema since it uses a wrong compatible
'rockchip,rk808' instead of the expected 'rockchip,rk809'.

Instead of duplicating even more content, merge the RK809 support into
the more inclusive RK817 schema and drop the now obsolete rockchip,rk809
related file.

Fixes: 6c38ca03406e ("dt-bindings: mfd: rk808: Convert bindings to yaml")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 .../devicetree/bindings/mfd/rockchip,rk809.yaml    | 288 ---------------------
 .../devicetree/bindings/mfd/rockchip,rk817.yaml    |  37 ++-
 2 files changed, 27 insertions(+), 298 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
deleted file mode 100644
index 839c0521f1e5..000000000000
--- a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
+++ /dev/null
@@ -1,288 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/mfd/rockchip,rk809.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: RK809 Power Management Integrated Circuit
-
-maintainers:
-  - Chris Zhong <zyw@rock-chips.com>
-  - Zhang Qing <zhangqing@rock-chips.com>
-
-description: |
-  Rockchip RK809 series PMIC. This device consists of an i2c controlled MFD
-  that includes regulators, an RTC, and power button.
-
-properties:
-  compatible:
-    enum:
-      - rockchip,rk809
-
-  reg:
-    maxItems: 1
-
-  interrupts:
-    maxItems: 1
-
-  '#clock-cells':
-    description: |
-      See <dt-bindings/clock/rockchip,rk808.h> for clock IDs.
-    minimum: 0
-    maximum: 1
-
-  clock-output-names:
-    description:
-      From common clock binding to override the default output clock name.
-
-  rockchip,system-power-controller:
-    type: boolean
-    deprecated: true
-    description:
-      Telling whether or not this PMIC is controlling the system power.
-
-  system-power-controller: true
-
-  wakeup-source:
-    type: boolean
-    description:
-      Device can be used as a wakeup source.
-
-  vcc1-supply:
-    description:
-      The input supply for DCDC_REG1.
-
-  vcc2-supply:
-    description:
-      The input supply for DCDC_REG2.
-
-  vcc3-supply:
-    description:
-      The input supply for DCDC_REG3.
-
-  vcc4-supply:
-    description:
-      The input supply for DCDC_REG4.
-
-  vcc5-supply:
-    description:
-      The input supply for LDO_REG1, LDO_REG2, and LDO_REG3.
-
-  vcc6-supply:
-    description:
-      The input supply for LDO_REG4, LDO_REG5, and LDO_REG6.
-
-  vcc7-supply:
-    description:
-      The input supply for LDO_REG7, LDO_REG8, and LDO_REG9.
-
-  vcc8-supply:
-    description:
-      The input supply for SWITCH_REG1.
-
-  vcc9-supply:
-    description:
-      The input supply for DCDC_REG5 and SWITCH_REG2.
-
-  regulators:
-    type: object
-    patternProperties:
-      "^(LDO_REG[1-9]|DCDC_REG[1-5]|SWITCH_REG[1-2])$":
-        type: object
-        $ref: /schemas/regulator/regulator.yaml#
-        unevaluatedProperties: false
-    unevaluatedProperties: false
-
-allOf:
-  - if:
-      properties:
-        '#clock-cells':
-          const: 0
-
-    then:
-      properties:
-        clock-output-names:
-          maxItems: 1
-
-    else:
-      properties:
-        clock-output-names:
-          maxItems: 2
-
-required:
-  - compatible
-  - reg
-  - interrupts
-  - "#clock-cells"
-
-additionalProperties: false
-
-examples:
-  - |
-    #include <dt-bindings/pinctrl/rockchip.h>
-    #include <dt-bindings/interrupt-controller/irq.h>
-    #include <dt-bindings/gpio/gpio.h>
-    i2c {
-        #address-cells = <1>;
-        #size-cells = <0>;
-
-        rk808: pmic@1b {
-            compatible = "rockchip,rk808";
-            reg = <0x1b>;
-            #clock-cells = <1>;
-            clock-output-names = "xin32k", "rk808-clkout2";
-            interrupt-parent = <&gpio3>;
-            interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
-            pinctrl-names = "default";
-            pinctrl-0 = <&pmic_int_l_pin>;
-            rockchip,system-power-controller;
-            wakeup-source;
-
-            vcc1-supply = <&vcc_sysin>;
-            vcc2-supply = <&vcc_sysin>;
-            vcc3-supply = <&vcc_sysin>;
-            vcc4-supply = <&vcc_sysin>;
-            vcc6-supply = <&vcc_sysin>;
-            vcc7-supply = <&vcc_sysin>;
-            vcc8-supply = <&vcc3v3_sys>;
-            vcc9-supply = <&vcc_sysin>;
-            vcc10-supply = <&vcc_sysin>;
-            vcc11-supply = <&vcc_sysin>;
-            vcc12-supply = <&vcc3v3_sys>;
-
-            regulators {
-                vdd_center: DCDC_REG1 {
-                    regulator-name = "vdd_center";
-                    regulator-always-on;
-                    regulator-boot-on;
-                    regulator-min-microvolt = <750000>;
-                    regulator-max-microvolt = <1350000>;
-                    regulator-ramp-delay = <6001>;
-                    regulator-state-mem {
-                        regulator-off-in-suspend;
-                    };
-                };
-
-                vdd_cpu_l: DCDC_REG2 {
-                    regulator-name = "vdd_cpu_l";
-                    regulator-always-on;
-                    regulator-boot-on;
-                    regulator-min-microvolt = <750000>;
-                    regulator-max-microvolt = <1350000>;
-                    regulator-ramp-delay = <6001>;
-                    regulator-state-mem {
-                        regulator-off-in-suspend;
-                    };
-                };
-
-                vcc_ddr: DCDC_REG3 {
-                    regulator-name = "vcc_ddr";
-                    regulator-always-on;
-                    regulator-boot-on;
-                    regulator-state-mem {
-                        regulator-on-in-suspend;
-                    };
-                };
-
-                vcc_1v8: vcc_wl: DCDC_REG4 {
-                    regulator-name = "vcc_1v8";
-                    regulator-always-on;
-                    regulator-boot-on;
-                    regulator-min-microvolt = <1800000>;
-                    regulator-max-microvolt = <1800000>;
-                    regulator-state-mem {
-                        regulator-on-in-suspend;
-                        regulator-suspend-microvolt = <1800000>;
-                    };
-                };
-
-                vcc1v8_pmupll: LDO_REG3 {
-                    regulator-name = "vcc1v8_pmupll";
-                    regulator-always-on;
-                    regulator-boot-on;
-                    regulator-min-microvolt = <1800000>;
-                    regulator-max-microvolt = <1800000>;
-                    regulator-state-mem {
-                        regulator-on-in-suspend;
-                        regulator-suspend-microvolt = <1800000>;
-                    };
-                };
-
-                vcc_sdio: LDO_REG4 {
-                    regulator-name = "vcc_sdio";
-                    regulator-always-on;
-                    regulator-boot-on;
-                    regulator-min-microvolt = <1800000>;
-                    regulator-max-microvolt = <3000000>;
-                    regulator-state-mem {
-                        regulator-on-in-suspend;
-                        regulator-suspend-microvolt = <3000000>;
-                    };
-                };
-
-                vcca3v0_codec: LDO_REG5 {
-                    regulator-name = "vcca3v0_codec";
-                    regulator-always-on;
-                    regulator-boot-on;
-                    regulator-min-microvolt = <3000000>;
-                    regulator-max-microvolt = <3000000>;
-                    regulator-state-mem {
-                        regulator-off-in-suspend;
-                    };
-                };
-
-                vcc_1v5: LDO_REG6 {
-                    regulator-name = "vcc_1v5";
-                    regulator-always-on;
-                    regulator-boot-on;
-                    regulator-min-microvolt = <1500000>;
-                    regulator-max-microvolt = <1500000>;
-                    regulator-state-mem {
-                        regulator-on-in-suspend;
-                        regulator-suspend-microvolt = <1500000>;
-                    };
-                };
-
-                vcca1v8_codec: LDO_REG7 {
-                    regulator-name = "vcca1v8_codec";
-                    regulator-always-on;
-                    regulator-boot-on;
-                    regulator-min-microvolt = <1800000>;
-                    regulator-max-microvolt = <1800000>;
-                    regulator-state-mem {
-                        regulator-off-in-suspend;
-                    };
-                };
-
-                vcc_3v0: LDO_REG8 {
-                    regulator-name = "vcc_3v0";
-                    regulator-always-on;
-                    regulator-boot-on;
-                    regulator-min-microvolt = <3000000>;
-                    regulator-max-microvolt = <3000000>;
-                    regulator-state-mem {
-                        regulator-on-in-suspend;
-                        regulator-suspend-microvolt = <3000000>;
-                    };
-                };
-
-                vcc3v3_s3: SWITCH_REG1 {
-                    regulator-name = "vcc3v3_s3";
-                    regulator-always-on;
-                    regulator-boot-on;
-                    regulator-state-mem {
-                        regulator-off-in-suspend;
-                    };
-                };
-
-                vcc3v3_s0: SWITCH_REG2 {
-                    regulator-name = "vcc3v3_s0";
-                    regulator-always-on;
-                    regulator-boot-on;
-                    regulator-state-mem {
-                        regulator-off-in-suspend;
-                    };
-                };
-            };
-        };
-    };
diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
index d70b4307ac77..2cb6d176a84c 100644
--- a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
+++ b/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
@@ -4,20 +4,21 @@
 $id: http://devicetree.org/schemas/mfd/rockchip,rk817.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: RK817 Power Management Integrated Circuit
+title: RK809/RK817 Power Management Integrated Circuit
 
 maintainers:
   - Chris Zhong <zyw@rock-chips.com>
   - Zhang Qing <zhangqing@rock-chips.com>
 
 description: |
-  Rockchip RK817 series PMIC. This device consists of an i2c controlled MFD
-  that includes regulators, an RTC, a power button, an audio codec, and a
-  battery charger manager.
+  Rockchip RK809/RK817 series PMIC. This device consists of an i2c controlled
+  MFD that includes regulators, an RTC, a power button and an audio codec.
+  The RK817 variant also provides a battery charger manager.
 
 properties:
   compatible:
     enum:
+      - rockchip,rk809
       - rockchip,rk817
 
   reg:
@@ -89,20 +90,20 @@ properties:
 
   vcc8-supply:
     description:
-      The input supply for BOOST.
+      The input supply for BOOST on RK817, or for SWITCH_REG2 on RK809.
 
   vcc9-supply:
     description:
-      The input supply for OTG_SWITCH.
+      The input supply for OTG_SWITCH on RK817,
+      or for DCDC_REG5 and SWITCH_REG1 on RK809.
 
   regulators:
     type: object
     patternProperties:
-      "^(LDO_REG[1-9]|DCDC_REG[1-4]|BOOST|OTG_SWITCH)$":
-        type: object
+      "^(LDO_REG[1-9]|DCDC_REG[1-5]|BOOST|OTG_SWITCH|SWITCH_REG[1-2])$":
+        $ref: /schemas/regulator/regulator.yaml
         unevaluatedProperties: false
-        $ref: /schemas/regulator/regulator.yaml#
-    unevaluatedProperties: false
+    additionalProperties: false
 
   codec:
     type: object
@@ -172,6 +173,22 @@ allOf:
         clock-output-names:
           maxItems: 2
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk817
+    then:
+      properties:
+        regulators:
+          patternProperties:
+            "^(DCDC_REG5|SWITCH_REG[1-2])$": false
+    else:
+      properties:
+        regulators:
+          patternProperties:
+            "^(BOOST|OTG_SWITCH)$": false
+
 required:
   - compatible
   - reg

-- 
2.45.2


