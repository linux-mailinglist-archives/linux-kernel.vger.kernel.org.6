Return-Path: <linux-kernel+bounces-526580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2D1A40093
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9CF67A4181
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D89253F2D;
	Fri, 21 Feb 2025 20:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxbT5lcG"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BE5253F06;
	Fri, 21 Feb 2025 20:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740169002; cv=none; b=f4+Dagc+m/Z9vVfrwIMQNCkiYU/igU25LH49859S5Zq07IMiFR0yaMe7bD045HcRmeeJWgl0VcHMIeY7cKYy/s3BmKPu+KHitJMzd0l4iTDbquyUnTqAX36iZBhpUxmtBGWq+OTqQIl5gdwcJ8J2VhfX1KoFZL6ioGb3XFYoUG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740169002; c=relaxed/simple;
	bh=oSsgHxWm93UX4Dr0gTfLMbljoK+SAeJiEhBDHrh1GCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qn/aKqR4DNAK8bJa9kwD1CApaZIb9aroXv78GZdgG8JnBOn6DX/JaXAGcXYOTrOnept6voKHSssweBz0YSvIS4qIYUNdmBTTzo/zZl6uluFuiB3vjUC5/6v8C/T+pllPt/oHbFXLmsnwRxfRxDFE8u+YqLml5NugKwyNQ9A+u80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxbT5lcG; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5debbced002so4641750a12.1;
        Fri, 21 Feb 2025 12:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740168998; x=1740773798; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=97ERf3V/Bpk7MgoHGPJsnvkiQqZJeJp/kSKmJml6+us=;
        b=AxbT5lcGEyuSWFnKJEn3mYnEvP3RumxXCOhcgep2lYbAFsmtLD11j4e6b1/Ua91fWK
         9fJLic+AI0JmAjQYX6fCOH8ZFhkbO83/PwqMGyJj+P4s2Q1eqJdF6kgVKuaazEY8RQ/+
         G99vcpvimIfjZMK0YRkfZkjwjad+a4K735zBDunsfBHyS9GjJfF6oEGrHjgj5nGKFev+
         VtMSdJwz3o3O+9UqhP2czNZUEgiTChglkNNf9C7mpFdxjLL8f8jCkXTKhpe5Y2DalGl8
         t1qkpew+FWTHczFSQIyyISB5hlvho4AsyQZ7bnRzpVUeXOeLpAeU0mkPh5xQaA5adQEu
         sdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740168998; x=1740773798;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97ERf3V/Bpk7MgoHGPJsnvkiQqZJeJp/kSKmJml6+us=;
        b=BZCILAXXltb0tn0z2+yFr2+Nyk3BeGa0CVykhGjyWoGrj0LJJRT/QREm7gYdPsnvhu
         H7pUspsMGuUTK3m64PRBQ5wSZLmFJZc12E6+77artCAXNWPmC4zxHsAJ2WFRnW1NeAKL
         qIrB6JRuM4qBtlhJA6W8VY/5Eu8F8nkXoYpByTvdUk1uPLTMr1DrXrrvEw8Eh3fi/dcR
         xdbaZ+dPRqCJRbDzqe8bTuDEp+PhbSuJWCB+A2wRlrBSP3lFUMXckku0qtbZMg9OBIZ2
         2NhPRiyWvFMtzEoaB4aVDa96cG54rdkfc1TfPdKm0VX85oyM0xLukR+sHRmifEgOO/Wr
         eChw==
X-Forwarded-Encrypted: i=1; AJvYcCVUmlTUhy45qxmldTaSzxlX/JZMNGfzXvKC1FRectlVTsahhoHquD49fsxBXdxpwuM9FpRjd6exqw1lkcly@vger.kernel.org, AJvYcCXXQGy/MpvnjEQ/pWpSKBfm/Jr/1dhArNuJclPRn9h3CDv2DJrdB9GLHPy7KcTtL0nf6id+bz5qOpFY@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0wE++EtFrCjjrhhBOMBCf5EAH8BtJNP5zDF/RWDvvHe9Z7jo0
	7mup8m8pYqscWbYVW12mOTjk6oUpF+0ZREVoDT7VPptY03W1EvID
X-Gm-Gg: ASbGncuhIIdRXX1HrQiqcwfIcdYD76yxu+gI8dtsKZsx35HbVmAzth6CjVdruG9MiDJ
	8ON7CESt3JvsDVRKagecNGcNfRc3i6+ZeUcXo7fiZuH9jH2eC4Ufu24w5eKGaz2sViRljpuKkUL
	xhLSDbMIaCtYxxVrN53GUimgpjqX/i7dWvdh3bgm+2WhxhxPhFhv051COkF6LTc8Az0mKDokxpz
	h3WJ5UALBmB9/hT9ml5fgFZS9oC9nb+kABfCsi4YSha7pH0x+3+AfysT/rbYWMz2r4r3hXvmxWz
	DyD4pxSTPSKCb+cGb+g9TVDfn3NPl93nLcOw1fGVvAfPF6Uc2ah+Xr71voqDsrA6BrVWiqch
X-Google-Smtp-Source: AGHT+IFX0cBW5NhhaqSoZUE02MmKdZx+XfwVP6S+FGJatQ0gAH+hL5/+9KxAWHDDmDivmB6UEYLASw==
X-Received: by 2002:a05:6402:40c1:b0:5de:4f4c:3780 with SMTP id 4fb4d7f45d1cf-5e0a12212afmr7730937a12.5.1740168997874;
        Fri, 21 Feb 2025 12:16:37 -0800 (PST)
Received: from hex.my.domain (83.8.202.192.ipv4.supernova.orange.pl. [83.8.202.192])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1b4f70sm14127594a12.12.2025.02.21.12.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 12:16:36 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Fri, 21 Feb 2025 21:16:25 +0100
Subject: [PATCH v5 3/9] ARM: dts: Drop DTS for BCM59056 PMU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-bcm59054-v5-3-065f516a9042@gmail.com>
References: <20250221-bcm59054-v5-0-065f516a9042@gmail.com>
In-Reply-To: <20250221-bcm59054-v5-0-065f516a9042@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740168989; l=4265;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=oSsgHxWm93UX4Dr0gTfLMbljoK+SAeJiEhBDHrh1GCg=;
 b=xn8dnAj7UkaSerl2L1ALR3Y5M5eGQt/UvlOlAyVc7XHJXSagGqSJShZbZorT4vSLbeBF7DUCB
 6Z2MKxtI0c4ACsSDPw9TdM0NzcHlPX1kcetxY958MQJGSDqBQEjcQfi
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


