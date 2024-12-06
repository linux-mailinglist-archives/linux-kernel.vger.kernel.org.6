Return-Path: <linux-kernel+bounces-434305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9AA9E64A2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 04:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D336E1885590
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 03:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC16319047C;
	Fri,  6 Dec 2024 03:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miyavHvr"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B286118C03E;
	Fri,  6 Dec 2024 03:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733454809; cv=none; b=pUdzGW6qzTXdrUGsW9Ewr4ctJ5nsIkHoMKCRZwk1CQiXVPfRfYfrLG50w638OUXhgk/35YeU5DAaiiDj32gmaUbCsXL8HQkZcWsl+MOu3amhkr3gQf7lBi7sfueyNZ6tR0OTO9ElFTFKfRfS4e54q9+WeqW/GiPxr7QiGqIcjp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733454809; c=relaxed/simple;
	bh=ewpSy87GKk3ODmjzJvXb0r2TyqTHeq3BXBtQEY4c1BE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dtAmn1Js4FnDolfwrNIco8Hn1/BYTwND6LVB5Vwc4nlr+7qd0TPr4qof8mB6pMvP1rXgTEPYA9apL9u+Eif+EKXJcQujPC/yLI4csVZhnLFa8ho5P4IrbEPq0FM+EPznCIhL+087lKssyM9cPVR958cAjrDSECLWqQDVHkmx7o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miyavHvr; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7252fba4de1so1881981b3a.0;
        Thu, 05 Dec 2024 19:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733454807; x=1734059607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuOQJ2SkMr9MVCpuQjB+HvX8BSfQHaT0CbF4h7Jt34Q=;
        b=miyavHvrAJqWq2L9pF22Vo7CFaLPzC8iDN9ahfSUB033DKp8qWiMsBdEIar0uUGlUF
         tA3pLrm+HshMEEE7jvSlMQFpf7xzUyw+EfDSpA3sK1//OVPD6DfHyUqd5YHWaESRsCwp
         EENzh2gmaEXnyo82PAHPCr9AOWFn/mYmJUxb4DwV5Mi/QZb0x54S46B/aZ9He73+m/0U
         sffLiZOMm5yP5VPMUkLufI8FVWg6gey4EZqEY563oEZQQMOVRPPoygmN2P5Vtgt6mgsK
         Gk40HwhZMZP0r1CMym/4GQsdjZnKPzJH9Ph6zWeokOUCFliMXbjCiBZFGL+uzGPqS+Av
         RuKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733454807; x=1734059607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JuOQJ2SkMr9MVCpuQjB+HvX8BSfQHaT0CbF4h7Jt34Q=;
        b=ETG+tw/T8lAnNZlh5A1VeRnjcZWCtAzMd7ZCZ2X0MeNF0ng+ao1Bc8eV4IXjGtUShh
         QWWTffqOfesxQHKGWYHCBQ8F15ug2rZjqF+h2xr4IN4wmWyh/ndNAo7ylNOaKDQ2ldNj
         LyCv5Rmv9iA/TKMU3P5UDRyNpCp6ne52M0yfHIPg4iH93auEjxbuii67EZzp+c/GdlVG
         fPZqr6ho8dohKw0ZbrU3bpXwXCENJsr2RRSp4cHOzGn3wtLM1DETzOFizIsexL0cm9gP
         psZWWmVwLLiPiUY/d6GcrRRNSUGbmuejxdAmkv1Ue+4CyzefsKM0By0LO27ibhLrfJjG
         ySbA==
X-Forwarded-Encrypted: i=1; AJvYcCVUYKgvT+gKibJfN8tUvR/zbD9a+IduKK68JtsrqnwLXB2mUN3aUHc2QRDURHiSrubzS+Ez9jJtopVD3vmx@vger.kernel.org, AJvYcCW8Ic2V5kYytcOJBse2IeFX13wNzsi2OF3lJ0DkK7EIjk5NdRunDgMd2VTa4GBTRA7kwy7T+1pzy7y/@vger.kernel.org
X-Gm-Message-State: AOJu0YySvzBghxJX+TxYpH1NtUrqiH0PeMPIn7Lg+A+Ed+vMtqs90lES
	jik+mHrJiEtXnSXvzILIVQqZHeZcc7R/E3P+9TiRuoX4aUWEig9w
X-Gm-Gg: ASbGnctfIASGOTv0cV0YZZ4G4POVpzBe5xguV1ax7cf9VtnIHS8PviqfKC4P3seHGZQ
	oC1WI0NArfjkJLjXjpbqpzbvEAl8iXRHoEhS3AG+O47r6w57zJC0WiUo3AP45HchvnqiNe0x4ud
	qaaA4Np+AHs5ePnmwNfgpcXagqOcE/LPL0aKQpAHZRL0+mcIwkjBtFI8uzMwMlsluUorEU1Z4N6
	5g+RTdj3w5k/ujlMzScRQcHARGokcxPDZGmf5QRedfqp8cfmuuXeVOJedQ8eU9t2usaL9BCyhJI
	DiZJ5KEBBbpqGxbzW5m0vS1YX3SHukR7YXw=
X-Google-Smtp-Source: AGHT+IFG79erwAcKYIbcdG6HiYsY6FuhsdbcOyL2J1Yhh14Eott+QLsa1nKgm+/WkfeveOKenOMEkg==
X-Received: by 2002:a05:6a00:894:b0:71e:5b92:b036 with SMTP id d2e1a72fcca58-725b81be43bmr2345419b3a.22.1733454806821;
        Thu, 05 Dec 2024 19:13:26 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a29e9003sm1966791b3a.44.2024.12.05.19.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 19:13:26 -0800 (PST)
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
Subject: [PATCH v11 1/2] dt-bindings: mtd: nuvoton,ma35d1-nand: add new bindings
Date: Fri,  6 Dec 2024 03:13:17 +0000
Message-Id: <20241206031318.156152-2-hpchen0nvt@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241206031318.156152-1-hpchen0nvt@gmail.com>
References: <20241206031318.156152-1-hpchen0nvt@gmail.com>
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


