Return-Path: <linux-kernel+bounces-526233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28361A3FC20
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 174168654C7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9067E1EF090;
	Fri, 21 Feb 2025 16:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JL/FJjnI"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5B71F3BA9
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740155880; cv=none; b=MEYRFDnZJDV+8uz8NQavj0sz18Z1+e5uPOTo2b5CzFGXdKFizQlui7Y/ECZY5LI2zTe+S5mdDTPvjfmNA/2VQlaFE9pGnWUs8e2s1/9DuUzGLcsJQZpCbjUbbf5VxLiu3ObISXU0FHX0t+MlSSDLO4KKouFkTVMM9bC5vTD4WJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740155880; c=relaxed/simple;
	bh=PNc2UA/ZLsZQUeWdLDl3KKGsX49tWcp0C8Wye1i/fTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgrF+xl+jfC1ddTEpLKmNpnGJO10y6bF3jzaS2Bj1p+5BmCJKUgtN4WHEmAMGcQMJwviwykJS4OeyF+gApUSb21KcYHvBj9Jj4SeI+HCr9drNmt17Fny3gIgoLEK4b4S3L7d1cHS7iY5hXUY8PahbxaOaSsntY3l5hnV3OQD5Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JL/FJjnI; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30a2f240156so22490751fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 08:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740155876; x=1740760676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HiCM9rHR9ep2t2LpEOjyyuBT+CM+zVgh9rP3wMq2c10=;
        b=JL/FJjnIcXB8ITWohaDRlmX9UYR8swzsBZM1H8FTIEFvFdiLbtf92NaIUJ+Ff/dDmc
         VVAv2Fl5AsCtNmidypQ2CJ3kTgGmTv5q9CoCa/iTwCiJig0W0ueaEOnJwFk8lrXUQquQ
         5AorFv4Wyac5Hpw7Bs6EAxhkJEJORdXRJsiuYPUdLZgFJ7NNaY+uI4+vOIHKksuf0Ykc
         BY6CV3lLMgZWzQVPrAoihufuElePshMMECdnrhLQS//0diG1fLcNH5sIZ7K8BwJ/q88l
         MpI8nxZrEVlwb+UAQPlQlBeTtW8o0M4fHuiIR+ZROA3K25mki+yCn8jWHd+P3UmuQF8x
         P5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740155876; x=1740760676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HiCM9rHR9ep2t2LpEOjyyuBT+CM+zVgh9rP3wMq2c10=;
        b=o7EddyeBsj7XMD8d/MmpLjb3CKyvm1giFJFNfQf50TSoHl1UndHfH6VKmy/2ngRF1v
         qTz3aqkPj6/9i2NRl9QR2m/4ZUGuGrM62iirEt9B49nb6cAIrmtsIWj0S8o6tvKB245Z
         VsxWn+cdn6xBrdG+N1eSgRB1UceG+hWC67iaZOwygCFmy7ODp3ARuWbXc2wIDJ3UdFA6
         yZgeo0K6vQmuc4J9XxMFpaYYjtY5KsFDdbDNizAsgxV0STEhR03iq9QbA7AcN/Eor4HZ
         1gDElOB+1A0Qhktzb55Uq5ljjB9ZYuKVp8o9+VhdEpE+MU0bn0X1yFGqKRmtwWUVKKzd
         ybTg==
X-Forwarded-Encrypted: i=1; AJvYcCWyvxHayj9ZPBy9G7msPo1s1JyWGad77ieE0NGppL0/AOuKYyC7twJKjjh3wjswwfeImnL6c9wSGwu/BPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Zl66HUtQ4rH4M3hKnmuvknxlK96gxwp4Bw+O5msZGqCChyFB
	sNbfUHPcABQl03+aRLj/aO6JpvipHTKqMWPixVUMD5YTxgi4GEgV2YCTEM0DHpY=
X-Gm-Gg: ASbGnctFE9IwOqublwPAqCzvuqfFoSUSLvrGBrCGyvj9WvXwAslZ8TU8gBt+tuZS7sq
	V851AJnax0AcuTZHM/9c/ewzAYIEuDQqfHYGWrLzStkyU8lNyXsGv/y1raGCCdKbh5+JUTY+ulg
	TpCR2YFqmPqyzsfG+HS3f65ro0+nRsrkitnzhobVpMUv0E9O4waO91nzV2CwGZWTSyuf2xMVXja
	mamcyYXZ+3C0JyY/mZzJisQdo3XbN0RYd3XQ8DOMDZOndMODZtrPv3AHHzKWlJbeOBwUFKpogTH
	LS2kAZqjNfNpfufiB2b/rnUqnJvJszCuiQlVH4O4ssEoFlqdb/QCuiIgrrIYG6SdVKdXVbeE3t+
	0uoUEpg==
X-Google-Smtp-Source: AGHT+IGoFXuun5GJ97Xvt7Zgkc3Ne28NUcJZxPJK51Drj8l8NBtis2PX6e4XOtShtMwtO68U8U2oOQ==
X-Received: by 2002:a05:6512:e99:b0:545:c51:4a0f with SMTP id 2adb3069b0e04-54838edd8e6mr1785885e87.4.1740155876184;
        Fri, 21 Feb 2025 08:37:56 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5461dea980dsm1758346e87.63.2025.02.21.08.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 08:37:54 -0800 (PST)
Date: Fri, 21 Feb 2025 18:37:52 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 14/15] drm/msm/dpu: support plane splitting in
 quad-pipe case
Message-ID: <5sio6so2dcdadxps4russkuk4i4duui3oxcl3aeiafkbsw4ag2@g6l42epivgpz>
References: <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-0-c11402574367@linaro.org>
 <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-14-c11402574367@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-14-c11402574367@linaro.org>

On Mon, Feb 17, 2025 at 10:16:03PM +0800, Jun Nie wrote:
> The content of every half of screen is sent out via one interface in
> dual-DSI case. The content for every interface is blended by a LM
> pair in quad-pipe case, thus a LM pair should not blend any content
> that cross the half of screen in this case. Clip plane into pipes per
> left and right half screen ROI if topology is quad pipe case.
> 
> The clipped rectangle on every half of screen is futher handled by two
> pipes if its width exceeds a limit for a single pipe.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c  |  11 +++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h  |   2 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 134 +++++++++++++++++++++---------
>  3 files changed, 107 insertions(+), 40 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

