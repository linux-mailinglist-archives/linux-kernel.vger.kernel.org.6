Return-Path: <linux-kernel+bounces-516106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C77A36D01
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 10:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD381718AA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 09:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F8E1A5BA1;
	Sat, 15 Feb 2025 09:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1iOsKfs"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AEB1A3165;
	Sat, 15 Feb 2025 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739612394; cv=none; b=cZ7D3er8JcsSpDMqRI5WVwsRrLWg5Z/hcCFkC+yJZwP79d6Js8eTK1okuupv4bYDK7gXBSB7rzwFIIMH0ChX0E1T7nVszb6UXSKKMCmO897aEx15H+AysQeKI8dvNGt8LV0kyZMJygLRxlK40GQKkQbXQrUcl8u3Vs2yJNB52FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739612394; c=relaxed/simple;
	bh=oSsgHxWm93UX4Dr0gTfLMbljoK+SAeJiEhBDHrh1GCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jqaAxPFA2OLlK6HggSGUFfHIcAj4+PXo4++bQSrCDRnnQAdUYBWMiZLMXg1kqZYJGbKEi1VOoOJRtYOKB6mPCvCcdcW/KQCq7lQduyNOgKnnDpz5dFkvOS4irsLTxCH0r8sFjO/2zB/RLZWVVb5AN/q2+NxNh2kCEiokfiD4mUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1iOsKfs; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5ded46f323fso3284126a12.1;
        Sat, 15 Feb 2025 01:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739612391; x=1740217191; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=97ERf3V/Bpk7MgoHGPJsnvkiQqZJeJp/kSKmJml6+us=;
        b=P1iOsKfsb+wmyBJpq3L32BqYanZuyfEPHupteGQRTTgaZGJ++iE9XXlBpwZMtzuPgY
         pIsutUDE/9Z3cTOwohg7L42br3uRZYKN4A758ER+6jCsGu3tgGsXkx0lDZUznow2oCou
         f7SstBqeSzvF3YcAdQ725BMota1j6asZUng4sxEKPpfC8rk4NSvLrlM/YkoafPnwky4i
         g7rO9GNs7IIRvPiagsGJYoogONMFA3m/zK52wcihQncW986taZlA/EcEh7L3awGcBOzn
         IaL8z+HwfMEFozU+ituxhWJkXwk0R1Vj2kxQZHrSnAlVh0iatgdI189swPb6NCu48Pts
         ZCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739612391; x=1740217191;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97ERf3V/Bpk7MgoHGPJsnvkiQqZJeJp/kSKmJml6+us=;
        b=jL2b9pfxEmz1nRw+63CxhKM9tWt1V2BBng+7sn2ipo2jRTVMjLeZ7P0cgNjykQO4Nv
         e5yKVodEveBvz5HjmWvC0YqcHl18ExEiEa9aGsR2b3YO34t90/L2S435wFlkXviVtQxc
         H+996eTsWcrLMVV5TfDF4DDEzK42i7jV/XLaOwezaKDRmLWXLr1AjZWChJoo6AW5p/MX
         FtGKZpfbxjZ7jQAecWnCpE6wx6Egq/U6+AKH2ia1ONTReguBxSXo68OwuISpz/lyk0lx
         hK3hygnL4cq8RZi2XNkxC3qhPk+Ls5+ARmYiHIlvidqrdf9M3d5FsA9bGo9OCAmTeTuj
         RVuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVB+sv4rJ9q62j/gETOSyHJmlTwxdtFW+jncQNU/dTMcxBhGxjbOnwIzRMhXDm/EuX3x5005MO6AWJsDNsm@vger.kernel.org, AJvYcCWLQyUdXgEx6lsSkx1iyfVgK0jASggjtO8KgjoyLuWG62zD6TiVCdGsOtFyyPURuHdEuym7YMREfUtp@vger.kernel.org
X-Gm-Message-State: AOJu0YztPejlVwH9WneufB8IhwfGoRXN2ZifDql7cJfUOCbL9qebBko8
	d/bu+6k/5V/Jd6Moe32GGughxp3f+CslpViojntIPHS9q2WfOnkI
X-Gm-Gg: ASbGncu/Bfbmd8UjIyWbcAEc8NYt9b4Zcio5dh0EPSUvEcczlP5zlTZ5zTNl/Xr3pPS
	b5qQc3AOVZ264tGHJX/0DOwInlvSuymYLMvsdZV5oSDS2Wzkbm4akKx9eAae2caQQPGS+wbYPUi
	Pv287NV9ETAgXNxsIae8gHXg7LjBMLz2WvjNHdAKpMl5KEq+nWLcn6xFFcXjwpLL+GqaTyZMrJS
	Z1aV45gPX1s5ZxnfeZ1qh5XdmbMXoS1wZ3ItioPLSjJ/P5JT78wKjpH8HMBW+GWXRshAEVZCsvM
	hkO9ExbCmiJG4+N1HyoWE+iC0N9yrfGwOGYmhZPQnI0dCQDherng9PWCdLerYA==
X-Google-Smtp-Source: AGHT+IEmnfJdkVs52L6LtS2eYqiXXVArGWoGY9+5/Wydc6pEP0Nw9yS668U0eiqIjzSLV5V8VEZv8w==
X-Received: by 2002:a17:907:9494:b0:ab7:d537:91cb with SMTP id a640c23a62f3a-abb70aa6217mr212329266b.7.1739612391125;
        Sat, 15 Feb 2025 01:39:51 -0800 (PST)
Received: from hex.my.domain (83.8.115.239.ipv4.supernova.orange.pl. [83.8.115.239])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb7aecd3d5sm69698966b.148.2025.02.15.01.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 01:39:49 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Sat, 15 Feb 2025 10:39:38 +0100
Subject: [PATCH v4 3/9] ARM: dts: Drop DTS for BCM59056 PMU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250215-bcm59054-v4-3-dbfb2d76a855@gmail.com>
References: <20250215-bcm59054-v4-0-dbfb2d76a855@gmail.com>
In-Reply-To: <20250215-bcm59054-v4-0-dbfb2d76a855@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739612381; l=4265;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=oSsgHxWm93UX4Dr0gTfLMbljoK+SAeJiEhBDHrh1GCg=;
 b=fjXL2zGg8ujsZq9zIspXdWAZocT7+/ynnRoq3vtY6cN/EMAPNNhRAykXbVwC4fTyzU6uFjpD4
 67PUnbgruY4BbzW1zdF7UlNGtCMUNBC60UObuTumMaUNHHAh3s4tyGn
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

The BCM59056 PMU has its own separate DTSI, meant to be included
in a DTS file after defining the pmu node on some I2C bus.

This seems rather unintuitive; drop the DTS in favor of adding the
BCM59056 PMU node directly into the device DTS files.

If the amount of subdevices supported by the BCM590xx grows, and
a common device tree turns out to be beneficial, it can be reintroduced
in the future.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v4:
- PMIC -> PMU in commit message
---
 arch/arm/boot/dts/broadcom/bcm28155-ap.dts | 68 +++++++++++-----------
 arch/arm/boot/dts/broadcom/bcm59056.dtsi   | 91 ------------------------------
 2 files changed, 32 insertions(+), 127 deletions(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm28155-ap.dts b/arch/arm/boot/dts/broadcom/bcm28155-ap.dts
index 2f3634545e64978888cd0b47fd5647a5e2eb8e07..cefaa9a3c45c9c90bffc08f739161d8ea21d98dd 100644
--- a/arch/arm/boot/dts/broadcom/bcm28155-ap.dts
+++ b/arch/arm/boot/dts/broadcom/bcm28155-ap.dts
@@ -37,7 +37,39 @@ &pmu_bsc {
 	status = "okay";
 
 	pmu: pmu@8 {
+		compatible = "brcm,bcm59056";
+		interrupts = <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0x08>;
+
+		regulators {
+			camldo1_reg: camldo1 {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			sdldo_reg: sdldo {
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+			};
+
+			sdxldo_reg: sdxldo {
+				regulator-min-microvolt = <2700000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			usbldo_reg: usbldo {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			iosr1_reg: iosr1 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+		};
 	};
 };
 
@@ -74,39 +106,3 @@ &usbotg {
 &usbphy {
 	status = "okay";
 };
-
-#include "bcm59056.dtsi"
-
-&pmu {
-	compatible = "brcm,bcm59056";
-	interrupts = <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
-	regulators {
-		camldo1_reg: camldo1 {
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
-
-		sdldo_reg: sdldo {
-			regulator-min-microvolt = <3000000>;
-			regulator-max-microvolt = <3000000>;
-		};
-
-		sdxldo_reg: sdxldo {
-			regulator-min-microvolt = <2700000>;
-			regulator-max-microvolt = <3300000>;
-		};
-
-		usbldo_reg: usbldo {
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
-
-		iosr1_reg: iosr1 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-always-on;
-		};
-	};
-};
diff --git a/arch/arm/boot/dts/broadcom/bcm59056.dtsi b/arch/arm/boot/dts/broadcom/bcm59056.dtsi
deleted file mode 100644
index a9bb7ad81378d88811c4473763c579d3d2c006a1..0000000000000000000000000000000000000000
--- a/arch/arm/boot/dts/broadcom/bcm59056.dtsi
+++ /dev/null
@@ -1,91 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
-* Copyright 2014 Linaro Limited
-* Author: Matt Porter <mporter@linaro.org>
-*/
-
-&pmu {
-	compatible = "brcm,bcm59056";
-	regulators {
-		rfldo_reg: rfldo {
-		};
-
-		camldo1_reg: camldo1 {
-		};
-
-		camldo2_reg: camldo2 {
-		};
-
-		simldo1_reg: simldo1 {
-		};
-
-		simldo2_reg: simldo2 {
-		};
-
-		sdldo_reg: sdldo {
-		};
-
-		sdxldo_reg: sdxldo {
-		};
-
-		mmcldo1_reg: mmcldo1 {
-		};
-
-		mmcldo2_reg: mmcldo2 {
-		};
-
-		audldo_reg: audldo {
-		};
-
-		micldo_reg: micldo {
-		};
-
-		usbldo_reg: usbldo {
-		};
-
-		vibldo_reg: vibldo {
-		};
-
-		csr_reg: csr {
-		};
-
-		iosr1_reg: iosr1 {
-		};
-
-		iosr2_reg: iosr2 {
-		};
-
-		msr_reg: msr {
-		};
-
-		sdsr1_reg: sdsr1 {
-		};
-
-		sdsr2_reg: sdsr2 {
-		};
-
-		vsr_reg: vsr {
-		};
-
-		gpldo1_reg: gpldo1 {
-		};
-
-		gpldo2_reg: gpldo2 {
-		};
-
-		gpldo3_reg: gpldo3 {
-		};
-
-		gpldo4_reg: gpldo4 {
-		};
-
-		gpldo5_reg: gpldo5 {
-		};
-
-		gpldo6_reg: gpldo6 {
-		};
-
-		vbus_reg: vbus {
-		};
-	};
-};

-- 
2.48.1


