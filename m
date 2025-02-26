Return-Path: <linux-kernel+bounces-533842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B64CA45F67
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA84E3AF78B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA1A2BB13;
	Wed, 26 Feb 2025 12:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VxBHbk33"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4FB2F37
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740573145; cv=none; b=r/RHQvtMsW4LpCx/BKFPHT3t/dX4hafQMZxEBu8jj91kv7mXEZ7c46nl4a3dqdZrf5VE0rum8m4KK7rmTrEerkxDM35Lt4APBCiUVv444Hkd9Tk3NjBlz+ZFPWsnWZpjuqFoK99UiLbKKN6rQy/s2cN+e2hGpTkGMXByeBJfhRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740573145; c=relaxed/simple;
	bh=f7vmxxj2aXQGnMGrEnTOGdqDh+9P0TeHrkYJRqajnDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l0oKCs9JtaIGO6Ia2u6AinxbWcH8pQI+vFQNTwsE6kHz9nCqgzorC6CGY1jHcmvQgx9mojNLi78jGRr1NLRstSvYxI6VvlW1+oAH7szug9JogtkgY/uB/T+3ZyW4gfhSnZzyakJuC8KD40FFhqZVpYQWxtvmPiHJz5eKjmmlKHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VxBHbk33; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220ec47991aso93699565ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 04:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740573143; x=1741177943; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=23d26b6/rNMhE2TK5FNAdZfYGc+bxo+2P+WD0NWcJF8=;
        b=VxBHbk33hNOQp+qMDwbrc0/YMxoeP+BzuGc6+g8+eK4YvzPQFbaikvxnzqHG2UI2BX
         dNFDweMX2B+ivvUsoUA0PuI3cIxpfpTE5YUwMEqB751U7qUaCOLmtIULmM7o/KMekNZu
         jVkCp3+/xShEZ+8KdqaMSScVAQ/D2PDTd+Jm//MILieWG8ptt4FQT6Axz8VKTjJdQri1
         yn2rTGpgbpeOu+PLmDYa+psLA8FOBGcuhVPqskUE3pRzOnMaQC3xn+pK36lAewCngLFW
         u7U1VHa/byx8cOZg8xB01w/fYc/aSfH73mziWDUgZOq5dSpFR81MUyymzoYDR6chpw/l
         XsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740573143; x=1741177943;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23d26b6/rNMhE2TK5FNAdZfYGc+bxo+2P+WD0NWcJF8=;
        b=scUkSXBWyKsgz63WiTrpmh0HJ8kvVr99KEBPgUzXPeBsSqkiMO01hi4IzUuDzfi8iz
         yGhxxfE5fFGgOcZsmzSsVMUVv3azGdHUs7gfxOLvgnyrYq5Tmy8PPl9HyyFVb9vmwB1R
         u6NgMvlOKd8AjrM28UP1OWzPLMvwmFkFFudA/HZl7QqK39YikJ/9D7P6pCTpwMWqqmgl
         tc6o3+zJlwbyr2bla56ZXLIqrIKJ/5KgCU5NhNBEhE9GAI4dosl6suKv2y8k7idV9n/G
         je8QN3a97TgaBrxwYFxT/E1XyVbpkpg3rimFV8W5/hShZZxt4D+rwj9KQzk7swVmhTIw
         0T0w==
X-Forwarded-Encrypted: i=1; AJvYcCVfBbC85abDCBP3XTHPb0s1YLqLyFiOuQ0A6GD2oO2eU0KyQceq8JzXpTPsPdWJFIN4+0uiULODVnzpLtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwizPa2ZIk0lBTgpXdTQgcBqa0svS21uQR2KLps3plBdUSgSA7L
	7xN5PQ5t8P4k9T0hCKK1R1h4kvLqPm3zb6q8pKLrt1NBc5iMWyAWYEqJbzRfZrNvzcRm9+3rg/p
	KYe1n/X08
X-Gm-Gg: ASbGncugoH9uuRvwe1Ymq9e/QAoRtAXrSBeBEdMqtMia4lrDudiM0901CKFiH0Z2YRJ
	HlKhWS1LFl/DHFcoMsw4E8LoNxWrNKGeDDjcLIRT+7R+V/ltDkItuz6CkxTjH7+RmYowipEaUCQ
	7WRA4FJPyHD2OXC7npp43JSn4OEdzyZdTlo4SVntggNOOl8xqY29DfsKBsUKgPbOJVYwLZylazk
	P33id3NHlOwVFOkBVuVNoKzqeSGIx8HURuI2B4b+CtZLcN7jBOg9t4+KVvvSzCiFf63d9YaVVLO
	MBd2x/SAjc2V5cLfAfp/L0U=
X-Google-Smtp-Source: AGHT+IHVVzFpsGmtsq4hAfdadtZ4ek/RNhHfQ2epqmHAApnWgocn4RuqZ/m42Ny0pXhmgs81z0+wAw==
X-Received: by 2002:a17:90a:cf8e:b0:2fe:7fea:ca34 with SMTP id 98e67ed59e1d1-2fe7feaca86mr3927063a91.32.1740573142662;
        Wed, 26 Feb 2025 04:32:22 -0800 (PST)
Received: from [127.0.1.1] ([112.64.61.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825d2ed3sm1352479a91.29.2025.02.26.04.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 04:32:22 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
Date: Wed, 26 Feb 2025 20:30:50 +0800
Subject: [PATCH v7 01/15] drm/msm/dpu: check every pipe per capability
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v7-1-8d5f5f426eb2@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740573128; l=4444;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=f7vmxxj2aXQGnMGrEnTOGdqDh+9P0TeHrkYJRqajnDk=;
 b=X4cagGaZxaqU7Ia3nLsHe6h2uE2PcqvGMXzJ36oRUK9xMkHSLwHG9XOBJyo95a54hBxj7fnz3
 lxh7fMCVHPdDc9z1HHeinvb6lT0w53TFAGULMG1msVXb9y4p6Fa2Q71
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

The capability stored in sblk and pipe_hw_caps is checked only for
SSPP of the first pipe in the pair with current implementation. That
of the 2nd pipe, r_pipe, is not checked and may violate hardware
capability. Move requirement check to dpu_plane_atomic_check_pipe()
for the check of every pipe.

Fixes: ("dbbf57dfd04e6 drm/msm/dpu: split dpu_plane_atomic_check()")
Signed-off-by: Jun Nie <jun.nie@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 71 ++++++++++++++++---------------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index 098abc2c0003cde90ce6219c97ee18fa055a92a5..feb90c42fef58f3385625f6d8165bfcdabf46d2d 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -729,12 +729,40 @@ static int dpu_plane_check_inline_rotation(struct dpu_plane *pdpu,
 static int dpu_plane_atomic_check_pipe(struct dpu_plane *pdpu,
 		struct dpu_sw_pipe *pipe,
 		struct dpu_sw_pipe_cfg *pipe_cfg,
-		const struct msm_format *fmt,
-		const struct drm_display_mode *mode)
+		const struct drm_display_mode *mode,
+		struct drm_plane_state *new_plane_state)
 {
 	uint32_t min_src_size;
 	struct dpu_kms *kms = _dpu_plane_get_kms(&pdpu->base);
 	int ret;
+	const struct msm_format *fmt;
+	uint32_t supported_rotations;
+	const struct dpu_sspp_cfg *pipe_hw_caps;
+	const struct dpu_sspp_sub_blks *sblk;
+
+	pipe_hw_caps = pipe->sspp->cap;
+	sblk = pipe->sspp->cap->sblk;
+
+	/*
+	 * We already have verified scaling against platform limitations.
+	 * Now check if the SSPP supports scaling at all.
+	 */
+	if (!sblk->scaler_blk.len &&
+	    ((drm_rect_width(&new_plane_state->src) >> 16 !=
+	      drm_rect_width(&new_plane_state->dst)) ||
+	     (drm_rect_height(&new_plane_state->src) >> 16 !=
+	      drm_rect_height(&new_plane_state->dst))))
+		return -ERANGE;
+
+	fmt = msm_framebuffer_format(new_plane_state->fb);
+
+	supported_rotations = DRM_MODE_REFLECT_MASK | DRM_MODE_ROTATE_0;
+
+	if (pipe_hw_caps->features & BIT(DPU_SSPP_INLINE_ROTATION))
+		supported_rotations |= DRM_MODE_ROTATE_90;
+
+	pipe_cfg->rotation = drm_rotation_simplify(new_plane_state->rotation,
+						   supported_rotations);
 
 	min_src_size = MSM_FORMAT_IS_YUV(fmt) ? 2 : 1;
 
@@ -923,47 +951,20 @@ static int dpu_plane_atomic_check_sspp(struct drm_plane *plane,
 	struct dpu_plane_state *pstate = to_dpu_plane_state(new_plane_state);
 	struct dpu_sw_pipe *pipe = &pstate->pipe;
 	struct dpu_sw_pipe *r_pipe = &pstate->r_pipe;
-	const struct msm_format *fmt;
 	struct dpu_sw_pipe_cfg *pipe_cfg = &pstate->pipe_cfg;
 	struct dpu_sw_pipe_cfg *r_pipe_cfg = &pstate->r_pipe_cfg;
-	uint32_t supported_rotations;
-	const struct dpu_sspp_cfg *pipe_hw_caps;
-	const struct dpu_sspp_sub_blks *sblk;
 	int ret = 0;
 
-	pipe_hw_caps = pipe->sspp->cap;
-	sblk = pipe->sspp->cap->sblk;
-
-	/*
-	 * We already have verified scaling against platform limitations.
-	 * Now check if the SSPP supports scaling at all.
-	 */
-	if (!sblk->scaler_blk.len &&
-	    ((drm_rect_width(&new_plane_state->src) >> 16 !=
-	      drm_rect_width(&new_plane_state->dst)) ||
-	     (drm_rect_height(&new_plane_state->src) >> 16 !=
-	      drm_rect_height(&new_plane_state->dst))))
-		return -ERANGE;
-
-	fmt = msm_framebuffer_format(new_plane_state->fb);
-
-	supported_rotations = DRM_MODE_REFLECT_MASK | DRM_MODE_ROTATE_0;
-
-	if (pipe_hw_caps->features & BIT(DPU_SSPP_INLINE_ROTATION))
-		supported_rotations |= DRM_MODE_ROTATE_90;
-
-	pipe_cfg->rotation = drm_rotation_simplify(new_plane_state->rotation,
-						   supported_rotations);
-	r_pipe_cfg->rotation = pipe_cfg->rotation;
-
-	ret = dpu_plane_atomic_check_pipe(pdpu, pipe, pipe_cfg, fmt,
-					  &crtc_state->adjusted_mode);
+	ret = dpu_plane_atomic_check_pipe(pdpu, pipe, pipe_cfg,
+					  &crtc_state->adjusted_mode,
+					  new_plane_state);
 	if (ret)
 		return ret;
 
 	if (drm_rect_width(&r_pipe_cfg->src_rect) != 0) {
-		ret = dpu_plane_atomic_check_pipe(pdpu, r_pipe, r_pipe_cfg, fmt,
-						  &crtc_state->adjusted_mode);
+		ret = dpu_plane_atomic_check_pipe(pdpu, r_pipe, r_pipe_cfg,
+						  &crtc_state->adjusted_mode,
+						  new_plane_state);
 		if (ret)
 			return ret;
 	}

-- 
2.34.1


