Return-Path: <linux-kernel+bounces-415027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB3A9D30D4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 00:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C396EB21259
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 23:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AE81D358B;
	Tue, 19 Nov 2024 23:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="N2psSRQm"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC8C1C1F0B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 23:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732057753; cv=none; b=Rn45NAkJwjpBXM0CKiouX90hPDhDh3Reh8k4Bc9X9xJzujQKeB4FM05P8D7ROC7vQXlzvWEF4kr8BzEG7oc8DgZJcygYHnT+m9uuZcHunMyMqgUbc84w2RnYEt6o6hFeTFkVTvU9TCKaVYUZEwwkiHgfUAC36iipACL2ue4H65o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732057753; c=relaxed/simple;
	bh=G9NOBYO4nxWvEsIBhMRGiQBwufvotZ4seMXBjY7SkA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=khvRW/eoCgk3giKewjwZFn6p3/Gemh52PYNn5VrAmpU5wzhn0UX9Wz9nVU0XrE/pON+IdKLkzqYlBc3rl7BpwerK/5VfZj32JHZHTOdMBjY3erMQ+BTCGqjNaCLeAiqbtBjJA7RGilFtYUfZnEJrEp1sHQCLgMPGrtRvVLrRU0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=N2psSRQm; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1732057730;
 bh=3YnguvlMq3yVXKBatvax4toDXEpAfggthYQx8MYd0TA=;
 b=N2psSRQmGtYBy2RiSo7IGz3YFIFGkqt/yeyHRX0+8OQHO+m7Pygf7TqAco38Xw3DAqBuHTY8t
 NykojJBzYuzQALGDnPlubxY4KMAFRoDwS7S5xY2Pa6Om4OTc8Qr44fFHaKrR9pAYGFO+nMZ3aX7
 ghlumzh6iBoltNedIuBFJ682XgZd2LDaHpTY06Db0NSR9V+eNIY+bG8DcbTqD/CeHbLE/1eoQUi
 M6pcA7Zmlupm2p4vM3RCvAcf7vUqCCBcZ2rH6bt9M1oo9VXKdlA7d2muPJXeOLVDnoAq6gidlBx
 gQMyIQ5Tp6F6HJ+X6/CnbztViao1hZhjZ/zE6ezFVfew==
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: rk3308-rock-s0: Fix sdmmc access on v1.1 boards
Date: Tue, 19 Nov 2024 23:08:36 +0000
Message-ID: <20241119230838.4137130-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.47.0
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
X-ForwardEmail-ID: 673d1a7f0a51d1c96019a6b0

BootROM leave GPIO4_D6 configured as SDMMC_PWREN function and DW MCI
driver set PRWEN high on MMC_POWER_UP and low on MMC_POWER_OFF.
Similarly U-Boot also set PRWEN high before accessing mmc.

However, HW revision prior to v1.2 must pull GPIO4_D6 low to access
sdmmc. For HW revision v1.2 the state of GPIO4_D6 has no impact.

Model an always-on active low fixed regulator using GPIO4_D6 to fix
use of sdmmc on older HW revisions of the board.

Fixes: adeb5d2a4ba4 ("arm64: dts: rockchip: Add Radxa ROCK S0")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 .../boot/dts/rockchip/rk3308-rock-s0.dts      | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308-rock-s0.dts b/arch/arm64/boot/dts/rockchip/rk3308-rock-s0.dts
index bd6419a5c20a..8311af4c8689 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308-rock-s0.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3308-rock-s0.dts
@@ -74,6 +74,23 @@ vcc_io: regulator-3v3-vcc-io {
 		vin-supply = <&vcc5v0_sys>;
 	};
 
+	/*
+	 * HW revision prior to v1.2 must pull GPIO4_D6 low to access sdmmc.
+	 * This is modeled as an always-on active low fixed regulator.
+	 */
+	vcc_sd: regulator-3v3-vcc-sd {
+		compatible = "regulator-fixed";
+		gpios = <&gpio4 RK_PD6 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdmmc_2030>;
+		regulator-name = "vcc_sd";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_io>;
+	};
+
 	vcc5v0_sys: regulator-5v0-vcc-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
@@ -181,6 +198,12 @@ pwr_led: pwr-led {
 		};
 	};
 
+	sdmmc {
+		sdmmc_2030: sdmmc-2030 {
+			rockchip,pins = <4 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	wifi {
 		wifi_reg_on: wifi-reg-on {
 			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
@@ -233,7 +256,7 @@ &sdmmc {
 	cap-mmc-highspeed;
 	cap-sd-highspeed;
 	disable-wp;
-	vmmc-supply = <&vcc_io>;
+	vmmc-supply = <&vcc_sd>;
 	status = "okay";
 };
 
-- 
2.47.0


