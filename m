Return-Path: <linux-kernel+bounces-542026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEA7A4C4CA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ECD018863A9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7726B22B8B6;
	Mon,  3 Mar 2025 15:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jYFHKKk3"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C5422B59B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741014989; cv=none; b=g0GEnBS0wJ3ra2uc5pT0KIY5qp/yV3iKJjK2Qy4FbEnqLOI8SYjH7d+SpCXFy7zf0LIjJJ4PcN1FP4gtPk+ijQOR2j3zgvvZp/bYDt9f0pP9fyszBxBzZtYB7g/NPlIp+pBMycqBzX36WeuY4U7F/HFLf27SVaGmIB3uCIZheCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741014989; c=relaxed/simple;
	bh=LlIwaPbf+HH4PxIPS5YpJQVYFDplXAqOUs0Fqhpinbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VOuNLfW8ZaO1feKjebyp6H02nNIUnBiJBdnHEdqsRjz84cXTkXmH5c3uPpyf5zfjYeLxiUD+WjRkmwOoRjuJWZUs4QV+5QYk18FznSMF5ROZUdQ5WMu3kjq8Q5oPVYwvmE1quVe7xwXvdWRwVcYyKXPfST3lMjNO2n29K5QicbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jYFHKKk3; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2233622fdffso87255785ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 07:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741014987; x=1741619787; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oc++QhoQONQQQCVNdB+FMhEMF6g1pjddZJUkAMQAE8Q=;
        b=jYFHKKk30RhlAnZoAr1FM/+325rc39RvS+bJ4wqshWy8FpEFn26z3PaXpr1UIBJQNC
         G/tasjbbbqqP/VWl80PwLWp6ihGV1CkowdjAqrTGy1wadSfFTF+MicJwYvXgebXwtDKR
         GQKHT67hPa+fGOcC2gJzAWRHguQ+xY4X5V3gydfVwhz1uPewTwBV/M+gEe7eqsWBmYI6
         Pn+outNw53um5My8oU5P03tJiDpx3H+6Sv2DeW5ZfJZGSpGHo5/toZ4BBnlbM0Gk41sn
         NwcuJNddSi/A9bLx5mbdm4qnKduiQldPYzU8Rc2p+uwOuVDeV/dr15asl5Y20GwlQ65y
         F4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741014987; x=1741619787;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oc++QhoQONQQQCVNdB+FMhEMF6g1pjddZJUkAMQAE8Q=;
        b=d05tC8GaYcc1P4XK3AVhPQY80Qj8oCxNafUZUbRH14+DH6c5nmYYjkxwn+9jcXIG1+
         Dthk7r6UU3HYRh8u8x34svDMB9c81sEyVSWEwISx4zq7fMFMhHx02MISnjeFxLzOyPyM
         B/4ZAm6DE4gN+l+Hn3uVJPAwDbwDaXw60t7gvyxDI0bmxm+M95XG1Xps+drhTaE20Wv7
         vw/57sb3TJ9nNJ9VA1o53FlkUYdCtzt8LA1etTIOoVKGJmQ0KHYbbI8XrQhOtUlWPISj
         LtlT71O7oauUHd+n6m2kErVME3LNeQDnfqS/NWaEMt05jU6Gly/J1Q+4DNBpcVxqIjV4
         kLvg==
X-Forwarded-Encrypted: i=1; AJvYcCXeEF5w3rxI6tDdnMOorWNg47lP45aBMIPzQEQPL9RJiQVHamFukJmq8a1ZgQSL88N+DHjMg8ttB1UixM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGZvsb2IkluMccKqhA8Fzry8ZxhJIFgATFnZ4zIRBwHkNIheW8
	FRMVJmvilCPO31tnf3ruuBHXxIhtjN48H/7ve3qlCSfshyvSc9/dMUcUB9Se7NyH6J0sOkAIqeL
	dSx6PuQ==
X-Gm-Gg: ASbGncvnvtmYXYrCyQud9/v8E7mxNeGkeLfLa8YUUpqitHD5Oe2D5b34D4yKyJw/0uy
	f9rF8z6rjo5ViHi1g50nkEahUdeDmPJTQevHIbjG5XtBMfDbWf0z0v1rs80XyXwIz6hEUSd7t70
	E25GLNEKQdmn2c/QtH0wmJxgzNI+eMevRy2TCckuPy7CnY0ZO34oFK9YobkSMCgnl1lVo2HBVHa
	qaxaEF6ObMBlV/gvN0aVinSgSpNgSzpPKezT+QSYGQJCeah3h0dps397+UBZQ8DIysPdCMoSAxk
	EmCciZK8QgoeZZ7IiU1M2+sbwBa8FTNlDx47Ui5vtg==
X-Google-Smtp-Source: AGHT+IEQ1Nt1JrCf0bwlq18Plfv2BqciVq5ZCffMRG6l18kBCkJrsK8W6/j7WRECwgn7DzJ5aCF0og==
X-Received: by 2002:a17:903:2b04:b0:21f:564:80a4 with SMTP id d9443c01a7336-22369258510mr206358145ad.33.1741014987121;
        Mon, 03 Mar 2025 07:16:27 -0800 (PST)
Received: from [127.0.1.1] ([112.64.60.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736584b3cffsm1851984b3a.4.2025.03.03.07.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:16:26 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
Date: Mon, 03 Mar 2025 23:14:43 +0800
Subject: [PATCH v8 14/15] drm/msm/dpu: support plane splitting in quad-pipe
 case
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v8-14-eb5df105c807@linaro.org>
References: <20250303-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v8-0-eb5df105c807@linaro.org>
In-Reply-To: <20250303-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v8-0-eb5df105c807@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741014878; l=8117;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=LlIwaPbf+HH4PxIPS5YpJQVYFDplXAqOUs0Fqhpinbc=;
 b=65k4ibLc2eCRC7auWYBTqrfiZpe0w4E5Vyt+kuqg8k4OoqoFZEImy8xPHhV01T4M2plezRqgJ
 7wx7dmAHRZWDFPhet31ew/Mp4ivBxFkt/SYVTfTrFwrVCGzAbcnefcr
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

The content of every half of screen is sent out via one interface in
dual-DSI case. The content for every interface is blended by a LM
pair in quad-pipe case, thus a LM pair should not blend any content
that cross the half of screen in this case. Clip plane into pipes per
left and right half screen ROI if topology is quad pipe case.

The clipped rectangle on every half of screen is futher handled by two
pipes if its width exceeds a limit for a single pipe.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 134 +++++++++++++++++++++---------
 1 file changed, 94 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index 0245f158881b5c37fffb75d78c75310ba446a0b7..850ce3a59f4dad0d1a6d6fcc3dc95a5ae00afd45 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -831,8 +831,12 @@ static int dpu_plane_atomic_check_nosspp(struct drm_plane *plane,
 	struct dpu_plane_state *pstate = to_dpu_plane_state(new_plane_state);
 	struct dpu_sw_pipe_cfg *pipe_cfg;
 	struct dpu_sw_pipe_cfg *r_pipe_cfg;
+	struct dpu_sw_pipe_cfg init_pipe_cfg;
 	struct drm_rect fb_rect = { 0 };
+	const struct drm_display_mode *mode = &crtc_state->adjusted_mode;
 	uint32_t max_linewidth;
+	u32 num_lm;
+	int stage_id, num_stages;
 
 	min_scale = FRAC_16_16(1, MAX_UPSCALE_RATIO);
 	max_scale = MAX_DOWNSCALE_RATIO << 16;
@@ -855,13 +859,10 @@ static int dpu_plane_atomic_check_nosspp(struct drm_plane *plane,
 		return -EINVAL;
 	}
 
-	/* move the assignment here, to ease handling to another pairs later */
-	pipe_cfg = &pstate->pipe_cfg[0];
-	r_pipe_cfg = &pstate->pipe_cfg[1];
-	/* state->src is 16.16, src_rect is not */
-	drm_rect_fp_to_int(&pipe_cfg->src_rect, &new_plane_state->src);
+	num_lm = dpu_crtc_get_num_lm(crtc_state);
 
-	pipe_cfg->dst_rect = new_plane_state->dst;
+	/* state->src is 16.16, src_rect is not */
+	drm_rect_fp_to_int(&init_pipe_cfg.src_rect, &new_plane_state->src);
 
 	fb_rect.x2 = new_plane_state->fb->width;
 	fb_rect.y2 = new_plane_state->fb->height;
@@ -886,35 +887,91 @@ static int dpu_plane_atomic_check_nosspp(struct drm_plane *plane,
 
 	max_linewidth = pdpu->catalog->caps->max_linewidth;
 
-	drm_rect_rotate(&pipe_cfg->src_rect,
+	drm_rect_rotate(&init_pipe_cfg.src_rect,
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
+	 * But we may have 2 rect to split wide plane that exceeds limit with 1
+	 * config for 2:2:1. So need to handle both wide plane splitting, and
+	 * two halves of screen splitting for quad-pipe case. Check dest
+	 * rectangle left/right clipping first, then check wide rectangle
+	 * splitting in every half next.
+	 */
+	num_stages = (num_lm + 1) / 2;
+	/* iterate mixer configs for this plane, to separate left/right with the id */
+	for (stage_id = 0; stage_id < num_stages; stage_id++) {
+		struct drm_rect mixer_rect = {stage_id * mode->hdisplay / num_stages, 0,
+					(stage_id + 1) * mode->hdisplay / num_stages,
+					mode->vdisplay};
+		int cfg_idx = stage_id * PIPES_PER_STAGE;
+
+		pipe_cfg = &pstate->pipe_cfg[cfg_idx];
+		r_pipe_cfg = &pstate->pipe_cfg[cfg_idx + 1];
+
+		drm_rect_fp_to_int(&pipe_cfg->src_rect, &new_plane_state->src);
+		pipe_cfg->dst_rect = new_plane_state->dst;
+
+		DPU_DEBUG_PLANE(pdpu, "checking src " DRM_RECT_FMT
+				" vs clip window " DRM_RECT_FMT "\n",
+				DRM_RECT_ARG(&pipe_cfg->src_rect),
+				DRM_RECT_ARG(&mixer_rect));
+
+		/*
+		 * If this plane does not fall into mixer rect, check next
+		 * mixer rect.
+		 */
+		if (!drm_rect_clip_scaled(&pipe_cfg->src_rect,
+					  &pipe_cfg->dst_rect,
+					  &mixer_rect)) {
+			memset(pipe_cfg, 0, 2 * sizeof(struct dpu_sw_pipe_cfg));
+
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
+		pipe_cfg->dst_rect.x1 -= mixer_rect.x1;
+		pipe_cfg->dst_rect.x2 -= mixer_rect.x1;
+
+		DPU_DEBUG_PLANE(pdpu, "Got clip src:" DRM_RECT_FMT " dst: " DRM_RECT_FMT "\n",
+				DRM_RECT_ARG(&pipe_cfg->src_rect), DRM_RECT_ARG(&pipe_cfg->dst_rect));
+
+		/* Split wide rect into 2 rect */
+		if ((drm_rect_width(&pipe_cfg->src_rect) > max_linewidth) ||
+		     _dpu_plane_calc_clk(mode, pipe_cfg) > max_mdp_clk_rate) {
+
+			if (drm_rect_width(&pipe_cfg->src_rect) > 2 * max_linewidth) {
+				DPU_DEBUG_PLANE(pdpu, "invalid src " DRM_RECT_FMT " line:%u\n",
+						DRM_RECT_ARG(&pipe_cfg->src_rect), max_linewidth);
+				return -E2BIG;
+			}
+
+			memcpy(r_pipe_cfg, pipe_cfg, sizeof(struct dpu_sw_pipe_cfg));
+			pipe_cfg->src_rect.x2 = (pipe_cfg->src_rect.x1 + pipe_cfg->src_rect.x2) >> 1;
+			pipe_cfg->dst_rect.x2 = (pipe_cfg->dst_rect.x1 + pipe_cfg->dst_rect.x2) >> 1;
+			r_pipe_cfg->src_rect.x1 = pipe_cfg->src_rect.x2;
+			r_pipe_cfg->dst_rect.x1 = pipe_cfg->dst_rect.x2;
+			DPU_DEBUG_PLANE(pdpu, "Split wide plane into:"
+					DRM_RECT_FMT " and " DRM_RECT_FMT "\n",
+					DRM_RECT_ARG(&pipe_cfg->src_rect),
+					DRM_RECT_ARG(&r_pipe_cfg->src_rect));
+		} else {
+			memset(r_pipe_cfg, 0, sizeof(struct dpu_sw_pipe_cfg));
+		}
 
-	drm_rect_rotate_inv(&pipe_cfg->src_rect,
-			    new_plane_state->fb->width, new_plane_state->fb->height,
-			    new_plane_state->rotation);
-	if (drm_rect_width(&r_pipe_cfg->src_rect) != 0)
-		drm_rect_rotate_inv(&r_pipe_cfg->src_rect,
-				    new_plane_state->fb->width, new_plane_state->fb->height,
+		drm_rect_rotate_inv(&pipe_cfg->src_rect,
+				    new_plane_state->fb->width,
+				    new_plane_state->fb->height,
 				    new_plane_state->rotation);
 
+		if (drm_rect_width(&r_pipe_cfg->src_rect) != 0)
+			drm_rect_rotate_inv(&r_pipe_cfg->src_rect,
+					    new_plane_state->fb->width,
+					    new_plane_state->fb->height,
+					    new_plane_state->rotation);
+	}
+
 	pstate->needs_qos_remap = drm_atomic_crtc_needs_modeset(crtc_state);
 
 	return 0;
@@ -954,20 +1011,17 @@ static int dpu_plane_atomic_check_sspp(struct drm_plane *plane,
 		drm_atomic_get_new_plane_state(state, plane);
 	struct dpu_plane *pdpu = to_dpu_plane(plane);
 	struct dpu_plane_state *pstate = to_dpu_plane_state(new_plane_state);
-	struct dpu_sw_pipe *pipe = &pstate->pipe[0];
-	struct dpu_sw_pipe *r_pipe = &pstate->pipe[1];
-	struct dpu_sw_pipe_cfg *pipe_cfg = &pstate->pipe_cfg[0];
-	struct dpu_sw_pipe_cfg *r_pipe_cfg = &pstate->pipe_cfg[1];
-	int ret = 0;
-
-	ret = dpu_plane_atomic_check_pipe(pdpu, pipe, pipe_cfg,
-					  &crtc_state->adjusted_mode,
-					  new_plane_state);
-	if (ret)
-		return ret;
+	struct dpu_sw_pipe *pipe;
+	struct dpu_sw_pipe_cfg *pipe_cfg;
+	int ret = 0, i;
 
-	if (drm_rect_width(&r_pipe_cfg->src_rect) != 0) {
-		ret = dpu_plane_atomic_check_pipe(pdpu, r_pipe, r_pipe_cfg,
+	for (i = 0; i < PIPES_PER_PLANE; i++) {
+		pipe = &pstate->pipe[i];
+		pipe_cfg = &pstate->pipe_cfg[i];
+		if (!pipe->sspp)
+			continue;
+		DPU_DEBUG_PLANE(pdpu, "pipe %d is in use, validate it\n", i);
+		ret = dpu_plane_atomic_check_pipe(pdpu, pipe, pipe_cfg,
 						  &crtc_state->adjusted_mode,
 						  new_plane_state);
 		if (ret)

-- 
2.34.1


