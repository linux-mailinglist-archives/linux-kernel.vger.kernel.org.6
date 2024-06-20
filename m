Return-Path: <linux-kernel+bounces-222379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F7691008A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 781141C2171C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B897F1A8C22;
	Thu, 20 Jun 2024 09:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KE13Pvu3"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC86B47772
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 09:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718876408; cv=none; b=QoNaiSwKwQSeZu9GO8ZZ8Fn4455XB2sIpbSWheccSz65a+8qQe4O6x2ySkCqv3YyYp/34WSMSc3hk7Ohen8FQaXBCYsLxv8One2mYEvnVjAgwJ4jL1DN0TtugEKu1dJKRwL4yj9itS0qxu1E6wi1aX7jfP96T4nBSjkpU5hG884=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718876408; c=relaxed/simple;
	bh=Dt9pPhUPKxY49NTj7PYxkDDnTHGBCFbjM6B6CNFCAiM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h4XJ8Q1ptzlyyb0MeUX/INarxV32NBoKTqaOgipfTxHz08dActtokGa70xoKgS95i3BogT8R89Nfxkf6NrJFZziMyYJ13UmPkCXD3JTr0HaRklax7tzrit+lsEKlQuXQAh/STBwybk71G5jjlZ72ieVoQt3Xz/ZQ7QdxMkyGZ/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KE13Pvu3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42198492353so6937645e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 02:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718876403; x=1719481203; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1eoyKMeKwORnjXrfh8fRmcKanMlp49yxm/SsNRMKvko=;
        b=KE13Pvu3l12aL4gwxqzsoza+yc1PRJ9V4u39u52bWmSwZZctg4r1PFU92MLTF1zkNh
         dhxuI4f+haTwVRmQpTyxxiXZHTnu1T52xuQzqGBGqljZ8GEtcaAS6ug31DIRcq5JKf1a
         J/mvPnQwakF2H2X1X8Ys9PyanZd7fd7ogMUKoWLe1zFGG7dUc6ndpXbUcNMdsEqCn/T5
         kSy0mc74tGKPUM8ZlgYPmO0PrypgG7tqU3V0GaKFNSt5zgIKa2H582yM24CP+RP6jWGn
         lI6Lom0sP0ojNYG/q+V7nrZ/qv4DW7aDBtNBslGDY9jCWGWfi3f4cp5eqduUtxzvrXU9
         Jmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718876403; x=1719481203;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1eoyKMeKwORnjXrfh8fRmcKanMlp49yxm/SsNRMKvko=;
        b=xMw1ANO65ZeOicBWv+3Qf2EaQa3EEoAKWroVoOx3A/elINY5qaAKlAZ+CIF0fB2jbY
         l0XTEp/mYG688GIDxTe3F193XFSKQx0b6FICBMZT7hCO2/tBd+T2EV7qa1dQO41bQrTz
         WaiExPew/R9azA0iHU1yyN9EhjQmTMpTecFFHZQ4P+gFTGY7Obx0kln7FNbbaRK0j2e2
         cA8fymuTGDatticaJppXEqI8xRM8LWn+9+lNngjtbVEc4Z2/rUeo0LaslT5TrJuGhpFO
         Ff45fdamdgsBjB6USOn2ZW1/oeWt3rGeqgSFoPOp7NVSkB3Rx15MdcQYbIxy+AOpMF9f
         tF8A==
X-Forwarded-Encrypted: i=1; AJvYcCVJU0hKYvqWGeyjXfgbuX16b+yUfoCAM88mZRQAVrPmNqaWliiHueRopwl2KrLfH9huiooG1sJRT8KeSbBPpG2Pm5vteWewX/gh+mc6
X-Gm-Message-State: AOJu0YxB/6iQoB2c8nRzvOFXbZBK6pesBxDD4aqnf5YY5igJ5+/N+vm3
	yDfVZedYwbbG4PNQXCVOxUvwRrkFV5NK0feS976D4WKmOBDvHLyvLIFbN0xBazM=
X-Google-Smtp-Source: AGHT+IFDJlM479D2ow1xuBjPiaCS8XgHSUUVM8IEoVkLP3TsnYi7kngOy9GAbZDMsF3Dc3VZbJbjvw==
X-Received: by 2002:a05:600c:4999:b0:422:4fcd:d4b9 with SMTP id 5b1f17b1804b1-42475297a99mr34223535e9.29.1718876403164;
        Thu, 20 Jun 2024 02:40:03 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d211ae0sm19366095e9.41.2024.06.20.02.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 02:40:02 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 20 Jun 2024 11:39:58 +0200
Subject: [PATCH v2 2/2] ASoC: dt-bindings: convert everest,es7134.txt to
 dt-schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-topic-amlogic-upstream-bindings-convert-everest-v2-2-660985615522@linaro.org>
References: <20240620-topic-amlogic-upstream-bindings-convert-everest-v2-0-660985615522@linaro.org>
In-Reply-To: <20240620-topic-amlogic-upstream-bindings-convert-everest-v2-0-660985615522@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2687;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Dt9pPhUPKxY49NTj7PYxkDDnTHGBCFbjM6B6CNFCAiM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmc/juS/ZiY6C79JWMKeEjMvnvKqkxo+frglHe7jEy
 BNabhHOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZnP47gAKCRB33NvayMhJ0XkPD/
 9rBxrmrn4vIR3SwOwviZZesq/gdjryZkvsSTmtlO1OqgBgn3dG7HT2soideZLUMeW/6cybHrS9QdI8
 p3xyBrlQn8Wmuw5j6Ez0k7TCrVsKalJABR0Uls36chUlM6fa4YozeKZ4U6heu8U4zEjk0pXeIuca5E
 JAgeTdfVhPtPTSR6PUPmViDzpRbhbpTzHbuEfVGuBMTkmGLIERk6JYgFk5bzWMqDGD84HHlNdZp4kQ
 bbt/o6u04i19PXeKCVAjWgVFGsbkgCFLbevzK4TnPFUNNuHfUh0qYJ3fZ8WJfOn4blmB/s5VEyeQ74
 oos6ShGSMWpDBraiOtAuhvrI0mr7xV4UpwfOW94FKbNqx4hYYZ4C0JTL1iM2+wHFBRP7Anm0lvHXvu
 uBFzemAD9wVw+wswOgPQaRJBOrMyP8Rgc5Z4dgxyZ/PqNafCI0IAc1MOdfzjRPFNQZ5kkM/Kh0CZX9
 xCMDbD6oLoiACwubxgYXCZWngQ3HYI4ny38HGuEMvvPjZZ6Yg2aYmvkKU40fIx2JT9pyu4+8o+T4Gh
 3U/Weg23DYh2tNHjHI+qBaMTALwa5kQC4uT2yD0tJEEUNaH5oi3Cpim5dikWXCoCGBvaO8hn6+9ZOR
 n100tO79w5h3WF4i52DTRIvqFR1/dA+gAXaWJOM9BTOhe6bKtZWmR3OzZ6gg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Convert the text bindings of the Everest ES7134/7144/7154 2 channels
I2S analog to digital converter to dt-schema.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/sound/everest,es7134.txt   | 15 ------
 .../devicetree/bindings/sound/everest,es71x4.yaml  | 62 ++++++++++++++++++++++
 2 files changed, 62 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/everest,es7134.txt b/Documentation/devicetree/bindings/sound/everest,es7134.txt
deleted file mode 100644
index 091666069bde..000000000000
--- a/Documentation/devicetree/bindings/sound/everest,es7134.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-ES7134 i2s DA converter
-
-Required properties:
-- compatible : "everest,es7134" or
-               "everest,es7144" or
-	       "everest,es7154"
-- VDD-supply : regulator phandle for the VDD supply
-- PVDD-supply: regulator phandle for the PVDD supply for the es7154
-
-Example:
-
-i2s_codec: external-codec {
-	compatible = "everest,es7134";
-	VDD-supply = <&vcc_5v>;
-};
diff --git a/Documentation/devicetree/bindings/sound/everest,es71x4.yaml b/Documentation/devicetree/bindings/sound/everest,es71x4.yaml
new file mode 100644
index 000000000000..fd1b32812228
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/everest,es71x4.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/everest,es71x4.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Everest ES7134/7144/7154 2 channels I2S analog to digital converter
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+properties:
+  compatible:
+    enum:
+      - everest,es7134
+      - everest,es7144
+      - everest,es7154
+
+  VDD-supply: true
+  PVDD-supply: true
+
+  '#sound-dai-cells':
+    const: 0
+
+required:
+  - compatible
+  - VDD-supply
+
+allOf:
+  - $ref: dai-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - everest,es7134
+              - everest,es7144
+    then:
+      properties:
+        PVDD-supply: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - everest,es7154
+    then:
+      required:
+        - PVDD-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+   codec {
+       compatible = "everest,es7134";
+       #sound-dai-cells = <0>;
+       VDD-supply = <&vdd_supply>;
+   };
+
+...

-- 
2.34.1


