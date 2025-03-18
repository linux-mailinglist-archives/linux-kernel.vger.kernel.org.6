Return-Path: <linux-kernel+bounces-565707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79307A66DE0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88A943BD070
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69AA1F585C;
	Tue, 18 Mar 2025 08:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tBHr/43r"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E771F5825
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 08:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742285675; cv=none; b=HAMoe1WHi1IDk7ELbQ5UhgQBcUwGq8UVMy2YAi0CCbksd75ehrd2tS6P/bF+CEtP/67xyVuREvAOQFiLwyW+0kC6oeCZigAzZO3lZOyI+GGtwWWZKNnqbE7E1hkDyeTzw7YHZJ4UFIp3vAc7+zkMgUH5lfRm03OVKwvvkgsFEYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742285675; c=relaxed/simple;
	bh=kpYhAE7uR/Tyni7qReOQZa3rzECUbNHArsrNdvdXEvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R0L5It8+kxPwWR+VF6hqooQC+hXbddxZ71lvUMRfg8BjBoKP2p1xN/AQhGhhpsRGdsp7Iq5SOllHzGkAJZy1s2W3zvvHPIiqF8dC4TttfedCm0XSnmTEMAuxaVJqXxD7JHB/fjrGOhTBBHB0g4RzTAt1xsspmDca1esNj9xk/BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tBHr/43r; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf861f936so4847745e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 01:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742285671; x=1742890471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dLuwN61Q3GRayy8EmdEcIAVdX4Eqmf/jQIyEt+DDRRU=;
        b=tBHr/43rq361eEK/066HrGU1W0onwlp2aIHTueRHTA8ThOUbrn//GfEC7bbSArVSnG
         WSapzCni28jbnLtc2h2q0ACpmV09sLxnE0udnHDadEyPiTdmWPuhFz5VNU9kl2SG1UpF
         mGWhbs4YADTdEKwLTDP8yspn+uEMOAFB3h2rvIodtUd9phfmvAd4yUBoIwFxoiyXDV/4
         eK6VrBLh3Vn/esd2J2HGN7t90FfK1YnTgQcUoN4EvXtLY34UAVYEjDMQVJkxaO6HR2NJ
         1VJiAPTykBpeIwp1wMZgX0SIVG4EOzI4EZNCiMXIyniQjfPrGRpJAYGvp5jP7i8Z6xOu
         DkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742285671; x=1742890471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dLuwN61Q3GRayy8EmdEcIAVdX4Eqmf/jQIyEt+DDRRU=;
        b=lpMm5TyL1pZbxMXbxAqwWs76Fkf1Tsn/ESEC3gCNQTZ2HuIWAE/1LRoKb6v2V0DWRr
         wbYs0itmSuekmRT3XpueD003RoXxBkfmMNyFBURUcjPxsgp1yEaL09sOOpDt8z1Eg94o
         y/wRqyhgemH30FTWOjF6SZQ91kNABIBfwLXpz5uoj4/wz2ikEGo7Xt0il79EXlowncfW
         ZiusW1J426sAw87a114n/8PZo/74pIq/SpODmM8AgRKVX/McScT8Vx+mCbE1ll0nmd6l
         rCO1psv4xeXvYtLabZeeZefxx2CGZNWjNuEfrQFkfvJIT6OkHNElRcSBMchqtf5WrdZv
         h/mA==
X-Forwarded-Encrypted: i=1; AJvYcCWL7Y/orDDo8yuB1WUKjtjS+dTCtVPoHMO9h/TWdknxbSGgU3+wyupZ7NG+3rQBMOeBlVY90+bgWU5PmdU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj8fG0CrI8D1XLAUnIpMhAmg7VUKoARNh2fZ/W0KnnqmBUDz9J
	vc5VKIy/5pQue+GlILd8/FuZpgdPn5ySZZqqHGe51INqrDLrSYkM8zfiGmhLtrI=
X-Gm-Gg: ASbGncvIHdbQYbh0wQqS7gZNkSzT06iLHGfYStGEyEnP6Zoz8c1lnV0qkpNA4hJ3kFm
	L8f+SFI+r/QTVGSR1SLObuv0IG/QyqoCsGrZjjGyMS2DMI+anrqGy6XDhWLSvgLFFxjKkJw7FZe
	trgxQS2pnrEYd1N0mSwrIwGNadziOE3ZKNZsL8K4ftsHPQnlwYlni8Rk4d66rVJ870+4AY6POPm
	51zkwyfKlAbgATiKUhTr8Jiam8VHzgGy3ugtAGnHz01+0lzz8a/RZmgoAHYX6ZDNUbLkw8jzRPt
	vTpg7UmxvgfS8IZrhDwl+V90/zizK4UUfQ6K36ZGhwV7ZyLflC2TlYI5UQ==
X-Google-Smtp-Source: AGHT+IEMC3Xz3WPRUA5+5v3BxRr1IH5qa5tHNG3UyQ7wgUGN37CfqIolgBcAw3SYNFtQ5ny2KkGLCQ==
X-Received: by 2002:a05:6000:18a4:b0:391:2f03:4cb9 with SMTP id ffacd0b85a97d-3971cd57d8emr5941018f8f.1.1742285671341;
        Tue, 18 Mar 2025 01:14:31 -0700 (PDT)
Received: from krzk-bin.. ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c888117csm17114678f8f.44.2025.03.18.01.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 01:14:30 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Davis <afd@ti.com>,
	Artur Rojek <contact@artur-rojek.eu>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Dzmitry Sankouski <dsankouski@gmail.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: power: supply: Correct indentation and style in DTS example
Date: Tue, 18 Mar 2025 09:14:28 +0100
Message-ID: <20250318081428.33979-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DTS example in the bindings should be indented with 2- or 4-spaces and
aligned with opening '- |'. Correct mixtures of the style or any other
indentations to use preferred 4-spaces.

No functional changes here, but saves some comments during reviews
of new patches built on the existing code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/power/supply/bq25980.yaml        | 34 +++++++++----------
 .../power/supply/ingenic,battery.yaml         | 14 ++++----
 .../bindings/power/supply/ltc4162-l.yaml      | 18 +++++-----
 .../bindings/power/supply/maxim,max77705.yaml |  4 +--
 4 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/bq25980.yaml b/Documentation/devicetree/bindings/power/supply/bq25980.yaml
index b70ce8d7f86c..256adbef55eb 100644
--- a/Documentation/devicetree/bindings/power/supply/bq25980.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq25980.yaml
@@ -87,28 +87,28 @@ unevaluatedProperties: false
 examples:
   - |
     bat: battery {
-      compatible = "simple-battery";
-      constant-charge-current-max-microamp = <4000000>;
-      constant-charge-voltage-max-microvolt = <8400000>;
-      precharge-current-microamp = <160000>;
-      charge-term-current-microamp = <160000>;
+        compatible = "simple-battery";
+        constant-charge-current-max-microamp = <4000000>;
+        constant-charge-voltage-max-microvolt = <8400000>;
+        precharge-current-microamp = <160000>;
+        charge-term-current-microamp = <160000>;
     };
     #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     i2c {
-      #address-cells = <1>;
-      #size-cells = <0>;
+        #address-cells = <1>;
+        #size-cells = <0>;
 
-      bq25980: charger@65 {
-          compatible = "ti,bq25980";
-          reg = <0x65>;
-          interrupt-parent = <&gpio1>;
-          interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
-          ti,watchdog-timeout-ms = <0>;
-          ti,sc-ocp-limit-microamp = <2000000>;
-          ti,sc-ovp-limit-microvolt = <17800000>;
-          monitored-battery = <&bat>;
-      };
+        bq25980: charger@65 {
+            compatible = "ti,bq25980";
+            reg = <0x65>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
+            ti,watchdog-timeout-ms = <0>;
+            ti,sc-ocp-limit-microamp = <2000000>;
+            ti,sc-ovp-limit-microvolt = <17800000>;
+            monitored-battery = <&bat>;
+        };
     };
 
 ...
diff --git a/Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml b/Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml
index 741022b4449d..cb04fb25d8ac 100644
--- a/Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml
+++ b/Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml
@@ -48,14 +48,14 @@ examples:
     #include <dt-bindings/iio/adc/ingenic,adc.h>
 
     simple_battery: battery {
-            compatible = "simple-battery";
-            voltage-min-design-microvolt = <3600000>;
-            voltage-max-design-microvolt = <4200000>;
+        compatible = "simple-battery";
+        voltage-min-design-microvolt = <3600000>;
+        voltage-max-design-microvolt = <4200000>;
     };
 
     ingenic-battery {
-            compatible = "ingenic,jz4740-battery";
-            io-channels = <&adc INGENIC_ADC_BATTERY>;
-            io-channel-names = "battery";
-            monitored-battery = <&simple_battery>;
+        compatible = "ingenic,jz4740-battery";
+        io-channels = <&adc INGENIC_ADC_BATTERY>;
+        io-channel-names = "battery";
+        monitored-battery = <&simple_battery>;
     };
diff --git a/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml b/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
index 06595a953659..bc7ed7b22085 100644
--- a/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
+++ b/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
@@ -61,13 +61,13 @@ additionalProperties: false
 examples:
   - |
     i2c {
-      #address-cells = <1>;
-      #size-cells = <0>;
-      charger: battery-charger@68 {
-              compatible = "lltc,ltc4162-l";
-              reg = <0x68>;
-              lltc,rsnsb-micro-ohms = <10000>;
-              lltc,rsnsi-micro-ohms = <16000>;
-              lltc,cell-count = <2>;
-      };
+        #address-cells = <1>;
+        #size-cells = <0>;
+        charger: battery-charger@68 {
+            compatible = "lltc,ltc4162-l";
+            reg = <0x68>;
+            lltc,rsnsb-micro-ohms = <10000>;
+            lltc,rsnsi-micro-ohms = <16000>;
+            lltc,cell-count = <2>;
+        };
     };
diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max77705.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max77705.yaml
index bce7fabbd9d3..e3b84068993b 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max77705.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max77705.yaml
@@ -37,8 +37,8 @@ examples:
     #include <dt-bindings/interrupt-controller/irq.h>
 
     i2c {
-      #address-cells = <1>;
-      #size-cells = <0>;
+        #address-cells = <1>;
+        #size-cells = <0>;
 
         charger@69 {
             compatible = "maxim,max77705-charger";
-- 
2.43.0


