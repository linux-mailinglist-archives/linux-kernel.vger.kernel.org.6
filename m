Return-Path: <linux-kernel+bounces-380196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0470C9AEA12
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E271C21340
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CBD1EBFE2;
	Thu, 24 Oct 2024 15:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="aENqxCrl"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215671E378A;
	Thu, 24 Oct 2024 15:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782851; cv=none; b=AggsWtPYDxbJY0nbAqn5OmtkVyeZuFie/JBNxhDaadtIEDDRV3aOSoP02CADh45tiBNNIQ8IQ+uw4exgvM82vbthayB5a+/aJ1uI0rcKMMLvuz7mOaK/uBIWPwKgZO3Cp4nLtLX+lxnDkK2jFwXhQSfbEwcRW10aKlCibU/3JEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782851; c=relaxed/simple;
	bh=AAiz/VD1btLjuJNykiG+8szSa3n9z3i8FooWG3QVfHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dhWgl/T+0UXwjLkMgweG2o3ryPYyt0uW/RrAhRh3QYpS0Q09SVXV57bDur/U3pA398LwA6ch3IAz7eXzC93xFU8eM5EXyMA/L45DT2etAoRDEbfd5ZSlVp+O/AXFW+YsIALadG0FiBr0KaaomlSO8Iu2YBjorj+HTjXpTrPqW58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=aENqxCrl; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tT0U40vv7udlyyxS/UUhxQXBmlfc4h3QNcCT/CwDSHw=; b=aENqxCrlMoVWcNI5m97whKwwDx
	sfcr7DpCIZAQEFOdxx4DafhqabWaY7q6cN3SP6WRdLAwmwSQ+wGVmQp3qUG78P9ouI8vNdu/qccis
	8Ezhr28LZKVr8PqCG6+FSPPf9zRjo5BW84cwEqUA7A5jKuhwtQMPO8vezrvPcc5g4m1xvjNQjViqB
	5AW0oeLQEhc7B4OS2L1xanNFmZyw0QoFQie2rTWPVxUMpFXfXk8dS5JZ7ZQ08pZx47BQra42s67V+
	STuvV+4RFko1j1t6V+kSGwGVKyq9P4+AF+AM7ug2Erypeyf/2meAj40EnCkKpt9BRBvI6FclmCHcv
	zKDyzgbA==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t3zXL-0004at-Ea; Thu, 24 Oct 2024 17:14:07 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@cherry.de,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH v2 3/3] arm64: dts: rockchip: add HDMI support to rk3588-jaguar
Date: Thu, 24 Oct 2024 17:14:03 +0200
Message-ID: <20241024151403.1748554-4-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241024151403.1748554-1-heiko@sntech.de>
References: <20241024151403.1748554-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The jaguar has an hdmi output port, which is connected
to the hdmi0 controller of the rk3588.

Add the necessary plumbing to enable it using the recently merged
hdmi-qp controller.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 .../arm64/boot/dts/rockchip/rk3588-jaguar.dts | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
index e24da1a4331d..6a59887979ce 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
@@ -8,6 +8,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/soc/rockchip,vop2.h>
 #include <dt-bindings/usb/pd.h>
 #include "rk3588.dtsi"
 
@@ -58,6 +59,17 @@ emmc_pwrseq: emmc-pwrseq {
 		reset-gpios = <&gpio2 RK_PA3 GPIO_ACTIVE_HIGH>;
 	};
 
+	hdmi-con {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi0_out_con>;
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -271,6 +283,29 @@ &gpu {
 	status = "okay";
 };
 
+&hdmi0 {
+	/* No CEC on Jaguar */
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdmim0_tx0_hpd &hdmim0_tx0_scl &hdmim0_tx0_sda>;
+	status = "okay";
+};
+
+&hdmi0_in {
+	hdmi0_in_vp0: endpoint {
+		remote-endpoint = <&vp0_out_hdmi0>;
+	};
+};
+
+&hdmi0_out {
+	hdmi0_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
+&hdptxphy_hdmi0 {
+	status = "okay";
+};
+
 &i2c0 {
 	pinctrl-0 = <&i2c0m2_xfer>;
 	status = "okay";
@@ -1052,3 +1087,18 @@ &usb_host1_ehci {
 &usb_host1_ohci {
 	status = "okay";
 };
+
+&vop {
+	status = "okay";
+};
+
+&vop_mmu {
+	status = "okay";
+};
+
+&vp0 {
+	vp0_out_hdmi0: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
+		reg = <ROCKCHIP_VOP2_EP_HDMI0>;
+		remote-endpoint = <&hdmi0_in_vp0>;
+	};
+};
-- 
2.45.2


