Return-Path: <linux-kernel+bounces-384390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8659B297D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6612BB20CDD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965EE1922F9;
	Mon, 28 Oct 2024 07:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="O3ZDwoOa"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A442191F84
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730101332; cv=none; b=GY5adPYB77bo9q/ofscka/Ub7Rimoqcuqi549lIn5tIq90D5449VSOjPfKIzxKT9CmKx86umOqFX8x95PoOx05Q4kEMjVfflyR3i/k3ZcXw92hSQUVkXI7vodNW/etgYD41ZJ/XVADF5+5zlGVlsYGT3g4nHqELScQERUAZ36gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730101332; c=relaxed/simple;
	bh=lvpf4L9Rqv+7xoDBIQvnbk1TRjftRLEPcDgj/WlrS6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lLk6TrdnbdEL7rXoS/0XIJCIf7+GXx1RQQpUX5wK68POcMwN4FIT5kmFOD8K0ByV/rPMEctf80qrHrk/XM4cij1BHW0pMLlyi/L2/4rwvuHxWlbPSF2d+zbuXL/Xcl9Y9ZWyC6Jjojs04uuCLIGgjl1PFHm1NiGeZOQa43T5Y+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=O3ZDwoOa; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=ReNNa
	/bjIUuQfNRlBiXhYY/+3u8nvvMSOrGOZBdjHB0=; b=O3ZDwoOajOf3TPWHJlXlb
	DnNxqlYO2fv0gRHOTg8W7dd/MUwDJwX1SFnWeH23dqRvT4GFRdXh3VWdWKT9UcgB
	99EIr0BQe71NtFKty3glh2L9IFl5Pbo2YJxok4mrk0+ne3vmNOI9I799m1h3T0nC
	jaaC+8sE4A5ZcXYto9eRP0=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnr6c1QB9nigGjDg--.909S2;
	Mon, 28 Oct 2024 15:41:44 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: hjc@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH] drm/rockchip: vop2: Don't spam logs in atomic update
Date: Mon, 28 Oct 2024 15:41:34 +0800
Message-ID: <20241028074140.382199-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnr6c1QB9nigGjDg--.909S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw13Gr1xCw4kAr4rZFyUGFg_yoW5WFW8pF
	y7CF909r4Utr4qga47JrZxZr43K392ka4xtF4xW3W7K343trn7JrsxGF4xJrWYvF48u34U
	AFn8J34Y9a4xZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j-SdgUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0gyGXmcfN0LRQQAAsb

From: Andy Yan <andy.yan@rock-chips.com>

Demote the error message to drm_dbg_kms to only print the message
if the respective debug messages are enabled.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 5c5459ee03076..e75b027674869 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1373,8 +1373,9 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 	dsp_w = drm_rect_width(dest);
 
 	if (dest->x1 + dsp_w > adjusted_mode->hdisplay) {
-		drm_err(vop2->drm, "vp%d %s dest->x1[%d] + dsp_w[%d] exceed mode hdisplay[%d]\n",
-			vp->id, win->data->name, dest->x1, dsp_w, adjusted_mode->hdisplay);
+		drm_dbg_kms(vop2->drm,
+			    "vp%d %s dest->x1[%d] + dsp_w[%d] exceed mode hdisplay[%d]\n",
+			    vp->id, win->data->name, dest->x1, dsp_w, adjusted_mode->hdisplay);
 		dsp_w = adjusted_mode->hdisplay - dest->x1;
 		if (dsp_w < 4)
 			dsp_w = 4;
@@ -1384,8 +1385,9 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 	dsp_h = drm_rect_height(dest);
 
 	if (dest->y1 + dsp_h > adjusted_mode->vdisplay) {
-		drm_err(vop2->drm, "vp%d %s dest->y1[%d] + dsp_h[%d] exceed mode vdisplay[%d]\n",
-			vp->id, win->data->name, dest->y1, dsp_h, adjusted_mode->vdisplay);
+		drm_dbg_kms(vop2->drm,
+			    "vp%d %s dest->y1[%d] + dsp_h[%d] exceed mode vdisplay[%d]\n",
+			    vp->id, win->data->name, dest->y1, dsp_h, adjusted_mode->vdisplay);
 		dsp_h = adjusted_mode->vdisplay - dest->y1;
 		if (dsp_h < 4)
 			dsp_h = 4;
@@ -1398,14 +1400,14 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 	 */
 	if (!(win->data->feature & WIN_FEATURE_AFBDC)) {
 		if (actual_w > dsp_w && (actual_w & 0xf) == 1) {
-			drm_err(vop2->drm, "vp%d %s act_w[%d] MODE 16 == 1\n",
+			drm_dbg_kms(vop2->drm, "vp%d %s act_w[%d] MODE 16 == 1\n",
 				vp->id, win->data->name, actual_w);
 			actual_w -= 1;
 		}
 	}
 
 	if (afbc_en && actual_w % 4) {
-		drm_err(vop2->drm, "vp%d %s actual_w[%d] not 4 pixel aligned\n",
+		drm_dbg_kms(vop2->drm, "vp%d %s actual_w[%d] not 4 pixel aligned\n",
 			vp->id, win->data->name, actual_w);
 		actual_w = ALIGN_DOWN(actual_w, 4);
 	}
@@ -1443,7 +1445,7 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 		 */
 		stride = (fb->pitches[0] << 3) / bpp;
 		if ((stride & 0x3f) && (xmirror || rotate_90 || rotate_270))
-			drm_err(vop2->drm, "vp%d %s stride[%d] not 64 pixel aligned\n",
+			drm_dbg_kms(vop2->drm, "vp%d %s stride[%d] not 64 pixel aligned\n",
 				vp->id, win->data->name, stride);
 
 		uv_swap = vop2_afbc_uv_swap(fb->format->format);
-- 
2.34.1


