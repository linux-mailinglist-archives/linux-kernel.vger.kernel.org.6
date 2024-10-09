Return-Path: <linux-kernel+bounces-356602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C968996401
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0D011C23B71
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC9718F2C5;
	Wed,  9 Oct 2024 08:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mmn+WfhT"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11DB191F69
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728463875; cv=none; b=klpOjZn1ZamY7bosrpiC42nVCQsn9794KP2u3fS1g8oyWh6WvpDu61GwmdBu90do3W/E5jvUPpOT2Rpgi4MUhMv7o7seZRTVfESzdSW72cXDpVlPkZ3vibADn+25abNiJ7FNnI0dsMKqwEwt9pyAATAVfuZfXl/uyiZVctHiNW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728463875; c=relaxed/simple;
	bh=vJuCxGkGWnTz/P7Gtny2/1VxQGiyRWGiMV+/Rk64D/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RTx2Uc+kKSRZOm24WsOlkng92NaOr0OFEeRaktJ+G0dz3Gp4UPgrNvrQ1TIb4Zxf/swVzk1m9Ouq6ZiN3usIxsWsh5YTbFR1jVqXdE1A4MNzPd0M3uaZ0gl2ny0iySOYyV1vVsTyFDU8gzx+XAqPflNL/D9F7JPjMfoOgKYxoP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mmn+WfhT; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e28d7d44dbso1196153a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 01:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728463873; x=1729068673; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lGPiijXBHhXZLgDLI4yCnvpkLyy91sdQEmrQWlXpxFs=;
        b=mmn+WfhT7tJWr0iHkcixMCC5lSeeRAJHPIuWPJI5yxhBT8jWwHXZC9T1IF+qhHKTIB
         mpDiS7ASDre/q9Bz5ax8WEX0rTje8t6etTIVNB5mn+NtZnmXLrjAyWT1vu0Ju1WJhnZw
         lCk7wJ45UMZEBAizv12tVVH/brL0RDM4oOuV0ao1iLC+YYMr8tjxpYmSkfmoMEYGOV7O
         T1Nfzga2Kt4WodR8hjZOI2r+2pwl7LlPaJe5yEL1rEfqTa5RJBoG/wUhYwKPmEq9VdB5
         aIb9pyFuVYPi3lfA8fvgtBNq+06vGpt/5PCh+Z36cMXLXvTL5qH250NfHNqx7GIMyrcW
         kIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728463873; x=1729068673;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lGPiijXBHhXZLgDLI4yCnvpkLyy91sdQEmrQWlXpxFs=;
        b=gKXktvsGxijN2UiTedlXqWahGIxQcPp9Opkd5bpTU28xQirCxXXpWOZRSQ+JPwc83i
         jC96a4Qz8Fniopddu7k/HqgmnNUSZ4mP94j7RK7eSRBGDOYGi/4F9SOHfnvhZH+8uJfe
         83KjaNi6+MBEKi6U2PjsdrvmNsord+y0OnMq9tr8vETXY5E8cK7RkDDFnhRo2xenUo+d
         HjY3hBoRYsd0Ibc7NV1H8dz4jntOeyk41VMengGvmuNOjtis4iV1QuNPMRWJH13DzPor
         1qRKTB/hh4F72N+M3REqWQQMsptcBxlw+sqDsKKOJRD5b7Buu5Qom8g/4s+L1cMCHRWt
         iIKw==
X-Forwarded-Encrypted: i=1; AJvYcCUu8DVvBQ48ESExLiJ8OJ3r5ddtfwe+HnlU5055jFmAC+oKbEXrvYGUvG4OBONFT/RDiWjkRhjyjqAdH30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6zn1EndYKR9sop+oidz7io+80sVAPffq6z1MNmNrgjbBMuNcT
	GFILtslOJiyIPE548yqbDoqvCvvccdgsO28fJLvVsxlSMnx4ra9UQ8Zl1gyiDU4=
X-Google-Smtp-Source: AGHT+IHrjXqIDxYCqwvHmyuAo/2KaTwbzzxWXLOebacPfVE93Zx+pXmlthJkNcFwtHdZDvlnIGicew==
X-Received: by 2002:a17:90b:4007:b0:2e0:970d:e37e with SMTP id 98e67ed59e1d1-2e2a246d989mr2280624a91.21.1728463873256;
        Wed, 09 Oct 2024 01:51:13 -0700 (PDT)
Received: from [127.0.1.1] ([112.65.12.217])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2abad236esm898157a91.10.2024.10.09.01.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 01:51:13 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Wed, 09 Oct 2024 16:50:22 +0800
Subject: [PATCH v2 09/14] drm/msm/dpu: blend pipes per mixer pairs config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-9-76d4f5d413bf@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728463820; l=3761;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=vJuCxGkGWnTz/P7Gtny2/1VxQGiyRWGiMV+/Rk64D/Y=;
 b=1MAjd3Jvkinq6GMa/Z1lrF4XLcay/hBv+mExg+EKDZlBZS5b9WsUnciLcQv8VCirNsVEuE42e
 uUJS17Cr/0cCekZocENT5LBgQ/bZiJecz/rUoIPmrKAEUZGAwKJUYSi
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

Blend pipes by set of mixer pair config. The first 2 pipes are for left
half screen with the first set of mixer pair config. And the later 2 pipes
are for right in quad pipe case.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    | 38 ++++++++++++++++++-----------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h |  1 +
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 43d9817cd858f..66f745399a602 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -442,7 +442,7 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
 	const struct msm_format *format;
 	struct dpu_hw_ctl *ctl = mixer->lm_ctl;
 
-	uint32_t lm_idx, i;
+	uint32_t lm_idx, lm_pair, i, pipe_idx;
 	bool bg_alpha_enable = false;
 	DECLARE_BITMAP(fetch_active, SSPP_MAX);
 
@@ -463,15 +463,20 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
 		if (pstate->stage == DPU_STAGE_BASE && format->alpha_enable)
 			bg_alpha_enable = true;
 
-		for (i = 0; i < PIPES_PER_LM_PAIR; i++) {
-			if (!pstate->pipe[i].sspp)
-				continue;
-			set_bit(pstate->pipe[i].sspp->idx, fetch_active);
-			_dpu_crtc_blend_setup_pipe(crtc, plane,
-						   mixer, cstate->num_mixers,
-						   pstate->stage,
-						   format, fb ? fb->modifier : 0,
-						   &pstate->pipe[i], i, stage_cfg);
+		/* loop pipe per mixer pair */
+		for (lm_pair = 0; lm_pair < PIPES_PER_PLANE / 2; lm_pair++) {
+			for (i = 0; i < PIPES_PER_LM_PAIR; i++) {
+				pipe_idx = i + lm_pair * PIPES_PER_LM_PAIR;
+				if (!pstate->pipe[pipe_idx].sspp)
+					continue;
+				set_bit(pstate->pipe[pipe_idx].sspp->idx, fetch_active);
+				_dpu_crtc_blend_setup_pipe(crtc, plane,
+							   mixer, cstate->num_mixers,
+							   pstate->stage,
+							   format, fb ? fb->modifier : 0,
+							   &pstate->pipe[pipe_idx], i,
+							   &stage_cfg[lm_pair]);
+			}
 		}
 
 		/* blend config update */
@@ -503,7 +508,7 @@ static void _dpu_crtc_blend_setup(struct drm_crtc *crtc)
 	struct dpu_crtc_mixer *mixer = cstate->mixers;
 	struct dpu_hw_ctl *ctl;
 	struct dpu_hw_mixer *lm;
-	struct dpu_hw_stage_cfg stage_cfg;
+	struct dpu_hw_stage_cfg stage_cfg[LM_PAIRS_PER_PLANE];
 	int i;
 
 	DRM_DEBUG_ATOMIC("%s\n", dpu_crtc->name);
@@ -516,9 +521,9 @@ static void _dpu_crtc_blend_setup(struct drm_crtc *crtc)
 	}
 
 	/* initialize stage cfg */
-	memset(&stage_cfg, 0, sizeof(struct dpu_hw_stage_cfg));
+	memset(&stage_cfg, 0, sizeof(stage_cfg));
 
-	_dpu_crtc_blend_setup_mixer(crtc, dpu_crtc, mixer, &stage_cfg);
+	_dpu_crtc_blend_setup_mixer(crtc, dpu_crtc, mixer, &stage_cfg[0]);
 
 	for (i = 0; i < cstate->num_mixers; i++) {
 		ctl = mixer[i].lm_ctl;
@@ -535,8 +540,13 @@ static void _dpu_crtc_blend_setup(struct drm_crtc *crtc)
 			mixer[i].mixer_op_mode,
 			ctl->idx - CTL_0);
 
+		/*
+		 * call dpu_hw_ctl_setup_blendstage() to blend layers per stage cfg.
+		 * There is 4 mixers at most. The first 2 are for the left half, and
+		 * the later 2 are for the right half.
+		 */
 		ctl->ops.setup_blendstage(ctl, mixer[i].hw_lm->idx,
-			&stage_cfg);
+			&stage_cfg[i / 2]);
 	}
 }
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
index 3277debe11689..d8f5cffa60ea6 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
@@ -34,6 +34,7 @@
 
 #define PIPES_PER_PLANE			2
 #define PIPES_PER_LM_PAIR		2
+#define LM_PAIRS_PER_PLANE		2
 #ifndef DPU_MAX_DE_CURVES
 #define DPU_MAX_DE_CURVES		3
 #endif

-- 
2.34.1


