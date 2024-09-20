Return-Path: <linux-kernel+bounces-333999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D633397D13E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 636851F22EE7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 06:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B80374C4;
	Fri, 20 Sep 2024 06:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4DRy2RI"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C293A43155;
	Fri, 20 Sep 2024 06:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726814279; cv=none; b=VKeq2LlyQcxOiCmrIYoIennGC/y0pdu7hvHNUVEK1xN16KJSNSLJEIcCq6NC8C1j70rz0UNkgFkf2pM8Xlz+8zvhmxDyhmSOCafadNjTvpGZOtBpranF0wegVknbskPt2uuYL7fEeCPiTnXJI56tHAXLFw9pzZSi6PI3JGE4gDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726814279; c=relaxed/simple;
	bh=1z9fnWUuNK0Pc7cPE4EqMowbgf5W39Nzy/4+d/iZNHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u956aXp8ZJ583ddvAGIoQgEKst9HI4l6Xl/Usc1xkjFwDq6vLz1nA9YGlPf13iTt5476yPCEyhqKZbPAQ0z6NkbSfGRrWeU5n8dQ6qcBWN4xB/2L5AmwnAt+sRdXYYU/CG3BSgK/AZkdy7GKxa9it9E6Ctn8tDFXnqO+atFQWlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4DRy2RI; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2059112f0a7so16324585ad.3;
        Thu, 19 Sep 2024 23:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726814277; x=1727419077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjX+GWxHlPwm32RdWG50sup+7/ylH4rWNpxlnfN528U=;
        b=b4DRy2RI0eA6wxThBdB9l7GsDW8QY2oTgk8IIRKGsNKofX9u0rr+VNfWVLc8lErWKa
         EieUYe+XQ1tKiIK3wPKKoGpUx4cxErrQaaByoHWIWfj6AdJ4qBaVh50VSOWKE6549wml
         9hivSmpi2UtMUAqV+nHmHcRh11UhwnMonPTYJSqAsYgcFtN5dRwjjDC075vfjhJCVA/F
         hhs92mT1CxoeSkMZoImvnmqDYxpGFCkV4M9eQ5+9b4SwKA29j34HY/EQ/LIZaLy5tUTv
         Et0b97Ex8o8b5Q/WjVY7FPs8mErremevvP9AB5hKhsOiFiv0VveX4F6eOf0gSQnMCgzb
         vg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726814277; x=1727419077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjX+GWxHlPwm32RdWG50sup+7/ylH4rWNpxlnfN528U=;
        b=JJvrWGjLZ/yITmyXrb9KZ11lvF4iROrJGypc2nI722FTzHCqCPHvDQhqToYPWFlt/z
         +YmdN3yWQXs4iwk4DoBRd1emTm5RqfTU8YtMwZvKQa4ntSoqoW0PlQfb1lvv0SAu4Lyc
         XH69cBHfnGAKRSFv62Yq+1J8OcBBcuZ65s2XYM74o1Uo7zKKjUDr16rbfAgFazx2reKX
         JARgCT6DEHogrdBXQBpyqP0x775B1a3BHkxlDPASt5KHXaFS8KKdWvvp0ZfDbEco4cm+
         zgfFthgi/0V6lHIZW7X80XQxo25kl92fSA1S2PItJRgnDYq888mgGV1AQEMSXKnoYzDl
         QTJg==
X-Forwarded-Encrypted: i=1; AJvYcCU/dwFOnBP4aO6bQdEwqqKu+BRC5o+3IA6li3vEeOsG6+Y3lAiPSleItKdo1VDYJ4j3hGJSlKx2Ii7pnvN9@vger.kernel.org, AJvYcCXUZQBZGMRAAUuVymsK+jW++eXFgL1f4ecTmqHce1u3e9Nr8OaNf/YWqmqvuZIQmPESodiKyczrvBie@vger.kernel.org
X-Gm-Message-State: AOJu0YzPjP3yzbOGm3q5NZYp34JQGc8u9AmXiiyjhzlYmHY6yR2rv8Bt
	t3wFDUnBu/XvbusyOw2nOBUbfe7CUlFwZsrKdElxCkC43QFWyG2p
X-Google-Smtp-Source: AGHT+IFlqeN8lVR0+I9q/5UTEOoO9h5fv4UAcAT8UAAD76MlwNpn3rhH3qdokI5WDFY925BMoNGCtw==
X-Received: by 2002:a17:903:1cd:b0:205:5dfe:7cc with SMTP id d9443c01a7336-208d838f244mr27652045ad.20.1726814276941;
        Thu, 19 Sep 2024 23:37:56 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d64dfsm89106425ad.134.2024.09.19.23.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 23:37:56 -0700 (PDT)
From: Hui-Ping Chen <hpchen0nvt@gmail.com>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	esben@geanix.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui-Ping Chen <hpchen0nvt@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/2] dt-bindings: mtd: nuvoton,ma35d1-nand: add new bindings
Date: Fri, 20 Sep 2024 06:37:48 +0000
Message-Id: <20240920063749.475604-2-hpchen0nvt@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240920063749.475604-1-hpchen0nvt@gmail.com>
References: <20240920063749.475604-1-hpchen0nvt@gmail.com>
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


