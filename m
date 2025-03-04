Return-Path: <linux-kernel+bounces-543274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31009A4D3B4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F82E1897EB2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14441F7060;
	Tue,  4 Mar 2025 06:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3JO3756"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682371F5838;
	Tue,  4 Mar 2025 06:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741069253; cv=none; b=PiVgcPB5OUvS2aoGdd+slbRaub3tsR7Q6+Dm0FCM4THecFdF21UkBmenWSF1At46+drlBlOuTHrJ2NcBxZ/NYZrMYUP1fkioVCOt+Y1AfpumPxSSoIFo6RfKDUnkMHfD5Naez8/MhVz7AkQKj+OW8GtFQ9XWSTKT/Z/E7CffMiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741069253; c=relaxed/simple;
	bh=oSsgHxWm93UX4Dr0gTfLMbljoK+SAeJiEhBDHrh1GCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oyYOSomFdHhFM+HGSK2o9urQqGDi2lBlg2OHbx4KJVZ5AnhWREyY+3uAjrwJBCFs5sRhCQfIkEW0td3zuSk+sCgbXjP3mxQnbD2EXp/yGZ8EkRBsqIlQmwjnls1J2VcIMPs4bVXFwW7CG+I+1i2t7mEOP6qY0DqwBlxH9nGYkr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3JO3756; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e058ca6806so8530010a12.3;
        Mon, 03 Mar 2025 22:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741069250; x=1741674050; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=97ERf3V/Bpk7MgoHGPJsnvkiQqZJeJp/kSKmJml6+us=;
        b=c3JO3756sarsXaj3XALp9TCt00dn9fVYFxTJfws2XsM7oQw8eMkSOrsICmZ4R5F5iG
         b1xz0qWCkAFcGTtniMEAdL54Z24Q162PWkK4a6urviWzbogLnJhApOF2JUVokhom/62+
         ifYNPOVAcQGBYFyQOilEW1uOJYceiuG/mPzRDJIedy1hu28FBgv3A7H6EPjzomSLwcfr
         luK/5ZISM1h+m7CV9x2BAoQYJtyqoMa3hjkpoYmA2b4aSi2J38icHwQ2fpXrwcKDqjSG
         z6N4/JA2I999VAkkIemvrIDd6Om/jz5nMyPRo2xWgzT58WP+CyGaTSnKEfiEhsBfAE+n
         doSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741069250; x=1741674050;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97ERf3V/Bpk7MgoHGPJsnvkiQqZJeJp/kSKmJml6+us=;
        b=OSrSDH2BerZIOVoC2eMOiCKsEn8/ZqUs+vYln5X85GvrhIMBMkQzDg7gL0lr5NuheV
         u2IhV1y7leFFsW49AJyvoYV86C8oBvi/xN7G3GNnIuxwRuQioVQ+JZEWs9U1QPq/6qt6
         9vufJKR2OoAT/Q0YG/jhyv1jcEO4YqsLQZNW3y4oPZj10pA9CptDK0LcKCjbWJDCE/2d
         /mSFMqfZoNV3KJ0IONwK4Zwn8JrVATYw62lImUHdifSOmo4HxhCQQBlsVNegXZXWXE+f
         Wr/G1S/oRPrmjmXgwkM7i2Ssbtl1GkCDL7Ls1+Ug6CtuuOmHSRmQ03EpBbWozHxcQ8o+
         P0gQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9Fzasl4H8i3UVatAkdOPJlQvNyY1vK347ILoNVi/EG8JFC2HHwWP51qy2CLzsdz8bMYlxeSxsV7/c@vger.kernel.org, AJvYcCVSRbGh0AxRgUC8AxQnxbtNAQLk0zJDE3Sz/uKNOncdZE2pq0txkxaZuib2sG7gb7N6iHbe5BQxaa4ACWja@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz6xoO6Qhy6JS3wd7owfT3AkjV5s/39N6iStlMcdF8oLQhcAUY
	2ylKzdw9INtaalbhn0hrAGneX7aSIojhow8GJ0vxigvAptOftHJX
X-Gm-Gg: ASbGncuCCOsdB84Q6Tin1oXCjRnhL3eLkR5RO3glKcc0xP5klrNb3RYel3Kh/Ze5p86
	4POwZBRTxzgMUV5L0y25WEgJ23AL4xMhUs4KKGzsOJxHVRzdsJg0SMIkJq9MuhKfjdNOxd8sNWy
	91If0FOlK6teiuOE+HsAA9fr+zOA//OQL81BmcIXTVAOlDj6cTh+tOmSRCyY9VtRpSnLY4Tqo+b
	I1fXqk3aEyeo3UDA1f27Z+Gf8svOHqh/0DHbBUIQolbOVHpAfefxkXXDQb9WkNf+LFU/WVJiJVw
	+dCvJQT8ELB2dGmjoPJVb8P3RLPMStFSFQTxCEAY6TfmkNfzCaO6J8yCx0fkUIzRGaG9E5r84YZ
	KRZnw7jl1o1PNYn4=
X-Google-Smtp-Source: AGHT+IETu8E7wBlicYrIJPSlHcZly3Nq9bJ5rvMGIHFhEg3oFUbbPHyfXTWuUCwSJ4ixrhNvMNd+Lg==
X-Received: by 2002:a05:6402:5190:b0:5dc:1289:7f1c with SMTP id 4fb4d7f45d1cf-5e4d6b853a7mr19363341a12.29.1741069249529;
        Mon, 03 Mar 2025 22:20:49 -0800 (PST)
Received: from hex.my.domain (83.8.122.142.ipv4.supernova.orange.pl. [83.8.122.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c43a663fsm7609036a12.68.2025.03.03.22.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 22:20:49 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Tue, 04 Mar 2025 07:20:34 +0100
Subject: [PATCH v6 03/10] ARM: dts: Drop DTS for BCM59056 PMU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-bcm59054-v6-3-ae8302358443@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741069240; l=4265;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=oSsgHxWm93UX4Dr0gTfLMbljoK+SAeJiEhBDHrh1GCg=;
 b=0Ge+lOaV9AGpWKF2qpI9XFmgFwmsiyDdxZ9rSmekozIIvQToAB7WXH8CJNzl3txCTOGpL4DBN
 THKadnJOkdeCdQTORr5ZP8w7+7qHglq/cP1gr+oih6+hQcISNGQmhiN
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


