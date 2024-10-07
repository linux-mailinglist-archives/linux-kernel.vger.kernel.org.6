Return-Path: <linux-kernel+bounces-353084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A26F1992836
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 11:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A2AE1F215B8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321DE19CC1E;
	Mon,  7 Oct 2024 09:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="k0cXll59"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902DF18DF6C;
	Mon,  7 Oct 2024 09:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728293545; cv=none; b=RUyDk3xle8GZSv8gIySbutheHwnVYN/cf4GzKcgK26rymoNLBoCDMtCXiSzCmU0dOnbRbu15+N9Ptj4GqYVK9x6fiqnPU3HjRd1macDq6zyTgHiQLpL9yoc32EeoVwGDrbDiki6b741Mm8gphvypvCfya4BafOK444H1WqeOAr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728293545; c=relaxed/simple;
	bh=Q6ow7GUqAzWy9Gsj22wYbT3r7EnlqIllFyUxMnG3duM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p0nfYmuvx3W98RXy5g0TNQcFsP0R8YvKZKatkijfjcecbxkueAvu6v/YsAOqCNbkBbzJXKJv0ElUldmmMGWXMqtBBfDLjHaJLnJjuHBQ48xkKhBjhJ/44CQX8R/IWm0X7CFs5QnL8vQukpq88nb1xKf5rncGsuMAZ6zptnMz66Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=k0cXll59; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 746EA207B5;
	Mon,  7 Oct 2024 11:32:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1728293539;
	bh=8CrAR/TdXELsDDoNgcW8TShChrJK9EkSXn/tY38DJaE=; h=From:To:Subject;
	b=k0cXll59hbdc0Pa2ajq57jg6Z7wYjeith+qFEhYDpr4DrLenItQ5UjP7NApBcn3/Q
	 /XliHTik6PUDKCZavpAVEoUnFdkYkU8Y9wt0xYlYNvdfXnXu32TOq0M5Xeh57wKd5m
	 wBSeeAjXP84MCkm90RJwGfsFWmzCTEOo3J6j5ZJWCtc3BCdrwHWWGs+lsmL7l9kKHV
	 PNjLTIRvBiqfc8xZ8kCf9psHsSI5wgF6b/m8EkuavZU1EVt+rR8ZcjcRDm6VPjxDSx
	 B95CGBVdDtV4NeCWUo42GpbjHGxMo9W/g7s7Mt9BVW3kLO8iXAISZ193qTDS98nzRe
	 HQO9qbQQGbQHQ==
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
Subject: [PATCH v2 1/2] dt-bindings: usb: add TUSB73x0 PCIe
Date: Mon,  7 Oct 2024 11:32:04 +0200
Message-Id: <20241007093205.27130-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241007093205.27130-1-francesco@dolcini.it>
References: <20241007093205.27130-1-francesco@dolcini.it>
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
v2: rename property to ti,tusb7320-pwron-active-high and change type to flag
---
 .../bindings/usb/ti,tusb73x0-pci.yaml         | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml

diff --git a/Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml b/Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml
new file mode 100644
index 000000000000..67a691dc03de
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
+                  compatible = "pci104C,8241";
+                  reg = <0x10000 0x0 0x0 0x0 0x0>;
+
+                  ti,tusb7320-pwron-active-high;
+            };
+        };
+    };
-- 
2.39.5


