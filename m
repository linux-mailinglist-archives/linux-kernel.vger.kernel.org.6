Return-Path: <linux-kernel+bounces-333388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D74B897C7CE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 12:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693721F269E9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 10:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F4419AA43;
	Thu, 19 Sep 2024 10:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r+z9VlVB"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C5C198842
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 10:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726740746; cv=none; b=bMz8aq7paJMhFEiWKjPAaPFt0gGxc1HW7ayTKK8re1CqF7z4UpHalE9jh0egZvT1yo9uTolCJRRGZ3/R2sLdaS4BgN8/jAEr7u5cdCmQF93lU98zxRwE8Caq7YuLT+5kNhswiWxKRuxsvugwpPZZXez3H2UlKAjQLXvN1PQZS8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726740746; c=relaxed/simple;
	bh=DIkAJir5JfJORJ5MkFp4kEfthpXf2iDOkp5wt+Yfn7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTqaEJNXuMrt2HUmm24dNfERHhqYFLtvnzq8n2SdGg0hBSgPufa7aTie2P6PJHfDNS0AxXqWcHVtuxl5GvTju2tJoem9XZWOfRcgjnpNB4Pkc8tzPNxA25PaS3cyozjzCF+20ZIOJ30WeU1g5IAHCWYYOI3heh4NI8hxW2SUduw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r+z9VlVB; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f74e613a10so9025571fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 03:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726740742; x=1727345542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GLFjOu5wJvL2rv+0CoDa2SB5UCn11iYd9z/GnY6i9QI=;
        b=r+z9VlVBHQ4Am+LOk3sIv+vhsOqdE53ZvrC3Wn8XQTCiOPdbcc2hpZAu6Tg2H6Fw9b
         H/9IaKVFolhbTRh3p5nCmq2z/OomS+ldQoxuTRP8nWeb/EGbabmRw+KOHUw5d/CaUAW2
         +xt8Wi+32sJ7jdRVclAeFevZ3gLcFDG+/+e63ey7QWdqgzF8MEk8SnWfm4KcrAmyigkd
         WlSr7BcA4Yuk9Jb9jsSWvvly/xjynW3idW1tn32YneHQH1zXCVUM7t2+ZDsZ5b9hqLQ/
         lPtD++iugBt10M7q49I1DZle6d9gUjiSRlkH25s2sHJeAzuT5knbnt/JQbbkKfEJzxph
         6fFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726740742; x=1727345542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLFjOu5wJvL2rv+0CoDa2SB5UCn11iYd9z/GnY6i9QI=;
        b=icJ3QJQMRNRwgMYhZKb1TnPa/exi8C605Zt56iTKkC4cBPaWCk2hf4jUjQPTb0n1Yx
         axtAL9lpgVSeQRhpKJU0Wxs7HHNGpPq3ys9R19ZbXgdaEdF7QfCXCj7SAbZ6Un6zc5no
         Rf2jwSLcjUX4OsqJ7J9cmC2JvG0C849E133SxukvvnIrsGgnmfj9WMUPHkpMl/Q+moNu
         8vhZiZz5Cw5intTZANtxUv/i2tlIvKyZdFMgu870C8RvlEtttH+0H64IflggPN2GPfLE
         P8Xm+hd400z5PcDtgelnFroENdAWLlUqmCa2n8BcqC7wluV2LIX/CW4LF9l6J6OOkmO+
         v+UA==
X-Forwarded-Encrypted: i=1; AJvYcCWURviCsuElSv/frH4H29epVPjSWaeVclaaijATI+SJU4rUhYi+VBVM+tcuXgckOvICRF4e8dz+k5bpv0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP4pqScRrCLpNEBW7b3+hiR/z9ixUSk27+6NLlwe83XtMXWd/1
	EaOnRzITxInWEfAKg129tE9tb7JQ5fG8ExmnMGq/E5zAMnPRhtPHJFPIf5ORyzDom4uFXeRDpDy
	Evnc=
X-Google-Smtp-Source: AGHT+IFs8u88LihqDZIZ2JBPSh5x0leTTbUiKEPgu3X0utw4O9nD7aokz6LHJhifGnBWperW+atYZw==
X-Received: by 2002:a2e:84a:0:b0:2f7:5777:cf14 with SMTP id 38308e7fff4ca-2f7935c342bmr109006111fa.35.1726740742024;
        Thu, 19 Sep 2024 03:12:22 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f79d59ba9dsm15593971fa.128.2024.09.19.03.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 03:12:20 -0700 (PDT)
Date: Thu, 19 Sep 2024 13:12:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, devicetree@vger.kernel.org, 
	Douglas Anderson <dianders@chromium.org>, Pin-yen Lin <treapking@chromium.org>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Benson Leung <bleung@chromium.org>, 
	Conor Dooley <conor+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org, 
	Guenter Roeck <groeck@chromium.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Lee Jones <lee@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Prashant Malani <pmalani@chromium.org>, 
	Robert Foss <rfoss@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Ivan Orlov <ivan.orlov0322@gmail.com>, 
	linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v4 03/18] usb: typec: Stub out typec_switch APIs when
 CONFIG_TYPEC=n
Message-ID: <kvm44f4c2lejbvfviuykxvcyo3ofcncjt5ssesn7ldequfeymc@eocnaacw425i>
References: <20240901040658.157425-1-swboyd@chromium.org>
 <20240901040658.157425-4-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240901040658.157425-4-swboyd@chromium.org>

On Sat, Aug 31, 2024 at 09:06:41PM GMT, Stephen Boyd wrote:
> Ease driver development by adding stubs for the typec_switch APIs when
> CONFIG_TYPEC=n. Copy the same method used for the typec_mux APIs to be
> consistent.
> 
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: <linux-usb@vger.kernel.org>
> Cc: Pin-yen Lin <treapking@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  include/linux/usb/typec_mux.h | 43 +++++++++++++++++++++++++++++++----
>  1 file changed, 38 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/usb/typec_mux.h b/include/linux/usb/typec_mux.h
> index 2489a7857d8e..efb5ed32b813 100644
> --- a/include/linux/usb/typec_mux.h
> +++ b/include/linux/usb/typec_mux.h
> @@ -3,6 +3,7 @@
>  #ifndef __USB_TYPEC_MUX
>  #define __USB_TYPEC_MUX
>  
> +#include <linux/err.h>
>  #include <linux/property.h>
>  #include <linux/usb/typec.h>
>  
> @@ -24,16 +25,13 @@ struct typec_switch_desc {
>  	void *drvdata;
>  };
>  
> +#if IS_ENABLED(CONFIG_TYPEC)
> +
>  struct typec_switch *fwnode_typec_switch_get(struct fwnode_handle *fwnode);
>  void typec_switch_put(struct typec_switch *sw);
>  int typec_switch_set(struct typec_switch *sw,
>  		     enum typec_orientation orientation);
>  
> -static inline struct typec_switch *typec_switch_get(struct device *dev)
> -{
> -	return fwnode_typec_switch_get(dev_fwnode(dev));
> -}
> -
>  struct typec_switch_dev *
>  typec_switch_register(struct device *parent,
>  		      const struct typec_switch_desc *desc);
> @@ -42,6 +40,41 @@ void typec_switch_unregister(struct typec_switch_dev *sw);
>  void typec_switch_set_drvdata(struct typec_switch_dev *sw, void *data);
>  void *typec_switch_get_drvdata(struct typec_switch_dev *sw);
>  
> +#else
> +
> +static inline struct typec_switch *
> +fwnode_typec_switch_get(struct fwnode_handle *fwnode)
> +{
> +	return NULL;
> +}
> +static inline void typec_switch_put(struct typec_switch *sw) {}
> +static inline int typec_switch_set(struct typec_switch *sw,
> +		     enum typec_orientation orientation)
> +{
> +	return 0;
> +}

Just my 2c:

The stubs above look fine from my POV, they help us to cleanup the users
of the API. The register/unregister callbacks are not. The switch
providers should clearly know whether the API is actually available or
not. Compare this to how other subsystems (regulators, interconnects,
etc) provide stubs for consumer API only.

In other words, please consider sending a patch that drops provider-side
Type-C MUX API stubs.

> +
> +static inline struct typec_switch_dev *
> +typec_switch_register(struct device *parent,
> +		      const struct typec_switch_desc *desc)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +static inline void typec_switch_unregister(struct typec_switch_dev *sw) {}
> +
> +static inline void typec_switch_set_drvdata(struct typec_switch_dev *sw, void *data) {}
> +static inline void *typec_switch_get_drvdata(struct typec_switch_dev *sw)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +
> +#endif /* CONFIG_TYPEC */
> +
> +static inline struct typec_switch *typec_switch_get(struct device *dev)
> +{
> +	return fwnode_typec_switch_get(dev_fwnode(dev));
> +}
> +
>  struct typec_mux_state {
>  	struct typec_altmode *alt;
>  	unsigned long mode;
> -- 
> https://chromeos.dev
> 

-- 
With best wishes
Dmitry

