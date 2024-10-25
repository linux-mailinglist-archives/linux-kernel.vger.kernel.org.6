Return-Path: <linux-kernel+bounces-380785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 244AC9AF617
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 02:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DF7F1C214EA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 00:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4151E531;
	Fri, 25 Oct 2024 00:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LH31sfeF"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B36FB673
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 00:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729815620; cv=none; b=lImMOdWpuKbCEsNveQpVf0hX6Asq04Zb84B80TfO0nUOsg5oujdyfXTYxRnCi1nrMch4Eu98jklh5o0qrjTvS7ZDZikT+DCD7e4V5ZdsupbShBFWd9mxTFxKphaeyvnYtEseFufL8624iLmcD2CYKf6AAhAwKqR6JEqIIMSdbOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729815620; c=relaxed/simple;
	bh=PHJ6sTq6uvNcQ3gChU8Ct2HDM9wv2LQmbjOrC4ORXdI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JlmRMfMt8OePJ17T1lK1WdVa9kE+zT8225zLX9lFFz/ko/LvVNhf/eUAlNDP1dH45/+bD1SkkOC7EJRuSluz7alLllwduEMbf6VtTjLUL56bWmCaITTmQ7+uu26qujkyzrei/x05qqGA2zBGsvEnLmk8tFxeAKSJRJ5WKQHNRnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LH31sfeF; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539fbbadf83so2028045e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 17:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729815617; x=1730420417; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JazWMIkVQS8p1EyDaDe3Z84iDsKuOpFQiDqKXM3qNvI=;
        b=LH31sfeFxxSwG+UhHkFxFuvYWRHx+pFFYelo/YbeFhTrcv4fqnYV1/XQNDuqc6bxUy
         FnWHAy9Sw/a/i2YDYxK8ltOI4aF2/1A4Bvv/9uqlkKdUNcAEcTz0IREcxCBzeXVbnJcy
         bVLBJGp7eqI/jCW6zFwPOouMBGMV6bek4oDEwxDv6j8GkSWyg2tOZwPEBGmp9P2H1uUD
         niv6CAAggRB1noTZqDkdpfZwqbG+2MdhnUMlLgsbwvkA2r+Aum2dg91AQH2MJ00O9NIi
         cjyCnftbcLU1MPSoNYcWKrPJ4VcmM1chY7gl9fuWZUZvRHIKLWsw6Le5L/14SPGS6G0v
         on2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729815617; x=1730420417;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JazWMIkVQS8p1EyDaDe3Z84iDsKuOpFQiDqKXM3qNvI=;
        b=vQ+TcR1GPuZP34J7CQG7UbmS7Z1K4Jl8PeM4LSwv22fOUtTfDCCOi3x65fOAHrcoYM
         FRhptv6vclTgofDwj38BdH45cO5hZ3NgH9xfa5krd9zgrQrLavwNdvbVLmsLpB7WqJ32
         1qPbxZktsONsu+w6xXvHZrQPIW/nSqfYTVawYlZva95dwCYH39Jnt1trpCowqHCCn6IL
         +iPyWJvqEW1NrOElUOvsuY99mUmHPRUMpn1QRWGwpeGUjq50xzfTWZg0imFk6Yo/fgXz
         U6T5G8z9TxMxtDa3HhkEGzuChTgHHkRpBvgDWb1Vii0E3nugXsxrjs0AQJlU9gs1sdXW
         nvqw==
X-Forwarded-Encrypted: i=1; AJvYcCV713zj806k2ClwahHAlRdRh2z4qnP5c0LMLAEw7IDwALTamuAgAxQD4Pkjiv8oGmCjimwFg8TZzi5EcV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6RXJhBOCNeC8AofYciRgpvJwy4TxslDS9R5X+IsCd+WaLaxkQ
	O5bYwsjxDGp+mhgCww9T9wwwaXffdoJuse3TosWFC+hRLcdGlzgA00kLWWpuKaSz2Z7NCDjP8Yk
	K
X-Google-Smtp-Source: AGHT+IH4ihiQHJARiTWnfLQwFkyVcMpyXvC7EwdHVpv5nSyfcZCcySDU5vmWQQTKvV5ZfTfcCAMgCA==
X-Received: by 2002:a05:6512:10c7:b0:539:e023:8fce with SMTP id 2adb3069b0e04-53b1a2facb6mr4665041e87.12.1729815616586;
        Thu, 24 Oct 2024 17:20:16 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1b05b3sm6227e87.161.2024.10.24.17.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 17:20:16 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 25 Oct 2024 03:20:09 +0300
Subject: [PATCH v6 2/9] drm/msm/dpu: move pstate->pipe initialization to
 dpu_plane_atomic_check
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-dpu-virtual-wide-v6-2-0310fd519765@linaro.org>
References: <20241025-dpu-virtual-wide-v6-0-0310fd519765@linaro.org>
In-Reply-To: <20241025-dpu-virtual-wide-v6-0-0310fd519765@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2729;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=PHJ6sTq6uvNcQ3gChU8Ct2HDM9wv2LQmbjOrC4ORXdI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnGuQ6hQho0KIgBTBFvj9q6BbQKv0Gp3wic2CJz
 SwNl9VOghaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZxrkOgAKCRCLPIo+Aiko
 1UgnB/4lW/gdxBKLrIy5SBKyqWzevme3eymEBo8+UbDaxqGVnggcx0aM3CP9kZvr0Ii5OvjBcvf
 0fSlCwZh/tVpiyYOw+1/ZTNRm7qxPE9FSWmL5GCK0kOeYQ+sPmyHP7kB09bWO8lLVYkJ1srq1WK
 0XU9iMZHCM+ZKo00OqpFD3Nw6lhKdSvqauT2HRfoYmhOkTl+DokoGE5EIOW5CwQ97/9xD3I/X6F
 0ZBtfkevH5jV4TlTLyUTvnulTMNGBFWdFwZe3igUVvKuTCJt+PzzxmCe5+LmW2iZrPMq51iozPO
 7HnoidCOp3JT5A2rfeMCr2jvND7ccagqEPRH7j1IHvNb2/XU
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

In preparation for virtualized planes support, move pstate->pipe
initialization from dpu_plane_reset() to dpu_plane_atomic_check(). In
case of virtual planes the plane's pipe will not be known up to the
point of atomic_check() callback.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index 37faf5b238b0..725c9a5826fd 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -797,13 +797,22 @@ static int dpu_plane_atomic_check(struct drm_plane *plane,
 	uint32_t max_linewidth;
 	unsigned int rotation;
 	uint32_t supported_rotations;
-	const struct dpu_sspp_cfg *pipe_hw_caps = pstate->pipe.sspp->cap;
-	const struct dpu_sspp_sub_blks *sblk = pstate->pipe.sspp->cap->sblk;
+	const struct dpu_sspp_cfg *pipe_hw_caps;
+	const struct dpu_sspp_sub_blks *sblk;
 
 	if (new_plane_state->crtc)
 		crtc_state = drm_atomic_get_new_crtc_state(state,
 							   new_plane_state->crtc);
 
+	pipe->sspp = dpu_rm_get_sspp(&kms->rm, pdpu->pipe);
+	r_pipe->sspp = NULL;
+
+	if (!pipe->sspp)
+		return -EINVAL;
+
+	pipe_hw_caps = pipe->sspp->cap;
+	sblk = pipe->sspp->cap->sblk;
+
 	min_scale = FRAC_16_16(1, sblk->maxupscale);
 	ret = drm_atomic_helper_check_plane_state(new_plane_state, crtc_state,
 						  min_scale,
@@ -820,7 +829,6 @@ static int dpu_plane_atomic_check(struct drm_plane *plane,
 	pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
 	r_pipe->multirect_index = DPU_SSPP_RECT_SOLO;
 	r_pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
-	r_pipe->sspp = NULL;
 
 	pstate->stage = DPU_STAGE_0 + pstate->base.normalized_zpos;
 	if (pstate->stage >= pdpu->catalog->caps->max_mixer_blendstages) {
@@ -1286,7 +1294,6 @@ static void dpu_plane_reset(struct drm_plane *plane)
 {
 	struct dpu_plane *pdpu;
 	struct dpu_plane_state *pstate;
-	struct dpu_kms *dpu_kms = _dpu_plane_get_kms(plane);
 
 	if (!plane) {
 		DPU_ERROR("invalid plane\n");
@@ -1308,16 +1315,6 @@ static void dpu_plane_reset(struct drm_plane *plane)
 		return;
 	}
 
-	/*
-	 * Set the SSPP here until we have proper virtualized DPU planes.
-	 * This is the place where the state is allocated, so fill it fully.
-	 */
-	pstate->pipe.sspp = dpu_rm_get_sspp(&dpu_kms->rm, pdpu->pipe);
-	pstate->pipe.multirect_index = DPU_SSPP_RECT_SOLO;
-	pstate->pipe.multirect_mode = DPU_SSPP_MULTIRECT_NONE;
-
-	pstate->r_pipe.sspp = NULL;
-
 	__drm_atomic_helper_plane_reset(plane, &pstate->base);
 }
 

-- 
2.39.5


