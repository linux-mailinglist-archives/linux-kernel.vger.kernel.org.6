Return-Path: <linux-kernel+bounces-400103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD789C0904
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 987B91F22FE3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB5F212F09;
	Thu,  7 Nov 2024 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgEAApSE"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4876212EF4;
	Thu,  7 Nov 2024 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730990081; cv=none; b=egk6dPg4dauq0HpFhdkk1JhmGHDIIUKXjzIz7ze0/WJSweIx3+Y+TUn0FAgSg2P6jMcIDdPNzr09SEKmCivQj1Vn8i0jr9NXqaMZZlup4YSG8ZO6oMuV0QC2QgsIf52YyXYFofAWHcu9qV5fW8sT4CDjJefnYaPHq1+mDMTRPMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730990081; c=relaxed/simple;
	bh=+VXnf4L4+EUCWLwDDfo++V6wLUGKACpR+5t67b887/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KUjvuOD7DGDMO3WQ7l5BTslTfsYgp4NaWDQclKckdxk8z1fRXe2r7uaxAAX74ATS5xw7lK3R1gS9/cJRyJZFxmHxfWHXovCPee1L+JnHyf3VIDR3k7v/Sy2jp1STlzTGQ2tevUD2lEn5jC4B9NCqwZGSDWypKV9pTtsajZodHrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgEAApSE; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c9c28c1ecbso1305620a12.0;
        Thu, 07 Nov 2024 06:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730990078; x=1731594878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F75piWahFu3xEvjEvyJygjFoe6Wvi89gUM0KanR4MpI=;
        b=UgEAApSEtFKXlkZE1aCTy+Y6B8ZzSxcPSCtfvDVhaZ39Iwx180Cth7QESwVCduOT6l
         lYRpsU133msEZqjtdQacBaRilM59Wv5ulMZtzTq3Oj9m+GRU5gdFvbqJwM4IGrcdNVT6
         R05JvKbef3yh+bZEyrsOohcBiFhAzrYSXbTV07wPaiOTNGZOk610eFdhgN6Fbl4+vNz2
         /odtplgVzEPe1Nw0Vyik7rOadcvUnTR65TyGx5YT63Jhir4ToVBwUoWsmjRHB3D4IN94
         M1Oc8m9nXCy6jD8Lt7/WYlJMtbprL5Y32Q4zLOqBXVOjkGKrgC3Myq0IbFNBaCLU8IQv
         9COg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730990078; x=1731594878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F75piWahFu3xEvjEvyJygjFoe6Wvi89gUM0KanR4MpI=;
        b=BgL3UGp974SOuobeGZNSqBDtsxul+BDEsbt8QE7NawDXfJBxXbrS61XpuFZY4vOZmS
         OH0IqwdCDH8wL6Ncv9uLL9kQgcC+9OfY4u6/UFt89P4btHRis+gUQjXurRVLatUD4V9O
         X8fOA3WWuzoK5t9uI0SiHi/qBqDtoJuwiVRWb9Sd2mnodgewMLhK5di4DpDdzx9379DG
         XPwYga3A93yg/OLPE4R6KMw7A0bbY06Mrk1WqLWUbqu1jo54jPmBuXPgUi5ib4Olxm8B
         P7dBu4+PN0GIKBZ6xS5CnZ9GwhectjuYdECaWvn8WEphk+MEDbJH82Ornj176ynUL0+s
         y+JQ==
X-Forwarded-Encrypted: i=1; AJvYcCWd9T7VfcyFsosenOAbMvmJTEnVnLtje5KqlqokubZkHUG2N3e1QigTinXm3jrWr8bXmfUEZyT84CP0aYdM@vger.kernel.org, AJvYcCXj3ZDLYoyJZXeIMuCCKGc4/EnZbc+lAdBJzKnlafJy7L+Kt2ztA40Mb4x1qiQNTE6xJFruDAW+E12f@vger.kernel.org
X-Gm-Message-State: AOJu0YyECZmnakiNOmQXiMrScbxY17F0O7oYd1jY+QeBklZVnSCD0LtA
	1yasaofP3qv4wgSbPZjJCSyL0PN/1AeuOIxMbySL2aa92+sydqPM
X-Google-Smtp-Source: AGHT+IGd4G0KS5uDfvxPoW9U4SNRhx7uhG/Wy5chDr4KEWTlLa8sOsBZ4tHb3V9I4IDAQQJgFfqRmg==
X-Received: by 2002:a05:6402:50cc:b0:5cb:7780:f1f6 with SMTP id 4fb4d7f45d1cf-5cbbf94ebeamr31344872a12.33.1730990077700;
        Thu, 07 Nov 2024 06:34:37 -0800 (PST)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03bb7fcasm880381a12.52.2024.11.07.06.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 06:34:37 -0800 (PST)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-actions@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: clock: actions,owl-cmu: convert to YAML
Date: Thu,  7 Nov 2024 16:34:31 +0200
Message-ID: <20241107143431.728669-1-ivo.ivanov.ivanov1@gmail.com>
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
v3: list the headers in the description
v3: match properties: order with required:
v3: add clocks as a required property
v3: drop unused example node label
v3: use the preferred four-space indentation for dts example

v2: drop address and size cells from example
---
 .../bindings/clock/actions,owl-cmu.txt        | 52 ----------------
 .../bindings/clock/actions,owl-cmu.yaml       | 60 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 61 insertions(+), 53 deletions(-)
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
index 000000000..1717099b7
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/actions,owl-cmu.yaml
@@ -0,0 +1,60 @@
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
+  See also::
+    include/dt-bindings/clock/actions,s500-cmu.h
+    include/dt-bindings/clock/actions,s700-cmu.h
+    include/dt-bindings/clock/actions,s900-cmu.h
+
+properties:
+  compatible:
+    enum:
+      - actions,s500-cmu
+      - actions,s700-cmu
+      - actions,s900-cmu
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Host oscillator source
+      - description: Internal low frequency oscillator source
+
+  "#clock-cells":
+    const: 1
+
+  "#reset-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - "#clock-cells"
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@e0160000 {
+        compatible = "actions,s900-cmu";
+        reg = <0xe0160000 0x1000>;
+        clocks = <&hosc>, <&losc>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
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


