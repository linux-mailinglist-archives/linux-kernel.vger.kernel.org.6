Return-Path: <linux-kernel+bounces-398223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B7A9BEA60
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 084CA1F24750
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 12:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B47C1F9423;
	Wed,  6 Nov 2024 12:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="PqnMfRss"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2810C1F8F13;
	Wed,  6 Nov 2024 12:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896691; cv=none; b=EcxhQfHTJquAD9t8uWaaV/nHNz0gx3aZ++A9P58E1ZP2FoKm38Pa5b5ilPfHfGW9C7jHwsXZYXwgfpZQYSQ3n7VcUNivY0EOEI7T8M6KixV4VmcD7RmZbZL4rziTVlJD/ZovCUiMcVpeq3+VomvDB5BlY5Yc7L3vklnm5LmCs3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896691; c=relaxed/simple;
	bh=zhWvmrEiopHjJe+O7D5Vx0z+Lx0rjErsDW9o4V/CGJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NoEHkgnrjI6Q/vWn2VskMz24JJO3oRAIGP8e0+j9s2KONnJbmlQyrMG4Mojyg0lUDjfoh9S+PQqklrQw5UF8AqIYehoNQxazjzlPNI2sJ30x2QKjzz896P4rwaaAu52j7bsG3xwMLGV5MrKRc96PFS7loOs8FRWW1PCvy2Jj6Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=PqnMfRss; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nd8WDBdT4JcyHkbixH6x2sPY4R14WnZRTUvb0ld1FwA=; b=PqnMfRssaNkWIHW6vVO88Pw+lg
	GgbHjce6zAZnmMoqiX9JgT/2VEghfg22EfjNpIFpe1xbsBTKEFXWnyqf319oOZTNPzcgzSiRh8QtQ
	VY0fX6QF+m4+oXZE5JW+nmua6nbIfd2ou0Dq2WFcH7gvm2wJyrhklRKXY02kzihusbUBRsnxxkj/G
	TfeyOqUe4OpJMmbJ/Jw52vhaSw3koKfPOgSaPnMHRQS98HDXfe/oVKMk/MJwIAm77W4LY6M8QfcjE
	CNwf96hPOlQ3dxfB1eS3m40gBQLTqYtW1t7P60SesS1+RT22FT6dDNxr4cNjGkpnPuLquDjB+XKxS
	3d/zmOBw==;
Received: from i53875b28.versanet.de ([83.135.91.40] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t8fIW-0007A8-8i; Wed, 06 Nov 2024 13:38:08 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@cherry.de,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 2/3] arm64: dts: rockchip: add dsi controller nodes on rk3588
Date: Wed,  6 Nov 2024 13:37:57 +0100
Message-ID: <20241106123758.423584-3-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241106123758.423584-1-heiko@sntech.de>
References: <20241106123758.423584-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The RK3588 comes with two DSI2 controllers based on a new Synopsis IP.
Add the necessary nodes for them.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index 8c95c56e8097..6d31de2a6930 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -1414,6 +1414,62 @@ i2s9_8ch: i2s@fddfc000 {
 		status = "disabled";
 	};
 
+	dsi0: dsi@fde20000 {
+		compatible = "rockchip,rk3588-mipi-dsi2";
+		reg = <0x0 0xfde20000 0x0 0x10000>;
+		interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru PCLK_DSIHOST0>, <&cru CLK_DSIHOST0>;
+		clock-names = "pclk", "sys";
+		resets = <&cru SRST_P_DSIHOST0>;
+		reset-names = "apb";
+		power-domains = <&power RK3588_PD_VOP>;
+		phys = <&mipidcphy0>;
+		phy-names = "dcphy";
+		rockchip,grf = <&vop_grf>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			dsi0_in: port@0 {
+				reg = <0>;
+			};
+
+			dsi0_out: port@1 {
+				reg = <1>;
+			};
+		};
+	};
+
+	dsi1: dsi@fde30000 {
+		compatible = "rockchip,rk3588-mipi-dsi2";
+		reg = <0x0 0xfde30000 0x0 0x10000>;
+		interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru PCLK_DSIHOST1>, <&cru CLK_DSIHOST1>;
+		clock-names = "pclk", "sys";
+		resets = <&cru SRST_P_DSIHOST1>;
+		reset-names = "apb";
+		power-domains = <&power RK3588_PD_VOP>;
+		phys = <&mipidcphy1>;
+		phy-names = "dcphy";
+		rockchip,grf = <&vop_grf>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			dsi1_in: port@0 {
+				reg = <0>;
+			};
+
+			dsi1_out: port@1 {
+				reg = <1>;
+			};
+		};
+	};
+
 	hdmi0: hdmi@fde80000 {
 		compatible = "rockchip,rk3588-dw-hdmi-qp";
 		reg = <0x0 0xfde80000 0x0 0x20000>;
-- 
2.45.2


