Return-Path: <linux-kernel+bounces-553438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CC5A58999
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 01:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C90A43AB4DE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 00:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D811F1401B;
	Mon, 10 Mar 2025 00:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="F7yxa6K0"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F0ADDBC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 00:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741565594; cv=none; b=fL+51aQdk7IgXied1qEM3jwDHSpEq/ZMy0FqfnhA69KeYoKj6FEIc85VEW7echhRWYPv3ESZASRomiKXxvv7HAnnk28XpZ4nMzq2MvTIjk0NEgIK+SpCFuyb1YZWrwv2tNmQ5d9N4mjIk7ED+1GqSgo+RSEYiVVzRx7htEekA6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741565594; c=relaxed/simple;
	bh=6QrsQCgfLGlEEg2v/k0LauMQmTYl0OG7sCbgjB1yoeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2vxxxdUNvWqG7M5VeOzAv3wOwUy4LlI5KY9ptaboVw/c6AoXGj2Y+9nKRK9Ktv+PnKGNKkmZVcm5QQzP4CqlAhVmFlLtTI3fjQHN5aHN5gotIMOm1W4Ui3P8iNTqz5SvvsvLLaJ8+ZS6hk2Yp/a2nF7Drg/VTRpllQgkBwgpHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=F7yxa6K0; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1741565591; bh=zOLH/juLTXvxgHLu54B/ak9W7ilP6o7Nh3Sn02QT/08=;
 b=F7yxa6K066HAtxtjrLM9eJ/XKqvl/rbySkZhxQ8N5K6OOb2W4UNSeY5k8MEy1syKzwHNJ4mFJ
 Ud/+zjQe/UQVUi9so+qcGDs8REdAienfv1RHM/NndCeXFMczWIhV9jGsp4U60f2lr671MgKwv0r
 w99pn9RZx5fZkcuZWmjLQ1tjUQ57I1RYoqEOkB7Zab2lMGS0alm7hZ2q/WLNCPcJgDnT1SwytVc
 lz1x4QaU0gpbfLZrbGkfAfRrzw0rTTIfrAqoE2vSZnJP5wn/862VPpH/jIyEOoOpSOetujXuaME
 31GckNeJtGytJX8HrDRqg2j5l0Hjg6YycVlclrikal8Q==
X-Forward-Email-ID: 67ce2e96f812de2512d1f57c
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 2/2] arm64: dts: rockchip: Enable Ethernet controller on Radxa E20C
Date: Mon, 10 Mar 2025 00:12:51 +0000
Message-ID: <20250310001254.1516138-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310001254.1516138-1-jonas@kwiboo.se>
References: <20250310001254.1516138-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Radxa E20C has two GbE ports, LAN and WAN. The LAN port is provided
using a GMAC controller and a YT8531C PHY and the WAN port is provided
by an RTL8111H PCIe Ethernet controller.

Enable support for the LAN port on Radxa E20C.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v2:
- Rebase on top of the "Support I2C controllers in RK3528" series [1]

[1] https://lore.kernel.org/r/20250309070603.35254-1-ziyao@disroot.org
---
 .../boot/dts/rockchip/rk3528-radxa-e20c.dts   | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
index 790cd18f29cb..f4984e036f38 100644
--- a/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
@@ -16,6 +16,7 @@ / {
 	compatible = "radxa,e20c", "rockchip,rk3528";
 
 	aliases {
+		ethernet0 = &gmac1;
 		mmc0 = &sdhci;
 		mmc1 = &sdmmc;
 	};
@@ -123,6 +124,17 @@ vccio_sd: regulator-vccio-sd {
 	};
 };
 
+&gmac1 {
+	clock_in_out = "output";
+	phy-handle = <&rgmii_phy>;
+	phy-mode = "rgmii-id";
+	phy-supply = <&vcc_3v3>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii_miim>, <&rgmii_tx_bus2>, <&rgmii_rx_bus2>,
+		    <&rgmii_rgmii_clk>, <&rgmii_rgmii_bus>;
+	status = "okay";
+};
+
 &i2c1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c1m0_xfer>;
@@ -136,7 +148,25 @@ eeprom@50 {
 	};
 };
 
+&mdio1 {
+	rgmii_phy: ethernet-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&gmac1_rstn_l>;
+		reset-assert-us = <20000>;
+		reset-deassert-us = <100000>;
+		reset-gpios = <&gpio4 RK_PC2 GPIO_ACTIVE_LOW>;
+	};
+};
+
 &pinctrl {
+	ethernet {
+		gmac1_rstn_l: gmac1-rstn-l {
+			rockchip,pins = <4 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	gpio-keys {
 		user_key: user-key {
 			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
-- 
2.48.1


