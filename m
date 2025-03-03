Return-Path: <linux-kernel+bounces-542019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3780A4C4B8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07DC716BDE5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E39121D5B5;
	Mon,  3 Mar 2025 15:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mrOHFsWu"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D565D2144A4
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741014953; cv=none; b=Hs61AzMyHZ4nRy+zh+stj0oFqKegAKnA/epHVo/p8pepg9g9FRlny7CHQzQqhcg+e7R1dZ7bOMB0d+Mqsq4lL5hqWoofXIonUhz+b2aUG0uNi+yIkY7pmiHG9Y21uayvskFBYih63Oj7o3qqKowic4BE/X1ZjuaPmRpEqEXb4Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741014953; c=relaxed/simple;
	bh=CYxXjoGPBo4uvT8jsEkwbX8WYPTbGIdNFxJtu3SWxQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=avIAC5ZTD6Cc+56WUci+q5SR8HfEJXs40Yspue9Q5kYWHBbauZIXkvtGLprxp/+90fe+FBxGPm8aPt4xDtcYp8p7+MUQp8aB6KssjIeCVOeqU1LQ40H5UjrdVfkSa0yspLias5xlv9hYvmAMyO+7cGcBgJM9vr7WmXNl0d27NM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mrOHFsWu; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2234bec7192so66482455ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 07:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741014951; x=1741619751; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qYqL5aquEf9QP1MU+9dPpzn37KZ182hWurvxtiyryKc=;
        b=mrOHFsWueKXVwYJNFaUIQxaaHG8V9FFv4RGX+O/fiA7PLM8rq6z0sXI65VlNEAeL35
         +3Hh5tavVM1W6OYswkdcoDYQdp4KN+bTr8rGSD67rnk1GLIuvzZd8vnIxxPxn51VDTv2
         c+aHRNoipQySlJNhgRQZfY6aaH/KPnbqsMDwKPQeCl3pzxdzmMUh9lLIzvjLI7G1BvyC
         njMmIObFaGZWsZNtSJR378Wn0aQr+Vnf+lWh+gGIKBQAPO0HIEnF/Z6gidin5e1bnLaF
         Ua7qImu3AU5QDiv363KX1Xf9OdMCmIPK9z85upOwSxfkASz8m+5l29ohfvplogoJG2gT
         4uEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741014951; x=1741619751;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qYqL5aquEf9QP1MU+9dPpzn37KZ182hWurvxtiyryKc=;
        b=eoVjIRHO7DNeSeP1Hjj2UExRynr1+xja3WFb6QfdN/7EkmbZWgFV6aChUqU93CZI73
         iIrx72ewrOO+C4BoUhpzaBdGAtAjuv3TYRvRP7Nk/mof4fFWg6h0jIgf/L8kq139bkTD
         LEJ93clbGdiIe/tbzfoHjBkOIT3ShbvUcwfrcdhiAhVZY6Sd0gA/I5FlvTtTzHHBoXbb
         GENnBnxSTXE0HJh7/KTzPmFlp97PtR139gWWv6dQpb8N2Gx747E6UehLjNLjagb7W3GC
         VPy1LtZciqDx49bwE5ZWb8v0btQfLX9UfhUP4rx//f/v5ZkycVghcQDP9feWoUBya9O9
         kj7g==
X-Forwarded-Encrypted: i=1; AJvYcCU2/xGfapT3HYe3uyAUu12dvXas9sq2O7aBa2/FtTRFOfBOdNDjw1ynWD21qONI76/KQpKDi7LgA53QHZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5QOCRGo4DWQxC2Q2du3ZXp3KWCoOjYRYn3bhXRJnuL/YnL0Zo
	kpZ0dZIKTTH14SA2fXmoihSEfBeOl5HrQIqNUl8/8v0kFXV05lSNHiqmADyj18Y7OzoNPU36uSi
	r5bJGlQ==
X-Gm-Gg: ASbGnctVkHDPPr9Ys3mjAzra4Ug5/T8rf3u9GO4BxScWUzao9tEAuNji9yTY5I0ZXG1
	ODW0gvsjpz1B0v0UpSQ30QThAGaWV0NIdd1DBRIRkyNUBGpocyDbwRZIOAj68wv4ybqWQS50BE5
	I5eEBYGsWNGmPNs5tGLIMaFl4xv06Qq28O0YfKaJ4q2G8aAQbFWCBQdRmC9CO/q6nGgouvmIJww
	UUDU2CbQnpFTAgBonvPDNObg3/oWJiC2cWSzyaM1BrM3NvWd4v4ya3OWv2dFSIsmBG2bFQ7iEai
	nZURc7Z2+V/RWioXvNDhy9SatBWbCklbDT0hPPHxYQ==
X-Google-Smtp-Source: AGHT+IHBMkeJ/K/xmZ0r+6e1iC6/N1q8Tpd5ZgTdrqZ75hZ98XnPHX+o0gzUBYeec6SHcEus8rnwfA==
X-Received: by 2002:a05:6a00:139c:b0:736:5e6f:295b with SMTP id d2e1a72fcca58-7365e6f2a10mr4343635b3a.12.1741014951078;
        Mon, 03 Mar 2025 07:15:51 -0800 (PST)
Received: from [127.0.1.1] ([112.64.60.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736584b3cffsm1851984b3a.4.2025.03.03.07.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:15:50 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
Date: Mon, 03 Mar 2025 23:14:38 +0800
Subject: [PATCH v8 09/15] drm/msm/dpu: Add pipe as trace argument
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v8-9-eb5df105c807@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741014878; l=2487;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=CYxXjoGPBo4uvT8jsEkwbX8WYPTbGIdNFxJtu3SWxQs=;
 b=tEkg4RUT7oIGfsE4cuD/GwxCmFq8r/pBRQl9NiRcBh8QSHfXdU+84EoL4yepFYoNSj4QpB8Dh
 i4x5sqCQIuNBKjB1Q4RTZE+R5Y4emQpw31G4+A4LPEc+J5kUhrVA0gI
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

Add pipe as trace argument in trace_dpu_crtc_setup_mixer() to ease
converting pipe into pipe array later.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c  |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 41c9d3e3e3c7c0c74ac9007a1ea6dcdde0b05f97..05abe2d05d8d81fbaac58cf0b298abb8d2164735 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -411,7 +411,7 @@ static void _dpu_crtc_blend_setup_pipe(struct drm_crtc *crtc,
 
 	trace_dpu_crtc_setup_mixer(DRMID(crtc), DRMID(plane),
 				   state, to_dpu_plane_state(state), stage_idx,
-				   format->pixel_format,
+				   format->pixel_format, pipe,
 				   modifier);
 
 	DRM_DEBUG_ATOMIC("crtc %d stage:%d - plane %d sspp %d fb %d multirect_idx %d\n",
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h
index 5307cbc2007c5044c5b897c53b44a8e356f1ad0f..cb24ad2a6d8d386bbc97b173854c410220725a0d 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h
@@ -651,9 +651,9 @@ TRACE_EVENT(dpu_crtc_setup_mixer,
 	TP_PROTO(uint32_t crtc_id, uint32_t plane_id,
 		 struct drm_plane_state *state, struct dpu_plane_state *pstate,
 		 uint32_t stage_idx, uint32_t pixel_format,
-		 uint64_t modifier),
+		 struct dpu_sw_pipe *pipe, uint64_t modifier),
 	TP_ARGS(crtc_id, plane_id, state, pstate, stage_idx,
-		pixel_format, modifier),
+		pixel_format, pipe, modifier),
 	TP_STRUCT__entry(
 		__field(	uint32_t,		crtc_id		)
 		__field(	uint32_t,		plane_id	)
@@ -676,9 +676,9 @@ TRACE_EVENT(dpu_crtc_setup_mixer,
 		__entry->dst_rect = drm_plane_state_dest(state);
 		__entry->stage_idx = stage_idx;
 		__entry->stage = pstate->stage;
-		__entry->sspp = pstate->pipe.sspp->idx;
-		__entry->multirect_idx = pstate->pipe.multirect_index;
-		__entry->multirect_mode = pstate->pipe.multirect_mode;
+		__entry->sspp = pipe->sspp->idx;
+		__entry->multirect_idx = pipe->multirect_index;
+		__entry->multirect_mode = pipe->multirect_mode;
 		__entry->pixel_format = pixel_format;
 		__entry->modifier = modifier;
 	),

-- 
2.34.1


