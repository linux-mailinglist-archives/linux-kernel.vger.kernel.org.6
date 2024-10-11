Return-Path: <linux-kernel+bounces-360561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69844999CA9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A3C41F25F30
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5CE19995E;
	Fri, 11 Oct 2024 06:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dZQabCRe"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B988519AD94
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 06:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728628221; cv=none; b=I9lsuZ3/eIjmSOWI3NEdNItotWrU346BhhLAAHcjUEEd90+V8PJ1bNIT6x4CoLXaMN1sSLklmeUyqe04ttYcChenoaDD5zXQYOZxYdMP4FN8iIaGxnlFhINrV5cPk1yZptMUCjChCsTfdqQl49Gw2uWhuSqHnsCXCRgW+GITulA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728628221; c=relaxed/simple;
	bh=h0siM48bq3PDByFuywKQou5YOhOvkHoz0oc32xC8FvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADIjHsTmD1TCTnfRkipH4GXXOtTWE2FRgl7QfIkh+xbAnEwRX0IGUAJmAzMLkHW7DUfdYkLnX0j4S6SE+0dW0jLspHKyNh3SVUL5e/0pXPca9Lz7hUBmGbLQLpQTV5yulY3y1Ek0U/ZSXB+JPHeiQ1CLo3+jTXoHylqbRU8QqfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dZQabCRe; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e290bf7adaaso1726512276.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 23:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728628218; x=1729233018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVcEDroOEZwsIMVrx+9WRohn0DDzskEXWSGatUhqlGY=;
        b=dZQabCReNEUlwSN2QJ+YLGQJyFKtoOa6d8pwtsW1tSKlayt1+GCDa6mrvL85FDtDbI
         qnwm93jgtVo/Gz9xgOmqqwXjDe6iecCYX5DEj4F6mxfd6iGSV+eIWgZz54RO9DCuQcK/
         A3nAIdxQmDGybIQ7jIcTecTrEVJ2ouIe+JpStknMV4Qh5fuG3E3Y2R/+i8ibEoda4NTB
         CtAwmBRqnT2tIrk+VrkBfHVHBbuSBLyrq/NmazUIxS3OaImhs+DWRbDZlzh4hr+9oMMt
         vn+7yC2KmiV5fqATyAzYthGTe72Dzs9b0xA0Swx9+rm3UAehw+t2NaTRS+FvBrvjeWIj
         OLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728628218; x=1729233018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVcEDroOEZwsIMVrx+9WRohn0DDzskEXWSGatUhqlGY=;
        b=MgR4ax/FWRxsljKUHfInQT4B1lDV2GNupKi2MtnSvxt5D4eQ1Zvqvp7j544yX4Z9iA
         1AtCWgHpf3PrNECly9y1eaLfo1hMt08lQ47L7uwt/eYlXsWyCgeJ3xX3O0zIcutuZK5n
         nxh7Ur4OlPL+C7eAdHuMWsDO3Kc5kcAHC0lFu3ovQjaiBhHSTCRTC6VXb2gzv2CwHQ3e
         mCOUPDDC9E1x5QFVfxEslMMjJh5m9vKYIkSUtSsksGk002eynd0S7Xbi9eb7U0dQNpBB
         2DPxtNZ3XKS+8m0RU/zZJwNYdEqxT3SeURyTCQF8Qxbuwuy01rzzE9Bsd41v17ImldkS
         q+0w==
X-Forwarded-Encrypted: i=1; AJvYcCUxpTsBxpCagSb/BVHqTGPuqJtAStBVyjKx32LqryKI5xkeDQGFH6UaYjtSn35mazxwvYFdOH/wQMcengk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNm7cerRzVnaZBxJpn5k9oZvK94TFHhoX2f7xKfidFIH6PZHTS
	D93mDKMOCqsFCQ1mL9Ef0WfKNNLHMx01igMgNYA+VWNp8SqFmnt6q8MQ7ip76nfzkdqmPN7hgY/
	rFivRIAJv7xeh/rmc18NzFj1g6I3ygBK4aGbnY+T5Pcz4gYM/mvXU47fg
X-Google-Smtp-Source: AGHT+IHJdQGSufApLca8LjP+ezebvoTYvY+Iadu6v7iZqW7H9NHt7SSVE59XTNWKkbubvse0s188tLVmRhsmcUOf89Q=
X-Received: by 2002:a05:6902:1441:b0:e29:2e8:5c95 with SMTP id
 3f1490d57ef6-e2919fff5aemr1088090276.51.1728628218609; Thu, 10 Oct 2024
 23:30:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-0-76d4f5d413bf@linaro.org>
 <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-8-76d4f5d413bf@linaro.org>
 <n7bkvvxph2wxaxf2s7vonj273ouonlb2nisl7n7ora6j5stnlv@tt3v3uawwh2q>
In-Reply-To: <n7bkvvxph2wxaxf2s7vonj273ouonlb2nisl7n7ora6j5stnlv@tt3v3uawwh2q>
From: Jun Nie <jun.nie@linaro.org>
Date: Fri, 11 Oct 2024 14:30:07 +0800
Message-ID: <CABymUCPV+bu-MNGCRp_0A+jC9Z6hY3XRm4vZ5Ju2XxT5YuRzPA@mail.gmail.com>
Subject: Re: [PATCH v2 08/14] drm/msm/dpu: update mixer number info earlier
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dmitry Baryshkov <dmitry.baryshkov@linaro.org> =E4=BA=8E2024=E5=B9=B410=E6=
=9C=8810=E6=97=A5=E5=91=A8=E5=9B=9B 21:12=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Oct 09, 2024 at 04:50:21PM GMT, Jun Nie wrote:
> > Update mixer number info earlier so that the plane nopipe check
> > can have the info to clip the plane. Otherwise, the first nonpipe
> > check will have mixer number as 0 and plane is not checked.
> >
> > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > ---
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/=
drm/msm/disp/dpu1/dpu_encoder.c
> > index dfe282c607933..68655c8817bf8 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> > @@ -638,6 +638,7 @@ static int dpu_encoder_virt_atomic_check(
> >       struct dpu_global_state *global_state;
> >       struct drm_framebuffer *fb;
> >       struct drm_dsc_config *dsc;
> > +     struct dpu_crtc_state *cstate;
> >       int ret =3D 0;
> >
> >       if (!drm_enc || !crtc_state || !conn_state) {
> > @@ -662,6 +663,8 @@ static int dpu_encoder_virt_atomic_check(
> >       dsc =3D dpu_encoder_get_dsc_config(drm_enc);
> >
> >       topology =3D dpu_encoder_get_topology(dpu_enc, dpu_kms, adj_mode,=
 crtc_state, dsc);
> > +     cstate =3D to_dpu_crtc_state(crtc_state);
> > +     cstate->num_mixers =3D topology.num_lm;
> >
> >       /*
> >        * Use CDM only for writeback or DP at the moment as other interf=
aces cannot handle it.
> > @@ -1170,7 +1173,13 @@ static void dpu_encoder_virt_atomic_mode_set(str=
uct drm_encoder *drm_enc,
> >       }
> >
> >       cstate->num_dscs =3D num_dsc;
> > -     cstate->num_mixers =3D num_lm;
> > +     if (cstate->num_mixers !=3D num_lm) {
> > +             if (!cstate->num_mixers)
> > +                     DPU_ERROR_ENC(dpu_enc,
> > +                                   "mixer number %d is not as expected=
 %d\n",
> > +                                   num_lm, cstate->num_mixers);
> > +             cstate->num_mixers =3D num_lm;
> > +     }
>
> Is it a possible case or just defensive coding?

The value is initialized beforehand only in virtual plane case. So we
still need this
for non virtual plane case.
>
> >       dpu_enc->connector =3D conn_state->connector;
> >
> >       /*
> >
> > --
> > 2.34.1
> >
>
> --
> With best wishes
> Dmitry

