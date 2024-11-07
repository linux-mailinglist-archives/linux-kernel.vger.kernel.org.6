Return-Path: <linux-kernel+bounces-399578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 564AE9C0109
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7C1E1F22FC2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BB81E3DEE;
	Thu,  7 Nov 2024 09:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6/3aCrL"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86011E261C;
	Thu,  7 Nov 2024 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730971225; cv=none; b=JmSPPPd+0Vyl/++OKW5MuLs+G9pMq1NLAUnvslg1YbW2w+1nKRyUZ64gDniDKAQ2P3fYsRD4d4+Kgk04adQIQSmnVgPdqluiE0R1QDGFuRGOPAVfd8TDrkbFmkDB54dhURWsfrcVVAXBzlHw/mH4c5BiyWZiUK2FHSwL8tSNJAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730971225; c=relaxed/simple;
	bh=qcVQKBxN0F6baKWfAFHd5n9gYoMcBRYNhU4G/s72Xrs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WFLWj6cSS3QyO89VCzmdChx1Oly3/6kMA6hn52utvKJZbABUJ2f5uqi48rhfsbkn8q3gTDoCHPRZbCRmSGBJWpphAzC5jcnHvSNz2UUj1ZepX92Z9EETiLA3x55iD9j/wPnm+/pAOYgPeYQKpspR7asjmDAqArWCNf7LRzGGaO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6/3aCrL; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539ee1acb86so708681e87.0;
        Thu, 07 Nov 2024 01:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730971222; x=1731576022; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QK1XdOVmAUkQ2fTe+YuCgvHp77+BHuIFQXUOx8rf0ug=;
        b=k6/3aCrLJ+HuQLPAzsEfR0aNGKnT1WJxHYTupShUaZyTRcP6HVBhbPf/A68OLXw6cF
         QxlmLSdM5bVFC45J9VEWSAmY0j2SaEMilKl4TKQhzNBLKeHYp1jEBTh5jeH6Xf6mtPxN
         V8AtMFlpcfDW15A5MI+xxqm60VAw9LNrvF+VO2nNoVC0B3RAfHiN9jls4E92+3rRGUFD
         4Ii4lnaYF0VSHReKsvkrQDnHKWSmbHl9cpXb2f4yPMOy+fdY682rIUTWIFMkDxWIjgw9
         5kjswWZhgWr1x8peBIthjG/IzcySxLVsBGLDuHWeUYtIYTgjllN45LO1vdJhAtBsPyvf
         dlmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730971222; x=1731576022;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QK1XdOVmAUkQ2fTe+YuCgvHp77+BHuIFQXUOx8rf0ug=;
        b=jELwNx3ZjtSwHUU7LMBvEwPlalpct9qgXoA7pbyvkdY+1zisBC8OL2aNMd0pCKQ1NX
         JjghbXwGvFQaUxvs6gfH/+GSfuOogrPZnSMyAtHgT5+6daB1XUW6kx7jpt16y3AyyX00
         wx8pHUyYO/ypNmtcjwMValrx7D9qXBmyg9U5DlBNYt+5/tulIMvPX0tj83gDnP8xF/fX
         fLB/fiUMovC4wzZcprw51GhLGI0e6xVjYTOxoXj2mFWWLK0MxiJvLAkF+Qnh+bVvqG7f
         6hPlSMhH1o/ts6ChnLcdbwKOdUcY0Fn5SU+L2Bpyxe8oX+frMuD3AZF4+mXOePiSzKYX
         ArRg==
X-Forwarded-Encrypted: i=1; AJvYcCUFKElHX2cC+y9zr/jMpUJi4qq7fGsfGlF3xcVVF0iSgoLw6omx57esexAMTRZEwyCrA7pNJ6uM26qc@vger.kernel.org, AJvYcCVFGeqGM7MkLbLSCwhKFeVQsnEcFJgjQXTQN0j5wK+AynrbDG0PiQQIHwoWPnIQ99lN5FH50OhrwQkD02P6@vger.kernel.org
X-Gm-Message-State: AOJu0YwOs9IQc0FCKlX+h2B1lKCxLCUhJFzRUywYieEQW4Nb5AUUqOgA
	U9NxRC+0Vul8lXTpXLDL4ZfRunYxSUc3JLq+12PPC7hF51+Se0HoxfZajyrd
X-Google-Smtp-Source: AGHT+IEEQWtPYTw/UAfp3xustQoSg0MSdAth22EFd3NaHj0cAEhDqoMH8t3n/7QUg9JZseSLN9VyCA==
X-Received: by 2002:a05:6512:3caa:b0:539:f827:2fbc with SMTP id 2adb3069b0e04-53d65df7c5cmr11667995e87.26.1730971221265;
        Thu, 07 Nov 2024 01:20:21 -0800 (PST)
Received: from [192.168.1.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826a9b50sm139509e87.182.2024.11.07.01.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 01:20:19 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Thu, 07 Nov 2024 10:19:54 +0100
Subject: [PATCH v6 2/2] dt-bindings: mtd: davinci: convert to yaml
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241107-ondie-v6-2-f70905dc12bf@gmail.com>
References: <20241107-ondie-v6-0-f70905dc12bf@gmail.com>
In-Reply-To: <20241107-ondie-v6-0-f70905dc12bf@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7516;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=qcVQKBxN0F6baKWfAFHd5n9gYoMcBRYNhU4G/s72Xrs=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBnLIZG1343w/337NBzc1ONG4UdeNT8FL9DnYAzN
 CjKDumVhAGJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCZyyGRgAKCRCIgE5vWV1S
 MgqDD/wIYhvhmKLHzq4wjW0lIg4Dgrg/017ks9Vj+CkmlPtLeN4QNsQPGrJ1K1MlAQG22+MfUIA
 dC8iC+khIWro6pEJBKvPi8TBQviJKYHft2cGqQJ+e2k+I4InhQ4lnPtxzu1WV+9cYTXSulTBFZW
 StwzddKVQT8JeBN+Vv9IEIruj1jMzVSV2DSsshQLdE3KhWCxJo43urvBLhSKv2vSqz7TjRXu9Wx
 yvpw4FSTsQCEB/D2KPTUIkLenPoYv2LerenZkpDQ8N6SMgs46K0AjdMSglmYX6MlQ6c4e1P/mC5
 MoDzIO87sW+bNHEaT8uFb7pc/z/5Sah7bjbryiLZ01LFuIvBHaiYmLpJ6OSRxHmLO9h7+OGpNLg
 5ievr0gOpdaEoZz7teL3ig/730QUPr8IEgb7ZVCBQ7JxTHB3MkDlItPg0vln2wUWqvlWkaY6UTu
 eJ4MN9OC5Blna3of1UZ0FYl0gHmRKMA9KwPbvE+KL8tb3X1lQxyme3DJ1hcsQVm9/BmAi2RGAu7
 2Q/EV+KUVxY+o485DhPNPyvBQ6ydB7cChgYPOozsUTiSTuOiwRoK2u49Exq1mQEZwBhoWLB0tzr
 dE32FX15AkThDpDdihFn+xzvsvnkvTmjzsMe5zQE71HK7FZyDGRaiGE7ExjNq/+G0YvfyC/OrF0
 1/ZdcGLXku550vA==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Convert the bindings to yaml format.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 .../devicetree/bindings/mtd/davinci-nand.txt       |  94 ---------------
 .../devicetree/bindings/mtd/ti,davinci-nand.yaml   | 134 +++++++++++++++++++++
 2 files changed, 134 insertions(+), 94 deletions(-)

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
index 0000000000000000000000000000000000000000..fffdaa9bf85ac2ffb1b177bdc693c995d2a8ea20
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/ti,davinci-nand.yaml
@@ -0,0 +1,134 @@
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
+      - description:
+          Access window.
+      - description:
+          AEMIF control registers
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
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
+  - "#address-cells"
+  - "#size-cells"
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
+        reg = <0 0x02000000 0x02000000
+        1 0x00000000 0x00008000>;
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


