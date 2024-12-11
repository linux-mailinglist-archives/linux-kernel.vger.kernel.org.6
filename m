Return-Path: <linux-kernel+bounces-441131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 304E59ECA18
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D72C32859D8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BD2211A24;
	Wed, 11 Dec 2024 10:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WUAQeTdI"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E431236FB2;
	Wed, 11 Dec 2024 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733912132; cv=none; b=XvM9VGeYbDnA3waQGpSWtB1Q1y5dglVJVvHhpNj6/QN9pGSBO1TTrJavPMO6DL9feFPCfe88miCCzJgJDyql4uff/6KLLdMd9MhfRhQRkJlqB/qvJl8aTreldCavtzjSzd8Ui7KHWST1lfGfPIYtVal1QMzVJUFWr7lt7vegOkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733912132; c=relaxed/simple;
	bh=MuR2oeRfGbazny81Gg0qjiBQGXd4zaCOkbi5lO6j2Cs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g5o84ce+T1ZMUepa1/9LmJH4wIAG4SxPlupLoiI8te7sZ4olhfB3rpNSfvXCx6Ww2a3vv0kOxHwRGxcFzGha2wJIlznAbJy+EOUEwRaH30/NZwdilkXsGNP3x4vfDl8Tbgev2TFNVk8QgGLcJdI3Oj43iFLKTsTyZ6l2Jh+8wWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WUAQeTdI; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733912128;
	bh=MuR2oeRfGbazny81Gg0qjiBQGXd4zaCOkbi5lO6j2Cs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WUAQeTdInPgpiJzNdemRfTK33tu8MM4biHZJBaKYa17k0RRnmLJ2fcpGFcsn2q4/v
	 E6nxtoCDoxnDS8FJHhnZVibHrMBNDxcA3zh9l7AcjaVYIaDH2BnlhWSBqTuhRp0vPJ
	 PGPPfctSIhu8COXk5drExjddLwKUm93wE+/SzjRcWqEYsq3GFsMbDlr7HpV7W1GPDH
	 E0ppAuFoFmCeqShxvobA1MrLy7z65RQ9EF5L9VKOJnfE0keJ2CuGO3t9A9WW2gmzr+
	 1I+4+d9E5K1r3E3WUYBVVlqRJ5+6yaeLO6JZ50HrO58kHpYF2XriNkn52KAnb/anyJ
	 0D2TBSNeCfoOQ==
Received: from localhost (unknown [188.27.48.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 93C1E17E3600;
	Wed, 11 Dec 2024 11:15:28 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Wed, 11 Dec 2024 12:15:06 +0200
Subject: [PATCH v2 2/5] drm/rockchip: vop2: Drop unnecessary if_pixclk_rate
 computation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-vop2-hdmi0-disp-modes-v2-2-471cf5001e45@collabora.com>
References: <20241211-vop2-hdmi0-disp-modes-v2-0-471cf5001e45@collabora.com>
In-Reply-To: <20241211-vop2-hdmi0-disp-modes-v2-0-471cf5001e45@collabora.com>
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

The if_pixclk_rate variable is not being used outside of the if-block in
rk3588_calc_cru_cfg(), hence move the superfluous assignment from the
first branch to the inner comment-block.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 9873172e3fd331f4457fb70c5416dad7af9e3536..8b2f53ffefdbf1cc8737b3a86e630a03a7fd9348 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1695,8 +1695,8 @@ static unsigned long rk3588_calc_cru_cfg(struct vop2_video_port *vp, int id,
 			K = 2;
 		}
 
-		if_pixclk_rate = (dclk_core_rate << 1) / K;
 		/*
+		 * if_pixclk_rate = (dclk_core_rate << 1) / K;
 		 * if_dclk_rate = dclk_core_rate / K;
 		 * *if_pixclk_div = dclk_rate / if_pixclk_rate;
 		 * *if_dclk_div = dclk_rate / if_dclk_rate;

-- 
2.47.0


