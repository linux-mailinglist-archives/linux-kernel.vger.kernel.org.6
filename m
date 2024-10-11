Return-Path: <linux-kernel+bounces-360662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB26999DE0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED34128833A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5D4209F57;
	Fri, 11 Oct 2024 07:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nI1+5kLI"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B45C209F38
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728631594; cv=none; b=uatiTYMNCHwWrNrSIAzJRGLaVaQlhss9d4kOQreG2AvFOcaedZoUlrCdbLY6sR7PCgWO+2J6HI9UEIJJtOUc6XNcyfSu+yeaah0jJs7jo0oaezJZ3NIz+BF8dtuyYZqfn45CSri1zqNlPaF/y2jNRaRzFhFDPdhcupQFiAIwZ90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728631594; c=relaxed/simple;
	bh=lRxoYo3Sgxs2AlQLvFM+6v8hNWWcXGm3sNKOs8+kmEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cp4FCPK9EMX2swGRZJdedX7zvL8R3yTfglU9/y4ZImKgu6NufgqcXauQrNNMiLE/gWbKkCpCYZoL8mlEWPi8gK9KjO4vrLwniGUVOxpObSl1kkQYQuIIZ+IJ/X/MkLcTV7O7L+sOaNubyO9inq/JWR03d7uQUOGqZDYrNMKEWqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nI1+5kLI; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6dbb24ee34dso15257717b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 00:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728631590; x=1729236390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KRuCN3Wszg2QXEKCcFwbTYEij+If8Oy9RBdgkJuqDs=;
        b=nI1+5kLIppnVKxkhZu/FXj1mRSaefH1yz46xo/gVkMHEtYG7y8XUe3pYwSaV1PgkpZ
         Aks/Ua3ETfEtyCtIuUiM3flslwY4CQFyoAuJJeL3C+aurE/tk3ItJxHouIlHWcH+xn2U
         LEkXj5FkU1TEGCE8m7+jszumrww9xpOK+PRDuEcF471XAMud2h/p5VyTbrugaZhvLkmR
         tdRNKH6p/GCiN9V+V6EHcZYmJ3kItQejmQiPnL7xopyzabX3r+NNjTR32VUvoYFuVSz4
         rGErigYg/79WQ6Y64uiikbtuT0eWbe0ws7Jlp5Zaik85ZhW1iN4NzQcNSIPreucfnTrQ
         Qgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728631590; x=1729236390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3KRuCN3Wszg2QXEKCcFwbTYEij+If8Oy9RBdgkJuqDs=;
        b=bVsDxJRP7d9n9hmpiG/I4RbJ+Tfqwv6K1oXRmz+n/MrZdV7dynQCnrnvtYAtpQmS9u
         Sn83rHuyo5owv3GGCUTETmCD9Z+ogk0+5DM+BEJrIiTW7Y1syheDeMTHdLW0QApnPoJ0
         5Vv5w2eErp+V/BYpWYKtZJySitCTzvBDRwsWYQo59OGzGnKKxx+JEha6g0JxBz4k0YVj
         7fVlnfRmtbl8e0akdWYf1i32tfCxuQ/lE4/iCDWPRuAZ3MEh3iQxFSOmW6hqt9uR/8Ul
         Zd1leaV6zrvSMpmES4fAu+Lk9yTuwHNCGVlHhEetgHN5TK1YZh2K3Tc1bHBPWsn03XAI
         w6vQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaXG2Dr272cKJc7UJqqyVVUYvFK6TZNpDLbfXGRWOE8t/EWReQqW7oRn2ASoLjPI+nEEHupgP219x62as=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVwYOkigej7d353WkyRF1ZB2jM/EycA0I53FK1fljD3JLrK+ZK
	z1VBzawa9QL/nXhDxFqndll2p1GMGB2R1ARvE9M0vPQ2Hj74+xytIWBMKV6VIjoUM9CWdzroNSN
	WfQiXJ2pgDiHqHpEyx3atBtvHcBmR+EnA0CWfLw==
X-Google-Smtp-Source: AGHT+IF9yE55X6l58J3RNnrTFZtOa9ykDPuHPCDzo0nhg8NLPI4TATmILM0MbYyzUxfj5WDMeIG3jJPO6IRzkfWrDI0=
X-Received: by 2002:a05:690c:4a91:b0:6e2:b263:105b with SMTP id
 00721157ae682-6e347c4e3c8mr8932157b3.41.1728631590675; Fri, 11 Oct 2024
 00:26:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-0-76d4f5d413bf@linaro.org>
 <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-5-76d4f5d413bf@linaro.org>
 <kuvbcodnbgsgetkudbce32rajy6kg3lpxhcx6cvgm6bi7ekoki@smmnpdrwhbqn>
 <CABymUCOFV0Ze=55Ne23nKrN_4ES6cUT3_av7Q2xxtxT3Hw7ZJg@mail.gmail.com>
 <CAA8EJpqZ0X_DezzVPnWswwWoZCL8ZZJ4M-DHvUSo4qJXK6mQnQ@mail.gmail.com> <CABymUCMBQq2iGdqcSBhokDo6McFn6xc63zVrEe+2CNX_a1ejng@mail.gmail.com>
In-Reply-To: <CABymUCMBQq2iGdqcSBhokDo6McFn6xc63zVrEe+2CNX_a1ejng@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 11 Oct 2024 10:26:19 +0300
Message-ID: <CAA8EJpqqeN3A3rfT+T9CRbhhOb_gzH7SNxTNGF9uh2jwBZrwQQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/14] drm/msm/dpu: handle pipes as array
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Oct 2024 at 10:18, Jun Nie <jun.nie@linaro.org> wrote:
>
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> =E4=BA=8E2024=E5=B9=B410=
=E6=9C=8811=E6=97=A5=E5=91=A8=E4=BA=94 15:10=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Fri, 11 Oct 2024 at 09:49, Jun Nie <jun.nie@linaro.org> wrote:
> > >
> > > Dmitry Baryshkov <dmitry.baryshkov@linaro.org> =E4=BA=8E2024=E5=B9=B4=
10=E6=9C=8810=E6=97=A5=E5=91=A8=E5=9B=9B 21:08=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > On Wed, Oct 09, 2024 at 04:50:18PM GMT, Jun Nie wrote:
> > > > > Store pipes in array with removing dedicated r_pipe. There are
> > > > > 2 pipes in a drm plane at most currently. While 4 pipes are
> > > > > needed for new usage case. This change generalize the handling
> > > > > to pipe pair and ease handling to another pipe pair later.
> > > > >
> > > > > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > > > > ---
> > > > >  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c  |  34 +++---
> > > > >  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 167 ++++++++++++++++=
--------------
> > > > >  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h |  12 +--
> > > > >  drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h |  10 +-
> > > > >  4 files changed, 111 insertions(+), 112 deletions(-)
> > > > >

> > > > > @@ -1410,17 +1416,24 @@ static void _dpu_plane_atomic_disable(str=
uct drm_plane *plane)
> > > > >  {
> > > > >       struct drm_plane_state *state =3D plane->state;
> > > > >       struct dpu_plane_state *pstate =3D to_dpu_plane_state(state=
);
> > > > > -     struct dpu_sw_pipe *r_pipe =3D &pstate->r_pipe;
> > > > > +     struct dpu_sw_pipe *pipe;
> > > > > +     int i;
> > > > > +
> > > > > +     for (i =3D 0; i < PIPES_PER_STAGE; i +=3D 1) {
> > > > > +             pipe =3D &pstate->pipe[i];
> > > > > +             if (!pipe->sspp)
> > > > > +                     continue;
> > > > >
> > > > > -     trace_dpu_plane_disable(DRMID(plane), false,
> > > > > -                             pstate->pipe.multirect_mode);
> > > > > +             trace_dpu_plane_disable(DRMID(plane), false,
> > > > > +                                     pstate->pipe[i].multirect_m=
ode);
> > > > >
> > > > > -     if (r_pipe->sspp) {
> > > > > -             r_pipe->multirect_index =3D DPU_SSPP_RECT_SOLO;
> > > > > -             r_pipe->multirect_mode =3D DPU_SSPP_MULTIRECT_NONE;
> > > > > +             if (pipe->sspp && pipe->multirect_index =3D=3D DPU_=
SSPP_RECT_1) {
> > > >
> > > > if (i > 1)
> > >
> > > Is there any case that pipe->multirect_index =3D=3D DPU_SSPP_RECT_1 a=
nd i =3D=3D 0 ?
> >
> > You are converting the code. Please don't change the logic. Original
> > code had separate handling for r_pipe. After your conversion it should
> > be if (i =3D=3D 1) or if (i > 0), which means a typo in my review comme=
nt.
> >
> I see. You want to keep logic unchanged, with only handling the pipe in a=
rray.
> Handling to multiple pipe pairs can be added later.

Yes. Please never mix "rewrite" and "change the logic" together. It
complicates the review and is generally error-prone.

--=20
With best wishes
Dmitry

