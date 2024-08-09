Return-Path: <linux-kernel+bounces-281075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A630D94D2B9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2503F1F21BD6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C354197A65;
	Fri,  9 Aug 2024 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JYTGeDt3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23D8175AB;
	Fri,  9 Aug 2024 14:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723215345; cv=none; b=GGURSv1tu62V+ZaTdOGHYxsopgLG46kRKbJS+VxazqXmfoOBqdiqx5+mRxFwA+DONhl4Yy5iRu5ouBw7eB4oaLuNWRrWK5ZRiUEH3YXPKWwR7txLTOJ9MXtD9h+zARV7ce4N240YeS8caJ+9lZpHHnI1Y55VC6ry6MhhngJaX38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723215345; c=relaxed/simple;
	bh=CD71cNIsLw94o+FME/DmfOowqfxC2OXOBO8DMdNGFCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Scuook5bcUmb8NlU4PF/RxH3z+P8c9Cxxz0PHdcVn7HuWTsVfsb/IZRoYKqMVqax3ZqWr4jl3+u5WBxe2lR4UQkRlBQDWJ2X6GCDMA+aymJbWzDJalCH/j91pRtZaPgiJAe4eV/OW4CkEw536g9Jth+1ww9KtPTkK+J4ATsSePM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JYTGeDt3; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723215344; x=1754751344;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CD71cNIsLw94o+FME/DmfOowqfxC2OXOBO8DMdNGFCY=;
  b=JYTGeDt3Bc97Nk2fihqmcuAddgmToGpihdJKUNrJnfny/tnFt8hh6LAf
   UoyesmYV/pIFSaJCLAwvKojmiABdFxcUeikBL2Ajoz+Raj4QkasD9TzQ+
   XYdPRIGVtLvLV/o0F4ea/2/JsPw9c8Fmmse7s/ypb7uLmy03rDsbkaF4X
   yd3IUIN/3eA7uuMbsD+Q8RR+5uDBKiLHi5AU5AYBqTDvnL3ekXZUnnZk/
   5umX8X5ExA90UZAAv4+BH8L1OKNxk8Qa/tawxtccgyJRAQ/0ZtNrAezIv
   Ir+kZHao6b/2uBJZdQOmd4OO+8842yXRwyxS2bBCf6JAMAuEmyv7ZuVHU
   Q==;
X-CSE-ConnectionGUID: bI9kNglKR2uVq/b9uDM3Dg==
X-CSE-MsgGUID: 85hy0TwJTWSEDHxLTNKOnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="21534201"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="21534201"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 07:55:42 -0700
X-CSE-ConnectionGUID: KneSiHdoSViOtNTPGaRvqA==
X-CSE-MsgGUID: yeAlnjLFTHKwsOtoU+l1UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="57804712"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 07:55:37 -0700
Date: Fri, 9 Aug 2024 17:55:33 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com,
	daniel@ffwll.ch, linux@roeck-us.net, andi.shyti@linux.intel.com,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	anshuman.gupta@intel.com, badal.nilawar@intel.com,
	riana.tauro@intel.com, ashutosh.dixit@intel.com,
	karthik.poosa@intel.com
Subject: Re: [PATCH v4] drm/i915/hwmon: expose fan speed
Message-ID: <ZrYt5b7Tkl62FRyt@black.fi.intel.com>
References: <20240809061525.1368153-1-raag.jadav@intel.com>
 <ZrYB-GI9L2RSc2bt@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrYB-GI9L2RSc2bt@smile.fi.intel.com>

On Fri, Aug 09, 2024 at 02:48:08PM +0300, Andy Shevchenko wrote:
> On Fri, Aug 09, 2024 at 11:45:25AM +0530, Raag Jadav wrote:
> > Add hwmon support for fan1_input attribute, which will expose fan speed
> > in RPM. With this in place we can monitor fan speed using lm-sensors tool.
> > 
> > $ sensors
> > i915-pci-0300
> > Adapter: PCI adapter
> > in0:         653.00 mV
> > fan1:        3833 RPM
> > power1:           N/A  (max =  43.00 W)
> > energy1:      32.02 kJ
> 
> > v2:
> > - Add mutex protection
> > - Handle overflow
> > - Add ABI documentation
> > - Aesthetic adjustments (Riana)
> > 
> > v3:
> > - Declare rotations as "long" and drop redundant casting
> > - Change date and version in ABI documentation
> > - Add commenter name in changelog (Riana)
> > 
> > v4:
> > - Fix wakeref leak
> > - Drop switch case and simplify hwm_fan_xx() (Andi)
> 
> I do not understand why we pollute Git history with changelogs, but it's
> probably the ugly atavism in DRM workflow.

Yeah I'm still getting used to it.
Also welcome back, hope it's not a bad start ;)

> ...
> 
> > +hwm_fan_is_visible(const struct hwm_drvdata *ddat, u32 attr)
> > +{
> > +	struct i915_hwmon *hwmon = ddat->hwmon;
> > +
> > +	return attr == hwmon_fan_input &&
> > +	       i915_mmio_reg_valid(hwmon->rg.fan_speed) ? 0444 : 0;
> 
> Not sure why ternary here, it's not well readable in my opinion.
> 
> 	if (attr == hwmon_fan_input && i915_mmio_reg_valid(hwmon->rg.fan_speed))
> 		return 0444;
> 
> 	return 0;
> 
> looks better, no?

Andi had a preference for single return statement.
I'm personally fine with both.

> ...
> 
> > +	/*
> > +	 * HW register value is accumulated count of pulses from
> > +	 * PWM fan with the scale of 2 pulses per rotation.
> > +	 */
> > +	rotations = pulses >> 1;
> 
> In accordance with the comment the
> 
> 	rotations = pulses / 2;
> 
> looks better.
> 
> ...
> 
> (1)
> 
> > +	time = time_now - fi->time_prev;
> > +
> 
> I think location of this blank line is better at (1) above.
> 
> > +	if (unlikely(!time)) {
> > +		ret = -EAGAIN;
> > +		goto exit;
> > +	}

Sure.

> ...
> 
> > +	/* Convert to minutes for calculating RPM */
> > +	*val = DIV_ROUND_UP(rotations * (60 * MSEC_PER_SEC), time);
> 
> Have you considered to keep jiffies in the fi and use something from jiffies.h
> here? To me it feels like we multiply and divide when it can be avoided.
> Please, think about it (I haven't checked myself, just an idea to share).

Will explore.

Raag

