Return-Path: <linux-kernel+bounces-353821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F260993330
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E352CB2596E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFA81DAC8C;
	Mon,  7 Oct 2024 16:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Zovv+n4p"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABCC1D2711;
	Mon,  7 Oct 2024 16:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728318463; cv=none; b=YOPC0+UBFpChXyhvUsSS/hHrBwBbn5Ih9+9TlEVb8rpF3tkQDafyJYQN+EPRaAi/BmHO2Mkl0NIh/aETdP0s62WIoh9QWMskZtwWhWuXfHijzkaaKHCQqaD/tp1tGRds08QfIXnR5X3Nt/YyDFxU/ZrMMvAXSr4m7eXFlxkEepg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728318463; c=relaxed/simple;
	bh=dhIS2qxuYzrKEcHaGnAPlnJJBqZxP20zD84DYVAN73A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=snvwEejUfCVNuQjsunzyPAfucn193CjcOFgsa7ztbM6E9FNLgUuUYvdZr0tnWCYWv5zAwRPy6Fg5++dvUmR4ifqtU2EFdvDKNo5pB14Mk+aW7p9TGdvUeP+BJqw7Yl7Vnyml4GaoXpoFTSlri592R+D4HBptiKkjBYqiZ90SSs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Zovv+n4p; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qy8O/TmsmzDYewUZ3qCB4nBDlcLj83mGmeo1Cj46QWA=; b=Zovv+n4pff8MEXXuktE+AXOoNe
	6lNCbcBspcLrCRQWmyeMy4K3rmclXxRqpwFlmVLIoSotLC4PGQBdsp7hz+VuhHkpXTM6akvS10Coq
	ld9QjxDwWYoxJcxwPsRt+NeMea6RaUHQxkna15fTsSdDVtj/wdHA1ghkFd6IjSTW+O7GTk4ZnIRKA
	OGbZalQ/+jYzJ3PFn0gpTq4DFT9tJsV/W0UJibhPOC2G+NUBSKEpC58m03GA4krv85oAXrU/6798o
	EK+5lKSzSKNpRVZOF9kV1du0znoXJpuMdPnT32NqLSdWzzmN9B+scOtficsXXR+pqOjLpuOs+1RuA
	HPhEYKUw==;
Received: from i5e860d18.versanet.de ([94.134.13.24] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sxqa9-0002o8-4T; Mon, 07 Oct 2024 18:27:37 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: vkoul@kernel.org,
	kishon@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: phy: rk3228-hdmi-phy: convert to yaml
Date: Mon,  7 Oct 2024 18:27:32 +0200
Message-ID: <20241007162732.2450168-1-heiko@sntech.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the binding to yaml and rename it according to its first
compatible instead of the unspecific rockchip-inno-hdmi naming.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../bindings/phy/phy-rockchip-inno-hdmi.txt   | 43 --------
 .../phy/rockchip,rk3228-hdmi-phy.yaml         | 97 +++++++++++++++++++
 2 files changed, 97 insertions(+), 43 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-inno-hdmi.txt
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip,rk3228-hdmi-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-hdmi.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-hdmi.txt
deleted file mode 100644
index 710cccd5ee56..000000000000
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-hdmi.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-ROCKCHIP HDMI PHY WITH INNO IP BLOCK
-
-Required properties:
- - compatible : should be one of the listed compatibles:
-	* "rockchip,rk3228-hdmi-phy",
-	* "rockchip,rk3328-hdmi-phy";
- - reg : Address and length of the hdmi phy control register set
- - clocks : phandle + clock specifier for the phy clocks
- - clock-names : string, clock name, must contain "sysclk" for system
-	  control and register configuration, "refoclk" for crystal-
-	  oscillator reference PLL clock input and "refpclk" for pclk-
-	  based refeference PLL clock input.
- - #clock-cells: should be 0.
- - clock-output-names : shall be the name for the output clock.
- - interrupts : phandle + interrupt specified for the hdmiphy interrupt
- - #phy-cells : must be 0. See ./phy-bindings.txt for details.
-
-Optional properties for rk3328-hdmi-phy:
- - nvmem-cells = phandle + nvmem specifier for the cpu-version efuse
- - nvmem-cell-names : "cpu-version" to read the chip version, required
-	  for adjustment to some frequency settings
-
-Example:
-	hdmi_phy: hdmi-phy@12030000 {
-		compatible = "rockchip,rk3228-hdmi-phy";
-		reg = <0x12030000 0x10000>;
-		#phy-cells = <0>;
-		clocks = <&cru PCLK_HDMI_PHY>, <&xin24m>, <&cru DCLK_HDMIPHY>;
-		clock-names = "sysclk", "refoclk", "refpclk";
-		#clock-cells = <0>;
-		clock-output-names = "hdmi_phy";
-		status = "disabled";
-	};
-
-Then the PHY can be used in other nodes such as:
-
-	hdmi: hdmi@200a0000 {
-		compatible = "rockchip,rk3228-dw-hdmi";
-		...
-		phys = <&hdmi_phy>;
-		phy-names = "hdmi";
-		...
-	};
diff --git a/Documentation/devicetree/bindings/phy/rockchip,rk3228-hdmi-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,rk3228-hdmi-phy.yaml
new file mode 100644
index 000000000000..ac15bf857ef9
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/rockchip,rk3228-hdmi-phy.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/rockchip,rk3228-hdmi-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip HDMI PHY with Innosilicon IP block
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3228-hdmi-phy
+      - rockchip,rk3328-hdmi-phy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: sysclk
+      - const: refoclk
+      - const: refpclk
+
+  clock-output-names:
+    description:
+      The hdmiphy output clock name, that gets fed back to the CRU.
+
+  "#clock-cells":
+    const: 0
+
+  interrupts:
+    maxItems: 1
+
+  nvmem-cells:
+    maxItems: 1
+    description: A phandle + nvmem specifier for the cpu-version efuse
+      for adjustment to some frequency settings, depending on cpu-version
+
+  nvmem-cell-names:
+    items:
+      - const: cpu-version
+
+  '#phy-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - clock-output-names
+  - '#clock-cells'
+  - '#phy-cells'
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3228-hdmi-phy
+
+    then:
+      properties:
+        interrupts: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3328-hdmi-phy
+
+    then:
+      required:
+        - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+
+    #include <dt-bindings/clock/rk3228-cru.h>
+    hdmi_phy: phy@12030000 {
+      compatible = "rockchip,rk3228-hdmi-phy";
+      reg = <0x12030000 0x10000>;
+      #phy-cells = <0>;
+      clocks = <&cru PCLK_HDMI_PHY>, <&xin24m>, <&cru DCLK_HDMI_PHY>;
+      clock-names = "sysclk", "refoclk", "refpclk";
+      #clock-cells = <0>;
+
+      clock-output-names = "hdmi_phy";
+    };
-- 
2.43.0


