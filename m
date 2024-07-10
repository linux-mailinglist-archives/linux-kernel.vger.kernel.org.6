Return-Path: <linux-kernel+bounces-247151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F036492CBEB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E0B51F229FA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF9E84A32;
	Wed, 10 Jul 2024 07:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYEFHGoS"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7338E83CD9;
	Wed, 10 Jul 2024 07:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720596501; cv=none; b=WksqgclySs4Rk4AT0cxye1A5wE5N/HSC0fTzuyZnLObV+AT0thGNd3wnhJ4C3C/h5vr1F7mqyORaQHTTAcJBTefxl8pUF3nt5E5vtsVScZhY9nRMooNFet1+PGe61ZiUGb/4QVed6+cebft7oaEgRaD77bqw0yftuHsnbUgOJyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720596501; c=relaxed/simple;
	bh=xLrXFMCa+ZVf2BoMI1TvIQ2l4PsrXNPhP1XvRjPpC3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L5jv9j+uZy88SwZVUuMEFpxyxyvNRfX5ro8TpSpDr6Cb5Z50XwZCtQk/2e/m7/+z6n3NKHc01aBa1t2aF/WklKXfQQDLJ8gBfcaRRu9JO5ZRlHjx52dXwq8ig4bx+UJhgknjZdru40TuOJhb5+21WUXRqU9DszRsIexT+0AgWNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYEFHGoS; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6e7e23b42c3so3165576a12.1;
        Wed, 10 Jul 2024 00:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720596500; x=1721201300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/zjRVa3Uqe4dlMlnLz1HXHc8gPRm1KW7opYsvONaNGg=;
        b=NYEFHGoSHQtu76hEVn4FJX3DOmil/yiPOcH6x+4Xd3EP4cWw03g42v3DbtQTLEoE9j
         q8DnfCn5waZ1LpYOZOqF/L1WqPQdkwRgTC4k53DWqut8kN+Imfs1b+0KmK53QKLvlvet
         qP8bph2C4l3PCLh16nmIsGR+kWj01/rtW8BnqQxMPc9nopxlX4JTBrJ2bHX6bbJvdZKA
         uXcTQ4xM8pl2oRquPhGDUlvZa1sRmClYnrH9ARgAxnUfkg4KkJwXMbwAXQYTUsNPDFjp
         F69/OXdNsKvhte9I9OattYjBCBEZbmdvx7FWZIYFNAcIPjHO6zNzsFuZZBalyBYAT3cR
         3kuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720596500; x=1721201300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/zjRVa3Uqe4dlMlnLz1HXHc8gPRm1KW7opYsvONaNGg=;
        b=oZLVFvTprBEhmtBlVPF9Sytt9z5NM49i55AE93qJmkqdsK2F/89/EqcAwrkcNF2pD+
         Ft567cHiI/69I7g/B1uhJvYQP/SU9HckVzU+LNJbCEovZzMUDecnMqY2hKQ/Vs+c7GiT
         +XHO3PNJShqfVsWBnO//yl78bnMCoBZb6pf5Xcu/Kl4+BaSQ1cle0GN1DaME9+w+g7rE
         QVteOYNL02os9XLZ+11T4ybG8zkdnF1iOn3tclqCFU6PwtD2kAg24GilBf9VPCvFfGNE
         pVnHGfBNTYr8jdn+59d5okLMVsJyFyw8OTBIJ/pEuyrqB8UaXAD5aEmjanpMxfIK6b5M
         lV9w==
X-Forwarded-Encrypted: i=1; AJvYcCV/slI865McXxjy20ZoA1trS+SiMAxV4AELV6FSOXFTXlSksP6dO53Hy2cwQE0lQL/M7P1b9zcxaRbihBJF+/GKolbEEPIIdG7Hzj4DlwVkGczP8tMXL3zBM50e8Z1O8c96g45k403gA/MAvxbuSvmmO/qir4F/cI3eCVWerEllv9xN4zQM
X-Gm-Message-State: AOJu0Yyjjh/0GCaYAc08qi6v7Km0sbGsEb2gMNUuba0rFFCVcexQ8pF1
	AJNENdAc8PiG74C65T5+lChL0GwBBJq9hrYhXk1cBJ0ZkR+ZZdc1
X-Google-Smtp-Source: AGHT+IFu0qG2le5/zbstuRM/nVLLnScMXOcToJf4iu1XEgBAZVxL4GTxdNfBD3Wm7sxWWCa+RNKpZg==
X-Received: by 2002:a05:6a20:9e4a:b0:1be:c3dd:642a with SMTP id adf61e73a8af0-1c2982512f3mr5285279637.37.1720596499433;
        Wed, 10 Jul 2024 00:28:19 -0700 (PDT)
Received: from fedora.. ([45.118.158.79])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ca34e89d46sm3074678a91.27.2024.07.10.00.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 00:28:19 -0700 (PDT)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: Animesh Agarwal <animeshagarwal28@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	patches@opensource.cirrus.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: cirrus,cs42xx8: Convert to dtschema
Date: Wed, 10 Jul 2024 12:57:52 +0530
Message-ID: <20240710072756.99765-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Cirrus Logic CS42448/CS42888 audio CODEC bindings to DT
schema format. Set power supply properties to required only for CS42888.

Cc: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
---
 .../bindings/sound/cirrus,cs42xx8.yaml        | 81 +++++++++++++++++++
 .../devicetree/bindings/sound/cs42xx8.txt     | 34 --------
 2 files changed, 81 insertions(+), 34 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/cirrus,cs42xx8.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/cs42xx8.txt

diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs42xx8.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs42xx8.yaml
new file mode 100644
index 000000000000..725b47e82062
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cirrus,cs42xx8.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/cirrus,cs42xx8.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic CS42448/CS42888 audio CODEC
+
+maintainers:
+  - patches@opensource.cirrus.com
+
+properties:
+  compatible:
+    enum:
+      - cirrus,cs42448
+      - cirrus,cs42888
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    const: mclk
+
+  VA-supply:
+    description: Analog power supply.
+
+  VD-supply:
+    description: Digital power supply.
+
+  VLC-supply:
+    description: Control port power supply
+
+  VLS-supply:
+    description: Serial port interface power supply.
+
+  reset-gpios:
+    description: This pin is connected to the chip's RESET pin.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: cirrus,cs42888
+then:
+  required:
+    - VA-supply
+    - VD-supply
+    - VLC-supply
+    - VLS-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      codec@48 {
+          compatible = "cirrus,cs42888";
+          reg = <0x48>;
+          clocks = <&codec_mclk 0>;
+          clock-names = "mclk";
+          VA-supply = <&reg_audio>;
+          VD-supply = <&reg_audio>;
+          VLS-supply = <&reg_audio>;
+          VLC-supply = <&reg_audio>;
+          reset-gpios = <&gpio 1>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/sound/cs42xx8.txt b/Documentation/devicetree/bindings/sound/cs42xx8.txt
deleted file mode 100644
index bbfe39347c20..000000000000
--- a/Documentation/devicetree/bindings/sound/cs42xx8.txt
+++ /dev/null
@@ -1,34 +0,0 @@
-CS42448/CS42888 audio CODEC
-
-Required properties:
-
-  - compatible : must contain one of "cirrus,cs42448" and "cirrus,cs42888"
-
-  - reg : the I2C address of the device for I2C
-
-  - clocks : a list of phandles + clock-specifiers, one for each entry in
-    clock-names
-
-  - clock-names : must contain "mclk"
-
-  - VA-supply, VD-supply, VLS-supply, VLC-supply: power supplies for the device,
-    as covered in Documentation/devicetree/bindings/regulator/regulator.txt
-
-Optional properties:
-
-  - reset-gpios : a GPIO spec to define which pin is connected to the chip's
-    !RESET pin
-
-Example:
-
-cs42888: codec@48 {
-	compatible = "cirrus,cs42888";
-	reg = <0x48>;
-	clocks = <&codec_mclk 0>;
-	clock-names = "mclk";
-	VA-supply = <&reg_audio>;
-	VD-supply = <&reg_audio>;
-	VLS-supply = <&reg_audio>;
-	VLC-supply = <&reg_audio>;
-	reset-gpios = <&pca9557_b 1 GPIO_ACTIVE_LOW>;
-};
-- 
2.45.2


