Return-Path: <linux-kernel+bounces-531079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FEAA43BEA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37F8C188597C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09F826389C;
	Tue, 25 Feb 2025 10:35:57 +0000 (UTC)
Received: from smtp.dudau.co.uk (dliviu.plus.com [80.229.23.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D023260A3D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.229.23.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740479757; cv=none; b=H+QPWhQRmc3BXl6UGdhIneLg69BrfufBND3v8MY5f8fxcxamJtIZf4kZQAwIfZ+7VZhQCBArLgL1YTZ2GyErs++kUY9AxPLOqQkvxiijJNHKUFdPhzjL4b0u4CdTZtp+sT+WawoK6uJ4R6CNVkiSWCDz6yppjxawFWheuALpgTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740479757; c=relaxed/simple;
	bh=EJrFkML/scjKF+Lmlj/zEDEUjKP7+ZvAcedIE8vKUQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqmcfpWpdtZ8np/3XhMGGzXUhtfpvhI2Hfb9E0eEEq5Wr9doz9CfZMx7LMMzp7c3uNqL/aeSZbAOmxWkotKMWekYG9AQ8ejafle3o5VNr/3CLRYABE4w6/l5i9MUA1ztqL5NABoSgbO18kMsIrZMyirtFORVLeg99x+3ohyjdMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dudau.co.uk; spf=pass smtp.mailfrom=dudau.co.uk; arc=none smtp.client-ip=80.229.23.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dudau.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dudau.co.uk
Received: from mail.dudau.co.uk (bart.dudau.co.uk [192.168.14.2])
	by smtp.dudau.co.uk (Postfix) with SMTP id 89AEF41E2245;
	Tue, 25 Feb 2025 10:28:02 +0000 (GMT)
Received: by mail.dudau.co.uk (sSMTP sendmail emulation); Tue, 25 Feb 2025 10:28:02 +0000
Date: Tue, 25 Feb 2025 10:28:02 +0000
From: Liviu Dudau <liviu@dudau.co.uk>
To: oushixiong1025@163.com
Cc: Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Shixiong Ou <oushixiong@kylinos.cn>
Subject: Re: [PATCH] drm/arm/komeda: Add a condition check before removing
 sysfs attribute
Message-ID: <Z72bMsXmoQv1UVv0@bart.dudau.co.uk>
References: <20250220085358.232883-1-oushixiong1025@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250220085358.232883-1-oushixiong1025@163.com>

Hello,

Replying from my personal email as the corporate system seems to have blackholed your emails
while I was on holiday.

Can you tell me more why you think that if sysfs_create_group() fails we should not call
sysfs_remove_group()? After all, we don't know how far sysfs_create_group() has progressed before
it encountered an error, so we still need to do some cleanup.

Best regards,
Liviu

On Thu, Feb 20, 2025 at 04:53:58PM +0800, oushixiong1025@163.com wrote:
> From: Shixiong Ou <oushixiong@kylinos.cn>
> 
> [WHY] If the call to sysfs_create_group() fails, there is
>       no need to call function sysfs_remove_group().
> 
> [HOW] Add a condition check before removing sysfs attribute.
> 
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 7 ++++++-
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.h | 2 ++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> index 5ba62e637a61..7d646f978640 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> @@ -259,6 +259,8 @@ struct komeda_dev *komeda_dev_create(struct device *dev)
>  		goto err_cleanup;
>  	}
>  
> +	mdev->sysfs_attr_enabled = true;
> +
>  	mdev->err_verbosity = KOMEDA_DEV_PRINT_ERR_EVENTS;
>  
>  	komeda_debugfs_init(mdev);
> @@ -278,7 +280,10 @@ void komeda_dev_destroy(struct komeda_dev *mdev)
>  	const struct komeda_dev_funcs *funcs = mdev->funcs;
>  	int i;
>  
> -	sysfs_remove_group(&dev->kobj, &komeda_sysfs_attr_group);
> +	if (mdev->sysfs_attr_enabled) {
> +		sysfs_remove_group(&dev->kobj, &komeda_sysfs_attr_group);
> +		mdev->sysfs_attr_enabled = false;
> +	}
>  
>  	debugfs_remove_recursive(mdev->debugfs_root);
>  
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> index 5b536f0cb548..af087540325c 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> @@ -216,6 +216,8 @@ struct komeda_dev {
>  #define KOMEDA_DEV_PRINT_DUMP_STATE_ON_EVENT BIT(8)
>  	/* Disable rate limiting of event prints (normally one per commit) */
>  #define KOMEDA_DEV_PRINT_DISABLE_RATELIMIT BIT(12)
> +
> +	bool sysfs_attr_enabled;
>  };
>  
>  static inline bool
> -- 
> 2.17.1
> 

-- 
Everyone who uses computers frequently has had, from time to time,
a mad desire to attack the precocious abacus with an axe.
       	   	      	     	  -- John D. Clark, Ignition!

