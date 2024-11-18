Return-Path: <linux-kernel+bounces-413112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 248909D13BA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAB221F2334A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6D71B6D08;
	Mon, 18 Nov 2024 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=remote-tech-co-uk.20230601.gappssmtp.com header.i=@remote-tech-co-uk.20230601.gappssmtp.com header.b="fGvIvmss"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6771B6D0D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731941706; cv=none; b=pC3rH3x6OdyP4jnQJs5dm3LyZ7lrgW/4+JyATgYjW30Z4JINixRsJqXxAv1/a+h0b4Pd5xh+5rxarqFfE3sB6vwHDhB7I6ZPQOJhw5Tai/omzmIr5UDN3ztbwHojwrmTmdNFX3bgOr4RrN+ku5DqdXfEKICe5SFzFLr0ivJbgZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731941706; c=relaxed/simple;
	bh=dv2/+Rc9yxwcZ2ND2dAyftrng/AjLfmMhWY48feSw7c=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IuxdXHwB//WnMxnTBkBkyzK8t5cYLeHcktyLrWJR8nkS70cbkUJnSCNfxeh0gJjhYIKj6U+BqQBJtswJjjEEHKS9R1xtfwiMF12y9v1DtC/1Y82BqkMS3azZTuviCkrBZhHygCHGO79KYvEWGUrxiSk5A0usdsGSCn5+Z72PSbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=remote-tech.co.uk; spf=pass smtp.mailfrom=remote-tech.co.uk; dkim=pass (2048-bit key) header.d=remote-tech-co-uk.20230601.gappssmtp.com header.i=@remote-tech-co-uk.20230601.gappssmtp.com header.b=fGvIvmss; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=remote-tech.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remote-tech.co.uk
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c9c28c1ecbso6135648a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 06:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=remote-tech-co-uk.20230601.gappssmtp.com; s=20230601; t=1731941703; x=1732546503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HDksoDp0rwZZvhM7tfWOTul1zfu84mkjAf3xJn2pMg8=;
        b=fGvIvmssmzboydxCuDt04lVh1xlmklOQlJivFCKjbCUNRR15kwabjQ6iYceWlKardT
         Rm+IUDsMADTPg9Pe22xTWb4vyTfohkSFUBDRUDq3e7pXpi/aeUktgKwMxVyqjCIKJGhk
         5P5wb7PRsXt99rQ4uhExXiM/GwGFMnuhq6wt7pKhGHJ5x5QRnJUBp1XzF+oeEMEqiVNg
         5tyixfTH1D4Vs3NSyP0w7gy6sR7f2/xY1cghLypkRxmNPe253tqXoJqecdyL4HmS48Kx
         m0JNUUKFMf7FnL+Yajk/OuUMm82CPAbxaG+NNAtclYf0UV2rpPs4/2QXjHziDIzWEbTD
         S0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731941703; x=1732546503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDksoDp0rwZZvhM7tfWOTul1zfu84mkjAf3xJn2pMg8=;
        b=YI8pc9/HHZ9SFk01vWNG8W1Q1kiJifHXLYaWF9ZsV/VYJASIcUHGx55MpPE5DiU4Pv
         TpfIXASWvdL6c3Nuqj/2zVHCo1QCM9owgyo75usHYqNt/XRy29d21lN4fKaXLi4IczwK
         aXfVNmutM3VSkIYSZdIjvA0tKAGsAsd/fs47rUfvtZuj4YxQQXZ6ObrKs+N7RAaTZmYz
         StX4KOXptluVCwaY8gafaQ9l5QRVs9c4gM7xQNpnbWi0OLo1HQ7sIcM7t0IBHQZzyYuA
         1Olke/MdK8FYDzYz0DGIShuKU1IEQWWEgFV60Cj96RZxBdrGG3nPkYXN9UBRVqiD8dzl
         tIOw==
X-Forwarded-Encrypted: i=1; AJvYcCVFknbsRS/q1B6CtXY1ukcNKgDP5ze2AM/dFEFALcKeArpzQjv4iJl0oLdT+00CON3vcJXaT7YlyJTQNXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt86Tx4vpfDnkO4nAN43eUcV/Sy66tZ/kwRmmitxpvaGBrzKb5
	9khwYty4MisGzsZhsBLbaooLdYkdy7xL8C6gU9YYrx2Q8LwVyla15CLRdjn0HKh2Z+U5k/qqYmp
	m9mqtu10O4rQrEJPuD3/0tdlLr2WMoFRZ0FD4zdEhKhiwvLreFNEUI0YpX9iyBQEoObz891QTwN
	VknkEOjnufDjd4w0wBTWfoi7UwmvU=
X-Google-Smtp-Source: AGHT+IEw/8Rd958gcjQ3nia1tg5M9oS0PLVfT7Ts7ZiqMxu69u1ESP6k5StqjkwwG6LrEz5Pxdj+hg==
X-Received: by 2002:a17:907:1c29:b0:a9e:df65:3a81 with SMTP id a640c23a62f3a-aa483554f81mr886273566b.59.1731941702918;
        Mon, 18 Nov 2024 06:55:02 -0800 (PST)
Received: from localhost.localdomain ([178.27.36.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df1b642sm546125666b.40.2024.11.18.06.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 06:55:01 -0800 (PST)
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
Subject: [PATCH v7 2/3] dt-bindings: leds: Add LED1202 LED Controller
Date: Mon, 18 Nov 2024 14:54:44 +0000
Message-Id: <20241118145449.7370-3-vicentiu.galanopulo@remote-tech.co.uk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241118145449.7370-1-vicentiu.galanopulo@remote-tech.co.uk>
References: <20241118145449.7370-1-vicentiu.galanopulo@remote-tech.co.uk>
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


