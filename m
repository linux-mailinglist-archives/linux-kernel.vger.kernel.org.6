Return-Path: <linux-kernel+bounces-517803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B1AA385C7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EE00188ABE5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F7821D587;
	Mon, 17 Feb 2025 14:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wCMMf9Pl"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D5221D584
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801805; cv=none; b=BMs1pTAfKE4YVol7CZpf6rCPmKy7jlCdV5OSeJR4aP3zOuO+72eyuY3WDHXVG1lIO9RNvZKFVeOsKr352+P6C2W4cWk/fzJocjg1sUleIDudRi7lHaquVm6AZJRdqwLD/CfCN3adswRLYUQAN8BodOvVbBWhHDVwBLAXlMX8JOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801805; c=relaxed/simple;
	bh=KapOubmHrnJ45Q6eHl5TCN92cp2NDgoLCMZwQ/tSSxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vg2Kty2jSfzebCAbeKHhN2P130UpHnw9H4Hh/T9HTN2Tcf9RSCYIj8T/BJ+2CxA4RQz9K9g9mcnTcEg/rD06NF3LYstRu6zT/FsrkY/bZxxZ/zdXMP0dSzRiSyZ4VsiodmjnvG/LpMgE6h3Fmo1yupPJHv0D33s7OZOeQ99aIsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wCMMf9Pl; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-221050f3f00so35592385ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 06:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739801803; x=1740406603; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=69vNi3OZA4rlkkM15gA1GocQBCacDIa/QmSzA91F8v0=;
        b=wCMMf9Pl6zlf50j0BFovfleOdqOcq44WtNLSZ5J++A8uUbvBQGkdK4dcZibbGR8mKy
         mWzdnjA+konSLP9x3jgEJZAYUt2gsdDt26gL1PVlHoMryOp0YZnGD/E3LA0oXCCEDp80
         SnORJ10B6QF8wrRXCgmKVIM4lG1F+47B2oWrih4ILQEwwubmWmlsmr2IH5pHxv5Thw0I
         umGW7gguD7zfQc+G6gzAUu/JX4klkFGM+be59dF3fNwBW2JCpKUkdnvmh4+0AcQXKAGO
         jnLE2ecXecxALsHRg2dxmMU3ywNuy18/3xevxBCm13d2kQ9Rrqy2h2A4OsgkxAFTJuTV
         V81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739801803; x=1740406603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=69vNi3OZA4rlkkM15gA1GocQBCacDIa/QmSzA91F8v0=;
        b=gmYEG8CVT8/+WPgWoK3VfimJCIRQnB1Mqpoe48H18efHeitO341iKUO/sLQBEaQSMw
         ibEK23i9Xs9YRHH6YE5eVjd+ngyCeRSKrAOGGO8Jixj3mOtVo0OjKAOkENkohgYzHLy8
         BR4eUp40KUBZZhXqApMwomLsknUfhM1sdgXP98rPuYhybtkEwvl8JCDdjw6JOvqgu18b
         hSjVt8qCsBk72L4PbGM3oLlZP3u27NaboV2KAxCJ0vXPzf9swtFH3a2CNJU+OhRXp1X4
         SBs33RIsH5rGoqKSCSbcTzyp+k3zZnr1VwLfjCbW/+kvFiCFRE+bB76HAZO26PKQvGJD
         XCUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMgvTX0P026gAZ7RIZkABxESQYEZxeK9BJXUJF3LKhausS5pBlZV5KYxmBihM4XCaCgEcgVtq4Y3luuR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyODsqEi7LJNmhVUuff2bhSQf9SBQFTznezUI2tQCrlL1H314mu
	DE+wVdStQjaJb93MhGnuh4F4N/W9+Cy0GASWZvdNjwgrhB9dTxnxPwof+3OqtC7y7lp6oIKUKhW
	iXzwAaA==
X-Gm-Gg: ASbGnctmoypLrT9F6EhxpvQzV5JE29x6w6Zm3O6ST5VVUU7sXyKE4vgiDE7v3Cf4H3m
	E4ZQtoJcx/PgdIoldSaUaOK0QgUbG8O3lKR54DQYLf4dChEj9V5hHCbpucUWWR/A0w2RnlaiRjA
	tcICykZM2C5aWtxSEJhEqMBsApK9GtlWK7jFsCkXJcBMAwuvrTi5wfKSwBM1pet0GP8jgvRGZSt
	lX0irvApizEKDCOQCNOM67NOnyPFH/l+8eY6wplYko8fQzS54pCmKPj7Vrzd/Gie7BMrwzypfvl
	Gc3vW1IqqPnl
X-Google-Smtp-Source: AGHT+IHW+t1AByBvZfuKljqfaxNCxT/6ZGDzP+lPvsrisD+l8/bqLv/XLHwaFORKcAyayNhHDuPrZQ==
X-Received: by 2002:a17:903:2f8f:b0:21f:515:d61 with SMTP id d9443c01a7336-22104028a15mr167933135ad.21.1739801803051;
        Mon, 17 Feb 2025 06:16:43 -0800 (PST)
Received: from [127.0.1.1] ([112.65.12.217])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5366984sm71900845ad.60.2025.02.17.06.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 06:16:42 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
Date: Mon, 17 Feb 2025 22:15:50 +0800
Subject: [PATCH v6 01/15] drm/msm/dpu: check every pipe per capability
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-1-c11402574367@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739801787; l=4383;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=KapOubmHrnJ45Q6eHl5TCN92cp2NDgoLCMZwQ/tSSxY=;
 b=Z/jcy7aDeNebmhku/f2ueRJ6iMchZ5gXAUP/St9wMgr5Bfi/LjEPAq4gVpOJ09R2eCum4Fz66
 5IzsXBs82M7BJfAIYuUURWURLp8NAMzGrIfczPMt2dTa5lfaWqY/Iwm
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

The capability stored in sblk and pipe_hw_caps is checked only for
SSPP of the first pipe in the pair with current implementation. That
of the 2nd pipe, r_pipe, is not checked and may violate hardware
capability. Move requirement check to dpu_plane_atomic_check_pipe()
for the check of every pipe.

Fixes: ("dbbf57dfd04e6 drm/msm/dpu: split dpu_plane_atomic_check()")
Signed-off-by: Jun Nie <jun.nie@linaro.org>
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


