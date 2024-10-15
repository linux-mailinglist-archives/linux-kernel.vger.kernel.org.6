Return-Path: <linux-kernel+bounces-365772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C0E99E9C7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823CA1C211E1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC8B1F12F8;
	Tue, 15 Oct 2024 12:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r2P5rcKI"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F39B1494DD
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 12:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728995190; cv=none; b=lnJnbvYa9/GBA8ygzYskgkMKmBmXUtFyRdnAGETAFrlZafVH6U4FzzmNrRlpqVv86jp1sMOWmlwO+eO8n7NgyltVXCxwqWxgHGL5WREo50EpwlhP7t4anM995dO+0A1qHPP8KR01ICY2YiD+JB36l12MfEL9fWjPhwzDL//rD+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728995190; c=relaxed/simple;
	bh=ddawXaGf78fQTmQWAQP1TJ1/3cTPR6k88VBZaAncCts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKio/FwUKk9H/898iMh3KV8tCTLfIcKTD0hLthSJcNaz4MRYMn8O7fFGjntIAiF49FSpUQlhstmkyg+kUCr4hFcfvqpAV2xx5mjyFwAHBw3sZVscZa1K3OWrxRW7obpGb27sKVK8bfVQT1E6dyVxlMIywQVZFkm9J2nHW3M391w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r2P5rcKI; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e3881042dcso18268477b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 05:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728995187; x=1729599987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ug4CIhvI9c7efoiVjwADMKle6ML6zboAC9qottYj1qg=;
        b=r2P5rcKI7eKiDASo3xbB4nS298MlQZH7iMGSoEwXdCLxcRdfSNQpYWijvy0Eu2kII0
         8gzonLzsHaG6OwhXGWGvYG5pITq2BGZUpt/imh3VIzi/3OmJ4KIEz03UcAfdsWlLJNTN
         StXPK/L1ZpZFVqlAyy77QMsrexoZx1LrRGaa1O1Qjim96I0mnW+Jq3nt1QvaDA1Uqg4i
         em5sRf2q86mM00VFtqV8WHPRrjgtMxotCrapz94I2f1A2O6NINqiHT+aFJ+XwEop1zKS
         qzgcs57cOWogqVopWcrUGXunOkTvreDwqIEneoZB68vjAXeN7MEU8QU6CWN+nF2Clvzf
         2D3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728995187; x=1729599987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ug4CIhvI9c7efoiVjwADMKle6ML6zboAC9qottYj1qg=;
        b=SflCLv0v8rMIht+t2/dZaqNbJOqOqKSKNu4YXyTikbE5jzQULihhQEAFgyvmzhcmQL
         tYNQYyg8IY+sLr98fEsHpdikebzS1nyaeUVFKktwd8hcC5802hYVJiUXuqlHJxnrrVuk
         peC8JFDlVXnia8SJLsTZGQgVbkrgnhSyaHT6ZhMcXQwPsaW0lYqDptMGt5l77PODvWru
         Wvl5R2z8JZOEwPcasP20BT4ciIrkqFLj1/5WpMEd9zDikMAl6NHMsQgrnoBW6yyFGn47
         59XBOG4v/oFcLVc5ZQx/K6DH3iQOmg/Pztj37NCEcbUSt8FjxdPLKVVsJ9tM6woxS5Js
         pRQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuISHRdRY79ZTpYT0kBqNt9GmUYBNdhO6M6poclDHco9E/WezGq1E3UIu0D6LGsENvTXSIGEp+eIE+GDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxF8nWXeQj4ntyLB00PiRhTad6LwTdRT7UyeGDCe3qz8gLPUSM
	NQJMK2hfLnkE5zK+Pw5nM+UgNzzcP5cv47gingGPFz9h2ydgD3uPZvcL6TYB61NtOufFgUzAjv8
	Jh9wO7HGZM5D93MGYPpXuuzeIAtw2E88+/gAX5w==
X-Google-Smtp-Source: AGHT+IE2uEu5425yw6JXhtzkTXiIwiLHa2uxraMUMytCqyA0U+XKYqEdiFVahWOa8TyQsjCe2gI8WVQTReMheBwdMyM=
X-Received: by 2002:a05:690c:dc7:b0:6dd:d2c5:b2c with SMTP id
 00721157ae682-6e364107ef0mr79205637b3.4.1728995187172; Tue, 15 Oct 2024
 05:26:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-0-76d4f5d413bf@linaro.org>
 <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-9-76d4f5d413bf@linaro.org>
 <zig5zuf6hjcrkwmsdiahtzz3t3mxrmwxj65l43xij3zhfcyidn@fuisasnavvo3>
 <CABymUCP7bVBSWXCNp33x_B8KaZSFU-Dx+bU5ctkgDGXrzURrXQ@mail.gmail.com>
 <CAA8EJpovnEq_ciO0YmiREhwvxv6yGKnRMPx5=6G7R+Ob6Hy_hA@mail.gmail.com>
 <CABymUCPdu5+iz-amwv_O999sLUOmUMczo_v=1aUpJGpHo5f8CA@mail.gmail.com>
 <CAA8EJppMu5o7juhKUN2Y_4CRYKtaWN9G01aPU2ZfksE_tzjqCQ@mail.gmail.com> <CABymUCNbwY5hoaOxydPccFAdbnCQgUMspJLHkNziQyf=NxOj2A@mail.gmail.com>
In-Reply-To: <CABymUCNbwY5hoaOxydPccFAdbnCQgUMspJLHkNziQyf=NxOj2A@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 15 Oct 2024 15:26:22 +0300
Message-ID: <CAA8EJpo9XMo9EGKMzVaDrS7tPZ6CHw6RkqROF4-k94KpFXVjfw@mail.gmail.com>
Subject: Re: [PATCH v2 09/14] drm/msm/dpu: blend pipes per mixer pairs config
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Oct 2024 at 11:27, Jun Nie <jun.nie@linaro.org> wrote:
>
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> =E4=BA=8E2024=E5=B9=B410=
=E6=9C=8811=E6=97=A5=E5=91=A8=E4=BA=94 15:13=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Fri, 11 Oct 2024 at 10:11, Jun Nie <jun.nie@linaro.org> wrote:
> > >
> > > Dmitry Baryshkov <dmitry.baryshkov@linaro.org> =E4=BA=8E2024=E5=B9=B4=
10=E6=9C=8811=E6=97=A5=E5=91=A8=E4=BA=94 15:03=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > On Fri, 11 Oct 2024 at 09:40, Jun Nie <jun.nie@linaro.org> wrote:
> > > > >
> > > > > Dmitry Baryshkov <dmitry.baryshkov@linaro.org> =E4=BA=8E2024=E5=
=B9=B410=E6=9C=8810=E6=97=A5=E5=91=A8=E5=9B=9B 21:15=E5=86=99=E9=81=93=EF=
=BC=9A
> > > > > >
> > > > > > On Wed, Oct 09, 2024 at 04:50:22PM GMT, Jun Nie wrote:
> > > > > > > Blend pipes by set of mixer pair config. The first 2 pipes ar=
e for left
> > > > > > > half screen with the first set of mixer pair config. And the =
later 2 pipes
> > > > > > > are for right in quad pipe case.
> > > > > > >
> > > > > > > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > > > > > > ---
> > > > > > >  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    | 38 +++++++++++=
+++++++-----------
> > > > > > >  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h |  1 +
> > > > > > >  2 files changed, 25 insertions(+), 14 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drive=
rs/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> > > > > > > index 43d9817cd858f..66f745399a602 100644
> > > > > > > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> > > > > > > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> > > > > > > @@ -442,7 +442,7 @@ static void _dpu_crtc_blend_setup_mixer(s=
truct drm_crtc *crtc,
> > > > > > >       const struct msm_format *format;
> > > > > > >       struct dpu_hw_ctl *ctl =3D mixer->lm_ctl;
> > > > > > >
> > > > > > > -     uint32_t lm_idx, i;
> > > > > > > +     uint32_t lm_idx, lm_pair, i, pipe_idx;
> > > > > > >       bool bg_alpha_enable =3D false;
> > > > > > >       DECLARE_BITMAP(fetch_active, SSPP_MAX);
> > > > > > >
> > > > > > > @@ -463,15 +463,20 @@ static void _dpu_crtc_blend_setup_mixer=
(struct drm_crtc *crtc,
> > > > > > >               if (pstate->stage =3D=3D DPU_STAGE_BASE && form=
at->alpha_enable)
> > > > > > >                       bg_alpha_enable =3D true;
> > > > > > >
> > > > > > > -             for (i =3D 0; i < PIPES_PER_LM_PAIR; i++) {
> > > > > > > -                     if (!pstate->pipe[i].sspp)
> > > > > > > -                             continue;
> > > > > > > -                     set_bit(pstate->pipe[i].sspp->idx, fetc=
h_active);
> > > > > > > -                     _dpu_crtc_blend_setup_pipe(crtc, plane,
> > > > > > > -                                                mixer, cstat=
e->num_mixers,
> > > > > > > -                                                pstate->stag=
e,
> > > > > > > -                                                format, fb ?=
 fb->modifier : 0,
> > > > > > > -                                                &pstate->pip=
e[i], i, stage_cfg);
> > > > > > > +             /* loop pipe per mixer pair */
> > > > > > > +             for (lm_pair =3D 0; lm_pair < PIPES_PER_PLANE /=
 2; lm_pair++) {
> > > > > > > +                     for (i =3D 0; i < PIPES_PER_LM_PAIR; i+=
+) {
> > > > > > > +                             pipe_idx =3D i + lm_pair * PIPE=
S_PER_LM_PAIR;
> > > > > > > +                             if (!pstate->pipe[pipe_idx].ssp=
p)
> > > > > > > +                                     continue;
> > > > > > > +                             set_bit(pstate->pipe[pipe_idx].=
sspp->idx, fetch_active);
> > > > > > > +                             _dpu_crtc_blend_setup_pipe(crtc=
, plane,
> > > > > > > +                                                        mixe=
r, cstate->num_mixers,
> > > > > > > +                                                        psta=
te->stage,
> > > > > > > +                                                        form=
at, fb ? fb->modifier : 0,
> > > > > > > +                                                        &pst=
ate->pipe[pipe_idx], i,
> > > > > > > +                                                        &sta=
ge_cfg[lm_pair]);
> > > > > > > +                     }
> > > > > > >               }
> > > > > > >
> > > > > > >               /* blend config update */
> > > > > > > @@ -503,7 +508,7 @@ static void _dpu_crtc_blend_setup(struct =
drm_crtc *crtc)
> > > > > > >       struct dpu_crtc_mixer *mixer =3D cstate->mixers;
> > > > > > >       struct dpu_hw_ctl *ctl;
> > > > > > >       struct dpu_hw_mixer *lm;
> > > > > > > -     struct dpu_hw_stage_cfg stage_cfg;
> > > > > > > +     struct dpu_hw_stage_cfg stage_cfg[LM_PAIRS_PER_PLANE];
> > > > > >
> > > > > > After seeing this code, can we define STAGES_PER_PLANE (and
> > > > > > also keep PLANES_PER_STAGE defined to 2)?
> > > > > >
> > > > > Could you elaborate it? Stages describe how many layers to be ble=
nded.
> > > > > Plane is a DRM concept that describe a buffer to be display in sp=
ecific
> > > > > display driver. Plane is already mapped to SSPP/multi-rect in DPU=
 driver
> > > > >  in blending stage level. So I am confused here.
> > > >
> > > > We have dpu_hw_stage_cfg, you are adding a second instance of it. S=
o
> > > > we now have two stages per plane.
> > >
> > > So you suggest to replace LM_PAIRS_PER_PLANE with STAGES_PER_PLANE,
> > > right? I assume a stage is coupled with a LM pair.
> > >
> > > But for PLANES_PER_STAGE, I am still confused. A stage or a LM pair c=
an
> > > involve many SSPP layers. How it related to planes? Plane is a concep=
ts from
> > > higher level.
> >
> > PIPES_PER_STAGE, excuse me.
>
> Do you mean to keep PIPES_PER_STAGE and do not introduce PIPES_PER_LM_PAI=
R,
> or use both? Looks like they are equal in hardware nature. A stage
> structure serves
> a mixer pair with 2 pipes. We can use PIPES_PER_LM_PAIR and add comment t=
o
>  indicate it, thus avoid defining too many macro.

Yes, don't introduce PIPES_PER_LM_PAIR and just add STAGES_PER_PLANE.

>
> >
> > --
> > With best wishes
> > Dmitry



--=20
With best wishes
Dmitry

