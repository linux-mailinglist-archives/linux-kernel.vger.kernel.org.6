Return-Path: <linux-kernel+bounces-410349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED9C9CDA42
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 09:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0807B22C46
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 08:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C2718A959;
	Fri, 15 Nov 2024 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j7xyfClW"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428C352F71
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 08:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731658264; cv=none; b=UeBPkbdG8kM8LHLmNhG3nKU4puMWhcI4Q7AN9jjxYD02KW5HhlqQEHrvKxb8QGUL5X9ZV1NSmxsT0B00H2JecC2lBRjcseEqlKPXATLgqitGnM42TqtHv+lhZHx/W2BCX1FvFz8gw3ZLkDk1pzYaBMRqtvF2mz46rX+HgR18HoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731658264; c=relaxed/simple;
	bh=qk3hmhtdpBsHBnvy9h5X9Uw3DW+mJdAws0jCsCuUJeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nu1HLChPbLnbwgPSeofMXr7SoyBHLU4wA3n+U9St9fQCnBD4b+IjzxkBbVj2/M66WF23v224Rl8gmUy07XErc1Vm32TNviB41MABtOHzSGbQ0Qj92H1G1MV9uMbDMEaPxOw6V2m4CojbZ2nh78Mys8FMp/tJM3kB1S9hyT/Vsdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j7xyfClW; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539e8607c2aso1566164e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 00:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731658260; x=1732263060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kwh7u5xnnm/NWxOJAx++yyoRAoW1uEF+MIYvUvWu0a0=;
        b=j7xyfClWZnqZFWuZnfZj4TTVF87cq0/SKyBaVyTlzubJzvFpVN2ys3WRQ87wwpSSA5
         Zs9sJTFI0k1TLiBoIgUGIZZSRtIeVJOwX5yxJQeFysje1QqMkAAuO+QPem8c1fCLej1T
         jG6EAiePJb8tMHp2VYMOK07Lcx9yyRbjvqajJ29iFDA0GpQD2MTTzRXrrQQLOcP5uqe6
         obP0LTxfd8KWdFbhCBlTCsEpGJVyQvritSGAk68LUDiwIN69GsmUKpisCiyM6JK3EblI
         PWRQ1HQyZmvg6ergH6+iAzMOAJT+dp/EsLM7TFiS5KEDYKw2++ko/ePk/nZpYawJCr0g
         Md4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731658260; x=1732263060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kwh7u5xnnm/NWxOJAx++yyoRAoW1uEF+MIYvUvWu0a0=;
        b=b7sTucHvEMhd2MWC+p5qgM+I04iwyXAc9M4jIZZyfUZn34KXQZYD0rf95GQgW47IsX
         OnXmSS/TCqXMxpy09qnbQ0ZHmBuGigkRUYNMXAJU/re4hYZIgRR/eMrfw5Yn9kNcG5yQ
         /CBhs7HvKlAqJJtRkn8Uo6KD4boBVGFXn6qHbRbiHxjWYwj1khZeUbr1AFf+4c3uaXfr
         TQeuQ7waDgIAWfUw70O9vOFHx9iR7/E0GkwZvGUIUqWpLhrKKEMLJzG28A9Et0hEDdKP
         d63ed4cdSlj5cQWrc3s01m3ZEu8yXCUNgzf/g2H3r5FtBIC13Joca+Fw5X6WZYqZFLwD
         Vx1w==
X-Forwarded-Encrypted: i=1; AJvYcCWWi0NwfS2FP53GNlUAICe63UMSI5nZ/ke6EZNg7BtEdAGnl05wzt47/CgwofbV3pYOn6FDDbwk/8K1daQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDRfc+tzQIDCxqbwqro4ggP/k3sWGTPjobDVmK+ONs9Lz7XcUt
	hf52qGaPtcm8i6l6BzlbZOnSpKgutS87p1SBuDdg66qhLNa4jHUU0Y15iwj+nbs=
X-Google-Smtp-Source: AGHT+IHxTCDUm2pw5A5a5bUpPHRsLv6nmhaSD0bEck6bFFxWDkqDt7K6yt+BTsbtTKUO/0vNYYpGoQ==
X-Received: by 2002:a05:6512:3d23:b0:52e:f2a6:8e1a with SMTP id 2adb3069b0e04-53dab2a6feamr638144e87.29.1731658260231;
        Fri, 15 Nov 2024 00:11:00 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da653e1a9sm477797e87.185.2024.11.15.00.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 00:10:58 -0800 (PST)
Date: Fri, 15 Nov 2024 10:10:56 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Stefan Ekenberg <stefan.ekenberg@axis.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH] drm/bridge: adv7533: Reset DSI receiver logic
Message-ID: <hukcjydehdbkk4xn3c62au4az4tlfjlkmxhq5db5xwabvxhyba@nf5tzddcbikv>
References: <20241113-adv7533-dsi-reset-v1-1-6c1069e35fd3@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113-adv7533-dsi-reset-v1-1-6c1069e35fd3@axis.com>

On Wed, Nov 13, 2024 at 08:40:15AM +0100, Stefan Ekenberg wrote:
> Reset DSI receiver logic during power on. The need for this change was
> discovered when investigating issue with ADV7535. The symptom of the
> problem was that ADV7535 continuously outputs a black image. This
> happened for about 10% of the times that ADV7535 was powered on. The
> rest of the times the image was as expected.
> 
> The solution in this patch (placement of reset and sleep time of 200ms)
> is implemented as outlined by the Analog Devices support team.

Is this reset sequence specific only to adv7535? Is it applicable to
adv7533? adv7511?

> 
> Signed-off-by: Stefan Ekenberg <stefan.ekenberg@axis.com>
> ---
>  drivers/gpu/drm/bridge/adv7511/adv7533.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7533.c b/drivers/gpu/drm/bridge/adv7511/adv7533.c
> index 4481489aaf5ebf164313c86cbf3447d2d7914ab9..93085c2b872ed98f4ee394236dc66c568c0e5ccf 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7533.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7533.c
> @@ -67,6 +67,15 @@ void adv7533_dsi_power_on(struct adv7511 *adv)
>  {
>  	struct mipi_dsi_device *dsi = adv->dsi;
>  
> +	/*
> +	 * Reset DSI receiver block logic to avoid ADV7535 startup problem.
> +	 * Without this reset it sometimes continuously fails to receive
> +	 * incoming DSI packets and outputs black image.
> +	 */
> +	regmap_write(adv->regmap_cec, 0x26, 0x18);
> +	msleep(200);
> +	regmap_write(adv->regmap_cec, 0x26, 0x38);
> +
>  	if (adv->use_timing_gen)
>  		adv7511_dsi_config_timing_gen(adv);
>  
> 
> ---
> base-commit: 59b723cd2adbac2a34fc8e12c74ae26ae45bf230
> change-id: 20241108-adv7533-dsi-reset-488c6fbb5e42
> 
> Best regards,
> -- 
> Stefan Ekenberg <stefan.ekenberg@axis.com>
> 

-- 
With best wishes
Dmitry

