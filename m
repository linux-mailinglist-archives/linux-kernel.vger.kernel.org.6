Return-Path: <linux-kernel+bounces-411858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D10C19D007D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 19:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D2C11F233A0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 18:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A0418E050;
	Sat, 16 Nov 2024 18:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HbcYmcuw"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4716F199FA1;
	Sat, 16 Nov 2024 18:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731781374; cv=none; b=N1V087XkiPH5F/G7fnH+8vrssFojtrkjqUjqXuqJrno1GzohdFaT8fPKEn93WY7uWLEjg8jGy70wAUYS7T9AuNcGWBpXnKFTJOtWdueZg9Xc6R9Zu7tFUkJHZEvMwTVksR/zZTozUh7vQxqo9cwhQ7SDZSWRNEUcChM4FFa0Gxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731781374; c=relaxed/simple;
	bh=uXHOo9+TzfRpI5IDnIvDAsLN/tG0WK21O4XtRokY5rA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XQ+GBVUbjNz0yFK6FK9OsD9JBEhzp2baV1WXkm4st8X/0NRn5Jg09mzWcBYoqIZN0N+QtSL0FJnyinjZCz3d9tV7BBDsWBQGoXUcT/CT8cE9+9dovyYHFZT9LupAAOs4VCIDSsuWXoLq4a8uGOpc0nqy9Q0jmpMjn1znCZkLE/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HbcYmcuw; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1731781365;
	bh=uXHOo9+TzfRpI5IDnIvDAsLN/tG0WK21O4XtRokY5rA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HbcYmcuw3KJPwpeen8ioxtv0tN99gDIhC7+J248GqCRUeGsPLf7p0P4AlLJ6NSYoV
	 LDLgkCJU8LE6MGVcKhpTYkLYR0K/GLDlWr7jrpI8mrzM33sOZCkIRyWYgKRlHcmQv9
	 b9r+vejMaaOTjzqjSkVFQPAC2TV9J3VsKiPGt5I+7DQTGG/55G/mtSYcq7bEYWPlCA
	 4dxtZf09hiVqQ+4UQUGa3t2jEzqSKOrQ3gdlJ0frXWs4YrA9wnJOndnFKdX6KM1Q/p
	 m+9nUQYn1s9LzFgM+1AHuyZ+E4BrWgoON2gB1qVGvLa2IbA1ml+o9Smr87sgSt0BKY
	 fndRSwruUh1HA==
Received: from localhost (unknown [86.120.21.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9146917E377E;
	Sat, 16 Nov 2024 19:22:45 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 16 Nov 2024 20:22:36 +0200
Subject: [PATCH 5/5] arm64: dts: rockchip: Add HDMI0 PHY PLL clock source
 to VOP2 on RK3588
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241116-vop2-hdmi0-disp-modes-v1-5-2bca51db4898@collabora.com>
References: <20241116-vop2-hdmi0-disp-modes-v1-0-2bca51db4898@collabora.com>
In-Reply-To: <20241116-vop2-hdmi0-disp-modes-v1-0-2bca51db4898@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

VOP2 on RK3588 is able to use the HDMI PHY PLL as an alternative and
more accurate pixel clock source to improve handling of display modes up
to 4K@60Hz on video ports 0, 1 and 2.

For now only HDMI0 output is supported, hence add the related PLL clock.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index 22462e86f48027ab7c5e270f2fa04df7afcc1d24..d07be2a81f28b4cbfe314992c662d8cfb3d3d344 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -1262,14 +1262,16 @@ vop: vop@fdd90000 {
 			 <&cru DCLK_VOP1>,
 			 <&cru DCLK_VOP2>,
 			 <&cru DCLK_VOP3>,
-			 <&cru PCLK_VOP_ROOT>;
+			 <&cru PCLK_VOP_ROOT>,
+			 <&hdptxphy_hdmi0>;
 		clock-names = "aclk",
 			      "hclk",
 			      "dclk_vp0",
 			      "dclk_vp1",
 			      "dclk_vp2",
 			      "dclk_vp3",
-			      "pclk_vop";
+			      "pclk_vop",
+			      "pll_hdmiphy0";
 		iommus = <&vop_mmu>;
 		power-domains = <&power RK3588_PD_VOP>;
 		rockchip,grf = <&sys_grf>;

-- 
2.47.0


