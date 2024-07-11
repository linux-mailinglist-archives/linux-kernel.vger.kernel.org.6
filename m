Return-Path: <linux-kernel+bounces-248777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4F292E1E1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FE4928481A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39040150992;
	Thu, 11 Jul 2024 08:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KD6XpLIo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2EE14F9EA;
	Thu, 11 Jul 2024 08:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720685896; cv=none; b=TJbLZV0TytWXPGHCNcPx8BsDlFo2NRSgFOCdCY4NCJc8yjxYmIiakEI3KNV/ySeaVff4TM/sVOkRaWInPOChZyersRcRr9/k9PqO4eH8YZVmR8zZMfTwAjc4xdQWRQ6awZxKZvq/WkJKyCUwW+9S9h5Y8GPw3mhJyG8er+3pnA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720685896; c=relaxed/simple;
	bh=hZ5aBRIk6w1Xb/vi90JXT8G+yOEd1bCt1HTZvEBYk8I=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DMcs5k9sEqDiDVFg56ZeKJQOzU0qO6OJKMR+RD4Q6mojbwvYEVDmIjGBuP67Y2Bk5nnjB2NNTIalbNYvNxjcpBT/PqvCaP5uncBJZxZIWXtpzeAtUQ97JUPshQCTAUOhRFQlGUaGzNgE4Vlbn5cLHWGhdpB3QyE1FWn09JcTJk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KD6XpLIo; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720685895; x=1752221895;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hZ5aBRIk6w1Xb/vi90JXT8G+yOEd1bCt1HTZvEBYk8I=;
  b=KD6XpLIoqY7PcWZq/15XDGAZTTVHkMVVfxYdJYWuF3mn2aEWaxEeGIE5
   frNRjvnAppS2NzlbeC/uT5Gjd/X6/qb7e7oxuxkp3krDevHbVlEZ67UXx
   2Mrc2sgnlAtao4UHq02gVrHi0tkxMZYqtlCT51fF/Mv4jUPI/avthHgmt
   05WnlR+OiQqNGKozNvqQcgHJCY4KB0LEklbmoH0TcKMNivtGCLVvS5arI
   5Z6rgMrl/glkt4Pdf/K5vOSgMUDvO+BqLXW2DK3RrxvINXftbKZ/NR6sK
   yBiapvGnu0V4a6w0oaf4tqyMqpJOk3zdGpBcYgeWB0tffBCbfno6CdMnY
   w==;
X-CSE-ConnectionGUID: hdj13rKpQ7iuRSQoj+ON8Q==
X-CSE-MsgGUID: lEal/3S2TCGQg+wnXV9fUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="18185567"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="18185567"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 01:18:14 -0700
X-CSE-ConnectionGUID: KnCuWWB9TMOXEKuc/B/AzQ==
X-CSE-MsgGUID: jSKVOxgZRjim/5y9+s5xow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="71705902"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.127])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 01:18:12 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 11 Jul 2024 11:18:07 +0300 (EEST)
To: Gergo Koteles <soyer@irl.hu>
cc: Hans de Goede <hdegoede@redhat.com>, Ike Panhc <ike.pan@canonical.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] platform/x86: ideapad-laptop: move ymc_trigger_ec
 from lenovo-ymc
In-Reply-To: <44f63dfa758c811ae941216874fbb1ec77f4a293.1720515666.git.soyer@irl.hu>
Message-ID: <828057ef-b941-879e-170e-f4e769d4b77a@linux.intel.com>
References: <cover.1720515666.git.soyer@irl.hu> <44f63dfa758c811ae941216874fbb1ec77f4a293.1720515666.git.soyer@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 9 Jul 2024, Gergo Koteles wrote:

> Some models need to trigger the EC for the yoga mode control to work
> properly. EC triggering consists of a VPC call that needs to be
> synchronized. The vpc_mutex is in the ideapad-laptop module, so
> synchronization is easier there.
> 
> Move the ymc_trigger_ec function to the ideapad-laptop module.
> 
> Signed-off-by: Gergo Koteles <soyer@irl.hu>
> ---
>  drivers/platform/x86/Kconfig          |  1 +
>  drivers/platform/x86/ideapad-laptop.c | 18 ++++++++++++++
>  drivers/platform/x86/ideapad-laptop.h |  2 ++
>  drivers/platform/x86/lenovo-ymc.c     | 34 ++++-----------------------
>  4 files changed, 26 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 665fa9524986..ddfccc226751 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -477,6 +477,7 @@ config LENOVO_YMC
>  	tristate "Lenovo Yoga Tablet Mode Control"
>  	depends on ACPI_WMI
>  	depends on INPUT
> +	depends on IDEAPAD_LAPTOP
>  	select INPUT_SPARSEKMAP
>  	help
>  	  This driver maps the Tablet Mode Control switch to SW_TABLET_MODE input
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index 464cc5fd0088..4dcdbb153dda 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -1615,6 +1615,24 @@ static void ideapad_sync_touchpad_state(struct ideapad_private *priv, bool send_
>  	priv->r_touchpad_val = value;
>  }
>  
> +void ideapad_ymc_trigger_ec(void)
> +{
> +	struct ideapad_private *priv;
> +	int ret;
> +
> +	guard(mutex)(&ideapad_shared_mutex);
> +
> +	priv = ideapad_shared;
> +	if (!priv)
> +		return;
> +
> +	scoped_guard(mutex, &priv->vpc_mutex)

It feels the ordering in this series is off because patch 2 add the 
mutex and here you add it into yet another function. If this patch 
would be before the other, the mutex changes could all go into the same 
patch.

> +		ret = write_ec_cmd(priv->adev->handle, VPCCMD_W_YMC, 1);
> +	if (ret)
> +		dev_warn(&priv->platform_device->dev, "Could not write YMC: %d\n", ret);
> +}
> +EXPORT_SYMBOL_GPL(ideapad_ymc_trigger_ec);

This export should be namespaced.

I'll have to say I can accept this approach only grudgingly... it feels 
off even if I understand why you have to do this cross driver thing.

-- 
 i.

>  static void ideapad_acpi_notify(acpi_handle handle, u32 event, void *data)
>  {
>  	struct ideapad_private *priv = data;
> diff --git a/drivers/platform/x86/ideapad-laptop.h b/drivers/platform/x86/ideapad-laptop.h
> index 4498a96de597..4dcbed842b0b 100644
> --- a/drivers/platform/x86/ideapad-laptop.h
> +++ b/drivers/platform/x86/ideapad-laptop.h
> @@ -13,6 +13,8 @@
>  #include <linux/jiffies.h>
>  #include <linux/errno.h>
>  
> +void ideapad_ymc_trigger_ec(void);
> +
>  enum {
>  	VPCCMD_R_VPC1 = 0x10,
>  	VPCCMD_R_BL_MAX,
> diff --git a/drivers/platform/x86/lenovo-ymc.c b/drivers/platform/x86/lenovo-ymc.c
> index e1fbc35504d4..0819e9823ca9 100644
> --- a/drivers/platform/x86/lenovo-ymc.c
> +++ b/drivers/platform/x86/lenovo-ymc.c
> @@ -62,19 +62,14 @@ static const struct dmi_system_id allowed_chasis_types_dmi_table[] = {
>  
>  struct lenovo_ymc_private {
>  	struct input_dev *input_dev;
> -	struct acpi_device *ec_acpi_dev;
>  };
>  
> -static void lenovo_ymc_trigger_ec(struct wmi_device *wdev, struct lenovo_ymc_private *priv)
> +static void lenovo_ymc_trigger_ec(void)
>  {
> -	int err;
> -
> -	if (!priv->ec_acpi_dev)
> +	if (!ec_trigger)
>  		return;
>  
> -	err = write_ec_cmd(priv->ec_acpi_dev->handle, VPCCMD_W_YMC, 1);
> -	if (err)
> -		dev_warn(&wdev->dev, "Could not write YMC: %d\n", err);
> +	ideapad_ymc_trigger_ec();
>  }
>  
>  static const struct key_entry lenovo_ymc_keymap[] = {
> @@ -125,11 +120,9 @@ static void lenovo_ymc_notify(struct wmi_device *wdev, union acpi_object *data)
>  
>  free_obj:
>  	kfree(obj);
> -	lenovo_ymc_trigger_ec(wdev, priv);
> +	lenovo_ymc_trigger_ec();
>  }
>  
> -static void acpi_dev_put_helper(void *p) { acpi_dev_put(p); }
> -
>  static int lenovo_ymc_probe(struct wmi_device *wdev, const void *ctx)
>  {
>  	struct lenovo_ymc_private *priv;
> @@ -149,23 +142,6 @@ static int lenovo_ymc_probe(struct wmi_device *wdev, const void *ctx)
>  	if (!priv)
>  		return -ENOMEM;
>  
> -	if (ec_trigger) {
> -		pr_debug("Lenovo YMC enable EC triggering.\n");
> -		priv->ec_acpi_dev = acpi_dev_get_first_match_dev("VPC2004", NULL, -1);
> -
> -		if (!priv->ec_acpi_dev) {
> -			dev_err(&wdev->dev, "Could not find EC ACPI device.\n");
> -			return -ENODEV;
> -		}
> -		err = devm_add_action_or_reset(&wdev->dev,
> -				acpi_dev_put_helper, priv->ec_acpi_dev);
> -		if (err) {
> -			dev_err(&wdev->dev,
> -				"Could not clean up EC ACPI device: %d\n", err);
> -			return err;
> -		}
> -	}
> -
>  	input_dev = devm_input_allocate_device(&wdev->dev);
>  	if (!input_dev)
>  		return -ENOMEM;
> @@ -192,7 +168,7 @@ static int lenovo_ymc_probe(struct wmi_device *wdev, const void *ctx)
>  	dev_set_drvdata(&wdev->dev, priv);
>  
>  	/* Report the state for the first time on probe */
> -	lenovo_ymc_trigger_ec(wdev, priv);
> +	lenovo_ymc_trigger_ec();
>  	lenovo_ymc_notify(wdev, NULL);
>  	return 0;
>  }
> 

