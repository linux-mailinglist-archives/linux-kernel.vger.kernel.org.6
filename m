Return-Path: <linux-kernel+bounces-446400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013C09F23E0
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 13:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 354241617B9
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 12:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0346718CBE8;
	Sun, 15 Dec 2024 12:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S8BlQM4X"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89307189912
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 12:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734266568; cv=none; b=j9wjVSFyYAFkkgDpONf+8039fNbEFTu6YzjR06lDmIcBp2ddTATZXYrDNgeb153qinx8AeuTsEkZ58AOqcW3Qi/pdGcUlGoQdc+4sCY+brsVQmCLF1jScquH3BAPTGL5PZOZBxbd5NG6bKRqv6tiKkV5oiyu2TZafFQJaxzGcNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734266568; c=relaxed/simple;
	bh=34l1H84WeU4LzQM3c34I60viscofOXunMpWCOKo6rK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVL3G3P+SRzIcmkfzhiQDo0VTp8HzGTlJMDschbBYqUUtflDgU8u7NrY1z6TB19zi4CPIXwa8g1BUQCEZeP4G6FYBG+q7BqR+xJP2QHAloYjXBuBoqfBMI85gylS/uVIvvaGXS7npBAUR3FkfnY+h7T+tmZVRj48WSfle2+2DSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S8BlQM4X; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3011c7b39c7so34874451fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 04:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734266565; x=1734871365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hYI3tK4z04wmka3DeGZjKOkOw0GlWVobEE9u3MV0cX0=;
        b=S8BlQM4Xz4F1EiIN0zS36/QEKMwinFzgVlorcUhI3N5i+tMQDuaRAN07pMRsp6w9vy
         OZw16Ph4uX6OXlLAC0LH4G74gsqZM0vXPnZG4JCFKEDLK2+lcYcxoC7f5eR+CK810PIO
         RhZjExDjfXJplNb25c6e6034qUBfIatwLzZqjYQqcSVJTPdkDwnxrMRvWco6+Jc0bi0z
         cmwA25yw7gCiABY1drk2Pqn+RktiPZ9XXd/ACMi8rX4hVGvLP28cvRFaACN+ZwJHj8Ek
         EJsfNz8JjTv8M6LCKxfF7WYC56tuLB2LX81VyEvcp/XAqgPPy44XeWSN3pg+T0iPaXjd
         vuzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734266565; x=1734871365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYI3tK4z04wmka3DeGZjKOkOw0GlWVobEE9u3MV0cX0=;
        b=CYoN6p6ne4JfpSJDKNOQRA32Rp3BTfwEhknfG2F2CYLG1SDen+9K9DK2RrCUd+pnOe
         fNIFjxvO3E70V1NCgtuqP/92iqY9vY67dbPiZszOc9ULI0tJyxSv96JUIuiRqd9HdMGk
         AZ8oHI5Nb++rADuUlerkW+CynMOWFdSRfX/Y6lxQZKbfA0soqOitEKu2TUqUAvFzoIbA
         B7ZiFkg0NoOL5RfJyg7aE+SzneAZLweL0QNI5UqUNUi3YH4x6fY0eIl6REPqLHTjt2Dm
         adUQeGk8f20iXP3EquLiBIxSZBttfWCs3FTRFsN16M+IiNMbdPz46YUrVL77gSDEw2JH
         035w==
X-Forwarded-Encrypted: i=1; AJvYcCUt4j7xxbwr/PfEnxgk0PLqFs16CqUdb7Do8q7xLUIv73TfEvgTmIIzodf2ild7aahU6EFn1GRJQtXw3YI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdSi2gqdnCM/AYnffAtNo5vOaH/LFHeFPuRXNSuEKiMUD+T0JB
	mn2gErKzUyF1yDWXlIUyyJFtcjqAQfO7iQyW2ohE1Y7sYRFbNFvm7LQMlZJlxqY=
X-Gm-Gg: ASbGnctC4gjUCaPl9mu8cgeMefks+7CDOPS8LdutmNbEDKmEywzUAPGw7UjbUN1kHJj
	LGBKdPiliQm31ob6dm2QBixpThsnJh/Hs5XaHDzKF24rpDeOtpTVVxN5oJOVy0G1Kt/6BQgm0om
	gF8ad/mRx4It+Pa5F+OIRwi02UuWBHKywT4YIjBkEYDnYzaRiaxHNE8SFssbxQNWLvHEh0/S4uK
	HhePjRJzVoDeX1iIQf3RT3BqToYhAa37Cgxuj+c1wuvh9kOkRFX9XpvV7rMCf9A0112hQzthmOE
	ZbdmchdYwYje/qGJV0Qx2T/ulgGofTtiqFBy
X-Google-Smtp-Source: AGHT+IHsbdhkAZECyyNTJWfHo8P5cXdKXaUUsnfTwGl+ugfHZQYfSxPEs6t1dmb15lJWqB6WTYjwMw==
X-Received: by 2002:a05:651c:54f:b0:300:de99:fcd9 with SMTP id 38308e7fff4ca-3025459d0d8mr36236791fa.29.1734266564741;
        Sun, 15 Dec 2024 04:42:44 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30344061d5dsm5850411fa.52.2024.12.15.04.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 04:42:44 -0800 (PST)
Date: Sun, 15 Dec 2024 14:42:41 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/3] drm/msm/dpu: allow using two SSPP blocks for a
 single plane
Message-ID: <tynudqtodz46ti2j6paivfmvczijokhqiqxh3c2hy5ujdyuuzv@t627uosi3fhp>
References: <20241215-dpu-virtual-wide-v8-0-65221f213ce1@linaro.org>
 <20241215-dpu-virtual-wide-v8-2-65221f213ce1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241215-dpu-virtual-wide-v8-2-65221f213ce1@linaro.org>

On Sun, Dec 15, 2024 at 02:40:17PM +0200, Dmitry Baryshkov wrote:
> Virtual wide planes give high amount of flexibility, but it is not
> always enough:
> 
> In parallel multirect case only the half of the usual width is supported
> for tiled formats. Thus the whole width of two tiled multirect
> rectangles can not be greater than max_linewidth, which is not enough
> for some platforms/compositors.
> 
> Another example is as simple as wide YUV plane. YUV planes can not use
> multirect, so currently they are limited to max_linewidth too.
> 
> Now that the planes are fully virtualized, add support for allocating
> two SSPP blocks to drive a single DRM plane. This fixes both mentioned
> cases and allows all planes to go up to 2*max_linewidth (at the cost of
> making some of the planes unavailable to the user).
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 144 ++++++++++++++++++++----------
>  1 file changed, 98 insertions(+), 46 deletions(-)

And I forgot to pick up the tag from the previous iteration:

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>


-- 
With best wishes
Dmitry

