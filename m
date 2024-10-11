Return-Path: <linux-kernel+bounces-360622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB9D999D5B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EA23287225
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6D2BA2D;
	Fri, 11 Oct 2024 07:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j2g7gj2u"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24EC635
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728630185; cv=none; b=FFXDUhNjdstNBzT4r8EgpCbT72UjqutLVh4LJOT2iX6sZEtQVN1UcJ3vEEIGtKNYuHNpfhf3fMiPizWi3glpMtHvozDXh6nFWm6TxhlNTvJo22E42VjWFIED9l2j0kQSDDUJv9zO8vTjkmTmRN9T/MeycfsKitDOMJFdvj3CWrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728630185; c=relaxed/simple;
	bh=o4MJNbvGM+bJwqv08q8gLQ2VClYFU3eXABrw4caFEMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ABwx96zOrQ3MjFzUJZaCCXELKk9sWbisLKdtiOQHJP8XU+G0g+RPhWr+bpE+uUJrvAl781dqKE6VleO0gDSG1WlI/L7+avCHk0hrfDLbowk0HTP+Em/J2SX3Rv8F5b7bMzy1vIRx1hr0YQOdxSy1XGIS+CH15iuWEGpomg9aJ5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j2g7gj2u; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6db836c6bd7so16646197b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 00:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728630183; x=1729234983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/WrAkYmWTzQpnkkGqkA3T9eZ4D5Jk8JiEoDs0ZQrAM=;
        b=j2g7gj2uSZhA9vlxgsNLQ/4yqN/O0m0FG6y8PhFCYTkF4xz8VQTUDT1pdvrqZtnWG7
         XRmDOS59wLqRBIkOEbD27Um9cNUzFrXuLTeMRmFED8pLF4oB7g2vVN+lYvXz8y4pmtax
         JaIxHCUtxWyfXDx6oNkKZx3ibdlfHrossjvPD2kgKrzLP/whMqrfZ48OOKpSvJx95RdU
         OwQYYXOLv/Jut5CEOka2u3lFZV2/c0XWxDxZun7+IUB10rnkTqoXZ0lyjHJS8LvUUgjO
         2ejjYLuATYBc+ds4wGrWraJw2tESczln1TCjsYOp6JffNwtHMp97EybhDMNedJBKZ41Q
         yiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728630183; x=1729234983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/WrAkYmWTzQpnkkGqkA3T9eZ4D5Jk8JiEoDs0ZQrAM=;
        b=Htcytq37aeKtOEEhTNLXW4AsoJ9hRrwzBZkRNn45/gkDiGLfrPF4pUXwyB6+v+/wEd
         mB+FoMyf0PiOXVrvewCA8i3AjRUJ2x0FATwACMrJnrrMPEYe8QaHOQ4jSSbK0BsjrY/9
         TNaXBFJJDxmNr14PQvycdevqHOxMHKDt8dih0OvAnwRghOtzxUGIRxNrbOI8MyBkwOb0
         MSvzDFyKiABy0iwjcUFUEHJPgdNOvn+e9xn+DjVK1W4AKdDg6JdNwkzxUO6XyxRwte5x
         xAaP5WiPvgtbe0rIB5pv6ENOsrT55FWHPy14z42uhY8MA4UNIx/gOi4svyz0D5G9RLYp
         G6Aw==
X-Forwarded-Encrypted: i=1; AJvYcCU36YUkFyqozMXdgbzXUoTEVRofuU+dd+8h80iFMjiw2R99KITEG9+yAhWXH9mErR//YxYuIDJ1hMAyu7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu1ZM7YLnMomj7BD5v33L6j7ByiO5+Gg3rB7aMvHdh2k5XyhnP
	PQXN+6X+X0ieOME9HD7ejeU/aKHwgyoed/t1e6eMGmqsF0e+MZhVUlhm3rM2T6EFq8DHG35NAad
	nPQjIWUSoUSfDoFuAvBFxICA0vkqpq4hdiKd4cA==
X-Google-Smtp-Source: AGHT+IExrPlFUulHFd/PrfCfhS/4BHjHsolgjvVdCJaeB+YAMnpZ8ogCYZHPoFPVad1Xx04WRVGP4lRAtqTIlIKyqzc=
X-Received: by 2002:a05:690c:4e09:b0:6dd:bbb4:bcc7 with SMTP id
 00721157ae682-6e347c4de20mr8741367b3.44.1728630182736; Fri, 11 Oct 2024
 00:03:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-0-76d4f5d413bf@linaro.org>
 <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-9-76d4f5d413bf@linaro.org>
 <zig5zuf6hjcrkwmsdiahtzz3t3mxrmwxj65l43xij3zhfcyidn@fuisasnavvo3> <CABymUCP7bVBSWXCNp33x_B8KaZSFU-Dx+bU5ctkgDGXrzURrXQ@mail.gmail.com>
In-Reply-To: <CABymUCP7bVBSWXCNp33x_B8KaZSFU-Dx+bU5ctkgDGXrzURrXQ@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 11 Oct 2024 10:02:52 +0300
Message-ID: <CAA8EJpovnEq_ciO0YmiREhwvxv6yGKnRMPx5=6G7R+Ob6Hy_hA@mail.gmail.com>
Subject: Re: [PATCH v2 09/14] drm/msm/dpu: blend pipes per mixer pairs config
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Oct 2024 at 09:40, Jun Nie <jun.nie@linaro.org> wrote:
>
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> =E4=BA=8E2024=E5=B9=B410=
=E6=9C=8810=E6=97=A5=E5=91=A8=E5=9B=9B 21:15=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Wed, Oct 09, 2024 at 04:50:22PM GMT, Jun Nie wrote:
> > > Blend pipes by set of mixer pair config. The first 2 pipes are for le=
ft
> > > half screen with the first set of mixer pair config. And the later 2 =
pipes
> > > are for right in quad pipe case.
> > >
> > > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > > ---
> > >  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    | 38 ++++++++++++++++++-=
----------
> > >  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h |  1 +
> > >  2 files changed, 25 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/d=
rm/msm/disp/dpu1/dpu_crtc.c
> > > index 43d9817cd858f..66f745399a602 100644
> > > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> > > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> > > @@ -442,7 +442,7 @@ static void _dpu_crtc_blend_setup_mixer(struct dr=
m_crtc *crtc,
> > >       const struct msm_format *format;
> > >       struct dpu_hw_ctl *ctl =3D mixer->lm_ctl;
> > >
> > > -     uint32_t lm_idx, i;
> > > +     uint32_t lm_idx, lm_pair, i, pipe_idx;
> > >       bool bg_alpha_enable =3D false;
> > >       DECLARE_BITMAP(fetch_active, SSPP_MAX);
> > >
> > > @@ -463,15 +463,20 @@ static void _dpu_crtc_blend_setup_mixer(struct =
drm_crtc *crtc,
> > >               if (pstate->stage =3D=3D DPU_STAGE_BASE && format->alph=
a_enable)
> > >                       bg_alpha_enable =3D true;
> > >
> > > -             for (i =3D 0; i < PIPES_PER_LM_PAIR; i++) {
> > > -                     if (!pstate->pipe[i].sspp)
> > > -                             continue;
> > > -                     set_bit(pstate->pipe[i].sspp->idx, fetch_active=
);
> > > -                     _dpu_crtc_blend_setup_pipe(crtc, plane,
> > > -                                                mixer, cstate->num_m=
ixers,
> > > -                                                pstate->stage,
> > > -                                                format, fb ? fb->mod=
ifier : 0,
> > > -                                                &pstate->pipe[i], i,=
 stage_cfg);
> > > +             /* loop pipe per mixer pair */
> > > +             for (lm_pair =3D 0; lm_pair < PIPES_PER_PLANE / 2; lm_p=
air++) {
> > > +                     for (i =3D 0; i < PIPES_PER_LM_PAIR; i++) {
> > > +                             pipe_idx =3D i + lm_pair * PIPES_PER_LM=
_PAIR;
> > > +                             if (!pstate->pipe[pipe_idx].sspp)
> > > +                                     continue;
> > > +                             set_bit(pstate->pipe[pipe_idx].sspp->id=
x, fetch_active);
> > > +                             _dpu_crtc_blend_setup_pipe(crtc, plane,
> > > +                                                        mixer, cstat=
e->num_mixers,
> > > +                                                        pstate->stag=
e,
> > > +                                                        format, fb ?=
 fb->modifier : 0,
> > > +                                                        &pstate->pip=
e[pipe_idx], i,
> > > +                                                        &stage_cfg[l=
m_pair]);
> > > +                     }
> > >               }
> > >
> > >               /* blend config update */
> > > @@ -503,7 +508,7 @@ static void _dpu_crtc_blend_setup(struct drm_crtc=
 *crtc)
> > >       struct dpu_crtc_mixer *mixer =3D cstate->mixers;
> > >       struct dpu_hw_ctl *ctl;
> > >       struct dpu_hw_mixer *lm;
> > > -     struct dpu_hw_stage_cfg stage_cfg;
> > > +     struct dpu_hw_stage_cfg stage_cfg[LM_PAIRS_PER_PLANE];
> >
> > After seeing this code, can we define STAGES_PER_PLANE (and
> > also keep PLANES_PER_STAGE defined to 2)?
> >
> Could you elaborate it? Stages describe how many layers to be blended.
> Plane is a DRM concept that describe a buffer to be display in specific
> display driver. Plane is already mapped to SSPP/multi-rect in DPU driver
>  in blending stage level. So I am confused here.

We have dpu_hw_stage_cfg, you are adding a second instance of it. So
we now have two stages per plane.

>
> -  Jun



--=20
With best wishes
Dmitry

