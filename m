Return-Path: <linux-kernel+bounces-410359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4259CDA5B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 09:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F478283560
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 08:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE7218D620;
	Fri, 15 Nov 2024 08:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bE8vh6w8"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC7518C92F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 08:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731658624; cv=none; b=LQJB3gr0qzKek/EecVjIdKj7ve/PTm2iUm+DWJNw5gRqEaX2Ft74xttld2AutQ1z1g2rclnhQA0gMdjG7cXQQkT5CHKTsDMHIFrybFt4qvRUsHiMtOqNTIzHrjT1YTdRxN174EDdrUhFTG6p25ZMwWbBzqlE4LfrdV7jTSLJHzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731658624; c=relaxed/simple;
	bh=PiOu4eRXB7bdpP5Ph/gxs/KP6wFJPt3Dns/Ve/nnvjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7CHtM6fWiDkAUZ13102yYUHKTJTDARY+Prx5UNUzIrXW+ht2ShjgQJmvQ7bdeG6CKPd3JzPBJX/H4ycHz61g4tryeox31446SaYI0hbjJOzpfM7zOb7VDWwGsLL3iphYNNeu/XVGzv06YyAZdBrSQlZsUf7SaIgNUamueLwkwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bE8vh6w8; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2feeb1e8edfso22004781fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 00:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731658621; x=1732263421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t2YkCRNrovYnwQATz/pIkkwhc17h8ivPooAcqDnALro=;
        b=bE8vh6w8SBcihsyG8X/QaGHgYXHmT9crCuRVTJ5mPiiigKt6yitsFdlspkWg3NpadY
         VLvF5E6a3kQBpGMumFuXpEeU6uOW0Vxe+kQOht8AitCn7s1iLPdYEYmc3Opu6tdqBaoR
         /T6HuDI9w+smf38SmjAWEIKKZ8ZCZjx31ABc9JCbXsuBtMcS57K3EVHPW7KeaWS6S36x
         4t4qkYIshg9isoj1S51sBWoVyXOhLvnSQMfIbSXjQ3yw74LrVJtposIdNv5s+DKRfTj2
         Tk4xaPFZLkHjsv9IDjnXHznB9IMZgMEZO+QZosKsCrvggxUsjMVn+HUDcH05ZXKHVGrH
         pO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731658621; x=1732263421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2YkCRNrovYnwQATz/pIkkwhc17h8ivPooAcqDnALro=;
        b=gxK1Fp6m1VYNcY61j8cOgGAGs8sMPTykcO5ZI4PgVU7YLZNWaiAf0hHavMLFec0o4H
         lqghsnEYVbl+VdhaMuqhtqGkdB6/wjunczj6PBGwr8/cfa3mD5SO2WyyLmhov/C1mmhp
         osW5qZtcLMnZjuHhfoVhX51CpLl7hYlbPjw2ldk5xG7forrVeLwTeGQ7jz/dU1BsyJcf
         AoStQJH85FBUZC/TATtNbgf9bK9wkF8FWx/8p1x5NOUdiJiYBWVRp78O2QBx0KPGz+pQ
         q7Y8fFEiDhkadnytiTzllTlzytf6kKZzIDWEchQ+0+YY4OSEjKcCKu6WoaUxM1s41E+D
         eRSg==
X-Forwarded-Encrypted: i=1; AJvYcCVuXnAdb15hcEGb0BBpGVf0NRUcLSD25fWyF0qx7n6zxRHB/876nkZOznLhRfygXt3VmH5HFMrrFeEjfRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ9a58OJgX8WEBYDypow2y4U4O5QvntYA0ntImu4NFyKTDibSH
	I3Bm8wELpn6u1cJ7NCLEXXY4mjJ1Gd1NpmO1idmFvBwJK1TUOUb2AUg+QBxXMDjXo6ZOBc8pTGl
	m
X-Google-Smtp-Source: AGHT+IEN4mguJ0cOGoaOOQuvKuUUyE9wQYRsThtI0TzLCrOKABBDK14uGJ4xT+Uc6LzV4XrKG3hWMQ==
X-Received: by 2002:a2e:bd0d:0:b0:2fb:3df8:6a8c with SMTP id 38308e7fff4ca-2ff606710c8mr17810691fa.23.1731658620830;
        Fri, 15 Nov 2024 00:17:00 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff598a7c86sm4718441fa.123.2024.11.15.00.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 00:16:59 -0800 (PST)
Date: Fri, 15 Nov 2024 10:16:56 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Stefan Ekenberg <stefan.ekenberg@axis.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH] drm/bridge: adv7511_audio: Update Audio InfoFrame
 properly
Message-ID: <nramdgi4pziet3ypwdi32zolnhdzualv4rpov372s4mfsakdhs@7qjro2oaef7i>
References: <20241113-adv7511-audio-info-frame-v1-1-49b368b995a5@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113-adv7511-audio-info-frame-v1-1-49b368b995a5@axis.com>

On Wed, Nov 13, 2024 at 08:38:11AM +0100, Stefan Ekenberg wrote:
> AUDIO_UPDATE bit (Bit 5 of MAIN register 0x4A) needs to be set to 1
> while updating Audio InfoFrame information and then set to 0 when done.
> Otherwise partially updated Audio InfoFrames could be sent out. Two
> cases where this rule were not followed are fixed:
>  - In adv7511_hdmi_hw_params() make sure AUDIO_UPDATE bit is updated
>    before/after setting ADV7511_REG_AUDIO_INFOFRAME.
>  - In audio_startup() use the correct register for clearing
>    AUDIO_UPDATE bit.
> 
> The problem with corrupted audio infoframes were discovered by letting
> a HDMI logic analyser check the output of ADV7535.
> 
> Signed-off-by: Stefan Ekenberg <stefan.ekenberg@axis.com>

Missing Fixes tag,

> ---
>  drivers/gpu/drm/bridge/adv7511/adv7511_audio.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
> index 61f4a38e7d2bf6905683cbc9e762b28ecc999d05..8f786592143b6c81e5a434768b51508d5e5f3c73 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
> @@ -153,7 +153,16 @@ static int adv7511_hdmi_hw_params(struct device *dev, void *data,
>  			   ADV7511_AUDIO_CFG3_LEN_MASK, len);
>  	regmap_update_bits(adv7511->regmap, ADV7511_REG_I2C_FREQ_ID_CFG,
>  			   ADV7511_I2C_FREQ_ID_CFG_RATE_MASK, rate << 4);
> -	regmap_write(adv7511->regmap, 0x73, 0x1);
> +
> +	/* send current Audio infoframe values while updating */
> +	regmap_update_bits(adv7511->regmap, ADV7511_REG_INFOFRAME_UPDATE,
> +			   BIT(5), BIT(5));
> +
> +	regmap_write(adv7511->regmap, ADV7511_REG_AUDIO_INFOFRAME(0), 0x1);
> +
> +	/* use Audio infoframe updated info */
> +	regmap_update_bits(adv7511->regmap, ADV7511_REG_INFOFRAME_UPDATE,
> +			   BIT(5), 0);
>  
>  	return 0;
>  }
> @@ -184,8 +193,9 @@ static int audio_startup(struct device *dev, void *data)
>  	regmap_update_bits(adv7511->regmap, ADV7511_REG_GC(0),
>  				BIT(7) | BIT(6), BIT(7));
>  	/* use Audio infoframe updated info */
> -	regmap_update_bits(adv7511->regmap, ADV7511_REG_GC(1),
> +	regmap_update_bits(adv7511->regmap, ADV7511_REG_INFOFRAME_UPDATE,
>  				BIT(5), 0);

Should the REG_GC(1) still be written?

> +
>  	/* enable SPDIF receiver */
>  	if (adv7511->audio_source == ADV7511_AUDIO_SOURCE_SPDIF)
>  		regmap_update_bits(adv7511->regmap, ADV7511_REG_AUDIO_CONFIG,
> 
> ---
> base-commit: 59b723cd2adbac2a34fc8e12c74ae26ae45bf230
> change-id: 20241108-adv7511-audio-info-frame-54614dd4bf57
> 
> Best regards,
> -- 
> Stefan Ekenberg <stefan.ekenberg@axis.com>
> 

-- 
With best wishes
Dmitry

