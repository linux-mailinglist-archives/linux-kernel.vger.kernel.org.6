Return-Path: <linux-kernel+bounces-516105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D3EA36CFF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 10:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF7C83B11A3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 09:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EBA1A316B;
	Sat, 15 Feb 2025 09:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZljsxQNr"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B8C1A23A4;
	Sat, 15 Feb 2025 09:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739612392; cv=none; b=KwH8PL8ttbkmN9OzT0FVLL40lIROamxbcPWRJZWHpDunYPK+bc0hJuzZLS3HxFNpKnFGd+UC+v5cXxYZGhfDc4WyASlRUddnAxbphuVZ5NyVeqX90tbwkmA4xoRoZmN3f1/jrud1suSiPxthmuSNuC8Zi8QuMwW3kvml0kOYiMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739612392; c=relaxed/simple;
	bh=IXmy1wf9hQDBFD9ExgsaM7f4FQfMLJwJNC7wgFzoiQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T/lCkLonWo9HSk3lR/8Lro5r/P3BEdyO/IXf4E9fTqgPAeb9tjUMBJuLdp9Yng/uuC+Y+v8bDcq8NwS4MVGEhtSgXanymdLO4nFJPJKLk+m/NQbpsRRkZV47ni9es2LVnSYbED+TVjLY77MjcrYPvx5F8VUu+eeDssYjsg6nkwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZljsxQNr; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab7e80c4b55so536711566b.0;
        Sat, 15 Feb 2025 01:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739612389; x=1740217189; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=690yNEMRJUQKTJ4PZeQTvHRlaj1/iV8n9Szh8khPTAs=;
        b=ZljsxQNrI+nLimHQ55Ucsg9YDuSzOcODLU8mYBicnnj/DjxdeFasPaFY+aDAACLjrj
         jAIdv6eiLPvb+xl6qJuQUzECJ5HzUSa3PgPpKNGwf1A/eDcO39WE+jIyaxx2PQhF5cQR
         8QJoIJQ5kl6FNfoIhkjVYZcY1aGGugcTNQHv7MyOA5lZizwGFiAdCjCKBxCcWmGMTbXe
         2dTHsg6extsA5U+PPjBAsSvFLW6NKBqAX959Xsh7FEoKeTFXBATy7/YvTXeYkNFNqKv8
         ho9rzIT2095LwF2pQKlatjWcja2dzJnmahZ9wCvyF4TyGe2pzgQuYMpF6rgFWfKajDeB
         33VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739612389; x=1740217189;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=690yNEMRJUQKTJ4PZeQTvHRlaj1/iV8n9Szh8khPTAs=;
        b=Wj3rULceJZC0Zk5W52scVhxCYSEv/IJKKIV9dyoeAUOLWDDgpsfKToTWEIBPoMBtN+
         al6O7rxKpCtmEHwYjDd1MIkKfmxUuMwbXmHkJ0ATtTu/fwjYhfG7G3b1QokHMi8Cpw99
         rHC33kkSmT4jKWWLdiEv3//+OSarYztnOwFNtwve2B1RLwTHdGGNh9/IaY3ZXDHXTzCt
         AjzM1cqT0ICLMN8JX0WY6XNOT2JVnlw4SrgIB3/Eul1DbbLWcJSzKUQ0YhM58caNdjcZ
         WCcexdaIoCGsf6P6UOCwcnnnrbbGXBH9Z91q1etE88laimN0c56H4uZvJXoGMcqX5dxO
         2PjQ==
X-Forwarded-Encrypted: i=1; AJvYcCViJZAcA0t0B5JuuIXNc4aZyau8+lM+dMseLIgAJl1PFcdilYUQ5GAWZwnmuZCgje6gKnnHqI+5V2fP@vger.kernel.org, AJvYcCXbEzU4eFV/pwZIyTDzSRNN8EX5Xrj1iWaOJRti/fw43sSdEByx0FE8QoR5AQUiAOKt+aOqLnkrE4QaM2xr@vger.kernel.org
X-Gm-Message-State: AOJu0YwtkMMm2oCoblMTsKFSPo8X8nEbFfhqWE/DKPLUInKMBO7VtPQD
	oOpdyrmQcfqsr33tx5pRv936gOJqn3BTgXwcK5ePycJqcrysHYf0
X-Gm-Gg: ASbGncuYiEw79/fNHBUq/xb06vLasu8OFpbqMgzOfJOI4PFzXg1Rhed/bnKR/D1Dok/
	n3KSlP/tS9r0I8AzxSUhYS2wOmRC0nd8TaurT/7Feh5RKlsS6C2Cks1+fIYW3zcq1fDn2Ba4d40
	GSgX32yQ3MvR5gmzG76fski2PwlHK8myRc5D1MdhZkItW7GqXFZw4KiP7eJXdKrd9OcZTPXs2xt
	Rw7iQIaXTZguBn+h8t6OzNUN2VvRK9fonriOcVaAKxAHODUHrFB0IFJOFs12SfHEtrn3SVz/SDQ
	Phw0C7hAHLIiNnr9dI8PObvTetDjIDy5+1L887R35jrrFbHkBhE+Rv4fO/P8GA==
X-Google-Smtp-Source: AGHT+IGRt2lvRvkQVFVRuLTCOx2v96wzbj/nYz9InSF2pKokdGYUIbB2j6Hc4x4sHep58Tdi8XfSoA==
X-Received: by 2002:a17:907:60d6:b0:ab7:ef48:1668 with SMTP id a640c23a62f3a-abb711c382fmr182639366b.57.1739612388994;
        Sat, 15 Feb 2025 01:39:48 -0800 (PST)
Received: from hex.my.domain (83.8.115.239.ipv4.supernova.orange.pl. [83.8.115.239])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb7aecd3d5sm69698966b.148.2025.02.15.01.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 01:39:47 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Sat, 15 Feb 2025 10:39:37 +0100
Subject: [PATCH v4 2/9] dt-bindings: mfd: brcm,bcm59056: Add compatible for
 BCM59054
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250215-bcm59054-v4-2-dbfb2d76a855@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739612381; l=4241;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=IXmy1wf9hQDBFD9ExgsaM7f4FQfMLJwJNC7wgFzoiQw=;
 b=3QR9JLkpHbg4uaWGeMx5lFIUF/L+fawYMGrzvwrd6dbSkAWUuSKciSpG+f8Cbbmy6ugqiPH4c
 KA+qlzshrURDqljsyhSBh663jbW0DV+Vev80QfCFzLJcnMF2j16hDOs
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

The BCM59054 MFD is fairly similar to the BCM59056, and will use
the same driver. Add compatible and specify the allowed regulator
nodes.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
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
index 0000000000000000000000000000000000000000..5b46d7fca05e21aa1eae991b5f9f60b444f20c1c
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


