Return-Path: <linux-kernel+bounces-183069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5D18C9417
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 10:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 594D9281754
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 08:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526232BAFC;
	Sun, 19 May 2024 08:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hZgN99hA"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CE710940
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716108034; cv=none; b=fpwGT7oy7BQIb1ZMMJloCiOQF8LbimhIe4OAchMIsiPTxd7uYZt5PRE+ZcGW1Sexe59DPdUHbQi1KI+D2JeGyyd93SF7SIzZaOYNmUkhvp5BapqDzLeS+cgPjv9dAOVAzLyLh0vcvc+08+17Yt3d2eUxD7o4maHlOWGm/rV7vSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716108034; c=relaxed/simple;
	bh=YRpNzQ5zShBeLJ7EHFOzaPwGXY60cRr8c2PrAP1MZRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7lV5k4E3yJl267lqhg4WpnwvG9majh7azid9AV2uN0V8W59u9VkW4v3rEcnKK8xqFrsw6LwhgSf+jGxN1P16CYQFQhz1wFdauq4BOdU7d209v21qVXVbtZe2feS3kyrcZVggMm7+9ylEd/LU/VJL4q7RlVPqoA/xdvPy8ZbWfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hZgN99hA; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e576057c06so23011861fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 01:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716108031; x=1716712831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MgTrllwDYHTgB7C+QKVDFFRer7No5HD5l0LPXbNp0Rc=;
        b=hZgN99hAJMzaOKtrm0NUsc9bA+zKWrIqWH3aoBvT8L5gDlOPV5veWaT+4ACSnTyBP/
         hog1bB3u0o2VwgzmtFYJErcIcMG9xqmPLb7RkQnMiFGVslE78Qr0gd2pqovSTx6lF72i
         sjNjy2dCnorAEtkKB/h8hRtNTp6jOA/qkg+kbTynP6Ax6DBL3TykFnAjk/A/JF71XuMP
         LsYSRone+cjezvacoXhxYvelC6T0QVyqIfIODuhHSZj8c5KL6ApSm4RoZBOyRbem4KCg
         vwKX2gtrIkOd3qV58WKIFfMl186aikgzMH4C7azK+7QMY2w8OvpUtksTqW4QmDknG/Un
         naIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716108031; x=1716712831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgTrllwDYHTgB7C+QKVDFFRer7No5HD5l0LPXbNp0Rc=;
        b=aJoQoRnnARKSxHhQS8dbpPTK/H3H84h13lnE6bXAnTft75koB+GNb5dc4z7Wl8RhR9
         s0bcaLwE3fmb6Yzvn8CNKRPyrueKV0qxcB0FAn6umO3b4l6gfkFXJcdnWqgman0OkFSp
         +HXRuBAACEmYUskwpVsb/h+wbcQqJqZCqPLwdg3g5ZUi7BjCdk9HJK985bo0rHfzGkEk
         xMttnMqzJRwv1NEejUGe91bHxmeGgVQ3xqCiagm68nm/fu/RFAXNpMNwM9mknL0Olyf4
         TfkpD8/UKMQjtC2VsVIYdK9x6GXjkMpeXaCDXDmsXcLHeCiQ01cOzE03qf91bLG9B6rN
         jWkA==
X-Forwarded-Encrypted: i=1; AJvYcCXfIba6W/r+Ba3+Up0WxIQ79soQsBp14SfIyiysaT8/J6Zozo3fhphrZJP3t1XJkTCSInKx5Fbibp0Tnb2kku5POEOm3sqAHSh3tMwL
X-Gm-Message-State: AOJu0YxP7IY/sx3Zqho0WN3X/+2paQ9BJkJr+kHj2zrMAM9PxxQDxMYK
	d4mcWe5wdlcDNo+MnsCki7u3bbeCs8z3VJt29v/jD/wP7Ap3xOcRixmpsixyrhw=
X-Google-Smtp-Source: AGHT+IEj+o0GE3iSfy5vy0xWlDi14/h6b+B2BzuNrvjjBdZo1C91BvTjjcT+ES/qsBFTc1EsXLX9fg==
X-Received: by 2002:a2e:960f:0:b0:2df:b7cf:9607 with SMTP id 38308e7fff4ca-2e51ff4d030mr186327031fa.22.1716108031394;
        Sun, 19 May 2024 01:40:31 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e4d0bbd57fsm29637451fa.22.2024.05.19.01.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 01:40:30 -0700 (PDT)
Date: Sun, 19 May 2024 11:40:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Bjorn Andersson <quic_bjorande@quicinc.com>, Connor Abbott <cwabbott0@gmail.com>, 
	Ruan Jinjie <ruanjinjie@huawei.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/msm: Add obj flags to gpu devcoredump
Message-ID: <npo6qfweuwlo36gsrseb2oldsqpuv6z2soie3rt4u4zmoxdyzf@hlwx7zd22osl>
References: <20240513155150.166924-1-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513155150.166924-1-robdclark@gmail.com>

On Mon, May 13, 2024 at 08:51:47AM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> When debugging faults, it is useful to know how the BO is mapped (cached
> vs WC, gpu readonly, etc).
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 1 +
>  drivers/gpu/drm/msm/msm_gpu.c           | 6 ++++--
>  drivers/gpu/drm/msm/msm_gpu.h           | 1 +
>  3 files changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

