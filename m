Return-Path: <linux-kernel+bounces-386406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D075E9B430E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BC84B2172B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C6E202657;
	Tue, 29 Oct 2024 07:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="mYBZ8O2c"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40051FF7A8;
	Tue, 29 Oct 2024 07:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730186696; cv=none; b=JITRA+0htrxNlfbpFTnF2x2pBy093bBe72Bigaw8bYW2Ah7pIWV49LGz0lWXkGQuaWnYFOmbGy6Mj6XGgETUpN1XAOreL4c1wfENLeFsuARt0QxfaAaWl1UVzKNoRqge7Plfwb2tH5CTFw/pujUZgVbgL93daCQiCBL+McFiFjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730186696; c=relaxed/simple;
	bh=dD6sfEA6TyrR92IuEwIrvwGdiNhG++5AP5oCyAJBRv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aQc2lfkoZptLhfaqcNRnS6IUX7RgaTcZQDOxb2XZ+kihtPTGsQ4HrN//7/92gHHIaj7Myu0RLovqRtaTpDeLysmF8xbim4WSCxNpKXcfXMPn9kU/oCP1HUTQay/6grLDqCyJ1sCZtKU4PIiXRjOBtO3Gecquxty1XNL2kf3MP50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=mYBZ8O2c; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 647481F9F5;
	Tue, 29 Oct 2024 08:24:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1730186689;
	bh=zJNrAwAncRDPcYMxzosZep3z32xn7omnGmf2DkOscDA=; h=From:To:Subject;
	b=mYBZ8O2cH/93cCXsLZ5jlf8UCQuSLx6er4SbJxa+hFPMGCJG4XZXsQ0A6RXE3gEF+
	 TDO1EKFhduTCVcXCADWs7lN5KVkx5/cEt825kqniLcczjvj3ppQ8O6Btd8ZpShvYfI
	 JYncPE4kcT9sHI2sLeLM27iaoTK3Io6zHXWOrJx2+i/XwyWhJbOWwfygJDkhNqGKh9
	 yYBcakeHLIvHKHHptER9emnTfGfRUvmko6NpUxmRXUSxb0pWFEKqQgMQ12ZMH3Gjgh
	 8nOL+QrzG7DlSFH5uAYH+KW/BMkJD9cPkwHBJa70dY5GTzCbb2m1I7KpDrHUxNKyT8
	 c815J4RrX3jVQ==
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
Subject: [PATCH v5 1/2] dt-bindings: usb: add TUSB73x0 PCIe
Date: Tue, 29 Oct 2024 08:24:43 +0100
Message-Id: <20241029072444.8827-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241029072444.8827-1-francesco@dolcini.it>
References: <20241029072444.8827-1-francesco@dolcini.it>
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

Datasheet: https://www.ti.com/lit/ds/symlink/tusb7320.pdf
Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v5:
 - s/ti,tusb7320-pwron-active-high/ti,pwron-active-high/
v4:
 - add $ref: usb-xhci.yaml
 - description: wrap to 80 columns, add that the two variants use the
   same device ID
 - revise the example, based on comment from Rob and taking
   marvell,prestera.yaml as an example (this binding was reviewed and
   amended by Rob in the past).
v3: use lowercase hex in compatible
v2: rename property to ti,tusb7320-pwron-active-high and change type to flag
---
 .../bindings/usb/ti,tusb73x0-pci.yaml         | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml

diff --git a/Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml b/Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml
new file mode 100644
index 000000000000..ddda734f36fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml
@@ -0,0 +1,55 @@
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
+  to four downstream ports, both variants share the same PCI device ID.
+
+properties:
+  compatible:
+    const: pci104c,8241
+
+  reg:
+    maxItems: 1
+
+  ti,pwron-active-high:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Configure the polarity of the PWRONx# signals. When this is present, the
+      PWRONx# pins are active high and their internal pull-down resistors are
+      disabled. When this is absent, the PWRONx# pins are active low (default)
+      and their internal pull-down resistors are enabled.
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: usb-xhci.yaml
+
+additionalProperties: false
+
+examples:
+  - |
+    pcie@0 {
+        reg = <0x0 0x1000>;
+        ranges = <0x02000000 0x0 0x100000 0x10000000 0x0 0x0>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+        device_type = "pci";
+
+        usb@0 {
+              compatible = "pci104c,8241";
+              reg = <0x0 0x0 0x0 0x0 0x0>;
+              ti,pwron-active-high;
+        };
+    };
-- 
2.39.5


