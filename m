Return-Path: <linux-kernel+bounces-202910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4508FD2DC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D67F1C223E9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C0A152DEB;
	Wed,  5 Jun 2024 16:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z6kcO2H2"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234AA61FD6
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 16:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717604626; cv=none; b=XvyBY4wM2w4OmP7KRnTp6OGIPpux8j9fFqeVygJN+hOy+Q4F7SzVf6cwZ8CYuXhpUaFF3bN77oVU/xwIP4YvPisz0UnBEZ/0eYCEysJaEYUYYqcHOYwmTjkVq/H2n+LJAxhFJWf6DuLmwU2KC6zsGL6gF++wYYxDvUCPLrMkUbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717604626; c=relaxed/simple;
	bh=Kh6qdgD8gN3kAFOnYgqdARfzmUnV4nBrhS9jybICIxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Zup0d68kKMfkGjrIwp7H2oLsEId3PJezR3t0f7PVrNjbpm8HSCN48wxay/224/BS5bJ8pDBnL4YJ/MgrURIDZopUhwHq0l+jXI4JeaLHRp508qJhLbEQU36QQ0czN8sy5qfjRitciO2mybbG1/oCYs8TZJSF1QpW9J1HuQ89I90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z6kcO2H2; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42155e7084cso210395e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 09:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717604623; x=1718209423; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gHdEt550F1bEVRbDb46OyuzqxvV/QnpebMYwJjNOjY4=;
        b=z6kcO2H2vMsYYkOP3MJPNHM0rgTRJl5i4rn5k6ATTrZPYBwu4zojI2v1GnByrJmYwU
         JiRJEJ8+ocqSlZoWoVwdzIwRmSRfbBk1FU0KO0aLKm86IQdMB8RKWkih66DEWmpmjMTJ
         2AyMcZHTQrQIouc2JZ+88bhdlZfmOMATW680W+8ncPaWaD2kWaAhbkSf75tOa6z27RAg
         BnT94bZ5L4ixiJZk3PwCtYt0tvoVeELWQTpdxL7hW32NPxP1MeEv5qjYdbOozFLGO8+u
         FN8bTdjfo0v+IDNvne7nJmIuGoOviZ/VyhGdHkfDVbnuhen8BCurkVdliIkNiAvuycpw
         I55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717604623; x=1718209423;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gHdEt550F1bEVRbDb46OyuzqxvV/QnpebMYwJjNOjY4=;
        b=stu1H/9j1p6CVWsjJqyM8QotkTVK9U08eHmu38Pk+J+GN88MFNpraChgtDt6uMFiFV
         H7pKvrxAzLsU6Oy5kW4S8JQ/8dCdkFrtBhZ1LvpouKdNz0aGA1ft8Otz4HfZicLa4WU+
         57U29ylw5wb0gkAmfSNn6XkBy+v99fH+nytOxosKgLlmWtOJ8a9ihHpoij1qmA8kIidJ
         LXNaK9UuT73yuVayzwSvjwFNh5JNd7Iy3HYxnc63vkdnarM+JCaeonVJ9yaHnJj4jJh1
         wN4L3lhAl02kKO3hpTDxk/Nn9saORvGYLIcVuQ1webdYYwe7UtjuvgCvFRiyCwj6tmAG
         BRxw==
X-Forwarded-Encrypted: i=1; AJvYcCXpLfyjYdmKCf0W4fsV8EPN60IlKRT5vPlneJdAjsxM/FeI/uZ0ZtYBM5dydERhc2UjPn5bHUTN1pRCEKKm0/k38ZF365Aol6Fh9Q44
X-Gm-Message-State: AOJu0YzeJt3uHMqCGkHkQz3mXPApQeKAOPl/DCsheY1d9tz+/4etjGQk
	9a+k947lz81YXbxRIhcG7C1tDpJnG8JClU2K4DV2H3TqvCv/zAiGtg7aQNA+sh4=
X-Google-Smtp-Source: AGHT+IF1O2G99r4xRgtljG98+ucYesGFfJbY7KI63jODvWrBBCVZMWvqxSh7GcUBaF2AJhCDveDj+w==
X-Received: by 2002:a05:600c:4212:b0:421:5609:115d with SMTP id 5b1f17b1804b1-42156355b00mr22614075e9.41.1717604623476;
        Wed, 05 Jun 2024 09:23:43 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421581016e0sm28191635e9.9.2024.06.05.09.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 09:23:43 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 05 Jun 2024 18:23:42 +0200
Subject: [PATCH] ASoC: dt-binding: convert amlogic,g12a-tohdmitx to
 dt-schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-topic-amlogic-upstream-bindings-convert-g12a-tohdmitx-v1-1-b851c195e241@linaro.org>
X-B4-Tracking: v=1; b=H4sIAA2RYGYC/x2NywrDIBBFfyXMugMqNdj+SunC6sQM1AdqQyDk3
 ytZHQ4c7j2gUWVq8JwOqLRx45yGyNsEbrUpELIfDkqou5iFxp4LO7Txm8Pgr7ReyUb8cPKcQkO
 X00a1Y5DKjnj1kfuO3mjx0GaW3hgY26XSwvv1+3qf5x8dr8+YhwAAAA==
To: Jerome Brunet <jbrunet@baylibre.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3588;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Kh6qdgD8gN3kAFOnYgqdARfzmUnV4nBrhS9jybICIxU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmYJEO8xzG0MMshcpkcqCqBsYFkiu8m34xyUH6ua1c
 bNJ27u6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZmCRDgAKCRB33NvayMhJ0ZtQEA
 DO/VXqjr5leAf37OKLLcpq0P8pr5p2aYKq9yRyRGGp4k7bDR1s095+LdF/r63uDB5HQzmGu0Nbn3JI
 bRXRdpXjU7uJvUs850YRL4hh0TLLlQigv/gDWY7JvyGXSS80EGUcsLBhd2ppf9DyFaviGOzDRCwPPI
 LIjPm1pYNw/LLweXvwhAnaw70MOhzeM6AB9CcP2jzWdA+YsFEBJqW8wnZWVN4h202S/YNvKxCC6pKd
 v6fyU4MG0JSCNNUFqm9zlI4ueEiL24Bq19lzzkIUp6AKj61/DeAI9dXYHudrzoID0CrmJb/r0dU6uA
 5E+zh1jU4SKJLntVJ9YpMeHD5DhBovYN4jjDp8gS96BFQdIu87Kj0btTJSnCAZLX9k51GPQrEjaJPf
 uCYnjxjPwSh9aP7Sw9vX0x+IZF8SPdlYraRTFBy8sut3gbGVHGB6UWONPVPycNKDuDMhUqySYw8QUd
 Km8HYwcSUsJCkqkfpxBYwyZUt25AAsuSmZWOVYk5YZDB4g/R0oqjHUil2BwkWyuIVDbrYtv+AI+fWH
 JNtNbSs9Zs7nDl1aH3plyRyiMS11OUa+wmMnjfFdnVhWhPXwAgVlQg/Xz2hljMxcWiqUjFLNLR6X3J
 yNgT+BW9wWwOqjlLc7AxcRv8KYQOIuD+X+4k3bixrCFyVSgPWg9Bzwt9HgxA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Convert text bindings to dt-schema format for the Amlogic TX HDMI
control glue.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/sound/amlogic,g12a-tohdmitx.txt       | 58 ----------------------
 .../bindings/sound/amlogic,g12a-tohdmitx.yaml      | 56 +++++++++++++++++++++
 2 files changed, 56 insertions(+), 58 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/amlogic,g12a-tohdmitx.txt b/Documentation/devicetree/bindings/sound/amlogic,g12a-tohdmitx.txt
deleted file mode 100644
index 4e8cd7eb7cec..000000000000
--- a/Documentation/devicetree/bindings/sound/amlogic,g12a-tohdmitx.txt
+++ /dev/null
@@ -1,58 +0,0 @@
-* Amlogic HDMI Tx control glue
-
-Required properties:
-- compatible: "amlogic,g12a-tohdmitx" or
-	      "amlogic,sm1-tohdmitx"
-- reg: physical base address of the controller and length of memory
-       mapped region.
-- #sound-dai-cells: should be 1.
-- resets: phandle to the dedicated reset line of the hdmitx glue.
-
-Example on the S905X2 SoC:
-
-tohdmitx: audio-controller@744 {
-	compatible = "amlogic,g12a-tohdmitx";
-	reg = <0x0 0x744 0x0 0x4>;
-	#sound-dai-cells = <1>;
-	resets = <&clkc_audio AUD_RESET_TOHDMITX>;
-};
-
-Example of an 'amlogic,axg-sound-card':
-
-sound {
-	compatible = "amlogic,axg-sound-card";
-
-[...]
-
-	dai-link-x {
-		sound-dai = <&tdmif_a>;
-		dai-format = "i2s";
-		dai-tdm-slot-tx-mask-0 = <1 1>;
-
-		codec-0 {
-			sound-dai = <&tohdmitx TOHDMITX_I2S_IN_A>;
-		};
-
-		codec-1 {
-			sound-dai = <&external_dac>;
-		};
-	};
-
-	dai-link-y {
-		sound-dai = <&tdmif_c>;
-		dai-format = "i2s";
-		dai-tdm-slot-tx-mask-0 = <1 1>;
-
-		codec {
-			sound-dai = <&tohdmitx TOHDMITX_I2S_IN_C>;
-		};
-	};
-
-	dai-link-z {
-		sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
-
-		codec {
-			sound-dai = <&hdmi_tx>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/sound/amlogic,g12a-tohdmitx.yaml b/Documentation/devicetree/bindings/sound/amlogic,g12a-tohdmitx.yaml
new file mode 100644
index 000000000000..34e9de1366f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,g12a-tohdmitx.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/amlogic,g12a-tohdmitx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic G12a HDMI TX Control Glue
+
+maintainers:
+  - Jerome Brunet <jbrunet@baylibre.com>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  $nodename:
+    pattern: "^audio-controller@.*"
+
+  "#sound-dai-cells":
+    const: 1
+
+  compatible:
+    oneOf:
+      - items:
+          - const: amlogic,g12a-tohdmitx
+      - items:
+          - enum:
+              - amlogic,sm1-tohdmitx
+          - const: amlogic,g12a-tohdmitx
+
+  reg:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  sound-name-prefix: true
+
+required:
+  - "#sound-dai-cells"
+  - compatible
+  - reg
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/reset/amlogic,meson-g12a-audio-reset.h>
+
+    tohdmitx: audio-controller@744 {
+        compatible = "amlogic,g12a-tohdmitx";
+        reg = <0x744 0x4>;
+        #sound-dai-cells = <1>;
+        resets = <&clkc_audio AUD_RESET_TOHDMITX>;
+    };

---
base-commit: c3f38fa61af77b49866b006939479069cd451173
change-id: 20240605-topic-amlogic-upstream-bindings-convert-g12a-tohdmitx-d85095861d88

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


