Return-Path: <linux-kernel+bounces-440488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F27C99EBEFE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 00:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5C971887DFA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 23:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732F8211282;
	Tue, 10 Dec 2024 23:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DMkHw+RP"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A042451EF;
	Tue, 10 Dec 2024 23:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733872036; cv=none; b=fHClkHdgkVlERcjlK9J5hfScyXAEFtZG2ueySH5Yeacc0N5+erpw3Kw5OhMcuvjQu0QJfQ++bliwqi5Rn3d5YjhbeNdnMetHDBu8y30F0MQuf3TikDfJ70N4OaAg7lCxBLN4mOZ4UAn1NTlfg/x2bGXQAy0Gv3xe5s0drFDRt5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733872036; c=relaxed/simple;
	bh=DuquKXFrrFxNB+/27gdv/HCQ8M7uGVTRTKsJMPlOXKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g6ILh6PI/YcSudNXjyoUg0e2XlrQfGnEzprnoWXE/5Dh0hAF9zS0ExT04oaSZ8fn5Ij0nBrojE61Eele9UGR7dGogLjsEgNJAFpiIZhm/yRBk2OwVyS+4v58xrZDTtF3HnzlyOJB2Vm19GbZa1xkqAE13UtqgSilJrfkM2HLLLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DMkHw+RP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733872033;
	bh=DuquKXFrrFxNB+/27gdv/HCQ8M7uGVTRTKsJMPlOXKI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DMkHw+RPR534EjfaNihm7yVqwmAFsllI1aJJNjZEwR9oiOdaYNkJQBmEkL88Mz9/e
	 gHMrUkaHZ3gvxBVRJWR1mmcPktW/yNJwS6pv4ywz8nGYr2MrCY5cAiViUwKRMEpmv6
	 sCp1MuI017fimXj3IlhUvjuUlx0CEXHFO16WtKzWMD82POHnxsIGFdSmypDRqZKota
	 dV2qT4RK81l5AYaaNvC01NJsliTemLyunZb367hCukiJUcuorGtovQ5nFNLdQh529w
	 bF0kHhJDgB48P/2+MEBEdjKVx2QLhbQ+zlKRSjluk18KnUHfs0c49zEj2yq2rZrXc7
	 +ToK1TUyyWM/Q==
Received: from localhost (unknown [188.27.48.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 143C417E09C0;
	Wed, 11 Dec 2024 00:07:13 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Wed, 11 Dec 2024 01:06:15 +0200
Subject: [PATCH v2 2/4] arm64: dts: rockchip: Add PHY node for HDMI1 TX
 port on RK3588
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-rk3588-hdmi1-v2-2-02cdca22ff68@collabora.com>
References: <20241211-rk3588-hdmi1-v2-0-02cdca22ff68@collabora.com>
In-Reply-To: <20241211-rk3588-hdmi1-v2-0-02cdca22ff68@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Alexandre ARNOUD <aarnoud@me.com>, kernel@collabora.com, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

In preparation to enable the second HDMI output port found on RK3588
SoC, add the related PHY node.  This requires a GRF, hence add the
dependent node as well.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi
index 0ce0934ec6b793af45585f67d5312434d80357de..68fa9806164776cef8732bb776e958003779ba28 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi
@@ -67,6 +67,11 @@ u2phy1_otg: otg-port {
 		};
 	};
 
+	hdptxphy1_grf: syscon@fd5e4000 {
+		compatible = "rockchip,rk3588-hdptxphy-grf", "syscon";
+		reg = <0x0 0xfd5e4000 0x0 0x100>;
+	};
+
 	i2s8_8ch: i2s@fddc8000 {
 		compatible = "rockchip,rk3588-i2s-tdm";
 		reg = <0x0 0xfddc8000 0x0 0x1000>;
@@ -395,6 +400,22 @@ sata-port@0 {
 		};
 	};
 
+	hdptxphy1: phy@fed70000 {
+		compatible = "rockchip,rk3588-hdptx-phy";
+		reg = <0x0 0xfed70000 0x0 0x2000>;
+		clocks = <&cru CLK_USB2PHY_HDPTXRXPHY_REF>, <&cru PCLK_HDPTX1>;
+		clock-names = "ref", "apb";
+		#phy-cells = <0>;
+		resets = <&cru SRST_HDPTX1>, <&cru SRST_P_HDPTX1>,
+			 <&cru SRST_HDPTX1_INIT>, <&cru SRST_HDPTX1_CMN>,
+			 <&cru SRST_HDPTX1_LANE>, <&cru SRST_HDPTX1_ROPLL>,
+			 <&cru SRST_HDPTX1_LCPLL>;
+		reset-names = "phy", "apb", "init", "cmn", "lane", "ropll",
+			      "lcpll";
+		rockchip,grf = <&hdptxphy1_grf>;
+		status = "disabled";
+	};
+
 	usbdp_phy1: phy@fed90000 {
 		compatible = "rockchip,rk3588-usbdp-phy";
 		reg = <0x0 0xfed90000 0x0 0x10000>;

-- 
2.47.0


