Return-Path: <linux-kernel+bounces-437501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657BB9E941A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1140B1664A4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CFC22A1FA;
	Mon,  9 Dec 2024 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JHvJWkD3"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CABD227B98;
	Mon,  9 Dec 2024 12:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747437; cv=none; b=qFyVGWFJDY8r+N/Yt4lKiCdKicV5QOvwUmBBchAohkAKu0BgCjPnT5eDsumhGRru7HxRA+ZJXUBNa+CpPQmvbaTcHCIC2ANtTxveVIznPMJzDe8xH3w+3smLvjaS0fweokvcpnJPHIslwq9m0mOyzNb5TED/axVNDoBxih1d+d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747437; c=relaxed/simple;
	bh=EcteiLvZXkQpXTKFXN1pk2VNfnyjuxNax4jH8HDnX+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JwEnKUiz89jyra1TE/fmcSp8XAIdmcdkZzTsxw8Z3Uj7PlAfRlYUE6ZyiEgMxc4eXs+p+DI74B6sqxRVvtrQTGYFXFUNIkSDHR9ry1lKQ0Wif5S6rt5FCihSyTJq0czgQi0ICXmo43zLLcuTvHwGz87DvUZBBUSsEnmQz1BtLx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JHvJWkD3; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=3FYwu
	3JoLexUk2zE01A1KXdKUzgFzdxQ+q2JuyReUm8=; b=JHvJWkD3LUV1A8dAYCX5V
	FSr4lzXv7kpva+gort6Cpmy/YSh2ZAfXxS4J7cgZZQnAon317cABjRuQ3ZVPve77
	E9EDXEgAgHN7XpsuJWxUnEfjjBLY4gV8NxxAe059IZpS8WGQ+fhggteY56euAilv
	x/Y/gy+x/BZIOFA3R0pcO4=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD3Woe44lZnubZICA--.5849S8;
	Mon, 09 Dec 2024 20:29:55 +0800 (CST)
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
Subject: [PATCH v5 03/18] drm/rockchip: vop2: Fix the mixer alpha setup for layer 0
Date: Mon,  9 Dec 2024 20:29:16 +0800
Message-ID: <20241209122943.2781431-7-andyshrk@163.com>
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
X-CM-TRANSID:PCgvCgD3Woe44lZnubZICA--.5849S8
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF4rXr13WF4kZr45Gw1xZrb_yoWkKFg_C3
	4fWr1fGr1kGFn8Jw1jka1fGFZIyan2kF18Ga1DtFyjyFykZw1xta4rXryxX345CF1rAr9r
	G3W8XryrCFnxujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0aYLDUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqQqwXmdW3c3WHAABsn

From: Andy Yan <andy.yan@rock-chips.com>

The alpha setup should start from the second layer, the current calculation
starts incorrectly from the first layer, a negative offset will be obtained
in the following formula:

offset = (mixer_id + zpos - 1) * 0x10

Fixes: 604be85547ce ("drm/rockchip: Add VOP2 driver")
Tested-by: Derek Foreman <derek.foreman@collabora.com>
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

(no changes since v1)

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index d0b2b881ff07..1f0fa153c62e 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -2459,6 +2459,12 @@ static void vop2_setup_alpha(struct vop2_video_port *vp)
 		struct vop2_win *win = to_vop2_win(plane);
 		int zpos = plane->state->normalized_zpos;
 
+		/*
+		 * Need to configure alpha from second layer.
+		 */
+		if (zpos == 0)
+			continue;
+
 		if (plane->state->pixel_blend_mode == DRM_MODE_BLEND_PREMULTI)
 			premulti_en = 1;
 		else
-- 
2.34.1


