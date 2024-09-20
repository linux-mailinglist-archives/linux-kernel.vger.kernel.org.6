Return-Path: <linux-kernel+bounces-334105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E383997D2AA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A694C2822CF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8D613C8F9;
	Fri, 20 Sep 2024 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cxlYDHHq"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EC57DA7F;
	Fri, 20 Sep 2024 08:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820605; cv=none; b=MKGyrIaTiQGTz3Uckgq7rNEV0TU435WgIhaDWM37OxkhfkQSQS1Jp6WzYzIJshiFL6dSxpT+5jyZHhsUoVysTbyKbSQ2l9mLO4o2bI6zBvCawdd4jyuBqOO0lIGpIwDzx0puqc8kmC6cIpEgYGRRgc5WaGeYk/t9H5Tt0Y+k74g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820605; c=relaxed/simple;
	bh=ACt1+YihUlgaEx/fQmEz6ytZsrPV98VA/NEP28yauno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ve6koE9wpE5eFObygvcZn/rTKs/gx4dzrwp6TImwPe09xyrAJmBg1R5+myZfTh+wTCjUi/GHV2tIU+XuRlBjV+smogNla9fvWY2gx7u6GCHj8ilQTt++9dUVBroJYX58MhqY4Xg+ZwJ8ctuN+ibNIQYlW/QMqEWyyfd6+RPDGUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cxlYDHHq; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=pssPv
	On+4Ieo8JXCdj0k3N11a+VxA4LtocfM2lHt8OE=; b=cxlYDHHqN6gHPczPCrCzj
	EOIi95Ao05cvnzsQYNhve+gEUMZMrQrBsdIQb7+1b0mWTEA0m/FQba1Ss46vkR+d
	Olo5yinXYBr4FFCEgfsr9EZwAydjyXBUOQzHGt0amzjcPiTyjBrOuCzrAIZA414w
	g7YC6poKQ6BUPVoXiyT4UI=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mta-g3-2 (Coremail) with SMTP id _____wCXDpvcMO1mQpM6KA--.41288S2;
	Fri, 20 Sep 2024 16:22:56 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: hjc@rock-chips.com,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	derek.foreman@collabora.com,
	minhuadotchen@gmail.com,
	detlev.casanova@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v3 13/15] drm/rockchip: vop2: Add uv swap for cluster window
Date: Fri, 20 Sep 2024 16:22:40 +0800
Message-ID: <20240920082251.6952-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920081626.6433-1-andyshrk@163.com>
References: <20240920081626.6433-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXDpvcMO1mQpM6KA--.41288S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFW8Ww1kAF4UAw47JFy7ZFb_yoW8Gr4kpw
	43ZrWqgrW5Kw4Iq34kJFZ8ZFWfCwnxKayxZws7tw109ry3KFyDK3ZIkFWUAr1qya12kF47
	tFn3A3y7Zr1jvrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7fHUUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqRhgXmVODBHm+gABsk

From: Andy Yan <andy.yan@rock-chips.com>

The Cluster windows of upcoming VOP on rk3576 also support
linear YUV support, we need to set uv swap bit for it.

As the VOP2_WIN_UV_SWA register defined on rk3568/rk3588 is
0xffffffff, so this register will not be touched on these
two platforms.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

(no changes since v1)

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 9603bd8491bc..84c67f5d267f 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1284,10 +1284,8 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 
 	rb_swap = vop2_win_rb_swap(fb->format->format);
 	vop2_win_write(win, VOP2_WIN_RB_SWAP, rb_swap);
-	if (!vop2_cluster_window(win)) {
-		uv_swap = vop2_win_uv_swap(fb->format->format);
-		vop2_win_write(win, VOP2_WIN_UV_SWAP, uv_swap);
-	}
+	uv_swap = vop2_win_uv_swap(fb->format->format);
+	vop2_win_write(win, VOP2_WIN_UV_SWAP, uv_swap);
 
 	if (fb->format->is_yuv) {
 		vop2_win_write(win, VOP2_WIN_UV_VIR, DIV_ROUND_UP(fb->pitches[1], 4));
-- 
2.34.1


