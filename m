Return-Path: <linux-kernel+bounces-301946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D17F095F7D8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C00EB21C10
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E0219885D;
	Mon, 26 Aug 2024 17:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YUecXhJM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E8864A;
	Mon, 26 Aug 2024 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692918; cv=none; b=oIjAnTQaaPJdPqu9weOm5zxwpnvWPBcZrkQ7FYIrKXBXdsUZCh+lIrB7PZ4JruXrk1t/C8XQmkzhRm9MEqN7ZsyNXCbk6EG5L6uXQ1g/DzGm03O7ZaOes5hjoabCqJBhNsAypBFqwmv5ZH+DoPmtrzCjdd+A7CKl6kn869k2yDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692918; c=relaxed/simple;
	bh=lkLq0gZHHCT225w7KBWxwFP8hdO2Ew8mCt6F0ilTIck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHJJ3PbdQK5JnmmAywELO+cbjusPWQ9gR1rypNjhZa3X5oGfx1zMv9WkZynx3G0SDOVJdtWe7yYkGmIWcLX34rGU5e6AnMCqwBkvNHFYj6BMQGL5dSE9DVox83pyfVd+jZZNPFx3F4/ovrQpsNU9pWz6Yu7q94dPX24b40ZIA1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YUecXhJM; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724692918; x=1756228918;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lkLq0gZHHCT225w7KBWxwFP8hdO2Ew8mCt6F0ilTIck=;
  b=YUecXhJM9+bnHElodZZcjBPsWvkKF/MwjWs6B3SRUk2crfCqt+vIrAOt
   O6REqa/3FczZtHmhZ+NCTiDXf1lOMc9jd6OH+PmHMy6ItdM89q0/EckRA
   Iy72VPWpUrgJyGWGzqXn1mQvjBhTfU+PHyg58Blj4GXgVwsk9FT6Iz/Bw
   xBmwHwpL0qNjcWgQsyz2GJaByCOdTTIftsk0jWKBI8SJZ4ES/Sn1VTmWq
   ffUIZZ4fVBp/8Wv1br0fIwWfJ6W0Kt3RrW1lZHa9xrrtqgAT0BXta/eCw
   9GVwLYa0E9QACWLaXLhRS5ru0YY6sz/YBj0jaHt8WdyWtTGSx0wgYfuev
   A==;
X-CSE-ConnectionGUID: K0eUZ63MSHu2xxlGUbCBJQ==
X-CSE-MsgGUID: 1OxVTVIqSCCCfrB2ZMolRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="40601221"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="40601221"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 10:21:57 -0700
X-CSE-ConnectionGUID: MmNG/6OFQUmuQCOOgaa7wQ==
X-CSE-MsgGUID: 8wiKmWJWRXC4vrLLno4P0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="67474240"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 10:21:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sidPc-000000021Qh-2GIC;
	Mon, 26 Aug 2024 20:21:52 +0300
Date: Mon, 26 Aug 2024 20:21:52 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Scally <djrscally@gmail.com>
Subject: Re: [PATCH v1 1/1] platform/x86: int3472: discrete: Remap "reset" to
 "enable" for OV7251
Message-ID: <Zsy5sDXD4lnACobC@smile.fi.intel.com>
References: <20240821184546.627456-1-andriy.shevchenko@linux.intel.com>
 <ae68cba8-564c-47bf-a796-2bf15b3998d6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae68cba8-564c-47bf-a796-2bf15b3998d6@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Aug 26, 2024 at 05:12:44PM +0200, Hans de Goede wrote:
> On 8/21/24 8:40 PM, Andy Shevchenko wrote:
> > The driver of OV7251 expects "enable" pin instead of "reset".
> > Remap "reset" to "enable" and update polarity.
> > 
> > In particular, the Microsoft Surface Book can't load the camera sensor
> > driver without this change:
> > 
> >  ov7251 i2c-INT347E:00: supply vdddo not found, using dummy regulator
> >  ov7251 i2c-INT347E:00: supply vddd not found, using dummy regulator
> >  ov7251 i2c-INT347E:00: supply vdda not found, using dummy regulator
> >  ov7251 i2c-INT347E:00: cannot get enable gpio
> >  ov7251 i2c-INT347E:00: probe with driver ov7251 failed with error -2
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > 
> > Hmm... I have spent some time to achieve this, and then I realised that
> > linux-surface GitHub project already has something similar [1].
> > 
> > The advantage of [1] is that it applies the quirk to all OV7251 sensors
> > on the platform (don't know how useful it IRL).
> > 
> > However, it seems the [1] has two issues:
> > 1) it missed terminator entry in the ACPI ID table;
> > 2) it forces polarity to be active high, while I think the XOR approach
> > is better as it's possible (but quite unlikely I believe) that reset pin
> > might be inverted on the PCB level.
> > 
> > All in all, I'm fine with any of these patches to be applied with the
> > above mentioned improvements / caveats.
> > 
> > Link: https://github.com/linux-surface/kernel/commit/d0f2c2d5a449c2bf69432f90d164183143d8af8d [1]
> 
> Looking at the datasheet the sensor actually has a reset pin and not
> an enable pin and the current GPIO mapping in the ov7251 driver /
> device-tree bindings is wrong.
> 
> The datasheet describes the single reset control pin as:
> 
> D6 XSHUTDOWN input "reset (active low with internal pull down resistor)"
> 
> So as we have done before I would greatly prefer for the sensor driver
> to get fixed instead of hacking around this in the int3472 code.
> 
> You could do something similar to what is done in the ov2680.c driver
> for this, here is the ov2680 gpiod-get code adjusted for the ov7251 case:
> 
>         /*
>          * The device-tree bindings call this pin "enable", but the
> 	 * datasheet describes the pin as "reset (active low with internal
> 	 * pull down resistor)". The ACPI tables describing this sensor
> 	 * on e.g. the Microsoft Surface Book use the ACPI equivalent of
> 	 * "reset" as pin name, which ACPI glue code then maps to "reset".
>  	 * Check for a "reset" pin if there is no "enable" pin.
>          */
> 	ov7251->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_HIGH);
> 	if (IS_ERR(ov7251->enable_gpio)) {
> 		ov7251->enable_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> 		if (!IS_ERR(ov7251->enable_gpio))
> 			gpiod_toggle_active_low(ov7251->enable_gpio);
> 	}
> 	if (IS_ERR(ov7251->enable_gpio)) {
>                 dev_err(dev, "cannot get enable gpio\n");
>                 return PTR_ERR(ov7251->enable_gpio);
>         }

That's a good idea!

We can also fix in-kernel DT with that, because now it's quite confusing to
have a comment for CAMx_RST_N (note N, sic!).

I will test this at some point in the future unless Dan or somebody else beats
me up to it.

> >  drivers/platform/x86/intel/int3472/discrete.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
> > index b5f6f71bb1dd..0559295dfb27 100644
> > --- a/drivers/platform/x86/intel/int3472/discrete.c
> > +++ b/drivers/platform/x86/intel/int3472/discrete.c
> > @@ -86,6 +86,16 @@ static int skl_int3472_map_gpio_to_sensor(struct int3472_discrete_device *int347
> >  		return -EINVAL;
> >  	}
> >  
> > +	/*
> > +	 * The driver of OV7251 expects "enable" pin instead of "reset".
> > +	 * Remap "reset" to "enable" and update polarity.
> > +	 */
> > +	if (!strcmp(int3472->sensor_name, "i2c-INT347E:00") &&
> > +	    !strcmp(func, "reset")) {
> > +		func = "enable";
> > +		polarity ^= GPIO_ACTIVE_LOW;
> > +	}
> > +
> >  	ret = skl_int3472_fill_gpiod_lookup(&int3472->gpios.table[int3472->n_sensor_gpios],
> >  					    agpio, func, polarity);
> >  	if (ret)

-- 
With Best Regards,
Andy Shevchenko



