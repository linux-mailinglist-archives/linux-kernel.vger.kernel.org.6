Return-Path: <linux-kernel+bounces-240749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BFE927211
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBA952873A1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 08:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DE11AB505;
	Thu,  4 Jul 2024 08:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mO4E1Srw"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D711A4F0F;
	Thu,  4 Jul 2024 08:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720082970; cv=none; b=VV1H8ZBRRYYjj7d6zwWZN7NuoRHx++lBZ9LLYP7Ho2kafVKywyLDJw8/1uGKUFKDjWGUqZwV+SLQpcd6K/kuie4JtbSm2VhrJ/WWrwxGKCILRo2njNZLB/XWiS++tkpN+uwACx9K6herGUfXW1yx/Ohf7enIRtN51LOMCrw78n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720082970; c=relaxed/simple;
	bh=1HjxPqypgsve3fGZqqNIgilI5FsrzhZKY0WXWsKK6IQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DLwnUJbHimzkKNj3hTeRYPSg9QnRePLm2SPJAFeZ38jRY3o/2AltHJptL0HziZCt4rvx0vh+7AFHnLkHSQ9Rjc4qucUj3BWwcZb97iFkxg8Nwz8bSltksybvQiUm0c5MZez2PUiiiyZrPQUr61QrJkayZTmlZ9UQp4FrPDtiuyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mO4E1Srw; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720082968; x=1751618968;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1HjxPqypgsve3fGZqqNIgilI5FsrzhZKY0WXWsKK6IQ=;
  b=mO4E1Srw+k1u/YqtdN7a9bULnpdd71+jRkPM2OdsPjrcUiszK58EmeAt
   j91XnYaDBAVEM70RARjfVQZsg7urvJq4GbvxXgJJtB9mv0mhCfWkCUSje
   BZQiZGvzFCfqiSCkr9DxgMXC2fh8/2PAzdMsJJOpkrtx4TDJoXtVlxfji
   h277FrCp++LcarMKvcCm+qIJRal1wisjdWKHMHcrPlnRWazZxn40GCunN
   qjlteqQfqI6Pz4TTdRR3KyoOsGhGaR7g/HbhahSO3yJKG/oAryNeCdP+r
   lnzEJBdpTtaMZ3eeIuaonQ1Qkj7DCfdLJ2jkN9xOii7ool/Qu1Lii55/5
   Q==;
X-CSE-ConnectionGUID: QwADFB6LR8OoRGaGmTWhqQ==
X-CSE-MsgGUID: iVsUngpoRVias0yp19+3Xw==
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="259727486"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2024 01:49:27 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jul 2024 01:48:46 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jul 2024 01:48:36 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
	<rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux@armlinux.org.uk>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <arnd@arndb.de>, <Jason@zx2c4.com>,
	<palmer@rivosinc.com>, <mpe@ellerman.id.au>, <rdunlap@infradead.org>,
	<dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <manikandan.m@microchip.com>, <Hari.PrasathGE@microchip.com>,
	<Nicolas.Ferre@microchip.com>
Subject: [PATCH 1/4] dt-bindings: display: bridge: add sam9x75-mipi-dsi binding
Date: Thu, 4 Jul 2024 14:18:34 +0530
Message-ID: <20240704084837.168075-2-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240704084837.168075-1-manikandan.m@microchip.com>
References: <20240704084837.168075-1-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add the 'sam9x75-mipi-dsi' compatible binding, which describes the
Microchip's specific wrapper for the Synopsys DesignWare MIPI DSI HOST
Controller for the sam9x75 series System-on-Chip (SoC) devices.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 .../bridge/microchip,sam9x75-mipi-dsi.yaml    | 135 ++++++++++++++++++
 1 file changed, 135 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-mipi-dsi.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-mipi-dsi.yaml
new file mode 100644
index 000000000000..87aaf9c929e9
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-mipi-dsi.yaml
@@ -0,0 +1,135 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/microchip,sam9x75-mipi-dsi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip SAM9X75 MIPI DSI Controller
+
+maintainers:
+  - Manikandan Muralidharan <manikandan.m@microchip.com>
+
+description:
+  Microchip specific extensions or wrapper to the Synopsys Designware MIPI DSI.
+  The MIPI Display Serial Interface (DSI) Host Controller implements all
+  protocol functions defined in the MIPI DSI Specification. The DSI Host
+  provides an interface between the LCD Controller (LCDC) and the MIPI D-PHY,
+  allowing communication with a DSI-compliant display.
+
+allOf:
+  - $ref: /schemas/display/dsi-controller.yaml#
+
+properties:
+  compatible:
+    const: microchip,sam9x75-mipi-dsi
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description:
+      MIPI DSI must have two clocks to function correctly.Peripheral clock
+      'pclk' for the hardware block functionality and Generic clock 'refclk' to
+      drive the D-PHY PLL block.
+    minItems: 2
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: refclk
+
+  microchip,sfr:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to Special Function Register (SFR) node.To enable the DSI/CSI
+      selection bit in SFR's ISS Configuration Register.
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description:
+          DSI Input port node, connected to the LCDC RGB output port.
+
+        properties:
+          endpoint:
+            $ref: /schemas/media/video-interfaces.yaml#
+            unevaluatedProperties: false
+            properties:
+              remote-endpoint: true
+
+      port@1:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description:
+          DSI Output port node, connected to a panel or a bridge input port.
+
+        properties:
+          endpoint:
+            $ref: /schemas/media/video-interfaces.yaml#
+            unevaluatedProperties: false
+            properties:
+              remote-endpoint: true
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - ports
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/at91.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi: dsi@f8054000 {
+         compatible = "microchip,sam9x75-mipi-dsi";
+         reg = <0xf8054000 0x200>;
+         clocks = <&pmc PMC_TYPE_PERIPHERAL 54>, <&pmc PMC_TYPE_GCK 55>;
+         clock-names = "pclk", "refclk";
+         microchip,sfr = <&sfr>;
+
+         #address-cells = <1>;
+         #size-cells = <0>;
+
+         ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                        reg = <0>;
+                        dsi_in: endpoint {
+                            remote-endpoint = <&hlcdc_panel_output>;
+                        };
+                };
+
+                port@1 {
+                        reg = <1>;
+                        dsi_out: endpoint {
+                            remote-endpoint = <&mipi_in_panel>;
+                        };
+                };
+         };
+
+         panel@0 {
+              compatible = "hannstar,hsd060bhw4", "himax,hx8394";
+              reg = <0>;
+              vcc-supply = <&mic23150_reg>;
+              iovcc-supply = <&mic23150_reg>;
+              reset-gpios = <&pioC 24 GPIO_ACTIVE_LOW>;
+              backlight = <&backlight>;
+
+              port {
+                   mipi_in_panel: endpoint {
+                        remote-endpoint = <&dsi_out>;
+                   };
+              };
+         };
+    };
+...
-- 
2.25.1


