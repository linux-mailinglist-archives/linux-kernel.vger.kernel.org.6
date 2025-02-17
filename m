Return-Path: <linux-kernel+bounces-517813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB355A385EF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 811987A255B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC1722259C;
	Mon, 17 Feb 2025 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yf8AV0OM"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE9E2248B8
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801868; cv=none; b=h29Ke0/DSGqx7YFiUT7v1yrL9eDo+OsUKkmLA0ib8aood+EkR2kv+EAjl1lklr7oWrpaj5ixippA1wYsz9Hq9vVEWtDhNttM70t1xyfn2Zd2qrgLpVkPQ5e3B9vcczbUkGN8PoM2/jWlv92/PDdECeqNcvSfm+31jg52dCM3swg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801868; c=relaxed/simple;
	bh=CMwjep3Ttk+3IAwsKedb6tkEBDGheQNAuAjS+mRm7GE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KA4Uz0mqENB8S6gJTBoWwqgV4vjlN1wQ4SaeL8pdkXT7pSFZYmVLXVeHllRuyKLp2MVCyIWl8IkDMKN/+oIUlAmZk1q8gujX6wg3D861SPmPCSa31/RW+kIAVn/7iiI0Kirq0z35wtDEBwncYiJwHS0XmVfuxvnl9ikOC8562uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yf8AV0OM; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220bfdfb3f4so90441355ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 06:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739801865; x=1740406665; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yl2Cy/3TkgHsjjs7WL8YSNhGNRkIYKIY+ZYHhQBu3kk=;
        b=yf8AV0OMPT0PuZ70zOQ1TPsNOrIu9N8F67AbAgLZ/PP7YhfcIeMHhGYM3XvshM6ujF
         CqmXQJR/+PZTjJO/yduia0gn8/YtTQr0uZRUCpFQU0Sq1mQMTK/Q2m7x8/Qx5ejUvdbC
         xoGfkm0DNnnszn1z7URIKdQ6Bu7/lh3gVYQ5NuJJpM3hAkO4H3RqQk1iPKJQZrzCVHUb
         tLu6TVAu1XzzZXCNj2wNAwPXCxwNXq2EFXpr3UpYqpdMsgb3QAX/qsbY8FAFnoCcEux0
         rkFwhroBJ0o8r8c8YV5Vm0J8qx8B6sS9Iiczk8BsU7lyD0STxiWAucBcIfF85fI5jDSJ
         x8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739801865; x=1740406665;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yl2Cy/3TkgHsjjs7WL8YSNhGNRkIYKIY+ZYHhQBu3kk=;
        b=xDz3jYnpG64/Mw5TgwW6o9TVQZ9IPrTMUBhAm9Y3mp/S+qSwKYUTHx4XV7wD/hTmkp
         SggXnMWLUBUYNH5WSf/Tt7BegE4+w6/Us2AtNhXDaMrC6etoJ7wP3o3w31b8Hz8GvSFR
         70GUm8Wjxw7sqkd5A1Q78jSOltiQp5IITaa7HlZu2vr1cRK1/e/Do25q8unfTV3CMQ6F
         v+dcBUHjbnP4lZSmvX/FcDKCXTMGSvCGjLSYnfjaAMAm0DYiFRlH3CFKQpAnOzJ7zyNP
         p+N4ZIuB1K0MJjMAXj3Rj7OqHXysyakveGEEayqCmNZYSMTmCDnVeWkBP8D83t5Ceuo3
         9MZg==
X-Forwarded-Encrypted: i=1; AJvYcCX74SbP5c6B8MApMRMEiFAacADoD97CU5U8zJKQxUAWOiRJ40vh536oIrK4W0vUjvXd2mYErbuZY9UVFbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVT9pWoJBHLTNGcMxOlIuKdScWod6NPyqQU6OAcveh/KI7LxQD
	b4cEN5CmKcUQCezm6Ljy4WItVuxPEgLVTAt58+bcNRlninkmRHo3y+wALhMlTZf0LHEzevFQ67G
	bUSAncQ==
X-Gm-Gg: ASbGncv1jgln5lI7Lts83Cz/izX1YIzqgQllW/xdfmCzEgOGt1XSUIt6kdwZMe0nJpB
	/b5gPMKBD7f1h6kvYZRic5UJBxO0zudIE86ccjyXKymFaFor4spOqCmkW6FIbHqtMuAEIGMQPpM
	hu8aFWNOYXbHtxIIEDUUHejzcndOvVsomCnsL1KUcV2pOoe2yDDt6WC6IZeT2mlsTVbmrXm65d4
	7ATaBLzJnwm0md7SHAPLhWcJ9JNAgYWoDHR0gqF6J3rc4x8fcyOl4E6DpPVQO/K+j6HZce7ty39
	bEXLOMQgbzXe
X-Google-Smtp-Source: AGHT+IHvImrP1ufK5qK/GFymm5+h9exelf7tqGGe8S68IeCggnkCx8RtxUdqRRnREn7dxYQvMhOeqw==
X-Received: by 2002:a17:903:2b07:b0:220:e792:8456 with SMTP id d9443c01a7336-22103efec11mr162049065ad.11.1739801865433;
        Mon, 17 Feb 2025 06:17:45 -0800 (PST)
Received: from [127.0.1.1] ([112.65.12.217])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5366984sm71900845ad.60.2025.02.17.06.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 06:17:45 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
Date: Mon, 17 Feb 2025 22:15:59 +0800
Subject: [PATCH v6 10/15] drm/msm/dpu: handle pipes as array
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-10-c11402574367@linaro.org>
References: <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-0-c11402574367@linaro.org>
In-Reply-To: <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-0-c11402574367@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jun Nie <jun.nie@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739801787; l=16749;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=CMwjep3Ttk+3IAwsKedb6tkEBDGheQNAuAjS+mRm7GE=;
 b=NDq4HS0Ybm7C5hJeU8Co9jMZQ7OSs1Ahyt35ZhsaxA3FXp8RtRom8ehylzwFc7M6EdBurJs0j
 KnPWldgY2dqBIM2+cdrQOcYLTisaYbbX5qAtSGNhHPgdDA+1mx3eV1J
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

There are 2 pipes in a drm plane at most currently, while 4 pipes are
required for quad-pipe case. Generalize the handling to pipe pair and
ease handling to another pipe pair later. Store pipes in array with
removing dedicated r_pipe.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c  |  35 +++----
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 169 +++++++++++++++++-------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h |  12 +--
 3 files changed, 113 insertions(+), 103 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 05abe2d05d8d81fbaac58cf0b298abb8d2164735..193818b02197d0737c86de7765d98732fa914e8e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -442,7 +442,7 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
 	const struct msm_format *format;
 	struct dpu_hw_ctl *ctl = mixer->lm_ctl;
 
-	uint32_t lm_idx;
+	uint32_t lm_idx, i;
 	bool bg_alpha_enable = false;
 	DECLARE_BITMAP(fetch_active, SSPP_MAX);
 
@@ -463,20 +463,15 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
 		if (pstate->stage == DPU_STAGE_BASE && format->alpha_enable)
 			bg_alpha_enable = true;
 
-		set_bit(pstate->pipe.sspp->idx, fetch_active);
-		_dpu_crtc_blend_setup_pipe(crtc, plane,
-					   mixer, cstate->num_mixers,
-					   pstate->stage,
-					   format, fb ? fb->modifier : 0,
-					   &pstate->pipe, 0, stage_cfg);
-
-		if (pstate->r_pipe.sspp) {
-			set_bit(pstate->r_pipe.sspp->idx, fetch_active);
+		for (i = 0; i < PIPES_PER_STAGE; i++) {
+			if (!pstate->pipe[i].sspp)
+				continue;
+			set_bit(pstate->pipe[i].sspp->idx, fetch_active);
 			_dpu_crtc_blend_setup_pipe(crtc, plane,
 						   mixer, cstate->num_mixers,
 						   pstate->stage,
 						   format, fb ? fb->modifier : 0,
-						   &pstate->r_pipe, 1, stage_cfg);
+						   &pstate->pipe[i], i, stage_cfg);
 		}
 
 		/* blend config update */
@@ -1440,15 +1435,15 @@ static int _dpu_debugfs_status_show(struct seq_file *s, void *data)
 		seq_printf(s, "\tdst x:%4d dst_y:%4d dst_w:%4d dst_h:%4d\n",
 			state->crtc_x, state->crtc_y, state->crtc_w,
 			state->crtc_h);
-		seq_printf(s, "\tsspp[0]:%s\n",
-			   pstate->pipe.sspp->cap->name);
-		seq_printf(s, "\tmultirect[0]: mode: %d index: %d\n",
-			pstate->pipe.multirect_mode, pstate->pipe.multirect_index);
-		if (pstate->r_pipe.sspp) {
-			seq_printf(s, "\tsspp[1]:%s\n",
-				   pstate->r_pipe.sspp->cap->name);
-			seq_printf(s, "\tmultirect[1]: mode: %d index: %d\n",
-				   pstate->r_pipe.multirect_mode, pstate->r_pipe.multirect_index);
+
+		for (i = 0; i < PIPES_PER_STAGE; i++) {
+			if (!pstate->pipe[i].sspp)
+				continue;
+			seq_printf(s, "\tsspp[%d]:%s\n",
+				   i, pstate->pipe[i].sspp->cap->name);
+			seq_printf(s, "\tmultirect[%d]: mode: %d index: %d\n",
+				   i, pstate->pipe[i].multirect_mode,
+				   pstate->pipe[i].multirect_index);
 		}
 
 		seq_puts(s, "\n");
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index feb90c42fef58f3385625f6d8165bfcdabf46d2d..ef44af5ab681c8f526333fa92531a2225983aa09 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -619,6 +619,7 @@ static void _dpu_plane_color_fill(struct dpu_plane *pdpu,
 	struct msm_drm_private *priv = plane->dev->dev_private;
 	struct dpu_plane_state *pstate = to_dpu_plane_state(plane->state);
 	u32 fill_color = (color & 0xFFFFFF) | ((alpha & 0xFF) << 24);
+	int i;
 
 	DPU_DEBUG_PLANE(pdpu, "\n");
 
@@ -632,12 +633,13 @@ static void _dpu_plane_color_fill(struct dpu_plane *pdpu,
 		return;
 
 	/* update sspp */
-	_dpu_plane_color_fill_pipe(pstate, &pstate->pipe, &pstate->pipe_cfg.dst_rect,
-				   fill_color, fmt);
-
-	if (pstate->r_pipe.sspp)
-		_dpu_plane_color_fill_pipe(pstate, &pstate->r_pipe, &pstate->r_pipe_cfg.dst_rect,
+	for (i = 0; i < PIPES_PER_STAGE; i++) {
+		if (!pstate->pipe[i].sspp)
+			continue;
+		_dpu_plane_color_fill_pipe(pstate, &pstate->pipe[i],
+					   &pstate->pipe_cfg[i].dst_rect,
 					   fill_color, fmt);
+	}
 }
 
 static int dpu_plane_prepare_fb(struct drm_plane *plane,
@@ -827,8 +829,8 @@ static int dpu_plane_atomic_check_nosspp(struct drm_plane *plane,
 	struct dpu_kms *kms = _dpu_plane_get_kms(&pdpu->base);
 	u64 max_mdp_clk_rate = kms->perf.max_core_clk_rate;
 	struct dpu_plane_state *pstate = to_dpu_plane_state(new_plane_state);
-	struct dpu_sw_pipe_cfg *pipe_cfg = &pstate->pipe_cfg;
-	struct dpu_sw_pipe_cfg *r_pipe_cfg = &pstate->r_pipe_cfg;
+	struct dpu_sw_pipe_cfg *pipe_cfg;
+	struct dpu_sw_pipe_cfg *r_pipe_cfg;
 	struct drm_rect fb_rect = { 0 };
 	uint32_t max_linewidth;
 
@@ -853,6 +855,9 @@ static int dpu_plane_atomic_check_nosspp(struct drm_plane *plane,
 		return -EINVAL;
 	}
 
+	/* move the assignment here, to ease handling to another pairs later */
+	pipe_cfg = &pstate->pipe_cfg[0];
+	r_pipe_cfg = &pstate->pipe_cfg[1];
 	/* state->src is 16.16, src_rect is not */
 	drm_rect_fp_to_int(&pipe_cfg->src_rect, &new_plane_state->src);
 
@@ -949,10 +954,10 @@ static int dpu_plane_atomic_check_sspp(struct drm_plane *plane,
 		drm_atomic_get_new_plane_state(state, plane);
 	struct dpu_plane *pdpu = to_dpu_plane(plane);
 	struct dpu_plane_state *pstate = to_dpu_plane_state(new_plane_state);
-	struct dpu_sw_pipe *pipe = &pstate->pipe;
-	struct dpu_sw_pipe *r_pipe = &pstate->r_pipe;
-	struct dpu_sw_pipe_cfg *pipe_cfg = &pstate->pipe_cfg;
-	struct dpu_sw_pipe_cfg *r_pipe_cfg = &pstate->r_pipe_cfg;
+	struct dpu_sw_pipe *pipe = &pstate->pipe[0];
+	struct dpu_sw_pipe *r_pipe = &pstate->pipe[1];
+	struct dpu_sw_pipe_cfg *pipe_cfg = &pstate->pipe_cfg[0];
+	struct dpu_sw_pipe_cfg *r_pipe_cfg = &pstate->pipe_cfg[1];
 	int ret = 0;
 
 	ret = dpu_plane_atomic_check_pipe(pdpu, pipe, pipe_cfg,
@@ -1011,10 +1016,10 @@ static int dpu_plane_atomic_check(struct drm_plane *plane,
 	struct dpu_plane *pdpu = to_dpu_plane(plane);
 	struct dpu_plane_state *pstate = to_dpu_plane_state(new_plane_state);
 	struct dpu_kms *dpu_kms = _dpu_plane_get_kms(plane);
-	struct dpu_sw_pipe *pipe = &pstate->pipe;
-	struct dpu_sw_pipe *r_pipe = &pstate->r_pipe;
-	struct dpu_sw_pipe_cfg *pipe_cfg = &pstate->pipe_cfg;
-	struct dpu_sw_pipe_cfg *r_pipe_cfg = &pstate->r_pipe_cfg;
+	struct dpu_sw_pipe *pipe = &pstate->pipe[0];
+	struct dpu_sw_pipe *r_pipe = &pstate->pipe[1];
+	struct dpu_sw_pipe_cfg *pipe_cfg = &pstate->pipe_cfg[0];
+	struct dpu_sw_pipe_cfg *r_pipe_cfg = &pstate->pipe_cfg[1];
 	const struct drm_crtc_state *crtc_state = NULL;
 	uint32_t max_linewidth = dpu_kms->catalog->caps->max_linewidth;
 
@@ -1058,7 +1063,7 @@ static int dpu_plane_virtual_atomic_check(struct drm_plane *plane,
 		drm_atomic_get_old_plane_state(state, plane);
 	struct dpu_plane_state *pstate = to_dpu_plane_state(plane_state);
 	struct drm_crtc_state *crtc_state;
-	int ret;
+	int ret, i;
 
 	if (plane_state->crtc)
 		crtc_state = drm_atomic_get_new_crtc_state(state,
@@ -1073,8 +1078,8 @@ static int dpu_plane_virtual_atomic_check(struct drm_plane *plane,
 		 * resources are freed by dpu_crtc_assign_plane_resources(),
 		 * but clean them here.
 		 */
-		pstate->pipe.sspp = NULL;
-		pstate->r_pipe.sspp = NULL;
+		for (i = 0; i < PIPES_PER_STAGE; i++)
+			pstate->pipe[i].sspp = NULL;
 
 		return 0;
 	}
@@ -1111,19 +1116,21 @@ static int dpu_plane_virtual_assign_resources(struct drm_crtc *crtc,
 	struct dpu_sw_pipe_cfg *pipe_cfg;
 	struct dpu_sw_pipe_cfg *r_pipe_cfg;
 	const struct msm_format *fmt;
+	int i;
 
 	if (plane_state->crtc)
 		crtc_state = drm_atomic_get_new_crtc_state(state,
 							   plane_state->crtc);
 
 	pstate = to_dpu_plane_state(plane_state);
-	pipe = &pstate->pipe;
-	r_pipe = &pstate->r_pipe;
-	pipe_cfg = &pstate->pipe_cfg;
-	r_pipe_cfg = &pstate->r_pipe_cfg;
 
-	pipe->sspp = NULL;
-	r_pipe->sspp = NULL;
+	pipe = &pstate->pipe[0];
+	r_pipe = &pstate->pipe[1];
+	pipe_cfg = &pstate->pipe_cfg[0];
+	r_pipe_cfg = &pstate->pipe_cfg[1];
+
+	for (i = 0; i < PIPES_PER_STAGE; i++)
+		pstate->pipe[i].sspp = NULL;
 
 	if (!plane_state->fb)
 		return -EINVAL;
@@ -1213,6 +1220,7 @@ void dpu_plane_flush(struct drm_plane *plane)
 {
 	struct dpu_plane *pdpu;
 	struct dpu_plane_state *pstate;
+	int i;
 
 	if (!plane || !plane->state) {
 		DPU_ERROR("invalid plane\n");
@@ -1233,8 +1241,8 @@ void dpu_plane_flush(struct drm_plane *plane)
 		/* force 100% alpha */
 		_dpu_plane_color_fill(pdpu, pdpu->color_fill, 0xFF);
 	else {
-		dpu_plane_flush_csc(pdpu, &pstate->pipe);
-		dpu_plane_flush_csc(pdpu, &pstate->r_pipe);
+		for (i = 0; i < PIPES_PER_STAGE; i++)
+			dpu_plane_flush_csc(pdpu, &pstate->pipe[i]);
 	}
 
 	/* flag h/w flush complete */
@@ -1335,15 +1343,12 @@ static void dpu_plane_sspp_atomic_update(struct drm_plane *plane,
 	struct dpu_plane *pdpu = to_dpu_plane(plane);
 	struct drm_plane_state *state = plane->state;
 	struct dpu_plane_state *pstate = to_dpu_plane_state(state);
-	struct dpu_sw_pipe *pipe = &pstate->pipe;
-	struct dpu_sw_pipe *r_pipe = &pstate->r_pipe;
 	struct drm_crtc *crtc = state->crtc;
 	struct drm_framebuffer *fb = state->fb;
 	bool is_rt_pipe;
 	const struct msm_format *fmt =
 		msm_framebuffer_format(fb);
-	struct dpu_sw_pipe_cfg *pipe_cfg = &pstate->pipe_cfg;
-	struct dpu_sw_pipe_cfg *r_pipe_cfg = &pstate->r_pipe_cfg;
+	int i;
 
 	pstate->pending = true;
 
@@ -1358,12 +1363,12 @@ static void dpu_plane_sspp_atomic_update(struct drm_plane *plane,
 			crtc->base.id, DRM_RECT_ARG(&state->dst),
 			&fmt->pixel_format, MSM_FORMAT_IS_UBWC(fmt));
 
-	dpu_plane_sspp_update_pipe(plane, pipe, pipe_cfg, fmt,
-				   drm_mode_vrefresh(&crtc->mode),
-				   &pstate->layout);
-
-	if (r_pipe->sspp) {
-		dpu_plane_sspp_update_pipe(plane, r_pipe, r_pipe_cfg, fmt,
+	/* move the assignment here, to ease handling to another pairs later */
+	for (i = 0; i < PIPES_PER_STAGE; i++) {
+		if (!pstate->pipe[i].sspp)
+			continue;
+		dpu_plane_sspp_update_pipe(plane, &pstate->pipe[i],
+					   &pstate->pipe_cfg[i], fmt,
 					   drm_mode_vrefresh(&crtc->mode),
 					   &pstate->layout);
 	}
@@ -1371,15 +1376,17 @@ static void dpu_plane_sspp_atomic_update(struct drm_plane *plane,
 	if (pstate->needs_qos_remap)
 		pstate->needs_qos_remap = false;
 
-	pstate->plane_fetch_bw = _dpu_plane_calc_bw(pdpu->catalog, fmt,
-						    &crtc->mode, pipe_cfg);
-
-	pstate->plane_clk = _dpu_plane_calc_clk(&crtc->mode, pipe_cfg);
-
-	if (r_pipe->sspp) {
-		pstate->plane_fetch_bw += _dpu_plane_calc_bw(pdpu->catalog, fmt, &crtc->mode, r_pipe_cfg);
+	pstate->plane_fetch_bw = 0;
+	pstate->plane_clk = 0;
+	for (i = 0; i < PIPES_PER_STAGE; i++) {
+		if (!pstate->pipe[i].sspp)
+			continue;
+		pstate->plane_fetch_bw += _dpu_plane_calc_bw(pdpu->catalog, fmt,
+							     &crtc->mode, &pstate->pipe_cfg[i]);
 
-		pstate->plane_clk = max(pstate->plane_clk, _dpu_plane_calc_clk(&crtc->mode, r_pipe_cfg));
+		pstate->plane_clk = max(pstate->plane_clk,
+					_dpu_plane_calc_clk(&crtc->mode,
+							    &pstate->pipe_cfg[i]));
 	}
 }
 
@@ -1387,17 +1394,31 @@ static void _dpu_plane_atomic_disable(struct drm_plane *plane)
 {
 	struct drm_plane_state *state = plane->state;
 	struct dpu_plane_state *pstate = to_dpu_plane_state(state);
-	struct dpu_sw_pipe *r_pipe = &pstate->r_pipe;
+	struct dpu_sw_pipe *pipe;
+	int i;
 
-	trace_dpu_plane_disable(DRMID(plane), false,
-				pstate->pipe.multirect_mode);
+	for (i = 0; i < PIPES_PER_STAGE; i += 1) {
+		pipe = &pstate->pipe[i];
+		if (!pipe->sspp)
+			continue;
 
-	if (r_pipe->sspp) {
-		r_pipe->multirect_index = DPU_SSPP_RECT_SOLO;
-		r_pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
+		trace_dpu_plane_disable(DRMID(plane), false,
+					pstate->pipe[i].multirect_mode);
+
+		if (!pipe->sspp)
+			continue;
 
-		if (r_pipe->sspp->ops.setup_multirect)
-			r_pipe->sspp->ops.setup_multirect(r_pipe);
+		if (i % PIPES_PER_STAGE == 0)
+			continue;
+
+		/*
+		 * clear multirect for the right pipe so that the SSPP
+		 * can be further reused in the solo mode
+		 */
+		pipe->multirect_index = DPU_SSPP_RECT_SOLO;
+		pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
+		if (pipe->sspp->ops.setup_multirect)
+			pipe->sspp->ops.setup_multirect(pipe);
 	}
 
 	pstate->pending = true;
@@ -1492,31 +1513,26 @@ static void dpu_plane_atomic_print_state(struct drm_printer *p,
 		const struct drm_plane_state *state)
 {
 	const struct dpu_plane_state *pstate = to_dpu_plane_state(state);
-	const struct dpu_sw_pipe *pipe = &pstate->pipe;
-	const struct dpu_sw_pipe_cfg *pipe_cfg = &pstate->pipe_cfg;
-	const struct dpu_sw_pipe *r_pipe = &pstate->r_pipe;
-	const struct dpu_sw_pipe_cfg *r_pipe_cfg = &pstate->r_pipe_cfg;
+	const struct dpu_sw_pipe *pipe;
+	const struct dpu_sw_pipe_cfg *pipe_cfg;
+	int i;
 
 	drm_printf(p, "\tstage=%d\n", pstate->stage);
 
-	if (pipe->sspp) {
-		drm_printf(p, "\tsspp[0]=%s\n", pipe->sspp->cap->name);
-		drm_printf(p, "\tmultirect_mode[0]=%s\n",
+	for (i = 0; i < PIPES_PER_STAGE; i++) {
+		pipe = &pstate->pipe[i];
+		if (!pipe->sspp)
+			continue;
+		pipe_cfg = &pstate->pipe_cfg[i];
+		drm_printf(p, "\tsspp[%d]=%s\n", i, pipe->sspp->cap->name);
+		drm_printf(p, "\tmultirect_mode[%d]=%s\n", i,
 			   dpu_get_multirect_mode(pipe->multirect_mode));
-		drm_printf(p, "\tmultirect_index[0]=%s\n",
+		drm_printf(p, "\tmultirect_index[%d]=%s\n", i,
 			   dpu_get_multirect_index(pipe->multirect_index));
-		drm_printf(p, "\tsrc[0]=" DRM_RECT_FMT "\n", DRM_RECT_ARG(&pipe_cfg->src_rect));
-		drm_printf(p, "\tdst[0]=" DRM_RECT_FMT "\n", DRM_RECT_ARG(&pipe_cfg->dst_rect));
-	}
-
-	if (r_pipe->sspp) {
-		drm_printf(p, "\tsspp[1]=%s\n", r_pipe->sspp->cap->name);
-		drm_printf(p, "\tmultirect_mode[1]=%s\n",
-			   dpu_get_multirect_mode(r_pipe->multirect_mode));
-		drm_printf(p, "\tmultirect_index[1]=%s\n",
-			   dpu_get_multirect_index(r_pipe->multirect_index));
-		drm_printf(p, "\tsrc[1]=" DRM_RECT_FMT "\n", DRM_RECT_ARG(&r_pipe_cfg->src_rect));
-		drm_printf(p, "\tdst[1]=" DRM_RECT_FMT "\n", DRM_RECT_ARG(&r_pipe_cfg->dst_rect));
+		drm_printf(p, "\tsrc[%d]=" DRM_RECT_FMT "\n", i,
+			   DRM_RECT_ARG(&pipe_cfg->src_rect));
+		drm_printf(p, "\tdst[%d]=" DRM_RECT_FMT "\n", i,
+			   DRM_RECT_ARG(&pipe_cfg->dst_rect));
 	}
 }
 
@@ -1554,14 +1570,17 @@ void dpu_plane_danger_signal_ctrl(struct drm_plane *plane, bool enable)
 	struct dpu_plane *pdpu = to_dpu_plane(plane);
 	struct dpu_plane_state *pstate = to_dpu_plane_state(plane->state);
 	struct dpu_kms *dpu_kms = _dpu_plane_get_kms(plane);
+	int i;
 
 	if (!pdpu->is_rt_pipe)
 		return;
 
 	pm_runtime_get_sync(&dpu_kms->pdev->dev);
-	_dpu_plane_set_qos_ctrl(plane, &pstate->pipe, enable);
-	if (pstate->r_pipe.sspp)
-		_dpu_plane_set_qos_ctrl(plane, &pstate->r_pipe, enable);
+	for (i = 0; i < PIPES_PER_STAGE; i++) {
+		if (!pstate->pipe[i].sspp)
+			continue;
+		_dpu_plane_set_qos_ctrl(plane, &pstate->pipe[i], enable);
+	}
 	pm_runtime_put_sync(&dpu_kms->pdev->dev);
 }
 #endif
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h
index acd5725175cdde4fcf7a9f71bb446251c5a14d22..052fd046e8463855b16b30389c2efc67c0c15281 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h
@@ -18,10 +18,8 @@
  * struct dpu_plane_state: Define dpu extension of drm plane state object
  * @base:	base drm plane state object
  * @aspace:	pointer to address space for input/output buffers
- * @pipe:	software pipe description
- * @r_pipe:	software pipe description of the second pipe
- * @pipe_cfg:	software pipe configuration
- * @r_pipe_cfg:	software pipe configuration for the second pipe
+ * @pipe:	software pipe description array
+ * @pipe_cfg:	software pipe configuration array
  * @stage:	assigned by crtc blender
  * @needs_qos_remap: qos remap settings need to be updated
  * @multirect_index: index of the rectangle of SSPP
@@ -35,10 +33,8 @@
 struct dpu_plane_state {
 	struct drm_plane_state base;
 	struct msm_gem_address_space *aspace;
-	struct dpu_sw_pipe pipe;
-	struct dpu_sw_pipe r_pipe;
-	struct dpu_sw_pipe_cfg pipe_cfg;
-	struct dpu_sw_pipe_cfg r_pipe_cfg;
+	struct dpu_sw_pipe pipe[PIPES_PER_STAGE];
+	struct dpu_sw_pipe_cfg pipe_cfg[PIPES_PER_STAGE];
 	enum dpu_stage stage;
 	bool needs_qos_remap;
 	bool pending;

-- 
2.34.1


