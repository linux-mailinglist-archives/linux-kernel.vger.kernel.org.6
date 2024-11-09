Return-Path: <linux-kernel+bounces-402714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C02E9C2AC1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 07:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5EB1F22BE9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 06:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF73613AA2E;
	Sat,  9 Nov 2024 06:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CoVi5wjd"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFE8233D73
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 06:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731134479; cv=none; b=CAKcGz4GSLD/aG6+93Y9YabicuYntosdjuqoim+c4AUvLz0JhoVy8ytjenlA0t/nJUl9aqHDCnBZ6cZsdO118W5mcLm+lNePWFvmMdEIAzpTNT69/pXLSswIkLwVApQC2pnck37KGvFqYpfn4Q/SHWekwdaJAqufDPmZijCFh4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731134479; c=relaxed/simple;
	bh=b/pYJB7ff1VOHxnQqKgR1eAwihT9fLrrs3wRLF85ocg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZNRe6ZWvsmBDMNXJBZRbX1K3ikMIr6nimcpJalYJFgft50FD9bJVWJsuwYhyKdli03IaV9z8naCKC7adoSDeSZrKAcsNAJa8glc7RlgJNcdCg2XpFsF+7gBiIPlL0hFq1eqfKI7eL1pG8vyuoqg0qgHtRAYC9XIHVlxGaWoepI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CoVi5wjd; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb561f273eso22406481fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 22:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731134475; x=1731739275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CWQ5mBVFWFsy+kB+NSDCfBo5RSCH1U3/SXkD0DVPa5w=;
        b=CoVi5wjdz1pfs8GpizItBQNDQApU/YcV15rGVRw/jijukPm8ERXuFcV1KIFDUEdUud
         n2h2GDYdF1S3QulYVf3DgtLEbQM4kHhN7i/aXhU0auvhAapaELdCf8UcRmAe6kIbECt7
         brpVZhO0Bo6bJcda8tbpNm4SlT5VBRrK9cVWuoI2n9seW5rUk3ez0JY4aUtBwycNHmbb
         UprOkLcelCsteUtrqqRIMdQdPnPoQSklq1Q0NIKAKt84wu5P0FsmI3Nau2PNQwMTUZyl
         ztxZkohKKVIXVBeH5N/7Gh0klLdIuNUN0mgHapcdGVgvf7XrfzsZLEea6aCUDRHpmE3m
         h8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731134475; x=1731739275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWQ5mBVFWFsy+kB+NSDCfBo5RSCH1U3/SXkD0DVPa5w=;
        b=v0m7yulO+LK+e56bMQtjpOxJNq8cz2GxneW+gjxpzkjZtNk7WEFRWljXOsV0VOewUY
         cycw8RFyjwDa6WzlTqdxOpIAsNxMH7n/EhaodmwMZsnApBF+48HGTmh+GcspA2Tu8/O0
         m34ohV2/1xPExBDRuak2iMqjQJKvfQskp1f7lx7c9FWpQe/a4rGgxFY2VXBmI9GoaVyF
         V/VxERb92NwkVHbiJpEpg+/meioVHfcyQTUGzmlKmezVz9M8cg1UHhg6TXTsDH4H406S
         OkyMlr3UpwE1fQTxIeujK9qqeOy6P/K9VsFwthhb6nAafyIydxO2MuF+PXDi6XL4h4ME
         bIMg==
X-Forwarded-Encrypted: i=1; AJvYcCUzI9xN5pjKenIvZK29eTaH4ICvJxY4LC+0EuTjPScoeJrB3mssDMEE5SVMX6FPoXA4iuw1huEL0/Hs5w0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww2jQdhIQwzIaH4Cf1YJL3EIDn2vzakEDzNs8vnNQZVb4mmeh0
	m3lbavnPpciXKSUJmOEdFvLS7STH8PBFKkBAi6w2LDHlzbxObokNE9ClhhAtM6w=
X-Google-Smtp-Source: AGHT+IFpqQudCAMbUbKCGbMohOnVCQLlVCh7IkfcMv+rur4EeV0Icisq02nGodSZId4auTEzLub3qQ==
X-Received: by 2002:a2e:9fc9:0:b0:2fb:5c20:43e0 with SMTP id 38308e7fff4ca-2ff2024449fmr28510501fa.15.1731134475209;
        Fri, 08 Nov 2024 22:41:15 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff179a5f72sm9426311fa.93.2024.11.08.22.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 22:41:14 -0800 (PST)
Date: Sat, 9 Nov 2024 08:41:12 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: heikki.krogerus@linux.intel.com, tzungbi@kernel.org, 
	linux-usb@vger.kernel.org, chrome-platform@lists.linux.dev, jthies@google.com, 
	akuchynski@google.com, pmalani@chromium.org, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/7] platform/chrome: cros_ec_typec: Thunderbolt
 support
Message-ID: <zbtwtfywopvuh5b6skzxf53if7s7lxf53x6uxqnenpe3mipsdg@zdk7wfp7mqbg>
References: <20241107193021.2690050-1-abhishekpandit@chromium.org>
 <20241107112955.v3.6.Ic61ced3cdfb5d6776435356061f12307da719829@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107112955.v3.6.Ic61ced3cdfb5d6776435356061f12307da719829@changeid>

On Thu, Nov 07, 2024 at 11:29:59AM -0800, Abhishek Pandit-Subedi wrote:
> Add support for entering and exiting Thunderbolt alt-mode using AP
> driven alt-mode.
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> 
> Changes in v3:
> - Fix usage of TBT sid and mode.
> - Removed unused vdm operations during altmode registration
> 
> Changes in v2:
> - Refactored thunderbolt support into cros_typec_altmode.c
> 
>  drivers/platform/chrome/Makefile             |  3 +
>  drivers/platform/chrome/cros_ec_typec.c      | 23 +++---
>  drivers/platform/chrome/cros_typec_altmode.c | 85 ++++++++++++++++++++
>  drivers/platform/chrome/cros_typec_altmode.h | 14 ++++
>  4 files changed, 114 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
> index 2f90d4db8099..b9b1281de063 100644
> --- a/drivers/platform/chrome/Makefile
> +++ b/drivers/platform/chrome/Makefile
> @@ -21,6 +21,9 @@ cros-ec-typec-objs			:= cros_ec_typec.o cros_typec_vdm.o
>  ifneq ($(CONFIG_TYPEC_DP_ALTMODE),)
>  	cros-ec-typec-objs		+= cros_typec_altmode.o
>  endif
> +ifneq ($(CONFIG_TYPEC_TBT_ALTMODE),)
> +	cros-ec-typec-objs		+= cros_typec_altmode.o
> +endif

Doesn't this also result in the object file being included twice and
thus in a duplicate symbols declaration?

>  obj-$(CONFIG_CROS_EC_TYPEC)		+= cros-ec-typec.o
>  
>  obj-$(CONFIG_CROS_EC_LPC)		+= cros_ec_lpcs.o
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 3a6f5f2717b9..558b618df63c 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -302,18 +302,19 @@ static int cros_typec_register_port_altmodes(struct cros_typec_data *typec,
>  
>  	/*
>  	 * Register TBT compatibility alt mode. The EC will not enter the mode
> -	 * if it doesn't support it, so it's safe to register it unconditionally
> -	 * here for now.
> +	 * if it doesn't support it and it will not enter automatically by
> +	 * design so we can use the |ap_driven_altmode| feature to check if we
> +	 * should register it.
>  	 */
> -	memset(&desc, 0, sizeof(desc));
> -	desc.svid = USB_TYPEC_TBT_SID;
> -	desc.mode = TYPEC_ANY_MODE;
> -	amode = typec_port_register_altmode(port->port, &desc);
> -	if (IS_ERR(amode))
> -		return PTR_ERR(amode);
> -	port->port_altmode[CROS_EC_ALTMODE_TBT] = amode;
> -	typec_altmode_set_drvdata(amode, port);
> -	amode->ops = &port_amode_ops;
> +	if (typec->ap_driven_altmode) {
> +		memset(&desc, 0, sizeof(desc));
> +		desc.svid = USB_TYPEC_TBT_SID;
> +		desc.mode = TBT_MODE;
> +		amode = cros_typec_register_thunderbolt(port, &desc);
> +		if (IS_ERR(amode))
> +			return PTR_ERR(amode);
> +		port->port_altmode[CROS_EC_ALTMODE_TBT] = amode;
> +	}
>  
>  	port->state.alt = NULL;
>  	port->state.mode = TYPEC_STATE_USB;
> diff --git a/drivers/platform/chrome/cros_typec_altmode.c b/drivers/platform/chrome/cros_typec_altmode.c
> index 3598b8a6ceee..9cf2cef6c277 100644
> --- a/drivers/platform/chrome/cros_typec_altmode.c
> +++ b/drivers/platform/chrome/cros_typec_altmode.c
> @@ -8,6 +8,7 @@
>  #include "cros_ec_typec.h"
>  
>  #include <linux/usb/typec_dp.h>
> +#include <linux/usb/typec_tbt.h>
>  #include <linux/usb/pd_vdo.h>
>  
>  #include "cros_typec_altmode.h"
> @@ -67,6 +68,8 @@ static int cros_typec_altmode_enter(struct typec_altmode *alt, u32 *vdo)
>  
>  	if (data->sid == USB_TYPEC_DP_SID)
>  		req.mode_to_enter = CROS_EC_ALTMODE_DP;
> +	else if (data->sid == USB_TYPEC_TBT_SID)
> +		req.mode_to_enter = CROS_EC_ALTMODE_TBT;
>  	else
>  		return -EOPNOTSUPP;
>  
> @@ -196,6 +199,53 @@ static int cros_typec_displayport_vdm(struct typec_altmode *alt, u32 header,
>  	return 0;
>  }
>  
> +static int cros_typec_thunderbolt_vdm(struct typec_altmode *alt, u32 header,
> +				      const u32 *data, int count)
> +{
> +	struct cros_typec_altmode_data *adata = typec_altmode_get_drvdata(alt);
> +
> +	int cmd_type = PD_VDO_CMDT(header);
> +	int cmd = PD_VDO_CMD(header);
> +	int svdm_version;

I suppose that with the current approach this misses the ap_mode_entry
check. If it gets moved to cros_typec_altmode_vdm(), then it should be
okay.

> +
> +	svdm_version = typec_altmode_get_svdm_version(alt);
> +	if (svdm_version < 0)
> +		return svdm_version;
> +
> +	switch (cmd_type) {
> +	case CMDT_INIT:
> +		if (PD_VDO_SVDM_VER(header) < svdm_version) {
> +			typec_partner_set_svdm_version(adata->port->partner,
> +						       PD_VDO_SVDM_VER(header));
> +			svdm_version = PD_VDO_SVDM_VER(header);
> +		}
> +
> +		adata->header = VDO(adata->sid, 1, svdm_version, cmd);
> +		adata->header |= VDO_OPOS(adata->mode);
> +
> +		switch (cmd) {
> +		case CMD_ENTER_MODE:
> +			/* Don't respond to the enter mode vdm because it
> +			 * triggers mux configuration. This is handled directly
> +			 * by the cros_ec_typec driver so the Thunderbolt driver
> +			 * doesn't need to be involved.
> +			 */
> +			break;
> +		default:
> +			adata->header |= VDO_CMDT(CMDT_RSP_ACK);
> +			schedule_work(&adata->work);
> +			break;
> +		}
> +
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +
>  static int cros_typec_altmode_vdm(struct typec_altmode *alt, u32 header,
>  				      const u32 *data, int count)
>  {
> @@ -204,6 +254,9 @@ static int cros_typec_altmode_vdm(struct typec_altmode *alt, u32 header,
>  	if (adata->sid == USB_TYPEC_DP_SID)
>  		return cros_typec_displayport_vdm(alt, header, data, count);
>  
> +	if (adata->sid == USB_TYPEC_TBT_SID)
> +		return cros_typec_thunderbolt_vdm(alt, header, data, count);
> +
>  	return -EINVAL;
>  }
>  
> @@ -273,3 +326,35 @@ cros_typec_register_displayport(struct cros_typec_port *port,
>  	return alt;
>  }
>  #endif
> +
> +#if IS_ENABLED(CONFIG_TYPEC_TBT_ALTMODE)
> +struct typec_altmode *
> +cros_typec_register_thunderbolt(struct cros_typec_port *port,
> +				struct typec_altmode_desc *desc)
> +{
> +	struct typec_altmode *alt;
> +	struct cros_typec_altmode_data *data;
> +
> +	alt = typec_port_register_altmode(port->port, desc);
> +	if (IS_ERR(alt))
> +		return alt;
> +
> +	data = devm_kzalloc(&alt->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data) {
> +		typec_unregister_altmode(alt);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	INIT_WORK(&data->work, cros_typec_altmode_work);
> +	data->alt = alt;
> +	data->port = port;
> +	data->ap_mode_entry = true;
> +	data->sid = desc->svid;
> +	data->mode = desc->mode;
> +
> +	typec_altmode_set_ops(alt, &cros_typec_altmode_ops);
> +	typec_altmode_set_drvdata(alt, data);
> +
> +	return alt;
> +}
> +#endif
> diff --git a/drivers/platform/chrome/cros_typec_altmode.h b/drivers/platform/chrome/cros_typec_altmode.h
> index c6f8fb02c99c..810b553ddcd8 100644
> --- a/drivers/platform/chrome/cros_typec_altmode.h
> +++ b/drivers/platform/chrome/cros_typec_altmode.h
> @@ -31,4 +31,18 @@ static inline int cros_typec_displayport_status_update(struct typec_altmode *alt
>  	return 0;
>  }
>  #endif
> +
> +#if IS_ENABLED(CONFIG_TYPEC_TBT_ALTMODE)
> +struct typec_altmode *
> +cros_typec_register_thunderbolt(struct cros_typec_port *port,
> +				struct typec_altmode_desc *desc);
> +#else
> +static inline struct typec_altmode *
> +cros_typec_register_thunderbolt(struct cros_typec_port *port,
> +				struct typec_altmode_desc *desc)
> +{
> +	return typec_port_register_altmode(port->port, desc);
> +}
> +#endif
> +
>  #endif /* __CROS_TYPEC_ALTMODE_H__ */
> -- 
> 2.47.0.277.g8800431eea-goog
> 

-- 
With best wishes
Dmitry

