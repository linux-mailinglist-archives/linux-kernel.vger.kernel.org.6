Return-Path: <linux-kernel+bounces-306675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E549641FC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13EFAB256F9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A294218E36A;
	Thu, 29 Aug 2024 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="hb27Kn4d"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2C818F2EF;
	Thu, 29 Aug 2024 10:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724927207; cv=none; b=s51RJbDRJPG4rZ/k8tIQqmJRWs3HExv/e1+vAI0DrUGLDTN3WRpwkBmuYJTdWiKgOBcVWG5OMOZdOk+u0TJE04WvDtU2JQNpN0uMqXnOTmZHQAoAvhgzA4C6JVvDlyKgjdkkgqkZ0SrllqOIyZjpuvlDVR+TVVwOUQxb8FPn8Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724927207; c=relaxed/simple;
	bh=XqwKKVwXVCVwYDxJa99igQyUTTFSAF8ushvNwAihGgM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CPft3lgc7fYt9DN5aNyuFkZzOC6JJmxixeJPNZZW/5U4zkzPyCE1tLAejCJ1pNkEWqpMiWvwhcAGe3pwEYLx1HD6+2RxD32R4AIkzlB1dUpuU8/glXDP+YqMVOuxI5VJM1wW5S2y+jaldLOtI7ZFHjhbtLT572lY8+MIUmZ1/q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=hb27Kn4d; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 0D4FA88A99;
	Thu, 29 Aug 2024 12:26:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724927203;
	bh=wJQPagtdUNlpPJvsfeaRTfYdfhIfa8rXrCNWOietuUw=;
	h=From:To:Cc:Subject:Date:From;
	b=hb27Kn4dpKKFb0kWrFejnQDmo3fZHro//k8aKdCLNkno+KAhU41jRpAWQhyMVI6Xz
	 5T5N+BmG3nyzZjFZWWOCbZ9bsuXhwiIMl7e9sGlEAyCzFgbpO0YXr52YaOOLmcgKkc
	 lQCv75QGo8JrfpShbjLceRIPhTnDwJaOy2Iji3tIoQREZPW3mc/lKdL2r4M01/mG9N
	 z/oHEYJUm6BtgZJfrHAvjsahCiovUpfIa/EVyG4oIP/pHgSIi6ZrTpTO5GZPj8Vuia
	 1pNpEr3o7kIk0r+mx9kM4BJswWvjEX6B+LeCin7bTMVc9fTe1sK0CvnjahacjE6zNr
	 sCr2G6EmpGGBg==
From: Lukasz Majewski <lukma@denx.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	linux-sound@vger.kernel.org
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v4] ASoC: dt-bindings: Convert mxs-saif.txt to fsl,imx28-saif.yaml (imx28 saif)
Date: Thu, 29 Aug 2024 12:26:25 +0200
Message-Id: <20240829102625.3128645-1-lukma@denx.de>
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
This patch converts (and removes it) this file to fsl,imx28-saif.yaml.

Changes for the mxs-saif.txt:
- Adds 'clocks', '#clock-cells' and '#sound-dai-cells' properties
- Provide device description

Signed-off-by: Lukasz Majewski <lukma@denx.de>

---
Changes for v4:
- Change file name to match compatible (fsl,imx28-saif.yaml)
- Remove 'saif0' and 'saif1' labels as those are not needed in the
  example node

Changes for v3:
- Add #clock-cells property

Changes for v2:
- Remove mxs-saif.txt
- Add description with information about extensions required for this
  device's current DTS description
---
 .../bindings/sound/fsl,imx28-saif.yaml        | 82 +++++++++++++++++++
 .../devicetree/bindings/sound/mxs-saif.txt    | 41 ----------
 2 files changed, 82 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,imx28-saif.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/mxs-saif.txt

diff --git a/Documentation/devicetree/bindings/sound/fsl,imx28-saif.yaml b/Documentation/devicetree/bindings/sound/fsl,imx28-saif.yaml
new file mode 100644
index 000000000000..b2c73a9b7a55
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,imx28-saif.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/fsl,imx28-saif.yaml#
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
+    saif@80042000 {
+        compatible = "fsl,imx28-saif";
+        reg = <0x80042000 2000>;
+        #sound-dai-cells = <0>;
+        interrupts = <59>;
+        dmas = <&dma_apbx 4>;
+        dma-names = "rx-tx";
+        #clock-cells = <0>;
+        clocks = <&clks 53>;
+    };
+    saif@80046000 {
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


