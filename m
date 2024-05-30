Return-Path: <linux-kernel+bounces-195289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF7D8D4A1B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 13:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53C6CB2246D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E841316F83D;
	Thu, 30 May 2024 11:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdoQIjw0"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC89E16EBE7;
	Thu, 30 May 2024 11:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717067552; cv=none; b=WKpz13bruj9PNe/hfEyxbmFeKFbFysdP/abc8PcLsIwQbMLhDfPJkvwHPmlCl8uSMZfPsqIaMXtfiS0Zdn6ezhfF5qG918nDDot59TSKNBD4hC3fgzO/rHjOTKbC/99kltpCCe6DzXHxD3/8GnL15xM+ItLYJbtgOWtm96uVohE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717067552; c=relaxed/simple;
	bh=3cP0CgNH4/p1G4UHNV7GH84DsDeHOaCfd0R7VXpcYT8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uQghD0MAVgcvYBLIQQSkXpwH8Zq+zj425RpZxj8MEEECG+e5vTcdIyHXt+q7ZpnSeZeCrKnyZajWjW9nG60lMZniJTl6lmH0TWJWGt4mnMPjH7/f7anzQ655w5CSJ0QSFHwZWNeBuocli7Qw4NBCuAASHajlQBmkAB4tQ421hUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdoQIjw0; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f4c7b022f8so6702935ad.1;
        Thu, 30 May 2024 04:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717067550; x=1717672350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EA3a+jjuJJiEg+h/Kepfr2XA8pktXgAA0MuF28rf4EU=;
        b=FdoQIjw0wqrojFugsImsCexAearDSs7uJJYauMGBV+y1MJFNRo9G3Y3yfD9j1Ik0lw
         jCZEmQ2v9GNgxgwBLbGJPxN6LaeLPGTpzG864btMS8JkKlRB8+6l3pIP1ziLhZ1GuVEN
         7b6KeT5pvVe2qp0SB7LX5OzuCxe/a5MlGLRngTUFPmqrEw6zaamvXpKFlEt+6UBTQ0mI
         ypKzwa8mQfoqdMLsqlAaXk4Hk8noSWXapXPhoEfGWyCLc07IX8xV6ld/VZad0jy79//4
         PjmKexd3WKs693zVUbiHpLPV4Ph+ni62y4x5l9gksuCF5FDuc9suCKS/tcOKY9gTLhTL
         pIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717067550; x=1717672350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EA3a+jjuJJiEg+h/Kepfr2XA8pktXgAA0MuF28rf4EU=;
        b=d3f7i+yN44aV+sjhw9FwI56Rrr5vKQ0nMz7IVbXALEoybNP2GZCRcd2KCPPYjHij46
         HTEI45Y7JuXLgjimZHlQoOQdQtVcQzW674G9OLl3nFoGtdzHrDXygi0CSqWn4yNpo0Zd
         sVWsNduX2PmgdYGeodTwl5kdGZTXSOgSBZXEgpSGFxMeQPah+SP2WmkmzztckPF98/iQ
         9i7wrOVZDa4CO1C4YdIWRz9dPgOoFES/tgm1gKAlk5PguaYzDcROTquj1ICFKi32DeQI
         plKbfBs7gL0dV1OczFpwm8wdwkFMdvAe8dSCRH3XXvVn3bijRaVMI0K1Un/rndMDXzKk
         BcMw==
X-Forwarded-Encrypted: i=1; AJvYcCWmLRSmCI4+hQ99DGxQYO0miR24vWkkQNd+zfn8m/hPH9Sci6FEemg46iRf4OWf5E6bY8gLVNpYvqLrJxAR2cyzH5YU7ACGyQr3QkDvVJ72vCn+ldI2Dk3DMV55hw1rKAOmx5s73/mpxXyD4jemLzndbHP0DM8JjDRrJHiZ3ExZNdJfjLZ4
X-Gm-Message-State: AOJu0YzWox7p26R1js+ZmKcaT/0+3wCedohzeGKwHYlklt+529cqBXWN
	VSWIKlKk5dDFc6zaO9gKxirG4o9NuqRJtYCCcmbLj2YGrvzl+PrG
X-Google-Smtp-Source: AGHT+IEjGR6+KySqWy27uKGkPdNOVsFChacN4OY4gwyrrv3G6NoigEhCr6rlgVuy5apEs6D3TvQeNA==
X-Received: by 2002:a17:902:ce90:b0:1f4:64d6:919d with SMTP id d9443c01a7336-1f619b2d1e4mr18128265ad.66.1717067550003;
        Thu, 30 May 2024 04:12:30 -0700 (PDT)
Received: from localhost.localdomain ([103.14.183.213])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f49932961csm75960795ad.79.2024.05.30.04.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 04:12:29 -0700 (PDT)
From: Mighty <bavishimithil@gmail.com>
To: 
Cc: peter.ujfalusi@gmail.com,
	Mithil Bavishi <bavishimithil@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lopez Cruz <misael.lopez@ti.com>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6] ASoC: dt-bindings: omap-mcpdm: Convert to DT schema
Date: Thu, 30 May 2024 16:42:05 +0530
Message-Id: <20240530111205.1764-1-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mithil Bavishi <bavishimithil@gmail.com>

Convert the OMAP4+ McPDM bindings to DT schema.

Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
---
Changelog v6:
- Add dma property
- Add dma-names property
- Add reg-names property
- Remove ti,hwmods completely (no longer needed since the sysc
  conversion)
- Update example to match one in DTS

Changelog v5:
- Add imports for constants
- Add desc to ti,hwmods

Changelog v4:
- Changed maintainer name
- Use $ref and enum in ti-hwmods property
- Make clocks property only have maxItems, no description
- Add items to clock-names
- Fix address of node in example
- Remove extra line

 .../devicetree/bindings/sound/omap-mcpdm.txt  | 30 --------
 .../bindings/sound/ti,omap4-mcpdm.yaml        | 73 +++++++++++++++++++
 2 files changed, 73 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/omap-mcpdm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml

diff --git a/Documentation/devicetree/bindings/sound/omap-mcpdm.txt b/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
deleted file mode 100644
index ff98a0cb5..000000000
--- a/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-* Texas Instruments OMAP4+ McPDM
-
-Required properties:
-- compatible: "ti,omap4-mcpdm"
-- reg: Register location and size as an array:
-       <MPU access base address, size>,
-       <L3 interconnect address, size>;
-- interrupts: Interrupt number for McPDM
-- ti,hwmods: Name of the hwmod associated to the McPDM
-- clocks:  phandle for the pdmclk provider, likely <&twl6040>
-- clock-names: Must be "pdmclk"
-
-Example:
-
-mcpdm: mcpdm@40132000 {
-	compatible = "ti,omap4-mcpdm";
-	reg = <0x40132000 0x7f>, /* MPU private access */
-	      <0x49032000 0x7f>; /* L3 Interconnect */
-	interrupts = <0 112 0x4>;
-	interrupt-parent = <&gic>;
-	ti,hwmods = "mcpdm";
-};
-
-In board DTS file the pdmclk needs to be added:
-
-&mcpdm {
-	clocks = <&twl6040>;
-	clock-names = "pdmclk";
-	status = "okay";
-};
diff --git a/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml b/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml
new file mode 100644
index 000000000..cdea0a008
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/ti,omap4-mcpdm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: OMAP McPDM
+
+maintainers:
+  - Misael Lopez Cruz <misael.lopez@ti.com>
+
+description:
+  OMAP ALSA SoC DAI driver using McPDM port used by TWL6040
+
+properties:
+  compatible:
+    const: ti,omap4-mcpdm
+
+  reg:
+    items:
+      - description: MPU access base address
+      - description: L3 interconnect address
+
+  reg-names:
+    items:
+      - const: mpu
+      - const: dma
+
+  interrupts:
+    maxItems: 1
+
+  dmas:
+    maxItems: 2
+
+  dma-names:
+    items:
+      - const: up_link
+      - const: dn_link
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: pdmclk
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - dmas
+  - dma-names
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    mcpdm@0 {
+      compatible = "ti,omap4-mcpdm";
+      reg = <0x0 0x7f>, /* MPU private access */
+            <0x49032000 0x7f>; /* L3 Interconnect */
+      reg-names = "mpu", "dma";
+      interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-parent = <&gic>;
+      dmas = <&sdma 65>, <&sdma 66>;
+      dma-names = "up_link", "dn_link";
+      clocks = <&twl6040>;
+      clock-names = "pdmclk";
+    };
-- 
2.34.1


