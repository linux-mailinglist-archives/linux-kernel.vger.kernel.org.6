Return-Path: <linux-kernel+bounces-223441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA550911312
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91433283252
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2281BA084;
	Thu, 20 Jun 2024 20:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K/HA8cBt"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD8E2E859
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 20:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718914941; cv=none; b=DjO4RY8zsQLIeO2xA3/s32n8OzdGleRfCpMU3bZMgyd8Ju05PI7RVHXjhTeKqn6vhEwZfqtZFlO+nVJ5LfYYrcq/bSC/F1xxHiLK69X9e86hhnDmupY8nMSl4BQmfEzRaVr45BRvvx0luNL+DCNqcgVUZU+o9RyYoU9RUqDAgaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718914941; c=relaxed/simple;
	bh=lKsNVvn8g6ewzdJ/OW5IYJqCN/+v7NPYP9gkx5zEdwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/yv4Cq5usUuj98nklDyyV8JtgwYmSk+8yiYG/YlGsSt6ZrnP66lFUezdctLL3LqVquT/tOSP2T2AaEp70wkoYxI3bYo+F3tMVXBMFJsSR3Mfy3IKMvZar/r2YyPUN7h8v2kFjz4NQ9i7zJ9lSd84Dj14y96gUaP4mvkd+goKcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K/HA8cBt; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e95a75a90eso13236371fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 13:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718914937; x=1719519737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lOvYMghuPF6rvmiNqyAE5UU+Cu5JdSGdpel/er+AFsg=;
        b=K/HA8cBtdaP1qKbP8p531oBKSfHRTGCz/2bNjnFTNbVMFIzmP9U7bSLz+/bjgP3iPV
         5YSz+b0L/lPvwPVVjgJ+XmdtuWLKbL1/DCJjILW9+WqcSUviFQIgcOEPXOCCpag2RPjC
         VtIZ8ZOBtAGYK8sT0ZtDnZCiVHY0L40hs+ei6AFL/UGgc48QolrJP9ZLE4EiX+blbCkc
         XUOKddNy8KVQW0YTizKHn0lHAYr0PILgqyab+wOyIvsr7k/LCZbCrZU/u3CpWCmNzVC0
         UZ2e3B8c0uARyGLNBEnVbLhxr735Ahs5IQL74e5VmeYal7cxHu+jn6kmt0z40zXVgoIc
         UyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718914937; x=1719519737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOvYMghuPF6rvmiNqyAE5UU+Cu5JdSGdpel/er+AFsg=;
        b=qIUmmF9sxg1iK7peWy0JUYBgibwB22LgxChXYAM+0Zur9bYVDnFc0P+HU1Dqc2ffCt
         IHJDJTl4mWZc90KUFMjSH26unEacdtnOGVRqY8jv6XP6/YP8EW49q+E/4g1U2enipnGG
         dv7sfWNRhB42vxo6/mlOxXNslr1214vU17cOF4XRS6xldETHJ/AKw50PyvGlrtulnR19
         IDSDGnq3uJOFV1uMLA7+A+GOgDoEgRNmwl8jzmLVEfHnC9Dam+NDiFGS8I4xuRkb6arw
         zwqOL0vb6MG2ekgaBOu+UnPWvyskue8jRyhbXEldLfR6q2ZxNW0P1eymEnI3U+JZkB8j
         BX1A==
X-Forwarded-Encrypted: i=1; AJvYcCWb5ZB0VIZbfyelD+oK8X+7mLa/WTqSiLt0CaWfbSxUtiIZVT6J/qTpNzOamhf0cF9he1sDvktHCJ1jjhUtIqRHKEsZDieFavKxfFKV
X-Gm-Message-State: AOJu0YyIyCZJT8RgZI+HUjP2r6gEzVdnsDE+RhMek4C9tYvW4IFrDnY4
	VoRi35xOCv805ZVChLDTvF4bsKCcPFr9AzXEZcBVKSMsvdWIyq3UlZWWs+Hn+kI=
X-Google-Smtp-Source: AGHT+IGiaHRg7jR/WYQboUkDnyBsqb7OqSvEkiFZuFC3QRtuiPZzbScBg4tpeD3wwsA+RSMqYyxzFQ==
X-Received: by 2002:a2e:9bca:0:b0:2ea:e773:c58 with SMTP id 38308e7fff4ca-2ec3cea10d1mr38061221fa.24.1718914937186;
        Thu, 20 Jun 2024 13:22:17 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec4d76f728sm116721fa.120.2024.06.20.13.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 13:22:16 -0700 (PDT)
Date: Thu, 20 Jun 2024 23:22:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Adam Ford <aford173@gmail.com>
Cc: dri-devel@lists.freedesktop.org, victor.liu@nxp.com, 
	sui.jingfeng@linux.dev, aford@beaconembedded.com, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] drm/bridge: adv7511:  Fix Intermittent EDID failures
Message-ID: <bsfvj5st6s3m5bvegkaq6sqrojq7obevsxf2wlffs5ewrz7hog@yrpq7azq7b6k>
References: <20240601132459.81123-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240601132459.81123-1-aford173@gmail.com>

On Sat, Jun 01, 2024 at 08:24:59AM GMT, Adam Ford wrote:
> In the process of adding support for shared IRQ pins, a scenario
> was accidentally created where adv7511_irq_process returned
> prematurely causing the EDID to fail randomly.
> 
> Since the interrupt handler is broken up into two main helper functions,
> update both of them to treat the helper functions as IRQ handlers. These
> IRQ routines process their respective tasks as before, but if they
> determine that actual work was done, mark the respective IRQ status
> accordingly, and delay the check until everything has been processed.
> 
> This should guarantee the helper functions don't return prematurely
> while still returning proper values of either IRQ_HANDLED or IRQ_NONE.
> 
> Reported-by: Liu Ying <victor.liu@nxp.com>
> Fixes: f3d9683346d6 ("drm/bridge: adv7511: Allow IRQ to share GPIO pins")
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Tested-by: Liu Ying <victor.liu@nxp.com> # i.MX8MP EVK ADV7535 EDID retrieval w/o IRQ
> ---
> V2:  Fix uninitialized cec_status
>      Cut back a little on error handling to return either IRQ_NONE or
>      IRQ_HANDLED.
> 
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511.h b/drivers/gpu/drm/bridge/adv7511/adv7511.h
> index ea271f62b214..ec0b7f3d889c 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511.h
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511.h
> @@ -401,7 +401,7 @@ struct adv7511 {
>  
>  #ifdef CONFIG_DRM_I2C_ADV7511_CEC
>  int adv7511_cec_init(struct device *dev, struct adv7511 *adv7511);
> -void adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int irq1);
> +int adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int irq1);
>  #else
>  static inline int adv7511_cec_init(struct device *dev, struct adv7511 *adv7511)
>  {
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c b/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c
> index 44451a9658a3..651fb1dde780 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c
> @@ -119,7 +119,7 @@ static void adv7511_cec_rx(struct adv7511 *adv7511, int rx_buf)
>  	cec_received_msg(adv7511->cec_adap, &msg);
>  }
>  
> -void adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int irq1)
> +int adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int irq1)
>  {
>  	unsigned int offset = adv7511->info->reg_cec_offset;
>  	const u32 irq_tx_mask = ADV7511_INT1_CEC_TX_READY |
> @@ -130,17 +130,21 @@ void adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int irq1)
>  				ADV7511_INT1_CEC_RX_READY3;
>  	unsigned int rx_status;
>  	int rx_order[3] = { -1, -1, -1 };
> -	int i;
> +	int i, ret = 0;
> +	int irq_status = IRQ_NONE;
>  
> -	if (irq1 & irq_tx_mask)
> +	if (irq1 & irq_tx_mask) {
>  		adv_cec_tx_raw_status(adv7511, irq1);
> +		irq_status = IRQ_HANDLED;
> +	}
>  
>  	if (!(irq1 & irq_rx_mask))
> -		return;
> +		return irq_status;
>  
> -	if (regmap_read(adv7511->regmap_cec,
> -			ADV7511_REG_CEC_RX_STATUS + offset, &rx_status))
> -		return;
> +	ret = regmap_read(adv7511->regmap_cec,
> +			ADV7511_REG_CEC_RX_STATUS + offset, &rx_status);

There is no need for the ret variable, regmap_read can return either 0
or a negative error code.

With that fixed:


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> +	if (ret < 0)
> +		return irq_status;
>  
>  	/*
>  	 * ADV7511_REG_CEC_RX_STATUS[5:0] contains the reception order of RX


-- 
With best wishes
Dmitry

