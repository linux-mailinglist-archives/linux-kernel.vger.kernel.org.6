Return-Path: <linux-kernel+bounces-196099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F9F8D5750
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 02:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180C82870CE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 00:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F245223;
	Fri, 31 May 2024 00:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCtfISmQ"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A607B4C79;
	Fri, 31 May 2024 00:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717116423; cv=none; b=h3sHjiLhkYTeoJg97E1jFI1JEoBAJw8h1+x8Fo7rDM7viPR5HmBqVTs6v4ZzDq4fXIPKLygDpk9BsEBhtrWYJkxZqh6+pdKQHm+gn9/mPssQUqgh94Jl+hZEtpHM80haKIkA6Q6exESvinz2IN9NXS5oCJ1PedRDOWYCkMvKuks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717116423; c=relaxed/simple;
	bh=C9HKHhNcPiAhE04fDvPduEhceu4osC2csh/3rWYlKL4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=cnx9yqa5hN796qd+zT4QyiWzyBoMUcxOgcn0rYjgDpJ0Hw1PFFOsCW5Jr4xYVtER7GhsVznvi/33BMOt9Fh5u9JfWZD/s+ETM/twfVB1wAZMwlIJNEuQ56m+C8tVogRBntmQMre7jiu4/GHxcv7jSk0mgzXPuGvZDF7h1pvKHto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCtfISmQ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-354c5b7fafaso1495698f8f.3;
        Thu, 30 May 2024 17:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717116420; x=1717721220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DQwdJntsJuVKOOqXj3GohGH9mfSc2/q6Dn87IT5t7hw=;
        b=TCtfISmQlzgcg6AsffkAuseIEpXzYTD7pzzsmfmLaVyJeInnopIN2ouaBtdUav3Ji+
         olxCXUcI72nh8BTJFDgzMOiNEyUjcNRwVuGw6WwvISru+S1Jr1MhzjD0CcNLDVRADQ3r
         Sd27NHD9Evb+kf5SLPbef9zyhi3Jwa523dExhGcF1/Zw3LyTpnmrS4KMfrtCAFBu5N0c
         I8szRv4kuBRBHH6y5Ttn8VED5PwAzWDpv07lv2UM4KHWH2B6V6vTdF+e95xJbVvcAAij
         +UDRkmWkOlO/950tmUjY8XemHGug5HAn8uLBivcv2pxH/tUOCYo76NXc1e/XNUuKF+jq
         KHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717116420; x=1717721220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DQwdJntsJuVKOOqXj3GohGH9mfSc2/q6Dn87IT5t7hw=;
        b=VTWqTUKn1ImN6XUYX6XzWK9Kt7HL/PecqyTcb971unsGLeNN3HhUvAS2DtMD7xcqZD
         00pqhSNWnAihx7nStG1Th1miVKgl+Qx0UU/pYtSpe4vb07ZIsrLBVdXm9nVbhw+xrRQs
         H19WXHuLZfAQeEl0+qVELzC7d3WFkFGBo5ecoPVzbIz8hFo8nBUhSvd+HW8aA9nkg68c
         5bLjSO/Sv6v4EgildPseUMjeLc+kw9mHVmMwL0hD8v8/O6IYwVd2lBMHd25Gg1cTBcRq
         isLm2QiX6PTA5s8BuUoZ9HZSXRmqfuLaBDUyV1ka+CRpq3N0uKCx/Co1nzf/XwgAd2ml
         bEmg==
X-Forwarded-Encrypted: i=1; AJvYcCWwTlCV+NmK9ZM/FrVIdFG5CQNsbtKZxIhSTVgpVSUvvtCBJKLMoz4FjxkbnqYkjhmTYMueLdjyHJpgclISm6zyyjJg3WM7drCRdc+ZOLXHnPo/SPNRYwswr+6WrNDk/H5xfR2DiiZsjeW5QhHJJ77aR1C68cs3vUfUr3+RmCOl91Xy2w3/
X-Gm-Message-State: AOJu0YzOx1DK985cfFqUC1x9TKQJkjQnWY+ZJ+qFDLWGfqfJKbFkaWNk
	NwBCQeTGNEE5xfVNcMWTtoksl7L30VJC6VjaDFiTXtP3h3xZxBuf
X-Google-Smtp-Source: AGHT+IH7vSioT0lTo7FjcreH8oFTqjegQM4dz85qybyOJIoAeFjFHV9JGSFlMvZ5z1ocHw6U6zWI+Q==
X-Received: by 2002:a5d:4acd:0:b0:34c:719e:6786 with SMTP id ffacd0b85a97d-35e0f25e733mr141753f8f.4.1717116419681;
        Thu, 30 May 2024 17:46:59 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-35dd04c0e84sm608486f8f.13.2024.05.30.17.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 17:46:59 -0700 (PDT)
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
Subject: [PATCH v3 1/3] dt-bindings: hwmon: g762: Convert to yaml schema
Date: Thu, 30 May 2024 23:16:50 +0200
Message-ID: <20240530211654.7946-1-ansuelsmth@gmail.com>
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
---
Changes v3:
- Rename yaml to g762 from g76x

 .../devicetree/bindings/hwmon/g762.txt        | 47 -----------
 .../devicetree/bindings/hwmon/gmt,g762.yaml   | 83 +++++++++++++++++++
 2 files changed, 83 insertions(+), 47 deletions(-)
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
index 000000000000..8c179cbbc65c
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/gmt,g762.yaml
@@ -0,0 +1,83 @@
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


