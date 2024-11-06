Return-Path: <linux-kernel+bounces-398106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 338159BE577
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 12:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16D9D1C21266
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 11:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB19B1DE4FA;
	Wed,  6 Nov 2024 11:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G/ix3cpw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7541DDC30;
	Wed,  6 Nov 2024 11:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730892305; cv=none; b=l8DDi0EiFJUU7uZBF5ZSMCfzo+WTXonc6J8RLVdKw3IvQ1GAfjtU6FkgOjmojvBC3UoHepaucmQ+v2rVhIwUv3bNX+iwFM9tYVRgg7FTyc5JD+xFJNZMIcwCyvISqEjZZ6bQ48tV/p+PK7O32AGYHEeN/yVMg6Mgkuf8zPYUDz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730892305; c=relaxed/simple;
	bh=+s+4Z9BY1gKoGqiJ6WInB5iJMwPreFFWbpYFsVdwIDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBE223mqHHtnJuVdlgwpP1iy19e98J8S5mRxHWDP9Zx918dA65cRYJzxGag8kfNP4Hlv1BoUfsJcEdruns1UVFJ5y++A1LRfpcfQ+S/Uf+6rQAKs/u6LgAL+317v3G5DrhEUxhEv2K5jAIF+edNyNbjY/gwYQv5hAhsFa5TudlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G/ix3cpw; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730892304; x=1762428304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+s+4Z9BY1gKoGqiJ6WInB5iJMwPreFFWbpYFsVdwIDI=;
  b=G/ix3cpwtweJ2rUy/JDh3j8fh9BIpr5KDdIpdytlmB2s5ipVae6J34bn
   Rx+acuaE10HjZJumXWdFcAf+4Elnd2nG4DoYdDE4AB7f1TReutl95q5j5
   Yl9XOXmZyxMmw01vAd0rP789wmtJsNSsDM6P5APezY73o4Gx9nEUnYxZD
   k21wodNt/i2FRAephiU+xvI5sPc7uRu7snCARUwAifhsqn2JU3D9gUMIy
   soSZjK6WnWByknhI41gvM1v9USMJJmfdT3B3vPsemFEwni3vOOEgLQnZD
   6U1u/N0Z/faRgR1wSlfawb4ISEXE4QzS0CJJKFj1o+S9bp8lvHUwYGr7o
   w==;
X-CSE-ConnectionGUID: zDreIeM0QsWExQ1yQjjsSw==
X-CSE-MsgGUID: GrTJUr1JRGKg6eG6HCvGkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41785294"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41785294"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 03:25:03 -0800
X-CSE-ConnectionGUID: +SW4i7uhT4uKtSCoAUx8lQ==
X-CSE-MsgGUID: KfEoq31gSuGq/r24vJ6jpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="84398673"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 03:25:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t8e9g-0000000Bm1P-1gx9;
	Wed, 06 Nov 2024 13:24:56 +0200
Date: Wed, 6 Nov 2024 13:24:56 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alexis Cezar Torreno <alexisczezar.torreno@analog.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
	Radu Sabau <radu.sabau@analog.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/2] hwmon: (pmbus/adp1050): Support adp1051 and adp1055
Message-ID: <ZytSCD0dViGp-l2b@smile.fi.intel.com>
References: <20241106090311.17536-1-alexisczezar.torreno@analog.com>
 <20241106090311.17536-3-alexisczezar.torreno@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106090311.17536-3-alexisczezar.torreno@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Nov 06, 2024 at 05:03:11PM +0800, Alexis Cezar Torreno wrote:
> ADP1051: 6 PWM for I/O Voltage, I/O Current, Temperature
> ADP1055: 6 PWM for I/O Voltage, I/O Current, Power, Temperature

Missing blank line and perhaps you can add Datasheet: tag(s) for these HW?
(see `git log --no-merges --grep Datasheet:` for the example)

> Signed-off-by: Alexis Cezar Torreno <alexisczezar.torreno@analog.com>

...

> --- a/drivers/hwmon/pmbus/adp1050.c
> +++ b/drivers/hwmon/pmbus/adp1050.c
> @@ -6,8 +6,8 @@
>   */
>  #include <linux/bits.h>
>  #include <linux/i2c.h>
> -#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  
>  #include "pmbus.h"

Stray change. This pure depends on the your `locale` settings.
The original one seems using en_US.UTF-8 and it's perfectly fine.

...

> +static struct pmbus_driver_info adp1051_info = {
> +	.pages = 1,
> +	.format[PSC_VOLTAGE_IN] = linear,
> +	.format[PSC_VOLTAGE_OUT] = linear,
> +	.format[PSC_CURRENT_IN] = linear,
> +	.format[PSC_TEMPERATURE] = linear,
> +	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN | PMBUS_HAVE_VOUT
> +		   | PMBUS_HAVE_IOUT | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_VOUT
> +		   | PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_INPUT
> +		   | PMBUS_HAVE_STATUS_TEMP,

I dunno if the other entries in the file are written in the same style, but
usual one is

	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN | PMBUS_HAVE_VOUT |
		   PMBUS_HAVE_IOUT | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_VOUT |
		   PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_INPUT |
		   PMBUS_HAVE_STATUS_TEMP,

Or even more logically

	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN |
		   PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
		   PMBUS_HAVE_TEMP |
		   PMBUS_HAVE_STATUS_INPUT |
		   PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT |
		   PMBUS_HAVE_STATUS_TEMP,

> +};
> +
> +static struct pmbus_driver_info adp1055_info = {
> +	.pages = 1,
> +	.format[PSC_VOLTAGE_IN] = linear,
> +	.format[PSC_VOLTAGE_OUT] = linear,
> +	.format[PSC_CURRENT_IN] = linear,
> +	.format[PSC_TEMPERATURE] = linear,
> +	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN | PMBUS_HAVE_VOUT
> +		   | PMBUS_HAVE_IOUT | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3
> +		   | PMBUS_HAVE_POUT | PMBUS_HAVE_STATUS_VOUT
> +		   | PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_INPUT
> +		   | PMBUS_HAVE_STATUS_TEMP,

Ditto.

> +};

...

>  static const struct i2c_device_id adp1050_id[] = {
> -	{"adp1050"},
> +	{ .name = "adp1050", .driver_data = (kernel_ulong_t)&adp1050_info},
> +	{ .name = "adp1051", .driver_data = (kernel_ulong_t)&adp1051_info},
> +	{ .name = "adp1055", .driver_data = (kernel_ulong_t)&adp1055_info},
>  	{}
>  };

> +

Stray blank line.

>  MODULE_DEVICE_TABLE(i2c, adp1050_id);

-- 
With Best Regards,
Andy Shevchenko



