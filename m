Return-Path: <linux-kernel+bounces-278984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C3694B75F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 462BEB21DF9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EE218E02E;
	Thu,  8 Aug 2024 07:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lUXHDuaG"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC46118C900;
	Thu,  8 Aug 2024 07:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101120; cv=none; b=hL8tr1MrwS+EHjWQjWJYUZsIzBhWNb3d4Ot2l66FWdNRnPaOaR9FPNs0ovN2P7NFruzNGnUpGOjMZK+Xd5chMQ099aak05EkSdSIFefMpvYeBQyyMLPXhygESTFiyFm0ojhYSW68bxWGocELEffld6qTuW4SIqSL2oCo7Bcb8XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101120; c=relaxed/simple;
	bh=c9afPepMkTuuDsJLMYEOq/oNIOKfM4XKxA4r3QHB7hI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUJiwu/MRhsmDcmbSqTQ6E0H2L5DTJNd5qBbUJVQtcYFyMchT8ao6hlfmPEMcuOWKnzWbGo5vbbe0LalZxHAf7l4lkog+CiRpr0nAd48B5OFwwg4zl06QdetpEUnmo+D3u+qszYiYWx+oNeGZTdI8O3EzuW0i+ZTtlfTAnJG5nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lUXHDuaG; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id B3346C0002;
	Thu,  8 Aug 2024 07:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723101116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uob6iqJ4dxQ2dTDfxhS5GBjrRmflXRU3RjyB9muRTTI=;
	b=lUXHDuaGqkEdrGC8FVeGG+KhA8Tn99WgeR6e0wWJi+Zcq4Iwhb18Y4Iar7RTnHcYcoPURC
	jnpKgLsmuXnTAlsuiTbovXFFCyqHU5WN7flCPo8mQN/w49hdHlEtXJYjdpdrrwnVbyAQpI
	FQjiOgc8XBYDVcX5RUsZA5vjM6/ijByLTPKshxQH4AMVTWKOacKE3jzJjojnowzJOesJkH
	sGzyrUPpMcukeoYelMmOd0ShepimJqn2P7GIXRaOTiVIuD2p1ER0ICncG7ab5WIxhGi3Pr
	9IoHlE5MeOcP5xJzJBQ8HdsyKUxFpTb0pEu/YMOgBz7J+8qJlYZEc7bPdgabJA==
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
Subject: [PATCH v2 23/36] dt-bindings: soc: fsl: cpm_qe: Add QUICC Engine (QE) QMC controller
Date: Thu,  8 Aug 2024 09:11:16 +0200
Message-ID: <20240808071132.149251-24-herve.codina@bootlin.com>
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

Add support for the QMC (QUICC Multichannel Controller) available in
some PowerQUICC SoC that uses a QUICC Engine (QE) block such as MPC8321.

This QE QMC is similar to the CPM QMC except that it uses UCCs (Unified
Communication Controllers) instead of SCCs (Serial Communication
Controllers). Also, compared against the CPM QMC, this QE QMC does not
use a fixed area for the UCC/SCC parameters area but it uses a dynamic
area allocated and provided to the hardware at runtime.
Last point, the QE QMC can use a firmware to have the QMC working in
'soft-qmc' mode.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../soc/fsl/cpm_qe/fsl,qe-ucc-qmc.yaml        | 197 ++++++++++++++++++
 1 file changed, 197 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe-ucc-qmc.yaml

diff --git a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe-ucc-qmc.yaml b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe-ucc-qmc.yaml
new file mode 100644
index 000000000000..71ae64cb8a4f
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe-ucc-qmc.yaml
@@ -0,0 +1,197 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe-ucc-qmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PowerQUICC QE QUICC Multichannel Controller (QMC)
+
+maintainers:
+  - Herve Codina <herve.codina@bootlin.com>
+
+description:
+  The QMC (QUICC Multichannel Controller) emulates up to 64 channels within one
+  serial controller using the same TDM physical interface routed from TSA.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,mpc8321-ucc-qmc
+      - const: fsl,qe-ucc-qmc
+
+  reg:
+    items:
+      - description: UCC (Unified communication controller) register base
+      - description: Dual port ram base
+
+  reg-names:
+    items:
+      - const: ucc_regs
+      - const: dpram
+
+  interrupts:
+    maxItems: 1
+    description: UCC interrupt line in the QE interrupt controller
+
+  fsl,tsa-serial:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to TSA node
+          - enum: [1, 2, 3, 4, 5]
+            description: |
+              TSA serial interface (dt-bindings/soc/qe-fsl,tsa.h defines these
+              values)
+               - 1: UCC1
+               - 2: UCC2
+               - 3: UCC3
+               - 4: UCC4
+               - 5: UCC5
+    description:
+      Should be a phandle/number pair. The phandle to TSA node and the TSA
+      serial interface to use.
+
+  fsl,soft-qmc:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Soft QMC firmware name to load. If this property is omitted, no firmware
+      are used.
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  '^channel@([0-9]|[1-5][0-9]|6[0-3])$':
+    description:
+      A channel managed by this controller
+    type: object
+    additionalProperties: false
+
+    properties:
+      compatible:
+        items:
+          - enum:
+              - fsl,mpc8321-ucc-qmc-hdlc
+          - const: fsl,qe-ucc-qmc-hdlc
+          - const: fsl,qmc-hdlc
+
+      reg:
+        minimum: 0
+        maximum: 63
+        description:
+          The channel number
+
+      fsl,operational-mode:
+        $ref: /schemas/types.yaml#/definitions/string
+        enum: [transparent, hdlc]
+        default: transparent
+        description: |
+          The channel operational mode
+            - hdlc: The channel handles HDLC frames
+            - transparent: The channel handles raw data without any processing
+
+      fsl,reverse-data:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          The bit order as seen on the channels is reversed,
+          transmitting/receiving the MSB of each octet first.
+          This flag is used only in 'transparent' mode.
+
+      fsl,tx-ts-mask:
+        $ref: /schemas/types.yaml#/definitions/uint64
+        description:
+          Channel assigned Tx time-slots within the Tx time-slots routed by the
+          TSA to this cell.
+
+      fsl,rx-ts-mask:
+        $ref: /schemas/types.yaml#/definitions/uint64
+        description:
+          Channel assigned Rx time-slots within the Rx time-slots routed by the
+          TSA to this cell.
+
+      fsl,framer:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description:
+          phandle to the framer node. The framer is in charge of an E1/T1 line
+          interface connected to the TDM bus. It can be used to get the E1/T1 line
+          status such as link up/down.
+
+    allOf:
+      - if:
+          properties:
+            compatible:
+              not:
+                contains:
+                  const: fsl,qmc-hdlc
+        then:
+          properties:
+            fsl,framer: false
+
+    required:
+      - reg
+      - fsl,tx-ts-mask
+      - fsl,rx-ts-mask
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - fsl,tsa-serial
+  - '#address-cells'
+  - '#size-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/soc/qe-fsl,tsa.h>
+
+    qmc@a60 {
+        compatible = "fsl,mpc8321-ucc-qmc", "fsl,qe-ucc-qmc";
+        reg = <0x3200 0x200>,
+              <0x10000 0x1000>;
+        reg-names = "ucc_regs", "dpram";
+        interrupts = <35>;
+        interrupt-parent = <&qeic>;
+        fsl,soft-qmc = "fsl_qe_ucode_qmc_8321_11.bin";
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        fsl,tsa-serial = <&tsa FSL_QE_TSA_UCC4>;
+
+        channel@16 {
+            /* Ch16 : First 4 even TS from all routed from TSA */
+            reg = <16>;
+            fsl,operational-mode = "transparent";
+            fsl,reverse-data;
+            fsl,tx-ts-mask = <0x00000000 0x000000aa>;
+            fsl,rx-ts-mask = <0x00000000 0x000000aa>;
+        };
+
+        channel@17 {
+            /* Ch17 : First 4 odd TS from all routed from TSA */
+            reg = <17>;
+            fsl,operational-mode = "transparent";
+            fsl,reverse-data;
+            fsl,tx-ts-mask = <0x00000000 0x00000055>;
+            fsl,rx-ts-mask = <0x00000000 0x00000055>;
+        };
+
+        channel@19 {
+            /* Ch19 : 8 TS (TS 8..15) from all routed from TSA */
+            compatible = "fsl,mpc8321-ucc-qmc-hdlc",
+                         "fsl,qe-ucc-qmc-hdlc",
+                         "fsl,qmc-hdlc";
+            reg = <19>;
+            fsl,operational-mode = "hdlc";
+            fsl,tx-ts-mask = <0x00000000 0x0000ff00>;
+            fsl,rx-ts-mask = <0x00000000 0x0000ff00>;
+            fsl,framer = <&framer>;
+        };
+    };
-- 
2.45.0


