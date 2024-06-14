Return-Path: <linux-kernel+bounces-215383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F569091C6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EF2728C56E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961F31B29CC;
	Fri, 14 Jun 2024 17:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mu2HR3Dw"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67F41B143F;
	Fri, 14 Jun 2024 17:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718386387; cv=none; b=Hd28vq/CTzJnJJUhGLhctyu7FOU1vamOZP+6HDrNuuLDVJ6yqpnieEsc5+Bp36g7BENyoP01t/dXrPx+41hSj2sdaMwIvgyziB1V3WKnv1dlCNYuhshsQ30JrhTvSOl4HDaV4dfb3vGjyPQLk1qTDC81dJEulxMPnKWPGTbk1XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718386387; c=relaxed/simple;
	bh=/RI6whJcmrvhiRO7t2XvDhnsZ9qXtW9I/fr2BpEIl5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdndIIPzkvFa2xUUSbkm8zDM31ppz76QIPAOgnq7Q46sQrnI0tbk5EVf4iSn6sHIt3qoeglItUOtmTe1iIuJnFt9kRnZgGVUXmIwijsjOQkjnOnHCzAdoU+gY3WNU+CQXUxjvLcU7LZKkFQFzsJwiLUxzv+EqDKb1ANTKwjOQyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mu2HR3Dw; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 69CB4FF814;
	Fri, 14 Jun 2024 17:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1poOcFigCzvNGw/WIJa8uOgiTHrPvQYSCIrCvjonocA=;
	b=mu2HR3Dw1aITM193U1cexzdtb8QKZ1a9PXL2MG0TOKyhwi6f3LpCeGx4rLg+ikykvEZ4ZL
	Ai+WTcy1wgQ/ZjwhBbRR8Qt3773gme4HCDzrlLejQDXlZ68xQzYN271k4qXHAfVfGn//ub
	ToNiozd/fv3C04ZAsWOXK4JYqDOqLkkLAur7fAZ1+rDqLVem3bRtxw3tfbJddf1PoIIm4Z
	mJDVmK1rlTjkdn3x7lxT2Ku72BcXS1ReAh0cyH5dQjOA0N/gar2lXB05dffSvLPnpLrRoS
	FyGIZGylTrDGDa6hMQfj1pQR847YhNRmdacYBGpihMiqmFngY2he87fXGncYhQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-um@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 21/23] dt-bindings: interrupt-controller: Add support for Microchip LAN966x OIC
Date: Fri, 14 Jun 2024 19:32:22 +0200
Message-ID: <20240614173232.1184015-22-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240614173232.1184015-1-herve.codina@bootlin.com>
References: <20240614173232.1184015-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

The Microchip LAN966x outband interrupt controller (OIC) maps the
internal interrupt sources of the LAN966x device to an external
interrupt.
When the LAN966x device is used as a PCI device, the external interrupt
is routed to the PCI interrupt.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../microchip,lan966x-oic.yaml                | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/microchip,lan966x-oic.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/microchip,lan966x-oic.yaml b/Documentation/devicetree/bindings/interrupt-controller/microchip,lan966x-oic.yaml
new file mode 100644
index 000000000000..b2adc7174177
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/microchip,lan966x-oic.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/microchip,lan966x-oic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip LAN966x outband interrupt controller
+
+maintainers:
+  - Herve Codina <herve.codina@bootlin.com>
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+description: |
+  The Microchip LAN966x outband interrupt controller (OIC) maps the internal
+  interrupt sources of the LAN966x device to an external interrupt.
+  When the LAN966x device is used as a PCI device, the external interrupt is
+  routed to the PCI interrupt.
+
+properties:
+  compatible:
+    const: microchip,lan966x-oic
+
+  '#interrupt-cells':
+    const: 2
+
+  interrupt-controller: true
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - '#interrupt-cells'
+  - interrupt-controller
+  - interrupts
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    interrupt-controller@e00c0120 {
+        compatible = "microchip,lan966x-oic";
+        reg = <0xe00c0120 0x190>;
+        #interrupt-cells = <2>;
+        interrupt-controller;
+        interrupts = <0>;
+        interrupt-parent = <&intc>;
+    };
+...
-- 
2.45.0


