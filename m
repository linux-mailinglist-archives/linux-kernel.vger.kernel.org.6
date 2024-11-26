Return-Path: <linux-kernel+bounces-422585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D7C9D9B92
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6FC9168B22
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF471DB344;
	Tue, 26 Nov 2024 16:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUmc/8lL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659481D89ED;
	Tue, 26 Nov 2024 16:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732638866; cv=none; b=K/tna+aIjPQrJa1nNYXecqcl8bKUx8wmjlyIY8fX6lm2PWTwJ+9Zk+t0DQdYx0tsDvbf/57huJzZunay2CCET1BLvNhgoqa00XBHBHsf3rKwNtH0DibVBcs2hUxrqZVry/eYcVaCfoTiptsHBhQ3s/EQU9A+EOuY6/vDlOamv6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732638866; c=relaxed/simple;
	bh=cZp+0fnE3D0SdUSdagpJlc6mZJAcEEhN8c8IM3YwJI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lqJl21nlxVj+yBtqiS2QAjVG37R0KvhOwBXFIHEH9X/Cqw0P24/iBvtxjKQevCTzNkvQ6xmnpVoXpddF9bynXpSOhuyE8CvG0quZRlq+EpXoILsJGEmT1WjtEVYyXL4yTmUSl/YO/TKNbMFPS/95o+7XxjN2W/TE5CE35XuB3Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUmc/8lL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C801AC4CECF;
	Tue, 26 Nov 2024 16:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732638865;
	bh=cZp+0fnE3D0SdUSdagpJlc6mZJAcEEhN8c8IM3YwJI4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tUmc/8lLyAFnAf5/JIcKg4Zx9AUAXG3tjPfJFBw1WG7Hhu3JfuL0Yh05cfuVEiH08
	 gsf1VlJRnpFQ2pOUsgRtK0YH2alADukid7NhOcHSZ2254d3xIJzvKLIwoaVnc7QFe2
	 KKWoCRxewnDo+Xtfpsfg6Jv7it7vFDH6DDn7ERXuHyrhV69vJxst4bwx+tZ3vwyHA1
	 0jlP1jtFlJJqnmajrbY/u1l1ddX64XhbIdqgJcnzRYnsac4rZoSAqxwkgIqTKm+Yny
	 p4cW71eSt3FPA9iYkCqV22LoM1I0rFGlyubE2jj6cn7FnicFNnf+3kTBLPjqKzwa1J
	 myF2vbggCV4lA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71FFD3B9BD;
	Tue, 26 Nov 2024 16:34:25 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Date: Tue, 26 Nov 2024 17:34:20 +0100
Subject: [PATCH v2 1/5] dt-bindings: display: Add Apple pre-DCP display
 controller bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-adpdrm-v2-1-c90485336c09@gmail.com>
References: <20241126-adpdrm-v2-0-c90485336c09@gmail.com>
In-Reply-To: <20241126-adpdrm-v2-0-c90485336c09@gmail.com>
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, asahi@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732638864; l=6343;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=g48Jg5r677KMzSMpMRmoo0wqjqOCLTepYWRiT3THiy0=;
 b=JyWUct6fDmArKlep5mGw0yzFNg2T5T3D1QKWlsQHOA19YDCqOO27AU9srxSoMw56J5uijKsO7
 ZMzE1AiAqMcDu7Yc5hjiwzD0tlgQK8rOOR5ImWd/WcQyvAtQyfm3xFX
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20241124 with
 auth_id=283
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: fnkl.kernel@gmail.com

From: Sasha Finkelstein <fnkl.kernel@gmail.com>

Add bindings for a secondary display controller present on certain
Apple laptops.

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
 .../display/apple,h7-display-pipe-mipi.yaml        | 89 ++++++++++++++++++++++
 .../bindings/display/apple,h7-display-pipe.yaml    | 77 +++++++++++++++++++
 .../bindings/display/panel/apple,summit.yaml       | 58 ++++++++++++++
 3 files changed, 224 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/apple,h7-display-pipe-mipi.yaml b/Documentation/devicetree/bindings/display/apple,h7-display-pipe-mipi.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..2cf2f50e9fc7329a5b424d5ddf8c34cad2ebb6be
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/apple,h7-display-pipe-mipi.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/apple,h7-display-pipe-mipi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple pre-DCP display controller MIPI interface.
+
+maintainers:
+  - asahi@lists.linux.dev
+  - Sasha Finkelstein <fnkl.kernel@gmail.com>
+
+description:
+  The MIPI controller part of the pre-DCP Apple display controller
+
+allOf:
+  - $ref: dsi-controller.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - apple,t8112-display-pipe-mipi
+          - apple,t8103-display-pipe-mipi
+      - const: apple,h7-display-pipe-mipi
+
+  reg:
+    maxItems: 1
+
+  reg-names:
+    const: mipi
+
+  power-domains:
+    maxItems: 1
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+
+    required:
+      - port@0
+      - port@1
+
+  '#address-cells': true
+
+  '#size-cells': true
+
+patternProperties:
+  "^panel@[0-3]$": true
+
+required:
+  - compatible
+  - reg
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    display_dfr: dsi@228200000 {
+    	compatible = "apple,t8103-display-pipe-mipi", "apple,h7-display-pipe-mipi";
+    	reg-names = "mipi";
+    	reg = <0x28200000 0xc000>;
+    	power-domains = <&ps_dispdfr_mipi>;
+
+    	ports {
+    		#address-cells = <1>;
+    		#size-cells = <0>;
+
+    		dfr_mipi_in: port@0 {
+    			#address-cells = <1>;
+    			#size-cells = <0>;
+    			reg = <0>;
+    		};
+
+    		dfr_mipi_out: port@1 {
+    			#address-cells = <1>;
+    			#size-cells = <0>;
+    			reg = <1>;
+    		};
+    	};
+    };
+...
diff --git a/Documentation/devicetree/bindings/display/apple,h7-display-pipe.yaml b/Documentation/devicetree/bindings/display/apple,h7-display-pipe.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..98982da9c5f672167d67e4cd3b47e1fbdafc9510
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/apple,h7-display-pipe.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/apple,h7-display-pipe.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple pre-DCP display controller.
+
+maintainers:
+  - asahi@lists.linux.dev
+  - Sasha Finkelstein <fnkl.kernel@gmail.com>
+
+description:
+  A secondary display controller used to drive the "touchbar" on certain Apple laptops.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - apple,t8112-display-pipe
+          - apple,t8103-display-pipe
+      - const: apple,h7-display-pipe
+
+  reg:
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: be
+      - const: fe
+
+  power-domains:
+    maxItems: 2
+
+  interrupts:
+    maxItems: 2
+
+  interrupt-names:
+    items:
+      - const: be
+      - const: fe
+
+  iommus:
+    maxItems: 1
+
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/apple-aic.h>
+    display_dfr: display-pipe@228200000 {
+    	compatible = "apple,t8103-display-pipe", "apple,h7-display-pipe";
+    	reg-names = "be", "fe";
+    	reg = <0x28200000 0xc000>,
+    		<0x28400000 0x4000>;
+    	power-domains = <&ps_dispdfr_fe>, <&ps_dispdfr_be>;
+    	interrupt-parent = <&aic>;
+    	interrupts = <AIC_IRQ 502 IRQ_TYPE_LEVEL_HIGH>,
+    		<AIC_IRQ 506 IRQ_TYPE_LEVEL_HIGH>;
+    	interrupt-names = "be", "fe";
+    	iommus = <&displaydfr_dart 0>;
+    	port {
+    		dfr_adp_out_mipi: endpoint {
+    			remote-endpoint = <&dfr_mipi_in_adp>;
+    		};
+    	};
+    };
+...
diff --git a/Documentation/devicetree/bindings/display/panel/apple,summit.yaml b/Documentation/devicetree/bindings/display/panel/apple,summit.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..db14f7af3787076c84ccdda08fedeb8912d5514d
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/apple,summit.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/apple,summit.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple "Summit" display panel.
+
+maintainers:
+  - asahi@lists.linux.dev
+  - Sasha Finkelstein <fnkl.kernel@gmail.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+  - $ref: /schemas/leds/backlight/common.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - apple,j293-summit
+          - apple,j493-summit
+      - const: apple,summit
+
+  reg:
+    maxItems: 1
+
+  max-brightness: true
+
+  port: true
+
+required:
+  - compatible
+  - reg
+  - max-brightness
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    dsi {
+    	#address-cells = <1>;
+    	#size-cells = <0>;
+
+    	panel@0 {
+    		compatible = "apple,j293-summit", "apple,summit";
+    		reg = <0>;
+    		max-brightness = <255>;
+
+    		port {
+    			dfr_panel_in: endpoint {
+    				remote-endpoint = <&dfr_bridge_out>;
+    			};
+    		};
+    	};
+    };
+...

-- 
2.47.1



