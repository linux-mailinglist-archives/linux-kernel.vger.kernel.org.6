Return-Path: <linux-kernel+bounces-526187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55083A3FB56
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EA7D165C95
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED411DEFDD;
	Fri, 21 Feb 2025 16:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ynNAWDSx"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A813E8633A
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740155105; cv=none; b=DizX0ohfNKKiEyPFrmYpZqx3WtMsWIMCRwZ4J74vJOVgDMEFenMXna6VGx5tFuS6u3fVcs/E2lhjtbGKhH+85PHu25RH02XyqZqVATMpCT/fBShvQZviAbnFLY6MInld5kvFhj9xRgK9di60oEYJmv22nHjQygHWgDAuWDUQ8N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740155105; c=relaxed/simple;
	bh=6DOyCeEIuabVadIgO+ngHJ98tZfMs3laHTMToh+IRPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fChJAXuul651HlFcc/bvDPO4clbjxtKO8FYD6JLORJEji7cpMI47R1pi0ocn7NipYCvZ/VwraH38ILRKv8UkLLTMWtrnrbjwpF1n4eNaqS8SHxRjQIfTOcaEPzQZmyd4fEqjRG/2swVZmOuudN0kGaHHYHvTMaEFx+UpY8urD1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ynNAWDSx; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6fb9388f9f8so23742467b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 08:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740155102; x=1740759902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dw2LSPn4p4oHMVWGGbX7p83lj89Xs+Zx7joVuGBhQE=;
        b=ynNAWDSxn2pbrQlplZMCvsNFYhvtatFDSXPo/aR6lKY0M9d+JokxCMQyeZsZaiSw77
         +h9xCmNozXS4+xkH1KNoPbesJosazQr0bcVbge4SyDJcib3gZDyStz/A1B0T3F0qh98f
         8WAu+qopu5dg4Loh5wti7NFuXGTpSM2tVVrsWN/8wSnI3cO3wa/vQ1Jg1EJD8Ju8Cr9m
         gws2FbVofZqoWLjJUv9oWv3Eg2SxXvlVMYmXqCN9/LEXT1nT50EHtr2nSpzDvOA+O0CL
         6OgdgyZvNHkrKZQnJCSnZ0RfYwh4E5Hx22RjGL+fDdihH4Sk+JYR+769U76FcEswbWf0
         EnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740155102; x=1740759902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7dw2LSPn4p4oHMVWGGbX7p83lj89Xs+Zx7joVuGBhQE=;
        b=rwhLWXuWjBn6qAeqdj5icsLmK18X7wrFcMPlTExRMr3POAcVe6cVdnQUbfLp48GwqS
         nbA5yw3vWUfKbOOG1aiumuDz08gB+ERvtZHlEDszKnQpLkbdSAoJwhr2RqDk3UtIcF9z
         Jn+VXWTwXbVl09xcRh3OXxkBt8EjJajof9dtMhwS3Otg9zCo6VMarcLfYd6t/Mq8SLmU
         XH9wgSpuSMOVjBrGe1EekOeDkmlF4rxq7wLercERqW/B6UqoeR3LOH9FM+XBEIeydCb6
         sq94DA5Du72rXSIEGO+8qiqRlqV9r3ojRE37W+IkRiOswITC/jFkx3CvanxwgIryefIT
         RTPw==
X-Forwarded-Encrypted: i=1; AJvYcCUCUF1ZwZgq+32lm2cwq/XjsI6uQKgN4kJuURr7JxEO+U7AmtSKn7TJ89dxtczusUPUw54uwTsYmT8jOWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKouegZ9qCaq1X2ddF7z4M2Rax8S8V+avnA4w6TNLgNuExMIus
	ePTfftebinuY9B7oDE9TzHolNOad7j5NtPm7fwmpnHo1JL327roSUPsf2L7rNNcKaogkNFLo65V
	89lSq/cAzZyHZT3WRLxtwdWWUdoydcL8oSXTGXw==
X-Gm-Gg: ASbGncsXuUiXwOh+3PWhhgOEiCqZyEDgfHqFZSdCSu9/Cbjhfkpy8aEd5cOGz7rOl2e
	PxpNohdPbsnnfflqCVHRoYdhmFx1PuNdS3PknbLnIv/PAxdL+MTRiDSy8G5Fieasnq9qp97KG7W
	Be72t9yLdcYU+uwnOMvB2qCg==
X-Google-Smtp-Source: AGHT+IHSP4qUUydGpYdXtz2gK85IvsMIHQC8OSLidB2Ckf6s9uE7p/Zt+DVtkEXwyAE91tbj7srKBQjREnpYB2HOfOI=
X-Received: by 2002:a05:690c:46c7:b0:6fb:1c5a:80ea with SMTP id
 00721157ae682-6fbcc85fbd6mr36065247b3.32.1740155102557; Fri, 21 Feb 2025
 08:25:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-0-c11402574367@linaro.org>
 <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-12-c11402574367@linaro.org>
 <qrwo5jtdj64vu27jn3v2wwyuxu25bjqrybj5jjfc5ifiotgzit@6vx2km46j7b3>
 <CABymUCPEYJTK=gBHcL291qn2zbotC7_8jA4z18sbSZSjRafSsg@mail.gmail.com>
 <ee7xdxyxjs46zfbotsa6hdmwpsvrkaere2hend4iavcvk6duqn@ogvght5qcx7b>
 <CABymUCNnt0Jiks+Fv8Os=V+zxzPAKMyH-wUpgDNMibWA_KNAxg@mail.gmail.com>
 <djq577v6e7cnvybegddxfzqgg5eat4ormqyopa4b5j7wa6spfk@jwuy4cash6ch> <CABymUCOHTecLL7zvsXA1uw=3hr4TAL0PZN6AEwFVGRX5G0_j9g@mail.gmail.com>
In-Reply-To: <CABymUCOHTecLL7zvsXA1uw=3hr4TAL0PZN6AEwFVGRX5G0_j9g@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 21 Feb 2025 18:24:51 +0200
X-Gm-Features: AWEUYZk6hXewd_nXlg1xB3QA0qyGnOQaVvRf84wUzT4pvI9PIs5mozaQq_9coHg
Message-ID: <CAA8EJpppBjxenqXX3baEV2mmxBHEhT7wSanwY5Dq17Lcsc=wLA@mail.gmail.com>
Subject: Re: [PATCH v6 12/15] drm/msm/dpu: blend pipes per mixer pairs config
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Feb 2025 at 18:12, Jun Nie <jun.nie@linaro.org> wrote:
>
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> =E4=BA=8E2025=E5=B9=B42=E6=
=9C=8821=E6=97=A5=E5=91=A8=E4=BA=94 22:21=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Fri, Feb 21, 2025 at 04:07:45PM +0800, Jun Nie wrote:
> > > Dmitry Baryshkov <dmitry.baryshkov@linaro.org> =E4=BA=8E2025=E5=B9=B4=
2=E6=9C=8821=E6=97=A5=E5=91=A8=E4=BA=94 00:17=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > On Thu, Feb 20, 2025 at 11:48:45PM +0800, Jun Nie wrote:
> > > > > Dmitry Baryshkov <dmitry.baryshkov@linaro.org> =E4=BA=8E2025=E5=
=B9=B42=E6=9C=8818=E6=97=A5=E5=91=A8=E4=BA=8C 03:57=E5=86=99=E9=81=93=EF=BC=
=9A
> > > > > >
> > > > > > On Mon, Feb 17, 2025 at 10:16:01PM +0800, Jun Nie wrote:
> > > > > > > Currently, only 2 pipes are used at most for a plane. A stage=
 structure
> > > > > > > describes the configuration for a mixer pair. So only one sta=
ge is needed
> > > > > > > for current usage cases. The quad-pipe case will be added in =
future and 2
> > > > > > > stages are used in the case. So extend the stage to an array =
with array size
> > > > > > > STAGES_PER_PLANE and blend pipes per mixer pair with configur=
ation in the
> > > > > > > stage structure.
> > > > > > >
> > > > > > > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > > > > > > ---
> > > > > > >  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    | 45 +++++++++++=
++++++++----------
> > > > > > >  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h |  1 +
> > > > > > >  2 files changed, 30 insertions(+), 16 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drive=
rs/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> > > > > > > index 81474823e6799132db71c9712046d359e3535d90..50acaf25a3ffc=
c94354faaa816fe74566784844c 100644
> > > > > > > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> > > > > > > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> > > > > > > @@ -401,7 +401,7 @@ static void _dpu_crtc_blend_setup_pipe(st=
ruct drm_crtc *crtc,
> > > > > > >                                      struct dpu_hw_stage_cfg =
*stage_cfg
> > > > > > >                                     )
> > > > > > >  {
> > > > > > > -     uint32_t lm_idx;
> > > > > > > +     uint32_t lm_idx, lm_in_pair;
> > > > > > >       enum dpu_sspp sspp_idx;
> > > > > > >       struct drm_plane_state *state;
> > > > > > >
> > > > > > > @@ -426,7 +426,8 @@ static void _dpu_crtc_blend_setup_pipe(st=
ruct drm_crtc *crtc,
> > > > > > >       stage_cfg->multirect_index[stage][stage_idx] =3D pipe->=
multirect_index;
> > > > > > >
> > > > > > >       /* blend config update */
> > > > > > > -     for (lm_idx =3D 0; lm_idx < num_mixers; lm_idx++)
> > > > > > > +     lm_in_pair =3D num_mixers > 1 ? 2 : 1;
> > > > > > > +     for (lm_idx =3D 0; lm_idx < lm_in_pair; lm_idx++)
> > > > > > >               mixer[lm_idx].lm_ctl->ops.update_pending_flush_=
sspp(mixer[lm_idx].lm_ctl, sspp_idx);
> > > > > >
> > > > > > I almost missed this. Why is this necessary?
> > > > >
> > > > > It is protective code. In case there is only 1 LM, we should not
> > > > > iterate 2 LM in a stage.
> > > >
> > > > That's not what the code does.
> > >
> > > I do not get your iea. _dpu_crtc_blend_setup_pipe() is called with
> > > num_mixers set as:
> > > cstate->num_mixers - (stage * PIPES_PER_STAGE).
> > > So lm_in_pair will get the LM number in this stage to iterate.
> >
> > You have written that it is incorrect to iterate over two LMs if we hav=
e
> > one. The code does a different thing: 'don't iterate over more than two
> > LMs'. It would be more idiomatic to write it as:
> >
> > lm_in_pair =3D min(num_mixers, 2);
> >
> > And then it is obvious that it is not 'lm_in_pair' (note, singular), bu=
t
> > something like 'lms_in_stage'. I'd really ask you to pull this up to a
> > caller function and pass a correct num_mixers instead.
>
> Thanks for the suggestion! min() is much more readable than mine version.=
 And
> stage is more proper than LM pair as a stage may only contain one LM. Wil=
l
> replace the term.
>
> For the pulling up to a caller, you mean the min(num_mixers, 2) here, rig=
ht?

Yes, to _dpu_crtc_blend_setup_mixer(). And of course. use a proper define f=
or 2.

>
> >
> > > >
> > > > > >
> > > > > > >  }
> > > > > > >
> > > > > >
> > > > > > [...]
> > > > > >
> > > > > > > @@ -535,8 +543,13 @@ static void _dpu_crtc_blend_setup(struct=
 drm_crtc *crtc)
> > > > > > >                       mixer[i].mixer_op_mode,
> > > > > > >                       ctl->idx - CTL_0);
> > > > > > >
> > > > > > > +             /*
> > > > > > > +              * call dpu_hw_ctl_setup_blendstage() to blend =
layers per stage cfg.
> > > > > > > +              * There are 4 mixers at most. The first 2 are =
for the left half, and
> > > > > > > +              * the later 2 are for the right half.
> > > > > > > +              */
> > > > > >
> > > > > > The comment is invalid until you introduce quad pipe, currently=
 there
> > > > > > are 2 mixers at most. However you can just say something like '=
stage
> > > > > > data is shared between PIPES_PER_STAGE pipes'.
> > > > >
> > > > > Accepted.
> > > > > >
> > > > > > >               ctl->ops.setup_blendstage(ctl, mixer[i].hw_lm->=
idx,
> > > > > > > -                     &stage_cfg);
> > > > > > > +                     &stage_cfg[i / PIPES_PER_STAGE]);
> > > > > > >       }
> > > > > > >  }
> > > > > > >
> > > > > > > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/dr=
ivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> > > > > > > index 5f010d36672cc6440c69779908b315aab285eaf0..64e220987be56=
82f26d02074505c5474a547a814 100644
> > > > > > > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> > > > > > > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> > > > > > > @@ -34,6 +34,7 @@
> > > > > > >  #define DPU_MAX_PLANES                       4
> > > > > > >  #endif
> > > > > > >
> > > > > > > +#define STAGES_PER_PLANE             2
> > > >
> > > > BTW, This should be 1 for now.
> > >
> > > Yeah, it can be added in the last patch.
> > > >
> > > > > > >  #define PIPES_PER_PLANE                      2
> > > > > > >  #define PIPES_PER_STAGE                      2
> > > > > > >  #ifndef DPU_MAX_DE_CURVES
> > > > > > >
> > > > > > > --
> > > > > > > 2.34.1
> > > > > > >
> > > > > >
> > > > > > --
> > > > > > With best wishes
> > > > > > Dmitry
> > > >
> > > > --
> > > > With best wishes
> > > > Dmitry
> >
> > --
> > With best wishes
> > Dmitry



--=20
With best wishes
Dmitry

