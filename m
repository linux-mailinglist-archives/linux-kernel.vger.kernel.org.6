Return-Path: <linux-kernel+bounces-278879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C0694B5F8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 06:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04163B2135B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 04:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E7012C473;
	Thu,  8 Aug 2024 04:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HVNK57JB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A6917FD;
	Thu,  8 Aug 2024 04:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723092180; cv=none; b=reP5JXobh+KRgmCxGZkk5ijM/dEAPw//Tw8pLyuH68IhkewGjxzcd7wqeiuvXAd+h8BBq3m5SO4xKScAzzxVRduY6wLa0yJIU+1mBpDaK7ux33jejgXK8Gi1ci7HMaLzLV2I8b9Z/rWgsPuTEocmgUE69+fFGiGCZs65JOSicu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723092180; c=relaxed/simple;
	bh=4syzyV6hdGjV22Hiflj6sEtCj534I2q+jdzZRjAGewU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMRrhgnX6CXe9bDjpXRm2QSsTAPYf0ifwLPgyaTHYfquZi1mnjQhV4+V6KrNBbY20TNtVkzOh1JdQ4lH6uYg54d+g0pML/BQ6F6rBW/Yzmrb1UyV5B7M/Trc6+iB2Ebyp+bdJVphZzJpV8KZFJwX/VZLbKRI7IvJOMzJjQUBUlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HVNK57JB; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723092178; x=1754628178;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4syzyV6hdGjV22Hiflj6sEtCj534I2q+jdzZRjAGewU=;
  b=HVNK57JBPlBfiL10Rpkc4qIFGthSYTsVc1llWCnzczgO3BpaEz3Hg/4X
   PY7AOZMNbXscZtWfbRde1VIv5V0mLR9alpeoGjlRbXBegxizzcqZ6ODpC
   rCJZTd+T3podJniQIb51lqHpah8m3h++ILAqdxB8x3t0jKh+cQxAmkxlA
   yBR3clQTP4d4Mk5GKtQxhQ8qtYBLj8gexgEwOPWzlxH0Z/06ueue2TIiC
   8RljDesUDYEU8KE0fiZ7ThvpaRrcKa9MRlQxO72HX27B2jJ8Qp7EPrrfw
   PuSRStb3rhCFxxZPdgnpmzFsDoXDeH37M5LIrPEwraWhqnbZJXgFN9hGj
   w==;
X-CSE-ConnectionGUID: 08Nz32qWQyS8Rml9j/0voQ==
X-CSE-MsgGUID: wmEdLxsOQwSeFoRR3sPn8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="31867206"
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="31867206"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 21:42:57 -0700
X-CSE-ConnectionGUID: KXtIwPg7SaG4OrINrtmQ+Q==
X-CSE-MsgGUID: BT2jfhRmQaSIW27BmDM3lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="61203255"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 21:42:54 -0700
Date: Thu, 8 Aug 2024 07:42:51 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: Andi Shyti <andi.shyti@linux.intel.com>
Cc: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com,
	daniel@ffwll.ch, linux@roeck-us.net,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	anshuman.gupta@intel.com, badal.nilawar@intel.com,
	riana.tauro@intel.com, ashutosh.dixit@intel.com,
	karthik.poosa@intel.com, andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH v3] drm/i915/hwmon: expose fan speed
Message-ID: <ZrRMyzUfNdjyL1y6@black.fi.intel.com>
References: <20240807123018.827506-1-raag.jadav@intel.com>
 <ZrN1i2snlz8tSA1M@ashyti-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrN1i2snlz8tSA1M@ashyti-mobl2.lan>

On Wed, Aug 07, 2024 at 02:24:27PM +0100, Andi Shyti wrote:
> Hi Raag,
> 
> > +static umode_t
> > +hwm_fan_is_visible(const struct hwm_drvdata *ddat, u32 attr)
> > +{
> > +	struct i915_hwmon *hwmon = ddat->hwmon;
> > +
> > +	switch (attr) {
> > +	case hwmon_fan_input:
> > +		return i915_mmio_reg_valid(hwmon->rg.fan_speed) ? 0444 : 0;
> > +	default:
> > +		return 0;
> > +	}
> 
> Why do we need switch case here?

Just following the file conventions.

> Why can't this function become a single "return " line?
> 
> > +}
> > +
> > +static int
> > +hwm_fan_read(struct hwm_drvdata *ddat, u32 attr, long *val)
> > +{
> > +	struct i915_hwmon *hwmon = ddat->hwmon;
> > +	struct hwm_fan_info *fi = &ddat->fi;
> > +	u32 reg_val, pulses, time, time_now;
> > +	intel_wakeref_t wakeref;
> > +	long rotations;
> > +	int ret = 0;
> > +
> > +	switch (attr) {
> > +	case hwmon_fan_input:
> > +		with_intel_runtime_pm(ddat->uncore->rpm, wakeref) {
> > +			mutex_lock(&hwmon->hwmon_lock);
> > +
> > +			reg_val = intel_uncore_read(ddat->uncore, hwmon->rg.fan_speed);
> > +			time_now = jiffies_to_msecs(jiffies);
> > +
> > +			/* Handle overflow */
> > +			if (reg_val >= fi->reg_val_prev)
> > +				pulses = reg_val - fi->reg_val_prev;
> > +			else
> > +				pulses = UINT_MAX - fi->reg_val_prev + reg_val;
> > +
> > +			/*
> > +			 * HW register value is accumulated count of pulses from
> > +			 * PWM fan with the scale of 2 pulses per rotation.
> > +			 */
> > +			rotations = pulses >> 1;
> > +			time = time_now - fi->time_prev;
> > +
> > +			if (unlikely(!time)) {
> > +				ret = -EAGAIN;
> > +				mutex_unlock(&hwmon->hwmon_lock);
> > +				break;
> > +			}
> > +
> > +			/* Convert to minutes for calculating RPM */
> > +			*val = DIV_ROUND_UP(rotations * (60 * MSEC_PER_SEC), time);
> > +
> > +			fi->reg_val_prev = reg_val;
> > +			fi->time_prev = time_now;
> > +
> > +			mutex_unlock(&hwmon->hwmon_lock);
> > +		}
> > +		return ret;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> 
> same here, can we make this function:
> 
> if (attr != hwmon_fan_input)
> 	return -EOPNOTSUPP;
> 
> and then save all the indentation.

Makes sense for hwm_fan_read(). Let me try this.

> Are we expecting more cases here?

Not for now.

Raag

