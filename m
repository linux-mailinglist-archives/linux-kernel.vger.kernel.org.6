Return-Path: <linux-kernel+bounces-526579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4939A4008B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFAEB425977
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD09253B7D;
	Fri, 21 Feb 2025 20:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpZA5vmH"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0922F253B43;
	Fri, 21 Feb 2025 20:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740168999; cv=none; b=mReDBYprB1kvKxVfK+B+RwA26Us91Q26EuSTItqRHwulLMAdpKtsrUY1rFlafYrJLpUnxSzWORjeHStUMQglgK5Csab97raCdsWDY+YRjix0ulh+LR3z2eZ+wLLYVKc8lBgoGbv7GnKXqoiULW5SKWlasLnpbhWTsajOA05i3jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740168999; c=relaxed/simple;
	bh=PpEuTiDGyKp+riMoN5kE+7sYmjtJ+zWPti/YD+YCl7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OUF2l8T8BakttEW/wJlP+adV52mZsrMkQ3wYOD6oAxDBWGtvd1fs28GpwJXgjjID0Ip+qIwEK7CMzF69POX7S7NVDFWcX/PrmAkpjIra/Ljbhv7dnGOqlq7+FzbR9ngwF127LrBIw4Hi5cbFjjYhUp5ttTAnOvR6HqJlIQRjn4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpZA5vmH; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e05717755bso3711956a12.0;
        Fri, 21 Feb 2025 12:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740168996; x=1740773796; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZSkEhYKCv8Go9C/M2e6tKoaoFex90ZI4uQi8Tl4I0s8=;
        b=KpZA5vmH9LyYZm2K592oG9f8glKNxCRswZrxdYoLxif8NV7T+EauFlXZHw5TywCQsK
         1R2mTN0HLCrYljZW1kfzjadHpXA0rEvP9i+3BrA9QeejyfLH6A4bRpx3QE+pJMpsg3ij
         y8rpXb6DskcKi7LQVWBTREU5/iwVaahfD25Xdf3I46jTJnGz50EyX4r93Nh/65ZBxIdO
         +GXtM4XnoJ14AaoW9drIPpjv6w78+qGnZFXC4ULvfZ/mYPwW1UlvP5iyUfRHHxpjQLrz
         KdaGno3MjRkz+YiyHcCmw2/nLNDV8hJLQA3r1AKyyeDwoCNOYgY8lWqMwklqqslXGkAi
         GWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740168996; x=1740773796;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSkEhYKCv8Go9C/M2e6tKoaoFex90ZI4uQi8Tl4I0s8=;
        b=ETTW2hC859gb0pluztksI4m+k65El1NNd1YgQVlETFYrrx8Vx8TMsbU3+9we8j3qpJ
         N5H5eLcG7y+pjsZmo/wBXVE6AHp6Z4p+jBO88osmQ5fwQCYnUDhzMf1Lw6n9R/SdMTwB
         FjIfWnSQInqMKapTUfo1Z6wOZVeA8EsuTxaHqEk2+H4AkEgkien/4SxVC4WyrgYX9p+r
         0NT3q5hFMcDn7bFl2HYJwSqgrssryHrfQYUiCFVC9q/XlBgkcCVGs2A9S9WMugF7PEAJ
         cqZrBOsueQLK7b5GhYr11MevtatsSr6IIi0U/6YQs7zAkDaJFyy4qzvA/Y8iCCT9LnLd
         e9XA==
X-Forwarded-Encrypted: i=1; AJvYcCVQVIXwsU6nKO+lYWe9B9NWdegA7kHRt0VV60eeyyaZPQOXdVEV8ejlqUec3RhpMkvB6Sz/x7K/shdx1uzg@vger.kernel.org, AJvYcCXZ/8MaobdXcnHOAmvOdh67wkNwBUfcCvIWoN9XfAAAAK/BFbFIpMOffycutKgS4XirTYnj2oE0LkyS@vger.kernel.org
X-Gm-Message-State: AOJu0YzVQBjdE6DOiNTrBqwS3HxLP1W5yV12h85C7OneZmEssnYmITXD
	TYxWkCxUTLScOVhOBoo9q7Ho3JELUxs8vSz+ZBPFF0LIpj/N8bD3
X-Gm-Gg: ASbGncuMzkZI07E8MI0yDZHUusJM27W+xRfbYFHbOoNYQGkC6pyBAg4Ya4J4vLOTN17
	W4hGnijYzbaRnwoPORzm3VmrnwLyJrB+1Gc1o9VgCJxeZakF1ahJaPCwf024pgfBgsdlIkT/DZ8
	/YEgacZA6WALboeBYRVnuqrHKMBQubeyJi/IJBIZNw/fdHrR+j3ucDERvZjhlN2GsYh5mDwOtK+
	EFE1TJQg55lS1zCmTCQOcI3Zcl51mmZYd+XxPnnUwRC46snygsO6P1OcjYZsurJ0KmmgErZautk
	F68qsIkhW56AnlBcju/2ppZM+PN9cUq9OY5Gdznp/JHi4trwGbODeglsK2aKZABx6I7q8BKq
X-Google-Smtp-Source: AGHT+IE3uy7e74Z+u31T7KVhBW39R/G/jwJ66ELMVXMdLTdk27vCWM5ELOuSEcxzux/nU6WaQzSBgQ==
X-Received: by 2002:a05:6402:101a:b0:5e0:40e9:2383 with SMTP id 4fb4d7f45d1cf-5e0b722a4b5mr3770628a12.24.1740168995996;
        Fri, 21 Feb 2025 12:16:35 -0800 (PST)
Received: from hex.my.domain (83.8.202.192.ipv4.supernova.orange.pl. [83.8.202.192])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1b4f70sm14127594a12.12.2025.02.21.12.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 12:16:35 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Fri, 21 Feb 2025 21:16:24 +0100
Subject: [PATCH v5 2/9] dt-bindings: mfd: brcm,bcm59056: Add compatible for
 BCM59054
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-bcm59054-v5-2-065f516a9042@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740168989; l=4358;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=PpEuTiDGyKp+riMoN5kE+7sYmjtJ+zWPti/YD+YCl7g=;
 b=Gmgtbs2dSEuOcE/E/9neeGN7eQA4y5mZYwJNY7hTrjcBSfGkknk3ODpPp2cZR3RQsCkS/Mprs
 UU4jA7rnGQ1BMt7AlEVlDfAKZR4LKTlWuP/KVKJJOMCTBbItcnOuDB3
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

The BCM59054 MFD is fairly similar to the BCM59056, and will use
the same driver. Add compatible and specify the allowed regulator
nodes.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v5:
- Replace mfd/brcm,bcm59056.yaml with mfd/brcm,bcm590xx.yaml in
  regulator bindings description

Changes in v4:
- Fix yamllint errors (missing unevaluatedProperties)
- Drop comment with regulator name list
- Use full schema paths for $reg
- Change description of regulator binding to mention BCM59054
  explicitly
- Drop quotes around vbus reg name
- Change "Power Management IC" to "Power Management Unit" to match
  official Broadcom naming

Note that I did not end up moving the regulator refs from
allOf compatible matches; I explained my reasoning in [1].

[1] https://lore.kernel.org/lkml/ab853605-859d-44c6-8cbd-44391cd677e6@gmail.com/

Changes in v3:
- Split regulator node into separate file
- Removed quotes around compatible
---
 .../devicetree/bindings/mfd/brcm,bcm590xx.yaml     | 26 +++++++++-
 .../bindings/regulator/brcm,bcm59054.yaml          | 56 ++++++++++++++++++++++
 2 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/brcm,bcm590xx.yaml b/Documentation/devicetree/bindings/mfd/brcm,bcm590xx.yaml
index ec02486978efdc66846b33963f075b79184425fb..d9977091e9da2055c7ee1187210aa03844385971 100644
--- a/Documentation/devicetree/bindings/mfd/brcm,bcm590xx.yaml
+++ b/Documentation/devicetree/bindings/mfd/brcm,bcm590xx.yaml
@@ -11,7 +11,9 @@ maintainers:
 
 properties:
   compatible:
-    const: brcm,bcm59056
+    enum:
+      - brcm,bcm59054
+      - brcm,bcm59056
 
   reg:
     maxItems: 1
@@ -21,7 +23,6 @@ properties:
 
   regulators:
     type: object
-    $ref: /schemas/regulator/brcm,bcm59056.yaml#
 
 required:
   - compatible
@@ -30,6 +31,27 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: brcm,bcm59054
+    then:
+      properties:
+        regulators:
+          $ref: /schemas/regulator/brcm,bcm59054.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: brcm,bcm59056
+    then:
+      properties:
+        regulators:
+          $ref: /schemas/regulator/brcm,bcm59056.yaml#
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
diff --git a/Documentation/devicetree/bindings/regulator/brcm,bcm59054.yaml b/Documentation/devicetree/bindings/regulator/brcm,bcm59054.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..5404a15884ebc910924614ea49d18ec87c8638ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/brcm,bcm59054.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/brcm,bcm59054.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM59054 Power Management Unit regulators
+
+description: |
+  This is a part of device tree bindings for the BCM59054 power
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
+  "^(rf|sd|sdx|aud|mic|usb|vib|tcx)ldo$":
+    type: object
+    $ref: /schemas/regulator/regulator.yaml#
+    unevaluatedProperties: false
+
+  "^(c|mm|v)sr$":
+    type: object
+    $ref: /schemas/regulator/regulator.yaml#
+    unevaluatedProperties: false
+
+  "^(io|sd)sr[1-2]$":
+    type: object
+    $ref: /schemas/regulator/regulator.yaml#
+    unevaluatedProperties: false
+
+  "^gpldo[1-3]$":
+    type: object
+    $ref: /schemas/regulator/regulator.yaml#
+    unevaluatedProperties: false
+
+  "^lvldo[1-2]$":
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


