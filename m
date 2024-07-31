Return-Path: <linux-kernel+bounces-269245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8ED3942FB2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FE872812D6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9187B1AE871;
	Wed, 31 Jul 2024 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WvNeu6ZJ"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50BE1AD9C3
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 13:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722431206; cv=none; b=ZLgoipAxfHvDZgyItcOwg4CmdUqco2fEPdI1kVSXfnWP55rDFMZ+12G8Dh4RFlkA/4ZG8SVutW1YpRuVWqt5+3ZBJnql1Se8C4EoUgYdRAVEXieaJwdv+DTAukLdJXywCo5yr+gs18dRWElrwe9HzMH5UmgQjnyGtgW17Rpicnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722431206; c=relaxed/simple;
	bh=kSiCcIMu6C9gTC+NlQ1+jJI4DSv9cM5ShY0D5/L2hc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgVUavUyh6PdtYSeiRgALnJHiOzqVPX55be5fpW5kKt1dDhH196/8O3d9bAa9di+58UahdYjayWa2x11WN+3CCsrNbk1J8wrp46OvpbFu9kSV8IEVUsv1ldbA2mSmeIxLFnmWqPtPlh59oIAFbJLOq359l9r30SzWOLNrBs/EkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WvNeu6ZJ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52efaae7edfso6138302e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 06:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722431203; x=1723036003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KoH56SRwf8/TxoOHLTNrcELy8rHdgIrfzwiLwN+XWLI=;
        b=WvNeu6ZJF3ygUjwVthtzoLQjJdnXKMhl9EsvhMa9yy6MrslWlIX50ETWljin5w4J8D
         TG7qt4cs2xqLog+tfyweKcnowoFat605Cir0rWq/BKwnyVZ33Ew5KKpAMLSogmA7jV9Q
         1cB17InUDqmHFY4/Kg5Kg9KSZjGQQDXRPiRxIGgiwN14bqg6V52G8BFMmPLa+03kyWIL
         ZsQY8g0jqdTMTAp1KPwEcPmqLCHSnOleldik12RbLgkarLJz0KBOm9ilpk3qrknz2Oom
         8/qgIsUOkyTlvXloFTS1e0L+s19bCbXEh2eOZmE3eZHP40PbG8ZJOgLIBFTjx0TzqP5x
         Xl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722431203; x=1723036003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KoH56SRwf8/TxoOHLTNrcELy8rHdgIrfzwiLwN+XWLI=;
        b=tgtwqDXwWzFpF6GfGWkF0ICjx3b5KAHCRtZU3d1vogdE6p9Z+V/Gae8VcMoBltWp4h
         BKmJddf0QxTd8qhts9vDwWqbyyBcs6HyhXr8nWvGUdlJMedvidHLPmswzAQXQoANblan
         463kFhYzE6H/M2qbFmVvPCDQukfEbPbvN52ZUIM5oj9PNk2u8dWTt5h/CKNAhvw4hxTX
         z1neMI3Y5QSEFFRRhELhVSPatq50pm+3EMMafUcGmnkYZRuKA9zP6tKUYoIIOKv4Qf58
         7hFbYPhwIO9rovDpGtuvh0X0qIYFHhoxNwFOzmrviCQC6f38tVfnQK7EITitMt3VM10K
         oZ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQb8ytg9H7E6iuCKGL3Q7I3BKJY5fZxsKo5kYQKwqYXaBGEYI5DHWHzMahFAeZH8WiIECaepDGiOumjb6xEmC4ficgdkCCSGWvdTQZ
X-Gm-Message-State: AOJu0YyV2W6kK5HK+PeHtYEifcqyyVIIO2CFdwJrxeNLhmDRebbzTbcc
	GvGLDQpg88zWcdrdbaG1SRq4YeJH7iSc4ySGshJG34k4+FOH7mxvSfdI+xNolBU=
X-Google-Smtp-Source: AGHT+IHbuHd0d81j2oiFIcHNWF/Ai0JWQIg6X7IoOnNHD4z0+TMXZ41pg9PLSCtNerN21URRnZJdqA==
X-Received: by 2002:a19:770c:0:b0:52c:d626:77aa with SMTP id 2adb3069b0e04-5309b2d9aa9mr7801251e87.58.1722431202745;
        Wed, 31 Jul 2024 06:06:42 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5bd16f8sm2216692e87.118.2024.07.31.06.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 06:06:42 -0700 (PDT)
Date: Wed, 31 Jul 2024 16:06:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Elson Roy Serrao <quic_eserrao@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, gregkh@linuxfoundation.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org
Subject: Re: [PATCH 7/8] usb: misc: eud: Handle usb role switch notifications
Message-ID: <5nsextq3khhku3xfdwwj74wmx5ajyqhjyarfpnpa6i2tjx76ix@z7lpip6pi6re>
References: <20240730222439.3469-1-quic_eserrao@quicinc.com>
 <20240730222439.3469-8-quic_eserrao@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730222439.3469-8-quic_eserrao@quicinc.com>

On Tue, Jul 30, 2024 at 03:24:38PM GMT, Elson Roy Serrao wrote:
> Since EUD is physically present between the USB connector and
> the USB controller, it should relay the usb role notifications
> from the connector. Hence register a role switch handler to
> process and relay these roles to the USB controller. This results
> in a common framework to send both connector related events
> and eud attach/detach events to the USB controller.
> 
> Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
> ---
>  drivers/usb/misc/qcom_eud.c | 91 ++++++++++++++++++++++++++++---------
>  1 file changed, 69 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/usb/misc/qcom_eud.c b/drivers/usb/misc/qcom_eud.c
> index 3de7d465912c..9a49c934e8cf 100644
> --- a/drivers/usb/misc/qcom_eud.c
> +++ b/drivers/usb/misc/qcom_eud.c
> @@ -10,6 +10,7 @@
>  #include <linux/iopoll.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/of.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> @@ -35,12 +36,16 @@ struct eud_chip {
>  	struct device			*dev;
>  	struct usb_role_switch		*role_sw;
>  	struct phy			*usb2_phy;
> +
> +	/* mode lock */
> +	struct mutex			mutex;
>  	void __iomem			*base;
>  	void __iomem			*mode_mgr;
>  	unsigned int			int_status;
>  	int				irq;
>  	bool				enabled;
>  	bool				usb_attached;
> +	enum usb_role			current_role;
>  };
>  
>  static int eud_phy_enable(struct eud_chip *chip)
> @@ -64,6 +69,38 @@ static void eud_phy_disable(struct eud_chip *chip)
>  	phy_exit(chip->usb2_phy);
>  }
>  
> +static int eud_usb_role_set(struct eud_chip *chip, enum usb_role role)
> +{
> +	struct usb_role_switch *sw;
> +	int ret = 0;
> +
> +	mutex_lock(&chip->mutex);
> +
> +	/* Avoid duplicate role handling */
> +	if (role == chip->current_role)
> +		goto err;
> +
> +	sw = usb_role_switch_get(chip->dev);

Why isn't chip->role_sw good enough? Why do you need to get it each
time?

> +	if (IS_ERR_OR_NULL(sw)) {
> +		dev_err(chip->dev, "failed to get usb switch\n");
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	ret = usb_role_switch_set_role(sw, role);
> +	usb_role_switch_put(sw);
> +
> +	if (ret) {
> +		dev_err(chip->dev, "failed to set role\n");
> +		goto err;
> +	}
> +	chip->current_role = role;
> +err:
> +	mutex_unlock(&chip->mutex);
> +
> +	return ret;
> +}
> +
>  static int enable_eud(struct eud_chip *priv)
>  {
>  	int ret;
> @@ -77,7 +114,7 @@ static int enable_eud(struct eud_chip *priv)
>  			priv->base + EUD_REG_INT1_EN_MASK);
>  	writel(1, priv->mode_mgr + EUD_REG_EUD_EN2);
>  
> -	return usb_role_switch_set_role(priv->role_sw, USB_ROLE_DEVICE);
> +	return ret;
>  }
>  
>  static void disable_eud(struct eud_chip *priv)
> @@ -106,15 +143,20 @@ static ssize_t enable_store(struct device *dev,
>  	if (kstrtobool(buf, &enable))
>  		return -EINVAL;
>  
> +	/* EUD enable is applicable only in DEVICE mode */
> +	if (enable && chip->current_role != USB_ROLE_DEVICE)
> +		return -EINVAL;
> +
>  	if (enable) {
>  		ret = enable_eud(chip);
> -		if (!ret)
> -			chip->enabled = enable;
> -		else
> -			disable_eud(chip);
> +		if (ret) {
> +			dev_err(chip->dev, "failed to enable eud\n");
> +			return count;
> +		}
>  	} else {
>  		disable_eud(chip);
>  	}
> +	chip->enabled = enable;
>  
>  	return count;
>  }
> @@ -185,11 +227,9 @@ static irqreturn_t handle_eud_irq_thread(int irq, void *data)
>  	int ret;
>  
>  	if (chip->usb_attached)
> -		ret = usb_role_switch_set_role(chip->role_sw, USB_ROLE_DEVICE);
> +		ret = eud_usb_role_set(chip, USB_ROLE_DEVICE);
>  	else
> -		ret = usb_role_switch_set_role(chip->role_sw, USB_ROLE_HOST);
> -	if (ret)
> -		dev_err(chip->dev, "failed to set role switch\n");
> +		ret = eud_usb_role_set(chip, USB_ROLE_HOST);
>  
>  	/* set and clear vbus_int_clr[0] to clear interrupt */
>  	writel(BIT(0), chip->base + EUD_REG_VBUS_INT_CLR);
> @@ -198,16 +238,18 @@ static irqreturn_t handle_eud_irq_thread(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> -static void eud_role_switch_release(void *data)
> +static int eud_usb_role_switch_set(struct usb_role_switch *sw,
> +				   enum usb_role role)
>  {
> -	struct eud_chip *chip = data;
> +	struct eud_chip *chip = usb_role_switch_get_drvdata(sw);
>  
> -	usb_role_switch_put(chip->role_sw);
> +	return eud_usb_role_set(chip, role);
>  }
>  
>  static int eud_probe(struct platform_device *pdev)
>  {
>  	struct eud_chip *chip;
> +	struct usb_role_switch_desc eud_role_switch = {NULL};
>  	int ret;
>  
>  	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
> @@ -221,16 +263,6 @@ static int eud_probe(struct platform_device *pdev)
>  		return dev_err_probe(chip->dev, PTR_ERR(chip->usb2_phy),
>  				     "no usb2 phy configured\n");
>  
> -	chip->role_sw = usb_role_switch_get(&pdev->dev);
> -	if (IS_ERR(chip->role_sw))
> -		return dev_err_probe(chip->dev, PTR_ERR(chip->role_sw),
> -					"failed to get role switch\n");
> -
> -	ret = devm_add_action_or_reset(chip->dev, eud_role_switch_release, chip);
> -	if (ret)
> -		return dev_err_probe(chip->dev, ret,
> -				"failed to add role switch release action\n");
> -
>  	chip->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(chip->base))
>  		return PTR_ERR(chip->base);
> @@ -248,6 +280,18 @@ static int eud_probe(struct platform_device *pdev)
>  	if (ret)
>  		return dev_err_probe(chip->dev, ret, "failed to allocate irq\n");
>  
> +	eud_role_switch.fwnode = dev_fwnode(chip->dev);
> +	eud_role_switch.set = eud_usb_role_switch_set;
> +	eud_role_switch.get = NULL;
> +	eud_role_switch.driver_data = chip;
> +	chip->role_sw = usb_role_switch_register(chip->dev, &eud_role_switch);
> +
> +	if (IS_ERR(chip->role_sw))
> +		return dev_err_probe(chip->dev, PTR_ERR(chip->role_sw),
> +				"failed to register role switch\n");
> +
> +	mutex_init(&chip->mutex);

please move mutex_init earlier.

> +
>  	enable_irq_wake(chip->irq);
>  
>  	platform_set_drvdata(pdev, chip);
> @@ -262,6 +306,9 @@ static void eud_remove(struct platform_device *pdev)
>  	if (chip->enabled)
>  		disable_eud(chip);
>  
> +	if (chip->role_sw)
> +		usb_role_switch_unregister(chip->role_sw);
> +
>  	device_init_wakeup(&pdev->dev, false);
>  	disable_irq_wake(chip->irq);
>  }
> -- 
> 2.17.1
> 

-- 
With best wishes
Dmitry

