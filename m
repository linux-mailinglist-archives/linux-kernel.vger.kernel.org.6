Return-Path: <linux-kernel+bounces-185461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5B38CB533
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 23:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A955282815
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 21:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0830D14D717;
	Tue, 21 May 2024 21:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="dB5k1PWb"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DEB14BFA8
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 21:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716325872; cv=none; b=gN2sV8VePt7di4UP/lA3sCNoeGCtYH+kEX4Om5z4RtqDrF/w20I6OvqJneHk7qx/Ca79la4sOj1oT87LA0FEAbWwW8USOcP1UhjsnkXtSBdjw9mGXw7D8lreCtnx3aA5LV+U3Id4VrfMmTA0ePKdaDbKiCPzw0+VRx954gMPLHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716325872; c=relaxed/simple;
	bh=qQC3dm+HXs77tDlEOJ/esyMFwl8Q4vJ0HBIo9d2UWDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TjHBpw0xATljByvTrote7dk771SR1XiU6TTdLfukLRI5wvi+1vxJrqPWyzPpmZqv47mi/HxfYE6tzJdSyDADBJM5NrdZCWjr2XyGPYMsYb8EwbwFxN6WQXwQ1pd24FEne9SmIA1mi/5kBbGl9MuciIliu249FBWDv2ZJHuBLHRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=dB5k1PWb; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1716325866; bh=kTNtUvCVx2BdIKvV4sQmdXataht/4xiayUf/K28AyTQ=;
 b=dB5k1PWbfjrz9a7FZloO8mkx5076Tm+CvGIeClQ1x6RPupHHNPSSoIkLvjGllzY7lc+M2D+53
 KnNcjQeQJbIldjEJ2cQ4N4/tueYNTJgAUxK851H475cb0xwIgwzzT8+Pog69OVM5rKZjOWb1Day
 kn1KS8jAKYp35vTypM1cSbtfyhs8uXETpYPO49EmC7MzVng+LburP+NgQfOCBGVSm6+hIy/iN/L
 bjJBgvedvnavJuF1uEcJA4L+FYlyEdsGQkodPOvGRqL1TRyr1+TXGipS7MTMJ4Hx0gTRhEnZqb7
 h8Ji8wACzo2fE2yBdfhK7jrz7H0ss2SMLLhUfxtp9BYw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sjoerd Simons <sjoerd@collabora.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH 07/13] arm64: dts: rockchip: rk3308-rock-pi-s: Add mdio and ethernet-phy nodes
Date: Tue, 21 May 2024 21:10:10 +0000
Message-ID: <20240521211029.1236094-8-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240521211029.1236094-1-jonas@kwiboo.se>
References: <20240521211029.1236094-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 664d0de88b6b0c828344af14

Be explicit about the Ethernet port and define mdio and ethernet-phy
nodes in the device tree for ROCK Pi S.

Fixes: bc3753aed81f ("arm64: dts: rockchip: rock-pi-s add more peripherals")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 .../boot/dts/rockchip/rk3308-rock-pi-s.dts    | 26 ++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts b/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
index d4cf6026241c..f6fb90e13ad0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
@@ -144,11 +144,25 @@ &emmc {
 
 &gmac {
 	clock_in_out = "output";
+	phy-handle = <&rtl8201f>;
 	phy-supply = <&vcc_io>;
-	snps,reset-gpio = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
-	snps,reset-active-low;
-	snps,reset-delays-us = <0 50000 50000>;
 	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		rtl8201f: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&mac_rst>;
+			reset-assert-us = <20000>;
+			reset-deassert-us = <50000>;
+			reset-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
+		};
+	};
 };
 
 &gpio0 {
@@ -221,6 +235,12 @@ &pinctrl {
 	pinctrl-names = "default";
 	pinctrl-0 = <&rtc_32k>;
 
+	gmac {
+		mac_rst: mac-rst {
+			rockchip,pins = <0 RK_PA7 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	leds {
 		green_led: green-led {
 			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
-- 
2.43.2


