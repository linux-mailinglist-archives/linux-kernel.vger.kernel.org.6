Return-Path: <linux-kernel+bounces-533853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8B5A45F85
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E23553B5100
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B73B21D3D8;
	Wed, 26 Feb 2025 12:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fUWM571a"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E18218AB7
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740573226; cv=none; b=r4krjIyyxqMtAz88pC0tFf8jzLJXV1cK4W6LMt/OzlC0LbPls8uRTq8vHRK4ktWP3U28s6nv/4HGY07EvhHp7HKBt6WVjPpohqf2tFlGBLpqkValnIZvuQuPiRtsF4qizjFru/AdWtDEk/Wa2l7fUhMOEEn9+/egPz8Qur6gRi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740573226; c=relaxed/simple;
	bh=UL1d/PVOBb1p9Mpxa5pHeU/I1d+NRhaJvrXb38SFtac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rVM6ZmTsFAfpovut76zf4WhcCUPqwvheNkuEi4/kMdrz8A9+6EMdL2yNaxqHo7yPLVyqklpY4lSvrpHdJmbD27JGVVMnbCxLjWB9ajfmJZOB9rmpcfXBjYu8R71bBLf3kk8fNk/puRE2qeZaH9TVopVliIBtpvMJ3Q7ttcMDefg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fUWM571a; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fc33aef343so13458608a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 04:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740573224; x=1741178024; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0sgd1n2rxa6C0H32nqGJ+05AslCqGv14mv07cJG70+E=;
        b=fUWM571abBR6qlKRfBc9hYCJfmH7HNBeFZ5woyuczhRr85cyMEmaS7C3aGJkXwGr5K
         uXOol9r3tQ09enkEHTXLOzMN6rpPogb5RFxDwKh1N+AD/1VWMRZtiu8ZBkxq1DaJK7d4
         /uZzz2yahdvoc4nPR+7i1+tM+UWhaAXeD6uo7XCqPa3LzmaaBZybMxzyCk23SSQtQloN
         oQwQWeQ3Ugbj9NN/LZk46ir+U8XYqK7lo0kND+FEZirgLZ988GPj/NCo7l4EN5vSc2vD
         mtSS8zCLopc/PY79rbtCXuZuGT2AEAE6Ps/AVQJf83yy0SLFze/GAYZPbmPdaocqBJRF
         uUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740573224; x=1741178024;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0sgd1n2rxa6C0H32nqGJ+05AslCqGv14mv07cJG70+E=;
        b=NkQGAMe1iMxA30986I0SSsEXV6KCgH7a7/QRyEZgFXQx/1f10zTtCw5lWij9cjtBmF
         5bX6+q8ITki/cCwSmvQtlc/75zgHLLHAZOtJWBEz3sEef6bKOy9PFS2vY3D7OIhvxlwm
         zxFztjzoAMCtHzFH5ObQHqZvfjapGNg8Kncl2BtDyBysdOtamcxvlLSZ96EKoW31Y7G1
         gg8IREaY8jmqOi1uUV6XJmn0lyinKUNPY/PjWBfySZgRGCzc7U8a/tN6s1p9BE4W5nHq
         V9EoiHo7IlW2TiceDfcbdHu48CLvzyn2VIzVTeihel79PnkZkZeowITid31842HFDx2b
         rwEA==
X-Forwarded-Encrypted: i=1; AJvYcCX+2Q3EILfR5M2KZeQFhfYG2thmvP6bzZ8k2BL+buENL79QPXd8hZzc1tY+Kbj/JI/JcvTRPXihoXYu5jQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbJtimvbBxig5FYi7JtYkmZT4on9F5QdzkGrRC2Hb6TGGC4jTS
	hF5h1fNj0Zdq/Sc3u4e/lD1BM74x6XKlwajq7Rjs6ejAPYxfiXVXPu/3fVZusf8=
X-Gm-Gg: ASbGnctngM905tTZfkiE18/DY6joRxrOmY3EO6+gVuinbSnIt2EUr+giuCCd5ddmZBF
	MsRZyaQkJIOcJ7QHDF0bjBXilzLKF47BOdcD0GA2NSbmXrxg8DDM0HFlOca9hIe6bmwTytrlW7J
	S5XLAFVWelFXjIdU5dGXyT9plsD5C1BTliS3mRoGyUih/tgJS6RS4/4I3u/6Pv+GcbBlo+S12jj
	t47MeMFLsv+H/mHg7nBsj8VocCYRIssuxGXdjmq/ZIT3L/JV3DlvQ23fps9ryiUVfDMtvpjlRG5
	/HZlSYRRQ5FPwVVHKkOs3DU=
X-Google-Smtp-Source: AGHT+IGLWheu9zktlbh+Z7y8IRuyLk+pzkIoGIAvOksGzvR789O1NWXNmlnTNnd8YOkHcMH+f58qFw==
X-Received: by 2002:a17:90a:d644:b0:2ee:fa0c:cebc with SMTP id 98e67ed59e1d1-2fe7e32cf49mr5104611a91.20.1740573224122;
        Wed, 26 Feb 2025 04:33:44 -0800 (PST)
Received: from [127.0.1.1] ([112.64.61.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825d2ed3sm1352479a91.29.2025.02.26.04.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 04:33:43 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
Date: Wed, 26 Feb 2025 20:31:01 +0800
Subject: [PATCH v7 12/15] drm/msm/dpu: blend pipes per mixer pairs config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v7-12-8d5f5f426eb2@linaro.org>
References: <20250226-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v7-0-8d5f5f426eb2@linaro.org>
In-Reply-To: <20250226-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v7-0-8d5f5f426eb2@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740573128; l=5139;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=UL1d/PVOBb1p9Mpxa5pHeU/I1d+NRhaJvrXb38SFtac=;
 b=y5ssVRKg17DXTuxX1bfksoUWGCzPkhwyJeMk57iyudKy/Wpmkr1cF74QuMeiEXGsLo34V4ICQ
 HOq0plcp7u3Bs4hoDJGGdH4dODQOZbLKEbnWMoq+OifRxwhvThLzFcE
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

Currently, only 2 pipes are used at most for a plane. A stage structure
describes the configuration for a mixer pair. So only one stage is needed
for current usage cases. The quad-pipe case will be added in future and 2
stages are used in the case. So extend the stage to an array with array
size STAGES_PER_PLANE and blend pipes per mixer pair with configuration
in the stage structure.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    | 45 +++++++++++++++++++----------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h |  3 +-
 2 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 81474823e6799132db71c9712046d359e3535d90..0a053c5888262d863a1e549e14e3aa40a80c3f06 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -392,7 +392,7 @@ static void _dpu_crtc_program_lm_output_roi(struct drm_crtc *crtc)
 static void _dpu_crtc_blend_setup_pipe(struct drm_crtc *crtc,
 				       struct drm_plane *plane,
 				       struct dpu_crtc_mixer *mixer,
-				       u32 num_mixers,
+				       u32 lms_in_pair,
 				       enum dpu_stage stage,
 				       const struct msm_format *format,
 				       uint64_t modifier,
@@ -426,7 +426,7 @@ static void _dpu_crtc_blend_setup_pipe(struct drm_crtc *crtc,
 	stage_cfg->multirect_index[stage][stage_idx] = pipe->multirect_index;
 
 	/* blend config update */
-	for (lm_idx = 0; lm_idx < num_mixers; lm_idx++)
+	for (lm_idx = 0; lm_idx < lms_in_pair; lm_idx++)
 		mixer[lm_idx].lm_ctl->ops.update_pending_flush_sspp(mixer[lm_idx].lm_ctl, sspp_idx);
 }
 
@@ -442,7 +442,7 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
 	const struct msm_format *format;
 	struct dpu_hw_ctl *ctl = mixer->lm_ctl;
 
-	uint32_t lm_idx, i;
+	uint32_t lm_idx, stage, i, pipe_idx, head_pipe_in_stage, lms_in_pair;
 	bool bg_alpha_enable = false;
 	DECLARE_BITMAP(fetch_active, SSPP_MAX);
 
@@ -463,15 +463,24 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
 		if (pstate->stage == DPU_STAGE_BASE && format->alpha_enable)
 			bg_alpha_enable = true;
 
-		for (i = 0; i < PIPES_PER_PLANE; i++) {
-			if (!pstate->pipe[i].sspp)
-				continue;
-			set_bit(pstate->pipe[i].sspp->idx, fetch_active);
-			_dpu_crtc_blend_setup_pipe(crtc, plane,
-						   mixer, cstate->num_mixers,
-						   pstate->stage,
-						   format, fb ? fb->modifier : 0,
-						   &pstate->pipe[i], i, stage_cfg);
+		/* loop pipe per mixer pair with config in stage structure */
+		for (stage = 0; stage < STAGES_PER_PLANE; stage++) {
+			head_pipe_in_stage = stage * PIPES_PER_STAGE;
+			for (i = 0; i < PIPES_PER_STAGE; i++) {
+				pipe_idx = i + head_pipe_in_stage;
+				if (!pstate->pipe[pipe_idx].sspp)
+					continue;
+				lms_in_pair = min(cstate->num_mixers - (stage * PIPES_PER_STAGE),
+						  PIPES_PER_STAGE);
+				set_bit(pstate->pipe[pipe_idx].sspp->idx, fetch_active);
+				_dpu_crtc_blend_setup_pipe(crtc, plane,
+							   &mixer[head_pipe_in_stage],
+							   lms_in_pair,
+							   pstate->stage,
+							   format, fb ? fb->modifier : 0,
+							   &pstate->pipe[pipe_idx], i,
+							   &stage_cfg[stage]);
+			}
 		}
 
 		/* blend config update */
@@ -503,7 +512,7 @@ static void _dpu_crtc_blend_setup(struct drm_crtc *crtc)
 	struct dpu_crtc_mixer *mixer = cstate->mixers;
 	struct dpu_hw_ctl *ctl;
 	struct dpu_hw_mixer *lm;
-	struct dpu_hw_stage_cfg stage_cfg;
+	struct dpu_hw_stage_cfg stage_cfg[STAGES_PER_PLANE];
 	int i;
 
 	DRM_DEBUG_ATOMIC("%s\n", dpu_crtc->name);
@@ -516,9 +525,9 @@ static void _dpu_crtc_blend_setup(struct drm_crtc *crtc)
 	}
 
 	/* initialize stage cfg */
-	memset(&stage_cfg, 0, sizeof(struct dpu_hw_stage_cfg));
+	memset(&stage_cfg, 0, sizeof(stage_cfg));
 
-	_dpu_crtc_blend_setup_mixer(crtc, dpu_crtc, mixer, &stage_cfg);
+	_dpu_crtc_blend_setup_mixer(crtc, dpu_crtc, mixer, stage_cfg);
 
 	for (i = 0; i < cstate->num_mixers; i++) {
 		ctl = mixer[i].lm_ctl;
@@ -535,8 +544,12 @@ static void _dpu_crtc_blend_setup(struct drm_crtc *crtc)
 			mixer[i].mixer_op_mode,
 			ctl->idx - CTL_0);
 
+		/*
+		 * call dpu_hw_ctl_setup_blendstage() to blend layers per stage cfg.
+		 * stage data is shared between PIPES_PER_STAGE pipes.
+		 */
 		ctl->ops.setup_blendstage(ctl, mixer[i].hw_lm->idx,
-			&stage_cfg);
+			&stage_cfg[i / PIPES_PER_STAGE]);
 	}
 }
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
index 5f010d36672cc6440c69779908b315aab285eaf0..74bf3ab9d6cfb8152b32d89a6c66e4d92d5cee1d 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
@@ -34,8 +34,9 @@
 #define DPU_MAX_PLANES			4
 #endif
 
-#define PIPES_PER_PLANE			2
+#define STAGES_PER_PLANE		1
 #define PIPES_PER_STAGE			2
+#define PIPES_PER_PLANE			(PIPES_PER_STAGE * STAGES_PER_PLANE)
 #ifndef DPU_MAX_DE_CURVES
 #define DPU_MAX_DE_CURVES		3
 #endif

-- 
2.34.1


