Return-Path: <linux-kernel+bounces-286308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1F4951969
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E1A0B22D56
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F06D1AE05E;
	Wed, 14 Aug 2024 10:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xuebi+sT"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DE71448D4;
	Wed, 14 Aug 2024 10:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723632823; cv=none; b=YhIxHehuAY1KzFK30DbiBlmd6rzjimTL3MNTIJ7WXC1HQvXfdPF1kl7to4Sg0vUuH+dQo7L0Mt2r1luFL78kygCXCSJ6UOsEmMfrmuBwr0CKel8RcP+xyfkq1jmhM1xNXdZuL5iXOVOzt+iFGZ8uRbmsdh1thAZIEmUbnT2mx7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723632823; c=relaxed/simple;
	bh=Aj7sKuykYMEBw09BQyOhIExTMRQK6Jv7TFjbDsucY2k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cB1DVtyw76yQf/VlbJCWKI9+lBaAax3rFezFH3oQ0MbBGb+ed8JAnkJMeusXYzuD0+UzvLkg0kp52J3LZ+F17uG/c2fhKn4lZ8k5XCsXW+kjbhEb2+UMldIr5dofz9d7Viw/ToW+El0Q5mHNh+ckfKdc1uhlQBH5dDBmacmwG9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xuebi+sT; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723632821; x=1755168821;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Aj7sKuykYMEBw09BQyOhIExTMRQK6Jv7TFjbDsucY2k=;
  b=xuebi+sTn7PILxJK5Zf72kUC/dxho8qvX/nf2BIzVU4FwsXb0GLhFs3w
   YlR17i1CxLKYJGt0flcimYIduFadexv8HNpn9DWhRtfI/5sCtS6Li9dMs
   L4EYPZkTNalbI/XEuQgWSVQ2azYg2IyCOQvO+GuNAmqoE2RbPF/tKi1Ha
   CMFeQ1XgEKKYOSGnSWcJei1r2yZ8DYe/pR8y3Ne/JtAQW9uqsvtjrGzXD
   V92sO+2G7WAe5p8iaoRwHhzSAIoOpCVly2hIk1sZ6t82DFNDZDJpAQ75M
   lOWfrlOJHxq839p88xIi0rnRIor3qU+j8QReXZq2rKiBCFsYO32ANT65F
   A==;
X-CSE-ConnectionGUID: uJjbrbWgSo2CAGswzsVaNQ==
X-CSE-MsgGUID: yvdEaXssQsCCA0wk6cERdQ==
X-IronPort-AV: E=Sophos;i="6.09,145,1716274800"; 
   d="scan'208";a="261393459"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Aug 2024 03:53:39 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Aug 2024 03:53:19 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 14 Aug 2024 03:53:09 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
	<rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux@armlinux.org.uk>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <arnd@arndb.de>, <geert+renesas@glider.be>,
	<mpe@ellerman.id.au>, <rdunlap@infradead.org>, <dharma.b@microchip.com>,
	<dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v3 1/4] dt-bindings: display: bridge: add sam9x75-mipi-dsi binding
Date: Wed, 14 Aug 2024 16:22:53 +0530
Message-ID: <20240814105256.177319-2-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240814105256.177319-1-manikandan.m@microchip.com>
References: <20240814105256.177319-1-manikandan.m@microchip.com>
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
changes in v3:
- Describe the clocks used

changes in v2:
- List the clocks with description
- remove describing 'remove-endpoint' properties
- remove unused label, node and fix example DT indentation
- cosmetic fixes
---
 .../bridge/microchip,sam9x75-mipi-dsi.yaml    | 116 ++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-mipi-dsi.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-mipi-dsi.yaml
new file mode 100644
index 000000000000..3c86f0cd49e9
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-mipi-dsi.yaml
@@ -0,0 +1,116 @@
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
+  protocol functions defined in the MIPI DSI Specification.The DSI Host
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
+    items:
+      - description:
+          Peripheral Bus Clock between LCDC and MIPI DPHY
+      - description:
+          MIPI DPHY Interface reference clock for PLL block
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
+     #include <dt-bindings/clock/at91.h>
+     #include <dt-bindings/gpio/gpio.h>
+
+     dsi@f8054000 {
+       compatible = "microchip,sam9x75-mipi-dsi";
+       reg = <0xf8054000 0x200>;
+       clocks = <&pmc PMC_TYPE_PERIPHERAL 54>, <&pmc PMC_TYPE_GCK 55>;
+       clock-names = "pclk", "refclk";
+       microchip,sfr = <&sfr>;
+
+       #address-cells = <1>;
+       #size-cells = <0>;
+
+       ports {
+         #address-cells = <1>;
+         #size-cells = <0>;
+
+         port@0 {
+           reg = <0>;
+           dsi_in: endpoint {
+             remote-endpoint = <&hlcdc_panel_output>;
+           };
+         };
+
+         port@1 {
+           reg = <1>;
+           dsi_out: endpoint {
+             remote-endpoint = <&mipi_in_panel>;
+           };
+         };
+       };
+     };
+...
-- 
2.25.1


