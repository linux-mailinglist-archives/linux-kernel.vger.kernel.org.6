Return-Path: <linux-kernel+bounces-309176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FF5966712
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63E83B20C9B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 16:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A021B5820;
	Fri, 30 Aug 2024 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vW+gA4aY"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3DE1B2EC5
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 16:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035944; cv=none; b=KP2g7HKeFIBN7DoIJEhy+xCMzZXRS+wiLhvFvvsdPkMbPtHgCtRO5AQEsH8nhwMsc8Jszy6sUcpcoyIHVcZXA/qcvwYYBm/c1Xj0NtJ0UWyFj/OeBhnS7s4lwK/xRnFPVDA7+/Vo6EzjUIr5e9MMbIQ9MVXo0e0NT1Y+w4vaohM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035944; c=relaxed/simple;
	bh=9CFrXcknrszqO6vd2KlpPYg8IThO+L2g2ySYied+bck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPW2mtFe1i2AoWc36WaqXnU3FT1mYg12gvoN2UmuqfJ10piINan+NaSTGDvU9VufbMhinKtutX+VkpCT23xWYsOQLRQVdAHuTv6TgJcMjjA8/B9GfbBVtXCNUVHAobvT0RaJMwfNNQ05/4XSp2sFr1+aZ6Q+TDH3svy9bTzmubk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vW+gA4aY; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ef27bfd15bso19331771fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 09:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725035940; x=1725640740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uwq4R/f36WQQ1Swarqd8PQ+Sx4wkeeX3AmNPKu0eUyY=;
        b=vW+gA4aYHPc+EChNPqOxONHp8YrUAeErN35Y2n/PlIAEa8b5Trkcc1qjhJNMQJGIXy
         tp8ksY62SKCiutYpWyBMQSIFyZL31WHRZM64r5Q4ngDG4SxAf0BTmbDkTgNhfesZa8bf
         eGhF7Ry71UdxX/wMM2Qp6MxZJAhbbFJQFdcEsaREKRmJmvNAj7TKKb5M8dcitSRv031i
         QH+Wn1fr8pcFr3I9WMpJEPB2ae8zBdcxBK1EDA8XyFRVoo5NI1p+aAI4Wt8HG4YlppOw
         tfVrIeXYI53+TUgjBkbYwc+4G0Jj4NvjcN6QwjwhNghKT1wtKCtoNkAPA6QR8F8C/SAc
         yDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725035940; x=1725640740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwq4R/f36WQQ1Swarqd8PQ+Sx4wkeeX3AmNPKu0eUyY=;
        b=uX22diKk/RqkwkDAvFJMfqtBWIRkZ9eNf1Bhlq+AdCPkbPDK7F44/XezIAWehKOm07
         CQu6ITd1qErDYp+htAn5z1ZOgNe18ohri7Um7upEfi0cXIQctL//m/cntwbFWJp7pCwk
         WWTx7T7LXrTK6+kh95zUeTKHF3kB4Wgkw1Jw0Q0vmga7ppuY2t/5c7D4M1yMpmahTEJF
         p4v8CuBf+dVAKK+wVf1UTZIaAD++qMoah/ye9+8hIWL+pXKxwoM458D6mxieNKKmqtye
         HHwBK2LEbTHb7D6eS2S7HWR91ds+IqgdTpHG/tzOPu1QuIJHblGkgr12BpXieQppEKjj
         cKsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+HR9XbADslVeQGYupo31H3hsqbdorcucQWDrAbm55FVnlZyeW4t0Sqh4oT790ey+sVcxY2ePkUebf3Sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YziUAqLtxNk2LmkFiA04ibOiYHM1P+tNGTo+YK6orqrJm7IJbUa
	/ImWV51+JqouMKqUub+6vuksF+LsSWemVYbw1Hjvkc+dZ2xHrmXSFmNRE+SE0+c=
X-Google-Smtp-Source: AGHT+IGXlaawo+aNd8bvyU9hJTs0LcQHomL+gI7bfl9YYFu3/2gV7tZKCkjm/N27yB8W8cQUyGkfZg==
X-Received: by 2002:a2e:3213:0:b0:2f3:f6fa:cfd2 with SMTP id 38308e7fff4ca-2f6106d6968mr40049701fa.25.1725035939563;
        Fri, 30 Aug 2024 09:38:59 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f615194f19sm7176211fa.130.2024.08.30.09.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 09:38:58 -0700 (PDT)
Date: Fri, 30 Aug 2024 19:38:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, quic_abhinavk@quicinc.com, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, quic_ebharadw@quicinc.com, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Rob Clark <robdclark@chromium.org>
Subject: Re: [PATCH 02/21] drm: print clone mode status in atomic state
Message-ID: <e3moledbfob2xkgxpbta3onlzc5yi6u7cbsmuo5ao4qq7nyyhj@lr32vqnjzkbi>
References: <20240829-concurrent-wb-v1-0-502b16ae2ebb@quicinc.com>
 <20240829-concurrent-wb-v1-2-502b16ae2ebb@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829-concurrent-wb-v1-2-502b16ae2ebb@quicinc.com>

On Thu, Aug 29, 2024 at 01:48:23PM GMT, Jessica Zhang wrote:
> Add clone mode status to the DRM atomic print state
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/drm_atomic.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 07b4b394e3bf..145d6a758d4d 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -455,6 +455,7 @@ static void drm_atomic_crtc_print_state(struct drm_printer *p,
>  	drm_printf(p, "\tconnector_mask=%x\n", state->connector_mask);
>  	drm_printf(p, "\tencoder_mask=%x\n", state->encoder_mask);
>  	drm_printf(p, "\tmode: " DRM_MODE_FMT "\n", DRM_MODE_ARG(&state->mode));
> +	drm_printf(p, "\tin_clone_mode=%d\n", drm_crtc_in_clone_mode(crtc->state));

We have encoder_mask two lines above. What is the benefit of having the
separate in_clone_mode?

>  
>  	if (crtc->funcs->atomic_print_state)
>  		crtc->funcs->atomic_print_state(p, state);
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

