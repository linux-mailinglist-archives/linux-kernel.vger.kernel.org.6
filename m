Return-Path: <linux-kernel+bounces-181930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D558C8381
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 11:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83755B2137A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 09:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BB822324;
	Fri, 17 May 2024 09:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmH5v00w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A3B18AE0
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 09:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715938235; cv=none; b=exZxGs4R3WX1XqHE5iL05uszT4vZ+0CQd1AskTH1WBHSVmbvV1dzUDVebM1gdlpfPU99aKmgUBdLmJJVXgNXdrMXoqSFPi+hM1/CGRUCR6AyJ1Ri1i9nuYq0Hgx+WbjwT/NrNzrfHTYbf4kCvwJ+N6u81qJ/y9bvcaYsnYBa5Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715938235; c=relaxed/simple;
	bh=0Ppg0DAmyJKW6/IVs6KUizB75FN0TSYnPMZbnsVDHgs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PvgTuj7ClgPP52a0k2jkLAchgXY7RAECFrVgPRZyyTRHwQYEkfHh3Ali1YGveXHMHkS19OnePU0B8B8j92rLcYnZFG76TaBxgNRln8Nir6nVlo/QJQqWlljZt5sxDwRRchm7ACBnHpHQapkxEYvfcjWJllWT2oexeyNZobTxXQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmH5v00w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1284C2BD10;
	Fri, 17 May 2024 09:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715938235;
	bh=0Ppg0DAmyJKW6/IVs6KUizB75FN0TSYnPMZbnsVDHgs=;
	h=From:To:Cc:Subject:Date:From;
	b=bmH5v00wYUvLkqz9+qA8rWRCupLwX1m5hMeQDJUs2qwYwkbzF9ljuNOloc11WvjyP
	 hvUSG9PXL4eIZwZp0lRZmjOam88aPbFXJDXvDchIm6iWfQ628f88uEx0xNhlri7gSG
	 mE0fl0sBvBSVlreZ+Kwjf6A5Cx7UNduJJ4D08U50oibH27oiPdvytGeH1FG/Ib7o29
	 D8KnrhHLu8YBqtv+4OZLc85M438kcmrOREv46vm1cjXNLK1s3bvEVZ+H6Y52UoBBEB
	 K6vQl5keKuLDsify+oRjgAmE65x4Gpb4zBidqZ5M/5H3R6b8ZzTJ3z7w8DZeM7zrlD
	 Zxti9UU8qPyIA==
From: Michael Walle <mwalle@kernel.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Jani Nikula <jani.nikula@intel.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH] drm/mediatek/dp: fix spurious kfree()
Date: Fri, 17 May 2024 11:30:24 +0200
Message-Id: <20240517093024.1702750-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm_edid_to_sad() might return an error or just zero. If that is the
case, we must not free the SADs because there was no allocation in
the first place.

Fixes: dab12fa8d2bd ("drm/mediatek/dp: fix memory leak on ->get_edid callback audio detection")
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index 536366956447..ada12927bbac 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -2073,9 +2073,15 @@ static const struct drm_edid *mtk_dp_edid_read(struct drm_bridge *bridge,
 		 */
 		const struct edid *edid = drm_edid_raw(drm_edid);
 		struct cea_sad *sads;
+		int ret;
 
-		audio_caps->sad_count = drm_edid_to_sad(edid, &sads);
-		kfree(sads);
+		ret = drm_edid_to_sad(edid, &sads);
+		/* Ignore any errors */
+		if (ret < 0)
+			ret = 0;
+		if (ret)
+			kfree(sads);
+		audio_caps->sad_count = ret;
 
 		/*
 		 * FIXME: This should use connector->display_info.has_audio from
-- 
2.39.2


