Return-Path: <linux-kernel+bounces-233503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DF391B866
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360A51F22DF8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 07:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5869F45009;
	Fri, 28 Jun 2024 07:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GTUI6AdO"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D014E7E785
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 07:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719559882; cv=none; b=j8qwS8dwgvGKHsCxw88Qo63Bj1CzVu7UezBntFu/BICsfH5ZUNCJdI7p9HobCDF1dwhQHZ6H54CoZUQxGm4EbOS2xi8pbKBI0Mv5m5m8cdvgj2RX15HrvrUv/p3vHNShnmADO/51IHGvQLGIO+KMoEJZdf4WHQ4hZnMNV03yFgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719559882; c=relaxed/simple;
	bh=WHA3NFm9AbJmBCKC+rOG8HLFgAgyO/vkhfBB5Vrm0b0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+Pnweq4NPSJQuQZk0HDMf+W1Ks/4NGYcjGqoR51FOHsKB889uwMOVSszn67dXYi/ZrONs4GgZRaRtNe/xOeKvkifOx4NAx85kBgyW5o/CY8H/y/burncbHO4+kBgJq40RIUCMHgfwNsvnTrF7vY/avoDK3GE7yFE4pMwSQmbTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GTUI6AdO; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-642035f8c4eso3134197b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 00:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719559880; x=1720164680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YC2vL0ngu+VabJtGh1zVsPqyy5eHSHNms/TBgq3e8Yc=;
        b=GTUI6AdObeOgRpXMWKauSAVb6hZD1mBBkC5kg8TXQZBAro/DWV6HWKdJnR/UWTaiPm
         r8AaswwNlox/h8rpWbvWQEZNhFQVapjLfCwoAX4LPFUV9I6HYKAL7d1CftbLHBN+Ymf5
         PB9+MIF5aB5UNjREkjxEoDKek4FdkK9yQ7j/CcPHUU6gpm8EtW2WZT1pDvlQlFMCkzLI
         B/In2COCfWsqADh/F3GzOf4oQ1U/568dbNYL+NUM3fXgx1Yv1ksoK2zmHPjbB4HS5TG/
         3Ct5vEwVabPdwnukBGQWoEyK4Pz+B+jNrNueeL+no1Gwkje1RIqXmwhYUBKhxd9w2kCe
         RNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719559880; x=1720164680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YC2vL0ngu+VabJtGh1zVsPqyy5eHSHNms/TBgq3e8Yc=;
        b=TgeaO97UWP3S+WgdONWC53WpjXiJxQXtGXvbSIaflrW+Yijyh82iVUamOHikgBMLzk
         OqTMY7nO0IGtBvQlqAUKO95ynWZ8VuVTjpyAv4NC4gIUO9VP2essNtnYuWvfOiFPPe10
         WclHpp2HlshfOOr/m82y1RZjOcMmDalmYPTQYDV2qNKa2oMhXZjua/Z5LP290K8LbKOl
         ymDr0i2gBN9qZQF97f6sz8hkRumjqtFaeYRraJTQvZoy3DYWtgNVAapbl6CjLqSPL+bv
         gk/85wULhc8+RJhftVrnFXhU7xqBfiuMd/0tcMDJjForXhAHXdj3JHiuZY7JdY870sjm
         x8gA==
X-Forwarded-Encrypted: i=1; AJvYcCVgPfJR7YiQBBV5E4svLIwUWO0mCFVpda8t0ntSnoYXPOCAqe0izkV6/h+IkBHG4zDK8voQkOkVuu+dY9j3ZxMAI3mwxan1yDMnwUux
X-Gm-Message-State: AOJu0YwCTd7eT42wwoh5NyN6eRolQVzSb74j7b5DcmpcXcT4S762f5gq
	U3PYeuk6SBbfeN2QeqTIcuUS6ulczk3d77B9Jj+kBx2eIAJUgt361eowZ3WIq8Ut1++FEnLozWy
	wQdbLttx+i3Uz2dhscIq1NxIU/boOOFnBR1cCew==
X-Google-Smtp-Source: AGHT+IG7e3Nr80WUtusNzOc09aLXt6sidhbn4QxSDEczeY6o412AgaGYOcgxZvP1ziiQ2oQuPobDDT3ETxOmxZUGw+4=
X-Received: by 2002:a05:690c:805:b0:60a:448:ff4f with SMTP id
 00721157ae682-649c56c39demr38634787b3.41.1719559879818; Fri, 28 Jun 2024
 00:31:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627205328.2912859-1-quic_abhinavk@quicinc.com>
 <CAF6AEGuGYG5mO-4KdNFbQFMA4dKj2PWT22xeh-3AFgedAG0uHw@mail.gmail.com>
 <3749ac14-54d0-fb62-345b-cef62399b6d4@quicinc.com> <CAA8EJppM1429sGzW6hq4QzLEjVX5Cf+8Jt5y94+VocFmPyxz+Q@mail.gmail.com>
 <19c49c3b-057c-ce83-1ec6-4929676ff0e7@quicinc.com>
In-Reply-To: <19c49c3b-057c-ce83-1ec6-4929676ff0e7@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 28 Jun 2024 10:31:09 +0300
Message-ID: <CAA8EJprr+sX2CqdZTUA4R0scQqY+-D7gy3dmY85DoR6oeL=OnA@mail.gmail.com>
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

On Fri, 28 Jun 2024 at 08:44, Abhinav Kumar <quic_abhinavk@quicinc.com> wro=
te:
>
>
>
> On 6/27/2024 4:22 PM, Dmitry Baryshkov wrote:
> > On Fri, 28 Jun 2024 at 00:21, Abhinav Kumar <quic_abhinavk@quicinc.com>=
 wrote:
> >>
> >>
> >>
> >> On 6/27/2024 2:13 PM, Rob Clark wrote:
> >>> On Thu, Jun 27, 2024 at 1:53=E2=80=AFPM Abhinav Kumar <quic_abhinavk@=
quicinc.com> wrote:
> >>>>
> >>>> On QCM2290 chipset DPU does not support UBWC.
> >>>>
> >>>> Add a dpu cap to indicate this and do not expose compressed formats
> >>>> in this case.
> >>>>
> >>>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> >>>> ---
> >>>>    drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h | 1 +
> >>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h          | 2 ++
> >>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c               | 5 ++++-
> >>>>    3 files changed, 7 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h=
 b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h
> >>>> index 3cbb2fe8aba2..6671f798bacc 100644
> >>>> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h
> >>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h
> >>>> @@ -12,6 +12,7 @@ static const struct dpu_caps qcm2290_dpu_caps =3D =
{
> >>>>           .max_mixer_blendstages =3D 0x4,
> >>>>           .has_dim_layer =3D true,
> >>>>           .has_idle_pc =3D true,
> >>>> +       .has_no_ubwc =3D true,
> >>>>           .max_linewidth =3D 2160,
> >>>>           .pixel_ram_size =3D DEFAULT_PIXEL_RAM_SIZE,
> >>>>    };
> >>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/driver=
s/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> >>>> index af2ead1c4886..676d0a283922 100644
> >>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> >>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> >>>> @@ -342,6 +342,7 @@ struct dpu_rotation_cfg {
> >>>>     * @has_dim_layer      dim layer feature status
> >>>>     * @has_idle_pc        indicate if idle power collapse feature is=
 supported
> >>>>     * @has_3d_merge       indicate if 3D merge is supported
> >>>> + * @has_no_ubwc        indicate if UBWC is supported
> >>>>     * @max_linewidth      max linewidth for sspp
> >>>>     * @pixel_ram_size     size of latency hiding and de-tiling buffe=
r in bytes
> >>>>     * @max_hdeci_exp      max horizontal decimation supported (max i=
s 2^value)
> >>>> @@ -354,6 +355,7 @@ struct dpu_caps {
> >>>>           bool has_dim_layer;
> >>>>           bool has_idle_pc;
> >>>>           bool has_3d_merge;
> >>>> +       bool has_no_ubwc;
> >>>
> >>> has_no_ubwc sounds kinda awkward compared to has_ubwc.  But I guess
> >>> you wanted to avoid all that churn..
> >>>
> >>
> >> Yes I wanted to avoid modifying all the catalogs.
> >>
> >>> How about instead, if msm_mdss_data::ubwc_{enc,dec}_version are zero,
> >>> then we know there is no ubwc support in the display.
> >>>
> >>
> >> hmm ... should work .... I can post a v2 with this and avoid touching
> >> the catalog altogether.
> >
> > Yes, this sounds much better.
> >
>
> Ok, does this qualify for a Fixes tag too? Because exposing ubwc formats
> on non-ubwc supported chipsets seems like a bug.

I think it does.
For example, I've also added Fixes: to the patch disabling YUV on qcm2290.

--=20
With best wishes
Dmitry

