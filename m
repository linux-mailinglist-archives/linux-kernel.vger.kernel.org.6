Return-Path: <linux-kernel+bounces-515916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A122DA36A74
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 739D43A76FC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EBC1FCFCB;
	Sat, 15 Feb 2025 00:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DXg2dQg3"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428911A23AA;
	Sat, 15 Feb 2025 00:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580960; cv=none; b=ABspxXIhfu6ICxo+q5QcUNvXy1Yb/9oN6jc4zRfupuZ3sJpqrXIOdn3DPzY5kKy41JCy9spHz/PqFSuRJlJnny5gzok4MeJzEtq9GaQpyFuAGAt6Q4UiXzcv8qjGfFZQ/LEODHEP+IIhCUYSgZEKNSNA8jUCgZz64M7nIotB6CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580960; c=relaxed/simple;
	bh=MLcedUWBkgkxVWzbTDCOp0QOw7S68POvgln+Xwcmv1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CyiiByU5b/74wpH3cDZMalB5K9Ba3mYZn94FVJbunqP2lTHMNQ539YhXX1Ezi0zcRNErQTYegArV4vYVscRI2JuNOGIIbbQ3G2I1fQkgMDXQT0vvlbi9NOd3/XH4EPFqYly3DE3D1XrLQcXpbiXhgyi/Y0YlW6PEyTgmnC9iXT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DXg2dQg3; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739580956;
	bh=MLcedUWBkgkxVWzbTDCOp0QOw7S68POvgln+Xwcmv1I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DXg2dQg3MG/904U+ETV8QkQ6q5k5cPYok47HVEkyQkeKso7F7pLb3cCAQ2klpxkG/
	 daW5nCLdXVmjqD1om9qxWTPcwhzJsRjHvHeruTji6ExRJcjlmUTfnKjjz8/4RrdjG4
	 7l3qXsctRvkD/hNMihjXYCE7pu6LeNXuSoHJPSHNl8iT/5zeVz+N2qNGVDgmioRhMC
	 Qo5XpGoQKsjPGRhPbDNCcndIn8V1c97bgc8nTfcQM331pg+DxZ0VqboiiKcF31Kf+/
	 vUmRzlbNzcxfmacJ8LENhyOM+ynNHrxmAS6iBfbp8AomyYo0o6dKgozVbM0HZptpHN
	 MMzty5Y97z8Iw==
Received: from localhost (144.232.221.87.dynamic.jazztel.es [87.221.232.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 2D35017E0FBA;
	Sat, 15 Feb 2025 01:55:56 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 15 Feb 2025 02:55:38 +0200
Subject: [PATCH 2/4] arm64: dts: rockchip: Enable HDMI1 PHY clk provider on
 RK3588
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250215-vop2-hdmi1-disp-modes-v1-2-81962a7151d6@collabora.com>
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

Since commit c4b09c562086 ("phy: phy-rockchip-samsung-hdptx: Add clock
provider support"), the HDMI PHY PLL can be used as an alternative and
more accurate pixel clock source for VOP2 to improve display modes
handling on RK3588 SoC.

Add the missing #clock-cells property to allow using the clock provider
functionality of HDMI1 PHY.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi
index 9bc5287bb6469138c2d9e2fcfec7984c830c2ce5..97e55990e0524ed447d182cef416190822bf67be 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi
@@ -479,6 +479,7 @@ hdptxphy1: phy@fed70000 {
 		reg = <0x0 0xfed70000 0x0 0x2000>;
 		clocks = <&cru CLK_USB2PHY_HDPTXRXPHY_REF>, <&cru PCLK_HDPTX1>;
 		clock-names = "ref", "apb";
+		#clock-cells = <0>;
 		#phy-cells = <0>;
 		resets = <&cru SRST_HDPTX1>, <&cru SRST_P_HDPTX1>,
 			 <&cru SRST_HDPTX1_INIT>, <&cru SRST_HDPTX1_CMN>,

-- 
2.48.1


