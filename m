Return-Path: <linux-kernel+bounces-211473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF200905233
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403B91F21BE9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 12:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E9716D4C5;
	Wed, 12 Jun 2024 12:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQn7FmAU"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DA25CB8;
	Wed, 12 Jun 2024 12:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718194543; cv=none; b=FGXD8POGDjahpu3GCYDODye+AZ5+w8hzaG2ADMKJegU0J8ckqUriIuTU00adkweHDznMJlWHD48MDjUGCTCjR9mT5XZCD/mT6PUxvHakm9PEYZ8LTUCiP0uboJ1bl/Ioo7XNlFH3HI9UXTuNGS+vIZE7w25m3DiueOw6nXkjbME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718194543; c=relaxed/simple;
	bh=aREFeHhRGadkM71j2silmcFik/atuRpn25ZF2V68cm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m4NB915T6/IiXlU8S6r9Q/E4P9sq/cRoqguhAo/aUDAsFZ2+xoqupU080+qJBuk6pRRvqrp4rqx0FxG/JQk4sL5n48LHczVohnxKVPgvtb34NG5Ppm1zP3ToIQtUSo2HoEsoRUUTtdCejH5XrSyHv05F3uO7I/iUgCsqGksjIFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQn7FmAU; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f6fabe9da3so33102345ad.0;
        Wed, 12 Jun 2024 05:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718194541; x=1718799341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vuzEzGYE5Vn8QxEth1OgjuHeZDFf8sibXRRMgQoc9co=;
        b=jQn7FmAU2WgpOlpNOOecmWhvvT6yFwdqOSzTGCx9njeovqlRBp2gCJCpAdz9oiOjIe
         TH+6LhOQZI1u52Ce9QS5jBTwxwAWbMrwyQ9U5EClUCNaLob+sU1JEq6Y5vB2t5N3hu28
         UzSAnD4yuxrmV/trxVlk7KO0QYfIzq2d1OnX8HhC1N7YMU1Pqq8X7exsoJspgqCjHZ4i
         hjKaYFMSHKswRhiymgU5QBiA73iOmqs1Qfs4CycaRyios33wO1FnjaeiNQVe7oDtnTI+
         RjzcMaZ+64HGiDocILcehQBTas0zQHB6KrKByfD8q1Zv8dWQ4gKP3scN0iextptYXXC6
         etGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718194541; x=1718799341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vuzEzGYE5Vn8QxEth1OgjuHeZDFf8sibXRRMgQoc9co=;
        b=mh6maVWdpJD0ohW5WJdM+Wc1zLAI9lepJorG4ILmqS2RGmuTeFlmYLyC7gY94BngSL
         umgVcdqVax5PEK62wvCj7iYmtWMeWkfgF9ttGd1QkA9CKnNC5jfkYsNi06X1G1ao2Xxp
         4Fecj6vFRCdkh/i1sGi6p4f1uiHxpOiu0ruIz6vyUEQWOm5h+ZJrFv36zNjwS4jFPFUv
         x3KB3KoqCVNFyDx2h04d0rGb3Zk8egk4SoAFGSJEL5MWck02v7vOEo3rytsLpkcQYpsT
         2q7qKqDuJtcMGVdVumtI2TXwPWsDFnSx7rzeMa6kvbACfjW/jYAo2bMvg1jaRwCDBsw4
         zuVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWhWYWDPyqOWjd71pqdfPMU/xzwwcxX5eEAXmPUqWANhGzZfzmjN4DJ6ZBHa8rFw9ZK6ZM+NPBSTyq13h52B0Tr5t6Ma0QvC+2BTgimfks7LF0l6iEMdDkfInnYkxZhKAteVwg4EdMRFO/BD/tMvCXeCzOuyrbmHl8pifqPiOzS2h5NmSP
X-Gm-Message-State: AOJu0YzsNG5Fipr0NTOJ1RPmcSNhH9fZYmcy5yQiScobsubzwRjK9RZ9
	lxHdGMaphNmxD1fAYCzkSN9UySLXuzLFjMFvQ6XzURj6vYdckjdI
X-Google-Smtp-Source: AGHT+IFT/P6FYWtTRJkNs6wLGGCcWkJumILXOfirg+uDIrQZlS7ojKpDd8hwE95oENWAgmgVc92ffw==
X-Received: by 2002:a17:902:ea12:b0:1f6:502d:ca88 with SMTP id d9443c01a7336-1f83b715d75mr19286615ad.49.1718194540868;
        Wed, 12 Jun 2024 05:15:40 -0700 (PDT)
Received: from fedora.one.one.one.one ([2405:201:6013:c0b2:ea4b:30e0:4e3a:ab56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f84619fcfasm5280725ad.282.2024.06.12.05.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 05:15:40 -0700 (PDT)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: animeshagarwal28@gmail.com,
	Rob Herring <robh@kernel.org>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: ASoC: wlf,wm8782: Convert to dtschema
Date: Wed, 12 Jun 2024 17:44:59 +0530
Message-ID: <20240612121503.38769-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the WM8782 audio codec bindings to DT schema.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>

---
Changes in v2:
- Added missing "ASoC" string in the subject.
---
 .../devicetree/bindings/sound/wlf,wm8782.yaml | 47 +++++++++++++++++++
 .../devicetree/bindings/sound/wm8782.txt      | 24 ----------
 2 files changed, 47 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8782.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wm8782.txt

diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8782.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8782.yaml
new file mode 100644
index 000000000000..d0bbdc9f9ced
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wlf,wm8782.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/wlf,wm8782.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Wolfson Microelectromics WM8782 audio CODEC
+
+maintainers:
+  - patches@opensource.cirrus.com
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: wlf,wm8782
+
+  Vdda-supply:
+    description: Regulator for the analog power supply (2.7V - 5.5V)
+
+  Vdd-supply:
+    description: Regulator for the digital power supply (2.7V - 3.6V)
+
+  wlf,fsampen:
+    description: FSAMPEN pin value, 0 for low, 1 for high, 2 for disconnected.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2]
+
+  "#sound-dai-cells":
+    const: 0
+
+required:
+  - compatible
+  - Vdda-supply
+  - Vdd-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    wm8782: codec {
+        compatible = "wlf,wm8782";
+        Vdda-supply = <&vdda_supply>;
+        Vdd-supply = <&vdd_supply>;
+        wlf,fsampen = <2>;
+    };
diff --git a/Documentation/devicetree/bindings/sound/wm8782.txt b/Documentation/devicetree/bindings/sound/wm8782.txt
deleted file mode 100644
index 1a28f3280972..000000000000
--- a/Documentation/devicetree/bindings/sound/wm8782.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-WM8782 stereo ADC
-
-This device does not have any control interface or reset pins.
-
-Required properties:
-
- - compatible  : "wlf,wm8782"
- - Vdda-supply : phandle to a regulator for the analog power supply (2.7V - 5.5V)
- - Vdd-supply  : phandle to a regulator for the digital power supply (2.7V - 3.6V)
-
-Optional properties:
-
- - wlf,fsampen:
-   FSAMPEN pin value, 0 for low, 1 for high, 2 for disconnected.
-   Defaults to 0 if left unspecified.
-
-Example:
-
-wm8782: stereo-adc {
-	compatible = "wlf,wm8782";
-	Vdda-supply = <&vdda_supply>;
-	Vdd-supply = <&vdd_supply>;
-	wlf,fsampen = <2>; /* 192KHz */
-};
-- 
2.45.2


