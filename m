Return-Path: <linux-kernel+bounces-443454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A359EF09B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7276E293FEA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424A623588A;
	Thu, 12 Dec 2024 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="pw0JJYUU"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4687E231A2E
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020350; cv=none; b=JQWNeko3Rvf+VykTGClUD7rcHuEQ/crua1kdfVj9SARK5hiDhcnl9j9RqhvGB4rqyFHDIKvgOm/oaVz2Yg2ntGjDoyMzN0wS4Yh4NU8LcasCKQa2NCBvWN3XtxMvjL26MxjPpQECFh2verRs5wW4WRdrt+2VNh6AHEdA5m1KI3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020350; c=relaxed/simple;
	bh=rkPNOS/CThHiZ6WlZSF0eZPRzkaH0woMbTCR+SPr3t8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DVPS4+WUyYJqj4v+O7t9CZqL/kz5GNwfl5MJLEbho8vZAHDlG2jvlnH7NQAcbZluIk14CRsCcdL3bAgusj24lHTZ5iZgeHQCd12haHrY34f21oXqBjwEz7CYHEeQeyQ6CzIkr/zZ1G6OKKOuGd2uv6uq7YATb2kG4GJBmS1YpkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=pw0JJYUU; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-434ab114753so5827785e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1734020345; x=1734625145; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZmY4nSeOHfUAeSRoOGUYAdGnJvM3BDuelhiAae/7ZWg=;
        b=pw0JJYUU8lSpKaYDG1xYEW30vvb8fR1NvawXdELQX9Y6mK70Y6/vu1rkkSu+eFdcaG
         YWF9nrKSZS5qbGTb8+/EJJD3HcedIwLxdHThtgVs/e45sJUT3Gh3Y31TNvv25NMvvZeY
         0YpX++blG3D9AQZ7p60v+tGpeyEGS645Bbro3tkPXVBthgbRIH8//RM2WisK7C5WPuTh
         uTVy/eCa+BKpM/nK14RuJ7FbXBrQ8VL2p0q7yUbNk4r30gyIUSHpgVvnPOEqWUr8DOUA
         r2ZFpZU/U4AhvuwAgx1vo73cpfmJSZ7q5wtwh9KL31wLQWo7sx0Sivl5mFoL+pR5qG6v
         NyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734020345; x=1734625145;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZmY4nSeOHfUAeSRoOGUYAdGnJvM3BDuelhiAae/7ZWg=;
        b=deh21vZxuv6JWJPa4Yp0ZXDiDbl1XHDSCjB6c0xYKHEgyzCtw6e6wYXa2om3QnUyvd
         ovg2pkxWH+QdR4MNyLyFZskm5xO/HsAX3m08gp2B63V76TUHckg084I2NiExuNgyUdQg
         d4PRqhNqXzNBzWXNh4yblhxV+HHUoacjpFdiZcgH2w5nvHpTZtN5i+0tGHTvPLf9+Z1c
         xTtBO/G3LAxaVtj23yrfRJqZDn0SVsjY71IonZ3QhRwbpgnEPCMrholJptmBaiE4FZCq
         sRKLqvFE/hu+4uh7/+vpf8rfazEnozTFSd5ktqIlR7N07QQRiy4JuoE9LhLjo+QmEfCp
         NQ+g==
X-Forwarded-Encrypted: i=1; AJvYcCVxEgDbqDw55JFJnhEGGwWFURHuHP9cDau+c/sTPwX7PBQOQaQ8HhajkGaWleoEN1lmuJ/c9mLA9jsh8y4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKsompmOb3ko0Qya36U9MqCa3FbCKWswB7bRCZZBLB0r26WKPl
	ZEpTOwi1oXu1uKC+1VYTy0Mvn253sBMKFx/fpgZM/fjrB4+5G8hGUfGIL4+Khws=
X-Gm-Gg: ASbGnctv80WO9ePLXe9DsulmGI8AIz6VRcyJc1+zVOwNAM4uSWscrg94i57rBKWirob
	m0u6/QN1NRarnDXHAO1bDqvRJp5Vwm1agOIxsmlZYO8Z9zR+prZBP+pTQkR9AtZp8xD2Tor99l/
	O1MmrWaEJflNpZEfKA5RxLCg6CxwOCYaEdGm4PFPpieEa0zlHSW3Npy5sPsN8pmoYNIczMLxTWK
	JC7oiQVN5SXsQw7B8IttstG98PbQvxTF+JAgncSmvBSNtZi
X-Google-Smtp-Source: AGHT+IGaFVqNcAbsh2wXwykvgIG8wIvYr5xOyoWGcWi8bclbVOgLkhFW5BR0LdTPsNVGk8Tlgv5MLQ==
X-Received: by 2002:a05:600c:b86:b0:434:f2f4:4c07 with SMTP id 5b1f17b1804b1-4361c373f5fmr66829415e9.15.1734020345541;
        Thu, 12 Dec 2024 08:19:05 -0800 (PST)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4361e322328sm44336105e9.0.2024.12.12.08.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 08:19:04 -0800 (PST)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 12 Dec 2024 16:18:52 +0000
Subject: [PATCH v2 2/7] dt-bindings: display: Fix BCM2835 HVS bindings for
 BCM2712
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-dt-bcm2712-fixes-v2-2-35986e04d0f4@raspberrypi.com>
References: <20241212-dt-bcm2712-fixes-v2-0-35986e04d0f4@raspberrypi.com>
In-Reply-To: <20241212-dt-bcm2712-fixes-v2-0-35986e04d0f4@raspberrypi.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Eric Anholt <eric@anholt.net>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Doug Berger <opendmb@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Thomas Gleixner <tglx@linutronix.de>, 
 Stefan Wahren <wahrenst@gmx.net>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, 
 linux-gpio@vger.kernel.org, Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.14.1

Commit 6cfcbe548a3a ("dt-bindings: display: Add BCM2712 HVS bindings")
added the compatible string for BCM2712, but missed out that
the number of interrupts and clocks changed too.

Update to validate clock and interrupts for the variants.

Fixes: 6cfcbe548a3a ("dt-bindings: display: Add BCM2712 HVS bindings")
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 .../bindings/display/brcm,bcm2835-hvs.yaml         | 83 ++++++++++++++++++----
 1 file changed, 69 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml
index f91c9dce2a44..36bf8eec88a6 100644
--- a/Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml
+++ b/Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml
@@ -20,11 +20,20 @@ properties:
     maxItems: 1
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 3
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 3
 
   clocks:
-    maxItems: 1
-    description: Core Clock
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    maxItems: 2
 
 required:
   - compatible
@@ -33,17 +42,63 @@ required:
 
 additionalProperties: false
 
-if:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - brcm,bcm2711-hvs
-          - brcm,bcm2712-hvs
-
-then:
-  required:
-    - clocks
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: brcm,bcm2711-hvs
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Core Clock
+        interrupts:
+          maxItems: 1
+
+      required:
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: brcm,bcm2712-hvs
+
+    then:
+      properties:
+        clocks:
+          maxItems: 2
+        clock-names:
+          items:
+            - const: core
+            - const: disp
+        interrupts:
+          items:
+            - description: Channel 0 End of frame
+            - description: Channel 1 End of frame
+            - description: Channel 2 End of frame
+        interrupt-names:
+          items:
+            - const: ch0-eof
+            - const: ch1-eof
+            - const: ch2-eof
+      required:
+        - clocks
+        - clock-names
+        - interrupt-names
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: brcm,bcm2835-hvs
+
+    then:
+      properties:
+        interrupts:
+          maxItems: 1
 
 examples:
   - |

-- 
2.34.1


