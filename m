Return-Path: <linux-kernel+bounces-437492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC24C9E9408
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D753D1887A0D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629CB226ED7;
	Mon,  9 Dec 2024 12:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="B0G1QN62"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5766E12D758;
	Mon,  9 Dec 2024 12:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747431; cv=none; b=q06jpelGUwG88NRZN1FZhgdsG6cSE6stCbbno1w2M5oFcd2uAwjNysohzfFwT+CE2genRXnxqX/a2WckuRDySowPtLjZ5Krj7Or/8msZBWPI7xC1jDyukxJNnztI1WPsmCP/XlaaK0zk+Ge+/sLjjagOeATrKfPX+FyXaC+c5pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747431; c=relaxed/simple;
	bh=2tP7RyqGJKqTQtooNWeU/Fz9zRukhNlpMCG0SOynVkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LqvG5F+khBGCo8gXk8TCFiDD2YDrB9t+RBoBJYhpLrenMISIdQlx9Bocw0rEZIAg3n83o5FpQFcc3SkWlpksx/FE6sjA4cbwx5UhBSnarwlBDX5IO/Mu4HrWubgiqDuyBRAu5B0i3RAS3SZI2ImfDhad0tEdNpMHUSKNGL1ph0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=B0G1QN62; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=7X6o0
	hpzj2530qDO1Llbx05J6NTctHz1/3MyYnTP84U=; b=B0G1QN62PrVfCuzlO4ilx
	UfQvObXYIcHzTqcufrmCp70HvxRHAQwQ0TvyOQcZ56Jbd9XFe3+1CeBOfFu4dw5g
	0uzsFWeTA9csdet55GFzKx8ij2ILJ/GFh1uSplFd4S5Fy7pWnnFVg9/vuosAjMmT
	0zaLucOAZp7wE79BJ7X+BQ=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD3Woe44lZnubZICA--.5849S12;
	Mon, 09 Dec 2024 20:29:58 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: hjc@rock-chips.com,
	krzk+dt@kernel.org,
	s.hauer@pengutronix.de,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	derek.foreman@collabora.com,
	detlev.casanova@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v5 07/18] drm/rockchip: vop2: Check linear format for Cluster windows on rk3566/8
Date: Mon,  9 Dec 2024 20:29:20 +0800
Message-ID: <20241209122943.2781431-11-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241209122943.2781431-1-andyshrk@163.com>
References: <20241209122943.2781431-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgD3Woe44lZnubZICA--.5849S12
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr4kKw1ktFWfAFWkXw1rXrb_yoW8Ar45pF
	ZrCrZ0gr4UGrWjgr97JrsxCr4akwn2kay7Jrn3Gw13tFyxtr1DJwn8CF97Cr43Ary7C342
	yF1ftryDWFW2vr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jsa9-UUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqQuwXmdW3c3W3QAAsm

From: Andy Yan <andy.yan@rock-chips.com>

The Cluster windows on rk3566/8 only support afbc mode.

Fixes: 604be85547ce ("drm/rockchip: Add VOP2 driver")
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

Changes in v5:
- Added in V5

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index d7ddeec27c7d..bd8db45eeba6 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1165,6 +1165,7 @@ static int vop2_plane_atomic_check(struct drm_plane *plane,
 	struct vop2_video_port *vp;
 	struct vop2 *vop2;
 	const struct vop2_data *vop2_data;
+	struct vop2_win *win;
 	struct drm_rect *dest = &pstate->dst;
 	struct drm_rect *src = &pstate->src;
 	int min_scale = FRAC_16_16(1, 8);
@@ -1178,6 +1179,7 @@ static int vop2_plane_atomic_check(struct drm_plane *plane,
 	vp = to_vop2_video_port(crtc);
 	vop2 = vp->vop2;
 	vop2_data = vop2->data;
+	win = to_vop2_win(plane);
 
 	cstate = drm_atomic_get_existing_crtc_state(pstate->state, crtc);
 	if (WARN_ON(!cstate))
@@ -1215,6 +1217,16 @@ static int vop2_plane_atomic_check(struct drm_plane *plane,
 		return -EINVAL;
 	}
 
+	if (vop2->data->soc_id == 3568 || vop2->data->soc_id == 3566) {
+		if (vop2_cluster_window(win)) {
+			if (!rockchip_afbc(plane, fb->modifier)) {
+				drm_err(vop2->drm, "Unsupported linear format for %s\n", win->data->name);
+				return -EINVAL;
+			}
+		}
+
+	}
+
 	/*
 	 * Src.x1 can be odd when do clip, but yuv plane start point
 	 * need align with 2 pixel.
-- 
2.34.1


