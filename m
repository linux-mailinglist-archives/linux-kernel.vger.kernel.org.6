Return-Path: <linux-kernel+bounces-406530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 204DB9C6083
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC6FE1F217A3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FDB21764F;
	Tue, 12 Nov 2024 18:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="RDGPOH3d"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91832076A9
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 18:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731436466; cv=none; b=DnMdIDZVeD5trbqFCBcyelPdJlzkekhJjB9uiuHJPtavghkI5ytbG2uWLRgRX/fCbj3XvI0eWlGKaBsAQEfUfst3Tlza/X+vl0u34YXUSvojOtKRvTyzLJp/pK7z3yJoHeQOfsdOxQ++T6hGTqd/dOvNK1DCdpi2dD4vToULIEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731436466; c=relaxed/simple;
	bh=ny7+lW1QmUhgPG79p69Qw+n9y/fGzw7D/iIT7aahRTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fpUuCIkSv2exzY4oOQBwFGQzgJGD/V9tZH5LF9ZG2gJ4lKEPDrukyrzX3vAPHIEzc2YXSdA+yLt5edbvGlty/Ikho+qWrrQdQlwsSb64ooHLhcloSvrQ9x+rDhX9bcDwwSsO06IOf0DK2eRwdM/++ONC1QGFKA9OjSW0yMb0cAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=RDGPOH3d; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731436454;
	bh=ny7+lW1QmUhgPG79p69Qw+n9y/fGzw7D/iIT7aahRTg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RDGPOH3d7vcDKwgeYK2zkr8uPra5EsGDEpTxI9MqTfgAruNJ/p65p+DUUZBmhUOa9
	 c+oTa1j++EnYxPQTKbE/vJqqSbHG7EtU3AnjQ2bNPAAS3XngD2mNmy5UkhRCi33rYg
	 631EDRfWSdt1UR3QWZd7yLsLj6tiJAYMQ/rlRto4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 12 Nov 2024 19:34:10 +0100
Subject: [PATCH v2 1/7] drm/amd/display: Remove spurious declaration of
 dm_helpers_get_sbios_edid()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241112-amdgpu-drm_edid-v2-1-1399dc0f0469@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731436454; l=1175;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=ny7+lW1QmUhgPG79p69Qw+n9y/fGzw7D/iIT7aahRTg=;
 b=3ar7M6gLBobRg5ww5czn+dI7lh1If/niMN9gX0UCr2oUTL0FjYA/4uZApdSJmiawvXuIOk5eV
 dBVAsiCboDaCX80Ebm5yTo3QSF/ZFuYzu8yjj8l11+9ghjYQowgzBJn
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
index 2e4a46f1b499d1dc990ef92a00fddf50287f3e05..483d8c29261814a608895abe1a195225514f78e6 100644
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
2.47.0


