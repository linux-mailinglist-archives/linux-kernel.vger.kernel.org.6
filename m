Return-Path: <linux-kernel+bounces-255325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F47933F33
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0F601C20962
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2746181D10;
	Wed, 17 Jul 2024 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KuKjkDU2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EF7181BBA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721228621; cv=none; b=gTifhDZ+vW1i7hrzmmd6yHRJoLwHqJhna/AyGFE7LRTrPzYlnFpgA2Ab+uWJqg7FEyoNgejo83XjKeDFwvcC6RUi8VsSnw86PvOtZ0Oma4yAf9+/u8oXO655qNgYoxNWmmlOsN7qPf12K6b6j0xoS+yuPxJxj2jQq511Z5d86zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721228621; c=relaxed/simple;
	bh=R+9iyAoZdzjTKBpBg1pnk8v4vy/Ji0I9UnK5On22/Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsCpGasejRbtDnz9DxLMgvPBYoF+w41EEy40bQsBJExvOKSikbt8PlN22AfHNHSC0Bh59DybUazJGXHMR0nay8U7k+XoGy5yNHWbpyVvqtIXoFKBgAvm5d8PXnbcmVdnopcc2Gj/P2QlyFGzlAdNDSCm8l/RimVv9ByYQWB8O4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KuKjkDU2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89045C32782;
	Wed, 17 Jul 2024 15:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721228621;
	bh=R+9iyAoZdzjTKBpBg1pnk8v4vy/Ji0I9UnK5On22/Z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KuKjkDU2UuSidCkTfSxuXl7fhpob9ajwSL8dmB8cfN7KOfty+d37s6q7YJXfZtdSJ
	 +j0L/zGAkCsDL3mdo+zGtgONhUiK7eiCPCWaymgepJSPiJZoDDSxGKPmcjUhv1lJt0
	 QfK3IgfIP4ayyqfW/JWHRfCvsyaxkBV1R40upswo=
Date: Wed, 17 Jul 2024 17:03:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Benjamin Thery <benjamin.thery@bull.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH] driver core: Fix error handling in driver API
 device_rename()
Message-ID: <2024071756-uproot-relieve-6e27@gregkh>
References: <20240717-device_rename_fix-v1-1-54d85024518f@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717-device_rename_fix-v1-1-54d85024518f@quicinc.com>

On Wed, Jul 17, 2024 at 10:50:05PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Call failure of device_rename(@dev, @new_name) maybe unexpectedly change
> link name within @dev's class directory to @new_name, fixed by correcting
> error handling for the API.

I'm sorry, but I don't understand the text here, what exactly are you
doing?

> Fixes: f349cf34731c ("driver core: Implement ns directory support for device classes.")
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/base/core.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 2b4c0624b704..a05b7186cf33 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4512,9 +4512,11 @@ EXPORT_SYMBOL_GPL(device_destroy);
>   */
>  int device_rename(struct device *dev, const char *new_name)
>  {
> +	struct subsys_private *sp = NULL;
>  	struct kobject *kobj = &dev->kobj;
>  	char *old_device_name = NULL;
>  	int error;
> +	bool is_link_renamed = false;
>  
>  	dev = get_device(dev);
>  	if (!dev)
> @@ -4529,7 +4531,7 @@ int device_rename(struct device *dev, const char *new_name)
>  	}
>  
>  	if (dev->class) {
> -		struct subsys_private *sp = class_to_subsys(dev->class);
> +		sp = class_to_subsys(dev->class);
>  
>  		if (!sp) {
>  			error = -EINVAL;
> @@ -4537,17 +4539,20 @@ int device_rename(struct device *dev, const char *new_name)
>  		}
>  
>  		error = sysfs_rename_link_ns(&sp->subsys.kobj, kobj, old_device_name,
> -					     new_name, kobject_namespace(kobj));
> -		subsys_put(sp);
> +				new_name, kobject_namespace(kobj));

Why did you change the indentation here?

>  		if (error)
>  			goto out;
> +
> +		is_link_renamed = true;
>  	}
>  
>  	error = kobject_rename(kobj, new_name);
> -	if (error)
> -		goto out;
> -
>  out:
> +	if (error && is_link_renamed)
> +		sysfs_rename_link_ns(&sp->subsys.kobj, kobj, new_name,
> +				old_device_name, kobject_namespace(kobj));
> +	subsys_put(sp);

How was this found?  What in-kernel code causes this problem?  And how
was this tested?

thanks,

greg k-h

