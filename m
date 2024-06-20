Return-Path: <linux-kernel+bounces-223535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BF391149C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 23:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 655931C20EF5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088A0823CE;
	Thu, 20 Jun 2024 21:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8c/B/7M"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7DC7D417;
	Thu, 20 Jun 2024 21:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718918929; cv=none; b=JKjY94E567amcc0NOi54ZNbe/wqkbkeXm0u8e/r58sQjpHS8ozfeO/5WBLIiRSCgrQGqglaz1RldZ8aaTdAtCqsnK3yugHD5DoXCDWzhb3jAOdocrpUL/FqURUWVvJA7dgjRgYULp9sb1HtPC1AsnT+YN6LyOQ2NdIxzG1wh5FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718918929; c=relaxed/simple;
	bh=Z38+JkwIs2hWAd/dtAoKlQVpdg9/KfK9D5srBH71r/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OWA0mgJG2TSsT2OLg7nqx01MGTbZCj8nTq5Y+0zronPZg6ItkpfcrLCnuy7kXmwLo/A5DhEdfULylsTrUWnMnF+OsbA5PKTrZ/lxpqy/n9Uc9nMcYYBBj2Y5c1G1BxuvUZGisM9ITCwplWCfxrT5iTnFj/HVP4IefcIPAwBsRl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8c/B/7M; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2c7c61f7ee3so1169470a91.1;
        Thu, 20 Jun 2024 14:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718918927; x=1719523727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B2IrnnGEnY0PAdsg8+78PSsbMokLJN/NcVtSSSZKo7A=;
        b=J8c/B/7MHsmdOvW1caRKmvErBrT3EdHaKZWdUqTZYB1blNV+0hUEIjVK/dAMeZCeSG
         CmmysS6QThaaHJD6iC8gFDjVdH/+I+Y+M+ADcLEEC99nNS/VCIkoCUlp3mdhnr5s/fAy
         2gajjwX0Jv9ThKzJTUhFuBMX65hgkJN2L8jaDKIV4bNguQGIpmYHAl0DcuV1TZsVk24H
         Ev0rhcQZOay1FYuB3U3u4H3qJS2r2HTP8xCyJ18gb1SO/TC/8N2PjK6BdT29Inq8eJlv
         neBYgtoiGS9MMyWftMja7SswsP1/sQq5sJmIG2B7ChJaEkYr6uc3YQOHHWj2kQ8oyFVb
         LBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718918927; x=1719523727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B2IrnnGEnY0PAdsg8+78PSsbMokLJN/NcVtSSSZKo7A=;
        b=YuTcBQVE0uaPP7cXJ4wNTb/k7Oz3NWsrcIqMc3ukjLeUmosjkDMpE8h4wrB7dECoCf
         lVVmUhA5DxRoQX5CAzwXJrdSCQc6qsdnTIyq5BMKc8uxPPESyS8fO0mVQ0Nq+3kEoOL1
         5jCQPV5lF3SnrZVga/ZfNmLQKfiLbI7lJDPOA/Erm1Ndct2Ick0q4KOAgKB/6xbI6Jtz
         LQS+alw6qQFc6u2evyZtb9+qgPWx+7o1euHtcFds9Ru6xpt9zh02YA4SLfd3RkRMMeyo
         Hbezt5sDVS0g3vkOrwwgApfol9sVzYLroVGg9c0zG1jxP8nLwaXzOqbeTOiuIJ7J9Gd6
         pTiw==
X-Forwarded-Encrypted: i=1; AJvYcCWtLVrB+GGQp/l7Zyjm1pxH+vABzxXvkb/Sj2jEat+wNFgwUe8ruXwWCRnoTh8Y4uGQdnphRDUGS4gR/QyGYazbjCYFleKcb+Je5Gu4sWmjTExJGh40NomRAN5ToSPKpkgLyYsGUqMKQQ==
X-Gm-Message-State: AOJu0Ywwq6vCY0p322SLWj3tnF5A4XjGfgQKcTc78srkRPewSRCmQz9h
	nUoo5ZvcdX8hPc0a2OUFxopVDO+3F9skPAm8nFLa2qGLpJi+xMXE
X-Google-Smtp-Source: AGHT+IH4Mmq3L3BL4GOBwjn22i7w8MWuGPUuZniUS0Ra/uXagWa+InuUen9W/sgAZvNVcMUn5CtXCg==
X-Received: by 2002:a17:90a:4217:b0:2c8:81b:e798 with SMTP id 98e67ed59e1d1-2c8081be805mr1710242a91.30.1718918926729;
        Thu, 20 Jun 2024 14:28:46 -0700 (PDT)
Received: from shresth-aspirea71576g.abesec.ac.in ([139.5.197.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c819a8f68csm147411a91.30.2024.06.20.14.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 14:28:46 -0700 (PDT)
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
Subject: [PATCH v5] dt-bindings: phy: rockchip-emmc-phy: Convert to dtschema
Date: Fri, 21 Jun 2024 02:58:07 +0530
Message-ID: <20240620212806.3011-2-shresthprasad7@gmail.com>
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

Changes in v5:
    - remove myself from maintainers list
    - put `clocks` before `clock-names`
    - remove node lables
    - remove `grf` node from example
    - remove blank lines in grf.yaml
    - add to example in grf.yaml

Tested against `rockchip/rk3399-firefly.dtb`, `rockchip/rk3399-orangepi.dtb`
and `rockchip/rk3399-pinebook-pro.dtb`.
---
 .../phy/rockchip,rk3399-emmc-phy.yaml         | 64 +++++++++++++++++++
 .../bindings/phy/rockchip-emmc-phy.txt        | 43 -------------
 .../devicetree/bindings/soc/rockchip/grf.yaml | 16 ++++-
 3 files changed, 77 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip,rk3399-emmc-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/rockchip,rk3399-emmc-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,rk3399-emmc-phy.yaml
new file mode 100644
index 000000000000..3e3729b1c799
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/rockchip,rk3399-emmc-phy.yaml
@@ -0,0 +1,64 @@
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
+
+properties:
+  compatible:
+    const: rockchip,rk3399-emmc-phy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: emmcclk
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
+    phy@f780 {
+      compatible = "rockchip,rk3399-emmc-phy";
+      reg = <0xf780 0x20>;
+      clocks = <&sdhci>;
+      clock-names = "emmcclk";
+      drive-impedance-ohm = <50>;
+      #phy-cells = <0>;
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
index 79798c747476..78c6d5b64138 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -176,9 +176,10 @@ allOf:
             Documentation/devicetree/bindings/phy/rockchip-pcie-phy.txt
 
       patternProperties:
-        "phy@[0-9a-f]+$":
-          description:
-            Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
+        "^phy@[0-9a-f]+$":
+          type: object
+          $ref: /schemas/phy/rockchip,rk3399-emmc-phy.yaml#
+          unevaluatedProperties: false
 
   - if:
       properties:
@@ -292,6 +293,15 @@ examples:
         #phy-cells = <0>;
       };
 
+      phy@f780 {
+        compatible = "rockchip,rk3399-emmc-phy";
+        reg = <0xf780 0x20>;
+        clocks = <&sdhci>;
+        clock-names = "emmcclk";
+        drive-impedance-ohm = <50>;
+        #phy-cells = <0>;
+      };
+
       u2phy0: usb2phy@e450 {
         compatible = "rockchip,rk3399-usb2phy";
         reg = <0xe450 0x10>;
-- 
2.45.2


