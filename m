Return-Path: <linux-kernel+bounces-284526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1CC9501ED
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76939284B84
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6FC1946C1;
	Tue, 13 Aug 2024 10:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B9QwbK0V"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496AC18991F;
	Tue, 13 Aug 2024 10:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723543392; cv=none; b=ZcPABZOyWnIDQcGITulTb+wS9gdxglgeYcEDJwwivnvjM3yzYT1JvCqGO/pP+H22eUlyPP34/VIvJXYsCZ6VuwDYQgfuncCjHJ3I5SNuOUh5RVk9H4Nhaiznd2vn2VE+gmAYtr1F/tHbVUheUJbY/U+6Vyic10yVbSP7mshn+9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723543392; c=relaxed/simple;
	bh=uAMAIU2rNUtIJG4IQj+VwcR3lSGm3E5jiddPfvFc3lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQL2bDlfIHapOHVp6P/j3KZ1BkUnjksfKwQx9DW5Rpo0Zr4tZwGCIZ4m9f1FH59D246WStFae78ycVn834hfw6CU8xlgA9nUoMEqECa3Lq2D4RW7/AcuvcPT5HLJj2oglPstSaJcffijYq7B+ul+eGRqCWmedOwC9i/kyctxR9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B9QwbK0V; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723543390; x=1755079390;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uAMAIU2rNUtIJG4IQj+VwcR3lSGm3E5jiddPfvFc3lg=;
  b=B9QwbK0Vo8H7ah53w8OQshTXjTweVxqVgxO0WyzBRIrJxgRt3eN2hZOm
   VSb1wfIW8Z68KsJaDwkEQNgtm0gi+E6KHUCAsm6n10MIblvKZ+rBgFGfn
   qK4V5dedCfzBJo7X22oNbcj4KYe5eE74d0nykpCDJ9cEG37zNrpoiPtCo
   e5jjnh/2/MmmJ/LGmoez87rJ7jhxt3icXPe0RzmwEG0MTfs1906dH9pAi
   52lJrt3xBI5I0U9A9l1MPlYTifnF+3IgMXJkdHpTjcoJjQlC1pkWXrBiW
   VY78I+k1cRFrZcmcZfkt/MON8RH3/sPExlvVLJTeCeQG83aP5KSIw1EkI
   Q==;
X-CSE-ConnectionGUID: 9908qKQWS4qn71Cq/gE2Wg==
X-CSE-MsgGUID: P6A2v1XGTwir30Zb8FTtPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="32268460"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="32268460"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 03:03:10 -0700
X-CSE-ConnectionGUID: iurrRxMEQbK0kZEmRhUkJA==
X-CSE-MsgGUID: uNIHJ3wGS22d1YRrHibNDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="59184596"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 03:03:06 -0700
Date: Tue, 13 Aug 2024 13:03:01 +0300
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
Subject: Re: [PATCH v5] drm/i915/hwmon: expose fan speed
Message-ID: <ZrsvVSu8rdNYfsSo@black.fi.intel.com>
References: <20240812081538.1457396-1-raag.jadav@intel.com>
 <ZroK4oSAte9qdnA8@smile.fi.intel.com>
 <Zrry71BfJ31q3iOi@black.fi.intel.com>
 <ZrsY6tMts81T-uFa@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrsY6tMts81T-uFa@smile.fi.intel.com>

On Tue, Aug 13, 2024 at 11:27:22AM +0300, Andy Shevchenko wrote:
> On Tue, Aug 13, 2024 at 08:45:19AM +0300, Raag Jadav wrote:
> > On Mon, Aug 12, 2024 at 04:15:14PM +0300, Andy Shevchenko wrote:
> > > On Mon, Aug 12, 2024 at 01:45:38PM +0530, Raag Jadav wrote:
> 
> ...
> 
> > > > +static int
> > > > +hwm_fan_read(struct hwm_drvdata *ddat, u32 attr, long *val)
> > > > +{
> > > > +	struct i915_hwmon *hwmon = ddat->hwmon;
> > > > +	struct hwm_fan_info *fi = &ddat->fi;
> > > > +	u64 rotations, time_now, time;
> > > > +	intel_wakeref_t wakeref;
> > > > +	u32 reg_val, pulses;
> > > > +	int ret = 0;
> > > > +
> > > > +	if (attr != hwmon_fan_input)
> > > > +		return -EOPNOTSUPP;
> > > > +
> > > > +	wakeref = intel_runtime_pm_get(ddat->uncore->rpm);
> > > > +	mutex_lock(&hwmon->hwmon_lock);
> > > > +
> > > > +	reg_val = intel_uncore_read(ddat->uncore, hwmon->rg.fan_speed);
> > > > +	time_now = get_jiffies_64();
> > > 
> > > > +	/* Handle HW register overflow */
> > > > +	if (reg_val >= fi->reg_val_prev)
> > > > +		pulses = reg_val - fi->reg_val_prev;
> > > > +	else
> > > > +		pulses = UINT_MAX - fi->reg_val_prev + reg_val;
> > > 
> > > Isn't it the abs_diff() reimplementation?
> > 
> > Not exactly. This is specific to 32 bit register overflow, so we count
> > from max value.
> 
> I see. But since you have the both variables of u32, why:
> 1) UINT_MAX?
> 2) Not simply using
> 
> 	pulses = reg_val - fi->reg_val_prev;
> 
> which will wrap over correctly?

Agree. Will update.

Raag

