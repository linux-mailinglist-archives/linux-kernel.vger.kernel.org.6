Return-Path: <linux-kernel+bounces-526578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8009BA40088
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BFF97AE529
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6392253B5C;
	Fri, 21 Feb 2025 20:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvbEHVRX"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13698252916;
	Fri, 21 Feb 2025 20:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740168997; cv=none; b=sPsecZJZsLv6Y+MdM7C/cqkjk6q0iH47hC41NGxMACHQ/P/LsVITsiO4SEf9fGAiuemk/w+qAOy8Yiaf3StpW/0X01QpoIlOrDGNmND9ZnBt/hWeVx3pM3iK/VxvctwlhtoKKf1rG7SQcvZWuwFHuenx7nQ+my/TNble89HFmXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740168997; c=relaxed/simple;
	bh=nmZOfdFUCwQJVeMBIfyxFyv13V4skfJRGlmbbAjd1jo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xjlx6T/4My66jtoCc78Ksw3HjUF9NE8iVdRzrL3fUBEevCdapE8HutV74VWVnfvFjVKNdwVanGhBwQ/N5RSd2FU/JwEd6tcE9Lk9JVydSIs4iO/k0B9NRY/uT+x1L4WtiPs20BYH4ICT288c5KBYWdEvp5kOg68MUnLIKJXPJbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WvbEHVRX; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e058ca6806so4599740a12.3;
        Fri, 21 Feb 2025 12:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740168994; x=1740773794; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zE4KND447LgUw6NsxZh9MwKO2XkGq/PSQxxIzCwavvs=;
        b=WvbEHVRXYv5XMd5vj2Q+PGDxCEytrpHT0q9+Ss5JIRbgrdmIz3dYVVMP66F/zeOAVE
         L2l92hQFxy/wVt/vVoWYtwdTIUb7Oo64RFL3mVBUgBOA9Qqb9WEQJoK5Ky5tA5rcDaYV
         f5PtAXZreDneGyye31xZDSwTbu3hWTFMWaV2sHB9nVmsHfE3kEGi7pynXCQVTWpd+eER
         OIux5aLOmdZpr80osAzl+biAHCu5Njgpj894dE6lm9QDe/gigFP69G+07kgk1lMQ52Nc
         3fd4mK0jenG/Z8V5eU1gM+R3OhaEaPAgXXO3QESavI9ECq4xj7O4yWGi7mxsJKJzIZZz
         iPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740168994; x=1740773794;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zE4KND447LgUw6NsxZh9MwKO2XkGq/PSQxxIzCwavvs=;
        b=POyP2cXeHLo2bR+6vq0dNyEddC1iFuAcbQsY/MpVPNVa2vSXScJ0o1qW9BazngJiMb
         TbSuPGsg9aWmOwfcT2FegtzR+XF/vnC4N1wJNWCNqs1SwQshkQ/UwxPThnh9gpDPdvRs
         LG1RkPDpcrlXNa+fxN8/2LiAgqlTQWsAz2ZYygZDl/QEPb3c8vVT6x16lBr8r0YppGIO
         DoP8YQAa9r9uv48++YYJBZlKYsJKNwpbG9JNbpKhaXCy88G01iE1jzWqrG54Xsn6gMBV
         M/HrgWxg+8Myt0wanwv2hd5xqeHH59fpTkpyJpliQrG87wS0CKrrUgYLVUuXxIhhjCHv
         jBVw==
X-Forwarded-Encrypted: i=1; AJvYcCWF9EjLxlnkukp9nsnDQkmYpF5esMHg8MnKPLvYMjcezU+2caGBNVECFi/uxcVAqcKa5aqtgHy8bJLP@vger.kernel.org, AJvYcCXppV2z4T0BeJIIhAqlCMZUmnhuZBBT9VWMe7ewQFVS+0/Sb17yX78OGLIfNEKxfm8dryqWp2OtMrJzsB7t@vger.kernel.org
X-Gm-Message-State: AOJu0YwrAxU/gyua9zcbhcBuV5ODkN0gKGJB8QdpPt+v4B/NPUX6MDA0
	g3lqUYUOEVDM3S4GPDLvrCRB3hHMFZ/2PtsuX7mIxMWNC9bSpY3y
X-Gm-Gg: ASbGnctHt+qUsv+O8gPw38lNi3h1vSwjbzGr4eHpAld24N8xwJ1N+HdQl+4zfWwCVYa
	YR5eqIr+3iaiTIb3Le6bvRNZ5s4iS0nbuvuqMrohn8BmOGSOWgImj7x609arCDoH3mVvRIRMs2J
	kmduGYQkttqZcKGPq/Vn1UGdJj3ShVnmX4VlhFLRjUmhHhnLRGa7z38803+dyzEZJInxcpguZvr
	AgCAkDFI7q5ctC3+ku76bJxZ0G5PP/H3+Fs7KvanCKpFFIgYsNp+1L0YZ+SGoDx7bZ/ZDxZo7Ow
	VWF3tfsX4Z1z3BX8ui8Hh6FL4PR4hKHRrLR5cGeldEXPX4znNAx2IMU4kYpPJDfFitt812jQ
X-Google-Smtp-Source: AGHT+IFX05K/jG+cWowFunxMbqT7q2fbRvvwU1JNDBdJ/7CLMJP5qJ37WUbt1Vd9vQQuR8wQXi2hKA==
X-Received: by 2002:a05:6402:540c:b0:5e0:7d9b:b15d with SMTP id 4fb4d7f45d1cf-5e0b70e9cc6mr3954275a12.9.1740168994066;
        Fri, 21 Feb 2025 12:16:34 -0800 (PST)
Received: from hex.my.domain (83.8.202.192.ipv4.supernova.orange.pl. [83.8.202.192])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1b4f70sm14127594a12.12.2025.02.21.12.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 12:16:32 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Fri, 21 Feb 2025 21:16:23 +0100
Subject: [PATCH v5 1/9] dt-bindings: mfd: brcm,bcm59056: Convert to YAML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-bcm59054-v5-1-065f516a9042@gmail.com>
References: <20250221-bcm59054-v5-0-065f516a9042@gmail.com>
In-Reply-To: <20250221-bcm59054-v5-0-065f516a9042@gmail.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Stanislav Jakubek <stano.jakubek@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740168989; l=6085;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=nmZOfdFUCwQJVeMBIfyxFyv13V4skfJRGlmbbAjd1jo=;
 b=kV88aRiFrJaiMp2uj3F0vpqgIlO/PTVpbJafJAesj1M/RWXR1sSbCcvfXaY7USoPvz9fR7pLi
 T90ssPdZH6DCMPrUWi8yxGYWVFMypTQhVoDEUyISfk9hVsmQmJPhDr/
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

Convert devicetree bindings for the Broadcom BCM59056 PMU MFD from
TXT to YAML format. This patch does not change any functionality;
the bindings remain the same.

The bindings have been split into two parts: the MFD binding and
a separate binding for the regulator node, to simplify the addition
of other models later (which have different regulators).

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v5:
- Replace mfd/brcm,bcm59056.yaml with mfd/brcm,bcm590xx.yaml in
  regulator binding description

Changes in v4:
- Made $ref use full schema path
- Cleaned up example
- Dropped regulator name list comment
- Changed description of regulator binding to mention BCM59056
  explicitly
- Changed "Power Management IC" to "Power Management Unit" to match
  official Broadcom naming
- Renamed mfd/brcm,bcm59056.yaml to mfd/brcm,bcm590xx.yaml

Changes in v3:
- Moved regulator node to separate binding
- Removed quotes around compatibles/vbus property
- Style fixes for example
---
 .../devicetree/bindings/mfd/brcm,bcm59056.txt      | 39 ----------------
 .../devicetree/bindings/mfd/brcm,bcm590xx.yaml     | 54 ++++++++++++++++++++++
 .../bindings/regulator/brcm,bcm59056.yaml          | 51 ++++++++++++++++++++
 3 files changed, 105 insertions(+), 39 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/brcm,bcm59056.txt b/Documentation/devicetree/bindings/mfd/brcm,bcm59056.txt
deleted file mode 100644
index be51a15e05f926913b3a473648d977b25f1a2fbc..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/mfd/brcm,bcm59056.txt
+++ /dev/null
@@ -1,39 +0,0 @@
--------------------------------
-BCM590xx Power Management Units
--------------------------------
-
-Required properties:
-- compatible: "brcm,bcm59056"
-- reg: I2C slave address
-- interrupts: interrupt for the PMU. Generic interrupt client node bindings
-  are described in interrupt-controller/interrupts.txt
-
-------------------
-Voltage Regulators
-------------------
-
-Optional child nodes:
-- regulators: container node for regulators following the generic
-  regulator binding in regulator/regulator.txt
-
-  The valid regulator node names for BCM59056 are:
-  	rfldo, camldo1, camldo2, simldo1, simldo2, sdldo, sdxldo,
-	mmcldo1, mmcldo2, audldo, micldo, usbldo, vibldo,
-	csr, iosr1, iosr2, msr, sdsr1, sdsr2, vsr,
-	gpldo1, gpldo2, gpldo3, gpldo4, gpldo5, gpldo6,
-	vbus
-
-Example:
-	pmu: bcm59056@8 {
-		compatible = "brcm,bcm59056";
-		reg = <0x08>;
-		interrupts = <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
-		regulators {
-			rfldo_reg: rfldo {
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <3300000>;
-			};
-
-			...
-		};
-	};
diff --git a/Documentation/devicetree/bindings/mfd/brcm,bcm590xx.yaml b/Documentation/devicetree/bindings/mfd/brcm,bcm590xx.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..ec02486978efdc66846b33963f075b79184425fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/brcm,bcm590xx.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/brcm,bcm590xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM590xx Power Management Units
+
+maintainers:
+  - Artur Weber <aweber.kernel@gmail.com>
+
+properties:
+  compatible:
+    const: brcm,bcm59056
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  regulators:
+    type: object
+    $ref: /schemas/regulator/brcm,bcm59056.yaml#
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@8 {
+            compatible = "brcm,bcm59056";
+            reg = <0x08>;
+            interrupts = <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
+
+            regulators {
+                rfldo {
+                    regulator-min-microvolt = <1200000>;
+                    regulator-max-microvolt = <3300000>;
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/regulator/brcm,bcm59056.yaml b/Documentation/devicetree/bindings/regulator/brcm,bcm59056.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..9e0cddc0f1116bbf1ec03826ca7758f4311a67c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/brcm,bcm59056.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/brcm,bcm59056.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM59056 Power Management Unit regulators
+
+description: |
+  This is a part of device tree bindings for the BCM59056 power
+  management unit.
+
+  See Documentation/devicetree/bindings/mfd/brcm,bcm590xx.yaml for
+  additional information and example.
+
+maintainers:
+  - Artur Weber <aweber.kernel@gmail.com>
+
+patternProperties:
+  "^(cam|sim|mmc)ldo[1-2]$":
+    type: object
+    $ref: /schemas/regulator/regulator.yaml#
+    unevaluatedProperties: false
+
+  "^(rf|sd|sdx|aud|mic|usb|vib)ldo$":
+    type: object
+    $ref: /schemas/regulator/regulator.yaml#
+    unevaluatedProperties: false
+
+  "^(c|m|v)sr$":
+    type: object
+    $ref: /schemas/regulator/regulator.yaml#
+    unevaluatedProperties: false
+
+  "^(io|sd)sr[1-2]$":
+    type: object
+    $ref: /schemas/regulator/regulator.yaml#
+    unevaluatedProperties: false
+
+  "^gpldo[1-6]$":
+    type: object
+    $ref: /schemas/regulator/regulator.yaml#
+    unevaluatedProperties: false
+
+properties:
+  vbus:
+    type: object
+    $ref: /schemas/regulator/regulator.yaml#
+    unevaluatedProperties: false
+
+additionalProperties: false

-- 
2.48.1


