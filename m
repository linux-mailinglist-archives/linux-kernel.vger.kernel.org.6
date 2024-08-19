Return-Path: <linux-kernel+bounces-292380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B57956EB2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07A4528342F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 15:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343AC3C463;
	Mon, 19 Aug 2024 15:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDoFiYOY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B47726AD3
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 15:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724081159; cv=none; b=tq/yMFu1NAMNQf+4+p8OcCDIfObmn6qAbwo9jM4u3g8zX0N8mnUatRuo71Rgvi46iY5QLdHermlP05BJ50lmXVOOtImSMi972TTLcemY5Kcky5blm0yfSftZrKgPtyFisMAvH5f7jeZkV91UUMHy29MF4gRSyrFONbO0wJx5HTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724081159; c=relaxed/simple;
	bh=47/mi7Pp62O0NFO5UbuSap4oR+3mOW++0umg7qsCsBA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fXgpnvhZRtNF+1K1RDGmmm0hdu249Sm73YBMCj2GoqHXV0rkcfh81GCjIIoC2AQsmBKAqe19e371JNFqhYKIgnM8YrmPqFSBTuK6Th3WvjbKmTrhQB/IUFzyddCv7KvqLh/qmuqMSoJWwvBZwFURXK5zob6hx2ZMzfSjpioXnho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDoFiYOY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF41CC32782;
	Mon, 19 Aug 2024 15:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724081159;
	bh=47/mi7Pp62O0NFO5UbuSap4oR+3mOW++0umg7qsCsBA=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=XDoFiYOYW1rdOm/PlOWwkn0+xmRO1qU8ePa5eQJfWGBTka/go2kpm/eEw7ujW7Mcb
	 EQZDyuIVWcmC76hv7rhZ+jRZPxvCYJxoqWd/2yM6evlaayp//TkdwRvxSY91qBVUYu
	 PqADLPMTwklhCDxensp4lX0W2wxRft5HZhJF966ePMtC3g4CdT/UQCK85bQhI1XWhq
	 1dFoZ8so4FXGhSw2c7KwYXrN6NAmppWLrDImiVnCNW+zIY6pmoZ97o+WMUgg8hKAuz
	 bbqbH7Ha6g+Ei/9gPawCCo4t+wTg8e+SsUHZJbWARPqfHPYFGWZvadj3C/jtSvLjla
	 peQwOA/NRdjFg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3404C3DA4A;
	Mon, 19 Aug 2024 15:25:58 +0000 (UTC)
From: "Jason-JH.Lin via B4 Relay" <devnull+jason-jh.lin.mediatek.com@kernel.org>
Date: Mon, 19 Aug 2024 23:25:10 +0800
Subject: [PATCH v2] drm/mediatek: Fix missing configuration flags in
 mtk_crtc_ddp_config()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-drm-fixup-0819-v2-1-a03580ece3ec@mediatek.com>
X-B4-Tracking: v=1; b=H4sIANVjw2YC/0XMyw6CMBCF4Vchs3ZILxrAFe9hXDTtVAZtS1o0J
 oR3t2Hj8svJ+TcolJkKXJsNMn24cIoV6tSAnUx8ELKrBiXUWfRyQJcDev6+FzzoL5KU0523roN
 6WjLV9Qje7tU+p4DrlMn8M53QUmgt+lYKOfQocTYlRZyn9sVxDOTYrPRsbQqw7z+bhOfSowAAA
 A==
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Singo Chang <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>, 
 Project_Global_Chrome_Upstream_Group@mediatek.com, 
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724081157; l=4198;
 i=jason-jh.lin@mediatek.com; s=20240718; h=from:subject:message-id;
 bh=Q8yNxL1V+8Fyf9/F6ibfR4vyzWQzF1gZGlRNpdyq+Wc=;
 b=mToiwGYxLF03l56+/AFJ9V9ANIGgrncpw7osIk6F0/74e0A7jXKT07UbGl+3ZLs4bpGWzcnTw
 ZnS/1DpPIMIAc4J5tkIajRWuoi2bqOL0I0z+8LJ8aLmLA4e0/T61qtA
X-Developer-Key: i=jason-jh.lin@mediatek.com; a=ed25519;
 pk=7Hn+BnFBlPrluT5ks5tKVWb3f7O/bMBs6qEemVJwqOo=
X-Endpoint-Received: by B4 Relay for jason-jh.lin@mediatek.com/20240718
 with auth_id=187
X-Original-From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Reply-To: jason-jh.lin@mediatek.com

From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>

In mtk_crtc_ddp_config(), mtk_crtc will use some configuration flags to
generate instructions to cmdq_handle, such as:
  state->pending_config
  mtk_crtc->pending_planes
  plane_state->pending.config
  mtk_crtc->pending_async_planes
  plane_state->pending.async_config

These configuration flags may be set to false when a GCE IRQ comes calling
ddp_cmdq_cb(). This may result in missing prepare instructions,
especially if mtk_crtc_update_config() with the flase need_vblank (no need
to wait for vblank) cases.

Therefore, the mtk_crtc->config_updating flag is set at the beginning of
mtk_crtc_update_config() to ensure that these configuration flags won't be
changed when the mtk_crtc_ddp_config() is preparing instructions.
But somehow the ddp_cmdq_cb() didn't use the mtk_crtc->config_updating
flag to prevent those pending config flags from being cleared.

To avoid missing the configuration when generating the config instruction,
the config_updating flag should be added into ddp_cmdq_cb() and be
protected with spin_lock.

Fixes: 7f82d9c43879 ("drm/mediatek: Clear pending flag when cmdq packet is done")
Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
---
Change in v2:
Add spin_lock protection for config_updating flag.
---
 drivers/gpu/drm/mediatek/mtk_crtc.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediatek/mtk_crtc.c
index 6f34f573e127..b752c0b46383 100644
--- a/drivers/gpu/drm/mediatek/mtk_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
@@ -69,6 +69,8 @@ struct mtk_crtc {
 	/* lock for display hardware access */
 	struct mutex			hw_lock;
 	bool				config_updating;
+	/* lock for config_updating to cmd buffer */
+	spinlock_t			config_lock;
 };
 
 struct mtk_crtc_state {
@@ -107,10 +109,13 @@ static void mtk_crtc_finish_page_flip(struct mtk_crtc *mtk_crtc)
 static void mtk_drm_finish_page_flip(struct mtk_crtc *mtk_crtc)
 {
 	drm_crtc_handle_vblank(&mtk_crtc->base);
+
+	spin_lock(&mtk_crtc->config_lock);
 	if (!mtk_crtc->config_updating && mtk_crtc->pending_needs_vblank) {
 		mtk_crtc_finish_page_flip(mtk_crtc);
 		mtk_crtc->pending_needs_vblank = false;
 	}
+	spin_unlock(&mtk_crtc->config_lock);
 }
 
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
@@ -314,6 +319,13 @@ static void ddp_cmdq_cb(struct mbox_client *cl, void *mssg)
 
 	state = to_mtk_crtc_state(mtk_crtc->base.state);
 
+	spin_lock(&mtk_crtc->config_lock);
+
+	if (mtk_crtc->config_updating) {
+		spin_unlock(&mtk_crtc->config_lock);
+		goto ddp_cmdq_cb_out;
+	}
+
 	state->pending_config = false;
 
 	if (mtk_crtc->pending_planes) {
@@ -340,6 +352,10 @@ static void ddp_cmdq_cb(struct mbox_client *cl, void *mssg)
 		mtk_crtc->pending_async_planes = false;
 	}
 
+	spin_unlock(&mtk_crtc->config_lock);
+
+ddp_cmdq_cb_out:
+
 	mtk_crtc->cmdq_vblank_cnt = 0;
 	wake_up(&mtk_crtc->cb_blocking_queue);
 }
@@ -571,7 +587,11 @@ static void mtk_crtc_update_config(struct mtk_crtc *mtk_crtc, bool needs_vblank)
 	int i;
 
 	mutex_lock(&mtk_crtc->hw_lock);
+
+	spin_lock(&mtk_crtc->config_lock);
 	mtk_crtc->config_updating = true;
+	spin_unlock(&mtk_crtc->config_lock);
+
 	if (needs_vblank)
 		mtk_crtc->pending_needs_vblank = true;
 
@@ -625,7 +645,10 @@ static void mtk_crtc_update_config(struct mtk_crtc *mtk_crtc, bool needs_vblank)
 		mbox_client_txdone(mtk_crtc->cmdq_client.chan, 0);
 	}
 #endif
+	spin_lock(&mtk_crtc->config_lock);
 	mtk_crtc->config_updating = false;
+	spin_unlock(&mtk_crtc->config_lock);
+
 	mutex_unlock(&mtk_crtc->hw_lock);
 }
 
@@ -1068,6 +1091,7 @@ int mtk_crtc_create(struct drm_device *drm_dev, const unsigned int *path,
 		drm_mode_crtc_set_gamma_size(&mtk_crtc->base, gamma_lut_size);
 	drm_crtc_enable_color_mgmt(&mtk_crtc->base, 0, has_ctm, gamma_lut_size);
 	mutex_init(&mtk_crtc->hw_lock);
+	spin_lock_init(&mtk_crtc->config_lock);
 
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
 	i = priv->mbox_index++;

---
base-commit: 469f1bad3c1c6e268059f78c0eec7e9552b3894c
change-id: 20240819-drm-fixup-0819-f51e2d37fcd7

Best regards,
-- 
Jason-JH.Lin <jason-jh.lin@mediatek.com>



