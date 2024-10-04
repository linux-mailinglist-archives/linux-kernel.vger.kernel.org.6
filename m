Return-Path: <linux-kernel+bounces-350309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE3A99033E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 14:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55294283DF8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 12:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A961D7984;
	Fri,  4 Oct 2024 12:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="g8m/PlFu"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7531D61AD;
	Fri,  4 Oct 2024 12:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728045940; cv=none; b=NmrLyqScF/0ymWMRzjwBWUQDrIPtzAOaScCkDnCvqRs6IRgpac1gzAgbxYmn6EQAhbK2kf8qGnJbFeAKvJSH2hQVTZSubyxxi5en86AYAGVwuWrneQEXOJDCymGwIn7deWbIQBbBmBvv1tOsgXzfXUd1MCj7cF/isd9/AMHsDpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728045940; c=relaxed/simple;
	bh=uWsZNGe3pqxzZr79023FPOo8NHWjPAJAYWxwLX8dIJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TuGaPKyRetAEJWyvOeGAB/umk7PneijBT44sJJEyp1b/pNVcHvvuTv/gXuT6W7x6+JVeCzMdwOJhpE9ux5yY6hIX+bpM/9vp7O24lrLj4lQjV8fKz0UXe1s8g6toHAQVOYO0V8WUlQKKASuV+ZBsRKxeECFgUPXoC+0CtBXkmLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=g8m/PlFu; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 087E520B3E;
	Fri,  4 Oct 2024 14:45:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1728045927;
	bh=kYBsUjE2mHIzazcKSvxnMOQn0HZCyzCwd7IP56x1zOo=; h=From:To:Subject;
	b=g8m/PlFuZIimr/+DitGPyh4kPiMpJnYZVG8WuI10t0C41SNx+n+NTLI84QZ9480YH
	 q67ScRwBzzDDdYcn+zfBh9iIgUHDq+ptc3z+IT/tu9oIO1k6ULk8A+VrlWo8UezAxS
	 aZZzKvDWgsLeP1kRpHQuUmJH/9z6t/FOU0YPjqOUSmxLgz0jrIKNLdG/tScSLa88ns
	 2eNTEEoVi4PDqAUmdRBVa0EzR+KBPy8kvx9akhkE+RiM5SEO1BHOr9OueHTNkYg6A9
	 DOH0mtQ+wGdKhcLDINFKXJIGZHrYHBDQRWRrMcAxXEUigBF4vknfkV47hwwfdCgYDh
	 t0vug5Hyfyvuw==
From: Francesco Dolcini <francesco@dolcini.it>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Parth Pancholi <parth.pancholi@toradex.com>,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: usb: add TUSB73x0 PCIe
Date: Fri,  4 Oct 2024 14:45:20 +0200
Message-Id: <20241004124521.53442-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241004124521.53442-1-francesco@dolcini.it>
References: <20241004124521.53442-1-francesco@dolcini.it>
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
 .../bindings/usb/ti,tusb73x0-pci.yaml         | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml

diff --git a/Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml b/Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml
new file mode 100644
index 000000000000..bcb619b08ad3
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
+    const: pci104C,8241
+
+  reg:
+    maxItems: 1
+
+  ti,tusb7320-pwron-polarity-invert:
+    type: boolean
+    description:
+      Configure the polarity of the PWRONx# signals. When this is false, the PWRONx#
+      pins are active low and their internal pull-down resistors are enabled.
+      When this is true, the PWRONx# pins are active high and their internal pull-down
+      resistors are disabled.
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
+                  compatible = "pci104C,8241";
+                  reg = <0x10000 0x0 0x0 0x0 0x0>;
+
+                  ti,tusb7320-pwron-polarity-invert;
+            };
+        };
+    };
-- 
2.39.5


