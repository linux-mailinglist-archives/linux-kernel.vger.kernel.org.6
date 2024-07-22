Return-Path: <linux-kernel+bounces-258775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C280938C85
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A31441F24F07
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A198176249;
	Mon, 22 Jul 2024 09:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="M43fM3c9"
Received: from smtpout43.security-mail.net (smtpout43.security-mail.net [85.31.212.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B4516CD27
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.31.212.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641513; cv=none; b=eO1tilk+9BupcisSu+SEOOscrFJ2Kso0WIFkuEzBfG8MdpmrkOyOScThp8iJxOWFRVEfOVBR4xGWtqPjyRzm0dZd6wyg69vJ+MJbqYn3DcmJhQN/GX8D0ypKxM5NYFXaO6n2wfj0ki/tnlPxkPVpXyzhd/RpFGfZVXlrbrg3V6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641513; c=relaxed/simple;
	bh=I96rfEW8ScQ10PPJ++fzpMrvWRQP0sxu3gDqH2P0U8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R+EqaGuCJv2y8Fut/1D7mac7N6tcMJ7ubwF1mJiG4T+rHAzlPT7qdfWS9/cbIBGzXr1KuLOLPa7jeYR90RR8n+UzzfWs+B2gyDr1hwB8E+dnWr2rrATbEnREnvZKmOGH8YUG4I9sCIO67XS7hEXJqXwCcLS35wWdcBa0a0NVSB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=M43fM3c9; arc=none smtp.client-ip=85.31.212.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx303.security-mail.net [127.0.0.1])
	by fx303.security-mail.net (Postfix) with ESMTP id 035C730F013
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:43:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1721641398;
	bh=I96rfEW8ScQ10PPJ++fzpMrvWRQP0sxu3gDqH2P0U8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M43fM3c9YgLjTwko9c0KZjCFPiCmxBmk8Ipc25+cwBTOs2TSrxvdJzWk9KyDfu4W9
	 4DpyNn370BvQmKuv0/qCh9IiuASXC07QJfCH2nGo2ZQhR7pqAULaNY+LL7uuAWNDrr
	 jDV4CHwYJhgUKoPBubTygjgEiqXFzYELBvKVd7Vg=
Received: from fx303 (fx303.security-mail.net [127.0.0.1]) by
 fx303.security-mail.net (Postfix) with ESMTP id BFFC530EFB0; Mon, 22 Jul
 2024 11:43:17 +0200 (CEST)
Received: from srvsmtp.lin.mbt.kalray.eu (unknown [217.181.231.53]) by
 fx303.security-mail.net (Postfix) with ESMTPS id 0884030ED15; Mon, 22 Jul
 2024 11:43:17 +0200 (CEST)
Received: from junon.lan.kalrayinc.com (unknown [192.168.37.161]) by
 srvsmtp.lin.mbt.kalray.eu (Postfix) with ESMTPS id D236040317; Mon, 22 Jul
 2024 11:43:16 +0200 (CEST)
X-Quarantine-ID: <JgOEEzZdZjTS>
X-Secumail-id: <10d66.669e29b5.6079.0>
From: ysionneau@kalrayinc.com
To: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jonathan Borne <jborne@kalrayinc.com>, Julian
 Vetter <jvetter@kalrayinc.com>, Yann Sionneau <ysionneau@kalrayinc.com>
Cc: Jules Maselbas <jmaselbas@zdiv.net>, devicetree@vger.kernel.org
Subject: [RFC PATCH v3 05/37] dt-bindings: Add binding for
 kalray,coolidge-apic-mailbox
Date: Mon, 22 Jul 2024 11:41:16 +0200
Message-ID: <20240722094226.21602-6-ysionneau@kalrayinc.com>
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

Add binding for Kalray Coolidge APIC Mailbox interrupt-controller.

Co-developed-by: Jules Maselbas <jmaselbas@zdiv.net>
Signed-off-by: Jules Maselbas <jmaselbas@zdiv.net>
Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
---

Notes:

V2 -> V3: Fixed bindings to adhere to dt-schema
---
 .../kalray,coolidge-apic-mailbox.yaml         | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-apic-mailbox.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-apic-mailbox.yaml b/Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-apic-mailbox.yaml
new file mode 100644
index 0000000000000..334b816b80583
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-apic-mailbox.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/kalray,coolidge-apic-mailbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Kalray Coolidge APIC-Mailbox
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
+  The APIC-Mailbox contains 128 mailboxes of 8 bytes (size of a word),
+  this hardware block is basically a 1 KB of smart memory space.
+  Each mailbox can be independently configured with a trigger condition
+  and an input mode function.
+
+  Input mode are:
+   - write
+   - bitwise OR
+   - add
+
+  Interrupts are generated on a write when the mailbox content value
+  match the configured trigger condition.
+  Available conditions are:
+   - doorbell: always raise interruption on write
+   - match: when the mailbox's value equal the configured trigger value
+   - barrier: same as match but the mailbox's value is cleared on trigger
+   - threshold: when the mailbox's value is greater than, or equal to, the
+     configured trigger value
+
+  Since this hardware block generates IRQs based on writes to some memory
+  locations, it is both an interrupt controller and an MSI controller.
+
+properties:
+  compatible:
+    const: kalray,coolidge-apic-mailbox
+
+  reg:
+    maxItems: 1
+
+  "#interrupt-cells":
+    const: 0
+    description:
+      The IRQ number.
+
+  "#address-cells":
+    const: 0
+
+  interrupt-controller: true
+
+  interrupts:
+    maxItems: 128
+    minItems: 1
+    description: |
+     Specifies the interrupt line(s) in the interrupt-parent controller node;
+     valid values depend on the type of parent interrupt controller
+
+  msi-controller: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - "#interrupt-cells"
+  - "#address-cells"
+  - interrupt-controller
+  - interrupts
+  - msi-controller
+
+examples:
+  - |
+    apic_mailbox: interrupt-controller@a00000 {
+        compatible = "kalray,coolidge-apic-mailbox";
+        reg = <0 0xa00000 0 0x0f200>;
+        #interrupt-cells = <0>;
+        interrupt-controller;
+        interrupt-parent = <&apic_gic>;
+        interrupts = <0>, <1>, <2>, <3>, <4>, <5>, <6>, <7>, <8>, <9>;
+        msi-controller;
+    };
+
+...
-- 
2.45.2






