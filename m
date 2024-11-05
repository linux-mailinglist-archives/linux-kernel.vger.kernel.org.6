Return-Path: <linux-kernel+bounces-396776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F819BD1CE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C6701C250A3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3241317BB28;
	Tue,  5 Nov 2024 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=remote-tech-co-uk.20230601.gappssmtp.com header.i=@remote-tech-co-uk.20230601.gappssmtp.com header.b="kd7Eg5rb"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C27B16EBE9
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730823059; cv=none; b=Fb+DHUwuxuzqhbI5bONdwRFq6j8c8bIw4NddIvtiweYARrzKfwuURgDPvsbKh0uc+IC66Dt85P2q2Y75MGfDrZUTeBOh1JHG2oJXpqPmEBvUy3Iys3nm2iq4O+G3FTxzgexoWZQe/1LXknglCPliEdD6KVQq7AlPs9Am01RsM8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730823059; c=relaxed/simple;
	bh=w+XHq9w7Bz9O2dHFT5zj8vUvIOCoNUqwqvDDMjf/3u0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jufaFj6xPez/Mp8dX/DX1R3fWzVDQj6K+MTpoJ3M4rbN5aLTneG3shiOy3iDh80t0o+3hpMkmjYHPUZJYy/x0InHX/0RA2bW4qsxPzzc0KffrQqA1ThbZwfhaI/BNIoJhig7aQm9i/6DS6TF517fA1JRdzbJb/tiSjk0lL6wXoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=remote-tech.co.uk; spf=pass smtp.mailfrom=remote-tech.co.uk; dkim=pass (2048-bit key) header.d=remote-tech-co-uk.20230601.gappssmtp.com header.i=@remote-tech-co-uk.20230601.gappssmtp.com header.b=kd7Eg5rb; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=remote-tech.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remote-tech.co.uk
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso86923241fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 08:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=remote-tech-co-uk.20230601.gappssmtp.com; s=20230601; t=1730823056; x=1731427856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zHi7Lp38jT8FmPt7TMK4PF42l87ejDv0GI3ZM6aDB/0=;
        b=kd7Eg5rbYM++BwMbFzFGP0IwFmtKZt82trmlT+ZwCjUSrSPMPG0JgpJ/tTDE8/bq7K
         0V/BE7G8riRYFKe6ePN9oEskDp/hT1jOinXuSPVPxZ871D8CQDlet53uNiHukt3PFoY3
         XmkcgqO9hfqtu3sn/PflqytBd3yHk85UrchONzy7E+NxBSB4U9RkJZgq6O/PCm3kaahb
         Q9YQhg2u8CSF28xFSObEe32WsxbpqDDcIAdMJiBsKdo/qCOGgImiMS9oJ6WsuUg+DBOF
         pM3fKfdPa1QYRh82ZAQz+3kdJeT/1kugUsFBDMrs/2Utk4B68piGQSy5njllGbkjqmV7
         +M8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730823056; x=1731427856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zHi7Lp38jT8FmPt7TMK4PF42l87ejDv0GI3ZM6aDB/0=;
        b=IvhpdkkE5bae92+HIs7VCUSsTNQpco+J3s/TJwSx3eUu3iG5qRVK8NdZjes5PFYQao
         Ct9jd53zf+kBj+nZSfNs/ip39H2Yvx/8V4Jh13rmoFGsOM0MZYaYKvSo52T+StdYwQy6
         AU8Q3MSTb6xTyMNzkDVJtO+Xp+GP0NIlfDjBdfQXPMGIiRfRWYA2e/ym89T/XsknOFg/
         mdOdQIBuhQ+X+hYTx8acr3U2CIKLS+jJzExERCw310AAIeCqTUTTkrZfBUHd7a/qBm3u
         msCTRF4zY2dbsuua2UdSAORSrJJzGhtw/HNjiXcdrgOfAYoTlGe9kgIDtGGjvpki/6tU
         XUrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUdREkBp7sz3PJ7K9oKk+/6BJVfZSweHBlU6AlyxMZE8mVqey/x2KfFeWbjfrfRbhs5qztWJ3FJ1mB668=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCex5ZfvdxUgKTfTyky7vdkT2mbt8DcCQu+/j9/v7oWKVkXaJq
	0/NLagBlmJSm7OIkpkKFPNkYeCUh7loIyT3noTQvXuyXjdVkB3RtJ8l4Qvomq/4rzyYghALNiNg
	kNOradESnKh/H4/1+1kXDrlhR1HTT2HhpEVbWYBKAEdOjpo00W5CN/45Ci2nqO0HGj80mQIZw2u
	HgNUkcRFNdv0NRHUpQOIlplOYka6w=
X-Google-Smtp-Source: AGHT+IHDuD8+xEUGCr7lKtRUPyXfy9Q6dyYFtIlDZz++QeysYZt0+vINN/SdZ6xr3U9/UqhQeiHppg==
X-Received: by 2002:a05:651c:b2b:b0:2fb:3960:9667 with SMTP id 38308e7fff4ca-2fedb7a2aa3mr109659971fa.14.1730823054168;
        Tue, 05 Nov 2024 08:10:54 -0800 (PST)
Received: from localhost.localdomain ([178.27.36.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb17f7928sm151184666b.138.2024.11.05.08.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 08:10:53 -0800 (PST)
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
Subject: [PATCH 2/3] [PATCH v4] dt-bindings: leds: Add LED1202 LED Controller
Date: Tue,  5 Nov 2024 16:10:37 +0000
Message-Id: <20241105161041.4813-2-vicentiu.galanopulo@remote-tech.co.uk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241105161041.4813-1-vicentiu.galanopulo@remote-tech.co.uk>
References: <20241105161041.4813-1-vicentiu.galanopulo@remote-tech.co.uk>
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

v1: https://lore.kernel.org/lkml/ZnCnnQfwuRueCIQ0@admins-Air/T/
v2: https://lore.kernel.org/all/ZniNdGgKyUMV-hjq@admins-Air/T/
v3: https://lore.kernel.org/all/ZniNdGgKyUMV-hjq@admins-Air/T/

Signed-off-by: Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>

---
Changes in v4:
  - remove label property, use devm_led_classdev_register_ext instead
  - use as base patch the v3
Changes in v3:
  - remove active property
Changes in v2:
  - renamed label to remove color from it
  - add color property for each node
  - add function and function-enumerator property for each node
---
 .../devicetree/bindings/leds/st,led1202.yaml  | 132 ++++++++++++++++++
 1 file changed, 132 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/st,led1202.yaml

diff --git a/Documentation/devicetree/bindings/leds/st,led1202.yaml b/Documentation/devicetree/bindings/leds/st,led1202.yaml
new file mode 100644
index 000000000000..7e49e6464d41
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
2.25.1


