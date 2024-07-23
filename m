Return-Path: <linux-kernel+bounces-259761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B4A939CC0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180D92821E3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC42D14D443;
	Tue, 23 Jul 2024 08:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TYnD7YS3"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E17614C586
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721723589; cv=none; b=NZtS7h8hB3h0051ea2Wl4ZNFjYpNpoV+anXcDGNUST/DwQhjhatqdq5Z/VwugdfAGFQ128G5n/1IO/1VuKtVfNZb9LG6m3rXcYeWxW3g9IIIjZRbJukdWHk0O7ekqugX5ztueCCh3ls/01Br3RB/NAg7r7DW7pdz5FOk81D7T90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721723589; c=relaxed/simple;
	bh=b8CoiMb5iphdulrbGF9IbDlgJakpNPEN+MYJHrdNTPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LOKNEaxmUMuJQ79PFm/781ur4QgcFg7GgmC0CGAOfzIb42S7QoKC6SaghXsvSyX+C93UAXByD/ski6SL4xwGuJ8s2mL22o+ueQClHgvdi6hSUW4WzPwVKK54Zwbrfp1Zk2T3UKSy/i5PoDfqzCUxqLR9mlpUQ8sxtnT1gEGlxPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TYnD7YS3; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4266ea6a488so45201955e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 01:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721723585; x=1722328385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1t+iNJUM6/WeeHxpFiE1OIXXIHbHfdlbLYRP84zH2DY=;
        b=TYnD7YS3YXDtTFBLWcmGOetaDhbvhAkRuiKJ9fG5gY6HHYfQOx/RVRAMGeIE7FvSac
         tWnqQ1jV2TN9xVL8Vmw5Prt7wzRP5zs1/g/t809gFZUDhs7vTDyoOy4fQDlONSDHVxOX
         dfvvpQymKHjedY9nvTxlCbrG3Lr7vA5IJW4PCSXzFve7aDc/YNd/PfedUS0w4IreVGqy
         WGl1XQNRYr3pCN5Y7sld8WYoPCnq/WMdffaz+l6UyNPq8mhD0Tlv07EFx70BpdJcQyn6
         RDRgOtHUFYlQLIzpQjRXvSQPaYnlcHNBWWjVpbDNEHE3PyY/4dsNSSkWt/d8FTKkTQ9K
         znIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721723585; x=1722328385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1t+iNJUM6/WeeHxpFiE1OIXXIHbHfdlbLYRP84zH2DY=;
        b=eA1VE+hyfhBSJTfxBJl9iPMLqUkzY1iWOnxh/Jo69sxTkMkaSzl7AxH5Vz6SD66iJ/
         p1s/gZ1dHdwPsgo5zONDE+zi2S0x0NSYpnUfG1j82WYP6kMt6ychqoUx2e31YF/UuPCV
         GOuGP7ggFsVjVi1gPHT8V1jCNQ//Qy+xT0GaRNGbAKCEvx5w897ks7sqmw9SALfhbZnC
         AWPuo3Ih7cKQ3PW6kRSm3ucgNxR/vEYo5qY+e9NRTsDcrDix8crO6ks3zOc34FSO2qg3
         ReZ14ES7AMH/PxmTgbXNvfLLrVHqgMK+W9rSieUc7lRKYyljXQbJ2aoz3jMzIwRUHd2a
         ULaw==
X-Forwarded-Encrypted: i=1; AJvYcCXvchA1YC9EVS7rZRYDVBH7S3XjHBxG3+NH1lzyB9gVeobfyXOMEfky80kIoPzUul6fYtB86yZ0K3soiXb+CVqqJneTz6vWTJ4GOoGN
X-Gm-Message-State: AOJu0YzBYoJhS/pH3luM67bZdvlLQveeLCwk5u5Fxvj2+ISOTgzjxegc
	MPyoTblFhhtaJiafcgz+9xAu5vQz7i9qLPVlCxk2utDN7ykXZNfWAKNUb66WBvM=
X-Google-Smtp-Source: AGHT+IFr4CpzZyMvq6++T1fapTLZpMDNxT4jkNAHhBZudp0bJTnJiQ+DtD4LUAMj0LUFlA1zfq8k6Q==
X-Received: by 2002:a05:600c:1912:b0:427:d8f2:33b with SMTP id 5b1f17b1804b1-427dc529086mr88754665e9.20.1721723585395;
        Tue, 23 Jul 2024 01:33:05 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d68fa171sm162857735e9.1.2024.07.23.01.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 01:33:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephan Gerhold <stephan@gerhold.net>,
	alsa-devel@alsa-project.org,
	linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Adam Skladowski <a39.skl@gmail.com>
Subject: [PATCH] ASoC: dt-bindings: qcom,apq8016-sbc-sndcard: move to separate binding
Date: Tue, 23 Jul 2024 10:33:00 +0200
Message-ID: <20240723083300.35605-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The APQ8016 SBC and MSM8916 QDSP6 sound cards are a bit different from
others: they have additional IO muxing address space and pin control.
Move them to separate schema, so the original qcom,sm8250.yaml will be
easier to manage.  New schema is going to grow for other platforms
having more of IO muxing address spaces.

Cc: Adam Skladowski <a39.skl@gmail.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../sound/qcom,apq8016-sbc-sndcard.yaml       | 205 ++++++++++++++++++
 .../bindings/sound/qcom,sm8250.yaml           | 137 ------------
 2 files changed, 205 insertions(+), 137 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,apq8016-sbc-sndcard.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc-sndcard.yaml b/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc-sndcard.yaml
new file mode 100644
index 000000000000..6ad451549036
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc-sndcard.yaml
@@ -0,0 +1,205 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,apq8016-sbc-sndcard.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm APQ8016 and similar sound cards
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+  - Stephan Gerhold <stephan@gerhold.net>
+
+properties:
+  compatible:
+    enum:
+      - qcom,apq8016-sbc-sndcard
+      - qcom,msm8916-qdsp6-sndcard
+
+  reg:
+    items:
+      - description: Microphone I/O mux register address
+      - description: Speaker I/O mux register address
+
+  reg-names:
+    items:
+      - const: mic-iomux
+      - const: spkr-iomux
+
+  audio-routing:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description:
+      A list of the connections between audio components. Each entry is a
+      pair of strings, the first being the connection's sink, the second
+      being the connection's source. Valid names could be power supplies,
+      MicBias of codec and the jacks on the board.
+
+  aux-devs:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: |
+      List of phandles pointing to auxiliary devices, such
+      as amplifiers, to be added to the sound card.
+
+  model:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: User visible long sound card name
+
+  pin-switches:
+    description: List of widget names for which pin switches should be created.
+    $ref: /schemas/types.yaml#/definitions/string-array
+
+  widgets:
+    description: User specified audio sound widgets.
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+
+patternProperties:
+  ".*-dai-link$":
+    description:
+      Each subnode represents a dai link. Subnodes of each dai links would be
+      cpu/codec dais.
+
+    type: object
+
+    properties:
+      link-name:
+        description: Indicates dai-link name and PCM stream name.
+        $ref: /schemas/types.yaml#/definitions/string
+        maxItems: 1
+
+      cpu:
+        description: Holds subnode which indicates cpu dai.
+        type: object
+        additionalProperties: false
+
+        properties:
+          sound-dai:
+            maxItems: 1
+
+      platform:
+        description: Holds subnode which indicates platform dai.
+        type: object
+        additionalProperties: false
+
+        properties:
+          sound-dai:
+            maxItems: 1
+
+      codec:
+        description: Holds subnode which indicates codec dai.
+        type: object
+        additionalProperties: false
+
+        properties:
+          sound-dai:
+            minItems: 1
+            maxItems: 8
+
+    required:
+      - link-name
+      - cpu
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - model
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/sound/qcom,lpass.h>
+    sound@7702000 {
+        compatible = "qcom,apq8016-sbc-sndcard";
+        reg = <0x07702000 0x4>, <0x07702004 0x4>;
+        reg-names = "mic-iomux", "spkr-iomux";
+
+        model = "DB410c";
+        audio-routing =
+            "AMIC2", "MIC BIAS Internal2",
+            "AMIC3", "MIC BIAS External1";
+
+        pinctrl-0 = <&cdc_pdm_lines_act &ext_sec_tlmm_lines_act &ext_mclk_tlmm_lines_act>;
+        pinctrl-1 = <&cdc_pdm_lines_sus &ext_sec_tlmm_lines_sus &ext_mclk_tlmm_lines_sus>;
+        pinctrl-names = "default", "sleep";
+
+        quaternary-dai-link {
+            link-name = "ADV7533";
+            cpu {
+                sound-dai = <&lpass MI2S_QUATERNARY>;
+            };
+            codec {
+                sound-dai = <&adv_bridge 0>;
+            };
+        };
+
+        primary-dai-link {
+            link-name = "WCD";
+            cpu {
+                sound-dai = <&lpass MI2S_PRIMARY>;
+            };
+            codec {
+                sound-dai = <&lpass_codec 0>, <&wcd_codec 0>;
+            };
+        };
+
+        tertiary-dai-link {
+            link-name = "WCD-Capture";
+            cpu {
+                sound-dai = <&lpass MI2S_TERTIARY>;
+            };
+            codec {
+                sound-dai = <&lpass_codec 1>, <&wcd_codec 1>;
+            };
+        };
+    };
+
+  - |
+    #include <dt-bindings/sound/qcom,q6afe.h>
+    #include <dt-bindings/sound/qcom,q6asm.h>
+    sound@7702000 {
+        compatible = "qcom,msm8916-qdsp6-sndcard";
+        reg = <0x07702000 0x4>, <0x07702004 0x4>;
+        reg-names = "mic-iomux", "spkr-iomux";
+
+        model = "msm8916";
+        widgets =
+            "Speaker", "Speaker",
+            "Headphone", "Headphones";
+        pin-switches = "Speaker";
+        audio-routing =
+            "Speaker", "Speaker Amp OUT",
+            "Speaker Amp IN", "HPH_R",
+            "Headphones", "HPH_L",
+            "Headphones", "HPH_R",
+            "AMIC1", "MIC BIAS Internal1",
+            "AMIC2", "MIC BIAS Internal2",
+            "AMIC3", "MIC BIAS Internal3";
+        aux-devs = <&speaker_amp>;
+
+        pinctrl-names = "default", "sleep";
+        pinctrl-0 = <&cdc_pdm_lines_act>;
+        pinctrl-1 = <&cdc_pdm_lines_sus>;
+
+        mm1-dai-link {
+            link-name = "MultiMedia1";
+            cpu {
+                sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA1>;
+            };
+        };
+
+        primary-dai-link {
+            link-name = "Primary MI2S";
+            cpu {
+                sound-dai = <&q6afedai PRIMARY_MI2S_RX>;
+            };
+            platform {
+                sound-dai = <&q6routing>;
+            };
+            codec {
+                sound-dai = <&lpass_codec 0>, <&wcd_codec 0>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
index c9076dcd44c1..1d3acdc0c733 100644
--- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
@@ -27,9 +27,7 @@ properties:
               - qcom,sm8650-sndcard
           - const: qcom,sm8450-sndcard
       - enum:
-          - qcom,apq8016-sbc-sndcard
           - qcom,apq8096-sndcard
-          - qcom,msm8916-qdsp6-sndcard
           - qcom,qcm6490-idp-sndcard
           - qcom,qcs6490-rb3gen2-sndcard
           - qcom,qrb5165-rb5-sndcard
@@ -58,18 +56,6 @@ properties:
     $ref: /schemas/types.yaml#/definitions/string
     description: User visible long sound card name
 
-  pin-switches:
-    description: List of widget names for which pin switches should be created.
-    $ref: /schemas/types.yaml#/definitions/string-array
-
-  widgets:
-    description: User specified audio sound widgets.
-    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
-
-  # Only valid for some compatibles (see allOf if below)
-  reg: true
-  reg-names: true
-
 patternProperties:
   ".*-dai-link$":
     description:
@@ -122,34 +108,6 @@ required:
   - compatible
   - model
 
-allOf:
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,apq8016-sbc-sndcard
-              - qcom,msm8916-qdsp6-sndcard
-    then:
-      properties:
-        reg:
-          items:
-            - description: Microphone I/O mux register address
-            - description: Speaker I/O mux register address
-        reg-names:
-          items:
-            - const: mic-iomux
-            - const: spkr-iomux
-      required:
-        - compatible
-        - model
-        - reg
-        - reg-names
-    else:
-      properties:
-        reg: false
-        reg-names: false
-
 additionalProperties: false
 
 examples:
@@ -231,98 +189,3 @@ examples:
             };
         };
     };
-
-  - |
-    #include <dt-bindings/sound/qcom,lpass.h>
-    sound@7702000 {
-        compatible = "qcom,apq8016-sbc-sndcard";
-        reg = <0x07702000 0x4>, <0x07702004 0x4>;
-        reg-names = "mic-iomux", "spkr-iomux";
-
-        model = "DB410c";
-        audio-routing =
-            "AMIC2", "MIC BIAS Internal2",
-            "AMIC3", "MIC BIAS External1";
-
-        pinctrl-0 = <&cdc_pdm_lines_act &ext_sec_tlmm_lines_act &ext_mclk_tlmm_lines_act>;
-        pinctrl-1 = <&cdc_pdm_lines_sus &ext_sec_tlmm_lines_sus &ext_mclk_tlmm_lines_sus>;
-        pinctrl-names = "default", "sleep";
-
-        quaternary-dai-link {
-            link-name = "ADV7533";
-            cpu {
-                sound-dai = <&lpass MI2S_QUATERNARY>;
-            };
-            codec {
-                sound-dai = <&adv_bridge 0>;
-            };
-        };
-
-        primary-dai-link {
-            link-name = "WCD";
-            cpu {
-                sound-dai = <&lpass MI2S_PRIMARY>;
-            };
-            codec {
-                sound-dai = <&lpass_codec 0>, <&wcd_codec 0>;
-            };
-        };
-
-        tertiary-dai-link {
-            link-name = "WCD-Capture";
-            cpu {
-                sound-dai = <&lpass MI2S_TERTIARY>;
-            };
-            codec {
-                sound-dai = <&lpass_codec 1>, <&wcd_codec 1>;
-            };
-        };
-    };
-
-  - |
-    #include <dt-bindings/sound/qcom,q6afe.h>
-    #include <dt-bindings/sound/qcom,q6asm.h>
-    sound@7702000 {
-        compatible = "qcom,msm8916-qdsp6-sndcard";
-        reg = <0x07702000 0x4>, <0x07702004 0x4>;
-        reg-names = "mic-iomux", "spkr-iomux";
-
-        model = "msm8916";
-        widgets =
-            "Speaker", "Speaker",
-            "Headphone", "Headphones";
-        pin-switches = "Speaker";
-        audio-routing =
-            "Speaker", "Speaker Amp OUT",
-            "Speaker Amp IN", "HPH_R",
-            "Headphones", "HPH_L",
-            "Headphones", "HPH_R",
-            "AMIC1", "MIC BIAS Internal1",
-            "AMIC2", "MIC BIAS Internal2",
-            "AMIC3", "MIC BIAS Internal3";
-        aux-devs = <&speaker_amp>;
-
-        pinctrl-names = "default", "sleep";
-        pinctrl-0 = <&cdc_pdm_lines_act>;
-        pinctrl-1 = <&cdc_pdm_lines_sus>;
-
-        mm1-dai-link {
-            link-name = "MultiMedia1";
-            cpu {
-                sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA1>;
-            };
-        };
-
-        primary-dai-link {
-            link-name = "Primary MI2S";
-            cpu {
-                sound-dai = <&q6afedai PRIMARY_MI2S_RX>;
-            };
-            platform {
-                sound-dai = <&q6routing>;
-            };
-            codec {
-                sound-dai = <&lpass_codec 0>, <&wcd_codec 0>;
-            };
-        };
-    };
-- 
2.43.0


