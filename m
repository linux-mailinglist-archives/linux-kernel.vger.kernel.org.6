Return-Path: <linux-kernel+bounces-299209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB10B95D18F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0C0D1C21C78
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D29189BB1;
	Fri, 23 Aug 2024 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b="VJOQ8SI7"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABCF189509
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724427361; cv=none; b=dzTubeH/1dcp27NL53NzOv88Xft42fVbcs30miv3aTHg2ND71keLw32NkgRQBbfqi2RZGsiyR3ZOiIPXIy/OAN6bohnG0pudP+OBLAdpuEkRHOyFFAq8joEUwNWoIDPbkcZ2xMSqtsGxCwsJZjrRpyK51sEeYGFnCLANUEVMW2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724427361; c=relaxed/simple;
	bh=ic1UksxX9C3U+zO04YiIE/rAsB50nQjVR88sEiBVK1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Le56VoIkJNTcBZfVKFt58CjjJ8/xT/45EJu0CLiqfDj8E4ixZgZphZKfvTFVZzfklJRXi9MQWdzIegs7LrzJZl1LhgkzdRgxeewsjCBT2vSG9/5JAPTRIsjj79EU+OqMlsnzj2qlNf/gzNd23dSXwtaS6dUHNLuHInfJonDtjGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com; spf=pass smtp.mailfrom=linumiz.com; dkim=pass (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b=VJOQ8SI7; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linumiz.com
Received: from eig-obgw-6009a.ext.cloudfilter.net ([10.0.30.184])
	by cmsmtp with ESMTPS
	id hR0osFbBAqvuohWKQs6cLz; Fri, 23 Aug 2024 15:35:54 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
	by cmsmtp with ESMTPS
	id hWKNsUBcTEatOhWKOs7fAa; Fri, 23 Aug 2024 15:35:53 +0000
X-Authority-Analysis: v=2.4 cv=F5ZRdLhN c=1 sm=1 tr=0 ts=66c8ac59
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=kofhyyBXuK/oEhdxNjf66Q==:17
 a=yoJbH4e0A30A:10 a=vU9dKmh3AAAA:8 a=PIVyUoi6X9y6bivDt_YA:9
 a=rsP06fVo5MYu2ilr0aT5:22 a=ZCPYImcxYIQFgLOT52_G:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=HI4wA5946lgKTidFdG+3Mj2M1oic6hs347gXt2MsqwU=; b=VJOQ8SI7zWFzyuDXoLQpIwwRFZ
	I9b+Ml8jOjYnmdAtObuXmj1zNlq6uuXbLPNXHlV8hkLbtnj229NavZX56pqdTeiBojhE0KgI39kF/
	rUC6P0UG0ARVZ/rE01l8CE/6HfAOsR1z4WirP2E8UhEWRJFGRD8d+Cfe4I5w/hfZEWvtfGl1CJybj
	bDhuU1W73xngcpo9kFK/15Sg15jMTzrFZoIgk8mfuKRX7Yt/qUek8FUy3eNz9vrQiw/8cqBdZdHcE
	uR8TBbivAQWFHWjqSH6ChQXbdtU5SvzTMUgz0XBurwgzHnyOOSQ8YVq02XqQ6d/YDeglBMD96Bbqy
	oNKcMaSw==;
Received: from [122.165.245.213] (port=53684 helo=localhost.localdomain)
	by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <karthikeyan@linumiz.com>)
	id 1shWKL-000GB4-37;
	Fri, 23 Aug 2024 21:05:50 +0530
From: Karthikeyan Krishnasamy <karthikeyan@linumiz.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	alexandre.belloni@bootlin.com
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	Karthikeyan Krishnasamy <karthikeyan@linumiz.com>
Subject: [PATCH 2/8] ARM: dts: rockchip: Add i2s0 node for RV1126
Date: Fri, 23 Aug 2024 21:05:22 +0530
Message-Id: <20240823153528.3863993-3-karthikeyan@linumiz.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240823153528.3863993-1-karthikeyan@linumiz.com>
References: <20240823153528.3863993-1-karthikeyan@linumiz.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 122.165.245.213
X-Source-L: No
X-Exim-ID: 1shWKL-000GB4-37
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [122.165.245.213]:53684
X-Source-Auth: karthikeyan@linumiz.com
X-Email-Count: 22
X-Org: HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFn6ItC6KUve9oUBJEiMjjl7hTQ2yWxALeFUL4/3piEbB+Px5oVZPEbSKtBSJfjRbZDDY0jNZ5vYvC0wRHMEk6rJA8pZOf6fKSMN+PNACA/Bd4i88XkZ
 BXARaAra81c5CzLBM1orJfO48xesxX/v28oWtoSB/hIsnzYBGmnWK7eFCA6D/C1aPxup3Jx0rmENABRG0MJjGMYFS/YeQmW3SvCAJzk7lFPaPv32DoWlXp/D

Add i2s0 node and possible pinctrl for Rockchip RV1126

Signed-off-by: Karthikeyan Krishnasamy <karthikeyan@linumiz.com>
---
 .../arm/boot/dts/rockchip/rv1126-pinctrl.dtsi | 102 ++++++++++++++++++
 arch/arm/boot/dts/rockchip/rv1126.dtsi        |  26 +++++
 2 files changed, 128 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rv1126-pinctrl.dtsi b/arch/arm/boot/dts/rockchip/rv1126-pinctrl.dtsi
index be666b25b830..c83490dfe8f6 100644
--- a/arch/arm/boot/dts/rockchip/rv1126-pinctrl.dtsi
+++ b/arch/arm/boot/dts/rockchip/rv1126-pinctrl.dtsi
@@ -123,6 +123,108 @@ i2c3m2_xfer: i2c3m2-xfer {
 				<1 RK_PD7 3 &pcfg_pull_none>;
 		};
 	};
+	i2s0 {
+		i2s0m0_sclk_tx: i2s0m0-sclk-tx {
+			rockchip,pins =
+			/* i2s0_sclk_tx_m0 */
+			<3 RK_PD0 1 &pcfg_pull_none>;
+		};
+		i2s0m0_sclk_rx: i2s0m0-sclk-rx {
+			rockchip,pins =
+			/* i2s0_sclk_rx_m0 */
+			<3 RK_PD1 1 &pcfg_pull_none>;
+		};
+		i2s0m0_mclk: i2s0m0-mclk {
+			rockchip,pins =
+			/* i2s0_mclk_m0 */
+			<3 RK_PD2 1 &pcfg_pull_none>;
+		};
+		i2s0m0_lrck_tx: i2s0m0-lrck-tx {
+			rockchip,pins =
+			/* i2s0_lrck_tx_m0 */
+			<3 RK_PD3 1 &pcfg_pull_none>;
+		};
+		i2s0m0_lrck_rx: i2s0m0-lrck-rx {
+			rockchip,pins =
+			/* i2s0_lrck_rx_m0 */
+			<3 RK_PD4 1 &pcfg_pull_none>;
+		};
+		i2s0m0_sdi0: i2s0m0-sdi0 {
+			rockchip,pins =
+			/* i2s0_sdi0_m0 */
+			<3 RK_PD6 1 &pcfg_pull_none>;
+		};
+		i2s0m0_sdo0: i2s0m0-sdo0 {
+			rockchip,pins =
+			/* i2s0_sdo0_m0 */
+			<3 RK_PD5 1 &pcfg_pull_none>;
+		};
+		i2s0m0_sdo1_sdi3: i2s0m0-sdo1_sdi3 {
+			rockchip,pins =
+			/* i2s0_sdo1_sdi3_m0 */
+			<3 RK_PD7 1 &pcfg_pull_none>;
+		};
+		i2s0m0_sdo2_sdi2: i2s0m0-sdo2_sdi2 {
+			rockchip,pins =
+			/* i2s0_sdo2_sdi2_m0 */
+			<4 RK_PA0 1 &pcfg_pull_none>;
+		};
+		i2s0m0_sdo3_sdi1: i2s0m0-sdo3_sdi1 {
+			rockchip,pins =
+			/* i2s0_sdo3_sdi1_m0 */
+			<4 RK_PA1 1 &pcfg_pull_none>;
+		};
+		i2s0m1_sclk_tx: i2s0m1-sclk-tx {
+			rockchip,pins =
+			/* i2s0_sclk_tx_m1 */
+			<3 RK_PA4 3 &pcfg_pull_none>;
+		};
+		i2s0m1_sclk_rx: i2s0m1-sclk-rx {
+			rockchip,pins =
+			/* i2s0_sclk_rx_m1 */
+			<3 RK_PB1 3 &pcfg_pull_none>;
+		};
+		i2s0m1_mclk: i2s0m1-mclk {
+			rockchip,pins =
+			/* i2s0_mclk_m1 */
+			<3 RK_PB0 3 &pcfg_pull_none>;
+		};
+		i2s0m1_lrck_tx: i2s0m1-lrck-tx {
+			rockchip,pins =
+			/* i2s0_lrck_tx_m1 */
+			<3 RK_PA5 3 &pcfg_pull_none>;
+		};
+		i2s0m1_lrck_rx: i2s0m1-lrck-rx {
+			rockchip,pins =
+			/* i2s0_lrck_rx_m1 */
+			<3 RK_PB2 3 &pcfg_pull_none>;
+		};
+		i2s0m1_sdi0: i2s0m1-sdi0 {
+			rockchip,pins =
+			/* i2s0_sdi0_m1 */
+			<3 RK_PA7 3 &pcfg_pull_none>;
+		};
+		i2s0m1_sdo0: i2s0m1-sdo0 {
+			rockchip,pins =
+			/* i2s0_sdo0_m1 */
+			<3 RK_PA6 3 &pcfg_pull_none>;
+		};
+		i2s0m1_sdo1_sdi3: i2s0m1-sdo1_sdi3 {
+			rockchip,pins =
+			/* i2s0_sdo1_sdi3_m1 */
+			<3 RK_PB3 3 &pcfg_pull_none>;
+		};
+		i2s0m1_sdo2_sdi2: i2s0m1-sdo2_sdi2 {
+			rockchip,pins =
+			/* i2s0_sdo2_sdi2_m1 */
+			<3 RK_PB4 3 &pcfg_pull_none>;
+		};
+		i2s0m1_sdo3_sdi1: i2s0m1-sdo3_sdi1 {
+			rockchip,pins =
+			/* i2s0_sdo3_sdi1_m1 */
+			<3 RK_PB5 3 &pcfg_pull_none>;
+		};
+	};
 	pwm2 {
 		/omit-if-no-ref/
 		pwm2m0_pins: pwm2m0-pins {
diff --git a/arch/arm/boot/dts/rockchip/rv1126.dtsi b/arch/arm/boot/dts/rockchip/rv1126.dtsi
index 59de848c9a83..09ecde58c553 100644
--- a/arch/arm/boot/dts/rockchip/rv1126.dtsi
+++ b/arch/arm/boot/dts/rockchip/rv1126.dtsi
@@ -434,6 +434,32 @@ timer0: timer@ff660000 {
 		clock-names = "pclk", "timer";
 	};
 
+	i2s0: i2s@ff800000 {
+		compatible = "rockchip,rv1126-i2s-tdm";
+		reg = <0xff800000 0x1000>;
+		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru MCLK_I2S0_TX>, <&cru MCLK_I2S0_RX>, <&cru HCLK_I2S0>;
+		clock-names = "mclk_tx", "mclk_rx", "hclk";
+		dmas = <&dmac 20>, <&dmac 19>;
+		dma-names = "tx", "rx";
+		resets = <&cru SRST_I2S0_TX_M>, <&cru SRST_I2S0_RX_M>;
+		reset-names = "tx-m", "rx-m";
+		rockchip,grf = <&grf>;
+		#sound-dai-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2s0m0_sclk_tx>,
+			     <&i2s0m0_sclk_rx>,
+			     <&i2s0m0_mclk>,
+			     <&i2s0m0_lrck_tx>,
+			     <&i2s0m0_lrck_rx>,
+			     <&i2s0m0_sdi0>,
+			     <&i2s0m0_sdo0>,
+			     <&i2s0m0_sdo1_sdi3>,
+			     <&i2s0m0_sdo2_sdi2>,
+			     <&i2s0m0_sdo3_sdi1>;
+		status = "disabled";
+	};
+
 	vop: vop@ffb00000 {
 		compatible = "rockchip,rv1126-vop";
 		reg = <0xffb00000 0x200>, <0xffb00a00 0x400>;
-- 
2.39.2


