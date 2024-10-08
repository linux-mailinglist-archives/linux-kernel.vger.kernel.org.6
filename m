Return-Path: <linux-kernel+bounces-355101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC0599474E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDE292843F7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9FC1DFD8F;
	Tue,  8 Oct 2024 11:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="Gih9R00N"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F77E1917E5
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 11:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728387278; cv=none; b=dE/aufE+SqlbH1GnNxHNgh1BenX4fgsS8enghVtUAd10gloGtIF1MYHqMP8Vd67IvOkDxMNBmcRVoar4hFbSsHOkoSZ2YBGWYooTjvekvJ4EB/Iwe1dpnLcjrg1jL66RA5N0sM70XHq4Uo8BScGhdllguY2eXA+Jn/aqApjfwS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728387278; c=relaxed/simple;
	bh=7rPn0Zhr1Au3miPuYWq6KKAiEVX5BjKq8teXQe1T2ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JbmWXaBFDzgXU6FIc3g0Gsmt/iRkMOsDn0b5h2oJYy9FJwzyCuPssEYyFmp1mTM+UMSvFDCUf6bId69xkvUlNiE3i+L3viTQJYfNnmAdr2iiWHUCqUWLJZ0u08jmf8hvrZGFWDmodnQIhVDTSA7Ca2GbSV0T8vOcojMaWOk2w0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=Gih9R00N; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1728387273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dKlqz7no2Q0t056MIy0/Nk83i3CyvmCGheL9X0Hx2a4=;
	b=Gih9R00ND98f9TxWntc7iICTyevgHbEJHne476iMNtuYR3DmO8m1rXXY2CM9F8xB0VAaSr
	5m+uFIcE2deDLKvzy63wQ4Fn54thb3LPC0nvzHjmLreIpxVidW+Zsay+r3bkOTOg6EeEQV
	sHpTopbwjLFUYybAis2ixpUgJmqUSW7viIKDbJ4jbld5mZ8Sj70sPDPr0+2/h+5NEZovQG
	8M4D0FBvCjqRoj5gIAB1/03yIJheWUK8O/hBGCqtBkpiOshbd+zF2PYd7X5sSzR9tMjLl2
	Fdh2yNdjc/zdtyfvC7Kmtt4ZnL/J76TFm9oPE9iEX1raH3/Ltpr3jXJgUxzSsA==
From: Diederik de Haas <didi.debian@cknow.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Diederik de Haas <didi.debian@cknow.org>,
	Dragan Simic <dsimic@manjaro.org>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	Samuel Holland <samuel@sholland.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] arm64: dts: rockchip: Fix reset-gpios property on brcm BT nodes
Date: Tue,  8 Oct 2024 13:15:39 +0200
Message-ID: <20241008113344.23957-5-didi.debian@cknow.org>
In-Reply-To: <20241008113344.23957-1-didi.debian@cknow.org>
References: <20241008113344.23957-1-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

For most compatibles, the "brcm,bluetooth.yaml" binding doesn't allow
the 'reset-gpios' property, but there is a 'shutdown-gpios' property.

Page 12 of the AzureWave-CM256SM datasheet (v1.9) has the following wrt
pin 34 'BT_REG_ON' (connected to GPIO0_C4_d on the PineNote):

  Used by PMU to power up or power down the internal regulators used
  by the Bluetooth section. Also, when deasserted, this pin holds the
  Bluetooth section in reset. This pin has an internal 200k ohm pull
  down resistor that is enabled by default.

So it is safe to replace 'reset-gpios' with 'shutdown-gpios'.

Fixes: d449121e5e8a ("arm64: dts: rockchip: Add Pine64 PineNote board")
Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
changes in v2:
- Extended commit message to explain why replacing 'reset' with
  'shutdown' is safe
- Added Fixes tag

 arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi  | 2 +-
 arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
index 7381bb751852..100a2774bbb5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
@@ -686,9 +686,9 @@ bluetooth {
 		clock-names = "lpo";
 		device-wakeup-gpios = <&gpio0 RK_PC2 GPIO_ACTIVE_HIGH>;
 		host-wakeup-gpios = <&gpio0 RK_PC3 GPIO_ACTIVE_HIGH>;
-		reset-gpios = <&gpio0 RK_PC4 GPIO_ACTIVE_LOW>;
 		pinctrl-0 = <&bt_enable_h>, <&bt_host_wake_l>, <&bt_wake_h>;
 		pinctrl-names = "default";
+		shutdown-gpios = <&gpio0 RK_PC4 GPIO_ACTIVE_LOW>;
 		vbat-supply = <&vcc_wl>;
 		vddio-supply = <&vcca_1v8_pmu>;
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi
index d09e6542e236..3e0cbfff96d8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi
@@ -402,9 +402,9 @@ bluetooth {
 		clock-names = "lpo";
 		device-wakeup-gpios = <&gpio2 RK_PB2 GPIO_ACTIVE_HIGH>;
 		host-wakeup-gpios = <&gpio2 RK_PB1 GPIO_ACTIVE_HIGH>;
-		reset-gpios = <&gpio2 RK_PC0 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&bt_host_wake_h &bt_reg_on_h &bt_wake_host_h>;
+		shutdown-gpios = <&gpio2 RK_PC0 GPIO_ACTIVE_LOW>;
 		vbat-supply = <&vcc_3v3>;
 		vddio-supply = <&vcc_1v8>;
 	};
-- 
2.45.2


