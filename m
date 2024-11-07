Return-Path: <linux-kernel+bounces-400031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D3C9C07FA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2928287CB4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C291212655;
	Thu,  7 Nov 2024 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWnkWJa7"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59765212D3A;
	Thu,  7 Nov 2024 13:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987260; cv=none; b=HXFlF6nN6Amsli5Sf9dJNXguEEjXOyg/Qj/ry4BKA4h0o8qpmc2Muns4RjnICaMD02xZ+jfOLsvgsZ1bwKG6f/jBx9VQVX5Uk1Jlh9vT/5lp1uFLP9H4XbgzYB3NyrMhtsjR0dUIN626EYmvWAox3iBQQ3PODa+XKIIjf6M6Uro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987260; c=relaxed/simple;
	bh=2/qLSSMsB+YGfZQhvTE/L3JLsSPTvmuQFzCCfyhNHy0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lag/+0ZBGtyH+1u9xKDiip/FUvGXdNqY52JZsZnmOsnOgKX2lytO3903RR6kiz9q4GFMjWLsEClYK2USCVStOk/bM8Wu64IZUawHi/rzeSDZk9nXtQV3H+QLIv5HxXIOiSrGoIjaLdbv6zk5knIC07USSFhbEOhsbtTyp3h9kRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWnkWJa7; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb51f39394so8156191fa.2;
        Thu, 07 Nov 2024 05:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730987256; x=1731592056; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SwlYA1btjVElIAnpXjyhLJRCjG01im8ol94Q+fCfTTE=;
        b=KWnkWJa791VUPDsxa/Wcyc10V1/pqoojNP14yiSLNwZ+m4nmSVHQZAYQKV92Rw29hV
         cM1ofQasqrCOsuhM3KviSZ9w1bCHEZgiSu4xhvmuq+9OcNHJ2Vn1lvIfSGga6BiZzVC9
         NT12iTWpzkv+cTIaho2iMeFrA75HclTRygLSvtBJzVmEW1lsYODg6SKx/M3y/jh1Q6SM
         68l7dHgfYqiFllhMyJqhNqmFHQ71+mkHrWoX3mm+ng2NI7cSn0hgYrF/7dGkwjgp3OJZ
         v7An/0w418/jnUAjdcRQoHZpXYjMvfKcbqlPC0atblOCTUFfVhX/ZZoGGfPia9hKfcqr
         E61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730987256; x=1731592056;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwlYA1btjVElIAnpXjyhLJRCjG01im8ol94Q+fCfTTE=;
        b=hg39NYZy/w+1WZjXxfy9k2zG/X2C3rSgjesMeci1g11rflzf3J9hwGDDixyOJPll4G
         IqZfwyAmqHDLqejVubpyGSzf8QPCOSZdSJOMBeycZNevhku9suP/5yF54G9pf6aBxrCW
         w6jtkoi1W1Zux/ybSMrFT5gg+di4LfQxWigbJhqTO6bUkmPf3LJFvC0Upsi0Npi5xYbC
         ZvsC2ue6wPyGe/iioeuEHJQl3GwUirTMO6qJfAJ9wl7sq44G8HNM4Z9wQuU9Oq9FGNGo
         Uxc3xZyhoBG5TRqAxwxgQ/j+yhnQh03tJWQP2sHOITdAFDwX6lS7ajsXe+MuI0+LSxUo
         LAvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNLM81cYhJpvn5b9UyIJtudXSwKnAR1ip7CSiWI3+hcWCFJb4vu2VbaPiUF3MQsqy8FKOMD/+ZtOSM@vger.kernel.org, AJvYcCXa1GHt6JKy/kh+Iud6ie+Ro+D0JDo5fQ6N6VZZhTcjCAylLt775E+aD3WJQyq6DZU1MyLuyK4TB6dC4DIs@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1GdsClyGAD9JUzO79HldF7QOyAb25FTIc/bbI18DbxGowKcbe
	bqBNr1gfUIBpbyMvd5Qln5ZhU68ZY4QHrNN8+/8DywlvVeQsGhIg
X-Google-Smtp-Source: AGHT+IEUfsk10liiiVYX0eA0dh8gtt8gDUg1Da0/H5cFNiBMGxanEKBd6tr0eAZ2J9V8JMeMnmrYdA==
X-Received: by 2002:a2e:b88d:0:b0:2fb:3d86:d932 with SMTP id 38308e7fff4ca-2fcbdfaea70mr225554551fa.12.1730987256239;
        Thu, 07 Nov 2024 05:47:36 -0800 (PST)
Received: from [192.168.1.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff179d80f5sm2276591fa.105.2024.11.07.05.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 05:47:35 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Thu, 07 Nov 2024 14:47:08 +0100
Subject: [PATCH v7 2/2] dt-bindings: mtd: davinci: convert to yaml
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241107-ondie-v7-2-98829fc8a958@gmail.com>
References: <20241107-ondie-v7-0-98829fc8a958@gmail.com>
In-Reply-To: <20241107-ondie-v7-0-98829fc8a958@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7384;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=2/qLSSMsB+YGfZQhvTE/L3JLsSPTvmuQFzCCfyhNHy0=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBnLMTtG07LNg4JYqu7NmLP520DK4Gq/5PPdFsIQ
 MgK6lTmWkeJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCZyzE7QAKCRCIgE5vWV1S
 MtxVEACOwZhrLHujlDlNF9EwUI6XmxCQMRT3EOolqltfeok7sjLQFX+q+W8DGTh4+5btamn5kkw
 tbwADKyS26KwjRwt5nPAgG2nudi5e1+m/j+WyUz2Y+laKMUEvRazLhaaDiJJWTENeNyWw/We2Tl
 74PoosEHWZcBrR9dvQJXJPc2H12n7E6ggnzQNA/LBNu2lwP+7HsHxxOTJCDzabzU5KYIWQ2mmBf
 0ja970XQGTG9gYfwX6INaRymH3KYfHNXpD06+1MCoBEi0J12chbcUlZ5fA86bG73yze2ucfIarE
 CyuN4I/wRGo3I4qNoNOW4XRC2P8wTVl0XXjVfnz0ztNQqWkIbnrKtmR4cLqwyyOhStUK3CxOi/t
 GIXpyRhDbt3QlLVJ0C7ds/yNznZCIgksoRuabppenGWJJB3xPLEYDe4fp0n+LBHerZoVgGHDkpb
 AQHG3D/MXFxH0ffcHJZiDF5r2YX8jIT76KDjEy9q+j23VSp1wF3lJnvsMMT6rxfe5KV7uldN2ct
 zH4nVIHq3BHw0li15WMEUessc6eyYPn4HeqH5F/zPd6jUdVPpLJzj9J1kl4QVyjKppd9P9QSYAW
 K5pC5jZlbmJ7nyyuTR2WePm3TnY0CFNasoIIljJS6SxMrllLedpd2UpiqAChBvZ5x/swgekJXq8
 ToVrJdvlILMTqcQ==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Convert the bindings to yaml format.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 .../devicetree/bindings/mtd/davinci-nand.txt       |  94 ----------------
 .../devicetree/bindings/mtd/ti,davinci-nand.yaml   | 124 +++++++++++++++++++++
 2 files changed, 124 insertions(+), 94 deletions(-)

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
index 0000000000000000000000000000000000000000..ed24b0ea86e5ccc795882ae52275c39a25fabad3
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/ti,davinci-nand.yaml
@@ -0,0 +1,124 @@
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
+  - $ref: nand-controller.yaml
+
+properties:
+  compatible:
+    enum:
+      - ti,davinci-nand
+      - ti,keystone-nand
+
+  reg:
+    items:
+      - description: Access window.
+      - description: AEMIF control registers.
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
+    description: Bus width to the NAND chip.
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
+    bus {
+      #address-cells = <2>;
+      #size-cells = <1>;
+
+      nand-controller@2000000,0 {
+        compatible = "ti,davinci-nand";
+        #address-cells = <1>;
+        #size-cells = <0>;
+        reg = <0 0x02000000 0x02000000>,
+              <1 0x00000000 0x00008000>;
+
+        ti,davinci-chipselect = <1>;
+        ti,davinci-mask-ale = <0>;
+        ti,davinci-mask-cle = <0>;
+        ti,davinci-mask-chipsel = <0>;
+
+        ti,davinci-nand-buswidth = <16>;
+        ti,davinci-ecc-mode = "hw";
+        ti,davinci-ecc-bits = <4>;
+        ti,davinci-nand-use-bbt;
+
+        partitions {
+          compatible = "fixed-partitions";
+          #address-cells = <1>;
+          #size-cells = <1>;
+
+          partition@0 {
+            label = "u-boot env";
+            reg = <0 0x020000>;
+          };
+        };
+      };
+    };

-- 
2.47.0


