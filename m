Return-Path: <linux-kernel+bounces-335105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED9B97E116
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 13:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E23FE281385
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 11:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFFD193065;
	Sun, 22 Sep 2024 11:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flokli.de header.i=@flokli.de header.b="UtGneW1D"
Received: from mail.flokli.de (mail.flokli.de [116.203.226.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274F63B7AC;
	Sun, 22 Sep 2024 11:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.226.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727004088; cv=none; b=ZiPakmtw7m6d53VGrShXMK7GXveGh8rBcmcYzAWDoJF67bMRiLSq767JUY2wcNLnFa4QpJ0k+Cp2Z4uiNIHmkawhdBdV+LE+M1MzaU2hH8wOzgBHMHTrKVCN4wTLkHPybqBTDGuOhbmS5itspflckaLL5MrhN0vpmX+YjWDKHu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727004088; c=relaxed/simple;
	bh=9gW+dAUsSzMNbOy50TO99NdJ8ORNAysNtlIeDT5JpZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qh2Ar6KRT6OqMGCPenkCGDtlY3lybMq2Ptbt/BcZ3PzEQyNeHPJfla3oQvWTSc8uM9RM9daVaxPwUPmYDVJq5zoyHIT2gkyVB7PHzvlTtKknLtAhJ6Vev0BifwkKcZDMX9CBc2szJ+9mVRu4ZkQ1LWmtNrVbnGqbQnSEtptRQQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flokli.de; spf=pass smtp.mailfrom=flokli.de; dkim=pass (1024-bit key) header.d=flokli.de header.i=@flokli.de header.b=UtGneW1D; arc=none smtp.client-ip=116.203.226.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flokli.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flokli.de
From: Florian Klink <flokli@flokli.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flokli.de; s=mail;
	t=1727004081; bh=GuRo2k0T9oiOFVzmZlE5UWzPH3hTNSPfo+s1LYF8J38=;
	h=From:To:Cc:Subject:Date;
	b=UtGneW1D2ul2axDXdozrtFWvUGfQCDuiXu1h0PdFHUc+XZx/AfVMrfD9roNuP2JbQ
	 sxWuFSYDM4Ars5fUvHd8D1no56FoFYcYYtQ+nnmMc9wX0EJDvSafukxTx5hU4R9ZkY
	 dDJV1nNBAN662PTZDcXRI+oD1/B+OaUuiDogFDjQ=
To: 
Cc: Florian Klink <flokli@flokli.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Dragan Simic <dsimic@manjaro.org>,
	=?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <tszucs@protonmail.ch>,
	Ondrej Jirman <megi@xff.cz>,
	Muhammed Efe Cetin <efectn@protonmail.com>,
	FUKAUMI Naoki <naoki@radxa.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: enable automatic fan control on Orange Pi 5+
Date: Sun, 22 Sep 2024 14:21:03 +0300
Message-ID: <20240922112113.251431-1-flokli@flokli.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This links the PWM fan on Orange Pi 5+ as an active cooling device
managed automatically by the thermal subsystem, with a target SoC
temperature of 65C and a minimum-spin interval from 55C to 65C to
ensure airflow when the system gets warm.

This is pretty much the same as '4a152231b050 ("arm64: dts: rockchip:
enable automatic fan control on Rock 5B")', except for the Orange Pi
5+ board.

Signed-off-by: Florian Klink <flokli@flokli.de>
---
 .../dts/rockchip/rk3588-orangepi-5-plus.dts   | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
index e74871491ef5..d91438752006 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
@@ -351,6 +351,36 @@ &i2s2m0_sdi
 	status = "okay";
 };
 
+&package_thermal {
+	polling-delay = <1000>;
+
+	trips {
+		package_fan0: package-fan0 {
+			temperature = <55000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+
+		package_fan1: package-fan1 {
+			temperature = <65000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map0 {
+			trip = <&package_fan0>;
+			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
+		};
+
+		map1 {
+			trip = <&package_fan1>;
+			cooling-device = <&fan 2 THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
 /* phy1 - M.KEY socket */
 &pcie2x1l0 {
 	reset-gpios = <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
-- 
2.46.0


