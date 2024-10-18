Return-Path: <linux-kernel+bounces-370850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 513C39A32D9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 04:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3C21F242A1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 02:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288F0178383;
	Fri, 18 Oct 2024 02:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1t8mO/U"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCCB1714BF;
	Fri, 18 Oct 2024 02:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218329; cv=none; b=U6RBNrxi2eGvf0HiI0bIQzg7PFqnC8LwQD+I3VHFK7gHyyWcF+wtCcptXIaI1tyNU18XLZRfCrxDxtSsddZYS1KouKIIbbMhY/69OSq6jsdGjcNZ4mBAybpbBcbPHuPSwmOv9/Xqcydr5qkzTdzZD85/xUJeheciEYWpXrMGR00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218329; c=relaxed/simple;
	bh=ewpSy87GKk3ODmjzJvXb0r2TyqTHeq3BXBtQEY4c1BE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tgECfWtaKw8cwCdBk7ptvIhSBJc0ZtiFOX6DlUggbgrtTbGfykEztHxv09i0kRP/lOfYt0vZwQDb7QknyIDKUApuM5rr7wlnNsOec4EZs5umb8JP8ZNObCx5h2N223OT6rRPtTgFbqFFyi4qJFAmscwHKIz+lbBAPRl3GKxZHJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1t8mO/U; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e625b00bcso1249552b3a.3;
        Thu, 17 Oct 2024 19:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729218327; x=1729823127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuOQJ2SkMr9MVCpuQjB+HvX8BSfQHaT0CbF4h7Jt34Q=;
        b=a1t8mO/USY08ntxaQ9lrjcr47lygtzN+qvbWF3vUjyZY6eWKojslqt18x8wuz6aNDy
         Sde/S+1btXLL3xeEHqiYRMvlLx5YK3jjPc2Ro83C9LEK0cGrANjK/3+5oFLKfWEAdqZL
         FxOLx+D7MBoVCPZPfrK1XuxBKGa9wCaY8PIsjA3RsOag017F5xixMMRUsqo80ogMfPL+
         proJyw0wj0u+66seQiYVp8vmTEfN4+zldLk6Ahgc0taA9DrDzZJKY0Cti/U8OZkiCcm4
         u+DbUtylPkwC/Nyh5WggVpbpKPFFvBscxh9T1alK9n0Sv7TqH4ziLLqxRzIQu/mzio3q
         jdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729218327; x=1729823127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JuOQJ2SkMr9MVCpuQjB+HvX8BSfQHaT0CbF4h7Jt34Q=;
        b=L/2rW8CuwQmmehGw6KLO0ARHme8REZQ3tSdxGpdNsEtOi9yObapUDzn2xw/ipHTKAi
         OYq6BOyrrdovQdZE+9wtb2teKyW9XHZ43R66M7jAesl9ZWmzfqwvsQuIfY+WakCwREhT
         9KYdCPg+w7nD39/u/uklDdg+iQhFuxULUwL3tVl/Xkp2E0nV6bWZD6/ZrkL1ywKtg+o7
         RovuO/msIk9nBXLdwF27O+0xqkajCuhLqRjggnXTCQNDnRJZUafpum2dvVm5hXwP0ULK
         7OSbthkWqqDWbpGNvx+xgwf0RJLiEIvzroVHFmJdtwkIBsa0QTmaVX5iO/wD/WKOXEzT
         kbCw==
X-Forwarded-Encrypted: i=1; AJvYcCVynhOmXSi8ixbXh6rsREbBYUSaZrzg0noBbnaGHsJCjx7hgt7vPrDD3inIez2KZweXoO7BRRB6NgO6KPP7@vger.kernel.org, AJvYcCWBMIYj2V+EbVm28wDKaZJeu8y4KbdOg5bbtF/BlVXo2TOxD6wk9Vjd7+e6j6rKZP90s/wlr2kfyLHI@vger.kernel.org
X-Gm-Message-State: AOJu0YyfRw91X/PQ+4bARvtwgq2HwKxoGFb1Ql/CBQeHlVrBdC0vb/1G
	Hw0raEJBhdQpR7gci1328zI//teSVSKQyc8VWhtE9z2ktbLK+rJW
X-Google-Smtp-Source: AGHT+IHJ/MEvHRvbwVFB7ZjlGDhD0lvfpVU5XQbF0P3fVrtL1XV9YS+0WMgmmD95fpUGJgvodmYO8A==
X-Received: by 2002:a05:6a00:10c7:b0:71e:67e7:1a4c with SMTP id d2e1a72fcca58-71ea31fd4ebmr1327343b3a.12.1729218327275;
        Thu, 17 Oct 2024 19:25:27 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea34ac42bsm361736b3a.197.2024.10.17.19.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 19:25:27 -0700 (PDT)
From: Hui-Ping Chen <hpchen0nvt@gmail.com>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nikita.shubin@maquefel.me,
	arnd@arndb.de,
	vkoul@kernel.org,
	esben@geanix.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui-Ping Chen <hpchen0nvt@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 1/2] dt-bindings: mtd: nuvoton,ma35d1-nand: add new bindings
Date: Fri, 18 Oct 2024 02:25:18 +0000
Message-Id: <20241018022519.721914-2-hpchen0nvt@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241018022519.721914-1-hpchen0nvt@gmail.com>
References: <20241018022519.721914-1-hpchen0nvt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dt-bindings for the Nuvoton MA35 SoC NAND Controller.

Signed-off-by: Hui-Ping Chen <hpchen0nvt@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/mtd/nuvoton,ma35d1-nand.yaml     | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/nuvoton,ma35d1-nand.yaml

diff --git a/Documentation/devicetree/bindings/mtd/nuvoton,ma35d1-nand.yaml b/Documentation/devicetree/bindings/mtd/nuvoton,ma35d1-nand.yaml
new file mode 100644
index 000000000000..0b651450a8f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/nuvoton,ma35d1-nand.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/nuvoton,ma35d1-nand.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton MA35D1 NAND Flash Interface (NFI) Controller
+
+maintainers:
+  - Hui-Ping Chen <hpchen0nvt@gmail.com>
+
+allOf:
+  - $ref: nand-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,ma35d1-nand-controller
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+patternProperties:
+  "^nand@[a-f0-9]$":
+    type: object
+    $ref: raw-nand-chip.yaml
+    properties:
+      reg:
+        minimum: 0
+        maximum: 1
+
+      nand-ecc-step-size:
+        enum: [512, 1024]
+
+      nand-ecc-strength:
+        enum: [8, 12, 24]
+
+    required:
+      - reg
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        nand-controller@401A0000 {
+            compatible = "nuvoton,ma35d1-nand-controller";
+            reg = <0x0 0x401A0000 0x0 0x1000>;
+            interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&clk NAND_GATE>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            nand@0 {
+                reg = <0>;
+                nand-on-flash-bbt;
+                nand-ecc-step-size = <512>;
+                nand-ecc-strength = <8>;
+
+                partitions {
+                    compatible = "fixed-partitions";
+                    #address-cells = <1>;
+                    #size-cells = <1>;
+
+                    uboot@0 {
+                        label = "nand-uboot";
+                        read-only;
+                        reg = <0x0 0x300000>;
+                    };
+                };
+            };
+        };
+    };
+
+...
-- 
2.25.1


