Return-Path: <linux-kernel+bounces-283142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BD194EDD5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FFCA28217A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C14217BB34;
	Mon, 12 Aug 2024 13:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XZKqyhQK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8706026ADD;
	Mon, 12 Aug 2024 13:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723468523; cv=none; b=oiGCWzUXaY5hwnyLT6c1+7Yj9G8ZZMOSTlgQe7hkia7kMOpLCelckgjs12h8dNmoW7EwifWO7jTfqGBW6UpJJ9JWK+lUl2rH0IY3jYevvTadTiubmtPy15aytEfxy7N64AkVjr7D0Z1RzweYqSnb/Ki6kzEGGhpq1vzN9tgk0t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723468523; c=relaxed/simple;
	bh=mw28CMZsCYEDai4Uy7oNYa4fhqfTA0xHHE6WVcjY/I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8jnjNZw38aw9QL3a2G0Nef1eHQqcQLLTxURu+m7wDxzHhUVuZtbIVtEk1JfXpII0hNaaq+qF81mFopHxkpnsPEAWo743fVZn+hLyCUiJ19zLmkzDb5Ao8oGwYDOpHbUqjPfUIaiffJbNRQMUfLlaBX4h2o8UxKDhktSHrV0LBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XZKqyhQK; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723468521; x=1755004521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mw28CMZsCYEDai4Uy7oNYa4fhqfTA0xHHE6WVcjY/I0=;
  b=XZKqyhQKzwQb0OGAsqb0FUER3Et5BFufCs1OxqoVmAxv8x56fPVLXla4
   h7dqd/OdV2b2O4tKwzPw1JL64+yooufPJwiSvcay/3a0JdDS8+f/s83kr
   C48PJhIO8834198GCH7/01t9FAZl2Oyj9nZxKJPk1ESbRE3Nak2AGjb/l
   4+8EAF7ifoTCnqz425IjD2R0r1akG+EfqAU9o0bUHVkZg31Zw+womXgQX
   4hgXxkSTeHP0rRadGZfjmINyoOp5DryOMLKY5yMi0a+ifCwckfBU37Ijg
   lKciImPKWhCBz+4d7YDaiffYBqA8g1UbkWkm5CPfnFJ46fLN9tyk1uVg/
   w==;
X-CSE-ConnectionGUID: ub6aXopHRse5LDeWwYPkDA==
X-CSE-MsgGUID: I20RqlJKQvOkj2etZZDSzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="12963664"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="12963664"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 06:15:20 -0700
X-CSE-ConnectionGUID: XLaW1EqfSKeEXNJ7CNVLng==
X-CSE-MsgGUID: ZxUZsq4MRcKzL5iRWLRWJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="62393301"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 06:15:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sdUtG-0000000EM1E-1ASo;
	Mon, 12 Aug 2024 16:15:14 +0300
Date: Mon, 12 Aug 2024 16:15:14 +0300
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
Message-ID: <ZroK4oSAte9qdnA8@smile.fi.intel.com>
References: <20240812081538.1457396-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812081538.1457396-1-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Aug 12, 2024 at 01:45:38PM +0530, Raag Jadav wrote:
> Add hwmon support for fan1_input attribute, which will expose fan speed
> in RPM. With this in place we can monitor fan speed using lm-sensors tool.
> 
> $ sensors
> i915-pci-0300
> Adapter: PCI adapter
> in0:         653.00 mV
> fan1:        3833 RPM
> power1:           N/A  (max =  43.00 W)
> energy1:      32.02 kJ

...

> +static int
> +hwm_fan_read(struct hwm_drvdata *ddat, u32 attr, long *val)
> +{
> +	struct i915_hwmon *hwmon = ddat->hwmon;
> +	struct hwm_fan_info *fi = &ddat->fi;
> +	u64 rotations, time_now, time;
> +	intel_wakeref_t wakeref;
> +	u32 reg_val, pulses;
> +	int ret = 0;
> +
> +	if (attr != hwmon_fan_input)
> +		return -EOPNOTSUPP;
> +
> +	wakeref = intel_runtime_pm_get(ddat->uncore->rpm);
> +	mutex_lock(&hwmon->hwmon_lock);
> +
> +	reg_val = intel_uncore_read(ddat->uncore, hwmon->rg.fan_speed);
> +	time_now = get_jiffies_64();

> +	/* Handle HW register overflow */
> +	if (reg_val >= fi->reg_val_prev)
> +		pulses = reg_val - fi->reg_val_prev;
> +	else
> +		pulses = UINT_MAX - fi->reg_val_prev + reg_val;

Isn't it the abs_diff() reimplementation?

> +	/*
> +	 * HW register value is accumulated count of pulses from
> +	 * PWM fan with the scale of 2 pulses per rotation.
> +	 */
> +	rotations = pulses / 2;
> +
> +	time = jiffies_delta_to_msecs(time_now - fi->time_prev);
> +	if (unlikely(!time)) {
> +		ret = -EAGAIN;
> +		goto exit;
> +	}
> +
> +	/*
> +	 * Convert to minutes for calculating RPM.
> +	 * RPM = number of rotations * msecs per minute / time in msecs
> +	 */
> +	*val = DIV_ROUND_UP(rotations * (MSEC_PER_SEC * 60), time);
> +
> +	fi->reg_val_prev = reg_val;
> +	fi->time_prev = time_now;
> +exit:
> +	mutex_unlock(&hwmon->hwmon_lock);
> +	intel_runtime_pm_put(ddat->uncore->rpm, wakeref);
> +	return ret;
> +}


-- 
With Best Regards,
Andy Shevchenko



