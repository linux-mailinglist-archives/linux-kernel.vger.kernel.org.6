Return-Path: <linux-kernel+bounces-216940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A1590A8D3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3237C1F23CDE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE49F19066E;
	Mon, 17 Jun 2024 08:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2odm/ET"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F54C171B0;
	Mon, 17 Jun 2024 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718614579; cv=none; b=qhMQLimfMOr5J2ARiUJY5OUxU2vtkV/ah9zMDDBxVdVIGvtgnFqOa+GHAQORQR6KF6tOnYjioKsO/HsPqZ9MxTX2kJGC8if0u/vxhX9jLgwM2/of2MUAKfp4yZVT3bibSjui6ho3Atb83ALNSiGLwsVnChMFKsHjEmhN7Payl4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718614579; c=relaxed/simple;
	bh=Oui3HoXK55nnW0IUGIdFKPDnIg/Y9ztYiH1xOpz6wYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nb7nADuDfp8lBEaV0thx6rOyDb9/MrckZXXFyJ2jj4V0M/KBx1Gb/2KX79lGc+mRriQ1mraXqWsHG+a5GzllSJNg4xEBg0xfWY6I3+XKLLx+r+UJmg+95fiJbalrAgI6BkOtxrMUJfccCJ5qTssgmZQ3S/cneABDEDORLRyNyHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2odm/ET; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f44b5b9de6so32597755ad.3;
        Mon, 17 Jun 2024 01:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718614578; x=1719219378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Px2F5O/xlFYH5rKqkkkLF6gjhpLOgiX0YoFm/7eZqRY=;
        b=f2odm/ET1zOHL8QADMp0lEn9Q2LE86N2blYnkH2zxLUDN2oQUS/IdqucHwCaUdz/81
         xNM5L8caHDcehNEGl8MUW39CKtXoQdNEgt+MerPy7Pnw+oN6JUPWakoqRRtwZXqk/PLi
         KpkN9y2XmeiSc3wMGCurhfTcELaXE4wOVEYizYX2R0KcE8qXHSPDVdGNube43HF3nYje
         CTm0YEnFuYN2oyKM7cRsZE/oaGkOlBQWRvYN4kA8M6yHCTlTKz4BGwNWNihmVjUtpoiQ
         EBDr5QZ8lHD72wboiRey3c1a1vgKunCmhdG90QqrnpMEXOJ0pxZbQBEUzcoUCSVKsed1
         TDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718614578; x=1719219378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Px2F5O/xlFYH5rKqkkkLF6gjhpLOgiX0YoFm/7eZqRY=;
        b=NlLGaabVzGEo44pFfp7oDpyGEmhEKm12QrDD0R3PddNIfhN8gJdzbaRS1M+Yxi/cNi
         S46qXgNIGavMzG71JC9nSgyPfar/cKn6DzNFK4oMjZsVn78pZhCeliq5TUI0TV6pSCCG
         6vXN5xhDWo6Lo7zSzoEBuwwAqLNmwcuGnmA3JDqVA5SluRxHaFNajoJzVNbyxzSaKkGD
         2JgIVTwJr7VWBW0cQIGM1hCJ2FKt0t9F++EznN4XltHg+22n8HzxI071yoYrga3xgRjb
         0qRc+htIby6kCva3/CGK9Z4EuyP38sJfyMZY+/0P2OYOevVnD440SIruqVWSLikmHVJv
         aYsA==
X-Forwarded-Encrypted: i=1; AJvYcCXgsdktkWlo48d5fl62RMXan+Th2rhjYUsrXL+KX037ErQgAiqWVRPrSu/1pTGc9PQnD4rlgjSIL9+kLGJ+IDlpQq3eNyTbkVwAOtijNR5nB/RKv1BT+xQ1jazq2ZsKtfFiNXLkQpo/9A==
X-Gm-Message-State: AOJu0YyMxt8Gl1ZNNXwGtBGp9cE2lFrVcotRxIIkV4ntQ0Cgs62jfUTS
	FQhGwqKj8DBmKi9IzZJ81ifgd4NuLvj/J3q+sZ9U+SV2MW9gZ80n
X-Google-Smtp-Source: AGHT+IHeVjWVii646asJCpvxGnP4VmV3AlDIExZwWwDrivS9N4JaJa0DteWgOnOA+8uSzFbLsrsErQ==
X-Received: by 2002:a17:903:22c5:b0:1f7:e32f:f067 with SMTP id d9443c01a7336-1f862a1694emr96194705ad.50.1718614577443;
        Mon, 17 Jun 2024 01:56:17 -0700 (PDT)
Received: from localhost.localdomain ([122.161.50.215])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f28fd8sm75407295ad.252.2024.06.17.01.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 01:56:16 -0700 (PDT)
From: Shresth Prasad <shresthprasad7@gmail.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	sebastian.reichel@collabora.com,
	andy.yan@rock-chips.com,
	s.hauer@pengutronix.de,
	jbx6244@yandex.com
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	javier.carrasco.cruz@gmail.com,
	skhan@linuxfoundation.org,
	Shresth Prasad <shresthprasad7@gmail.com>
Subject: [PATCH v4] dt-bindings: phy: rockchip-emmc-phy: Convert to dtschema
Date: Mon, 17 Jun 2024 14:23:42 +0530
Message-ID: <20240617085341.34332-2-shresthprasad7@gmail.com>
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
Request for an Ack from the PHY maintainers, so that the DT maintainer Heiko 
can merge it to grf.yaml in the order that he likes.

Changes in v4:
    - change license to `GPL-2.0-only`
    - change dt-binding file name
    - remove descriptions
    - move `#phy-cells` to the bottom
    - add Heiko to maintainers
    - fix `patternProperties` regex in grf.yaml
    - change `description` to `$ref` in grf.yaml

Tested against `rockchip/rk3399-firefly.dtb`, `rockchip/rk3399-orangepi.dtb`
and `rockchip/rk3399-pinebook-pro.dtb`.
---
 .../phy/rockchip,rk3399-emmc-phy.yaml         | 72 +++++++++++++++++++
 .../bindings/phy/rockchip-emmc-phy.txt        | 43 -----------
 .../devicetree/bindings/soc/rockchip/grf.yaml |  9 ++-
 3 files changed, 78 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip,rk3399-emmc-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/rockchip,rk3399-emmc-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,rk3399-emmc-phy.yaml
new file mode 100644
index 000000000000..e61ba2b0abcd
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/rockchip,rk3399-emmc-phy.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/rockchip,rk3399-emmc-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip EMMC PHY
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+  - Shresth Prasad <shresthprasad7@gmail.com>
+
+properties:
+  compatible:
+    const: rockchip,rk3399-emmc-phy
+
+  reg:
+    maxItems: 1
+
+  clock-names:
+    const: emmcclk
+
+  clocks:
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
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    grf: syscon@ff770000 {
+      compatible = "rockchip,rk3399-grf", "syscon", "simple-mfd";
+      reg = <0xff770000 0x10000>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      emmcphy: phy@f780 {
+        compatible = "rockchip,rk3399-emmc-phy";
+        reg = <0xf780 0x20>;
+        clocks = <&sdhci>;
+        clock-names = "emmcclk";
+        drive-impedance-ohm = <50>;
+        #phy-cells = <0>;
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
index 79798c747476..6e1b1cdea680 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -176,9 +176,12 @@ allOf:
             Documentation/devicetree/bindings/phy/rockchip-pcie-phy.txt
 
       patternProperties:
-        "phy@[0-9a-f]+$":
-          description:
-            Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
+        "^phy@[0-9a-f]+$":
+          type: object
+
+          $ref: /schemas/phy/rockchip,rk3399-emmc-phy.yaml#
+
+          unevaluatedProperties: false
 
   - if:
       properties:
-- 
2.45.2


