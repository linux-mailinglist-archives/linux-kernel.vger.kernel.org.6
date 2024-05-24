Return-Path: <linux-kernel+bounces-188585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 973C18CE3EE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 11:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3741128237B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C994F85931;
	Fri, 24 May 2024 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cuRcJ3l/"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BA66EB4B
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 09:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716544581; cv=none; b=AdpoXnlBt8QJ04jeXYhjE827onl5kt5GL/H0juKMcI8IMSGd9f57NuqeUnMA2Rt8PC5cWCF8EiSWCBLrxtVQuLehija8NhQ0jzrky2tLqc42CZ7Zoe0+fX/5k2ImzAltdpbfqSaol2WXI2jZjnpQoKLTTMo8IwjHLohoaKNwpkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716544581; c=relaxed/simple;
	bh=iRu9e78NdcDnTBDCCkCGyMazX6AFWYokoLWk7OrbVCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gs4FlS9GPyuoTsQWs+E6UxD+MWgt5eRtqEMMQOiSNnScwdqwWNseHIzxzLnzcxwts3ec33smOEhFRxStszBqfN/LTfAZNXiWnwbsxFegmfoOTxitbFEZ1ayd5rG6YuOQR8O9kwTJTJBV7aI6iKtkBB0rBzunhqRhKd9H5e/e8cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cuRcJ3l/; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-529646df247so568872e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 02:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716544578; x=1717149378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OT/BHu21xlzrZaPBXSQr5kcpxtnJHEb0rcd2Xou+Ygk=;
        b=cuRcJ3l/rB43XH+eMxwW9dD6AtKvzg03JG2kHqqYc5xxUMktUm7V5P/sEPGlQIgHPf
         toYkjCU12uEC0VXyd3XBpBD+izMProTr9VoRG+uMjQxC2Xj367qLykNz3R6xPemU/pLW
         AGhcfl+uBG3baq2iFJ4fi1sKaleDb4HJYZNR8pIfHUH31SFBjU31hAMdu2w4SlnjJoVd
         tYYKMdX1+Ho0Uv2WeBrr+7aXLoYz8Bknh6p982tIBFXg1K291pbDGJmlQR8jZXUytr+j
         uRqMqJq0A4vdwwuWVxa3r/7aCqEcWJwvl/UvAo2vR/A/WEaJHVOdDQzbEwKeZbIRkjOb
         Xrvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716544578; x=1717149378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OT/BHu21xlzrZaPBXSQr5kcpxtnJHEb0rcd2Xou+Ygk=;
        b=GQp6Jv6xCVNuCAGskocbhbwuR3e+UfnPu0zMY6PrFkKF/IIgaadrSfO0wPc9O8FzCL
         WWaVjnitx5C5XgX+rm4PGR/MoMX4+Mkfv44intt8hSRsW5vaLUJVff+mYqzovXzgXjQY
         5/GuVaon4Y4NvhvK9ApLDTNaMKu8YBBV6SfxmfpWyZyUalNJn1eSDg2odggxULeeVKrC
         MwgmY2gIRA+nvgI7rm5JDoVLDddcJj3ihzGvV+rwg91qnq127hrPrgROT9P+3SQzyj+r
         h5SsI7LDrloLZqYCYBH0jihS39orsHrYil3m1RTtvPowxOvRnBGhBQXW23bUNGo1D3Fw
         6fpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHoEe8krFwC7N/lBxzTKj89qii7cvjc/mtkCCDvwntlHe/uNykcVGunnXgavx5hqXwZOibBXj/FWtivllTUlcZVrNQDKYJwhdN4ora
X-Gm-Message-State: AOJu0YyLDL1HfKsp8G158vuRUsdqyl875ZbFxFL9smltNdd9PPZac6nP
	oEQpQh0eHjmVShbHgXLMg01VON5iO2Z3+emnhgoBaCGuKHxl8tItoSTAZMRDJfc=
X-Google-Smtp-Source: AGHT+IFJQH7uxP0T6n5vJtUthNYdkzKrumtOMJhrf7mDjGc72AlYIsw25VDwEtSyryl4d5bZ1ypGUw==
X-Received: by 2002:a05:6512:535:b0:51f:315c:75e0 with SMTP id 2adb3069b0e04-529666d9470mr1016847e87.44.1716544577665;
        Fri, 24 May 2024 02:56:17 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5297066bb25sm142379e87.154.2024.05.24.02.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 02:56:17 -0700 (PDT)
Date: Fri, 24 May 2024 12:56:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Francesco Dolcini <francesco.dolcini@toradex.com>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v1 2/2] usb: typec: mux: gpio-sbu: Make enable gpio
 optional
Message-ID: <5of64nmgpotr7fu66urgko5gfvr4ffhmff4dgkagkdvwh2dywk@etlw6rsmhki6>
References: <20240524071034.4441-1-francesco@dolcini.it>
 <20240524071034.4441-3-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524071034.4441-3-francesco@dolcini.it>

On Fri, May 24, 2024 at 09:10:34AM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> The enable gpio is not required when the SBU mux is used only for
> orientation, make it optional.
> 
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  drivers/usb/typec/mux/gpio-sbu-mux.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux/gpio-sbu-mux.c b/drivers/usb/typec/mux/gpio-sbu-mux.c
> index 374168482d36..cf44259980a1 100644
> --- a/drivers/usb/typec/mux/gpio-sbu-mux.c
> +++ b/drivers/usb/typec/mux/gpio-sbu-mux.c
> @@ -47,7 +47,7 @@ static int gpio_sbu_switch_set(struct typec_switch_dev *sw,
>  		break;
>  	}
>  
> -	if (enabled != sbu_mux->enabled)
> +	if (sbu_mux->enable_gpio && enabled != sbu_mux->enabled)
>  		gpiod_set_value_cansleep(sbu_mux->enable_gpio, enabled);

I think it's safe to pass NULL to gpiod_set_value_cansleep().

>  
>  	if (swapped != sbu_mux->swapped)
> @@ -66,6 +66,9 @@ static int gpio_sbu_mux_set(struct typec_mux_dev *mux,
>  {
>  	struct gpio_sbu_mux *sbu_mux = typec_mux_get_drvdata(mux);
>  
> +	if (!sbu_mux->enable_gpio)
> +		return -EOPNOTSUPP;

Can we skip registering the mux if there is no enable_gpio? This can
save users from the unexpected errors during runtime.

> +
>  	mutex_lock(&sbu_mux->lock);
>  
>  	switch (state->mode) {
> @@ -102,7 +105,8 @@ static int gpio_sbu_mux_probe(struct platform_device *pdev)
>  
>  	mutex_init(&sbu_mux->lock);
>  
> -	sbu_mux->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
> +	sbu_mux->enable_gpio = devm_gpiod_get_optional(dev, "enable",
> +						       GPIOD_OUT_LOW);
>  	if (IS_ERR(sbu_mux->enable_gpio))
>  		return dev_err_probe(dev, PTR_ERR(sbu_mux->enable_gpio),
>  				     "unable to acquire enable gpio\n");
> @@ -141,7 +145,8 @@ static void gpio_sbu_mux_remove(struct platform_device *pdev)
>  {
>  	struct gpio_sbu_mux *sbu_mux = platform_get_drvdata(pdev);
>  
> -	gpiod_set_value_cansleep(sbu_mux->enable_gpio, 0);
> +	if (sbu_mux->enable_gpio)
> +		gpiod_set_value_cansleep(sbu_mux->enable_gpio, 0);
>  
>  	typec_mux_unregister(sbu_mux->mux);
>  	typec_switch_unregister(sbu_mux->sw);
> -- 
> 2.39.2
> 

-- 
With best wishes
Dmitry

