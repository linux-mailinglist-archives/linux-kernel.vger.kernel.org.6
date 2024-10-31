Return-Path: <linux-kernel+bounces-390627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C449B7C79
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EADE61F21CAE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 14:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B01B1A01CC;
	Thu, 31 Oct 2024 14:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="diwR6ibr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A614619538D;
	Thu, 31 Oct 2024 14:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730383919; cv=none; b=RSJDO62NB8FH23bc1oc9Obq8oaeILj0TPMUvPvKPF0rrtaw4dzPbopn6dX5qYRxcrgzxAmN5p4YpQR/QZljuIyo/+oQ1Bsy1F1gjyWzu245AmP9spZPPoRTYY/T2EKHsBhHH3rh1kKOhQMRPM0nPTJ+ToOvWats+Yuz50lUtKg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730383919; c=relaxed/simple;
	bh=mRUUykKXPxpnmAir/PAmc6d7yy4KP2FC3UqvBuwfs28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4fXXg3Xkzs3eJx6fbRbUIV/TH+5h7yxBMRQq9IlJlmZTKMJZL02AN2HfsAIYECWDgJCjSihe0GSd0u+8eEaFcUeVt7KZOXEhUFtQLqGWoq69WUZjGFhQZv55YNMjrX1R0MAkWgYCphZdGMVZiFMx+sisJBZL92rliS7u8jGa7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=diwR6ibr; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730383916; x=1761919916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mRUUykKXPxpnmAir/PAmc6d7yy4KP2FC3UqvBuwfs28=;
  b=diwR6ibr6XmBAIS0twOy2TtzkQfPrggNCBy7jSKur794ydPR+HQOsa+T
   Z4uZqRafOLl9V8n/cPoiipKmlSn0G3+kmP3y75D7MwY/J13debd8qS0bk
   UFTTMVfB6WmIQGEnDdlUJTs4tK6Ucj1Zblofa5HnsTrWgSljsUY7Cgh2Y
   y1rxMMopVBqQMc8kJCXN11SBLjuRca8cXBv26bWKmKNLc1izJvfBDuU0i
   mccQou5SvMc9qoiX8sqH7vtjPEyhTjaZbvCyfXw8yjlQsEdZutLgsdo/U
   N6PADAA1eaZNbOWn3SY8M9HvJ6OKrH3t+hG6FB9jmbiYsHWJ+NoTMLrgF
   w==;
X-CSE-ConnectionGUID: x+40xn7kS9aS3iVIPHOhog==
X-CSE-MsgGUID: LSc37C17QYqye8Lv4iVE9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30288676"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30288676"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 07:11:56 -0700
X-CSE-ConnectionGUID: xszmimeHTseK41POLTOL5w==
X-CSE-MsgGUID: aIIqy4AJTl+pI+hD84fylA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="82545181"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa009.jf.intel.com with SMTP; 31 Oct 2024 07:11:51 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 31 Oct 2024 16:11:50 +0200
Date: Thu, 31 Oct 2024 16:11:50 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: tzungbi@kernel.org, linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev, dmitry.baryshkov@linaro.org,
	jthies@google.com, akuchynski@google.com, pmalani@chromium.org,
	Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] usb: typec: Add driver for Thunderbolt 3
 Alternate Mode
Message-ID: <ZyOQJmF-PcFHgmeq@kuha.fi.intel.com>
References: <20241030212854.998318-1-abhishekpandit@chromium.org>
 <20241030142833.v2.1.I3080b036e8de0b9957c57c1c3059db7149c5e549@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030142833.v2.1.I3080b036e8de0b9957c57c1c3059db7149c5e549@changeid>

Hi Abhishek,

On Wed, Oct 30, 2024 at 02:28:32PM -0700, Abhishek Pandit-Subedi wrote:
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> Thunderbolt 3 Alternate Mode entry flow is described in
> USB Type-C Specification Release 2.0.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Co-developed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> 
> Changes:
> * Delay cable + plug checks so that the module doesn't fail to probe
>   if cable + plug information isn't available by the time the partner
>   altmode is registered.
> * Remove unncessary brace after if (IS_ERR(plug))
> 
> The rest of this patch should be the same as Heikki's original RFC.
> 
> 
> Changes in v2:
> - Use <linux/usb/typec_tbt.h> and add missing TBT_CABLE_ROUNDED
> - Pass struct typec_thunderbolt_data to typec_altmode_notify
> - Rename TYPEC_TBT_MODE to USB_TYPEC_TBT_MODE
> - Use USB_TYPEC_TBT_SID and USB_TYPEC_TBT_MODE for device id
> - Change module license to GPL due to checkpatch warning
> 
>  drivers/platform/chrome/cros_ec_typec.c  |   2 +-
>  drivers/usb/typec/altmodes/Kconfig       |   9 +
>  drivers/usb/typec/altmodes/Makefile      |   2 +
>  drivers/usb/typec/altmodes/thunderbolt.c | 308 +++++++++++++++++++++++
>  include/linux/usb/typec_tbt.h            |   3 +-
>  5 files changed, 322 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/usb/typec/altmodes/thunderbolt.c
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index c7781aea0b88..53d93baa36a8 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -499,7 +499,7 @@ static int cros_typec_enable_tbt(struct cros_typec_data *typec,
>  	}
>  
>  	port->state.data = &data;
> -	port->state.mode = TYPEC_TBT_MODE;
> +	port->state.mode = USB_TYPEC_TBT_MODE;
>  
>  	return typec_mux_set(port->mux, &port->state);
>  }

The definition should be changed in a separate patch.

> +static const struct typec_device_id tbt_typec_id[] = {
> +	{ USB_TYPEC_TBT_SID, USB_TYPEC_TBT_MODE },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(typec, tbt_typec_id);

Now the mode would be the same thing as connector state, which is not
true. The connector state is supposed to reflect the pin assignment,
and the mode is the mode index used with the actual VDMs. For example,
DP alt mode has several different states, but only one mode.

The TBT3 altmode driver will not work with this patch alone, it will
never bind to the partner TBT3 alt mode because the mode does not
match.

Can you reorganise this series so that the patch 2/7 comes before this
one? Then I think you can just use the SVID unless I'm mistaken:

        static const struct typec_device_id tbt_typec_id[] = {
		{ USB_TYPEC_TBT_SID },
		{ }
        };
        MODULE_DEVICE_TABLE(typec, tbt_typec_id);

Alternatively, just leave it to TYPEC_ANY_MODE for now.

> +static struct typec_altmode_driver tbt_altmode_driver = {
> +	.id_table = tbt_typec_id,
> +	.probe = tbt_altmode_probe,
> +	.remove = tbt_altmode_remove,
> +	.driver = {
> +		.name = "typec-thunderbolt",
> +		.owner = THIS_MODULE,
> +	}
> +};
> +module_typec_altmode_driver(tbt_altmode_driver);
> +
> +MODULE_AUTHOR("Heikki Krogerus <heikki.krogerus@linux.intel.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Thunderbolt3 USB Type-C Alternate Mode");
> diff --git a/include/linux/usb/typec_tbt.h b/include/linux/usb/typec_tbt.h
> index fa97d7e00f5c..3ff82641f6a0 100644
> --- a/include/linux/usb/typec_tbt.h
> +++ b/include/linux/usb/typec_tbt.h
> @@ -10,7 +10,7 @@
>  #define USB_TYPEC_TBT_SID		USB_TYPEC_VENDOR_INTEL
>  
>  /* Connector state for Thunderbolt3 */
> -#define TYPEC_TBT_MODE			TYPEC_STATE_MODAL
> +#define USB_TYPEC_TBT_MODE		TYPEC_STATE_MODAL

I think USB_TYPEC_STATE_TBT would be better. But please change this in
a separate patch in any case.

thanks,

-- 
heikki

