Return-Path: <linux-kernel+bounces-356609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E334E99641C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 133DA1C24023
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BAE192D8E;
	Wed,  9 Oct 2024 08:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QxBjHlEv"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A65192B76
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 08:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728463893; cv=none; b=FnfYLKJWA+zVkWaPoNFONlqtrG8oS4qFfVsxcePY9eVEVVUTzkKpcsdvAcOKl3pQujV4mQo0XcYKQ+1QCJGqg5Mo1d46XB1bUXZqJVJ614d1zHoBvimp1M8Sa/jW4ihaVcW4z3y48AEu2iwS8N5H+8Tj/Fkt6dXdV9yRfFLtyWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728463893; c=relaxed/simple;
	bh=CZPvn+ixECCJlwEHRHraiyoiomUWWKsJjwFhygCQwTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tq8Bda0JbEg8fEpy6ByAYFkC8DcvuPoXgi+L+hWPX08UvN0ydG67B+4FbcjnS414cdYh5cig+6mVq/4sfPwoJbpYprwsOnI5ClVTj/dQ8pALtOxBeL07d7I2KZc3MtNBauliuhevG+HBfwiSL76VSb4cSOhbecDoh9Rp6THLO/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QxBjHlEv; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2bd0e2c4fso18199a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 01:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728463890; x=1729068690; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lBJlR6luuHJD2SBRXmS4TBrVXnItCuuwBx1jOrvel4A=;
        b=QxBjHlEvj8RB1yTY/w9SoPYl95cKwHKG5eHLhxj0vUwlkBR0G3qYL/bcBBi+o+BX8O
         uWXzEQsBDI9Q6EnWqJ0/0FKmnU8bKXMjNExejUZhB/9rQdeV/N2/AapSFULuDCLvZul6
         e4V3IsEbIMzd2kUdx6Sw44ecTJYH2+ZbGwJM/W+s5V4Hk3I0CSQfo4dggOxbWDrDEBf0
         yeRJRTKkeuk1Mcs8uVL2omu/bUQ1r0UG6jKZIE2ZhFA6A7xmbeJ4TRd4wr5aTj8CcPIx
         1492g0jxlsoMer1HTRWJR7+RyePTIwJqH78WP3EqKz+SSKdPoXdvjmVUBoKW2NPa1hIe
         7r9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728463890; x=1729068690;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBJlR6luuHJD2SBRXmS4TBrVXnItCuuwBx1jOrvel4A=;
        b=if5pNSjURE5o4xOoED1o2ElNcFk0SplF8kPPA3YBCIh/Y9CR8aJqu6bnTddHLnFkeI
         34xR6Pj3JdbcHFX6mOoBesmfrhapufOXbQTR1IijJuy1fkqS0Q7JR/ni3fibUKMwot9H
         nsnMUDem3oNrr8vopG5GMKmT+jjPgUqlCKqR4WR6jB04q2kzznwgQZjKwNMik2vI+Y4a
         uyz3QmG5VSggxdjMYxgfyCMFVoiF6q591VawdP3rT/AUMQa4I4BgnoaGvfOvGgFkAw90
         XVR2VW+kFzS3itpHtP5uUxf7iUJVbXGY1GzC9B2nSwpYUEJ84E40ohrkREnplIbK5mEY
         iXFA==
X-Forwarded-Encrypted: i=1; AJvYcCUxc69reusEIRR4IgnGKbrE8d/2UK5+7CAEzE4T++n9kN+8ciYpW+wQAUHP/nktqWAxyqlR/sw1wfLpQhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVicwwK6e0GXJFjew/cWbu2pXd5R8loPNiLYBrXxkXr4RKOOph
	ogJWXpb6dhXE0MFHpWpl0W4hgAtJ6yB1figoidXbba0L9+4HaQ2ccOakXcgcD5o=
X-Google-Smtp-Source: AGHT+IG66GziAUmgiUUsi3KTQJBC4gAlqvuDR119PyWGN/Diu92dHzPdmdutFYrMKyP3/PNQiJlbkA==
X-Received: by 2002:a17:90a:ce94:b0:2e2:7f8f:3ad7 with SMTP id 98e67ed59e1d1-2e2a21eeb54mr1854426a91.7.1728463889956;
        Wed, 09 Oct 2024 01:51:29 -0700 (PDT)
Received: from [127.0.1.1] ([112.65.12.217])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2abad236esm898157a91.10.2024.10.09.01.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 01:51:29 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Wed, 09 Oct 2024 16:50:25 +0800
Subject: [PATCH v2 12/14] drm/msm/dpu: support plane splitting in quad-pipe
 case
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-12-76d4f5d413bf@linaro.org>
References: <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-0-76d4f5d413bf@linaro.org>
In-Reply-To: <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-0-76d4f5d413bf@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jun Nie <jun.nie@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728463820; l=7922;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=CZPvn+ixECCJlwEHRHraiyoiomUWWKsJjwFhygCQwTY=;
 b=EHUAFkbmU3QeX8NKH88pnLfL76SKXBm4B7CBY7a1Ly9PBgUR2iMfPx/8K+/9vtilcuHatv8Y+
 JEN4cyXPL0WBGTTWsGHnXXvj5hBqCJvz6Olo107OIMCR07oRbbhEDWg
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

Clip plane into pipes per left and right half screen ROI if topology
is quad pipe. Then split the clipped rectangle by half if the rectangle
width still exceeds width limit.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c  |  7 +++
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h  |  6 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 99 ++++++++++++++++++++++---------
 3 files changed, 84 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 66f745399a602..d2aca0a9493d5 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1310,6 +1310,13 @@ int dpu_crtc_vblank(struct drm_crtc *crtc, bool en)
 	return 0;
 }
 
+unsigned int dpu_crtc_get_lm_num(const struct drm_crtc_state *state)
+{
+	struct dpu_crtc_state *cstate = to_dpu_crtc_state(state);
+
+	return cstate->num_mixers;
+}
+
 #ifdef CONFIG_DEBUG_FS
 static int _dpu_debugfs_status_show(struct seq_file *s, void *data)
 {
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
index 5260e2440f059..ee7cf71f89fc7 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
@@ -304,4 +304,10 @@ static inline enum dpu_crtc_client_type dpu_crtc_get_client_type(
 
 void dpu_crtc_frame_event_cb(struct drm_crtc *crtc, u32 event);
 
+/**
+ * dpu_crtc_get_lm_num - Get mixer number in this CRTC pipeline
+ * state: Pointer to drm crtc state object
+ */
+unsigned int dpu_crtc_get_lm_num(const struct drm_crtc_state *state);
+
 #endif /* _DPU_CRTC_H_ */
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index 898fc2937954e..480a1b46aba72 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -837,10 +837,12 @@ static int dpu_plane_atomic_check_nopipe(struct drm_plane *plane,
 	struct dpu_kms *kms = _dpu_plane_get_kms(&pdpu->base);
 	u64 max_mdp_clk_rate = kms->perf.max_core_clk_rate;
 	struct dpu_plane_state *pstate = to_dpu_plane_state(new_plane_state);
-	struct dpu_sw_pipe_cfg *pipe_cfg;
-	struct dpu_sw_pipe_cfg *r_pipe_cfg;
+	struct dpu_sw_pipe_cfg pipe_cfg;
 	struct drm_rect fb_rect = { 0 };
+	const struct drm_display_mode *mode = &crtc_state->adjusted_mode;
 	uint32_t max_linewidth;
+	u32 lm_num;
+	int lmcfg_id, lmcfg_num;
 
 	min_scale = FRAC_16_16(1, MAX_UPSCALE_RATIO);
 	max_scale = MAX_DOWNSCALE_RATIO << 16;
@@ -863,13 +865,10 @@ static int dpu_plane_atomic_check_nopipe(struct drm_plane *plane,
 		return -EINVAL;
 	}
 
-	/* move the assignment here, to ease handling to another pairs later */
-	pipe_cfg = &pstate->pipe_cfg[0];
-	r_pipe_cfg = &pstate->pipe_cfg[1];
-	/* state->src is 16.16, src_rect is not */
-	drm_rect_fp_to_int(&pipe_cfg->src_rect, &new_plane_state->src);
+	lm_num = dpu_crtc_get_lm_num(crtc_state);
 
-	pipe_cfg->dst_rect = new_plane_state->dst;
+	/* state->src is 16.16, src_rect is not */
+	drm_rect_fp_to_int(&pipe_cfg.src_rect, &new_plane_state->src);
 
 	fb_rect.x2 = new_plane_state->fb->width;
 	fb_rect.y2 = new_plane_state->fb->height;
@@ -884,34 +883,78 @@ static int dpu_plane_atomic_check_nopipe(struct drm_plane *plane,
 
 	max_linewidth = pdpu->catalog->caps->max_linewidth;
 
-	drm_rect_rotate(&pipe_cfg->src_rect,
+	drm_rect_rotate(&pipe_cfg.src_rect,
 			new_plane_state->fb->width, new_plane_state->fb->height,
 			new_plane_state->rotation);
 
-	if ((drm_rect_width(&pipe_cfg->src_rect) > max_linewidth) ||
-	     _dpu_plane_calc_clk(&crtc_state->adjusted_mode, pipe_cfg) > max_mdp_clk_rate) {
-		if (drm_rect_width(&pipe_cfg->src_rect) > 2 * max_linewidth) {
-			DPU_DEBUG_PLANE(pdpu, "invalid src " DRM_RECT_FMT " line:%u\n",
-					DRM_RECT_ARG(&pipe_cfg->src_rect), max_linewidth);
-			return -E2BIG;
+	/*
+	 * We have 1 mixer pair cfg for 1:1:1 and 2:2:1 topology, 2 mixer pair
+	 * configs for left and right half screen in case of 4:4:2 topology.
+	 * But we may have 2 rect to split plane with 1 config for 2:2:1.
+	 * So need to handle super wide plane splitting, and plane on right half
+	 * for quad-pipe case. Check dest rectangle left/right clipping
+	 * first, then check super wide rectangle splitting in every half next.
+	 */
+	lmcfg_num = (lm_num + 1) / 2;
+	/* iterate mixer configs for this plane, to separate left/right with the id */
+	for (lmcfg_id = 0; lmcfg_id < lmcfg_num; lmcfg_id++) {
+		struct drm_rect mixer_rect = {lmcfg_id * mode->hdisplay / lmcfg_num, 0,
+					(lmcfg_id + 1) * mode->hdisplay / lmcfg_num, mode->vdisplay};
+		int cfg_idx = lmcfg_id * PIPES_PER_LM_PAIR;
+		struct dpu_sw_pipe_cfg *cur_pipecfg = &pstate->pipe_cfg[cfg_idx];
+
+		drm_rect_fp_to_int(&cur_pipecfg->src_rect, &new_plane_state->src);
+		cur_pipecfg->dst_rect = new_plane_state->dst;
+
+		DPU_DEBUG_PLANE(pdpu, "checking src " DRM_RECT_FMT
+				" vs clip window " DRM_RECT_FMT "\n",
+				DRM_RECT_ARG(&cur_pipecfg->src_rect),
+				DRM_RECT_ARG(&mixer_rect));
+
+		/* If this plane does not fall into mixer rect, check next mixer rect */
+		if (!drm_rect_clip_scaled(&cur_pipecfg->src_rect, &cur_pipecfg->dst_rect, &mixer_rect)) {
+			memset(&pstate->pipe_cfg[cfg_idx], 0, 2 * sizeof(struct dpu_sw_pipe_cfg));
+			memset(&pstate->pipe[cfg_idx], 0, 2 * sizeof(struct dpu_sw_pipe));
+			continue;
 		}
 
-		*r_pipe_cfg = *pipe_cfg;
-		pipe_cfg->src_rect.x2 = (pipe_cfg->src_rect.x1 + pipe_cfg->src_rect.x2) >> 1;
-		pipe_cfg->dst_rect.x2 = (pipe_cfg->dst_rect.x1 + pipe_cfg->dst_rect.x2) >> 1;
-		r_pipe_cfg->src_rect.x1 = pipe_cfg->src_rect.x2;
-		r_pipe_cfg->dst_rect.x1 = pipe_cfg->dst_rect.x2;
-	} else {
-		memset(r_pipe_cfg, 0, sizeof(*r_pipe_cfg));
-	}
+		cur_pipecfg->valid = true;
+		cur_pipecfg->dst_rect.x1 -= mixer_rect.x1;
+		cur_pipecfg->dst_rect.x2 -= mixer_rect.x1;
+
+		DPU_DEBUG_PLANE(pdpu, "Got clip src:" DRM_RECT_FMT " dst: " DRM_RECT_FMT "\n",
+				DRM_RECT_ARG(&cur_pipecfg->src_rect), DRM_RECT_ARG(&cur_pipecfg->dst_rect));
+
+		/* Split super wide rect into 2 rect */
+		if ((drm_rect_width(&cur_pipecfg->src_rect) > max_linewidth) ||
+		     _dpu_plane_calc_clk(mode, cur_pipecfg) > max_mdp_clk_rate) {
+			struct dpu_sw_pipe_cfg *r_pipe_cfg = &pstate->pipe_cfg[cfg_idx + 1];
+
+			if (drm_rect_width(&cur_pipecfg->src_rect) > 2 * max_linewidth) {
+				DPU_DEBUG_PLANE(pdpu, "invalid src " DRM_RECT_FMT " line:%u\n",
+						DRM_RECT_ARG(&cur_pipecfg->src_rect), max_linewidth);
+				return -E2BIG;
+			}
+
+			memcpy(r_pipe_cfg, cur_pipecfg, sizeof(struct dpu_sw_pipe_cfg));
+			cur_pipecfg->src_rect.x2 = (cur_pipecfg->src_rect.x1 + cur_pipecfg->src_rect.x2) >> 1;
+			cur_pipecfg->dst_rect.x2 = (cur_pipecfg->dst_rect.x1 + cur_pipecfg->dst_rect.x2) >> 1;
+			r_pipe_cfg->src_rect.x1 = cur_pipecfg->src_rect.x2;
+			r_pipe_cfg->dst_rect.x1 = cur_pipecfg->dst_rect.x2;
+			r_pipe_cfg->valid = true;
+			DPU_DEBUG_PLANE(pdpu, "Split super wide plane into:"
+					DRM_RECT_FMT " and " DRM_RECT_FMT "\n",
+					DRM_RECT_ARG(&cur_pipecfg->src_rect),
+					DRM_RECT_ARG(&r_pipe_cfg->src_rect));
+		} else {
+			memset(&pstate->pipe_cfg[cfg_idx + 1], 0, sizeof(struct dpu_sw_pipe_cfg));
+			memset(&pstate->pipe[cfg_idx + 1], 0, sizeof(struct dpu_sw_pipe));
+		}
 
-	drm_rect_rotate_inv(&pipe_cfg->src_rect,
-			    new_plane_state->fb->width, new_plane_state->fb->height,
-			    new_plane_state->rotation);
-	if (drm_rect_width(&r_pipe_cfg->src_rect) != 0)
-		drm_rect_rotate_inv(&r_pipe_cfg->src_rect,
+		drm_rect_rotate_inv(&cur_pipecfg->src_rect,
 				    new_plane_state->fb->width, new_plane_state->fb->height,
 				    new_plane_state->rotation);
+	}
 
 	pstate->needs_qos_remap = drm_atomic_crtc_needs_modeset(crtc_state);
 

-- 
2.34.1


