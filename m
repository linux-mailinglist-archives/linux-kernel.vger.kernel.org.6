Return-Path: <linux-kernel+bounces-212898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B42F29067EE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4590F289B56
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6052D13D63A;
	Thu, 13 Jun 2024 09:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChICw35f"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283AC13D606;
	Thu, 13 Jun 2024 09:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718269229; cv=none; b=nstEYkeCnYh52s3SzuRNtCfPv/4qclJgvhnLvWQiB5F0i6R3z/y/GH1RBBcdr6YV7s5VTZ/xSwPF5Qe4Cf7RbKlbMJG+uJRG3q8jsyiPHMYTGT8lgdTmj6It4bMpguNWQ0aETlAoOR+5NiyFDT12WZ576hoPNx9fP9ezHYXMvOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718269229; c=relaxed/simple;
	bh=i1s0CMgeIj1Qw46N3a4uDY6KX6KnPecOSSqz66sUL08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MQYOYV6AwBeKZsVOcs0871Cya+ObhJR+I3qeR9Q0TvdEwFIfLq10w28dcoH4un2FP+wd+ZDPgt/vI5s05uu0Ys/si/zlcUz8NBufnAPVS06XM5JQ8R85oOf9vfq92tz3KT041oS7fAoErdEzhUxiNCaCt9l/EhUyUpGrOnw6gP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChICw35f; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f6c7cdec83so7281765ad.0;
        Thu, 13 Jun 2024 02:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718269227; x=1718874027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SxIVzyf9PimEVOucHthqxn21ESGQccRm+KuqO9GK610=;
        b=ChICw35f8Xp7C/bsipbBKOfmkwgAKfKtUzjyeqDMPVaooMTtrTw/qjNhazdBRZEUCA
         7ILpGChxzYSyL4UTBDe4KLq0eqxXloBJtEiQteRRdJkP0RZ+U2I7ZWoJTZXOiUuJxSrm
         xbgpr0KygVjUoUjHNdJCQdfp7n/a4QGUp+9odlR4docWKegEzbZi/j95DQhlZh3H421+
         AFTUn/1VZLLtovhxSRBc2N935BDEE5AkelGrqUwRolqGJ4fKuYYRjCCQK53e2vwe0xQT
         /Ga5Hq/QP0QGVPhfNucm2REdCmkLAC6QHyMNoJdm0asAJZUESW5PRB6oeIt6nzJSKniQ
         /D8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718269227; x=1718874027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SxIVzyf9PimEVOucHthqxn21ESGQccRm+KuqO9GK610=;
        b=uK71/x6VA4uhdNEw8mDclwQE6CWkd1H5D7J8HEoX8ex+++PoCABYK+qaA+IUOqVScu
         XYcoxUKtJMoJIBWbdH6ZIwq3B7Pqwcp/cCGN0am4PlullUZWgS/KBua2iHoapSwciann
         7ZSmfxpo8G5eGMhOaD0aQL2+Cf61BYYiU4k/YH26emBJBWAzjCI76g823cl0mZm/ZKwV
         kB74Vn6CxFvNi/GAihRC71dXhCxXMT08Z270Ec/EZGk+muQmDKg6ng7v+qvNBM81asTx
         43dr/pzLu9wTGfVwZUn6SPSFa+NyTpBeBMReNOLfRtFHlvuCCRNf2csXU9hQlgN3PO8C
         BZWw==
X-Forwarded-Encrypted: i=1; AJvYcCXjjt7wAsQB7IEpSfagCXuenalSWsTYixZX+wHDw3RJQZ7iYZh4lBGQ1TRxxZwwnZus55clhGsV3kEB4kP847YBFfybOvIFalKwdlh53S3Wgq1f4oQIDUGzo04KfCHJGJ7yzP4C/egNCA==
X-Gm-Message-State: AOJu0YwSHAPDk5KEk9esAhhhgpi0fEExXn10aYo8mDfm7T3YIJ96ulnf
	IFtg56P4iId2c8NRgAZ6jIx8kFnMhhM2h1q+hqcAD63E2MMGSjcY
X-Google-Smtp-Source: AGHT+IHebA6zUpF1OzPjp9lAJ5eM6arVSXRTaiJFDOXPT4G11C9bXRMGbkEWnrg5Ozkc/q2yoyktKA==
X-Received: by 2002:a17:903:2281:b0:1f7:126:5bab with SMTP id d9443c01a7336-1f83b6ca36emr41855705ad.40.1718269227364;
        Thu, 13 Jun 2024 02:00:27 -0700 (PDT)
Received: from shresth-aspirea71576g.abesec.ac.in ([139.5.197.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855ee6a7bsm8575765ad.159.2024.06.13.02.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 02:00:26 -0700 (PDT)
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
Subject: [PATCH v3] dt-bindings: phy: rockchip-emmc-phy: Convert to dtschema
Date: Thu, 13 Jun 2024 14:28:13 +0530
Message-ID: <20240613085812.4020-2-shresthprasad7@gmail.com>
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
Changes in v3:
    - fix `reg` in example being too long

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
index 000000000000..85d74b343991
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
+      reg = <0xff770000 0x10000>;
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


