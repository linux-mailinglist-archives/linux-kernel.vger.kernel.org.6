Return-Path: <linux-kernel+bounces-360610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E94999D34
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43CB51F24FAE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472BC20966B;
	Fri, 11 Oct 2024 06:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zUjWwqVD"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27042635
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 06:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728629642; cv=none; b=FIP3EpvmZN65WCnSfXBo5oUEqWIA1qrc+7yZx/kQsFmS7sigHw8zoWJMuGzLKRH1qwSBKtqrP7wqRYqk2L9evT5SS5pW8uHvK1JadvAYAcrAVgIHNPmTFHpmdj5PX8doMb7qy1UPzk7JwvgoqSnZ+31/5FgVOneP0qBxULaGlno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728629642; c=relaxed/simple;
	bh=RhOyCcD+p6NcNr11PB1lLFi9WZWY8FM8KzdFrOo0HEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KuThBhLeYlexR6oKtStZKCvCUv1E8G2wUxMjrm/tAlU8sNjbjaZusK5RFYcLSqvQ1nSRnghje4DX/PbbOx4goKrc7e8XluywjqnEnewc5EEccZnAoJ4xahC24OdsuRh70BvUog+HfxcfwPaj5IsPGLYSSdUYj4aCapFk6xzlyqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zUjWwqVD; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso1507051276.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 23:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728629640; x=1729234440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17oCjGzef/2UE8bCOde+fsQlgIs92oMXKbycZ1wrAZI=;
        b=zUjWwqVD6qxHI23mPyMI7Z1ACR1SObW3bHWlEEqIclsgKEvnz7Em9/0cl/NBHzalgN
         m3mnRwqonrl+LvCFh0sSVldtJZ9HJtuXjqCngIsS6jlfr39eDAgl76O+vPo1DXbnfAWK
         6AjRs3IbEvkycmsEsdWah6DbgvVc72jHpn2zr8zqZil6tZcV+nPl6n2LcVZghjIC49mb
         DwdCtuDGPJRQ8weWY+9U4Tnm4aMeYU9lFjE/bGtuU50Fg6AVPqYR0RGlaDzZ6e9x0Huh
         Mow0bHYcc1og4OBlDy4aa/zxaKlBRZmgglPNgXCDt5c85xWRzzPyjaoTXEvfq6w0Wu79
         wkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728629640; x=1729234440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17oCjGzef/2UE8bCOde+fsQlgIs92oMXKbycZ1wrAZI=;
        b=Kk0Ij8ZtYHNzIfLW46r1kXQBSCaoQoyvq+2NJVFI6zIDt/qYSpYmWRNtTn0IP6txxz
         5Vlm4+WsRChowHgTnsykkcZQYpTody4zYI9pn0r3A6w99clUP7AdMX+sP2vYvnsC6KjT
         vtK1porJasBA6nDXlfusKqTibDWhPgbPeHlLdtrmxiSpiVQWYqsk6UL0ElC5NN/P0lut
         g5WuVCVCyJntOrVQ92k+seX5SpVI5o5gnLPbDB1rqCz8yjBIi3PZQCBY4jQVlws1DD7A
         sAtJHYfkfe9xmpNguiYM0/268qvfOifa35DTvaoZaB5oVLwM9PdjAU6hviAqsXLuZK7n
         ANrg==
X-Forwarded-Encrypted: i=1; AJvYcCWmTAI2G+E3A3BE2HJaCIzeTAisctuDj+S9RXq/68rcSdk5oKr+qtQ4/6D6A9NZumtU98F/wyEsxy/pg2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCrawAmNxzU21fYC7n3nu1IgiV1ZX/7fW+dVJcwyqk+SZMT8Ci
	9DXFM/433vUDPCKW63gr4gPok/OCCb3n0yQFm05i2MvMhLDbME7+Vn+jz0aVXjYyOLbhXFBf55f
	V4DeM8b1Lu7mhAx4ZcOIzq9io8le23lkVDQNG1g==
X-Google-Smtp-Source: AGHT+IEcKrVhYkTlegrRYlks5vwNXkS8Zs44m1DY8Xw3QedwmulZZ7MGGC1XpVbTOaR1CUfuKx1qdvJf7YjcaChKFkY=
X-Received: by 2002:a05:6902:e06:b0:e28:e5e8:5e3d with SMTP id
 3f1490d57ef6-e2918e5e2dcmr1023240276.0.1728629640142; Thu, 10 Oct 2024
 23:54:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-0-76d4f5d413bf@linaro.org>
 <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-11-76d4f5d413bf@linaro.org>
 <olzxobeurhyi76tdn7mq3wegxth4c7a2ys7dikajkx4d5y5z7i@3vkyjy3hg57s>
In-Reply-To: <olzxobeurhyi76tdn7mq3wegxth4c7a2ys7dikajkx4d5y5z7i@3vkyjy3hg57s>
From: Jun Nie <jun.nie@linaro.org>
Date: Fri, 11 Oct 2024 14:53:49 +0800
Message-ID: <CABymUCO0u8hOLtie7typUQ3XV4AAds3RhT_hF23WB5Ruiz9AnQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/14] drm/msm/dpu: Share SSPP info for multi-rect case
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dmitry Baryshkov <dmitry.baryshkov@linaro.org> =E4=BA=8E2024=E5=B9=B410=E6=
=9C=8810=E6=97=A5=E5=91=A8=E5=9B=9B 21:21=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Oct 09, 2024 at 04:50:24PM GMT, Jun Nie wrote:
> > Share SSPP info for multi-rect case if virtual plane is not enabled.
> > Otherwise, the 2nd half of DMA content is not displayed due to sspp
> > pointer of r_pipe is null.
>
> Fixes?

Yeah. It is to fix bug in non virtual plane mode. Do you suggest to split
to another patch set?
>
> >
> > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > ---
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/dr=
m/msm/disp/dpu1/dpu_plane.c
> > index 904ebec1c8a18..898fc2937954e 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> > @@ -1042,6 +1042,11 @@ static int dpu_plane_atomic_check(struct drm_pla=
ne *plane,
> >               pipe->multirect_index =3D DPU_SSPP_RECT_0;
> >               pipe->multirect_mode =3D DPU_SSPP_MULTIRECT_PARALLEL;
> >
> > +             /*
> > +              * Signifies that r_pipe is to be used if the width of th=
e 2nd
> > +              * pipe is not 0. This does not apply to virtual plane ca=
se.
> > +              */
> > +             r_pipe->sspp =3D pipe->sspp;
> >               r_pipe->multirect_index =3D DPU_SSPP_RECT_1;
> >               r_pipe->multirect_mode =3D DPU_SSPP_MULTIRECT_PARALLEL;
> >       }
> >
> > --
> > 2.34.1
> >
>
> --
> With best wishes
> Dmitry

