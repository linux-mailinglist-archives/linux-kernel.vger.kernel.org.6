Return-Path: <linux-kernel+bounces-221226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BF390F0B2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F6EEB25818
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508F947A60;
	Wed, 19 Jun 2024 14:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oejyAPu2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F11F1F934
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 14:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807534; cv=none; b=iy/LfpAvk7GYLYSVjwE+aii5jl6N5FDDaNz6W/PCojergcU6vqim1bZGEs67eP0LMORs5WKLEfwj09rdhI7beB2672SXg1/Ob1TumtgACZ/REBotLrpEySXs1GDJGXQMDAyB2m6QhVx4vOknQWiuiddttJrGJlmIjTCtuImC1lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807534; c=relaxed/simple;
	bh=ooFwSoVJ9N3sXdcV4iug2DcGs+ehRHDEPEzbrAfyAEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=isnO2o1OSs58jgUntJdtmylr9F3pkoYbrWjUn79HgHGbAECH7yb1Q/V0WO7R/Vo+eDSz6GSyiFfAIN8t8WCr20pVACWqV2qUyAvVwV0SGD70N8gHiVOAjSoeI5K8qXaLYbKhpn9bd0FfQVhbSNZqiles2zQEbakuXXCSNXmIEu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oejyAPu2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F552C2BBFC;
	Wed, 19 Jun 2024 14:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718807534;
	bh=ooFwSoVJ9N3sXdcV4iug2DcGs+ehRHDEPEzbrAfyAEI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oejyAPu2JXl8kl9zvH+6wmfbH/zgNTpnVQS3xP9/HtTUHm1hVGnEPinDmIXJmqZED
	 OBBiTGv69W2b2W9IdzeWOIuXSLXbCYtJ5A/PNM7T3fwyASyE/Lbe6ndY5BAWbHSYhc
	 HU3FMYPRLlCRoYd1fp1cBAwKPLcFTiM2P7J39TsVH3sdtVwJrIOk2oVrrj06ODPlvo
	 wzQMIzYRHt4Wasst8wG+xBz7259/rN2LfIVe6AJEvPOeifAf1yNTq9l389xChktcYU
	 QA7H65p3zZLyjVg9QusI9fcy2Y5uQBiqKvzc3pKWvtxglIuSOvu18htzyh0jnLo7uI
	 mlBHP5tQn3Ncw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294E5C2BA15;
	Wed, 19 Jun 2024 14:32:14 +0000 (UTC)
From: Hsiao Chien Sung via B4 Relay <devnull+shawn.sung.mediatek.com@kernel.org>
Date: Wed, 19 Jun 2024 22:30:42 +0800
Subject: [PATCH v2 01/14] drm/mediatek: Add missing plane settings when
 async update
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240619-mediatek-drm-next-v2-1-abf68f46f8d2@mediatek.com>
References: <20240619-mediatek-drm-next-v2-0-abf68f46f8d2@mediatek.com>
In-Reply-To: <20240619-mediatek-drm-next-v2-0-abf68f46f8d2@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 CK Hu <ck.hu@mediatek.com>, Bibby Hsieh <bibby.hsieh@mediatek.com>, 
 Daniel Kurtz <djkurtz@chromium.org>, YT Shen <yt.shen@mediatek.com>, 
 Mao Huang <littlecvr@chromium.org>, "Nancy.Lin" <nancy.lin@mediatek.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Hsiao Chien Sung <shawn.sung@mediatek.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718807531; l=1082;
 i=shawn.sung@mediatek.com; s=20240616; h=from:subject:message-id;
 bh=ADiZlSVJT5s2sH18XbsNK2Wsb8sGtAwURKhvCjHjtzc=;
 b=gfNppxTA+mVrfrBvf5D7MJe0paBA2cf2WEfnKLHt5WTwPXCRiUEncV+qSTR2nzFgM60Hr96T1
 tmWaMMjutARD9u9VKIGLeiFj60u/Eayszwxm0DgYRouHJEmN5VHa8tQ
X-Developer-Key: i=shawn.sung@mediatek.com; a=ed25519;
 pk=lq1w8BuWDINX+4JHjGHhhbAU5ICP+cL9VCj7wn+cEDA=
X-Endpoint-Received: by B4 Relay for shawn.sung@mediatek.com/20240616 with
 auth_id=172
X-Original-From: Hsiao Chien Sung <shawn.sung@mediatek.com>
Reply-To: shawn.sung@mediatek.com

From: Hsiao Chien Sung <shawn.sung@mediatek.com>

Fix an issue that plane coordinate was not saved when
calling async update.

Fixes: 920fffcc8912 ("drm/mediatek: update cursors by using async atomic update")

Reviewed-by: CK Hu <ck.hu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_plane.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_plane.c b/drivers/gpu/drm/mediatek/mtk_plane.c
index 4625deb21d40..a74b26d35985 100644
--- a/drivers/gpu/drm/mediatek/mtk_plane.c
+++ b/drivers/gpu/drm/mediatek/mtk_plane.c
@@ -227,6 +227,8 @@ static void mtk_plane_atomic_async_update(struct drm_plane *plane,
 	plane->state->src_y = new_state->src_y;
 	plane->state->src_h = new_state->src_h;
 	plane->state->src_w = new_state->src_w;
+	plane->state->dst.x1 = new_state->dst.x1;
+	plane->state->dst.y1 = new_state->dst.y1;
 
 	mtk_plane_update_new_state(new_state, new_plane_state);
 	swap(plane->state->fb, new_state->fb);

-- 
Git-146)



