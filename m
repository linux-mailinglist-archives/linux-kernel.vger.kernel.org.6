Return-Path: <linux-kernel+bounces-563093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0F9A636EC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 19:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44BD3188F2E8
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 18:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496711EF0B7;
	Sun, 16 Mar 2025 18:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODuy/eit"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50241E1E1B;
	Sun, 16 Mar 2025 18:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742149162; cv=none; b=LynXLT8T5k1EZ4t9qPCIN0wm4q8DSf24bCQOALvl9wtrmMWyncxnWyISPJpog1f3DaaRSW7g9A3D8xv/svLtlt4soDOH9XViscuIXgdb1Nd+eoeKsFNFD7OboXACJs5tlii3mcIOatm8thkP72v3PbnL/DhrjVjYCeOFMsBcyCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742149162; c=relaxed/simple;
	bh=dm7aREBrSuogWhHL7IYSSu3jO/9Oq8Tet0hiRF+dXhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j856iCP2mFTy/B3hXU/HaOoDjfIa+Z9xCvteoAMG33cW1YckOh+gX883MhksZ/2l8u2XL+OIWXXohOhwxkBucL3F1CY+1keRfZWMNhGlf6wlax69tFhON9WggIDHpmP9eSfaa5EwKeiqe5uvzhBzp2u25qznFOFCn/G/7RvENN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODuy/eit; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso705317166b.3;
        Sun, 16 Mar 2025 11:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742149159; x=1742753959; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a2a5kh801vl9iToE3scZElc09JqjoduUAaLOK7aaGhA=;
        b=ODuy/eitaiNa3dwk6St4QMs78JsFuWWU8gTJGENpic8B++zLP1LagpujD2B3WpSNCZ
         WpOjxLPZMXPQh7Q1LATj3DjOtxOyUiadMAR9RqzMkIQlPeECl1m+Ph6PIA0E6Mpol5Ux
         TPDUSoWp+2Y7CGi6VoCDjEb3BA5aUVeTrVH5B/lW7SDO3GNQ3O7Y7hyUsjw5WBZ4y3Fo
         TTS73+uHEns0gEwluyPM+ka8lVyz8k03zepgwLcXB7xe/rcCY3SqhosGslOeYYnHYVbE
         wayKhU/z/2ole7ZnP0gxdcB5mOPgoXLuYqF5oKRv48sYYbIu1dQR3fAZfT+hZQcrSbyB
         Mt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742149159; x=1742753959;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2a5kh801vl9iToE3scZElc09JqjoduUAaLOK7aaGhA=;
        b=Vh/d2D8R1RWD6y/nAakALjXxkzczCkimS0wUItoiHhpnM8unKbhQoZPbl0nH8IAmqS
         NX8fGpr0Ywm7Ry7AM7EL+h7NAUyM7Nt0cbZZPM3JzLGjS3Q6xpoG8BOxK+ble9h+Uhrg
         bWTBUczy1kmo3euZ/NUzMN/tL4eZi1hIGSIsTBKRihEDHVeireaZzd8cC4w9O6Y6WgVV
         8tRKT7Sto9hK/+pcwQNLHGZXJzkgLOvygt6h7peGHDVNzDN1XWZZg7wOb8dy4l4eo1lx
         ohrFbgpB+tmXqRYhY7yutauPKS5aL3kXe8uxT2VtR6dGsyvVMhUGKJjhmNaysORJ1+Sj
         jMJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP4FDiuFvEYgR6SZTu9oKF1XyCYJQ4rn42xK9bOuHInPygkdDnUHntd965wTNWuTctBZQWezMrTOZ4RqNO@vger.kernel.org, AJvYcCWvQXQH7MnbKgQUEW9o7p6oDq8YZtVHZJ/kR6r2kAByJOMbDrdVFxNTm5CNO/bAsNv5PgKT2tVOtwv+@vger.kernel.org
X-Gm-Message-State: AOJu0YzffqE7ZrSd/5cmCj/AkjUAJjFX7/fY9KOcndJPtFXVw69gRnOe
	69AQv+qWlhFN4ySxj62q8oZ63Oemrxlcyi2Bx64Knux+/eg+RBND
X-Gm-Gg: ASbGnct6XQLqXZU5rJTMCuDs/XiEcbUF2EhIY/2htD93ogaN5ETgz+gFL0yNrO8vgeu
	kkUOz6s53EsLUgP9CCmYqv8Vcau/+E1pc8pMVoI8MlmEu8iTqgnD++1anZmDlzONLPkLEc6+3Xt
	pWzUFzF01hu6r8nuFryPAFVjl2nWtHIZ6eduUpM2MjMwQLqc+wxCHMDhI3Oaud/dEjKYzTZI8iA
	yL5qz6I/0Ytf9H8BNj19Y+7jXwFJpslYX0HCV4dMbIOQSn5aXZsaze9ULLUMvk3uQiVhtCbnoVZ
	UXWHXxELoXclLScrdgJT2W4F9NEpfmHoDMP/j+pkVzTkhNX5WLS2NxMgfoQJQFUxOcr2z1PjPA8
	I7w2kB3o49khVkazJ0w==
X-Google-Smtp-Source: AGHT+IGTb97sCzpYsDhmihcnk9Aluh4vlMNE+WF/B/S4d9ZBrV6Q8S6OHoKG9rtKiJt+ZbLxdPSc0A==
X-Received: by 2002:a17:907:72cd:b0:ac2:6837:6248 with SMTP id a640c23a62f3a-ac3301e8dacmr745340066b.30.1742149158591;
        Sun, 16 Mar 2025 11:19:18 -0700 (PDT)
Received: from hex.my.domain (83.11.178.210.ipv4.supernova.orange.pl. [83.11.178.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a48b51sm537951266b.149.2025.03.16.11.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 11:19:18 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Sun, 16 Mar 2025 19:18:50 +0100
Subject: [PATCH v7 02/10] dt-bindings: mfd: brcm,bcm59056: Add compatible
 for BCM59054
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250316-bcm59054-v7-2-4281126be1b8@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742149152; l=4488;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=dm7aREBrSuogWhHL7IYSSu3jO/9Oq8Tet0hiRF+dXhE=;
 b=BNVI0vy3mD8vTpNEq1/ixssqPwEcWdvXJtBIodlHWEgY3UXpyNC+0tDbUipAzCn6j1Pk4sRzP
 8IME8svoMkSDR5V2lL5PggUyCBWMHc8pg1hoK8l6ZvPkouu27kMK1dh
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

The BCM59054 MFD is fairly similar to the BCM59056, and will use
the same driver. Add compatible and specify the allowed regulator
nodes.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v6:
- Replace mfd/brcm,bcm590xx.yaml with mfd/brcm,bcm59056.yaml

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
 .../devicetree/bindings/mfd/brcm,bcm59056.yaml     | 26 +++++++++-
 .../bindings/regulator/brcm,bcm59054.yaml          | 56 ++++++++++++++++++++++
 2 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/brcm,bcm59056.yaml b/Documentation/devicetree/bindings/mfd/brcm,bcm59056.yaml
index b387ef9885c3ac524e0782545dbca9c0e81a556c..b67d7a723fc242869e5bdc6b3602785f62af45bd 100644
--- a/Documentation/devicetree/bindings/mfd/brcm,bcm59056.yaml
+++ b/Documentation/devicetree/bindings/mfd/brcm,bcm59056.yaml
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


