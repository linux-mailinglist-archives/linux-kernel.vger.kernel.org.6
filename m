Return-Path: <linux-kernel+bounces-398528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3039BF26E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61DA7B25007
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4CE20408B;
	Wed,  6 Nov 2024 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TnQ3AabS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64821DE8AE;
	Wed,  6 Nov 2024 16:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730908908; cv=none; b=GszCXHa1LYHf1w+FVj99OWnpSt1xqyivlsbnxf3tWNP7iYuFH/OuC38qprbIWo6uXLireroryL/HdH7LJQWJCUEjw94IgPXn5jDN99bG21/Vtcp4mmvhD7gf8FD1wahMsdN+pA8yyuHPy9jdkiodGX40jwHsqrQbc/Rg8wrgnX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730908908; c=relaxed/simple;
	bh=0gZo0LpDDy6OaOxYoZPg0q/9CHab4Xlz711plnJ6z5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NS94FvYPZphFLfwa5gmgEFYQ6WMhoEDlMHof1d3b2Wy5qi3yk2dxGEOdhmj8vlwSDQ19IbmfIIJocgouY/KTpenVC/b6+R2bu5Kfrys96dhBsgCr3Vpts8Z2TS7dopvPVuj/zirlj/KXKI1BLX4Aax/nqwLXXF8d42k9uQ1oykI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TnQ3AabS; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730908906; x=1762444906;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0gZo0LpDDy6OaOxYoZPg0q/9CHab4Xlz711plnJ6z5c=;
  b=TnQ3AabSqhqCSSyv76EdQqARdfWfvtR4Aziqm1wnl5h1ZUoKGLy2rqXD
   Oq/3ipK3eGhiSgYK67ID1/yEV8E3miSP/KfywQ34kORw4OXtzNS+ygRNN
   OvaV4TgtnkXWiwM4ZLT0DT1+4uGVQpwgG7FFiZeKD/nLsOrqwRABY9MQA
   KjUmiUapj82w1dIh2o8NAgbxQuvqHCVlO2kGCqrH/40szxeyVvF1eexZz
   dYhS78yaPQ4F/zJIHv4/YaqVUFFr0Pq2V1lw/j0+FZbQzJg3vQR7TFkEz
   W+n9boeBZEXgxrNsBLpm9eZpPvaZC04aJRRfa+4Auzw3GV4n3eiXWSql5
   g==;
X-CSE-ConnectionGUID: YR5/PAtsTzC4TpBal0ow9g==
X-CSE-MsgGUID: VD3mSEazRFmwMiZPUYYlyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="34495837"
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="34495837"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 08:01:22 -0800
X-CSE-ConnectionGUID: KH3judhSRne8HkDe75e1aw==
X-CSE-MsgGUID: wl0MarRxSzOTkDoX8dB+ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="84247091"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 08:01:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t8iT7-0000000ByXm-0yBV;
	Wed, 06 Nov 2024 18:01:17 +0200
Date: Wed, 6 Nov 2024 18:01:16 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Alexis Cezar Torreno <alexisczezar.torreno@analog.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
	Radu Sabau <radu.sabau@analog.com>,
	Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/2] hwmon: (pmbus/adp1050): Support adp1051 and adp1055
Message-ID: <ZyuSzPXnxRYG4Gk3@smile.fi.intel.com>
References: <20241106090311.17536-1-alexisczezar.torreno@analog.com>
 <20241106090311.17536-3-alexisczezar.torreno@analog.com>
 <ZytSCD0dViGp-l2b@smile.fi.intel.com>
 <55825e91-b111-4689-bb3e-ede2c241728d@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55825e91-b111-4689-bb3e-ede2c241728d@roeck-us.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Nov 06, 2024 at 07:55:30AM -0800, Guenter Roeck wrote:
> On 11/6/24 03:24, Andy Shevchenko wrote:
> > On Wed, Nov 06, 2024 at 05:03:11PM +0800, Alexis Cezar Torreno wrote:
> > > ADP1051: 6 PWM for I/O Voltage, I/O Current, Temperature
> > > ADP1055: 6 PWM for I/O Voltage, I/O Current, Power, Temperature
> > 
> > Missing blank line and perhaps you can add Datasheet: tag(s) for these HW?
> > (see `git log --no-merges --grep Datasheet:` for the example)
> 
> Is that an official tag ? Frankly, if so, I think it is quite useless
> in the patch description because datasheet locations keep changing.
> I think it is much better to provide a link in the driver documentation.

I believe it's semi-official, meaning that people use it from time to time.
I'm fine with the Link in the documentation. Actually with any solution that
saves the respective link in the kernel source tree (either in form of commit
message or documentation / comments in the code).

...

> > > +static struct pmbus_driver_info adp1055_info = {
> > > +	.pages = 1,
> > > +	.format[PSC_VOLTAGE_IN] = linear,
> > > +	.format[PSC_VOLTAGE_OUT] = linear,
> > > +	.format[PSC_CURRENT_IN] = linear,
> > > +	.format[PSC_TEMPERATURE] = linear,
> > > +	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN | PMBUS_HAVE_VOUT
> > > +		   | PMBUS_HAVE_IOUT | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3
> > > +		   | PMBUS_HAVE_POUT | PMBUS_HAVE_STATUS_VOUT
> > > +		   | PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_INPUT
> > > +		   | PMBUS_HAVE_STATUS_TEMP,
> > 
> > Ditto.
> 
> That one slipped through with the original driver submission.
> I thought that checkpatch complains about that, but it turns out that
> it doesn't. I agree, though, that the usual style should be used.

Oh, okay, that's up to you then.

-- 
With Best Regards,
Andy Shevchenko



