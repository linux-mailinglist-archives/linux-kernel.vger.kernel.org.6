Return-Path: <linux-kernel+bounces-270340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84698943ED9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 03:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0AC61C2291D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 01:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DD81DBB8F;
	Thu,  1 Aug 2024 00:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mLkpTVMF"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CCA1DBB86
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 00:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472500; cv=none; b=NpoQk4GJJUyPMhPTnwmAWBfM6DyVMXJIPrHcSUmue7JTheoHz128WxpdawLB6+UPh97giTboxVuLDHlU6xF1Opz0UL2bRvqFqR6FX3sz/IWTMEYWLJ3mxsYsPSK+XeJrp/m7Y3PuGWUbgHQc5iGiGk3ivVKzPHerRQTMT7SFVqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472500; c=relaxed/simple;
	bh=WQ/Mc4zHQy5Ga10rKNhs90GEgXR81mwR3QuecHPifm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VhhkxXM4LuGXArJTiVfsyMDiv+TdVFKnWTnK9LMRYog2bBazCIT11BEsBf9689PayEy32zYT6lZstSmvV6R94As6cpefI6B3FqgagwKva3qIqNGRxsp1tv9tCtRaHKASBfYKpuy5Ss1+q3MixJSiVmkZ/AfImmEEfssfeUpCT6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mLkpTVMF; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-654cf0a069eso46640667b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 17:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722472497; x=1723077297; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M/CELQaNvMQTBTPJnHhuNUlt/nKrqYgz+WkyNAnHqFw=;
        b=mLkpTVMFreEWqguLs8oeY689vJF5bwAri0t9OJqeJ/JcjZds0MI7qoqmz+qMuVSPli
         TowAS4EaZeIBdRtmjemem6Mf0nCcmntboPrUewWapifLkyh5cyfZHGv6i1ciUfT5FCLP
         PtNOSEvR1yxvIJHBLR1yn17lN5xS0DAY7v6hbmQBWSUIVyIV0VvAVrNiZ8ZmbPS9hfBS
         bzRUyPP3CMPHWDz2ypc2MW8MBHzGuNIsaNW4CIHBWxr91HaKBq/xvsMGRO8RmH047Ng3
         0UGkuCXo48ma4ETLzHjXJb5afaYQqf2vgKpmn2qdUkEIXtqS9om2lkIbgwTKLjk7NTM8
         aF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722472497; x=1723077297;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M/CELQaNvMQTBTPJnHhuNUlt/nKrqYgz+WkyNAnHqFw=;
        b=V8lM8pb4aZeGhlNlZvCtTQNdklRmThk5gCway4Vo8dgvuIai6FCmnvPTy+rgJI8SfV
         DaYOwv6mt1py5D3SILzs5gZVJPB9TFtFf8LEcQ6NmlWIJsEFpejlNaOKcD2Vf7LmK23A
         GluQJOddXnOlxRc/fEaGPkGyqArr9Dbhc6fl41QMelxClSmBk+sLj6zH/o4pG69WCaAh
         NjmlRsEZZrYj1C7Z9m/7Ku7nGU1Y4kfqW66k+i76HsrvQ/1p7oIYyNJCAsvE2U3LNTae
         mP4YMRSHzPD0T/Ya026RJ9TyGmhWN9pReJYUPhY2K78F07hYVAGlHXp+caAuk6uA8gyk
         pcOA==
X-Forwarded-Encrypted: i=1; AJvYcCXJLFS6ShZOZ2Bel4LYtbpdEHSlybLoTJlAbqdytLDfivWafyTUV/0JlDmMs7R06eLN/X1pqPAC1petIftX8kLFSKQ24e4ytB7Dn25Z
X-Gm-Message-State: AOJu0YxopXX1BkMkizfo4dHoWBuXgoDcNmLh3DVQpwjat+XkJz1WIcvQ
	fkTOyQFK7wy0HhPejlT06HfXOtP9recDS8t8Vq3dzA0SLPRLu1ikmkvN3cPIGaOKtqXd69eNqd+
	ae6Cb602ioH1cDDOcYk5eSkX6lzF2rH5J80l7ow==
X-Google-Smtp-Source: AGHT+IGaBGM1AayDPzuZZA1cyOtTi6oJv13xWErQOdKjC4oVXJkICQP5cLrmmu5xwR7QC6Y4C3u8Iwj/z6IN0YJq5QE=
X-Received: by 2002:a0d:f3c6:0:b0:650:a1cb:b122 with SMTP id
 00721157ae682-6874bc631bcmr9370347b3.27.1722472497251; Wed, 31 Jul 2024
 17:34:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627-dpu-virtual-wide-v5-0-5efb90cbb8be@linaro.org>
 <20240627-dpu-virtual-wide-v5-2-5efb90cbb8be@linaro.org> <b2cceeb8-fe81-4212-9b07-b70cad8d3b9b@quicinc.com>
In-Reply-To: <b2cceeb8-fe81-4212-9b07-b70cad8d3b9b@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 1 Aug 2024 03:34:46 +0300
Message-ID: <CAA8EJpp2pg1FyrE8ftxGduHUnX=nsu=Zg_mwCrkcdqJqMJZjDw@mail.gmail.com>
Subject: Re: [PATCH v5 02/12] drm/msm/dpu: relax YUV requirements
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 31 Jul 2024 at 22:36, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 6/26/2024 2:45 PM, Dmitry Baryshkov wrote:
> > YUV formats require only CSC to be enabled. Even decimated formats
> > should not require scaler. Relax the requirement and don't check for the
> > scaler block while checking if YUV format can be enabled.
> >
> > Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 5 ++---
> >   1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> > index 1c3a2657450c..148bd79bdcef 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> > @@ -743,10 +743,9 @@ static int dpu_plane_atomic_check_pipe(struct dpu_plane *pdpu,
> >       min_src_size = MSM_FORMAT_IS_YUV(fmt) ? 2 : 1;
> >
> >       if (MSM_FORMAT_IS_YUV(fmt) &&
> > -         (!pipe->sspp->cap->sblk->scaler_blk.len ||
> > -          !pipe->sspp->cap->sblk->csc_blk.len)) {
> > +         !pipe->sspp->cap->sblk->csc_blk.len) {
> >               DPU_DEBUG_PLANE(pdpu,
> > -                             "plane doesn't have scaler/csc for yuv\n");
> > +                             "plane doesn't have csc for yuv\n");
> >               return -EINVAL;
> >       }
> >
>
> Change seems fine, but one question, is there a chipset in the catalog
> with a Vig SSPP which has only csc but not scaler? Even qcm2290 has
> neither scaler nor csc
>
> So was this just a code-walkthrough fix or was there any issue hit due
> to this?

Just a code walkthrough.



-- 
With best wishes
Dmitry

