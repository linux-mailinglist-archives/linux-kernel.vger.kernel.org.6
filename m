Return-Path: <linux-kernel+bounces-543273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DB7A4D3B1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 665DA1897FD8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C7A1F584D;
	Tue,  4 Mar 2025 06:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0uYard6"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E841F5615;
	Tue,  4 Mar 2025 06:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741069251; cv=none; b=bNjbqE9XsxoCMMkpUScuRPyxXSz+plyEDFO6+FbXrcQQ6yRH9/OR+Af6/O/GJM+1T9GJCjekEWVLVWN8AbBjmzjiRaTgSQE8OERACB3u4kUk1TlNUx37kryMnHyx3Potx623bQodkp1rRVWzjzxrRweSD8AeSkM6SIrtzhBoZbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741069251; c=relaxed/simple;
	bh=uKY/pvKOppCATK1lW8BOBHq0yCrMNbql6EnLBlHnpBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TaJfQfgJsKw+7z+GVGU0sVV+gbokLCjQnFkF1x33PIgo2cJ/XxY1wMSJoBZ/P2+DYqRSTfBooR5ZMUGhoaUdSmF2WU2eYIyeiu0qQ5tLsR2nV3R7Ps/tWAH8PxcYl1/+HhKL+URVTPoNYEN3wyvW1eOAvYBaqZSYMNmbfK3fHPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0uYard6; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e4b410e48bso7943259a12.0;
        Mon, 03 Mar 2025 22:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741069248; x=1741674048; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qyiEiO+lrv2EFnXfMGMyPw5E4yChu6zGBy6NaYQRiQY=;
        b=Z0uYard6PWnF2UAaeuO7rYJhVgUw5os9/qUopNwjFdo7jTmiA0h9uLAwRIO9BPuwKy
         SojlchEkmoB8qE8uF4K74ucqUu8BKYMOni20EAqhODpWEanbR6pUxVbzIEwfN3SmC/ig
         uID1WQkg6J3/X5FrRAwmbpFsyLgAmrlZ537E8CKZTDcC5zCezXN0OqyUbtaiccqrJqqt
         XjMxIS0vKb/OJYJ2AOgGqKwwHS5p6E+ODZRZzTSCWUpq5seywqorc2L3KATcDkknx+FT
         1//fiSbWL/D8PoiiEcWG5mLgSBpESKuh3KRqvQqzh8nTpqBTlGRTMYLUXDP6hI6UujTF
         i9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741069248; x=1741674048;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyiEiO+lrv2EFnXfMGMyPw5E4yChu6zGBy6NaYQRiQY=;
        b=dnB1QQk1ZqkABqRkR2+nf8Nc6DRPpf/1F+rC1y9tFZ/FyWrg8qSaawKnY+bYpxCjmu
         ZGgNDNa+cG9fwXLe5/QigSvASHTRSBEluvHeU2ZC9d1lCKQetnYeF+ytntFai/wBAi3O
         H7mz+7vTJDFCY689QwB8sFmapAKbYFuFL4uWIYnWjEtVhb48eOy9IwElzjjatnq3R1Mv
         IFvMxPiTBuRRE8nDebUflWR+tTBnGw3CdQO5q2FaWR8EmZ0ft2tzfh8KoykRvJ8OyAPB
         zGZWoOGuEcJHCAPqKk7Yq8irrcDjQT8Oag4tEe+W07bh5ec0gRzhMxsmZ5tykpoHNmKk
         LGvg==
X-Forwarded-Encrypted: i=1; AJvYcCVGU/HE9NZ6UHFawVpqzX33abSxN26G8VKFB60YWohNWCRK9LGdN6UGBLPrCCoTEub9Lp9vENiGL1h0e8gD@vger.kernel.org, AJvYcCVfXMN+jujcrDvhHQKHFg1sjiUiLA6SFZJuhUtpyybcbAFzOPAukksvYHxfLYkAEdzB30HD3CE/r28I@vger.kernel.org
X-Gm-Message-State: AOJu0YyolptQjzauK9zwgSJH5AWQI7One7DGMNdSbofni9NtKFJNgYet
	lxBF4pPeocBAezW+WkBdhbvHqlI99SZu7zWDG66sHBIN278mnAEu
X-Gm-Gg: ASbGncv8qDh6hY4e03p+Ni/tDf7aYUpuPoGZctAud59N6EciY4DWZzyk3QBZKYu6n87
	DlY+rAeNTYHwXR2ZA6bXgZmju0uDmrp360578GOFEM+cohcfY9kq8to6yTQER9kAEhqJVNK3wHZ
	s2Znzh9fNBazbmjlEjmHm9Kj7Eo1iIImrblvy63QxrlQjFDXqrNEQ3DP3TbXVqCczBKnjtC8Qjr
	qHZ7gL/5d9UsK8UBphAf0MC6D23jVZIvq7Rty1ljOIpJRbA4my0h2bfuQP7JWuYTYdjAGcbWnhw
	4VCpIEYjO99ZZeafvqeM/YqMGw13ut2SvZFcRT1t2lie+KLTE3xAkSz1aWGl4+CAEJsbStoItRD
	YJoqwrlfmUtDMKoI=
X-Google-Smtp-Source: AGHT+IF2tnU7nvXtOlGzN4lOLDFoWcyh4RVs6EFLjb17C7DUOfM5XfLgvmFycbkrGKgTPU1KHz2BuQ==
X-Received: by 2002:a05:6402:2714:b0:5e4:d530:31a0 with SMTP id 4fb4d7f45d1cf-5e4d6921913mr18579693a12.0.1741069247649;
        Mon, 03 Mar 2025 22:20:47 -0800 (PST)
Received: from hex.my.domain (83.8.122.142.ipv4.supernova.orange.pl. [83.8.122.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c43a663fsm7609036a12.68.2025.03.03.22.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 22:20:46 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Tue, 04 Mar 2025 07:20:33 +0100
Subject: [PATCH v6 02/10] dt-bindings: mfd: brcm,bcm59056: Add compatible
 for BCM59054
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-bcm59054-v6-2-ae8302358443@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741069239; l=4438;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=uKY/pvKOppCATK1lW8BOBHq0yCrMNbql6EnLBlHnpBs=;
 b=pEI/t3Zh4tTV3f80cqxONxxxBDb+oiyEgfqUMy+9olMlnTzzZ8+zz2vnLPEEeyX+Ol2tEsCIz
 fUVEMSEFQdnC6amEbP4VVcm3z4uPmimF4NRxs2+r7N+XS7GcuauXJOf
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

The BCM59054 MFD is fairly similar to the BCM59056, and will use
the same driver. Add compatible and specify the allowed regulator
nodes.

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


