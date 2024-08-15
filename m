Return-Path: <linux-kernel+bounces-287796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CDF952CAF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A8B3281438
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD5C1B5828;
	Thu, 15 Aug 2024 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNYCSWjV"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F3E370;
	Thu, 15 Aug 2024 10:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723717595; cv=none; b=uEdoe5/tj0QXqZC/As35F1bKqGb/wU9qCWzw5kDfymx/CUD0pTrCwduYWJkWrVCD9L/GwH0ernaIa6D5NXCgmktMaS8Uejy9AXmgOW4WMcxPwY2tv6irLFPKbbuQFXWyqTEyiXsCbS36FBvCl/gAXDSYSsz1FVDmJyCMc6LDRE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723717595; c=relaxed/simple;
	bh=lAe2vVpSugfIIjdbD4FWx/7yrntYpU7quHyeR3LdBjg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LkacCT1/lg5Wx9lEi2Y8tSpPsrC4OLgF/4PYT1iDgB8+aFG2hiIess5WnB+Ze5kgo0pAWJCPJfNyzKx4Qtzx0sUwhwrccBXb+sAXEfDR/KyRPwjFWak4j8NilPiu5AjiHOCvqN3LMFzujAgpTTTv/xJ2Kikv/qy8Np1I6ew9pR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNYCSWjV; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a108354819so1182864a12.0;
        Thu, 15 Aug 2024 03:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723717592; x=1724322392; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vTO73W8ziVgnh6T8iVSlljTIqvEyvsW3MqydaZeuxJo=;
        b=HNYCSWjVHsWrCR4q83jTFIAX2S12BRsGjbzqd+6h9S2077822F7tEMetowsiPimvZx
         r42rk1SieGNhGsgEENcZS3Y9f94tI+NiFvJqWFdePDSutPDs6LM0Q2svaO/evW50fJEX
         3+qgmlAOrJL67QFn4w+7GwKUSoSo8EE4FRuXCtYRA1An++vEzQxY9XCTXd+1T8q65NJX
         XXRuSKydoylWzujYRYgdaxLF7wk3KzARC0e4aziWeebUXcXQA6M68PKiT2f1CHBrKjRj
         5vPbRnrEy8Fgmcuw7b23coE7uhATIXbzQXxOAyISjStWdEAYGEoqNTkB40vU4bt63nHK
         VZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723717592; x=1724322392;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vTO73W8ziVgnh6T8iVSlljTIqvEyvsW3MqydaZeuxJo=;
        b=DWwARAG2bcltT7fZd1seNsC/gsQ8NP5f+AyYDlaxhPiX0quiKorYmpdLV3rOsL62dS
         sQXeMqIsQvqwN39yCLjGiy1zfLYCysPxJyKeeNNGMQrEXIWwofO/yCSkE+iaT0sXhPv+
         EVwSrJkj9PHc0MomPCZSkKxF9ZTq9sGMEhWFP/y6qEujYhomO//KZkGueSjM1BG3Wcuf
         aZY1KVOSIWHVdS9hNuogh72qRgBJyvnhFFljcbHBNVZKjzbmK86yadKr/8b/Yo2tg7oP
         14RxINNMh7zXCLht68ThRf/r8dNsCCbM+wexCPQmPzmshgPI02S8BfNIs27aIeb5Vg8V
         Ya/g==
X-Forwarded-Encrypted: i=1; AJvYcCVbwQOxnnhjRc+Nx0WzkEMe1Tw9bPC3dGSMHNOENqQSnAQ0KhYl+ZFHufLmvcS5SrECYgQFESgIWF4wQFAbtST66WMb2HwS7sn5RS36
X-Gm-Message-State: AOJu0YzTZeAC6aSoO7HrXG7FTZOZJO9KCuJNH6cQoksfr6KXPRp8CUEf
	5pN4wyKEqAJmqerpavDUDOFKeV713T2Pt0SE0tKIWhWudcSkJQXc229BzQ==
X-Google-Smtp-Source: AGHT+IEfx6ZFLs0hghbnMMaMu58BkV9hLZIBaMZKkf+skhQnZZFjQrZRBuVXGFWxLlC+91OhcTOOeQ==
X-Received: by 2002:a05:6402:3546:b0:5a2:d411:89fa with SMTP id 4fb4d7f45d1cf-5bea1cb2054mr3548815a12.36.1723717591919;
        Thu, 15 Aug 2024 03:26:31 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbe7fa52sm696875a12.73.2024.08.15.03.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 03:26:31 -0700 (PDT)
Date: Thu, 15 Aug 2024 12:26:29 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mfd: sprd,sc2731: convert to YAML
Message-ID: <Zr3X1RoQs7ElTnlJ@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert the Spreadtrum SC27xx PMIC bindings to DT schema. Adjust the
filename to match the compatible of the only in-tree user, SC2731.
Change #interrupt-cells value to 1, as according to [1] that is the
correct value.

[1] https://lore.kernel.org/lkml/b6a32917d1e231277d240a4084bebb6ad91247e3.1550060544.git.baolin.wang@linaro.org/

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
Depends on:
  - eFuse YAML conversion: https://lore.kernel.org/lkml/9fba73ce66f1f3b7b2a8f46e7c21f60cff5a85f0.1721199034.git.stano.jakubek@gmail.com/
  - RTC YAML conversion: https://lore.kernel.org/lkml/ZrBzmQI0IAL7LI3e@standask-GA-A55M-S2HP/

 .../devicetree/bindings/mfd/sprd,sc2731.yaml  | 124 ++++++++++++++++++
 .../bindings/mfd/sprd,sc27xx-pmic.txt         |  40 ------
 2 files changed, 124 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/sprd,sc27xx-pmic.txt

diff --git a/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml b/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml
new file mode 100644
index 000000000000..59df02e1e53b
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml
@@ -0,0 +1,124 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/sprd,sc2731.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Spreadtrum SC27xx PMIC
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+description: |
+  Spreadtrum PMICs belonging to the SC27xx series integrate all mobile handset
+  power management, audio codec, battery management and user interface support
+  functions in a single chip. They have 6 major functional blocks:
+    - DCDCs to support CPU, memory
+    - LDOs to support both internal and external requirements
+    - Battery management system, such as charger, fuel gauge
+    - Audio codec
+    - User interface functions, such as indicator, flash LED and so on
+    - IC level interface, such as power on/off control, RTC, typec and so on
+
+properties:
+  $nodename:
+    pattern: '^pmic@[0-9a-f]+$'
+
+  compatible:
+    enum:
+      - sprd,sc2720
+      - sprd,sc2721
+      - sprd,sc2723
+      - sprd,sc2730
+      - sprd,sc2731
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+  spi-max-frequency: true
+
+  '#address-cells':
+    const: 1
+
+  '#interrupt-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  regulators:
+    type: object
+    $ref: /schemas/regulator/sprd,sc2731-regulator.yaml#
+
+patternProperties:
+  "^adc@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/iio/adc/sprd,sc2720-adc.yaml#
+
+  "^charger@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/power/supply/sc2731-charger.yaml#
+
+  "^efuse@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/nvmem/sprd,sc2731-efuse.yaml#
+
+  "^fuel-gauge@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/power/supply/sc27xx-fg.yaml#
+
+  "^gpio@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/gpio/sprd,gpio-eic.yaml#
+
+  "^led-controller@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/leds/sprd,sc2731-bltc.yaml#
+
+  "^rtc@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/rtc/sprd,sc2731-rtc.yaml#
+
+  "^vibrator@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/input/sprd,sc27xx-vibrator.yaml#
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - spi-max-frequency
+  - '#address-cells'
+  - '#interrupt-cells'
+  - '#size-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      pmic@0 {
+        compatible = "sprd,sc2731";
+        reg = <0>;
+        interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-controller;
+        spi-max-frequency = <26000000>;
+        #address-cells = <1>;
+        #interrupt-cells = <1>;
+        #size-cells = <0>;
+      };
+    };
+...
diff --git a/Documentation/devicetree/bindings/mfd/sprd,sc27xx-pmic.txt b/Documentation/devicetree/bindings/mfd/sprd,sc27xx-pmic.txt
deleted file mode 100644
index 21b9a897fca5..000000000000
--- a/Documentation/devicetree/bindings/mfd/sprd,sc27xx-pmic.txt
+++ /dev/null
@@ -1,40 +0,0 @@
-Spreadtrum SC27xx Power Management Integrated Circuit (PMIC)
-
-The Spreadtrum SC27xx series PMICs contain SC2720, SC2721, SC2723, SC2730
-and SC2731. The Spreadtrum PMIC belonging to SC27xx series integrates all
-mobile handset power management, audio codec, battery management and user
-interface support function in a single chip. It has 6 major functional
-blocks:
-- DCDCs to support CPU, memory.
-- LDOs to support both internal and external requirement.
-- Battery management system, such as charger, fuel gauge.
-- Audio codec.
-- User interface function, such as indicator, flash LED and so on.
-- IC level interface, such as power on/off control, RTC and typec and so on.
-
-Required properties:
-- compatible: Should be one of the following:
-	"sprd,sc2720"
-	"sprd,sc2721"
-	"sprd,sc2723"
-	"sprd,sc2730"
-	"sprd,sc2731"
-- reg: The address of the device chip select, should be 0.
-- spi-max-frequency: Typically set to 26000000.
-- interrupts: The interrupt line the device is connected to.
-- interrupt-controller: Marks the device node as an interrupt controller.
-- #interrupt-cells: The number of cells to describe an PMIC IRQ, must be 2.
-- #address-cells: Child device offset number of cells, must be 1.
-- #size-cells: Child device size number of cells, must be 0.
-
-Example:
-pmic@0 {
-	compatible = "sprd,sc2731";
-	reg = <0>;
-	spi-max-frequency = <26000000>;
-	interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
-	interrupt-controller;
-	#interrupt-cells = <2>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-};
-- 
2.34.1


