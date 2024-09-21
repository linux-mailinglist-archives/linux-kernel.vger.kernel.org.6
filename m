Return-Path: <linux-kernel+bounces-334923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CBF97DE5C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 20:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CCEC2817A8
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 18:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A29C44C6F;
	Sat, 21 Sep 2024 18:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flokli.de header.i=@flokli.de header.b="H842euL1"
Received: from mail.flokli.de (mail.flokli.de [116.203.226.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3548320E;
	Sat, 21 Sep 2024 18:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.226.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726944327; cv=none; b=cA1g5GBITLWSL3ZOYrUUue1YR8iygiBrFLDV8CYP5FWHtLIrBYKRPDzngV3LK15fTsSe68IXRk74ZfwCKbp1Dyi4DLQ3O/FxVZvAgs5Vq6MDj63UIefrgJ9nZQbNYsyDQZd4jOqcb1SmMOMKr53hieYmB8H54sDvcqDyLMcN0Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726944327; c=relaxed/simple;
	bh=6hQQPrPgMjqVKwcLlVZjQ9AJ7sSgiCwigaAx46FEvpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FyynsKyJ5jcUPAxAZt5bvWvKsjFiqW8CZ5FoR6qtJQlXFQCWctLN9jp8Z7qVu0jeJaFp3DPRpjD2OIN2nmZIs4niuaPsgsZZW1AevlHgl5qI7GCi93Yz8aOfHjs7TgVADSm2aTy0QDQ8pIwBisgYhAJmRti1ojqIpLajCR7oY3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flokli.de; spf=pass smtp.mailfrom=flokli.de; dkim=pass (1024-bit key) header.d=flokli.de header.i=@flokli.de header.b=H842euL1; arc=none smtp.client-ip=116.203.226.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flokli.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flokli.de
From: Florian Klink <flokli@flokli.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flokli.de; s=mail;
	t=1726943902; bh=LdeSOtI+tbdp74aNkMRYpdTnLpUe4xv3Q3ma2Gb4eRQ=;
	h=From:To:Cc:Subject:Date;
	b=H842euL1DdokvOuLO/5C5y2aSaeYMuftNGmY8G8siXBGrk7MMAWECUvby8Sh1voE+
	 8F3yKiIvLWcYbKrGtjTeEDSxrOSwCjlqmu8n6I4/vKDwzSLYEOPVQxCOBVsCrdrYot
	 ISZdV1RZ/6LmzWVcI9mKJYUv6G6ByeZtAvw2kaks=
To: 
Cc: Florian Klink <flokli@flokli.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Kever Yang <kever.yang@rock-chips.com>,
	=?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <tszucs@protonmail.ch>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Muhammed Efe Cetin <efectn@protonmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: enable automatic fan control on Orange Pi 5+
Date: Sat, 21 Sep 2024 21:38:00 +0300
Message-ID: <20240921183810.225322-1-flokli@flokli.de>
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
index e74871491ef5..8569e862b6ee 100644
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
+		map1 {
+			trip = <&package_fan0>;
+			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
+		};
+
+		map2 {
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


