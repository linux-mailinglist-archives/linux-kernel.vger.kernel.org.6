Return-Path: <linux-kernel+bounces-380199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B25189AEA16
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64F11C2242B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232401EF0A1;
	Thu, 24 Oct 2024 15:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="C2aW70CR"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215101DDA21;
	Thu, 24 Oct 2024 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782852; cv=none; b=eOx0YOHV770LavW7ktWu9s5Uodjho9idxGVHEcijeN0DjAnD3BcQWn2L0ziXNDeKqXbKesjO1kYebRXYYEWODG7sMYh4QYDNtBxd0xxISVrkls/OqqpM53i0jQh28CaCtEXPuHUOL7Tug9WMOAaHt51kxs5pHlrnqK2hk8jR6Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782852; c=relaxed/simple;
	bh=4LWglwpqZd5E9gVekuQg7zARpvR8P7IsglFzq4awsts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=juhkHwWMKwWrHwCwujIVy+qKEFzE/6+T7LEX0RTLG3mzAxZgwyPTDMadzJ7Uy3CfcKebbOL0LtLMF7GXB6PWa3f81FYzUNFuvbt7jP8ClDFHReSy98QFHfgGEcJt+Ilw45zFYJBl0sWPSbli0AAfOtEIORcyh5evzf2h7SIwlsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=C2aW70CR; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xtYtlnfTmvr3zN41Ip+EWEfN6UogitdaSsSvvG5Igbo=; b=C2aW70CRgRMOdVKehjfz70W+Cr
	svEASVpImDuk6Se2C1x4e6t8o2meA3u80bJhW7T6KN1pG2eWmZuz9w1mMvnJjnjLVg9GerofysCvT
	bb/9Tn/mVwRQxDiJlSJxTN0FWoMCnvIr11Qdpy24Ei0FL8YK3lrHc7xNLErFfY5Sl20KpWGUQ+u5D
	CD+UngHkHp3CA2CYmGfIKu1/4G8ZVKTSuS6U0enP9MjmuBzGxfd27PZVnsXNyjhsbfGEJNlRxqo/T
	gcmdHfRR7JT9xpTgiBpF8l70DyoGfAWRzTG9IwVe1qV/dsGS1AmTzVKz2jZpZYEVdhhi2xfm8GmEF
	R4euxe8A==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t3zXL-0004at-3T; Thu, 24 Oct 2024 17:14:07 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@cherry.de,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH v2 2/3] arm64: dts: rockchip: add HDMI support to rk3588-tiger-haikou
Date: Thu, 24 Oct 2024 17:14:02 +0200
Message-ID: <20241024151403.1748554-3-heiko@sntech.de>
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

The Haikou baseboard has an hdmi output port, which is connected
via the Q7 connector to the hdmi0 controller of the rk3588.

Add the necessary plumbing to enable it using the recently merged
hdmi-qp controller.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 .../boot/dts/rockchip/rk3588-tiger-haikou.dts | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
index e4b7a0a4444b..270d59a56037 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/soc/rockchip,vop2.h>
 #include "rk3588-tiger.dtsi"
 
 / {
@@ -61,6 +62,17 @@ switch-lid-btn-n {
 		};
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
 	i2s3-sound {
 		compatible = "simple-audio-card";
 		simple-audio-card,format = "i2s";
@@ -155,6 +167,32 @@ &gmac0 {
 	status = "okay";
 };
 
+&hdmi0 {
+	/*
+	 * While HDMI-CEC is present on the Q7 connector, it is not
+	 * connected on Haikou itself.
+	 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdmim0_tx0_hpd &hdmim1_tx0_scl &hdmim1_tx0_sda>;
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
 &i2c1 {
 	status = "okay";
 
@@ -321,3 +359,18 @@ &usb_host1_xhci {
 &usb_host2_xhci {
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


