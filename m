Return-Path: <linux-kernel+bounces-371882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 928829A41BC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7C91C24A8D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C45E1FF5F7;
	Fri, 18 Oct 2024 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="lrX4z7cN"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1A31EE03D
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729263155; cv=none; b=E0rwH+wFTkRDmnSe+RKlxIVA1ziUvrua3IaAFuQdCEuNiLyz5rvaljJSrMi/T4o9q4Lpu2ps6tKSXczphSMdylpMbcUHmDEda2ij4YR3DswgycnLFZ9K6JNSApYcrRhp4Ful6JU3+EFDsU3DRcuoVSdh7BJMVWzo0ay8U45jvr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729263155; c=relaxed/simple;
	bh=4n+xC1OqSR+FiSxSwPKtJfP3Ja0fohHQxfTzsNFf//c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sHfyTA3iLcUk/s6K6lA5E3yPpUQw72TFkPNT9/wUpkTDwRqUKlXAGE1UHGUN5AA9+TzPRZ7rmSIafu9S1wzC9m5OXUnD0tAFsJjQKLgvb+aGRiLWPXRi9vWDmyBruHYdFSRadWjVUQIjEX4GRLu9R0PqzrrI/6yBfgOSnfv8khk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=lrX4z7cN; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1729263150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6Op0z2Z8YZdmLDf5Ekh5OWfa4CyRppADnsh714GMqJU=;
	b=lrX4z7cNsWFHB1b4QGI0oeP4D0vNqiylloxToHWTN/qBJa5G2aydNc7ejWX4oJPgcfkrKb
	QG4MvU36zsQLG9PozbCDciiMDf5CkaDviRvzgV32H7cln2zacvnn/RKTfVXb3Clnsqef8W
	S+Bs8IfyPIEvJ87Ou6JCKk+FGbWOg6KzsdhT37kAgtq2XcKUPNfR4AZHeskHi+ryL6rcCS
	XK5pDSTwfz4k7Jo+BIn+R2xpV2syQQQp0Ws0gy5idSfY0lDp9YtEb5Lr2h6E+/mgDBuJtU
	6raG+qwTFvb4yWIQ7H+Ou6zrXGKwlVmVYq0E085B2dY2lqGeRiCU+PVyJWln+A==
From: Diederik de Haas <didi.debian@cknow.org>
To: Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-rockchip@lists.infradead.org,
	Samuel Holland <samuel@sholland.org>,
	Dragan Simic <dsimic@manjaro.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH v2] arm64: dts: rockchip: Correct GPIO polarity on brcm BT nodes
Date: Fri, 18 Oct 2024 16:45:50 +0200
Message-ID: <20241018145053.11928-2-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Paragraph "3.4 Power up Timing Sequence" of the AzureWave-CM256SM
datasheet mentions the following about the BT_REG_ON pin, which is
connected to GPIO0_C4_d:

  When this pin is low and WL_REG_ON is high,
  the BT section is in reset.

Therefor set that pin to GPIO_ACTIVE_HIGH so that it can be pulled low
for a reset.
If set to GPIO_ACTIVE_LOW, the following errors are observed:

  Bluetooth: hci0: command 0x0c03 tx timeout
  Bluetooth: hci0: BCM: Reset failed (-110)

So fix the GPIO polarity by setting it to ACTIVE_HIGH.
This also matches what other devices with the same BT device have.

Fixes: a3a625086192 ("arm64: dts: rockchip: Fix reset-gpios property on brcm BT nodes")
Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
Changes in v2:
- Better commit description with references to the datasheet
- Dropped the (self-)blame as it's not useful to evaluate the usefulness
  of this patch

 arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi  | 2 +-
 arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
index a477bd992b40..0131f2cdd312 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
@@ -688,7 +688,7 @@ bluetooth {
 		host-wakeup-gpios = <&gpio0 RK_PC3 GPIO_ACTIVE_HIGH>;
 		pinctrl-0 = <&bt_enable_h>, <&bt_host_wake_l>, <&bt_wake_h>;
 		pinctrl-names = "default";
-		shutdown-gpios = <&gpio0 RK_PC4 GPIO_ACTIVE_LOW>;
+		shutdown-gpios = <&gpio0 RK_PC4 GPIO_ACTIVE_HIGH>;
 		vbat-supply = <&vcc_wl>;
 		vddio-supply = <&vcca_1v8_pmu>;
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi
index e9fa9bee995a..1e36f73840da 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi
@@ -404,7 +404,7 @@ bluetooth {
 		host-wakeup-gpios = <&gpio2 RK_PB1 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&bt_host_wake_h &bt_reg_on_h &bt_wake_host_h>;
-		shutdown-gpios = <&gpio2 RK_PC0 GPIO_ACTIVE_LOW>;
+		shutdown-gpios = <&gpio2 RK_PC0 GPIO_ACTIVE_HIGH>;
 		vbat-supply = <&vcc_3v3>;
 		vddio-supply = <&vcc_1v8>;
 	};
-- 
2.45.2


