Return-Path: <linux-kernel+bounces-395138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8819BB905
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A03A01C21433
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E5E1C07D9;
	Mon,  4 Nov 2024 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btTYNtSh"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1515D1B6D17;
	Mon,  4 Nov 2024 15:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730734282; cv=none; b=aPQTYlji//Ejp7gCHPp252l3+pf7e+g82N7N6+J9Wi5FcIX8BfTKn1iG+pLcno/rb8smFOYnC+BBs0GDiAzpEV0usxuR+rEcCh2rFDa62cfoOQx1ITYEiOdD1lIULGVxqyhR+6O4HjcUpLgPDC5L64mBiVk+jL/ZEbTzoEpPz3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730734282; c=relaxed/simple;
	bh=6YLYmM6YYR9/20z0JtAHvj/9/J+v4uEkl4GdcVwy8DU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aIqo58bHF95lTrJKmdH2oS+07bpZapRFMwFHdwokGy0+BxTdIiySsnfFTSDERfbwhEudwKgS/I1k3nmtDDQYZoMDDt/lfagnBONiq05df5aMANYYmDqkxYhySEB6PrrGSXcO8qQ/4WQI4TW+Zg2kHiLbQDswTxihx9BAWnNSN+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btTYNtSh; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9abe139088so677019666b.1;
        Mon, 04 Nov 2024 07:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730734279; x=1731339079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d/3LogGj4xkkr4o1UTB8qXkiTCCsI8G7HemaQt+AbGo=;
        b=btTYNtShz5nTtpJ6ktW8kymgv2XGyGBgfF8CLUydnZTSMVUg3fmZL5ls49RGmn6qzX
         YOfQvFrpfN6xttpRAq0hV/U0HO2h1VDRjuRUT0YMV3EamLUogFTQtCNoAkFftT3po+8s
         LfVHhjBl2DY2sb7ki9HzF2jpOf9t28lpb0WJZVZVEuACF/6EBbyZJVXzfHzrKnNzzwV7
         jZAwaCJLZJNsdsFXezjLXj2seRvF4idd0BLLOZBY7UY0h1X4e+ZyXJqcll+IRhNtiY2/
         BymW2af0EGAa791SWbNffd5uI89WSfvKWPqX2ie7c+IUnrnvgSCwFHvTjD0UgErvrShK
         HbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730734279; x=1731339079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/3LogGj4xkkr4o1UTB8qXkiTCCsI8G7HemaQt+AbGo=;
        b=eb+hkApSyOoDCiMBCDHfHAH6VhZ0jdR6F5ofM1d4Gz/dur6PvRPye6MCnQ3I5u6IHs
         vMCiTyzrUP99v7QWnLezhb933meIfg0tNsDj/jDiNy3YGJEvYJ8Y9fn34+oksA4lRVgt
         EOA48ev0u280lP1Me7jRHjy6DsJUeHyzmy7MzXn3akq1N9opThjTNkDLjV6QfLK/2ujz
         Z5OIYdO9gYIX06Dgf5pcO2OrC30R3xJRMt81ZJvmn267hsD35xUKYvFmeN8ZmwhpAf06
         V8pim/z736xjBWpJbDQ3MXrCoJJQYSNpK2YfsyQ3jnoc2rWZJ6ISh2J9j8/ORIeTEpBd
         DXRA==
X-Forwarded-Encrypted: i=1; AJvYcCU8BD1ENW9z3/LvvodkxZJeqC/knL9ClH+TGuSEzd0PsQPpuWIFojWpruDnMUWue994x5kDntD8wtZs@vger.kernel.org, AJvYcCWJfSiCMT9TuqgbE4lywcNTAF15bzSv5yFGXs44addXl0NxjoHcxWPtNrBqfUGDdADc9ln5ICTLzeV7@vger.kernel.org, AJvYcCWi0Fyg4oDp32bVEBq+5TXJpMdpJTEvZN7SqPVnvK8i+ZDrBC1GiKSCwoxv/KCs3dMSHnyu/b7CYM0jdlUT@vger.kernel.org
X-Gm-Message-State: AOJu0YwjgIUlWPvpjXP154wgcrobDSbviDBhyDDboBat6m6BrlI6bDNY
	ZTgIL1ykVJ5GXKGHPDb9JLr6HV8P4qm+FmsyTGeq9jPwDo2cclhW
X-Google-Smtp-Source: AGHT+IGRcKbIwGQbBQLPAesO3IxNhJ0Y1eyNVqxLs9jLYjV9pVflKzinTtL7MsseoMNKn2MXv+3bkA==
X-Received: by 2002:a17:907:7f0e:b0:a9a:9df:5580 with SMTP id a640c23a62f3a-a9de5ce6778mr3147777866b.19.1730734279190;
        Mon, 04 Nov 2024 07:31:19 -0800 (PST)
Received: from ivaylo-T580.. (miroral.stz.ddns.bulsat.com. [91.139.249.115])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e56649363sm559817166b.184.2024.11.04.07.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 07:31:18 -0800 (PST)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-actions@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] dt-bindings: clock: actions,owl-cmu: convert to YAML
Date: Mon,  4 Nov 2024 17:31:08 +0200
Message-ID: <20241104153108.3053932-1-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Actions Semi Owl CMU bindings to DT schema.

Changes during conversion:
 - Since all Actions Semi Owl SoCs utilize the internal low frequency
   oscillator as a parent for some clocks, require it.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 .../bindings/clock/actions,owl-cmu.txt        | 52 ----------------
 .../bindings/clock/actions,owl-cmu.yaml       | 61 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 62 insertions(+), 53 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
 create mode 100644 Documentation/devicetree/bindings/clock/actions,owl-cmu.yaml

diff --git a/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt b/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
deleted file mode 100644
index d19885b7c..000000000
--- a/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
+++ /dev/null
@@ -1,52 +0,0 @@
-* Actions Semi Owl Clock Management Unit (CMU)
-
-The Actions Semi Owl Clock Management Unit generates and supplies clock
-to various controllers within the SoC. The clock binding described here is
-applicable to S900, S700 and S500 SoC's.
-
-Required Properties:
-
-- compatible: should be one of the following,
-	"actions,s900-cmu"
-	"actions,s700-cmu"
-	"actions,s500-cmu"
-- reg: physical base address of the controller and length of memory mapped
-  region.
-- clocks: Reference to the parent clocks ("hosc", "losc")
-- #clock-cells: should be 1.
-- #reset-cells: should be 1.
-
-Each clock is assigned an identifier, and client nodes can use this identifier
-to specify the clock which they consume.
-
-All available clocks are defined as preprocessor macros in corresponding
-dt-bindings/clock/actions,s900-cmu.h or actions,s700-cmu.h or
-actions,s500-cmu.h header and can be used in device tree sources.
-
-External clocks:
-
-The hosc clock used as input for the plls is generated outside the SoC. It is
-expected that it is defined using standard clock bindings as "hosc".
-
-Actions Semi S900 CMU also requires one more clock:
- - "losc" - internal low frequency oscillator
-
-Example: Clock Management Unit node:
-
-        cmu: clock-controller@e0160000 {
-                compatible = "actions,s900-cmu";
-                reg = <0x0 0xe0160000 0x0 0x1000>;
-                clocks = <&hosc>, <&losc>;
-                #clock-cells = <1>;
-                #reset-cells = <1>;
-        };
-
-Example: UART controller node that consumes clock generated by the clock
-management unit:
-
-        uart: serial@e012a000 {
-                compatible = "actions,s900-uart", "actions,owl-uart";
-                reg = <0x0 0xe012a000 0x0 0x2000>;
-                interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-                clocks = <&cmu CLK_UART5>;
-        };
diff --git a/Documentation/devicetree/bindings/clock/actions,owl-cmu.yaml b/Documentation/devicetree/bindings/clock/actions,owl-cmu.yaml
new file mode 100644
index 000000000..e9c0dfb94
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/actions,owl-cmu.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/actions,owl-cmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Actions Semi Owl Clock Management Unit (CMU)
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description: |
+  The Actions Semi Owl Clock Management Unit generates and supplies clock
+  to various controllers within the SoC.
+
+  All available clocks are defined as preprocessor macros in
+  include/dt-bindings/clock/ headers.
+
+properties:
+  compatible:
+    enum:
+      - actions,s500-cmu
+      - actions,s700-cmu
+      - actions,s900-cmu
+
+  clocks:
+    items:
+      - description: Host oscillator source
+      - description: Internal low frequency oscillator source
+
+  "#clock-cells":
+    const: 1
+
+  reg:
+    maxItems: 1
+
+  "#reset-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - "#clock-cells"
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        cmu: clock-controller@e0160000 {
+          compatible = "actions,s900-cmu";
+          reg = <0x0 0xe0160000 0x0 0x1000>;
+          clocks = <&hosc>, <&losc>;
+          #clock-cells = <1>;
+          #reset-cells = <1>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 420d06d37..652c9822a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2016,7 +2016,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-actions@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/actions.yaml
-F:	Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
+F:	Documentation/devicetree/bindings/clock/actions,owl-cmu.yaml
 F:	Documentation/devicetree/bindings/dma/owl-dma.yaml
 F:	Documentation/devicetree/bindings/i2c/i2c-owl.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
-- 
2.43.0


