Return-Path: <linux-kernel+bounces-534032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E271A461D8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15AE21889F19
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B10722157B;
	Wed, 26 Feb 2025 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="bkg6BcNi"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C3817B4EC;
	Wed, 26 Feb 2025 14:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579002; cv=none; b=lcIRa48HlX1ZrhW0HjzbaBY9131FyXv6pcRzlhBpe160vGDYRUxrXK9SLh9lwY3uMH4QBKyKxrIHUXi7c7vPLKMD3sgIJolXSH4f0hitAqIZmcebAyMD6hkG9RcByBDwUpMGia1nco0HdKlGYXGyNj9ef2gof01+KYA4Lmt3eac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579002; c=relaxed/simple;
	bh=ok/NhUHTZuWCxGqzKkdB5O+6plbPgK9H+btTODaRFcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IlSERnmHAC5XlONkz144qlJj8dl79qP/mbmWYMcRrc8pv3UrOyv2PtpkPIcNJvSydr3G02nnkE1ZEguASavy3RIIgf2fss9km6FdRnpUQkp/Y1Ev7ucKDdWqNb8dML54cfXUWW7E/l4Po7UFH3gLfpReyv7Xz05oScoejLA3t08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=bkg6BcNi; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gE+DoygJHk7LwLMt2mguR3vh+dirYo0lkI+9kyHltus=; b=bkg6BcNipUZa9RfptKX8x+a98r
	TdkcfFVy6xJZHCHfqtHlqTVG+7LG4BqPkE0Ya0oMmfEOaLcQXFYQsmuufb9i42zfCWkzzuhm48UAw
	SIr4qeildYb1InvOlBEcFGCEgIOHSpOJDVrL0ydyEADc+ieq3x8DFHJ7DAggkTr1XuRDICr5Yafdz
	LQh/9OfLh5YPfbCSDS821QUuDjCab3UkkXpcF1edctHm4tARELW7W0HhKTVVirkmVtQbCLPXr5WRU
	uiMmakB7QD13rtMv3oRjR0wJRbl3IlrYa/peClxrUqpQpfIJZeNK3BQQ33WveCieQaNVZYL5ug6Kh
	fY5XZPhw==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tnI6o-0000V2-J9; Wed, 26 Feb 2025 15:09:58 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@cherry.de,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dse@thaumatec.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH v3 1/3] arm64: dts: rockchip: add mipi dcphy nodes to rk3588
Date: Wed, 26 Feb 2025 15:09:40 +0100
Message-ID: <20250226140942.3825223-2-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250226140942.3825223-1-heiko@sntech.de>
References: <20250226140942.3825223-1-heiko@sntech.de>
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
index 8b497eb5da16..5535d5d905f6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -574,6 +574,16 @@ sys_grf: syscon@fd58c000 {
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
@@ -2915,6 +2925,38 @@ usbdp_phy0: phy@fed80000 {
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
+		#phy-cells = <1>;
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
+		#phy-cells = <1>;
+		status = "disabled";
+	};
+
 	combphy0_ps: phy@fee00000 {
 		compatible = "rockchip,rk3588-naneng-combphy";
 		reg = <0x0 0xfee00000 0x0 0x100>;
-- 
2.47.2


