Return-Path: <linux-kernel+bounces-423585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F549DA9F7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA0D4B22161
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5931200102;
	Wed, 27 Nov 2024 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="V/2lKhhc"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1E21FF618;
	Wed, 27 Nov 2024 14:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732718272; cv=none; b=la/u11C3SoREcxA4we2Q7Qey4HVUUqJaAIHnBJUZLAkzF7dl778tt8vAL2pp2cZ35mpwGrddFqaOg4NmvqhrbH0MFYAwqQBGS47cR9jCY5HGlg2yQ76TxiBTG8wFuv3OZ+Wn9BCH0f6eKeAOGqPgX+10CGqt9JvaeUblXhQ3Cuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732718272; c=relaxed/simple;
	bh=qluvYIbCFVTYUifJ8xvv/r5eKclqW2y9rVa6I+OSi44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BxzZpT1y75Rb+xk0HpePPbEo+7rhEdO2zQyMfGyX+QyNuvWS78M7AcqAs6Kf+7IHduE7nywkUFaJhbXe0TQpc4TqcLYXjh8omh5+kp3NDyOFQ0wXcYaAUZycNBc1CM5wgrWeDjPw7G0UosZhZqZWIeza+FtsdYZWsHk5pfSH7ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=V/2lKhhc; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=A8jtOmHgwKdJ7RYEMzsWHMrOOYe8zOa1+15YlW8Yfq4=; b=V/2lKhhc1QZtG0Hce3FY5TsE9B
	52TwnwBAwnaVs7JIZpvaj8wbX/mgpPKRmBb3Q/jndwtOvnIRqh4eing1+lH0iTTEQy6wR/CwLMzJ7
	m8N/sLgzMCzDLq/ZSHDoMnjhcaAM57xIKssvc+/XwWqL2iuegL/QaN1Mvwf5nBS5BGPfjmMaMsL6T
	RNhPResJ9dx22t/hNMY66vj4YmnB/SBWVm8Edl0x4LhuNDPjnNJmMXt/+dITJWfSCHErE6vh2uu0h
	zI+8pS2J+KAWkbT7+wHlOxDSVyovtUVbXyrNFlRwju4hFUm8m19NcT3ep3IBpplCYf5f5U6Z4lRkQ
	ENk9smvQ==;
Received: from i5e86190f.versanet.de ([94.134.25.15] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tGJAk-0002n6-4q; Wed, 27 Nov 2024 15:37:42 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@cherry.de,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dse@thaumatec.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH v2 2/3] arm64: dts: rockchip: add dsi controller nodes on rk3588
Date: Wed, 27 Nov 2024 15:37:18 +0100
Message-ID: <20241127143719.660658-3-heiko@sntech.de>
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

The RK3588 comes with two DSI2 controllers based on a new Synopsis IP.
Add the necessary nodes for them.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index 93d031d8821f..52a5f3005d97 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/clock/rockchip,rk3588-cru.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/phy/phy.h>
 #include <dt-bindings/power/rk3588-power.h>
 #include <dt-bindings/reset/rockchip,rk3588-cru.h>
 #include <dt-bindings/phy/phy.h>
@@ -1418,6 +1419,62 @@ i2s9_8ch: i2s@fddfc000 {
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
+		phys = <&mipidcphy0 PHY_TYPE_DPHY>;
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
+		phys = <&mipidcphy1 PHY_TYPE_DPHY>;
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


