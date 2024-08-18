Return-Path: <linux-kernel+bounces-291011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E1E955C39
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 12:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDC9E1F21021
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 10:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEAC4965C;
	Sun, 18 Aug 2024 10:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="JbJOCE6J"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26021199B8
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 10:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723977826; cv=none; b=PCW/FgpheL0upUa0xTgQuIodGk05oH0pRA341hROJMBLaBmQw30BT1R+Nu7QulJl0lWkd6n6ZKTy+L4OpH3vKo0EFUUOylE9dr3zplOSLZqRyjXWHAGsvT6hyamvS3LVq9y3C/S05AjPTrxrKpTw5+Sy8woChSjk4TZ2KCLxysY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723977826; c=relaxed/simple;
	bh=m6tZ+bkNum+lT9LuP45n39o3Kd/bRgn7J6zpoZystEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lfpa555/918HWNJbOcSpLtaIK0btsfCDiaF//n5qO7hFBjACjF23Z+rNiRBzBDTrkZP1LzzGxxol8kPY1WT3x/hzNwMfyyZO0G+LIQpxOKDnh8PLsxuWjE2RSIgJvlrlzXjXcgfxJyvN9RAwVcM5w0eHjNhyI5486XfYklkXEHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=JbJOCE6J; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723977821;
	bh=m6tZ+bkNum+lT9LuP45n39o3Kd/bRgn7J6zpoZystEI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JbJOCE6Jlx5RCqqXzNzh049IuNIn7N0JMls5JihdAFZXtJRJD5t1He053nvvFm2Qt
	 uPZJ9pyYeMEncFSXEnNpjshmStP+FdR6HlUSEBIWa0oOQpSk+pjeuHsvN3YAQ+Catk
	 fBJH/AQpXUhenjhKIO1495YZTIgkIYwzC5oauy1Q=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 18 Aug 2024 12:43:26 +0200
Subject: [PATCH 02/12] drm/amd/display: Remove EDID members of ddc_service
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240818-amdgpu-drm_edid-v1-2-aea66c1f7cf4@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723977820; l=806;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=m6tZ+bkNum+lT9LuP45n39o3Kd/bRgn7J6zpoZystEI=;
 b=ozRNgTI5VgAdH6JDcIzjC2DrBbm2VMGUqtREn5p8IP4s3WC9TgD+uDngpZxIXuBVqA29YXg90
 kDNFbGJaNhUAud/a/fNH1lKngn+Y35Vl25dJjIR+ZsqjA9CIKq2mJAS
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

All usages of these fields have been removed.

Fixes: 7c7f5b15be65 ("drm/amd/display: Refactor edid read.")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/gpu/drm/amd/display/dc/dc_ddc_types.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_ddc_types.h b/drivers/gpu/drm/amd/display/dc/dc_ddc_types.h
index 428e3a9ab65a..7dd1cfb9ab76 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_ddc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_ddc_types.h
@@ -189,10 +189,6 @@ struct ddc_service {
 	enum display_dongle_type dongle_type;
 	struct dc_context *ctx;
 	struct dc_link *link;
-
-	uint32_t address;
-	uint32_t edid_buf_len;
-	uint8_t edid_buf[DC_MAX_EDID_BUFFER_SIZE];
 };
 
 #endif /* DC_DDC_TYPES_H_ */

-- 
2.46.0


