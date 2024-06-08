Return-Path: <linux-kernel+bounces-207003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9832901134
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 11:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B631B1C20FEC
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 09:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E629177982;
	Sat,  8 Jun 2024 09:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3dg9TFH"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAEE12BE91;
	Sat,  8 Jun 2024 09:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717840403; cv=none; b=iFx9NFGDO5cQRgFS/2LIeCyXOE8x/scYEVPwJxNiU34w160FomjjyWi1zlSLB1y4BNN3XpJrF0x+HT+muDtZltY/7qSZd83CKR6iFXIqE9LCyWEsnnTJc9k8CIu51zMFgbeYmQgCtSp03k2irTfx8ERx+8oj3JKw0w0Hoex6iKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717840403; c=relaxed/simple;
	bh=ICnH9E1Vy2cQKqPrA1Ck3aDm8zat1w0IaApwCIiylXY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ayBAgxGuQxjfQFwz7qXaEjY5Or6fdiVxGAaTb2mkk6EL1V+UDnGJzswNPLVs35jaFDy7g8eEeusPT7U0IwdnFNJMhrMl7QaatDPRN4uDzxqLYdcnPR2JdbGMV0D1oqlhWntkkBGE/c5XVr+02eg4yhJTPOVOMtNK5kaBKXeVpHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3dg9TFH; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f692d6e990so28451665ad.3;
        Sat, 08 Jun 2024 02:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717840401; x=1718445201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cvD3ncXaEoCBCf40kRzJQGFe4ot3LxPDiKmhU0HzD1I=;
        b=Z3dg9TFHkAe3S+quRkOcFHSGD2Y9dLKw29r23gFVU/uVKPEqZpjGwevBY5cBAC7062
         mVdrywndwAEaUj3Lpv/yGIgEUSqaX5Gf4B00eDyV1aSsxLg0vz9nBcXh7tKvNVopcwef
         b2iGAvHT7wyoGiGinhra/2xgq5nE86zizx8nJ8hTFUgpwHDrmTmvrzPF9KAjvqz4hMhu
         75Z4VkYVO+pyLcVAQ1+3DWFrX/f0ok8urjiqBSXukq5mIb2YeyDHUvocIGAV2YxQ1F9H
         kNjGLtHejNlH2lP2rpEb1x/xBeSK5I+dtpdMU06s+59RdsrfFDkzvDnb8i3HZLyQRl4y
         R1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717840401; x=1718445201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cvD3ncXaEoCBCf40kRzJQGFe4ot3LxPDiKmhU0HzD1I=;
        b=JaaUw6GDoJwLoQKjS/VnhNVtULUV4MYrKNdFU1LbgoqxGYz7slJaVXAbkhk7grNmIS
         m+2UqNSaqsKMsXv1Y4x51YYhWBESK19I2qZEZQkfQ1G6dtaNSu4TlEPfNztILiED8ygK
         m0m7UiBGfQtIj105vkKxSAveK2Mlk0T3U586qgQQ2EVrhVqS4JWxl49k0RKOB+blM74t
         I3CZW7eitUAYr59m6EAF+VF3Pye5rnN+JpsF1BD2ypbqomYEAh9jGQ/laqgDvYW7V90u
         GsjQcsrO4LK64FbgFaOcUD/ffp4kfIQRztTl19b5/KOqfZy2zy8EgqzSS1ZAJkoK5twd
         Z4Ug==
X-Forwarded-Encrypted: i=1; AJvYcCWyoW+VQWKnySCPIf0Agie8qLMz8juC3Z+iCWIccm3PxIQ21UPX7wF0YmoORzrQXHawQdef6R5myDeDQwJZbzbHc9TAVBWTCA0vUEyGjMchfGqAKrYYFg0yJVbFS8JZIqgQyCfmg0DOxUNy/AfvuXJS91IrxHdc2FfnagK/0ezVVyBoHC84
X-Gm-Message-State: AOJu0YzeqN7uChCAPC0Dh3dx6jKdYUOBel/7s+3dsZ9t0moK1otq5LSH
	u1mMuRMr6HLtgmsaTpffOxgfOTB+tL1NPAmLTQnzo3BEKHCGToYpu4J6pNkG
X-Google-Smtp-Source: AGHT+IFhV3NOoaW40VGlv2M13vMd5k4gK++hhzBbIbUAJ59ZDFJqeEc6+RaYccabHAi5XzkCHu6nag==
X-Received: by 2002:a17:903:22cd:b0:1f4:9158:6b9 with SMTP id d9443c01a7336-1f6d0377274mr57753685ad.47.1717840400852;
        Sat, 08 Jun 2024 02:53:20 -0700 (PDT)
Received: from localhost.localdomain ([152.58.55.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd76ca92sm48075475ad.78.2024.06.08.02.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 02:53:20 -0700 (PDT)
From: Mighty <bavishimithil@gmail.com>
To: 
Cc: peter.ujfalusi@gmail.com,
	Mithil Bavishi <bavishimithil@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lopez Cruz <misael.lopez@ti.com>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7] ASoC: dt-bindings: omap-mcpdm: Convert to DT schema
Date: Sat,  8 Jun 2024 15:23:02 +0530
Message-Id: <20240608095305.2887-1-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mithil Bavishi <bavishimithil@gmail.com>

Convert the OMAP4+ McPDM bindings from txt to yaml (dtschema).
Drop ti,hwmods property as it is not needed since the sysc conversion.
Add dma, dma-names, reg-names properties to match the DTS so as to not
break the already existing ABI.
Also update example node to match the existing node in the DTS.

Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
---
Changelog v7:
- Mention the changes in commit message
- Add entire changelog

Changelog v6:
- Add dma property
- Add dma-names property
- Add reg-names property
- Remove ti,hwmods completely (no longer needed since the sysc
  conversion)
- Update example to match one in DTS

Changelog v5:
- Add imports for constants
- Add desc to ti,hwmods

Changelog v4:
- Changed maintainer name
- Use $ref and enum in ti-hwmods property
- Make clocks property only have maxItems, no description
- Add items to clock-names
- Fix address of node in example
- Remove extra line

Changelog v3:
- Add subject prefix in commit message
- Use correct name in Signed-off
- Change filename to match compatible
- Use generic node name

Changelog v2:
- Use maxItems for interrupts and ti,hwmods
- Change example node address

 .../devicetree/bindings/sound/omap-mcpdm.txt  | 30 --------
 .../bindings/sound/ti,omap4-mcpdm.yaml        | 73 +++++++++++++++++++
 2 files changed, 73 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/omap-mcpdm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml

diff --git a/Documentation/devicetree/bindings/sound/omap-mcpdm.txt b/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
deleted file mode 100644
index ff98a0cb5..000000000
--- a/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-* Texas Instruments OMAP4+ McPDM
-
-Required properties:
-- compatible: "ti,omap4-mcpdm"
-- reg: Register location and size as an array:
-       <MPU access base address, size>,
-       <L3 interconnect address, size>;
-- interrupts: Interrupt number for McPDM
-- ti,hwmods: Name of the hwmod associated to the McPDM
-- clocks:  phandle for the pdmclk provider, likely <&twl6040>
-- clock-names: Must be "pdmclk"
-
-Example:
-
-mcpdm: mcpdm@40132000 {
-	compatible = "ti,omap4-mcpdm";
-	reg = <0x40132000 0x7f>, /* MPU private access */
-	      <0x49032000 0x7f>; /* L3 Interconnect */
-	interrupts = <0 112 0x4>;
-	interrupt-parent = <&gic>;
-	ti,hwmods = "mcpdm";
-};
-
-In board DTS file the pdmclk needs to be added:
-
-&mcpdm {
-	clocks = <&twl6040>;
-	clock-names = "pdmclk";
-	status = "okay";
-};
diff --git a/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml b/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml
new file mode 100644
index 000000000..cdea0a008
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/ti,omap4-mcpdm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: OMAP McPDM
+
+maintainers:
+  - Misael Lopez Cruz <misael.lopez@ti.com>
+
+description:
+  OMAP ALSA SoC DAI driver using McPDM port used by TWL6040
+
+properties:
+  compatible:
+    const: ti,omap4-mcpdm
+
+  reg:
+    items:
+      - description: MPU access base address
+      - description: L3 interconnect address
+
+  reg-names:
+    items:
+      - const: mpu
+      - const: dma
+
+  interrupts:
+    maxItems: 1
+
+  dmas:
+    maxItems: 2
+
+  dma-names:
+    items:
+      - const: up_link
+      - const: dn_link
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: pdmclk
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - dmas
+  - dma-names
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    mcpdm@0 {
+      compatible = "ti,omap4-mcpdm";
+      reg = <0x0 0x7f>, /* MPU private access */
+            <0x49032000 0x7f>; /* L3 Interconnect */
+      reg-names = "mpu", "dma";
+      interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-parent = <&gic>;
+      dmas = <&sdma 65>, <&sdma 66>;
+      dma-names = "up_link", "dn_link";
+      clocks = <&twl6040>;
+      clock-names = "pdmclk";
+    };
-- 
2.34.1


