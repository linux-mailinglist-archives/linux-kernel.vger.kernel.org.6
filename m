Return-Path: <linux-kernel+bounces-261844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5132393BCD9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7E61F21E8A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 07:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4414516F26E;
	Thu, 25 Jul 2024 07:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KipCyvzh"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85C216E887
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 07:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721891164; cv=none; b=i7rBET0OasXd2wZbXVRZlT820oustd9zulAJ6PAyeKV8RFVqkIaygnKc6EHVwtkD3ImE2CROT3ZZlYBKLbW+inDyR7OKfOxxb6YAgCGO5Fpu5Itwq9NcRTDq3vb53W8ea+M/A81cRvq1pNh/zmm1dZbEkY286SeUDqe0P3TeYIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721891164; c=relaxed/simple;
	bh=CHlJmucPNbTooY/cIPar6d813VxryIVawWhVxhMioHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hLmvcQvW13i45mf/j+ltqYD5DXHviCOQ28tJMaFq+dXNriGGGeB715FumpYPgIe3RCSnsN2N1vRwZKGbS3NHbhhINYcxnJgFruBZVTJjcny8qxZ7xq7OSeXDQ5XzQYjXHy6RkPeD7dGdOU+HSrOmzfleOetVS+f6HseQdMjuCt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KipCyvzh; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7ab5fc975dso17022766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 00:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721891161; x=1722495961; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gOTZHYO/lqNhZCm7gTaweDmBGXw1jkQtgojTqIvh5FM=;
        b=KipCyvzhHjeF5gTK9FHpVIPlzpU3joWg8oJ1/S0gJfKVpC9Yen0eDQoXSHm6oyNvm+
         Sde7mW0ob81Sg34MRcJURj8je8RW0cBsTBin4f7K53zlm/QfQDrR4t3VVXR1koNXXYV1
         8+oi0RZ4P5+E/yt2hyt3+MGsNS7gjNa26Wz3tqsJIl000rnjWVUKf6609HcUN7JfzT6y
         dBlJ5osw08hBHFEFvmtp3S4kmmvYqMWCcfyfBUA7+ETXEea8wv5nr8hqzfzZKGL7W8Bl
         BdgMjOl0O+gug4fIxKnbeHB6wmcXjVdTvnnTchjRlE3M9vVGdCjVOzftlygoXvYAZzZj
         kzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721891161; x=1722495961;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gOTZHYO/lqNhZCm7gTaweDmBGXw1jkQtgojTqIvh5FM=;
        b=gN1HyT1R1UO2qjew3ebYmStjcvqJRSUfhZzEz889O6vHUZfZbEqMXZ2N03CVbI/vfe
         PfQO2/0HOZdj4e1Uluq7EsTOR/0jFOEPxQgr22CLw42GW3cFJworzlF9RWg7xvf6heJ/
         gLGLxUqn+XuPM928zkmE1f8Z/sg2Wb2eQY6Si7AFAsHS77L9c6H4e45+zG4ZMUljq7eS
         kCQG4STyIYGsmGgoAeYihgG+VqyxYsBEmAT5+LKx+9OUAEvNtiqJq4UZXpxaZsWSmgC/
         FPpZ3a/hR/soZYQTn3nmSQgGuAVH/0ubt1cNFFWY7axlnBJMWUEzN90X3t34NktJaF+z
         HLow==
X-Forwarded-Encrypted: i=1; AJvYcCWRQIGud7PokaouSdqQmmOR7qeE7+koBFUPQGe+t7G60GXyQ8m+7bnbyhr+icYVHcgEeo+4ge1jTXeX7L6CLbvBHFiDOkhuimAFrZSm
X-Gm-Message-State: AOJu0Yzqdvtk/sV71+NWZoZ4XIlGKt0sY2ib7jTlinO0NZcT35wOg+Dy
	O2W4zvAmlWIe6AHJG7LqnTg0VxLRhwlopzi9T/sj3m2LB/RpDTfAD1plDcYsr+c=
X-Google-Smtp-Source: AGHT+IFuRqsE0mF4On1rhIHc90IENgUcCINfM+JKK9IIHDmswQAsCtVg1p/AaW75wX2cHabxNqAOuw==
X-Received: by 2002:a17:907:d17:b0:a7a:ba59:3164 with SMTP id a640c23a62f3a-a7acb821251mr79754466b.53.1721891161055;
        Thu, 25 Jul 2024 00:06:01 -0700 (PDT)
Received: from puffmais.c.googlers.com (118.240.90.34.bc.googleusercontent.com. [34.90.240.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab2311asm40253566b.18.2024.07.25.00.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 00:06:00 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 25 Jul 2024 08:05:58 +0100
Subject: [PATCH v5 1/2] dt-bindings: serial: samsung: avoid duplicating
 permitted clock-names
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240725-gs101-uart-binding-v5-1-e237be8253a9@linaro.org>
References: <20240725-gs101-uart-binding-v5-0-e237be8253a9@linaro.org>
In-Reply-To: <20240725-gs101-uart-binding-v5-0-e237be8253a9@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

This binding currently duplicates the permitted clock-names in various
places, and when adding more compatibles, clock-names will have to be
duplicated even more.

The reason is:
1) subschemas (-if: ...), still have to match the top-level:
       pattern: '^clk_uart_baud[0-3]$'
2) there is one compatible that doesn't follow sequential numbering for
   the clock names (samsung,s3c6400-uart)
3) when limiting the number of clock-names, we also want to enforce
   sequential names
Because of 1) and 2), the patterns can not simply be changed to
constant strings, and later overridden in a different subschema (for
samsung,s3c6400-uart only).

Since we can't populate the top-level clock-names based on the
compatible, and because when limiting the number of items we generally
want sequential numbers and not a pattern, move the permitted strings
into a subschema of its own and populate it based on the compatible:
    * 'uart clk_uart_baud2 clk_uart_baud3' for the one outlier
    * 'uart clk_uart_baud0..3' for everything else

This way we can avoid having to duplicate the permitted names
everywhere.

While at it, add blank lines as per the universal style, which is to
have blank lines between properties, except where they are booleans.

Also add another example using a compatible that uses the default
clock-names scheme, as opposed to the existing example that uses
samsung,s3c6400-uart's non-default clock-names. This allows testing
both versions of the clock-names property when running
dt_binding_check.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
v5:
* drop now-meaningless top level clock-names description (Rob)
* collect tags
---
 .../devicetree/bindings/serial/samsung_uart.yaml   | 64 +++++++++++++++++-----
 1 file changed, 50 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 0f0131026911..0075712e7be8 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -56,14 +56,8 @@ properties:
     maxItems: 5
 
   clock-names:
-    description: N = 0 is allowed for SoCs without internal baud clock mux.
     minItems: 2
-    items:
-      - const: uart
-      - pattern: '^clk_uart_baud[0-3]$'
-      - pattern: '^clk_uart_baud[0-3]$'
-      - pattern: '^clk_uart_baud[0-3]$'
-      - pattern: '^clk_uart_baud[0-3]$'
+    maxItems: 5
 
   dmas:
     items:
@@ -103,18 +97,45 @@ allOf:
         compatible:
           contains:
             enum:
-              - samsung,s5pv210-uart
+              - samsung,s3c6400-uart
     then:
       properties:
         clocks:
-          minItems: 2
+          minItems: 3
           maxItems: 3
+
+        clock-names:
+          items:
+            - const: uart
+            - const: clk_uart_baud2
+            - const: clk_uart_baud3
+
+    else:
+      properties:
         clock-names:
           minItems: 2
           items:
             - const: uart
-            - pattern: '^clk_uart_baud[0-1]$'
-            - pattern: '^clk_uart_baud[0-1]$'
+            - const: clk_uart_baud0
+            - const: clk_uart_baud1
+            - const: clk_uart_baud2
+            - const: clk_uart_baud3
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,s5pv210-uart
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 3
+
+        clock-names:
+          minItems: 3
+          maxItems: 3
 
   - if:
       properties:
@@ -129,10 +150,9 @@ allOf:
       properties:
         clocks:
           maxItems: 2
+
         clock-names:
-          items:
-            - const: uart
-            - const: clk_uart_baud0
+          maxItems: 2
 
   - if:
       properties:
@@ -163,3 +183,19 @@ examples:
                  <&clocks SCLK_UART>;
         samsung,uart-fifosize = <16>;
     };
+  - |
+    #include <dt-bindings/clock/google,gs101.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    serial_0: serial@10a00000 {
+      compatible = "google,gs101-uart";
+      reg = <0x10a00000 0xc0>;
+      clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP1_PCLK_0>,
+               <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP1_IPCLK_0>;
+      clock-names = "uart", "clk_uart_baud0";
+      interrupts = <GIC_SPI 634 IRQ_TYPE_LEVEL_HIGH 0>;
+      pinctrl-0 = <&uart0_bus>;
+      pinctrl-names = "default";
+      samsung,uart-fifosize = <256>;
+    };

-- 
2.45.2.1089.g2a221341d9-goog


