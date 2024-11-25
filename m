Return-Path: <linux-kernel+bounces-420463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C55999D7B21
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 06:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DAF428151D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 05:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A1617B421;
	Mon, 25 Nov 2024 05:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6e7IyVx"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53E31632F1;
	Mon, 25 Nov 2024 05:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732512335; cv=none; b=KKkRXMAlmfdE/CEDv3bnP+oZxb1PD1yzy9jqhV6KlEKacvRJtvwU3RMcobRjDkHKdWZC4qj/SAoXSxxWibL5yglqgmi7uDsfYbh8uetdstfIB6NHDtQO9+UMV27G/gCZD6pBCxeWW/E4y42F1AxRrSoj8BlykiEfQu0vkkzmaDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732512335; c=relaxed/simple;
	bh=ewpSy87GKk3ODmjzJvXb0r2TyqTHeq3BXBtQEY4c1BE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uKLpWrLHK6qzLrZUVweMLAVDDunRQM3eXxHtaeTsbVJA5c7FExqzW0g1OsCIYF3fqMKC/Gq1noOHphn1hMa0RmuE6cerUxOhHrqRFzFKCGGwLh1d1yXdU0DJJEVELXL8oEIvcE7WG5Otuo8BLYOgpLeglKKddOxgdYWixievsS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6e7IyVx; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-71d41932d32so443457a34.0;
        Sun, 24 Nov 2024 21:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732512333; x=1733117133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuOQJ2SkMr9MVCpuQjB+HvX8BSfQHaT0CbF4h7Jt34Q=;
        b=L6e7IyVxLVQo9K/8ENJlHYlJHU9kebdeWlAWftVrKIT1c0394YvJR7k5vedyJOUV2G
         V9r2eh+4P+ZRonczO0xRy+b+GoAp0kiWEsqz2L8aANC58HVGveShGwc5IK4rOaqdYVCL
         XQmCpdxUalzAqAKI5nR3eeGh7YVRb1pVzuttbJUlbhtTagGxP13e7RWUCZCTGXcpNwTM
         veANwyNLDG0OYha+s0MbFP6xP71jD7oWUMEwY0JAZXb8nzD5t1kCkLW7y5BdIs6RApx1
         MAd2ojsSorHaopxTZHRmOMNYdtY3ZC3d5VvZ3pV4ChGWTs0WT9HG2z3jrHLzVNcDFIwy
         UeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732512333; x=1733117133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JuOQJ2SkMr9MVCpuQjB+HvX8BSfQHaT0CbF4h7Jt34Q=;
        b=A5nrkSWZcphdjX04HcE9hZCrjEarUIRRK5GnV8fuApEa45UyjUMXQL3O6c0R0K7Wws
         m/rWGW3aXEkRgCt/Vd8J4jN0rkmgRjYIsL7GM6z2wcEgNj0PXx8vMhzrvz5xvcBOkGga
         vaKu5vP220gO1ehcxw45Wo665C6ag8YRX87ffQY/Gmc6x3s0wd3VqI9UNNcVMkD64CR8
         xtn5Mj/8O0Mfg3QnO535vbeUurk98FycnTTHizFr0L2ne5bv+75XpSwkvO3h5FmTJlGN
         aeIQFl36L5PSGamRjhZzlm1UB0Ag2l5bB7fx4WYR9eb669Vs6vsK7B2/HajYxPrqZUBt
         /RUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7CwbzvfmmtJ+hDZxGWZMIyRQrPUkJgyl9EMAZor/3HsIWOFjrX6ZMUw1TUZNRaDOSR1e3IyCT6npV5D5l@vger.kernel.org, AJvYcCWpk2m0RU4F09Qp1PY/2dpK5RJRuRff8BQeN6RyNjrL2DXpVMXuNE7smlH6S65wLSUe2jzowxcY/Gbn@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6r8vgatXEC396mRl/TR7Rpd4ZncBbKMwAcVn8MJ4KwPu/t3zT
	pDaLvwfUF73M6hKpN6zhsLyVKlZLtKv2In8PIx/gIwLCRiSbUqZ4
X-Gm-Gg: ASbGncuUnaYJGwLz4UbyvRheO/tTSTfaplws48LFU7AeuDW0kcIEiZddq/aoC5S0Cgj
	Rkfbk7aJV8+FMEqEdEA9fDOZPqcJBSmDSBmK+UoUfcVCyCDoPuRARbd0mH4EVU8vd3U6UsEE0LR
	Ym3jbZnE+5e2J9aOq3uuqo6YOu6s/R1zhR69+tPhV+hYGM2IOslq7DnqpLbY3DBglINBWsvI6zT
	D8buW5uCl/wikWnMEszyfJSn4APLHTi19P1ww68PD8AC2LpnkT3TYZL9Rd7VoBgBSSOc8EjcG6D
	xKUIkMqRF0rVeuQ2O7Z1OaUY1Djnwa3MqZg=
X-Google-Smtp-Source: AGHT+IHtfvucq6U9mAu5ufGyGi1M4cqxlrC0u6NIo6vYE0Nh2x0INqalF/owdWqB41+rN6DU0Hl1Yw==
X-Received: by 2002:a05:6830:6e0c:b0:71d:4660:de72 with SMTP id 46e09a7af769-71d4660e45dmr3046828a34.27.1732512332791;
        Sun, 24 Nov 2024 21:25:32 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc1e2490sm5698557a12.31.2024.11.24.21.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 21:25:32 -0800 (PST)
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
Subject: [PATCH v9 1/2] dt-bindings: mtd: nuvoton,ma35d1-nand: add new bindings
Date: Mon, 25 Nov 2024 05:25:23 +0000
Message-Id: <20241125052524.135362-2-hpchen0nvt@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241125052524.135362-1-hpchen0nvt@gmail.com>
References: <20241125052524.135362-1-hpchen0nvt@gmail.com>
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


