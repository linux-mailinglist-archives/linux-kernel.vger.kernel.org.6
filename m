Return-Path: <linux-kernel+bounces-516104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A516A36CFD
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 10:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B2F3B11B8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 09:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F501A23A1;
	Sat, 15 Feb 2025 09:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtaYXBTR"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D8F19D8BE;
	Sat, 15 Feb 2025 09:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739612390; cv=none; b=P2d55XkOj7l1H/mfo1nDTnUnmRDcGdLNib9R57dqCcws8Bjwh1qrfsE4mtQvPb/Gyeao+dGeP9Fc1YFz3XqNRW/FKFg9LvjVaOl+o8mMAUzZMwdiNxqUvUcD/6mElPa+j94/Wa+RRSH4JhSN4uCJeXEyjj3RtGiXvKxEyKp89iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739612390; c=relaxed/simple;
	bh=IcV7ywoevjGD2Ny/Tny5tgvm+/Z9vNz3mjswQsgUrAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ObJ+Hqlm6gu4mjapAJwj/D+qQDPaYqZJFqPCUnH7QupBA8mP9X8ZMfaFtY+Vo55G19bqBFhSYQlaSdXXksk57wQfM+WWTY/MYX1xA6K7Bc+Y8bQrW1g5uJRUtZSWIdqdmpSgIWBZgPx6maC/Y+bJ1NgH6nP8FPRblUbTloFIcYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtaYXBTR; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaeec07b705so460216866b.2;
        Sat, 15 Feb 2025 01:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739612386; x=1740217186; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zBy5hLuEmKlC/echdm6iJKgyIGv/+KLaA0/xc/ZzmQQ=;
        b=CtaYXBTRygSyvAIogRFORgbLmxf4x5eydrQMldKY/qpBj0ChhIx78QkYKuXiK7xY0x
         LhafhjT+uyFbXn3VG/pb2bC4HbBrO8HkZkKxAsRzz0wtTY80AugnXIzSr5yFkrvjdEyL
         iCSq5nf1IDoVq/xool66Oa143UHv2yC2ixRv8+6ZaVMe4dtl5OUejmQ/vMHIOeVAt9m/
         1S4L4fgmQRCHkQl4OebvG7oaWbGVYZPYBA7wYUGaJdKsnYlXlIraQbkvLgw4A3mqEXlC
         F/dJXosk4iYbvOGP9b31lKd53HeCndw2A+9CndQ8Lxe+kjyVj8yeMxAFmRTHfHjBpr58
         oxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739612386; x=1740217186;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zBy5hLuEmKlC/echdm6iJKgyIGv/+KLaA0/xc/ZzmQQ=;
        b=Betisnvez5FmL0O1om78WsWcJV14RxU6zrHy2Dtg8iaCIoB3HK/yz3O4BMAY5wrzua
         VTctoVOAIBa8pFOMQqgLZE7Fv4T8X5aT4nRkvVe9feqLt44lknk8e/Pmm9bYRAcWpIWP
         7qetVnZeNaqT7b4TsT355PxP8SLLla9FAApt1s92GbbsQRgOY5VE30IOFEaRUcScRz/Y
         Mnl5L8nObUwtEVs6gJqyts+Yk+zCd2oY0wlY/skVGEi57K/YAo7Gidu4mqg/Q4kXPQh5
         2LkbuUuKpzYr3mEtPAkdLvSWJhwF31ckIToeqkaRLXCQDu7nqLWqw02T3YGIE47ldCBJ
         TFtg==
X-Forwarded-Encrypted: i=1; AJvYcCVcml5Sml6j54X9x8ikSRLBmY7ml3ijtPdlNaNYYLiFKlXqJRkqZUJbwo02fvgbrYVTulzA4f28wxafAge9@vger.kernel.org, AJvYcCWXiOTnZwjheGv3zlgwhPY03h54KWqF0s9nb1HQVXYXyMnglOqa21fJI8IU0CuLWKpsXBJ78ti957+j@vger.kernel.org
X-Gm-Message-State: AOJu0YyH7L3566AORQzC51QSEU6mdkZL1NECJz6a8eblJGaMSKFHOvxO
	Iy9j3IT3jD6a019PrdvUeyvLjVDdel637kKgF4IZNfMGnu54Cho8
X-Gm-Gg: ASbGnct5UtOKaMIP0YT538N+R3xMAF79QQB6UhQuPDKDvjHBYfArUqiNR3wFllxeMar
	WlZutgyxdoEkxgFtNhtU1UhE3WoRpb3TmMX1BRhcq4x++NdbO1DSfMIdErrA9J4CB+FV38277pQ
	ZMTpsTtyShOsKgg47ht6iD1ITyAWi7dzff7zLsCrPPa+DM8ugg5N/IJUeHfyc5H1/JXdVSd8xzM
	OwGNSTyKoqILzlmjyZTflin0uaqph+MlOC6tz20pwoXLsB9tHigQ08Uz7vIaWpyxyyQn1NwcEBf
	OUwXAZrXL3e5WczvCliMYN/U45mS66F0KD0p6me246m6SVsxJY4NPpH7ECbIvw==
X-Google-Smtp-Source: AGHT+IGSYJkhJaodpX4MgIKP7KaGkoGAYEgkdgutm+iExs8hhepyEeN6TVJ40HgRYdf+U/gPIzi/uA==
X-Received: by 2002:a17:907:7fac:b0:ab7:cc00:4d4a with SMTP id a640c23a62f3a-abb70d95cb3mr188795166b.35.1739612386292;
        Sat, 15 Feb 2025 01:39:46 -0800 (PST)
Received: from hex.my.domain (83.8.115.239.ipv4.supernova.orange.pl. [83.8.115.239])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb7aecd3d5sm69698966b.148.2025.02.15.01.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 01:39:45 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Sat, 15 Feb 2025 10:39:36 +0100
Subject: [PATCH v4 1/9] dt-bindings: mfd: brcm,bcm59056: Convert to YAML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250215-bcm59054-v4-1-dbfb2d76a855@gmail.com>
References: <20250215-bcm59054-v4-0-dbfb2d76a855@gmail.com>
In-Reply-To: <20250215-bcm59054-v4-0-dbfb2d76a855@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739612381; l=5969;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=IcV7ywoevjGD2Ny/Tny5tgvm+/Z9vNz3mjswQsgUrAc=;
 b=S8zVcz8GHgsSLyd5yZzQ07s18OFI1j29J+V4Py9MMPHcU4NHAsLt9lQ9GhhXaxGOzklJH5o9c
 zDTC1K3oYroCJRxHPpEujCsVulhKCsphpPEnTuNzf/TStByuEnEYwvc
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
index 0000000000000000000000000000000000000000..7a5e36394d216232e0a2070fb20d09dcc1ea8056
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
+  See Documentation/devicetree/bindings/mfd/brcm,bcm59056.yaml for
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


