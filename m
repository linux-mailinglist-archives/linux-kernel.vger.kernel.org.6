Return-Path: <linux-kernel+bounces-527646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DF0A40DAC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 10:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 586267AA490
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 09:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E66204F6C;
	Sun, 23 Feb 2025 09:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UDWClHbf"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CF82036FE;
	Sun, 23 Feb 2025 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740303166; cv=none; b=Lx6Yhchuz4UFABf1Nap7exdVWxoMQ53SjlbWgA/DUCMdC9S/CAXqH1gJ1bm9Y7AHcVp5MXERKU4u+6PMbHjK1/TfR0Hgu/5CINJYeJFRTHsIgFR05W+4mSjZiprb8+oe7zssAT9rZIvyK1MConEj4jgXBKBHqsqCwyTu1H9OW6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740303166; c=relaxed/simple;
	bh=SE9Nutny/gzjaQ3Hy7tTClTNDcn3VFJaaCAjW0BhTsc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hOr598owGsBfsPy9tgClAPGC60yX3K4T2CJsPllc6Stdo9Cjt1JxPQ8jqqokw/7G369/UomL3fZz5Fr3VXR0ETv3VvNG7j0rTKUXnYrmralVdMtZ5bS2AphAlbYnVELTBYBxmFh/ARXNvnyy/ORh+cFjPT1gv3AECNeyGpPWoII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UDWClHbf; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740303157;
	bh=SE9Nutny/gzjaQ3Hy7tTClTNDcn3VFJaaCAjW0BhTsc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UDWClHbfy2lN7RQStexxDn+njHyDLp5ChxksGKP7Uo4hoN1O9ET9J2nJGyn2kBzOH
	 5ZvtdzIxClimUtlIFtc7X36VbXAc99XC+beTZ3eGOc9GGRl9h3nF6HS7ZiS/S+kHJq
	 RnsmpncGqbWnrtld2L6pHI46l+tEuEiF0EWVrQeoTWVMJuRh6DGIQDyJ5EH1BkE7g6
	 EtIKWEoTkXUZQcqY1Y7kHXN+gaXmkoXg3UguWTu49nFGJqManXvTVCIHK8QMrfFzJT
	 MO4MrEsneQyJIbrEJQ9S3KlMxr/nZqbASNHxs1s1RLKH13F6g6RYKmvauWJ0WT2Dkz
	 Jmd3sdOV8ns6g==
Received: from localhost (unknown [188.27.58.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 2EC4717E0CFA;
	Sun, 23 Feb 2025 10:32:37 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sun, 23 Feb 2025 11:31:40 +0200
Subject: [PATCH v2 4/5] arm64: dts: rockchip: Add HDMI1 PHY PLL clock
 source to VOP2 on RK3588
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250223-vop2-hdmi1-disp-modes-v2-4-f4cec5e06fbe@collabora.com>
References: <20250223-vop2-hdmi1-disp-modes-v2-0-f4cec5e06fbe@collabora.com>
In-Reply-To: <20250223-vop2-hdmi1-disp-modes-v2-0-f4cec5e06fbe@collabora.com>
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


