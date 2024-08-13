Return-Path: <linux-kernel+bounces-284319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA6D94FFD3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7A25284378
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2061487F9;
	Tue, 13 Aug 2024 08:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ThALaafD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F1113C691;
	Tue, 13 Aug 2024 08:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723537652; cv=none; b=EFQVKcLD6FgDQzpbHgzTFWvdLZ7yaA0vbt7VyWyifqPnywMVEdLNp643g/wiZmjuoak89hi0ZUgv9Lgd7A9BA70IwgKOKWa4Df8YFEjDqn3+UvP3UgZnEGwJ9V9S11PbZJn91bFfYyShQ5bF5V2iVrZI7Xk6AWfKpP9glZO6L4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723537652; c=relaxed/simple;
	bh=RyDHZHG1qM+4Ggl8UqXwMYT3dj0QzqQytYDcJf5gWcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmMiE4Pa2WSbQdODbn0IO6T91kxfqArDxt03CiKX7fiNZXzKoXZQN0s4TqX6VNyUt8CadURowJ4lDrMdQNCeYTGSFKIob2B3FOuR4oAWV9LYil92bsV3D8/xOg61b5YSnjhY/hkuw3tKijYxjDBjILk+lihjavEISOk6ACo4ubQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ThALaafD; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723537651; x=1755073651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RyDHZHG1qM+4Ggl8UqXwMYT3dj0QzqQytYDcJf5gWcw=;
  b=ThALaafDcl8GrsVeS+hDRlwjf4jGNcYY4SslO1PAg7EGKAXvAuthWZYx
   tBknVdUdZh2U+6V+u9Bv0bAee0gNmTEGIQJRKojgkRUBzK0RUE2BugYA8
   PJYx3l0a5G+GYcMwYmCGkS0r0RYZQ6Chgj2X6oIkxFAZW3uN76cTuhR2V
   vLedWm675LeHznEI3+VE/W/artkw9Gcd2/xM1kMzBJbLvyLQ8AW8hOMTl
   vPOXwuC2zOUr0G/D0szqiQLbiCxetMZDV4QUxRzcNK3/ZjAI7Sqn2DB0G
   qvNjnt3Kr0SbHXpKPpdddsAJ2RoEdDkBHGGAjieIT7Xa7NQPG1JN5M9jG
   w==;
X-CSE-ConnectionGUID: 0Dam2R8CQuq0oCSBo3GbSA==
X-CSE-MsgGUID: PQLNKZHxSl2pmChePJU4vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="44206968"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="44206968"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 01:27:30 -0700
X-CSE-ConnectionGUID: V9r30wDxRkWwvgSwb20/Qw==
X-CSE-MsgGUID: PUr0OWqzQleZMmjieiro2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="63432409"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 01:27:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sdmsE-0000000Eeuo-1cOg;
	Tue, 13 Aug 2024 11:27:22 +0300
Date: Tue, 13 Aug 2024 11:27:22 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com,
	daniel@ffwll.ch, linux@roeck-us.net, andi.shyti@linux.intel.com,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	anshuman.gupta@intel.com, badal.nilawar@intel.com,
	riana.tauro@intel.com, ashutosh.dixit@intel.com,
	karthik.poosa@intel.com
Subject: Re: [PATCH v5] drm/i915/hwmon: expose fan speed
Message-ID: <ZrsY6tMts81T-uFa@smile.fi.intel.com>
References: <20240812081538.1457396-1-raag.jadav@intel.com>
 <ZroK4oSAte9qdnA8@smile.fi.intel.com>
 <Zrry71BfJ31q3iOi@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zrry71BfJ31q3iOi@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Aug 13, 2024 at 08:45:19AM +0300, Raag Jadav wrote:
> On Mon, Aug 12, 2024 at 04:15:14PM +0300, Andy Shevchenko wrote:
> > On Mon, Aug 12, 2024 at 01:45:38PM +0530, Raag Jadav wrote:

...

> > > +static int
> > > +hwm_fan_read(struct hwm_drvdata *ddat, u32 attr, long *val)
> > > +{
> > > +	struct i915_hwmon *hwmon = ddat->hwmon;
> > > +	struct hwm_fan_info *fi = &ddat->fi;
> > > +	u64 rotations, time_now, time;
> > > +	intel_wakeref_t wakeref;
> > > +	u32 reg_val, pulses;
> > > +	int ret = 0;
> > > +
> > > +	if (attr != hwmon_fan_input)
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	wakeref = intel_runtime_pm_get(ddat->uncore->rpm);
> > > +	mutex_lock(&hwmon->hwmon_lock);
> > > +
> > > +	reg_val = intel_uncore_read(ddat->uncore, hwmon->rg.fan_speed);
> > > +	time_now = get_jiffies_64();
> > 
> > > +	/* Handle HW register overflow */
> > > +	if (reg_val >= fi->reg_val_prev)
> > > +		pulses = reg_val - fi->reg_val_prev;
> > > +	else
> > > +		pulses = UINT_MAX - fi->reg_val_prev + reg_val;
> > 
> > Isn't it the abs_diff() reimplementation?
> 
> Not exactly. This is specific to 32 bit register overflow, so we count
> from max value.

I see. But since you have the both variables of u32, why:
1) UINT_MAX?
2) Not simply using

	pulses = reg_val - fi->reg_val_prev;

which will wrap over correctly?

Note, in your case (in comparison to the wrap over variant) the off-by-one is
present. Is it on purpose?

-- 
With Best Regards,
Andy Shevchenko



