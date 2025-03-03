Return-Path: <linux-kernel+bounces-541937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4747A4C398
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF51616BFD4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5D62144B8;
	Mon,  3 Mar 2025 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="K6sirqud"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846572139DB
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741012774; cv=none; b=YhBiMfWPMJXzgp8eHiB1pPrqQtWo1kSg0Np74IcrVK8FPJENos9/dksF3uYUwUq1BdlHF4MiK1Ahy+lZjiA71koeJwIJ4szQYES8XMN9qL4PwP6DDY2PED5ZYinJ4jSAtoYorziyPI9Q32PHzxP5RkbD5oeeqZLp7AzzO66u8OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741012774; c=relaxed/simple;
	bh=fIfj58Ul8EwY9c+AHQLHHbF/BQwHxUja+x8dJWwhoX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROh34dPVUtS6NUSBagh1buy67w0tqDtvJDWOKuQwTOaJCE5xGrWu4NcGwRETZ/dEDF3qYMAk5EVebQQEI0VfoMYOiGt54CdcXv2ktCpMMZzJPw1bEUqsoBnzDHsgjPVFhkGccfietAlMRcN+CDuGWJGsG9iPMheKrEd6YGhIH+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=K6sirqud; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=Cdlfgnw8G3+c2z4nhjgVDSllq75qCcu4juCsqIjCRVU=; b=K6sirqudCWNyvGUV
	/HTVqPM3WYWKlwJk6yB1/38dSP70Im0Cm/yvMBZwLWIL/eYN48TVSc26B6c8i15hLfJ8OtvFou7KL
	JIctFSYAvAAakwQmItCIQjHAo4RElyzFmj493wDm89Bg5mPU+Q2oyCqJc5jLYf5+2RA9TV4lGHuyl
	GX4Uop2w1DjcNh1vyjrWbukIHUMYPeuA7LNh+LVhm20X/KiQ6lqBhx/8t3VF6EOIMuLJZvqneXfqm
	yEH7tOknyWujF3edoOtlVCgyQBU5Io+0s2PW7MKmCQ/4FB2F2Spuz0kuIXGHulBLTTwyKdAPo6v4i
	yL88hIl2jwOYzNqgsg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tp6x4-0028PG-2R;
	Mon, 03 Mar 2025 14:39:26 +0000
From: linux@treblig.org
To: alexander.deucher@amd.com,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	siqueira@igalia.com,
	austin.zheng@amd.com,
	jun.lei@amd.com,
	kenneth.feng@amd.com,
	linux-kernel@vger.kernel.org
Cc: airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 4/6] drm/amdgpu: Remove unused pre_surface_trace
Date: Mon,  3 Mar 2025 14:39:20 +0000
Message-ID: <20250303143922.36342-5-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303143922.36342-1-linux@treblig.org>
References: <20250303143922.36342-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

pre_surface_trace() has been unused since 2017's
commit 745cc746da42 ("drm/amd/display: remove
dc_pre_update_surfaces_to_stream from dc use")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 .../gpu/drm/amd/display/dc/core/dc_debug.c    | 120 ------------------
 .../amd/display/include/logger_interface.h    |   5 -
 2 files changed, 125 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
index af1ea5792560..650e89825968 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
@@ -51,126 +51,6 @@
 		DC_LOG_BANDWIDTH_CALCS(__VA_ARGS__); \
 } while (0)
 
-void pre_surface_trace(
-		struct dc *dc,
-		const struct dc_plane_state *const *plane_states,
-		int surface_count)
-{
-	int i;
-	DC_LOGGER_INIT(dc->ctx->logger);
-
-	for (i = 0; i < surface_count; i++) {
-		const struct dc_plane_state *plane_state = plane_states[i];
-
-		SURFACE_TRACE("Planes %d:\n", i);
-
-		SURFACE_TRACE(
-				"plane_state->visible = %d;\n"
-				"plane_state->flip_immediate = %d;\n"
-				"plane_state->address.type = %d;\n"
-				"plane_state->address.grph.addr.quad_part = 0x%llX;\n"
-				"plane_state->address.grph.meta_addr.quad_part = 0x%llX;\n"
-				"plane_state->scaling_quality.h_taps = %d;\n"
-				"plane_state->scaling_quality.v_taps = %d;\n"
-				"plane_state->scaling_quality.h_taps_c = %d;\n"
-				"plane_state->scaling_quality.v_taps_c = %d;\n",
-				plane_state->visible,
-				plane_state->flip_immediate,
-				plane_state->address.type,
-				plane_state->address.grph.addr.quad_part,
-				plane_state->address.grph.meta_addr.quad_part,
-				plane_state->scaling_quality.h_taps,
-				plane_state->scaling_quality.v_taps,
-				plane_state->scaling_quality.h_taps_c,
-				plane_state->scaling_quality.v_taps_c);
-
-		SURFACE_TRACE(
-				"plane_state->src_rect.x = %d;\n"
-				"plane_state->src_rect.y = %d;\n"
-				"plane_state->src_rect.width = %d;\n"
-				"plane_state->src_rect.height = %d;\n"
-				"plane_state->dst_rect.x = %d;\n"
-				"plane_state->dst_rect.y = %d;\n"
-				"plane_state->dst_rect.width = %d;\n"
-				"plane_state->dst_rect.height = %d;\n"
-				"plane_state->clip_rect.x = %d;\n"
-				"plane_state->clip_rect.y = %d;\n"
-				"plane_state->clip_rect.width = %d;\n"
-				"plane_state->clip_rect.height = %d;\n",
-				plane_state->src_rect.x,
-				plane_state->src_rect.y,
-				plane_state->src_rect.width,
-				plane_state->src_rect.height,
-				plane_state->dst_rect.x,
-				plane_state->dst_rect.y,
-				plane_state->dst_rect.width,
-				plane_state->dst_rect.height,
-				plane_state->clip_rect.x,
-				plane_state->clip_rect.y,
-				plane_state->clip_rect.width,
-				plane_state->clip_rect.height);
-
-		SURFACE_TRACE(
-				"plane_state->plane_size.surface_size.x = %d;\n"
-				"plane_state->plane_size.surface_size.y = %d;\n"
-				"plane_state->plane_size.surface_size.width = %d;\n"
-				"plane_state->plane_size.surface_size.height = %d;\n"
-				"plane_state->plane_size.surface_pitch = %d;\n",
-				plane_state->plane_size.surface_size.x,
-				plane_state->plane_size.surface_size.y,
-				plane_state->plane_size.surface_size.width,
-				plane_state->plane_size.surface_size.height,
-				plane_state->plane_size.surface_pitch);
-
-
-		SURFACE_TRACE(
-				"plane_state->tiling_info.gfx8.num_banks = %d;\n"
-				"plane_state->tiling_info.gfx8.bank_width = %d;\n"
-				"plane_state->tiling_info.gfx8.bank_width_c = %d;\n"
-				"plane_state->tiling_info.gfx8.bank_height = %d;\n"
-				"plane_state->tiling_info.gfx8.bank_height_c = %d;\n"
-				"plane_state->tiling_info.gfx8.tile_aspect = %d;\n"
-				"plane_state->tiling_info.gfx8.tile_aspect_c = %d;\n"
-				"plane_state->tiling_info.gfx8.tile_split = %d;\n"
-				"plane_state->tiling_info.gfx8.tile_split_c = %d;\n"
-				"plane_state->tiling_info.gfx8.tile_mode = %d;\n"
-				"plane_state->tiling_info.gfx8.tile_mode_c = %d;\n",
-				plane_state->tiling_info.gfx8.num_banks,
-				plane_state->tiling_info.gfx8.bank_width,
-				plane_state->tiling_info.gfx8.bank_width_c,
-				plane_state->tiling_info.gfx8.bank_height,
-				plane_state->tiling_info.gfx8.bank_height_c,
-				plane_state->tiling_info.gfx8.tile_aspect,
-				plane_state->tiling_info.gfx8.tile_aspect_c,
-				plane_state->tiling_info.gfx8.tile_split,
-				plane_state->tiling_info.gfx8.tile_split_c,
-				plane_state->tiling_info.gfx8.tile_mode,
-				plane_state->tiling_info.gfx8.tile_mode_c);
-
-		SURFACE_TRACE(
-				"plane_state->tiling_info.gfx8.pipe_config = %d;\n"
-				"plane_state->tiling_info.gfx8.array_mode = %d;\n"
-				"plane_state->color_space = %d;\n"
-				"plane_state->dcc.enable = %d;\n"
-				"plane_state->format = %d;\n"
-				"plane_state->rotation = %d;\n"
-				"plane_state->stereo_format = %d;\n",
-				plane_state->tiling_info.gfx8.pipe_config,
-				plane_state->tiling_info.gfx8.array_mode,
-				plane_state->color_space,
-				plane_state->dcc.enable,
-				plane_state->format,
-				plane_state->rotation,
-				plane_state->stereo_format);
-
-		SURFACE_TRACE("plane_state->tiling_info.gfx9.swizzle = %d;\n",
-				plane_state->tiling_info.gfx9.swizzle);
-
-		SURFACE_TRACE("\n");
-	}
-	SURFACE_TRACE("\n");
-}
-
 void update_surface_trace(
 		struct dc *dc,
 		const struct dc_surface_update *updates,
diff --git a/drivers/gpu/drm/amd/display/include/logger_interface.h b/drivers/gpu/drm/amd/display/include/logger_interface.h
index 058f882d5bdd..4c01514b926c 100644
--- a/drivers/gpu/drm/amd/display/include/logger_interface.h
+++ b/drivers/gpu/drm/amd/display/include/logger_interface.h
@@ -40,11 +40,6 @@ struct dc_state;
  *
  */
 
-void pre_surface_trace(
-		struct dc *dc,
-		const struct dc_plane_state *const *plane_states,
-		int surface_count);
-
 void update_surface_trace(
 		struct dc *dc,
 		const struct dc_surface_update *updates,
-- 
2.48.1


