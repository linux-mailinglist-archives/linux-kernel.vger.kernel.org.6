Return-Path: <linux-kernel+bounces-232166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1FB91A453
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA8F28677C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110DE13F42F;
	Thu, 27 Jun 2024 10:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiRiFRiq"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8FA208A5;
	Thu, 27 Jun 2024 10:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719485452; cv=none; b=gANIQ4CExsPmDgJCwfbtFVrDt7aXqIXJXmQ7PtdhLE3M1pqeedGlySk86Rxlm9rKwH4Q5xWy8/5lNvVDxrFEn/xDodZ+W8PmwdN0c0ShQJ9SPWhipaVFiGtfx2rt5HM+FoxJtnCkWw/yPfpARhkhX75YBL3xsn9duw16L2orFA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719485452; c=relaxed/simple;
	bh=YBwgjVUikR/vPP6m/xvgU/SfQMiAcLM7lsk6wezZYrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DBUxPMTdMV7NkAkQ07TOYkdhyCcyDOHH+y5kqcBshp3wB9/I0GG2DLF7awSAgRzjnV5tJ8suNfLNCjv05lNjqxGZh3EUBN3DGdoIpVJVlsfYSZ8MgYsNqJ3zx3hYkQCWaLL5h2i2gQO/Ermauc9GmsVPsjOorcECnHwIPMO/PQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JiRiFRiq; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3762abfe005so32200365ab.2;
        Thu, 27 Jun 2024 03:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719485450; x=1720090250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Z0nf81rt4pKCg289A1fafeQoAs93ALMK9Xuprzaa04=;
        b=JiRiFRiqfjeQ3YF+dRrhfzU+VyMAq8Y+U0LXGz1M8wep8U7GlC/qOBBoT5ITGf2pR3
         5aVUT8284I/5cEyuTxV2qbKw/k0IRBx2Bp4Z02YuYkSZv7rUosvIXMOkmuco0J+uqr31
         FI5o7t2USsrnVm/OXiQyGiETYx5yUP4Y+9mJ/6iRgtqpyPg/y/1atNAJHQ05L0ckqFxO
         uIb3Epf8YeELXPwCoK1ktzjvhUJbX9mS+mM33F2xAjchIZZXTJe0spzVAfvtZFD0K9y+
         bvp6fCHwyCnqWWXYuj8mmgLUKE7JL03KDnG5xnoNGCcpBOyuMjRxdMUjpOipUUkw4FlU
         zJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719485450; x=1720090250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Z0nf81rt4pKCg289A1fafeQoAs93ALMK9Xuprzaa04=;
        b=HueyDeEjSsMFBfTGR08WhNY3LiVOZdmv/8ttn6SPsyHgM0m30P/eqVFqdRTMHOpPA3
         UTMYxwBhEfBNOkoy0DXp8C5ue5j68aujJeNrDxAMQr/qCIbYgHWEfsrsZt6zxHdoSUd5
         5RN4jPDTHwW7lJiL8qI+c86Yugeo9n5TqLYtB6B9rFSaYVF27/Booh+VUgrfJZYaGLn1
         /OmbHCaL7vwrRwxws6K2/6nXEIF0ryKafyrHkykAPBMHDcUeNkLt8cQiN8nZq5XGn/4V
         pA6vzU2AQfvCGzFkByDnopQ0YcQyz+Py0+6APA/kfFRFFXKCSu6Vq1Qei/R3S6Kyl5bf
         +k6g==
X-Forwarded-Encrypted: i=1; AJvYcCUOhChg7MLlbltoeRd762VmcIG0NoVWKRnzx5vLsLOevuXDABDyTBqhF9kfLrHy+kDYFUGmV5WU4WHNpi9/1wmVs/GfpgPQkKb7rHCv50yQp6f8kn9MDZsvbyw3gvfteWSgES68yy4O1ostOhkDMoIo2MHAjEiq7LbhJDJa6FGDwnB0HOJT
X-Gm-Message-State: AOJu0Yxc8cxr4Gu9VU5NX4eSF9pHsixSYsKIgrM5xOUIJX54ORKn8Iy9
	rS9zU7RJPd7pPPaMqhCxJmpFSngs7DIfAqeSuCgBsJYiHNEcFqQq
X-Google-Smtp-Source: AGHT+IGDM0alksr+Hd4IyG19uJTvuI9/pP6uHRFbuipA+wKeHE7MFDNVcAiTXIeALNGcV08o2DrY6g==
X-Received: by 2002:a05:6e02:1807:b0:375:a6cd:dff2 with SMTP id e9e14a558f8ab-3763f5ca221mr181124435ab.5.1719485449554;
        Thu, 27 Jun 2024 03:50:49 -0700 (PDT)
Received: from fedora.one.one.one.one ([2405:201:6013:c9a2:59df:d296:bffe:732c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72749c25c3asm830283a12.90.2024.06.27.03.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 03:50:49 -0700 (PDT)
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
Subject: [PATCH v2] ASoC: dt-bindings: realtek,rt5677: Convert to dtschema
Date: Thu, 27 Jun 2024 16:20:26 +0530
Message-ID: <20240627105030.14360-1-animeshagarwal28@gmail.com>
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
Changes in v2:
  - Used consistant quotes.
  - Listed jack detect as properties instead of patternProperties.
---
 .../bindings/sound/realtek,rt5677.yaml        | 135 ++++++++++++++++++
 .../devicetree/bindings/sound/rt5677.txt      |  78 ----------
 2 files changed, 135 insertions(+), 78 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt5677.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/rt5677.txt

diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5677.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5677.yaml
new file mode 100644
index 000000000000..9ce23e58e5ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/realtek,rt5677.yaml
@@ -0,0 +1,135 @@
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
+  realtek,jd1-gpio:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0 # OFF
+      - 1 # GPIO1 for jd1.
+      - 2 # GPIO2 for jd1.
+      - 3 # GPIO3 for jd1.
+    description: Configures GPIO Mic Jack detection 1.
+
+  realtek,jd2-gpio:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0 # OFF
+      - 1 # GPIO4 for jd2.
+      - 2 # GPIO5 for jd2.
+      - 3 # GPIO6 for jd2.
+    description: Configures GPIO Mic Jack detection 2.
+
+  realtek,jd3-gpio:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0 # OFF
+      - 1 # GPIO4 for jd3.
+      - 2 # GPIO5 for jd3.
+      - 3 # GPIO6 for jd3.
+    description: Configures GPIO Mic Jack detection 3.
+
+patternProperties:
+  '^realtek,in[1-2]-differential$':
+    type: boolean
+    description: Indicate MIC1/2 input are differential, rather than
+      single-ended.
+
+  '^realtek,lout[1-3]-differential$':
+    type: boolean
+    description: Indicate LOUT1/2/3 outputs are differential, rather than
+      single-ended.
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


