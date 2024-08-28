Return-Path: <linux-kernel+bounces-304644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDE496231F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C094C284B99
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3745165F16;
	Wed, 28 Aug 2024 09:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="iYkYYAJi"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D7E15C13D;
	Wed, 28 Aug 2024 09:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724836330; cv=none; b=JW4Hrn9EsvY7IGBZkp1Sb3meLaJ4XvhsArf9vQwJ3JmV5cjSpKKmzij7hvoczTI8xYMDM7SymyOuwdBizU2+0/g+nNqARxSbPSdcs5pj9phRdL/oqv7/9Tqwe+bnM/2nJZMX0ue3pMYLNAjTf010Y/Mm3hg0cNrGCWRvu5aLn+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724836330; c=relaxed/simple;
	bh=py7WNHFqaDklaOhQ2w8uzIN3xg2iCJk3lPybb5aymv0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sU553mwENFuSw7mo4t7zrdsLUYAs7a4BUuIxL1VxT2S/79PsxZbEcSvdVm5NYl9aRDmlOSwSj3vgPQjNrxTRUppKigfGlylTLO9fdCa0oIDCwGA7ScT5eJXcphIBP777kn3raHU3CFm7tjWrCzK1OTUy3AVVLHiD90bJ3oiJQ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=iYkYYAJi; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 0AEE98641C;
	Wed, 28 Aug 2024 11:11:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724836320;
	bh=0UHGu++TVhvGTMTBxR5QUaSiGMr14Fo9/b/MnkvehCw=;
	h=From:To:Cc:Subject:Date:From;
	b=iYkYYAJiAlVDAYl62o/UCurX/4PAOGL9wZbWxzwQKuzXnG9xVGcG482V0+zf2Jw+x
	 vvrQwskWuksK/5RQoAIJP+U683RR2mb81O7hlSGXd/FLQwUG6lrXYTOryU44k4sddd
	 Dq+BgGsfYIISfGxIXpWEdW9BH02RyeVvPs8Fv9q5oSEeMQcLaxMzEPV/3NupDnFD0I
	 AQW3AYjlcTT05nN8CsHMjhTfG8lVw7X6FyctSzqjdlgPN2K7HeJhUCqYCjX0rD58Wv
	 pf40rajqH2xEW/4mYz7ZemasLvMsSi0EWLE9zIFGD1xGD6OtwUDmNkfStBds2OFHcN
	 cA0xwguDoRvPw==
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
Subject: [PATCH v2] ASoC: dt-bindings: Convert mxs-saif.txt to fsl,saif.yaml (imx28 saif)
Date: Wed, 28 Aug 2024 11:11:39 +0200
Message-Id: <20240828091139.2621158-1-lukma@denx.de>
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
- Adds 'clocks' and '#sound-dai-cells' properties
- Provide device description

Signed-off-by: Lukasz Majewski <lukma@denx.de>

---
Changes for v2:
- Remove mxs-saif.txt
- Add description with information about extensions required for this
  device's current DTS description
---
 .../devicetree/bindings/sound/fsl,saif.yaml   | 78 +++++++++++++++++++
 .../devicetree/bindings/sound/mxs-saif.txt    | 41 ----------
 2 files changed, 78 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,saif.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/mxs-saif.txt

diff --git a/Documentation/devicetree/bindings/sound/fsl,saif.yaml b/Documentation/devicetree/bindings/sound/fsl,saif.yaml
new file mode 100644
index 000000000000..cc78a95e0391
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,saif.yaml
@@ -0,0 +1,78 @@
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


