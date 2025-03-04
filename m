Return-Path: <linux-kernel+bounces-543272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E08A4D3AF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC543AE4BA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B701F5619;
	Tue,  4 Mar 2025 06:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2losxkp"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F700152E02;
	Tue,  4 Mar 2025 06:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741069249; cv=none; b=rtn+4FKVb8qREQHapv9hQY0fuleOE5993XTiJydKwKHpdEu5p7zauInrfr9whxsX+l/JeDdCE/6gee1xwg8YVPMHocy5/Aswg7C2UdntcWzcWZqlLKi2TaFPQQHPS5Ol07mVce538LQ4imgnGAA0seCoyzwP/sdpVxy/APkXF94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741069249; c=relaxed/simple;
	bh=OKN+CN2A+d56Fb66yEYr6DNfAWGIXyqUrcezaW0HQS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gQCJnraAl+kxTe8Kizjx8nisEgzivKOfJSUwNuNjyWrLwjA++0pCrZlt0XKP7CkKwIVDO/j5hX0j9B9wPb0HFA+JKP+nHrA7yDyYRYe3ApPUxitsVWH22NJPnOuEgfczoUZy/Z/JrtMLo85y1Tn5p42IRzcVzFI3gFRiVr+LlDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2losxkp; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e4b410e48bso7943221a12.0;
        Mon, 03 Mar 2025 22:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741069245; x=1741674045; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Uy9CppE4fbZwaD1unI2/hAAzqWfqC2phH0FTdQH/0A=;
        b=W2losxkprva7MlsCOBUt2EiwWbqk0QqCutBN09M3otvu9VeJkhGWf6enWzT/QVsWqC
         fR5Z3fw0W/ONhez/zZRDEyhNspvl3BgslPvRn4zr84GnmOg8jzQUFTWqxI+FyGQsSVbs
         dE3aQto2UHUyC6xANMAufMwirIEeJSS1MuO/WIRIL8S0Br9nGc9WcIU06FRukobRfGjU
         begF17g4Fc7UtaDxzQzEMWGMiKYQFhDqYXE2V7ZPm5gEjubXXxuvEPyVR3JtzSSENO1S
         LUXF9zpboX4M/JAn6Wamq8iqgN/8veYWCB8JU70EHCLNlBXAsizlVIc6ZdIK7tGTINjf
         cS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741069245; x=1741674045;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Uy9CppE4fbZwaD1unI2/hAAzqWfqC2phH0FTdQH/0A=;
        b=bziBpHtAFF86wDFslO0qXdCRIeOIVL+Rzdvk2Dnys+rFjp7TIBv1lFfR8ofCHwK/LA
         xLZDSuRR0o08VHij3GW6Im+yEzGC/wwEKTo46O9LjorP3HSkxBErDN/sNs54HPZ6sjl0
         6b/ek7zwKKXcBqyKygBDAO2i02TWy7t8rq/rYIsS5Zpe5WZ+EU8cfJJPnpOaBoXzXLzY
         gGYulXOIqPBdcY1DwAvUiPxo007Cc7ucFSYCRt8QAaDnhi7RbcHDfpRmLX605otLIktg
         +HajcZriaibkbGIj5RAB3rbpaqne7FbuOiF9RxPIhH2BtX45Emg+3DoIpvpPXmmU/hrl
         /6vg==
X-Forwarded-Encrypted: i=1; AJvYcCUKFyRmpXVlTnSJpvABtrb0EXNTXXMOxNtI2nkA8vWofBPCNHtbG+x+6XwlRNM3wP9wzF8NY+2oKiVv@vger.kernel.org, AJvYcCXbrysoewoDsWdaK85rR4wQhVM7Es520E+bCNktyJjlpXCb+MANL/Cx5ZAEcFrP28D2do4oVCz5DulphBx7@vger.kernel.org
X-Gm-Message-State: AOJu0YwhREHxM6doWQ5yA90Gwt73vcYVPb59inufwwDqMh2qV+05TqTM
	sAnNK0Seu7xEpJI1Z6hl4rwzPRVzCxwjSUiq6E0KnDF5qnP4GZAM
X-Gm-Gg: ASbGncs7yXvtvxejzp20N7GGi5LpuSDhXq4i6TfTqGUnKa5AKRTPYVQyKpPVxmsaGGl
	/psxFxKwGCYyeuPHJdCw2jvUe1D9vNvr4ysyp6kToOWxHV0Kv4+D8uCrGIxCz48rBVAYjwk+ddY
	RJyOoTBzfnGPM/vYZ8gxwsmXl/F0aa1ME8WHgd8+aVhW/z7vg7gaj3NwQf8B338TFKDIqY4Z2ma
	XdtwHc7rpht/KX9Y27SWx06NcDgeeeP4OOlBWbL9AT2v9RzcpdHypL3wTujyJwXS8IYoymbE23A
	D3GagTjz4fw73zzvRkGmuhqgRC9DJdMA0yt1XDuq3KILzVnquUNqmHFZVxSwl1CiaitAD46dye3
	Dx4danoT6aE40i7Q=
X-Google-Smtp-Source: AGHT+IGLMAjQYLVLVvGSKN+OkUAaJuck5uuxbpRXNQWss39rcpICZpsaoCC9ihIlGISZaUMMIf1qeA==
X-Received: by 2002:a05:6402:5194:b0:5de:c9d0:6742 with SMTP id 4fb4d7f45d1cf-5e4d6ae8552mr17478973a12.9.1741069245106;
        Mon, 03 Mar 2025 22:20:45 -0800 (PST)
Received: from hex.my.domain (83.8.122.142.ipv4.supernova.orange.pl. [83.8.122.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c43a663fsm7609036a12.68.2025.03.03.22.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 22:20:44 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Tue, 04 Mar 2025 07:20:32 +0100
Subject: [PATCH v6 01/10] dt-bindings: mfd: brcm,bcm59056: Convert to YAML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-bcm59054-v6-1-ae8302358443@gmail.com>
References: <20250304-bcm59054-v6-0-ae8302358443@gmail.com>
In-Reply-To: <20250304-bcm59054-v6-0-ae8302358443@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741069239; l=6165;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=OKN+CN2A+d56Fb66yEYr6DNfAWGIXyqUrcezaW0HQS8=;
 b=Sz/TenvJJpGfls0lmsRYFKWaNtab/Ze4zaOPu0banvBFS64h1ePKoPTxx4EostmqPi9bFbd0S
 nHD58RwkgGED3Mqqw6qt2mrjs70t2+pZPVeCH/IdUZxafLHzIaLl1uX
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


