Return-Path: <linux-kernel+bounces-442292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEC59EDA4C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A6C4167DA3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7AE1F238B;
	Wed, 11 Dec 2024 22:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xgzo3l4C"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3711F2376
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956868; cv=none; b=uubER3552eykpFqRjOeEGnqQV9zuiVNx8CKVXDaRebgfV4k8c+wlG9k6KQBQkaTG8KtLDQr1GawkUnbqhvYdXLUhtwjZz9eUblQ8fkGuDjPosw4vXqzb7x7zkozEvJF5Mv8aH/9g+PsrFrG9Lpc4PfZuvZ0x0TeWqS2uPK7oNRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956868; c=relaxed/simple;
	bh=Fq+LO8VWUcEVEEM7b4zMt/e5qKYfK8l4AnLblE1FTsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VnAIwlljd/tKwXmAW0xD23DFKwBnjzSwrREFFWo6IAcxPxIOpp6w4hOajgzJ4VCGnv0yv5Ttv6v9NTjQh+PGgVHHgci3IPlGf2L/A7oevmtCWjiAdUnUaV4rKQJj9E5bu4Ru9yCXVLg6R8OIMhYWvfBYIrlAtwtSUIPWiV5n2WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xgzo3l4C; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6efeb120f4dso5877b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 14:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733956863; x=1734561663; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kQZXgd67ZCOvJ076FqycnZdlFNGoIk/UlxfteNEpnm8=;
        b=xgzo3l4CRXCezIZSWIYW7E7wHScU60zMB/GzTouyGWpIiE1mxeUaARRvrJ1DHPjE8q
         uiKdqrXz2oV1l/2ckRBaL72r9pvU7PwF+Tbmnx3u491ErN0Zq1pLNkj54fYQCPdJJmt9
         nldAPrpUKxtmBfNbB7pJYJ/pNTmfvUMAibvIQm123MKEWYrk1Hc6tPSWLYUMMYdrIWCP
         +ce8aRUq3VlurM8N9bCc5PmbDYU0OShHIvEps/VX4JZwEHa4g9lIyOEo588bqNi6q98O
         L8PAu87u1UZIkJOGT+L1tflwUUHZTF/AZsMF/mo3vOAuVJpUF3O8Tg3VjGqQt5mU1CqS
         ypuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733956863; x=1734561663;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kQZXgd67ZCOvJ076FqycnZdlFNGoIk/UlxfteNEpnm8=;
        b=cOW0qmA2R7pAtZE8vmAS3GbnjDx/lAMA8A4gcL54ml4SyKd2th4scmBOFw848e3VJ9
         Ik5AdTSMqhkh7ZQMESowxqB0ePzqeFRXkw/F6IgbYOr7SGr6XW5EtthcBKQw2guLH0Ak
         RXqRlHPro0nxM+qKgb2ZAvB/wyFmR/luRRJwhZPDoVKKsfx/Nn7BFo4MGq3sLUYmzs2V
         phcxfeZFX+sas62GLkC7TywCQ/7jhF42dYqq1H0AiBSkL6zCFK8hBN/vDM8grStEv4yB
         +QR4ytc5PfOkMsvAD2Dwxact1NxHmgtfYNaV5H5573bqsEpq4CYCRMIgSCt6Xg73agc+
         5swg==
X-Forwarded-Encrypted: i=1; AJvYcCUG+Je/AdmlN0zUKC4JYr8hScMdhl2VcAjVhXxZ7pHonMOsMbLUx43JZka36PlLIWAr9KsU1JgIaOBiaVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ3E88mBP8xAPajMfDCxcmmvUPLazMNWzNLcKet068WSRmHao/
	x8+cILv4+Jkrbb/uCTUw4nDa7nMDe1150F/rm/D75GQ5/1JH2pJ3qBt/lPXrbCfC86TrERfi5FF
	uXNslCKIlnT3aRkbyHMdDLggGBFGajf5F+hvNVw==
X-Gm-Gg: ASbGncuISoGzbTtQracjvMSKMIHZYhwpQFwOt/RncRhc43c7DLcL4Vd34V+tNrxu4+k
	GD6ttKwykoG8jJAaZG9KTysKpOy4yVoeogqCM
X-Google-Smtp-Source: AGHT+IFx9U1xmIQiDX1vBx6D7MZb4EK2Reh5V7D+ZfzgWjxQn2K+gafTKYLrSeI+6HrlwX0/AVB9Z8wzIXTbGCE1GE0=
X-Received: by 2002:a05:690c:6f92:b0:6ef:7fdb:7d41 with SMTP id
 00721157ae682-6f19060cabemr17208557b3.0.1733956862793; Wed, 11 Dec 2024
 14:41:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130-dpu-virtual-wide-v7-0-991053fcf63c@linaro.org>
 <20241130-dpu-virtual-wide-v7-2-991053fcf63c@linaro.org> <160151f0-9cc6-40f6-9f53-466185835e4d@quicinc.com>
 <hpmxj7tjmvbo55izoxgygqmysbabnpb35mprvn6w53vbtehnwe@yxmiigoeuyf3> <cfbadc5a-6de0-4081-948c-3542c615a992@quicinc.com>
In-Reply-To: <cfbadc5a-6de0-4081-948c-3542c615a992@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 12 Dec 2024 00:40:51 +0200
Message-ID: <CAA8EJpoLwOVN3MB70UkiPe-dRhFMBigpTYc2PMn+tXnD=LhoBg@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] drm/msm/dpu: allow using two SSPP blocks for a
 single plane
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Dec 2024 at 00:38, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 12/11/2024 2:24 PM, Dmitry Baryshkov wrote:
> > On Wed, Dec 11, 2024 at 01:51:51PM -0800, Abhinav Kumar wrote:
> >>
> >>
> >> On 11/29/2024 5:55 PM, Dmitry Baryshkov wrote:
> >>> Virtual wide planes give high amount of flexibility, but it is not
> >>> always enough:
> >>>
> >>> In parallel multirect case only the half of the usual width is supported
> >>> for tiled formats. Thus the whole width of two tiled multirect
> >>> rectangles can not be greater than max_linewidth, which is not enough
> >>> for some platforms/compositors.
> >>>
> >>> Another example is as simple as wide YUV plane. YUV planes can not use
> >>> multirect, so currently they are limited to max_linewidth too.
> >>>
> >>> Now that the planes are fully virtualized, add support for allocating
> >>> two SSPP blocks to drive a single DRM plane. This fixes both mentioned
> >>> cases and allows all planes to go up to 2*max_linewidth (at the cost of
> >>> making some of the planes unavailable to the user).
> >>>
> >>
> >> Overall looks so much cleaner after unification!
> >>
> >> One small nit below,
> >>
> >>
> >> You can still have,
> >>
> >> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> >>
> >> Note: we have started testing this series with sc7180 CrOS, and will report
> >> our findings/ give tested-by this week.
> >>
> >>
> >> <snip>
> >>
> >>> +static bool dpu_plane_try_multirect_parallel(struct dpu_sw_pipe *pipe, struct dpu_sw_pipe_cfg *pipe_cfg,
> >>> +                                        struct dpu_sw_pipe *r_pipe, struct dpu_sw_pipe_cfg *r_pipe_cfg,
> >>> +                                        struct dpu_hw_sspp *sspp, const struct msm_format *fmt,
> >>> +                                        uint32_t max_linewidth)
> >>> +{
> >>> +   r_pipe->sspp = NULL;
> >>> +
> >>> +   pipe->multirect_index = DPU_SSPP_RECT_SOLO;
> >>> +   pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
> >>> +
> >>> +   r_pipe->multirect_index = DPU_SSPP_RECT_SOLO;
> >>> +   r_pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
> >>> +
> >>
> >>
> >> There are two places where the multirect_index and multirect_mode are reset.
> >> Would it be better to just have a small api dpu_plane_reset_multirect() and
> >> do this there?
> >
> > I'm not sure, what's the benefit. We can add an API to reset one pipe
> > (to also be able to use it in _dpu_plane_atomic_disable()), but then
> > it's just deduplication for the sake of deduplication.
> >
>
> Yeah I was thinking something like
>
> dpu_plane_reset_multirect(pipe);
> dpu_plane_reset_multirect(r_pipe);
>
> But its only a minor benefit, hence as I wrote it as a nit. We can keep
> things as it is, if its unnecessary in your opinion.

Well, granted that I hope to be able to drop non-virtual planes after
a few releases, I don't think it makes real sense.


-- 
With best wishes
Dmitry

