Return-Path: <linux-kernel+bounces-214306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FF9908288
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 05:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC43BB22390
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 03:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818D6146A83;
	Fri, 14 Jun 2024 03:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPj4diUf"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D00D1465BA;
	Fri, 14 Jun 2024 03:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718336353; cv=none; b=oVtBDZx+VCY9kcaSOhGi0dR5pSUUF9KjCwB1ClzKC733t6DFFKhnfESX9a8lrJP+t2sM4hjBGTOA3uvqOxn6mTo7b4J0lu4ekEIdJA8eoqgQDi/gfjxe4QQPyWBcSExJ2y7KVD2vCROHoUZURK/R7bXyn657zg2jU1Am5dsmZtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718336353; c=relaxed/simple;
	bh=MRGKH7Al/P4uIb5rMXoF8kTbwe+/D+dxu02Fp4+Xphs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1QCiXnF7W0U89LLJ+rfxNlTQAGKYDZndOyZL1OtN+zEmFQl7yJ0dWhIsK9KjFw/KMrZDC9eULRHmprtRc2mbAg934fAmYtqU+FcLRfcJwC8Ku593xlL2FrM8+1fe11S/Yjp8sE6nAPPtiuEK9Z9AWT+5ZJMpPepN94s8rtr+i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPj4diUf; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f862f7c7edso4580765ad.3;
        Thu, 13 Jun 2024 20:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718336352; x=1718941152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yC2KZ8utKvZ5i3tIa2c6ONzpeArrchHhMMJliHQRCmw=;
        b=mPj4diUfc7yEXcTHgnQcBCKmuVgOuntg14VdwoQ58kAIlYdzrL0KkNOk9NPohOL1Pe
         9eApTJH8UIr4yA3PMKSb/cfuN9qL6+xcWtf2Z7oyPLvgnh/ErK7cuCQpdmhR5qtzMq8y
         B34FIJl4kGwYA8xR0Ama1oEwE2fR6Zy2X+ZyiLVDtUnAb1cQjAkEahPRagOUdnEKTUBo
         WBYJX+STc5rC8XO6+vcxBI2/faQk7X+/lsIhoNFRc2R6VpIzKBRb1caNh24U7prLWQST
         IZX6AGm0d9ejY4m8Dr1jG1DLPx25LtgD+V0Z22GJ5PvUMCXRRhpsmqAw7iKiRGFXle04
         r5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718336352; x=1718941152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yC2KZ8utKvZ5i3tIa2c6ONzpeArrchHhMMJliHQRCmw=;
        b=JxW/+VeEBnqCyR8yn3ehl3wxI8P03bnrJGDYAXkOADkrIBJFZTu45K26eSpILD4iBA
         XF5LeY+N/ptFcmmBHhZiN1dcmD5q7QLhShHGGs+LfceZsO33lZzE/4AA65iJI0cxmwa+
         AxMJfz1grGkYXu0g+MnJ5AmyqbGPqyMS11DJf5XaOJ1sPlEai3WjeamIMeeoMGFcnTaS
         Ay715TJutiLnvwqtc21qawaBczHXiYcdRgreD90pdmRw3UE7hi5F7CtftnzcL+TjfNEK
         MY7pLhK7hrt1ihaE++MepWgD0hIkvsgWFuhGaykx500laAiLpKN/OJKbZZ4YbYVwJNYK
         BSiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRkw+XL0eOpk1cmXmwBdp+XYumxjo/SmSgANtYY+nV2K6DYLKu1PonaiVhYiB0cales5vE6jh9jt09Q6Sy11u1Q3nJkFUGGNXN8CaG+bDBBbWzU8IGQwbQY40VRoB8+gpoTqtJgmRjJOeq3JrKKjN+4jWtgFMhkMEt0bxDjuACN3dFiVCh
X-Gm-Message-State: AOJu0Ywx9C7zaydSBeG68aZVQ8UEN9S4BGCp3TRVoPetxffzjxZEEyUu
	oscW+d3Rudijb8bGOk02up19Ive8LrHtFu6lr6z524Q50b1ephI2
X-Google-Smtp-Source: AGHT+IGHe3/pVNHsZ7vpwj7vZI6Di61dHv4cXsLx75K7oolGVFp0Q9YVw1ZqCDyoepng8I2Ntj+dyg==
X-Received: by 2002:a17:902:d482:b0:1f6:f336:899f with SMTP id d9443c01a7336-1f8628062bbmr16723235ad.54.1718336351381;
        Thu, 13 Jun 2024 20:39:11 -0700 (PDT)
Received: from fedora.one.one.one.one ([2405:201:6013:c0b2:ea4b:30e0:4e3a:ab56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f002b0sm21824085ad.192.2024.06.13.20.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 20:39:10 -0700 (PDT)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: Animesh Agarwal <animeshagarwal28@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ASoC: dt-bindings: realtek,rt5514: Convert to dtschema
Date: Fri, 14 Jun 2024 09:08:06 +0530
Message-ID: <20240614033812.51312-2-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240614033812.51312-1-animeshagarwal28@gmail.com>
References: <20240614033812.51312-1-animeshagarwal28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the RT5514 audio CODEC bindings to DT Schema.

Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
---
 .../bindings/sound/realtek,rt5514.yaml        | 60 +++++++++++++++++++
 .../devicetree/bindings/sound/rt5514.txt      | 37 ------------
 2 files changed, 60 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt5514.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/rt5514.txt

diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5514.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5514.yaml
new file mode 100644
index 000000000000..28e5f583fd91
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/realtek,rt5514.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/realtek,rt5514.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RT5514 audio CODEC
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
+maintainers:
+  - Animesh Agarwal <animeshagarwal28@gmail.com>
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


