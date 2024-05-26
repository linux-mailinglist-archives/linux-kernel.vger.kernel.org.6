Return-Path: <linux-kernel+bounces-189840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9449A8CF581
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 20:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51FF1281186
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 18:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520DB56477;
	Sun, 26 May 2024 18:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfgLfjod"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6A21FA5;
	Sun, 26 May 2024 18:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716749138; cv=none; b=IPJ4M4vPPbMtc0jGsdbnh/LDdg/Dm4pRC1v64XQVkrVwc2Q1ENatcQkPMboRP0XCJqrM2t83MTjhkIwWfyzpC8OH/vCFudMAyhHn4+xdyai8ZWtDkZYgo0zn2Wr3JHDfDdSBnHzdy6XpEf5zW1Dl+R6d76P6TKMpgs8uIPCFcLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716749138; c=relaxed/simple;
	bh=kBxqKZt3yNiBobYLsd+AE4sKuvGrJdLiY2b+Bt+0qno=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bkadFg7/213RerL1ceQWdcb00RnRzjX5HvdBtlSj5tL0xiDx0SiYKpMMOYAYc2UKqbzLIxiXVlhk1/HKlycB8v6JwNbA4MPee3GZBbnCshkn0+pKopHHuX1djtWr1rJAvh3cjfW7LkQ3yQ25kuKMFSWO5UBcADdVNy0Z2QyFvEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfgLfjod; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e95a1f9c53so31491101fa.0;
        Sun, 26 May 2024 11:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716749135; x=1717353935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=miLZb61bb6eHKVsGFJqgSUKqREuKVQ85VCQ63BLN4t4=;
        b=OfgLfjod2vU9NMat+fTqXCOPcJsT0fTMlMP+7GLbkBWkQVhSkH5XJuzj2ZPJmUdfDy
         7+wB5MIbO66zEe5bMROt35ox6jSX/holij+z1KNL3VHDYZjRnMKX4MeaR6tPxhl3fMxQ
         0lYmfZ7t1nuidxj55Zn3lUseLTLEHDzjfwvDoiRnvkFkljzERcO+9UuBi1QRMD2W/9rw
         JoaseO251qrENwQO5LXEayrDhs+bbib6GJ4IcLrf3SxNSOfTdF/ArHobBIGiDfqeOAjr
         Xe7Ll7EmbIS2Y0deThbDEMz506QdXCRywdSc2vhI6NG5ED/V0pS5QHX68edp0DDmiz6t
         TTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716749135; x=1717353935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=miLZb61bb6eHKVsGFJqgSUKqREuKVQ85VCQ63BLN4t4=;
        b=Ksc++e5yn2I73lISYf5NlE8uMjQQrmSizA6TV5Sb3j3fJ7FJl+4rZsAr6JwY6ql8ei
         sFfio8WG0MW66JrVoxKzxnEQ1xF2EcmrUrOHyussLhYPsFlxewNJjpRUskEIz49oI3oJ
         6lIfNg1uxt47ErFP6VTZtfrCcxC121RsPm6qqKJ0OhMMiPHINX7P7uKU23KuAw6+bGNv
         ygliATAhHzUXX9xeoEYy0LVilJuvMAupSpMjXeEfcc1lBVtug3n61M2dLCt+GZFUQUPM
         JNNBxO+lEBCfEIFiOUHTyi8ZqfgLE1ASyBb5YIVV6knhdhS7s9CRiHrHExWRZwY3G2xu
         cloA==
X-Forwarded-Encrypted: i=1; AJvYcCUW1egqPbbemvRNRMN3R1lSbfAB1drcHJdpIEcSisQ9Cco8vG5Dj2CpO5JFZTpwAVG4JZq+rVmIAsl2gU5w9YB7RH2kY4ASGBQ5gLSWwuCViOneGwXgc+3UTLI0XPxOF8T4PNPzr7Cnf6vDsBJyJnLYHI5vFKkb2+vVS4d8e1Xwbvu9dJNZ
X-Gm-Message-State: AOJu0Yx2N67vpY/i5UEPwHjflbC9TnHlZyzTSh9LEi9ZE6UVsttN6XPQ
	R8eJHVe5YwyZ0kVxGq/rDrcF/Xiaa7XaQ0rEUbyA/mbgkjnnqQz8
X-Google-Smtp-Source: AGHT+IHSCfugX/hh3BML+J946B+KyEq7nhGjevAknvFRJgmvi01bsdZjuw2ImLGRO7NGEScNBD0o/g==
X-Received: by 2002:a2e:b70a:0:b0:2e1:adc4:47f6 with SMTP id 38308e7fff4ca-2e95b0945d4mr45205081fa.6.1716749134608;
        Sun, 26 May 2024 11:45:34 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-421089cc504sm84960075e9.40.2024.05.26.11.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 11:45:34 -0700 (PDT)
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
Subject: [PATCH v2 1/3] dt-bindings: hwmon: g762: Convert to yaml schema
Date: Sun, 26 May 2024 20:45:23 +0200
Message-ID: <20240526184526.21010-1-ansuelsmth@gmail.com>
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


