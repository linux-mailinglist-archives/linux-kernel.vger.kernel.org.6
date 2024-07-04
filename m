Return-Path: <linux-kernel+bounces-241640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03098927D72
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 21:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C4961F24CF9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D6F131E2D;
	Thu,  4 Jul 2024 19:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0doIfOC"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98A67344D;
	Thu,  4 Jul 2024 19:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720119720; cv=none; b=hGzHwYAKC4FSv/y+I5isojw5FjFIreNvuBMJyijg/9JTVtUA+ZYQYY6zXr2hB0XrJsWmEx/Im7TUj3gDoy9xT7QqU7UxTdricRzKVnSQQDVcimHFcFm97WsX976PRqxGzmqwGD3ojw4m/W5SIDP2eUMBDiTBdYI7E4qpxLfmbrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720119720; c=relaxed/simple;
	bh=nmMRH5pXrMMRKuug0BuIt4QE4BnydUTQpv/mMb3qEJw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rMiQX9P/vavZsMzXzOgo4mrOCguQPy3r4rsg4+TenPWxusFpWttimOCC65+TevLIfOfK3CSu4n7ut8F0CQNXY6kHWsl2ILaVfU9+3SjFoI+a9OXc4GswWBS+Qllol+cxXG1pA//f7PetEqajPQdVJgxDcrvckOHsBFy5Wy+TwAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0doIfOC; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-367a23462e6so422288f8f.3;
        Thu, 04 Jul 2024 12:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720119717; x=1720724517; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YEliSMC16j7aM+RT12WbhyFPc+cpM+7NR5Vb+5oa/1w=;
        b=T0doIfOCWbfCM0uSzB6OKzB3a9ynCTgT/u20enp4rZTBpfnlmCojhdlu3qsq15PbQp
         87gKpgQWfzChf8vd21dt9VDa8Sm/roGjSb0d4aFBfL65oreJW/2/wUxybaHPVB7wpWDV
         xig7nXqXBb+xSrqMAir/5qeRKGSvr/f/6uqpKk9ok2rBPlLWUmodkYDBv3qOnX1r2wPy
         kC4c0/m8DbHpn6M/xjDF28JWozaREzR4pQitYUnUBFDjKfrNWyvh482QQA8cqb5Ze4bv
         vwhHMmqE/7tY+wmAIo0m09PJsv+74G4jhFoxIQcyvmXe9DxN30e6LNuTq2IUSGddh9xp
         Ud7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720119717; x=1720724517;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YEliSMC16j7aM+RT12WbhyFPc+cpM+7NR5Vb+5oa/1w=;
        b=cEfUZfAHBntt8UKCy08IHcTLF28DIEsw+3r0MIOK57HaLHavY7WZJ9VIDyc9259cG6
         Rba7yw+F0egdpwW1rgIUFBNWLkZ9UyjlSqgzcKS/SFOiasssF5VXKwTcsHTqTNQgbnPc
         9MDmeJ2+Dm4rNTLQmXpOO5+96/lTi0cD5tZxU9DlgNr+P+hU/tLD279GzDHgaA/fLQzu
         hjG/1mToSS1wokm0E0RSk34TnCVG7KKIm9/oGPRgo5tBUgjYbb6+ZK3Z3xErvpvQPrSD
         T/Ej2yrFSETKqYMXu9SwoBzbeeGbIHrYQy5YoGakTOxOxnwLvfpHarqWpcd9PgNQaJLH
         rPtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXUikAJsKbdSfxeCGzznS/KQCc3SzqRIAlTIgCdvoCap3LFHlxco9yZ0W1rOlgFiKGhNBHKMsXnoMdzsKL5b+T59A5YK7VM+awDA==
X-Gm-Message-State: AOJu0YwRrkTRd9ZrmTz8Gs3jdhLhcWFyBSaf4pdirc6PzLtfZS3dBpAY
	ZvLlb/TJtHeVdH5WeSnUSgQr8MweljurvXUTYjqYP0ffoXj+x+g5
X-Google-Smtp-Source: AGHT+IE9o2urE3a2f9G2KQXy1ofKL771HQTP7bu92yZO6KSXO8w4D7Y8Zf4OKZRL1AyQIvyv9ZnAEg==
X-Received: by 2002:a05:6000:1245:b0:367:88c2:bcfc with SMTP id ffacd0b85a97d-3679dd15b9bmr1983390f8f.1.1720119717032;
        Thu, 04 Jul 2024 12:01:57 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679224d11dsm5098853f8f.12.2024.07.04.12.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 12:01:56 -0700 (PDT)
Date: Thu, 4 Jul 2024 21:01:54 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolin Wang <baolin.wang7@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: regulator: sprd,sc2731-regulator: convert to
 YAML
Message-ID: <ZobxoobZvA8k3pyi@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert the Spreadtrum SC2731 regulator bindings to DT schema.

Change during conversion:
  - switch compatible from sprd,sc27xx-regulator to sprd,sc2731-regulator,
    same as the only in-tree user has done back in 2019 [1]

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/arm64/boot/dts/sprd/sc2731.dtsi?h=v6.9&id=0419a75b1808dda225b17ba1509f195f23c0db88

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 .../regulator/sprd,sc2731-regulator.txt       | 43 ------------
 .../regulator/sprd,sc2731-regulator.yaml      | 67 +++++++++++++++++++
 2 files changed, 67 insertions(+), 43 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/sprd,sc2731-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/sprd,sc2731-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/sprd,sc2731-regulator.txt b/Documentation/devicetree/bindings/regulator/sprd,sc2731-regulator.txt
deleted file mode 100644
index 63dc07877cd6..000000000000
--- a/Documentation/devicetree/bindings/regulator/sprd,sc2731-regulator.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-Spreadtrum SC2731 Voltage regulators
-
-The SC2731 integrates low-voltage and low quiescent current DCDC/LDO.
-14 LDO and 3 DCDCs are designed for external use. All DCDCs/LDOs have
-their own bypass (power-down) control signals. External tantalum or MLCC
-ceramic capacitors are recommended to use with these LDOs.
-
-Required properties:
- - compatible: should be "sprd,sc27xx-regulator".
-
-List of regulators provided by this controller. It is named according to
-its regulator type, BUCK_<name> and LDO_<name>. The definition for each
-of these nodes is defined using the standard binding for regulators at
-Documentation/devicetree/bindings/regulator/regulator.txt.
-
-The valid names for regulators are:
-BUCK:
-	BUCK_CPU0, BUCK_CPU1, BUCK_RF
-LDO:
-	LDO_CAMA0, LDO_CAMA1, LDO_CAMMOT, LDO_VLDO, LDO_EMMCCORE, LDO_SDCORE,
-	LDO_SDIO, LDO_WIFIPA, LDO_USB33, LDO_CAMD0, LDO_CAMD1, LDO_CON,
-	LDO_CAMIO, LDO_SRAM
-
-Example:
-	regulators {
-		compatible = "sprd,sc27xx-regulator";
-
-		vddarm0: BUCK_CPU0 {
-			regulator-name = "vddarm0";
-			regulator-min-microvolt = <400000>;
-			regulator-max-microvolt = <1996875>;
-			regulator-ramp-delay = <25000>;
-			regulator-always-on;
-		};
-
-		vddcama0: LDO_CAMA0 {
-			regulator-name = "vddcama0";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <3750000>;
-			regulator-enable-ramp-delay = <100>;
-		};
-		...
-	};
diff --git a/Documentation/devicetree/bindings/regulator/sprd,sc2731-regulator.yaml b/Documentation/devicetree/bindings/regulator/sprd,sc2731-regulator.yaml
new file mode 100644
index 000000000000..ffb2924dde36
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/sprd,sc2731-regulator.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/sprd,sc2731-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Spreadtrum SC2731 Power Management IC regulators
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+description: |
+  The SC2731 integrates low-voltage and low quiescent current DCDC/LDO.
+  14 LDO and 3 DCDCs are designed for external use. All DCDCs/LDOs have
+  their own bypass (power-down) control signals. It is recommended to use
+  external tantalum or MLCC ceramic capacitors with these LDOs.
+  Valid names for the regulators are:
+    BUCK:
+      BUCK_CPU0, BUCK_CPU1, BUCK_RF
+    LDO:
+      LDO_CAMA0, LDO_CAMA1, LDO_CAMD0, LDO_CAMD1, LDO_CAMIO, LDO_CAMMOT,
+      LDO_CON, LDO_EMMCCORE, LDO_SDCORE, LDO_SDIO, LDO_SRAM, LDO_USB33,
+      LDO_VLDO, LDO_WIFIPA
+
+properties:
+  compatible:
+    const: sprd,sc2731-regulator
+
+patternProperties:
+  "^BUCK_(CPU[0-1]|RF)$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+  "^LDO_(CAM(A0|A1|D0|D1|IO|MOT)|CON|EMMCCORE|SD(CORE|IO)|SRAM|USB33|VLDO|WIFIPA)$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    regulators {
+      compatible = "sprd,sc2731-regulator";
+
+      BUCK_CPU0 {
+        regulator-name = "vddarm0";
+        regulator-min-microvolt = <400000>;
+        regulator-max-microvolt = <1996875>;
+        regulator-ramp-delay = <25000>;
+        regulator-always-on;
+      };
+
+      LDO_CAMA0 {
+        regulator-name = "vddcama0";
+        regulator-min-microvolt = <1200000>;
+        regulator-max-microvolt = <3750000>;
+        regulator-enable-ramp-delay = <100>;
+      };
+    };
+...
-- 
2.34.1


