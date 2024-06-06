Return-Path: <linux-kernel+bounces-204902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C80178FF4D7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6026B289775
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E52F47A62;
	Thu,  6 Jun 2024 18:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3sJN3/2"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C35E45C06;
	Thu,  6 Jun 2024 18:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717699346; cv=none; b=kdiawf4j+CqqQqQ//Kwd/lKoYjxtz/idNw/bxYfkhRz7ZF8bC+3FH+Ls/+M/Hr2SncWMxzHNPDCAPMqcPa4PLxqghZyDuO8FUq8CgxK6DKB0qa/POVAzX0s4sRHcrjblgfpTYI/NBjuOPK9iXrG+6k/+p5l1lQehmt11WGblT2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717699346; c=relaxed/simple;
	bh=2h8Vxw5mpU42JmfFgTGuiFo4V0nj7ZmBz9Em/NBHfjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OCHXwb7QLSo+kYbYLwy/mLYRNLUeeOAN/DE+zZTCxIssBZ6jEW7SQ6j2Fa9UMW8E3SvbbDQRonTbPydUx9qvialnKc3wmE79Z+xioStPq15NoaXWK1EA782g2doPfSFfW0lD4PLtOISol8yF73UpJp0WcztGOtwaEI9he7yf+p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3sJN3/2; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f61f775738so11896845ad.2;
        Thu, 06 Jun 2024 11:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717699344; x=1718304144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4iZQmT4vxNQolNnYp5zIseeWy4wyJJ76G+a9PWEi2OQ=;
        b=I3sJN3/2dovvoF5j3ktyW8wodIzy41omvFaLyGgQtoequqXUmsU8pexLTTDxaCETpC
         xoiqywbesixxZReUD+5hzqs7EnC9akSunxK1PdCAZV4U8cTzoZgstNqpiQiq3aAeUcqJ
         1go2NFAN3lfpCGSIUW1vTcLmYor0Y97Lk4ByDfn9/lXo+HM29agm+3prmxGEo0dJ8Mqt
         YdKbju5Tz2EQuMRxZ+z/uN3aZLReqVWEqdfT/iRiBjX4GPSdcro1ErlnfBNlnWKF87E9
         cH3/jTgzLLSUGBkcF0atGBPHwfLAQp6GXOCUMegcnLU61qiR4vOYX3nkNehSvfSd1iq4
         fofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717699344; x=1718304144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4iZQmT4vxNQolNnYp5zIseeWy4wyJJ76G+a9PWEi2OQ=;
        b=tn59N0xT/O8BHFCWktYy1ztCAcTcUlm7HLfg89iFLEaTrLzdIkbOXZbwGZRsFO8wWD
         llsXg/pUuBT2l3uSRqvm5KFd16HqpLjohiQPFGbsg5lQyAkHOmB3t+Plv1/v4vzIK+Ic
         LV/Qf7PHSO8IFdNczE7OqmTciB7Yet5TOvHEJ5gdUnjmlx0LQW2ToyC0r8OMub3KV5LH
         9dnCLlielc/4K/JIzTT9j+RVPoGlyiN/B7XaxRiTkRpWNxsQwmtAzpz4qEftRcgUjn8X
         sn+dpUgZpOl6YSlIViN177PslYcguSQ75vT/BPYJTQeB7cZWa0ZNA+oSyujNvKLGIVKJ
         RWEw==
X-Forwarded-Encrypted: i=1; AJvYcCUpTSxAtGmZpUMB6xCZRhFVm4D7YHO3wPLno1qtlGGusxg/qJN9+jtShsWge9EVJRYHtX5aClBTieVW7dTLYrqEBZ5XCF5n96hUW4xSM4CCm2cSCStGqLVbWgZB3h+1G4dt0fU6z9SjvQ==
X-Gm-Message-State: AOJu0YwRAWtRpsw/LkQQ3RvCNl8XC6io+pQzJu/lNYvpYTXzsH1URSQN
	xOtCCFCroxxtQXJwhc1cTOxVnAQPAxf4nJ+sKFicy8Gg0OUZPMXD
X-Google-Smtp-Source: AGHT+IFkQ8Z6wzTxzhMDbB5Ba2CM0TWh/R5abXx0fHzeL39jtPW0SNgr7hl/LnynWuc0TSMqC4UxAg==
X-Received: by 2002:a17:902:e849:b0:1f6:6c3f:1664 with SMTP id d9443c01a7336-1f6d0301bb0mr4632405ad.38.1717699344437;
        Thu, 06 Jun 2024 11:42:24 -0700 (PDT)
Received: from shresth-aspirea71576g.abesec.ac.in ([117.55.241.163])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd81bca0sm18446625ad.305.2024.06.06.11.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 11:42:24 -0700 (PDT)
From: Shresth Prasad <shresthprasad7@gmail.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	Shresth Prasad <shresthprasad7@gmail.com>
Subject: [PATCH] dt-bindings: phy: rockchip-emmc-phy: Convert to dtschema
Date: Fri,  7 Jun 2024 00:11:36 +0530
Message-ID: <20240606184135.11065-2-shresthprasad7@gmail.com>
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
Tested against `rockchip/rk3399-firefly.dtb`, `rockchip/rk3399-orangepi.dtb`
and `rockchip/rk3399-pinebook-pro.dtb`.

 .../bindings/phy/rockchip,emmc-phy.yaml       | 78 +++++++++++++++++++
 .../bindings/phy/rockchip-emmc-phy.txt        | 43 ----------
 2 files changed, 78 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip,emmc-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/rockchip,emmc-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,emmc-phy.yaml
new file mode 100644
index 000000000000..bd8485c77bfe
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/rockchip,emmc-phy.yaml
@@ -0,0 +1,78 @@
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
+    grf {
+      compatible = "rockchip,rk3399-grf", "syscon", "simple-mfd";
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
-- 
2.45.2


