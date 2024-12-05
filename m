Return-Path: <linux-kernel+bounces-433044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D19F9E5351
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F6FF167EEF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8061F1DD0EC;
	Thu,  5 Dec 2024 11:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DxDvQvIs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F1F1DC1AF;
	Thu,  5 Dec 2024 11:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733396760; cv=none; b=EZgKBLphvyPsHz58xyODuJ+jwhMeLX6fAJpFtLeZmtSmCe/446oRxk3wkYmR82ljIWMjdZBuTPptBK81eZZjFiBMdrQfkHQScSR9MSudOM5WonuOyEGGBLwkiDLHI+KNCuE+4w0XVRULsmhZeiw7TEFFODvdq5NmO7cFwrYGw5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733396760; c=relaxed/simple;
	bh=Nntjf2dViJcHYDyAFDAxMf0nRRDvUM4oGH/Ud4Z6HAM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Pw5nr0/BC+pcXi2J7rVLBm01q8GDaYjZ7HSNrhVz0J0LXCbPPEI/AfIbqPcT6RxoqvtdbGFe4W4DjgBzO6VNYpNgWlqXWlyeBnoIcZfWbpU5PchonI3XaNeTRJ06mNbUIxBYCzBIGr/7B3vixWvgJQ3ixz+PPSUaAUn5upnVShE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DxDvQvIs; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733396759; x=1764932759;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Nntjf2dViJcHYDyAFDAxMf0nRRDvUM4oGH/Ud4Z6HAM=;
  b=DxDvQvIsRxXPP88n1o76Rshj9LNF3Dc0uOC3U2j47OYilVJPkKAIdV1e
   ozv2rPF+OyLg7tjLaiI/tp90GIu3zBELbTK/i3xmNooth6d84MOyF5Tz2
   H4woHVTGXzvzDH25FRLIvrFNUgFWP1ergxv1rBOKO72csEk1+KOasp46Z
   RkWSCBmt6el1XEuYTxeMtJh+8m9rFT3gQ2CXuBpJziGbsuODqkGO+L1LB
   tV9VpYi9FAcNExqnJuvZKqWewNP5zeNgPMkv3dDduQQrz76PAdCKgvJL0
   Ry6p9VPELO0YfAgWBDXSFcUf3Tn1YRp3OZjjAOwLl+NKJUd3USCnZCO1H
   w==;
X-CSE-ConnectionGUID: CdnGYJu1QaGIPqzlRPpvuw==
X-CSE-MsgGUID: Kp1M63jATcCDiX7ppgJ71A==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="56182290"
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="56182290"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 03:05:57 -0800
X-CSE-ConnectionGUID: B7Ueq8LrRPu9wc2TT7pE8g==
X-CSE-MsgGUID: 4jNCLfzGQzukVuMxLgGAKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="117306797"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.60])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 03:05:54 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 5 Dec 2024 13:05:50 +0200 (EET)
To: Kurt Borja <kuurtb@gmail.com>
cc: Dell.Client.Kernel@dell.com, Hans de Goede <hdegoede@redhat.com>, 
    LKML <linux-kernel@vger.kernel.org>, mario.limonciello@amd.com, 
    platform-driver-x86@vger.kernel.org, w_armin@gmx.de
Subject: Re: [RFC PATCH 10/21] alienware-wmi: Add alienfx OPs to platdata
In-Reply-To: <20241205004225.2185672-2-kuurtb@gmail.com>
Message-ID: <b6875a98-6fce-435d-7061-9da7e907b69b@linux.intel.com>
References: <20241205002733.2183537-3-kuurtb@gmail.com> <20241205004225.2185672-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 4 Dec 2024, Kurt Borja wrote:

> Both WMI devices handled by this module specify a distinct interface for
> LED control. Previously this module handled this by dynamically adapting
> arguments passed to wmi_evaluate_method() based on the `interface`
> global variable.
> 
> To avoid the use of global variables, and enable the migration to
> wmidev_* methods, let the WMI drivers present a single interface through
> this "alienfx operations".
> 
> Also define alienware_wmi_command(), which serves as a wrapper for
> wmidev_evaluate_method(). This new method is very similar to
> alienware_wmax_command() but is WMI device agnostic and makes use of
> non-deprecated WMI methods.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  drivers/platform/x86/dell/alienware-wmi.c | 110 ++++++++++++++++++++++
>  1 file changed, 110 insertions(+)
> 
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> index 34fb59a14bc0..043cde40de9a 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -411,8 +411,16 @@ struct alienfx_priv {
>  	u8 lighting_control_state;
>  };
>  
> +struct alienfx_ops {
> +	int (*upd_led)(struct alienfx_priv *priv, struct wmi_device *wdev,
> +		       u8 location);
> +	int (*upd_brightness)(struct alienfx_priv *priv, struct wmi_device *wdev,
> +			      u8 brightness);
> +};
> +
>  struct alienfx_platdata {
>  	struct wmi_device *wdev;
> +	struct alienfx_ops ops;
>  };
>  
>  static struct platform_profile_handler pp_handler;
> @@ -421,6 +429,32 @@ static enum wmax_thermal_mode supported_thermal_profiles[PLATFORM_PROFILE_LAST];
>  static u8 interface;
>  static struct wmi_driver *preferred_wmi_driver;
>  
> +static acpi_status alienware_wmi_command(struct wmi_device *wdev, u32 method_id,
> +					 void *in_args, size_t in_size, u32 *out_data)
> +{
> +	acpi_status ret;
> +	union acpi_object *obj;

> +	struct acpi_buffer in = { in_size,  in_args };
> +	struct acpi_buffer out = {  ACPI_ALLOCATE_BUFFER, NULL };

Extra whitespace on both lines.

> +
> +	if (out_data) {
> +		ret = wmidev_evaluate_method(wdev, 0, method_id, &in, &out);
> +		if (ACPI_FAILURE(ret))
> +			goto out_free_ptr;
> +
> +		obj = (union acpi_object *) out.pointer;

The usual style for casts is without space but not an end of the world if 
you want to have the space there (in any case, it's not explicitly stated 
in coding style).

> +
> +		if (obj && obj->type == ACPI_TYPE_INTEGER)
> +			*out_data = (u32) obj->integer.value;
> +	} else {
> +		ret = wmidev_evaluate_method(wdev, 0, method_id, &in, NULL);
> +	}
> +
> +out_free_ptr:
> +	kfree(out.pointer);
> +	return ret;
> +}
> +
>  /*
>   * Helpers used for zone control
>   */
> @@ -1178,11 +1212,48 @@ static void alienfx_wmi_exit(struct wmi_device *wdev)
>  /*
>   * Legacy WMI device
>   */
> +static int legacy_wmi_update_led(struct alienfx_priv *priv,
> +				 struct wmi_device *wdev, u8 location)
> +{
> +	acpi_status status;
> +	struct acpi_buffer input;
> +	struct legacy_led_args legacy_args;

Mostly try to abide the reverse xmas tree order (but if there's 
dependency, feel free to violate it where it makes sense).

-- 
 i.

> +	legacy_args.colors = priv->colors[location];
> +	legacy_args.brightness = priv->global_brightness;
> +	legacy_args.state = priv->lighting_control_state;
> +
> +	input.length = sizeof(legacy_args);
> +	input.pointer = &legacy_args;
> +
> +	if (legacy_args.state == LEGACY_RUNNING)
> +		status = alienware_wmi_command(wdev, location + 1, &legacy_args,
> +					       sizeof(legacy_args), NULL);
> +	else
> +		status = wmi_evaluate_method(LEGACY_POWER_CONTROL_GUID, 0,
> +					     location + 1, &input, NULL);
> +
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static int legacy_wmi_update_brightness(struct alienfx_priv *priv,
> +					struct wmi_device *wdev, u8 brightness)
> +{
> +	return legacy_wmi_update_led(priv, wdev, 0);
> +}
> +
>  static int legacy_wmi_probe(struct wmi_device *wdev, const void *context)
>  {
>  	int ret = 0;
>  	struct alienfx_platdata pdata = {
>  		.wdev = wdev,
> +		.ops = {
> +			.upd_led = legacy_wmi_update_led,
> +			.upd_brightness = legacy_wmi_update_brightness,
> +		},
>  	};
>  
>  	if (quirks->num_zones > 0)
> @@ -1219,11 +1290,50 @@ static struct wmi_driver alienware_legacy_wmi_driver = {
>  /*
>   * WMAX WMI device
>   */
> +static int wmax_wmi_update_led(struct alienfx_priv *priv,
> +			       struct wmi_device *wdev, u8 location)
> +{
> +	acpi_status status;
> +	struct wmax_led_args in_args = {
> +		.led_mask = 1 << location,
> +		.colors = priv->colors[location],
> +		.state = priv->lighting_control_state,
> +	};
> +
> +	status = alienware_wmi_command(wdev, WMAX_METHOD_ZONE_CONTROL,
> +				       &in_args, sizeof(in_args), NULL);
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static int wmax_wmi_update_brightness(struct alienfx_priv *priv,
> +				      struct wmi_device *wdev, u8 brightness)
> +{
> +	acpi_status status;
> +	struct wmax_brightness_args in_args = {
> +		.led_mask = 0xFF,
> +		.percentage = brightness,
> +	};
> +
> +	status = alienware_wmi_command(wdev, WMAX_METHOD_BRIGHTNESS, &in_args,
> +				       sizeof(in_args), NULL);
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	return 0;
> +}
> +
>  static int wmax_wmi_probe(struct wmi_device *wdev, const void *context)
>  {
>  	int ret = 0;
>  	struct alienfx_platdata pdata = {
>  		.wdev = wdev,
> +		.ops = {
> +			.upd_led = wmax_wmi_update_led,
> +			.upd_brightness = wmax_wmi_update_brightness,
> +		},
>  	};
>  
>  	if (quirks->thermal)
> 

