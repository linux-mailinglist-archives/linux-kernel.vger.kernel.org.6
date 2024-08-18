Return-Path: <linux-kernel+bounces-291008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0B1955C36
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 12:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A82B71F20FF3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 10:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6654A2940D;
	Sun, 18 Aug 2024 10:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ZMB10MJH"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08023A27E
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 10:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723977825; cv=none; b=rN5tObEBi9DBcF130zgUV2ppiHePrLi+Td4pQI7NJzNd9kMlVXtNrdvCt37ahApKb5AscFUISon52Tlab7fOYPnBTqFtrPH1kkmuVvJFu8p+Zk1H0eALmbw/0bkJIS1Qdax2YXPgQhwuRLHEc8FcNDqsFsIZK/a8OrGKGeaRjsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723977825; c=relaxed/simple;
	bh=LIhDXO/vt61k9fDXb4us5vdCDXJKik9UE+Gw+d4EsFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EG6T/8WJ4yHyUovpctXYFGoWurnmhIBNICagbb7/7nrh64g3ISChc6r7diQXKq0hfHlBCBs5EdU68gNNBT8gZ4QgpcxDecckv0yzcy0DFOW9mCJvLhq8grWOT7283260li65IadBlSUO/umwmuvHLR2B83s3gBtwND1NzUxAc/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ZMB10MJH; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723977821;
	bh=LIhDXO/vt61k9fDXb4us5vdCDXJKik9UE+Gw+d4EsFY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZMB10MJHVTsbEAgJsPd/WoBVbaAt6cEqCBm1JInvuDej99GJMxLVZIq+HAwJIQDSG
	 bfSzFtp9SanQU1/JdSebwMsjIJqmJhhZm7tCXNPvBj47xLO9QdXwAXWi13qttLKRfM
	 4W/OShkMj2gPHkFvi+bxvsQ/iWpNgSyGVT+E5KN4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 18 Aug 2024 12:43:27 +0200
Subject: [PATCH 03/12] drm/edid: constify argument of drm_edid_is_valid()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240818-amdgpu-drm_edid-v1-3-aea66c1f7cf4@weissschuh.net>
References: <20240818-amdgpu-drm_edid-v1-0-aea66c1f7cf4@weissschuh.net>
In-Reply-To: <20240818-amdgpu-drm_edid-v1-0-aea66c1f7cf4@weissschuh.net>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, jinzh <jinzh@github.amd.com>, 
 Aric Cyr <Aric.Cyr@amd.com>, Alan Liu <HaoPing.Liu@amd.com>, 
 Tony Cheng <Tony.Cheng@amd.com>, 
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Harry Wentland <Harry.Wentland@amd.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723977820; l=1353;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=LIhDXO/vt61k9fDXb4us5vdCDXJKik9UE+Gw+d4EsFY=;
 b=1rBJN1vkIMxT+m2KRWFgnD882q/vGNU3J9DzDazmvd0Q9rpLOmUAECU5yqqlfUgOvLr9zcegN
 39k1x2tRzx4CntHpKLI1NRy/DB3fB+PBg4H37POxzpYGpXHM5Kx48TM
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

drm_edid_is_valid() does not modify its argument, so mark it as const.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/gpu/drm/drm_edid.c | 2 +-
 include/drm/drm_edid.h     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index f68a41eeb1fa..69fb11741abd 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -2034,7 +2034,7 @@ EXPORT_SYMBOL(drm_edid_block_valid);
  *
  * Return: True if the EDID data is valid, false otherwise.
  */
-bool drm_edid_is_valid(struct edid *edid)
+bool drm_edid_is_valid(const struct edid *edid)
 {
 	int i;
 
diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index 6bdfa254a1c1..a5b377c4a342 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -442,7 +442,7 @@ int drm_add_modes_noedid(struct drm_connector *connector,
 int drm_edid_header_is_valid(const void *edid);
 bool drm_edid_block_valid(u8 *raw_edid, int block, bool print_bad_edid,
 			  bool *edid_corrupt);
-bool drm_edid_is_valid(struct edid *edid);
+bool drm_edid_is_valid(const struct edid *edid);
 void drm_edid_get_monitor_name(const struct edid *edid, char *name,
 			       int buflen);
 struct drm_display_mode *drm_mode_find_dmt(struct drm_device *dev,

-- 
2.46.0


