Return-Path: <linux-kernel+bounces-443452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 510409EF15B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D985174BA9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77226231A46;
	Thu, 12 Dec 2024 16:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="XjL8XaPl"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7915223E80
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020347; cv=none; b=QFe844PqMM+lC0eTjEZ7G+sA/qsnp0103dehDBMq9TtzTUcnFqVqsnb/oXgVULJGLm6WTycw3apX6swMKrErRuuFksNBBpNqRDUj9awFzidNrNEtg3XEeyRs6Vzj1QLq1BUjf0iSq4eIb2gK8ogzWGfM1T8oNzbn54etwxhPAVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020347; c=relaxed/simple;
	bh=7ND0VHnVmm8LcXHDwESXYMU2C05O2sQs2Pn504aPY3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mz4RkVItNFEMKImm0R9/hnznLnk/v95V2hSk9AOZD/HjasaGKcqpHSYyupL2J036Uk/vdwBljHIVdkUj0OLRZ5wnsWAK7yNRWB0zD1H8byx9wOv20dWkiSYm9mBYrw2tuhR0g+p2zpnCh79rEQaDbixFwOjnk7cuOtb6Ki25a8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=XjL8XaPl; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4361f796586so10231295e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1734020344; x=1734625144; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y6HwzRhtwuck+pMBjZMoVZ4D2FniLRRRufqq2y2rOjs=;
        b=XjL8XaPlNWTlg/sk9QuuyuWirn2v1kM7XFUGyb4SGwwPMDLRWESWrICGjaJTStTKvZ
         eQWwjX7D2nacOsyFE1KHuC80xK5mtw32qHvz5uPTllaFMevZL4c9ouVY704mwgKByx8V
         M5deaW2mmQWMetW5NSh/UrOdJVeXVNWQnF2zHYzStWoQLGTmqDH03PD39BiQndKiK/HU
         t+uIi/sDtvM8cBfeDIH7T7K4cEsuHq7FS2MQug/CcbWo01e41O3nacirSQlsDWx9+S/S
         C7pOL0vPoMxUVV4Iw3QnE87oVhdWLapa08hf53q4Rc5ACGz0ElsrYPpd5TlrfgBtfwzp
         dHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734020344; x=1734625144;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6HwzRhtwuck+pMBjZMoVZ4D2FniLRRRufqq2y2rOjs=;
        b=c+BWmbMdZYwRxr2CdOa1f+TgQpT+NftD+3oTFSp2rte7+oqTh7XeTcuU2pmf9JqC0e
         LwLYmTFI5HjehZ2/SjZVtgWtVjLAUFKyvBWqkbr03ge4NLqU/vcnadgTqISJsqfG3cLI
         ROqa1auRmEFVoySndkSzWk3Uji1Syq1ntJ/8PjOItGGo7cNGPa7i2gRrvYFneh2meLC0
         EQh+hnY4UEgyj8EkdMIrmnt9UoG+BgHNQEo/iMSKaRfxw605TVNhsnW7FGosf+TrY04a
         FInplRH/X484GNkrYlfUky8ShbMiiIeKxVxF6R4aK7n/XvotFlLXIqMZqp1VOmeNXZPk
         zM0w==
X-Forwarded-Encrypted: i=1; AJvYcCUluUP84l+zcgyvzgD/4iA4ZGNlCWA75gJPL4+bBOILN0KwjNQ6LsIKuWLa01wEkkydw/HMvQterKGqc9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUqXJGOovOs/tw4yM7arUp536iTu25VZwTq3LMVoFAjp5f/w4R
	C/a2SWPTYUgkYMVNz93IOasQVYBruBQvndldqqC2J5hXgGVEU5AqZqWwg513TBQ=
X-Gm-Gg: ASbGncv6fscoRKAlmUbI9j8NAVkYAQIqpbWrD6fyhD2GjtlNrDEoQL0sZycGanFD5xK
	Zk+Lt0yY0A6lyiVp3VCkMg/hAeuO5CammAARFMdwRxHDFpmj0+MSwrOg6Q5I/JS7pFyA4hy1Guv
	YgY0RBDlo5n9or5OpFV9zjUiWRDsMs5OboG6rpfpD/OZOwQR6UjPWHhKAeBpkbvavzOkLT4Cio8
	Cj5pM2En5NOIz5WI2tSxTd7eTBygH7+VVoS1gMul7+hvOTR
X-Google-Smtp-Source: AGHT+IECJruZQ6LwRw858w1Yxs8MMZZ8ljYIT9r3bgD0QLs1iDMGolWGCI6cX4+UuSx7QkTjWRFBnA==
X-Received: by 2002:a05:600c:524b:b0:434:a781:f5d9 with SMTP id 5b1f17b1804b1-4361c3aaefamr71124875e9.11.1734020344259;
        Thu, 12 Dec 2024 08:19:04 -0800 (PST)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4361e322328sm44336105e9.0.2024.12.12.08.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 08:19:03 -0800 (PST)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 12 Dec 2024 16:18:51 +0000
Subject: [PATCH v2 1/7] dt-bindings: display: bcm2711-hdmi: Add interrupt
 details for BCM2712
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-dt-bcm2712-fixes-v2-1-35986e04d0f4@raspberrypi.com>
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

Commit 62948c62abca ("dt-bindings: display: Add BCM2712 HDMI bindings")
added the compatible strings for BCM2712, but missed out that the
number of interrupts changed.

Update the schema to include the interrupt requirements.

Fixes: 62948c62abca ("dt-bindings: display: Add BCM2712 HDMI bindings")
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 .../bindings/display/brcm,bcm2711-hdmi.yaml        | 107 ++++++++++++++++++---
 1 file changed, 93 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml
index 6d11f5955b51..a7ca3a336187 100644
--- a/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml
@@ -56,22 +56,38 @@ properties:
       - const: cec
 
   interrupts:
-    items:
-      - description: CEC TX interrupt
-      - description: CEC RX interrupt
-      - description: CEC stuck at low interrupt
-      - description: Wake-up interrupt
-      - description: Hotplug connected interrupt
-      - description: Hotplug removed interrupt
+    oneOf:
+      - items:
+        - description: CEC TX interrupt
+        - description: CEC RX interrupt
+        - description: CEC stuck at low interrupt
+        - description: Wake-up interrupt
+        - description: Hotplug connected interrupt
+        - description: Hotplug removed interrupt
+
+      - items:
+        - description: CEC TX interrupt
+        - description: CEC RX interrupt
+        - description: CEC stuck at low interrupt
+        - description: Hotplug connected interrupt
+        - description: Hotplug removed interrupt
 
   interrupt-names:
-    items:
-      - const: cec-tx
-      - const: cec-rx
-      - const: cec-low
-      - const: wakeup
-      - const: hpd-connected
-      - const: hpd-removed
+    oneOf:
+      - items:
+        - const: cec-tx
+        - const: cec-rx
+        - const: cec-low
+        - const: wakeup
+        - const: hpd-connected
+        - const: hpd-removed
+
+      - items:
+        - const: cec-tx
+        - const: cec-rx
+        - const: cec-low
+        - const: hpd-connected
+        - const: hpd-removed
 
   ddc:
     $ref: /schemas/types.yaml#/definitions/phandle
@@ -112,6 +128,66 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - brcm,bcm2711-hdmi0
+              - brcm,bcm2711-hdmi1
+    then:
+      properties:
+        interrupts:
+          items:
+            - description: CEC TX interrupt
+            - description: CEC RX interrupt
+            - description: CEC stuck at low interrupt
+            - description: Wake-up interrupt
+            - description: Hotplug connected interrupt
+            - description: Hotplug removed interrupt
+        interrupt-names:
+          items:
+            - const: cec-tx
+            - const: cec-rx
+            - const: cec-low
+            - const: wakeup
+            - const: hpd-connected
+            - const: hpd-removed
+
+
+      required:
+        - interrupts
+        - interrupt-names
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - brcm,bcm2712-hdmi0
+              - brcm,bcm2712-hdmi1
+    then:
+      properties:
+        interrupts:
+          items:
+            - description: CEC TX interrupt
+            - description: CEC RX interrupt
+            - description: CEC stuck at low interrupt
+            - description: Hotplug connected interrupt
+            - description: Hotplug removed interrupt
+        interrupts-names:
+          items:
+            - const: cec-tx
+            - const: cec-rx
+            - const: cec-low
+            - const: hpd-connected
+            - const: hpd-removed
+
+      required:
+        - interrupts
+        - interrupt-names
+
 examples:
   - |
     hdmi0: hdmi@7ef00700 {
@@ -136,6 +212,9 @@ examples:
                     "hd";
         clocks = <&firmware_clocks 13>, <&firmware_clocks 14>, <&dvp 1>, <&clk_27MHz>;
         clock-names = "hdmi", "bvb", "audio", "cec";
+        interrupts = <0>, <1>, <2>, <3>, <4>, <5>;
+        interrupt-names = "cec-tx", "cec-rx", "cec-low", "wakeup",
+                "hpd-connected", "hpd-removed";
         resets = <&dvp 0>;
         ddc = <&ddc0>;
     };

-- 
2.34.1


