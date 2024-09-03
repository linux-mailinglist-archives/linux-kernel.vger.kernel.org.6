Return-Path: <linux-kernel+bounces-312399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EAC96960F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F6252810B6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6F1200113;
	Tue,  3 Sep 2024 07:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C7kROc9y"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B762220010C
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 07:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725349808; cv=none; b=USdF3/VPbSO6CroH68zsG237zilKW8QgNuPPTOWVFf2mBrnYO+Df4tOa4MQ+bUZX5f1fhLdwiIbrcB2SR16nDLqIyPKi97vr87GAiNSKuG8MdB5bbRq64p/j3iwpFPtust53lMuT5VTtntEsm+mlIfREUTn7bAILv6hul3r2vEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725349808; c=relaxed/simple;
	bh=HXDHXog/nAm3pwkQB6U5r8QpdRZvdPOQ6cObg+BHu68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UnTW+ItDY1EF6ErmqEdUxXSPplUVd+mHlOC5lOe86Z0tPV7MZZwij1aGC4txKVgqCjobGzGHKhB1eaGKN4Ab9k39ctQ1RtxNAM0OvuUfe0BwAecDaSd7yZhpe6JwG+B0h2RDoTsICB8OJ+JELdy0RGzsZKOF4Z0rOjX9RxoxCNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C7kROc9y; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5343617fdddso8536249e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 00:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725349805; x=1725954605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lqltuZsVvo3q+kL5FQoAhahgvZp8TI3+xOC4Ek386E=;
        b=C7kROc9yIKHHQnS/96E9gXgnWf1TZVTH9bnoV3HJ2Tnc7Cgfcc9iAdZoTAezfoYzTq
         QJ4JS/6NQf2ENxO9a1doiBevAIcvWSoPmFinru+xIkR/UW8Ug486ux6jTmO1Cs9QSShm
         TkC7qRBSa6N9SS9b8/9POuwoJah90PvbJpily3p2s8HuWeIdr0Ec3cQdSoY3zC1AwWZ0
         3f1h4hXsDb/cA9+O9fFS52f3Ha1vtdznYatzmPdEU0ydAuRWPNedLmY6xRMTEPLZ/fsG
         WwdxNLNlQJkv0e29Dq3LalHqG8+BRJIlBUz482aBx+iLR8xLrzdQ4D90vWW3Na4uSd4C
         3wWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725349805; x=1725954605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+lqltuZsVvo3q+kL5FQoAhahgvZp8TI3+xOC4Ek386E=;
        b=fN7hnCqzlNYC/KG2qTyaAbz3If23An7Tyhvta8PvW17NIT9FL/W0rRTorjWEgi+awV
         9tYe6C1IedRt1hs+UztJCTkZicdOgwvbPNYhWkvmK5KoE9R3jBwI//bec0pAzIUTHL+E
         7YElmoG2pqn0OxquLvzpo1pJEjPL2L908KV9eVrnIpgDXIAH8/NzDRnZPtduLaPFRjqT
         XZXdHvZMo9diE/wfaJmakURixR3iGcUtvRhE+SM4/roR0lZ3isxZmaaoKmSDbaRQEQpw
         4Oq3EtBTMYeaFVYzhHX2yu/e34hLPuhl0ZYr6JylnZ/WPT3GDbnvYktbEF8aoGo1jL0I
         0y6g==
X-Forwarded-Encrypted: i=1; AJvYcCX28sLDwRaqOQLhCgZ5HZm6tZIxHK8bgXYS4a5W764C4DHyn4P3VLAHK/f/uAAQKwaYK1XPpVKHarMw2RQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2XvZ2+snYH8A7t0QeIt542MDVhbbr8sQj5Zid7Zcb5UC/DVie
	Bj0WZ7z79PZOhAN1GkhtBO9WVAwBmW3E8xgFh8bHqnXmOHApHPeAEJ4ldjl3MwrX9QBELIAHuK1
	rq7WpV0rSVH9fgCfaxHtFiVAhdYU03fVkK5AdiA==
X-Google-Smtp-Source: AGHT+IEJwTXohM4H9uSVusjPmKwI6JnO7SPg+/suagC/qP96uj/Jk/AgITd3OvcJR2rJohaA8rXhIBIKARoJIvpPzkw=
X-Received: by 2002:a05:6512:3c9e:b0:52c:deb9:904b with SMTP id
 2adb3069b0e04-53546bde550mr9695782e87.38.1725349804799; Tue, 03 Sep 2024
 00:50:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-0-bdb05b4b5a2e@linaro.org>
 <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-10-bdb05b4b5a2e@linaro.org>
 <CAA8EJppFCVQPFa1-o7T08Bs+vzbykDXwVTOq4=B2LuWJb2gYGw@mail.gmail.com>
In-Reply-To: <CAA8EJppFCVQPFa1-o7T08Bs+vzbykDXwVTOq4=B2LuWJb2gYGw@mail.gmail.com>
From: Jun Nie <jun.nie@linaro.org>
Date: Tue, 3 Sep 2024 15:49:53 +0800
Message-ID: <CABymUCPi-DbPW=Aos=m0mrHj2TgxEy=QNEFpbCsb3srr-qe1Eg@mail.gmail.com>
Subject: Re: [PATCH 10/21] drm/msm/dpu: fix lm number counter for quad-pipe
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
=9C=8829=E6=97=A5=E5=91=A8=E5=9B=9B 19:17=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, 29 Aug 2024 at 13:20, Jun Nie <jun.nie@linaro.org> wrote:
> >
> > Add the case to reserve multiple pair mixer for high resolution
>
> I think you already know what is missing here.

Add the case to reserve multiple pair mixer for high resolution. Current
code only support one pair of mixer usage case. To support quad-pipe
usage case, multiple pair mixers are needed.

>
> >
> > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > ---
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 6 +++---
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c      | 8 +++++++-
> >  2 files changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/=
drm/msm/disp/dpu1/dpu_encoder.c
> > index 33cfd94badaba..f57725ad494d2 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> > @@ -54,7 +54,7 @@
> >  #define MAX_PHYS_ENCODERS_PER_VIRTUAL \
> >         (MAX_H_TILES_PER_DISPLAY * NUM_PHYS_ENCODER_TYPES)
> >
> > -#define MAX_CHANNELS_PER_ENC 2
> > +#define MAX_CHANNELS_PER_ENC 4
> >
> >  #define IDLE_SHORT_TIMEOUT     1
> >
> > @@ -2029,8 +2029,8 @@ static void dpu_encoder_helper_reset_mixers(struc=
t dpu_encoder_phys *phys_enc)
> >         struct dpu_hw_mixer_cfg mixer;
> >         int i, num_lm;
> >         struct dpu_global_state *global_state;
> > -       struct dpu_hw_blk *hw_lm[2];
> > -       struct dpu_hw_mixer *hw_mixer[2];
> > +       struct dpu_hw_blk *hw_lm[MAX_CHANNELS_PER_ENC];
> > +       struct dpu_hw_mixer *hw_mixer[MAX_CHANNELS_PER_ENC];
> >         struct dpu_hw_ctl *ctl =3D phys_enc->hw_ctl;
> >
> >         memset(&mixer, 0, sizeof(mixer));
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/m=
sm/disp/dpu1/dpu_rm.c
> > index e219d706610c2..77d7ff789346e 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> > @@ -306,7 +306,11 @@ static int _dpu_rm_reserve_lms(struct dpu_rm *rm,
> >                 if (!rm->mixer_blks[i])
> >                         continue;
> >
> > -               lm_count =3D 0;
> > +               /*
> > +                * Clear the last bit to drop the previous primary mixe=
r if
> > +                * fail to find its peer.
> > +                */
> > +               lm_count &=3D 0xfe;
> >                 lm_idx[lm_count] =3D i;
> >
> >                 if (!_dpu_rm_check_lm_and_get_connected_blks(rm, global=
_state,
> > @@ -353,6 +357,8 @@ static int _dpu_rm_reserve_lms(struct dpu_rm *rm,
> >
> >                 trace_dpu_rm_reserve_lms(lm_idx[i] + LM_0, enc_id,
> >                                          pp_idx[i] + PINGPONG_0);
> > +               DPU_DEBUG("reserve lm[%d]:%d, pp_idx[%d]:%d, dspp[%d]:%=
d for enc_id %d\n",
> > +                         i, lm_idx[i], i, pp_idx[i], i, dspp_idx[i], e=
nc_id);
> >         }
> >
> >         return 0;
> >
> > --
> > 2.34.1
> >
>
>
> --
> With best wishes
> Dmitry

