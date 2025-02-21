Return-Path: <linux-kernel+bounces-525576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D47A3F197
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B771701EEB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C91204F90;
	Fri, 21 Feb 2025 10:14:50 +0000 (UTC)
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CD7205AC0
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 10:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740132889; cv=none; b=a7nuAUyDscEeZiTGwxP52/ymKDGBDBcLQVaw4OvdIdgn0EkZhI2lLiGeLmB3X8lwHdnOPn3N+SzU9g4RWbn+H2cyAjJqr9cWrk0258cZt+VqehjmWJ95rRTrpnCc/J88FNWA5whDp+J3Ca8nfsXEKAv7ar+Ts/7i72JOx5LVhJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740132889; c=relaxed/simple;
	bh=s6kvTlBWs3QTc69KNC5Ob0gAjwaprTQipz5QovyifGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Asb82vXlayn7Zw3QgHykGI1P31nskaJ3ldlUSN8wUsfBajMjig56UxyuW2R874bIf3T720FgfhcEIc7xkM7m4bAQOjeIdLqf+5V5cLVFm4/3dbErNH+uAhI8fdr9j3OFWqq92SU6cdDIX/BLZwDhQGkDWaTlKFLcznP3HuI2t8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=45.157.188.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YzmFr4N0wz4Fy;
	Fri, 21 Feb 2025 11:14:40 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YzmFr0MTFzJSZ;
	Fri, 21 Feb 2025 11:14:40 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Fri, 21 Feb 2025 11:14:26 +0100
Subject: [PATCH v2 1/2] dt-bindings: gpio: nxp,pcf8575: add reset GPIO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-pca976x-reset-driver-v2-1-a2bcb9fdc256@cherry.de>
References: <20250221-pca976x-reset-driver-v2-0-a2bcb9fdc256@cherry.de>
In-Reply-To: <20250221-pca976x-reset-driver-v2-0-a2bcb9fdc256@cherry.de>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha

From: Quentin Schulz <quentin.schulz@cherry.de>

A few of the I2C GPIO expander chips supported by this binding have a
RESETN pin to be able to reset the chip. The chip is held in reset while
the pin is low, therefore the polarity of reset-gpios is expected to
reflect that, i.e. a GPIO_ACTIVE_HIGH means the GPIO will be driven high
for reset and then driven low, GPIO_ACTIVE_LOW means the GPIO will be
driven low for reset and then driven high. If a GPIO is directly routed
to RESETN pin on the IC without any inverter, GPIO_ACTIVE_LOW is thus
expected.

Out of the supported chips, only PCA9670, PCA9671, PCA9672 and PCA9673
show a RESETN pin in their datasheets. They all share the same reset
timings, that is 4+us reset pulse[0] and 100+us reset time[0].

When performing a reset, "The PCA9670 registers and I2C-bus state
machine will be held in their default state until the RESET input is
once again HIGH."[1] meaning we now know the state of each line
controlled by the GPIO expander. Therefore, setting lines-initial-states
and reset-gpios both does not make sense and their presence is XOR'ed.

[0] https://www.nxp.com/docs/en/data-sheet/PCA9670.pdf Fig 22.
[1] https://www.nxp.com/docs/en/data-sheet/PCA9670.pdf 8.5

Tested-by: Heiko Stuebner <heiko@sntech.de> # exclusion logic
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 .../devicetree/bindings/gpio/nxp,pcf8575.yaml      | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/nxp,pcf8575.yaml b/Documentation/devicetree/bindings/gpio/nxp,pcf8575.yaml
index 3718103e966a13e1d77f73335ff73c18a3199469..633ac5cfa04a10bcbb748b6580938cddae9e5596 100644
--- a/Documentation/devicetree/bindings/gpio/nxp,pcf8575.yaml
+++ b/Documentation/devicetree/bindings/gpio/nxp,pcf8575.yaml
@@ -73,6 +73,44 @@ properties:
 
   wakeup-source: true
 
+  reset-gpios:
+    maxItems: 1
+    description:
+      GPIO controlling the (reset active LOW) RESET# pin.
+
+      The active polarity of the GPIO must translate to the low state
+      of the RESET# pin on the IC, i.e. if a GPIO is directly routed
+      to the RESET# pin without any inverter, GPIO_ACTIVE_LOW is
+      expected.
+
+      Performing a reset makes all lines initialized to their input (pulled-up)
+      state.
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              enum:
+                - nxp,pca9670
+                - nxp,pca9671
+                - nxp,pca9672
+                - nxp,pca9673
+    then:
+      properties:
+        reset-gpios: false
+
+  # lines-initial-states XOR reset-gpios
+  # Performing a reset reinitializes all lines to a known state which
+  # may not match passed lines-initial-states
+  - if:
+      required:
+        - lines-initial-states
+    then:
+      properties:
+        reset-gpios: false
+
 patternProperties:
   "^(.+-hog(-[0-9]+)?)$":
     type: object

-- 
2.48.1


