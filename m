Return-Path: <linux-kernel+bounces-219947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A1A90DA9F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B7D2B23B40
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956CC13FD72;
	Tue, 18 Jun 2024 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lcfdcyXg"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B08A13E8BE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 17:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718731620; cv=none; b=UrXEOfujXa9bziwbNyeWmmuYcIzMJZeVHtaR1SudM1DV8s3R+u0gJYagxbAgxxV4uAJr71tU8oosfts8cv9lI/+31fPMATd8BhPlbKSKH1GFOtYotgbEopkS1iRelyUNHvXOJDalq7AAWK3+S7s3tOcxyoePTAqYprhXJnygURA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718731620; c=relaxed/simple;
	bh=C67RHACpPp61qeVE9UwoRllkODOsgpgxer+BTPBPlFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CekM2SNQmleNY7V7bNHmGXhR+A18GVGXXnWQDBp9tVYejaEJtTzMcmPz00yehZkMc6q/p7nWAya5tAz+G+V6pOFa9KiB+wD5WRCJ90MotJ0f85+s9VPXfzn6yu340jj+tp/ZH3QMxcpV3BVAGIi2eBsZMuOWGkmy7DRxylsw4Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lcfdcyXg; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ead2c6b50bso62504351fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 10:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718731617; x=1719336417; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W2XgDBRe+uXR1JhTiAW0H+F2QdLuA6dIQSH0HmfL2qI=;
        b=lcfdcyXgfyZHLkNHrRTYeZKmJ/3WJFNo9sC+NJ+BvPznNCPBIP4gLVDYnRIOx+epGe
         8ECwMlXQJjGxFTHC5zS/ClgfobDd9ngG9hQ1FLXriEn/MdEnJgAnAtVDvpp6fufhkYiG
         d+Nl3AWF+AYeYq2UXimeB7AETjTWeMqOIrE0ejKQBHMmhi40/Yg5pwN1qU56GbDrIFx8
         ny2K9mYtqD0/4m9ZfrfhSgOTMYEnIymKi4piNL733KmpJ87APmN406owgDadBpdh5Ef7
         F0XOjLzid2ou43ez7hf2oL4CeImcV2PWn25S9vP6JrkTHh9oBiQKIIP66QBZAsSTc9iA
         qmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718731617; x=1719336417;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W2XgDBRe+uXR1JhTiAW0H+F2QdLuA6dIQSH0HmfL2qI=;
        b=HU38BmLxWcH6pLmcIDESy3FtZ2bcjpl4dd+SQeo7aH+tNqvaakrVvAQDhhbeW17hJb
         BoUfDdvlEzHdHyhKGNlQ/BdnOQvdhfbjIltPCUE3+BOsXLL1ir9CYu+fwkarD4jIOrS/
         lKd7wBuFoeSfyFoHvcUXwwx466UmQ9TJVIAq/E7OeXRLmIXp7XstJr89o349ATfHZsmg
         K61dZUs+QEDoSGQLSUNB6QQ8qK775T8NWpuuH0UjKpLdNoOxwcfvlvpX/wZp3MjUKxUP
         ImaTi5VC3Ov//36lH9pySC0xkWmv2SL9BegkQIqYoVUFXl/QM2WpuXqPfuDPRcCg+/xZ
         s08Q==
X-Forwarded-Encrypted: i=1; AJvYcCWgFhz5JWAUmkOrj712hK0+8plGzh2tBqxgfxl5C6U666wwm3am+RXGdw1wY1395G18dVmLWdYDW/zp0789yvGeHQJ9aH1IJNppuKMr
X-Gm-Message-State: AOJu0Yw+zbQE71cjF/cvKnJBL0os4zCjVt6zC2oV6ITuvMMOpmsN4ZVe
	Ry7cjRyZwlJPdBpgPoPn9xqXGl2a39rDBF01l0PIV1DHiewgEsODZs9IdNttLlE=
X-Google-Smtp-Source: AGHT+IHnlPq6SIHBVQIVyvhtZzEM4VjHJZd+R56nsfAoWok8bl5Nz8Rpo3Ive6lWbA3CpuueiYxIMA==
X-Received: by 2002:a05:6512:49a:b0:52b:c1d4:7df3 with SMTP id 2adb3069b0e04-52ccaa36980mr190988e87.35.1718731617392;
        Tue, 18 Jun 2024 10:26:57 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2889052sm1555203e87.299.2024.06.18.10.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 10:26:57 -0700 (PDT)
Date: Tue, 18 Jun 2024 20:26:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] drm/msm/adreno: Move hwcg table into a6xx
 specific info
Message-ID: <x64uencmmiqlozqhjnp2jclizjzhhhekkhvxqmm6dlilr7huyd@wmaikimb63jx>
References: <20240617225127.23476-1-robdclark@gmail.com>
 <20240617225127.23476-5-robdclark@gmail.com>
 <wnnjjljjyl5s3fkwiapux3f76243ngp2ppk2cm7kkhdp5dc4sz@v4wypnga3izv>
 <CAF6AEGvjeGxP+A2umyQHo49G1rAdZkY0bHuemvFP4jgNkspu3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF6AEGvjeGxP+A2umyQHo49G1rAdZkY0bHuemvFP4jgNkspu3Q@mail.gmail.com>

On Tue, Jun 18, 2024 at 09:33:48AM GMT, Rob Clark wrote:
> On Tue, Jun 18, 2024 at 1:30 AM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Mon, Jun 17, 2024 at 03:51:14PM GMT, Rob Clark wrote:
> > > From: Rob Clark <robdclark@chromium.org>
> > >
> > > Introduce a6xx_info where we can stash gen specific stuff without
> > > polluting the toplevel adreno_info struct.
> > >
> > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > ---
> > >  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 65 +++++++++++++++++------
> > >  drivers/gpu/drm/msm/adreno/a6xx_gpu.c     |  6 +--
> > >  drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  9 ++++
> > >  drivers/gpu/drm/msm/adreno/adreno_gpu.h   |  6 ++-
> > >  4 files changed, 67 insertions(+), 19 deletions(-)
> > >
> >
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >
> >
> > > @@ -98,7 +100,9 @@ struct adreno_info {
> > >       struct msm_gpu *(*init)(struct drm_device *dev);
> > >       const char *zapfw;
> > >       u32 inactive_period;
> > > -     const struct adreno_reglist *hwcg;
> > > +     union {
> > > +             const struct a6xx_info *a6xx;
> > > +     };
> > >       u64 address_space_size;
> > >       /**
> > >        * @speedbins: Optional table of fuse to speedbin mappings
> >
> > My preference would be towards wrapping the adreno_gpu, but that would
> > require more significant rework of the driver. Let's see if we can get
> > to that later.
> >
> 
> yeah, it was going to be more re-work, and I'm neck deep in
> gpuvm/vm_bind.. I just wanted to land this since it is a pita (and
> error prone) to rebase as more gpu's get added ;-)

Yes, I'm fine with that. My note was more like a 'later todo' item.

> 
> It isn't entirely unlike how we handle gpu gen specific options in
> mesa, where we have a somewhat bigger set of options, so I wouldn't
> say that this approach was worse than extending adreno_info.. just
> different..


-- 
With best wishes
Dmitry

