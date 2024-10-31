Return-Path: <linux-kernel+bounces-390967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2120C9B80A6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2CFF28132C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEBD1A0B00;
	Thu, 31 Oct 2024 16:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kTHDAcVh"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C5D1A3BAD
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730393672; cv=none; b=m0BJVWyvz6Z8j0Y1dr/aO7mG0+n+Qoq0qPrWi3SEKAbSi5jV7XBSYbPqqU+lSz9hZ8Gm6TSQnjgK6O/EcVaFRyVHSnNGj01XgwytW1nAjLB5dtZFrQ/XZKHNGvylqBKw2Gw4VIsxbXM7yN+FmsCScPjJJMG0H6KvOW8YtsoNXaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730393672; c=relaxed/simple;
	bh=jM/qlR8PUxUcY2HlBiCsuJqhEkkRRdosdYqvPQcIuHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlWGIMGGPWX1TmMgo1e/FRTonX+5HNlK4J3n4sTPOZIv7J3am/dhO7K/qlM6B9tziArKDJsycvyztqhbGLZJwVZXu1dUG+yMFVBmHn6V3PSk6TleZUIGrnWVud+fENNS/3GrnBRdeA0SfwcsB+tk3esfvNgeYLM/FlNuxHeKRJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kTHDAcVh; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb587d0436so13666391fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 09:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730393668; x=1730998468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LcG1Cptwud8AIi8pa0Ca3S8gnx7zEHdaWmbNdickIkk=;
        b=kTHDAcVhStprSN05Z3aUfKX9LdaWIl5jdW5sgU10OI87i+vzaYm9YWABpjlVXy+SZT
         EvfYy2043MLnWweT0WNN68S3D19edtVFy68cLmfJQvEgWphO5U8KflC/fiqnFWUekgQr
         vGeHft1Hu+c2YbW4bz+hHkS9wGBvd9Og2TbGr0e121EjE7uCjrfZd5eKpbYlsE09/ZcA
         rzEJdxnZwefwt6TNOAm6RNClft6XT6GcCVTAHzPhkm960fGii/GYoKGUOtg0YXp1iuFe
         M8LDeuMy5xutEg3+knaQ9/lUnsgRuAO+rvKEUUMzF8MfWyt04LCvcQNUqf+iAQk5Hi5p
         qh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730393668; x=1730998468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcG1Cptwud8AIi8pa0Ca3S8gnx7zEHdaWmbNdickIkk=;
        b=bIgWhOCO7iZiVbJQ9Y6uMs8Hag4ozXJYAeWCD3x38fvx4cUt2lUartLCoANSvF8ST+
         w6koTw2vM3ycDUwj9yATWNGPMxaCJoq2xfLX9Yf5DarqXTHtods5x+An0tp7ohcX6SG5
         xU5d1FdNwZdc3Kzda1x+inUm+Jzif4HWJ4OYWHHoALRLiS+J8TQMhv4CqHDsq+vOLG5T
         2HQVV8RaIndACiGUy5gVvWzSA7NJhRd1pdv//clNr1atCkpqFAvZ5h8F0NzG1jbl3zMm
         Z3mBo6vU+QbxR6ehdFxLPdxY74v7JcDT3jP0SmLedSoZ5rzkZXdu11aH2YrBBYotTGv8
         ZwEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqp5GVUQ825bd/7I9K+yA2D97s77OfSaVAT1zTNE4M48MjW9rXpEzaD9ZSHgOMCAYvdnUl2M1OPRAP2xE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiQV9nnZXdfzdEjUE1kC1toh3V4qbpFgU9aH18O7kkdhiABYxG
	ORJh8/qUiMXgkId0/d7gtSWkQ/reiva181S6e5MDTtBdH57wrCxwdUkfEEhdJ74=
X-Google-Smtp-Source: AGHT+IFbZzedgv73FPhHSopZrrz16kElbA7K8+QBYnMOAyeDwtCyC0BGEf/LrmGOrhd3qp//daS0zw==
X-Received: by 2002:a05:651c:1541:b0:2fb:5688:55a4 with SMTP id 38308e7fff4ca-2fedb7a2fe0mr3529681fa.17.1730393668492;
        Thu, 31 Oct 2024 09:54:28 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef6182dfsm2668051fa.71.2024.10.31.09.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 09:54:27 -0700 (PDT)
Date: Thu, 31 Oct 2024 18:54:25 +0200
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
Subject: Re: [PATCH RFC 4/4] drm/msm/dp: Add support for LTTPR handling
Message-ID: <6lpeexb5menpwrzcnmr367x4lmhvzyovhdybn54mnwk55ieehy@mos4oso67boo>
References: <20241031-drm-dp-msm-add-lttpr-transparent-mode-set-v1-0-cafbb9855f40@linaro.org>
 <20241031-drm-dp-msm-add-lttpr-transparent-mode-set-v1-4-cafbb9855f40@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031-drm-dp-msm-add-lttpr-transparent-mode-set-v1-4-cafbb9855f40@linaro.org>

On Thu, Oct 31, 2024 at 05:12:48PM +0200, Abel Vesa wrote:
> Link Training Tunable PHY Repeaters (LTTPRs) are defined in DisplayPort
> 1.4a specification. As the name suggests, these PHY repeaters are
> capable of adjusting their output for link training purposes.
> 
> The msm DP driver is currently lacking any handling of LTTPRs.
> This means that if at least one LTTPR is found between DPTX and DPRX,
> the link training would fail if that LTTPR was not already configured
> in transparent mode.

It might be nice to mention what is the transparent mode, especially for
those who do not have the standard at hand.

> The section 3.6.6.1 from the DisplayPort v2.0 specification mandates
> that before link training with the LTTPR is started, the DPTX may place
> the LTTPR in non-transparent mode by first switching to transparent mode
> and then to non-transparent mode. This operation seems to be needed only
> on first link training and doesn't need to be done again until device is
> unplugged.
> 
> It has been observed on a few X Elite-based platforms which have
> such LTTPRs in their board design that the DPTX needs to follow the
> procedure described above in order for the link training to be successful.
> 
> So add support for reading the LTTPR DPCD caps to figure out the number
> of such LTTPRs first. Then, for platforms (or Type-C dongles) that have
> at least one such an LTTPR, set its operation mode to transparent mode
> first and then to non-transparent, just like the mentioned section of
> the specification mandates.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index f01980b0888a40b719d3958cb96c6341feada077..5d3d318d7b87ce3bf567d8b7435931d8e087f713 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -107,6 +107,8 @@ struct dp_display_private {
>  	struct dp_event event_list[DP_EVENT_Q_MAX];
>  	spinlock_t event_lock;
>  
> +	u8 lttpr_caps[DP_LTTPR_COMMON_CAP_SIZE];
> +
>  	bool wide_bus_supported;
>  
>  	struct dp_audio *audio;
> @@ -367,12 +369,35 @@ static int dp_display_send_hpd_notification(struct dp_display_private *dp,
>  	return 0;
>  }
>  
> +static void dp_display_lttpr_init(struct dp_display_private *dp)
> +{
> +	int lttpr_count;
> +
> +	if (drm_dp_read_lttpr_common_caps(dp->aux, dp->panel->dpcd,
> +					  dp->lttpr_caps))
> +		return;
> +
> +	lttpr_count = drm_dp_lttpr_count(dp->lttpr_caps);
> +
> +	if (lttpr_count) {
> +		drm_dp_lttpr_set_transparent_mode(dp->aux, true);
> +
> +		if (lttpr_count > 0) {
> +			if (drm_dp_lttpr_set_transparent_mode(dp->aux, false) != 1)
> +				drm_dp_lttpr_set_transparent_mode(dp->aux, true);
> +		}
> +	}
> +}
> +
>  static int dp_display_process_hpd_high(struct dp_display_private *dp)
>  {
>  	struct drm_connector *connector = dp->dp_display.connector;
>  	const struct drm_display_info *info = &connector->display_info;
>  	int rc = 0;
>  
> +	if (!dp->dp_display.is_edp)
> +		dp_display_lttpr_init(dp);

Why is it limited to non-eDP cases only.

> +
>  	rc = dp_panel_read_sink_caps(dp->panel, connector);
>  	if (rc)
>  		goto end;
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

