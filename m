Return-Path: <linux-kernel+bounces-563094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6E7A636EE
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 19:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 078D516DDDC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 18:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B478C1F4720;
	Sun, 16 Mar 2025 18:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeSYdcH0"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FA71EEA5D;
	Sun, 16 Mar 2025 18:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742149165; cv=none; b=mCuDaPGdIJopAIs2r7hMJaTcyQXVKwYSme8k8LoHYvC8LUiQ17gGT+nkMuGDe0w2vHdkjt8RZ5OKY9ep/y0IWLVbJsm0t2V9Vg7Fqt4bUbbqs3Y0ZtpFkSi3xf38DtbKQNJGEEjdxgNRmugjbSdZJsfbEwbR+kvVonA6qMMoL78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742149165; c=relaxed/simple;
	bh=oSsgHxWm93UX4Dr0gTfLMbljoK+SAeJiEhBDHrh1GCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J9k/G7SsumqylFScm3edZs9bgConm3zJ9N44sQ93gvLWI6DIDy6Q0cschRk75aDL4tsohQ3IC5dWWxUsnLNHFKQVhyGs/yndZ7xfrIvJHY+bA+pCbHLpx3w2IOMjcOtl3cHhmT+6EB7fAQWM/uskecx29VIY8TaI+vX7ivtl1e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeSYdcH0; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac2b10bea16so70094666b.0;
        Sun, 16 Mar 2025 11:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742149161; x=1742753961; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=97ERf3V/Bpk7MgoHGPJsnvkiQqZJeJp/kSKmJml6+us=;
        b=CeSYdcH0c2gZQm79AB0b2qb56u3FmBI4AXi0X9clHjHzH/4HHkVJ0xGV+1vUp1XZ9P
         j3OT/AICgizMpUxWucgqNjwtY7heFVgMxhaBoFX9ufprqDCcS0jdTF9XqhzpIWG4gpcR
         LZTu1Mi7yXAhQk70Hxj4PPAhPFiklKQaHO0HbzabNmdy1o+up5kS7Q8B9poOEPozUTr0
         p1Pg5zsIjCidq4bZjJUFvufPmQYTDS9RoBfEZpSkSMR9h2/gJlscg/8EfctWjA0xT/Y3
         X9tf74v5AtKlVGr5PaMHccLRmcBpHB4sUE4BSLuBSgE1+6jH0JsDripTt+/uLKPBhT09
         6WMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742149161; x=1742753961;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97ERf3V/Bpk7MgoHGPJsnvkiQqZJeJp/kSKmJml6+us=;
        b=E9IcBw1nU3s9UAEzQy2XrElvbNCSJWsMG0wpLLvMatwAZwsorWgUmgTH1Dww0wfLgQ
         rPOcfQCx7Aiqb/shSppQAD39timIwFAOYw/TZ6cncA7lxvpjk5AbIB8ktOFHMyo9BRLo
         oY5Hq2XLdHAgY49iEPvuzIcC+6EqJAbu0cNOM6SGEdccBhnA/vg9g/Qu9DwWOrDzmJMr
         s6+i4qf11OE7XoOC6uCd+Jwi6mCKJLeLCQtqTj0OvmdDLqwooMv50+fj/fzkM5U+KU/b
         K/fKskbGUeizQXu7Hr/vWdyoghdp9pU94088+3ve5qw3BAhQlCViaQlSjlhFItZWUz68
         7Hwg==
X-Forwarded-Encrypted: i=1; AJvYcCVP0etmFQanO1A+nF1ZSIDmzQe+TrkIP+oj8Rw3hjrRC5nAt4LuNu2bIViNA0N2XjVf+8wd6pGGHSZm@vger.kernel.org, AJvYcCWp+YdZ7DoOuoi0uvHOfa2gLHPdVJrF/4PSzD44STkw90PSoFhzmRundaNq+TzGNfNCQg2yUVtJxYCOi8jL@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj4oBw9RWA9czBPYsy2Y3bS3kNPO1IUg2+WxlhZ34LFjDtFq5/
	z9KPiFN2HKl2pfl/G0ay6UxTS5yHMGUr63gd2DzfU2xJTmXh3Lbf
X-Gm-Gg: ASbGnct1/VkVrk/SX/WdTANSQINiDLL1Pg6EUQleFzL9k2TCjvjKzFE117AlTs2doOr
	3/D9gK5oBUlL8fhXkbZFwo6vzMl2eRHFmyvPkRs4HOCaL4t6PjPivjgZTB7Dv7T/x7HCR1HmxBE
	/g+TX+BaUuc2BeOk3i8f58YxZLtUrtyeJ9EYJd67CUoalhDiKKjIUd0owK59GittBLgUf5h9Yab
	3EgGvgmD0dvVE675qW0BQ+4PcqOYnHtjYhSnHkEgVIom6no1t+/6H+uP1+RN2sSNPx3mjlzv5LK
	hee6ZtZYIKtd7BEoulH2ZwoFdHarWl4f3TotXOBgYxMzwVLKh3tfZ9omDVbY8BcSWcga5ckUyyO
	QfTTLckLdKHLIMpzLqYlf0uk2k2Bx
X-Google-Smtp-Source: AGHT+IG+83lChTiI1RBzCDIq8j9lOSoKKPoy8P0LCpgfYgJS30USvkARqAJeFOkKxSUjVu6YQZtMmg==
X-Received: by 2002:a17:906:c10d:b0:ac2:7cf9:7193 with SMTP id a640c23a62f3a-ac3304195a3mr1071132166b.48.1742149161249;
        Sun, 16 Mar 2025 11:19:21 -0700 (PDT)
Received: from hex.my.domain (83.11.178.210.ipv4.supernova.orange.pl. [83.11.178.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a48b51sm537951266b.149.2025.03.16.11.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 11:19:20 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Sun, 16 Mar 2025 19:18:51 +0100
Subject: [PATCH v7 03/10] ARM: dts: Drop DTS for BCM59056 PMU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250316-bcm59054-v7-3-4281126be1b8@gmail.com>
References: <20250316-bcm59054-v7-0-4281126be1b8@gmail.com>
In-Reply-To: <20250316-bcm59054-v7-0-4281126be1b8@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742149152; l=4265;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=oSsgHxWm93UX4Dr0gTfLMbljoK+SAeJiEhBDHrh1GCg=;
 b=uoPcsxaopSegQjH9DQN9ffpNUBszrF6XR3Yfteih7WnBU+g5Uxpu+0gJ8JZ1h9wWSkHq5IKf6
 sEzCZxVbjVVD8ZkiVSjgHenP5iu/z5HFP8/kOgswtj2KHgqNxsMLRgJ
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


