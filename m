Return-Path: <linux-kernel+bounces-258763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B795938C74
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01AC01F23E06
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D798172BDA;
	Mon, 22 Jul 2024 09:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="P2opam/0"
Received: from smtpout42.security-mail.net (smtpout42.security-mail.net [85.31.212.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B4C16C871
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.31.212.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641505; cv=none; b=gvz9Ms4geW0z4lqQgYAKcAx5ViMyV1O+l+7bnlFif0gAoT0GADqkjfxs3j99d+B/AcN0VImBOY9ZvT9OgATHDvzpVbCKaPKQEaNLzV4REBWuBdhFy6drEYGOMu0OH2aFniroflb1yLwXywA883oFNNcLdsun2QI+LuOnqchnTOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641505; c=relaxed/simple;
	bh=7jQH1IAsbXXXmxjL2scAVo9a1/FDM4Dwc1U0HJ1/ZqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=en6ezxtCo53xyYfKWECedKrK64xh3cutludpU/yCuEaj4O1lthWah9qBRme4SoGoTegoAkeKJLBQrE1kb5xusfglW2U99nbRxwmC8NnyJ7chOrMu97D0tvhL+UQdTBSl8kfwyBVfwlgP25IdUtN4NoWz/ap5b0ROEBTxlmb7ZWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=P2opam/0; arc=none smtp.client-ip=85.31.212.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx302.security-mail.net (Postfix) with ESMTP id 9EC9580B0C2
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:43:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1721641398;
	bh=7jQH1IAsbXXXmxjL2scAVo9a1/FDM4Dwc1U0HJ1/ZqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P2opam/0AOzVqFW6nbUXtEYgCtfR34dcTiI/d2j9gnoQDoMlWNjiip/PiBacmYjNX
	 SZWBuygmxbg2sdYwAT7mORGALdGfYFWjaYX54E84FCMi1+lAVgF+XBXeUyefIH92b+
	 n3s9BQtAkossWcAOxD0C4r1lmbF/XKVgZuSPE3VQ=
Received: from fx302 (localhost [127.0.0.1]) by fx302.security-mail.net
 (Postfix) with ESMTP id 7575F80AA51; Mon, 22 Jul 2024 11:43:18 +0200 (CEST)
Received: from srvsmtp.lin.mbt.kalray.eu (unknown [217.181.231.53]) by
 fx302.security-mail.net (Postfix) with ESMTPS id EB2A480AD43; Mon, 22 Jul
 2024 11:43:17 +0200 (CEST)
Received: from junon.lan.kalrayinc.com (unknown [192.168.37.161]) by
 srvsmtp.lin.mbt.kalray.eu (Postfix) with ESMTPS id BDE1F40317; Mon, 22 Jul
 2024 11:43:17 +0200 (CEST)
X-Quarantine-ID: <J_47Xn6ko2Vh>
X-Secumail-id: <a646.669e29b5.e91e9.0>
From: ysionneau@kalrayinc.com
To: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jonathan Borne <jborne@kalrayinc.com>, Julian
 Vetter <jvetter@kalrayinc.com>, Yann Sionneau <ysionneau@kalrayinc.com>
Cc: Jules Maselbas <jmaselbas@zdiv.net>, devicetree@vger.kernel.org
Subject: [RFC PATCH v3 07/37] dt-bindings: Add binding for
 kalray,coolidge-ipi-ctrl
Date: Mon, 22 Jul 2024 11:41:18 +0200
Message-ID: <20240722094226.21602-8-ysionneau@kalrayinc.com>
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

Add binding for Kalray Coolidge IPI controller.

Co-developed-by: Jules Maselbas <jmaselbas@zdiv.net>
Signed-off-by: Jules Maselbas <jmaselbas@zdiv.net>
Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
---

Notes:

V2 -> V3:
- fixed bindings to adhere to dt-schema
- moved to interrupt-controller directory, like the related driver
---
 .../kalray,coolidge-ipi-ctrl.yaml             | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-ipi-ctrl.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-ipi-ctrl.yaml b/Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-ipi-ctrl.yaml
new file mode 100644
index 0000000000000..91e3afe4f1ca5
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-ipi-ctrl.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/kalray,coolidge-ipi-ctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Kalray Coolidge SoC Inter-Processor Interrupt Controller (IPI)
+
+maintainers:
+  - Jonathan Borne <jborne@kalrayinc.com>
+  - Julian Vetter <jvetter@kalrayinc.com>
+  - Yann Sionneau <ysionneau@kalrayinc.com>
+
+description: |
+  The Inter-Processor Interrupt Controller (IPI) provides a fast synchronization
+  mechanism to the software. It exposes eight independent set of registers that
+  can be use to notify each processor in the cluster.
+  A set of registers contains two 32-bit registers:
+    - 17-bit interrupt control, one bit per core, raise an interrupt on write
+    - 17-bit mask, one per core, to enable interrupts
+
+  Bit at offsets 0 to 15 selects cores in the cluster, respectively PE0 to PE15,
+  while bit at offset 16 is for the cluster Resource Manager (RM) core.
+
+  The eight output interrupts are connected to each processor core interrupt
+  controller (intc).
+
+properties:
+  compatible:
+    const: kalray,coolidge-ipi-ctrl
+
+  reg:
+    maxItems: 1
+
+  interrupts-extended:
+    maxItems: 16
+    description: |
+      Specifies the interrupt line the IPI controller will raise on the core INTC.
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 0
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts-extended
+  - interrupt-controller
+  - '#interrupt-cells'
+
+examples:
+  - |
+    ipi: inter-processor-interrupt@ad0000 {
+        compatible = "kalray,coolidge-ipi-ctrl";
+        reg = <0x00 0xad0000 0x00 0x1000>;
+        #interrupt-cells = <0>;
+        interrupt-controller;
+        interrupts-extended = <&core_intc0 24>,
+                              <&core_intc1 24>,
+                              <&core_intc2 24>,
+                              <&core_intc3 24>,
+                              <&core_intc4 24>,
+                              <&core_intc5 24>,
+                              <&core_intc6 24>,
+                              <&core_intc7 24>,
+                              <&core_intc8 24>,
+                              <&core_intc9 24>,
+                              <&core_intc10 24>,
+                              <&core_intc11 24>,
+                              <&core_intc12 24>,
+                              <&core_intc13 24>,
+                              <&core_intc14 24>,
+                              <&core_intc15 24>;
+    };
+
+...
-- 
2.45.2






