Return-Path: <linux-kernel+bounces-565543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B8BA66A58
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 183A47AADA0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148B11DE3A5;
	Tue, 18 Mar 2025 06:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QCzYi/YY"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDC41B4121
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742278877; cv=none; b=kPWB2D2JaK2HgV88PTgqOdJQGulDmv4cSrXe40yii5lwsVfn+Ux14ycSwXPJzWR2wSYCTgbSQznjpQ/KOwxcJPmvObQNEoHHTnCIGOge8iPaxUELUv+tpnGWz2yHgy1+GKIMrG4/RkNzs7mYOnNVx/gRVEokZkkyl1GVZrfRamk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742278877; c=relaxed/simple;
	bh=Nj5xrxNcNHFVrVkbgJKcUisCl89+Oy6+AgspMjcVIkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h5YJGE9ksS0sUy4V5KEGHVrizURSPULJGZ/gDvQW5UHJ91P9FDL6k9hx9kvrZr/CQLhYAUnfaVk3z/3tyHtWjLrZmgd4+K94xTYfl7TkpSMJh0hIlcvCEcTCYvPc9DE2AGDgyyAvUQ5GhKiSjWZFE4VQGQ+fGqDmCuqmtr70+a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QCzYi/YY; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=JeIAn
	ytvxe2YyCl42o/5nXwhjEdd0ZygLFlQfAIddWE=; b=QCzYi/YYsE3GHKZoE6oVc
	IhOAsmnobcdTUX6LNC2eQjxgTydY8WpgbYLrol1/1ByB3GAQdfk6y1YfWnAe6+WK
	JAklvx6E527Mvfq5tOcjPg2ZEgiuT53wOuzYKZhc/DN01lI64JW7ydfC/nzjGBHs
	CmuhsORUMTahDNftYWcEls=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3_+qpENlnvx6pAA--.16708S2;
	Tue, 18 Mar 2025 14:20:29 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: hjc@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	derek.foreman@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH] drm/rockchip: vop2: Make overlay layer select register configuration take effect by vsync
Date: Tue, 18 Mar 2025 14:20:17 +0800
Message-ID: <20250318062024.4555-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_+qpENlnvx6pAA--.16708S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw1kWw1rAr4UJF48JFy3twb_yoW8ZF43pr
	nxAry2gFZ2kF4qqrnF9F98Zr1fJwsFya1fKF9akasruas2yw1DWwnxuas8ArsxJr17Ar4j
	k39xJrW5AF42vr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jx_-PUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0gQUXmfZEI4ElgAAsu

From: Andy Yan <andy.yan@rock-chips.com>

Because the layer/window enable/disable is take effect by vsync, if the
overlay configuration of these layers does not follow vsync and
takes effect immediately instead, when multiple layers are dynamically
enable/disable, inconsistent display contents may be seen on the screen.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h | 1 +
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
index 680bedbb770e..fc3ecb9fcd95 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
@@ -710,6 +710,7 @@ enum dst_factor_mode {
 
 #define VOP2_COLOR_KEY_MASK				BIT(31)
 
+#define RK3568_OVL_CTRL__LAYERSEL_REGDONE_SEL		GENMASK(31, 30)
 #define RK3568_OVL_CTRL__LAYERSEL_REGDONE_IMD		BIT(28)
 #define RK3568_OVL_CTRL__YUV_MODE(vp)			BIT(vp)
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
index 0a2840cbe8e2..32c4ed685739 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
@@ -2070,7 +2070,10 @@ static void rk3568_vop2_setup_layer_mixer(struct vop2_video_port *vp)
 	struct rockchip_crtc_state *vcstate = to_rockchip_crtc_state(vp->crtc.state);
 
 	ovl_ctrl = vop2_readl(vop2, RK3568_OVL_CTRL);
-	ovl_ctrl |= RK3568_OVL_CTRL__LAYERSEL_REGDONE_IMD;
+	ovl_ctrl &= ~RK3568_OVL_CTRL__LAYERSEL_REGDONE_IMD;
+	ovl_ctrl &= ~RK3568_OVL_CTRL__LAYERSEL_REGDONE_SEL;
+	ovl_ctrl |= FIELD_PREP(RK3568_OVL_CTRL__LAYERSEL_REGDONE_SEL, vp->id);
+
 	if (vcstate->yuv_overlay)
 		ovl_ctrl |= RK3568_OVL_CTRL__YUV_MODE(vp->id);
 	else
-- 
2.43.0


