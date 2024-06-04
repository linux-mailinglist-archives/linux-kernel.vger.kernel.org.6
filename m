Return-Path: <linux-kernel+bounces-201103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A2C8FB98B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8B881C2120B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59948149015;
	Tue,  4 Jun 2024 16:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEFOZDH3"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7980148855;
	Tue,  4 Jun 2024 16:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717519931; cv=none; b=jept2EJkGg+37Rjz5Fg/NnDIQmBf5BBTMT+CE+vH3KOg073u5G7OZz5o1Vfef/Jv6raHRCQN7WfTwr0nzPp5JAdDtPHoh+pjVNJ2v1osii0JT2sD5gGbN0hV9JGKVxrUyRTg1GEgYE7k1hZ5exumM1NqzSYPohJBa+2JWOLPf40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717519931; c=relaxed/simple;
	bh=5xgUfNefMw6wri/wlUNbDyhBSguJ3pHNq3wLRAPp26E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=AwQePvr6cGb8FI5NVUjcXAjAnircG920xWV52EkT6rC7CBvaJuSGKCabsB/tpBCBC+0CaaSozGRRqds6n+0SvG0yw1RaSTKtS3tSVTNz7+po8QKXXFbYBobZPQGO5eUeYn6u4PFmsVucyTiInp55QmmR4UvvSfIQ4S/XfeyAghk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEFOZDH3; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42147970772so8118905e9.0;
        Tue, 04 Jun 2024 09:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717519928; x=1718124728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=B1Jmxeyxl2JTcXXAAs8GoA7peZQ32QIewc1EvPktBMQ=;
        b=XEFOZDH3c933LHZJ6+NfoYwORg7bNUruoTf/cnPm4ftjYqnwq39BMBZ12nKqV33Eve
         D3dPKQeCkNRrhiA5u3yWFcb4oOK1yDnkYma7mWEzda6Td7vE8VsuDBmJP5EqJWyyV2tf
         deYKLeh1Thyy43Ki6DS0N5cbljKc+y4cKfeAxkNi0WM+uy9oEeoZkoJeL4IMjaP4TXpi
         fsTQdqAI2Rdi6UbVDeu/eEME2Rw794wSoBaYrTnh5oXvsvCycbj/Fga+4uK4mKpa4KtF
         L9GERtmt/09zpsMPdIxJ2reZYh43n74Nv1xdePcr89ebElRPRTYQcTmRt8LEKnT37XjG
         vJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717519928; x=1718124728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B1Jmxeyxl2JTcXXAAs8GoA7peZQ32QIewc1EvPktBMQ=;
        b=MyKOzwB2MSJURXNf8Ccg9eCDD9v9y6qR8fd2u0OoUyijaky4o/qcGi2yqvqvcw8g71
         4NpF64kciH1B+w3CA6PloC4ZIowTdPrM+BtHPkGzRyz/30qGNfNuxl1LC+2GD6dtPvER
         tAdPmZKM8nJbhIi4Y8a4m3EMU6xhj76cyoqVNXM35PQQaXon8ygJzM3qP31HDqeKVz1f
         ivaHJZ8yQ3yUO6tbuo0MciKbCqnjnyngzLBgxjftVuWFn6rupZGcloqGyffDuLJEd2M1
         u1vK6FCj2ysh3QldSQGSROmpxCkopksn10mTZygykF5Ne/EYcD/MvLz0bp1WVoQ8fRem
         m6TQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZ9ChDXnoeYea1OqzOYUzX6oadA9nyPyIOmg7TiOe3AAvyboMwZBJI998SZHCFXY/N414bvIwfYAQ069YQIPC6ncVnPTouUyoOADlWEkfJFbkvmiOKd+hTFsRQLVlo4qHC2k+djxOlDatnonwU5Th/4h8rIS66I6VO8RszTvBME1/iWYIy
X-Gm-Message-State: AOJu0Yxl5UNQ9zEQdIQzY+vBcMmvrN4vfsoIszHf7F5YSu1uRGEaNdkf
	ENxGJNrEYyAVD9LxSUSs5ue9JI20gma5wknVclgFOY5MrzEWYG82
X-Google-Smtp-Source: AGHT+IGew2QGLmhBJKgIkPQsUevYJs7yaWGXRd7LMJsL8rwmWlpRGcGuq4R/SIPPxpRgV0sMwBX8+A==
X-Received: by 2002:a05:600c:3105:b0:419:f241:633b with SMTP id 5b1f17b1804b1-421562cf43cmr1626575e9.8.1717519927916;
        Tue, 04 Jun 2024 09:52:07 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4212b85c61dsm162465555e9.28.2024.06.04.09.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 09:52:07 -0700 (PDT)
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
Subject: [PATCH v4 1/3] dt-bindings: hwmon: g762: Convert to yaml schema
Date: Tue,  4 Jun 2024 18:43:41 +0200
Message-ID: <20240604164348.542-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert g762 Documentation to yaml schema and port all the custom
properties and info.

Add the vendor prefix to name to follow naming standard.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
Changes v4:
- Fix typo
- Drop fixed clock
- Add Reviewed-by tag
Changes v3:
- Rename yaml to g762 from g76x

 .../devicetree/bindings/hwmon/g762.txt        | 47 ------------
 .../devicetree/bindings/hwmon/gmt,g762.yaml   | 72 +++++++++++++++++++
 2 files changed, 72 insertions(+), 47 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/g762.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/gmt,g762.yaml

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
diff --git a/Documentation/devicetree/bindings/hwmon/gmt,g762.yaml b/Documentation/devicetree/bindings/hwmon/gmt,g762.yaml
new file mode 100644
index 000000000000..762779da5ba2
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/gmt,g762.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/gmt,g762.yaml#
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
+    description: PWM polarity (positive or negative duty)
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


