Return-Path: <linux-kernel+bounces-265921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3959593F7B9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B5F2824F5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629B0189F2A;
	Mon, 29 Jul 2024 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WZSnojx8"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3736718734F;
	Mon, 29 Jul 2024 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262895; cv=none; b=hkh2OPv1CI0LTpcGtvNj3/LRNka5PCe++TSzK/mi3MSJa6yOpDV8De4Wa4P7e40SD/fXkSSntrs1paXrHi7QfDsF4YnXNJ3U0oKBMsfo2Fvg1XKXXNsQHPonVESsGUBGK76xnXKVv/WJJudZ46o6B/yEOTBzGjkiPOPuNfjEVa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262895; c=relaxed/simple;
	bh=KMhlilya1WHJ33qn3N/5jdVny8PGquZEOpSmkS7iJ1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndwd4F4/9xABl5t05lEHifypOdC6eoKJygovE9CAOIGW5NpbAM4LlGTnR5BTl6lDT50vV+ZmO5Fz/XyLA8iLXrZoN7M82bcyLVkUEQKngEW06GZXtaZ6VU6Iwcujd7XRV63z7Zcf8wOwBBUdOEYCezdu9mleudIb50361raj83Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WZSnojx8; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 45A3F24000C;
	Mon, 29 Jul 2024 14:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722262891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D3DJjxgR5FbSnXWNbLxnghZpnQRvnh0vC8nm2pehkqk=;
	b=WZSnojx8uGO35BhNurHWS5/ukMSKVOfQRoSW9XVYXwLB03CyaxCokCaHkhU1bLp90Z7v9e
	+1dJnWDxLII26s/wnM/7AvPBOs+aQLm7Bpve6AydMWJ+2ECmJK4hB4VJWl/oTBbJ3S4ukm
	i5NIkfowIe+7mTXt8US7AOJ8hjdSvePjoeDaK0OxVeLiWBAnpiiOYo/0grxqdTo6lFlmUX
	tGER9vk4AcP+WJDqQWCHH92jQYS5Pn/JtIqyjNgo2uAyrYvIN3YeRxC4CZjSlm2zqKlRtg
	mLq3YgfnfgQcAbXrnEqZZsiGs1s9tRmc/ACk0di9hXJQR/j6s6MeR8o16WEvpA==
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
Subject: [PATCH v1 23/36] dt-bindings: soc: fsl: cpm_qe: Add QUICC Engine (QE) QMC controller
Date: Mon, 29 Jul 2024 16:20:52 +0200
Message-ID: <20240729142107.104574-24-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240729142107.104574-1-herve.codina@bootlin.com>
References: <20240729142107.104574-1-herve.codina@bootlin.com>
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
index 000000000000..1215b2de36e6
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
+      compatible:
+        items:
+          - enum:
+              - fsl,mpc8321-ucc-qmc-hdlc
+          - const: fsl,qe-ucc-qmc-hdlc
+          - const: fsl,qmc-hdlc
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


