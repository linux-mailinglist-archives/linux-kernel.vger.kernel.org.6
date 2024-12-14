Return-Path: <linux-kernel+bounces-445912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C069F1D76
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 09:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BA11168F34
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 08:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB2C191F6F;
	Sat, 14 Dec 2024 08:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="idhw6uHU"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7071C185B48;
	Sat, 14 Dec 2024 08:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734164274; cv=none; b=cgup7qa0uQswm6v+DAeVgqjFAkurC/T9QZYxOJnL6e/ExzL4SbiHvsxCJfH+Tc17sM1Pmied61fkVC1teRpWEtFxbcudQIna5wmRQHDYXWz1ZWM5jjIQSvOc3eGCDU95ts0I8oxDrv2uk1Xm87P8tAGlR1bzpxUXK7htVl4Bj0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734164274; c=relaxed/simple;
	bh=x90FHC5u9ZEwleGDzQlstrdas6slNVuahYQPXmATfr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GxNa1WQyiYYZUaJD4bsCN1ubkR2V68pMdKdMixwYCTPZROeOYmvFoBRtwwoLJSCqBSiskeo9lpQUS65h75D3IMlp9kmMxJty6mv4UUY4t896DdQzjZwpCmmZiLrJTXGTmcqZoyQXQXCmoLDc4CFOnXDUCbEIkmKMWRjXWbMeuv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=idhw6uHU; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=n9kqw
	reHTXNHZZbYtIN60/GfMBmJOUF2KyeKvQKAMa0=; b=idhw6uHUUmTijZr0ixT5x
	RphVd8n3k4EEF2a1H5QjkdByzwL0y1RZiuKLAAUvnyxu5zU3a8jo5a1eUDzzqoMN
	xB97MClCDQrRgD6YrXfksuK1ihgvM6G1H9/XhpKK1KEZm7ldaqXu9fJD47aFtWwK
	k3kN5zqrb2uHOCTQVKB2n4=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3fwEQP11ntNLtAQ--.5686S10;
	Sat, 14 Dec 2024 16:17:31 +0800 (CST)
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
	Andy Yan <andy.yan@rock-chips.com>,
	Michael Riesch <michael.riesch@wolfvision.net>
Subject: [PATCH v6 08/16] drm/rockchip: vop2: Support 32x8 superblock afbc
Date: Sat, 14 Dec 2024 16:17:07 +0800
Message-ID: <20241214081719.3330518-9-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241214081719.3330518-1-andyshrk@163.com>
References: <20241214081719.3330518-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3fwEQP11ntNLtAQ--.5686S10
X-Coremail-Antispam: 1Uf129KBjvJXoWxCrW3XFyUGw4xGFykuryUWrg_yoW5Gryrpr
	W3ZrWqgw4UKF1jqa1DJrWDZF43Aan2k3y7XrnrGr1YqryYkr9rG34DKFyDZrWDt3yfGFW0
	vFn3GrW7Zw1Fyr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8R6wUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqRa1XmddM6y0QgAAsH

From: Andy Yan <andy.yan@rock-chips.com>

This is the only afbc format supported by the upcoming
VOP for rk3576.

Add support for it.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Tested-by: Michael Riesch <michael.riesch@wolfvision.net> # on RK3568
Tested-by: Detlev Casanova <detlev.casanova@collabora.com>

---

(no changes since v2)

Changes in v2:
- split it from main patch add support for rk3576

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index b5f35839d5e8..efe7d0cbe155 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1454,16 +1454,18 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
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
@@ -1474,6 +1476,9 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 			drm_dbg_kms(vop2->drm, "vp%d %s stride[%d] not 64 pixel aligned\n",
 				    vp->id, win->data->name, stride);
 
+		 /* It's for head stride, each head size is 16 byte */
+		stride = ALIGN(stride, block_w) / block_w * 16;
+
 		uv_swap = vop2_afbc_uv_swap(fb->format->format);
 		/*
 		 * This is a workaround for crazy IC design, Cluster
@@ -1504,7 +1509,11 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
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


