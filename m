Return-Path: <linux-kernel+bounces-176733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3C68C33DB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 23:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C4091F21A55
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 21:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9AF22F17;
	Sat, 11 May 2024 21:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQc5uu62"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FFF2137F;
	Sat, 11 May 2024 21:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715464010; cv=none; b=hl1H2/BXNsl20JZdkkCp8gpLjGiB89Bb7BV8b8FgX+8nXRfi2UhComxl5vbX2g/6xSvNLZN9YsHDuPFVhQ9kDKepAOv7pWnIF3W7R8Bvu5a/UCDkoh+jUJxVhMPrvdIh7PX6etFUMCMbFzeaj8KJzhdtz1JJtkI2BWAX3c4tPQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715464010; c=relaxed/simple;
	bh=08uIG1/bwHmwBLe7pL7bLSc0GiqPtuTS6M4lMExW6GQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OF9GYx7KhLDrvgZNog6QkeOxu7/3CWbdVIvG0QKrAJHDnCMs7PBPJAFzz4EyTgAjsqixMedKNsdYSm6xlJ9m4tnwfiLHYDDiRWvuHWb7utOby81KRJmpwOBs7ckw8zcGOAaELA66xWgTQmAlRpandUtrYnUJksQHu37EeX7pcHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQc5uu62; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ed96772f92so27280915ad.0;
        Sat, 11 May 2024 14:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715464008; x=1716068808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eCVJMzFVoc+BRHoT08G8Xmn5JdPV6LQjStyH9q97kgs=;
        b=WQc5uu62OYjqzWK1XV6OcOvOeRRcAXnuynBQ0soHmilQYQ6g4x3kEUcsULabddIlvI
         auC6apFKlQRTresRb+ZieA1JbuutDN2OmCuTZG9419zOKULJ8uVMjOhi5ZO88GD6FmEk
         rTYyicc2duQjKf6CR/NuiF6Mgp8TDI/My1wn3bAVIs7h2XGCXWFI9L7iI5sB7bqrqrRD
         KiMI+TdBganx9KBCg9N2mC7pwzEpXFcd34UJKsScKrHmFNkDPWZ+uZvGCzenOXeBTBYV
         PfAnofXtFH9zwqsc469qfhMv9b+yj5wGRmBb4jdGV6ZxmpAq7c+XVBiKRfVV2XToyf9W
         cqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715464008; x=1716068808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eCVJMzFVoc+BRHoT08G8Xmn5JdPV6LQjStyH9q97kgs=;
        b=EierQwn7nYxvTMMLbPvNDLkxR6CFgbQ4ep+4sT54MacIFhA68dJfj5wg/JG6tBTDXC
         fU7vd/fwrd7eYUofrG5I/nfdBvG81AmpaanUi0b+yMzR2Of+t8HzS1o5MeAGkrCWO0U9
         4dbUBmENfkWrvpemclf/zPO+jWXUtVVC7CVYdgnIS5DhcRXYxOENRc2qRCqHlF7Ex3Yv
         GuMQ17vmQpnUFC78Npi+k5BiXikOZ+oh0yGfhWq2xLUCjTNDHkmQuz3XTqDdFHRd2Fsk
         GZjGVDm+0Yzzr8gdrLXuyNqhH3uVcNoX7qoVjvE0A371qm9PBSGXsDoFL+0Sdy8ITZdL
         n2Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUgXCqhOg5JWCJOvVfIRR6MNds60dI+qQF9LkSnZM8DNeyVDp1LW4reCaJzWlhM5fQUBb4TuT3ItDTEgWMDDfWumDnJbroJ8krN0hsB1UBoRXcbUx7JGj3kFS0PGOsudyRWyRlaRtuyu5g=
X-Gm-Message-State: AOJu0YxBaPEnu/cIK/IlHxO2eVujAweGpOtZzalRPRi+jicDEeUGMCRV
	Ao9HefyITvOzKKdqcp7Jgtrw+Goh56X+3VQfzT/kzaFDXhaZo9jhspBgHfd5OZ8=
X-Google-Smtp-Source: AGHT+IHY0s6Kbuqn2GTExvPKTmIO9p64Dem87wOTwxfXJZrpnCk9XO8x508ZhLwCTRapY6MUpIW4XQ==
X-Received: by 2002:a17:903:246:b0:1e2:bc3c:bef6 with SMTP id d9443c01a7336-1ef43e2797cmr70728535ad.37.1715464008240;
        Sat, 11 May 2024 14:46:48 -0700 (PDT)
Received: from xiaxiShen-ThinkPad.dhcp4.washington.edu ([205.175.106.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c038679sm52913235ad.208.2024.05.11.14.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 14:46:47 -0700 (PDT)
From: Xiaxi Shen <shenxiaxi26@gmail.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Cc: shenxiaxi26@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	javier.carrasco.cruz@gmail.com,
	skhan@linuxfoundation.org
Subject: [PATCH] ASoC: dt-bindings: ak4118: convert to dt schema
Date: Sat, 11 May 2024 14:46:24 -0700
Message-Id: <20240511214624.242579-1-shenxiaxi26@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert ak4118 binding to DT schema

It passed dt_binding_check and dtbs_check. Let me know
if you think it should include something else

Signed-off-by: Xiaxi Shen <shenxiaxi26@gmail.com>
---
 .../devicetree/bindings/sound/ak4118.txt      | 22 -------
 .../bindings/sound/asahi-kasei,ak4118.yaml    | 58 +++++++++++++++++++
 2 files changed, 58 insertions(+), 22 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/ak4118.txt
 create mode 100644 Documentation/devicetree/bindings/sound/asahi-kasei,ak4118.yaml

diff --git a/Documentation/devicetree/bindings/sound/ak4118.txt b/Documentation/devicetree/bindings/sound/ak4118.txt
deleted file mode 100644
index 6e11a2f7404c..000000000000
--- a/Documentation/devicetree/bindings/sound/ak4118.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-AK4118 S/PDIF transceiver
-
-This device supports I2C mode.
-
-Required properties:
-
-- compatible : "asahi-kasei,ak4118"
-- reg : The I2C address of the device for I2C
-- reset-gpios: A GPIO specifier for the reset pin
-- irq-gpios: A GPIO specifier for the IRQ pin
-
-Example:
-
-&i2c {
-	ak4118: ak4118@13 {
-		#sound-dai-cells = <0>;
-		compatible = "asahi-kasei,ak4118";
-		reg = <0x13>;
-		reset-gpios = <&gpio 0 GPIO_ACTIVE_LOW>
-		irq-gpios = <&gpio 1 GPIO_ACTIVE_HIGH>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/sound/asahi-kasei,ak4118.yaml b/Documentation/devicetree/bindings/sound/asahi-kasei,ak4118.yaml
new file mode 100644
index 000000000000..abbce999eb30
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/asahi-kasei,ak4118.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/asahi-kasei,ak4118.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AK4118 S/PDIF transceiver
+
+allOf:
+  - $ref: dai-common.yaml#
+
+maintainers:
+  - Liam Girdwood <lgirdwood@gmail.com>
+  - Mark Brown <broonie@kernel.org>
+  - Rob Herring <robh@kernel.org>
+  - Krzysztof Kozlowski <krzk+dt@kernel.org>
+  - Conor Dooley <conor+dt@kernel.org>
+
+properties:
+  compatible:
+    const: asahi-kasei,ak4118
+
+  reg:
+    description: The I2C address of the device for I2C
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0    
+
+  reset-gpios:
+    description: A GPIO specifier for the reset pin
+    maxItems: 1
+
+  irq-gpios:
+    description: A GPIO specifier for the IRQ pin
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - irq-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+   i2c {
+     #address-cells = <1>;
+     #size-cells = <0>;
+     ak4118@13 {
+       #sound-dai-cells = <0>;
+       compatible = "asahi-kasei,ak4118";
+       reg = <0x13>;
+       reset-gpios = <&gpio 0 0>;
+       irq-gpios = <&gpio 1 1>;
+     };
+   };
-- 
2.34.1


