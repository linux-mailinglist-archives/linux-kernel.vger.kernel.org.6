Return-Path: <linux-kernel+bounces-384689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D162D9B2D3E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 008B81C21A37
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2799C1D3648;
	Mon, 28 Oct 2024 10:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uggDzW3u"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F59317E010
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112378; cv=none; b=Kqola/CWIbIqGZWusx7LHFQGGhB9YOE80DvIHmuxU22hU4CAm5AEZVRjYkIWsBB9jUo9uSky7T0uvuaSFBUnUOVo7hOqb8grCyu6a08CAMumLGXJYE+Di8clSaym7roKs/Xma4UNx/V8G8/56ZJgLOFLpWvLq/D9nyP0vsX60eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112378; c=relaxed/simple;
	bh=SICDd0axSbFMeeXlp6VHRRv/+xJ5dkoI5WjGJ3O261w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URvXLlL5MG8mB5N1USqeY9uL9oueskQSgKGC8f5kMAarzEGQ2Q1GVPIMXtQ+469DCKDnG8EnA50llwJpQjynEQmbLUsUIgOvaIEy219QGHe1S38X+gmN5De/bG6X+TU3ZyCvKU6RTQRodd6WkbrJtECk6WBLfr/rd5ZWG1mF4b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uggDzW3u; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539fe02c386so4777557e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 03:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730112373; x=1730717173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CHj4nYgiHaKiW5aEYPKVHro023TFgtEOxg1MzyObDrg=;
        b=uggDzW3u0b4VFzlE14W7VYG3K00IJ9oKSdhJ2o0fZe4O0j9FGIFU86GHwLxamuBCEJ
         FjgLAxxCaI01Yegsmm+hj4VUwhdvekYATtaeLptVAN4gtDsteeG2tn4Tm6+l/meQEdEG
         jOfwcRiKnQKjO12izR3OzlUUMmfvcL0KG4nk2Afvex+H1NR2nxcoeEnYNWeRV5/Zad1y
         1Rgkq9BEk5pCZxzjWcIqj7HjozmK5iRFTNqaXxXJm8r3Kx6l48B5RowF0ub7eY1h0AbN
         UyJeVgxs/eE2ps+Cu5zD1V/X3AMAIYifE5ifajj4fU8EM9IgCy7AEXUfUaRyIOWUTINa
         C8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730112373; x=1730717173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHj4nYgiHaKiW5aEYPKVHro023TFgtEOxg1MzyObDrg=;
        b=d8Dae87zlyrvhwU3eX7s+cDYnTDysaQCbUz91sv75lSBxN7375xab0+b7ltO8+pMF2
         Ge9wG8dIXvivsqDwjhOHmyuUnO5DKdhodzu0/Eh9Q6O5Obzuor5qLwLxLzzZS/qnpG7Z
         31ClMNyrOUz2pJsiHGIMdwvV2uVx9SwyJt7Z9tdpu3yvxqNcb+2hnnYWcrwPRVrgO3bE
         FbFho8NApllovSDw43v0gHFArE2oYYuk1DVYGArRHlW3ebMiObrjTRCrATC0O8909LAJ
         pe7Kxwid4lyterylFGVE4NGglLvspyYl20zgyo5viuryR43EqqP1PzL5T1J5BxZmnEY3
         nFlw==
X-Forwarded-Encrypted: i=1; AJvYcCXGuUFhy3LxtEBGa/atgn4zRU4zmsDprwrjC1A0NFgdHax+ugPyumzXDEWQhKDK/3W3cK+Mmip/6KUFlMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8joveFvdR2GZ2jslwgA+2fijxjnvd1NPLNY0mhh/pPAFFhKJx
	ku4/YGTnbu8PWde7GP2wOtC9zhcMXzGFoDYXZ1IHG2FGoIN3y0Hz+MVyZR/v9sk=
X-Google-Smtp-Source: AGHT+IHmdmeAg2Am8DAe8AvOhZdn+dyWxgaURYqcx9xeJb14r6Mw3+xvZqYxW/k7eyS8xGuqbReo7g==
X-Received: by 2002:a19:6a12:0:b0:539:fd75:2b6c with SMTP id 2adb3069b0e04-53b2375231dmr3431313e87.21.1730112372556;
        Mon, 28 Oct 2024 03:46:12 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1cbe9dsm1053140e87.225.2024.10.28.03.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 03:46:12 -0700 (PDT)
Date: Mon, 28 Oct 2024 12:46:10 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/9] drm/msm/dpu: move pstate->pipe initialization to
 dpu_plane_atomic_check
Message-ID: <jk4tfzg3zw4g23pg7rpre2pn32h6h46u2rc5ydnzuwo7mk3mam@ybw64lkaidyb>
References: <20241025-dpu-virtual-wide-v6-0-0310fd519765@linaro.org>
 <20241025-dpu-virtual-wide-v6-2-0310fd519765@linaro.org>
 <1dcf786e-463f-4e51-af71-66ee6077b5f1@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dcf786e-463f-4e51-af71-66ee6077b5f1@quicinc.com>

On Fri, Oct 25, 2024 at 12:00:20PM -0700, Abhinav Kumar wrote:
> 
> 
> On 10/24/2024 5:20 PM, Dmitry Baryshkov wrote:
> > In preparation for virtualized planes support, move pstate->pipe
> > initialization from dpu_plane_reset() to dpu_plane_atomic_check(). In
> > case of virtual planes the plane's pipe will not be known up to the
> > point of atomic_check() callback.
> > 
> 
> I had R-bed this in v5. Did anything change in v6?

No, nothing. I'm sorry for forgetting to run `b4 trailers -u`.

> But one comment below.
> 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 25 +++++++++++--------------
> >   1 file changed, 11 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> > index 37faf5b238b0..725c9a5826fd 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> > @@ -797,13 +797,22 @@ static int dpu_plane_atomic_check(struct drm_plane *plane,
> >   	uint32_t max_linewidth;
> >   	unsigned int rotation;
> >   	uint32_t supported_rotations;
> > -	const struct dpu_sspp_cfg *pipe_hw_caps = pstate->pipe.sspp->cap;
> > -	const struct dpu_sspp_sub_blks *sblk = pstate->pipe.sspp->cap->sblk;
> > +	const struct dpu_sspp_cfg *pipe_hw_caps;
> > +	const struct dpu_sspp_sub_blks *sblk;
> >   	if (new_plane_state->crtc)
> >   		crtc_state = drm_atomic_get_new_crtc_state(state,
> >   							   new_plane_state->crtc);
> > +	pipe->sspp = dpu_rm_get_sspp(&kms->rm, pdpu->pipe);
> > +	r_pipe->sspp = NULL;
> > +
> > +	if (!pipe->sspp)
> > +		return -EINVAL;
> > +
> > +	pipe_hw_caps = pipe->sspp->cap;
> > +	sblk = pipe->sspp->cap->sblk;
> > +
> >   	min_scale = FRAC_16_16(1, sblk->maxupscale);
> >   	ret = drm_atomic_helper_check_plane_state(new_plane_state, crtc_state,
> >   						  min_scale,
> 
> Do you think it will be better to move the get_sspp() call after the
> drm_atomic_helper_check_plane_state()?

I'd say, it makes no difference. I'll check your suggestion if I have to
send another iteration.

> 
> > @@ -820,7 +829,6 @@ static int dpu_plane_atomic_check(struct drm_plane *plane,
> >   	pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
> >   	r_pipe->multirect_index = DPU_SSPP_RECT_SOLO;
> >   	r_pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
> > -	r_pipe->sspp = NULL;
> >   	pstate->stage = DPU_STAGE_0 + pstate->base.normalized_zpos;
> >   	if (pstate->stage >= pdpu->catalog->caps->max_mixer_blendstages) {
> > @@ -1286,7 +1294,6 @@ static void dpu_plane_reset(struct drm_plane *plane)
> >   {
> >   	struct dpu_plane *pdpu;
> >   	struct dpu_plane_state *pstate;
> > -	struct dpu_kms *dpu_kms = _dpu_plane_get_kms(plane);
> >   	if (!plane) {
> >   		DPU_ERROR("invalid plane\n");
> > @@ -1308,16 +1315,6 @@ static void dpu_plane_reset(struct drm_plane *plane)
> >   		return;
> >   	}
> > -	/*
> > -	 * Set the SSPP here until we have proper virtualized DPU planes.
> > -	 * This is the place where the state is allocated, so fill it fully.
> > -	 */
> > -	pstate->pipe.sspp = dpu_rm_get_sspp(&dpu_kms->rm, pdpu->pipe);
> > -	pstate->pipe.multirect_index = DPU_SSPP_RECT_SOLO;
> > -	pstate->pipe.multirect_mode = DPU_SSPP_MULTIRECT_NONE;
> > -
> > -	pstate->r_pipe.sspp = NULL;
> > -
> >   	__drm_atomic_helper_plane_reset(plane, &pstate->base);
> >   }
> > 

-- 
With best wishes
Dmitry

