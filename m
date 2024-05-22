Return-Path: <linux-kernel+bounces-186007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A97018CBE80
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 11:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CAB72827F1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 09:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12AF81722;
	Wed, 22 May 2024 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m0Aq26r7"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8BC6026A
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716371295; cv=none; b=U1KsoWwGREOQQjyhp8VXQGOQ2tVng0XK/dtHy/7ZUH+CoehsdWMYIFE+oAWD1icTOFWuS+9SQOIKW5tE9/rbhv2Psr+G9kn+B32pEqOnlqF9helCmZ5aQSopAGI82NfF9VZk/LlFE3oHDn4u48FQK1Nhrk+ceFzGBmyNUcJOfqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716371295; c=relaxed/simple;
	bh=omFLdolZvGc4xQSWLt7a52xcBAYC8ZG2c0FRLO/U8SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rD3g8ne52t2WuaH9BHrUeJQoxWddskuIttcSvfM8KvnJ1kr3PJk0ytvJXnPVWW0ae8kxx2Y4+lnl4ldyQNh1tnniXWrL9LDPQsaCdXPmcGWiI5agqz3Dq72OPYUUyFh7cgnqM1O7nRfN9clF6VW9R5nxaRBU1v9wslZHOfpHbOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m0Aq26r7; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52232d0e5ceso6407135e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 02:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716371291; x=1716976091; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wOYgFzdldhFOs8AkqkazEb6OybG4e8b+WL3wRmANGa0=;
        b=m0Aq26r7ArDR/ipGpuWazFc3nUYMmoM+UkcYo1kfdVlDRDDmM/FDng48cLaWhzoHbQ
         ZpjA+qEDvLUZUk9E3+iySQMNq2MK9wFwcYTUIW8W4fTvs6HSKWmXoqRIrZal+xNnv7f5
         ICzoUi3886IWcG913t2SbnBWmlL/yaN4Z2pkCKmi4cSFgzMwJV4bEG8TdF+jMy8J8xZd
         6aVbqH+rqVb2Hqm91ku3tPdJl1KMc7U41nJzoNtWBA6c0FZwbvVxNRH1nvumWpHRZlOl
         XV9sH4fJINfRMyC/MmOyH5kMdUyq+I8CiTJ3UTfC3+Hg/EkYKKWmCxoPEPMfRdEEdGZs
         UOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716371291; x=1716976091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOYgFzdldhFOs8AkqkazEb6OybG4e8b+WL3wRmANGa0=;
        b=DIN3uGSftZNUxNCEYAxmQmPpmUWJi6yDRD9t0GI5Y9feC/3kVbPqnPzhkclcUeJgns
         aghw58g0jQhlcPFSYuztLEkXuKdORiR5l/rdNf2fYaf9bG5nAcebTf0REmNIstsM6ika
         aWHfeUj4naU4qyKUUEgBjxE6dIAEO1/PwgxM/ZSH9vPlPsmEpNOS4L5rqdIjuLMmlYJS
         OlmA7zp4uxwtV25AhbSxjAOLGdaume8j+HjLSRrFWWYffUmVICkRY+kZ9CcLOeqqeHrt
         rwYLs7TUmE9KV6DmelGIn5eOmNL28S28ZghaccvI/A4zt2VwliUmxoto3zK2FDTBaC7z
         xz2g==
X-Forwarded-Encrypted: i=1; AJvYcCWsMNHvZ4w0DxDcSBa+JpAsRb3jDryaO8XLJOBnVcXD905YUzZQrqCMezgyeoNClFRoyuW8pOg02xw9r8Evy23MRO21HLJrhvduOAuP
X-Gm-Message-State: AOJu0YwmCE1Qo9asrjAZYGv6ifSxocgAq1JaleW2GO1Mi9qQwo20FLjl
	HPTLd7XD1VlpY9VUWbOU810En2aUD7Dsqx7fHaEIGdx9BGeMwM+Rjga72ahFmUI=
X-Google-Smtp-Source: AGHT+IE2KdRn8tiZE5EhAMqBZDzzCFB+zAishxFGbPK+g4iaMbgPVJWTe8n8SoI27ZkHJmcECOuQ2w==
X-Received: by 2002:ac2:5e85:0:b0:51f:d72:cd2d with SMTP id 2adb3069b0e04-526bf35cb2amr849600e87.22.1716371291176;
        Wed, 22 May 2024 02:48:11 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f35ad640sm4913602e87.61.2024.05.22.02.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 02:48:10 -0700 (PDT)
Date: Wed, 22 May 2024 12:48:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Adam Ford <aford173@gmail.com>
Cc: dri-devel@lists.freedesktop.org, ictor.liu@nxp.com, 
	sui.jingfeng@linux.dev, aford@beaconembedded.com, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: adv7511:  Fix Intermittent EDID failures
Message-ID: <idjjg2lj7labpaq55u5ttn42fcp3ryae2ctvaw4c5lqlfp2wmz@2r6tilyvqbaf>
References: <20240521011614.496421-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521011614.496421-1-aford173@gmail.com>

On Mon, May 20, 2024 at 08:16:14PM -0500, Adam Ford wrote:
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
> Reported by: Liu Ying <victor.liu@nxp.com>
> Fixes: f3d9683346d6 ("drm/bridge: adv7511: Allow IRQ to share GPIO pins")
> Signed-off-by: Adam Ford <aford173@gmail.com>
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
> index 44451a9658a3..4efb2cabf1b5 100644
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
> +	if (ret < 0)
> +		return ret;

Ok, maybe I was wrong with my previous suggestion. The code starts to
look more and more clumsy.  Do we really care about error status at all?
Maybe it's enough to return IRQ_NONE here from the IRQ handlers?

>  
>  	/*
>  	 * ADV7511_REG_CEC_RX_STATUS[5:0] contains the reception order of RX
> @@ -172,6 +176,8 @@ void adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int irq1)
>  
>  		adv7511_cec_rx(adv7511, rx_buf);
>  	}
> +
> +	return IRQ_HANDLED;
>  }
>  
>  static int adv7511_cec_adap_enable(struct cec_adapter *adap, bool enable)
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> index 66ccb61e2a66..56dd2d5a0376 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -469,6 +469,8 @@ static int adv7511_irq_process(struct adv7511 *adv7511, bool process_hpd)
>  {
>  	unsigned int irq0, irq1;
>  	int ret;
> +	int cec_status;

cec_status ends up being unset if CEC is disabled.

> +	int irq_status = IRQ_NONE;
>  
>  	ret = regmap_read(adv7511->regmap, ADV7511_REG_INT(0), &irq0);
>  	if (ret < 0)
> @@ -478,38 +480,41 @@ static int adv7511_irq_process(struct adv7511 *adv7511, bool process_hpd)
>  	if (ret < 0)
>  		return ret;
>  
> -	/* If there is no IRQ to handle, exit indicating no IRQ data */
> -	if (!(irq0 & (ADV7511_INT0_HPD | ADV7511_INT0_EDID_READY)) &&
> -	    !(irq1 & ADV7511_INT1_DDC_ERROR))
> -		return -ENODATA;
> -
>  	regmap_write(adv7511->regmap, ADV7511_REG_INT(0), irq0);
>  	regmap_write(adv7511->regmap, ADV7511_REG_INT(1), irq1);
>  
> -	if (process_hpd && irq0 & ADV7511_INT0_HPD && adv7511->bridge.encoder)
> +	if (process_hpd && irq0 & ADV7511_INT0_HPD && adv7511->bridge.encoder) {
>  		schedule_work(&adv7511->hpd_work);
> +		irq_status = IRQ_HANDLED;
> +	}
>  
>  	if (irq0 & ADV7511_INT0_EDID_READY || irq1 & ADV7511_INT1_DDC_ERROR) {
>  		adv7511->edid_read = true;
>  
>  		if (adv7511->i2c_main->irq)
>  			wake_up_all(&adv7511->wq);
> +		irq_status = IRQ_HANDLED;
>  	}
>  
>  #ifdef CONFIG_DRM_I2C_ADV7511_CEC
> -	adv7511_cec_irq_process(adv7511, irq1);
> +	cec_status = adv7511_cec_irq_process(adv7511, irq1);
> +
> +	if (cec_status < 0)
> +		return cec_status;
>  #endif
>  
> -	return 0;
> +	/* If there is no IRQ to handle, exit indicating no IRQ data */
> +	if (irq_status == IRQ_HANDLED || cec_status == IRQ_HANDLED)
> +		return IRQ_HANDLED;
> +
> +	return IRQ_NONE;
>  }
>  
>  static irqreturn_t adv7511_irq_handler(int irq, void *devid)
>  {
>  	struct adv7511 *adv7511 = devid;
> -	int ret;
>  
> -	ret = adv7511_irq_process(adv7511, true);
> -	return ret < 0 ? IRQ_NONE : IRQ_HANDLED;
> +	return adv7511_irq_process(adv7511, true);

This should be return ret < 0 ? IRQ_NONE : ret. We should not be
returning negative error via irqreturn_t.

>  }
>  
>  /* -----------------------------------------------------------------------------
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry

