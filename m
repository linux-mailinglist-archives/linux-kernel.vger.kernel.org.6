Return-Path: <linux-kernel+bounces-379987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 018749AE6CA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABEE41F27BD9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D791F7084;
	Thu, 24 Oct 2024 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="xdRcTUkU"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846471EF097;
	Thu, 24 Oct 2024 13:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729776769; cv=none; b=ecpy1p8Hr3wHGdmp4C0/wg0i9MzDGdt26mt1521lJoY9EEBP/sWg11eDQQT4gKZgQBifRweSfRW5eMdHxN7D6MKZl7UwzqFN0BLEH4fLJ0RhHwWMbwrbdMEZRlgvgb2EjBSTsO8r0caQByTjfj8U4kP8DZ0HLAZJOmevVIMNFc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729776769; c=relaxed/simple;
	bh=paS26i/SjF5cRqBIozfje/J0XyE2H4LFuZCbWxcOlWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A1Tfb2pMtQYRzR4eQghkDUXn02nD9BB8HfI6hX8F4avpQnzW3Iv4yqAqSW6c5fCpUi8WBICvex45AYa623GmPuwwEf3+BCspx5bqpgFXcHMmSEe0u4eMAb+DdSHi+I9MvH9VMtiFvyw+QtUf29IUkFYzE++8YRxDvpRt0EqwzF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=xdRcTUkU; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OntcF2LDcuLBkXSM2En+JfGB3Jl5eFSXxvJ7ANnr81Q=; b=xdRcTUkUw6WtN9ur1eJvgRfwKW
	HwV0UPL3m6H94N6HpfdGUpWgpc/MbDOWUszVPhYhs4503kN/0wGNBNFIRwZ5i1RKN6UMsiQJ7qYIf
	3BJbJiOU/qj1YYkTWN5OVxmHtEPci4859fe6VswhX9ty/B21HuxGBftaeiiATGf2Bo0d/9C8euVvK
	o8NvESGfQXl0KITPYyHlAaM8lr5D51Yzv/vN7YFBLD6Z8+sP2D+1Jx2l9qOjj5lhvXGFA0DbSKz2E
	eH+Og/n+fu3FMjMNC3R+Dlt6mVVxYaKbF4Skfzk1uemvxGSFKX780ZeT9w0swcA5dh9gztacLQt1Y
	esKMx2NQ==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t3xxD-0007hQ-AY; Thu, 24 Oct 2024 15:32:43 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@cherry.de,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 1/2] arm64: dts: rockchip: add HDMI support to rk3588-tiger-haikou
Date: Thu, 24 Oct 2024 15:32:39 +0200
Message-ID: <20241024133240.1737647-1-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
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
 .../boot/dts/rockchip/rk3588-tiger-haikou.dts | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
index e4b7a0a4444b..e3596341b816 100644
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
@@ -155,6 +167,29 @@ &gmac0 {
 	status = "okay";
 };
 
+&hdmi0 {
+	/* No CEC on Haikou */
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
 
@@ -321,3 +356,18 @@ &usb_host1_xhci {
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


