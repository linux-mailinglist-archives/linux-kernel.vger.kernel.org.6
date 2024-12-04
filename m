Return-Path: <linux-kernel+bounces-430496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79EA9E31A2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 03:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 870C4285077
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 02:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7906213D281;
	Wed,  4 Dec 2024 02:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDCi63OO"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5888284A2B;
	Wed,  4 Dec 2024 02:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733280700; cv=none; b=SDDxWDYvUUDI70rJlaXmgA2SiTu1qu8Hxm4cP3NFgs7pIYfLwUkwaC1Os6MIaQmr3Ju1frNvkhY90S+3DPV89Fm9IoJlfzG2Z5lK/0qivJQvVukbmIupPiFGb/GezSPaBYJ8nlhUX9FIjoP9YS/EMi97cNRnhnt7SIDWQBXLkiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733280700; c=relaxed/simple;
	bh=ewpSy87GKk3ODmjzJvXb0r2TyqTHeq3BXBtQEY4c1BE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FAOenN9zZwE7/rdHYOb3P+MI8FXqnvAKYP/8R5UyfvvBRBv156zURdRw+9ni7zKSMi0nQhqv8ebdtJmCO92G34qyW2FoQBeVLV4FPpBp2/6O+dupQNiZTJ2kzL1DO+af08mGCxK1VmGo2YTSdjMlt14ANuT2zOGjwUVp6W02gTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDCi63OO; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3ea3cc9a5ddso3134650b6e.3;
        Tue, 03 Dec 2024 18:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733280698; x=1733885498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuOQJ2SkMr9MVCpuQjB+HvX8BSfQHaT0CbF4h7Jt34Q=;
        b=CDCi63OOrxY8sBYqr6x8fN+vcTBUz9E21NST3IZoL4jN99agfwhLCIfdgNhCenzg1Q
         qu3/hMzXNWa1UrTVWIOCm0/U7TuFyRSDurBi0eEXJaxqqb9rCCKp3jG/YHhTBbVg2CPh
         LZn1pl6jV8L4NlMGh+Cg+k1DrjExKQhFcBY7CHYtjXZSqv6JljeH2ST9lCGPvhr86Yo5
         Idsk2jWRCtkFQ16bkW7IJemxU7kCOFMJ9YlRGaBdkO90LdphDJRwchX/Pj1FEzode4hV
         zTi0tmXbC/z8MOiA5/1MGaJDkp04JvbRI0Z9ZC8rlt4BBC9q5z2BaEL0Dx4JCn/mLmwr
         HSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733280698; x=1733885498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JuOQJ2SkMr9MVCpuQjB+HvX8BSfQHaT0CbF4h7Jt34Q=;
        b=Sg5NgH1cq5NdBXQ1RP+ZOCCqmDn3d+as7qR96YE0sfeXZD688G3RIb38ONxJDtGy0h
         42uIuXK1AXNpdMaEn+oant5ofFtFQ51OynXAagp77oxR4jW/v2NGhx+6WwmU80MgWQ95
         LzDF0acGenjivQM8NTwqHNU+WpXisl5sbd/VSuilHoR3ANt05SdsIs4AFp2LsyvlcH/s
         VURGSKpNEAGE2T+1Fml6FuX9PIW+iNgL5RefFikEPzkobPzjUEh6POFutR0CUKEoNPKu
         m84slIpoGdjm/YXts9yVpjP6Rz6mJEW678uADg88x0TmLHTEhjy6jyD0w99korX/l+vq
         k38A==
X-Forwarded-Encrypted: i=1; AJvYcCUS7KdqfwBZ9Ecq8X+jxcpo1BT1yB2EMZwt9qis68zgiT/BfMHSETRF95JU+3CGAPfb02bywIFqshP+@vger.kernel.org, AJvYcCX0bP47sRPcneH++Cl0075g8Yv2FUknNm0LGB6V9/TJhfx3D3abHX+2/mYKTHwwCAjwaYMrRKKrz0mfEE17@vger.kernel.org
X-Gm-Message-State: AOJu0YyncG30LqRrVcOzZQQTUDxV8fLKhmZYsnv/V5b9owkpEkVvne5J
	osXnvTAmhq3wR7EWRt3OEz/7exmaMo5+SRBlyGcuwhtf1sVwifT7
X-Gm-Gg: ASbGnctEIG+xn4C86wCXzv7rPe1Eka/6L/p3qB0Up/6vLCO0Yo13IcaAWHcV7xxlMw4
	uVP1laWOD5RZvyZBtzgBd9XOFgy1R6JY/qhGUr5QO3/Yd/JRyTNVtvkIX8kTKooR1hHUDspBdlW
	syO7rDUOMgJt/ogIIUpYZQbtFgHqfniGnOZniqDf1ZWXQZMko7G6Ss4nSfbNHDZMjwxUC7r2Aym
	A/v1afHmExPTS0dA5ryAIt6P+L+iwCrQlhhQlYPw0/L32zynqOKRfd8ZnOxETlOiUFno8UnUIrq
	zNeKHsGifEZJfQh10/1M6eKgcvpatOLGO+w=
X-Google-Smtp-Source: AGHT+IGdgZmYcROU3GLrE/Lnsq8td5WaI19cpYlW7mWHLWAFkUTuxlmQVvL03z//4tMMMev1am4TmQ==
X-Received: by 2002:a05:6808:198f:b0:3e6:3860:596b with SMTP id 5614622812f47-3eae4edaddfmr5302776b6e.8.1733280698297;
        Tue, 03 Dec 2024 18:51:38 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7259114ec35sm74543b3a.126.2024.12.03.18.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 18:51:38 -0800 (PST)
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
Subject: [PATCH v10 1/2] dt-bindings: mtd: nuvoton,ma35d1-nand: add new bindings
Date: Wed,  4 Dec 2024 02:51:28 +0000
Message-Id: <20241204025129.150525-2-hpchen0nvt@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241204025129.150525-1-hpchen0nvt@gmail.com>
References: <20241204025129.150525-1-hpchen0nvt@gmail.com>
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


