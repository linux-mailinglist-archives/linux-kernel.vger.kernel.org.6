Return-Path: <linux-kernel+bounces-278961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC43D94B728
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16DDF1C231A0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DB9188016;
	Thu,  8 Aug 2024 07:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JfJJZbmR"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3D97464;
	Thu,  8 Aug 2024 07:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101108; cv=none; b=E8cyw0gahQ08DqshpkSuUQjpldiyLVWi9fZSPTnftbwBBo1GMHQpl5Ku0WJKGYbKaz2p3tA7VNHT6duPNdJzV5AKeZy9lBqZUz6z0jUts9PA4CqT9pOcjYhkxH8WLZf9qAjR5Iv5daDXTx6fLT0RIDfcaFk1sbXdzPLuK+9qXpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101108; c=relaxed/simple;
	bh=DXQXh8juWXfKiYFK7RX1CZ5vj5uxEUm7yMyCD4oTMFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eP5Kr0edYTQGgvzjoS0B9P/QxHrmzDc1CLqYRrXhvuH0y/TokTDSRtgf3AG5TVAaL31ukOGb97lKYV99RvJ+BhL+EeuxjQVqrtKPUuBdCF8UDPSSsNWUW9CeIhlxmQiDbL4tgJlrPJXQSAEN79AeOdYqJMjU8Dgcu6XmkoHx0Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JfJJZbmR; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 46F02C0013;
	Thu,  8 Aug 2024 07:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723101103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O51zc97GTHWxplwmFL6UetG7Pd9xJzEuVM/G68/5Omw=;
	b=JfJJZbmRF1XsdMo/57V4LJaVyayOuPQroTM0IscItx1UKyZnYREE+tBZSJBHpVd//qvXeK
	IbTrKaDw4P4PRrvXBMo0ZS/SCzCZcDSEyHyjB9DNxNQakS9ipx/8wQgPytKhDY14OBgL+f
	v22imp+Qn4o5YU4Ehu8RZW93XsGsocrDF4dia0PaAd5BEZjS95PJOtYRrBGXwXQBQN4Bg4
	n0jEVSuPf+gnimHd+te8sY1b9h9hGHyalyBhl7QhkaTAIkHWRq/Gwd+8zluqIjYfI+L7R0
	RdYHft7hQ4973ImNnKfHoMzeS8/c2r5tcLopwxBr2pg4r87Psgvc7U1lrO2tTQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Li Yang <leoyang.li@nxp.com>,
	Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 07/36] dt-bindings: soc: fsl: cpm_qe: Add QUICC Engine (QE) TSA controller
Date: Thu,  8 Aug 2024 09:11:00 +0200
Message-ID: <20240808071132.149251-8-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240808071132.149251-1-herve.codina@bootlin.com>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Add support for the time slot assigner (TSA) available in some
PowerQUICC SoC that uses a QUICC Engine (QE) block such as MPC8321.

This QE TSA is similar to the CPM TSA except that it uses UCCs (Unified
Communication Controllers) instead of SCCs (Serial Communication
Controllers). Also, compared against the CPM TSA, this QE TSA can handle
up to 4 TDMs instead of 2 and allows to configure the logic level of
sync signals.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../bindings/soc/fsl/cpm_qe/fsl,qe-tsa.yaml   | 210 ++++++++++++++++++
 include/dt-bindings/soc/qe-fsl,tsa.h          |  13 ++
 2 files changed, 223 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe-tsa.yaml
 create mode 100644 include/dt-bindings/soc/qe-fsl,tsa.h

diff --git a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe-tsa.yaml b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe-tsa.yaml
new file mode 100644
index 000000000000..3b50e0a003ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe-tsa.yaml
@@ -0,0 +1,210 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe-tsa.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PowerQUICC QE Time-slot assigner (TSA) controller
+
+maintainers:
+  - Herve Codina <herve.codina@bootlin.com>
+
+description:
+  The TSA is the time-slot assigner that can be found on some PowerQUICC SoC.
+  Its purpose is to route some TDM time-slots to other internal serial
+  controllers.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,mpc8321-tsa
+      - const: fsl,qe-tsa
+
+  reg:
+    items:
+      - description: SI (Serial Interface) register base
+      - description: SI RAM base
+
+  reg-names:
+    items:
+      - const: si_regs
+      - const: si_ram
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  '^tdm@[0-3]$':
+    description:
+      The TDM managed by this controller
+    type: object
+
+    additionalProperties: false
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 3
+        description:
+          The TDM number for this TDM, 0 for TDMa, 1 for TDMb, 2 for TDMc and 3
+          for TDMd.
+
+      fsl,common-rxtx-pins:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          The hardware can use four dedicated pins for Tx clock, Tx sync, Rx
+          clock and Rx sync or use only two pins, Tx/Rx clock and Tx/Rx sync.
+          Without the 'fsl,common-rxtx-pins' property, the four pins are used.
+          With the 'fsl,common-rxtx-pins' property, two pins are used.
+
+      clocks:
+        minItems: 2
+        items:
+          - description: Receive sync clock
+          - description: Receive data clock
+          - description: Transmit sync clock
+          - description: Transmit data clock
+
+      clock-names:
+        minItems: 2
+        items:
+          - const: rsync
+          - const: rclk
+          - const: tsync
+          - const: tclk
+
+      fsl,rx-frame-sync-delay-bits:
+        enum: [0, 1, 2, 3]
+        default: 0
+        description: |
+          Receive frame sync delay in number of bits.
+          Indicates the delay between the Rx sync and the first bit of the Rx
+          frame.
+
+      fsl,tx-frame-sync-delay-bits:
+        enum: [0, 1, 2, 3]
+        default: 0
+        description: |
+          Transmit frame sync delay in number of bits.
+          Indicates the delay between the Tx sync and the first bit of the Tx
+          frame.
+
+      fsl,clock-falling-edge:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          Data is sent on falling edge of the clock (and received on the rising
+          edge). If not present, data is sent on the rising edge (and received
+          on the falling edge).
+
+      fsl,fsync-rising-edge:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          Frame sync pulses are sampled with the rising edge of the channel
+          clock. If not present, pulses are sampled with the falling edge.
+
+      fsl,fsync-active-low:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          Frame sync signals are active on low logic level.
+          If not present, sync signals are active on high level.
+
+      fsl,double-speed-clock:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          The channel clock is twice the data rate.
+
+    patternProperties:
+      '^fsl,[rt]x-ts-routes$':
+        $ref: /schemas/types.yaml#/definitions/uint32-matrix
+        description: |
+          A list of tuple that indicates the Tx or Rx time-slots routes.
+        items:
+          items:
+            - description:
+                The number of time-slots
+              minimum: 1
+              maximum: 64
+            - description: |
+                The source (Tx) or destination (Rx) serial interface
+                (dt-bindings/soc/qe-fsl,tsa.h defines these values)
+                 - 0: No destination
+                 - 1: UCC1
+                 - 2: UCC2
+                 - 3: UCC3
+                 - 4: UCC4
+                 - 5: UCC5
+              enum: [0, 1, 2, 3, 4, 5]
+        minItems: 1
+        maxItems: 64
+
+    allOf:
+      # If fsl,common-rxtx-pins is present, only 2 clocks are needed.
+      # Else, the 4 clocks must be present.
+      - if:
+          required:
+            - fsl,common-rxtx-pins
+        then:
+          properties:
+            clocks:
+              maxItems: 2
+            clock-names:
+              maxItems: 2
+        else:
+          properties:
+            clocks:
+              minItems: 4
+            clock-names:
+              minItems: 4
+
+    required:
+      - reg
+      - clocks
+      - clock-names
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - '#address-cells'
+  - '#size-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/soc/qe-fsl,tsa.h>
+
+    tsa@ae0 {
+        compatible = "fsl,mpc8321-tsa", "fsl,qe-tsa";
+        reg = <0xae0 0x10>,
+              <0xc00 0x200>;
+        reg-names = "si_regs", "si_ram";
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        tdm@0 {
+            /* TDMa */
+            reg = <0>;
+
+            clocks = <&clk_l1rsynca>, <&clk_l1rclka>;
+            clock-names = "rsync", "rclk";
+
+            fsl,common-rxtx-pins;
+            fsl,fsync-rising-edge;
+
+            fsl,tx-ts-routes = <2 0>,             /* TS 0..1 */
+                           <24 FSL_QE_TSA_UCC4>, /* TS 2..25 */
+                           <1 0>,                 /* TS 26 */
+                           <5 FSL_QE_TSA_UCC3>;  /* TS 27..31 */
+
+            fsl,rx-ts-routes = <2 0>,             /* TS 0..1 */
+                           <24 FSL_QE_TSA_UCC4>, /* 2..25 */
+                           <1 0>,                 /* TS 26 */
+                           <5 FSL_QE_TSA_UCC3>;  /* TS 27..31 */
+        };
+    };
diff --git a/include/dt-bindings/soc/qe-fsl,tsa.h b/include/dt-bindings/soc/qe-fsl,tsa.h
new file mode 100644
index 000000000000..3cf3df9c0968
--- /dev/null
+++ b/include/dt-bindings/soc/qe-fsl,tsa.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+
+#ifndef __DT_BINDINGS_SOC_FSL_QE_TSA_H
+#define __DT_BINDINGS_SOC_FSL_QE_TSA_H
+
+#define FSL_QE_TSA_NU		0
+#define FSL_QE_TSA_UCC1		1
+#define FSL_QE_TSA_UCC2		2
+#define FSL_QE_TSA_UCC3		3
+#define FSL_QE_TSA_UCC4		4
+#define FSL_QE_TSA_UCC5		5
+
+#endif
-- 
2.45.0


