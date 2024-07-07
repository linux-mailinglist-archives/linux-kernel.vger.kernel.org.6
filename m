Return-Path: <linux-kernel+bounces-243488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8149296D1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 08:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53F1F281EBB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 06:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C8EBA2F;
	Sun,  7 Jul 2024 06:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwk0XcZD"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B46B4A1D;
	Sun,  7 Jul 2024 06:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720333710; cv=none; b=d8ZA8MzWmfV5Ic+igPtY0vchjyKefyQG/L3Lnuma+bLjaU1yiIU03o26YUJsG5i4ZuoOVQLQxbylPNlE1V3bMHcGL800QhtnjeuZc3VOYGduztE6oO2DglZwC29p2+7Iby6ytLvfDM3AFEvsni6ferI+guNQ8airdwhoK2+9XYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720333710; c=relaxed/simple;
	bh=GADGVIQ+z375aVHvcKgsktFjykd9IRuivqf+FIBeZBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lHsKCmw6n9psX6olSHKT7x/c93N28xIzF07yEH2biiFa7SLlBVypFF9CSrvvlipZmKYr0yUIT6VF9HAiIskD9Ge8cjaOjcafrttWPsWcUeZVpTHI9B0uQsooGYZgfepBuse3eIw/riqrKCCsYTpwkGMBXRJoSZVh7bEQm89bNR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwk0XcZD; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fa2ea1c443so21479035ad.0;
        Sat, 06 Jul 2024 23:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720333708; x=1720938508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l5tNj/A1m7ym+nbplCHex5l79VZ8cqmFsV8y1luHk2U=;
        b=hwk0XcZD2BNjpBTkOAQCa8aXGEceRCE8WwTt1rcnf2+p9ISLb9hbwInDfJDUZc03An
         DsPHBwTZHIELB545SZ+478T+8jxNqvLL+yHVgWlRo7WmnbLx4gxf92EMnkIF1xuVlhYC
         Ks1z8RtG/kz17pPkpAGo4uGO5k5C+OlcDIeBHMxL1MwuN2bsusXCdOR6GKMz+CEKkrAa
         /5o1ay+8V7nmntl9Kg3A/Fmhj6Jin5RdMb6tLIMGXFhrMLhdUxboSqoNuwWzRzUDasFY
         JuT+AMJIp+dk15CR1bw/ZLDfgPKmkYjH0gsmIUcmnDq6KSl7J3y8M1YcWDtzGXw/bWch
         hDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720333708; x=1720938508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l5tNj/A1m7ym+nbplCHex5l79VZ8cqmFsV8y1luHk2U=;
        b=ult5ACXDYVk0ucGs4/roWsjO3WGO5osKtk4mxkDisAe7cHkqDUF5rsLPm7JWj9sVE3
         /LVS9p50VvmUp5Z0E9ByE11voaW7JsUQC6RsQuJfyDhwMfx+MI8ZbIhLHP2062YATpPo
         5cCJ1s5f/KMJdeagSydefrOzHl+Z6e/VlR4wzwFOv0odM2C/DLrm/1eSUzID23COK3Y3
         A55zw/RbKccp+3gRaZZofvPqhVCeqCCGpiPt+yhlN7V1rVcsLj++Bs3w/Ml7j8YXeEni
         nPIga2EPw+Rl8ZXm00LJnxKbjrlJlUpxPyybJg1h3kGDAmaSsYEtiUwekK7M6zbeCckP
         ijgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI7MDcl9MAzXIhYsOvJzSF7qAYshEkkm1mYoLeEGcvwqMxqWFC146TH/fMoOnQ3T00spcgJKlfDnZ5KW5BZwzveYaOC3WH8KivVEg8THUeYEkZZFd/h2g1R4GLlDW0Ib2s0fkkcHVa/yHwg8wpGfJQGFg/dxT53aoJ2pwwB/kUViL+egng
X-Gm-Message-State: AOJu0YzqO2xEem1RzaaI/FqwNFg4AZG64echEKKeAu2vzzsmlEBceXbJ
	Ubo2VEtEyhFYDVcjv3W34VTxBzFK6FCVbJ/PQN3xW9XcTQxiU/DH
X-Google-Smtp-Source: AGHT+IHKfl1KS8Wj4Ovno8Mf6wy204G8pDN8gTXB3LmtLLIxQphYuCcaRx6DqgeB99rn+/r//tkdLg==
X-Received: by 2002:a17:902:ce8d:b0:1fb:82f5:6648 with SMTP id d9443c01a7336-1fb82f56afdmr10347935ad.36.1720333708260;
        Sat, 06 Jul 2024 23:28:28 -0700 (PDT)
Received: from fedora.one.one.one.one ([2405:201:6013:c9a2:59df:d296:bffe:732c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb1cb298cesm72739165ad.252.2024.07.06.23.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 23:28:27 -0700 (PDT)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: Animesh Agarwal <animeshagarwal28@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	patches@opensource.cirrus.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: cirrus,cs4270: Convert to dtschema
Date: Sun,  7 Jul 2024 11:56:58 +0530
Message-ID: <20240707062702.174390-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Cirrus Logic CS4270 audio CODEC bindings to DT schema. Add
missing va-supply, vd-supply and vlc-supply properties, because they
are already being used in the DTS and the driver for this device.

Cc: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
---
 .../bindings/sound/cirrus,cs4270.yaml         | 53 +++++++++++++++++++
 .../devicetree/bindings/sound/cs4270.txt      | 21 --------
 2 files changed, 53 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/cirrus,cs4270.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/cs4270.txt

diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs4270.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs4270.yaml
new file mode 100644
index 000000000000..824d799ee5ff
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cirrus,cs4270.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/cirrus,cs4270.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic CS4270 audio CODEC
+
+maintainers:
+  - patches@opensource.cirrus.com
+
+description:
+  The CS4270 is a stereo audio codec. The driver for this device currently only
+  supports I2C.
+
+properties:
+  compatible:
+    const: cirrus,cs4270
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    description:
+      This pin will be deasserted before communication to the codec starts.
+    maxItems: 1
+
+  va-supply:
+    description: Voltage regulator phandle for the VA supply.
+
+  vd-supply:
+    description: Voltage regulator phandle for the VD supply.
+
+  vlc-supply:
+    description: Voltage regulator phandle for the VLC supply.
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
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      codec: cs4270@48 {
+          compatible = "cirrus,cs4270";
+          reg = <0x48>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/sound/cs4270.txt b/Documentation/devicetree/bindings/sound/cs4270.txt
deleted file mode 100644
index c33770ec4c3c..000000000000
--- a/Documentation/devicetree/bindings/sound/cs4270.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-CS4270 audio CODEC
-
-The driver for this device currently only supports I2C.
-
-Required properties:
-
-  - compatible : "cirrus,cs4270"
-
-  - reg : the I2C address of the device for I2C
-
-Optional properties:
-
-  - reset-gpios : a GPIO spec for the reset pin. If specified, it will be
-		  deasserted before communication to the codec starts.
-
-Example:
-
-codec: cs4270@48 {
-	compatible = "cirrus,cs4270";
-	reg = <0x48>;
-};
-- 
2.45.2


