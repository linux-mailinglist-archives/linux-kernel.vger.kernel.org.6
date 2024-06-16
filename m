Return-Path: <linux-kernel+bounces-216223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87735909CDE
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 11:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 275002814BB
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 09:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236DE1850B3;
	Sun, 16 Jun 2024 09:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJAI7oGz"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F034E16D9B5;
	Sun, 16 Jun 2024 09:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718531559; cv=none; b=kVQz8H2Xvxy/HPQhwDUvkz5IUcT+5+5bYIf2ND/+dBoKsG0/fAy75ckyuJiux+1ibHFhtE+zzduWpHpF2JGxTZCuJhGJ9MKDhEfoItoxmXPvJ/79+xrkz+opIsP7lA907Da7Y5/nF1SWb5+qDrHe9SwysMuN+TahiKpC3aInv5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718531559; c=relaxed/simple;
	bh=YZHKZATojJ2HK+Z+DAwC+6Oa+5yLu6I/Vp6L8JR97K8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t3DuM6f2FKFw2hW5qGZ/2GMbfY/GCYXhZCPjd4XJJ/gwF0OJqgvV2tQhe1mIcqKX9IzwvVdwiwtX5AK1TQkGn2/EtE1meTPdvRD4E5NKsflwOc1Kzfoy4NSw/ONyuYG6Qwbo+mFtFgD5gk3trEnJ0Lq/IWzjqXNymqBxogA9y5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJAI7oGz; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7042a8ad9f5so2998946b3a.0;
        Sun, 16 Jun 2024 02:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718531557; x=1719136357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GKTZuZsWgG4U6fxLMx1cgYwrM7Q/BtT3yyk8jGRBk/s=;
        b=nJAI7oGz+L7oP1RPvFqw2Mnl08cW8DDj1j4FLDeJqFwX3l1VwWxPQw1Q2wbXNVlEPo
         HNdlSvFLZzPN9YDnlw+F0F3jHyaDVhWj3an23iP01bR8SyFFP5zCUqXdlWPbEdIhm3rv
         rVfpbbcnYg5RJTs62lh6m0ZOmB163mMRcfYG0fzrU539Tnbi83AwKCqYlS5EFF+WMCFR
         k82xF3A+o3Yv6+037JYuzmbY7gmsg0QaMCGBPB1pAbnX02lsu9LTTuukT0fh+Lymoak6
         ylu3sQmyEU4h3v1jyB/FKBDPRPZMqWO6pCitwtE2fcaJtBYAmTP55ffur5B1bqBjFN+M
         2UpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718531557; x=1719136357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GKTZuZsWgG4U6fxLMx1cgYwrM7Q/BtT3yyk8jGRBk/s=;
        b=uQOFCFT62zircLiv6JSv4+Di6jX7gpLbieFylDFfpYJGhn8nZ1ZCllsUF1xfIIoQ1l
         TO7hJwvMfgnsG900tRIQossNPb73VKLhXemNFHHkTlD9u7Ej2mykVzexL0WZ1GFN0bms
         mc4M2vHHi6hv859Efho6Ei6tBc7svTo5x0gPmmvDdxvx1/75323woe1nZ8Rq8Oeqfkx7
         dpKme1bjz66Th3EnObrKcQXizzScmjC3Dm1Eq9gR6wnxMPF6sPrVP4VpJovHc2bSrC+7
         6rUfNdfm7IT55h42PlboZ8u/qr3updGLnAPKa2emIGEXfeC85LlTENqahL/ndl717CmO
         XkZw==
X-Forwarded-Encrypted: i=1; AJvYcCXkoMTB6XtshD9mK1RfXnHYmAfxUaXslHB4MtSc0KLdsMKUShvZAN0Kv8p8/sptZyaw/JRN2K0Qq1zMVyqtJ1rAdZtaeTil8eEigC4+NZdFCKOHKLcOkNdUMSqDmwcuWXVVSw2e6qvOUdaP7GVVuNLGPLr3uxVxIsvHjpMfIQnv0gYF92mv
X-Gm-Message-State: AOJu0YyWPMaKqSK/Ffa+/IHX3Utb1L+RMSJrgA2DWvRAPwr1HmBVsP5k
	NBcs1bDuM+3e9RKwKpRvR8z9xfusolC4UUG/0NiuwPc2Jw/Vw2+N
X-Google-Smtp-Source: AGHT+IG1Q+D08Au94XxXFGiSSXNSz13KorAKbPoqOdVlM3M321xVm8e12/BOIt5uWsNmrVCA/VqVlw==
X-Received: by 2002:a05:6a21:7887:b0:1b6:a7c5:4fad with SMTP id adf61e73a8af0-1bae800c9d4mr11339816637.26.1718531557033;
        Sun, 16 Jun 2024 02:52:37 -0700 (PDT)
Received: from fedora.one.one.one.one ([2405:201:6013:c0b2:ea4b:30e0:4e3a:ab56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc9891b9sm5891275b3a.95.2024.06.16.02.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 02:52:36 -0700 (PDT)
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
Subject: [PATCH v2 1/2] ASoC: dt-bindings: realtek,rt5514: Convert to dtschema
Date: Sun, 16 Jun 2024 15:22:19 +0530
Message-ID: <20240616095223.260786-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the RT5514 audio CODEC bindings to DT Schema. Make bindings
complete by adding 'spi-max-frequency', 'wakeup-source' properties.

Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>

---
Changes in v2:
  - Added ref to spi-peripheral-props.yaml and dai-common.yaml.
  - Added missing properties 'spi-max-frequency' and 'wakeup-source'
  - Moved maintainers list abouve description.
---
 .../bindings/sound/realtek,rt5514.yaml        | 70 +++++++++++++++++++
 .../devicetree/bindings/sound/rt5514.txt      | 37 ----------
 2 files changed, 70 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt5514.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/rt5514.txt

diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5514.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5514.yaml
new file mode 100644
index 000000000000..7fbf7739c371
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/realtek,rt5514.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/realtek,rt5514.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RT5514 audio CODEC
+
+maintainers:
+  - Animesh Agarwal <animeshagarwal28@gmail.com>
+
+description: |
+  This device supports both I2C and SPI.
+
+  Pins on the device (for linking into audio routes) for I2C:
+    * DMIC1L
+    * DMIC1R
+    * DMIC2L
+    * DMIC2R
+    * AMICL
+    * AMICR
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: realtek,rt5514
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Master clock to the CODEC
+
+  clock-names:
+    items:
+      - const: mclk
+
+  interrupts:
+    maxItems: 1
+    description: The interrupt number to the cpu.
+
+  realtek,dmic-init-delay-ms:
+    description: Set the DMIC initial delay (ms) to wait it ready for I2C.
+
+  spi-max-frequency: true
+
+  wakeup-source:
+    type: boolean
+    description: Flag to indicate this device can wake system (suspend/resume).
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        codec@57 {
+            compatible = "realtek,rt5514";
+            reg = <0x57>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/sound/rt5514.txt b/Documentation/devicetree/bindings/sound/rt5514.txt
deleted file mode 100644
index d2cc171f22f2..000000000000
--- a/Documentation/devicetree/bindings/sound/rt5514.txt
+++ /dev/null
@@ -1,37 +0,0 @@
-RT5514 audio CODEC
-
-This device supports both I2C and SPI.
-
-Required properties:
-
-- compatible : "realtek,rt5514".
-
-- reg : the I2C address of the device for I2C, the chip select
-        number for SPI.
-
-Optional properties:
-
-- clocks: The phandle of the master clock to the CODEC
-- clock-names: Should be "mclk"
-
-- interrupts: The interrupt number to the cpu. The interrupt specifier format
-	      depends on the interrupt controller.
-
-- realtek,dmic-init-delay-ms
-  Set the DMIC initial delay (ms) to wait it ready for I2C.
-
-Pins on the device (for linking into audio routes) for I2C:
-
-  * DMIC1L
-  * DMIC1R
-  * DMIC2L
-  * DMIC2R
-  * AMICL
-  * AMICR
-
-Example:
-
-rt5514: codec@57 {
-	compatible = "realtek,rt5514";
-	reg = <0x57>;
-};
-- 
2.45.2


