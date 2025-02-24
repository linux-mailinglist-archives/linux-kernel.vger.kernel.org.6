Return-Path: <linux-kernel+bounces-528669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC072A41A7E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 288A61889879
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BB524BBEE;
	Mon, 24 Feb 2025 10:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fQJNwoaF"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75BB24A075
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392076; cv=none; b=aN0AquRvb6I27+FSgyupyn/0/o5+gfu9ROYSc7J1xr88B1x33SjF34juMVBwL0PfkG9xQyAwYTQUfB1qzLwMQkfznTrMkDmAfmSs/yDVqlH99rfQ5IKOw7T6gtgqiREaPpJDA10LRbUlosDtkGbjTxyQ8+5PpfnRecBMB5hr+Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392076; c=relaxed/simple;
	bh=vbjKASiWXzboA2sZA1rLnu3UzF7hoa5908pNhKGfpXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3vV58zmOZpR5R5XOp4ZQnx2gRj6ukgxCX7c7lVbxz28FTcbusSY7kYkovr7DNiBXUgK+8/BG6NeFj/IX7QGsxqpq+Hel216lfDPV0bjw0jHd2iqfUbPNoDEhvsW1JuVW672KkLgU3ZL51zfD60feloBFvad0So8gtKBdVxzIiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fQJNwoaF; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6fb2a6360efso28357547b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 02:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740392074; x=1740996874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BT21T9ZsOx2rQl7hC4pSS3NJ3nW+q3IUFkB1OpRZPQ=;
        b=fQJNwoaF2n7ZkLJm4NiIAQcXapgeTSRhho3norCqkAUZSZekUqRfdWNVRiipkshIIm
         Nsi6evZXtCm1wjx93kyjMdsN2CxxJmY41/4FndnzGP4Krn2MkxTsL5FM6UE/yuU8OSl7
         Pv14k9nN2fsmnzjbQMhiCFwR4B2QTaJTBcISqrYov9WP0Pz2VjiuG4UZJLR54vB/KjTK
         s8i5ob9A2+9MQSHLa9ghsrrW9JyzNkCyZs4LhsQMBOnRLLNU/SFfV3KVDImNmUyBpOzV
         TnVs1ENLImOJaNNljMp4zbCcVmG48ZCE/xD+sI8+u2bIFyWS9r5/I234bdovIE0I2ILr
         u04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740392074; x=1740996874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7BT21T9ZsOx2rQl7hC4pSS3NJ3nW+q3IUFkB1OpRZPQ=;
        b=qzPV9V2qD/b+gkG4f0UEtuKlZPdPbE5XWShL2jU7gkvd8DgC2CTr4pct/moNkCQzYM
         +fL5g8BsaMiwPpUIU4GRmJF9Ip/1pdpZJPSgo6iv6C0E8/HycE4gOFrCMA3iTf3qwgcL
         bgvz9kaJ5EAwKIfa43owMNHguIUqgV8d4DXHaV7p2eqQwWL5PPsz6vCdWIbYCj6hg9Ou
         NizsKewuOu8aZtN/lzdLl0B8qzZi3c4pr1mZ+ANhPKmHL0Lrx4ftRAD9uWInDowDla/y
         iwlpjZJL3NkHa/dVXF2av9R3qpo+aRqrKPwB1TiMnj9xk8n/WQzubfx0SjDrEdESdrHC
         ax+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKYVGXKOp4+XXqzXCjW8NH0Kq3o7Ry1pKlX/Q/GI3tJcO38Fq5ukqnlljaECFt4KTR2R/Num75emQVhGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ2iS2HRccCWMJZ7FTukb4+xqdwChBm50qu9I9hSmK/MbCjC2N
	LamLciaFYFQjJUjkFdQUu2TRZ2C7sr9yX7Iy5OUjvmsXmzCjX2z5TTzygXGVmj82QTqX6bZiDYe
	OstxvcPUwdHMNMDVb81YX2/fyCYL6ZIuSpI5iWg==
X-Gm-Gg: ASbGncsr2bpSjDLqyImT4gGRWlQg3r97qRf+V1jTbS4nM5+BHBZTwB1IybECJeDx6Lr
	uewETXnfxULdBiomZzBNc/zJ733g+B6y5RWE2bO7DDmHsePaCADJ7sHACIAZXAIlJB2T4toFGPA
	KkiAX8W7DsdvPC
X-Google-Smtp-Source: AGHT+IHHGiZHgy3s+8XmerKKacF1ioGYVr8/i83Pon+/HFCKY/mSb0SsQmhW+azRKtQiXlPjwnGd0WwE37FqCzJtHXw=
X-Received: by 2002:a05:690c:9c05:b0:6f7:5605:c62b with SMTP id
 00721157ae682-6fbcc3673cfmr103922197b3.27.1740392073624; Mon, 24 Feb 2025
 02:14:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-0-c11402574367@linaro.org>
 <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-13-c11402574367@linaro.org>
 <khmeegjx5jmu4c32un3gqu7sumkbtdkg6cawwwmwtmkp5gkrag@sklf5tr7qbwv>
In-Reply-To: <khmeegjx5jmu4c32un3gqu7sumkbtdkg6cawwwmwtmkp5gkrag@sklf5tr7qbwv>
From: Jun Nie <jun.nie@linaro.org>
Date: Mon, 24 Feb 2025 18:14:22 +0800
X-Gm-Features: AWEUYZm42Zh3tL3vnQp2tEApXMrcBNfOORo391vJrlHk1uL8HJBN-be9zH45G4k
Message-ID: <CABymUCOnnWQZpOhgDfENmWrTUuwb76zSN7nSeO+eyNp4k+PKRw@mail.gmail.com>
Subject: Re: [PATCH v6 13/15] drm/msm/dpu: support SSPP assignment for
 quad-pipe case
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dmitry Baryshkov <dmitry.baryshkov@linaro.org> =E4=BA=8E2025=E5=B9=B42=E6=
=9C=8822=E6=97=A5=E5=91=A8=E5=85=AD 00:36=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Feb 17, 2025 at 10:16:02PM +0800, Jun Nie wrote:
> > Currently, SSPPs are assigned to a maximum of two pipes. However,
> > quad-pipe usage scenarios require four pipes and involve configuring
> > two stages. In quad-pipe case, the first two pipes share a set of
> > mixer configurations and enable multi-rect mode when certain
> > conditions are met. The same applies to the subsequent two pipes.
> >
> > Assign SSPPs to the pipes in each stage using a unified method and
> > to loop the stages accordingly.
> >
> > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > ---
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 63 +++++++++++++++++++----=
--------
> >  1 file changed, 39 insertions(+), 24 deletions(-)
> >
> > +     for (stage_id =3D 0; stage_id < num_stages; stage_id++) {
> > +             for (i =3D stage_id * PIPES_PER_STAGE; i < (stage_id + 1)=
 * PIPES_PER_STAGE; i++) {

Do you mean define and assign r_pipe / r_pipe_cfg here?

> > +                     pipe =3D &pstate->pipe[i];
> > +                     pipe_cfg =3D &pstate->pipe_cfg[i];
> > +
> > +                     if (drm_rect_width(&pipe_cfg->src_rect) =3D=3D 0)
> > +                             break;
> > +
> > +                     pipe->sspp =3D dpu_rm_reserve_sspp(&dpu_kms->rm, =
global_state, crtc, &reqs);
> > +                     if (!pipe->sspp)
> > +                             return -ENODEV;
> > +
> > +                     r_pipe =3D &pstate->pipe[i + 1];
> > +                     r_pipe_cfg =3D &pstate->pipe_cfg[i + 1];
> > +
> > +                     /*
> > +                      * If current pipe is the first pipe in pipe pair=
, check
> > +                      * multi-rect opportunity for the 2nd pipe in the=
 pair.
> > +                      * SSPP multi-rect mode cross mixer pairs is not =
supported.
> > +                      */
> > +                     if ((i % PIPES_PER_STAGE =3D=3D 0) &&
>
> Please move r_pipe / r_pipe_cfg definition and assignment here.

r_pipe / r_pipe_cfg is used in this if(). Please see above question.
>
>
> > +                         drm_rect_width(&r_pipe_cfg->src_rect) !=3D 0 =
&&
> > +                         dpu_plane_try_multirect_parallel(pipe, pipe_c=
fg, r_pipe, r_pipe_cfg,
> > +                                                           pipe->sspp,
> > +                                                           msm_framebu=
ffer_format(plane_state->fb),
> > +                                                           dpu_kms->ca=
talog->caps->max_linewidth)) {
> > +                             i++;
> > +                     } else {
> > +                             /* multirect is not possible, use two SSP=
P blocks */
> > +                             pipe->multirect_index =3D DPU_SSPP_RECT_S=
OLO;
> > +                             pipe->multirect_mode =3D DPU_SSPP_MULTIRE=
CT_NONE;
> > +                             DPU_DEBUG_PLANE(pdpu, "allocating sspp_%d=
 for pipe %d.\n",
> > +                                             pipe->sspp->idx - SSPP_NO=
NE, i);
> > +                     }
> > +             }
> >       }
> >
> >       return dpu_plane_atomic_check_sspp(plane, state, crtc_state);
> >
> > --
> > 2.34.1
> >
>
> --
> With best wishes
> Dmitry

