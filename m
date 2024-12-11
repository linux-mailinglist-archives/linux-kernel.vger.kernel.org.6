Return-Path: <linux-kernel+bounces-441108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8C39EC9B2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2865D286BE7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF55F1E9B25;
	Wed, 11 Dec 2024 09:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="e+3Y+ugd"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBAE236FA9;
	Wed, 11 Dec 2024 09:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733910695; cv=none; b=JyvdSWN3LIqX7L7wh5kw48tsc/PfEhpV2BAiCrwUzxDzAEt5CjzJLUSgDhZygtFXLykzZ9ajyOAdT+hTNrWGvFVCkcuS/yCWLYaT1BFC6y8DGviREqWiE8cZ394tCMQFBKfjc+Q3oXd9oGuwUwYxDg14adK7a13H3nEHC0n1FUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733910695; c=relaxed/simple;
	bh=LzAaQ9/f27z5r4Rw3P4o4STEAG4bFLrOUEoWElzrSCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=lg+V/g2IwVRQP88kwxW2Wd5RppFyg4xm5wUK2kpF7R2lG0mEFrio9zKjZh//jLJ7bvpt7wQ+peeFsNcJaNyuYYGRrqXfP8NMuCxFbTThxjn9tZ+oS38LtWAcxNB28txTkL806w1Ge0l7duaw9G3wwMdVX5d2vMNh7QqCgRxbL60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=e+3Y+ugd; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733910693; x=1765446693;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=LzAaQ9/f27z5r4Rw3P4o4STEAG4bFLrOUEoWElzrSCg=;
  b=e+3Y+ugdEDB5wWp9cbXVEoRjv5JE3ok5nTNbHqwY1XiE6CDyyikE4Sgv
   jRBHLu430YoKboLSLr8Z993zTXasEABXc/CDt0ldkJ68Q5dA+E8F2ijRJ
   ptm/OaCiO2CExHXdNyDqOaz5ekX0NCsRdeo1o/AIIrZMqUnuzCXvOxN8V
   wvBtvKHsPWUbwBl8dYUQW2DaKD5WA2PWbUqF8s3Mpg+HeG1yy8j4o1Mkk
   FDGtZm8KT/JzPiBnjtI6bSs7uFSefPDAtJXnBo5dGFj+HoQbNQ5SSEg6w
   J6ZLdpmUtoq0mxyx1QU5De6jVuZ/SPePX7vVi/IBs/uVLrPX5ZasNTfB3
   w==;
X-CSE-ConnectionGUID: GnpFG6FJQ6OCytt/AW6k6A==
X-CSE-MsgGUID: Tmq7ep6yT3ejLSoZb9pFJg==
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="39091181"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Dec 2024 02:51:26 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 11 Dec 2024 02:51:00 -0700
Received: from che-dk-mpulab01.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 11 Dec 2024 02:50:56 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Wed, 11 Dec 2024 15:16:15 +0530
Subject: [PATCH v2] ASoC: dt-bindings: sound: atmel-at91sam9g20ek: convert
 to json-schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241211-sound-atmel-at91sam9g20ek-v2-1-86a0e31e6af9@microchip.com>
X-B4-Tracking: v=1; b=H4sIAGZfWWcC/x2MwQqDMBAFf0X23ECy6iH+SukhNU+7VGPJWhHEf
 zd4GZjDzEGKLFDqqoMyNlFZUhF+VNR/QhphJBYnttw4dtbo8k/RhHXGVOidhtmPbPE1bwsfgaa
 t655K/8sYZL/fz9d5XovhgeRrAAAA
X-Change-ID: 20241210-sound-atmel-at91sam9g20ek-b0e9dee4533c
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrei Simion
	<andrei.simion@microchip.com>, Liam Girdwood <lgirdwood@gmail.com>, "Mark
 Brown" <broonie@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Nicolas
 Ferre" <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>
CC: <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Balakrishnan Sambath <balakrishnan.s@microchip.com>
X-Mailer: b4 0.14.2

Convert atmel-at91sam9g20ek-wm8731-audio DT binding to yaml
based json-schema.Change file name to match json-scheme naming.

Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
---
Changes in v2:
- Add missing CODEC pin options to 'atmel,audio-routing' items.
- Drop 'minItems' from 'atmel,audio-routing' since enum defines valid connections.
- Add subsystem tag to subject.
- Add blank line between properties and fix typo.
- Add audio complex description.
- Link to v1: https://lore.kernel.org/lkml/20240214-at91sam9g20ek-wm8731-yaml-v1-1-33333e17383b@microchip.com
---
 .../bindings/sound/atmel,at91sam9g20ek-wm8731.yaml | 70 ++++++++++++++++++++++
 .../sound/atmel-at91sam9g20ek-wm8731-audio.txt     | 26 --------
 2 files changed, 70 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/atmel,at91sam9g20ek-wm8731.yaml b/Documentation/devicetree/bindings/sound/atmel,at91sam9g20ek-wm8731.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..7f6334c96e0b753f83a1714a34514f101c2639c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/atmel,at91sam9g20ek-wm8731.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/atmel,at91sam9g20ek-wm8731.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel at91sam9g20ek wm8731 audio complex
+
+maintainers:
+  - Balakrishnan Sambath <balakrishnan.s@microchip.com>
+
+description:
+  The audio complex configuration for Atmel at91sam9g20ek with WM8731 audio codec.
+
+properties:
+  compatible:
+    const: atmel,at91sam9g20ek-wm8731-audio
+
+  atmel,model:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: The user-visible name of this sound complex.
+
+  atmel,audio-routing:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description: A list of the connections between audio components.
+    items:
+      enum:
+        # Board Connectors
+        - Ext Spk
+        - Int Mic
+
+        # CODEC Pins
+        - LOUT
+        - ROUT
+        - LHPOUT
+        - RHPOUT
+        - LLINEIN
+        - RLINEIN
+        - MICIN
+
+  atmel,ssc-controller:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of the SSC controller.
+
+  atmel,audio-codec:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of WM8731 audio codec.
+
+required:
+  - compatible
+  - atmel,model
+  - atmel,audio-routing
+  - atmel,ssc-controller
+  - atmel,audio-codec
+
+additionalProperties: false
+
+examples:
+  - |
+    sound {
+        compatible = "atmel,at91sam9g20ek-wm8731-audio";
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_pck0_as_mck>;
+        atmel,model = "wm8731 @ AT91SAMG20EK";
+        atmel,audio-routing =
+            "Ext Spk", "LHPOUT",
+            "Int MIC", "MICIN";
+        atmel,ssc-controller = <&ssc0>;
+        atmel,audio-codec = <&wm8731>;
+    };
diff --git a/Documentation/devicetree/bindings/sound/atmel-at91sam9g20ek-wm8731-audio.txt b/Documentation/devicetree/bindings/sound/atmel-at91sam9g20ek-wm8731-audio.txt
deleted file mode 100644
index 9c5a9947b64d454a892e1e4148ff06be7c33d6cd..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/sound/atmel-at91sam9g20ek-wm8731-audio.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-* Atmel at91sam9g20ek wm8731 audio complex
-
-Required properties:
-  - compatible: "atmel,at91sam9g20ek-wm8731-audio"
-  - atmel,model: The user-visible name of this sound complex.
-  - atmel,audio-routing: A list of the connections between audio components.
-  - atmel,ssc-controller: The phandle of the SSC controller
-  - atmel,audio-codec: The phandle of the WM8731 audio codec
-Optional properties:
-  - pinctrl-names, pinctrl-0: Please refer to pinctrl-bindings.txt
-
-Example:
-sound {
-	compatible = "atmel,at91sam9g20ek-wm8731-audio";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pck0_as_mck>;
-
-	atmel,model = "wm8731 @ AT91SAMG20EK";
-
-	atmel,audio-routing =
-		"Ext Spk", "LHPOUT",
-		"Int MIC", "MICIN";
-
-	atmel,ssc-controller = <&ssc0>;
-	atmel,audio-codec = <&wm8731>;
-};

---
base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
change-id: 20241210-sound-atmel-at91sam9g20ek-b0e9dee4533c

Best regards,
-- 
Balakrishnan Sambath <balakrishnan.s@microchip.com>


