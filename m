Return-Path: <linux-kernel+bounces-352385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 584C9991E66
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 15:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C6E3280D55
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 13:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF61176ABB;
	Sun,  6 Oct 2024 13:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O15OCU0S"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1E2170A3F;
	Sun,  6 Oct 2024 13:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728219975; cv=none; b=eKKl5o4Vc0byyAofBin5uo6amXzEQTj/3PZeOSQ1+o6kz7WqKbNHAlnqfT+lwDHLGBLUdoGAPIXtmNZ1/mRArAQ3Ous73zI+49SiZOqS+mYLIv+CQAj+R/vykyTcCtkG7MvRX8mtd3EEvQM2bFjobKMSBZ9RDEp3hFf9hKoBhnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728219975; c=relaxed/simple;
	bh=V+SIaep7bWzHTvD8pybyr/9k++8fOylDO9+jqQn/TC4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cMajkKcS0nZk8zQB9cG16tQG+li8isqqVSSs2sxXt0pcXcmgOigQB40jkjwK/A9SMjyBJs94lCLtBFgZBjJgWEJFzHK4Mp1iKikuxEGUpexIZRWrwlV0UZNHyt/ZVt2Ri6GoU8V3c0KaG1f0dfwL+TalR1d6QodKgdlODXc/9zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O15OCU0S; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5389e24a4d1so4269473e87.3;
        Sun, 06 Oct 2024 06:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728219972; x=1728824772; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z4ull0/o4n6FDTwu/Kzs9/7Z+1yfWkdZ5F6ZbcuSSNA=;
        b=O15OCU0Stqj0LpelfTI+doJ6fHiaUNpe1hY6sKQGQW876gEtwYEstxaTtmij0hzmh/
         c+/wgsRpUMcB0swSfDkPhaa8Su+9z5dtFzu9DFuIDCCtyAyMQDwGDsg40q1265Ys0F6H
         vfT2niFMSdjrKfEGestoUAcvH7gF0I763RIvDFIq8LdfMCggKQ4+lV/8/HzcHQ+1lu9a
         cUjlLL5ampOXTKyLPXhccvjCZJtrgwYsRkSMohItgkJPHFbwXjIAuwgAA4xcdL6g6a7Y
         n052IKdR9ey5wwXg6C6ZKIEqeJWeGPYlDQwhUYoBjvZ75UY14wrZT4Owup0TDVhPXIk2
         tJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728219972; x=1728824772;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4ull0/o4n6FDTwu/Kzs9/7Z+1yfWkdZ5F6ZbcuSSNA=;
        b=oQeCTY3o1jQt6lLUbikkoOJjS8jWmYEc6EKoVqIzdPr3YU0NgaU3q7kFh/XdTIKFak
         DIhMIa8cN4u+UeBI0U6xC8fiy7udA4KVDYpzRIloykBn59fjCNiddtEeTTVQXWe0CCpV
         1LclG124ah+//HrBFljLkZNmVg18kcYnw15xHVJqbMdAJ3XinFCRY0VD1LupsLRNRs4N
         3ezXIcBFteNUSWVKPPMaabCyjsVvF83tkaIq/WBJOzU1+vf5oggaBNNvpihvYMZyyge9
         anRmBEDgNMAiDvOr6V1V2eEMzvxLHoStX5Y5IiIKd2Hrn8iGW3Liz2AQ3/7DFMRzkb8E
         CxkA==
X-Forwarded-Encrypted: i=1; AJvYcCUvvfMYPQuYqB3TcrhyE1x55++f3QPtzfs0KklBfmMmbAXqb15Awv+ftzm8XG49yvWGrn3bxPYKZ7+R2QNr@vger.kernel.org, AJvYcCVO/4wU8nldDtz+z1NzDPhH5JQcFQDPprxmtX8/9jKtiEY0WuwTcMrE7V1XYR5qEyMqtFd7N6QLnL+/@vger.kernel.org
X-Gm-Message-State: AOJu0YyAxZobTIp1miQugl0ZMH8NgCVRDrniufh3uMCm8rJTwOuRTz9R
	CM5pp3ALMoOzIfZQ7jWRo+KYbethlsblWX7HvNRf6cuWwrJgDnHW
X-Google-Smtp-Source: AGHT+IHa95SrnM4qpTU+LSmo4EIPiIHdxMOpzZDCmW5C4T0GQoERsc3vhQrLHiqojRFzijlHlKgzDQ==
X-Received: by 2002:a05:6512:3351:b0:539:9490:7257 with SMTP id 2adb3069b0e04-539ab873352mr3109464e87.30.1728219971457;
        Sun, 06 Oct 2024 06:06:11 -0700 (PDT)
Received: from [192.168.1.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff2904csm512749e87.304.2024.10.06.06.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 06:06:09 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Sun, 06 Oct 2024 15:05:47 +0200
Subject: [PATCH v4 2/2] dt-bindings: mtd: davinci: convert to yaml
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241006-ondie-v4-2-ff9b9fd9a81d@gmail.com>
References: <20241006-ondie-v4-0-ff9b9fd9a81d@gmail.com>
In-Reply-To: <20241006-ondie-v4-0-ff9b9fd9a81d@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7116;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=V+SIaep7bWzHTvD8pybyr/9k++8fOylDO9+jqQn/TC4=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBnAos1iTHHu0HTEqDSxrmkEVg6UTaOPiHTVyOtf
 3SfZEcCp9GJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCZwKLNQAKCRCIgE5vWV1S
 MhxvEADZ35FNlqa18epP/Vsrk+Tw1OtMkE/ULdjMKGOsfPztVohmtUE5mkr2+uHZmcx3UXQBGnx
 q9d2rH14GOcHdEbnhxuSnq5ml6FDFXVnXuEw+Zn/b4ML2AfP7LNcQUY4n0qKJVC2ooPc9aK9ccJ
 tbwFqxQdKDM6N1tZ8OOJMphMCRHYLXXrqzuKnnPEu9aWeX10ufzO8iVpES67KE/4AidU+gk3akd
 kz1QgEpcm6OzUOaiG6mZaEmDQMR5HITCnAgPaZmCPhuKP0TF9HvvTH0ad9u3Um/xAXjwsXx8NtH
 LzIok79lGKnmoJAvlmcSZeGjuDl2qhYhNGRP+xEY82Y/YZaB+h9WJ0pEivvfMvr7Y/gvCIA2k1S
 uWnEfWnidMEbv7BkjewJkMOEXWRHryWVsz50t/YNzqZSg8F3gZ3Fs6iibAtbLzcPtEjlbarie4X
 7umRKv8ekH/QR4eierfn3+UKm6KbA8WpmzkhlSXWZBbEqay4FjS6XhOOhk3KK76HlB1UjZWDId+
 6ZWfRpt5tg2IzLeNOcwPk8qEs1JZkpn2wAnN5Y//cUl6SyaLKYMpH1tJL4T/7UV0Ih4K33XOFS/
 lXuqyeyux+sdG++Sm/eFb2J5BGggxfuKDo/yn68WbrymacUgm719ZXP8+5Lzvk0vieEUwOmXGwr
 7zhy4cIqOWr1Pqg==
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
index 0000000000000000000000000000000000000000..d87fe7136d64ab15fcd7fc824f7888d6643f1b91
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
+additionalProperties: true
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


