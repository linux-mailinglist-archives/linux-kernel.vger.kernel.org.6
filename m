Return-Path: <linux-kernel+bounces-542024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E61A4C4C6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DDE6174984
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E171A2153C6;
	Mon,  3 Mar 2025 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aSZAtp+o"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811AA215768
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741014982; cv=none; b=RD9q4eUWwl/NOEfLd37NogfXKwkbzH8cGQN5UpL2/KklH28Q4obMOsCWHwkYYtR/B4TMm2LhT33PD8DApJ81mUCtyX3MyPLJm+bFJYGbTHzIeFcltjjK4Slvu4yqmL9+m25gSCtkP5HiUjE9SGleL010aGAxx2LFE26BNChNDQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741014982; c=relaxed/simple;
	bh=ePNMMcEGe1JDTHAjr10tWqIoVJITlGWG4gqdbWeDX1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aJ69bYCuieg5MKZPvF2eaH27alCStp2s7fFI1pXKmXWr34oecmgX5oolXZJ75Sal+WDet6m4ef6ROGu2pOKgBTRrRGKQYeIL5GxIEEhmBRW/JT40UWhuimlM2M4ZnE8FO7qxo7KbsD5pfjYnTOYJ8XnXb3RIq2CZ7q5WurA/rko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aSZAtp+o; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22334203781so87797765ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 07:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741014980; x=1741619780; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JJwNXR5/FA1bwrksoREVmlsFsu5t6bJdXbvSI3qGRv0=;
        b=aSZAtp+o5Odz5wiOOEfvlJB68C2zS1vsEIdpTeC+bdMdIt+kdUfjHQyGH7XSC4ytVm
         LT4xrwDtOz3TTrAxa3oNYwniYLGWTYw9ECu8dDCY/AmHlQxqhmGqvogktG+/sYM1Qzx5
         88NEfVBk34alpkdyF+WI08fkkOqy5xalqU0YygCluhBKxOvco4+p4n0ciwtVYlQWIMz/
         Qv/V+k3cq77K7CGYoiM1aFR5XeDqGo5cSEaV7bZqfFZ+5+1ks02AdLlLwM9xJ1V7hPX3
         yCo5Y1kgNOI8AqwVd6eMCzKdRr/MyUkTZbE0irkZH9W5QQXeyDyumXVIay4WshzwT5Ty
         6vrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741014980; x=1741619780;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJwNXR5/FA1bwrksoREVmlsFsu5t6bJdXbvSI3qGRv0=;
        b=HNT9Y7Ia+GozdB27nVl4ogZQ6K0eYAzgPcvrD8LVx4HkRtOWJe0urIXr16/v0LzG9B
         U2V0B0KzpU3u53LglXE/ksYVbJvw+/gTXDjvY4tR8wurKt85PIXrgX6VON4g9OkLxwGS
         EnjTEdC/MeJQreSegX4cNV/qbGN1hhaovTQeUITdGh8ExnNLG2/DS4QCjogUaq3sJsQm
         OpyATdkYxilhJx5FNKGLuhor0mSu1yKGtxmwEtCMYimOwEZmXGXGexYfdhk92oFVR4wb
         OiJuzLja0U9h0dv4t+4kmQqj7VYdAx1ISbjMWMNKJmzCsiZtuk8BPm+bywyo/E8C/dAX
         grnA==
X-Forwarded-Encrypted: i=1; AJvYcCUpJTY3lSLOUgxE0pukluVFZWWbxQc0xtH0oSf2xpSfVfT3/erf5if/V+Cc9XW4dk1BdiMId+BE7V0MuHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR5T9pqkkvVNgwbRsbRkaZ5stWsFQejycMtlwYd0/p3LM51ECK
	VETCQ3Xtd/eYLAvCW9JlW/4WAZa7CR9XY+7u4YRpM48r5OliMRaqp0dh3ds2TRxhYpcYIkRD0ku
	cV66LFw==
X-Gm-Gg: ASbGncsVo6A+d6jAg8SILEJG9VElScjCRwXPuY2SgPqpExstkwtLLlFNGD7Cwk+p/ME
	JLUZle6cCc9h18dmXD/AaytsmdCLNtGxFVpsOSVB2GmDpcdugDoy11uDaEZtwt0haXD0vjh69AX
	WItk1WcVmp6sr+UVugRQ4frTRZPNvMCQbmhLiSeHQPGPyAd2y7PtYH3spGPgFmVsonABzSWqLIA
	BuOSvNZeuMjV1YqqAe1uwCdt3tFILucdZiAvW7nIJqxR2+PbohEwH0pg6uUSLJLsHzzH2P5SskH
	1ICT84C+FWGWB92xRMojkg30TkSzfwrOpTRC0hzsXw==
X-Google-Smtp-Source: AGHT+IE1+I1a6C4GkaIKEMJYRAIAIPlqnMwAZ4/E6m8E1fUS94oLMhy4xVMa2pj2jJk9HmcZTW1g+w==
X-Received: by 2002:a05:6a00:cd1:b0:736:4d05:2e35 with SMTP id d2e1a72fcca58-7364d0530cfmr8341363b3a.3.1741014979568;
        Mon, 03 Mar 2025 07:16:19 -0800 (PST)
Received: from [127.0.1.1] ([112.64.60.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736584b3cffsm1851984b3a.4.2025.03.03.07.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:16:19 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
Date: Mon, 03 Mar 2025 23:14:42 +0800
Subject: [PATCH v8 13/15] drm/msm/dpu: support SSPP assignment for
 quad-pipe case
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v8-13-eb5df105c807@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741014878; l=5614;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=ePNMMcEGe1JDTHAjr10tWqIoVJITlGWG4gqdbWeDX1E=;
 b=4cEJMb5KlA0GTKQX1UO6Ej4OrdsmNdwBp7kNNf9Aqn2yRanYC+vrCQFI+pSMqj8pBuZpzHKmJ
 vf7QUnqbdQRA0PzMrAGOUmi7viWIGwsHtp91OnNJO/0E5CtePGnPIgq
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

Currently, SSPPs are assigned to a maximum of two pipes. However,
quad-pipe usage scenarios require four pipes and involve configuring
two stages. In quad-pipe case, the first two pipes share a set of
mixer configurations and enable multi-rect mode when certain
conditions are met. The same applies to the subsequent two pipes.

Assign SSPPs to the pipes in each stage using a unified method and
to loop the stages accordingly.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c  | 11 ++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h  |  2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 64 +++++++++++++++++++++----------
 3 files changed, 57 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 6fbe42e8988edac7e7917ae8de180aefdaf443e9..fa487d625dde5cbd9a83ceb5163c049da45163f7 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1367,6 +1367,17 @@ int dpu_crtc_vblank(struct drm_crtc *crtc, bool en)
 	return 0;
 }
 
+/**
+ * dpu_crtc_get_num_lm - Get mixer number in this CRTC pipeline
+ * @state: Pointer to drm crtc state object
+ */
+unsigned int dpu_crtc_get_num_lm(const struct drm_crtc_state *state)
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
index 0b148f3ce0d7af80ec4ffcd31d8632a5815b16f1..b14bab2754635953da402d09e11a43b9b4cf4153 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
@@ -264,4 +264,6 @@ static inline enum dpu_crtc_client_type dpu_crtc_get_client_type(
 
 void dpu_crtc_frame_event_cb(struct drm_crtc *crtc, u32 event);
 
+unsigned int dpu_crtc_get_num_lm(const struct drm_crtc_state *state);
+
 #endif /* _DPU_CRTC_H_ */
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index 1095727d1d9f17407f2b063039bf2efd8733ec70..0245f158881b5c37fffb75d78c75310ba446a0b7 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -1115,8 +1115,9 @@ static int dpu_plane_virtual_assign_resources(struct drm_crtc *crtc,
 	struct dpu_sw_pipe *r_pipe;
 	struct dpu_sw_pipe_cfg *pipe_cfg;
 	struct dpu_sw_pipe_cfg *r_pipe_cfg;
+	struct dpu_plane *pdpu = to_dpu_plane(plane);
 	const struct msm_format *fmt;
-	int i;
+	int i, num_lm, stage_id, num_stages;
 
 	if (plane_state->crtc)
 		crtc_state = drm_atomic_get_new_crtc_state(state,
@@ -1124,11 +1125,6 @@ static int dpu_plane_virtual_assign_resources(struct drm_crtc *crtc,
 
 	pstate = to_dpu_plane_state(plane_state);
 
-	pipe = &pstate->pipe[0];
-	r_pipe = &pstate->pipe[1];
-	pipe_cfg = &pstate->pipe_cfg[0];
-	r_pipe_cfg = &pstate->pipe_cfg[1];
-
 	for (i = 0; i < PIPES_PER_PLANE; i++)
 		pstate->pipe[i].sspp = NULL;
 
@@ -1142,24 +1138,52 @@ static int dpu_plane_virtual_assign_resources(struct drm_crtc *crtc,
 
 	reqs.rot90 = drm_rotation_90_or_270(plane_state->rotation);
 
-	pipe->sspp = dpu_rm_reserve_sspp(&dpu_kms->rm, global_state, crtc, &reqs);
-	if (!pipe->sspp)
-		return -ENODEV;
+	num_lm = dpu_crtc_get_num_lm(crtc_state);
+	num_stages = (num_lm + 1) / PIPES_PER_STAGE;
+	for (stage_id = 0; stage_id < num_stages; stage_id++) {
+		i = stage_id * PIPES_PER_STAGE;
+		pipe = &pstate->pipe[i];
+		pipe_cfg = &pstate->pipe_cfg[i];
+		r_pipe = &pstate->pipe[i + 1];
+		r_pipe_cfg = &pstate->pipe_cfg[i + 1];
 
-	if (!dpu_plane_try_multirect_parallel(pipe, pipe_cfg, r_pipe, r_pipe_cfg,
-					      pipe->sspp,
-					      msm_framebuffer_format(plane_state->fb),
-					      dpu_kms->catalog->caps->max_linewidth)) {
-		/* multirect is not possible, use two SSPP blocks */
-		r_pipe->sspp = dpu_rm_reserve_sspp(&dpu_kms->rm, global_state, crtc, &reqs);
-		if (!r_pipe->sspp)
+		if (drm_rect_width(&pipe_cfg->src_rect) == 0)
+			goto r_pipe_assign;
+
+		pipe->sspp = dpu_rm_reserve_sspp(&dpu_kms->rm, global_state, crtc, &reqs);
+		if (!pipe->sspp)
 			return -ENODEV;
 
-		pipe->multirect_index = DPU_SSPP_RECT_SOLO;
-		pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
+		/*
+		 * Check multi-rect opportunity for the 2nd pipe in the
+		 * pair. SSPP multi-rect mode cross mixer pairs is not
+		 * supported.
+		 */
+		if (drm_rect_width(&r_pipe_cfg->src_rect) != 0 &&
+		    dpu_plane_try_multirect_parallel(pipe, pipe_cfg, r_pipe, r_pipe_cfg,
+						     pipe->sspp,
+						     msm_framebuffer_format(plane_state->fb),
+						     dpu_kms->catalog->caps->max_linewidth)) {
+			DPU_DEBUG_PLANE(pdpu, "allocate sspp_%d for pipe %d and %d.\n",
+					pipe->sspp->idx - SSPP_NONE, i, i + 1);
+			continue;
+		}
+
+		DPU_DEBUG_PLANE(pdpu, "allocate sspp_%d for pipe %d\n",
+				pipe->sspp->idx - SSPP_NONE, i);
+
+r_pipe_assign:
+		if (drm_rect_width(&r_pipe_cfg->src_rect) == 0)
+			continue;
+
+		r_pipe->sspp = dpu_rm_reserve_sspp(&dpu_kms->rm,
+						 global_state,
+						 crtc, &reqs);
+		if (!r_pipe->sspp)
+			return -ENODEV;
 
-		r_pipe->multirect_index = DPU_SSPP_RECT_SOLO;
-		r_pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
+		DPU_DEBUG_PLANE(pdpu, "allocate sspp_%d for pipe %d\n",
+				r_pipe->sspp->idx - SSPP_NONE, i + 1);
 	}
 
 	return dpu_plane_atomic_check_sspp(plane, state, crtc_state);

-- 
2.34.1


