Return-Path: <linux-kernel+bounces-335164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3852397E21C
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 16:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69DDF1C20DB3
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 14:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B115D515;
	Sun, 22 Sep 2024 14:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flokli.de header.i=@flokli.de header.b="GUA8Ibtq"
Received: from mail.flokli.de (mail.flokli.de [116.203.226.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC85BA27;
	Sun, 22 Sep 2024 14:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.226.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727017171; cv=none; b=nfJ+o7fArdBRqZEVqyMR8TF9mueKZ2AmvXStUE7KvJ/6I1a1+eCH6qO4qx8+8J+px0E2c/xsW4Fyl/Zcv2iQSfOa/JpWjgkFTPPsxtt1T3iehzn5Da+42zg3jF6fIeKb6t51MFiu/e06AHeta/LuhiizVeih03TMTFM48FBujN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727017171; c=relaxed/simple;
	bh=AgOP0Ok4FSxiKdpNFexjZ88fW1kw6PEgKOe6RQbWgMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j6CDAm7kffFqjVD8wU2e62hq8Bw3RFCEXwvC1wtHRO7HY8T7xlBFnC9Zimo74ATLe/Iw+FYQNmfe1yjplwhakBkx6PeOSsi7enA8j1oRUnfCXqot1hcNBqiQeZ0WkFJz1fSCjRqYIMp85Y83mYkoEc7vm3HR9bkqr6UT2sEbAqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flokli.de; spf=pass smtp.mailfrom=flokli.de; dkim=pass (1024-bit key) header.d=flokli.de header.i=@flokli.de header.b=GUA8Ibtq; arc=none smtp.client-ip=116.203.226.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flokli.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flokli.de
From: Florian Klink <flokli@flokli.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flokli.de; s=mail;
	t=1727017164; bh=wzNkufJNs8JPj15IvW3yIEGMtLG/2YOpr4iUk3QGOrA=;
	h=From:To:Cc:Subject:Date;
	b=GUA8IbtqGOgl4JXHafk152p32hTzOHE4TkzL7n35QqLyoHdhIQRC7/TMiD/+p0gQZ
	 Oi9drzI9lZz2CFkck6JCxJdfgvpLhtFSGDi2S9iFMiuiyXR8bwP87sEk0v5VjFWN4k
	 PPFFGXKKECoBGyECWReZiWaW0roT/RQo6gbgRous=
To: 
Cc: Florian Klink <flokli@flokli.de>,
	Dragan Simic <dsimic@manjaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Ondrej Jirman <megi@xff.cz>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: rockchip: enable automatic fan control on Orange Pi 5+
Date: Sun, 22 Sep 2024 17:55:29 +0300
Message-ID: <20240922145538.256235-2-flokli@flokli.de>
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
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
   Changes in v2:
    - Updated map{1,2} to map{0,1} for the same reasons as [1]

   Link to v1: https://lore.kernel.org/linux-rockchip/20240921183810.225322-1-flokli@flokli.de/T/#u

[1] https://lore.kernel.org/linux-rockchip/335ecd5841ab55f333e17bb391d0e1264fac257b.1726954592.git.dsimic@manjaro.org/T/#u
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


