Return-Path: <linux-kernel+bounces-315758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5339A96C698
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D21111F27B06
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C795C1E4116;
	Wed,  4 Sep 2024 18:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BKQV+MTg"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E532C1E203E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 18:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725475297; cv=none; b=Ucj0brIYx0Qo4MOFQG+gxcIFg7+fomE2PNBmGvOaIUqNqGggcwm1Rr9DswfBW9tzsmAdLg6PBPpJ0HTKlTVYbrN6Y1CsN3U47kZmbWMU1eivwReIElzC4U4n2lrHOHvQkj0eYVeKNoWuzIqT0pMGXIOjKdQX7OaY63WLAxmzFgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725475297; c=relaxed/simple;
	bh=8qoQNCibop+PWRXlwU+sPRjnFU3RMyP2DbOvaibPqi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqSHl/7ihE8Dlv8iiBMHI8URT9EqvpkO+fKYZDKsjaFCfFz+AhPPuq1WqjV0UM3vwXD9JhPvOYoYnI6BgHAZLimtNRlTnZAaJA0Hs19NwFRawQjFhcTs96N7AmRcVhAihzqojdnDwDneodwpqdHf9TG+JnCnfUp8169TX8lMI+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BKQV+MTg; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6d6891012d5so37369327b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 11:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725475294; x=1726080094; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1UsoRD5I9/OcwpVT0l8HcbEMWglcM4WiU2VwW1FbqqA=;
        b=BKQV+MTgRcfDEFAiBkX1r56BQWHYSr4YXjjdAFQ50RhdUPtgh1Ne3PYfwtjw9hHnHj
         VmzsCA9ua5Nt/qBy3vOE5oBVQ3fvCr11aTAZy9olzKmmwe4OM/XyLf4Ji8deyFe0s7V9
         mwaRWJHxfGOMWSs8ec8TikiBOT9FwG+s1LLH/bZVXd1T+u0UvyEvPetJCArPihl9F+Jq
         SRSSXLSkRDVSi37LR1G5jxh8WCESK+dTw7mHJiR9k1/rRAgy8CXc8DmqbI+kgIEjp65R
         US/BIFDyjJ5QEmbzCYYpaeM2aQFX9drCf+XteSpYbOVr/TiADZOYsnoWup8aeuTpzvZ+
         VSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725475294; x=1726080094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1UsoRD5I9/OcwpVT0l8HcbEMWglcM4WiU2VwW1FbqqA=;
        b=l7Ta3AigK/UigoufpHkzpBDBpoacjP6SCZT+7WlcJTq1lhdC/C7RzjMPaDu6O7CANF
         i5xN+lmkMc2biZ1VqTlcmCUnmr8YIDpYeyOrv26Q9erC3puZceDzUF97c+9+Rjyq16TY
         XbZkho5a153RoipsoesGhqsarV08eVCw+HFisCUzZeStzZkp7BPqWKNN/kRbeczcdF9W
         HaPV6+u/tY7Z0YI1r1TWTL0K4QdeVEZp51HPirJksl1wMVjo7JxAR76UKmMdODi7XDgx
         agItw+N0TvaChOijZCkpXM8geo1RUbqVTz7NYVN5zzGxEDIVPTvZ0aajYYwRr4ostCz7
         XfNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmZWHylajPJm2e6yW8KT2dOD42eAtWtmvSdToHoE4SVuu96C7JGOAfTkFzYHg0/7Y7/m59AoSeXz4vUQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygbq3Ww0hNFnKh5QzFhbGAFuW5q5FXb3NIImIO9ZCOFcwC50gm
	Xi61DOn4pnRv5oZzFCPyB9dt6AXA9UX0GVcB6fWiWLFdo5atUZn/MsqGSdCkgHFXG02w1MCBWv0
	hcmufthc6Wk+FElvNOjq6V/9/lZHzO0PAwE6qUg==
X-Google-Smtp-Source: AGHT+IFuskZq0UGQgmP4DjibP7i7FiVBXXGXy1UOcoBhtUO9qeXXooabJvPQYAhjWsZh98zkVqcHlTvpZ2+ncq2R+jo=
X-Received: by 2002:a05:690c:f0a:b0:6ae:1e27:c993 with SMTP id
 00721157ae682-6d652cc6539mr149253317b3.7.1725475293727; Wed, 04 Sep 2024
 11:41:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829-concurrent-wb-v1-0-502b16ae2ebb@quicinc.com>
 <20240829-concurrent-wb-v1-7-502b16ae2ebb@quicinc.com> <uqtlpynjdszqyyikj64uxwuqnk3lmzma7kd2vwxipnj4fg2eje@7toj5kww7vk7>
 <9f95704d-0699-4b11-b8cb-40f1a57eeebd@quicinc.com>
In-Reply-To: <9f95704d-0699-4b11-b8cb-40f1a57eeebd@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 4 Sep 2024 21:41:23 +0300
Message-ID: <CAA8EJpqM0QBxLFCx22UuVmYAE258im_Up2-3fu6qez1GrOhOQg@mail.gmail.com>
Subject: Re: [PATCH 07/21] drm/msm/dpu: Check CRTC encoders are valid clones
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, quic_abhinavk@quicinc.com, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, quic_ebharadw@quicinc.com, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Rob Clark <robdclark@chromium.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Sept 2024 at 01:18, Jessica Zhang <quic_jesszhan@quicinc.com> wrote:
>
>
>
> On 8/30/2024 10:00 AM, Dmitry Baryshkov wrote:
> > On Thu, Aug 29, 2024 at 01:48:28PM GMT, Jessica Zhang wrote:
> >> Check that each encoder in the CRTC state's encoder_mask is marked as a
> >> possible clone for all other encoders in the encoder_mask and that only
> >> one CRTC is in clone mode at a time
> >>
> >> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> >> ---
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 36 +++++++++++++++++++++++++++++++-
> >>   1 file changed, 35 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> >> index 5ec1b5a38922..bebae365c036 100644
> >> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> >> @@ -1,6 +1,6 @@
> >>   // SPDX-License-Identifier: GPL-2.0-only
> >>   /*
> >> - * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> >> + * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
> >>    * Copyright (c) 2014-2021 The Linux Foundation. All rights reserved.
> >>    * Copyright (C) 2013 Red Hat
> >>    * Author: Rob Clark <robdclark@gmail.com>
> >> @@ -1204,6 +1204,36 @@ static struct msm_display_topology dpu_crtc_get_topology(
> >>      return topology;
> >>   }
> >>
> >> +static bool dpu_crtc_has_valid_clones(struct drm_crtc *crtc,
> >> +            struct drm_crtc_state *crtc_state)
> >> +{
> >> +    struct drm_encoder *drm_enc;
> >> +    struct drm_crtc *temp_crtc;
> >> +    int num_cwb_sessions = 0;
> >> +
> >> +    drm_for_each_crtc(temp_crtc, crtc->dev)
> >> +            if (drm_crtc_in_clone_mode(temp_crtc->state))
> >
> > No, get the state from drm_atomic_state. temp_crtc->state might be
> > irrelevant.
>
> Hi Dmitry,
>
> Ack.
>
> >
> >> +                    num_cwb_sessions++;
> >
> > Even simpler:
> > if (temp_crtc != crtc && drm_crtc_in_clone_mode(...))
> >       return false;
>
> Ack.
>
> >
> >> +
> >> +    /*
> >> +     * Only support a single concurrent writeback session running
> >> +     * at a time
> >
> > If it is not a hardware limitation, please add:
> > FIXME: support more than one session
>
> This is a hardware limitation.
>
> >
> >> +     */
> >> +    if (num_cwb_sessions > 1)
> >> +            return false;
> >> +
> >> +    drm_for_each_encoder_mask(drm_enc, crtc->dev, crtc_state->encoder_mask) {
> >> +            if ((crtc_state->encoder_mask & drm_enc->possible_clones) !=
> >> +                            crtc_state->encoder_mask) {
> >
> > Align to opening bracket, please. Granted that other drivers don't
> > perform this check, is it really necessary? Doesn't
> > validate_encoder_possible_clones() ensure the same, but during the
> > encoder registration?
>
> The difference here is that validate_encoder_possible_clones() is only
> called when the drm device is initially registered.
>
> The check here is to make sure that the encoders userspace is proposing
> to be cloned are actually possible clones of each other. This might not
> be necessary for drivers where all encoders are all possible clones of
> each other. But for MSM (and CWB), real-time display encoders can only
> be clones of writeback (and vice versa).

I had the feeling that encoder_mask should already take care of that,
but it seems I was wrong.
Please extract this piece as a generic helper. I think it should be
called from the generic atomic_check() codepath.




--
With best wishes
Dmitry

