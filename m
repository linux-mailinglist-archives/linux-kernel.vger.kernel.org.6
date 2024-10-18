Return-Path: <linux-kernel+bounces-371902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A98A39A41FD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72425283B49
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56605200B93;
	Fri, 18 Oct 2024 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTsLzh6l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A423D2746B
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729264222; cv=none; b=T9lKMudPkpR8fJEPJJa4bmm4EKBeKS8hN0HOjXEJVATbFwrP7Lc8LLi2fqWEOkw9DWafTUOIIysazIB/25SKGNdK1fp1tVYKTtfyzNtG3md3aH46nafioH8DbOoKqHaYitvgXTiNqP+wmkeHB/dRQneKeuPhzQyZvQlNCRDJnYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729264222; c=relaxed/simple;
	bh=1PJEXr3kEPCQZZ5V+Hy5FS8SkVqvabwVcmhCAPX1iOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AtNCr9DchMKNS/ID9B0mbr/DrMoU4qoXQpR/B6/VQvT3ma7OCpnUMTyaZV+gTfoKRsu8taOUliJvdCF111InCYCdKzn+/KF+Z1GUAD/vjAyuglnEqc9MQ+hhnRi4VXJSrYUrY3f4c+bowbowbWbgvGUbeP2AbVOm4HltZHhU+aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTsLzh6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FA7C4CEC3;
	Fri, 18 Oct 2024 15:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729264222;
	bh=1PJEXr3kEPCQZZ5V+Hy5FS8SkVqvabwVcmhCAPX1iOQ=;
	h=From:To:Cc:Subject:Date:From;
	b=QTsLzh6lThzlelfZBn/cIWOm1pUUnVUt4PEgpXo6zcTOjv7CgYPjb979ht52ZkEwY
	 oYEq8dlQK+JvichsF/8JBqw1yXlpH8EngGrGEG2gb0SKoKCHRmGjtBJyd2Mxu5psRj
	 J1hYFJaT41xlRHJH+8Sz3ibTLpBEteYzOXaz3fiIH5fs4PN1pE4XnQgeHft2pQiNkH
	 jcz5w/I8o6EFgpHSBWzoH9wvoPcwNokJxYvYITsksrU3yFhDPiyu8bjKvdlx7oClds
	 GEqxnMcPj5e/Pt7/k/ZlK4qtptReFNQtcQ3WuU0InCF4klTC9nNGerwH2R/8LhDdn4
	 +K6SEWbKYMA0Q==
From: Arnd Bergmann <arnd@kernel.org>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Algea Cao <algea.cao@rock-chips.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/rockchip: avoid 64-bit division
Date: Fri, 18 Oct 2024 15:10:10 +0000
Message-Id: <20241018151016.3496613-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Dividing a 64-bit integer prevents building this for 32-bit targets:

ERROR: modpost: "__aeabi_uldivmod" [drivers/gpu/drm/rockchip/rockchipdrm.ko] undefined!

As this function is not performance criticial, just Use the div_u64() helper.

Fixes: 128a9bf8ace2 ("drm/rockchip: Add basic RK3588 HDMI output support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
index 9c796ee4c303..c8b362cc2b95 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -82,7 +82,7 @@ static void dw_hdmi_qp_rockchip_encoder_enable(struct drm_encoder *encoder)
 		 * comment in rk_hdptx_phy_power_on() from
 		 * drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
 		 */
-		phy_set_bus_width(hdmi->phy, rate / 100);
+		phy_set_bus_width(hdmi->phy, div_u64(rate, 100));
 	}
 }
 
-- 
2.39.5


