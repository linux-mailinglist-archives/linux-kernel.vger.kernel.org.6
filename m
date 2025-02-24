Return-Path: <linux-kernel+bounces-529641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0807EA42933
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74CE94423F4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B62325485D;
	Mon, 24 Feb 2025 17:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RqIpo5l0"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C90263F3E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416893; cv=none; b=e+yZosxA+F6VIhb8gkwDFwfyjlOJQfhqWwSfdxokgPXNtI7MToxlPSGoMxr+p0OkbNGfZhMmTLNibHueD1SrQQKGhkmD2GTvtl5u/34r8+uM83DUKXz+1cLjF68QHwu+iNo1qntxFbAAW0gEz8n2Ijc2soxM1rc4sO5UVVqm1d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416893; c=relaxed/simple;
	bh=2hplAwJzDJ/YDi7bjamHHdDkwbYLwpQhdJLck9HAtcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SytpCpReKi9J9dSNnLUp5LMaO0YYo1CF9AdgKDdDVZo6RPretRCTdDvMR2sT9HXTZROxSTMHwF2a16eADPR1/sYR18yVzmkt/EHONY91to7xZdSTIzUQ9YhajmtbSTLYvxauyiMRXhwlYLVO5Y42R580HxI6zOfAh8vm1AA6RNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RqIpo5l0; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5452c2805bcso5148328e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740416889; x=1741021689; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SDD7C/XbQ4WEaFEyI9RS4ouDEECOxDAKosUSoNyCeps=;
        b=RqIpo5l0ogxQqq4lijtmFIGbMjPvikLMvEI9KJtixFCMC604+nS/XegK1Qo7SlGIzB
         bPikd7L+9098kcOC+sJ2YfzsVfwowo8+k93p3XlpLlAiRJ8xU4BoIbaPHCU0ljKYFU0z
         DQUXs3dSyrsyMs2ptcsVyHu8mJqEeE1LyC0cmeNo5Lpk1KQSLybKEdi04Y0AOhSAEFBj
         /l3RByaBLvYbMnNKPV5qQfwDmqNitUnc47Glznp6Q4vIrZzoxkQDiDNTG1CxvjEspgGz
         ZjAjmTJ1eK0HZcXVFbYFWv3/8TdvtNvnGApMxLKt6aUHIL7HX+PQavnuzn+lD2EwGrhl
         jMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740416889; x=1741021689;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SDD7C/XbQ4WEaFEyI9RS4ouDEECOxDAKosUSoNyCeps=;
        b=ueWicgb6GDu9AhseUV+9aQE99arUdxsEb52p5StcRHRFq8WhDodN256wUDCdZmPHLY
         Ki+dmM4uYFKyqZKDEj/Ipob1gk2wyex4U5mgleJlo1EvSs4GAd183oUae5iaq7gLdZdj
         7DHdnhMDH/6AQgHpxdu5PQ5aDow59yIkLoMetf2dqcCq2D8vIzDCPOjtDLBuk+RVtMWg
         /bA0oS/hN/jQQ75uJ4zHXMHhGgNHJ7joZ7dGwayjrgUTTNoZx5WGbz/+C8mLqpsWzp1b
         IED7nBvueKWbmzV/YKCqnLNhH2P26wOYatKzg+w63gKAu/0UhYJnnzzOiesfK99D/Ctl
         XHOA==
X-Forwarded-Encrypted: i=1; AJvYcCXALx+IRDY9oyyvZGi5pSB8RSuhw+A4vRAiKUsfqcGfUwdufl89VQJ6mXk/33R6aAQGJNqnmV0GB6LsGOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxISw+C4m/Uve71zillQmZm6mJvreN00Z2QAQ5eVM0QncbvuFo0
	Zrh081EUgUd8sul51NYv1YVZkX+Q/SvR597DNtnXlpSLBUDUEWuUIIhkHSi+4e8=
X-Gm-Gg: ASbGncum4j/pkAUtheMZA7FJVVbiFF09Kv56FadOqXckvxJbaFIdF5ve2MbvWjZNXJ7
	XVCtxXXUWmqGAh8sXspsTHEq7OAwfq4fmWYiePWvOnpuGqHsfzTh58BWa3RS/qBvQvepHyDBcCx
	HcRksT1c+eev7XvcLcoCfTviF/zNUi+lTioKLlIKYpp/PQkGSLYFkfustk6ARmPxWdRjv0LEWQc
	we8d33XeYK3m/D1Cg6eDCiGyhHrLgUdNgU0B6V5D7IayG/L5JKumMu6Gjyq83QagqNMZWph4kS/
	pY6YSeYYFx6x9HtVthW+RimTwHrDD4CshG6hvfLuHaEtKrvsBD95kHdvTyxIGfc8nXIY0X3g/nV
	vNLE/bg==
X-Google-Smtp-Source: AGHT+IHB1gFnnaGSzBphtTkMlhlOX/xtMLMcfN5SzTa6WkSqGOzrAt8tTjA8bVyEGzKZWV+BQiheoQ==
X-Received: by 2002:a05:6512:691:b0:545:e7f:cf33 with SMTP id 2adb3069b0e04-54838efaefcmr5529016e87.28.1740416889466;
        Mon, 24 Feb 2025 09:08:09 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-545243fdfb6sm3283441e87.218.2025.02.24.09.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 09:08:08 -0800 (PST)
Date: Mon, 24 Feb 2025 19:08:06 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 13/15] drm/msm/dpu: support SSPP assignment for
 quad-pipe case
Message-ID: <n22g66ruabunma4w4p44zjtsnb5t4vdpjuaocasbup3alb4fxp@74tu3wnqbwfg>
References: <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-0-c11402574367@linaro.org>
 <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-13-c11402574367@linaro.org>
 <khmeegjx5jmu4c32un3gqu7sumkbtdkg6cawwwmwtmkp5gkrag@sklf5tr7qbwv>
 <CABymUCOnnWQZpOhgDfENmWrTUuwb76zSN7nSeO+eyNp4k+PKRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABymUCOnnWQZpOhgDfENmWrTUuwb76zSN7nSeO+eyNp4k+PKRw@mail.gmail.com>

On Mon, Feb 24, 2025 at 06:14:22PM +0800, Jun Nie wrote:
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> 于2025年2月22日周六 00:36写道：
> >
> > On Mon, Feb 17, 2025 at 10:16:02PM +0800, Jun Nie wrote:
> > > Currently, SSPPs are assigned to a maximum of two pipes. However,
> > > quad-pipe usage scenarios require four pipes and involve configuring
> > > two stages. In quad-pipe case, the first two pipes share a set of
> > > mixer configurations and enable multi-rect mode when certain
> > > conditions are met. The same applies to the subsequent two pipes.
> > >
> > > Assign SSPPs to the pipes in each stage using a unified method and
> > > to loop the stages accordingly.
> > >
> > > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > > ---
> > >  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 63 +++++++++++++++++++------------
> > >  1 file changed, 39 insertions(+), 24 deletions(-)
> > >
> > > +     for (stage_id = 0; stage_id < num_stages; stage_id++) {
> > > +             for (i = stage_id * PIPES_PER_STAGE; i < (stage_id + 1) * PIPES_PER_STAGE; i++) {
> 
> Do you mean define and assign r_pipe / r_pipe_cfg here?

No, because for i = num_stages-1, the r_pipe would point to invalid
memory.

> 
> > > +                     pipe = &pstate->pipe[i];
> > > +                     pipe_cfg = &pstate->pipe_cfg[i];
> > > +
> > > +                     if (drm_rect_width(&pipe_cfg->src_rect) == 0)
> > > +                             break;
> > > +
> > > +                     pipe->sspp = dpu_rm_reserve_sspp(&dpu_kms->rm, global_state, crtc, &reqs);
> > > +                     if (!pipe->sspp)
> > > +                             return -ENODEV;
> > > +
> > > +                     r_pipe = &pstate->pipe[i + 1];
> > > +                     r_pipe_cfg = &pstate->pipe_cfg[i + 1];
> > > +
> > > +                     /*
> > > +                      * If current pipe is the first pipe in pipe pair, check
> > > +                      * multi-rect opportunity for the 2nd pipe in the pair.
> > > +                      * SSPP multi-rect mode cross mixer pairs is not supported.
> > > +                      */
> > > +                     if ((i % PIPES_PER_STAGE == 0) &&
> >
> > Please move r_pipe / r_pipe_cfg definition and assignment here.
> 
> r_pipe / r_pipe_cfg is used in this if(). Please see above question.

Maybe we can rework it somehow. I really don't fancy the after-the-array
pointer.

> >
> >
> > > +                         drm_rect_width(&r_pipe_cfg->src_rect) != 0 &&
> > > +                         dpu_plane_try_multirect_parallel(pipe, pipe_cfg, r_pipe, r_pipe_cfg,
> > > +                                                           pipe->sspp,
> > > +                                                           msm_framebuffer_format(plane_state->fb),
> > > +                                                           dpu_kms->catalog->caps->max_linewidth)) {
> > > +                             i++;
> > > +                     } else {
> > > +                             /* multirect is not possible, use two SSPP blocks */
> > > +                             pipe->multirect_index = DPU_SSPP_RECT_SOLO;
> > > +                             pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
> > > +                             DPU_DEBUG_PLANE(pdpu, "allocating sspp_%d for pipe %d.\n",
> > > +                                             pipe->sspp->idx - SSPP_NONE, i);
> > > +                     }
> > > +             }
> > >       }
> > >
> > >       return dpu_plane_atomic_check_sspp(plane, state, crtc_state);
> > >
> > > --
> > > 2.34.1
> > >
> >
> > --
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry

