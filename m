Return-Path: <linux-kernel+bounces-189331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4028CEE82
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 12:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88F54B217A6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 10:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B212376F4;
	Sat, 25 May 2024 10:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVbIbMSi"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FD22BB16;
	Sat, 25 May 2024 10:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716632967; cv=none; b=asDpLdeSV1pYuiS0BV8kDI3jzquZmyy8tKSLC763dTOd3RuwmzO0uFvtHz1rYs9lCDGKSqxbx+iAOvz5UV9lozoDIxqqXD+aBDHwTosXCSIMlS6rfwwjd0fxhejl34C5Bqq++sMqVbOEiPmE0O7XNuIemj/5ZQ3N8OuwC3f4SdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716632967; c=relaxed/simple;
	bh=N3cigQASH5aPySn58ICfGRQpR7Ju7/mbMWtr5LCOwNs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZY1m7hwtCn8WE9NE2X4Qm6lP31T5zQtg5J4U1dhEFxArZIIaBVRAe5mK3R5hj0jrd7iR0qQ/AreJWYMmLZDifYptS/dNzh2UnRFCuFsYtblF7RAoQcI64cZyM4GHH6jAh8VzFyFbi9OTfOQ11NTWkkjyZ+UMJJiQhiY1eAC6LSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVbIbMSi; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-354faf5f1b4so2474026f8f.1;
        Sat, 25 May 2024 03:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716632964; x=1717237764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMH0rKAImsJvaTI5337Dr7Uinr6zejv64aYJwOTfOMY=;
        b=dVbIbMSiWd42j1FvyhRLPTlETeNiQMsnJqvi5wrGcTe6m2ivpGYYMwEU3Da88nz6ag
         65R8DmwN8rx0s411spTrqO14H59zx1C9R5Uukl5VEDPbY7g+fsWbM+04FVBu41ZN16D4
         OpiWWXnWHDHSc5yoSqG38u8d1JCmbZfCEHa0oy7/Wqc2GeFkrfKzyw8dxDIi4dkgAT1a
         404HMij0MUwJ017HnuBlyjBOuNIkJlgbNAjaP2XglFCfapaGLJQ4cu4VGxwmjrVkhAc1
         o5qVXoXjh3jpiYwpnL5fyAL4vytkWnxvExjxH6uvFoHbU/+d0H+l4Ya1lMqZQ41XrNMo
         jjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716632964; x=1717237764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMH0rKAImsJvaTI5337Dr7Uinr6zejv64aYJwOTfOMY=;
        b=jI2chDrERmNt4CPjslzd+GHzR2APouq3dAOtE5JMwZsB7t55iTktDSZQDocoTfyW/D
         4x1paNqNw1LmPrALh4WRFvURFrLfktcIcQbdVQDNEVI/nl9HSW4T2ImLcpf5mqzwcqqy
         kVJ5VdS1Qp6XeGCM7PVfdemyiAq/or/PWuhtM0WttQ7yp2WK8ESiPdKK4Pjr7Y5sIDto
         ElVYXOfzNRuxOhUhT7PymwVwlBo2RfFhhnmxh+iwYwvxm/dCVF7kafQjGscrEHo7sQmm
         u0tNHEHz8FlozqDsD1qb5rgyMZLA/HQdJX2l0xVaKjD3woEeNsCprJLHEVvNIM7htD5E
         HcZA==
X-Forwarded-Encrypted: i=1; AJvYcCU9ho+5DMPtgiR/GkrdWHP33tdsBEAoFN7FhHpqR+Zz+zhMPg7krajYlf/qetGc+YpNB1QVYG/6r6C6+DXaWabaoHjcv9+DaLv2vavC98WksH6UvauS73Pcf9phbgC4jn/LgbBVNcyfJevOvL0VMsfU9rAwWPzgZOjx+yGGlPHBgA0s6ayM
X-Gm-Message-State: AOJu0YwqCXKUNmpesQVoBzhBGlpwlyloYAdTRiCTW55Z4QZr34uXvkLb
	R6DWJIwTfIu/6SxpyWvw5oKffOZP7tHrFFsuxOs7jHFtS7UI9PL1
X-Google-Smtp-Source: AGHT+IET61yBdk7r+/rRJjoLtnHqhtah5niSswc0UxbR4Pp0Kw/VqXbz4bHX2k/A4SE4LTq0buN3Xw==
X-Received: by 2002:a05:6000:bd2:b0:354:fd10:d217 with SMTP id ffacd0b85a97d-3552fe17d69mr3986636f8f.63.1716632964280;
        Sat, 25 May 2024 03:29:24 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3557a1c918csm3674651f8f.77.2024.05.25.03.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 03:29:23 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: hwmon: g76x: Add support for g761
Date: Sat, 25 May 2024 12:29:11 +0200
Message-ID: <20240525102914.22634-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240525102914.22634-1-ansuelsmth@gmail.com>
References: <20240525102914.22634-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for g761 PWM Fan controller. This is an exact copy of g763
with the difference that it does also support an internal clock
oscillators.

Add required logic to support this additional feature with the property
gmt,internal-clock and reject invalid schema that define both
internal-clock property and external clocks.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../devicetree/bindings/hwmon/gmt,g76x.yaml   | 43 +++++++++++++++++--
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/gmt,g76x.yaml b/Documentation/devicetree/bindings/hwmon/gmt,g76x.yaml
index bfefe49f54bf..d6e80392d045 100644
--- a/Documentation/devicetree/bindings/hwmon/gmt,g76x.yaml
+++ b/Documentation/devicetree/bindings/hwmon/gmt,g76x.yaml
@@ -4,13 +4,13 @@
 $id: http://devicetree.org/schemas/hwmon/gmt,g76x.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: GMT G762/G763 PWM Fan controller
+title: GMT G761/G762/G763 PWM Fan controller
 
 maintainers:
   - Christian Marangi <ansuelsmth@gmail.com>
 
 description: |
-  GMT G762/G763 PWM Fan controller.
+  GMT G761/G762/G763 PWM Fan controller.
 
   If an optional property is not set in DT, then current value is kept
   unmodified (e.g. bootloader installed value).
@@ -22,6 +22,7 @@ description: |
 properties:
   compatible:
     enum:
+      - gmt,g761
       - gmt,g762
       - gmt,g763
 
@@ -48,10 +49,37 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [0, 1, 2]
 
+  gmt,internal-clock:
+    description: Use the Internal clock instead of externally attached one
+      via the CLK pin.
+    type: boolean
+
 required:
   - compatible
   - reg
-  - clocks
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - gmt,g762
+              - gmt,g763
+    then:
+      properties:
+        gmt,internal-clock: false
+
+      required:
+        - clocks
+
+  - if:
+      required:
+        - gmt,internal-clock
+
+    then:
+      properties:
+        clocks: false
 
 additionalProperties: false
 
@@ -80,4 +108,13 @@ examples:
             fan_startv = <1>;
             pwm_polarity = <0>;
         };
+
+        g761@1e {
+            compatible = "gmt,g761";
+            reg = <0x1e>;
+            gmt,internal-clock;
+            fan_gear_mode = <0>;
+            fan_startv = <1>;
+            pwm_polarity = <0>;
+        };
     };
-- 
2.43.0


