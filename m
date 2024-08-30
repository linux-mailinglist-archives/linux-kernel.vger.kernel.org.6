Return-Path: <linux-kernel+bounces-309195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CC396673E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D15BB2694E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 16:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863FA1BA299;
	Fri, 30 Aug 2024 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="emN0ncTA"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE551B8EBD
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 16:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725036179; cv=none; b=RHAc9YjaeVPyPIFxtRmyRNNz03M+3vXZ7QKfmGXraSelvHqC+LO6wwJrKyLeZZBZwnIKps6dr2Cr2Xy8Q5+7P9dP85n1c6jqnvmXH6D9/eE0R7eJD5en9GDHTIvnCb4KMA5pnJinZnQx3OdWTGl55eanHmLQpnLQFO/80Cp0HCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725036179; c=relaxed/simple;
	bh=RsXcGhU8oABB3fLKCkcpnk7Vk50IpKb3QFG9nxtNDg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AX/AoFZDYH/OwnQ8+8PYh6CaktnoIicaK+XZSuAqlx9mBCHnscENUu/Njr8hEWgMm1I3UMYYUWNflKdtezOZZjNMMlX78Tw7wD2yGEnXMbUVNDCcGcpWZ3LZB5UZRGbhmbXX1fXsLKwNn2VeDvIMa5ZoHIvsIZgjhE/wXgCYbXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=emN0ncTA; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-533461323cdso2519820e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 09:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725036176; x=1725640976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Ti26gzK1EQz5HySKD6b54SohAjKM16M+gJtA+MrRBY=;
        b=emN0ncTAUSPFyrOoN3BTYOjNM6R2wSDgH+aqKbeyzhj6ty/VaCHtVbsXhEoCHaVpea
         o7y70lxp/8LfzuS5tkDdmC6pkvmVLQWJpbQW4VyRA+8ns4KX8DytlVWHoCIZl5EXl0pn
         k1boIV0T7I//YA7Y4nCI3op+rZrq55fdoxxMGCLZFdv2lrCeqg+ChZt44aoWSpXwOGto
         vh9VSXSM+pCd0wRrOoXoCeZ/7EhJYLC7bI+o801PeTqVJacInuhKgcWldenjS4yedgC+
         9SRzT76+LPh5ZoMdgAuxrsWmay/N/HlP7aW6jceb0Ttm0Z+AcRF3ueUjhLi48JgumEB2
         lcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725036176; x=1725640976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Ti26gzK1EQz5HySKD6b54SohAjKM16M+gJtA+MrRBY=;
        b=PinaHJnSZrBD02/FQhvRsIup9mlRBP2z44ik1qEwjyBCVyG9uEt1INq3/XHNSxzYVN
         WXw1O1+SHLxS2y3qfI4ih2ljdWq10zIwUrfi71+Z3PLoNcpXi+zz8+dEWzfBqB290PWa
         lYGFv5EQaXDTVsTP82mauKDDU6eLqd0OmBxuF1rjRMemFA7kNPrC8M1mesinbov6Nfk+
         HNUaGGfyTZh/Qv40Z3XmmyG2WoeVn1CKyd4WNLZ/s2+ftLHo8LlqQ10IYc7h59/T+bwD
         QzqfT1VRPRD5xaCQ5f4sPX2Sa8OMPZlbnUF94benMMuGPhq7RxQnHPj8jf8FGkn6eqjG
         Gx3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlxPOxhzzN3lfwgDPWkEfyV0v89a1L0VUeBWRcCwlGwZ7W5TTk980gGQXAWnK13q5EDTVIA6h737EiyTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr2Tgsug8cVjbGiSuDzlrxTvimELlA3aW3OMBBMvOnoggITnRv
	UjJ4p22hGbP56i39x2ANpMh7L3o98dBEYaKxu8xRUtsDgbFPhspfkS2t0gnCiEw=
X-Google-Smtp-Source: AGHT+IHPok1p6V+eHfwGcCeO0mQYbxw1nUP6jPzcZsijDd7LU+nuYlx/M/lyCnpp0vDdUCgJVIYcDg==
X-Received: by 2002:a05:6512:159a:b0:52c:e047:5c38 with SMTP id 2adb3069b0e04-53546b0401cmr2164051e87.15.1725036175176;
        Fri, 30 Aug 2024 09:42:55 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5354084dfc3sm680610e87.269.2024.08.30.09.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 09:42:54 -0700 (PDT)
Date: Fri, 30 Aug 2024 19:42:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, quic_abhinavk@quicinc.com, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, quic_ebharadw@quicinc.com, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Rob Clark <robdclark@chromium.org>
Subject: Re: [PATCH 05/21] drm/msm/dpu: move resource allocation to CRTC
Message-ID: <fiydda6an5a4dc2gmrj4fnti4ymkk7ntbtpq6mgushmgnzl6cp@pwtz6goteljh>
References: <20240829-concurrent-wb-v1-0-502b16ae2ebb@quicinc.com>
 <20240829-concurrent-wb-v1-5-502b16ae2ebb@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829-concurrent-wb-v1-5-502b16ae2ebb@quicinc.com>

On Thu, Aug 29, 2024 at 01:48:26PM GMT, Jessica Zhang wrote:
> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> All resource allocation is centered around the LMs. Then other blocks
> (except DSCs) are allocated basing on the LMs that was selected, and LM
> powers up the CRTC rather than the encoder.
> 
> Moreover if at some point the driver supports encoder cloning,
> allocating resources from the encoder will be incorrect, as all clones
> will have different encoder IDs, while LMs are to be shared by these
> encoders.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> [quic_abhinavk@quicinc.com: Refactored resource allocation for CDM]
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> [quic_jesszhan@quicinc.com: Changed to grabbing exising global state and
> dropped clearing num_mixers in crtc_disable]

Hmm, I still see the chunk in dpu_crtc_disable(). I think the chunk is
correct so that if there is a disable/enable pair of calls with no
intermediate mode_set then num_mixers carry over the correct value.

> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    |  89 +++++++++++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 201 +++++++++++-----------------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  19 +++
>  3 files changed, 183 insertions(+), 126 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index 4c1be2f0555f..3296b0650056 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -1091,9 +1091,6 @@ static void dpu_crtc_disable(struct drm_crtc *crtc,
>  
>  	dpu_core_perf_crtc_update(crtc, 0);
>  
> -	memset(cstate->mixers, 0, sizeof(cstate->mixers));
> -	cstate->num_mixers = 0;
> -
>  	/* disable clk & bw control until clk & bw properties are set */
>  	cstate->bw_control = false;
>  	cstate->bw_split_vote = false;

-- 
With best wishes
Dmitry

