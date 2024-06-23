Return-Path: <linux-kernel+bounces-226439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F433913E62
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 23:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A0B1F214AE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 21:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D4E1850AA;
	Sun, 23 Jun 2024 21:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=remote-tech-co-uk.20230601.gappssmtp.com header.i=@remote-tech-co-uk.20230601.gappssmtp.com header.b="EM7LF2Hy"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3B0185096
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 21:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719176575; cv=none; b=ayCUzy1sQK/dv4in7PbVegLF4EjsW96RqlOB021qOed00AboIScyo5UzRLzZe1KnvXha/ivcW+u45v4R9HyBieVZBvQAvQKOjQ32t2ZlRbPuRJ+HTOL4xrxK/MYXI1VwPw71iz99c41q+lMrqW+QVFCBDhbypr72dpphyEJxr/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719176575; c=relaxed/simple;
	bh=GfEULV8xg05kdiKK5i743yh7W6tqQppAzpgm/RtrSIY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VBPkkhGPtW9JNG4zcR252VqJQr1P5oeqYOXSw6VF+LLeVO6tHmilSnEqvboJ0m3uI0HPartcmtxYZzwMiDm9cczqIE1HKsmGAvAHX2qJHWfw/EH14fHbr+yx4pDzCRKXo/39vah+j7F3Tct7Xj4sgYRrR5VHUXTTFTZIfn9dFmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=remote-tech.co.uk; spf=pass smtp.mailfrom=remote-tech.co.uk; dkim=pass (2048-bit key) header.d=remote-tech-co-uk.20230601.gappssmtp.com header.i=@remote-tech-co-uk.20230601.gappssmtp.com header.b=EM7LF2Hy; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=remote-tech.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remote-tech.co.uk
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7194ce90afso121409566b.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 14:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=remote-tech-co-uk.20230601.gappssmtp.com; s=20230601; t=1719176572; x=1719781372; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C2Q0gzBX8N6IydgITDvhPFm9H0OdZ97AsakiB5jkxqY=;
        b=EM7LF2HyE0z2QIEvcoWOnWoRAdnzI/dk/0go0RIt2V0bKmxktcRFgkB6tAJVWXr05E
         pUbr0G2rZYSa21RRiFAo90V7WYhHpRqAmFe1+/AtwAPTmDhZQR9dLGy4Z1fr3kr8qLLv
         f9L2t/kAnPDqmoX4J7xXmVUPnBkNgI0S1R+TSSie2KT/erMjaLWq7+AQyHklg0Alaz1M
         r4IaenwBJNjMrU0MO09FfXU4F8EGY/b8gg5GK6XjgCIgkdLjgUrbMPVEmS9ImFnx0j4v
         Ybus96wGNoUWXI/ofuh4KameoK5cAZrtDnmnRNKqo/QlPO4zXLMG0xRko7fZJ+oFujz1
         3HMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719176572; x=1719781372;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C2Q0gzBX8N6IydgITDvhPFm9H0OdZ97AsakiB5jkxqY=;
        b=HhB0KLvGMJjAWTqtXYNl3/sZlGOny3i+d1lHUqqnWkgLs/sOdVu/Q71gU8uqof8h5x
         MlkLFKLXWHgECQWGstXxb22cAedU+whRoRWj055uvkdXyn94oqI53238CgULDpRjBCdA
         nbKvDgKJe/ogEphZ98IDxzamjUCLhqw+lhVYMETUYA5c+V41cfpo79vD9WSMc5DQhROj
         O1NHO/vwFqBg1zqrXfPxH7WfeVbmApzWnreZonnpbT3E+WfyijX9V43t3AzEASvIK9bc
         FJLXGPNkY388Vq111zUc0z4SmCouXG7syc2eVNjGjx05JLhUPfZYD+YRgpmgyjViAGkT
         kmVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUnKjWETGfw00OZm/T2X39tph4jM3XUB37xIiv9OJ6KFQwbyXqZo3Mrgxe3yd+sVK6THo+KAt1MZlots8nTrlLhLDaXblwsE5jitOn
X-Gm-Message-State: AOJu0YxAscbIesXuXMmoI3Il3pdzrG6R8tHRzRBwlgMBS3RB3+g1E3L0
	C2oup8blmy4PiRm3dis5/PXLYu6UawgfSH+zKN0jGVst5i0tKQh3aJ4zVNa6KSxdF55Gwx1Jtkc
	VYWtU76JcW5C9dPUqBeiRSSNpKStfB3OKVt7G9hbIUk//UbroFaTkgAoFCy9TN7zPTfJOp/Nnzw
	53m+duNuXZArEz1znTan+dWLJhSMA=
X-Google-Smtp-Source: AGHT+IF6p6PrkBM7MCMqt0fhnpDs3/s2Ek1MKMe2Imaunb9Q4Quj0feu3pVgyqYTcpGn2NnWhpxbeA==
X-Received: by 2002:a17:907:198e:b0:a72:5644:b7d5 with SMTP id a640c23a62f3a-a725644b98dmr26112066b.11.1719176572022;
        Sun, 23 Jun 2024 14:02:52 -0700 (PDT)
Received: from admins-Air ([2a02:810d:aec0:2a54:e986:e9a5:7c6a:4f75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf560de1sm338881166b.186.2024.06.23.14.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 14:02:51 -0700 (PDT)
Date: Sun, 23 Jun 2024 23:02:44 +0200
From: Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>
To: pavel@ucw.cz, lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: leds: Add LED1202 LED Controller
Message-ID: <ZniNdGgKyUMV-hjq@admins-Air>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The LED1202 is a 12-channel low quiescent current LED driver with:
  * Supply range from 2.6 V to 5 V
  * 20 mA current capability per channel
  * 1.8 V compatible I2C control interface
  * 8-bit analog dimming individual control
  * 12-bit local PWM resolution
  * 8 programmable patterns

Signed-off-by: Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>
---

Changes in v2:
  - renamed label to remove color from it
  - add color property for each node
  - add function and function-enumerator property for each node

 .../devicetree/bindings/leds/st,led1202.yml   | 162 ++++++++++++++++++
 1 file changed, 162 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/st,led1202.yml

diff --git a/Documentation/devicetree/bindings/leds/st,led1202.yml b/Documentation/devicetree/bindings/leds/st,led1202.yml
new file mode 100644
index 000000000000..1484b09c8eeb
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/st,led1202.yml
@@ -0,0 +1,162 @@
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
+description:
+  The LED1202 is a 12-channel low quiescent current LED controller
+  programmable via I2C; The output current can be adjusted separately
+  for each channel by 8-bit analog and 12-bit digital dimming control.
+
+  Datasheet available at
+  https://www.st.com/en/power-management/led1202.html
+
+properties:
+  compatible:
+    enum:
+      - st,led1202
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
+  "^led@[0-9a-f]+$":
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
+            address-cells = <1>;
+            size-cells = <0>;
+
+            led@0 {
+                reg = <0>;
+                label = "led1";
+                function = LED_FUNCTION_STATUS;
+                color = <LED_COLOR_ID_RED>;
+                function-enumerator = <1>;
+                active = <1>;
+            };
+
+            led@1 {
+                reg = <1>;
+                label = "led2";
+                function = LED_FUNCTION_STATUS;
+                color = <LED_COLOR_ID_GREEN>;
+                function-enumerator = <2>;
+                active = <1>;
+            };
+
+            led@2 {
+                reg = <2>;
+                label = "led3";
+                function = LED_FUNCTION_STATUS;
+                color = <LED_COLOR_ID_BLUE>;
+                function-enumerator = <3>;
+                active = <1>;
+            };
+
+            led@3 {
+                reg = <3>;
+                label = "led4";
+                function = LED_FUNCTION_STATUS;
+                color = <LED_COLOR_ID_RED>;
+                function-enumerator = <4>;
+                active = <1>;
+            };
+
+            led@4 {
+                reg = <4>;
+                label = "led5";
+                function = LED_FUNCTION_STATUS;
+                color = <LED_COLOR_ID_GREEN>;
+                function-enumerator = <5>;
+                active = <1>;
+            };
+
+            led@5 {
+                reg = <5>;
+                label = "led6";
+                function = LED_FUNCTION_STATUS;
+                color = <LED_COLOR_ID_BLUE>;
+                function-enumerator = <6>;
+                active = <1>;
+            };
+
+            led@6 {
+                reg = <6>;
+                label = "led7";
+                function = LED_FUNCTION_STATUS;
+                color = <LED_COLOR_ID_RED>;
+                function-enumerator = <7>;
+                active = <1>;
+            };
+
+            led@7 {
+                reg = <7>;
+                label = "led8";
+                function = LED_FUNCTION_STATUS;
+                color = <LED_COLOR_ID_GREEN>;
+                function-enumerator = <8>;
+                active = <1>;
+            };
+
+            led@8 {
+                reg = <8>;
+                label = "led9";
+                function = LED_FUNCTION_STATUS;
+                color = <LED_COLOR_ID_BLUE>;
+                function-enumerator = <9>;
+                active = <1>;
+            };
+
+            led@9 {
+                reg = <9>;
+                active = <0>;
+            };
+
+            led@a {
+                reg = <10>;
+                active = <0>;
+            };
+
+            led@b {
+                reg = <11>;
+                active = <0>;
+            };
+        };
+    };
+
+...
-- 
2.39.3 (Apple Git-145)


