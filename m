Return-Path: <linux-kernel+bounces-252412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 916569312C3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2E911C21140
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCDB189F23;
	Mon, 15 Jul 2024 11:04:17 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9505416E877;
	Mon, 15 Jul 2024 11:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721041457; cv=none; b=j6luBAGWWZsBTkRlb71D4d45EzRzp6T5VXsWuhLIzZE5nanN0iEyIaCrfEUKb7ECkS/LIhToIW6TqlRkZU7ZnaIsgZQmDjaDf9IAGw18yHwh+b9D98jQFtoXj3ABmKy+tw4s8mocUmEEW8LXv06BcE4hP/NRb91cSu+vm16Lc1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721041457; c=relaxed/simple;
	bh=VN5ZQW78cS8Y8erYgmalcJjKv+eVsq/kp07WQZsw9/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rJ3af9kJVVh4fAsr8Rlmuzq/Xa5fYzJ0IkN0HJ7cUOCV9lzKPyCjWoMrqeT5jbT28+yqJ0lg9iZqnN0KPBKcuHIfD8mn/DW1MgdYiwQaq4GplpIFE+/M29li5xGdTr+W9aMq4OA05PzD90YEN7Y82Jo+zoM0njs6QUIzKiUzcW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860d09.versanet.de ([94.134.13.9] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sTJV3-0006GM-KP; Mon, 15 Jul 2024 13:04:09 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: mturquette@baylibre.com,
	sboyd@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v2 1/3] dt-bindings: clocks: add binding for voltage-controlled-oscillators
Date: Mon, 15 Jul 2024 13:02:49 +0200
Message-Id: <20240715110251.261844-2-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240715110251.261844-1-heiko@sntech.de>
References: <20240715110251.261844-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In contrast to fixed clocks that are described as ungateable, boards
sometimes use additional oscillators for things like PCIe reference
clocks, that need actual supplies to get enabled and enable-gpios to be
toggled for them to work.

This adds a binding for such oscillators that are not configurable
themself, but need to handle supplies for them to work.

In schematics they often can be seen as

         ----------------
Enable - | 100MHz,3.3V, | - VDD
         |    3225      |
   GND - |              | - OUT
         ----------------

or similar. The enable pin might be separate but can also just be tied
to the vdd supply, hence it is optional in the binding.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../bindings/clock/voltage-oscillator.yaml    | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/voltage-oscillator.yaml

diff --git a/Documentation/devicetree/bindings/clock/voltage-oscillator.yaml b/Documentation/devicetree/bindings/clock/voltage-oscillator.yaml
new file mode 100644
index 0000000000000..8bff6b0fd582e
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/voltage-oscillator.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/voltage-oscillator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Voltage controlled oscillator
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  compatible:
+    const: voltage-oscillator
+
+  "#clock-cells":
+    const: 0
+
+  clock-frequency: true
+
+  clock-output-names:
+    maxItems: 1
+
+  enable-gpios:
+    description:
+      Contains a single GPIO specifier for the GPIO that enables and disables
+      the oscillator.
+    maxItems: 1
+
+  vdd-supply:
+    description: handle of the regulator that provides the supply voltage
+
+required:
+  - compatible
+  - "#clock-cells"
+  - clock-frequency
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    voltage-oscillator {
+      compatible = "voltage-oscillator";
+      #clock-cells = <0>;
+      clock-frequency = <1000000000>;
+      vdd-supply = <&reg_vdd>;
+    };
+...
-- 
2.39.2


