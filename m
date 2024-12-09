Return-Path: <linux-kernel+bounces-438521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C1C9EA22D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 23:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1C04282AD3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 22:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93D019D08A;
	Mon,  9 Dec 2024 22:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rgeXeJw0"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3692B1991C8
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 22:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733784964; cv=none; b=bdXE54vcRbzLIxyjLrScXGtjjIu81+FyZnDDLf+SlbYh8l3vxFj9lEkxsWd7NqmFnyei7a7+Sk+JjHYbtEBhQ3I04dMYCoVN5XVPpBF79Zss8sFpHeoSsv2aOd+Q6pCmvftM7KRCIvYTJx1ZZgoCuqB8uQZ1eCdTp97Y6YpCAck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733784964; c=relaxed/simple;
	bh=12hQphzsjjUkW1d9H8mxTIKNWUmFq/0NOxwXiPmnEYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ku5f6IW7FWH8kgkJspY/86Q54W2bGoaD/P2gy+mhgGMGHOqJxXr+bBM031ElKd8EB9hLyf9nXZHC8d1aNZh/4a4hcBo8Ds5rbgAwrjIa/7b33rWZZej4x/9et7k0agzCsAt5d/W6WebXJ1KtJOHwBC549OaC0b17Dwio7ZMNoKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rgeXeJw0; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e3983426f80so3933079276.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 14:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733784961; x=1734389761; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zg360WQmWUIYP8x3ZHAPjL5tUINcGUKvmQ6oZ/CIGO4=;
        b=rgeXeJw0eEcq29aZERXFxoa/dt8qQ6JFh4c7p9zjHZ4+AhNt1b+lyHTDFj8r+1f4F8
         IhAl3vGiXLZVBfrAtnnqdhpWu0CSnfm7FGtkPU9OYmJjBeC56UssKf/B3APvE06pq6BV
         o3/cMLjzxe9NoGzac/VgUSPfKx7huZbzg2U0RQuKGTtEvGCPMo588Myrwb1wEHIcpv7U
         lOiiqqBcPYMoSy58XmqAdmVLW+JHnGcMrONhrE1Z8xkuO4vhVGa8sa1Pktbwdmo/vAI9
         dBnFOsy1jRqVP3vzfgdHsbwjO3tzw1WhT1BSpxeh2i3IUYMX7DT4l/TULZCVfW+Nue5p
         Jujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733784961; x=1734389761;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zg360WQmWUIYP8x3ZHAPjL5tUINcGUKvmQ6oZ/CIGO4=;
        b=EMjVptYGnjUGR6BLM1+5/kJ/ZqKo5ou7VAEQQHUrw4BCVHLfeb2nzh7oFxNRvycCVv
         pviyZ2ODkD3b846hssynGYiiN3KI/QXU7vjQMFUN1UMCN68PhBItSHbc1jkkJIH9Iy8r
         cn63Ok2lyY1He5WTBjNt4W42cttQvg1IFTPpcKA7u/JHz+8LoSM+t8vb5WcmZQBYdJOO
         oElQB+UN7jx8cN+rzIzaDqDGHSDe9XRmVkIAmCa7KkyVUGrH7Y9emVEcD25PYb+eFfLT
         wG6f4o6SlB2wOo7bOAxMEQLJ7VsI4zppc/FaRUOcX1uw/U9Ri3aQP+zKXt2+w/EwjXKj
         H8nA==
X-Forwarded-Encrypted: i=1; AJvYcCW3amHIUQEbnmWdNgof8XCEO9O0wfWR4+RwjuO4Ee+AjYsuMD6L8dg9hOB30TRH8pwV+srFNPF1DeZ+06s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbHJv238J4gHuiqzu4729zWpuNTGxyxMxg5x+Hz4i1oib3UqJV
	y872K9MGPIuYfb4kdN4UsvOs1QCdXWkZ2RvA4bQUBhOP+tRi1nyTd52UckKHcG9c5S73OR5YT6d
	hx8V+/A3Xk+YcLVCzR0dACkC31zdICKpNR8PMmw==
X-Gm-Gg: ASbGncune67va1NxzZlDpyeijMo36ELCVmxox1pRa6Exp48UtdXyHMLsnG/YE/+OU5Y
	7G3Kc93lbQpOXa5lGBJ6TnH+Hwq7gpO+beQk=
X-Google-Smtp-Source: AGHT+IGBS529CP3nkBRL/hSBck7KZQ3bTAxMxZelGrotzUE4fm9stmMtccbFjnXYDNdhGC2bqHRBAtW7fsN53rpNuQ8=
X-Received: by 2002:a05:6902:288f:b0:e39:7b55:ff7d with SMTP id
 3f1490d57ef6-e3a59bde21fmr2097243276.49.1733784961163; Mon, 09 Dec 2024
 14:56:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206-no_3dmux-v1-1-72ad2677a323@quicinc.com>
 <zae7rlojv5iiq2dx7bxhdsmmzj73o65cwk7kmryxsst36gy2of@k3vcm6omcias>
 <b784049f-a72c-47ff-a618-e7c85c132d28@quicinc.com> <CAA8EJpojwG+_Q_9GYBFzQ_ReDbnO=+GbTPZscWgS1f=fkU0Anw@mail.gmail.com>
 <ab8a9d0e-e786-47ea-833d-59d2f2988898@quicinc.com>
In-Reply-To: <ab8a9d0e-e786-47ea-833d-59d2f2988898@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 10 Dec 2024 00:55:50 +0200
Message-ID: <CAA8EJpoNSJ64+JWsmrdFVce-ADtjDhZzEjC2ZcJbqvfQ47F-_A@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dpu: filter out too wide modes if no 3dmux is present
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Abhinav,

On Tue, 10 Dec 2024 at 00:30, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> Hi Dmitry
>
> On 12/9/2024 2:16 PM, Dmitry Baryshkov wrote:
> > Hi Abhinav,
> >
> > On Mon, 9 Dec 2024 at 22:07, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 12/7/2024 9:29 PM, Dmitry Baryshkov wrote:
> >>> On Fri, Dec 06, 2024 at 12:00:53PM -0800, Abhinav Kumar wrote:
> >>>> On chipsets such as QCS615, there is no 3dmux present. In such
> >>>> a case, a layer exceeding the max_mixer_width cannot be split,
> >>>> hence cannot be supported.
> >>>>
> >>>> Filter out the modes which exceed the max_mixer_width when there
> >>>> is no 3dmux present. Also, add a check in the dpu_crtc_atomic_check()
> >>>> to return failure for such modes.
> >>>>
> >>>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> >>>> ---
> >>>> Note: this was only compile tested, so its pending validation on QCS615
> >>>> ---
> >>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 13 +++++++++++++
> >>>>    1 file changed, 13 insertions(+)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> >>>> index 9f6ffd344693ecfb633095772a31ada5613345dc..e6e5540aae83be7c20d8ae29115b8fdd42056e55 100644
> >>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> >>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> >>>> @@ -732,6 +732,13 @@ static int _dpu_crtc_check_and_setup_lm_bounds(struct drm_crtc *crtc,
> >>>>       struct dpu_kms *dpu_kms = _dpu_crtc_get_kms(crtc);
> >>>>       int i;
> >>>>
> >>>> +    /* if we cannot merge 2 LMs (no 3d mux) better to fail earlier
> >>>> +     * before even checking the width after the split
> >>>> +     */
> >>>> +    if (!dpu_kms->catalog->caps->has_3d_merge
> >>>> +        && adj_mode->hdisplay > dpu_kms->catalog->caps->max_mixer_width)
> >>>> +            return -E2BIG;
> >>>
> >>> Is it the same as checking that there are LMs which support
> >>> DPU_MIXER_SOURCESPLIT ?
> >>>
> >>
> >> DPU_MIXER_SOURCESPLIT tells whether we can have more than one SSPP in
> >> the same blend stage.
> >
> > Do we have a feature bit that corresponds to the ability to use 2 LMs?
> > I mean, there are other *split topologies, not necessarily the 3DMux
> > ones. E.g. PPSPLIT.
> >
>
> A layer can always be split across LMs. There is not really any feature
> bit for this as it can always be done in pretty much all DPU chipsets.
>
> Here the issue is we are not able to merge because there are no 3d mux
> blocks and hence we cannot split.
>
> We need to merge because, the same display is requiring multiple LMs.
>
> PP split will be a single LM going to two PPs and that going to two INTFs.
>
> Hence the way to look at this patch would be we are avoiding split
> because we cannot merge and not that we cannot split.

Ack, thanks a lot for the explanation!

>
> >>
> >> 494     if (test_bit(DPU_MIXER_SOURCESPLIT,
> >> 495             &ctx->mixer_hw_caps->features))
> >> 496             pipes_per_stage = PIPES_PER_STAGE;
> >> 497     else
> >> 498             pipes_per_stage = 1;
> >>
> >> That is different from this one. Here we are checking if we can actually
> >> blend two LM outputs using the 3dmux (so its post blend).
> >>
> >>>> +
> >>>>       for (i = 0; i < cstate->num_mixers; i++) {
> >>>>               struct drm_rect *r = &cstate->lm_bounds[i];
> >>>>               r->x1 = crtc_split_width * i;
> >>>> @@ -1251,6 +1258,12 @@ static enum drm_mode_status dpu_crtc_mode_valid(struct drm_crtc *crtc,
> >>>>    {
> >>>>       struct dpu_kms *dpu_kms = _dpu_crtc_get_kms(crtc);
> >>>>
> >>>> +    /* if there is no 3d_mux block we cannot merge LMs so we cannot
> >>>> +     * split the large layer into 2 LMs, filter out such modes
> >>>> +     */
> >>>> +    if (!dpu_kms->catalog->caps->has_3d_merge
> >>>> +        && mode->hdisplay > dpu_kms->catalog->caps->max_mixer_width)
> >>>> +            return MODE_BAD;
> >>>
> >>> This can be more specific, like MODE_BAD_HVALUE.
> >>>
> >>
> >> Yes for sure, will fix this up.
> >>
> >>>>       /*
> >>>>        * max crtc width is equal to the max mixer width * 2 and max height is 4K
> >>>>        */
> >>>>
> >>>> ---
> >>>> base-commit: af2ea8ab7a546b430726183458da0a173d331272
> >>>> change-id: 20241206-no_3dmux-521a55ea0669
> >>>>
> >>>> Best regards,
> >>>> --
> >>>> Abhinav Kumar <quic_abhinavk@quicinc.com>
> >>>>
> >>>
> >
> >
> >



-- 
With best wishes
Dmitry

