Return-Path: <linux-kernel+bounces-408822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEC79C83F2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D9F728254C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC3C1F26D2;
	Thu, 14 Nov 2024 07:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFk9cu2M"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189F815C14B;
	Thu, 14 Nov 2024 07:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731569168; cv=none; b=nFDPCyftwpMGMbfgeigl8UcuH5irLdaGl/8P+9bMQP1cv5O+LU7CFC+GpFV6hMjFEKp6Mxsmo5J2W1gLu4dUi1dticLSbfTqfp3R4bqtpbl/IAfff1c9NPrNvi7VTb2qUnlQs+K8g6YeQ2FMoYIPlaV9UhVZwWeIUFc24PNnLFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731569168; c=relaxed/simple;
	bh=IDQGuQbS7bXhRsBCafj78M5ReIygWpSEcRzZCjzJ/G8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ndtr6id4NgDhtD8zQKl+VOr9cU0SQzUvLjL3bffLC38yCgBTEdq7ONU/e3YYUgZRHIEAuSPaOcdEq25I39iOzuXKBCnWkBlz1zDQaqw5xvroVtGCFflLy1cEgd8E/MHYpNPW8m/b5q2Pz0V3MiQ77K8yTV7x9OWJQUrKqjXoqbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFk9cu2M; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aadb1so341378a12.0;
        Wed, 13 Nov 2024 23:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731569165; x=1732173965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bNkA9+McOFr4dA0w94szSWPTGnjmhGVcIjLVtGxtAME=;
        b=MFk9cu2MrO/Yc2NX4ztkNRFheYa0MXuw/MqqPmklIdafFNZgmaunx8uzjLScBrzM1e
         JSG/vz25y8t76MVYxz8Qz3hpR4Jz5zYLc8WZFkZ7LKuDOE/OkdK4/W7+/FxAWsehMvFi
         9A/QOELGmAOJrRC9eANHPAuc6gTV7ZHyo1m9yJtcT9kMspxK/CVy9wpqQbDK6NhwjHb3
         ehkfvr+1TPoT7BB1Kwc2UPgazMLHNihbnnFqkSGIgm2RyY4vExh7FFzVcCpFcHNCRgD2
         wy1WUQ9T0T3MnnKsvU3aIFGcsbcNycT47bG9bMhd1B9bxU98A7AJ4uldJDf5hz80W0GA
         k2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731569165; x=1732173965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bNkA9+McOFr4dA0w94szSWPTGnjmhGVcIjLVtGxtAME=;
        b=sh6klg+y7rVdOiDWUWw8BNt3HNgjbjqneDJNseQCgBIDyFAkyKyimpovA7lmLxHFyP
         3U3FsPGAUTHgvvLEXSeuu00Qr0P7RRVTLHWqojCFNCoDQ4U6X/QrHqhDYrJsp0eFA81F
         5ne0duN7LST0fUZG5dmOEbQ9FBrZi2ugdIdDZdUPbvvhxAAZZ0E/mFcICOdw5PhOjWQg
         gMuPW+deFhQyo0RWOYWW6+aRVf6c0eZrOv1xD4f8x2fdb6sxFO2su5ebylmnSgfp2ZIR
         r6RLHNn4onIdoEfhwu6JPxe/T2Xl8fC4JGi39DSy5u19YsuzPkUqy4wuz/8cjfeRkG6c
         oYpg==
X-Forwarded-Encrypted: i=1; AJvYcCWvyQZRimHkF5qh2hRz0vPQMT+uqQ9IU4KRCkz5P9ywy0HTYhWBcajperX70I06VUjD2Ydv4/X0CRzUoogC@vger.kernel.org, AJvYcCX5E1qORb3zjWxJ68u2P4Hu3Ewdv1TznW52LCVV+Ccdsz6sE2xxlXZeKaqwJNqEZjzsyY3Zz9hxsjrR@vger.kernel.org
X-Gm-Message-State: AOJu0YwoVI6bctZF0wYw34DkM9FrrkxL+cr9wRe3CTvOAtzTfzQ+PCH+
	9kw6clRB6sxKib/vkA0gosMYBa2v3R4i+h91RENjlDLnRDPxENSS
X-Google-Smtp-Source: AGHT+IGQE6v7az3F7eG37+YiLYVejzaNRHdYZyYAeB3vYXSjFWlp5ZvBEPVy62Z6p0EeXfVETVGQvA==
X-Received: by 2002:a17:907:7f1d:b0:a99:dde6:9f42 with SMTP id a640c23a62f3a-aa1f8105b9emr569468366b.47.1731569165173;
        Wed, 13 Nov 2024 23:26:05 -0800 (PST)
Received: from ivaylo-T580.. ([77.85.230.22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e0869cdsm28700466b.192.2024.11.13.23.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 23:26:04 -0800 (PST)
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
Subject: [PATCH v4] dt-bindings: clock: actions,owl-cmu: convert to YAML
Date: Thu, 14 Nov 2024 09:26:00 +0200
Message-ID: <20241114072601.265011-1-ivo.ivanov.ivanov1@gmail.com>
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
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
v4: change double : to a single one in description
v4: add tags from Dooley, Kozlowski and Sadhasivam

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
index 000000000..28396441b
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
+  See also:
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


