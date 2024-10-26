Return-Path: <linux-kernel+bounces-383388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA269B1AF7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 22:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11FF31F21AC6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 20:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51AF1D7E2F;
	Sat, 26 Oct 2024 20:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqkaXmTS"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4683B1D54C2;
	Sat, 26 Oct 2024 20:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729975702; cv=none; b=p7mFw4mcp27o9JjJCQpcAWHB1MY/MZ5K0ivQ9PRwW3z+Ja1hh0xcfueqOyKzzkj3ixbVycE8zx4m/S0uGvEp1fwIZ+3EniywWktXWMAxDrq5TercNLOZjJJRWItiYd7mEJR65XMOPqENRO8ZMrrKXMkskzXYI/wdUiwOoqb9JG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729975702; c=relaxed/simple;
	bh=LBHA8axdDgptLK0Z/drDDMkxSR3k9NMloOsHzw0RFbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dLThqckyedrK3a7X6uQdyh+nKD1TNfbaqjmZqJ7/INsEo/GZj0aqrP2HX+CaZdSEXEWqGSZufYBJbDjUL2b3C3wjJLujgpN7vJhjsH/pKLHj7wjzGKUJcYg9x0gJlceT05gKFx9ElByXb1+EE70ZDspJ5VQWWSxaxonKpVZSTb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqkaXmTS; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cb7139d9dso27039185ad.1;
        Sat, 26 Oct 2024 13:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729975699; x=1730580499; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fIA9fyOJQl8Gu0sByK4pSmQgiops8sit5rWYrUHittM=;
        b=KqkaXmTSLpa4o7sdV5k7apdjJdq7/1/bs9Zx58c+Dt+8/5XjlV8rtygaDnr45M8zfO
         JEM2Vfz/UwFjQrXZh8yZ9SINnV9tJsp4mg462EPS7wa9TG3mtnKBF+GDo7NkesSdqMJK
         TaDkrdjzAksBRGs0B7xG7VRxx7QmOvUxev7cKIDItxhBHA5nFQ09oRuJ96C84AIHfCDZ
         dsRfPD67qsmcRLelyplfA65K3bjGZQiVo4FiqFcnjG5ZAhrNsvms1wimK+6kdyXHkR2H
         raRvyTb6pc/Gl0NW2G6+BHL3yE/Iw/PZEN4M+JDImzv03REFLmMvdCOVcrAV8aZAlvc6
         O4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729975699; x=1730580499;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fIA9fyOJQl8Gu0sByK4pSmQgiops8sit5rWYrUHittM=;
        b=scvbWDyskQwml6j1F4QF8tZcEnQOaWtNHz9XRhOnVyJ5TFMFiPibE0VV3di3pJfppK
         ffRucktlXs6ypjkv8VvkaHVAlmDyet0uuHCFwugNy/ambAWHCyc7JJyXIkz/eniqBP4o
         aEesaUsOdl/F1P7vD2JqFYMZOFF2Dcgs2wd9VVc33u47r1v3W4KJZNA4r+i+vDmDefz1
         s+3jz/he0lAGekBIK2v+tN2zSfQ8M0VVqfJfwerrgUAoE1zOMRlcVSNb0FqBogBsksO6
         /jKrJlglbfWEKMI2+WBiDFZrE/w8tWkUzMWBziG7U7J8yobNhCqjdaDvQ1Qf8+XMkuv4
         a6WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiMs/lkEoJvPJva4H0DJ4NYIsWlcNqzxPMXCbK9QZ1EXThm9KYx/HsWeT+sgbmbl7UViKjKTmssnPFpe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQsDTBj4z6L/3NQ0U3qVD40aK+sNleQtQ58mo/KVZyRbExnh5q
	zCrGfCp5GIxY6azYmkeYOXDb3EfeRLmA7Y9HiD0tYiPl2OptAZ+K
X-Google-Smtp-Source: AGHT+IE333gdRW0oUHBCkmGDWZSQHfGYaDKn0tETw4Z0mGu0t3ZLNT8/4M/o2OAIEjGXwv5NgOXKVw==
X-Received: by 2002:a17:903:2b08:b0:20b:bad4:5b6e with SMTP id d9443c01a7336-210c6c3ec62mr43945645ad.38.1729975699387;
        Sat, 26 Oct 2024 13:48:19 -0700 (PDT)
Received: from Emma ([2401:4900:1c96:f151:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf4499esm27634295ad.8.2024.10.26.13.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 13:48:18 -0700 (PDT)
From: Karan Sanghavi <karansanghvi98@gmail.com>
Date: Sat, 26 Oct 2024 13:59:13 +0000
Subject: [PATCH v3] dt-bindings: power: Convert raspberrypi,bcm2835-power
 to Dt schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241026-raspberrypi-bcm2835-power-v3-1-6621e075d33f@gmail.com>
X-B4-Tracking: v=1; b=H4sIALD1HGcC/43NwQ6DIAyA4VcxnMciBYLstPdYdkDslGQKgYXNG
 N996MnTsvT0N+nXhSSMDhO5VAuJmF1yfirBTxWxg5l6pK4rTaAGwWqmaTQptBjjHBxt7QgNlzT
 4N0YqjQDOWmy01KTch4gP99nt27304NLLx3l/ldm2/UfNjDKqJGoQneVKyGs/Gvc8Wz+STc1wk
 AB+SVAkZoRpykjF1VFa1/UL011ntwwBAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Alexander Aring <alex.aring@gmail.com>, Eric Anholt <eric@anholt.net>, 
 Karan Sanghavi <karansanghvi98@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729951167; l=3906;
 i=karansanghvi98@gmail.com; s=20241017; h=from:subject:message-id;
 bh=LBHA8axdDgptLK0Z/drDDMkxSR3k9NMloOsHzw0RFbI=;
 b=QNVj74pVLjwDeuupmFKqLDUzJPtmv+LaSfOiza5lgdVnLkNwuzLzZs5U6tBlWbzEBHHFh8p/w
 EpBzzhM2MhNAkO3dYdYfkZh0qkrSS6QFZK2rCIZcxRGqCt0XKL6+gUC
X-Developer-Key: i=karansanghvi98@gmail.com; a=ed25519;
 pk=UAcbefT1C06npNVDJHdgpPqTm4WE9IhaA1fmJb3A37Y=

Convert the raspberrypi,bcm2835-power binding to Dt schema

Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
---
Changes in v3:
- Applied changes as per the feedback received for title and description
- Removed power label and renamed node to power-controller	
- Moved the file from bindings/soc/bcm to bindings/power
- Link to v2: https://lore.kernel.org/r/20241022-raspberrypi-bcm2835-power-v2-1-1a4a8a8a5737@gmail.com

Changes in v2:
- Added original file maintainers
- Removed unnecessary headers from example and formating from description 
- Link to v1: https://lore.kernel.org/r/20241019-raspberrypi-bcm2835-power-v1-1-75e924dc3745@gmail.com
---
 .../bindings/power/raspberrypi,bcm2835-power.yaml  | 44 ++++++++++++++++++++
 .../bindings/soc/bcm/raspberrypi,bcm2835-power.txt | 47 ----------------------
 2 files changed, 44 insertions(+), 47 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/raspberrypi,bcm2835-power.yaml b/Documentation/devicetree/bindings/power/raspberrypi,bcm2835-power.yaml
new file mode 100644
index 000000000000..71b3fa41c495
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/raspberrypi,bcm2835-power.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+
+---
+
+$id: http://devicetree.org/schemas/power/raspberrypi,bcm2835-power.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM2835 power domain
+
+maintainers:
+  - Alexander Aring <alex.aring@gmail.com>
+  - Eric Anholt <eric@anholt.net>
+
+description:
+  The Raspberry Pi power domain manages power for various subsystems
+  in the Raspberry Pi BCM2835 SoC.
+
+properties:
+  compatible:
+    enum:
+      - raspberrypi,bcm2835-power
+
+  firmware:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Reference to the RPi firmware device node
+
+  "#power-domain-cells":
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
+    power-controller {
+      compatible = "raspberrypi,bcm2835-power";
+      firmware = <&firmware>;
+      #power-domain-cells = <1>;
+      };
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

---
base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
change-id: 20241019-raspberrypi-bcm2835-power-5a4231be8959

Best regards,
-- 
Karan Sanghavi <karansanghvi98@gmail.com>


