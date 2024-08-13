Return-Path: <linux-kernel+bounces-284135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB33394FD64
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67FA22830FF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 05:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06492D611;
	Tue, 13 Aug 2024 05:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IBBBzPNm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BF71C69D;
	Tue, 13 Aug 2024 05:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723527930; cv=none; b=QytTfzKBkje/BurFaNsIU1UmIIsJZl96VwZR5kacYOFUL2y57DOmoia7IekzyVsD1xSmLItRcJon4h1bQ4kDtEpR+CLRcBHyF7Odv3Ps+Be0Jq3GqL3C8ctx6zIOrAdoeeCtNl3rxlT4jeTu/lV/cTeSkLP7LPPmfOxWWEPDqdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723527930; c=relaxed/simple;
	bh=YwpuBVSFNyDvfJmlX29Z5q0LHVN5p+qw1by/SJOWLDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHkGnZl+pMZBvDonPWhx3ydB4rCeBJ2AzhlL9vGvGxNyXqSGXSJ5zgBUhfuKBxOUS95Xo0EzasPQ4zlT4nRx2E9cAaRRCOj8VYdICDIsrF2mUmCFbQuMSa2uMBpZKkdyaLXobTT9jvPhpANs7PntXWHC5d2GyDGk+XizCO5bCqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IBBBzPNm; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723527928; x=1755063928;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YwpuBVSFNyDvfJmlX29Z5q0LHVN5p+qw1by/SJOWLDk=;
  b=IBBBzPNmfKJfeSmquIWfuEhWAp9gNHVBpGccp2ZbodAyR05Z7wSXgLt+
   9j8QwioHk6/TDOPIy6+k8SgO8nnXtHk1rP1AkHM3wG8gLK+gQWXW2iwwN
   sBsXCIyLpSukoHI5u6Qjb46xiA1QYfk4h22XGRj5fx2K6jmBdmXO1fGv0
   pAdNjrXmYbf9zysnDG9juPUFTOl3VYCWsGxkhRJmDUaxGblwR+bmpxYdX
   fa+kd9OG64w/PBdkAWUx6ZIGjUrHPQYPJ7+Vk54VAgNZfyZq2UHQrA8fh
   Gw5WuglU9zgrtmAiXqf66dTM3LIDizS5eLXC3sP9bJ/DalKqK54ocwDVI
   Q==;
X-CSE-ConnectionGUID: 8Lc98bAUR1S4xQWMhwNK2A==
X-CSE-MsgGUID: 0KQF8qQjS9yJxOCI6BOVlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21538930"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="21538930"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 22:45:27 -0700
X-CSE-ConnectionGUID: c9dFyZmbSLqazA9E/vH8Og==
X-CSE-MsgGUID: oXlUV/1dR6SazqjesTO58g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="81776598"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 22:45:22 -0700
Date: Tue, 13 Aug 2024 08:45:19 +0300
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
Message-ID: <Zrry71BfJ31q3iOi@black.fi.intel.com>
References: <20240812081538.1457396-1-raag.jadav@intel.com>
 <ZroK4oSAte9qdnA8@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZroK4oSAte9qdnA8@smile.fi.intel.com>

On Mon, Aug 12, 2024 at 04:15:14PM +0300, Andy Shevchenko wrote:
> On Mon, Aug 12, 2024 at 01:45:38PM +0530, Raag Jadav wrote:
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
> ...
> 
> > +static int
> > +hwm_fan_read(struct hwm_drvdata *ddat, u32 attr, long *val)
> > +{
> > +	struct i915_hwmon *hwmon = ddat->hwmon;
> > +	struct hwm_fan_info *fi = &ddat->fi;
> > +	u64 rotations, time_now, time;
> > +	intel_wakeref_t wakeref;
> > +	u32 reg_val, pulses;
> > +	int ret = 0;
> > +
> > +	if (attr != hwmon_fan_input)
> > +		return -EOPNOTSUPP;
> > +
> > +	wakeref = intel_runtime_pm_get(ddat->uncore->rpm);
> > +	mutex_lock(&hwmon->hwmon_lock);
> > +
> > +	reg_val = intel_uncore_read(ddat->uncore, hwmon->rg.fan_speed);
> > +	time_now = get_jiffies_64();
> 
> > +	/* Handle HW register overflow */
> > +	if (reg_val >= fi->reg_val_prev)
> > +		pulses = reg_val - fi->reg_val_prev;
> > +	else
> > +		pulses = UINT_MAX - fi->reg_val_prev + reg_val;
> 
> Isn't it the abs_diff() reimplementation?

Not exactly. This is specific to 32 bit register overflow, so we count
from max value.

Raag

