Return-Path: <linux-kernel+bounces-423583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B90079DA9F3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58DB3B217AB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DE11FF7C7;
	Wed, 27 Nov 2024 14:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="eh6H3tKE"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C17A1FCD1E;
	Wed, 27 Nov 2024 14:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732718271; cv=none; b=lKhWPj3ys4JTOIFNW2cMrFu1r2FBiQljcb7EAJMtD9zIPuX4/CgdG2AsMT8Ff4bsygHXbedB6Bux15A8lvCI1YUTpPSatpFvx+CHaTBcBp3RrOx2niNSkTSVBjJve9BNdsBL03wcYBhBt6bQhVOULXkA55V9E2t77qrm6B2Gw08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732718271; c=relaxed/simple;
	bh=PP5+wPi8HXWGarBSZQbTahnodx7qDktCxhWRo6bQdec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ooUHvoH1x/mBb306wSifmFpqtrz7b8t5VWwHVvrQytoZbzzHjemaH9HgfEBLYmP5qsz8AUJR91BUSn5IcSGG+QzY0GHd3RU6I97ON9lRNt/hqhTeUPmiYyL8DL+8qox0eW1WHVLypdjuWX2z/v4YVzzWCcEdi9HnmTIjrVCUO9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=eh6H3tKE; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JG65amItm1eQrPUKFI3ZjKhN3hgWEFqfBjT1QDEGt80=; b=eh6H3tKEO4hVqfxnVoFJfrSHKY
	GmuYz7tQm2zS+CPYGTm8lP9u0QQgaMPtJDps1DA/KFToM0xsOBtAsMJHwm9IDIkYW4Eq7dXPinRMb
	/E9FXJh7SR02UveBDtaO1GbUVLQyw1DO2WAAsRx5aHxAv+h46C/TiX/OsOakkSjj+fKMdaKqZy/ui
	u4UOGBAZ595I8jWLvRCFiNMCohNo72OQS7sY2ms6PeqJJS/yh7/KdzLBFKxGZawtug4vDFGAjq3es
	NOC/jf2NuaFe0of6VsVvDkcJkcQr6uzenEwwlnlp8Ucp6uOEosGK/EJKdY2bvB7vA9O3ZQmvTyCG2
	EQHl9hDg==;
Received: from i5e86190f.versanet.de ([94.134.25.15] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tGJAj-0002n6-NU; Wed, 27 Nov 2024 15:37:41 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@cherry.de,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dse@thaumatec.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH v2 1/3] arm64: dts: rockchip: add mipi dcphy nodes to rk3588
Date: Wed, 27 Nov 2024 15:37:17 +0100
Message-ID: <20241127143719.660658-2-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241127143719.660658-1-heiko@sntech.de>
References: <20241127143719.660658-1-heiko@sntech.de>
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
index d9a2648a65d2..93d031d8821f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -580,6 +580,16 @@ sys_grf: syscon@fd58c000 {
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
@@ -2882,6 +2892,38 @@ usbdp_phy0: phy@fed80000 {
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
2.45.2


