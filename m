Return-Path: <linux-kernel+bounces-211865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDA5905875
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D28BB2B903
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE0D181337;
	Wed, 12 Jun 2024 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpTrPoiP"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB3D181321;
	Wed, 12 Jun 2024 16:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718208254; cv=none; b=iLUQux/YrN8RAM0GKKLSldAVQ/0WvPTtx8KxkQFPOXvpb01LhORGiKu5HNtV/OeOnmIbBiv7ku/NvJAOhU+GVC/9ZwX8EFkx+bs/3f8tCYG7VkXsdopRnhTVoEYyDJRqpQCYpngivo7M6lcB6ZZcIFB15/VIxJPVAYd00EdjOZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718208254; c=relaxed/simple;
	bh=KDemYi20FzCyN4R11poSytu7smnSLYTz4hF35CJ5RWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jMRHsg6ir+ZX1cA0yAiYFFUiMTXrLTdy7cetBSV5c2cmY5G4alsLb1LVg2gOVrkgwfUD2yqo2eYDWZ6pHyeYbtQ6Cktn6c/RaNFhSxygVQOA4+pPjWGAGSZAIV1RIqVpEgdFk2LPhgMXx4z1GT3cQnlBnSSFUBFkAmYnSzcIVTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpTrPoiP; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7042cb2abc8so3211052b3a.0;
        Wed, 12 Jun 2024 09:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718208252; x=1718813052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AH50orR5FyIlpjugYepr6bfFOHdgPbrZzYYt/ypEgjU=;
        b=MpTrPoiPiep5+rNGz7sXxHtnjGPxP90pTPDu9O4jHdmGnXy5K459y9k+p5e1WKYaep
         BAQNVECQiUMmw1nIzRNo7+wl0rr61AR7QwxjNW8br8LlMxT+XLuJgv9aF5YO6W6NsMTJ
         4H9poZUzTk1AZ4iqSAj1VklhSNRbH0qzgGnYuHHnAF2MG1uX+hUvmz5vcvHMtvxnpLxL
         hrUgxshFNSEh60bWwEG3VxdimuVlq35YX7ew9TINgAtNM43GJfANNRG9ZqsfmRkRXWNQ
         zYHNQVy65i+TSREfuJjkneHa+TE6FqEJcT16VWPDLYR6AzLMBxSGpWfw0iXBqnA8hQSX
         aw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718208252; x=1718813052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AH50orR5FyIlpjugYepr6bfFOHdgPbrZzYYt/ypEgjU=;
        b=CzBOwr2PdNV768WYRligvvSuVqyxHb1YgI9lV7a2lXlBJkG4rnyzsSfFpB9ZHBNags
         mKmhabNLoKpqwsCOixjz6gdady/JjoGt4V1mCZESGYrgjrZWrwHqpJczw8DQ/lDJ07MY
         lXd5NyA8Wmpn+dVQfZNtfinSbbhtw3ndjppm/E8kcDcr/owz0N6PBgj7EssTpTRBU+lX
         +vuqbBiuOjcvRrFnRYmi+9qNP3ZIKN3IIHgcWjl+3MIfXYvYdnaH/WB9Q3xisQuGWdyh
         xJXLR+4PVAl4STs0AiA4ZSvakwfezwK/+QBcdkYtnLixB1kdKF+FXxFqXmIC36EoPq4h
         0Wbw==
X-Forwarded-Encrypted: i=1; AJvYcCXi6jDgBp439BGPAiohbzz1BnDs+QraMe69XZvJjqBeJo585ceiveQnrdqM3AeNSwfmtBO4Z4mx5MdrUZjZDhpTQcswBuBcyG6qnqRZZnID/kSqmQZRd6SBAm2GPzywieKqE6ryJOn1NA==
X-Gm-Message-State: AOJu0YwNUe9zJxMqdlU9QeOYLFDr5lrBF0x8KqdVpiEnoa2sKRPkVlKA
	chgnMOBy/FAUv9wg3K8q5y6WiMIHOIBS8Yb8DeosSdTMBGaJbQdD
X-Google-Smtp-Source: AGHT+IHc7rN5RhTKgGX+U2xnByt7BB6V+V8NYKfp2g4qSX34Lk1wtCxbkckFHtg4nNii+mCRqOfJPg==
X-Received: by 2002:a05:6a00:a14:b0:6fc:fcc8:cb38 with SMTP id d2e1a72fcca58-705bcf1accamr2931743b3a.33.1718208251825;
        Wed, 12 Jun 2024 09:04:11 -0700 (PDT)
Received: from shresth-aspirea71576g.abesec.ac.in ([139.5.197.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705382784b9sm5911884b3a.48.2024.06.12.09.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 09:04:11 -0700 (PDT)
From: Shresth Prasad <shresthprasad7@gmail.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	sebastian.reichel@collabora.com,
	s.hauer@pengutronix.de,
	cristian.ciocaltea@collabora.com,
	andy.yan@rock-chips.com
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	Shresth Prasad <shresthprasad7@gmail.com>
Subject: [PATCH v2] dt-bindings: phy: rockchip-emmc-phy: Convert to dtschema
Date: Wed, 12 Jun 2024 21:33:37 +0530
Message-ID: <20240612160336.5132-2-shresthprasad7@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert txt bindings of Rockchip EMMC PHY to dtschema to allow
for validation.

Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>
---
Changes in v2:
    - Fixed example
    - Changed file referenced in grf.yaml

Tested against `rockchip/rk3399-firefly.dtb`, `rockchip/rk3399-orangepi.dtb`
and `rockchip/rk3399-pinebook-pro.dtb`.

 .../bindings/phy/rockchip,emmc-phy.yaml       | 79 +++++++++++++++++++
 .../bindings/phy/rockchip-emmc-phy.txt        | 43 ----------
 .../devicetree/bindings/soc/rockchip/grf.yaml |  2 +-
 3 files changed, 80 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip,emmc-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/rockchip,emmc-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,emmc-phy.yaml
new file mode 100644
index 000000000000..f42045389383
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/rockchip,emmc-phy.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/rockchip,emmc-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip EMMC PHY
+
+maintainers:
+  - Shresth Prasad <shresthprasad7@gmail.com>
+
+properties:
+  "#phy-cells":
+    const: 0
+
+  compatible:
+    const: rockchip,rk3399-emmc-phy
+
+  reg:
+    description:
+      PHY register address offset and length in "general register files"
+    maxItems: 1
+
+  clock-names:
+    description: |
+      Although this is not a required property (because most boards can get
+      basic functionality without having access to it), it is strongly
+      suggested.
+    const: emmcclk
+
+  clocks:
+    description:
+      Should have a phandle to the card clock exported by the SDHCI driver.
+    maxItems: 1
+
+  drive-impedance-ohm:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Specifies the drive impedance in Ohm.
+    enum: [33, 40, 50, 66, 100]
+    default: 50
+
+  rockchip,enable-strobe-pulldown:
+    type: boolean
+    description: |
+      Enable internal pull-down for the strobe
+      line.  If not set, pull-down is not used.
+
+  rockchip,output-tapdelay-select:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Specifies the phyctrl_otapdlysec register.
+    default: 0x4
+    maximum: 0xf
+
+required:
+  - "#phy-cells"
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    grf: syscon@ff770000 {
+      compatible = "rockchip,rk3399-grf", "syscon", "simple-mfd";
+      reg = <0x0 0xff770000 0x0 0x10000>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      emmcphy: phy@f780 {
+        #phy-cells = <0>;
+        compatible = "rockchip,rk3399-emmc-phy";
+        reg = <0xf780 0x20>;
+        clocks = <&sdhci>;
+        clock-names = "emmcclk";
+        drive-impedance-ohm = <50>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt b/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
deleted file mode 100644
index 57d28c0d5696..000000000000
--- a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-Rockchip EMMC PHY
------------------------
-
-Required properties:
- - compatible: rockchip,rk3399-emmc-phy
- - #phy-cells: must be 0
- - reg: PHY register address offset and length in "general
-   register files"
-
-Optional properties:
- - clock-names: Should contain "emmcclk".  Although this is listed as optional
-		(because most boards can get basic functionality without having
-		access to it), it is strongly suggested.
-		See ../clock/clock-bindings.txt for details.
- - clocks: Should have a phandle to the card clock exported by the SDHCI driver.
- - drive-impedance-ohm: Specifies the drive impedance in Ohm.
-                        Possible values are 33, 40, 50, 66 and 100.
-                        If not set, the default value of 50 will be applied.
- - rockchip,enable-strobe-pulldown: Enable internal pull-down for the strobe
-                                    line.  If not set, pull-down is not used.
- - rockchip,output-tapdelay-select: Specifies the phyctrl_otapdlysec register.
-                                    If not set, the register defaults to 0x4.
-                                    Maximum value 0xf.
-
-Example:
-
-
-grf: syscon@ff770000 {
-	compatible = "rockchip,rk3399-grf", "syscon", "simple-mfd";
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-...
-
-	emmcphy: phy@f780 {
-		compatible = "rockchip,rk3399-emmc-phy";
-		reg = <0xf780 0x20>;
-		clocks = <&sdhci>;
-		clock-names = "emmcclk";
-		drive-impedance-ohm = <50>;
-		#phy-cells = <0>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 79798c747476..1f88416657cc 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -178,7 +178,7 @@ allOf:
       patternProperties:
         "phy@[0-9a-f]+$":
           description:
-            Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
+            Documentation/devicetree/bindings/phy/rockchip,emmc-phy.yaml
 
   - if:
       properties:
-- 
2.45.2


