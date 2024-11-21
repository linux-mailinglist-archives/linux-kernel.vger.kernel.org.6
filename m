Return-Path: <linux-kernel+bounces-417173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE9D9D4FE1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFA3B28414C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5EB19F485;
	Thu, 21 Nov 2024 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UolTThuh"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4403A19E97E;
	Thu, 21 Nov 2024 15:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732203465; cv=none; b=VkuI6t3IyItoQoauNNEs2uPs/QTyN1dUSwLPyzXYU4zu5CrvPmshgVdcqEF/P7+5HZO+EGCtuG1NdbkrVFzjkvM942jEnpL0TxbWJtY+DfsRITJvqnyCSxXYHCHcrz0xFwgkxV3CqLHZ3d4Q8LttGa2koTGqDpoJ3EnSYQZk9ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732203465; c=relaxed/simple;
	bh=e67T/bb73dIJmTnKmrhXEuI/9x+/0ZqyZXDdlyHF6vk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGootVEyueH9cump47XbfLORzNmjYMkS+K1wRUhaoPSzIvsz+3+WerFyPrf+3IqIL6Ek/SkExABXWTXGuNXKpaE68ha1ReHahzReucctXxJpOlp9Bjgod5JbpQZ+pPoiRqh1p/Zxp4AC4tE6XON8xwQTTQ6ePMWtsAgci8Autr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UolTThuh; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20cf3e36a76so10744925ad.0;
        Thu, 21 Nov 2024 07:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732203463; x=1732808263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ajIostHiPNrhoaapnUP6WI9Q5i3QNMOV0292OM4R3+4=;
        b=UolTThuhHHTBUcTwBig0uU77puJ2io6UT0h4JZhM7HIEIKYHZFiPhKI7pwsksqpsoB
         gF1xsNCy3MXc0JVmDnrqhj+aByFoJ3OC7B3+q1oiTDe8XmQxuiRK4bhZSR4kqZBBfdRU
         qdxLEgOO0LOGeceMuwLzi2YZ1SLD9kJyCpmrOx5qwmQPEMC5MZ2Kj6rMEppJjD6lPgMc
         2BSl/wTes8c46zwXNJ6JqojC+XGLc8zvMnM77kr+uwnh5mylG+ZbfaFPIzfEpTRKgSzM
         ZEBJpp3M2Y/3iwO10Td1r+VfiPFBNIu8JRLgm2l/9bXtqtXaJLl/ctTTRhN2p10oLngq
         V2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732203463; x=1732808263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajIostHiPNrhoaapnUP6WI9Q5i3QNMOV0292OM4R3+4=;
        b=DpLo8mITtxGM1QF8TtvgWjEiE3KfdT4OmNTjOlCNAcHTH0G/WCOrfM8RBNIBV82u2A
         1q+PzWId/QcJ1mb9/bv0WRCCPIt/NeNKSAaq8V7fxvGikwhhs4EXrjk3RhzrbFLaL7eW
         py01eWFNl0/XDcmWc7gL1jXQX67sp1yCj2Zx0BBORYDQTU/ddyf4a6blLictG4YVFvQR
         pfLhPhMikHHRPDQ4ASF6y/x9XN50dIfuy6qVeCE3DSuZ4D4wUaKKZoeXoW5d4Qz3QynM
         QjAXGzkoNbSheZPdO+SV9+1+vAUUm3r81vsZx49HKVw9sNv2X0u6Y6jNcO7m5nzxE7rg
         M8lA==
X-Forwarded-Encrypted: i=1; AJvYcCUH2a2TCPmHzTS9jF3DRo5QFaTTf9uKp9aAJ69VSwFryqOzAaytHnULPxrgm4GB9Gjfwhi+ay5/nwmnttI=@vger.kernel.org, AJvYcCUPkY5i4QfJ4ckgp+RUUyinW9rFcNB2umN7MzDOl+T7yQdPILaTckxPLXq4FH4DJCjZg9PgIGG0aT+WvBdJnC88FyMQZw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yys/cmmvKmeir9RRafepyoA7V6Bdj4zKgZjVdQYroaCSnun9pkO
	w4e1fkiWhbI3nsyLs1PfHI6CkxSIC7Ske/5UYRRz6sMt6VJFh+kx
X-Gm-Gg: ASbGncv1ZKZQIQtEwQ9qngUQBG+0DD0UQsMf60prCsMbMht7mgeStIgH5CFOWg2EXjx
	fgmjOY8ze8dx6H7m4ZCxEH+akx/sAAsn4J+XSFEa8+m80nlEb8XcuLnBHxmbXZKJM8kamAeoFNc
	wQIdeRVDDRTD3V2Gfx0+/2F9OwtU31OX6RDbmi/PcsMxu5qcn20B7k8byjQkZvlkf1j+0M7b2L0
	UYAoSbPXW+r7eeQh7o3g/noQMT6kwI8Bn6UfVAUX4jRXA==
X-Google-Smtp-Source: AGHT+IE+Be2uTmrYKGFeFKFwc+olBUh2rQAJSjYfcKlDQRXQaXzmsyDlo5NOxVxSozD6QpsmWkvK6Q==
X-Received: by 2002:a17:902:f681:b0:212:67a5:aaff with SMTP id d9443c01a7336-2126a4359b5mr100088145ad.39.1732203463225;
        Thu, 21 Nov 2024 07:37:43 -0800 (PST)
Received: from alphacentauri ([181.84.94.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-212884081easm15005765ad.278.2024.11.21.07.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 07:37:42 -0800 (PST)
Date: Thu, 21 Nov 2024 12:37:39 -0300
From: Kurt Borja <kuurtb@gmail.com>
To: Dell.Client.Kernel@dell.com, hdegoede@redhat.com, 
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org, mario.limonciello@amd.com, 
	platform-driver-x86@vger.kernel.org, w_armin@gmx.de
Subject: Re: [PATCH v2 2/4] alienware-wmi: Improves sysfs groups creation
Message-ID: <vfjavxf5gedn3nsdntamg6ercruja6cb3sobd5gax7nv63jm2j@2fvd4kucu3p4>
References: <20241120163834.6446-3-kuurtb@gmail.com>
 <20241120164314.7177-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120164314.7177-2-kuurtb@gmail.com>

On Wed, Nov 20, 2024 at 01:43:15PM -0300, Kurt Borja wrote:
> Devices with hdmi_mux, amplifier or deepslp quirks create a sysfs group
> for each available feature. To accomplish this, helper create/remove
> functions were called on module init, but they had the following
> problems:
> 
>  - Create helpers called remove helpers on failure, which in turn tried
>    to remove the sysfs group that failed to be created
>  - If group creation failed mid way, previous successfully created groups
>    were not cleaned up
>  - Module exit only removed hdmi_mux group
> 
> To improve this, drop all helpers and let the platform driver manage these
> sysfs groups, while controlling visibility with their respective quirks.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
> v2:
>  - Drop the helpers approach in favor of letting the driver manage the
>    wmax sysfs groups
> ---
> 
> Again I think not cleaning up created sysfs group is not actually a bug
> so this is only an improvement.
> 
> ---
>  drivers/platform/x86/dell/alienware-wmi.c | 112 +++++++---------------
>  1 file changed, 36 insertions(+), 76 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> index 6760c7627f62..ecab14d90b27 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -410,17 +410,12 @@ struct wmax_u32_args {
>  	u8 arg3;
>  };
>  
> +

Just realized the extra line here.

>  static struct platform_device *platform_device;
>  static struct platform_zone *zone_data;
>  static struct platform_profile_handler pp_handler;
>  static enum wmax_thermal_mode supported_thermal_profiles[PLATFORM_PROFILE_LAST];
>  
> -static struct platform_driver platform_driver = {
> -	.driver = {
> -		.name = "alienware-wmi",
> -	}
> -};
> -
>  static struct attribute_group zone_attribute_group = {
>  	.name = "rgb_zones",
>  };
> @@ -781,6 +776,12 @@ static ssize_t toggle_hdmi_source(struct device *dev,
>  	return count;
>  }
>  
> +static bool hdmi_group_visible(struct kobject *kobj)
> +{
> +	return quirks->hdmi_mux;
> +}
> +DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(hdmi);
> +
>  static DEVICE_ATTR(cable, S_IRUGO, show_hdmi_cable, NULL);
>  static DEVICE_ATTR(source, S_IRUGO | S_IWUSR, show_hdmi_source,
>  		   toggle_hdmi_source);
> @@ -793,25 +794,10 @@ static struct attribute *hdmi_attrs[] = {
>  
>  static const struct attribute_group hdmi_attribute_group = {
>  	.name = "hdmi",
> +	.is_visible = SYSFS_GROUP_VISIBLE(hdmi),
>  	.attrs = hdmi_attrs,
>  };
>  
> -static void remove_hdmi(struct platform_device *dev)
> -{
> -	if (quirks->hdmi_mux > 0)
> -		sysfs_remove_group(&dev->dev.kobj, &hdmi_attribute_group);
> -}
> -
> -static int create_hdmi(struct platform_device *dev)
> -{
> -	int ret;
> -
> -	ret = sysfs_create_group(&dev->dev.kobj, &hdmi_attribute_group);
> -	if (ret)
> -		remove_hdmi(dev);
> -	return ret;
> -}
> -
>  /*
>   * Alienware GFX amplifier support
>   * - Currently supports reading cable status
> @@ -838,6 +824,12 @@ static ssize_t show_amplifier_status(struct device *dev,
>  	return sysfs_emit(buf, "unconnected connected [unknown]\n");
>  }
>  
> +static bool amplifier_group_visible(struct kobject *kobj)
> +{
> +	return quirks->amplifier;
> +}
> +DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(amplifier);
> +
>  static DEVICE_ATTR(status, S_IRUGO, show_amplifier_status, NULL);
>  
>  static struct attribute *amplifier_attrs[] = {
> @@ -847,25 +839,10 @@ static struct attribute *amplifier_attrs[] = {
>  
>  static const struct attribute_group amplifier_attribute_group = {
>  	.name = "amplifier",
> +	.is_visible = SYSFS_GROUP_VISIBLE(amplifier),
>  	.attrs = amplifier_attrs,
>  };
>  
> -static void remove_amplifier(struct platform_device *dev)
> -{
> -	if (quirks->amplifier > 0)
> -		sysfs_remove_group(&dev->dev.kobj, &amplifier_attribute_group);
> -}
> -
> -static int create_amplifier(struct platform_device *dev)
> -{
> -	int ret;
> -
> -	ret = sysfs_create_group(&dev->dev.kobj, &amplifier_attribute_group);
> -	if (ret)
> -		remove_amplifier(dev);
> -	return ret;
> -}
> -
>  /*
>   * Deep Sleep Control support
>   * - Modifies BIOS setting for deep sleep control allowing extra wakeup events
> @@ -916,6 +893,12 @@ static ssize_t toggle_deepsleep(struct device *dev,
>  	return count;
>  }
>  
> +static bool deepsleep_group_visible(struct kobject *kobj)
> +{
> +	return quirks->deepslp;
> +}
> +DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(deepsleep);
> +
>  static DEVICE_ATTR(deepsleep, S_IRUGO | S_IWUSR, show_deepsleep_status, toggle_deepsleep);
>  
>  static struct attribute *deepsleep_attrs[] = {
> @@ -925,25 +908,10 @@ static struct attribute *deepsleep_attrs[] = {
>  
>  static const struct attribute_group deepsleep_attribute_group = {
>  	.name = "deepsleep",
> +	.is_visible = SYSFS_GROUP_VISIBLE(deepsleep),
>  	.attrs = deepsleep_attrs,
>  };
>  
> -static void remove_deepsleep(struct platform_device *dev)
> -{
> -	if (quirks->deepslp > 0)
> -		sysfs_remove_group(&dev->dev.kobj, &deepsleep_attribute_group);
> -}
> -
> -static int create_deepsleep(struct platform_device *dev)
> -{
> -	int ret;
> -
> -	ret = sysfs_create_group(&dev->dev.kobj, &deepsleep_attribute_group);
> -	if (ret)
> -		remove_deepsleep(dev);
> -	return ret;
> -}
> -
>  /*
>   * Thermal Profile control
>   *  - Provides thermal profile control through the Platform Profile API
> @@ -1151,6 +1119,20 @@ static void remove_thermal_profile(void)
>  		platform_profile_remove();
>  }
>  
> +const struct attribute_group *wmax_groups[] = {
> +	&hdmi_attribute_group,
> +	&amplifier_attribute_group,
> +	&deepsleep_attribute_group,
> +	NULL
> +};

And this is not static.

I'll fix it.

> [...]

