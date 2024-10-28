Return-Path: <linux-kernel+bounces-384773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C7D9B2E3B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF5121F22350
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58135205125;
	Mon, 28 Oct 2024 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="kGcOko++"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1940C1DC19F;
	Mon, 28 Oct 2024 10:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112874; cv=none; b=SHEU1zT7GrN1M1vQMo6+uE9hHSOmG6x1bqzBg2OChoTSoAubUios5wr84z4iO3vKVT6ZMG4HRd/PIZrjQOUXyjJuU7vyhcrcr28SygaPlz7T8zumMfuaOe1AHUGm3nP0o3hfzeRTkikBN6EuMAxxevnuNWFcg9/QftLZO2WI/iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112874; c=relaxed/simple;
	bh=T4AOAHhhAAV6BIM0MHwbxoio5jRcZJ0jwDX3JoS67Tg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BpgBdTDIedCwMML1y/VBnSWmcBVjY/TaDwlgOgrKS6IAN+vUT6lZjH+qs29UKQA9AmZsJydS0umMOK8yhRFK6Eb29uR9NGbuECbUk6+iIVh5OyNuHn10x3+GyJDY0xeno/CCYkXby4vseUzXsV1bPo616PxrdE/wlqKiBWUttBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=kGcOko++; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id BEFBB1F928;
	Mon, 28 Oct 2024 11:54:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1730112862;
	bh=UGWeCLNvpCgUVFKDrNCiEgB3WmbeAvlFwjq74rMtEVM=; h=From:To:Subject;
	b=kGcOko++DGamSrD7Hb4AQXyWCpXJciW9+cowdcUFG8wK88ndwd9RmOJQ/YwrOJXgZ
	 svfFdpRmAJd9h70GZ+flD77LfGhQi/kaow1fiY3+7LlIkb9ODxdNGvflJtAmrI1OsM
	 PshyKMtBpYty1MdFZ6g4hotifqm0sE1ycftiw/x0qv5twnAdagLpESGpgHfZzAuYwz
	 3nuOeCtGkqCEM3g2qUr6ZS4sIdgxzX5eeQfZ0EmsBZ8T6SU2ge6Q4Y+t0MFrYhJJL1
	 Q5avX6HW+k1SwSJFttfYJ/qo9+0vJNOrlDQapX81UTIGfggS8nvBEgPTJgU0rIeky7
	 auRUC4Hw6fq6w==
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
Subject: [PATCH v4 1/2] dt-bindings: usb: add TUSB73x0 PCIe
Date: Mon, 28 Oct 2024 11:54:12 +0100
Message-Id: <20241028105413.146510-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241028105413.146510-1-francesco@dolcini.it>
References: <20241028105413.146510-1-francesco@dolcini.it>
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
index 000000000000..e98a2e0bfcbb
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
+  ti,tusb7320-pwron-active-high:
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
+              ti,tusb7320-pwron-active-high;
+        };
+    };
-- 
2.39.5


