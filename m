Return-Path: <linux-kernel+bounces-334095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4A797D28F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A24BB20C89
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB6513A409;
	Fri, 20 Sep 2024 08:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Y/BKataO"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC821311AC;
	Fri, 20 Sep 2024 08:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820528; cv=none; b=iLuLRiMgiZAccCel478i6sKeOb0zneYjfEnNvFYHVg0s8ZFJqDvmO4mmXPz4WlkqoWT5EMR4LH39CLwMjH3hLGX3vwteKLhW3Tq/cTUxvlzz8el6mrPDj1sWlrP6FmddkfjVuUfuPBD/+Mmi2kmmVj0jwd/5FrSoSDtmRxpzZ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820528; c=relaxed/simple;
	bh=2qmbHyqDgpozMZtbVr2bnHgnBVuWqIWsPpUf7E72uJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SV2jlDvjCqCNACAaCxSTOttHXpNyu5xlpC4N+v+TIcnS135Rjvy/HBmM2FyHTYeZgIrC3+q5mULEkWxbFo7W7PRprYa37wSfF3qJ43IG2EKHZVcXmN1WdVAcSNgRmFjxIZLsn4siwnr59ctAJl/umbkVVf5TYysNfrvIbTkKBUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Y/BKataO; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=x6qQR
	zhQ+WwsX3+8y8fTI3CGANuJPV4QqizubWTDtQw=; b=Y/BKataO75IhJ5SZDZYzg
	tE61C9BjjHanvFStHjRJXIFvH+hiAzA7aqCrxWlg8UUnLTiv/6HCE7b+V4Gf/OQg
	mKFpZLLc1ec30TLhEw+lEx5ma20WlgFR19yRrvDFcMOtq89T+2JnHPmCzKt825dL
	P8yJxUduwFPCNtY2XWKbv4=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mta-g2-3 (Coremail) with SMTP id _____wDXJxiNMO1m7rcECA--.53890S2;
	Fri, 20 Sep 2024 16:21:36 +0800 (CST)
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
Subject: [PATCH v3 07/15] drm/rockchip: vop2: Support 32x8 superblock afbc
Date: Fri, 20 Sep 2024 16:21:31 +0800
Message-ID: <20240920082132.6771-1-andyshrk@163.com>
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
X-CM-TRANSID:_____wDXJxiNMO1m7rcECA--.53890S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw17Cr13GF1UAF18Wry3Jwb_yoW5Jr18pr
	W3ZrWqgr4DKF1jqa1DJFZ8ZF45Aan2k3y7XFnrKr1jgryYkrZrWa4qka4UZrWDtrWfGFW0
	vFn7JrW7Zw1Fyr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UKksgUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiMxhgXmbtL08n3AAAsF

From: Andy Yan <andy.yan@rock-chips.com>

This is the only afbc format supported by the upcoming
VOP for rk3576.

Add support for it.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

(no changes since v2)

Changes in v2:
- split it from main patch add support for rk3576

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index a7f9f88869a6..f6a030fd8e55 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1357,16 +1357,18 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 		vop2_win_write(win, VOP2_WIN_AFBC_HALF_BLOCK_EN, half_block_en);
 
 	if (afbc_en) {
-		u32 stride;
+		u32 stride, block_w;
+
+		/* the afbc superblock is 16 x 16 or 32 x 8 */
+		block_w = fb->modifier & AFBC_FORMAT_MOD_BLOCK_SIZE_32x8 ? 32 : 16;
 
-		/* the afbc superblock is 16 x 16 */
 		afbc_format = vop2_convert_afbc_format(fb->format->format);
 
 		/* Enable color transform for YTR */
 		if (fb->modifier & AFBC_FORMAT_MOD_YTR)
 			afbc_format |= (1 << 4);
 
-		afbc_tile_num = ALIGN(actual_w, 16) >> 4;
+		afbc_tile_num = ALIGN(actual_w, block_w) / block_w;
 
 		/*
 		 * AFBC pic_vir_width is count by pixel, this is different
@@ -1377,6 +1379,9 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 			drm_err(vop2->drm, "vp%d %s stride[%d] not 64 pixel aligned\n",
 				vp->id, win->data->name, stride);
 
+		 /* It's for head stride, each head size is 16 byte */
+		stride = ALIGN(stride, block_w) / block_w * 16;
+
 		uv_swap = vop2_afbc_uv_swap(fb->format->format);
 		/*
 		 * This is a workaround for crazy IC design, Cluster
@@ -1407,7 +1412,11 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 		else
 			vop2_win_write(win, VOP2_WIN_AFBC_AUTO_GATING_EN, 1);
 
-		vop2_win_write(win, VOP2_WIN_AFBC_BLOCK_SPLIT_EN, 0);
+		if (fb->modifier & AFBC_FORMAT_MOD_SPLIT)
+			vop2_win_write(win, VOP2_WIN_AFBC_BLOCK_SPLIT_EN, 1);
+		else
+			vop2_win_write(win, VOP2_WIN_AFBC_BLOCK_SPLIT_EN, 0);
+
 		transform_offset = vop2_afbc_transform_offset(pstate, half_block_en);
 		vop2_win_write(win, VOP2_WIN_AFBC_HDR_PTR, yrgb_mst);
 		vop2_win_write(win, VOP2_WIN_AFBC_PIC_SIZE, act_info);
-- 
2.34.1


