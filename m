Return-Path: <linux-kernel+bounces-331845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B839B97B1EE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C59E283C7A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC6C1A4E6E;
	Tue, 17 Sep 2024 15:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="qcVcFZK1"
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6298A17C988;
	Tue, 17 Sep 2024 15:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.3.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726585904; cv=none; b=dLBlgHasyg0VIx9icRWGAiQi4Vc8sf+F/3zDT+tt4XCW+B/pOz3S6MJnbmThn88k/K7wmk/iepkdCRERPLfbadTq95qIaMcEh+8RZEoYY+wSDnTlVDBM5IWcQ3CIPxYseSqGiZ5jHyD4XFdtYo87/M8/JpIeNQlAnXiha8u2pK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726585904; c=relaxed/simple;
	bh=bWP4qv+E2x90O4bWRb9DMakRIusLAM9KSMjl8VzEq04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HQHFUsgMjr53j4P+0RlmLVBQ3pL00Taq6mTbvTS4mkERk1x2SalXEPKgOhk5cxtx45bgA1aILrJSlGnpg/g1HBZCLWyVwDtrCCrB4E60rnNHh3fItUD+ro9JpB35a9qTOhQWFf5cQqe4n6Qo1zjYnsEMfEWUdxkLbOFvzFinA8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com; spf=pass smtp.mailfrom=ysoft.com; dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b=qcVcFZK1; arc=none smtp.client-ip=81.19.3.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ysoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
	s=20160406-ysoft-com; t=1726585901;
	bh=1cfKJJ01YsLZ5FGYmBxdnbC4cxwRLHTFQd2CggJXTGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qcVcFZK1yRz1eJN4E3E5d/pk2RQ+cqqN98WsNkb43R/y+4Bm+nTz1GIoUdvV6ixfC
	 YDAdWXHUXkYt8ZSN9YGlKHpvpF3jwBj4g0/MACwpPmCcQDvYLZ6+Cw/kHlbEn1LKuf
	 0Giklv6bJo4OOxGUhN7vwlofK2LlQOpVaUjGhcjk=
Received: from vokac-nb.ysoft.local (unknown [10.1.8.111])
	by uho.ysoft.cz (Postfix) with ESMTP id AA0B9A24A6;
	Tue, 17 Sep 2024 17:11:41 +0200 (CEST)
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
	=?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH 3/4] dt-bindings: usb: Add Diodes Incorporated PI5USB30213A Type-C Controller
Date: Tue, 17 Sep 2024 17:10:00 +0200
Message-ID: <20240917151001.1289399-4-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240917151001.1289399-1-michal.vokac@ysoft.com>
References: <20240917151001.1289399-1-michal.vokac@ysoft.com>
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

Signed-off-by: Petr Benes <petr.benes@ysoft.com>
Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 .../bindings/usb/diodes,pi5usb30213a.yaml     | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/diodes,pi5usb30213a.yaml

diff --git a/Documentation/devicetree/bindings/usb/diodes,pi5usb30213a.yaml b/Documentation/devicetree/bindings/usb/diodes,pi5usb30213a.yaml
new file mode 100644
index 000000000000..1cae10724152
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/diodes,pi5usb30213a.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/diodes,pi5usb30213a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PI5USB30213A Type-C port controller
+
+description:
+  Diodes Incorporated PI5USB30213A Type-C Controller supports host,
+  device, and dual-role mode based on voltage levels detected on CC
+  pin. Dual differential channel, 2:1 USB 3.0 Mux/Demux, USB Type-C
+  specification 1.1 compliant.
+
+maintainers:
+  - Petr Benes <petr.benes@ysoft.com>
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
+    $ref: ../connector/usb-connector.yaml#
+    unevaluatedProperties: false
+    description:
+      The managed USB Type-C connector.
+
+    properties:
+      compatible:
+        const: usb-c-connector
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
+      pi5usb30213a: tcpc@d {
+        compatible = "diodes,pi5usb30213a";
+        reg = <0xd>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_typec>;
+        interrupts-extended = <&gpio1 5 IRQ_TYPE_LEVEL_LOW>;
+        status = "okay";
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


