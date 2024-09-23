Return-Path: <linux-kernel+bounces-336002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E620797EDEC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22AEA1C21482
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE41C19F118;
	Mon, 23 Sep 2024 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="Lp19ZPwt"
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9960C19CC2C;
	Mon, 23 Sep 2024 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.3.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727104465; cv=none; b=rkP/MUKo6jaj3di1MIK2OAptzG8tdrSOQ8yXtBwg/mdnNqvbkaA/OSejTO6EKe1CvjhDpeg7Skx8GsRodtmKhjZhkzmESRnYeKhLFM1g3gjjpDYsfGeyQWO/oF5t4W2heQlu7u41+YcsulYsuSscz7Y/nmyI2OCuy1NcaEOU0Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727104465; c=relaxed/simple;
	bh=XOt7aBhxv7ynsa4yyg4wHcPQHXzmiOSb11s6zA2gvVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TToeCONPT4ypv8dUEuRy+E59kUVH0xpX8lDU9E47hBUS8h+ydoMvRGAYVJ6iLGp7fxuG0WCF7rwYxK/Kg+Hj1Vi7hjbFnZ0VqJYy3MIhv8WyoCfYEVRjV8q0rGISDh0SlTtyHnXdoDktquR9OPivO6I2iCDKfu6vV/ZhNpVrq3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com; spf=pass smtp.mailfrom=ysoft.com; dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b=Lp19ZPwt; arc=none smtp.client-ip=81.19.3.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ysoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
	s=20160406-ysoft-com; t=1727104461;
	bh=TKCy9Jq22eRkR6RmpHojozqZz4jZeE1HMz6d8/7gisk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lp19ZPwtv03gSL2F7CbIedTZD2s4iY3Djyxk/ygOi55M0kjmeYh+Oa9tCot/8U7bA
	 S5YYulEvK31BnG45kgW/TFqk0lswWmvJZq0V+LfuJ/BqBAXkswJJw+LLBX6oDzvexJ
	 tIrO/o3QZ0K6zBynuHT0kHK9h0edC0aveQkG1E8g=
Received: from vokac-nb.ysoft.local (unknown [10.1.8.111])
	by uho.ysoft.cz (Postfix) with ESMTP id 2B88BA05E5;
	Mon, 23 Sep 2024 17:14:21 +0200 (CEST)
From: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Petr Benes <petr.benes@ysoft.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Herburger <gregor.herburger@ew.tq-group.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Michael Walle <mwalle@kernel.org>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	=?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH v3 3/4] dt-bindings: usb: Add Diodes Incorporated PI5USB30213A Type-C Controller
Date: Mon, 23 Sep 2024 17:14:16 +0200
Message-ID: <20240923151417.1665431-4-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240923151417.1665431-1-michal.vokac@ysoft.com>
References: <20240923151417.1665431-1-michal.vokac@ysoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Petr Benes <petr.benes@ysoft.com>

Diodes Incorporated PI5USB30213A Type-C Controller supports host,
device, and dual-role mode based on voltage levels detected on CC
pin. Supports dual differential channel, 2:1 USB 3.0 Mux/Demux,
USB Type-C specification 1.1.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Petr Benes <petr.benes@ysoft.com>
Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
v3:
- Collected R-b tag from Krzysztof.
v2:
- Moved maintainers before description: block.
- Used full paths for references.
- Removed unneeded items form connector property.
- Fixed example.

 .../bindings/usb/diodes,pi5usb30213a.yaml     | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/diodes,pi5usb30213a.yaml

diff --git a/Documentation/devicetree/bindings/usb/diodes,pi5usb30213a.yaml b/Documentation/devicetree/bindings/usb/diodes,pi5usb30213a.yaml
new file mode 100644
index 000000000000..054a5409bd15
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/diodes,pi5usb30213a.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/diodes,pi5usb30213a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PI5USB30213A Type-C port controller
+
+maintainers:
+  - Petr Benes <petr.benes@ysoft.com>
+
+description:
+  Diodes Incorporated PI5USB30213A Type-C Controller supports host,
+  device, and dual-role mode based on voltage levels detected on CC
+  pin. Dual differential channel, 2:1 USB 3.0 Mux/Demux, USB Type-C
+  specification 1.1 compliant.
+
+properties:
+  compatible:
+    enum:
+      - diodes,pi5usb30213a
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  connector:
+    type: object
+    $ref: /schemas/connector/usb-connector.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - connector
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      typec@d {
+        compatible = "diodes,pi5usb30213a";
+        reg = <0xd>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_typec>;
+        interrupts-extended = <&gpio1 5 IRQ_TYPE_LEVEL_LOW>;
+
+        connector {
+          compatible = "usb-c-connector";
+          label = "USB-C";
+          vbus-supply = <&reg_typec>;
+          power-role = "source";
+          data-role = "dual";
+          typec-power-opmode = "default";
+          pd-disable;
+
+          ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+              reg = <0>;
+
+              usb_con_hs: endpoint {
+                remote-endpoint = <&typec_hs>;
+              };
+            };
+
+            port@1 {
+              reg = <1>;
+
+              usb_con_ss: endpoint {
+                remote-endpoint = <&typec_ss>;
+              };
+            };
+          };
+        };
+      };
+    };
-- 
2.43.0


