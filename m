Return-Path: <linux-kernel+bounces-340522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD7C98749B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 866AC1C228BF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 13:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F164503C;
	Thu, 26 Sep 2024 13:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tjKNA7Yw"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF1A5258
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 13:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727358146; cv=none; b=DytCAMlseHfjMwANf1p6zlrxHOjVSs7HwxY0fRG40wqBmjiglFMdTidFIVVrsrijnfOsvKF8s3xFh5TR4z/NyjS7VlxCy6DSB1Ta6LdxjJse9sjYrOxNde0RITmJLctzORuD6VF1yP7DXfkX+ApCHBJJXxCekunjJF0foKdhuEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727358146; c=relaxed/simple;
	bh=AEJCKU+X8Qz9nA+6tgsS1c+deZWha78O0L4LAfcxwYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FlL0+DdlOt1vv8CRRsaWAmMTfNG3n8gh8qWTc1DLW+wOK9s9o0du8gMfEOjHTBGGGNIE41e6nQKhGynKVB7jn0AxAizOShqKv+foh3oalM5ZeQdfhOxEMwkx+W1ivUWQNcnVFiD3Zvz3t7TbGXPa8jq2ksvERfzaqsc5VYVY9UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tjKNA7Yw; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8a913874b8so15212766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 06:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727358143; x=1727962943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0olxUn4zOrzj+babFECHIBxLQNDeiRAaP+GJq/C3teo=;
        b=tjKNA7Yweei1qKSb57Oyv0cFlcJwM52oc1+/kluANRBg4OXnCQNAkFR5QIoYu0Wlud
         VP2vd9B1V9xT0x+40R0c9OKpFa8np6+xGV3onKy2qlOHjzNBapPBxFWL8wt/jsVlKY4u
         fj1ubdk+3LkIxuO39Q3FSq5dr7R9Zv+1CW0NLWbE3xHV6TJh8t/b39isDfxKkco0FNr3
         64x6IZnHgZQaLwGwNiofNaNJcTIL9l5uGFgsGQlHgt7dqybTUFQYv+9AIUH7UL8qzvBX
         Z+RCvvGYsVv0afPtlEqmMGvvXFftze8AhqFBvGeysZHl99rljkAJsOS8iUoxvr/Mo0P0
         DceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727358143; x=1727962943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0olxUn4zOrzj+babFECHIBxLQNDeiRAaP+GJq/C3teo=;
        b=fa4rCDUtkKqapA5CPAqjPFo9O7bBb43pPCAegHUqAT04AwDtzNiMhl3lujN0uOlwQC
         aKlNkeXOdOx5sJNAQffKJCuQmtbMFQ9Tq0qZrqcqEGptjqhDX4+KV2C73DQiR0QurMMw
         iSKTIysPBwIAcPOjP0QhAKFxPnr4h9c8NTDGy+mqp3lTLT2rNd4WAEt5hhyxrFdKfFpF
         Ib61bBRNXxRB0CJUXnk+Ik5QInioBrIDrfTk20sOCmCS8PVkDe3bS12PyzlIfNbTFFJE
         tHEUsqqZJ6CYpy01hk9bW3NeNYKLlVLxICe/BsWlwH20WciTv2J400nJc0aHg7Aq7Kky
         AJgw==
X-Forwarded-Encrypted: i=1; AJvYcCV3Nu9IvgZejeZo1Y4FSAfULTwE/74JOhibvpJs8n0Or1Tgjmgu6kjFMB8BxOdrOMk+LdsOi7/Ku8d+lkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYnJV5FwbR4fxySVaQQitkcAqwpGI2SoD8CHmJF2NSwzS7kGvM
	1J364SGpiLe6KYudeZieEeVl+rs5dm60e1GPnI/NmaeuFFDkiCRQ9tTbtmUM9gc=
X-Google-Smtp-Source: AGHT+IEZV2zw0qNz/7zibfNZbp/zicHlzw+t1s35COuLxQ1apwDP+ajEjIqOKwhxbpcc57zdtWKV5g==
X-Received: by 2002:a17:907:971d:b0:a7a:a33e:47cd with SMTP id a640c23a62f3a-a93a040b6e5mr243281866b.8.1727358143042;
        Thu, 26 Sep 2024 06:42:23 -0700 (PDT)
Received: from krzk-bin.. (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f5475asm353315966b.79.2024.09.26.06.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 06:42:22 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Nishanth Menon <nm@ti.com>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH] dt-bindings: examples: Add GPIO hogs and variable-lists
Date: Thu, 26 Sep 2024 15:42:18 +0200
Message-ID: <20240926134218.20863-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Same Devicetree binding can be expressed multiple ways thus no wonder
we have multiple variants of similar concept.  All such code could be
cleaned up, but even then new contributor might not be able to find
good, existing binding solving their case.

Add subdirectory with two Devicetree schema examples (GPIO hog and
variable lists like clocks), hoping it will grow with reference-designs.
All these bindings use valid compatibles, although with "test" vendor
prefix, so they will be validated by DT schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

If approach is accepted, I will come with more ideas, as commented
during LPC DT BoF to creates examples based on review.

Cc: Nishanth Menon <nm@ti.com>
Cc: Bjorn Andersson <andersson@kernel.org>
---
 .../devicetree/bindings/example-schema.yaml   |   2 +
 .../examples/gpio-controller-and-hogs.yaml    |  72 ++++++++++++
 .../multiple-variants-and-variable-lists.yaml | 110 ++++++++++++++++++
 .../devicetree/bindings/writing-schema.rst    |   6 +-
 4 files changed, 189 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/examples/gpio-controller-and-hogs.yaml
 create mode 100644 Documentation/devicetree/bindings/examples/multiple-variants-and-variable-lists.yaml

diff --git a/Documentation/devicetree/bindings/example-schema.yaml b/Documentation/devicetree/bindings/example-schema.yaml
index a41f9b9a196b..0aece1823fde 100644
--- a/Documentation/devicetree/bindings/example-schema.yaml
+++ b/Documentation/devicetree/bindings/example-schema.yaml
@@ -25,6 +25,8 @@ description: |
   indentation less than the first line of the literal block. Lines also cannot
   begin with a tab character.
 
+  See also examples/ subdirectory for more detailed code snippets.
+
 select: false
   # 'select' is a schema applied to a DT node to determine if this binding
   # schema should be applied to the node. It is optional and by default the
diff --git a/Documentation/devicetree/bindings/examples/gpio-controller-and-hogs.yaml b/Documentation/devicetree/bindings/examples/gpio-controller-and-hogs.yaml
new file mode 100644
index 000000000000..597a847daa12
--- /dev/null
+++ b/Documentation/devicetree/bindings/examples/gpio-controller-and-hogs.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/examples/gpio-controller-and-hogs.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: An Example GPIO Controller with Hogs
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
+  - Conor Dooley <conor@kernel.org>
+
+properties:
+  compatible:
+    const: test,gpio-controller-and-hogs
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+  gpio-line-names:
+    minItems: 1
+    maxItems: 32
+
+  gpio-ranges:
+    minItems: 1
+    maxItems: 16
+
+  # Not every GPIO controller is an interrupt-controller
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+patternProperties:
+  "-hog(-[0-9]+)?$":
+    type: object
+    required:
+      - gpio-hog
+
+required:
+  - compatible
+  - interrupt-controller
+  - "#interrupt-cells"
+  - gpio-controller
+  - "#gpio-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    gpio {
+        compatible = "test,gpio-controller-and-hogs";
+
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio-ranges = <&iomuxc 0 0 32>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+
+        usb3-sata-sel-hog {
+            gpio-hog;
+            gpios = <4 GPIO_ACTIVE_HIGH>;
+            line-name = "usb3_sata_sel";
+            output-low;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/examples/multiple-variants-and-variable-lists.yaml b/Documentation/devicetree/bindings/examples/multiple-variants-and-variable-lists.yaml
new file mode 100644
index 000000000000..8763791a8adb
--- /dev/null
+++ b/Documentation/devicetree/bindings/examples/multiple-variants-and-variable-lists.yaml
@@ -0,0 +1,110 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/examples/multiple-variants-and-variable-lists.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: An Example Device with Multiple Variants and Variable Clock Inputs
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
+  - Conor Dooley <conor@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - test,variant-2-clocks
+      - test,variant-3-clocks
+      - test,variant-4-clocks
+
+  # Same principles as for clocks apply also to all list-based properties, like
+  # power-domains, reg, resets, etc.
+  clocks:
+    minItems: 2
+    maxItems: 4
+
+  # It is preferred that variants (devices) share as much as possible from
+  # lists, e.g. the list has common part with 'minItems: X'.  Example shows
+  # case when list cannot be constructed that way.
+  clock-names:
+    minItems: 2
+    maxItems: 4
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: test,variant-2-clocks
+    then:
+      properties:
+        clocks:
+          maxItems: 2
+        clock-names:
+          items:
+            - const: bus
+            - const: core
+
+  - if:
+      properties:
+        compatible:
+          const: test,variant-3-clocks
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 3
+        clock-names:
+          items:
+            - const: bus
+            - const: ref
+            - const: lane
+
+  - if:
+      properties:
+        compatible:
+          const: test,variant-4-clocks
+    then:
+      properties:
+        clocks:
+          minItems: 4
+        clock-names:
+          items:
+            - const: bus
+            - const: ref
+            - const: tx_lane
+            - const: rx_lane
+
+additionalProperties: false
+
+# Usually, if examples different by one property only one example is useful.
+# For the purpose of the excercise all variants are described.
+examples:
+  - |
+    device {
+        compatible = "test,variant-2-clocks";
+
+        clocks = <&cc 1>, <&cc 2>;
+        clock-names = "bus", "core";
+    };
+
+  - |
+    device {
+        compatible = "test,variant-3-clocks";
+
+        clocks = <&cc 1>, <&cc 2>, <&cc 3>;
+        clock-names = "bus", "ref", "lane";
+    };
+
+  - |
+    device {
+        compatible = "test,variant-4-clocks";
+
+        clocks = <&cc 1>, <&cc 2>, <&cc 3>, <&cc 4>;
+        clock-names = "bus", "ref", "tx_lane", "rx_lane";
+    };
diff --git a/Documentation/devicetree/bindings/writing-schema.rst b/Documentation/devicetree/bindings/writing-schema.rst
index 7e71cdd1d6de..4ecd4b309276 100644
--- a/Documentation/devicetree/bindings/writing-schema.rst
+++ b/Documentation/devicetree/bindings/writing-schema.rst
@@ -206,6 +206,10 @@ json-schema Resources
 Annotated Example Schema
 ------------------------
 
-Also available as a separate file: :download:`example-schema.yaml`
+Several examples for typical cases:
+ - :download:`examples/gpio-controller-and-hogs.yaml`
+ - :download:`examples/multiple-variants-and-variable-lists.yaml`
+
+Example-schema available as a separate file: :download:`example-schema.yaml`
 
 .. literalinclude:: example-schema.yaml
-- 
2.43.0


