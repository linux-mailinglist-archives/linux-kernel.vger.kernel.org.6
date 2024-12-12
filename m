Return-Path: <linux-kernel+bounces-443126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BC19EE7B9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2F861888630
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4F92153D1;
	Thu, 12 Dec 2024 13:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAedUtuX"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906B3214A86;
	Thu, 12 Dec 2024 13:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734010480; cv=none; b=pdfONbSDCf0QSCkTZShhDWiIWx4Nfme6QauLrdga6zR47kssIXb2jQYI3dEIVVIzctBoecIadef29SZ+HF74xs2huTUrxD4XrdDF+UPMty8ep/VUKRRpgOod37MNxFexz66JrJMrJGASloO6UciWoGwTz1UK0iqa9wS9CAy1fZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734010480; c=relaxed/simple;
	bh=WxqOpf+rd85nFwIAEG0Gb8p+PaeoQfSTyZF3aEh5UsU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u+UzRo7ceApuhxo6Jf0DCZqMFHE9/RRgCnqy4ZKWeDXnMTeD0+hrqo0CZbpKOFccgEGwPsbhfy+WIqSkGDM4DEA83of8stwhCJZW4ymjYh/QduW3roCxylTyKk5EbQ3mXsMIOOrQK42PcNZzW0OvKYq1cHYhMTqVzyaluKMF6Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aAedUtuX; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2166022c5caso5155855ad.2;
        Thu, 12 Dec 2024 05:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734010478; x=1734615278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GeCo6voBzfvsd9B5AKf1XLFT78VWFwo447c6e8aMI7g=;
        b=aAedUtuX0fCLVAbh3J3snRLyTWXSaXD2VWqh4JrjWoiG1cNZbst0oTZVM1p0lrqz/0
         T0fEhCKyBwINP6GG76+cxX0xwtPziuPQZRM0T9wY0gRbCM2M3+nS7zfJjQIBbwOH74GD
         87DV/zlq2iSYsN2MQm3mAAimHufYaDlIKPypjzYAIGiu32EaC/Td8Q7TAAI/F27VsOiS
         aRS9s1MoLUSGeTq3iVjxDKYh7p5/7mvBMnZwYTzCQFgcxz8ItizbbfeKn1P9cUMlU0GF
         eEJleyXJBIpX6NNqHSl8/qQ/xUppVLSF07/o7AoqRcesBRcTAXn97I7jmA4R1sl5oXKg
         6YBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734010478; x=1734615278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GeCo6voBzfvsd9B5AKf1XLFT78VWFwo447c6e8aMI7g=;
        b=r++GWTP0YSuTkY3zBw0WC/QqyCInXX6zztJm5kEaup/Mcf5H/1igt1yqg4beGnxZcx
         8WeexdoBlGTbtHTJnTHJ8ZYWZonDiBDKO/jszeHp8bcn1bhXnn0OdiImgjt0bY9EO32J
         XCBPKb6ucVbWWGX5IkdF/8zTXhh62GnPzBEDsIisEFs8eWJ0R3kedvaBKPohETXeZ+hp
         j6/RKDFYl4b5Gw5Vp0hrcciV/Ldx3PUEAhpfWDC0cAHaKf4KtCqKMiZAlviPUrI4P2rs
         wNJpgxEpys2XBAJ7uJsR3gbNHeKFlvCa+wXc5nffWKAIu70KFGPRNybKIFDRy9xAyH2O
         K1XQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWFZ4akpNLWd55tRP5xc09nC5eezJL0dhqTE/UuMT/Y6ruVs4pEXpbp5d1EFxGG4iM8neHJ3UHlmIb@vger.kernel.org, AJvYcCWtntVckqt5/vLDujVqeS5Pa7rRuJm5ctj3hpK9IVYrqmIdDqSozozsWtVH9kxqQ3dhf+nUnJ3wc/qQx5S7@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3ATDeL1c/z1CO8RwHwbWcDmXK5MeP0e09bSH/09ln5jm8Nlpn
	AC6kL2zrNFLNRgaDmRmziRv6WHypYEJB4J0KeFmkG04LcVyOVyLG
X-Gm-Gg: ASbGncsO3HJzA4tYUe8Tsqhtzvnr/3IT+ZKeD6I9gjkbbUQa5Xs9bgXS2qCvSMSS0Cl
	AfDYesRuxta17Fv7IVfiQ/5w9KOvyPlWak50YJ0zWfvedhKxom4Pc74qaJW+Su1kWYqTMq8YJw2
	OUaiG8dOzaeWMi6bgF30DjbaBvRnoAwuVbiBQGE3zSLZkTNbd78HYR/CoIFJks27pEde7Q3jSr/
	VUmREme9EP22QsPXSa79WuhMiRyuUi8cJ1tZXtrzbDcj/JoJLGyK7akVligqHWDq2c1e8QGi+DA
	ONYAxiuKPxIJMPM7y9jIE50wgQ6BdgMnqssz5sAudiA6KDBtBGjGvelHprywoxWSYQk+O/vzVQc
	oKtHW
X-Google-Smtp-Source: AGHT+IEz+JRhCfmuLuRPQjfAY6LvHPw+8lus0bkpzmOra75yYYsCHcZ2q2Oh1JNu4NCSZCdVZ0hghg==
X-Received: by 2002:a17:902:c947:b0:215:b75f:a1cb with SMTP id d9443c01a7336-2178ae4d3c3mr55231155ad.9.1734010476166;
        Thu, 12 Dec 2024 05:34:36 -0800 (PST)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2163562a838sm83390165ad.29.2024.12.12.05.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 05:34:35 -0800 (PST)
From: Yang Chen <yangchen.openbmc@gmail.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	patrick@stwcx.xyz,
	amithash@meta.com
Cc: Jerry.Lin@quantatw.com,
	yang.chen@quantatw.com
Subject: [PATCH v1 2/4] ARM: dts: aspeed: minerva: add i/o expanders on each FCB
Date: Thu, 12 Dec 2024 21:32:24 +0800
Message-Id: <20241212133226.342937-3-yangchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241212133226.342937-1-yangchen.openbmc@gmail.com>
References: <20241212133226.342937-1-yangchen.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add four I/O expanders on each i2c of fan control board (FCB), assign the
GPIO line name to each GPIO in use, and specify the interrupt GPIO number
for each FCB's i/o expander.

Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
---
 .../aspeed/aspeed-bmc-facebook-minerva.dts    | 456 ++++++++++++++++++
 1 file changed, 456 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index 426e249c3326..9cd225ae96cb 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -342,6 +342,82 @@ temperature-sensor@4b {
 				compatible = "ti,tmp75";
 				reg = <0x4b>;
 			};
+
+			gpio@11 {
+				compatible = "nxp,pca9555";
+				reg = <0x11>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <218 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"P48V_FAN1_PWRGD_R", "P48V_FAN2_PWRGD_R",
+				"P48V_FAN3_PWRGD_R", "P48V_FAN4_PWRGD_R",
+				"FCB_1_P48V_ZONE0_PWRGD_R", "FCB_1_P48V_ZONE1_PWRGD_R",
+				"FCB_1_PWRGD_P3V3_R", "",
+				"", "",
+				"", "",
+				"", "",
+				"", "";
+			};
+
+			gpio@12 {
+				compatible = "nxp,pca9555";
+				reg = <0x12>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <218 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"INA238_FAN1_ALERT_N", "INA238_FAN2_ALERT_N",
+				"INA238_FAN3_ALERT_N", "INA238_FAN4_ALERT_N",
+				"FCB_1_TMP75_ALERT_N", "",
+				"", "",
+				"FAN1_PRSNT", "FAN2_PRSNT",
+				"FAN3_PRSNT", "FAN4_PRSNT",
+				"", "",
+				"", "";
+			};
+
+			gpio@13 {
+				compatible = "nxp,pca9555";
+				reg = <0x13>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <218 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"FAN1_IL_TACH_ALERT", "FAN1_OL_TACH_ALERT",
+				"FAN2_IL_TACH_ALERT", "FAN2_OL_TACH_ALERT",
+				"FAN3_IL_TACH_ALERT", "FAN3_OL_TACH_ALERT",
+				"FAN4_IL_TACH_ALERT", "FAN4_IL_TACH_ALERT",
+				"", "",
+				"", "",
+				"", "",
+				"", "";
+			};
+
+			gpio@17 {
+				compatible = "nxp,pca9555";
+				reg = <0x17>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <218 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"FCB_1_P1V0_POWER_FAIL", "FCB_1_P1V8_POWER_FAIL",
+				"FCB_1_P48V_ZONE0_POWER_FAIL", "FAN1_POWER_FAIL",
+				"FAN2_POWER_FAIL", "FAN3_POWER_FAIL",
+				"FAN4_POWER_FAIL", "",
+				"", "",
+				"", "",
+				"", "",
+				"", "";
+			};
 		};
 		// FCB 2
 		imux17: i2c@0 {
@@ -389,6 +465,82 @@ temperature-sensor@4b {
 				compatible = "ti,tmp75";
 				reg = <0x4b>;
 			};
+
+			gpio@11 {
+				compatible = "nxp,pca9555";
+				reg = <0x11>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <220 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"P48V_FAN5_PWRGD_R", "P48V_FAN6_PWRGD_R",
+				"P48V_FAN7_PWRGD_R", "P48V_FAN8_PWRGD_R",
+				"FCB_2_P48V_ZONE0_PWRGD_R", "FCB_2_P48V_ZONE1_PWRGD_R",
+				"FCB_2_PWRGD_P3V3_R", "",
+				"", "",
+				"", "",
+				"", "",
+				"", "";
+			};
+
+			gpio@12 {
+				compatible = "nxp,pca9555";
+				reg = <0x12>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <220 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"INA238_FAN5_ALERT_N", "INA238_FAN6_ALERT_N",
+				"INA238_FAN7_ALERT_N", "INA238_FAN8_ALERT_N",
+				"FCB_2_TMP75_ALERT_N", "",
+				"", "",
+				"FAN5_PRSNT", "FAN6_PRSNT",
+				"FAN7_PRSNT", "FAN8_PRSNT",
+				"", "",
+				"", "";
+			};
+
+			gpio@13 {
+				compatible = "nxp,pca9555";
+				reg = <0x13>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <220 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"FAN5_IL_TACH_ALERT", "FAN5_OL_TACH_ALERT",
+				"FAN6_IL_TACH_ALERT", "FAN6_OL_TACH_ALERT",
+				"FAN7_IL_TACH_ALERT", "FAN7_OL_TACH_ALERT",
+				"FAN8_IL_TACH_ALERT", "FAN8_IL_TACH_ALERT",
+				"", "",
+				"", "",
+				"", "",
+				"", "";
+			};
+
+			gpio@17 {
+				compatible = "nxp,pca9555";
+				reg = <0x17>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <220 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"FCB_2_P1V0_POWER_FAIL", "FCB_2_P1V8_POWER_FAIL",
+				"FCB_2_P48V_ZONE0_POWER_FAIL", "FAN5_POWER_FAIL",
+				"FAN6_POWER_FAIL", "FAN7_POWER_FAIL",
+				"FAN8_POWER_FAIL", "",
+				"", "",
+				"", "",
+				"", "",
+				"", "";
+			};
 		};
 		// FCB 3
 		imux18: i2c@3 {
@@ -436,6 +588,82 @@ temperature-sensor@4b {
 				compatible = "ti,tmp75";
 				reg = <0x4b>;
 			};
+
+			gpio@11 {
+				compatible = "nxp,pca9555";
+				reg = <0x11>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <230 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"P48V_FAN9_PWRGD_R", "P48V_FAN10_PWRGD_R",
+				"P48V_FAN11_PWRGD_R", "P48V_FAN12_PWRGD_R",
+				"FCB_3_P48V_ZONE0_PWRGD_R", "FCB_3_P48V_ZONE1_PWRGD_R",
+				"FCB_3_PWRGD_P3V3_R", "",
+				"", "",
+				"", "",
+				"", "",
+				"", "";
+			};
+
+			gpio@12 {
+				compatible = "nxp,pca9555";
+				reg = <0x12>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <230 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"INA238_FAN9_ALERT_N", "INA238_FAN10_ALERT_N",
+				"INA238_FAN11_ALERT_N", "INA238_FAN12_ALERT_N",
+				"FCB_3_TMP75_ALERT_N", "",
+				"", "",
+				"FAN9_PRSNT", "FAN10_PRSNT",
+				"FAN11_PRSNT", "FAN12_PRSNT",
+				"", "",
+				"", "";
+			};
+
+			gpio@13 {
+				compatible = "nxp,pca9555";
+				reg = <0x13>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <230 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"FAN9_IL_TACH_ALERT", "FAN9_OL_TACH_ALERT",
+				"FAN10_IL_TACH_ALERT", "FAN10_OL_TACH_ALERT",
+				"FAN11_IL_TACH_ALERT", "FAN11_OL_TACH_ALERT",
+				"FAN12_IL_TACH_ALERT", "FAN12_IL_TACH_ALERT",
+				"", "",
+				"", "",
+				"", "",
+				"", "";
+			};
+
+			gpio@17 {
+				compatible = "nxp,pca9555";
+				reg = <0x17>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <230 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"FCB_3_P1V0_POWER_FAIL", "FCB_3_P1V8_POWER_FAIL",
+				"FCB_3_P48V_ZONE0_POWER_FAIL", "FAN9_POWER_FAIL",
+				"FAN10_POWER_FAIL", "FAN11_POWER_FAIL",
+				"FAN12_POWER_FAIL", "",
+				"", "",
+				"", "",
+				"", "",
+				"", "";
+			};
 		};
 		// FCB 4
 		imux19: i2c@2 {
@@ -483,6 +711,82 @@ temperature-sensor@4b {
 				compatible = "ti,tmp75";
 				reg = <0x4b>;
 			};
+
+			gpio@11 {
+				compatible = "nxp,pca9555";
+				reg = <0x11>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <232 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"P48V_FAN13_PWRGD_R", "P48V_FAN14_PWRGD_R",
+				"P48V_FAN15_PWRGD_R", "P48V_FAN16_PWRGD_R",
+				"FCB_4_P48V_ZONE0_PWRGD_R", "FCB_4_P48V_ZONE1_PWRGD_R",
+				"FCB_4_PWRGD_P3V3_R", "",
+				"", "",
+				"", "",
+				"", "",
+				"", "";
+			};
+
+			gpio@12 {
+				compatible = "nxp,pca9555";
+				reg = <0x12>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <232 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"INA238_FAN13_ALERT_N", "INA238_FAN14_ALERT_N",
+				"INA238_FAN15_ALERT_N", "INA238_FAN16_ALERT_N",
+				"FCB_4_TMP75_ALERT_N", "",
+				"", "",
+				"FAN13_PRSNT", "FAN14_PRSNT",
+				"FAN15_PRSNT", "FAN16_PRSNT",
+				"", "",
+				"", "";
+			};
+
+			gpio@13 {
+				compatible = "nxp,pca9555";
+				reg = <0x13>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <232 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"FAN13_IL_TACH_ALERT", "FAN13_OL_TACH_ALERT",
+				"FAN14_IL_TACH_ALERT", "FAN14_OL_TACH_ALERT",
+				"FAN15_IL_TACH_ALERT", "FAN15_OL_TACH_ALERT",
+				"FAN16_IL_TACH_ALERT", "FAN16_IL_TACH_ALERT",
+				"", "",
+				"", "",
+				"", "",
+				"", "";
+			};
+
+			gpio@17 {
+				compatible = "nxp,pca9555";
+				reg = <0x17>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <232 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"FCB_4_P1V0_POWER_FAIL", "FCB_4_P1V8_POWER_FAIL",
+				"FCB_4_P48V_ZONE0_POWER_FAIL", "FAN13_POWER_FAIL",
+				"FAN14_POWER_FAIL", "FAN15_POWER_FAIL",
+				"FAN16_POWER_FAIL", "",
+				"", "",
+				"", "",
+				"", "",
+				"", "";
+			};
 		};
 		// FCB 5
 		imux20: i2c@4 {
@@ -529,6 +833,82 @@ temperature-sensor@4b {
 				compatible = "ti,tmp75";
 				reg = <0x4b>;
 			};
+
+			gpio@11 {
+				compatible = "nxp,pca9555";
+				reg = <0x11>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <254 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"P48V_FAN20_PWRGD_R", "P48V_FAN19_PWRGD_R",
+				"P48V_FAN18_PWRGD_R", "P48V_FAN17_PWRGD_R",
+				"FCB_5_P48V_ZONE0_PWRGD_R", "FCB_5_P48V_ZONE1_PWRGD_R",
+				"FCB_5_PWRGD_P3V3_R", "",
+				"", "",
+				"", "",
+				"", "",
+				"", "";
+			};
+
+			gpio@12 {
+				compatible = "nxp,pca9555";
+				reg = <0x12>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <254 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"INA238_FAN20_ALERT_N", "INA238_FAN19_ALERT_N",
+				"INA238_FAN18_ALERT_N", "INA238_FAN17_ALERT_N",
+				"FCB_5_TMP75_ALERT_N", "",
+				"", "",
+				"FAN20_PRSNT", "FAN19_PRSNT",
+				"FAN18_PRSNT", "FAN17_PRSNT",
+				"", "",
+				"", "";
+			};
+
+			gpio@13 {
+				compatible = "nxp,pca9555";
+				reg = <0x13>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <254 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"FAN20_IL_TACH_ALERT", "FAN20_OL_TACH_ALERT",
+				"FAN19_IL_TACH_ALERT", "FAN19_OL_TACH_ALERT",
+				"FAN18_IL_TACH_ALERT", "FAN18_OL_TACH_ALERT",
+				"FAN17_IL_TACH_ALERT", "FAN17_OL_TACH_ALERT",
+				"", "",
+				"", "",
+				"", "",
+				"", "";
+			};
+
+			gpio@17 {
+				compatible = "nxp,pca9555";
+				reg = <0x17>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <254 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"FCB_5_P1V0_POWER_FAIL", "FCB_5_P1V8_POWER_FAIL",
+				"FCB_5_P48V_ZONE0_POWER_FAIL", "FAN20_POWER_FAIL",
+				"FAN19_POWER_FAIL", "FAN18_POWER_FAIL",
+				"FAN17_POWER_FAIL", "",
+				"", "",
+				"", "",
+				"", "",
+				"", "";
+			};
 		};
 		// FCB 6
 		imux21: i2c@5 {
@@ -575,6 +955,82 @@ temperature-sensor@4b {
 				compatible = "ti,tmp75";
 				reg = <0x4b>;
 			};
+
+			gpio@11 {
+				compatible = "nxp,pca9555";
+				reg = <0x11>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <252 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"P48V_FAN24_PWRGD_R", "P48V_FAN23_PWRGD_R",
+				"P48V_FAN22_PWRGD_R", "P48V_FAN21_PWRGD_R",
+				"FCB_6_P48V_ZONE0_PWRGD_R", "FCB_6_P48V_ZONE1_PWRGD_R",
+				"FCB_6_PWRGD_P3V3_R", "",
+				"", "",
+				"", "",
+				"", "",
+				"", "";
+			};
+
+			gpio@12 {
+				compatible = "nxp,pca9555";
+				reg = <0x12>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <252 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"INA238_FAN24_ALERT_N", "INA238_FAN23_ALERT_N",
+				"INA238_FAN22_ALERT_N", "INA238_FAN21_ALERT_N",
+				"FCB_6_TMP75_ALERT_N", "",
+				"", "",
+				"FAN24_PRSNT", "FAN23_PRSNT",
+				"FAN22_PRSNT", "FAN21_PRSNT",
+				"", "",
+				"", "";
+			};
+
+			gpio@13 {
+				compatible = "nxp,pca9555";
+				reg = <0x13>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <252 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"FAN24_IL_TACH_ALERT", "FAN24_OL_TACH_ALERT",
+				"FAN23_IL_TACH_ALERT", "FAN23_OL_TACH_ALERT",
+				"FAN22_IL_TACH_ALERT", "FAN22_OL_TACH_ALERT",
+				"FAN21_IL_TACH_ALERT", "FAN21_OL_TACH_ALERT",
+				"", "",
+				"", "",
+				"", "",
+				"", "";
+			};
+
+			gpio@17 {
+				compatible = "nxp,pca9555";
+				reg = <0x17>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <252 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-line-names =
+				"FCB_6_P1V0_POWER_FAIL", "FCB_6_P1V8_POWER_FAIL",
+				"FCB_6_P48V_ZONE0_POWER_FAIL", "FAN24_POWER_FAIL",
+				"FAN23_POWER_FAIL", "FAN22_POWER_FAIL",
+				"FAN21_POWER_FAIL", "",
+				"", "",
+				"", "",
+				"", "",
+				"", "";
+			};
 		};
 
 		imux22: i2c@6 {
-- 
2.34.1


