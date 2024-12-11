Return-Path: <linux-kernel+bounces-442227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B839ED997
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 643BB164C84
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA461EC4F9;
	Wed, 11 Dec 2024 22:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yPLatFto"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1A71EC4D6
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733955863; cv=none; b=OsVvZ9Gv2mJXuKO6R5Une2ptnGjbbYS8TSW7pcuK6m/oZcHCzW7M2CTXVFq5GoheRMb8PunnQ6qxYh79qzHM0kYPhFQBNTZdAYbvWN9fNMVjRzHEkPgHGsSLMYOwwtRc42wdWnDciOrg7evaVlIaJ5dliSJeRvDSIUZXGL94Ck4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733955863; c=relaxed/simple;
	bh=/5rTDPj4eG5P/dMMZ3UaadXwQgo5sue2mf716YTlQyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcuBz840eX8nzKny1kNwqM0mNSjv7ZmdwCs1LEh6pXAkQS+B7zunEJ6pmM162GpXr5SXra+HcvnF3Ij6OGbfyiGTcarr71KaSxUVcdDLzZ1dJjgIrLZ6/4chxt1aDztnxe8oebT2lsiQzN21Ng0eXaEhys3X4YmuMPtM2kccijc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yPLatFto; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53ff1f7caaeso5051584e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 14:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733955859; x=1734560659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TQt0c/B79tzZ92JCkmXyGPgoiCeeT1lFWyXxnDRmJf0=;
        b=yPLatFtoMKuH4FXESGbbTvaGZ+10m/VvbZBti7LIVYQtJAm9YzNizCgVm30urLp1TO
         oxZNLfzVszBTJjWGn4r3ME7LuP7oDN/owZQHPeaEHuiBNf62zgUaS+niDFjHH4OMM+FE
         7anw1O8AQ2zPxGmKlSaG4wYQGpVXjXO4KpgCG79YF4CHxvrhFL4gFFhgI9DA8FZyOx+F
         JRN67TWDRrtmhKHiKfcowV7W/RMq4q3pPPrB/sW65xzJ9aSpUnuHlpf62gu46aA2UHWY
         5wHDQNO+i1EyosLB5ndgR8ldafJXWLKexH6tsrX+RQZb5YnFpstzggWmY8GbKiW5JB2X
         Easw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733955859; x=1734560659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQt0c/B79tzZ92JCkmXyGPgoiCeeT1lFWyXxnDRmJf0=;
        b=kvluWHT/dRvKWModkJIkOa5SAkwh4rofV/63EfAJ9gNvtX9G+MDVGmZD/LFJfTgBzB
         h9zA+KJhaLrb8MUMQjG/mFOj2W4nicbVqMP+52qLGTVjHCY+rj7RHYyRkfKzlWjLQStI
         gTjpgmIJgjXUEeKspde8xKGLqopFSdmPsCPN92e1IYgzleuOQ5pQjgFLwI4ho1VQoBzP
         ykk0edQOJK6w7LHzCl0YBr6ePK+lY/UrYAGDjZLMhlTXrWTK00m7CiTdoB92rGdOX7AC
         koKcfezMJSqx3ywz9MxwcsSRlMSw5KjB9tc3bZtqISD6JR4mvJcgKb0/LSOhpUe9c4JZ
         4Lqw==
X-Forwarded-Encrypted: i=1; AJvYcCU1hR28QG9GSXNrjatw2aPsFQQMOJ/vihXbLZCDeXb3zm1H93AdoBLdbvCnM2421TsgEbndjOnbK8HobxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjW7OaK15bZ3nv9I1e4Bl8Tk1k2JI7kxWcHlotST5P2ZDVj9EK
	0Eo6EooCGeN5INiF1EvZMUgdoJfbc1A+bYdBRoEYWaFhB14LAJAknGb8o58jwDU=
X-Gm-Gg: ASbGncts+DvlTMpndGv8NV+aqKc43BDlvIH7i7rMQ9PUrsJVpDOrhBoYdKV636DhVNP
	vq4Uvl+TQ7stoFqvMIFgV7i70f5jlaWKnfcR0tdfmJmFqcrclfVE0CNSndq3OqjrBaA8PPkqMis
	qQoDGNI5wJo4jpKR6NtZ+u2ecU/Fn0cYftkdkgbWpWhgwzoYwseS3oEJ0jZlFIoOBg4zu9FcZ9G
	vVI7lefUhn5BK9oiJtsbTFQKJOpvkhk7j1ZQGuMI4GpBPbXVHcZLhulXrZJfnXlfvTpYCPlaEwS
	70siv3y9s3Se1p43K7RlwgXmElhA2xcRnQ==
X-Google-Smtp-Source: AGHT+IGUjnHXz8xm14gX4NMTwgGnSmfUk9Frni6oN0Mq2JYlv9txb+UhgRCFjpynV3Xptsxw0hq6Fg==
X-Received: by 2002:a05:6512:238b:b0:53e:39b7:54a3 with SMTP id 2adb3069b0e04-5402a5daa14mr1547884e87.24.1733955859171;
        Wed, 11 Dec 2024 14:24:19 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e3c48b122sm1519955e87.65.2024.12.11.14.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 14:24:17 -0800 (PST)
Date: Thu, 12 Dec 2024 00:24:12 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/3] drm/msm/dpu: allow using two SSPP blocks for a
 single plane
Message-ID: <hpmxj7tjmvbo55izoxgygqmysbabnpb35mprvn6w53vbtehnwe@yxmiigoeuyf3>
References: <20241130-dpu-virtual-wide-v7-0-991053fcf63c@linaro.org>
 <20241130-dpu-virtual-wide-v7-2-991053fcf63c@linaro.org>
 <160151f0-9cc6-40f6-9f53-466185835e4d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160151f0-9cc6-40f6-9f53-466185835e4d@quicinc.com>

On Wed, Dec 11, 2024 at 01:51:51PM -0800, Abhinav Kumar wrote:
> 
> 
> On 11/29/2024 5:55 PM, Dmitry Baryshkov wrote:
> > Virtual wide planes give high amount of flexibility, but it is not
> > always enough:
> > 
> > In parallel multirect case only the half of the usual width is supported
> > for tiled formats. Thus the whole width of two tiled multirect
> > rectangles can not be greater than max_linewidth, which is not enough
> > for some platforms/compositors.
> > 
> > Another example is as simple as wide YUV plane. YUV planes can not use
> > multirect, so currently they are limited to max_linewidth too.
> > 
> > Now that the planes are fully virtualized, add support for allocating
> > two SSPP blocks to drive a single DRM plane. This fixes both mentioned
> > cases and allows all planes to go up to 2*max_linewidth (at the cost of
> > making some of the planes unavailable to the user).
> > 
> 
> Overall looks so much cleaner after unification!
> 
> One small nit below,
> 
> 
> You can still have,
> 
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> Note: we have started testing this series with sc7180 CrOS, and will report
> our findings/ give tested-by this week.
> 
> 
> <snip>
> 
> > +static bool dpu_plane_try_multirect_parallel(struct dpu_sw_pipe *pipe, struct dpu_sw_pipe_cfg *pipe_cfg,
> > +					     struct dpu_sw_pipe *r_pipe, struct dpu_sw_pipe_cfg *r_pipe_cfg,
> > +					     struct dpu_hw_sspp *sspp, const struct msm_format *fmt,
> > +					     uint32_t max_linewidth)
> > +{
> > +	r_pipe->sspp = NULL;
> > +
> > +	pipe->multirect_index = DPU_SSPP_RECT_SOLO;
> > +	pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
> > +
> > +	r_pipe->multirect_index = DPU_SSPP_RECT_SOLO;
> > +	r_pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
> > +
> 
> 
> There are two places where the multirect_index and multirect_mode are reset.
> Would it be better to just have a small api dpu_plane_reset_multirect() and
> do this there?

I'm not sure, what's the benefit. We can add an API to reset one pipe
(to also be able to use it in _dpu_plane_atomic_disable()), but then
it's just deduplication for the sake of deduplication.


-- 
With best wishes
Dmitry

