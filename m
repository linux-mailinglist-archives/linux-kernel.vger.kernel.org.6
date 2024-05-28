Return-Path: <linux-kernel+bounces-192222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E348D1A45
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52444B216F4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7852516C855;
	Tue, 28 May 2024 11:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PM4154Sc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B379816ABC1
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716897114; cv=none; b=tX0RBg/9WG8xEGvtlXUnNlPDBPw/QxZyf1XjDPaB5LrvDqKaiBzm3OCkbf23Hutupt76IaAS2Gb+6EEonckwlj9gxpf9QMgr7ZZTaGXXxBW6me5JH5qv2hx88SdgASqFcVOULWmCBEzMRbpfiPH2ANcYDa4gNLcGmvjsNrf7eYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716897114; c=relaxed/simple;
	bh=5NTIA7k2l4qgufvS8T9jRq7tI4lxqaiQZj3NqXl42Bw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hP0Fy5+xbGaaF5bNU/lU4o/G2DD+TUT8XQHIc6+4fKF+4LI7icT+XiLAcwIO6aKi/GYfL2O7tu4gxm64ufoXhGh5PNH2PYiTDcnt2GRLW2XCYztp3oOfKw9WZOF70bpacxzb9vpj+8pRJrT5vq9s95AMe3Iy3QiYErxz9qSmpgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PM4154Sc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDBE5C32781;
	Tue, 28 May 2024 11:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716897114;
	bh=5NTIA7k2l4qgufvS8T9jRq7tI4lxqaiQZj3NqXl42Bw=;
	h=From:To:Cc:Subject:Date:From;
	b=PM4154ScBp2VJySWZgugutkPSdoLk0zA8wSptyJubDi8N1WOpmGZfnt3Ef9qRvnKk
	 /NRhcgP0sXS27+5SWf7AWBbdEQE6iUuhQ1C1iHm/9o/M/FkEAMRbX7ncct4p4tvVCH
	 hd2KWNfpiD70Anjirnn24Gls/SL/DTmMcWQZAhI26F9C8Tb2xfrpLyXe7nLbDLlpRK
	 yh3xAi5hdSEADjlncmcAyPUJdcvNoUXOsvAbnRL9G13td6XiUh8ckdiEQrT24uSE0r
	 c/ELf+mu/pZLiYJj26C4APSHndOPtj+3V+HaBhScA53ADOlSYoFYprMIwNzuYjnvWk
	 Wzxh7UfFQJ2mg==
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
	Wenjing Liu <wenjing.liu@amd.com>,
	Alvin Lee <alvin.lee2@amd.com>,
	Jun Lei <jun.lei@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Dillon Varone <dillon.varone@amd.com>,
	Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
	Roman Li <roman.li@amd.com>,
	Aric Cyr <aric.cyr@amd.com>,
	Joshua Aberback <joshua.aberback@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] [RESEND] drm/amd/display: dynamically allocate dml2_configuration_options structures
Date: Tue, 28 May 2024 13:51:18 +0200
Message-Id: <20240528115146.2870032-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This structure is too large to fit on a stack, as shown by the
newly introduced warnings from a recent code change:

drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn32/dcn32_resource.c: In function 'dcn32_update_bw_bounding_box':
drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn32/dcn32_resource.c:2019:1: error: the frame size of 1180 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn321/dcn321_resource.c: In function 'dcn321_update_bw_bounding_box':
drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn321/dcn321_resource.c:1597:1: error: the frame size of 1180 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_state.c: In function 'dc_state_create':
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_state.c:219:1: error: the frame size of 1184 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

Instead of open-coding the assignment of a large structure to a stack
variable, use an explicit kmemdup() in each case to move it off the stack.

Fixes: e779f4587f61 ("drm/amd/display: Add handling for DC power mode")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Originally sent as https://lore.kernel.org/all/20240418083421.3956461-1-arnd@kernel.org/
---
 .../display/dc/resource/dcn32/dcn32_resource.c   | 16 +++++++++++-----
 .../display/dc/resource/dcn321/dcn321_resource.c | 16 +++++++++++-----
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 022d320be1d5..0f11d7c8791c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -2007,21 +2007,27 @@ void dcn32_calculate_wm_and_dlg(struct dc *dc, struct dc_state *context,
 
 static void dcn32_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
-	struct dml2_configuration_options dml2_opt = dc->dml2_options;
+	struct dml2_configuration_options *dml2_opt;
+
+	dml2_opt = kmemdup(&dc->dml2_options, sizeof(dc->dml2_options), GFP_KERNEL);
+	if (!dml2_opt)
+		return;
 
 	DC_FP_START();
 
 	dcn32_update_bw_bounding_box_fpu(dc, bw_params);
 
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
 
 static struct resource_funcs dcn32_res_pool_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index e4b360d89b3b..07ca6f58447d 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1581,21 +1581,27 @@ static struct dc_cap_funcs cap_funcs = {
 
 static void dcn321_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
-	struct dml2_configuration_options dml2_opt = dc->dml2_options;
+	struct dml2_configuration_options *dml2_opt;
+
+	dml2_opt = kmemdup(&dc->dml2_options, sizeof(dc->dml2_options), GFP_KERNEL);
+	if (!dml2_opt)
+		return;
 
 	DC_FP_START();
 
 	dcn321_update_bw_bounding_box_fpu(dc, bw_params);
 
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
 
 static struct resource_funcs dcn321_res_pool_funcs = {
-- 
2.39.2


