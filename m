Return-Path: <linux-kernel+bounces-310273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCB196774A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 17:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C36281C1D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 15:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFD4185B6E;
	Sun,  1 Sep 2024 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="w94XTqet"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1F9184530;
	Sun,  1 Sep 2024 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725206271; cv=none; b=s/DWv8mLqSyAhwTENizIID4HAlvrdmBS4vsFFWzfAgzx3PLuNiB7uc7oWv7fGc0Q1PYwILGpY+gp6UDonI/24DM/9J8SqlW5OK/gm33XUQGt7Dzy/XY3CqybBetJtFLuvbnoDKFdhEsmB5xCCvWor2860J7lc+hu5eNjnkSvRok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725206271; c=relaxed/simple;
	bh=02PCcln/Xuj5Uv1wiMhXHQh3YhVWQ0MBQuy4rkjwQpg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gYk0DQujfXFmjTpb1kvtPQgawnzBcia4NHNWYeghJKjeqXuKgss6aPEvVZXy09mgc5DKz5eaR0niAbkz9nn+WMiQlhkqXlAkXT+kvjVM5ku9XgBvpVY9TSvP6kTheUsrPtrjxO/qfqG10IIM/001SUS7YSKeN3Zn/KED8pEcbf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=w94XTqet; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 7E2C51FA62;
	Sun,  1 Sep 2024 17:57:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1725206258;
	bh=uqCIwId1TqaArpD+Ua/VfFXHA7izDHzS5SszDWKTAx0=; h=From:To:Subject;
	b=w94XTqetAK0JcK49Hm1OqBLcbrIsXQOw8ck+PQxXWFqEByQ0SUKa+R/hz6QEGZNSJ
	 NFnK0Rha4QUTP0NAdOgXeSK7VmXc4gGHsYONRqQGtJj5/8tYOA1C1ZEdyrDMDfnPrX
	 8l7cH4r/n3/JTJp/NaZ3aQI2axMgtmhGJz8PGDkI4uSqvHSOFcU/YN1jllx11IHm3l
	 ZFlSTkcDaOxxskZiCgHo77dZynz1pbG86gwVOgXf09/yVctQVcyV4670j2Zyd8weMM
	 XyQjXHAs/4OejBCWE+wM09M7k0ivfXfoF6VkWtCoiNgXUcSFHrum2oGo1tEqul6q6J
	 eDANk7nwtZ3cA==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/10] arm64: dts: colibri-imx8x: Add PMIC thermal zone
Date: Sun,  1 Sep 2024 17:57:16 +0200
Message-Id: <20240901155721.7912-6-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240901155721.7912-1-francesco@dolcini.it>
References: <20240901155721.7912-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add PMIC thermal zones.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: no changes
---
 .../boot/dts/freescale/imx8dx-colibri.dtsi    | 11 ++++++
 .../boot/dts/freescale/imx8x-colibri.dtsi     | 34 +++++++++++++++++--
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8dx-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8dx-colibri.dtsi
index 66b0fcc6687d..4d1ad052c5b6 100644
--- a/arch/arm64/boot/dts/freescale/imx8dx-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dx-colibri.dtsi
@@ -9,3 +9,14 @@
 / {
 	model = "Toradex Colibri iMX8DX Module";
 };
+
+&thermal_zones {
+	pmic-thermal {
+		cooling-maps {
+			map0 {
+				cooling-device = <&A35_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						 <&A35_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index 60cf4e400052..bc1577b5f1ea 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
@@ -88,8 +88,6 @@ &adc0 {
 	vref-supply = <&reg_module_vref_1v8>;
 };
 
-/* TODO Cooling maps for DX */
-
 &cpu_alert0 {
 	hysteresis = <2000>;
 	temperature = <90000>;
@@ -420,6 +418,38 @@ &sai0 {
 	status = "okay";
 };
 
+&thermal_zones {
+	pmic-thermal {
+		polling-delay-passive = <250>;
+		polling-delay = <2000>;
+		thermal-sensors = <&tsens IMX_SC_R_PMIC_0>;
+
+		trips {
+			pmic_alert0: trip0 {
+				temperature = <110000>;
+				hysteresis = <2000>;
+				type = "passive";
+			};
+
+			pmic_crit0: trip1 {
+				temperature = <125000>;
+				hysteresis = <2000>;
+				type = "critical";
+			};
+		};
+
+		cooling-maps {
+			pmic_cooling_map0: map0 {
+				trip = <&pmic_alert0>;
+				cooling-device = <&A35_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						 <&A35_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						 <&A35_2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						 <&A35_3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+			};
+		};
+	};
+};
+
 &usbotg1 {
 	adp-disable;
 	disable-over-current;
-- 
2.39.2


