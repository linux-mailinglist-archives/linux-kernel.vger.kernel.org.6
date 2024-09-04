Return-Path: <linux-kernel+bounces-312479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 515B896972D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76B6C1C22DC2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E73D2101B6;
	Tue,  3 Sep 2024 08:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KTSU8gVf"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257762139A7
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 08:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725352473; cv=none; b=hHeoIu4l8M8OYSHpjmLrTTRh2K0tRW8frjp1MVZtc4WYwpYefjUkSkr/4mlwgPVXy9mkLl5Tc5IXiqXicVDpBzo0oMGGidFVX4YCs9pxr/BgGR+kHsWPW40u1SPXI2kSrFpF9YtGzhArKL/smVGtHLeI3gbLimdHp+Adbf+d94s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725352473; c=relaxed/simple;
	bh=TMITeL74isS6LmOErJ4cAaKv2UtPsd61SASH9AKUhDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gySb8gtsbja8nVZG4ONyd23Q2auXJNU5InkheIwUaLRauishexlTKe2bd9uG4F/4JnXSlZLVjPJfcFc8jPabjtGL7tyf+Mgfkx9EMUmJ/R5/n65iJWbhNSh6EEmtAheezb8Yfrez1/Kpza8T2Yn6Wr1pzHoqVtmx5V890q9rsxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KTSU8gVf; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6d3f017f80eso32390437b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 01:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725352470; x=1725957270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3o9D8uVOtpTVbk+TPNxYEMvtHmsKPOlQhjwdRt4OfR4=;
        b=KTSU8gVf5PacPc99g4ARFcXJEQn3LH7DcjxfLBP5PeauXo/CxdVhVJlmjygPT5trk5
         26aj8r42jPqEs0lHjosPV2cVXJwRqBhq79A1NsXoV5TE3Y2rIucKY8S5B9M4Z5uByu0J
         FPKjC+iwbdH0TMN4hhHs/X7wfxkBONxxrdE02djQ+ovwbSpdlrjdW0yW6sFqF+0P0BIf
         oHKvFe9Xi7u6q6U4K8aQc8P1lljIEAZTTGCD2UGWE1sU7Nzh6koxj/B66Q9PSvXcxDEV
         vjt91Bex+XnbMi3c9P+/Wo6RdAAouACQgMITuk7Jf20IFZjiVG7DoIZFwh9boGhZz+DZ
         NEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725352470; x=1725957270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3o9D8uVOtpTVbk+TPNxYEMvtHmsKPOlQhjwdRt4OfR4=;
        b=KZku85vw87Oik/1yJdQOUuapHtEfSAK4onP3NBRcHsoCiL7fEEBdpmaNtF9lrA2NMW
         vBaqjYWFxmoDuR90YKWmsrmL2SLgSr0SUjiacoUmzI9M10Epcc/Q6QjzD8B9qc0Dg8+V
         SGAdQwYaSH1VKAwomCfaELzeoUIql2ZWmxZmtU5hjVvKcELAkPVKy6dy/48Lch9BA9+C
         QHpTpQLUKVbAXS9NGnWlBA+GXC+EaVCGuovdDYOU5nOq0chIwQTkC0GKjiLDJfceIWaX
         h/5cTq3AcQz2YwBK5T2+rzelu5A+dGULxnjqJ+Q/o4XtLJjGXlGygEIwZVnJdESzeYGC
         769A==
X-Forwarded-Encrypted: i=1; AJvYcCUkCl04oHnO4+W5E9zbB8UhJ5CVha3adEaM3RWKQD3Uo0ni+nm8PpDzvmGpoEO65pt5/AAIM1TAzaTDtKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkoBeP9AgQqTxZFKayOPbKAQeNmRSBgP6yqN+PD9u4Io2aGMRE
	O/VsISQOD/Tv0jDWowo5gcw5lGhJHaxO3pSAUUKR2LkyLxN70VRCp4CEinnV4el2eWyMPVbq7Mf
	CBC1r2PbiZbieviXBtXv+bFedcK62cu4GcksPsg==
X-Google-Smtp-Source: AGHT+IE/swZHdLRleFxe2nf/SNcWP2+mYsPYhZlOG8GFptpLYVix/nbfVUqMnxGfBq8VesnX9TqFoJ846I0MXEspRSE=
X-Received: by 2002:a05:690c:dca:b0:631:78a1:baf with SMTP id
 00721157ae682-6d40ee58397mr150471477b3.6.1725352470013; Tue, 03 Sep 2024
 01:34:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-0-bdb05b4b5a2e@linaro.org>
 <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-3-bdb05b4b5a2e@linaro.org>
 <CAA8EJpqCL1xFVB8_2j2QwPsF-vHBcFBt3yx=acpWgmo4_Oudug@mail.gmail.com> <CABymUCOsF5gL_i-uEyBBpgV_9qO_T3hNQ6vSX-dMGRsdFfgPXg@mail.gmail.com>
In-Reply-To: <CABymUCOsF5gL_i-uEyBBpgV_9qO_T3hNQ6vSX-dMGRsdFfgPXg@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 3 Sep 2024 11:34:19 +0300
Message-ID: <CAA8EJppjr=6LncRGZAKdefvsPFXra=HZPuD5TjJRvvaf7WbALA@mail.gmail.com>
Subject: Re: [PATCH 03/21] drm/msm/dsi: pass the right width to dsc
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Sept 2024 at 10:34, Jun Nie <jun.nie@linaro.org> wrote:
>
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> =E4=BA=8E2024=E5=B9=B48=E6=
=9C=8829=E6=97=A5=E5=91=A8=E5=9B=9B 18:57=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Thu, 29 Aug 2024 at 13:19, Jun Nie <jun.nie@linaro.org> wrote:
> > >
> > > Data width for dsc engine is aligned with pipe, not with whole screen
> > > width. Because the width may be halved in DSI bonded case.
> >
> > Can't really parse this.
>
> Please forgive me for my bad English. Is below words better?
>
> Data width for DSC timing is aligned with the width that goes to a DSI

to a single DSI interface

> interface, not with whole screen width. For bonded-DSI case, the
> width for DSC timing is half width of whole screen.

sounds much better.

> >
> > >
> > > The dsc width is not related to the timing with back front porch in
> > > later stage, so update dsc timing earlier.
> > >
> > > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > > ---
> > >  drivers/gpu/drm/msm/dsi/dsi_host.c | 13 ++++++-------
> > >  1 file changed, 6 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm=
/dsi/dsi_host.c
> > > index 7a4d9c071be5a..5abade8f26b88 100644
> > > --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> > > +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> > > @@ -953,7 +953,7 @@ static void dsi_timing_setup(struct msm_dsi_host =
*msm_host, bool is_bonded_dsi)
> > >                         return;
> > >                 }
> > >
> > > -               dsc->pic_width =3D mode->hdisplay;
> > > +               dsc->pic_width =3D hdisplay;
> > >                 dsc->pic_height =3D mode->vdisplay;
> > >                 DBG("Mode %dx%d\n", dsc->pic_width, dsc->pic_height);
> >
> > Two separate commits
>
> OK. Will split it.
>
> >
> > >
> > > @@ -964,6 +964,11 @@ static void dsi_timing_setup(struct msm_dsi_host=
 *msm_host, bool is_bonded_dsi)
> > >                 if (ret)
> > >                         return;
> > >
> > > +               if (msm_host->mode_flags & MIPI_DSI_MODE_VIDEO)
> > > +                       dsi_update_dsc_timing(msm_host, false, hdispl=
ay);
> > > +               else
> > > +                       dsi_update_dsc_timing(msm_host, true, hdispla=
y);
> > > +
> > >                 /*
> > >                  * DPU sends 3 bytes per pclk cycle to DSI. If widebu=
s is
> > >                  * enabled, bus width is extended to 6 bytes.
> > > @@ -990,9 +995,6 @@ static void dsi_timing_setup(struct msm_dsi_host =
*msm_host, bool is_bonded_dsi)
> > >         }
> > >
> > >         if (msm_host->mode_flags & MIPI_DSI_MODE_VIDEO) {
> > > -               if (msm_host->dsc)
> > > -                       dsi_update_dsc_timing(msm_host, false, mode->=
hdisplay);
> > > -
> > >                 dsi_write(msm_host, REG_DSI_ACTIVE_H,
> > >                         DSI_ACTIVE_H_START(ha_start) |
> > >                         DSI_ACTIVE_H_END(ha_end));
> > > @@ -1011,9 +1013,6 @@ static void dsi_timing_setup(struct msm_dsi_hos=
t *msm_host, bool is_bonded_dsi)
> > >                         DSI_ACTIVE_VSYNC_VPOS_START(vs_start) |
> > >                         DSI_ACTIVE_VSYNC_VPOS_END(vs_end));
> > >         } else {                /* command mode */
> > > -               if (msm_host->dsc)
> > > -                       dsi_update_dsc_timing(msm_host, true, mode->h=
display);
> > > -
> > >                 /* image data and 1 byte write_memory_start cmd */
> > >                 if (!msm_host->dsc)
> > >                         wc =3D hdisplay * mipi_dsi_pixel_format_to_bp=
p(msm_host->format) / 8 + 1;
> > >
> > > --
> > > 2.34.1
> > >
> >
> >
> > --
> > With best wishes
> > Dmitry



--=20
With best wishes
Dmitry

