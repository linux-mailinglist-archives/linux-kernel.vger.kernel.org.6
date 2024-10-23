Return-Path: <linux-kernel+bounces-377641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D59619AC1BC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918E528344F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5569A15A849;
	Wed, 23 Oct 2024 08:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gMQy4Qx4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7999261FF2;
	Wed, 23 Oct 2024 08:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729672452; cv=none; b=J2xZTAFSQcHPD9yy4iIC9PXcu/WkAbo1q7L4m21paRUdjAtiRAcARCpZ2nk3gt9+Eu9R50mM9mSLQrMqqw/IMivToX8jfKbEuRo8IX78ecZ4dhIjWeSrsTD7FRVnfUPkl5ple90q2DvRBM/8BY+DrUfDi76iTnHMvFseaxfs5zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729672452; c=relaxed/simple;
	bh=p8ORP2zFBVpWCwfE76YamgNoakF/nQbKtEqbnRa2zD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFznzOeSu6JnXSc4xbx5o0+3APscYMc+oOa/lwHgPQBmrvfNw/jocZTSo6e4PpqcAAsW/n4KULazyRidIJaIPCkfakSMLW6P1RxYd7eHhW/Uj5lAsvR5YME5Ssdo9qzy/R4OXHEpyaHMCLQx8SDVyq/9hri6X2yNjeHjQaXu/ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gMQy4Qx4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6811C4CEC6;
	Wed, 23 Oct 2024 08:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729672452;
	bh=p8ORP2zFBVpWCwfE76YamgNoakF/nQbKtEqbnRa2zD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gMQy4Qx4CKOnux4Mgm/8LxkmPptqq6YfLZ3G1DoIOObJQEywYuNRrpUF9kVDO9jFC
	 7iuj2VP8zdS4pz7Yvafi3TBzsVihxhTS4YjcrhnwzrSrFowmkJkdulEUrnPQcDtCqG
	 WgsoX66OHVgYQFcXUAlx98UKA0YpfrYX2mgM2TD8=
Date: Wed, 23 Oct 2024 10:34:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiayi Li <lijiayi@kylinos.cn>
Cc: stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: core: use sysfs_emit() instead of sprintf()
Message-ID: <2024102358-remedial-festival-4548@gregkh>
References: <20241023082439.2430696-1-lijiayi@kylinos.cn>
 <20241023082439.2430696-2-lijiayi@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023082439.2430696-2-lijiayi@kylinos.cn>

On Wed, Oct 23, 2024 at 04:24:39PM +0800, Jiayi Li wrote:
> Follow the advice in Documentation/filesystems/sysfs.rst:
> show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> the value to be returned to user space.
> 
> Signed-off-by: Jiayi Li <lijiayi@kylinos.cn>
> ---
>  drivers/usb/core/endpoint.c        | 11 ++++++-----
>  drivers/usb/core/ledtrig-usbport.c |  3 ++-
>  drivers/usb/core/port.c            | 11 ++++++-----
>  3 files changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/usb/core/endpoint.c b/drivers/usb/core/endpoint.c
> index 4b38b87a1343..e48399401608 100644
> --- a/drivers/usb/core/endpoint.c
> +++ b/drivers/usb/core/endpoint.c
> @@ -14,6 +14,7 @@
>  #include <linux/kernel.h>
>  #include <linux/spinlock.h>
>  #include <linux/slab.h>
> +#include <linux/sysfs.h>
>  #include <linux/usb.h>
>  #include "usb.h"
>  
> @@ -39,7 +40,7 @@ static ssize_t field##_show(struct device *dev,			\
>  			       char *buf)			\
>  {								\
>  	struct ep_device *ep = to_ep_device(dev);		\
> -	return sprintf(buf, format_string, ep->desc->field);	\
> +	return sysfs_emit(buf, format_string, ep->desc->field);	\
>  }								\
>  static DEVICE_ATTR_RO(field)
>  
> @@ -52,7 +53,7 @@ static ssize_t wMaxPacketSize_show(struct device *dev,
>  				   struct device_attribute *attr, char *buf)
>  {
>  	struct ep_device *ep = to_ep_device(dev);
> -	return sprintf(buf, "%04x\n", usb_endpoint_maxp(ep->desc));
> +	return sysfs_emit(buf, "%04x\n", usb_endpoint_maxp(ep->desc));
>  }
>  static DEVICE_ATTR_RO(wMaxPacketSize);
>  
> @@ -76,7 +77,7 @@ static ssize_t type_show(struct device *dev, struct device_attribute *attr,
>  		type = "Interrupt";
>  		break;
>  	}
> -	return sprintf(buf, "%s\n", type);
> +	return sysfs_emit(buf, "%s\n", type);
>  }
>  static DEVICE_ATTR_RO(type);
>  
> @@ -95,7 +96,7 @@ static ssize_t interval_show(struct device *dev, struct device_attribute *attr,
>  		interval /= 1000;
>  	}
>  
> -	return sprintf(buf, "%d%cs\n", interval, unit);
> +	return sysfs_emit(buf, "%d%cs\n", interval, unit);
>  }
>  static DEVICE_ATTR_RO(interval);
>  
> @@ -111,7 +112,7 @@ static ssize_t direction_show(struct device *dev, struct device_attribute *attr,
>  		direction = "in";
>  	else
>  		direction = "out";
> -	return sprintf(buf, "%s\n", direction);
> +	return sysfs_emit(buf, "%s\n", direction);
>  }
>  static DEVICE_ATTR_RO(direction);
>  
> diff --git a/drivers/usb/core/ledtrig-usbport.c b/drivers/usb/core/ledtrig-usbport.c
> index 85c999f71ad7..5e3c515991f3 100644
> --- a/drivers/usb/core/ledtrig-usbport.c
> +++ b/drivers/usb/core/ledtrig-usbport.c
> @@ -10,6 +10,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/slab.h>
> +#include <linux/sysfs.h>
>  #include <linux/usb.h>
>  #include <linux/usb/of.h>
>  
> @@ -87,7 +88,7 @@ static ssize_t usbport_trig_port_show(struct device *dev,
>  						      struct usbport_trig_port,
>  						      attr);
>  
> -	return sprintf(buf, "%d\n", port->observed) + 1;
> +	return sysfs_emit(buf, "%d\n", port->observed) + 1;
>  }
>  
>  static ssize_t usbport_trig_port_store(struct device *dev,
> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
> index e7da2fca11a4..45d7af00f8d1 100644
> --- a/drivers/usb/core/port.c
> +++ b/drivers/usb/core/port.c
> @@ -9,6 +9,7 @@
>  
>  #include <linux/kstrtox.h>
>  #include <linux/slab.h>
> +#include <linux/sysfs.h>
>  #include <linux/pm_qos.h>
>  #include <linux/component.h>
>  #include <linux/usb/of.h>
> @@ -166,7 +167,7 @@ static ssize_t location_show(struct device *dev,
>  {
>  	struct usb_port *port_dev = to_usb_port(dev);
>  
> -	return sprintf(buf, "0x%08x\n", port_dev->location);
> +	return sysfs_emit(buf, "0x%08x\n", port_dev->location);
>  }
>  static DEVICE_ATTR_RO(location);
>  
> @@ -191,7 +192,7 @@ static ssize_t connect_type_show(struct device *dev,
>  		break;
>  	}
>  
> -	return sprintf(buf, "%s\n", result);
> +	return sysfs_emit(buf, "%s\n", result);
>  }
>  static DEVICE_ATTR_RO(connect_type);
>  
> @@ -210,7 +211,7 @@ static ssize_t over_current_count_show(struct device *dev,
>  {
>  	struct usb_port *port_dev = to_usb_port(dev);
>  
> -	return sprintf(buf, "%u\n", port_dev->over_current_count);
> +	return sysfs_emit(buf, "%u\n", port_dev->over_current_count);
>  }
>  static DEVICE_ATTR_RO(over_current_count);
>  
> @@ -219,7 +220,7 @@ static ssize_t quirks_show(struct device *dev,
>  {
>  	struct usb_port *port_dev = to_usb_port(dev);
>  
> -	return sprintf(buf, "%08x\n", port_dev->quirks);
> +	return sysfs_emit(buf, "%08x\n", port_dev->quirks);
>  }
>  
>  static ssize_t quirks_store(struct device *dev, struct device_attribute *attr,
> @@ -254,7 +255,7 @@ static ssize_t usb3_lpm_permit_show(struct device *dev,
>  			p = "0";
>  	}
>  
> -	return sprintf(buf, "%s\n", p);
> +	return sysfs_emit(buf, "%s\n", p);
>  }
>  
>  static ssize_t usb3_lpm_permit_store(struct device *dev,
> -- 
> 2.45.2
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

