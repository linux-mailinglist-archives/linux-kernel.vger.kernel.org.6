Return-Path: <linux-kernel+bounces-312395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48767969604
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3A931F21186
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1035A200121;
	Tue,  3 Sep 2024 07:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fitC8vh9"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EA71DAC49
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 07:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725349731; cv=none; b=PP/hJuDQTalFsbBD0eIRkCk2S6U4isQTir82QazYR2eXDAMra7zSzwr+UzAVSqYU0MGY83wnXvO3uB5HH9OOtGfOFV+N321EOzO0Gd+9d56SL5tuSJ/mz2uYsi7E5VdE0bdJAH6ZSIN7CNJyyZDbVQN9PmHmmZLMjFhS+01VxVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725349731; c=relaxed/simple;
	bh=UjlN0vxYhd68jCLZq9NBd0owmRvKtW88E0kMNhBq0n4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ItAvR8+/2PI33gqpE9IHPPucqtIIJxjNdrBm5Nx0N64UCV3a/QCYKXpVtaKdxHvx7aYbkCDckKtDh/GeN5L1/yVI1mTO1/2Hwp5gXFIDxWFlXiHcEsKlPopUWw8TiKtSdmit5FUoOoBclDAVorI8c9Neiq8Z24FkiZSHx+/1B9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fitC8vh9; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53438aa64a4so6009045e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 00:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725349728; x=1725954528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Sv5UiL21b/b3TY87F39nvEWfHp31hMXSNIqU/zuTOg=;
        b=fitC8vh94laL8j2RuRHc+ZJZirHYplLMUXhmp1i00iWT01c+TC/ONPZyVICI8jPf83
         re8JRi0swxzmcAQXBfeR0+xs7C1GmfuZOgOCFgtU/sdMz45klYuWzLifSdnu4XbuoE31
         vPS5kQeLhFM9Be2FfbttUxooMmvMuqEb8pHf0cKB5BMsotzaPl2WFggg7hbU/cijubbu
         HaeyrIwgK4goatoYWgal2ugiRd7YsbUYgcnyPtrAXUDYfiz6tBzU6mILIXhFtAa2CRP1
         4xMhLUbkRjt95yHtKDuwldUdPX5nc7x5SIg0ZkB5Qj8iIjCbHTlEUH0dfz+BtCF3nULZ
         YYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725349728; x=1725954528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Sv5UiL21b/b3TY87F39nvEWfHp31hMXSNIqU/zuTOg=;
        b=sKS9MMOL7HHGjLf85LByK1I8tgCL7p1Yqzo8rM2dluSCftLqdDLAFfJE5bXqDqexnY
         VkNHV64tHoCzIEOPwwsQ8ubkcpaE68wUVxp/FFOEW9Q+fKrVM7eUlqMhtYcm35gjOWO/
         yXVG+xvwFYtX6ygqV5ajYm6mHUmxwc/4rqC7vBLKU/gutVj5IQf0ZMCcS46NZr8HL7Hw
         T5IBBOckcVZuHzKa5wGpmTKehUWbO07qjPWTCqAnLT9nfwBlTRz6X45ixmvxnSRgUGp5
         wY4ZEOp9w/P7n12vXTKVYsDMUT9dg+udd5XYf18oMfocwLsuDFdhuTEFSrf4PBgGBJWc
         52qg==
X-Forwarded-Encrypted: i=1; AJvYcCU8HoJCY1WdRK5KcHyutGSziSkuPfvA0jgdZe0ebLNilVQErNScQmTIy1MDk/KWzgCdGT08bf6NWxK8hkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqmMXkllqiie4AJru4hgDDcy8ygSbTSZcrL9woBZogrdOxhp+k
	w8pMz9Rq0orWcNJzNLHhnTb3vLBGI8sp/Eput/+7K41dBFMCXchrxnucnMNJsnJzq94E3W6w8P1
	+Xq+6WEe4eGP1N12mtOprqzwleSyewImBPsoSnw==
X-Google-Smtp-Source: AGHT+IFb2cMkBKbVeiCZ5IYK8mCct3VX/awajZsJGd8T3xn5cm3YhWirCQaajtw1ZZucaT8Vf7utkyeAzyWgGqbZRv8=
X-Received: by 2002:a05:6512:1282:b0:533:d3e:16fe with SMTP id
 2adb3069b0e04-53546b69245mr7439461e87.38.1725349727618; Tue, 03 Sep 2024
 00:48:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-0-bdb05b4b5a2e@linaro.org>
 <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-7-bdb05b4b5a2e@linaro.org>
 <CAA8EJpqZjO9rfVgVkhyCpg9qfyc13MHtz=RRhZG6ihMsVM+bSA@mail.gmail.com>
In-Reply-To: <CAA8EJpqZjO9rfVgVkhyCpg9qfyc13MHtz=RRhZG6ihMsVM+bSA@mail.gmail.com>
From: Jun Nie <jun.nie@linaro.org>
Date: Tue, 3 Sep 2024 15:48:36 +0800
Message-ID: <CABymUCMCjYfXBOqXcLGZvH6CxU7Z_Qq1kKioZGC8PCORjtJM8Q@mail.gmail.com>
Subject: Re: [PATCH 07/21] drm/msm/dpu: Support dynamic DSC number
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dmitry Baryshkov <dmitry.baryshkov@linaro.org> =E4=BA=8E2024=E5=B9=B48=E6=
=9C=8829=E6=97=A5=E5=91=A8=E5=9B=9B 19:10=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, 29 Aug 2024 at 13:20, Jun Nie <jun.nie@linaro.org> wrote:
> >
> > Do not assume DSC number as 2. Because there are 4 DSC in
> > quad pipe case.
>
> Please expand the commit message. You prefer brevity, but your
> comments lack clarifications.

Is below message OK?

Current DSC number is fixed to 2 for any DSC usage case. While there are
more usage case that involve different number of DSC engine, such 4 in
quad-pipe case with bonded-DSI scenario. So retrieve the real number with
this change.

>
> >
> > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > ---
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/=
drm/msm/disp/dpu1/dpu_encoder.c
> > index 6bdd9c21ff3ed..05b203be2a9bc 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> > @@ -553,9 +553,9 @@ bool dpu_encoder_use_dsc_merge(struct drm_encoder *=
drm_enc)
> >                 if (dpu_enc->phys_encs[i])
> >                         intf_count++;
> >
> > -       /* See dpu_encoder_get_topology, we only support 2:2:1 topology=
 */
> > +       /* DSC and mixer are mapped 1:1, so reuse the mixer number */
>
> Why? DSCmerge is a valid topology even if it is not supported yet.

DSC merge is already supported in 2:2:1 topology without this patch
set. This change
is to get real DSC number in 4:4:2 topology, so that DSC merge can be
enabled for the
case.

>
> >         if (dpu_enc->dsc)
> > -               num_dsc =3D 2;
> > +               num_dsc =3D dpu_crtc_get_lm_num(drm_enc->crtc->state);
> >
> >         return (num_dsc > 0) && (num_dsc > intf_count);
> >  }
> >
> > --
> > 2.34.1
> >
>
>
> --
> With best wishes
> Dmitry

