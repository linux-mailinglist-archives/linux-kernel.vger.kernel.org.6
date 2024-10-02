Return-Path: <linux-kernel+bounces-347206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 710F098CF70
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9D3FB20B88
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F43F1990D2;
	Wed,  2 Oct 2024 09:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Og5QQfy9"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DD6198E81;
	Wed,  2 Oct 2024 09:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727859729; cv=none; b=Zxxx07CGsg4R3e50/upXABNO+TBvi04d6yWs7lPNQZcAQ2eHpFU7GP/elu0V3E+q+0w2JFo3Whx3bfnybS0VYkIPfQUnM6KSyYDNezzzgHAH6q9ONSae4wJJccUPc6jljJD277TWDtXg/dO78B/omRkbUyDShJdcuZqNNoKW0L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727859729; c=relaxed/simple;
	bh=NjBT3edl4GBWG4GA46iRK5fKaNXJFEz7AQjfmoGasas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lNTWfoKqHYnWHCVHZPLoN3JB/UcPeni78oSZyH2COytjwASmzv9lUJkHXubNTu2XyAKxUTxpJFq2Sk/lNkQjOdTydqAXlSWUSlr4RQX7GLo5FrLOq+BaZ2KDEbNgqeIKeyPj6Bg61sBPlvFrhPxoWaFx1Prh8NySbZ4tPhcbux4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Og5QQfy9; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5398b589032so6383030e87.1;
        Wed, 02 Oct 2024 02:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727859725; x=1728464525; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0W9IWK1hFhE7595MueUJkl9Ltu1+7FGQoJdkHWcX+as=;
        b=Og5QQfy9alMFWf8kvuomoep/nEbpXUZpHhpEzva7L/uze1njUZOE0vHxio1HGUsGQI
         8oc0MGxzkqXFxCksc5UVRMpJSynzDkaQc5NumvDkbHGi5+vmaNgjSKR2765DFgayQd9Q
         9gKQsKKJsWxY/CYEnCElp7rblURVb2U2R0D1JW+FdR0mqxvB8+Fsh+/R/Ax5K7lk3QF3
         S6cCIq0zrGhzLb7oRt3dLqK503Eg5FnDMRUCQyYCx6vF/sYrPPDoR8Bc/H88Luzv0Z2y
         /xYLiN5uWQzrRosCBrV+uy5n/CFo5TkYnpu6vMlNznxCRnM0VSsFkvBHkszYDdjFdEvx
         +2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727859725; x=1728464525;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0W9IWK1hFhE7595MueUJkl9Ltu1+7FGQoJdkHWcX+as=;
        b=wkkBChvRhKi8s1tsTvvQ9IVQo/ORoTodv7ropVgsp02dPJ47QhgDXdMCisezN4gNA9
         k7M8yvVrIHEkdGKj034DcMGFDh4O8AMKieRyjS5c6IP/yropxuxht+woXI4cmBNRQi4s
         RLT23F+iuiGifOucnA63unNGZPA7yuJQHu5aj1y1AwrRZL55dRat2+dWt/LeZBwfZuvo
         VVYRsZiBwpIlXwFJfzcJ1TDvUaxg5w9HokUz90Qp5jEEzFUZJsIRl3XN6ibay5/hQV86
         RhldD9/edggkwwumaZuzKAnCXg9HPAx2LOaROTvg3LNif0dfFD8oP09+nPofOzlngTBO
         R9zA==
X-Forwarded-Encrypted: i=1; AJvYcCUEQOM01Ns31OE7xQDLoJVndeeXB8lDSriuKOSdC7VQ7usqO3g+s+ED45oa7wOdZHPMONT4FUDuXDq8@vger.kernel.org, AJvYcCV3riTrSXZxl/gUJQiIXFzyAJ7ygucHkwEMPwnyYeufkdIGpYJ7JxOJfs287aGLE0Knehg+UWVTxAEvuuX+@vger.kernel.org
X-Gm-Message-State: AOJu0YwbtOEuD34KTaR75GhL3lm+rPhgKyeoNkeenjjkTBrbUg52tTRM
	YjZ5kj38+QhR/JmuIwut6tHdCySPKOnYovPLcrnkwt4oKI5jvIbl4v9ZMp89
X-Google-Smtp-Source: AGHT+IGcV5KpeOcgN8/kjZlE0lhZfvPGF++8Hbi8pKNboO677OXndylEDWuwiEb3joxc2+m0sD8t8w==
X-Received: by 2002:a05:6512:3083:b0:539:9510:2b8a with SMTP id 2adb3069b0e04-539a07a6332mr2051881e87.53.1727859724785;
        Wed, 02 Oct 2024 02:02:04 -0700 (PDT)
Received: from [192.168.1.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5389fd5e35asm1846796e87.85.2024.10.02.02.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 02:02:03 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 02 Oct 2024 11:01:31 +0200
Subject: [PATCH v2 2/2] dt-bindings: mtd: davinci: convert to yaml
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241002-ondie-v2-2-318156d8c7b4@gmail.com>
References: <20241002-ondie-v2-0-318156d8c7b4@gmail.com>
In-Reply-To: <20241002-ondie-v2-0-318156d8c7b4@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6866;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=NjBT3edl4GBWG4GA46iRK5fKaNXJFEz7AQjfmoGasas=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBm/QwAT6dxieHqBVtrqQhuPyU87iE0BXG/LT1H0
 hyUvpQPUCCJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCZv0MAAAKCRCIgE5vWV1S
 Mp/3D/4702rj3KkpzB+Lilz5BgJxfdjflOp5tJGf6ag+e1w4AjVUE6FGHzlcTXBSJcimVTXDTEu
 m97xKkV0MY+xICEl0XQ4fdCjwYjL2kU9l9tDAZITrWKgxCvzB7RBgq6fQmR8qxGwwHkl7qm0Jtd
 k6fUDudrtx8dSjvwb0PxXmm16krc/oKlfqliqm9GgNhkYoAjuDT1d3ixwoek/9OCfUWGAUrBzLy
 yDvdONUYu4KONlhBs9aWRoCrcz6w9eM6t38GuseFuTSzt5LEOFuURXW6GedmllJTbGEZKWqIqux
 pSzTNx4o1kw+D4ZOi7DyIqPhZiqb1/VJNusVnDOU8jF4zlmx64A9YSvueBDqfgIgO7RhUDlkTda
 LSnG+k7fj4NjMY8aY6Ncjm1Q1l583w2UQlOXclylxRQsJmlhDFN31vGOr0Zuuscjv7M0iDjLAW0
 WS2ndWa+jiRBDOWJHr/003mcISz/Vo7fogJUJ4yTkwOMCnFw8anSSJksVNyc2PkmQ41TGTCfBKS
 uBkM87XzFf+ZaDqyxa7kQLeYTfGEgaSIn7BKuAR65LHFu2ry9Zib9x8DhcfjwBAXP9NAL9efG1m
 gF8uhcEhQOvmb8eKjNuU/V50mTqlWb1b7UEGry/FB6Kn2eljxmU7Xh+QaOsJ6DqQ+8j+CFQKm87
 C2e3Gs9t6hMvCMQ==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Convert the bindings to yaml format.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 .../devicetree/bindings/mtd/davinci-nand.txt       |  94 ------------------
 .../devicetree/bindings/mtd/ti,davinci-nand.yaml   | 105 +++++++++++++++++++++
 2 files changed, 105 insertions(+), 94 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/davinci-nand.txt b/Documentation/devicetree/bindings/mtd/davinci-nand.txt
deleted file mode 100644
index eb8e2ff4dbd2901b3c396f2e66c1f590a32dcf67..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/mtd/davinci-nand.txt
+++ /dev/null
@@ -1,94 +0,0 @@
-Device tree bindings for Texas instruments Davinci/Keystone NAND controller
-
-This file provides information, what the device node for the davinci/keystone
-NAND interface contains.
-
-Documentation:
-Davinci DM646x - https://www.ti.com/lit/ug/sprueq7c/sprueq7c.pdf
-Kestone - https://www.ti.com/lit/ug/sprugz3a/sprugz3a.pdf
-
-Required properties:
-
-- compatible:			"ti,davinci-nand"
-				"ti,keystone-nand"
-
-- reg:				Contains 2 offset/length values:
-				- offset and length for the access window.
-				- offset and length for accessing the AEMIF
-				control registers.
-
-- ti,davinci-chipselect:	number of chipselect. Indicates on the
-				davinci_nand driver which chipselect is used
-				for accessing the nand.
-				Can be in the range [0-3].
-
-Recommended properties :
-
-- ti,davinci-mask-ale:		mask for ALE. Needed for executing address
-				phase. These offset will be added to the base
-				address for the chip select space the NAND Flash
-				device is connected to.
-				If not set equal to 0x08.
-
-- ti,davinci-mask-cle:		mask for CLE. Needed for executing command
-				phase. These offset will be added to the base
-				address for the chip select space the NAND Flash
-				device is connected to.
-				If not set equal to 0x10.
-
-- ti,davinci-mask-chipsel:	mask for chipselect address. Needed to mask
-				addresses for given chipselect.
-
-- nand-ecc-mode:		operation mode of the NAND ecc mode. ECC mode
-				valid values for davinci driver:
-				- "none"
-				- "soft"
-				- "hw"
-
-- ti,davinci-ecc-bits:		used ECC bits, currently supported 1 or 4.
-
-- nand-bus-width:		buswidth 8 or 16. If not present 8.
-
-- nand-on-flash-bbt:		use flash based bad block table support. OOB
-				identifier is saved in OOB area. If not present
-				false.
-
-Deprecated properties:
-
-- ti,davinci-ecc-mode:		operation mode of the NAND ecc mode. ECC mode
-				valid values for davinci driver:
-				- "none"
-				- "soft"
-				- "hw"
-
-- ti,davinci-nand-buswidth:	buswidth 8 or 16. If not present 8.
-
-- ti,davinci-nand-use-bbt:	use flash based bad block table support. OOB
-				identifier is saved in OOB area. If not present
-				false.
-
-Nand device bindings may contain additional sub-nodes describing partitions of
-the address space. See mtd.yaml for more detail. The NAND Flash timing
-values must be programmed in the chip select’s node of AEMIF
-memory-controller (see Documentation/devicetree/bindings/memory-controllers/
-davinci-aemif.txt).
-
-Example(da850 EVM ):
-
-nand_cs3@62000000 {
-	compatible = "ti,davinci-nand";
-	reg = <0x62000000 0x807ff
-	       0x68000000 0x8000>;
-	ti,davinci-chipselect = <1>;
-	ti,davinci-mask-ale = <0>;
-	ti,davinci-mask-cle = <0>;
-	ti,davinci-mask-chipsel = <0>;
-	nand-ecc-mode = "hw";
-	ti,davinci-ecc-bits = <4>;
-	nand-on-flash-bbt;
-
-	partition@180000 {
-		label = "ubifs";
-		reg = <0x180000 0x7e80000>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/mtd/ti,davinci-nand.yaml b/Documentation/devicetree/bindings/mtd/ti,davinci-nand.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..c0e09cccea8e65a6fcb98291c0cee0db56a97def
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/ti,davinci-nand.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/ti,davinci-nand.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI DaVinci NAND controller
+
+maintainers:
+  - Marcus Folkesson <marcus.folkesson@gmail.com>
+
+allOf:
+  - $ref: nand-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - ti,davinci-nand
+      - ti,keystone-nand
+
+  reg:
+    maxItems: 1
+
+  ti,davinci-chipselect:
+    description: |
+      Number of chipselect. Indicate on the davinci_nand
+      driver which chipselect is used for accessing
+      the nand.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+
+  ti,davinci-mask-ale:
+    description: |
+      Mask for ALE. Needed for executing address
+      phase. These offset will be added to the base
+      address for the chip select space the NAND Flash
+      device is connected to.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0x08
+
+  ti,davinci-mask-cle:
+    description: |
+      Mask for CLE. Needed for executing command
+      phase. These offset will be added to the base
+      address for the chip select space the NAND Flash
+      device is connected to.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0x10
+
+  ti,davinci-mask-chipsel:
+    description: |
+      Mask for chipselect address. Needed to mask
+      addresses for given chipselect.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0
+
+  ti,davinci-ecc-bits:
+    description: Used ECC bits.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 4]
+
+  ti,davinci-ecc-mode:
+    description: Operation mode of the NAND ECC mode.
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [none, soft, hw, on-die]
+    deprecated: true
+
+  ti,davinci-nand-buswidth:
+    description: Bus width to the NAND chip
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [8, 16]
+    default: 8
+    deprecated: true
+
+  ti,davinci-nand-use-bbt:
+    type: boolean
+    description: |
+      Use flash based bad block table support. OOB
+      identifier is saved in OOB area.
+    deprecated: true
+
+required:
+  - compatible
+  - reg
+  - ti,davinci-chipselect
+
+examples:
+  - |
+    nand_cs3@62000000 {
+    compatible = "ti,davinci-nand";
+    reg = <0x62000000 0x807ff
+    0x68000000 0x8000>;
+    ti,davinci-chipselect = <1>;
+    ti,davinci-mask-ale = <0>;
+    ti,davinci-mask-cle = <0>;
+    ti,davinci-mask-chipsel = <0>;
+    nand-ecc-mode = "hw";
+    ti,davinci-ecc-bits = <4>;
+    nand-on-flash-bbt;
+
+        partition@180000 {
+            label = "ubifs";
+            reg = <0x180000 0x7e80000>;
+        };
+    };

-- 
2.46.0


