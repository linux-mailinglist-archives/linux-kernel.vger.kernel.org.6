Return-Path: <linux-kernel+bounces-200253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D668FADB2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2040A1F23332
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310C314265A;
	Tue,  4 Jun 2024 08:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZfdi1+5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790733EA69
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 08:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717490024; cv=none; b=ulBgh/Ujo3GW+P4Jc98FlKWPRO9TqvM3bv9R6WfgGA3m/gl8bxPcBNRcInl+4GXuXvTpIEf9oUOraRR+0apK/emz7oISzhCCtHxQGSJU+BBHz2t9xb2hUFj4KVuKymC9pIr+BYaLAha3+/Pc9pUx/JppuZm7rj34NJtCyfbalPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717490024; c=relaxed/simple;
	bh=WcdjXKp0usjBkPhOi1eWLnKB5YMWTKiIrOQDU48frSc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G0dTxyRJmxQDkwMt9R8KmZsokT0u8gmHm85ryhyP6i3fMsEuBfDOM0NQIfSl+kwvt6Q6kpkqBdBtP5aJeE4PK/M0T57zGH0KYlKyeqa3jnftau02t19X9OwtYRwmd+RPLmgaJaY1wlCZla+D0OVzj94Dpb/50TG82N8pEuqZ4E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZfdi1+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89DEBC2BBFC;
	Tue,  4 Jun 2024 08:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717490024;
	bh=WcdjXKp0usjBkPhOi1eWLnKB5YMWTKiIrOQDU48frSc=;
	h=From:To:Cc:Subject:Date:From;
	b=qZfdi1+5gE9tloM9plnd3OEOQJBcvuaiwPhWTsubkB3Hn1yhrHMBn2W32u+eBZSLB
	 j3Px4R8aU+jzL2Q/Gm+E1qYhquQJGBWvOizcZVm5lVCTgwmCmcQK/Y/KK0Ww9amtbW
	 lKZdaM1s5gQTgve53ySXMXBI7m43/erS8Hw7un8inpwt37c4JgVvBlmz9N3EJAuiVI
	 2wiAymER1ylE2RtZDuWBGJSPo3By47m53Oquc03Vua3beillfXm6uXsEBmSsTcyhyP
	 bxBZbxuxsEC2pnQDkmSK90BXCeNIsoxqqJRuIdAsLSCidQusCgsedOFQ4DFn12ZeYd
	 wbogKIXNYjCJA==
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
Subject: [PATCH RESEND] drm/mediatek/dp: fix spurious kfree()
Date: Tue,  4 Jun 2024 10:33:37 +0200
Message-Id: <20240604083337.1879188-1-mwalle@kernel.org>
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
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
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


