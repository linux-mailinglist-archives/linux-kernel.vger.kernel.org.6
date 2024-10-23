Return-Path: <linux-kernel+bounces-377760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E70449AC65E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C19BB27263
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E40C19B5AC;
	Wed, 23 Oct 2024 09:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvA1tyx9"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F6919B3F6;
	Wed, 23 Oct 2024 09:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729675588; cv=none; b=DA1jQMZFizGLxP7E3j8xAbk0o3miUwNew77BczCLb0HZ00/CYDNGROG6LLZIM3nWJihm2LBLyc55El/yh1valrCXP+wye3tBI4sut9wfv5Z/GAcLe2uJ+bcbKFokcAUN69tVHk1zRoBRtuCyjc2n3dU2Acw4LLuPBWQbeeoro6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729675588; c=relaxed/simple;
	bh=ewpSy87GKk3ODmjzJvXb0r2TyqTHeq3BXBtQEY4c1BE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yru1ecbbvVYU3bQrkj7LgF4RlllTyhNMHmmmilx1FgTQay3BJxyHKOGBEoRaYX3/TQfrGEUEqb1C0HSE6trD/lfGvOQXQGoeAEk27NcKlXyasevq9ElKB0fquMYqTp/7aqj+2m4cf2+8RJbGOIef5xGO69qh0N838Ojxv1XzuJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvA1tyx9; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ea76a12c32so5309406a12.1;
        Wed, 23 Oct 2024 02:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729675585; x=1730280385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuOQJ2SkMr9MVCpuQjB+HvX8BSfQHaT0CbF4h7Jt34Q=;
        b=LvA1tyx9k16Y7HwoHxoR5TJCSUAwWMgCgXloIxSuxglRCnbAPWyJHgUIqtpEbT02K7
         Tinyjp65Gays3MsSZyqX90lG1HCz7J22DbCROjPNnO2CJPxvGhaCfL33iZQ5H3rn/ldu
         TGuhvkDu+YVtzTZ69uR1RrjZIPkv6yHSpe8joRxfoy9g3fg+xhyV16mxZJPw/ez0l9y0
         e0X9dF55PmCGLqGdWiwsHRP6H4IRRFg+I06EvoQmqZ9JUGYQj8KfCRqh2M+8ZFUKrcbf
         IMSTYsz1ErjpYqEB95i3+094RaT1vlPD6SaS7bOOANGEPDNnm/mu0tjLzZf+02BfLUbh
         Y2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729675585; x=1730280385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JuOQJ2SkMr9MVCpuQjB+HvX8BSfQHaT0CbF4h7Jt34Q=;
        b=ScpElITpTpOu+SUxJgVx3/B2rvLqHctCfmCNVMwo9vmAi3eq+mf/YrdB0nzE+a7v2f
         3dZJ/Urv4kkjcNPxwb0iXSp2Su18YL61AAfv5/6/CYcVFoyS09WkLS3QJmM+CBQuFRaN
         0plZ7cnXOQgsPL2kWyIE9lo0SQdcOcBJ+RZ1WzRKxYDSlvm/mUrTo0Mel+b+78PZLvd2
         y4ely7U+iuQLF0tNfv+d2hRgOwZZWDUoSmZVtmMI9DA6aqedYjH7P3gI+nujsQGQZiNf
         ct135WaSX8bjiLiB9kQtU2uKlfRfmQidtgQXRtwE5AwjWDM02DtAeE2L8ZUVKS1cPGi3
         z+Gw==
X-Forwarded-Encrypted: i=1; AJvYcCVoddX1VVD5LEvKjEz3EATVwhTF1PrUBTgx48RkyM6n7URVeOKV4VbvQzHkNEJ5DNfNM8SKEPsskDxP@vger.kernel.org, AJvYcCWeOGuRvSPRYIWQnsF5KqQImZlqg9GFbajE9RNH+Iq+iXfFuiqmCJmljMWwHS42J5sdOjXx2GWeMxR40zux@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt9Qczl0wfogPsJGSOy3iedIpnt+XFo63gEGG81//w0j0WAzBv
	+PD5zQDwVnhiQM8W9gpoVzLLMmX0o2kI+VOZyrnjbdefDn0GpgQ3
X-Google-Smtp-Source: AGHT+IFgSuaonEQKbpOdhU0C+5es5y80LkBF8oAhpgGB8tbojbboRAl1ZErgSSK1qa/OIURV/s+OfQ==
X-Received: by 2002:a05:6a20:d49b:b0:1d9:215c:c63a with SMTP id adf61e73a8af0-1d978bb324bmr2151475637.47.1729675585407;
        Wed, 23 Oct 2024 02:26:25 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0bd376sm54041635ad.132.2024.10.23.02.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 02:26:25 -0700 (PDT)
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
Subject: [PATCH v8 1/2] dt-bindings: mtd: nuvoton,ma35d1-nand: add new bindings
Date: Wed, 23 Oct 2024 09:26:16 +0000
Message-Id: <20241023092617.108021-2-hpchen0nvt@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241023092617.108021-1-hpchen0nvt@gmail.com>
References: <20241023092617.108021-1-hpchen0nvt@gmail.com>
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


