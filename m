Return-Path: <linux-kernel+bounces-515917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12182A36A76
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A2AC1896F4F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FD61FDA9D;
	Sat, 15 Feb 2025 00:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="S2aF9Ehy"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD3C1A304A;
	Sat, 15 Feb 2025 00:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580961; cv=none; b=Rzkrv4an0YY5z+FonZ615PvimLZUFmhk6oGGDvUJW/nInQ6MbDQQevpOl+xtg6RkOfDtvUpzcYdauvv9KdUUr56yfH+4Syt5Q1vqjARxYb4Q1k60WGNgO8wbTHolv5S/jUjhphHmq7nCTxqv52dntQp4y9kf9or9jKrQp/qkU38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580961; c=relaxed/simple;
	bh=SE9Nutny/gzjaQ3Hy7tTClTNDcn3VFJaaCAjW0BhTsc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NBchboEuM+I52Ub9BbcvxB/K0NxW+XXAZv1VlVL1/GrK6BXXGBBJk4NQGRt92LV+XsJqBVARHj5xbXPSRI/sSf+olaDcvb4k1t++7U6BXfO8slOiuEIcCrkDYE/fB2g5nqLX3uf+DGr6FV++ecVoVAfT0sPNGQAZLIPeRNlV7gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=S2aF9Ehy; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739580958;
	bh=SE9Nutny/gzjaQ3Hy7tTClTNDcn3VFJaaCAjW0BhTsc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=S2aF9EhypxIuz+HM/aOb9onCVBBNSj0b4uWLsV0wcZrlDSNMrdTzKJKp6ILTxA1Nv
	 xFb6UzPOJ3HbsU1cWYhoIJpPZ/2k7wI/25AQxMfbuY2+xgbPFjys7BOTM9UVOXXzbX
	 eM2hE67AfxrcBJOw3uBdA5v9SQ+iEBagBPfNIo+YP9cjzsUG+mzd+Hk95ZCIAj02pT
	 TS+xJD9suo7v+Wp4D4nlxLL8htQwPAMkmBillK834miktsl6zlcnfQ+yJLetV9py1W
	 lNgPXLp3PVAJHjmfLXnNIMLBafwLPF1EBvyVnttdEBctCkA6jBegqABXdwYyXBqsH+
	 HAngOoIpYCRbg==
Received: from localhost (144.232.221.87.dynamic.jazztel.es [87.221.232.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id A628B17E0FC1;
	Sat, 15 Feb 2025 01:55:57 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 15 Feb 2025 02:55:39 +0200
Subject: [PATCH 3/4] arm64: dts: rockchip: Add HDMI1 PHY PLL clock source
 to VOP2 on RK3588
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250215-vop2-hdmi1-disp-modes-v1-3-81962a7151d6@collabora.com>
References: <20250215-vop2-hdmi1-disp-modes-v1-0-81962a7151d6@collabora.com>
In-Reply-To: <20250215-vop2-hdmi1-disp-modes-v1-0-81962a7151d6@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

VOP2 on RK3588 is able to use the HDMI PHY PLL as an alternative and
more accurate pixel clock source to improve handling of display modes up
to 4K@60Hz on video ports 0, 1 and 2.

The HDMI1 PHY PLL clock source cannot be added directly to vop node in
rk3588-base.dtsi, along with the HDMI0 related one, because HDMI1 is an
optional feature and its PHY node belongs to a separate (extra) DT file.

Therefore, add the HDMI1 PHY PLL clock source to VOP2 by overwriting its
clocks & clock-names properties in the extra DT file.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi
index 97e55990e0524ed447d182cef416190822bf67be..1df8845bdc264b07601add3747b273f92091e7fa 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi
@@ -542,3 +542,24 @@ pcie30phy: phy@fee80000 {
 		status = "disabled";
 	};
 };
+
+&vop {
+	clocks = <&cru ACLK_VOP>,
+		 <&cru HCLK_VOP>,
+		 <&cru DCLK_VOP0>,
+		 <&cru DCLK_VOP1>,
+		 <&cru DCLK_VOP2>,
+		 <&cru DCLK_VOP3>,
+		 <&cru PCLK_VOP_ROOT>,
+		 <&hdptxphy0>,
+		 <&hdptxphy1>;
+	clock-names = "aclk",
+		      "hclk",
+		      "dclk_vp0",
+		      "dclk_vp1",
+		      "dclk_vp2",
+		      "dclk_vp3",
+		      "pclk_vop",
+		      "pll_hdmiphy0",
+		      "pll_hdmiphy1";
+};

-- 
2.48.1


