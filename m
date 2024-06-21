Return-Path: <linux-kernel+bounces-225007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4EA912A81
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 094EFB2A29D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3186F152516;
	Fri, 21 Jun 2024 15:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsRhugAq"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B920E84A4C;
	Fri, 21 Jun 2024 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718984450; cv=none; b=rIELrpzL6P3Q3tD7+/ZomZesy76ToaiF2WknYtW9abdjDV+WqCfLC7rvsvRQ3dmaxippFGnR7xMg3COT9KdEEMp2E6X/F5nKKnsFiGL7WJJ6CSCltWc1IQYgkwnFXRlScZLL0AXvAvkQ3QWE4BvQBXwXDdw8k5heDRaEGnnV8aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718984450; c=relaxed/simple;
	bh=J9beTWQ6nBQMACRt3dW6ixHUj30KwKhEXz5zO1lRtlE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cX6El45p3i6Sb0UiYzenGHEBjrQ3/RXL0AePD5u3fk1zeesrXI5VWcENKSKyXzjnQ93Xym6HvaAF55jRTNcUIL6wuwV7MrKUjGA7QBk/pKA8uxpGJqNPZaar224zUckhomie7XvpRLnSM+x6oAcg0JMuSIAVtVDQlXsVlCbIB0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsRhugAq; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7042a8ad9f5so1916419b3a.0;
        Fri, 21 Jun 2024 08:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718984448; x=1719589248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9lNEeiRMZyfbNEcygdR2xAKFEd5icF+LSS0bm07Oqsk=;
        b=gsRhugAqxoG9lvlKyazDDzrsHNU04jy9nsqlKvhPyMIlqf3iIEiAOd2FOalYpHjDIf
         bgd6AgF5zr0654KPzrvoGUqI0FBvH1hZTAFwGAoP2GikEps7eCXd6qE48n/s37bcAAnp
         SOn30qeGBugBpOeQ3dZ735lUCxTkLPsSUM3xW8R2fRnxoslMbvsa9eLZ42ecVTH4OMkg
         0rV0IrUmWV4/TAklMhKGipNeJYk0ARcVsetJHVBsdyH06SFaqaI0RmUbiD3xFA+85+Hn
         5EAe8Ng/9z7YkDFzX8yiCEe78nVkkYz9tKTVUD524TY3duQFJcqCrvDH0vRVXYPUg6U7
         ww3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718984448; x=1719589248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9lNEeiRMZyfbNEcygdR2xAKFEd5icF+LSS0bm07Oqsk=;
        b=aHT7LFBirRjjTQR2AdG4tGZk8qZGFc0JpHe++ud1Qjk8FY7B8JrrqdM1yPTRcOJl03
         Je0WtbJxpFEbL8SS9MbiWcFd2oZhOrFHAR/vKxhNqm34W8DyPn7LTYS1GV2OjZ9fyAZr
         B+NC+GxiPkwhl5Lpx/jDMj8GmJsO/YmOz6xUXS/NWvd8fNwz2jXE8U4bSOfCvIrGhFC8
         tm15EFtR5WIo8Hn84lgkTLA4a10/DH76ThTNqxNrnqT9qbrfg0L5xNewt/WhErNjOVXE
         geV3qwndhwufoZ6huG0+LXAzZRvZt7ekiU4QjCHjH+swiXFMG9JNwv3s827j7xBB8fII
         sbxg==
X-Forwarded-Encrypted: i=1; AJvYcCX1I+9l3KVNah0qA7249cS0TlemQ9rvmt0p2VgIs6mfQlWYFm4Kmx4Xn/P9v7y5pK0/rxoG2nY4RbIWO+9r4H8pUSTLXVEPCuyxXxh6SgH0ygvdl+I37m8nFmxfJL5n3qZmVSmCRZsc+2l79qXqr15LxSkI+iDFUoMQNYbuZ8atT0il66Zi
X-Gm-Message-State: AOJu0Yxm7P8vZmPT+u/B6uow+4DazfIeVdLokTXUa+xeFGsg06iddKZW
	VbYLcKnNQQSOCnxou/BqfCIjz+KYhkfPKXw3FC5PQ0Nt0uDDtJ11
X-Google-Smtp-Source: AGHT+IGRTpgRoS9Ooc2BHJ4NPBqzyh8zsWzwUoEzcYv0F/1FXItq5OIJQG5dLJb24ilLB+6dDw0BTA==
X-Received: by 2002:a05:6a20:3252:b0:1b5:88f5:5823 with SMTP id adf61e73a8af0-1bce65cabe9mr186358637.27.1718984447745;
        Fri, 21 Jun 2024 08:40:47 -0700 (PDT)
Received: from fedora.one.one.one.one ([2405:201:6013:c0b2:ea4b:30e0:4e3a:ab56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716baf4acd1sm1271070a12.75.2024.06.21.08.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 08:40:47 -0700 (PDT)
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
Subject: [PATCH] ASoC: dt-bindings: realtek,rt5645: Convert to dtschema
Date: Fri, 21 Jun 2024 21:10:27 +0530
Message-ID: <20240621154034.489037-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the RT5650/RT5645 audio CODEC bindings to DT schema.

Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
---
 .../bindings/sound/realtek,rt5645.yaml        | 129 ++++++++++++++++++
 .../devicetree/bindings/sound/rt5645.txt      |  82 -----------
 2 files changed, 129 insertions(+), 82 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt5645.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/rt5645.txt

diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5645.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5645.yaml
new file mode 100644
index 000000000000..d2d97d2bca2e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/realtek,rt5645.yaml
@@ -0,0 +1,129 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/realtek,rt5645.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RT5650/RT5645 audio CODEC
+
+maintainers:
+  - Animesh Agarwal <animeshagarwal28@gmail.com>
+
+description: |
+  This device supports I2C only.
+
+  Pins on the device (for linking into audio routes) for RT5645/RT5650:
+    * DMIC L1
+    * DMIC R1
+    * DMIC L2
+    * DMIC R2
+    * IN1P
+    * IN1N
+    * IN2P
+    * IN2N
+    * Haptic Generator
+    * HPOL
+    * HPOR
+    * LOUTL
+    * LOUTR
+    * PDM1L
+    * PDM1R
+    * SPOL
+    * SPOR
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - realtek,rt5645
+      - realtek,rt5650
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description: The CODEC's interrupt output.
+
+  avdd-supply:
+    description: Power supply for AVDD, providing 1.8V.
+
+  cpvdd-supply:
+    description: Power supply for CPVDD, providing 3.5V.
+
+  hp-detect-gpios:
+    description: 
+      A GPIO spec for the external headphone detect pin. If jd-mode = 0, we
+      will get the JD status by getting the value of hp-detect-gpios.
+
+  cbj-sleeve-gpios:
+    description:
+      A GPIO spec to control the external combo jack circuit to tie the
+      sleeve/ring2 contacts to the ground or floating. It could avoid some
+      electric noise from the active speaker jacks.
+
+  realtek,in2-differential:
+    description:
+      Indicate MIC2 input are differential, rather than single-ended.
+    type: boolean
+
+  realtek,dmic1-data-pin:
+    description: Specify which pin to be used as DMIC1 data pin.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0 # dmic1 is not used
+      - 1 # using IN2P pin as dmic1 data pin
+      - 2 # using GPIO6 pin as dmic1 data pin
+      - 3 # using GPIO10 pin as dmic1 data pin
+      - 4 # using GPIO12 pin as dmic1 data pin
+
+  realtek,dmic2-data-pin:
+    description: Specify which pin to be used as DMIC2 data pin.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0 # dmic2 is not used
+      - 1 # using IN2N pin as dmic2 data pin
+      - 2 # using GPIO5 pin as dmic2 data pin
+      - 3 # using GPIO11 pin as dmic2 data pin
+
+  realtek,jd-mode:
+    description: The JD mode of rt5645/rt5650.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0 # rt5645/rt5650 JD function is not used
+      - 1 # Mode-0 (VDD=3.3V), two port jack detection
+      - 2 # Mode-1 (VDD=3.3V), one port jack detection
+      - 3 # Mode-2 (VDD=1.8V), one port jack detection
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - avdd-supply
+  - cpvdd-supply
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
+        codec@1a {
+            compatible = "realtek,rt5650";
+            reg = <0x1a>;
+            hp-detect-gpios = <&gpio 19 0>;
+            cbj-sleeve-gpios = <&gpio 20 0>;
+            interrupt-parent = <&gpio>;
+            interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+            avdd-supply = <&avdd_reg>;
+            cpvdd-supply = <&cpvdd_supply>;
+            realtek,jd-mode = <3>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/sound/rt5645.txt b/Documentation/devicetree/bindings/sound/rt5645.txt
deleted file mode 100644
index c1fa379f5f3e..000000000000
--- a/Documentation/devicetree/bindings/sound/rt5645.txt
+++ /dev/null
@@ -1,82 +0,0 @@
-RT5650/RT5645 audio CODEC
-
-This device supports I2C only.
-
-Required properties:
-
-- compatible : One of "realtek,rt5645" or "realtek,rt5650".
-
-- reg : The I2C address of the device.
-
-- interrupts : The CODEC's interrupt output.
-
-- avdd-supply: Power supply for AVDD, providing 1.8V.
-
-- cpvdd-supply: Power supply for CPVDD, providing 3.5V.
-
-Optional properties:
-
-- hp-detect-gpios:
-  a GPIO spec for the external headphone detect pin. If jd-mode = 0,
-  we will get the JD status by getting the value of hp-detect-gpios.
-
-- cbj-sleeve-gpios:
-  a GPIO spec to control the external combo jack circuit to tie the sleeve/ring2
-  contacts to the ground or floating. It could avoid some electric noise from the
-  active speaker jacks.
-
-- realtek,in2-differential
-  Boolean. Indicate MIC2 input are differential, rather than single-ended.
-
-- realtek,dmic1-data-pin
-  0: dmic1 is not used
-  1: using IN2P pin as dmic1 data pin
-  2: using GPIO6 pin as dmic1 data pin
-  3: using GPIO10 pin as dmic1 data pin
-  4: using GPIO12 pin as dmic1 data pin
-
-- realtek,dmic2-data-pin
-  0: dmic2 is not used
-  1: using IN2N pin as dmic2 data pin
-  2: using GPIO5 pin as dmic2 data pin
-  3: using GPIO11 pin as dmic2 data pin
-
--- realtek,jd-mode : The JD mode of rt5645/rt5650
-   0 : rt5645/rt5650 JD function is not used
-   1 : Mode-0 (VDD=3.3V), two port jack detection
-   2 : Mode-1 (VDD=3.3V), one port jack detection
-   3 : Mode-2 (VDD=1.8V), one port jack detection
-
-Pins on the device (for linking into audio routes) for RT5645/RT5650:
-
-  * DMIC L1
-  * DMIC R1
-  * DMIC L2
-  * DMIC R2
-  * IN1P
-  * IN1N
-  * IN2P
-  * IN2N
-  * Haptic Generator
-  * HPOL
-  * HPOR
-  * LOUTL
-  * LOUTR
-  * PDM1L
-  * PDM1R
-  * SPOL
-  * SPOR
-
-Example:
-
-codec: rt5650@1a {
-	compatible = "realtek,rt5650";
-	reg = <0x1a>;
-	hp-detect-gpios = <&gpio 19 0>;
-	cbj-sleeve-gpios = <&gpio 20 0>;
-	interrupt-parent = <&gpio>;
-	interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
-	realtek,dmic-en = "true";
-	realtek,en-jd-func = "true";
-	realtek,jd-mode = <3>;
-};
-- 
2.45.2


