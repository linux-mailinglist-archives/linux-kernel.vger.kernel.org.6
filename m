Return-Path: <linux-kernel+bounces-354622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A14299405F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED61D1F2686B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88D61F893C;
	Tue,  8 Oct 2024 07:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKKddUrm"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0947F1F8EF3;
	Tue,  8 Oct 2024 07:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728371003; cv=none; b=hH0xhbiJQKqRlTmJE92/4VxfxFUHOFqsx7FLQeIEb8PQ2lUYXf11tptQJK6+k9LDgo/jfeSONa6CwAUbWroPZe8ZxKsyv0WUA7fEwhz7FV/ymdlV4oC5DUa3kQIXXoIeZ2WDYgweJLn+ydwZRYTJ45j0D/ytF2gI/CzJJBRX9UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728371003; c=relaxed/simple;
	bh=S2slwNNYHXYBPvgUnqA1Ug+OhRjjn6ggURi9xup7b+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BQtu0Y51yxz4YUiXEOPt/pu+US2Mt9gv9HaQNHl/YcSDyeHD33gEVcPPiUxGznGAic+GDHbHM7i7yeQZ3RgqUEAoWHxDVH8V1P9NLJBoJIzATNTC1oLe5TwDIOomBSd5DxNu2XzZubdsrMQvB93783Ww3qe2Dgcitp/0iOLyu7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKKddUrm; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fac5eb10ceso47206391fa.1;
        Tue, 08 Oct 2024 00:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728371000; x=1728975800; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=11/xVhPaw72EgSS30V828/PIoAW4o2UZR0EZZoGwGjc=;
        b=TKKddUrmsiWhEjpYjczXiYwcNKLve7jESJ7cJjJ+gsbf1mUcY/d4tUw33YB1nCE59D
         +Hm/XRbswaTPt8nO/wb6BzJ6NTe5uz4+rH+GgQdwfqary1rqnvb1lUPzMT/HMkcE05/o
         HjmvE21kIAGva2XNwbfkWUVaFm0dAAlvjTsAdTkM2038SsPr2TDu8i0IaJ8+ACLrjffZ
         FZwFAP64S1BnbVM4/U/3j1i9QlJdR2EUBgQ/dre65sVelMlbArNZD/pQpegVRe7dRJCC
         awZIbghuy8u5QnHxkU12WDEJUzI1bzBpqvm9Nk3TRIqSgkW7gcnivxLigvAqF22QvjFu
         tJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728371000; x=1728975800;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11/xVhPaw72EgSS30V828/PIoAW4o2UZR0EZZoGwGjc=;
        b=reEDvJS1c6pyOSlHaT9XI28x8yE2yTwYb7Mr5PDYfofHlyXAudS7QXxDmP8eXfbHqX
         auoRS4I0f/b5cuCpBn4sVRQdBVdbGqI/QkAawHpttUEcfnhQJfDfvOZXWObVu4SFmTKE
         eVixywauRO5C0Zh/uywYSXiW0LzXZoPS8uoEh6a4wmmG3FNmFeuObIx3aI0G9Gbm52VX
         GnHF7cDMm0xF4D0DLLDVCJI10aLvDgnUpCLTQMZ2T9DMNwiHhQyO5GwM3daqKrtyaHg6
         p2poVg91+7O282777B9qfzg8KTloB3WD76gy/Tg9l5M3GZ0DgihHNkr+jYjUc+Hidf/C
         VIuA==
X-Forwarded-Encrypted: i=1; AJvYcCVHglPIPunZEIC6cBpP4YZC6/Pj9lAKwPbRs7HpWWTUuwb1AdLhElKcEJVjWIXfRzO6xsQu5RbRFiFUnRYv@vger.kernel.org, AJvYcCXYf4MDoQPHCiRT5ZFloDLcb/WIpEOkjOpViYIaJgFivogWfLxwH2jul8ueKNBoCuQowrPtRi9gwgvg@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv7g742M3dx4sKgCayWGb4xUJlL8S4Ud3hEDpqtlS50Ox0+jp/
	B9zicUe+u+c+ZsCVBwpL7aawgCMZFZ1b/lv8uwHykfm5oEvmwqen
X-Google-Smtp-Source: AGHT+IHjlcrnWn+mCc42KdlVsOps7dkIGmO8CP0FiMa3dkWHEr2+kP+bcfJL9MltN8OBNRnF3zvbmA==
X-Received: by 2002:a2e:b8cf:0:b0:2f7:6277:f2be with SMTP id 38308e7fff4ca-2fb0dec999bmr7702681fa.22.1728370999667;
        Tue, 08 Oct 2024 00:03:19 -0700 (PDT)
Received: from [192.168.1.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2faf9ab1564sm10972441fa.7.2024.10.08.00.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 00:03:18 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Tue, 08 Oct 2024 09:02:45 +0200
Subject: [PATCH v5 2/2] dt-bindings: mtd: davinci: convert to yaml
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241008-ondie-v5-2-041ca4ccc5ee@gmail.com>
References: <20241008-ondie-v5-0-041ca4ccc5ee@gmail.com>
In-Reply-To: <20241008-ondie-v5-0-041ca4ccc5ee@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7118;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=S2slwNNYHXYBPvgUnqA1Ug+OhRjjn6ggURi9xup7b+k=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBnBNklMihNwzyb8a24StKA5OiYs4wE6wlkqskHu
 9Orwzk3JRuJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCZwTZJQAKCRCIgE5vWV1S
 MqA/EACm28H9VX+Szb1dXAh/jiXRBPA/G01lRKMoFwSwuT0mmh/OR3cUiUWGs9Z2M5A7hMaOwKQ
 pOq1TVlIlMlUlIByPFEiQI0fU0C5R5opQTTX76UGMaOcfJB4m9edvsFrEsQFUKg8oZ69iFyxSFr
 DkymYUNi9eRORilQJr+YFZQbi6Ch4l2dXTZo4saK0P4QNjazQJFfpMaaXcsiEzWKal59wSA7/o5
 5ar2vvA8Lac7bBKrJUmlm13d59ESBxoNXf6P3uFizZMTA/Uxk0ib45XRqupxJXCbs57PlWRc1Kt
 fmJDOu+r2pwqpCqBrlcwQdMXTLq3DzwFQDeSrx6ikHjim5p3ShQi37jOzgNt/P7i6x7P5fmBFpt
 QJLxgwt7FdBhGXetToKYnt9cT1z+Dc4nIgVWFIO12kNWdLtAy5IyGy/vwTtv2bx1SmkiyZvpR9V
 xqyCdVKNFySgH5xqYGLDO+rAzuQV8H+KPTpEakm/RSS0gLbvX2yPWSu5UHLRTHdRLLvkjKNAMzG
 6fFDIiBLj3t0Qgj+oePkag/gIQicyAnw2nLKpasyswbAAKtZZiJn2FUMQCF/M+0PGDIGu6pEbTE
 TWuCt+G4vo4bO71gFG+dtTf4cq1GQOF0yqi0OrKpk9iVohO/XvW+jsOHxBxlAGWj/fvf9bVFJFu
 Nl0iV8ymD0XfjVQ==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Convert the bindings to yaml format.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 .../devicetree/bindings/mtd/davinci-nand.txt       |  94 -----------------
 .../devicetree/bindings/mtd/ti,davinci-nand.yaml   | 115 +++++++++++++++++++++
 2 files changed, 115 insertions(+), 94 deletions(-)

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
index 0000000000000000000000000000000000000000..1263616593532e8483d556b4242b004a16620ddf
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/ti,davinci-nand.yaml
@@ -0,0 +1,115 @@
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
+  partitions:
+    $ref: /schemas/mtd/partitions/partitions.yaml
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
+unevaluatedProperties: false
+
+examples:
+  - |
+    nand-controller@2000000 {
+      compatible = "ti,davinci-nand";
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      reg = <0 0x02000000>;
+      ti,davinci-chipselect = <1>;
+      ti,davinci-mask-ale = <0>;
+      ti,davinci-mask-cle = <0>;
+      ti,davinci-mask-chipsel = <0>;
+      ti,davinci-nand-buswidth = <16>;
+      ti,davinci-ecc-mode = "hw";
+      ti,davinci-ecc-bits = <4>;
+      ti,davinci-nand-use-bbt;
+
+      partitions {
+        compatible = "fixed-partitions";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@0 {
+          label = "u-boot env";
+          reg = <0 0x020000>;
+        };
+      };
+    };

-- 
2.46.0


