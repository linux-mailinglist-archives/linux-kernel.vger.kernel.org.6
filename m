Return-Path: <linux-kernel+bounces-417242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F36409D511E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 17:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 798101F26B07
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157711AA783;
	Thu, 21 Nov 2024 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=remote-tech-co-uk.20230601.gappssmtp.com header.i=@remote-tech-co-uk.20230601.gappssmtp.com header.b="y3+KSqpn"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674081C4A16
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 16:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732208326; cv=none; b=ICvf5KrdIapT4sRsDMivub5ot9w4V4JAz2WxJvlAAK9fdw8SDI6SMWQ4ErROSk9ifni9+mBfC69rnnwEdhzLHEQx0WuVPwj8Jk1KwKMHQFL7QFf7xH7PyyvvE4tWGbdADBFPWMSzAXymDcjuE5ErEWZgbOxQyK8yT+bxFbXbB+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732208326; c=relaxed/simple;
	bh=/rk98YphhHbe/ZYSTzfJFAmQ84Ek4SJoyxchXfYoArI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OcgaB/udJafbf63ZSvprS4GmpWTtKtjqT4hOUSuCIv6uTpa1JC+q5gnOZ1SAepJCn3Fz+NCmLAKKGbD0ANzSv92IrXfoa3/IXH/KWSJQMMn2YaYaUtodxPgPQfiI40fhQUf8C2fgK2zRm1pdfzphsFDw+Rsw2KnUmI1aqqffqOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=remote-tech.co.uk; spf=pass smtp.mailfrom=remote-tech.co.uk; dkim=pass (2048-bit key) header.d=remote-tech-co-uk.20230601.gappssmtp.com header.i=@remote-tech-co-uk.20230601.gappssmtp.com header.b=y3+KSqpn; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=remote-tech.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remote-tech.co.uk
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cf6f367f97so1497822a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 08:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=remote-tech-co-uk.20230601.gappssmtp.com; s=20230601; t=1732208323; x=1732813123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xjtc7Bjar9DjwKzmJO26f3PuO3HlGp9yAOlHl5sQvtU=;
        b=y3+KSqpnzejBbQJ8bsZ9p+/y/aUgk/jiUKEBzU5/GikkFPj5IdiU8tKg8x4GHLxtq+
         rx0chZSiccV4NhHgcjIFGRzbwW+WQF13bYarB0sHXrnYzGpzD5FfOHTwErjO1Sal1gOJ
         sB5qvgX7QLO0HaiSqqtr5bDgQqWAKrTE6BibS3lj1FjfQ41H0fgx7jYHXAmzRptUhHzc
         HN9JsPPa/9asbP8ICccUv6XWfluSsBk5m4VfNz265X6XuOyH93BVHZbpNDaIkzERPErK
         HnjqkV+I06SMkbK7M4IXM5vZEKyMKH4Uh8As59TGtbJwZH7jJuLXiKYMrkvTYUC98+iq
         Slvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732208323; x=1732813123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xjtc7Bjar9DjwKzmJO26f3PuO3HlGp9yAOlHl5sQvtU=;
        b=UrnoW7B6jxAnB+t4pzFLOs02FdaC4amm3YLJxpjd7RMCz2LVtoeib5/Kq5ZdRl1v3K
         lcrMJ0kVRVACvWzSe6KBFhaLluJDxZA4eNmYnqNPLu92GjrTJK827/0RHWVn3Yu8TkVx
         LGs3EjL/WoQjuGWiyS80YcQnjqS1nLJbGxdOgQq3lqB7aBXunBYfkZAziG6i3R3q3lUQ
         QBSqcmzXIJ9dM+KpkzQ7+gCCj8VljBRGG9CbmgTzdwbuBehhKAWQBGMlLcQvrQ8kZBBq
         7Es6d+y6LfXtaddwwcBrgxUsZl29m/xmmCEsIURfekMDaspiELnA0+WjTIA0kTRD3eJi
         RdrA==
X-Forwarded-Encrypted: i=1; AJvYcCV+fbjgsMAghMDWtFtX0Kqb5AHrFfaJffE06KwSiVQm9NQaOgAgtyXV3CMvDcvuHhxN0A4PSd86yyWcHnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGXLEQknwDAfu25JRaxFku8gb8fJc/DxCq49voma2AQ16DncoB
	wYlKkPDuRVNyRC+J+TOenYXqdpZzOXl9uvMrLBVot7ijc2fNJWSq5gbF7HrdcAw8GSGp6q9Qa1A
	wex3sh+PgFx0bqwwGaZHIW4yfEZh+yzB3htFJofcs+Lcv/VFB6aVLP8dU65/ePq6W4V87I4EyJj
	BroQLe7MtkVsTHH7qE7IcKR1vf0Q0=
X-Gm-Gg: ASbGncuH2ohxh0YJWLFeJFfshSIbtQCRHWzj+jYwVZiBqz6iPQ73BbPIoSzjAKRCJXQ
	+/zyS6d1r8JKSPAFu8S1/UI1HuqTFRHlfrwzP13IRLm0y3ynbdma5SkW8z1ljK/MBStsEyeFp1j
	n0ZnTOUu2n+3k+Yibd0HUWk2qBeCsq9ke8UbnX2sGwQEASCXQnetEoXqXidN30aXTbKhAK/c1Fq
	7QTjwt4QQugpXeIB78bxBbJPvyKR1TtX4uFOgwNQQ6MED4tZpoKPiHJ8h8TA0dlsGWoO+qNM4H7
	qmBUuggwOzntvT1TqFJc
X-Google-Smtp-Source: AGHT+IGLS3KmQ7W38uHkAUt5viZ2Av6E/2C/dV0BXFOoBaL8NmcaVp/OqwnPRW9xtIPS0QThu5bqjw==
X-Received: by 2002:a17:907:97c9:b0:a9a:1792:f1a with SMTP id a640c23a62f3a-aa4dd52c6femr719914166b.7.1732208322610;
        Thu, 21 Nov 2024 08:58:42 -0800 (PST)
Received: from localhost.localdomain ([178.27.36.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f41536d3sm101502766b.24.2024.11.21.08.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 08:58:42 -0800 (PST)
From: Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v9 2/3] dt-bindings: leds: Add LED1202 LED Controller
Date: Thu, 21 Nov 2024 16:58:24 +0000
Message-Id: <20241121165829.8210-3-vicentiu.galanopulo@remote-tech.co.uk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241121165829.8210-1-vicentiu.galanopulo@remote-tech.co.uk>
References: <20241121165829.8210-1-vicentiu.galanopulo@remote-tech.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LED1202 is a 12-channel low quiescent current LED driver with:
  * Supply range from 2.6 V to 5 V
  * 20 mA current capability per channel
  * 1.8 V compatible I2C control interface
  * 8-bit analog dimming individual control
  * 12-bit local PWM resolution
  * 8 programmable patterns

If the led node is present in the controller then the channel is
set to active.

Signed-off-by: Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>
---
v1: https://lore.kernel.org/lkml/ZnCnnQfwuRueCIQ0@admins-Air/T/
v2: https://lore.kernel.org/all/ZniNdGgKyUMV-hjq@admins-Air/T/
v3: https://lore.kernel.org/all/ZniNdGgKyUMV-hjq@admins-Air/T/

Changes in v4:
  - remove label property, use devm_led_classdev_register_ext instead
Changes in v3:
  - remove active property
Changes in v2:
  - renamed label to remove color from it
  - add color property for each node
  - add function and function-enumerator property for each node

 .../devicetree/bindings/leds/st,led1202.yaml  | 132 ++++++++++++++++++
 1 file changed, 132 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/st,led1202.yaml

diff --git a/Documentation/devicetree/bindings/leds/st,led1202.yaml b/Documentation/devicetree/bindings/leds/st,led1202.yaml
new file mode 100644
index 000000000000..f1e5e4efaa3a
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/st,led1202.yaml
@@ -0,0 +1,132 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/st,led1202.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ST LED1202 LED controllers
+
+maintainers:
+  - Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>
+
+description: |
+  The LED1202 is a 12-channel low quiescent current LED controller
+  programmable via I2C; The output current can be adjusted separately
+  for each channel by 8-bit analog and 12-bit digital dimming control.
+  Datasheet available at
+  https://www.st.com/en/power-management/led1202.html
+
+properties:
+  compatible:
+    const: st,led1202
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^led@[0-9a-f]$":
+    type: object
+    $ref: common.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 11
+
+    required:
+      - reg
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        led-controller@58 {
+            compatible = "st,led1202";
+            reg = <0x58>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            led@0 {
+                reg = <0x0>;
+                function = LED_FUNCTION_STATUS;
+                color = <LED_COLOR_ID_RED>;
+                function-enumerator = <1>;
+            };
+
+            led@1 {
+                reg = <0x1>;
+                function = LED_FUNCTION_STATUS;
+                color = <LED_COLOR_ID_GREEN>;
+                function-enumerator = <2>;
+            };
+
+            led@2 {
+                reg = <0x2>;
+                function = LED_FUNCTION_STATUS;
+                color = <LED_COLOR_ID_BLUE>;
+                function-enumerator = <3>;
+            };
+
+            led@3 {
+                reg = <0x3>;
+                function = LED_FUNCTION_STATUS;
+                color = <LED_COLOR_ID_RED>;
+                function-enumerator = <4>;
+            };
+
+            led@4 {
+                reg = <0x4>;
+                function = LED_FUNCTION_STATUS;
+                color = <LED_COLOR_ID_GREEN>;
+                function-enumerator = <5>;
+            };
+
+            led@5 {
+                reg = <0x5>;
+                function = LED_FUNCTION_STATUS;
+                color = <LED_COLOR_ID_BLUE>;
+                function-enumerator = <6>;
+            };
+
+            led@6 {
+                reg = <0x6>;
+                function = LED_FUNCTION_STATUS;
+                color = <LED_COLOR_ID_RED>;
+                function-enumerator = <7>;
+            };
+
+            led@7 {
+                reg = <0x7>;
+                function = LED_FUNCTION_STATUS;
+                color = <LED_COLOR_ID_GREEN>;
+                function-enumerator = <8>;
+            };
+
+            led@8 {
+                reg = <0x8>;
+                function = LED_FUNCTION_STATUS;
+                color = <LED_COLOR_ID_BLUE>;
+                function-enumerator = <9>;
+            };
+        };
+    };
+...
-- 
2.39.3 (Apple Git-145)


