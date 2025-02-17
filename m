Return-Path: <linux-kernel+bounces-517816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AB9A3861E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61CE2164F50
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BED2253F4;
	Mon, 17 Feb 2025 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SG6JHlUM"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A574321D58F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801893; cv=none; b=bxtsZSdh9G84cyuls4QY8K+XiPc0+HmlDI5MOljeYnmmuwq+P8M6Pr5acLtJ/6NPqw5+DRtExkDzZNUqqIeGKIULqcGxz1bujrdOLQ41DQAlaA2S9SykB6VFNBjHE7MBVmh3dqs3woaCysJ526KbQl0bpuxu1GXo3G/fTVgGt98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801893; c=relaxed/simple;
	bh=7p8Cf2cc/bnE8b/fucvAxqQfmQCibLQPXtQ8uTs5zao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EpHFjnv8zAUwqpIMubglsDQKM2/kUmNjDqJpVwVgCuCyYAkivOS8G7JU8ONLSUNPamDjDa4uOLvhbhEoRlYX6ikI2lRcXNtIaK1rO8kRrfgqhZD5eqihHQkFJs2nvlssW/y8vX8Q+nBC59IsWVOZHbTSli4NDPfSRCx4e6Yh5Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SG6JHlUM; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-221206dbd7eso20969795ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 06:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739801891; x=1740406691; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+84HgPlIvBKwxhkb6I9ELvGb7NzlKgnjKlOyPCjS9Kk=;
        b=SG6JHlUM+aJSY9ve2qu1PuK/wUQnlnFz4wkiJP/u+Ler7PskxWCK5lDpxShWmj7GhQ
         rr6rlVBg74CTdk3FTeCL2OuARQhBeHzsJ7HCxTNEo2Du5MBVBlBE2tESG2uU/ozBdSPh
         l6+NNcTsmI/wA9D8OUOFn/nfLlobh1ciDCNCylHdk8Vsmymw3Wz3PO7/crpHRwx6a2EA
         W7E7WuTRyqHujX7DIygHUz+Pk3rUWlOPIXRHOnkxtYAYGpEhEJsxbOmvalIBZCXLRxzS
         PG9lyymfamzxbkMzWYwj8rmj13NAQPsA8T857dme1roQ8nA2w4jnCyIPnwRsWmFWPt5D
         T9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739801891; x=1740406691;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+84HgPlIvBKwxhkb6I9ELvGb7NzlKgnjKlOyPCjS9Kk=;
        b=hUjbLtKbKP1l/tQSRPadtvfZtAHaVq1EHsvOd0u4GCOSNsggbYRoECPVeDWf7O7O+k
         oLpV5OAs8oIERsB7uZaChk6JBMF1csBfhsq/iXkxHkBSte8Y5lHMFvP0SfFsOTMZ3Goj
         tSzzVnGbsy3flZptDhI6JBH2A1a7ECGGRV52HWfl6CuQtgWefMppXy4qSJfE4HluSYls
         jbBlghFxdFwabhImlobpmgVmvRUeaTz/ba28PVmqZZkZbJ4b43Ab9tbGulrbU7O5jcmH
         T6s45uo5/rZKAerMHciCXLw2Rro0CVEuUP1L1U1SoicA0XqJXNro4bcjwJSKr04a034O
         ksVA==
X-Forwarded-Encrypted: i=1; AJvYcCXhhzzribPCQATfuZfsN5mE75z0tUJcR7aRIdQjFQg7hkuDedQTJXGzYGSh6xNI2m+PpkWbLhl3HDKP0fY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEQzGGAQQbBsHuLXtbBls0Jn5YQsBoTDnNHyHGKxuv9n4CUKHi
	+BWnGabiYCxcakx0xjDbOaZOAygimJjSrAMtp55oSsVTYyL7Dw5h/x2p0JqtWYD5L04vwT2wEZP
	7EIjXHw==
X-Gm-Gg: ASbGncsr+HRBu3qFQWxzBop0znEOSBxJAOOr9zd/79jPuzMateDH7X9WQyF2dEL+rT/
	2MxXCLNaHgtjyLxJpvHY94POD3I4B3mixWIq3Q/zq7FtzGW4aif+xIzLwDs+hKSluqF8nBwtasI
	gzcdzSE/kTuS1UnLtfzHS3+kkQS48QAxHAvghkhy5nqNSiut+kCQIqRKUw2SvPwkfpqVTPZ4aIZ
	IIMewil1OK9yoI5b1MKKxqbwrQSqf9jHX42jTNfHjwBxHJk7MWdGny5Z8Goy5uG2+Va0oFHDKkE
	12q0mjCjalUw
X-Google-Smtp-Source: AGHT+IFXNtZ+5TJKSeoeqvx2/Zk1qMDod+K/e9CgiVIH+8Qg/bBnmV4JIgwavR0yVflf7Ko4ZwZPaA==
X-Received: by 2002:a17:902:f547:b0:21f:53ce:b2e2 with SMTP id d9443c01a7336-2210409af9fmr134156335ad.45.1739801890768;
        Mon, 17 Feb 2025 06:18:10 -0800 (PST)
Received: from [127.0.1.1] ([112.65.12.217])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5366984sm71900845ad.60.2025.02.17.06.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 06:18:10 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
Date: Mon, 17 Feb 2025 22:16:02 +0800
Subject: [PATCH v6 13/15] drm/msm/dpu: support SSPP assignment for
 quad-pipe case
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-13-c11402574367@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739801787; l=4059;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=7p8Cf2cc/bnE8b/fucvAxqQfmQCibLQPXtQ8uTs5zao=;
 b=gfPi485oSXgo49FYw33li21uSnP9+HXe8ePAytCi/gAzb22q722yTuHv6ToMd//mLSrcS+Lyl
 Al8Rn5R+5uNCWF1U7Y/oDbn9bGmG4jYjFeQbUvvLcynFv//T46ltJ+e
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
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 63 +++++++++++++++++++------------
 1 file changed, 39 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index d67f2ad20b4754ca4bcb759a65a39628b7236b0f..b87da2bd20861370e7b3b1fa60a689a145c2fab7 100644
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
 
@@ -1142,24 +1138,43 @@ static int dpu_plane_virtual_assign_resources(struct drm_crtc *crtc,
 
 	reqs.rot90 = drm_rotation_90_or_270(plane_state->rotation);
 
-	pipe->sspp = dpu_rm_reserve_sspp(&dpu_kms->rm, global_state, crtc, &reqs);
-	if (!pipe->sspp)
-		return -ENODEV;
-
-	if (!dpu_plane_try_multirect_parallel(pipe, pipe_cfg, r_pipe, r_pipe_cfg,
-					      pipe->sspp,
-					      msm_framebuffer_format(plane_state->fb),
-					      dpu_kms->catalog->caps->max_linewidth)) {
-		/* multirect is not possible, use two SSPP blocks */
-		r_pipe->sspp = dpu_rm_reserve_sspp(&dpu_kms->rm, global_state, crtc, &reqs);
-		if (!r_pipe->sspp)
-			return -ENODEV;
-
-		pipe->multirect_index = DPU_SSPP_RECT_SOLO;
-		pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
-
-		r_pipe->multirect_index = DPU_SSPP_RECT_SOLO;
-		r_pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
+	num_lm = dpu_crtc_get_num_lm(crtc_state);
+	num_stages = (num_lm + 1) / 2;
+	for (stage_id = 0; stage_id < num_stages; stage_id++) {
+		for (i = stage_id * PIPES_PER_STAGE; i < (stage_id + 1) * PIPES_PER_STAGE; i++) {
+			pipe = &pstate->pipe[i];
+			pipe_cfg = &pstate->pipe_cfg[i];
+
+			if (drm_rect_width(&pipe_cfg->src_rect) == 0)
+				break;
+
+			pipe->sspp = dpu_rm_reserve_sspp(&dpu_kms->rm, global_state, crtc, &reqs);
+			if (!pipe->sspp)
+				return -ENODEV;
+
+			r_pipe = &pstate->pipe[i + 1];
+			r_pipe_cfg = &pstate->pipe_cfg[i + 1];
+
+			/*
+			 * If current pipe is the first pipe in pipe pair, check
+			 * multi-rect opportunity for the 2nd pipe in the pair.
+			 * SSPP multi-rect mode cross mixer pairs is not supported.
+			 */
+			if ((i % PIPES_PER_STAGE == 0) &&
+			    drm_rect_width(&r_pipe_cfg->src_rect) != 0 &&
+			    dpu_plane_try_multirect_parallel(pipe, pipe_cfg, r_pipe, r_pipe_cfg,
+							      pipe->sspp,
+							      msm_framebuffer_format(plane_state->fb),
+							      dpu_kms->catalog->caps->max_linewidth)) {
+				i++;
+			} else {
+				/* multirect is not possible, use two SSPP blocks */
+				pipe->multirect_index = DPU_SSPP_RECT_SOLO;
+				pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
+				DPU_DEBUG_PLANE(pdpu, "allocating sspp_%d for pipe %d.\n",
+						pipe->sspp->idx - SSPP_NONE, i);
+			}
+		}
 	}
 
 	return dpu_plane_atomic_check_sspp(plane, state, crtc_state);

-- 
2.34.1


