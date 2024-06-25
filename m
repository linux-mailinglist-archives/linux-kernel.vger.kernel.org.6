Return-Path: <linux-kernel+bounces-228611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5875491623D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CED21C209A7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F381494DB;
	Tue, 25 Jun 2024 09:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bez1Ohws"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307B3145B3F;
	Tue, 25 Jun 2024 09:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719307371; cv=none; b=BB4Nk4K4VVPEqTezxYkRigtqKlgIvTRHECgSUj8FkUU2SWXjQHegyHfUHzo+rEG0NGF+x2eQtCv3B7RQyPp3b5lZt/nzZ2JiLFeUltVp7DZmytRn7u/IFXzlLg4G0gp4Pm5Jgn/MdzyQasDVwqnO4AX99A+FgpYOmPNLKafiQ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719307371; c=relaxed/simple;
	bh=mcWUtvufMUDlR02FhzKpyqn2PcRxAZP2VwVsA8wNe+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IOlxrTCTS23ZYEt7h1ToUjWD/enW5VLjv+hd2IZktvL/IprPkuVj77Cti/ONGsSrc1zKQTq+1XUIblWbHmCzLmmAYlzmW6RAwOXOjQnxGwYxdR/UViDsGpHgCEyrYf5ub08AwQSW8cGc8oRoNZTzOhtzFuL9sENQtpuFVn1VNhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bez1Ohws; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2598001aae7so2608408fac.2;
        Tue, 25 Jun 2024 02:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719307369; x=1719912169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0R8M7G5C/6TgikPyq56VxTw6fauhX8XejnjEjTrpj8=;
        b=Bez1OhwsIWN4QCUd35VItscU89sELY3idttxSLcqWopmbo2FX6SrDlMn/D0io3bAwX
         zHxVckCakl0T0BR2VF7RBZjlMvrOUEgXIOs5/96cBM/MZLuY/xXRsc6Oh6fqURuz5NSu
         vKn5nHpCmnowNCqcgNoYbR0ii696U2C/Z2QKoShjt2k4cq/dHhiW1rABTKnvVA35oRxm
         KoY6AXpAxitjK8x2yXDdbwMxxVm6O5BZBLujMn1js9gSavsaAguck6xohIkis1nWUl4e
         mq/QyDM7H01UD3BI1OXbPoP+ppfQPTimr4Mhs7m6Gr9ii8/3reNwZ7Zwx6sQaI2S+VNn
         0SYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719307369; x=1719912169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z0R8M7G5C/6TgikPyq56VxTw6fauhX8XejnjEjTrpj8=;
        b=ljLd9atiP9P2TKq2773sj4w5JayQs8fwBOOpQxEBOLboWqH9MvjzymxER0LOuj6mnf
         RLKLv8dV3zXyiz2Q4Z8pO/jKloD3V8kWYr3HxcIgMTfyBuUJAVF2/HaE0RWM39p94q2J
         5wGHs7/9Efg9u2pXb3QaeEe+Dcy26HVERG+CayouqjD4I1VWnaOBAUoKkUsBTbo9yg3i
         yl8OsnChBBi8CBJ36n4iJzqEq2ESQW+jsQYEj4EM7ZWGkofzMsHaY/K0hPXKrF+g8Av6
         WPO8QucblLTfmakoho/2AT2gtSPhdgQX3Wu+Yk7fEeCCBxjw3i6mYFk8zcCXNIIf9XZe
         Vz3A==
X-Forwarded-Encrypted: i=1; AJvYcCU+7EkEUL/psvPxK0siZ9ZAPNtihVXctu8JzyPCMNJrXbeJCcy7PgUZEWEQz1WjuynqtzT8LBCn9DvGKluBjE4KCmqCnrGaUAcOqdLHdSTMgZ/LrSsWwKY7SqZP1ClAgYVnm3Yox9Cbyjmaa5Xf89GzbbNNxO0SHKPDb8lyfOgZ3/w8GqBR
X-Gm-Message-State: AOJu0YwWF81i7afsROdEePz/kNEGq5XqrGpNLq1dWbueOGMjxFMUulTa
	EXrAzIfdcTRjPnA1Dcpy1doeNhDE3IFQrPi5eGYu0PtYnD89cLclfIpm+FEg0mMV6A==
X-Google-Smtp-Source: AGHT+IEAjngNN8PW65r1MpgUKqsUwf3fE+qtEwDMKySzgU6HLV1rvwxRCek8VPF0cPfHMj4xuE/4Xw==
X-Received: by 2002:a05:6870:d891:b0:254:7348:9071 with SMTP id 586e51a60fabf-25d0170cec9mr8774556fac.26.1719307369055;
        Tue, 25 Jun 2024 02:22:49 -0700 (PDT)
Received: from fedora.one.one.one.one ([2405:201:6013:c0b2:ea4b:30e0:4e3a:ab56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7066c2ebd85sm5628034b3a.93.2024.06.25.02.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 02:22:48 -0700 (PDT)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: animeshagarwal28@gmail.com,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: realtek,rt5677: Convert to dtschema
Date: Tue, 25 Jun 2024 14:52:09 +0530
Message-ID: <20240625092214.88005-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the RT5677 audio CODEC bindings to DT schema.

Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
---
 .../bindings/sound/realtek,rt5677.yaml        | 117 ++++++++++++++++++
 .../devicetree/bindings/sound/rt5677.txt      |  78 ------------
 2 files changed, 117 insertions(+), 78 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt5677.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/rt5677.txt

diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5677.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5677.yaml
new file mode 100644
index 000000000000..598495dbe7fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/realtek,rt5677.yaml
@@ -0,0 +1,117 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/realtek,rt5677.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RT5677 audio CODEC
+
+maintainers:
+  - Animesh Agarwal <animeshagarwal28@gmail.com>
+
+description: |
+  This device supports I2C only.
+
+  Pins on the device (for linking into audio routes):
+    * IN1P
+    * IN1N
+    * IN2P
+    * IN2N
+    * MICBIAS1
+    * DMIC1
+    * DMIC2
+    * DMIC3
+    * DMIC4
+    * LOUT1
+    * LOUT2
+    * LOUT3
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: realtek,rt5677
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+
+  realtek,pow-ldo2-gpio:
+    maxItems: 1
+    description: CODEC's POW_LDO2 pin.
+
+  realtek,reset-gpio:
+    maxItems: 1
+    description: CODEC's RESET pin. Active low.
+
+  realtek,gpio-config:
+    description: |
+      Array of six 8bit elements that configures GPIO.
+      0 - floating (reset value)
+      1 - pull down
+      2 - pull up
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 6
+    maxItems: 6
+    items:
+      maximum: 2
+
+patternProperties:
+  "^realtek,in[1-2]-differential$":
+    type: boolean
+    description: Indicate MIC1/2 input are differential, rather than
+      single-ended.
+
+  "^realtek,lout[1-3]-differential$":
+    type: boolean
+    description: Indicate LOUT1/2/3 outputs are differential, rather than
+      single-ended.
+
+  "^realtek,jd[1-3]-gpio$":
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0 # OFF
+      - 1 # GPIO1 for jd1 and GPIO4 for jd2.
+      - 2 # GPIO2 for jd1 and GPIO5 for jd2.
+      - 3 # GPIO3 for jd1 and GPIO6 for jd2.
+    description: Configures GPIO Mic Jack detection 1, 2 and 3.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - gpio-controller
+  - '#gpio-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        codec@2c {
+            compatible = "realtek,rt5677";
+            reg = <0x2c>;
+            interrupt-parent = <&gpio>;
+            interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
+            gpio-controller;
+            #gpio-cells = <2>;
+            realtek,pow-ldo2-gpio = <&gpio 3 GPIO_ACTIVE_HIGH>;
+            realtek,reset-gpio = <&gpio 3 GPIO_ACTIVE_LOW>;
+            realtek,in1-differential;
+            realtek,gpio-config = <0 0 0 0 0 2>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/sound/rt5677.txt b/Documentation/devicetree/bindings/sound/rt5677.txt
deleted file mode 100644
index da2430099181..000000000000
--- a/Documentation/devicetree/bindings/sound/rt5677.txt
+++ /dev/null
@@ -1,78 +0,0 @@
-RT5677 audio CODEC
-
-This device supports I2C only.
-
-Required properties:
-
-- compatible : "realtek,rt5677".
-
-- reg : The I2C address of the device.
-
-- interrupts : The CODEC's interrupt output.
-
-- gpio-controller : Indicates this device is a GPIO controller.
-
-- #gpio-cells : Should be two. The first cell is the pin number and the
-  second cell is used to specify optional parameters (currently unused).
-
-Optional properties:
-
-- realtek,pow-ldo2-gpio : The GPIO that controls the CODEC's POW_LDO2 pin.
-- realtek,reset-gpio : The GPIO that controls the CODEC's RESET pin. Active low.
-
-- realtek,in1-differential
-- realtek,in2-differential
-- realtek,lout1-differential
-- realtek,lout2-differential
-- realtek,lout3-differential
-  Boolean. Indicate MIC1/2 input and LOUT1/2/3 outputs are differential,
-  rather than single-ended.
-
-- realtek,gpio-config
-  Array of six 8bit elements that configures GPIO.
-    0 - floating (reset value)
-    1 - pull down
-    2 - pull up
-
-- realtek,jd1-gpio
-  Configures GPIO Mic Jack detection 1.
-  Select 0 ~ 3 as OFF, GPIO1, GPIO2 and GPIO3 respectively.
-
-- realtek,jd2-gpio
-- realtek,jd3-gpio
-  Configures GPIO Mic Jack detection 2 and 3.
-  Select 0 ~ 3 as OFF, GPIO4, GPIO5 and GPIO6 respectively.
-
-Pins on the device (for linking into audio routes):
-
-  * IN1P
-  * IN1N
-  * IN2P
-  * IN2N
-  * MICBIAS1
-  * DMIC1
-  * DMIC2
-  * DMIC3
-  * DMIC4
-  * LOUT1
-  * LOUT2
-  * LOUT3
-
-Example:
-
-rt5677 {
-	compatible = "realtek,rt5677";
-	reg = <0x2c>;
-	interrupt-parent = <&gpio>;
-	interrupts = <TEGRA_GPIO(W, 3) IRQ_TYPE_LEVEL_HIGH>;
-
-	gpio-controller;
-	#gpio-cells = <2>;
-
-	realtek,pow-ldo2-gpio =
-		<&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
-	realtek,reset-gpio = <&gpio TEGRA_GPIO(BB, 3) GPIO_ACTIVE_LOW>;
-	realtek,in1-differential = "true";
-	realtek,gpio-config = /bits/ 8  <0 0 0 0 0 2>;   /* pull up GPIO6 */
-	realtek,jd2-gpio = <3>;  /* Enables Jack detection for GPIO6 */
-};
-- 
2.45.2


