Return-Path: <linux-kernel+bounces-557461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA74A5D960
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AA9E7A7E3C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 09:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCE823BF9C;
	Wed, 12 Mar 2025 09:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ik4Jjyd3"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B5C23AE8B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741771579; cv=none; b=JF1ZB+cDL4ZiREIZR8cJ6dUHwS+S/C7JDalzSSUntemhusiAlP3hh69K5CvIWNGawlFj5sZjkCFcQIGyGgBZ7wXW0BmEVJu8NNJOgF94WWvBtABln/NyMnMDiyAHJ/vebBHcXRxL3xKBQL2NGbHHyk+llIl5kSx8wS7H5dhA6EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741771579; c=relaxed/simple;
	bh=kxHzYlD4Q7ouIup6NnoChAXZHHmMaS1kTRKj6jvl4Gw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZqMum3lqwM4c9jbmBr8GRnTdYBtAgs8P3La5uA1BbXblE0xzXZSthTKqY3Ut8UlQj7s5rnSkiUNNB+FcCnwsQh7V+UbWB8WHiOn4rszE+RlzCqj0asoh9wB4q4gQ/XwkiLAY6CuNpsgALhwELcOwzdf5bhmGQi3eTax/bBzxe2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ik4Jjyd3; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e56b229d60so1276852a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 02:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741771575; x=1742376375; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NpG4SN8+SswQB9WTTY/KhrQ2hSRzm3/LAyaIh8poviQ=;
        b=ik4Jjyd3MjaIjHdhdqlWNF2fUvp0KT4S0KQwZZvPGnT5c0RJVyr/C4Kd2UreJgIMYh
         xLf3inY88BnaUi787eBVohPRXDjwW4in8VEizqhDWXYb4oG1vie51WTeKZ7hyhpjcoDU
         RN440RU4FPIBLlP/pUWar4rwBBy2JepgaljiuFp2JWC3kvew7tuz3bNzycYVTertz+oj
         K2Sb8ySI0HzfAx2b8aZ8jYWwcQYtPxTSIw5Fj2iIJLzETg3/GjZVjKadwi21xgrLr6XG
         WBTp1jtA9Z/SXCxBAlnibr7F8NJqGB5E10bLBoQJAO6x1kunbnRvncVqpPd4linD/xyk
         DJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741771575; x=1742376375;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NpG4SN8+SswQB9WTTY/KhrQ2hSRzm3/LAyaIh8poviQ=;
        b=TIdESxNO2qAfBZRuVCG1/g9LORoYvCSTO0SfexKHPSvOfV7Yp1iG2PIIQ8PVQ05GOK
         eOPO3lYpbHgssuKETFSFyKkn41PrKEbebhiNq75GuflZYtIYSKpnln29XwBGXc6gRaJg
         FPZk+8wGTd9l4SfvDXug2fN7ZSkA/TCRuqthwkh3ulppwkKarR7+NBJgot/7XgOSZ6Xw
         IMwZACkg++uscd4kBSPiKBox5a8d94kHJ9FjgcJOh/4D44tGHbhCUBozeP3AX1dIoszy
         NK0bHzRq1PN9fB9fH8eU1XhdylneX3uBPT6SUaPlTBNxJJEUZbObOeSGBiZyDIinJWgv
         fUEg==
X-Forwarded-Encrypted: i=1; AJvYcCXS6M32MQNBNPPnwsg6LnurBzeWmciJ4Vm76lj6IvEbG3eEwqC6IEwmaZhO7XzCsRe5PvUEXaN79/ANbb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp2Mt+SRWa2oNDCnpt7gMWaxDJdB+BCJNpSX58t0yn+0xpFtCb
	dhzot/O9E1T/M3Wtd6mzZZVZGXx1yWQ8Vl33c6mK+17w0BGaO6ewWqAO+QErfc0=
X-Gm-Gg: ASbGncsN0pK/LGaZrXnDjMHcM9yu9XIbSLltThurYKlH3+FVNM8zy7HjUDa6atIkKBj
	+YcJe3SoM/9UHsqdvXUSjzgNecVioHe5+1F8arUlrA7vvckBDPOLM2A4AlsFQxXGtzhlsg/ZgTd
	sll8V5R58TYsC7g3L56Be4UTCZBgh21Ur6b/wxNi57TCTTMdwOd7om6243JkaeUkmr4hiuHBc8L
	uCBdOKKSGf0LYHzKI94YBy42M7I9sSHYN0vA+BJe51zaqDT5XeKHwXh4DdVX424N8HNCzhyOmIz
	tJ8E9pcw5mu+Pbc1wOju4ATwsCpHKPpasuLkbCzNY1DYdUFG6ElSQVtRMzDgVrCUJ+u4GYdtkNN
	UijJKIWpqaj4R8KilazmZnhvJmoMpsjKZs0BdLio=
X-Google-Smtp-Source: AGHT+IGMTylQyff6vU9GdrAYd99Xs9o2ZI+8BDiTPyKAU8vPNdImCoElshfShEdRpTQwXFn9jHo+tg==
X-Received: by 2002:a17:906:628a:b0:abf:27ac:2cf8 with SMTP id a640c23a62f3a-ac2ba563d91mr826133366b.21.1741771575046;
        Wed, 12 Mar 2025 02:26:15 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac25777c748sm894535266b.2.2025.03.12.02.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 02:26:14 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 12 Mar 2025 09:26:01 +0000
Subject: [PATCH v4 3/6] dt-bindings: mfd: add max77759 binding
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250312-max77759-mfd-v4-3-b908d606c8cb@linaro.org>
References: <20250312-max77759-mfd-v4-0-b908d606c8cb@linaro.org>
In-Reply-To: <20250312-max77759-mfd-v4-0-b908d606c8cb@linaro.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-hardening@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

The Maxim MAX77759 is a companion PMIC for USB Type-C applications and
includes Battery Charger, Fuel Gauge, temperature sensors, USB Type-C
Port Controller (TCPC), NVMEM, and a GPIO expander.

This describes the top-level device.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
v3:
* drop gpio-controller and gpio-cells, GPIO is provided by the child
  (Rob)

v2:
* rename expected nvmem subdev nodename to 'nvmem-0'
  I'd have preferred just 'nvmem', but that matches nvmem-consumer.yaml
  and fails validation.

Note: MAINTAINERS doesn't need updating, the binding update for the
first leaf device (gpio) adds a wildcard matching all max77759 bindings
---
 .../devicetree/bindings/mfd/maxim,max77759.yaml    | 99 ++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..525de9ab3c2b7b431e48497330640857540625b1
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/maxim,max77759.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim Integrated MAX77759 PMIC for USB Type-C applications
+
+maintainers:
+  - André Draszik <andre.draszik@linaro.org>
+
+description: |
+  This is a part of device tree bindings for the MAX77759 companion Power
+  Management IC for USB Type-C applications.
+
+  The MAX77759 includes Battery Charger, Fuel Gauge, temperature sensors, USB
+  Type-C Port Controller (TCPC), NVMEM, and a GPIO expander.
+
+properties:
+  compatible:
+    const: maxim,max77759
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+  reg:
+    maxItems: 1
+
+  gpio:
+    $ref: /schemas/gpio/maxim,max77759-gpio.yaml
+
+  nvmem-0:
+    $ref: /schemas/nvmem/maxim,max77759-nvmem.yaml
+
+required:
+  - compatible
+  - interrupts
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@66 {
+            compatible = "maxim,max77759";
+            reg = <0x66>;
+            interrupts-extended = <&gpa8 3 IRQ_TYPE_LEVEL_LOW>;
+
+            interrupt-controller;
+            #interrupt-cells = <2>;
+
+            gpio {
+                compatible = "maxim,max77759-gpio";
+
+                gpio-controller;
+                #gpio-cells = <2>;
+
+                interrupt-controller;
+                #interrupt-cells = <2>;
+            };
+
+            nvmem-0 {
+                compatible = "maxim,max77759-nvmem";
+
+                nvmem-layout {
+                    compatible = "fixed-layout";
+                    #address-cells = <1>;
+                    #size-cells = <1>;
+
+                    reboot-mode@0 {
+                        reg = <0x0 0x4>;
+                    };
+
+                    boot-reason@4 {
+                        reg = <0x4 0x4>;
+                    };
+
+                    shutdown-user-flag@8 {
+                        reg = <0x8 0x1>;
+                    };
+
+                    rsoc@10 {
+                        reg = <0xa 0x2>;
+                    };
+                };
+            };
+        };
+    };

-- 
2.49.0.rc0.332.g42c0ae87b1-goog


