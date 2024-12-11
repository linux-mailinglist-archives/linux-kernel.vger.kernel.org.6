Return-Path: <linux-kernel+bounces-441988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D6D9ED679
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFBDA1883129
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D52D2594A5;
	Wed, 11 Dec 2024 19:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MzGtvK3c"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D5D259483
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 19:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733944928; cv=none; b=YNh015Ks47+F44QxiSwHlB46N2ZA3NDSY8ZgDvHe9G39lNfJ+/rxMzoUEYWZ38aiPDTc+Erlp753OUM67goke9Pb/4Nrtsuxfojrx6pIff+UNFebquXQwMD3vhkKg0nvk3vuX3C1qJeJ99chpPNd1r/BZJm9Q2JVTLiYGPbKeuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733944928; c=relaxed/simple;
	bh=11evcTn2jA7V+NZsSFqxVqumc3HPnPBemNUZBzUxFOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCQD+27cx+CUqiztVlGZxEKxY03e4Qg5Srepkp9mAJNOLqPQhaBS3q66iJN1hUPSFDnIbMCBl+SoIOWf/FBStybROQXELG2cOlXJWwafHsKc/8XMUu0rlHDKadFOnaWolI5l8b3bHtLrP5QWgkyW13P/g8fyGTmChDGCUhXPDKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MzGtvK3c; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ffa8df8850so70978321fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 11:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733944925; x=1734549725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fhMIxqS4yJy4TMfF6IpImxcWZLV7gqt0icqJ+XQLDEs=;
        b=MzGtvK3cjtRIrnlvgucLSMR1ApKqUkQ/VtN6mxhZiqnr2TmGobWrA5sx69lV1AUrB0
         KfiXiSvoQ9OrIqIKdVMv7+bif08bFSLbomKKFsjgBWII9eDK8zYwPhJdaNmKCX8Z3EVo
         wQlmMXUYSJHphIZeNa5K8TxZgoT5TsmMwSH2gPISIBwJC1qn1A+ljoM6n3AHb6iOYPbY
         dgkbY5+v6z4Liqh+VeY0/dmIX+k7AACIBVpLNdNgk/pKViMw9XPKzOl5QY/94zrDFQTW
         eAE8mjx7Zs5mGT9vxTcA+SAxuH2uQlAWNtZh08YUK3kF4mJXCVTF0YnqoE1clFaZ7keI
         kxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733944925; x=1734549725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhMIxqS4yJy4TMfF6IpImxcWZLV7gqt0icqJ+XQLDEs=;
        b=BacP26S4X9qLitogq99ybycI3fmYuwRpd9uEdg9M2K5u5qF7jYbGJ6+d92fulJiTpl
         RXc6AtboacdrgXZOXsfGNGT5F/QNvGVy9EHTAPmFcajIvBZHoZpdDYLe7bXQaTz4FUD3
         +VWdSIwy61XbWRq8ZA43ff41JiHuVHZPrV9mI/31ktXpqHArZI9qrGZMIbKdLQSw8h0j
         78otFcj86za6wjraIAaDpJq3Wrv71n7FwWLnI6i0yyHV03Xc7fCMQiWgJa0S+ZgsviFA
         eRAZFLJwqbsdi9+RyScuaQeOMg3KqTk+fEDcNHlGPxw0LAh0kgUXIIMYfZmm2OEdD0EQ
         dXKA==
X-Forwarded-Encrypted: i=1; AJvYcCU+8PAJw6NNBKkbXajC0mKlGBsCIVxxfO14RUr6OjCo0YfxFEfU2uSv7Iy3a2IrVvXex5mutdulI6arARY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrXhe46KHvsB+R4GKraqbZNQacCjhj50vPi4+i0KzD2cemdYcJ
	elWhYIm9EzRH3umKnpQDWtEL+oMZx1xqzhQAoqyKgzK0zVj/FdSWjUsc80Ce0ec=
X-Gm-Gg: ASbGncu9gatb+rBTR2IgPNozdFKw/IDM3lw+I1Ljlr7r/KT+XOKCaiCbcLfpZmnB2Rd
	kqzuG7kaAst0TXURl3QE+vAFDoeFi+hIhnHEW3Qo9m5mW9f5lbhusP6bnyHr2L2uv82w9DtP1RY
	CjnVHJbwRfUi/Nn4QPIgPzEeGK5Hh+vXj6F39ohfNTdK0LlqH9Qd734YujJr8S5GnkGVFtQLaSF
	jV2eJhSSEEClLVUmHQ93LHZ2rRRaMc+zMGRrlqVp4HWYV3qyDj2Ynext23LDTVboEm+Gf4VGqmZ
	Rx2OvJVdS4LoS/pi7CC6sxDw6bRmfhcSBQ==
X-Google-Smtp-Source: AGHT+IE7tOuuyi7X6war4XV8L7zXaUOuiy/zuezb7qOEEGBSx8kQ05R5q5SvNGFQfCAc2tJou2uPgw==
X-Received: by 2002:a19:8c1c:0:b0:540:2ff1:309d with SMTP id 2adb3069b0e04-5402ff1319cmr40692e87.34.1733944924716;
        Wed, 11 Dec 2024 11:22:04 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e38dcdd1esm1617171e87.124.2024.12.11.11.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 11:22:03 -0800 (PST)
Date: Wed, 11 Dec 2024 21:22:00 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, 
	Danilo Krummrich <dakr@redhat.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH v2 1/4] drm/dp: Add helper to set LTTPRs in transparent
 mode
Message-ID: <o6xcm7jdcay77b6kltj7zownk6je6umqlmxsuscbbubw4jlr5v@w4zuusufajwx>
References: <20241211-drm-dp-msm-add-lttpr-transparent-mode-set-v2-0-d5906ed38b28@linaro.org>
 <20241211-drm-dp-msm-add-lttpr-transparent-mode-set-v2-1-d5906ed38b28@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211-drm-dp-msm-add-lttpr-transparent-mode-set-v2-1-d5906ed38b28@linaro.org>

On Wed, Dec 11, 2024 at 03:04:12PM +0200, Abel Vesa wrote:
> According to the DisplayPort standard, LTTPRs have two operating
> modes:
>  - non-transparent - it replies to DPCD LTTPR field specific AUX
>    requests, while passes through all other AUX requests
>  - transparent - it passes through all AUX requests.
> 
> Switching between this two modes is done by the DPTX by issuing
> an AUX write to the DPCD PHY_REPEATER_MODE register.
> 
> Add a generic helper that allows switching between these modes.
> 
> Also add a generic wrapper for the helper that handles the explicit
> disabling of non-transparent mode and its disable->enable sequence
> mentioned in the DP Standard v2.0 section 3.6.6.1. Do this in order
> to move this handling out of the vendor specific driver implementation
> into the generic framework.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/gpu/drm/display/drm_dp_helper.c | 50 +++++++++++++++++++++++++++++++++
>  include/drm/display/drm_dp_helper.h     |  2 ++
>  2 files changed, 52 insertions(+)
> 


> +/**
> + * drm_dp_lttpr_init - init LTTPR transparency mode according to DP standard
> + *
> + * @aux: DisplayPort AUX channel
> + * @lttpr_count: Number of LTTPRs
> + *
> + * Returns 0 on success or a negative error code on failure.
> + */
> +int drm_dp_lttpr_init(struct drm_dp_aux *aux, int lttpr_count)
> +{
> +	if (!lttpr_count)
> +		return 0;
> +
> +	/*
> +	 * See DP Standard v2.0 3.6.6.1 about the explicit disabling of
> +	 * non-transparent mode and the disable->enable non-transparent mode
> +	 * sequence.
> +	 */
> +	drm_dp_lttpr_set_transparent_mode(aux, true);
> +
> +	if (lttpr_count > 0 && !drm_dp_lttpr_set_transparent_mode(aux, false))
> +		return 0;
> +
> +	/*
> +	 * Roll-back to tranparent mode if setting non-tranparent mode failed or
> +	 * the number of LTTPRs is invalid
> +	 */
> +	drm_dp_lttpr_set_transparent_mode(aux, true);

This means that if lttpr_count < 0, then there will be two requests to
set LTTPRs to a transparent mode. Is that expected?

> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL(drm_dp_lttpr_init);
> +

-- 
With best wishes
Dmitry

