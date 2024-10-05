Return-Path: <linux-kernel+bounces-351720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB18599154B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 10:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06A3B1C20C2C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 08:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003F0146592;
	Sat,  5 Oct 2024 08:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEv88oAg"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A08D145A09;
	Sat,  5 Oct 2024 08:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728116812; cv=none; b=PajwlKq6YCimWOqgknEvBlNWGHpBESs5hvCqLbbhb7FqsIBpviM95x6G5Hb7nDK+OmfZKAisWQHRjJPrvabGkcPvc+LRFjlV4N6q+gM07+qVAly7/sj5lOOl/+GjlKS0GValwPodigHdlxwQDhELXKuJ1gD/GzhATgG5qU+rQGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728116812; c=relaxed/simple;
	bh=QDxkMI0n2UGhpclkMfDOTjcMs9n+2sf9z1tZUtp8xDU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VuiauPWfmBRd8Nhfn6kXGi+ZygBqKi1v7KkTbXBKEB8WW2KwNvl7ZWRyM875WFEDhi71Kn2mEJhxHXs1/9nsbOZkiRWy8MrbmkELBzYG2lFoSTJPrPxbVS/Dgf7TDcBurwuU8WugHheTPchYQkjBh1TS6VbOdNcF4q2mk5etPPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEv88oAg; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fac275471dso28212021fa.0;
        Sat, 05 Oct 2024 01:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728116808; x=1728721608; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lxKlPZuY6JQi3nqnX9Ezpc5OAxh4iVW3dp5hMM6fzFE=;
        b=iEv88oAglDcGgpkA/jeskA55q9rrUROnSfb1g6CKwgF2r+yWArtLEHxxby87TsRP9i
         qItTWry203vvJTQjqz4Llnm794Z4HtrKHc44pH4jDB9RGhQynQAyP51h9Ov7PkihT53o
         BIH6PxNFO6BxGF6UuyVDPDWdtGmSeKwIdYCIJmo9rLfWAdXsTzCHpWioflJUN/eTnDtL
         TUkaMv8loPSh1dEL2p/cg9o6iw97aQbv/8UMXSO3YsWcPJqYG0eaOyRSm6Oj8E4aLjCF
         2imtx4Hb2ZiiCeyvdNl6ntWRxACBnGDwCUBvqFPhankfp+yb+1xzUPrwi2qE+u2EBJVu
         hj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728116808; x=1728721608;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lxKlPZuY6JQi3nqnX9Ezpc5OAxh4iVW3dp5hMM6fzFE=;
        b=GxtnXLfkBEWuCYapH/m0GYsCRXXqCNsw9pSmocRbzMciHUR3em+ul74N6sXmqGLomj
         GxwE4xy9jay9uHUkz+a7TEFj4luGtAVWAPOpKbwDWnNpa2CoZSgZ1TJu2JoxAFgmytzT
         wGPMdq+TnzbSa8hmZVoo6m7BHAAHLzqSE6/zdrx2Yly3WnSbFBVzQAmC70PsYspG58ZK
         3VcSv67xriVfhpcaoO2Zej34caOB3R4l2JhROJkMAHbRkGqy1DJZkMNL2oC06+JVonGq
         eiluQHOBCu0okDRACqTtcQShpeSIM+pLOqzTKZKf6bNUOYTjCMsBQZKFXRXi0g3WQ/gy
         j6HQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhr3DEe7c4muOAnf8BwRwaD5EAAiEOS6dDo5xWhiTPZQV2UOSgXy445vKoaNY/jBpVXFARatGkAOGlEBMh@vger.kernel.org, AJvYcCXGRvNL+20Tfew1agHOb41ul9o7Z1Fr4um1fjlIbIcbrGhgC1/ZPapFdKGbToWHCXbwFCIRueDrJPvc@vger.kernel.org
X-Gm-Message-State: AOJu0YxbZUAp5OSvvkPssegt5APUVlOiTDjj69pqHYo2MHVp8z0AJ2Zv
	jx6t8ubKQALXoKzMeKnHeTjEZiDEenFirt4pbx2B0D/tx74kpSx7
X-Google-Smtp-Source: AGHT+IGpMj9A07n5jg68XCvAUJI1w2FEp8Tc7QlT4nWQDv+P3rK1eQW3fXDcxnr/8A1gz4WZmTSOdQ==
X-Received: by 2002:a2e:a550:0:b0:2fa:d49d:45ac with SMTP id 38308e7fff4ca-2faf3914661mr17379231fa.1.1728116807873;
        Sat, 05 Oct 2024 01:26:47 -0700 (PDT)
Received: from [192.168.1.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2faf9b3a88esm1857711fa.125.2024.10.05.01.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 01:26:46 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Sat, 05 Oct 2024 10:26:12 +0200
Subject: [PATCH v3 2/2] dt-bindings: mtd: davinci: convert to yaml
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241005-ondie-v3-2-459d9c32225c@gmail.com>
References: <20241005-ondie-v3-0-459d9c32225c@gmail.com>
In-Reply-To: <20241005-ondie-v3-0-459d9c32225c@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6849;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=QDxkMI0n2UGhpclkMfDOTjcMs9n+2sf9z1tZUtp8xDU=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBnAPg2fyAhT/8xon7/Smhwfy3iMB/u0syy2651/
 Bp5WtJnv+CJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCZwD4NgAKCRCIgE5vWV1S
 MuOkD/4xgSjmWAujY3vPLFaEfkdxgkttvwfVH6qoXkhs8QcregP61gjbfmRvDJGBBCHkH6LQoo3
 0UzEyZcAeLCcr8f3hRQ4Vl+cG7UZUNPbW8HBoa23P10gQAh+2s765Nc8kxAFOZORqLuTa5sqxN7
 Vpp5bxw3YLywa3//yVe2dWj3tvajCUGrHb9si/uFNB+z5x2wDYqHjxc6SPGWMgCQoMkAY2q/Snq
 TNO+ch9ak88eC8AjWmikzxuKj6Nt9sWDZWZE6OPmv2iaDg+eAPybydfLN7HlnFaKlYuHizZEf+i
 f6hNzMiC4wc4n600yqKl2mmTfFaAl1iJlll3t1t7hErfUi0CR0ttJAMD9Dme4kitA5PA54GsRoU
 Cg/PGmp4lZpT5MIao+/QD3vdPWO3kfvvhliwXnIPpSd3Gwn/DTo9LAsatrRmHGX+kRttHeTeVn7
 E46XEbqmG6SfEp/bKCHNKXqCLaaycsRzlAumUF5OlM2yxIuqtQiqZGjrc7cBzKUeWpVb4szKZKu
 bkLCQyGnMIVd6t1dFI+R4W8t4+dOAeJrxyZabCpG2usJhr4kqkZ2BM5BtEJS6Tvi4zzVd+vbfvY
 0uCBjVmr1epIskohPsswn+lDnXJnvWZxuE5Q41JHGTMB6grxiOeHGqsJ15EZviLT0u7KpArj7Da
 LcOv5V8Q5gQgl4w==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Convert the bindings to yaml format.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 .../devicetree/bindings/mtd/davinci-nand.txt       |  94 -------------------
 .../devicetree/bindings/mtd/ti,davinci-nand.yaml   | 102 +++++++++++++++++++++
 2 files changed, 102 insertions(+), 94 deletions(-)

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
index 0000000000000000000000000000000000000000..0acbe55f6d05f358fb19f70fdb3e5d2f0c468f88
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/ti,davinci-nand.yaml
@@ -0,0 +1,102 @@
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
+    description:
+      Number of chipselect. Indicate on the davinci_nand driver which
+      chipselect is used for accessing the nand.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+
+  ti,davinci-mask-ale:
+    description:
+      Mask for ALE. Needed for executing address phase. These offset will be
+      added to the base address for the chip select space the NAND Flash
+      device is connected to.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0x08
+
+  ti,davinci-mask-cle:
+    description:
+      Mask for CLE. Needed for executing command phase. These offset will be
+      added to the base address for the chip select space the NAND Flash device
+      is connected to.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0x10
+
+  ti,davinci-mask-chipsel:
+    description:
+      Mask for chipselect address. Needed to mask addresses for given
+      chipselect.
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
+    description:
+      Use flash based bad block table support. OOB identifier is saved in OOB
+      area.
+    deprecated: true
+
+required:
+  - compatible
+  - reg
+  - ti,davinci-chipselect
+
+examples:
+  - |
+    nand-controller@62000000 {
+      compatible = "ti,davinci-nand";
+      reg = <0x62000000 0x807ff
+      0x68000000 0x8000>;
+      ti,davinci-chipselect = <1>;
+      ti,davinci-mask-ale = <0>;
+      ti,davinci-mask-cle = <0>;
+      ti,davinci-mask-chipsel = <0>;
+      nand-ecc-mode = "hw";
+      ti,davinci-ecc-bits = <4>;
+      nand-on-flash-bbt;
+
+      partition@180000 {
+        label = "ubifs";
+        reg = <0x180000 0x7e80000>;
+       };
+    };

-- 
2.46.0


