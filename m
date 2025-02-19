Return-Path: <linux-kernel+bounces-520918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC65A3B12B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 06:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC6553AD3C5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 05:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711A71B87D9;
	Wed, 19 Feb 2025 05:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rBsELHd3"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3B01AF0DC;
	Wed, 19 Feb 2025 05:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739944671; cv=none; b=HeR4p+oSUnxsNeB9UuOlQVfn3Q8A3HGIgKzmMk6E8MDJwrSTtR8L01Pf07wN8SpZV6NuutglqvShnZZMg6mdnORPXgd0UCl2tbjlCUkVkg0UHL074zj15+wY+cv5C9ylDgeqSAjksTEPPUmYhlhzWGHf1cmE5D9sbXjLRZM3PvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739944671; c=relaxed/simple;
	bh=pfHqlSLud+JXl9D7n5BlEkHhIeYAhbebredddS+EqlM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=lzLlUyEQ0qaTEahHu5Jq+V+9z2vB6gr63uQGN606vlOwdnjBJD2YsVlnWK1pM4OX81H4un5Q6gKg2Q6vZIth/9JB91d3kT1XxOUt1GuJON/X9HMdK9jkjkjY5Dc1jfBsX0pGRV1AaFDvF2WeDGIp6m7Bvxp0+G2BpgUjiIK76os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rBsELHd3; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1739944670; x=1771480670;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=pfHqlSLud+JXl9D7n5BlEkHhIeYAhbebredddS+EqlM=;
  b=rBsELHd3O8u2BDLTWlqnTm737daUqi7VfMQXjB6sj3o6Eyf1oxMiDv6B
   N84QtODxV/hDlCMxwVcrF6geKPGFfv0xq7BkSOWYaE/dGhZOAPTcAvpWC
   5R7Xe9Vg/DBA7sLdnVHIehkLeuNjWh3LgQ6QbmgrXeb30x1IJnKL+N5rW
   vafH36nabrms9QvbJp4Z0CMmTM2/3DXn76MXpZV/uIGD791/+tV5mzCHi
   lTVcVnmSDYhbYyg1XmddzV7Be+GHojG/JgznSOUtcGc/PUSqPR64/UqgY
   EFm71BVCPOdlJ1W92xS2uhSy0ILo1wLAOGUzGyyIGwu1fMLaCeH3zTUkQ
   w==;
X-CSE-ConnectionGUID: H/CF0+SBQUK7yXSaxQ9BXA==
X-CSE-MsgGUID: tuIP3dstSBa4Jp38XcbJ+Q==
X-IronPort-AV: E=Sophos;i="6.13,298,1732604400"; 
   d="scan'208";a="37849285"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Feb 2025 22:57:49 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 18 Feb 2025 22:57:21 -0700
Received: from [10.40.56.22] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 18 Feb 2025 22:57:17 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Wed, 19 Feb 2025 11:22:27 +0530
Subject: [PATCH v3] ASoC: dt-bindings: atmel-at91sam9g20ek: convert to
 json-schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250219-sound-atmel-at91sam9g20ek-v3-1-d7c082af4e14@microchip.com>
X-B4-Tracking: v=1; b=H4sIAJpxtWcC/32NywrCMBREf6XctZE8ajGu+h/SRUxum4umKUktS
 um/Gwtu3QycgTmzQsZEmOFSrZBwoUxxLKAOFVhvxgEZucIguayFFJzl+BwdM3PAR0ktsgl6kBz
 v7MZRO8T6pJSFsp8S9vTa3deusKc8x/Terxb5bX9W8ce6SCbYuTEclcDG9LoNZFO0nqajjQG6b
 ds+vyWJRMYAAAA=
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
Changes in v3:
- Add recommended minItems and maxItems.
- Fix commit subject and a typo in example.
- Link to v2: https://lore.kernel.org/r/20241211-sound-atmel-at91sam9g20ek-v2-1-86a0e31e6af9@microchip.com

Changes in v2:
- Add missing CODEC pin options to 'atmel,audio-routing' items.
- Drop 'minItems' from 'atmel,audio-routing' since enum defines valid connections.
- Add subsystem tag to subject.
- Add blank line between properties and fix typo.
- Add audio complex description.
- Link to v1: https://lore.kernel.org/lkml/20240214-at91sam9g20ek-wm8731-yaml-v1-1-33333e17383b@microchip.com
---
 .../bindings/sound/atmel,at91sam9g20ek-wm8731.yaml | 72 ++++++++++++++++++++++
 .../sound/atmel-at91sam9g20ek-wm8731-audio.txt     | 26 --------
 2 files changed, 72 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/atmel,at91sam9g20ek-wm8731.yaml b/Documentation/devicetree/bindings/sound/atmel,at91sam9g20ek-wm8731.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..627da2d890b24a14e595d1752276c94b158451a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/atmel,at91sam9g20ek-wm8731.yaml
@@ -0,0 +1,72 @@
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
+    minItems: 2
+    maxItems: 4
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
+            "Int Mic", "MICIN";
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
base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
change-id: 20241210-sound-atmel-at91sam9g20ek-b0e9dee4533c

Best regards,
-- 
Balakrishnan Sambath <balakrishnan.s@microchip.com>


