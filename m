Return-Path: <linux-kernel+bounces-361019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55D499A26E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D82141C2378D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3796215F50;
	Fri, 11 Oct 2024 11:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eA2a8Unf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F35A2141D6;
	Fri, 11 Oct 2024 11:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728644886; cv=none; b=qhS69pVnU6kQNVAAklTzqf9HtfyzEpVgJNXGufXSELnmAnDZmMhikI+bHchii4jCcVlEDu9qc3y58SnfEBEyh09OAHhjsCIwj7brI24oW5CWwd9chjLON5M4xCAgyixcEOERjjYQWyD3vGPI1hBHIQu34hx3UluhdUJ/gkp6K2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728644886; c=relaxed/simple;
	bh=x5DKXx2zGLj8Z0SFGl9Ns91UnOPhG/Ub75VYlomXoTM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gZlGu12C22dRka+rzvSSoq7Jr0v0gz0GcV0vV0SRj7LBLV7aHv9PyKknHuf4BEtm9ZJE0B9PZQgMwwH1TxLPa6KRODD8Tvcut+AaNgnVXNMBmT/OOwxUJR3zJ9CJWUeJMAFC8P0C970vSMItgTy+vyRyvMsWKfvzB+6pd/+Bq4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eA2a8Unf; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728644884; x=1760180884;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=x5DKXx2zGLj8Z0SFGl9Ns91UnOPhG/Ub75VYlomXoTM=;
  b=eA2a8UnfHOKPN5dsuvojy6v3j54b/hxvu6q/p6OYUe9ZhXMX20BTqMTf
   hsqcZCp7ngJair831wqwmTfoGNdQqgfSRYH893xiENSQ7TbCc2Ux6oiFW
   +SCmhK2UbPaWm7xe2NpMJmB3gnWxkSCP+bVbMjNeW6gKLSwvmWO23dY88
   V/I26IkemShHaTTS4HCP3e6RIk6dB9Tf7nQyB9RsaDo5Z6z02X1YWtB7N
   3VTHtemhrhF/ynnylTRpO/BwMr41jZE8hjjhFaCVlUvo8rWGdURY6xisa
   lxUx0P6QTCct1212J84dWEax4S+0QQPuFTuVfX7U07KN4S0I/h2FeE0wO
   Q==;
X-CSE-ConnectionGUID: z3mRUulSSoOujiKTZLCiaQ==
X-CSE-MsgGUID: zr8hQahuQjeIoXo4jXuwng==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="39169802"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="39169802"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 04:08:04 -0700
X-CSE-ConnectionGUID: AHEP0UNeTkeuIpSRNper8Q==
X-CSE-MsgGUID: fdbeuio6TxKMMOEHXO8YLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="107732736"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.164])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 04:08:02 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 11 Oct 2024 14:07:58 +0300 (EEST)
To: Kurt Borja <kuurtb@gmail.com>
cc: Hans de Goede <hdegoede@redhat.com>, W_Armin@gmx.de, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4 2/4] alienware-wmi: alienware_wmax_command() is now
 input size agnostic
In-Reply-To: <20241011064712.306484-2-kuurtb@gmail.com>
Message-ID: <61bddc97-0fd0-8639-2df2-8b0b48f90695@linux.intel.com>
References: <20241011064336.305795-2-kuurtb@gmail.com> <20241011064712.306484-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 11 Oct 2024, Kurt Borja wrote:

As mentioned, please add the description of the change here.

This change also does int * -> u32 *, which I think is fine but please 
mention the justification here. If somebody looks this change 10 years 
from now, it helps a lot when the reasoning is recorded into the change.

-- 
 i.

> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  drivers/platform/x86/dell/alienware-wmi.c | 29 ++++++++++++-----------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> index 16a3fe9ac..8f7a8bfef 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -500,15 +500,15 @@ static void alienware_zone_exit(struct platform_device *dev)
>  	kfree(zone_attrs);
>  }
>  
> -static acpi_status alienware_wmax_command(struct wmax_basic_args *in_args,
> -					  u32 command, int *out_data)
> +static acpi_status alienware_wmax_command(void *in_args, size_t insize,
> +					  u32 command, u32 *out_data)
>  {
>  	acpi_status status;
>  	union acpi_object *obj;
>  	struct acpi_buffer input;
>  	struct acpi_buffer output;
>  
> -	input.length = sizeof(*in_args);
> +	input.length = insize;
>  	input.pointer = in_args;
>  	if (out_data) {
>  		output.length = ACPI_ALLOCATE_BUFFER;
> @@ -541,8 +541,8 @@ static ssize_t show_hdmi_cable(struct device *dev,
>  		.arg = 0,
>  	};
>  	status =
> -	    alienware_wmax_command(&in_args, WMAX_METHOD_HDMI_CABLE,
> -				   &out_data);
> +	    alienware_wmax_command(&in_args, sizeof(in_args),
> +				   WMAX_METHOD_HDMI_CABLE, &out_data);
>  	if (ACPI_SUCCESS(status)) {
>  		if (out_data == 0)
>  			return sysfs_emit(buf, "[unconnected] connected unknown\n");
> @@ -562,8 +562,8 @@ static ssize_t show_hdmi_source(struct device *dev,
>  		.arg = 0,
>  	};
>  	status =
> -	    alienware_wmax_command(&in_args, WMAX_METHOD_HDMI_STATUS,
> -				   &out_data);
> +	    alienware_wmax_command(&in_args, sizeof(in_args),
> +				   WMAX_METHOD_HDMI_STATUS, &out_data);
>  
>  	if (ACPI_SUCCESS(status)) {
>  		if (out_data == 1)
> @@ -589,7 +589,8 @@ static ssize_t toggle_hdmi_source(struct device *dev,
>  		args.arg = 3;
>  	pr_debug("alienware-wmi: setting hdmi to %d : %s", args.arg, buf);
>  
> -	status = alienware_wmax_command(&args, WMAX_METHOD_HDMI_SOURCE, NULL);
> +	status = alienware_wmax_command(&args, sizeof(args),
> +					WMAX_METHOD_HDMI_SOURCE, NULL);
>  
>  	if (ACPI_FAILURE(status))
>  		pr_err("alienware-wmi: HDMI toggle failed: results: %u\n",
> @@ -642,8 +643,8 @@ static ssize_t show_amplifier_status(struct device *dev,
>  		.arg = 0,
>  	};
>  	status =
> -	    alienware_wmax_command(&in_args, WMAX_METHOD_AMPLIFIER_CABLE,
> -				   &out_data);
> +	    alienware_wmax_command(&in_args, sizeof(in_args),
> +				   WMAX_METHOD_AMPLIFIER_CABLE, &out_data);
>  	if (ACPI_SUCCESS(status)) {
>  		if (out_data == 0)
>  			return sysfs_emit(buf, "[unconnected] connected unknown\n");
> @@ -694,8 +695,8 @@ static ssize_t show_deepsleep_status(struct device *dev,
>  	struct wmax_basic_args in_args = {
>  		.arg = 0,
>  	};
> -	status = alienware_wmax_command(&in_args, WMAX_METHOD_DEEP_SLEEP_STATUS,
> -					&out_data);
> +	status = alienware_wmax_command(&in_args, sizeof(in_args),
> +					WMAX_METHOD_DEEP_SLEEP_STATUS, &out_data);
>  	if (ACPI_SUCCESS(status)) {
>  		if (out_data == 0)
>  			return sysfs_emit(buf, "[disabled] s5 s5_s4\n");
> @@ -723,8 +724,8 @@ static ssize_t toggle_deepsleep(struct device *dev,
>  		args.arg = 2;
>  	pr_debug("alienware-wmi: setting deep sleep to %d : %s", args.arg, buf);
>  
> -	status = alienware_wmax_command(&args, WMAX_METHOD_DEEP_SLEEP_CONTROL,
> -					NULL);
> +	status = alienware_wmax_command(&args, sizeof(args),
> +					WMAX_METHOD_DEEP_SLEEP_CONTROL, NULL);
>  
>  	if (ACPI_FAILURE(status))
>  		pr_err("alienware-wmi: deep sleep control failed: results: %u\n",
> 

