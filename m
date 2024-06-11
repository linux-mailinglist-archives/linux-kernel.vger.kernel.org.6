Return-Path: <linux-kernel+bounces-209874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB620903C1E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B23241C227EF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D1017C226;
	Tue, 11 Jun 2024 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATlhLdVb"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E3517994D;
	Tue, 11 Jun 2024 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718109863; cv=none; b=hGn3rBDx1I4id2MpIX8uSTKV4q6+QGj+wynvsSe4zII/yUixKbm3xV4BrSVqI3vEgWBWXvCjBDeQm333eW6UaSrKQ06AoR/TT85VSWXp5B44sIQot8yeU7yVdxHX+3j2AZW/sZX3dWf7kTFrE3EjCIbX2UL3GyqldSfPjjLBP2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718109863; c=relaxed/simple;
	bh=wvAyPUBns/uNl9S66bSDSvxN3bhNbvQLJE39DQGbjLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kG1b7O6rUVxPaKIE6lyAZP03FNYPRSMrvnwe4MTy1PM3f5EIQSjcBeFjUQfvVo21Lu+woaXHnIKViJCDBCMqWA5cIttNux+j321L8xnES2XycAMrWlyFZ7PK7Z/kxQR8TcOQ7kxVHqtcRcryfBIenansexIBHUJSqaL1V0K+UhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATlhLdVb; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-6e3ff7c4cc8so2920571a12.3;
        Tue, 11 Jun 2024 05:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718109861; x=1718714661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AVwIlcHjQo8eh6OrUJ43oxF3efWtPUA/bK44QL6w+l8=;
        b=ATlhLdVbV024YS0KFj1k5uUqAx5cYTIIzEhumjeWvgx2U7KqaHuSTgIqA5KXik71Bf
         MH3V/WzRnN81ZArlvusjX/H9vCqnMdibCiBSyn1shcHHZtcUIR4Liap81uUYVSpxDvr2
         +q11TFO/5AIyh5fycVfBPzPf8VZWCnkrZp99FtusEFfo5lSVkXF0Mjd8tbsUmthRpbow
         CIws7g/N5I8L548NYtQkJ7gc6eXAmdNhpuRSt2xjkYbb53ypz8AOPi61oYv/MSkhLK6B
         xlpOkASgVcgNJgb7xS+XOsgdI1BCKWeVvM1+6XtB+WxRH8LvY1NKFqqJgx8l1Q1YHzD8
         pt6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718109861; x=1718714661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AVwIlcHjQo8eh6OrUJ43oxF3efWtPUA/bK44QL6w+l8=;
        b=KPZY4IWqBrn/anLtqosb3w/yR3rp0V2WD0DbOJDgWhpMro5fXwKWHd/La2ZpwLXpdE
         Au+MQAobK922XJmO7ykeyQuiSeJWELRe7ZyW+Thvnt7GGuFrqt68famEQqibzjKKdTk0
         HCISi3SMK/L6bJn9oUnu2G4bk97rbpIMk/xA4DFh2wixSQc7T3696JiJ8Tg3wOU6iKFZ
         HJqmc6Bl9exq1vvn7jXJCPBDMyXwDoOwnN/8gNWleGg0Rdl2E4QVP1wH/l1S+6aQavBz
         U4KiRLLMqxdgswKeE1qI8V4yq/cSxIpoMG/YGcG93F+N3QRUmwnplJ40mkSuZ/hfgqsn
         acbA==
X-Forwarded-Encrypted: i=1; AJvYcCWMVEmIbs5lKyED+RUCJo1UwFyu7q0GCeNDO3DjXdTgCkFCzkxJeBbD/z+BOdTZsGKTjrfGmU2QAciBnydkkM8i9wUWt58Qdz106eQ/OmfW1j/4D6xprmctNhGooCOMc4XRexXpmjkGrwXcpH5FUq7iLO3v4dP71FMHmoxXMBlfQK9KvND8
X-Gm-Message-State: AOJu0YzHcBae5pviPJVwoOnET2xXe4gV/T58uf+/6zIIA0D7scItlUIo
	vGMRwILl0E5rhuhZ1XVejBt32PWk1TNJf6/ZezguOnrWJG1SQgdeKKwapI6g
X-Google-Smtp-Source: AGHT+IGxYFQHUxLPouK/1ioV0eCRyouOGRoF0w2WN75pt0GtljsQjw6+Rf0APD0pqim83/wxnkvyUw==
X-Received: by 2002:a05:6a20:72a3:b0:1b7:82b4:a380 with SMTP id adf61e73a8af0-1b782b4a72amr5655759637.29.1718109861271;
        Tue, 11 Jun 2024 05:44:21 -0700 (PDT)
Received: from fedora.one.one.one.one ([2405:201:6013:c0b2:ea4b:30e0:4e3a:ab56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6eac1dea8b2sm3950627a12.63.2024.06.11.05.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 05:44:20 -0700 (PDT)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: animeshagarwal28@gmail.com,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: wlf,wm8782: Convert to dtschema
Date: Tue, 11 Jun 2024 18:14:00 +0530
Message-ID: <20240611124405.63427-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the WM8782 audio codec bindings to DT schema.

Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
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
2.45.1


