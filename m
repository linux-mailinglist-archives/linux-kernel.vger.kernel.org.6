Return-Path: <linux-kernel+bounces-525900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E02A3F714
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED2B63BAF9A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84C920F095;
	Fri, 21 Feb 2025 14:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bwR8rxvx"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F017D20F083
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740147667; cv=none; b=RBf2WwhKgd+WkNhhHEbjmczrlF3h2LG0I0lQLGlcMqH/WVciUzH+/oxWcjpw+83myWNOgPTQyuwwA9ed9eiZLUNvzSq3dCJSQJavUQwFQoBBt6+xnYYOrsjClhzEw2l/V6ZIP3btcoHMAYordtBL2JC0l62sZUk8odiTZbHJwic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740147667; c=relaxed/simple;
	bh=Okk00/7/I1/7vymB0EV+FBLPezox0pSKuhRNZxGr1X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlBVLdowLYt13HykrmwJ5OvwBCY3Z6wyKltMhSGy3sbRKRC0is3LjzVsXbwPb8r8Hp6FRdlsOhkbiRhXvCOe9ljf6Nn0nvjR27hQ4E/rLXjCF42wLRMkVPRwByB70zW97YkJpvaVrHbzxI2nVEQnBwVZk/97Frj1Kmz6eDAphd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bwR8rxvx; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54626a71b40so2092125e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 06:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740147664; x=1740752464; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/C9aXjHUlO1beVy7tJ0igGxNMnAGgKJPjFFb0vrOM34=;
        b=bwR8rxvxtrtI9orGwUPJOWqmiv2vCEprhV44RIx7AXu1lljwpSFfFsecu3j1gllea2
         /HqocJwcd/S2+9G+oOR7/FIri03T791tJQO37He4KRodQUj4G6nv5qLR1DDnQOuvXu+2
         zPCw75EmxvJKD416Swg+VF/SjzFKK933iQgOevPIt2ecmmE238hBeO9Vdc5SG1DsRW8/
         vJNRicOrAQF6qDvm160UPfkJ37R2M37IfFTTOAjidLkPa8FHgUJ/4+CMgRHGpufYh86Q
         LspPoo3AAJJWTyrB84x4lU9VNuch8SJc9z6GkLLBgE+sMIZiKTbevfV6DP5SPkCscQrA
         ZASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740147664; x=1740752464;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/C9aXjHUlO1beVy7tJ0igGxNMnAGgKJPjFFb0vrOM34=;
        b=h26fNmpzgyk8V3hbkxegTrdC8hcJP2RUJFjPmEEh1zi/NcduBmzjI893RW3doWGGHn
         BMnSPCP+Jf70eN03G2eCrEo7EYJsCz4mx9YebaafaGy8h8YM7dth9aNUP1JAEBnt9I35
         q/Z7MOkky+9bIpcSMoHhwj9T2tx/q51DLgKIkIMlkakNBQAq1ypz/xnF3bIzGEnshi8y
         nC6UHVPXUvmTuY8zE502mrcdRskNFdXtPLIdhgUyHYEbfcJOa5Sfh1przdknFqyB/Opu
         mXY5sEd/Ol4oj1WykZpa1K+97JFSC5HqUXW8PKafSkOO9T0TU4grYgHCgbmREqhPuAmd
         nuxg==
X-Forwarded-Encrypted: i=1; AJvYcCWTyNnJ2b0ddw5lpHq5FUamSEn4qxgfZWbu4rdMpAWVLE3Qht7Bihru94m24B0jvbVCTadgQWIRNBJZ8Ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQpynbSryWtSUKPxQO5Fd2LXqBoeG9GBDhOfSyFqKiUW58JugP
	xuYtO4yrACcsOtDEjBlWhFttPboJfs71IQVj9yYtYHGXub/uJshlbJmLfFtfRCI=
X-Gm-Gg: ASbGncvDY/AWPj/nNh47Wodo7tcqpwVVa5+q9zTfZuuXHFMz7aL1Dj2zO8a91UVLCCE
	Hj5wUBsIaweIx4XEUaMPF/tMQo4JIiel0KrnCpfnEnzogsSDWQz00Kv5Sqam6wenQ51QBOEtsEL
	tln/cyRyXydZuVQ3MeKkYYMKuAoc3oBoYU6JePoWq4iKFihEo6UEPBoB8v0OStemzBbO61Zn4PW
	clplYt0yxW4evpK6W0AKWuU0dTVCnsSHhoocDqpGDwVkp0QtheHfDqL3vbdEEi2rYK4rY+/ItTP
	yiUQ8U4dvVH06xz5M71QPNtzDLaMPPOH1oJ2xJj/MoAfjBGA6qkxYFpV7DmW8/oN+qNadS8Y2DD
	0NAVf1g==
X-Google-Smtp-Source: AGHT+IF8eCmACHE+xyiaFgbzM1UlrcuUp3RrCdRSkY2oEDQ/ZZy0v/hj0zGwHShMvQynxpAcMIw9tA==
X-Received: by 2002:a05:6512:3f17:b0:545:2ddf:1189 with SMTP id 2adb3069b0e04-5483912fc63mr1209704e87.6.1740147663964;
        Fri, 21 Feb 2025 06:21:03 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54530db5a4fsm2034136e87.248.2025.02.21.06.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 06:21:03 -0800 (PST)
Date: Fri, 21 Feb 2025 16:21:01 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 12/15] drm/msm/dpu: blend pipes per mixer pairs config
Message-ID: <djq577v6e7cnvybegddxfzqgg5eat4ormqyopa4b5j7wa6spfk@jwuy4cash6ch>
References: <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-0-c11402574367@linaro.org>
 <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-12-c11402574367@linaro.org>
 <qrwo5jtdj64vu27jn3v2wwyuxu25bjqrybj5jjfc5ifiotgzit@6vx2km46j7b3>
 <CABymUCPEYJTK=gBHcL291qn2zbotC7_8jA4z18sbSZSjRafSsg@mail.gmail.com>
 <ee7xdxyxjs46zfbotsa6hdmwpsvrkaere2hend4iavcvk6duqn@ogvght5qcx7b>
 <CABymUCNnt0Jiks+Fv8Os=V+zxzPAKMyH-wUpgDNMibWA_KNAxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABymUCNnt0Jiks+Fv8Os=V+zxzPAKMyH-wUpgDNMibWA_KNAxg@mail.gmail.com>

On Fri, Feb 21, 2025 at 04:07:45PM +0800, Jun Nie wrote:
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> 于2025年2月21日周五 00:17写道：
> >
> > On Thu, Feb 20, 2025 at 11:48:45PM +0800, Jun Nie wrote:
> > > Dmitry Baryshkov <dmitry.baryshkov@linaro.org> 于2025年2月18日周二 03:57写道：
> > > >
> > > > On Mon, Feb 17, 2025 at 10:16:01PM +0800, Jun Nie wrote:
> > > > > Currently, only 2 pipes are used at most for a plane. A stage structure
> > > > > describes the configuration for a mixer pair. So only one stage is needed
> > > > > for current usage cases. The quad-pipe case will be added in future and 2
> > > > > stages are used in the case. So extend the stage to an array with array size
> > > > > STAGES_PER_PLANE and blend pipes per mixer pair with configuration in the
> > > > > stage structure.
> > > > >
> > > > > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > > > > ---
> > > > >  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    | 45 +++++++++++++++++++----------
> > > > >  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h |  1 +
> > > > >  2 files changed, 30 insertions(+), 16 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> > > > > index 81474823e6799132db71c9712046d359e3535d90..50acaf25a3ffcc94354faaa816fe74566784844c 100644
> > > > > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> > > > > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> > > > > @@ -401,7 +401,7 @@ static void _dpu_crtc_blend_setup_pipe(struct drm_crtc *crtc,
> > > > >                                      struct dpu_hw_stage_cfg *stage_cfg
> > > > >                                     )
> > > > >  {
> > > > > -     uint32_t lm_idx;
> > > > > +     uint32_t lm_idx, lm_in_pair;
> > > > >       enum dpu_sspp sspp_idx;
> > > > >       struct drm_plane_state *state;
> > > > >
> > > > > @@ -426,7 +426,8 @@ static void _dpu_crtc_blend_setup_pipe(struct drm_crtc *crtc,
> > > > >       stage_cfg->multirect_index[stage][stage_idx] = pipe->multirect_index;
> > > > >
> > > > >       /* blend config update */
> > > > > -     for (lm_idx = 0; lm_idx < num_mixers; lm_idx++)
> > > > > +     lm_in_pair = num_mixers > 1 ? 2 : 1;
> > > > > +     for (lm_idx = 0; lm_idx < lm_in_pair; lm_idx++)
> > > > >               mixer[lm_idx].lm_ctl->ops.update_pending_flush_sspp(mixer[lm_idx].lm_ctl, sspp_idx);
> > > >
> > > > I almost missed this. Why is this necessary?
> > >
> > > It is protective code. In case there is only 1 LM, we should not
> > > iterate 2 LM in a stage.
> >
> > That's not what the code does.
> 
> I do not get your iea. _dpu_crtc_blend_setup_pipe() is called with
> num_mixers set as:
> cstate->num_mixers - (stage * PIPES_PER_STAGE).
> So lm_in_pair will get the LM number in this stage to iterate.

You have written that it is incorrect to iterate over two LMs if we have
one. The code does a different thing: 'don't iterate over more than two
LMs'. It would be more idiomatic to write it as:

lm_in_pair = min(num_mixers, 2);

And then it is obvious that it is not 'lm_in_pair' (note, singular), but
something like 'lms_in_stage'. I'd really ask you to pull this up to a
caller function and pass a correct num_mixers instead.

> >
> > > >
> > > > >  }
> > > > >
> > > >
> > > > [...]
> > > >
> > > > > @@ -535,8 +543,13 @@ static void _dpu_crtc_blend_setup(struct drm_crtc *crtc)
> > > > >                       mixer[i].mixer_op_mode,
> > > > >                       ctl->idx - CTL_0);
> > > > >
> > > > > +             /*
> > > > > +              * call dpu_hw_ctl_setup_blendstage() to blend layers per stage cfg.
> > > > > +              * There are 4 mixers at most. The first 2 are for the left half, and
> > > > > +              * the later 2 are for the right half.
> > > > > +              */
> > > >
> > > > The comment is invalid until you introduce quad pipe, currently there
> > > > are 2 mixers at most. However you can just say something like 'stage
> > > > data is shared between PIPES_PER_STAGE pipes'.
> > >
> > > Accepted.
> > > >
> > > > >               ctl->ops.setup_blendstage(ctl, mixer[i].hw_lm->idx,
> > > > > -                     &stage_cfg);
> > > > > +                     &stage_cfg[i / PIPES_PER_STAGE]);
> > > > >       }
> > > > >  }
> > > > >
> > > > > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> > > > > index 5f010d36672cc6440c69779908b315aab285eaf0..64e220987be5682f26d02074505c5474a547a814 100644
> > > > > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> > > > > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> > > > > @@ -34,6 +34,7 @@
> > > > >  #define DPU_MAX_PLANES                       4
> > > > >  #endif
> > > > >
> > > > > +#define STAGES_PER_PLANE             2
> >
> > BTW, This should be 1 for now.
> 
> Yeah, it can be added in the last patch.
> >
> > > > >  #define PIPES_PER_PLANE                      2
> > > > >  #define PIPES_PER_STAGE                      2
> > > > >  #ifndef DPU_MAX_DE_CURVES
> > > > >
> > > > > --
> > > > > 2.34.1
> > > > >
> > > >
> > > > --
> > > > With best wishes
> > > > Dmitry
> >
> > --
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry

