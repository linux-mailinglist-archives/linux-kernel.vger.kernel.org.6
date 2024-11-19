Return-Path: <linux-kernel+bounces-414008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C15849D21C3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 09:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3455BB22E41
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 08:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C82D146D6A;
	Tue, 19 Nov 2024 08:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wc0cxL38"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E6112CDAE;
	Tue, 19 Nov 2024 08:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732005659; cv=none; b=JNZzAmRQWalR8vqiX8y2+wa7/55gZAKI2RfqNdxChRfZ2TfmDBg6ZaknStOrsW/JN3qzf0KMYqPFV8aPM2oaLhZoarIpXSLCHUC0t2JkkXEsIwI+f/Ih5bZsBE5gq0cjikBV/Hpi2XvakVBycFD5lqPPirXfXPwx88buoDVfV68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732005659; c=relaxed/simple;
	bh=foxpm5wKwlwloNq6usUERz7EFczzSTrfh6VAXsdfZzc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jV1udiHzKUvDkqd/3LHjSLTGLqSW+Xl7SdL9mKe2CAW44cXs+393O2wXVeQQdDCR1CHpEkd7fC/T/nLp/kwmfGpXjYvmqoDu2Gad5HAvTOaIm8v2W4pkzPXrP/k16yNKlkZJME8klEAbRPLREvr4KH+LkFn8or3mix0VuaFiGzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wc0cxL38; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732005657; x=1763541657;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=foxpm5wKwlwloNq6usUERz7EFczzSTrfh6VAXsdfZzc=;
  b=Wc0cxL38gtKtTeSA227Ii3yBK32Z3JKfifxTy2QOMTRou+/Boa9Enmox
   aUB8L4wg8FPUxrt6k+62C6pE+WHWTsl7Y36y1GBQU7+H/vg6hvnHXjfcC
   V1r2GTzuDd4Jj2YGJMNDHeQal/XUuaN0E0D54ApSgGx+MKBbyKGdgOHFP
   H5iYXC4MQkCVZJuzD+t7xfXAtyhU0i/lFe2j2wT2J2FGk9zwNeacNTp8A
   PW6eT4JTMbwd0d3fhZQblBpxbzE8COVeFYV1AVK/XULO+b4WTqvKECxmM
   Rsj8K+2C2agSfpaDFPSTmhSM9GZZ60VxC64tFFuadN2PN7bXPj87E69SR
   A==;
X-CSE-ConnectionGUID: iUi17JSoQCKKC7GnTp6YMQ==
X-CSE-MsgGUID: gQhBstmeT0GeJF0fGGuMHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="32236646"
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="32236646"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 00:40:56 -0800
X-CSE-ConnectionGUID: EPyqhKEPR9OcVcGv3UGW0Q==
X-CSE-MsgGUID: FsJUhN8cSUuArKLhcOcVPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="93553654"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.54])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 00:40:53 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 19 Nov 2024 10:40:50 +0200 (EET)
To: Kurt Borja <kuurtb@gmail.com>
cc: Dell.Client.Kernel@dell.com, Hans de Goede <hdegoede@redhat.com>, 
    LKML <linux-kernel@vger.kernel.org>, mario.limonciello@amd.com, 
    platform-driver-x86@vger.kernel.org, w_armin@gmx.de
Subject: Re: [PATCH 5/5] alienware-wmi: Improves sysfs groups creation
In-Reply-To: <20241119043534.25683-1-kuurtb@gmail.com>
Message-ID: <6705ecb2-96df-60f0-0e06-90ed4d8554ab@linux.intel.com>
References: <20241119043534.25683-1-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 19 Nov 2024, Kurt Borja wrote:

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
> To improve this, drop all helpers in favor of two helpers that make use
> of sysfs_create_groups/sysfs_remove_groups to cleanly create/remove
> groups at module init/exit.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
> 
> I have a question. Do the created sysfs groups get removed when their
> kobj reference count goes to 0? I ask because I want to know if this is
> a bug fix.
> 
> ---
>  drivers/platform/x86/dell/alienware-wmi.c | 105 ++++++++--------------
>  1 file changed, 36 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> index 44f1f7b57d0a..e9ed2089cba0 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -410,8 +410,10 @@ struct wmax_u32_args {
>  	u8 arg3;
>  };
>  
> +
>  static struct platform_device *platform_device;
>  static struct platform_zone *zone_data;
> +const struct attribute_group *wmax_groups[4];
>  static struct platform_profile_handler pp_handler;
>  static enum wmax_thermal_mode supported_thermal_profiles[PLATFORM_PROFILE_LAST];
>  
> @@ -810,22 +812,6 @@ static const struct attribute_group hdmi_attribute_group = {
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
> @@ -864,22 +850,6 @@ static const struct attribute_group amplifier_attribute_group = {
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
> @@ -942,22 +912,6 @@ static const struct attribute_group deepsleep_attribute_group = {
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
> @@ -1165,6 +1119,34 @@ static void remove_thermal_profile(void)
>  		platform_profile_remove();
>  }
>  
> +static int __init create_wmax_groups(struct platform_device *pdev)
> +{
> +	int no_groups = 0;
> +
> +	if (quirks->hdmi_mux) {
> +		wmax_groups[no_groups] = &hdmi_attribute_group;
> +		no_groups++;
> +	}
> +
> +	if (quirks->amplifier) {
> +		wmax_groups[no_groups] = &amplifier_attribute_group;
> +		no_groups++;
> +	}
> +
> +	if (quirks->deepslp) {
> +		wmax_groups[no_groups] = &deepsleep_attribute_group;
> +		no_groups++;
> +	}
> +
> +	return no_groups > 0 ? device_add_groups(&pdev->dev, wmax_groups) : 0;

Couldn't these use .dev_groups and .is_visible?

-- 
 i.


> +}
> +
> +static void __exit remove_wmax_groups(struct platform_device *pdev)
> +{
> +	if (!wmax_groups[0])
> +		device_remove_groups(&pdev->dev, wmax_groups);
> +}
> +
>  static int __init alienware_wmi_init(void)
>  {
>  	int ret;
> @@ -1203,23 +1185,9 @@ static int __init alienware_wmi_init(void)
>  		goto fail_platform_device1;
>  	}
>  
> -	if (quirks->hdmi_mux > 0) {
> -		ret = create_hdmi(platform_device);
> -		if (ret)
> -			goto fail_prep_hdmi;
> -	}
> -
> -	if (quirks->amplifier > 0) {
> -		ret = create_amplifier(platform_device);
> -		if (ret)
> -			goto fail_prep_amplifier;
> -	}
> -
> -	if (quirks->deepslp > 0) {
> -		ret = create_deepsleep(platform_device);
> -		if (ret)
> -			goto fail_prep_deepsleep;
> -	}
> +	ret = create_wmax_groups(platform_device);
> +	if (ret)
> +		goto fail_prep_groups;
>  
>  	if (quirks->thermal) {
>  		ret = create_thermal_profile();
> @@ -1236,9 +1204,8 @@ static int __init alienware_wmi_init(void)
>  fail_prep_zones:
>  	remove_thermal_profile();
>  fail_prep_thermal_profile:
> -fail_prep_deepsleep:
> -fail_prep_amplifier:
> -fail_prep_hdmi:
> +	remove_wmax_groups(platform_device);
> +fail_prep_groups:
>  	platform_device_unregister(platform_device);
>  fail_platform_device1:
>  	platform_driver_unregister(&platform_driver);
> @@ -1251,7 +1218,7 @@ module_init(alienware_wmi_init);
>  static void __exit alienware_wmi_exit(void)
>  {
>  	alienware_zone_exit(platform_device);
> -	remove_hdmi(platform_device);
> +	remove_wmax_groups(platform_device);
>  	remove_thermal_profile();
>  	platform_device_unregister(platform_device);
>  	platform_driver_unregister(&platform_driver);
> 


