Return-Path: <linux-kernel+bounces-371543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 302989A3C77
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE19DB21E99
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3615020A5EF;
	Fri, 18 Oct 2024 10:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="uskH01RT"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DA91D7E4C;
	Fri, 18 Oct 2024 10:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248919; cv=none; b=mjsMW6JJaDNgk7gi8+RI5lP1lQrutXj6+JhPT+fuij0FxvuhSAsI7ha8T4Boew5/dwBdKOQfGvPljX9BPbz76OY+VARZphlQ5ZPtsOwEFOlZp/5TTzoAyDGn3RP/BqLVocYKm0avxY55evxhtJEPifUN8GDq9TW4LRXudL+yrnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248919; c=relaxed/simple;
	bh=dXlcSJAgvLlmp2SbcO9+GbAsPb/hnuby0rypYVZ0vDI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RcTYQ5PxHblWRrPevVR7yFRGQcZn7XpdqEH0aMJT2A13zCMU69nLuaKgVR/qLPqQBJEWPHjSgMDkgdS1mNRR8Lk1fy54bZe6RloiL4FLSe9J9JTza8Qi5X5EbwQnt/keNACl+KMGRBCXDa0sdpPd0eD3MDD4JsCFXad2HlRRKUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=uskH01RT; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 0BC201FAAF;
	Fri, 18 Oct 2024 12:55:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1729248912;
	bh=RpL7cRHFX05ZvjNV5sS2C29Zp9ge2OM147LKWy4YLsM=; h=From:To:Subject;
	b=uskH01RTuMuv/c8d7OfFlEum4z0Q9/xT726MJjjbn1MoYrwRJFF67YGIwg0QB/tXI
	 a9BZ1NE6qqninYumkUTXwVv/I05BGfMzTcQrDiY3DcCTe8TwinRFnJfj4yxucm9tBx
	 UmIAXLgRoddmNraHrmkGF49sJ9ODF97caZ9MTLGblpmf3ewjhxZXccJwyHsnyYSmIA
	 Xf7YFtwRsWht2BHmcZbWS+Cc3I4TuFjZEOFACaP1tXtR08KNSyptxMtjrKmYRW52iF
	 OugdYFwmHbrJTPj91HEQEXT2PfSdAaAT7LgqCE1hdjQNsO7GA0Eevfd60ki0cQOVS+
	 0zF8vri7IvFNg==
From: Francesco Dolcini <francesco@dolcini.it>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Parth Pancholi <parth.pancholi@toradex.com>,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: usb: add TUSB73x0 PCIe
Date: Fri, 18 Oct 2024 12:55:04 +0200
Message-Id: <20241018105505.28005-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241018105505.28005-1-francesco@dolcini.it>
References: <20241018105505.28005-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Parth Pancholi <parth.pancholi@toradex.com>

Add device tree bindings for TI's TUSB73x0 PCIe-to-USB 3.0 xHCI
host controller. The controller supports software configuration
through PCIe registers, such as controlling the PWRONx polarity
via the USB control register (E0h).

Similar generic PCIe-based bindings can be found as qcom,ath11k-pci.yaml
as an example.

Datasheet: https://www.ti.com/lit/ds/symlink/tusb7320.pdf
Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v3: use lowercase hex in compatible
v2: rename property to ti,tusb7320-pwron-active-high and change type to flag
---
 .../bindings/usb/ti,tusb73x0-pci.yaml         | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml

diff --git a/Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml b/Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml
new file mode 100644
index 000000000000..7083e24d279c
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/ti,tusb73x0-pci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TUSB73x0 USB 3.0 xHCI Host Controller (PCIe)
+
+maintainers:
+  - Francesco Dolcini <francesco.dolcini@toradex.com>
+
+description:
+  TUSB73x0 USB 3.0 xHCI Host Controller via PCIe x1 Gen2 interface.
+  The TUSB7320 supports up to two downstream ports, the TUSB7340 supports up
+  to four downstream ports.
+
+properties:
+  compatible:
+    const: pci104c,8241
+
+  reg:
+    maxItems: 1
+
+  ti,tusb7320-pwron-active-high:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Configure the polarity of the PWRONx# signals. When this is present, the PWRONx#
+      pins are active high and their internal pull-down resistors are disabled.
+      When this is absent, the PWRONx# pins are active low (default) and their internal
+      pull-down resistors are enabled.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    pcie {
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        pcie@0 {
+            device_type = "pci";
+            reg = <0x0 0x0 0x0 0x0 0x0>;
+            bus-range = <0x01 0xff>;
+
+            #address-cells = <3>;
+            #size-cells = <2>;
+            ranges;
+
+            usb@0 {
+                  compatible = "pci104c,8241";
+                  reg = <0x10000 0x0 0x0 0x0 0x0>;
+
+                  ti,tusb7320-pwron-active-high;
+            };
+        };
+    };
-- 
2.39.5


