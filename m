Return-Path: <linux-kernel+bounces-192226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 903BD8D1A52
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1E2E1C23DD1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF9A16D30D;
	Tue, 28 May 2024 11:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D03AwHuD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3319816C87C
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716897160; cv=none; b=sP0ANyzs7S0GJ8qCKpigETNaapE8d2b9Zw/UKTHahvs4OInohjTjIjPNuSOa1xHUVTllv4KB8VfpKp4wbApmBvUDQZ/j84ssXhhyx9K+mcxqzPTLUpbv3Ch6n0ToWZvJ2nSmse4hqkC6mODalYdLqYuo6+Cv472RTP2XMYooZFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716897160; c=relaxed/simple;
	bh=c6HLmHQgr+K+/opF/OiiYVpCKahYXfgVPr1CgHqBTgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZYDOtdHwFc6/0l+90f1k9P5YdCrmFp8jold7KlFfDKjpodlSGobS6Totu2xIA4aZnqFdCbw+196F82To2HxKUyT6jrrflxSC1D+889QqKQxOKS5BuBY+dYah+4u8NPKwqoWQtOdvryctVYsxRbuqVe1l+CtAq2A9YmFKvR5hW9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D03AwHuD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F68C32782;
	Tue, 28 May 2024 11:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716897159;
	bh=c6HLmHQgr+K+/opF/OiiYVpCKahYXfgVPr1CgHqBTgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D03AwHuDsKvcUkDlecqDtEPZZhMjTaMFd/0vPhG4U2wi15wGBBRYxi+a50oIIBAD3
	 kKAzYiBT1/iSoy4fgo1HuQYlVrjGJRadJCOGeXHrEpHjmtG5x2+kEt/49Zn++EPv+4
	 yeyFdAE0FhAbD49JWO4q62bg33zoI0vP/C8pwYSFZ30Fh2GsOjzJTbRobGkohqR5rr
	 +m1pqpaXPIfHzUI95y9nwRik70fTPhQk/0KhuQAFuk92y8DNShIWo2NiRIKgACLAsd
	 nq64oSyxXi+S9t5Pd+97UwuemMAMEJYbXLnE1eMhYtqw+0vuS/pjB9/noBCtL5TtS4
	 XbAPM52H58fyQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Dillon Varone <dillon.varone@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Chaitanya Dhere <chaitanya.dhere@amd.com>,
	Alvin Lee <alvin.lee2@amd.com>,
	Joshua Aberback <joshua.aberback@amd.com>,
	Charlene Liu <charlene.liu@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Wenjing Liu <wenjing.liu@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] drm/amd/display: avoid large on-stack structures
Date: Tue, 28 May 2024 13:51:20 +0200
Message-Id: <20240528115146.2870032-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240528115146.2870032-1-arnd@kernel.org>
References: <20240528115146.2870032-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Putting excessively large objects on a function stack causes
a warning about possibly overflowing the 8KiB of kernel stack:

drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn401/dcn401_resource.c: In function 'dcn401_update_bw_bounding_box':
drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn401/dcn401_resource.c:1599:1: error: the frame size of 1196 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
 1599 | }
      | ^
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_state.c: In function 'dc_state_create':
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_state.c:221:1: error: the frame size of 1196 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
  221 | }
      | ^

Use dynamic allocation instead.

Fixes: e779f4587f61 ("drm/amd/display: Add handling for DC power mode")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/dc/core/dc_state.c   | 16 +++++++++++-----
 .../display/dc/resource/dcn401/dcn401_resource.c | 16 +++++++++++-----
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index 70928223b642..8ea9391c60b7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -193,7 +193,11 @@ static void init_state(struct dc *dc, struct dc_state *state)
 struct dc_state *dc_state_create(struct dc *dc, struct dc_state_create_params *params)
 {
 #ifdef CONFIG_DRM_AMD_DC_FP
-	struct dml2_configuration_options dml2_opt = dc->dml2_options;
+	struct dml2_configuration_options *dml2_opt;
+
+	dml2_opt = kmemdup(&dc->dml2_options, sizeof(*dml2_opt), GFP_KERNEL);
+	if (!dml2_opt)
+		return NULL;
 #endif
 	struct dc_state *state = kvzalloc(sizeof(struct dc_state),
 			GFP_KERNEL);
@@ -207,12 +211,14 @@ struct dc_state *dc_state_create(struct dc *dc, struct dc_state_create_params *p
 
 #ifdef CONFIG_DRM_AMD_DC_FP
 	if (dc->debug.using_dml2) {
-		dml2_opt.use_clock_dc_limits = false;
-		dml2_create(dc, &dml2_opt, &state->bw_ctx.dml2);
+		dml2_opt->use_clock_dc_limits = false;
+		dml2_create(dc, dml2_opt, &state->bw_ctx.dml2);
 
-		dml2_opt.use_clock_dc_limits = true;
-		dml2_create(dc, &dml2_opt, &state->bw_ctx.dml2_dc_power_source);
+		dml2_opt->use_clock_dc_limits = true;
+		dml2_create(dc, dml2_opt, &state->bw_ctx.dml2_dc_power_source);
 	}
+
+	kfree(dml2_opt);
 #endif
 
 	kref_init(&state->refcount);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 247bac177d1b..8dfb0a3d21cb 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1581,21 +1581,27 @@ static struct dc_cap_funcs cap_funcs = {
 
 static void dcn401_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
-	struct dml2_configuration_options dml2_opt = dc->dml2_options;
+	struct dml2_configuration_options *dml2_opt;
+
+	dml2_opt = kmemdup(&dc->dml2_options, sizeof(*dml2_opt), GFP_KERNEL);
+	if (!dml2_opt)
+		return;
 
 	DC_FP_START();
 
 	dcn401_update_bw_bounding_box_fpu(dc, bw_params);
 
-	dml2_opt.use_clock_dc_limits = false;
+	dml2_opt->use_clock_dc_limits = false;
 	if (dc->debug.using_dml2 && dc->current_state && dc->current_state->bw_ctx.dml2)
-		dml2_reinit(dc, &dml2_opt, &dc->current_state->bw_ctx.dml2);
+		dml2_reinit(dc, dml2_opt, &dc->current_state->bw_ctx.dml2);
 
-	dml2_opt.use_clock_dc_limits = true;
+	dml2_opt->use_clock_dc_limits = true;
 	if (dc->debug.using_dml2 && dc->current_state && dc->current_state->bw_ctx.dml2_dc_power_source)
-		dml2_reinit(dc, &dml2_opt, &dc->current_state->bw_ctx.dml2_dc_power_source);
+		dml2_reinit(dc, dml2_opt, &dc->current_state->bw_ctx.dml2_dc_power_source);
 
 	DC_FP_END();
+
+	kfree(dml2_opt);
 }
 
 enum dc_status dcn401_patch_unknown_plane_state(struct dc_plane_state *plane_state)
-- 
2.39.2


