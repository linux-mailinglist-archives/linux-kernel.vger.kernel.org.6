Return-Path: <linux-kernel+bounces-216181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C63F909C60
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 09:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC478282229
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 07:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CABD184114;
	Sun, 16 Jun 2024 07:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUglQNkd"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB7116D32D;
	Sun, 16 Jun 2024 07:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718524228; cv=none; b=PBp6ikPsCP2f9Ehw2Injnr+JNWMGapkeZtvtGAOud4/nPTmGLvX1NIUTRMI0eW0BabN/dx7qsIyfwymfKT8vtjy3JUDKOKbMHy2BJDecTmCBqwxsGaHG0loUOiw4k7vAiQFOYZEtZ4nFY1rUyL1FGshHW/nU66Sf7njYLZN8cGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718524228; c=relaxed/simple;
	bh=FKs+l7vr8yUwexuIpXPZinbV1Mp7+jimwLSLCeURhIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MKH5csCtU3KWBaDy7htzhWPPcQEchcQwTXhdeVMRyKTPYIAimhbI+X2H4+lqHgsyXAVnAWaCE9zyXQfW0QM8eAmZXN955cZFKhi4BpxZdKkXP5qhxoOLfK1Jhg9LmwgKgYp9ZMPdHZfVyRO5oKW/NLwq5uRBQhe5pUsk1Ju0tEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUglQNkd; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2c2eb5b1917so3015973a91.2;
        Sun, 16 Jun 2024 00:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718524226; x=1719129026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SHcPhxF8HQUomrEgimOjlC4Pkp/Hf/7nELFDRzTQavQ=;
        b=BUglQNkdM0nNKLoBjfir5ZuhKrK87+z8kVLg1rLJf1d692RqOOU6mUQnkE4JQhGmHG
         tEdG8w4hqJOy/+t41DVz/QOD8owCRHHwF7MbGE/mfHnHV2f6UYAe5B4JLR63bQBF4dYl
         1jZcspXP+Zo+UkIwMOYsljRzBH9IHhbf41hvukb/Tp5whqpOcUbm4yxWKHtz880v9XHE
         eFw/KH+8DgcUHyNwEZNm3Qu80+rGhAKhsEslt3sGitvYTxQ0LT5ICKcNps7lOd63fUAm
         mYSEMzLTcf4lCaHHHPS3Z4UMAtU0phAIINjzMsiP4bjkjpM92zzd+vku9gzZKfG4r3Dp
         TIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718524226; x=1719129026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SHcPhxF8HQUomrEgimOjlC4Pkp/Hf/7nELFDRzTQavQ=;
        b=dSpd3FeRd82yHW6MEESOnLSUkO+TmlPcHGG64q0VC8kr/CgPkzekluE/N+JsDhXRUn
         j2FRj3F0ctjbWe12v0OA3ybYGKOxr21DY89w4u0hJDwk08hXPp1prNfiQ42oWa0b29YK
         Tj150oDUB6vdqvqMKZIKN2vGEbjYT8nMobuQmZFXp79Ar8fcVFA8ycSKWCR2FlP3grC3
         ezzcOVGcZxIAhTDosRPraR0fCCDwGsFx/B6paLNnUXuzS2TmonPw675sr5yXha5KR4hy
         VviqaRK+sd2Y3RXqVhiJKT+yA+WSfKmGqs3CGwGmnR5HfVBjaTZGETCi27JmXoBUXeW7
         7Baw==
X-Forwarded-Encrypted: i=1; AJvYcCVPIpVNAxYGqoS10l+SGg9iWBcQSwwoiLywwi7/o5njjQyGpTnEFr4fvRlf8jp35DuNZbvWnumlo5agywe6pio6hduRLeQ2plXudgTdO6/sGqafxlXgklwfCT8u79FjBeKDdhZN7E9AW8lzrPgJCEgBEjWxQ72YR+ZdgZCWpk0mNdhYvr8v
X-Gm-Message-State: AOJu0YzSSgkn2Q/qiceNIqV3j78VaOVmTpHPMaXJkG6wsl6DmutkIFAI
	KIwTgWTGO8bz/aQrpy3Koo4vnnUIi790vKZJfXq9kkpEJfCT0dzr
X-Google-Smtp-Source: AGHT+IEK/RZGQ2b9Y0wWYp4TV1f+E9MTFHnHo/ShqcI0xIy1SDy1oupuP0F4TF4G+1kVikHZwmD8lg==
X-Received: by 2002:a17:903:2302:b0:1f6:f0ff:47a7 with SMTP id d9443c01a7336-1f8629ff1eemr115315475ad.63.1718524225839;
        Sun, 16 Jun 2024 00:50:25 -0700 (PDT)
Received: from fedora.one.one.one.one ([2405:201:6013:c0b2:ea4b:30e0:4e3a:ab56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f18724sm59798865ad.234.2024.06.16.00.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 00:50:25 -0700 (PDT)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: animeshagarwal28@gmail.com,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ASoC: dt-bindings: realtek,rt5631: Convert to dtschema
Date: Sun, 16 Jun 2024 13:19:30 +0530
Message-ID: <20240616074936.151267-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the ALC5631/RT5631 audio CODEC bindings to DT Schema.

Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>

---
Changes in v2:
 - Moved maintainers list above description.
 - Added missing port property.
---
 .../bindings/sound/realtek,rt5631.yaml        | 67 +++++++++++++++++++
 .../devicetree/bindings/sound/rt5631.txt      | 48 -------------
 2 files changed, 67 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt5631.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/rt5631.txt

diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5631.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5631.yaml
new file mode 100644
index 000000000000..747a731c44c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/realtek,rt5631.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/realtek,rt5631.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ALC5631/RT5631 audio CODEC
+
+maintainers:
+  - Animesh Agarwal <animeshagarwal28@gmail.com>
+
+description: |
+  This device supports I2C only.
+
+  Pins on the device (for linking into audio routes):
+      * SPK_OUT_R_P
+      * SPK_OUT_R_N
+      * SPK_OUT_L_P
+      * SPK_OUT_L_N
+      * HP_OUT_L
+      * HP_OUT_R
+      * AUX_OUT2_LP
+      * AUX_OUT2_RN
+      * AUX_OUT1_LP
+      * AUX_OUT1_RN
+      * AUX_IN_L_JD
+      * AUX_IN_R_JD
+      * MONO_IN_P
+      * MONO_IN_N
+      * MIC1_P
+      * MIC1_N
+      * MIC2_P
+      * MIC2_N
+      * MONO_OUT_P
+      * MONO_OUT_N
+      * MICBIAS1
+      * MICBIAS2
+
+properties:
+  compatible:
+    enum:
+      - realtek,alc5631
+      - realtek,rt5631
+
+  reg:
+    maxItems: 1
+
+  port:
+    $ref: audio-graph-port.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        codec@1a {
+            compatible = "realtek,alc5631";
+            reg = <0x1a>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/sound/rt5631.txt b/Documentation/devicetree/bindings/sound/rt5631.txt
deleted file mode 100644
index 56bc85232c49..000000000000
--- a/Documentation/devicetree/bindings/sound/rt5631.txt
+++ /dev/null
@@ -1,48 +0,0 @@
-ALC5631/RT5631 audio CODEC
-
-This device supports I2C only.
-
-Required properties:
-
-  - compatible : "realtek,alc5631" or "realtek,rt5631"
-
-  - reg : the I2C address of the device.
-
-Pins on the device (for linking into audio routes):
-
-  * SPK_OUT_R_P
-  * SPK_OUT_R_N
-  * SPK_OUT_L_P
-  * SPK_OUT_L_N
-  * HP_OUT_L
-  * HP_OUT_R
-  * AUX_OUT2_LP
-  * AUX_OUT2_RN
-  * AUX_OUT1_LP
-  * AUX_OUT1_RN
-  * AUX_IN_L_JD
-  * AUX_IN_R_JD
-  * MONO_IN_P
-  * MONO_IN_N
-  * MIC1_P
-  * MIC1_N
-  * MIC2_P
-  * MIC2_N
-  * MONO_OUT_P
-  * MONO_OUT_N
-  * MICBIAS1
-  * MICBIAS2
-
-Example:
-
-alc5631: audio-codec@1a {
-	compatible = "realtek,alc5631";
-	reg = <0x1a>;
-};
-
-or
-
-rt5631: audio-codec@1a {
-	compatible = "realtek,rt5631";
-	reg = <0x1a>;
-};
-- 
2.45.2


