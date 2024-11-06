Return-Path: <linux-kernel+bounces-398225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 536859BEA65
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7795A1C25928
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 12:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3E61F9A82;
	Wed,  6 Nov 2024 12:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="0XvfO7h+"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BCC1E3786;
	Wed,  6 Nov 2024 12:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896692; cv=none; b=VPOpyNMjfWBKhi6N/gIaZ7Sn/5mKDTGPGvpTj0eiCQaAX93hWVuMCw3rX8SmPhLLiJvKPCCfvJZviRfmarmEqYOYsba2DKxlrfWuDCzQoLXjE7RwVQUVUcxlOhwzWpqFhLMo0ao5RXzKhjQLKJv32Xah/IQglrgaxf0CDt7xw6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896692; c=relaxed/simple;
	bh=eanpZhSG9dWUmjWfMe7zVrerkItvUw0VQ0neWEkUkUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NLg4L7HQphcyfYSKM+OhPVsZE2udXuBbt42bodpZ2UyiKKnc8bN1IPhD9IE+ysNl8TCDJ9Ng4YjtGycyKa4sOp1e7TWGL4Lft5F5lljj8YvqqQwE5lAgJ26JPRPf2JAF6v954NMcU7PHG2tnJZmC/qt2lhor72rRIxTKIWwyUck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=0XvfO7h+; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JPM/CaXFyY/a4sEGw6rIBS5Qu/8VC3MAZ527UKrKvBE=; b=0XvfO7h+50cRfYq5ugr8nVZedy
	pIwW6k5wH1Vnc4pCdF9kLUUTZ8MTVKLCFxscstV04UZJDLe9ZJInOxn1JwLY3GbUk8gfMchWlUSvE
	HVJXfgA65vKX2++sthIS4QK6JPIsegsLM7TdAauX4irbk/rpPutUfzto1gS6B1xvopk3ChMurcjfl
	vOF5o0tEs5VGWjkfzQxmWRsuqXfeQe8UapKLb/kOiP7naj7KdMg5k0DdFpNIOTGGxL6t8+TkcQJLJ
	7f7a1akkSDqqRwVLG6U7WWoAZj4D7RieONfMmq1S407nchi9veuMjbMtcnDUFAkkuVTUCEPZi55hc
	ZqoM/C2Q==;
Received: from i53875b28.versanet.de ([83.135.91.40] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t8fIV-0007A8-TR; Wed, 06 Nov 2024 13:38:07 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@cherry.de,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 1/3] arm64: dts: rockchip: add mipi dcphy nodes to rk3588
Date: Wed,  6 Nov 2024 13:37:56 +0100
Message-ID: <20241106123758.423584-2-heiko@sntech.de>
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

Add the two MIPI-DC-phy nodes to the RK3588, that will be used by the
DSI2 controllers and hopefully in some future also for camera input.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index 51ba7563f7d0..8c95c56e8097 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -576,6 +576,16 @@ sys_grf: syscon@fd58c000 {
 		reg = <0x0 0xfd58c000 0x0 0x1000>;
 	};
 
+	mipidcphy0_grf: syscon@fd5e8000 {
+		compatible = "rockchip,rk3588-dcphy-grf", "syscon";
+		reg = <0x0 0xfd5e8000 0x0 0x4000>;
+	};
+
+	mipidcphy1_grf: syscon@fd5ec000 {
+		compatible = "rockchip,rk3588-dcphy-grf", "syscon";
+		reg = <0x0 0xfd5ec000 0x0 0x4000>;
+	};
+
 	vop_grf: syscon@fd5a4000 {
 		compatible = "rockchip,rk3588-vop-grf", "syscon";
 		reg = <0x0 0xfd5a4000 0x0 0x2000>;
@@ -2878,6 +2888,38 @@ usbdp_phy0: phy@fed80000 {
 		status = "disabled";
 	};
 
+	mipidcphy0: phy@feda0000 {
+		compatible = "rockchip,rk3588-mipi-dcphy";
+		reg = <0x0 0xfeda0000 0x0 0x10000>;
+		rockchip,grf = <&mipidcphy0_grf>;
+		clocks = <&cru PCLK_MIPI_DCPHY0>,
+			 <&cru CLK_USBDPPHY_MIPIDCPPHY_REF>;
+		clock-names = "pclk", "ref";
+		resets = <&cru SRST_M_MIPI_DCPHY0>,
+			 <&cru SRST_P_MIPI_DCPHY0>,
+			 <&cru SRST_P_MIPI_DCPHY0_GRF>,
+			 <&cru SRST_S_MIPI_DCPHY0>;
+		reset-names = "m_phy", "apb", "grf", "s_phy";
+		#phy-cells = <0>;
+		status = "disabled";
+	};
+
+	mipidcphy1: phy@fedb0000 {
+		compatible = "rockchip,rk3588-mipi-dcphy";
+		reg = <0x0 0xfedb0000 0x0 0x10000>;
+		rockchip,grf = <&mipidcphy1_grf>;
+		clocks = <&cru PCLK_MIPI_DCPHY1>,
+			 <&cru CLK_USBDPPHY_MIPIDCPPHY_REF>;
+		clock-names = "pclk", "ref";
+		resets = <&cru SRST_M_MIPI_DCPHY1>,
+			 <&cru SRST_P_MIPI_DCPHY1>,
+			 <&cru SRST_P_MIPI_DCPHY1_GRF>,
+			 <&cru SRST_S_MIPI_DCPHY1>;
+		reset-names = "m_phy", "apb", "grf", "s_phy";
+		#phy-cells = <0>;
+		status = "disabled";
+	};
+
 	combphy0_ps: phy@fee00000 {
 		compatible = "rockchip,rk3588-naneng-combphy";
 		reg = <0x0 0xfee00000 0x0 0x100>;
-- 
2.45.2


