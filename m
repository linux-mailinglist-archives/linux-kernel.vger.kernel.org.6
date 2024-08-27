Return-Path: <linux-kernel+bounces-303586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C665960F45
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F912835A9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38C71CE6F9;
	Tue, 27 Aug 2024 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LT/LDSBV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D643A1CDFAD
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770561; cv=none; b=dfO0+dpyo2ATVyF7cou5YN+GtNcmhg5YA3TMPcxN925pWqvQtlqL/HwOvE5NxvBjleYSyQZGiRzjVfkto6WQsrqcaWP/cH6hE60Nwm/SfPE8t8nqj6XpD6b3Q2E2g9gZlkyiaBCo2mq3y93yaots6olPj9F1FircQTZWN4U+6O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770561; c=relaxed/simple;
	bh=xz/UXWEcxepYKNcKplNKWh6SZMhniiI0hGFc+cpA380=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BPA8eU+FQB8HyhJOuvZVtnoi8AhCKrOpiuHvifckMDFdglmd53s4BuLqtnMC/EbMhKdYuacJQ1fIZ0ItOZ0LdiVzdjqk1Q0prqxU9X7toRzwNY2F7EKyx0C+WrK06s7Jn8K3I85+3w5XxWAZM1DrbwfnTk6n/az04LeStvFeDXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LT/LDSBV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79CC4C4FDFD;
	Tue, 27 Aug 2024 14:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724770560;
	bh=xz/UXWEcxepYKNcKplNKWh6SZMhniiI0hGFc+cpA380=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LT/LDSBVgHCmFK5RVM4E1LVtG4IfiFWhKylo/7npYwn6ZRRh+wSqrF01UtglUvr+8
	 fL0Xn5wzbEf0zfJjBHsWWNHjafpdFrRk5x1QOTyHCh6EKUpQyfY8jiFoxxxo1K5eVv
	 4ui18Zu1hRq+BMsU1X2iwGC5dMwd/Z2mAIY8VuG3zpdBaNFcSpb0I7Irqr/a5Dml0q
	 uvdN05ISO/59QecsCeT1v/uvxmkp1RZNE1b/Xkyojry+6jOvN4lsSeuUifr53wQUb3
	 XS/akLEcLPp6s9i7hw1EZIcf5aeFbchpkxeKjyc9Z7/VGY6+P3EeJWGcKqr/tf1qEx
	 opVe0a51VpKsg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB42C54734;
	Tue, 27 Aug 2024 14:56:00 +0000 (UTC)
From: "Jason-JH.Lin via B4 Relay" <devnull+jason-jh.lin.mediatek.com@kernel.org>
Date: Tue, 27 Aug 2024 22:55:20 +0800
Subject: [PATCH v3 2/2] drm/mediatek: change config_lock from spin_lock to
 spin_lock_irqsave
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-drm-fixup-0819-v3-2-4761005211ec@mediatek.com>
References: <20240827-drm-fixup-0819-v3-0-4761005211ec@mediatek.com>
In-Reply-To: <20240827-drm-fixup-0819-v3-0-4761005211ec@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Singo Chang <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>, 
 "Jason-JH.Lin" <jason-jh.lin@mediatek.com>, 
 Project_Global_Chrome_Upstream_Group@mediatek.com, 
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724770559; l=3389;
 i=jason-jh.lin@mediatek.com; s=20240718; h=from:subject:message-id;
 bh=qmIEDrv7vEydnkYLajQteZQg7GKHc0xz1SItk+ixJMg=;
 b=BMUDPPx43HxuqLgPxE38r9SfCUMKzAyjGAJfDPSQ8Fp8MAR5/tJSt8tP35PMgK/0E70FFaATs
 XMmR4p7wiooD3Dn/qzlUeXxxFLuDK7Kd7rIrAvazmTQhyF3ZtSK5qKg
X-Developer-Key: i=jason-jh.lin@mediatek.com; a=ed25519;
 pk=7Hn+BnFBlPrluT5ks5tKVWb3f7O/bMBs6qEemVJwqOo=
X-Endpoint-Received: by B4 Relay for jason-jh.lin@mediatek.com/20240718
 with auth_id=187
X-Original-From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Reply-To: jason-jh.lin@mediatek.com

From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>

Operations within spin_locks are limited to fast memory access and
confirmation of minimum lock duration.

Although using spin_lock with config_lock seems to ensure shorter hold
times, it is safer to use spin_lock_irqsave due to potential deadlocks
and nested interrupt scenarios in interrupt contexts.

So change config_lock from spin_lock to spin_lock_irqsave.

Fixes: 7f82d9c43879 ("drm/mediatek: Clear pending flag when cmdq packet is done")
Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_crtc.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediatek/mtk_crtc.c
index b752c0b46383..d7f0926f896d 100644
--- a/drivers/gpu/drm/mediatek/mtk_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
@@ -108,14 +108,16 @@ static void mtk_crtc_finish_page_flip(struct mtk_crtc *mtk_crtc)
 
 static void mtk_drm_finish_page_flip(struct mtk_crtc *mtk_crtc)
 {
+	unsigned long flags;
+
 	drm_crtc_handle_vblank(&mtk_crtc->base);
 
-	spin_lock(&mtk_crtc->config_lock);
+	spin_lock_irqsave(&mtk_crtc->config_lock, flags);
 	if (!mtk_crtc->config_updating && mtk_crtc->pending_needs_vblank) {
 		mtk_crtc_finish_page_flip(mtk_crtc);
 		mtk_crtc->pending_needs_vblank = false;
 	}
-	spin_unlock(&mtk_crtc->config_lock);
+	spin_unlock_irqrestore(&mtk_crtc->config_lock, flags);
 }
 
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
@@ -313,16 +315,16 @@ static void ddp_cmdq_cb(struct mbox_client *cl, void *mssg)
 	struct mtk_crtc *mtk_crtc = container_of(cmdq_cl, struct mtk_crtc, cmdq_client);
 	struct mtk_crtc_state *state;
 	unsigned int i;
+	unsigned long flags;
 
 	if (data->sta < 0)
 		return;
 
 	state = to_mtk_crtc_state(mtk_crtc->base.state);
 
-	spin_lock(&mtk_crtc->config_lock);
-
+	spin_lock_irqsave(&mtk_crtc->config_lock, flags);
 	if (mtk_crtc->config_updating) {
-		spin_unlock(&mtk_crtc->config_lock);
+		spin_unlock_irqrestore(&mtk_crtc->config_lock, flags);
 		goto ddp_cmdq_cb_out;
 	}
 
@@ -352,7 +354,7 @@ static void ddp_cmdq_cb(struct mbox_client *cl, void *mssg)
 		mtk_crtc->pending_async_planes = false;
 	}
 
-	spin_unlock(&mtk_crtc->config_lock);
+	spin_unlock_irqrestore(&mtk_crtc->config_lock, flags);
 
 ddp_cmdq_cb_out:
 
@@ -585,12 +587,13 @@ static void mtk_crtc_update_config(struct mtk_crtc *mtk_crtc, bool needs_vblank)
 	struct mtk_drm_private *priv = crtc->dev->dev_private;
 	unsigned int pending_planes = 0, pending_async_planes = 0;
 	int i;
+	unsigned long flags;
 
 	mutex_lock(&mtk_crtc->hw_lock);
 
-	spin_lock(&mtk_crtc->config_lock);
+	spin_lock_irqsave(&mtk_crtc->config_lock, flags);
 	mtk_crtc->config_updating = true;
-	spin_unlock(&mtk_crtc->config_lock);
+	spin_unlock_irqrestore(&mtk_crtc->config_lock, flags);
 
 	if (needs_vblank)
 		mtk_crtc->pending_needs_vblank = true;
@@ -645,9 +648,9 @@ static void mtk_crtc_update_config(struct mtk_crtc *mtk_crtc, bool needs_vblank)
 		mbox_client_txdone(mtk_crtc->cmdq_client.chan, 0);
 	}
 #endif
-	spin_lock(&mtk_crtc->config_lock);
+	spin_lock_irqsave(&mtk_crtc->config_lock, flags);
 	mtk_crtc->config_updating = false;
-	spin_unlock(&mtk_crtc->config_lock);
+	spin_unlock_irqrestore(&mtk_crtc->config_lock, flags);
 
 	mutex_unlock(&mtk_crtc->hw_lock);
 }

-- 
2.43.0



