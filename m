Return-Path: <linux-kernel+bounces-390810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 972519B7ED1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56765282C3A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2BE1B140D;
	Thu, 31 Oct 2024 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FbcAeWO5"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41191ADFFE
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389460; cv=none; b=K8hWcUPgf7gl6ZM5KGsJCL/LMPnAjzVic4IwskEpeeDi6x20HT2gn6c/yaKZGMl2aLtMQ6wM4XH60r/a4+yYQEe/fDsMQyD+VZUtaeWgswtLAurk0hIbSQRAWx2gqprnFQhcDF2ue0J0CDZElzNzxQJUNV7UhZoFAikepCo9vbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389460; c=relaxed/simple;
	bh=8KbwkqqmAA2pftuYjQTvNKIu03ZVLX7cGW+thUOVIKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TwiygUH7hYbKtqBkETGCFriHXhl0TTop6/YxUP/7uXmyAenEZI4PlVL9F7SxNiID7koeVq3YG9umGwwfZb4xUMUp/w0hK95HVa6gogH4qB7+HcjG83V4GDsAcD4/aazDGi0g8VsjDMJ4WoJlrHTpGIJnVGtnPVN7FOA9MSG5w7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FbcAeWO5; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e9f8dec3daso8439117b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730389457; x=1730994257; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WkbJktFWhQ17ZPncxvn3FN6iDF+dModwKTnXQceOjrk=;
        b=FbcAeWO50PJDG1JAohPi8peSk4pyfvQqToVmo2h17ZF4r7ZoaSFjR9z64SLTEoNcNy
         W4MscrUeEJX455zlzdykRd9uxZgt+I13PYuHLN00SyDptHLB7UOlLSwu7ZloeDPW/MNH
         EE3xQN9CdlscloXZ6gNo56l0xoP6Va4PxEfP+PH1OIm42kokJhLHWz2BYhWKzZIHOwNo
         3CjzPBx1itqLujJx0t45hOdx+vFadQIsI/CS25xMvj8JGqw43lrZh5/KHXuwgsFwHH1G
         Mvc3SLOjuGaIBaVOxTjn8z/Z8hbC7dtvIw4bmN899H6bV6gzJyJz/UQVCZtdZ/IizjVK
         rHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730389457; x=1730994257;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WkbJktFWhQ17ZPncxvn3FN6iDF+dModwKTnXQceOjrk=;
        b=P9wPFgr36iTx46BggazcCc2Y0J677QKsz8WbjlTVBjrt21X8ctFPn+Gh5k90B1W4zx
         7b2BqsQjcJcsGZw9Bz/bBMnBIrPZX1xECEFLbuKBtuGaFyyXYhvUJ5Hp+agOmNbfZzJY
         +xuQA2Fe17HB8xs8GjhmG/O11ClPvHJ4lBeE5DxCt/FpnK3I7q/vr12vVrGDT/AxaKL6
         IANWvib6N8LXZrGbQ5bIgQqy7GHZ3MG78L6Oc5CtGih1YjqA69FpGqKFLfs78PVT2hsg
         HUb3icsmOEeXBwmBHgmEVyvKEGtF0iNaWbYLwwXyP2C8Y5+9XvrYlxgTRbK9qhOveMII
         N/vw==
X-Forwarded-Encrypted: i=1; AJvYcCW/CD4dUJbJbVAi89QYIBbcoDwgPgafy6WPtL0yA2njUqO77vZYfINlzp8mNwVVYSUR5D2fOn+ZRj7oqws=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmC+U1sPJwzbnPcsKfEVeX3XtEFNCSyNNOFTqO8Xsp36cbbvel
	hvetI1kB+c7Wpit+JNb3Of6HP2mLqvMxq1FQT4lmf5N6w4IzR0Ay2hKu0jpc9kHv3hCUIUslW/W
	PeJeZ02jY3kLy9eZGMjXwMOTg5h8EbFBHHPJLKg==
X-Google-Smtp-Source: AGHT+IGjmqvpPX1+bGFGcSxEoEH+wnbP2rdjGZXV5omtO6akLQEwaojlUw/funiMKKjk1H8UlB7i4QA7KdZjNAhvlgE=
X-Received: by 2002:a05:690c:d81:b0:6e3:430c:b120 with SMTP id
 00721157ae682-6e9d88cecf3mr189401227b3.5.1730389457603; Thu, 31 Oct 2024
 08:44:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025-dpu-virtual-wide-v6-0-0310fd519765@linaro.org>
 <20241025-dpu-virtual-wide-v6-7-0310fd519765@linaro.org> <e0f84f35-6d98-45c3-857c-c273820fab69@quicinc.com>
 <xxxedwb2t6xhfzmhpom6dirs2ur2qvmruimdxgvdkh7gmey5tr@qotm7xvbsg5a>
 <14531af0-29c3-40eb-bf52-8202ba155d0b@quicinc.com> <CAA8EJppCppQ_jJu4o62prW-Yp2E3WBfqdYgdJs-KB8kgghj0fg@mail.gmail.com>
In-Reply-To: <CAA8EJppCppQ_jJu4o62prW-Yp2E3WBfqdYgdJs-KB8kgghj0fg@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 31 Oct 2024 17:17:33 +0200
Message-ID: <CAA8EJpr_8LkP8wnR8n0wSeFHOWdG9osg+XZu_vCDkv5Y6y0gXA@mail.gmail.com>
Subject: Re: [PATCH v6 7/9] drm/msm/dpu: add support for virtual planes
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 31 Oct 2024 at 17:11, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> Hi Abhinav,
>
> On Wed, 30 Oct 2024 at 21:26, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> > On 10/30/2024 3:48 AM, Dmitry Baryshkov wrote:
> > > On Tue, Oct 29, 2024 at 02:30:12PM -0700, Abhinav Kumar wrote:
> > >> On 10/24/2024 5:20 PM, Dmitry Baryshkov wrote:
> > >>> +           if (reqs->yuv && !hw_sspp->cap->sblk->csc_blk.len)
> > >>> +                   continue;
> > >>
> > >> same here
> > >>> +
> > >>> +           if (reqs->rot90 && !(hw_sspp->cap->features & DPU_SSPP_INLINE_ROTATION))
> > >>> +                   continue;
> > >>> +
> > >>> +           global_state->sspp_to_crtc_id[i] = crtc_id;
> > >>> +
> > >>> +           return rm->hw_sspp[i];
> > >>> +   }
> > >>> +
> > >>> +   return NULL;
> > >>> +}
> > >>> +struct dpu_hw_sspp *dpu_rm_reserve_sspp(struct dpu_rm *rm,
> > >>> +                                   struct dpu_global_state *global_state,
> > >>> +                                   struct drm_crtc *crtc,
> > >>> +                                   struct dpu_rm_sspp_requirements *reqs)
> > >>> +{
> > >>> +   struct dpu_hw_sspp *hw_sspp = NULL;
> > >>> +
> > >>> +   if (!reqs->scale && !reqs->yuv)
> > >>> +           hw_sspp = dpu_rm_try_sspp(rm, global_state, crtc, reqs, SSPP_TYPE_DMA);
> > >>> +   if (!hw_sspp && reqs->scale)
> > >>> +           hw_sspp = dpu_rm_try_sspp(rm, global_state, crtc, reqs, SSPP_TYPE_RGB);
> > >>
> > >> I dont recollect whether RGB SSPPs supported scaling, if you have any source
> > >> or link for this, that would help me for sure.
> > >
> > > I have to dig further into the old fbdev driver. It looks like
> > > mdss_mdp_qseed2_setup() is getting called for all plane types on the
> > > corresponding hardware, but then it rejects scaling only for DMA and
> > > CURSOR planes, which means that RGB planes should get the scaler setup.
> > >
> > > For now this is from the SDE driver from 4.4:
> > >
> > >   * @SDE_SSPP_SCALER_RGB,     RGB Scaler, supported by RGB pipes
> > >
> > >> But even otherwise, I dont see any chipset in the catalog setting this SSPP
> > >> type, so do we need to add this case?
> > >
> > > Yes, we do. MSM8996 / MSM8937 / MSM8917 / MSM8953 use RGB planes.
> > >
> >
> > Yes those chipsets do have RGB SSPP. My question was whether they have
> > migrated to dpu and thats why I wanted to know whether we want to
> > include RGB SSPP handling.
> >
> > I do not even see them in msm_mdp5_dpu_migration.
>
> Ugh, it's a bug then, I'll push a fix.

Ok, this is very surprising:

static const char *const msm_mdp5_dpu_migration[] = {
        "qcom,msm8917-mdp5",
        "qcom,msm8937-mdp5",
        "qcom,msm8953-mdp5",
        "qcom,msm8996-mdp5",
        "qcom,sdm630-mdp5",
        "qcom,sdm660-mdp5",
        NULL,
};



-- 
With best wishes
Dmitry

