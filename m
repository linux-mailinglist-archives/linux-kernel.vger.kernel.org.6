Return-Path: <linux-kernel+bounces-373002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D97C9A508A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 21:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B36528642D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 19:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511E1191F74;
	Sat, 19 Oct 2024 19:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBMl32Kw"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AFF15C15E;
	Sat, 19 Oct 2024 19:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729367487; cv=none; b=J6Csk8RhaZxKMq638S9/Un1Cq3uL+1nva2x2Qfz7FA8qOzTVBYixKMjcikJliWgYLSNytcqcuVPAe1huBDfhbj60TqkFAoUjQKGd0RvZ9dbYnED7DvhKQlW7ZlNL1Tmf6pErvrv3X075431Qfv1janUApsQtyhw2mn46x0GcQwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729367487; c=relaxed/simple;
	bh=oHEjDKk9TkE4BFgTgh4sm+Vn2aH/CDh5V5lnt8KHNpQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=W1ZC/Y4r0imzXZJ/xz6tETJYB2tFD4Q4bv2qcqikaD8cw5pQA1Lna9QZyLJlBeu6b4Bn1w/Vvki1Jm/wGLxnShXrcb6naJv8+nYiAxlQd7g9xSPOvofUUODJxvhF0j+YcjAoCehUl66xUj8q4Tqd+Ge3mTqOOP/rLshvz6KZx8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBMl32Kw; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e61b47c6cso2595275b3a.2;
        Sat, 19 Oct 2024 12:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729367485; x=1729972285; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Thl/v6pkFNympRdYZXdKzmvf2wObllIaqGjp22mJ/xU=;
        b=MBMl32KwTxZ89FxH4g+z9+XGUwydbVRHk/4TMvQJxeShn/LjPTHwbr8ZJeicAONR/b
         fqfNSZ34dzIRC38QRhFocfFSxUq6XVham2S503eaJPa0gz9vv6JksRwOe0qULxFjNIAi
         /BtWR0FY0ijfebz1cCe9IGS31EXbVALliXmWu3NXiefFbD1XKrTv+6F2QlDYXgjlzpEE
         zAK2nqdKf020DbHBOIgLu84ThrBCgB7tiyc/pQ/AYdaRwP+PGuG/6V+Mx84H/WAkBnTW
         0qloSRZBnHfNhrozIH5zWZggpwaq5D03p0gjyOLygIgSeZkmP4NG7Z9q7CyZu76w6pPB
         inwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729367485; x=1729972285;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Thl/v6pkFNympRdYZXdKzmvf2wObllIaqGjp22mJ/xU=;
        b=F8VdPg8FBB3rz5pEV7zRE1+TBo9qM9HfQ7D7tiEnJfdvisDaE1AZq08uH7cwsPiqu8
         mL/OVonlYlLjaU0Q64kw1lFTXhfc3ghfakQppoM/raK05bZtgmMuHR38kQqyTpFwxLXS
         YOl5FHf3gofJAo+KGiFSEogKCBEaC7PaIGTH299aLMyJNxOmftWZdIH/YwlayUS62w49
         TX+huDttS/DRdXn5pOpOGeCFfUcrMZJ6oz2zlA2TaIXSaad/RePOWbMXZxdkY5nXZiH3
         DmtkP7UrZF1C5D/DeZtxT+uEbBYz86qnzrJsvE+9KrtU2wJEIf1mFWedngSG/WdaMUEX
         xjGw==
X-Forwarded-Encrypted: i=1; AJvYcCVd64Kc02WcrNESr0kNlVvkAfEf6jGHmUf1t8aoeSfilvDfCSpG30UGpyD9iqwgiWtrv/4rks+N5hACtvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbfgeHajG/GSakR0qXdXSUo8kNtXELMYFH/OE+qwp8n23Zkl1L
	iznP4vBoSQx1sB4wBBliqBsojMlwRscIWLmLBtgBhbgffcduX26V
X-Google-Smtp-Source: AGHT+IGNIRKIdiOgL4CiREZ/Cuxd7GC65Jr5JlRKqCtynmRAI33CUoTMy9XG4mLm4pxUCXMGkx2lwA==
X-Received: by 2002:a05:6a00:2302:b0:71e:5a1d:ecdc with SMTP id d2e1a72fcca58-71ea31d2c22mr9526671b3a.17.1729367484945;
        Sat, 19 Oct 2024 12:51:24 -0700 (PDT)
Received: from Emma ([2401:4900:1c96:190:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeaafbd62sm120226a12.4.2024.10.19.12.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 12:51:24 -0700 (PDT)
From: Karan Sanghavi <karansanghvi98@gmail.com>
Date: Sat, 19 Oct 2024 19:51:18 +0000
Subject: [PATCH] dt-bindings: soc: bcm: Convert to Dt schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241019-raspberrypi-bcm2835-power-v1-1-75e924dc3745@gmail.com>
X-B4-Tracking: v=1; b=H4sIALUNFGcC/x3MPQqAMAxA4atIZgO2tWC9iji0GjWDWlLwB/HuF
 sdveO+BRMKUoC0eEDo48b5lqLKAYfHbTMhjNuhK16pSDsWnGEjkjoxhWHVjLMb9JEHra21UoMZ
 ZB7mPQhNf/7vr3/cDi6quwmsAAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Karan Sanghavi <karansanghvi98@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729367480; l=3330;
 i=karansanghvi98@gmail.com; s=20241017; h=from:subject:message-id;
 bh=oHEjDKk9TkE4BFgTgh4sm+Vn2aH/CDh5V5lnt8KHNpQ=;
 b=w2mFxawKCxn4pXhsVTjbgzFlKBRVmQIaCTf4TKIhstsm6XwoGi9snItvd0R1q4JB5vkQ9qzOo
 CemqjYCtVpIAGOhp0oN6aW2hGP6QqfivDucCqe8v3eg+hlmt4uJHOL+
X-Developer-Key: i=karansanghvi98@gmail.com; a=ed25519;
 pk=UAcbefT1C06npNVDJHdgpPqTm4WE9IhaA1fmJb3A37Y=

Convert the raspberrypi,bcm2835-power binding to Dt schema

Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
---
 .../bindings/soc/bcm/raspberrypi,bcm2835-power.txt | 47 ----------------------
 .../soc/bcm/raspberrypi,bcm2835-power.yaml         | 42 +++++++++++++++++++
 2 files changed, 42 insertions(+), 47 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/bcm/raspberrypi,bcm2835-power.txt b/Documentation/devicetree/bindings/soc/bcm/raspberrypi,bcm2835-power.txt
deleted file mode 100644
index 30942cf7992b..000000000000
--- a/Documentation/devicetree/bindings/soc/bcm/raspberrypi,bcm2835-power.txt
+++ /dev/null
@@ -1,47 +0,0 @@
-Raspberry Pi power domain driver
-
-Required properties:
-
-- compatible:		Should be "raspberrypi,bcm2835-power".
-- firmware:		Reference to the RPi firmware device node.
-- #power-domain-cells:	Should be <1>, we providing multiple power domains.
-
-The valid defines for power domain are:
-
- RPI_POWER_DOMAIN_I2C0
- RPI_POWER_DOMAIN_I2C1
- RPI_POWER_DOMAIN_I2C2
- RPI_POWER_DOMAIN_VIDEO_SCALER
- RPI_POWER_DOMAIN_VPU1
- RPI_POWER_DOMAIN_HDMI
- RPI_POWER_DOMAIN_USB
- RPI_POWER_DOMAIN_VEC
- RPI_POWER_DOMAIN_JPEG
- RPI_POWER_DOMAIN_H264
- RPI_POWER_DOMAIN_V3D
- RPI_POWER_DOMAIN_ISP
- RPI_POWER_DOMAIN_UNICAM0
- RPI_POWER_DOMAIN_UNICAM1
- RPI_POWER_DOMAIN_CCP2RX
- RPI_POWER_DOMAIN_CSI2
- RPI_POWER_DOMAIN_CPI
- RPI_POWER_DOMAIN_DSI0
- RPI_POWER_DOMAIN_DSI1
- RPI_POWER_DOMAIN_TRANSPOSER
- RPI_POWER_DOMAIN_CCP2TX
- RPI_POWER_DOMAIN_CDP
- RPI_POWER_DOMAIN_ARM
-
-Example:
-
-power: power {
-	compatible = "raspberrypi,bcm2835-power";
-	firmware = <&firmware>;
-	#power-domain-cells = <1>;
-};
-
-Example for using power domain:
-
-&usb {
-       power-domains = <&power RPI_POWER_DOMAIN_USB>;
-};
diff --git a/Documentation/devicetree/bindings/soc/bcm/raspberrypi,bcm2835-power.yaml b/Documentation/devicetree/bindings/soc/bcm/raspberrypi,bcm2835-power.yaml
new file mode 100644
index 000000000000..bab6d7dea8a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/bcm/raspberrypi,bcm2835-power.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/bcm/raspberrypi,bcm2835-power.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM2835 power domain driver
+
+maintainers:
+  - Karan Sanghavi <karansanghvi98@gmail.com>
+
+description: |
+  The Raspberry Pi power domain driver manages power for various subsystems
+  in the Raspberry Pi BCM2835 SoC.
+
+properties:
+  compatible:
+    enum:
+      - raspberrypi,bcm2835-power
+
+  firmware:
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  '#power-domain-cells':
+    const: 1
+
+required:
+  - compatible
+  - firmware
+  - "#power-domain-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/power/raspberrypi-power.h>
+    power: power {
+      compatible = "raspberrypi,bcm2835-power";
+      firmware = <&firmware>;
+      #power-domain-cells = <1>;
+    };
+

---
base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
change-id: 20241019-raspberrypi-bcm2835-power-5a4231be8959

Best regards,
-- 
Karan Sanghavi <karansanghvi98@gmail.com>


