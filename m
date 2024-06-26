Return-Path: <linux-kernel+bounces-230627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C07917F8C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B4051F212FD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015141802AC;
	Wed, 26 Jun 2024 11:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yegsr3Os"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AFC17E8EE
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 11:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719401028; cv=none; b=Uv6yIfVEhbmu+VS6EwUID1OeDh50kSwH54Csf9eZTVuCTywrLEuq7bWgt5J+A2N6NM1ze0zcE5WR7qcpVzlcIHygVxA3upoJnc2akl7KNY7BAQlt+1jQaZy+2jCJNB3Xepjc2K+sVsmM/ByR17wRrLEz1L/QC8qWaqDsDYltP+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719401028; c=relaxed/simple;
	bh=QChUma85GCYXyOi7HEfymtdNZhoi544snV1GbK2nVR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ssEyb0eM0AbQWxnZlTwNzOrot5leqMgqYntiffMpx+dW8OfsoryvbNs8LSeXknvnwqkNTxIubI0TR3LS/V6UBzEn8iezdS1Aq7g0xVSowizbsZnYW3ChM7pPTeikQfvh1acPNxsfIl0j4ayiTb+P4dtaTieC7ewU4zeZUnJWBOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yegsr3Os; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57cc1c00ba6so131887a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 04:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719401024; x=1720005824; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TDOiH+4qTcTpWy9q12bDHm1ZTWA6t5V7SL+CaVV5EvQ=;
        b=Yegsr3OsAbiw7u/YKoEYuwqPn33QlnD7Vb9NiSoAYGYNqN0uflNpl4jyGy46Ow1bku
         I9HGc99DAqQ2Nelp3QUEV/bNZcZ9lSxCjFkG+SA4fFTijGGBQRXxY4Ruag2KtHO1AeUC
         sTL0rKwpm9bCgDdjgS3/s6zUoCnWa+Yium5Xk9flaZyyGSO6ZztVRNgFf33GNKluQ/sr
         EAnk29UQxSl919G+XtGlywgaYAM8QP+Kp9b1O/gUE/GQ0J71cCFehlt1/4pX29IREVU0
         ykYpsuq9g8x4gd6gQ4SPgd1iS5hEHTBz+p0KBFDXg0rqmJ/rXk32sFcwa04GpeFaXMwK
         Nbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719401024; x=1720005824;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TDOiH+4qTcTpWy9q12bDHm1ZTWA6t5V7SL+CaVV5EvQ=;
        b=A9+rLIA8JljzG3oBz8cJyGvWKyvcIMZ6sgHv95a3UOCsJrP+ys97L2uDKaSuOJnFgq
         co4rQjOT1pUVjDpVm901G6RkzdXg4R29GO9uYznX6Nmfkhy/Q87O1nfoL2ebXn6M9887
         1JF4w/mKHtWOWC4LlKcdaKRynlUG/fGOHSYugFuIRJ44cNH1vVg1SSsw7wFDT5QzRd6R
         Pvv8jf4NXlbljjIPM+lXY+lPM2FA2NS5drJFOCuZ9zfnXynU0CS3O28Y6C3f5vSOXKqt
         XFeGQV+SLwx0jMgB8a/r6cBZ+ItYVHr5wri3NZFwUS0pOEh3uwFwD05l2Ez9o5fH/4+v
         6Adw==
X-Forwarded-Encrypted: i=1; AJvYcCXQxv508fST8yNDFHHAq49rfn1ph+A1UGYyRTjOuiMJJLW4B8w/L9D+HU/K14ufyDvPlAEfHS3MzlV9VzxzkBsWVoQI7sYBtwEjqhBm
X-Gm-Message-State: AOJu0YyofOChfBmMmj4w3ktpxKqyTGjPHxrbpoTi6dFQnW8KQfd5cxzQ
	BokpGWhV4UjmzycfNVhjcT1f+54tKPsebxamm+AFAYrNeh2X5dE99XLvMd0hibvaEfQmJ6SfCAx
	F
X-Google-Smtp-Source: AGHT+IFoX+wKiYDm/oyjVE9JH01eD6ukectcYMJb+tEpQpZFklhChRAm296JO6RnSjx7tEiTPk2blA==
X-Received: by 2002:a17:906:9c8d:b0:a72:5bb9:b140 with SMTP id a640c23a62f3a-a725bb9b312mr505355766b.54.1719401024527;
        Wed, 26 Jun 2024 04:23:44 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fe03b4528sm497772166b.206.2024.06.26.04.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 04:23:44 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 26 Jun 2024 13:23:34 +0200
Subject: [PATCH v2 2/5] dt-bindings: soc: ti: am645-system-controller: add
 AM654 syscon
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-dt-bindings-ti-soc-mfd-v2-2-ee4d69017326@linaro.org>
References: <20240626-dt-bindings-ti-soc-mfd-v2-0-ee4d69017326@linaro.org>
In-Reply-To: <20240626-dt-bindings-ti-soc-mfd-v2-0-ee4d69017326@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Roger Quadros <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2054;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=QChUma85GCYXyOi7HEfymtdNZhoi544snV1GbK2nVR0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBme/o468sm/NtXDvDdwL4ZFOjGt++SeEkIIvuA5
 byH6CIbPu6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZnv6OAAKCRDBN2bmhouD
 13kFD/9GSaLTUcAbgJ+xzSM0ci0fqNjXC+LYoYMMSmSMSNDVt8gxMhN3jyBkYCLB80SmOVqQpDE
 2rQE87946bvB1HVa2FKoe9k/1lrAABKok8zU4swqCteMNA/wCQWOfiAywxFDkdxEjnMeN+sCkEk
 oBoillWOTt9KiwoHkt8e1A1aC6k1HalzVBUEQvkBTuDY8xpEXN3iTSKFzzrUr3Q/y+Zl1fgw9Nn
 t/twdu4KZTDWBPIKUh5QEjVK6K3kGvKzN5UjJDJ+zI3gRg9QrXfoSj5+tUMOarr6GiNVbP0Xu8y
 S9Lqc2P7xyaRf3KzKMKi+6+fAtyRDTRtj3/NHNYsxeWAmeeA+oshByqIUvAIKKcAD3Rnj5diKxn
 XsSxmszvrLVeNSLs5iVPuQC8xXk2Hh9MeVZqzUTimY01ViW1/wiZG0FgC9RDkaSoB/UY+KcU37l
 HxUnpjjM1yKQVa2jPxYmtBNEoQAdKf6G5Ew0X5VtTnWgduMdGH8DJSMu0khIg48XsGgFmrkjVxX
 xEjSg4N9xhwIO1gOVQC76PEVAspJeo043wfv6eDmkXdPFvjGp/BZgVTixhL/uluJxCHlO9jMs7t
 HvTI5tLoyt4S8khgRi+jy7uTWdkpS/4BoY11URyrDWh2KMxZ0fQfL0y/I6uLlihh3Di7CNjltWW
 kFuMW5qb4ykHKUQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add dedicated binding for the AM654 MCU SCM system controller registers,
already used in the DTS to properly describe its children.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../soc/ti/ti,am654-system-controller.yaml         | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
new file mode 100644
index 000000000000..8965b6524f4d
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/ti/ti,am654-system-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI AM654 System Controller Registers
+
+maintainers:
+  - Kishon Vijay Abraham I <kishon@kernel.org>
+  - Roger Quadros <rogerq@kernel.org>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - ti,am654-system-controller
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges: true
+
+patternProperties:
+  "^phy@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/phy/ti,phy-gmii-sel.yaml#
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    syscon@40f00000 {
+        compatible = "ti,am654-system-controller", "syscon", "simple-mfd";
+        reg = <0x40f00000 0x20000>;
+        ranges = <0x0 0x40f00000 0x20000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        phy@4040 {
+            compatible = "ti,am654-phy-gmii-sel";
+            reg = <0x4040 0x4>;
+            #phy-cells = <1>;
+        };
+    };

-- 
2.43.0


