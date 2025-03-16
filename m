Return-Path: <linux-kernel+bounces-563092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDFCA636EA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 19:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B57A17A6A1B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 18:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD041E5B6C;
	Sun, 16 Mar 2025 18:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyGuIn+T"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722E41C8635;
	Sun, 16 Mar 2025 18:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742149160; cv=none; b=eTbeIdUh4lze/LZCfRho12r4nmnXr1NXyHDVdUxj3i4z2Kq2+nTTrqYU+k7cdPuctPF12JFG2bW/ddmBX556V+hTSe/qUoc18FLLyj2FtuypDrozMMa00z1LeyNH0LQw64hKOH0OZx/MbqVuQiSwWeJ9xbXqMv61B/S3GN8ehd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742149160; c=relaxed/simple;
	bh=OAWctLwMdQDVOcNCm5hoBkP7a2fkK16oIvczHEI20U4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=la9s+ow2Y9fFgx7IgP2G+PtmV4YtQxfeSkYBXjTqptqDBTG7++jccYHMQvBiPf7tdRawx4imQ28vMGqU/RIIiR7WjGtfZps3JMN3We23cMqwSHsRwJFCmqdnQmqDkSuXCyFA5mHm6fxe466caDr1Xk7Z6boMRFp75TucRq+raPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PyGuIn+T; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so168553566b.3;
        Sun, 16 Mar 2025 11:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742149157; x=1742753957; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gnMpyxPQIH7YdCLtFOVkIdJffwSUtpS774knyvD88J0=;
        b=PyGuIn+TmZNhIrUe3uHGf8oRHh9or0K9ofjhVErRWOXf54EVO74elz8fFhPowc1mUG
         yMF/HeAlqrQLBsnQliBtVlvKpUOg+Ei5CEcNNbS2jFLhmDCjW3OJbivo5BcAG0PCWEAC
         nRjHUUKSMWRR3L4onuoibGsx4l4oqPFEyPIveJ6tHHf3cHcs6W5JGATvvaURXZ85e3Vh
         sFdnXdaxrgHnRQFoPXvRJAU+VXMQgdsA+lAxPzASFt7MyFVq4B+lgdbynp2oUAIzyyC7
         2zgO2ndWsYxWLxXoiKIs+ywouLZ9rSlSwJvhewx7+xNAnTGq+hvzdGszbzYnoPzsd22+
         EiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742149157; x=1742753957;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gnMpyxPQIH7YdCLtFOVkIdJffwSUtpS774knyvD88J0=;
        b=QMmYVrGPvLCxgCvEaTjOAsKEp4UDljcYHChQ1tWu2rxMYOFN+0XrqaSRnbI5kmkJO4
         OW4XqmCSdJEuxo5eilH3e9WvMSKINurZdZwFgnMoiNVUKge0eCuPAXFVrAOx7frHzFI8
         lYZ84Am2B1ZCtdyqnOsfxllRI8JGpIJ5mKYQukdo2Gds1S6xmXyPc0wzYNhdRIlS7kh0
         M8s9Z+ZpwzDiPfGYJWt5hzBcyu3qQtIBzwAsRha5UKCWoN6m5WBqRew5e4z/R5HYSM9y
         kxkQA3ZqbTctdPHsDwkziNDAB8+A+cNOYjUol6Ggt57Omppaoi7YBN6DiqBrt+eeXhCg
         MVSg==
X-Forwarded-Encrypted: i=1; AJvYcCV+ye7AYbKY1q8ZT2qpj9cnmSfmpcOUy5B5WOlFDI/Cx/8AQjqht5qW/ygbtGA8SjSXr1plO0GRoCk2@vger.kernel.org, AJvYcCXFl3agqGZEM4v/dERh6nhFyJ6KM7FVzkwaVB8tPWrs7bXAHG56dIi0a88BNRbtA+wmRx5Oo+0nyf7CU56A@vger.kernel.org
X-Gm-Message-State: AOJu0YzrL3QmOF2yii5C5gc6noiDYfDjAww42tVcbidpuM1rmwmcP6DD
	2fMzbASopRUO+GolqumBg6AGDC7seaOLkJVrq2aYKrLtsdr/gM4P
X-Gm-Gg: ASbGncsvu4KF4wTgr0vnRdJdoHjmycOUuZQ6EoKEGH3AEgwbMIXz5H9A+cwCQnDsj9N
	GipD4nKFD0Qia0t8arnPLpj0l8w4pzJ6ky0Byi/HeIadh8HDFxZePTPzcZWjUeT6x7Be3fEYASS
	q1eSuuqK7Lfivqc3P/k5OlvUk52PH3EzNHQmEkWoktkWwZlpWLT8lnoOyEFVwMeLWpO2kRXWZ5P
	vlCiJw9LnqiP2+UN6oPjhMRZ1KhTfcFaNdtdSTXrjGcCR2/qURfQmSuHNtts3ANsTRpVLud4Iw0
	v9VPMFAXpPPN/F3zKvYdoUsiZNcLRJPTmsNDIGKN54nbyMSyvdYO23u/qn4HAc+mOX81a3YXXgu
	0nL0FlF+Ixr03fYUquw==
X-Google-Smtp-Source: AGHT+IFQAhr70MJ4XwZ6DKDUDwIJn3vYtCtIUh7Dn7cupIJ8YeYxNF7Cr6QT7zLTbnqkFB/NFOs/Qw==
X-Received: by 2002:a17:907:2ce1:b0:ac2:ede5:d0d3 with SMTP id a640c23a62f3a-ac3302f37damr1115698166b.27.1742149156524;
        Sun, 16 Mar 2025 11:19:16 -0700 (PDT)
Received: from hex.my.domain (83.11.178.210.ipv4.supernova.orange.pl. [83.11.178.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a48b51sm537951266b.149.2025.03.16.11.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 11:19:15 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Sun, 16 Mar 2025 19:18:49 +0100
Subject: [PATCH v7 01/10] dt-bindings: mfd: brcm,bcm59056: Convert to YAML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250316-bcm59054-v7-1-4281126be1b8@gmail.com>
References: <20250316-bcm59054-v7-0-4281126be1b8@gmail.com>
In-Reply-To: <20250316-bcm59054-v7-0-4281126be1b8@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742149152; l=6215;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=OAWctLwMdQDVOcNCm5hoBkP7a2fkK16oIvczHEI20U4=;
 b=SYTovKYVmUN/Yga/71mRrYPExyZ0hy2UFA5UVlzIDC53yY67XKpMpsziy/MPtO6JHUGa3dA4p
 rJJ9u9LELjnA/mkQ4cJgKrgYWixfCEf/VcuE2fvhi9avPghRcBfr1Sz
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

Convert devicetree bindings for the Broadcom BCM59056 PMU MFD from
TXT to YAML format. This patch does not change any functionality;
the bindings remain the same.

The bindings have been split into two parts: the MFD binding and
a separate binding for the regulator node, to simplify the addition
of other models later (which have different regulators).

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v6:
- Replace mfd/brcm,bcm590xx.yaml with mfd/brcm,bcm59056.yaml

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
 .../devicetree/bindings/mfd/brcm,bcm59056.yaml     | 54 ++++++++++++++++++++++
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
diff --git a/Documentation/devicetree/bindings/mfd/brcm,bcm59056.yaml b/Documentation/devicetree/bindings/mfd/brcm,bcm59056.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..b387ef9885c3ac524e0782545dbca9c0e81a556c
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/brcm,bcm59056.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/brcm,bcm59056.yaml#
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


