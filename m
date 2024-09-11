Return-Path: <linux-kernel+bounces-325269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F8B975735
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C7261C22B71
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB151AB6C7;
	Wed, 11 Sep 2024 15:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YPURXsx4"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43EB19F127
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726068847; cv=none; b=L57sjyJqkdR8a4TOZ157MBJclSfRMg9vuSfug6BzaUMsLiex8rmVImtQlD54J0gD7xwQTPJFu8pwQ/884+lRF1pwMnpS22jryvytlTHfkSUT7pL444B4z7Pl9HM8tuZuX/hEPCZ6AARqc39ND+1cLmMBoPl0puqLHyrf84TL6VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726068847; c=relaxed/simple;
	bh=wa8vIJqABRqeYvov1oXOL1h0K0Mf6fdI3W7xfzVIewU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EPTzQiWCoq1wVWHvI8seclZxGNigF6/a5ffBerLWI4hsJYxPGk3yxT2W6w9hVl0VLdCywSQftiqW1iKMGDna6HRwLcW+W50/cTtx0pRakbieE1sr/u4fMFJqv/rNdx+mw0OUM1pn0Xvcg1fC18Tba74PHh8xBzV8iqufg9m8+dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YPURXsx4; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-374ba78f192so4194500f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726068844; x=1726673644; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uHcFmu5XbrOYTeHNU+qTmvTnV5L1RX1cOMxqeSCBcSw=;
        b=YPURXsx401nau0UPDSQTxA6pGvnNpT4gTbOQS/C+1Yw/4fJLlvR6qwZZkvRAyLYhjs
         hP/yM798raf/A3rB2ZOmCjFK9BgqTyCxhfdpggggyA89WLtJGeeQ4s9if+CRj6VaD/sZ
         8w7OJPbXEb/uvB8g8u/WrvL9xmmY4VJiU/VX99NEq1wt/kJg1oS14xU3hCTaJW2p5/1W
         rdDjS+VT1CDOJE1GVdxLzHYwk70409ajeD0ppDY2qbAMMJy6Bw1H9sS2cFkUAJcUkgxA
         kFLe7g2qgeFpMLxwgX6Vvt+Tn+NYOBU+akYE7vt7gAS5QjmjqyHNySMEAGIWco6f2kQ6
         R1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726068844; x=1726673644;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uHcFmu5XbrOYTeHNU+qTmvTnV5L1RX1cOMxqeSCBcSw=;
        b=qlCWaflREtxQmNGZjFuozINp2Mn2GaeU02PJqGNiIRZAwKhApsZzg1YCRRc+5/Yf1G
         L/Z9x2MCfoCCuMw9NVqRDkAmAqBMeSNRok/MmZE9AYXBOAhcf45Pz/dumflV3+XYAkmi
         /abDSMiMpw+WZboc2WkLKKMw//rPbyzvCh2atDqt30IzAzrp+AoXGRgv4Y8M/V6gmiBd
         LQfrsWGoB17W9s/DOKvn8OQjfE1a/d7RxLNbvDyw2zm5kH2zmy30+og9MrLtOs51NjAR
         ziAU5u7J9l6ciSabSHNTPjBDXn2STPDohFW+rd0ZSisRqRY+XzXP1l9+mxzWWQWX4XZA
         XO/g==
X-Forwarded-Encrypted: i=1; AJvYcCXBbZDs+j/UlPEdDN2wC75kURjChTFTVHtSww04CWhqSAL55IVliBNNCJtXtUSjMNiaTzd9mXFe5WvAeQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfeli3NkOEQbf0gMS5lD6DGkJkHOWZoQ1swt34Ji00M6vNrGRA
	cpVdZJpEAqDWru2T2/xYVp5mb8FZtH5rsxAsLNsBmwWTE+oOLJh7EDJML+XnkgY=
X-Google-Smtp-Source: AGHT+IFWFyQkBhATnw+IJVi8otW3rrwr9Qz3fq8KG3RdNbP1RXsP2ig7w61/5F0VZz7KI2H1NqfR2g==
X-Received: by 2002:a5d:460c:0:b0:374:c35e:de72 with SMTP id ffacd0b85a97d-378895c53e2mr11196727f8f.2.1726068843744;
        Wed, 11 Sep 2024 08:34:03 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789564a52csm11917360f8f.11.2024.09.11.08.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 08:34:03 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 11 Sep 2024 17:34:01 +0200
Subject: [PATCH] ASoC: dt-bindings: realtek,rt5640: Convert to dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-covert-realtek-rt5640-v1-1-6b3745e34540@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGi44WYC/x2NywrCMBBFf6Vk7UAS26D+inSRJmMcbB5MYhFK/
 93o6nK4B84uKjJhFbdhF4wbVcqpgzoNwj1tCgjkOwst9SivSkHLhRzYuObwW45nDe9SG6ONsFD
 ylEKFB32wgssbcoN+rQ1fwG0yo4TFGy/RWDn5i+idwvjXe+Y+H8cXGXwDbpMAAAA=
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=7375;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=wa8vIJqABRqeYvov1oXOL1h0K0Mf6fdI3W7xfzVIewU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm4bhqZ6tBAue+5W+zN4ajyn7xX6dg4E6C9Wy/wFS1
 1Lps1u6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuG4agAKCRB33NvayMhJ0a1FD/
 9q2k+xWfrTu9IMmwNaQ6KrHn8r1c+e7LboQGmGEKIk21JmyUN3TL3TGCGRHgLpT3K15cDo9NVFPZBI
 Oet5u5eXXClmV094ENoqQtpSSngZOjCOWu2wM5VYfNauC4+wCTZRtRk/NrCBmlCUAzTJrZoQX/hfpA
 U0Gy1UGIwgyCJnch3ZVz2uNPuESSW/TcUoRJn2U2HqQhaPycJuuv9UikbfJeMQAZ/p1eDLsgD+7MyP
 /NeQpmTxCjghyNTXiUvLskzIiXow11To4wKcSV6/4I6GrTbAxRc6D7l47sEhw8L9FpwK5GjM0E71Yn
 3RuA36Dcog5FEev0fGXZXqV8vqnrQhB9FJeWcU3+YgEdyJsHS9RbyclsvyR3TwutIMivefirkEknvb
 oXOEzky7t9iQYXPzTs3a+iFo1Rh7x7zjO4vymVaLsIR4XIzAhT7wNZBDzcOaynIeyRtfJB0jt6UuoU
 tfszkG3byiTS3llycnh/6QbKGA+XcNiTjySKF98osU6qHrjue0LXWnH0qUQb9YItPD4lQvoO5KWbgG
 9Z8BzI7iQh1FZK0jv0ZpEnKCt00mTew2M9sWhNxaNQxDloUCFLOtI65R9Q6goFqDVVSMZPXograFUb
 jKJ/mR2Ptkga2V00ugW6KaIRAaI6MYTeN6lGtxP80SPYcpPcWhsyL5akU0iw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Convert the RT5640/RT5639 audio CODEC bindings to DT schema.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/sound/realtek,rt5640.yaml  | 146 +++++++++++++++++++++
 Documentation/devicetree/bindings/sound/rt5640.txt |  97 --------------
 2 files changed, 146 insertions(+), 97 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5640.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5640.yaml
new file mode 100644
index 000000000000..3f4f59287c1c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/realtek,rt5640.yaml
@@ -0,0 +1,146 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/realtek,rt5640.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RT5640/RT5639 audio CODEC
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+description: |
+  This device supports I2C only.
+
+  Pins on the device (for linking into audio routes) for RT5639/RT5640:
+    * DMIC1
+    * DMIC2
+    * MICBIAS1
+    * IN1P
+    * IN1N
+    * IN2P
+    * IN2N
+    * IN3P
+    * IN3N
+    * HPOL
+    * HPOR
+    * LOUTL
+    * LOUTR
+    * SPOLP
+    * SPOLN
+    * SPORP
+    * SPORN
+
+  Additional pins on the device for RT5640:
+    * MONOP
+    * MONON
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - realtek,rt5640
+      - realtek,rt5639
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description: The CODEC's interrupt output.
+
+  realtek,in1-differential:
+    description:
+      Indicate MIC1 input is differential, rather than single-ended.
+    type: boolean
+
+  realtek,in2-differential:
+    description:
+      Indicate MIC2 input is differential, rather than single-ended.
+    type: boolean
+
+  realtek,in3-differential:
+    description:
+      Indicate MIC3 input is differential, rather than single-ended.
+    type: boolean
+
+  realtek,lout-differential:
+    description:
+      Indicate LOUT output is differential, rather than single-ended.
+    type: boolean
+
+  realtek,dmic1-data-pin:
+    description: Specify which pin to be used as DMIC1 data pin.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0 # dmic1 is not used
+      - 1 # using IN2P pin as dmic1 data pin
+      - 2 # using GPIO3 pin as dmic1 data pin
+
+  realtek,dmic2-data-pin:
+    description: Specify which pin to be used as DMIC2 data pin.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0 # dmic2 is not used
+      - 1 # using IN2N pin as dmic2 data pin
+      - 2 # using GPIO4 pin as dmic2 data pin
+
+  realtek,jack-detect-source:
+    description: The Jack Detect source.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0 # Jack Detect function is not used
+      - 1 # Use GPIO1 for jack-detect
+      - 2 # Use JD1_IN4P for jack-detect
+      - 3 # Use JD2_IN4N for jack-detect
+      - 4 # Use GPIO2 for jack-detect
+      - 5 # Use GPIO3 for jack-detect
+      - 6 # Use GPIO4 for jack-detect
+
+  realtek,jack-detect-not-inverted:
+    description:
+      Normal jack-detect switches give an inverted signal, set this bool
+      in the rare case you've a jack-detect switch which is not inverted.
+    type: boolean
+
+  realtek,over-current-threshold-microamp:
+    description: micbias over-current detection threshold in µA
+    enum:
+      - 600
+      - 1500
+      - 2000
+
+  realtek,over-current-scale-factor:
+    description: micbias over-current detection scale-factor
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0 # Scale current by 0.5
+      - 1 # Scale current by 0.75
+      - 2 # Scale current by 1.0
+      - 3 # Scale current by 1.5
+
+required:
+  - compatible
+  - reg
+  - interrupts
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
+            compatible = "realtek,rt5640";
+            reg = <0x1a>;
+            interrupt-parent = <&gpio>;
+            interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/sound/rt5640.txt b/Documentation/devicetree/bindings/sound/rt5640.txt
deleted file mode 100644
index 0c398581d52b..000000000000
--- a/Documentation/devicetree/bindings/sound/rt5640.txt
+++ /dev/null
@@ -1,97 +0,0 @@
-RT5640/RT5639 audio CODEC
-
-This device supports I2C only.
-
-Required properties:
-
-- compatible : One of "realtek,rt5640" or "realtek,rt5639".
-
-- reg : The I2C address of the device.
-
-- interrupts : The CODEC's interrupt output.
-
-Optional properties:
-
-- clocks: The phandle of the master clock to the CODEC
-- clock-names: Should be "mclk"
-
-- realtek,in1-differential
-- realtek,in2-differential
-- realtek,in3-differential
-  Boolean. Indicate MIC1/2/3 input are differential, rather than single-ended.
-
-- realtek,lout-differential
-  Boolean. Indicate LOUT output is differential, rather than stereo.
-
-- realtek,ldo1-en-gpios : The GPIO that controls the CODEC's LDO1_EN pin.
-
-- realtek,dmic1-data-pin
-  0: dmic1 is not used
-  1: using IN1P pin as dmic1 data pin
-  2: using GPIO3 pin as dmic1 data pin
-
-- realtek,dmic2-data-pin
-  0: dmic2 is not used
-  1: using IN1N pin as dmic2 data pin
-  2: using GPIO4 pin as dmic2 data pin
-
-- realtek,jack-detect-source
-  u32. Valid values:
-  0: jack-detect is not used
-  1: Use GPIO1 for jack-detect
-  2: Use JD1_IN4P for jack-detect
-  3: Use JD2_IN4N for jack-detect
-  4: Use GPIO2 for jack-detect
-  5: Use GPIO3 for jack-detect
-  6: Use GPIO4 for jack-detect
-
-- realtek,jack-detect-not-inverted
-  bool. Normal jack-detect switches give an inverted signal, set this bool
-  in the rare case you've a jack-detect switch which is not inverted.
-
-- realtek,over-current-threshold-microamp
-  u32, micbias over-current detection threshold in µA, valid values are
-  600, 1500 and 2000µA.
-
-- realtek,over-current-scale-factor
-  u32, micbias over-current detection scale-factor, valid values are:
-  0: Scale current by 0.5
-  1: Scale current by 0.75
-  2: Scale current by 1.0
-  3: Scale current by 1.5
-
-Pins on the device (for linking into audio routes) for RT5639/RT5640:
-
-  * DMIC1
-  * DMIC2
-  * MICBIAS1
-  * IN1P
-  * IN1N
-  * IN2P
-  * IN2N
-  * IN3P
-  * IN3N
-  * HPOL
-  * HPOR
-  * LOUTL
-  * LOUTR
-  * SPOLP
-  * SPOLN
-  * SPORP
-  * SPORN
-
-Additional pins on the device for RT5640:
-
-  * MONOP
-  * MONON
-
-Example:
-
-rt5640 {
-	compatible = "realtek,rt5640";
-	reg = <0x1c>;
-	interrupt-parent = <&gpio>;
-	interrupts = <TEGRA_GPIO(W, 3) IRQ_TYPE_LEVEL_HIGH>;
-	realtek,ldo1-en-gpios =
-		<&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
-};

---
base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
change-id: 20240911-topic-amlogic-arm32-upstream-bindings-fixes-covert-realtek-rt5640-bd6d0e6a05d8

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


