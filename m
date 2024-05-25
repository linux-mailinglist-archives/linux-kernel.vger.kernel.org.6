Return-Path: <linux-kernel+bounces-189330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CACB8CEE80
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 12:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA8EB281B9B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 10:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29032D057;
	Sat, 25 May 2024 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+KPAZI7"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDD12BB0A;
	Sat, 25 May 2024 10:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716632966; cv=none; b=KRVEiutZlfX/159gnSJ4EINytpD8t9L6Zq9jL+scLX8UQb8qAR6AxA4gWMZ8MM1jbvooClRxOcN+mrtFQCtGhiHIGTyHTtpH2yZLSfuUUMKiF4D7a4DaGDTbgxZB27GcI+8XWyS79iEFtFizI5zdCZOKNW90UhXySes/mcHXbZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716632966; c=relaxed/simple;
	bh=kBxqKZt3yNiBobYLsd+AE4sKuvGrJdLiY2b+Bt+0qno=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=KgM4R0KzgZBrDOJavWNdDDKFtr0At8wnMz4FfbVHrP0xb3tWD2k7v0zbYCZzL/yyNZLpwfy2GPBRHK+p5uohZr9fdFNL8/kAvYuU9cgO7j4mhrsOpJrxk/FKzJMQbK0xOo+qGRAomlp509S/uj8jpTu7s06F5EyDri2aNM1YhSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+KPAZI7; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-351d309bbecso6866885f8f.2;
        Sat, 25 May 2024 03:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716632963; x=1717237763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=miLZb61bb6eHKVsGFJqgSUKqREuKVQ85VCQ63BLN4t4=;
        b=H+KPAZI7ip822Jr+4PsnRAdtTVHfwbNM5ahPkSm73HvghqcVhAaUN5hbTfiQ/kLdq+
         gKS28yi2yqFFB8FMiGR4a/vnW6DgtLOolKCBPjubU8TXAPMo9d76qchZytw7cyVJmAAA
         cD1mhGQ2UplxT5HIUp5OQlfnv1QsQLKd5lTWRcL7WSO3FHYv3xuWPmaQuwbSu2Z93Rk+
         g7yx9s4brEUdwkmX+GhfI3e6O/YTviytQJLhwCsLIs5bD1qLs/zuoOwgCN2iZKXG9P8A
         kF+TbAmAiVS8JfZOGx3I8dgnsZQwi4vjVTtmaGWABxRfDc/8/WFxD86lWNXdQJK6KP05
         ZMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716632963; x=1717237763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=miLZb61bb6eHKVsGFJqgSUKqREuKVQ85VCQ63BLN4t4=;
        b=DYq/bQdhvCg6EoH+EIiX9/lz/NZiInVae3rUz+cyGAHug+YvTYeF0Xz143BXYvvFbk
         brIY7cKbqV/rCkZZBLMyHz4mXO4fXnTfNFCUUQxPnSH+pdm1Tg76O7HYWJWLdRdsA8wU
         MWxOwECFHo8+u1b5W4ZMoAvJ1U6XMpw5/SpN+v08v2Rd0bD1N9/hApFePRKVUAcuqRM6
         Ay/gzy3S8rb+6mFwZwhjiNZUeakjTFKPsXMacdk3lrAMSNsuWczkeMaiYdDacNqmaTYF
         KuSzGP7IyL2eaR9laUA+sSMa3Fy0evFOqjePoXPayWtidRVEO23KZM3xxrSMMRZYwlFv
         yThw==
X-Forwarded-Encrypted: i=1; AJvYcCXdx9VHfxGhzifBjU2YAwoi5FHpyIFhhLxQHywZDler3hkSS/z8U+6nNMxr2AP5zijvwGp4meX0IcCmEp574Swtev9ttToRxF8k9nbzlTVTs2ILLelIv7UPwvMHc88XZvOaBSdR9GDCkRkejx206V+xFP7ERpDXN/jS7m/aCiN9FVrFWUgL
X-Gm-Message-State: AOJu0YzKf/RtVEUJW4NalKNM7eVNiBIygwTyC7pIDt8KIY6nG9ruQZNz
	pHwBwR0WZLYPf+iIe2A6iv683NwvK00Un3j/0inKqvcXro5IgXSr
X-Google-Smtp-Source: AGHT+IFw6LxuhUxXMFjkGKrzwVqjOrq7IxQYbP/w/ZEtUm/8Af6yDC71Wcic05SYGXlh8ur6o0seXg==
X-Received: by 2002:adf:cd8a:0:b0:354:f9b4:e9b1 with SMTP id ffacd0b85a97d-3552f4fe99amr3850617f8f.27.1716632963208;
        Sat, 25 May 2024 03:29:23 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3557a1c918csm3674651f8f.77.2024.05.25.03.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 03:29:22 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: hwmon: g762: Convert to yaml schema
Date: Sat, 25 May 2024 12:29:10 +0200
Message-ID: <20240525102914.22634-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert g762 Documentation to yaml schema.

Since it supports various device, change the name to g76x and add the
vendor prefix.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../devicetree/bindings/hwmon/g762.txt        | 47 -----------
 .../devicetree/bindings/hwmon/gmt,g76x.yaml   | 83 +++++++++++++++++++
 2 files changed, 83 insertions(+), 47 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/g762.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/gmt,g76x.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/g762.txt b/Documentation/devicetree/bindings/hwmon/g762.txt
deleted file mode 100644
index 6d154c4923de..000000000000
--- a/Documentation/devicetree/bindings/hwmon/g762.txt
+++ /dev/null
@@ -1,47 +0,0 @@
-GMT G762/G763 PWM Fan controller
-
-Required node properties:
-
- - "compatible": must be either "gmt,g762" or "gmt,g763"
- - "reg": I2C bus address of the device
- - "clocks": a fixed clock providing input clock frequency
-	     on CLK pin of the chip.
-
-Optional properties:
-
- - "fan_startv": fan startup voltage. Accepted values are 0, 1, 2 and 3.
-	       The higher the more.
-
- - "pwm_polarity": pwm polarity. Accepted values are 0 (positive duty)
-	       and 1 (negative duty).
-
- - "fan_gear_mode": fan gear mode. Supported values are 0, 1 and 2.
-
-If an optional property is not set in .dts file, then current value is kept
-unmodified (e.g. u-boot installed value).
-
-Additional information on operational parameters for the device is available
-in Documentation/hwmon/g762.rst. A detailed datasheet for the device is available
-at http://natisbad.org/NAS/refs/GMT_EDS-762_763-080710-0.2.pdf.
-
-Example g762 node:
-
-   clocks {
-	#address-cells = <1>;
-	#size-cells = <0>;
-
-	g762_clk: fixedclk {
-		 compatible = "fixed-clock";
-		 #clock-cells = <0>;
-		 clock-frequency = <8192>;
-	}
-   }
-
-   g762: g762@3e {
-	compatible = "gmt,g762";
-	reg = <0x3e>;
-	clocks = <&g762_clk>
-	fan_gear_mode = <0>; /* chip default */
-	fan_startv = <1>;    /* chip default */
-	pwm_polarity = <0>;  /* chip default */
-   };
diff --git a/Documentation/devicetree/bindings/hwmon/gmt,g76x.yaml b/Documentation/devicetree/bindings/hwmon/gmt,g76x.yaml
new file mode 100644
index 000000000000..bfefe49f54bf
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/gmt,g76x.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/gmt,g76x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GMT G762/G763 PWM Fan controller
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description: |
+  GMT G762/G763 PWM Fan controller.
+
+  If an optional property is not set in DT, then current value is kept
+  unmodified (e.g. bootloader installed value).
+
+  Additional information on operational parameters for the device is available
+  in Documentation/hwmon/g762.rst. A detailed datasheet for the device is available
+  at http://natisbad.org/NAS/refs/GMT_EDS-762_763-080710-0.2.pdf.
+
+properties:
+  compatible:
+    enum:
+      - gmt,g762
+      - gmt,g763
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description: a fixed clock providing input clock frequency on CLK
+      pin of the chip.
+    maxItems: 1
+
+  fan_startv:
+    description: Fan startup voltage step
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+
+  pwm_polarity:
+    description: PWM polarity (psotivie or negative duty)
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+
+  fan_gear_mode:
+    description: FAN gear mode. Configure High speed fan setting factor
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2]
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    clocks {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        g762_clk: fixedclk {
+            compatible = "fixed-clock";
+            #clock-cells = <0>;
+            clock-frequency = <8192>;
+        };
+    };
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        g762@3e {
+            compatible = "gmt,g762";
+            reg = <0x3e>;
+            clocks = <&g762_clk>;
+            fan_gear_mode = <0>;
+            fan_startv = <1>;
+            pwm_polarity = <0>;
+        };
+    };
-- 
2.43.0


