Return-Path: <linux-kernel+bounces-258764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EFE938C77
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F6CB281F88
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A724116D306;
	Mon, 22 Jul 2024 09:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="Jk53thYc"
Received: from smtpout42.security-mail.net (smtpout42.security-mail.net [85.31.212.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CF316CD23
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.31.212.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641506; cv=none; b=J+2NxpTS0jHfHdWIwoas1YqlW41dEH8au8Egy758E4P8bx85JgBRy7zv0FJzFrJKUm56+31rCR9GWVrE6K3o0lM5ZxQEP6g6DAtErTJzb+qFFv3MUaNFODMwiHUZcX9EySv0yC92EL6Ft7ZUWyZ1eWxnBPpOoHieW0tyLBl/y2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641506; c=relaxed/simple;
	bh=oYzLSviRsu4hT5L/Iit/IeNJIfdJ/uOEBu+6RT3zUb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FO0Ik42VOTmcJEJR7bHi/iE7VOvHRGna/QeDxw1JPaMgyqaUBoDheb+4sUL2LxgG1vZnOWfMXZn0c1TYN0ZfmpQWKI8hZcAm2T4vYKxJevexZ/UlqIGrvY1e3JXRAlzUfRT8lzLwz2Tn+1Rty2hHOlr7vaG4SO6BZh1RACeC378=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=Jk53thYc; arc=none smtp.client-ip=85.31.212.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx302.security-mail.net (Postfix) with ESMTP id 38B7780B302
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:43:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1721641397;
	bh=oYzLSviRsu4hT5L/Iit/IeNJIfdJ/uOEBu+6RT3zUb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jk53thYcT8R0uKY8POuJbOPJCbnjeUs/yMuNuZQ6qqUZM5LG1HFtNu/TN9fidYmVf
	 00L1Y1iFD2PhEwC7usX+bU1djPDbM0JhlgPjC1CjZv5Vb31UiEVOgY9RC8LYTU8K5/
	 wtCWR8qO4iEWwC2QmCiycxmDqe40i64uhMoB+dSo=
Received: from fx302 (localhost [127.0.0.1]) by fx302.security-mail.net
 (Postfix) with ESMTP id 0B2A380B0B9; Mon, 22 Jul 2024 11:43:17 +0200 (CEST)
Received: from srvsmtp.lin.mbt.kalray.eu (unknown [217.181.231.53]) by
 fx302.security-mail.net (Postfix) with ESMTPS id 8B04580B017; Mon, 22 Jul
 2024 11:43:16 +0200 (CEST)
Received: from junon.lan.kalrayinc.com (unknown [192.168.37.161]) by
 srvsmtp.lin.mbt.kalray.eu (Postfix) with ESMTPS id 5EFAD40317; Mon, 22 Jul
 2024 11:43:16 +0200 (CEST)
X-Quarantine-ID: <O1GQZ7K0VGUs>
X-Secumail-id: <ae50.669e29b4.8950e.0>
From: ysionneau@kalrayinc.com
To: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jonathan Borne <jborne@kalrayinc.com>, Julian
 Vetter <jvetter@kalrayinc.com>, Yann Sionneau <ysionneau@kalrayinc.com>
Cc: Jules Maselbas <jmaselbas@zdiv.net>, devicetree@vger.kernel.org
Subject: [RFC PATCH v3 04/37] dt-bindings: Add binding for
 kalray,coolidge-apic-gic
Date: Mon, 22 Jul 2024 11:41:15 +0200
Message-ID: <20240722094226.21602-5-ysionneau@kalrayinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722094226.21602-1-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

From: Yann Sionneau <ysionneau@kalrayinc.com>

Add binding for Kalray Coolidge APIC GIC interrupt controller.

Co-developed-by: Jules Maselbas <jmaselbas@zdiv.net>
Signed-off-by: Jules Maselbas <jmaselbas@zdiv.net>
Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
---

Notes:

V2 -> V3: Fixed bindings to adhere to dt-schema
---
 .../kalray,coolidge-apic-gic.yaml             | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-apic-gic.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-apic-gic.yaml b/Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-apic-gic.yaml
new file mode 100644
index 0000000000000..02e25256c1c1d
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-apic-gic.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/kalray,coolidge-apic-gic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Kalray kv3-1 APIC-GIC
+
+maintainers:
+  - Jonathan Borne <jborne@kalrayinc.com>
+  - Julian Vetter <jvetter@kalrayinc.com>
+  - Yann Sionneau <ysionneau@kalrayinc.com>
+
+description: |
+  Each cluster in the Coolidge SoC includes an Advanced Programmable Interrupt
+  Controller (APIC) which is split in two part:
+    - a Generic Interrupt Controller (referred as APIC-GIC)
+    - a Mailbox Controller           (referred as APIC-Mailbox)
+  The APIC-GIC acts as an intermediary interrupt controller, muxing/routing
+  incoming interrupts to output interrupts connected to kvx cores interrupts lines.
+  The 139 possible input interrupt lines are organized as follow:
+     - 128 from the mailbox controller (one it per mailboxes)
+     - 1   from the NoC router
+     - 5   from IOMMUs
+     - 1   from L2 cache DMA job FIFO
+     - 1   from cluster watchdog
+     - 2   for SECC, DECC
+     - 1   from Data NoC
+  The 72 possible output interrupt lines:
+     -  68 : 4 interrupts per cores (17 cores)
+     -  1 for L2 cache controller
+     -  3 extra that are for padding
+
+properties:
+  compatible:
+    const: kalray,coolidge-apic-gic
+
+  reg:
+    maxItems: 1
+
+  "#interrupt-cells":
+    const: 1
+    description: The IRQ number.
+
+  interrupt-controller: true
+
+  interrupts-extended:
+    maxItems: 16
+    description: |
+     Specifies the interrupt line(s) in the interrupt-parent controller node;
+     valid values depend on the type of parent interrupt controller
+
+required:
+  - compatible
+  - reg
+  - "#interrupt-cells"
+  - interrupt-controller
+  - interrupts-extended
+
+additionalProperties: false
+
+examples:
+  - |
+    apic_gic: interrupt-controller@a20000 {
+        compatible = "kalray,coolidge-apic-gic";
+        reg = <0 0xa20000 0 0x12000>;
+        #interrupt-cells = <1>;
+        interrupt-controller;
+        interrupts-extended = <&core_intc0 0x4>,
+                              <&core_intc1 0x4>,
+                              <&core_intc2 0x4>,
+                              <&core_intc3 0x4>,
+                              <&core_intc4 0x4>,
+                              <&core_intc5 0x4>,
+                              <&core_intc6 0x4>,
+                              <&core_intc7 0x4>,
+                              <&core_intc8 0x4>,
+                              <&core_intc9 0x4>,
+                              <&core_intc10 0x4>,
+                              <&core_intc11 0x4>,
+                              <&core_intc12 0x4>,
+                              <&core_intc13 0x4>,
+                              <&core_intc14 0x4>,
+                              <&core_intc15 0x4>;
+    };
+
+...
-- 
2.45.2






