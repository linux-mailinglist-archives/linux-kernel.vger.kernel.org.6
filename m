Return-Path: <linux-kernel+bounces-304663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91362962359
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F382282315
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AC6161319;
	Wed, 28 Aug 2024 09:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="BbcK92HA"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F06315B984;
	Wed, 28 Aug 2024 09:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724837252; cv=none; b=rR3z92eOPw372uIkPKDEaXZ4bvTpFWs/mZiwyHZj94pde22NNwf/5XWDoqeBsFlA8sPoc01rtRmRdPSV/ecyoOgZkRWnZDMbCYNTc0FhYoV44QfP9X7SLkOQTbZmJPtiEWicjvSHRl6IxRbkvKTh69bCUoo8tmoI8RevYs1JKmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724837252; c=relaxed/simple;
	bh=+Rvz5EaGm+L6IyML2zuzaNrMzSuWIwQyliAnBAaUF9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=avEQjoO+ATTs2/+EupFgf7EwVo6D4i/Ej9N6joa520dEYjvaNI6vJczWIq6CWobDFpj2+vgIPOjvvhM/xnPMchH853k8Dlwc96hu0RHNIR9byCOWnmh0P/GPoOBeFKNCPYgDSX58AltvU/AGEr2NeFTX3C77F89MIhjeQE1bX04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=BbcK92HA; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 3E54588A2E;
	Wed, 28 Aug 2024 11:27:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724837246;
	bh=n1u3Ic7vwN6fKl+FzrNZ8SQ4XiiF31v4bdtWFOtiqU8=;
	h=From:To:Cc:Subject:Date:From;
	b=BbcK92HAkY27iVFlzC7vIbNSz/z2Yjk0MetTfbKfghng6dXKqr/zqiF3egdBlMVtg
	 wufX3NmIPFY/oFQQxx2vqvlTLAkr6zma//E7sxE0DW8uTtGhhrhQSIQjysRo9ZEWMC
	 t2gpBCrKa/q8PGlE7a7VKROUPJjKQ6X19+9YPa+57BZGYWMYgQKnFQXBFbIW06RTg9
	 YZfCBmPgLD5ZHNIkeC1hGl5lTC3j5lXa0sfmzr+KRtq7yNmirmgvvsKnIykgJ5aENO
	 PR0SUFFlAaOwMKUrQQTM8E8A7lJqUx98Q4eGHUD5iCISJilcEngaXKFQNe8aT+BSL6
	 vvD+WUdJldo3A==
From: Lukasz Majewski <lukma@denx.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v3] ASoC: dt-bindings: Convert mxs-saif.txt to fsl,saif.yaml (imx28 saif)
Date: Wed, 28 Aug 2024 11:27:09 +0200
Message-Id: <20240828092709.2626359-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The 'fsl,imx28-saif' compatible has already the mxs-saif.txt description.
This patch converts (and removes it) this file to fsl,saif.yaml (to follow
current fsl convention).

Changes for the mxs-saif.txt:
- Adds 'clocks', '#clock-cells' and '#sound-dai-cells' properties
- Provide device description

Signed-off-by: Lukasz Majewski <lukma@denx.de>

---
Changes for v3:
- Add #clock-cells property

Changes for v2:
- Remove mxs-saif.txt
- Add description with information about extensions required for this
  device's current DTS description
---
 .../devicetree/bindings/sound/fsl,saif.yaml   | 83 +++++++++++++++++++
 .../devicetree/bindings/sound/mxs-saif.txt    | 41 ---------
 2 files changed, 83 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,saif.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/mxs-saif.txt

diff --git a/Documentation/devicetree/bindings/sound/fsl,saif.yaml b/Documentation/devicetree/bindings/sound/fsl,saif.yaml
new file mode 100644
index 000000000000..0b5db6bb1b7c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,saif.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/fsl,saif.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale MXS Serial Audio Interface (SAIF)
+
+maintainers:
+  - Lukasz Majewski <lukma@denx.de>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+description:
+  The SAIF is based on I2S module that is used to communicate with audio codecs,
+  but only with half-duplex manner (i.e. it can either transmit or receive PCM
+  audio).
+
+properties:
+  compatible:
+    const: fsl,imx28-saif
+
+  reg:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0
+
+  interrupts:
+    maxItems: 1
+
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    const: rx-tx
+
+  "#clock-cells":
+    description: Configure the I2S device as MCLK clock provider.
+    const: 0
+
+  clocks:
+    maxItems: 1
+
+  fsl,saif-master:
+    description: Indicate that saif is a slave and its phandle points to master
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+  - reg
+  - "#sound-dai-cells"
+  - interrupts
+  - dmas
+  - dma-names
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    saif0: saif@80042000 {
+        compatible = "fsl,imx28-saif";
+        reg = <0x80042000 2000>;
+        #sound-dai-cells = <0>;
+        interrupts = <59>;
+        dmas = <&dma_apbx 4>;
+        dma-names = "rx-tx";
+        #clock-cells = <0>;
+        clocks = <&clks 53>;
+    };
+  - |
+    saif1: saif@80046000 {
+        compatible = "fsl,imx28-saif";
+        reg = <0x80046000 2000>;
+        #sound-dai-cells = <0>;
+        interrupts = <58>;
+        dmas = <&dma_apbx 5>;
+        dma-names = "rx-tx";
+        clocks = <&clks 53>;
+        fsl,saif-master = <&saif0>;
+    };
diff --git a/Documentation/devicetree/bindings/sound/mxs-saif.txt b/Documentation/devicetree/bindings/sound/mxs-saif.txt
deleted file mode 100644
index 7ba07a118e37..000000000000
--- a/Documentation/devicetree/bindings/sound/mxs-saif.txt
+++ /dev/null
@@ -1,41 +0,0 @@
-* Freescale MXS Serial Audio Interface (SAIF)
-
-Required properties:
-- compatible: Should be "fsl,<chip>-saif"
-- reg: Should contain registers location and length
-- interrupts: Should contain ERROR interrupt number
-- dmas: DMA specifier, consisting of a phandle to DMA controller node
-  and SAIF DMA channel ID.
-  Refer to dma.txt and fsl-mxs-dma.txt for details.
-- dma-names: Must be "rx-tx".
-
-Optional properties:
-- fsl,saif-master: phandle to the master SAIF.  It's only required for
-  the slave SAIF.
-
-Note: Each SAIF controller should have an alias correctly numbered
-in "aliases" node.
-
-Example:
-
-aliases {
-	saif0 = &saif0;
-	saif1 = &saif1;
-};
-
-saif0: saif@80042000 {
-	compatible = "fsl,imx28-saif";
-	reg = <0x80042000 2000>;
-	interrupts = <59>;
-	dmas = <&dma_apbx 4>;
-	dma-names = "rx-tx";
-};
-
-saif1: saif@80046000 {
-	compatible = "fsl,imx28-saif";
-	reg = <0x80046000 2000>;
-	interrupts = <58>;
-	dmas = <&dma_apbx 5>;
-	dma-names = "rx-tx";
-	fsl,saif-master = <&saif0>;
-};
-- 
2.39.2


