Return-Path: <linux-kernel+bounces-358704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D83D199829D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 983212820A5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB2A1BC9EE;
	Thu, 10 Oct 2024 09:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MoqewcXm"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725BBBE6F
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728553358; cv=none; b=bLeAjkWRduXbH+JqcsrdnZ24hgXRiRW+mYr1tz3ZxGac8T91k0XrLRj4DSc6m04PBMsow0EVyEmp/geE1Awbxbd6YiqpT+lZAeop4l0HEj98OH9k70xHGS0na0FdzhrHbSfRxbeieO6DTRoO8I9AvYtkiPdnh66SD/MSotgGQJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728553358; c=relaxed/simple;
	bh=qw7bxAwcUEvG6rzmDxAgT3vcA69UNv8FW+zgV5hbTxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f5KvCcMcscthM5ratJ4L6VFEMcK3ltRXegFeZKzFsELzZfk/G0YuNAXgZV/DMXC0cfyS3X4sJQ0fLBjN14w0RvPqFI4rXILYoM+MZPltSwGv4nLW6DdEAy/X+sFqwBAHjwAlWGP6bRC0NhkhmCw6FdH1UIjbri9SfSwGR8CuLbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MoqewcXm; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e2f4c1f79bso7428487b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 02:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728553355; x=1729158155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AFuEM5iQK1BFg24WS6aJ9H/ndfdGGqBiQFPKLr/iwg=;
        b=MoqewcXmHKBen+R9/q7pADloLoGELuAWTo/D5V401PmjR9UO2c1AMZv6MBBaRwi/vF
         ey49Hj7fyMDz9m6v/3PlIykvDkJTgZedTTFyIKnuZ9YyqcHxmbuxYqAeAHEUCZOPt7ZG
         geXFY2jWPPnjB0IPQttuOnzu0eVzNVWx9ZAwv3+/G1HEZmvPqz2UuKDsfPC6XbhXpjbf
         IVxM27YQFE0yfLft8LJ1X5CmXkW9aU747rjH4e2ev9eTf5tpIqLdarZIBGGT+mAASlNP
         sqRMJBhgnhuJAviu+FMJlAF/PqwgLZSA0TudKOiDpu7JI0JK9eX03JQsZGmUgwyH5NQ2
         JT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728553355; x=1729158155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AFuEM5iQK1BFg24WS6aJ9H/ndfdGGqBiQFPKLr/iwg=;
        b=iNHSlYMYLGmAFdWHgHUgzs25Bbk2YUxyPmD8DWkxIXoiRh20jrDq3s7xSBicC9bbAJ
         eHNavD9CXW7dB+uf/y+UnA1UJ0j5jQkQccEzW1T8jiLM+yjzjLGgEQkmYXi7VjouQdVD
         /rpmS2I86aB2xQ4zwJllEkuYbjHPfnbBo6mP7pagygZaSx+eNe4w2oYxeXFM9rTvmY2y
         aXLfMBQBKM9w3uRAhXBP+AvZrgXXWtci7pOEfvPM8htCTMIQ8irRGFE/uKnKzPbiHe8D
         E7+oZRO/yrhB8TAN3pB0JQVdBNh3ynV5U1GDzgge8EGQEH799caLpFT2X3Pjmr8B5kU/
         eUqg==
X-Forwarded-Encrypted: i=1; AJvYcCWrWq3HZGE3SGMS2R2oFG7nAkitNCdQp7qwQN5sOxxi3nAm8T/3E9IcRaqvSdVTZRZ0YRX5aFCu/pC0PNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YylPV3LZSGzy1DRixUyK08jFHc3LwT+/WO618nUdweE1bME/wcW
	QLulNGkeWECGtNAf0vlgdjmZoKW58atXcVJPytOy3KYeDVDP9XU71AyUBr//IdqGprXph511TDy
	HJWxNMKCCmE0xVfy0OND4j47c7k7knGz9znZD7Q==
X-Google-Smtp-Source: AGHT+IGmAQ12ZK/exUtgQunkQD9Pba+qYyFly3uEDHGNZP0eC+XCxiqyJ8v2g1NWX+u+g414abxOj3NfbQ9kYJQAxO4=
X-Received: by 2002:a05:690c:2f08:b0:6db:da26:e8c6 with SMTP id
 00721157ae682-6e322491509mr49597547b3.44.1728553355429; Thu, 10 Oct 2024
 02:42:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-20-v1-0-139511076a9f@linaro.org>
 <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-20-v1-2-139511076a9f@linaro.org>
 <CAA8EJpr-B2OZbn5_6dUnojf9ZTXkVcE2nUL1QHohTmk0Qa+bPg@mail.gmail.com> <CABymUCMAsXFz4tMdNexxU8UVGu_khcD6EE+KBt=5EHmKbXvG5A@mail.gmail.com>
In-Reply-To: <CABymUCMAsXFz4tMdNexxU8UVGu_khcD6EE+KBt=5EHmKbXvG5A@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 10 Oct 2024 12:42:24 +0300
Message-ID: <CAA8EJpqv84EPWysZKhATthybZ5ODutNq9mJ0SO2HpzqruaR=+g@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/msm/dpu: configure DSC per number in use
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Oct 2024 at 04:47, Jun Nie <jun.nie@linaro.org> wrote:
>
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> =E4=BA=8E2024=E5=B9=B410=
=E6=9C=8810=E6=97=A5=E5=91=A8=E5=9B=9B 06:10=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Wed, 9 Oct 2024 at 09:39, Jun Nie <jun.nie@linaro.org> wrote:
> > >
> > > Only 2 DSC engines are allowed, or no DSC is involved currently.
> >
> > Can't parse this phrase.
>
> How about this:
> If DSC is enabled, the only case is with 2 DSC engines so far.

Just:

Currently if DSC support is requested, the driver only supports using
2 DSC blocks.

>
>
> >
> > > We need 4 DSC in quad-pipe topology in future. So let's only configur=
e
> > > DSC engines in use, instread of maximum number of DSC engines.
> >
> > Nit: instead
>
> Yep.
> >
> > >
> > > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > > ---
> > >  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 13 ++++++++-----
> > >  1 file changed, 8 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gp=
u/drm/msm/disp/dpu1/dpu_encoder.c
> > > index 39700b13e92f3..e8400b494687c 100644
> > > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> > > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> > > @@ -1871,10 +1871,13 @@ static void dpu_encoder_dsc_pipe_cfg(struct d=
pu_hw_ctl *ctl,
> > >                 ctl->ops.update_pending_flush_dsc(ctl, hw_dsc->idx);
> > >  }
> > >
> > > -static void dpu_encoder_prep_dsc(struct dpu_encoder_virt *dpu_enc,
> > > -                                struct drm_dsc_config *dsc)
> > > +static void dpu_encoder_prep_dsc(struct drm_encoder *drm_enc)
> > >  {
> > >         /* coding only for 2LM, 2enc, 1 dsc config */
> > > +       struct dpu_encoder_virt *dpu_enc =3D to_dpu_encoder_virt(drm_=
enc);
> > > +       struct dpu_crtc_state *cstate =3D to_dpu_crtc_state(drm_enc->=
crtc->state);
> > > +       struct drm_dsc_config *dsc =3D dpu_enc->dsc;
> >
> > Why? This doesn't seem to be related to num_dscs introduction.
>
> You mean the comments above these 3 lines? Yeah, it should be removed.

No, I mean that this whole chunk isn't related to the num_dsc support.
There is no need to change function arguments.

> >
> > > +       int num_dsc =3D cstate->num_dscs;
> > >         struct dpu_encoder_phys *enc_master =3D dpu_enc->cur_master;
> > >         struct dpu_hw_ctl *ctl =3D enc_master->hw_ctl;
> > >         struct dpu_hw_dsc *hw_dsc[MAX_CHANNELS_PER_ENC];
> >
> > [...]
> >
> > > @@ -1953,7 +1956,7 @@ void dpu_encoder_prepare_for_kickoff(struct drm=
_encoder *drm_enc)
> > >         }
> > >
> > >         if (dpu_enc->dsc)
> > > -               dpu_encoder_prep_dsc(dpu_enc, dpu_enc->dsc);
> > > +               dpu_encoder_prep_dsc(drm_enc);
> > >  }
> > >
> > >  bool dpu_encoder_is_valid_for_commit(struct drm_encoder *drm_enc)
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

