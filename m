Return-Path: <linux-kernel+bounces-291010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C86CE955C38
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 12:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 482C3B215D7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 10:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4184445025;
	Sun, 18 Aug 2024 10:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="RzNS7DA7"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6C418C08
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 10:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723977826; cv=none; b=kzfglrvZy+EZvluXZfGIqhmmatc1sl6ugLhmoGWAf5vRdvCIv5qTbThRQFgUTlBazt1OX8K7YLqH1elCd67Gm/N1tKYdSUU9htM0JD5X6wgOeI5/qJ6CbCyoHCn+dAXhK55pJRa1OHNfK3hep73MG/C2L+tajR43+7o59kNrXe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723977826; c=relaxed/simple;
	bh=Lpqh2jSd9QADVKkj1nBrAHY5oYAEKgK5CLTaDTesv0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fDKYmpZ8TKjaqW7cbFHGNq5m6/EvLIEn9oobZ2oOTJgMRC03QXcGVRNFr1VOyZfMMmKWAsIihwn9BYxu8G4TO11SsthMwUeZtGc1EKybKXw0d1r0ylOwlYePyiJfpPTYiWqYhZzjkvauBgFkUa85Jnv+VD+fknwHq0xzMlUA0vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=RzNS7DA7; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723977821;
	bh=Lpqh2jSd9QADVKkj1nBrAHY5oYAEKgK5CLTaDTesv0s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RzNS7DA7DmymbVrEZrpYJY2HDQt1EN5qkBELCmYGpfFAsib4F+y+OC3oT7v/1ZJs7
	 +HbcA6qSK2hycyedD2FUw+IYUcJ477dAF6mIM8S3FlurGCrAo0BlCvN7IeT+RZf8Lc
	 JVCzSZBSSRLNPYMv8U5vFXi/nKP3ZzcIMxzIySys=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 18 Aug 2024 12:43:25 +0200
Subject: [PATCH 01/12] drm/amd/display: remove spurious definition for
 dm_helpers_get_sbios_edid()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240818-amdgpu-drm_edid-v1-1-aea66c1f7cf4@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723977820; l=1119;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Lpqh2jSd9QADVKkj1nBrAHY5oYAEKgK5CLTaDTesv0s=;
 b=6cPhRmU6AKisqobu394usiyHTuANxRVUXzhK+EvvTKfzWW1/CVS4lNNk+aO0p3QeecO/DZ5iE
 FKsNNNdnU1cCK4MKcae9jFshk8Q09Qw6PujjZKTfN2NkuJcP380w3bc
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The prototype is the whole content of commit
575d0df6dae4 ("drm/amd/display: refine the EDID override").
Apparently the definition was never added.

Fixes: 575d0df6dae4 ("drm/amd/display: refine the EDID override")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/gpu/drm/amd/display/dc/dm_helpers.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index 2e4a46f1b499..483d8c292618 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -208,8 +208,6 @@ int dm_helpers_dmub_set_config_sync(struct dc_context *ctx,
 		enum set_config_status *operation_result);
 enum adaptive_sync_type dm_get_adaptive_sync_support_type(struct dc_link *link);
 
-enum dc_edid_status dm_helpers_get_sbios_edid(struct dc_link *link, struct dc_edid *edid);
-
 bool dm_helpers_is_fullscreen(struct dc_context *ctx, struct dc_stream_state *stream);
 bool dm_helpers_is_hdr_on(struct dc_context *ctx, struct dc_stream_state *stream);
 

-- 
2.46.0


