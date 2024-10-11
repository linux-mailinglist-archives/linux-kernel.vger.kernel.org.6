Return-Path: <linux-kernel+bounces-360613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23396999D3E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84950B24007
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4126A1C1ABE;
	Fri, 11 Oct 2024 06:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Se78b/Fl"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAB419923C
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 06:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728629758; cv=none; b=gqzjgwdoPlC1VOmuk64QwCyb4BtDiJ0fPsJBJm7ZiRzNOBaxKV5YN0EhzoaykckSKwRYQda85dP9D/KoOTUEpkorwm+zs+ZNOTN4LFrIUqZ8a0pyeGuMqMCGcW32aaIuMe1phGis00Aniqm15eAq2bHyloNSf5ifmxHXtgA2hYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728629758; c=relaxed/simple;
	bh=WvPnWHW6EM58Oqe1lVFDfz/QoUAYQ2cItZ0U1ItXlhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vp1lAbvwYUc5/eBy6BIXu5JG9HbasPHjWkZ5vaSvoaMiLsIA5INUDsVw1VueVcVzT5oFWGq4IE28rVgBiadS2EOyuEAVtKUxusGot8ctVKpR5owPYJSfvBX+VKQ8SdVbasjBAKIRcEAeXucKpR5WlLKgMfYPtchi1AsJaRsvLJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Se78b/Fl; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6db836c6bd7so16583837b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 23:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728629756; x=1729234556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=leCB05U0kuVzNJlGaNnlHWm3c19kiX7kkCoAs5xAlbw=;
        b=Se78b/FlHbuxHbH6EveZgvG9BynskMK2h6rTNpglq2xsWulM04Sqd7hJpsDatMVtQ9
         mUkAg7srRg0tOPQVr9DJDhv0UezQ90ItK2kYVMki7yop12B+H2y3Wid2OSZHCzeagbGL
         HgiiPnM4vjsN7xLvlvPX9AGVYYjOPXchixI1JuOCij+VOLamG+EBjZ4mJrKRabXfronw
         Bq1W8CwBaJhWx2HO/wahLlj958nPnmBVntZbSnXSLTXm4ZNpaJnAXmP6MglX9NCpdJC+
         3vqz3Ja+Q4wxE6aUe6dD4bdEsVgou8S0ORcuKYZOaZWsV4h223ylcyYOqS1hz18dUlSJ
         IQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728629756; x=1729234556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=leCB05U0kuVzNJlGaNnlHWm3c19kiX7kkCoAs5xAlbw=;
        b=FizzbsmV9Ps9LC7NFvfpZN8vS0PTckuCQ0w+EMewELr6bzSwvFpATGIdAVjZvzeEP3
         iUyOnAX+uALufPpqH2N7MQpD/JutOd9S3Cx99FzmVkO4EcoU+S4Qy+OVoqrEdakGpOwY
         /pCK4y6gAUpzMtttVTnVuvyg592rqV+326VtWVnP4uyqLonG0FkfsL9tOhYgX0efs1jK
         r2A6YMoGv2ZM/lVnKZtmDxOysHlldXdlTObBBkOHyIdyMmauYMOcDmhWaYNp8BcEwqER
         wFl330RV3VxVST8VJApFHcuyU/KrvR2GTaXuM6fSrj7M8HiPcTrOErJ8sQfaT2shfoAW
         N2cA==
X-Forwarded-Encrypted: i=1; AJvYcCWlvM/8ozOHqclts2lCW9o8e7a5pL8iTxz2qDcgCQsX7bm8L8l507qvoReNRiLCNqzVbmdeZcLN9ot3PNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzP/Fl1fZ5msaJcviisp1nItR2MR0vOdJYFDhKX1Ue4DICLkTH
	/M8vS98YDcpReXidL1Z7ns2gDESZVPHUWZ+lWLKfBbPnezeETcsMVsacdQ3foWmbPg7/CgT0d4W
	PBnAOobI+p0YeqbMArxq9HJ5Xtka+l0DSqtDVNw==
X-Google-Smtp-Source: AGHT+IH5YCiYsZRowEZPmtFGdrbCCLKiOnoDuw8fJ58ZsrP+V7juvFxX6T6bpQgDnFc1GnkYDzMRc7XK1/rJE9iA3fs=
X-Received: by 2002:a05:690c:fc3:b0:63b:f919:2e89 with SMTP id
 00721157ae682-6e3477b9bbcmr12907577b3.2.1728629756126; Thu, 10 Oct 2024
 23:55:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-0-76d4f5d413bf@linaro.org>
 <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-11-76d4f5d413bf@linaro.org>
 <olzxobeurhyi76tdn7mq3wegxth4c7a2ys7dikajkx4d5y5z7i@3vkyjy3hg57s> <CABymUCO0u8hOLtie7typUQ3XV4AAds3RhT_hF23WB5Ruiz9AnQ@mail.gmail.com>
In-Reply-To: <CABymUCO0u8hOLtie7typUQ3XV4AAds3RhT_hF23WB5Ruiz9AnQ@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 11 Oct 2024 09:55:44 +0300
Message-ID: <CAA8EJpoioJ1CzeO0mwbQYJWBK0f1RDv-XZ2J7tX0N-Auf5JG2w@mail.gmail.com>
Subject: Re: [PATCH v2 11/14] drm/msm/dpu: Share SSPP info for multi-rect case
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Oct 2024 at 09:54, Jun Nie <jun.nie@linaro.org> wrote:
>
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> =E4=BA=8E2024=E5=B9=B410=
=E6=9C=8810=E6=97=A5=E5=91=A8=E5=9B=9B 21:21=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Wed, Oct 09, 2024 at 04:50:24PM GMT, Jun Nie wrote:
> > > Share SSPP info for multi-rect case if virtual plane is not enabled.
> > > Otherwise, the 2nd half of DMA content is not displayed due to sspp
> > > pointer of r_pipe is null.
> >
> > Fixes?
>
> Yeah. It is to fix bug in non virtual plane mode. Do you suggest to split
> to another patch set?

No, I suggest to add Fixes trailer and to move fixes to the top of the seri=
es.

> >
> > >
> > > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > > ---
> > >  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/=
drm/msm/disp/dpu1/dpu_plane.c
> > > index 904ebec1c8a18..898fc2937954e 100644
> > > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> > > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> > > @@ -1042,6 +1042,11 @@ static int dpu_plane_atomic_check(struct drm_p=
lane *plane,
> > >               pipe->multirect_index =3D DPU_SSPP_RECT_0;
> > >               pipe->multirect_mode =3D DPU_SSPP_MULTIRECT_PARALLEL;
> > >
> > > +             /*
> > > +              * Signifies that r_pipe is to be used if the width of =
the 2nd
> > > +              * pipe is not 0. This does not apply to virtual plane =
case.
> > > +              */
> > > +             r_pipe->sspp =3D pipe->sspp;
> > >               r_pipe->multirect_index =3D DPU_SSPP_RECT_1;
> > >               r_pipe->multirect_mode =3D DPU_SSPP_MULTIRECT_PARALLEL;
> > >       }
> > >
> > > --
> > > 2.34.1
> > >
> >
> > --
> > With best wishes
> > Dmitry



--=20
With best wishes
Dmitry

