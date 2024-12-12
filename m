Return-Path: <linux-kernel+bounces-443724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC05A9EFB28
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B93FD1882C2C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B18223338;
	Thu, 12 Dec 2024 18:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="Qy0ayegu"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C97B218594
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734028606; cv=none; b=fx4zVLqHODjTj9LvhWEa9S70cVJL/rFa+E2sRVK3SdyIgtT0AQD8XFG52B3QOGG+djgiFF8nvplBn1clMoskadRLhk753tyfkdOxqcwZ2Xoo6ylksvBXIjf0hDqt4bAwueaAf3SIBdtdCgiLC7TKtuTJdugvSrtmapKUJeZAhmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734028606; c=relaxed/simple;
	bh=rkPNOS/CThHiZ6WlZSF0eZPRzkaH0woMbTCR+SPr3t8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UECJLWRBxkoB6zw2gEi/oETTE9c4zHHqcDaq8zr6p8ZkK08Cr+UiuWJA3iO6vtWvs3RZ1hb9sEItTUWtbMsPcJaSZpF657WXxxGCam7PQj80dbOw1dTV+LdviJboXVKdAeT/TaUTTHqEIWy4uvKU9b9O1/P9P1+CuXvcQZtexXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=Qy0ayegu; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3862a921123so685143f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1734028603; x=1734633403; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZmY4nSeOHfUAeSRoOGUYAdGnJvM3BDuelhiAae/7ZWg=;
        b=Qy0ayeguk99iHuVBTkCZmC2a7Li07bPTqYCO5V3AEUKu1TSRAnFaG4J4rw1GkNmgBl
         w27SGhfvY2PMQf9E8kR3MOeH7f13bbAPD+CvOkyx7UlONsPDYF23dk/9Swv3v5vuvt/x
         R5pcslEhKgvahfs5YGtMfFEM7mln48pBFtKgTli0O1aruXbJOSDao2Xql5QC+AHz/wh5
         lFmpX4kz5pVRvj+oEWoPQ6yvsmLXNGfBKaNMZAYk/oRPfFCpqsDuYKKzrpzsazU8XI4h
         DcA4kEJsLIVXI0Upv55dTSuw4XhXUtJhNFgc7BdSzLE6Tu9KYLUNXL+9u1QVxF54c78T
         wcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734028603; x=1734633403;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZmY4nSeOHfUAeSRoOGUYAdGnJvM3BDuelhiAae/7ZWg=;
        b=gXrjhjH7pkNpAbe8l1kH8Ww8W4ahEK43AEKm0Dxy2llvJws0Y4CROQyY4azMJ00AXh
         5obiobI6PcbrAyRlOtWUIgb1TM+1tlej8HhhYcB3TJ12aORdqkvlnFe8Y9RvpmfDkUrJ
         pqGf8bURnmj5Mebv/IO4FH03BpGC4MegJSedPzSWi1frHLb/PLCVcwU9/MMOHNu+ffr3
         B2o+fLxsYPsfcWnpEviQXLr1PCT8NEsHYgJhi0xcDulYQ3bHDU3CD8TD/4ms5HAtqRA7
         h0O6xQNv1N3i+d7Wxhnp72su4jt/4uQ6QhCUv03j91NpwuxLsCftRcQ2tgXlUgU97Tu/
         WQgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjIEH+S6uTwplEWXZ9UunR5LpNsaALamXqRspbHdQU6hWyHPZl4RkA5I2M2wsa5Gla7JP+CZ8mtjaqj9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7XLyA5JKQqguF7QPPT1HslevmojTURArc7o4cYtK4IEtDNzj2
	iTkW3s1sdV8fxYsBia5NW/JRQGClNxTdinHcbVe9cZidvMayZlaM+O6J2ug0vOA=
X-Gm-Gg: ASbGnctUQ3dVJqojbtbIQ6wIgptwaz1P6JcAhN7PLTnGhLDZiuAVFU1Pkm9Hy+mYQ4E
	wA9xEKWXIKwp7GNK91gL11CCMB+Um9OSZtV1vB2gJe8jhzVqQOzzmffmJByaxqZfnV8xXY1s1mz
	P1DN0i1MmFF5FY1B1hV6Ds/sw18bfAKuWe420WtQSyCzLA/Ro3nbku7tgQ0s5dg8c/z/PHSViiZ
	9+AaKgF6PGKUBQ4bx9vO7Nmk5mJbuFWTu4p8EWIGyRx8ML7
X-Google-Smtp-Source: AGHT+IFU9uMnmpDGMa3W5FkV+Zbg8mGPNRBLqmRp7s6rNpHHpbC4TqWxpZPj4otDLO2FaOF1TjZ6vQ==
X-Received: by 2002:a05:6000:70e:b0:386:3864:5cf2 with SMTP id ffacd0b85a97d-38787691302mr4172021f8f.19.1734028602901;
        Thu, 12 Dec 2024 10:36:42 -0800 (PST)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-436257178e3sm24651995e9.41.2024.12.12.10.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 10:36:41 -0800 (PST)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 12 Dec 2024 18:36:29 +0000
Subject: [PATCH v3 2/7] dt-bindings: display: Fix BCM2835 HVS bindings for
 BCM2712
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-dt-bcm2712-fixes-v3-2-44a7f3390331@raspberrypi.com>
References: <20241212-dt-bcm2712-fixes-v3-0-44a7f3390331@raspberrypi.com>
In-Reply-To: <20241212-dt-bcm2712-fixes-v3-0-44a7f3390331@raspberrypi.com>
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


