Return-Path: <linux-kernel+bounces-193499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8A18D2D14
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB2B1F27CE2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 06:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858241607AA;
	Wed, 29 May 2024 06:18:46 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3082415F403;
	Wed, 29 May 2024 06:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716963526; cv=none; b=Qu5r3l8cmBz5AHgeVUPmLDuZmfgmSZTyKSjhQ0Bxnj5OPpdJabopqBbR4ffsPaIpYZXTHYn2MUd7nKDItGgXoWI3eZczKjMLNIBDoqTfUeJt9NjIO+zY9h63x6USQP+6Qx1OgNTut3uxQG8Bd0iSC6bUWCvpSDSiurlvMaB/hCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716963526; c=relaxed/simple;
	bh=Oawm5VsMDX5Q/shtm5IIpqGKOBJ57pu5FT1YaKQD7fM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=GEEANfTPp60TriuoxMRfp/2odN6c/uGsuImmg2ZC44SQwFUzcFqMaK4JpIk0VviV5Te2ZBK1rzpsiNL2kMA1fDP3GpihfG5PmTPdiMra3q2OWPvFd/Nl5MRTKYPd1VgW3Qr8PFj0S86F3/WMYNJ3+aAlm8NHyTCDRDH7/HxPPWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AA2F820151F;
	Wed, 29 May 2024 08:18:36 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 22DFC201529;
	Wed, 29 May 2024 08:18:36 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2974B181D0E3;
	Wed, 29 May 2024 14:18:34 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: conor@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	frank.li@nxp.com,
	conor+dt@kernel.org
Cc: hongxing.zhu@nxp.com,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: [PATCH v7 1/2] dt-bindings: phy: Add i.MX8Q HSIO SerDes PHY binding
Date: Wed, 29 May 2024 14:02:44 +0800
Message-Id: <1716962565-2084-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1716962565-2084-1-git-send-email-hongxing.zhu@nxp.com>
References: <1716962565-2084-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add i.MX8QM and i.MX8QXP HSIO SerDes PHY binding.
Introduce one HSIO configuration 'fsl,hsio-cfg', which need be set at
initialization according to board design.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/phy/fsl,imx8qm-hsio.yaml         | 164 ++++++++++++++++++
 1 file changed, 164 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8qm-hsio.yaml

diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8qm-hsio.yaml b/Documentation/devicetree/bindings/phy/fsl,imx8qm-hsio.yaml
new file mode 100644
index 000000000000..147bbfd2cd5f
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/fsl,imx8qm-hsio.yaml
@@ -0,0 +1,164 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/fsl,imx8qm-hsio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX8QM SoC series High Speed IO(HSIO) SERDES PHY
+
+maintainers:
+  - Richard Zhu <hongxing.zhu@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8qm-hsio
+      - fsl,imx8qxp-hsio
+  reg:
+    items:
+      - description: Base address and length of the PHY block
+      - description: HSIO control and status registers(CSR) of the PHY
+      - description: HSIO CSR of the controller bound to the PHY
+      - description: HSIO CSR for MISC
+
+  reg-names:
+    items:
+      - const: reg
+      - const: phy
+      - const: ctrl
+      - const: misc
+
+  "#phy-cells":
+    const: 3
+    description:
+      The first defines lane index.
+      The second defines the type of the PHY refer to the include phy.h.
+      The third defines the controller index, indicated which controller
+      is bound to the lane.
+
+  clocks:
+    minItems: 5
+    maxItems: 14
+
+  clock-names:
+    minItems: 5
+    maxItems: 14
+
+  fsl,hsio-cfg:
+    description: |
+      Specifies the use case of the HSIO module in the hardware design.
+      Regarding the design of i.MX8QM HSIO subsystem, HSIO module can be
+      confiured as following three use cases.
+      +---------------------------------------+
+      |                  | i.MX8QM            |
+      |------------------|--------------------|
+      |                  | Lane0| Lane1| Lane2|
+      |------------------|------|------|------|
+      | pciea-x2-sata    | PCIEA| PCIEA| SATA |
+      |------------------|------|------|------|
+      | pciea-x2-pcieb   | PCIEA| PCIEA| PCIEB|
+      |------------------|------|------|------|
+      | pciea-pcieb-sata | PCIEA| PCIEB| SATA |
+      +---------------------------------------+
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [ pciea-x2-sata, pciea-x2-pcieb, pciea-pcieb-sata]
+    default: pciea-pcieb-sata
+
+  fsl,refclk-pad-mode:
+    description:
+      Specifies the mode of the refclk pad used. INPUT(PHY refclock is
+      provided externally via the refclk pad) or OUTPUT(PHY refclock is
+      derived from SoC internal source and provided on the refclk pad).
+      This property not exists means unused(PHY refclock is derived from
+      SoC internal source).
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [ input, output, unused ]
+    default: unused
+
+  power-domains:
+    minItems: 1
+    maxItems: 2
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - "#phy-cells"
+  - clocks
+  - clock-names
+  - fsl,hsio-cfg
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8qxp-hsio
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: pclk0
+            - const: apb_pclk0
+            - const: phy0_crr
+            - const: ctl0_crr
+            - const: misc_crr
+        power-domains:
+          maxItems: 1
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8qm-hsio
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: pclk0
+            - const: pclk1
+            - const: apb_pclk0
+            - const: apb_pclk1
+            - const: pclk2
+            - const: epcs_tx
+            - const: epcs_rx
+            - const: apb_pclk2
+            - const: phy0_crr
+            - const: phy1_crr
+            - const: ctl0_crr
+            - const: ctl1_crr
+            - const: ctl2_crr
+            - const: misc_crr
+        power-domains:
+          minItems: 2
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8-clock.h>
+    #include <dt-bindings/clock/imx8-lpcg.h>
+    #include <dt-bindings/firmware/imx/rsrc.h>
+    #include <dt-bindings/phy/phy-imx8-pcie.h>
+
+    phy@5f1a0000 {
+        compatible = "fsl,imx8qxp-hsio";
+        reg = <0x5f1a0000 0x10000>,
+              <0x5f120000 0x10000>,
+              <0x5f140000 0x10000>,
+              <0x5f160000 0x10000>;
+        reg-names = "reg", "phy", "ctrl", "misc";
+        clocks = <&phyx1_lpcg IMX_LPCG_CLK_0>,
+                 <&phyx1_lpcg IMX_LPCG_CLK_4>,
+                 <&phyx1_crr1_lpcg IMX_LPCG_CLK_4>,
+                 <&pcieb_crr3_lpcg IMX_LPCG_CLK_4>,
+                 <&misc_crr5_lpcg IMX_LPCG_CLK_4>;
+        clock-names = "pclk0", "apb_pclk0", "phy0_crr", "ctl0_crr", "misc_crr";
+        power-domains = <&pd IMX_SC_R_SERDES_1>;
+        #phy-cells = <3>;
+        fsl,hsio-cfg = "pciea-pcieb-sata";
+        fsl,refclk-pad-mode = "input";
+    };
+...
-- 
2.37.1


