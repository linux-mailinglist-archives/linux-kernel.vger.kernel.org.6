Return-Path: <linux-kernel+bounces-312406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1957D96962A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA3F02817C4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3267200101;
	Tue,  3 Sep 2024 07:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AOYiAwhJ"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6191D54D3
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 07:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725349990; cv=none; b=BXcAz0rEZ/O0WUDE+xUcYxgxBqynqzUcBzAM//IXnnXNTVhudxmBx7w3WGMvLuijkbr05xLwOjlHBT0QZn0GIzN70W4DAEmk3zgTLDUQFS8aGNz9iKcJMlZyNvca1Osd/3pRI/CRLeMMgvLRX4M85j3nI8sdRQVVkwA/ePdRpJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725349990; c=relaxed/simple;
	bh=Q+meUPQ2T+KqITVVfESzYw7tB9BneCHj1cK2KpeDTqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ctD6Na+A7wlt5ysi8Kv9UXa8IM82g0oJY+5iwKjQHftnpcZIQzmM43mApbC6s9gMR8RfQf7r5+Rr5TxeKUDMroVfmG57oABAmu8vt6LTz0rv5kIGER1mFtYm97+qKtAVL29vYaudqPqoffY5WKSl8i/QBJwiXn2wCKwuCCaw6fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AOYiAwhJ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-533461323cdso6284643e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 00:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725349986; x=1725954786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DiVkizWabhW4BL7IbVoWILVMwDmACqtcboQ3xYY4DBk=;
        b=AOYiAwhJ4oQssrETxNqznBU+jjuC0gJxbEfwpXpotmoRxGZaNdfmjhiBm3pyOi9SL4
         i3nno1ViOW+J1WSpnSlxK87YPibUmU9NV+vlEmv0aaC6/oU9mb/joorLPVtZJwdITxY6
         09kj4QSFudoeM94GjF47KI7TV8bf/PEoHmyc9kcw5a7apv0Wwhy7UpbgudhauKmPZBGx
         81K8NZo/q/F2+FhcQbnArYqBfqFySI5A1G5acU7GCRZQTgR/FAV/I0Smzqx0JUDAaYGE
         IzEN5UjsZ8vD85m1GuB/YNABmhUh5cyexBnwD7bu8y3kGfV5h8UtHhP74gd1T4rejh0d
         BGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725349986; x=1725954786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DiVkizWabhW4BL7IbVoWILVMwDmACqtcboQ3xYY4DBk=;
        b=tTQ/cK7KPhj9jD/2zzMGXApiF8Q+VaZk6q+3DtxNl+lkBHFe+DU/XmfjkK+huaSTRw
         RWYjmsQy9rXvJsmKnusa+0kLYejU3Z07ouZd3Yu6o1dq/nqziyPjOWXvwy6FNSL3JWJ0
         FBCMWCWeU+GjtVq9aoZ0aj6TZLgx/IhP2Osgtsef+OgNYQui3HMv/ko2Ig3JPkHsX1Yk
         xsYQOs1iQt1EjEq/EETTf4YxRy2pz2zNzTvp7Bt+DA1rpAiA5UZVRgNM61PPVZtAEtxE
         Y7bmFiyXcnEStZtiaYCTj8iZugmv25dsNOKJxoTi9Lry9jTy6TC+XEwMjTe9Mn5bNUbK
         3Jog==
X-Forwarded-Encrypted: i=1; AJvYcCVz5mVc7pKObR1oAikLjG9rWc4pieuLCuqr4eX2g8Va2f3GXBID2d/PcZ1pWLHeRasfJHrwOJRkm+nN/vQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA0vq8D2qx1oXYYRcE6uowfMX5qOhJbO+KAGAuBstZrPkyLVY7
	pBdMTwslVW+ttrS1M94ajOWfVJ8Z4qiAgDq1WxxR+EIr/zqvGLOtKIxHcRqMefMdajDLABL9Ee4
	ZplddRIysejzz2FkuwMjQeKvYWOYrZmf5XWaOjw==
X-Google-Smtp-Source: AGHT+IH1q5Z6V/0gz6i1XwUHY5lw0kjrgLo7e/m69HtmgNlP0Tr4SSEr2P/btmdUC6xBDN4Zm7O5IJeNrckeE0iUpyI=
X-Received: by 2002:a05:6512:2206:b0:52e:7448:e137 with SMTP id
 2adb3069b0e04-53546af928amr9748127e87.6.1725349986272; Tue, 03 Sep 2024
 00:53:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-0-bdb05b4b5a2e@linaro.org>
 <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-14-bdb05b4b5a2e@linaro.org>
 <CAA8EJpp5TwzCZ6bpQQzzVBpEwhi28s-fX9wwOtrasCAGDBdykA@mail.gmail.com>
In-Reply-To: <CAA8EJpp5TwzCZ6bpQQzzVBpEwhi28s-fX9wwOtrasCAGDBdykA@mail.gmail.com>
From: Jun Nie <jun.nie@linaro.org>
Date: Tue, 3 Sep 2024 15:52:54 +0800
Message-ID: <CABymUCOWXUMgA-x8z3DonANYnUqTyJYgoekXTxALK05ihE+tGA@mail.gmail.com>
Subject: Re: [PATCH 14/21] drm/msm/dpu: Support quad-pipe in SSPP checking
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
=9C=8829=E6=97=A5=E5=91=A8=E5=9B=9B 19:38=E5=86=99=E9=81=93=EF=BC=9A
>
> > @@ -1033,13 +1030,10 @@ static int dpu_plane_atomic_check(struct drm_pl=
ane *plane,
> >                         return -E2BIG;
> >                 }
> >
> > -               /*
> > -                * Use multirect for wide plane. We do not support dyna=
mic
> > -                * assignment of SSPPs, so we know the configuration.
> > -                */
> >                 pipe->multirect_index =3D DPU_SSPP_RECT_0;
> >                 pipe->multirect_mode =3D DPU_SSPP_MULTIRECT_PARALLEL;
> >
> > +               r_pipe->sspp =3D pipe->sspp;
>
> NAK
>
I do not understand what's your point here. If multi-rectangle mode is
used, the 2 sw_pipe share a
SSPP structure. Otherwise the right half of mixer pair does not work
and no display on that side,
because there is no SSPP to handle in r_pipe setup.

>
> --
> With best wishes
> Dmitry

