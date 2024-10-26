Return-Path: <linux-kernel+bounces-383225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A599B18AF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 16:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67B471F21F44
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 14:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FA51C69D;
	Sat, 26 Oct 2024 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=remote-tech-co-uk.20230601.gappssmtp.com header.i=@remote-tech-co-uk.20230601.gappssmtp.com header.b="RAJoanSv"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D710C182C5
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729953971; cv=none; b=U/clTzc+NAOaYQOvZ0x6+KpbZ7oeHw/AvpmHTitmzKXbLkF0eWxYmEDVQR64eiykkZeI/1qpT2Fa15+PuCzLCTgw2Cj0u+0KbS8u5fPCiYFXOacTURVLPFqnppIYpHaWok7rh3lmhRo9RazRe0FTnsXwbUFe0/nIy8Bw0RANkNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729953971; c=relaxed/simple;
	bh=8CoRc6VVSdAOs0MhjAL9xRmWEpUdsZ2nZlVY/H/Dg+E=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kjD1IK1DNBS9HcxE+iirf3siZYeL0dTMstDX07ByBHN4P/r0sCStKs1ZgGewPJ4hac3PsCm5tpPDjITiHXaJ8W12LuYr2wdPzcRtdo1m5nYPoX8K6tOjRiJq6yZn8iwiHweckF8NnRHLlhwM0fshySIy9RB48t69G4BvuKtmwfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=remote-tech.co.uk; spf=pass smtp.mailfrom=remote-tech.co.uk; dkim=pass (2048-bit key) header.d=remote-tech-co-uk.20230601.gappssmtp.com header.i=@remote-tech-co-uk.20230601.gappssmtp.com header.b=RAJoanSv; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=remote-tech.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remote-tech.co.uk
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5cb72918bddso3837726a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 07:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=remote-tech-co-uk.20230601.gappssmtp.com; s=20230601; t=1729953967; x=1730558767; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TYdV1+I81l1u7g/Xvzt8Mck+vntRs86BbJfwFR1xvY8=;
        b=RAJoanSvMV2QQwtBzJHU3v56stik4dPXfa5qi1NYVltu0HCgq6nAjydlSjLFB3PzWM
         Uf3DOzVpZ26Vrr4RDq6vuUl9Wc4N5BfFub/JLV1thRoNvzb/+Is9jWirlmvCjmPOPCtc
         guAqWdFK56gizeDXqCoYC/1qAaUYUKSNayp+IxwUetzzoTF3fEoJPLQBrNE/KGcRq9PC
         y19ifUaDp5MwqLOMCBXznDJhL2RddHQ3x8ArMxXOA0jCooA3fvf1bulWfnsK5CcJEgzZ
         x0IYG4CrE1I44iF6HlHD7Lus8/Y3jwzYAKSMVV0b+POTYiFcgZ121wQS4drKlNcIUC1k
         7now==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729953967; x=1730558767;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TYdV1+I81l1u7g/Xvzt8Mck+vntRs86BbJfwFR1xvY8=;
        b=JDSLkt7ZQwebfcWypg1gaSurKAlcQ69Jp0FuJw8+Z20ZiDuu75Pyy7XCR3ctQmifJh
         bsdfNeOnsbhxtPVdyW2OCJlxIQYsmdYbzvioiMgIC5aPc1Oq87jf66U6WnPwGw4TnW35
         olIo7ovjZ77bGAwNfPryfKyE2Hw1nLDWubEUwytImaB9tWqhxKxgrWE8aPhC/5QLemaf
         hFl2wGklq9dBUmBLm67hb6bexOVN+JtOzCf+eWEGZUQrX6MoB9t1+zgZfHbUM/u55xbv
         9BYJ25O6qjlYdEoUjfsuQT0fCj2NHbk+MlYVq4+t20ckIRxhbExAnL6vbwg2rCAyVmE7
         ALEw==
X-Forwarded-Encrypted: i=1; AJvYcCUM2IURrFLS5wBfLel6115HA+TPk+YU9g8eNkmrC7Nu5kdhwLwMIQZqXU7F+aEpwnodLCcmcpAUtUBpiXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOfpE+saxYqtR+x/Nqn77VOqe3bzz/8m6wfddXjALnixFApVpi
	baVB95KJX0FBqJvRnVwNBNxMyLZdJ8gMGpPJdnmh2bdawaE5U/n06B6wFOTxiV1j5Ny21XB8B2S
	M/rpszPa6oHoZIDekWAftnp0HH3wIJblYKov082IGG6BGZk9Yx2YqGT2WbpCVU9eij27QGQmcXA
	jIsGG37hY+6+mgwV5VXYMEz71C9I4=
X-Google-Smtp-Source: AGHT+IGUnSipcSAWY4QhIiKUttouMU70Fi6sIKLp3DmCbqNNczG3lw23b8nTLFuxWsKBCgX91IN5kA==
X-Received: by 2002:a05:6402:2694:b0:5c4:4dfd:9fd5 with SMTP id 4fb4d7f45d1cf-5cbbfa91e51mr2093364a12.29.1729953967080;
        Sat, 26 Oct 2024 07:46:07 -0700 (PDT)
Received: from admins-Air ([2a02:810d:aec0:2a54:158c:1efa:f963:7401])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb631afe1sm1563258a12.71.2024.10.26.07.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 07:46:06 -0700 (PDT)
Date: Sat, 26 Oct 2024 16:46:03 +0200
From: Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>
To: pavel@ucw.cz, lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: leds: Add LED1202 LED Controller
Message-ID: <Zx0AqwUUchl4M6po@admins-Air>
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

If the led node is present in the controller then the channel is
set to active.

Signed-off-by: Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>
---

Changes in v3:
  - remove active property
Changes in v2:
  - renamed label to remove color from it
  - add color property for each node
  - add function and function-enumerator property for each node

 .../devicetree/bindings/leds/st,led1202.yml   | 103 ++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/st,led1202.yml

diff --git a/Documentation/devicetree/bindings/leds/st,led1202.yml b/Documentation/devicetree/bindings/leds/st,led1202.yml
new file mode 100644
index 000000000000..f64273599181
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/st,led1202.yml
@@ -0,0 +1,103 @@
+patternProperties:
+    "^led@[0-9a-f]+$":
+    type: object
+    $ref: common.yaml#
+    unevaluatedProperties: false
+
+    properties:
+        reg:
+        minimum: 0
+        maximum: 11
+
+    required:
+        - reg
+
+additionalProperties: false
+
+examples:
+    - |
+        #include <dt-bindings/leds/common.h>
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
+            };
+
+            led@1 {
+                reg = <1>;
+                label = "led2";
+                function = LED_FUNCTION_STATUS;
+                color = <LED_COLOR_ID_GREEN>;
+                function-enumerator = <2>;
+            };
+
+            led@2 {
+                reg = <2>;
+                label = "led3";
+                function = LED_FUNCTION_STATUS;
+                color = <LED_COLOR_ID_BLUE>;
+                function-enumerator = <3>;
+            };
+
+            led@3 {
+                reg = <3>;
+                label = "led4";
+                function = LED_FUNCTION_STATUS;
+                color = <LED_COLOR_ID_RED>;
+                function-enumerator = <4>;
+            };
+
+            led@4 {
+                reg = <4>;
+                label = "led5";
+                function = LED_FUNCTION_STATUS;
+                color = <LED_COLOR_ID_GREEN>;
+                function-enumerator = <5>;
+            };
+
+            led@5 {
+                reg = <5>;
+                label = "led6";
+                function = LED_FUNCTION_STATUS;
+                color = <LED_COLOR_ID_BLUE>;
+                function-enumerator = <6>;
+            };
+
+            led@6 {
+                reg = <6>;
+                label = "led7";
+                function = LED_FUNCTION_STATUS;
+                color = <LED_COLOR_ID_RED>;
+                function-enumerator = <7>;
+            };
+
+            led@7 {
+                reg = <7>;
+                label = "led8";
+                function = LED_FUNCTION_STATUS;
+                color = <LED_COLOR_ID_GREEN>;
+                function-enumerator = <8>;
+            };
+
+            led@8 {
+                reg = <8>;
+                label = "led9";
+                function = LED_FUNCTION_STATUS;
+                color = <LED_COLOR_ID_BLUE>;
+                function-enumerator = <9>;
+            };
+        };
+    };
-- 
2.39.3 (Apple Git-145)


