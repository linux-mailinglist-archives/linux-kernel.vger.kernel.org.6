Return-Path: <linux-kernel+bounces-406537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 222A29C61A6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40A62B2AC08
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD222218D9B;
	Tue, 12 Nov 2024 18:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="trWuKTH6"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E71F218585
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 18:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731436470; cv=none; b=oubDteYN8HgZu3DbmVtJiYVl6GCcklrxIHFTEkV+xnlJYz9v7HE3HJtjrfg9WFIuZoUOcN3lWoILCWl++41ZARvbBhAUIrz/RNIxUQ02FNNqBKMTq2ut0PxpHA6xbxR03O7Lv5PLG/4LUXfuf1vxdZD49ryq1bpAq6agPcG+DwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731436470; c=relaxed/simple;
	bh=GQbAFEDWc3+fqXey0UCnib602pu/hNtipXn2veTOQnE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YPUxtzQBl/iWOsj1pg/o7DtrjzqiNMOM85S+zxa/k73H2gwVkktaiBEg2WkZjJGGyUGYUG6you+RQVh0Pw/BEEiorq8Zd5gzl10bc+Wzt0oa5ZkuuTKqsGZKiJEay6s2KOJ16EMkxz4A9S1/gr/y4LnxIrdj7OwBtEoz3wzK4Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=trWuKTH6; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731436455;
	bh=GQbAFEDWc3+fqXey0UCnib602pu/hNtipXn2veTOQnE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=trWuKTH6f5Cm+jMlyBaJwqdnRcGUxNEXY17GJ5McYfCxpCUrl7YaM54ykLW2nIDX4
	 88mFmPzX8Ggw46/R98XaMq4Y7tJrTNAgxwmfk4NL9sSszRBZith+B09bpTDJeFCWS+
	 ZrLaODco5BWN790kX2SflQCvlCQ333t6+i0Ganqs=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 12 Nov 2024 19:34:15 +0100
Subject: [PATCH v2 6/7] drm/amd/display: Drop opencoded edid panel id
 extraction
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241112-amdgpu-drm_edid-v2-6-1399dc0f0469@weissschuh.net>
References: <20241112-amdgpu-drm_edid-v2-0-1399dc0f0469@weissschuh.net>
In-Reply-To: <20241112-amdgpu-drm_edid-v2-0-1399dc0f0469@weissschuh.net>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, 
 jinzh <jinzh@github.amd.com>, Aric Cyr <Aric.Cyr@amd.com>, 
 Alan Liu <HaoPing.Liu@amd.com>, Tony Cheng <Tony.Cheng@amd.com>, 
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Harry Wentland <Harry.Wentland@amd.com>, 
 Melissa Wen <mwen@igalia.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731436454; l=1611;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=GQbAFEDWc3+fqXey0UCnib602pu/hNtipXn2veTOQnE=;
 b=BV0quP0krDQKRm6g1QR1UItqHJe3GadXKHvPM5oEacRP9OTIyVhR+ESaBNNakuCVBBg9ZIVQI
 N224eyv7XrvC5BhtHt+rG9GsUcBq1ZjK689gN/i8Sh2PjB5hxkG8+bM
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Now that a struct drm_edid is available make use of the standard
drm_edid_get_panel_id().

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 57b4a58eb9c8bfcb7b76622cf303ba01450e30ba..6f51395bf02cd6fd647de5c1a63822853deb23c9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -48,16 +48,9 @@
 #include "ddc_service_types.h"
 #include "clk_mgr.h"
 
-static u32 edid_extract_panel_id(const struct edid *edid)
+static void apply_edid_quirks(const struct drm_edid *edid, struct dc_edid_caps *edid_caps)
 {
-	return (u32)edid->mfg_id[0] << 24   |
-	       (u32)edid->mfg_id[1] << 16   |
-	       (u32)EDID_PRODUCT_ID(edid);
-}
-
-static void apply_edid_quirks(const struct edid *edid, struct dc_edid_caps *edid_caps)
-{
-	uint32_t panel_id = edid_extract_panel_id(edid);
+	u32 panel_id = drm_edid_get_panel_id(edid);
 
 	switch (panel_id) {
 	/* Workaround for some monitors which does not work well with FAMS */
@@ -130,7 +123,7 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 
 	edid_caps->edid_hdmi = connector->display_info.is_hdmi;
 
-	apply_edid_quirks(edid_buf, edid_caps);
+	apply_edid_quirks(drm_edid, edid_caps);
 
 	sad_count = drm_edid_to_sad(edid_buf, &sads);
 	if (sad_count <= 0)

-- 
2.47.0


