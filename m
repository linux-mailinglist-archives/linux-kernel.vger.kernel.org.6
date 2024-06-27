Return-Path: <linux-kernel+bounces-233132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7368B91B2A8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 01:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96F8B1C21A69
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 23:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB2A1A2FA5;
	Thu, 27 Jun 2024 23:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bmUPoDIA"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167923FBA5
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 23:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719530567; cv=none; b=mATlzqpG/lycQeYDOmzkvqbiJzswoeGG9qjjQHExE+igyFmRU5a+PqpHuo5xqXB9r735SgL9lJkmyO1SKNMbelNOyLNk9WrFUBV2c6vcdKq/adEx2GooMZKAOt9DVrkLiTYNpoNadzKqnRRrz+mqWVcvw+crQJj1SPiuIbbLrW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719530567; c=relaxed/simple;
	bh=vDn4zbbwQN2LrueYoVu0Wjy6pY1bsY3BKxpWDC1yVf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/fLsc3BCzijgpn4yGYLMW6U+QzJo7NxUfuwC3Qh+ujK36+BNk8NfuG57SztX+u8OZ1aO2eNcXZrqR9L1xbjT0p+7H4rnEDegdP7iJw2nxoVlvarF2Oj9InxZfus2XY27QGWk+0y/2V7Arw5sY1bat8d8XToTA2iIOkbK12jaqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bmUPoDIA; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6480542003dso122617b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 16:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719530564; x=1720135364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LB7gCAzcMu24VqG7bE0lt079FWwJNySL9zyflCf6kE=;
        b=bmUPoDIAzjQb0rtfw/fLtbs9m4Mr7h6EluaT+ImdbLFBGVRtBCWonevRj0arUaPRnd
         3U8W79ziHGW6fvjulS2ij984UO5xxDrHVdreJ+aLjGj8AI/Cai2ZfpoapH065PfAYkcM
         LgiSQ23CbSYBmef6Dmty8bDgwp/ul1T2Y5kEGxLhT2bzyOKEaSMUUr6cixWSxvb83kXc
         1eb6/VuHjXUyYh/Oy0ztTl7tY3PBaCnAVwh0+eyj8SqShVrF1FbPJYOUCmEwKwIIsMUi
         ROk59OsMYmv7FyPOFXLUcu2j84BONA0NCqSq2JU8qNhNcKRIFYQM0HEjm4BC1F0cGO12
         I//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719530564; x=1720135364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0LB7gCAzcMu24VqG7bE0lt079FWwJNySL9zyflCf6kE=;
        b=C9/dSybBMS83mV3HOzXvoj1rZoID+TiCfQP54aFhl11uqygo2gd5nuAfteiJ0/5VC4
         f9+dvaHW9nQVFGnfath6NlxyBC06K9u1v74HNuIhLkDJYwkhND9UFF2VxMzRrCm8NU78
         CtZtBcTcPhR0gSzJu9JwpGY2Ah5aZlVnSyDCnMX7iiDr1+c2T2cLwlbFL3INFf7JZ/hP
         wkNyxxbd9vAfu3ZrKZQipojPxt2n4/wdF1mzv8e8fn/c8qMCHxnRvUoYRs1bZkYgc+8V
         gpD+nFCZYLglp/aZbPN0LihYptLU17ydyjlz/8XqMlOvmtTH+B9qooF8awIL5Wn1KSly
         k9Ug==
X-Forwarded-Encrypted: i=1; AJvYcCX2n5cazhdKCuNF+GDQ+DGbK5amCy0evVd4Ix7Qma6TMWB4PWbNzAGYtmFYE7nq7f/sBpfPHXfCsH1xyCTwYi9XxSJ+NL6pGmCNYilt
X-Gm-Message-State: AOJu0YyVJ0kauXl7wmgMkC3c2xy64ZICuIlgsd6C5XzM8duR71wcs7j+
	2fRleeJGmRZN6lKWPFyJaL1rfOVnj7buJ5v/z6QU9u3MiEbgvg8QwzO2luowtJGuIsK2hJFVaWV
	dhEOi8Eks469wcIrVb80+cMayAXd8aMZlJmCZJQ==
X-Google-Smtp-Source: AGHT+IHVr+5tNjDkazfolV1Z/Izc4wyGgRDTTfMMbJrJozuIjcL1Ax1K2NLH9YQJmTc28hAZR6/sL18+n2Y2dm8UqRQ=
X-Received: by 2002:a05:690c:d8a:b0:627:972f:baba with SMTP id
 00721157ae682-643aae70b44mr194087277b3.31.1719530564028; Thu, 27 Jun 2024
 16:22:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627205328.2912859-1-quic_abhinavk@quicinc.com>
 <CAF6AEGuGYG5mO-4KdNFbQFMA4dKj2PWT22xeh-3AFgedAG0uHw@mail.gmail.com> <3749ac14-54d0-fb62-345b-cef62399b6d4@quicinc.com>
In-Reply-To: <3749ac14-54d0-fb62-345b-cef62399b6d4@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 28 Jun 2024 02:22:32 +0300
Message-ID: <CAA8EJppM1429sGzW6hq4QzLEjVX5Cf+8Jt5y94+VocFmPyxz+Q@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/msm/dpu: check ubwc support before adding
 compressed formats
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, freedreno@lists.freedesktop.org, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	quic_jesszhan@quicinc.com, konrad.dybcio@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 28 Jun 2024 at 00:21, Abhinav Kumar <quic_abhinavk@quicinc.com> wro=
te:
>
>
>
> On 6/27/2024 2:13 PM, Rob Clark wrote:
> > On Thu, Jun 27, 2024 at 1:53=E2=80=AFPM Abhinav Kumar <quic_abhinavk@qu=
icinc.com> wrote:
> >>
> >> On QCM2290 chipset DPU does not support UBWC.
> >>
> >> Add a dpu cap to indicate this and do not expose compressed formats
> >> in this case.
> >>
> >> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> >> ---
> >>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h | 1 +
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h          | 2 ++
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c               | 5 ++++-
> >>   3 files changed, 7 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h b=
/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h
> >> index 3cbb2fe8aba2..6671f798bacc 100644
> >> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h
> >> @@ -12,6 +12,7 @@ static const struct dpu_caps qcm2290_dpu_caps =3D {
> >>          .max_mixer_blendstages =3D 0x4,
> >>          .has_dim_layer =3D true,
> >>          .has_idle_pc =3D true,
> >> +       .has_no_ubwc =3D true,
> >>          .max_linewidth =3D 2160,
> >>          .pixel_ram_size =3D DEFAULT_PIXEL_RAM_SIZE,
> >>   };
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/=
gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> >> index af2ead1c4886..676d0a283922 100644
> >> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> >> @@ -342,6 +342,7 @@ struct dpu_rotation_cfg {
> >>    * @has_dim_layer      dim layer feature status
> >>    * @has_idle_pc        indicate if idle power collapse feature is su=
pported
> >>    * @has_3d_merge       indicate if 3D merge is supported
> >> + * @has_no_ubwc        indicate if UBWC is supported
> >>    * @max_linewidth      max linewidth for sspp
> >>    * @pixel_ram_size     size of latency hiding and de-tiling buffer i=
n bytes
> >>    * @max_hdeci_exp      max horizontal decimation supported (max is 2=
^value)
> >> @@ -354,6 +355,7 @@ struct dpu_caps {
> >>          bool has_dim_layer;
> >>          bool has_idle_pc;
> >>          bool has_3d_merge;
> >> +       bool has_no_ubwc;
> >
> > has_no_ubwc sounds kinda awkward compared to has_ubwc.  But I guess
> > you wanted to avoid all that churn..
> >
>
> Yes I wanted to avoid modifying all the catalogs.
>
> > How about instead, if msm_mdss_data::ubwc_{enc,dec}_version are zero,
> > then we know there is no ubwc support in the display.
> >
>
> hmm ... should work .... I can post a v2 with this and avoid touching
> the catalog altogether.

Yes, this sounds much better.

--=20
With best wishes
Dmitry

