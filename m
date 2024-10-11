Return-Path: <linux-kernel+bounces-360628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBC7999D70
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD6CE1C22012
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70D8207A36;
	Fri, 11 Oct 2024 07:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iEhpSdm5"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6FBBA2D
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728630415; cv=none; b=ZXnoDjwA1RKDcfz07XInS+pH7NZ0qmwFMI583KAJ06mGI3dy9EIY3o2fY9/kUMZEiz6X0VfoXGv6ahFKCsrBsvXwqblsbiqRtXcFhBzxAgsBquBd6iguza/+ERjhnVoJShZpLG3903iyqU7W3TEpLG30UhLPwNSB/ONS+diOZOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728630415; c=relaxed/simple;
	bh=OUEq0owwHAkCt3sxN/Mq8rka0fcPjesIj/2Td3oVAH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g/ArrxxEYm/mjYrZzxcY2PuAWgdqIhvcBoDTgRRXiZ2NU1zNRUKp928lJsRQJRiJyRfcWyHB1Idc/XepfX+rs2TJ3gEDmhDNFFJzDmiftxAv/lWzBgSpn7ifbxDjxlxCzTx1hTVAdCUhn6inOYqR+5GiWc/K4YU/HAeJ22Lfp54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iEhpSdm5; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6dde476d3dfso16111707b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 00:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728630412; x=1729235212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KbDvhzRE0GcC1Dd4Kqw9/lX4StqtF0AG6/j/dYmGN1o=;
        b=iEhpSdm53iy/7JIxasQ7kLL4P2inSpX9JSGpxEF9oPcwJiiw1u5jk1GdWIvQKGHH1Q
         h42hzWALmMGeE/Wi3u69kPa/D4VvK9aG1imEoRRCz48y7FMd19gvLCokxPeHL/wtNTGw
         Kz8t7DRAkTSLrT+KZOowbnPMPPta/S4mZ0fp7ZQ6jIcy9Nx0gu604F1gzqDx/+O+7Q2N
         7mLGQhTR7fNbCdgLVnZLN5D84QFSQNWM9bn0B8JUJpJKAm6qlC1s0JUUMlui9SChdAzO
         pRhcNvX/jNhkj2imx1hTVphZCl2DvOh6FrFJHzP9pdcUTytZm7JqqE27JKANCDkgPnrk
         i/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728630412; x=1729235212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KbDvhzRE0GcC1Dd4Kqw9/lX4StqtF0AG6/j/dYmGN1o=;
        b=RRPnP5WBLXiEU37sYcfvUPSVeWbqpIEtLF7h9LQW+6BsRh5rqO817PyWLItt/J6Ii/
         PJJbWJdsUFj8oC7JvQNI/sJ/afs3l1qbrNk3wXLHZIELl5rS6c9lZHbWEGCtrewHGLVv
         GndAr2mwfQOJAzaPR8IbeHXddeB4pw6NxiPkk0AOy0+J8pAQ/tfPH0lxnbVsWXgFgbtG
         DZVTzlExvPswlQ4NUql2lfwxRE82nh1ttjvtFMcGbSOWpUljBtfM7MyXPikus2JXv/cB
         1S2jtRluBmfc1DqYLUsZW7i7pvGeoKZ6whbXHP1MG461iZ+tyU6sACFf2z38SNc+cz4V
         o2Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWAUFr95Teot5vuhS8qWliRDTHdKwQu/9XbndNLfO/8hE/mPifAWs+RJoCJrhKrAKBbJ2Z8A9wA/hgb+ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL6tBhkUkyMtn56ML3aSClhxlNYEZ9iAECV3WNBz9xblk5jio2
	3xvX1SMYeTtkvEA22xvP06fT/eM3NJ7h+MPA6HqjH8wn4pEfGL7LhIwiM6ZobPlkIrEgQ6c1zTh
	SOIBarLEcVYahSUT9O0rfYrnAfS0CBYrHEEvMmQ==
X-Google-Smtp-Source: AGHT+IGAqFf1aCWRylzQD2egBbLwi3qRNqcNEIYZaTvmCmq4ukOzJTKIvCqu2AgBinqdnGTEhCOpEXxLoURFTP8BrkA=
X-Received: by 2002:a05:690c:fc7:b0:6e2:b263:1045 with SMTP id
 00721157ae682-6e3477befe2mr12970867b3.6.1728630412570; Fri, 11 Oct 2024
 00:06:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-0-76d4f5d413bf@linaro.org>
 <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-8-76d4f5d413bf@linaro.org>
 <n7bkvvxph2wxaxf2s7vonj273ouonlb2nisl7n7ora6j5stnlv@tt3v3uawwh2q> <CABymUCPV+bu-MNGCRp_0A+jC9Z6hY3XRm4vZ5Ju2XxT5YuRzPA@mail.gmail.com>
In-Reply-To: <CABymUCPV+bu-MNGCRp_0A+jC9Z6hY3XRm4vZ5Ju2XxT5YuRzPA@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 11 Oct 2024 10:06:41 +0300
Message-ID: <CAA8EJpprO9pZ7bRf5HDA7-8UYKn5RiK2Yg9eW1NTYSEAE8ZDFw@mail.gmail.com>
Subject: Re: [PATCH v2 08/14] drm/msm/dpu: update mixer number info earlier
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Oct 2024 at 09:30, Jun Nie <jun.nie@linaro.org> wrote:
>
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> =E4=BA=8E2024=E5=B9=B410=
=E6=9C=8810=E6=97=A5=E5=91=A8=E5=9B=9B 21:12=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Wed, Oct 09, 2024 at 04:50:21PM GMT, Jun Nie wrote:
> > > Update mixer number info earlier so that the plane nopipe check
> > > can have the info to clip the plane. Otherwise, the first nonpipe
> > > check will have mixer number as 0 and plane is not checked.
> > >
> > > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > > ---
> > >  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 11 ++++++++++-
> > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gp=
u/drm/msm/disp/dpu1/dpu_encoder.c
> > > index dfe282c607933..68655c8817bf8 100644
> > > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> > > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> > > @@ -638,6 +638,7 @@ static int dpu_encoder_virt_atomic_check(
> > >       struct dpu_global_state *global_state;
> > >       struct drm_framebuffer *fb;
> > >       struct drm_dsc_config *dsc;
> > > +     struct dpu_crtc_state *cstate;
> > >       int ret =3D 0;
> > >
> > >       if (!drm_enc || !crtc_state || !conn_state) {
> > > @@ -662,6 +663,8 @@ static int dpu_encoder_virt_atomic_check(
> > >       dsc =3D dpu_encoder_get_dsc_config(drm_enc);
> > >
> > >       topology =3D dpu_encoder_get_topology(dpu_enc, dpu_kms, adj_mod=
e, crtc_state, dsc);
> > > +     cstate =3D to_dpu_crtc_state(crtc_state);
> > > +     cstate->num_mixers =3D topology.num_lm;
> > >
> > >       /*
> > >        * Use CDM only for writeback or DP at the moment as other inte=
rfaces cannot handle it.
> > > @@ -1170,7 +1173,13 @@ static void dpu_encoder_virt_atomic_mode_set(s=
truct drm_encoder *drm_enc,
> > >       }
> > >
> > >       cstate->num_dscs =3D num_dsc;
> > > -     cstate->num_mixers =3D num_lm;
> > > +     if (cstate->num_mixers !=3D num_lm) {
> > > +             if (!cstate->num_mixers)
> > > +                     DPU_ERROR_ENC(dpu_enc,
> > > +                                   "mixer number %d is not as expect=
ed %d\n",
> > > +                                   num_lm, cstate->num_mixers);
> > > +             cstate->num_mixers =3D num_lm;
> > > +     }
> >
> > Is it a possible case or just defensive coding?
>
> The value is initialized beforehand only in virtual plane case. So we
> still need this
> for non virtual plane case.

It looks better if it's handled in the non-virtual code instead.

--=20
With best wishes
Dmitry

