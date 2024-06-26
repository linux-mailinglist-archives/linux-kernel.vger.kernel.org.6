Return-Path: <linux-kernel+bounces-230626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75440917F8A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E962A1F217B1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F7C17F38D;
	Wed, 26 Jun 2024 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XPhmqBK8"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3653917B405
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 11:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719401026; cv=none; b=InO98JL7a96njJiNuz9gVq9fGpJWvN7eTFyNxrmSzfaiOqnR1SdqyaMPZ0yXEWUN+++TJnU2BKMmsWy1NRPsdb6W4ogoN5ww6QssguJ/roeWI4DcgJImfgIn6pimyI+xibbMkXEIf4QGN5IiBNg48Izydj8EmocrQ7C+lUnLWAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719401026; c=relaxed/simple;
	bh=z8/LYFLL33ZSSC3LJWTKkBqBU3ELjAHLh3fkufZPhjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WO6frV4/+yd8QFGKCpV9DFgZRdFOcjL16rZohlr1+aiUa/lgsQfFuymaoeNXJu3mivtc2uKyVD4OGNgbepiN0cH4MRRWRFNJijaq0UPnd1AFm7y/b6qLG9JLuru18/XZ8cjMzsV2Fh8wDfzI+6fnCavHGP8B5qNyXuaWh37FDKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XPhmqBK8; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso744359566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 04:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719401023; x=1720005823; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UHFAghzAoX9Bj9McLZuZq3fcUV6fdMaKdUsV7P8ymkQ=;
        b=XPhmqBK8Dy0Hh90QCNx4sE6dAQISzjQNI/DoNB58AOqHaAzdw/lLjDWXGANMNeIiXY
         Z2B1rsB79byq4w2QjqcvQ0mW9FHLaXUnL1w6J5vjBXXffG1B5t08RcgnVl68hLw/afwG
         6mEAIjaTFsG5G2Me4RMk9pP4hdukCqObxgEd94Vj51IRjr7+h7Y3VWhGa1YHEE6OgFH6
         YuAyI2bvsCECZDOF+d2yfXtykVORsLNGQGnrETY8WyJFkPKp94qvqDz+ntw7xJHwcimX
         2x9yf8lTtiMgKK//AKlRVUZFTmOxYDJs5mVaxTgm1nP7ywPTk9A/0uzbBJiXE6BQtUDH
         VNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719401023; x=1720005823;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UHFAghzAoX9Bj9McLZuZq3fcUV6fdMaKdUsV7P8ymkQ=;
        b=Rt2uL+cvbScEVx6HadSmI7T4XfR0dNS3zwlRadCLwik/4ygjGt1XLcjbBZ+J9i6et8
         1NrLdnuLML10KZx14IzkHrnxYLVqmRlxY1AQ3lmbgh5oRcAaUNw1iaqJQu8RpTAysiUW
         NKKA+ct7xkve5J2WWLcSM8OGTYR1rCz4/S/pVphumnJwPv+yFJnjP063HAvWTULDIfyz
         qfoaOhkTHCDk0QihjIRyVA9WZdXOyywwtBzzvrYYQvS6MlXT1a0pdKzPNu1EmskiKD64
         FA3fG/1LGimohJd2iD+JIRprlhAePkTQ22Tzf91maWbfY7Sz8v+M2gAUcdQJUhdMIqjt
         sBkQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2ZOy/GcWuX9va93dnw7pU7k4YbSlaOZoLPhmuQLpZLvhxJZgghfbx+5NE8BG3lv8jomu3iIHCwZd3vuGK4hjY8Edz06wu1CE29/aY
X-Gm-Message-State: AOJu0Yz3ICJnsgOB7uHxluunltxfOOZ8yzAiWK8DbCyElbNk6Llots+G
	YSLVwyjFoDULiXGO4zRoKZX40MUSvl75IUG1kP9aaG7pP2eyspdZaltFH90S+bsLpyRWcSmd7nn
	Q
X-Google-Smtp-Source: AGHT+IF+o9xL/rCN/q1fNqjVwtlLllTegQZ5VL+WhBeVkaD1yaS0lFWymqc51LELPvMepZKgvgcy8Q==
X-Received: by 2002:a17:906:d8b8:b0:a6f:e54e:a259 with SMTP id a640c23a62f3a-a7242c9ca32mr677753966b.32.1719401023176;
        Wed, 26 Jun 2024 04:23:43 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fe03b4528sm497772166b.206.2024.06.26.04.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 04:23:42 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 26 Jun 2024 13:23:33 +0200
Subject: [PATCH v2 1/5] dt-bindings: soc: ti: am62-system-controller: add
 AM62 syscon
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-dt-bindings-ti-soc-mfd-v2-1-ee4d69017326@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2488;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=z8/LYFLL33ZSSC3LJWTKkBqBU3ELjAHLh3fkufZPhjw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBme/o4OBjgFiK83FMO1ABlrUKpTvg7aolNSs66x
 LJ/aIxj5r6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZnv6OAAKCRDBN2bmhouD
 11DaD/0V0uUsrx/dRCVeyEQgxTd59UjtOj85U96i8UtJSrKzqHOZgCbBevSOpX54WJojqFhCoEM
 BDZBzsM0tCi18cxSngCKqOCPS1fR4ajhvnnm4x8QfDdwAe5MqgPrdO8UZqsLjAlQhK4Lsata7x1
 Vt+nJQtHWSYMuWwu8Vvgly1FvBzrP447K1x4XxHqJorNBpjGI5PfKR8Fg4932fvRHBxR7My7kb1
 1uT7jZMAJ/D7LnEQFTqcYjZ4BelB1UFsYrdvROsOwYkkCdBFRJWWwRqUg7yTLICN1pH+4LUNB3o
 xzjcqx8YgQxG4y4glWUx21ccCjfGzsOpWFx/jYFgm9gHefoH6LW1ywQVY8kF1g+vreILCHbDU3+
 Z9R+B4lWSqHh2CHz7oY6Iy/4c9MJMOYBD3aErv+hh5xnrX/P9lF4uj6l06JEnIIMEnodAT1dYtn
 IZHSlgfh6GE0YIhGAtJB/Kz8lXHDDhXyLqOyTwswnEgymBVAlOyMWkwVGrRsYIzF6bMTon5R4Fr
 +EDnLXlFnqnzIvR89unwMEIQRmf1j4ZsnKV4mVSJ6AQBhPr5fPI+r1VQC3AUHgHaHQPryupMFai
 pCam2ZKqyJuoHsbNGvVu2Yf+Se71gop3yoFZ2eDXs31WkdP/TyD5O2L98qiPK66WOGlefBHKYo9
 S9vUDeVGqLCEBSQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add dedicated binding for AM62 and AM62A wakeup system controller
registers, already used in the DTS to properly describe their children.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/soc/ti/ti,am62-system-controller.yaml | 77 ++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/ti/ti,am62-system-controller.yaml b/Documentation/devicetree/bindings/soc/ti/ti,am62-system-controller.yaml
new file mode 100644
index 000000000000..0cea0de5716a
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/ti/ti,am62-system-controller.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/ti/ti,am62-system-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI AM62 System Controller Registers
+
+maintainers:
+  - Kishon Vijay Abraham I <kishon@kernel.org>
+  - Roger Quadros <rogerq@kernel.org>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - ti,am62-system-controller
+          - ti,am62a-system-controller
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
+  "^chipid@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/hwinfo/ti,k3-socinfo.yaml#
+
+  "^syscon@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/mfd/syscon.yaml#
+    unevaluatedProperties: false
+    properties:
+      compatible:
+        items:
+          - const: ti,am62-usb-phy-ctrl
+          - const: syscon
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
+    syscon@43000000 {
+        compatible = "ti,am62-system-controller", "syscon", "simple-mfd";
+        reg = <0x43000000 0x20000>;
+        bootph-all;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x43000000 0x20000>;
+
+        chipid@14 {
+            compatible = "ti,am654-chipid";
+            reg = <0x14 0x4>;
+            bootph-all;
+        };
+
+        syscon@4008 {
+            compatible = "ti,am62-usb-phy-ctrl", "syscon";
+            reg = <0x4008 0x4>;
+        };
+    };

-- 
2.43.0


