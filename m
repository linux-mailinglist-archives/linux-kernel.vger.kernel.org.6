Return-Path: <linux-kernel+bounces-341223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C36987CDA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 04:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41F611C229AB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 02:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C1F16DC3C;
	Fri, 27 Sep 2024 02:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TN/OSoFA"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0200116BE01;
	Fri, 27 Sep 2024 02:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727402879; cv=none; b=G/r0l/lUgc/8YwYJTIakDZQMaARQ8rDyP0Is/eLhVGYIY+pkVpkr9D5Rb1GFShNw7NkT7sDpJF/zR36cClMRRxHXG72uDSQ81qq8nicVdZjWBUtA3mc63A5xGpIiTiyj50UpWTHSM+FbrdQvpUNclGpkKjraiQ4S+CLfstxMObU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727402879; c=relaxed/simple;
	bh=1z9fnWUuNK0Pc7cPE4EqMowbgf5W39Nzy/4+d/iZNHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mzPQRDySQHXLrTpvmMmn8/o7E95+VzQul/s3KG7KOAQnnbGklDOGPJzP0ncVbL++udA6cphl2EH36YckVslg7opDkbkqsLSiGYkvoWpJsKFKLWGTgVcRH+aPxB19Ex66laTiMaiJkjSBo48oLaa6XpqtaChN5myE843R5K2J6Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TN/OSoFA; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so1329702a12.3;
        Thu, 26 Sep 2024 19:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727402877; x=1728007677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjX+GWxHlPwm32RdWG50sup+7/ylH4rWNpxlnfN528U=;
        b=TN/OSoFARGKdrgoyknyyO+4T7bQ5GqYU5gRPOrNCp9hiaa4rZeSlTDFL6J6WOhSPxb
         xgDXMGH6FS3umZvmfJjH1XYW36jeON5i3nIvC+Ik24s0n+Kp1n3JUkeBIF87AxM9aqwN
         mhJ49tiZslPQsqo7Z1R+i+3LQ9g4EnwmvPUGhluxr5aCSnpDN1rT8lSf3pig8W7KGYIk
         rzOuTK594o5Z2eWuiomOU4wJo7NX72YacX8Rgdj514DUHIf9BvUPmTVvY/c2wIK3Maaf
         9P/VQnprK2uCC8MDqR1hlzXdjyHiiCUkOneqM9riwg5xZfoBHhJ2SHIVvEq9bW94D4Ih
         06dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727402877; x=1728007677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjX+GWxHlPwm32RdWG50sup+7/ylH4rWNpxlnfN528U=;
        b=Wm4S4A8p5xGkR+8Bt5rBjRXYs1xpyUuXURgKCRJEw9NMFJ6Po8avcnrhZImnhSdLqT
         uCtRayBCHw72+ccRz+lmf3h4cATuaDFPbnvECeXQmZ/Li20RXGTLI7a/UjJGVC7aoo6e
         6P7unPBxs8ANHKBzfTm8Mh1lNnj9VXUppCsd1sp0Feedmtlw8q3QAkNv/lpkD8wy9c+v
         9PIq64/m1stZ47J8uvcNHwRX0CxubCTAG7sy++M9RKRqoHn/WGNtiYs+MIjB7YXynhtY
         xcd65IYujde1AX1oGw5igh4GNh0H9aKXuz2helZQC4EAjOzfIo7PCHy+0oo6yvtOJjhk
         7aSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0+BRpZ2fpJWv8ZmKkOPu2AOfaImH25hlPauRqvvkO4NArCDDT4i8Jf5NojVBGKFCX455abZmhMozx@vger.kernel.org, AJvYcCWt74etchLf7ceuaX+L0UUUw1ITv6YnWfwqFj6tAIj7NSRsAuFy2kG2YM1B844UiJGebJ0l95YJJDCcbwCP@vger.kernel.org
X-Gm-Message-State: AOJu0YxdpQ0rgyGNpvy5HInFk40/y/s4FSGONQfMBrJK2Cji4nMBis6/
	4Dn/caQ3ZZXOfcA+/4aRweA8lnqmToBll1hkVjjwsn+VbwuxPy5m
X-Google-Smtp-Source: AGHT+IGQrURPuLL03VlNzLabx+LnqYRpPBw4Qu3jlVnfp/LNqLQAD4n09C0GEYLf4ADpxipDIQ6Hsg==
X-Received: by 2002:a05:6a21:3514:b0:1d4:f9ee:652b with SMTP id adf61e73a8af0-1d4fa68e9camr2677265637.18.1727402877260;
        Thu, 26 Sep 2024 19:07:57 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db2c66e1sm561022a12.47.2024.09.26.19.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 19:07:57 -0700 (PDT)
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
Subject: [PATCH v6 1/2] dt-bindings: mtd: nuvoton,ma35d1-nand: add new bindings
Date: Fri, 27 Sep 2024 02:07:48 +0000
Message-Id: <20240927020749.46791-2-hpchen0nvt@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240927020749.46791-1-hpchen0nvt@gmail.com>
References: <20240927020749.46791-1-hpchen0nvt@gmail.com>
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
 .../bindings/mtd/nuvoton,ma35d1-nand.yaml     | 93 +++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/nuvoton,ma35d1-nand.yaml

diff --git a/Documentation/devicetree/bindings/mtd/nuvoton,ma35d1-nand.yaml b/Documentation/devicetree/bindings/mtd/nuvoton,ma35d1-nand.yaml
new file mode 100644
index 000000000000..a8a549644c98
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/nuvoton,ma35d1-nand.yaml
@@ -0,0 +1,93 @@
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
+      nand-ecc-step-size:
+        enum: [512, 1024]
+
+      nand-ecc-strength:
+        enum: [8, 12, 24]
+
+    required:
+      - nand-ecc-step-size
+      - nand-ecc-strength
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
+
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


