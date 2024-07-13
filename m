Return-Path: <linux-kernel+bounces-251492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B40C930586
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 14:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC0FC2825C7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 12:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07507130A66;
	Sat, 13 Jul 2024 12:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqB1qdRR"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCBB53389;
	Sat, 13 Jul 2024 12:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720872779; cv=none; b=nBTH9XseuRylB7tWQnwTRbQlf2ZPOh31yeD7vdowdMdVMn93WzINGEZR9WkmvN209vxeJbwsJIAOubcqGw0SlhgNXEg1mnCjQjCmIK6kAcLpyQTHud4byV0ewVuK0/xnzSek7ihq+1axazcD0CECauCuGbSidvLRaq0StXp50r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720872779; c=relaxed/simple;
	bh=hHfwLIJ0FH+SbJdaPZgAvy7dYEUtEaKCpGLPLUOuUok=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=E/tnDW/Qveo0G1tktlbiCpycjSOBFjI1/ogRVWulGFW1xmHk4h483WJc7Ou57gqmfxPuUTINNdMNn8AEFEgsUkDWoS6GSlb5IE7JknbKeJP76T2wyFdFmtzXDdUqdoqCXEZcI2tCTnoiaTeskB77FlraKQfxYYYbcTG5TCH3tHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqB1qdRR; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-367a3d1a378so2420962f8f.1;
        Sat, 13 Jul 2024 05:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720872776; x=1721477576; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ufVYtDc7G7PuycxxzlcwPvFM8/Ac5PF0pinaAK0zLlw=;
        b=iqB1qdRRXIEHb+GwAtcKFnEYGMz33be03pKQkPcN3gT3lOeJ38TtOuPiniTwh/zGQz
         bU2vak/CRr8Jh+HiHA7C/6Ac26hYScPDGK+C0z9mE9R4w1ZgvTeIh1dmKspKzyBCTatz
         29Ib5LB4L7zioGOCt6d7xjGpUjp2avRhgEaJ0FcjwCryK/PypkjcMb8LtYjuTZvLFqqL
         SFpPW+cuVAeBxBRxYVvHMrwIZYpx8NmxqamWUxQA650WP/F4YibqScS3FIHIv5c+afqa
         ve0m50z+u1mkicViZ5POUrKd9yoCzynBSA217yEXcwPRQSW1AYNUuMIaTycRGqudU/uX
         TZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720872776; x=1721477576;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ufVYtDc7G7PuycxxzlcwPvFM8/Ac5PF0pinaAK0zLlw=;
        b=b6at0qidrlcTs0K60ay3uIWt94TWW4rdw51xsCdFyaGDGticrxHl8iyb5oph5lRFXM
         khwI1D/R/ZUMPJNxbqmGJlYoO4ciYceCUXjzLDcp/geDgcW7JU6Or1APn2KTZHCyvEiB
         aINzD80+fKQI5LUb5NSL9IplJIeQOglVkKjG9jwACXGfLC/nhcI759pwK0m9cQOMpTcr
         5AfKYoywOy4RsUHLnNW1OG/EpME+0/FG33GKL6OmhReRY0vlhMuEbKYQ2pj1XV91PJRQ
         f4NoTeE3RJVEBVEewIFb1iuuXYMHVnFEoVyhgwEiCpyKs77X9kJayJj6lQPcyXn9aUTC
         GUWA==
X-Forwarded-Encrypted: i=1; AJvYcCVzfunDVeP6Su/l0OJv0YxnKS+tAavaSxKepne3oeoF68t4iPn328EiznEx99sZyNXmaowIV8yE8wg3YiYSdVKoZTHqJjGSYAnSNzyr
X-Gm-Message-State: AOJu0YxuOVUXyi38/Owq5EqC1E6x26ubVa/OQ4a6UTHv7w4N+g4UMej0
	7YdS/qeIUPyPGlm/7hpM29Cbsba4TE3SgIQxulpIT2N3MyLNnKVb
X-Google-Smtp-Source: AGHT+IFAfvrMYHgTFmGI9NjEPMRXhsDXySxFbpwVSMR3d2UTjfV674MzhTHpyTL+TWlsxkaXpHyu3w==
X-Received: by 2002:a5d:47c3:0:b0:368:5be:2bf9 with SMTP id ffacd0b85a97d-36805be2c4dmr4458696f8f.24.1720872775373;
        Sat, 13 Jul 2024 05:12:55 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f25babbsm52609325e9.20.2024.07.13.05.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 05:12:55 -0700 (PDT)
Date: Sat, 13 Jul 2024 14:12:53 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolin Wang <baolin.wang7@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: nvmem: sprd-efuse: convert to YAML
Message-ID: <ZpJvRePtbaiG94Te@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert the Spreadtrum eFuse bindings to DT schema. Since they are very
similar, both of the existing Spreadtrum txt bindings were merged into
one common binding document, named after the only in-tree user, SC2731.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 .../bindings/nvmem/sc27xx-efuse.txt           | 52 -----------
 .../bindings/nvmem/sprd,sc2731-efuse.yaml     | 88 +++++++++++++++++++
 .../devicetree/bindings/nvmem/sprd-efuse.txt  | 39 --------
 3 files changed, 88 insertions(+), 91 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/nvmem/sc27xx-efuse.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/sprd,sc2731-efuse.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/sprd-efuse.txt

diff --git a/Documentation/devicetree/bindings/nvmem/sc27xx-efuse.txt b/Documentation/devicetree/bindings/nvmem/sc27xx-efuse.txt
deleted file mode 100644
index 586c08286aa9..000000000000
--- a/Documentation/devicetree/bindings/nvmem/sc27xx-efuse.txt
+++ /dev/null
@@ -1,52 +0,0 @@
-= Spreadtrum SC27XX PMIC eFuse device tree bindings =
-
-Required properties:
-- compatible: Should be one of the following.
-	"sprd,sc2720-efuse"
-	"sprd,sc2721-efuse"
-	"sprd,sc2723-efuse"
-	"sprd,sc2730-efuse"
-	"sprd,sc2731-efuse"
-- reg: Specify the address offset of efuse controller.
-- hwlocks: Reference to a phandle of a hwlock provider node.
-
-= Data cells =
-Are child nodes of eFuse, bindings of which as described in
-bindings/nvmem/nvmem.txt
-
-Example:
-
-	sc2731_pmic: pmic@0 {
-		compatible = "sprd,sc2731";
-		reg = <0>;
-		spi-max-frequency = <26000000>;
-		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		efuse@380 {
-			compatible = "sprd,sc2731-efuse";
-			reg = <0x380>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			hwlocks = <&hwlock 12>;
-
-			/* Data cells */
-			thermal_calib: calib@10 {
-				reg = <0x10 0x2>;
-			};
-		};
-	};
-
-= Data consumers =
-Are device nodes which consume nvmem data cells.
-
-Example:
-
-	thermal {
-		...
-		nvmem-cells = <&thermal_calib>;
-		nvmem-cell-names = "calibration";
-	};
diff --git a/Documentation/devicetree/bindings/nvmem/sprd,sc2731-efuse.yaml b/Documentation/devicetree/bindings/nvmem/sprd,sc2731-efuse.yaml
new file mode 100644
index 000000000000..98d1400991d7
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/sprd,sc2731-efuse.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/sprd,sc2731-efuse.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Spreadtrum eFuse
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - sprd,sc2720-efuse
+      - sprd,sc2721-efuse
+      - sprd,sc2723-efuse
+      - sprd,sc2730-efuse
+      - sprd,sc2731-efuse
+      - sprd,ums312-efuse
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: enable
+
+  hwlocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - hwlocks
+
+allOf:
+  - $ref: nvmem.yaml#
+  - $ref: nvmem-deprecated-cells.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: sprd,ums312-efuse
+    then:
+      required:
+        - clocks
+        - clock-names
+    else:
+      properties:
+        clocks: false
+        clock-names: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pmic {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      efuse@380 {
+        compatible = "sprd,sc2731-efuse";
+        reg = <0x380>;
+        hwlocks = <&hwlock 12>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        /* Data cells */
+        fgu_calib: calib@6 {
+          reg = <0x6 0x2>;
+          bits = <0 9>;
+        };
+
+        adc_big_scale: calib@24 {
+          reg = <0x24 0x2>;
+        };
+
+        adc_small_scale: calib@26 {
+          reg = <0x26 0x2>;
+        };
+      };
+    };
+...
diff --git a/Documentation/devicetree/bindings/nvmem/sprd-efuse.txt b/Documentation/devicetree/bindings/nvmem/sprd-efuse.txt
deleted file mode 100644
index 96b6feec27f0..000000000000
--- a/Documentation/devicetree/bindings/nvmem/sprd-efuse.txt
+++ /dev/null
@@ -1,39 +0,0 @@
-= Spreadtrum eFuse device tree bindings =
-
-Required properties:
-- compatible: Should be "sprd,ums312-efuse".
-- reg: Specify the address offset of efuse controller.
-- clock-names: Should be "enable".
-- clocks: The phandle and specifier referencing the controller's clock.
-- hwlocks: Reference to a phandle of a hwlock provider node.
-
-= Data cells =
-Are child nodes of eFuse, bindings of which as described in
-bindings/nvmem/nvmem.txt
-
-Example:
-
-	ap_efuse: efuse@32240000 {
-		compatible = "sprd,ums312-efuse";
-		reg = <0 0x32240000 0 0x10000>;
-		clock-names = "enable";
-		hwlocks = <&hwlock 8>;
-		clocks = <&aonapb_gate CLK_EFUSE_EB>;
-
-		/* Data cells */
-		thermal_calib: calib@10 {
-			reg = <0x10 0x2>;
-		};
-	};
-
-= Data consumers =
-Are device nodes which consume nvmem data cells.
-
-Example:
-
-	thermal {
-		...
-
-		nvmem-cells = <&thermal_calib>;
-		nvmem-cell-names = "calibration";
-	};
-- 
2.34.1


