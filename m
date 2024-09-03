Return-Path: <linux-kernel+bounces-312514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00796969799
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24E861C21641
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B48719F43A;
	Tue,  3 Sep 2024 08:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OnoEST2a"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D876A19F426
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 08:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725352954; cv=none; b=KduGFl/Ttmbp5wbmqcok5bcluL9JtOVSuVufMUZXg5hgl2c8etSfwbsh9iOa6x8Kazw+5U5VOK/5wgQtb9EuKVRRrGaVPbijYDzONJCp0g2HLvejAJCEKeAMfcsTnrGFqnH0+8ZdVcg+QJcELo7BgjyhngL3aEH7e4kUVKoPIFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725352954; c=relaxed/simple;
	bh=ingMFnquR2yoDFQxi+MAZTlvtrJFd3Gvon3zM7Ydg30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DVXBSimn+uQgbY/+3w1O9f+m7wZ40d8xw2lZx2aHpYIboBmbdRsQ+Cke3BgKfYjoG7F7fG/Rf4e1NS2QrcFb4viLXPiHVHnfbzhLUz5ufmKvySBuoTz4NdudDUcGcgeVczcyoDchRTxWj6uSkYqYAw+zmtmrGG1T+pcnFhcpixs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OnoEST2a; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6d49cec2a5dso31761187b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 01:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725352951; x=1725957751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/mrX622vzKi3A5Tls417WrDiltDIV6fbRHi06ziRyY=;
        b=OnoEST2atZ3MmZCE6Z0YzjDfl+E8LazscZlVjbXtvMpLycp6ei2lfdpuAHf5nMirGQ
         rYjOju6DF193txBKo4OfS2aO8/Epz2rQfAi9pUx9xgGpE9+Ulk80KiW1q8fFcpn5VNzq
         dmf2hDAUIZ6F0D9/GnAGeBP6qf95Xzd+4swpSQPF0fQu4G5/l1g+9xJhIfWHJBsv1Q3L
         RwxVTlbzeyWe/tb0du4Y9RxdDNMpvOVi7zbGAQ4+/9rOvsfExwx4ITT3VG6LjAVe4N9E
         Lws5+1LyLGSZfclUum4smM+DE+5tPH1FL7idWmiBTeJKLxQbEgdXlqluZ8CxTBUNWYwf
         QNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725352951; x=1725957751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/mrX622vzKi3A5Tls417WrDiltDIV6fbRHi06ziRyY=;
        b=Ot0/VS74JYZ8DXjCpUsOIurDfKiAC23yxuJPqaoW0FsEzlRHh0PRgtM7EbCtBas2T8
         A1GYBwsyyhbOW39y3uDj7d6sTdVzj4ZADimexsjemW+1xtfIliMLGM9+YOye85CeVx+S
         vv6lmMpSDlIatjocq0De4VKuDgdWZKCdIFx+hjZVq0ezfha5IFeImE3fvzBHog3evGWo
         cYUKUWNAhx9tQFxRkg2aNCqOgNIS4tTvujiQiluwmhF390aqA7yl9git5bmBSFzaVp2W
         7LSbM3THQxdmEQL1WrEQgkd2RMBI+mGG3sjd904sOufaiqwqITAV9KqXKx22klU7UOni
         Ragg==
X-Forwarded-Encrypted: i=1; AJvYcCVzOQn0s65R3T8q+KVkkCTxSoVaYv2XX5cnQ9V2oqojM5Kwa/Z559Zt0o+41BwUFflh3aRI8Z/6AAHzI4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVBrttGzigIA6/NZeJ936I1PFK6lYSimhIvhWEobKw/ioNPfje
	WDQkQkFPg9hwDbxZbSs9GRdDy0b35HpyswoC14Qd0SVqpiWgzSU0ihoillYj9u2an5CI8JqZCvJ
	i0ZgsjEWrIIB/EaDoTau1REwzX9Uy93W/Z8t6aw==
X-Google-Smtp-Source: AGHT+IEiAdbj4FLduYe5iuAiEPo48sVkQb/vb9WqTLElBDOx6SZ98v/BcgjqeHJ5ia7wgrlGOaAExZ2KbJYtwV2Gr2w=
X-Received: by 2002:a05:690c:f89:b0:65f:a0e5:8324 with SMTP id
 00721157ae682-6d40ee57193mr161576607b3.4.1725352949951; Tue, 03 Sep 2024
 01:42:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-0-bdb05b4b5a2e@linaro.org>
 <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-10-bdb05b4b5a2e@linaro.org>
 <CAA8EJppFCVQPFa1-o7T08Bs+vzbykDXwVTOq4=B2LuWJb2gYGw@mail.gmail.com> <CABymUCPi-DbPW=Aos=m0mrHj2TgxEy=QNEFpbCsb3srr-qe1Eg@mail.gmail.com>
In-Reply-To: <CABymUCPi-DbPW=Aos=m0mrHj2TgxEy=QNEFpbCsb3srr-qe1Eg@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 3 Sep 2024 11:42:19 +0300
Message-ID: <CAA8EJpqN_r2SCAZ9hSMwn6gNNzcRTyMy_-RJkobk+YN5Oyk1ug@mail.gmail.com>
Subject: Re: [PATCH 10/21] drm/msm/dpu: fix lm number counter for quad-pipe
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Sept 2024 at 10:50, Jun Nie <jun.nie@linaro.org> wrote:
>
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> =E4=BA=8E2024=E5=B9=B48=E6=
=9C=8829=E6=97=A5=E5=91=A8=E5=9B=9B 19:17=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Thu, 29 Aug 2024 at 13:20, Jun Nie <jun.nie@linaro.org> wrote:
> > >
> > > Add the case to reserve multiple pair mixer for high resolution
> >
> > I think you already know what is missing here.
>
> Add the case to reserve multiple pair mixer for high resolution. Current
> code only support one pair of mixer usage case. To support quad-pipe
> usage case, multiple pair mixers are needed.

pairs of mixers.
supports
two pairs of mixers

Also the text doesn't describe how that works. It's not obvious from
the patch, one has to read the source to understand what is going on.
Please make it clear.

>
> >
> > >
> > > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > > ---
> > >  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 6 +++---
> > >  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c      | 8 +++++++-
> > >  2 files changed, 10 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gp=
u/drm/msm/disp/dpu1/dpu_encoder.c
> > > index 33cfd94badaba..f57725ad494d2 100644
> > > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> > > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> > > @@ -54,7 +54,7 @@
> > >  #define MAX_PHYS_ENCODERS_PER_VIRTUAL \
> > >         (MAX_H_TILES_PER_DISPLAY * NUM_PHYS_ENCODER_TYPES)
> > >
> > > -#define MAX_CHANNELS_PER_ENC 2
> > > +#define MAX_CHANNELS_PER_ENC 4
> > >
> > >  #define IDLE_SHORT_TIMEOUT     1
> > >
> > > @@ -2029,8 +2029,8 @@ static void dpu_encoder_helper_reset_mixers(str=
uct dpu_encoder_phys *phys_enc)
> > >         struct dpu_hw_mixer_cfg mixer;
> > >         int i, num_lm;
> > >         struct dpu_global_state *global_state;
> > > -       struct dpu_hw_blk *hw_lm[2];
> > > -       struct dpu_hw_mixer *hw_mixer[2];
> > > +       struct dpu_hw_blk *hw_lm[MAX_CHANNELS_PER_ENC];
> > > +       struct dpu_hw_mixer *hw_mixer[MAX_CHANNELS_PER_ENC];
> > >         struct dpu_hw_ctl *ctl =3D phys_enc->hw_ctl;
> > >
> > >         memset(&mixer, 0, sizeof(mixer));
> > > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm=
/msm/disp/dpu1/dpu_rm.c
> > > index e219d706610c2..77d7ff789346e 100644
> > > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> > > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> > > @@ -306,7 +306,11 @@ static int _dpu_rm_reserve_lms(struct dpu_rm *rm=
,
> > >                 if (!rm->mixer_blks[i])
> > >                         continue;
> > >
> > > -               lm_count =3D 0;
> > > +               /*
> > > +                * Clear the last bit to drop the previous primary mi=
xer if
> > > +                * fail to find its peer.
> > > +                */
> > > +               lm_count &=3D 0xfe;
> > >                 lm_idx[lm_count] =3D i;
> > >
> > >                 if (!_dpu_rm_check_lm_and_get_connected_blks(rm, glob=
al_state,
> > > @@ -353,6 +357,8 @@ static int _dpu_rm_reserve_lms(struct dpu_rm *rm,
> > >
> > >                 trace_dpu_rm_reserve_lms(lm_idx[i] + LM_0, enc_id,
> > >                                          pp_idx[i] + PINGPONG_0);
> > > +               DPU_DEBUG("reserve lm[%d]:%d, pp_idx[%d]:%d, dspp[%d]=
:%d for enc_id %d\n",
> > > +                         i, lm_idx[i], i, pp_idx[i], i, dspp_idx[i],=
 enc_id);
> > >         }
> > >
> > >         return 0;
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

