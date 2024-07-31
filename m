Return-Path: <linux-kernel+bounces-269225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 334DD942F70
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6129F1C21E1D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E581B14EB;
	Wed, 31 Jul 2024 12:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SFnuZ0s9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4553C1B29A0
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 12:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722430414; cv=none; b=XIs9Vcvx92ddTuBmw5pp2Eaim5pHf2Mb+j0pC3xmwDKbSEa8QxpCMve/3sl7ToRZGHmB1VQH7aH9eXYBNIdKZSkrd3CQ7drivhEkL18Bd5HQZVcaTZS38eTs55TyALWvopmr3TsOEMOo3V7hTCY0KCsJJWZMr92QTr8nTuL+kqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722430414; c=relaxed/simple;
	bh=b2BPJwkxUBGBaV4qfTazgklOYLjv/5idMISq6n5H62s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZIE3lJ6rHW5Qj9SMJqXHdivoyTD1CyKCq3ULLR/sZo0ZvXDE7g3QIoVvGeY2sVdLSyjVp51GX7kirFuQsqcMFdwdMsjM1tU2a19Bz5dqRg8KOdQrb1whHcXqsOWzyxc2YRywGW1qRmkZyLx3P2XiG1FDNB4XUxtXjtYpow1yBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SFnuZ0s9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88190C116B1;
	Wed, 31 Jul 2024 12:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722430413;
	bh=b2BPJwkxUBGBaV4qfTazgklOYLjv/5idMISq6n5H62s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SFnuZ0s9O5R1e4z6oivPvMcgYF7am5sWFefAqJxWPdvKrslzGmkWLpCjqf2NRTRYY
	 jpT2GJ3yWzjoYlWFQgeYPQv/hSCK0Qrp1J6ZllEUlezI3RjLXyDfSNSOYMDVN1viMD
	 +/9qQilSs1HbfQ5ts4dHrfFM50ZHcsFs1YeVx1Jo=
Date: Wed, 31 Jul 2024 14:53:29 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH] driver core: Simplify driver API
 device_find_child_by_name() implementation
Message-ID: <2024073128-tinfoil-unaligned-8164@gregkh>
References: <20240720-simplify_drv_api-v1-1-07c5e028cccf@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240720-simplify_drv_api-v1-1-07c5e028cccf@quicinc.com>

On Sat, Jul 20, 2024 at 09:21:50AM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Simplify device_find_child_by_name() implementation by using present
> driver APIs device_find_child() and device_match_name().
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/base/core.c    | 15 +++------------
>  include/linux/device.h |  4 ++++
>  2 files changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 730cae66607c..22ab4b8a2bcd 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4089,18 +4089,9 @@ EXPORT_SYMBOL_GPL(device_find_child);
>  struct device *device_find_child_by_name(struct device *parent,
>  					 const char *name)
>  {
> -	struct klist_iter i;
> -	struct device *child;
> -
> -	if (!parent)
> -		return NULL;
> -
> -	klist_iter_init(&parent->p->klist_children, &i);
> -	while ((child = next_device(&i)))
> -		if (sysfs_streq(dev_name(child), name) && get_device(child))
> -			break;
> -	klist_iter_exit(&i);
> -	return child;
> +	/* TODO: remove type cast after const device_find_child() prototype */

I do not understand the TODO here.  Why is it needed?  Why not fix it up
now?

> +	return device_find_child(parent, (void *)name,
> +				 (int (*)(struct device *, void *))device_match_name);
>  }
>  EXPORT_SYMBOL_GPL(device_find_child_by_name);
>  
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 34eb20f5966f..685ffd2dc867 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -47,6 +47,9 @@ struct dev_pin_info;
>  struct dev_iommu;
>  struct msi_device_data;
>  
> +/* TODO: unify device match() parameter of driver APIs to this signature */

Same here, why have this?  Why not unify them and then fix this up?

> +typedef int (*device_match_t)(struct device *dev, const void *data);
> +
>  /**
>   * struct subsys_interface - interfaces to device functions
>   * @name:       name of the device function
> @@ -1073,6 +1076,7 @@ int device_for_each_child(struct device *dev, void *data,
>  			  int (*fn)(struct device *dev, void *data));
>  int device_for_each_child_reverse(struct device *dev, void *data,
>  				  int (*fn)(struct device *dev, void *data));
> +/* TODO: change type of @data to const void * and @match to device_match_t */

Again, why leave this here?

thanks,

greg k-h

