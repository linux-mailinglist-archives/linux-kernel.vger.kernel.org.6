Return-Path: <linux-kernel+bounces-535455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2696A47318
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 03:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0383B165AF8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E83814D43D;
	Thu, 27 Feb 2025 02:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jxcFJSZl"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D4F270036
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 02:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740623839; cv=none; b=LKq1SQIGnXZzvdITpt9YjsrjI4LkODgEy3Qa+Vg3X/0JCoBDNngB8BAAftOgdd3gYWj5MtKsqeqMNf4HKtGlBQviZFTkLZAWr/TMZOuPA2X8G1a57BnAtQa+bIXp1G20KS2XCe8G82nKNIBVYOkZKdBIRgXNUQrbBhzQO4trTP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740623839; c=relaxed/simple;
	bh=1aZdARq/05akDVNrrnIv2omWGAC66gwQQ+XGXmNHV/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kM+CQ7UoBzjaTLjlihJp9cwvwy48sChSfiLMkjVUMNHjLZYFWMHOarJVXiv+6TDT8LavLPJLedDlaEwXKuFEo1O7JQPsLOxpZHZcWGhZ6YYuy4t8xOBYwuqkQ2KogLXeLvMwLup34QeTQZaKpjJoUxnKwLlw+QzyAaBfdLHQZPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jxcFJSZl; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6f4bc408e49so4382927b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740623837; x=1741228637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2/JikIOXuq+9YZgvX/I0sOxCDWRqOTZNtQmLEPFnPo=;
        b=jxcFJSZl6z8fGdRT2porIfYDggnpsL7VMVBzeWsLqD8jde/dk9Z4WfDPi1jtnTg7QM
         +QExUQ1yLnG45yGT3EwFI0iiUqAVn0zWMWEh5RlELtBSxZitoF5TLW4YvWG8HD6kV4M7
         GhaHgBUf0MH86VZ5s7u6/xDPxj26Kjr3Jn37JUJjUBYhW76/itjzotBKkkvOlg1xelJj
         JPG/ab6RBfqab5fHGHvJXOcC3k+iUfGUv5Cc8vmvQxAhrrazIkjMQeELPH5ltzKoij6C
         wTBJ9zEH4THhzXUT7fvyQes9Yxz5FK99MrLxd3POXeHt2STp4I+0Bv6JMNs+RWVOPZia
         aedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740623837; x=1741228637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2/JikIOXuq+9YZgvX/I0sOxCDWRqOTZNtQmLEPFnPo=;
        b=vzlazfe4nVYF/0Uyqg+9tNChfAc6HXCbFPnA4ztlTTrJhIBfB0W3+7Gj2hTwhhlbtc
         Xg990lSsx7tu4slY6ObFgnxKDK/fDw0aIlmtLaDQ58kArr+LUXwWA7zuGu5hT1BOJf6f
         x30/R9A1Y9AN9D348cXI3CRb6sidAoAYen8tz9cvQ11NqiTEif6qOQv+KLQ4BKyA/Hso
         CtCAZenYKDBJRm6dWPCZnltMn3y785WL3rhMNjx/quqaI0XCl3oYsYFHq4QXUVYEZ40N
         HrsOzEBUUe/h8EIbNUFKRrdze33MPg1H4qj4pDPXKW4jcbDW6AwzJCyVTmkJvz4N32JL
         wXgA==
X-Forwarded-Encrypted: i=1; AJvYcCWjt2nDSuOOCbGZPSSKeTSRgOZrawP+BzPJAI5UF5xlbkiErfNizhHKR6V2GX5Q7DHboFtKYf+YXsdTics=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFEBPmeewyn2YwzcPhRwub5BYbxUn5xVjV0Y6CQfwQIgTmd1Kk
	9dG8TvjWslMvmk3DZ2A2dpkrraV46lI/bN2SXDZ4wbrYEhao2rH7NpRyKU+nIosoSCJCDU/SZ9/
	TiIf7LnAklw1Jx6WwdKnU/QkhABNv8Zten5dhQg==
X-Gm-Gg: ASbGnctTp653b/ix9tlgq6PP9orUsMEICuoUQt7kdr6ODi3L9RZIMiOgqgrrnNsMGhD
	5np9OMf5SmhiZ0kqDIFvw8kI9uxkw0bCZtABpZaKGh+xzvUFxRX+Y/m/HM9GvElzFEGeGapRsoU
	RVdqd0FalZt6qf
X-Google-Smtp-Source: AGHT+IGSw0gtdKcK4e/gjlWOJp54+6uLHAkVBNTZI2SEuatfi8tmEUqUfZLol5dS7eJGj3x1CROAqXjTXvG9Xlr25R0=
X-Received: by 2002:a05:690c:4512:b0:6f9:ac35:4483 with SMTP id
 00721157ae682-6fd2207a924mr52773417b3.25.1740623837083; Wed, 26 Feb 2025
 18:37:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v7-0-8d5f5f426eb2@linaro.org>
 <20250226-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v7-11-8d5f5f426eb2@linaro.org>
 <f7a1a1ef-bab7-4024-bfca-a9fa33f189b5@quicinc.com>
In-Reply-To: <f7a1a1ef-bab7-4024-bfca-a9fa33f189b5@quicinc.com>
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 27 Feb 2025 10:37:06 +0800
X-Gm-Features: AQ5f1JpajceI_JjtWnScexhP25AZZx5gURBP9Id9s4kjX02P38LidJgsE8Muoks
Message-ID: <CABymUCNgwWf8cvNB0thWP3AmHYK5WDv9AwyhhE1q5X7sYCArsA@mail.gmail.com>
Subject: Re: [PATCH v7 11/15] drm/msm/dpu: split PIPES_PER_STAGE definition
 per plane and mixer
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jessica Zhang <quic_jesszhan@quicinc.com> =E4=BA=8E2025=E5=B9=B42=E6=9C=882=
7=E6=97=A5=E5=91=A8=E5=9B=9B 09:38=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 2/26/2025 4:31 AM, Jun Nie wrote:
> > The stage contains configuration for a mixer pair. Currently the plane
> > supports just one stage and 2 pipes. Quad-pipe support will require
> > handling 2 stages and 4 pipes at the same time. In preparation for that
> > add a separate define, PIPES_PER_PLANE, to denote number of pipes that
> > can be used by the plane.
> >
> > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    |  2 +-
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h |  1 +
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c   | 14 +++++++-------
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h   |  4 ++--
> >   4 files changed, 11 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm=
/msm/disp/dpu1/dpu_crtc.c
> > index 193818b02197d0737c86de7765d98732fa914e8e..81474823e6799132db71c97=
12046d359e3535d90 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> > @@ -463,7 +463,7 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_=
crtc *crtc,
> >               if (pstate->stage =3D=3D DPU_STAGE_BASE && format->alpha_=
enable)
> >                       bg_alpha_enable =3D true;
> >
> > -             for (i =3D 0; i < PIPES_PER_STAGE; i++) {
> > +             for (i =3D 0; i < PIPES_PER_PLANE; i++) {
> >                       if (!pstate->pipe[i].sspp)
> >                               continue;
> >                       set_bit(pstate->pipe[i].sspp->idx, fetch_active);
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/=
drm/msm/disp/dpu1/dpu_hw_mdss.h
> > index ba7bb05efe9b8cac01a908e53121117e130f91ec..5f010d36672cc6440c69779=
908b315aab285eaf0 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> > @@ -34,6 +34,7 @@
> >   #define DPU_MAX_PLANES                      4
> >   #endif
> >
> > +#define PIPES_PER_PLANE                      2
> >   #define PIPES_PER_STAGE                     2
> >   #ifndef DPU_MAX_DE_CURVES
> >   #define DPU_MAX_DE_CURVES           3
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/dr=
m/msm/disp/dpu1/dpu_plane.c
> > index ef44af5ab681c8f526333fa92531a2225983aa09..d67f2ad20b4754ca4bcb759=
a65a39628b7236b0f 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> > @@ -1078,7 +1078,7 @@ static int dpu_plane_virtual_atomic_check(struct =
drm_plane *plane,
> >                * resources are freed by dpu_crtc_assign_plane_resources=
(),
> >                * but clean them here.
> >                */
> > -             for (i =3D 0; i < PIPES_PER_STAGE; i++)
> > +             for (i =3D 0; i < PIPES_PER_PLANE; i++)
> >                       pstate->pipe[i].sspp =3D NULL;
> >
> >               return 0;
> > @@ -1129,7 +1129,7 @@ static int dpu_plane_virtual_assign_resources(str=
uct drm_crtc *crtc,
> >       pipe_cfg =3D &pstate->pipe_cfg[0];
> >       r_pipe_cfg =3D &pstate->pipe_cfg[1];
> >
> > -     for (i =3D 0; i < PIPES_PER_STAGE; i++)
> > +     for (i =3D 0; i < PIPES_PER_PLANE; i++)
> >               pstate->pipe[i].sspp =3D NULL;
> >
> >       if (!plane_state->fb)
> > @@ -1241,7 +1241,7 @@ void dpu_plane_flush(struct drm_plane *plane)
> >               /* force 100% alpha */
> >               _dpu_plane_color_fill(pdpu, pdpu->color_fill, 0xFF);
> >       else {
> > -             for (i =3D 0; i < PIPES_PER_STAGE; i++)
> > +             for (i =3D 0; i < PIPES_PER_PLANE; i++)
>
> Hi Jun,
>
> Is there a reason why only this case was changed to PIPES_PER_PLANE but
> _dpu_plane_color_fill() only loops over PIPES_PER_STAGE?
>
> Similarly, I see that dpu_plane_danger_signal_ctrl() also only loops
> over PIPES_PER_STAGE.
>
> Thanks,
>
> Jessica Zhang
>
It is missed and should be converted to PIPES_PER_PLANE in
_dpu_plane_color_fill.
Thanks for pointing this out!

Regards,
Jun

