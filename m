Return-Path: <linux-kernel+bounces-277944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7C794A881
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A70322858F1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB0E1E7A46;
	Wed,  7 Aug 2024 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QSOkTQXv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D084AEE5;
	Wed,  7 Aug 2024 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723037079; cv=none; b=FAABTWzvY+gzbyaWMs3hAczpJ+ie2PC5pkv5wXFCW43omGBwpGRb+kSEOT+3VIAAe54QqULeoBVpKUM+S1i89L+0h+61NL1gGqwG0zfXZBYOUgrWyOeA33KdxCzuUQqxlHTXLTXpItE5LkNBDY9z248GJaU0orRgiaKXLyTV2iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723037079; c=relaxed/simple;
	bh=x/4yPIAf9q1wfWiVA6KbXYBEOAZjBG33Dys3A3QZTL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXVzLorKHI2oCMy/FWAU2Axtog2yhB3+x4wJDa89dGuNwQxEyN45CyQMGJARcF2Uba/G1Y9Ir+c+aaMbPL/CNRdun4PqaKDTuO/+6C2yaHy30Jy7pmQbFKO6a0vlwoH/5P0XozZU2DMS+wn/SIjCrMsq2kPD+aJ7EkNxxH4njIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QSOkTQXv; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723037078; x=1754573078;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x/4yPIAf9q1wfWiVA6KbXYBEOAZjBG33Dys3A3QZTL0=;
  b=QSOkTQXv3VlseWgPWBPU5wGRZjYO3OpxVM3Rb+xpqvH7s6ulxb2/asA5
   KsEbipUrPltnug/B5ZYFkegh5XN6ih4MqFdX3hQ7Qh5u68NCw/Hu72SYr
   DU6JD8e+PPBHDKHqbLlHFcIOopbgoOWXWnN0g0Sn+BKwFXth7pUrwMtO7
   3cbSr3tOXDXdvkJaHqKokYeD0msmL6CXgP7hO+kXzPjarQLdBtEfdKDEV
   L0iIBcFdYKLGrupiDSsr08J1D5GGQF7l/LoHGAa8C0Z4guBKjexCKZW1y
   YKV6KbYbg997GRi2zEB/BIAi3+N8rPtg/AHAHiWJWz0M8coVeXKlAvd/c
   Q==;
X-CSE-ConnectionGUID: KWk8hbMfSRWmuUy8g9WKww==
X-CSE-MsgGUID: HpDO6VB/RuOCmUv/stAW4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21225704"
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="21225704"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 06:24:37 -0700
X-CSE-ConnectionGUID: OI0ZN9nIR0WBrEAzJjhCuQ==
X-CSE-MsgGUID: aKUXzt+rR32vNNBYELVfPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="56798834"
Received: from dhhellew-desk2.ger.corp.intel.com.ger.corp.intel.com (HELO intel.com) ([10.245.245.2])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 06:24:31 -0700
Date: Wed, 7 Aug 2024 14:24:27 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com,
	daniel@ffwll.ch, linux@roeck-us.net,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	anshuman.gupta@intel.com, badal.nilawar@intel.com,
	riana.tauro@intel.com, ashutosh.dixit@intel.com,
	karthik.poosa@intel.com, andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH v3] drm/i915/hwmon: expose fan speed
Message-ID: <ZrN1i2snlz8tSA1M@ashyti-mobl2.lan>
References: <20240807123018.827506-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807123018.827506-1-raag.jadav@intel.com>

Hi Raag,

> +static umode_t
> +hwm_fan_is_visible(const struct hwm_drvdata *ddat, u32 attr)
> +{
> +	struct i915_hwmon *hwmon = ddat->hwmon;
> +
> +	switch (attr) {
> +	case hwmon_fan_input:
> +		return i915_mmio_reg_valid(hwmon->rg.fan_speed) ? 0444 : 0;
> +	default:
> +		return 0;
> +	}

Why do we need switch case here?
Why can't this function become a single "return " line?

> +}
> +
> +static int
> +hwm_fan_read(struct hwm_drvdata *ddat, u32 attr, long *val)
> +{
> +	struct i915_hwmon *hwmon = ddat->hwmon;
> +	struct hwm_fan_info *fi = &ddat->fi;
> +	u32 reg_val, pulses, time, time_now;
> +	intel_wakeref_t wakeref;
> +	long rotations;
> +	int ret = 0;
> +
> +	switch (attr) {
> +	case hwmon_fan_input:
> +		with_intel_runtime_pm(ddat->uncore->rpm, wakeref) {
> +			mutex_lock(&hwmon->hwmon_lock);
> +
> +			reg_val = intel_uncore_read(ddat->uncore, hwmon->rg.fan_speed);
> +			time_now = jiffies_to_msecs(jiffies);
> +
> +			/* Handle overflow */
> +			if (reg_val >= fi->reg_val_prev)
> +				pulses = reg_val - fi->reg_val_prev;
> +			else
> +				pulses = UINT_MAX - fi->reg_val_prev + reg_val;
> +
> +			/*
> +			 * HW register value is accumulated count of pulses from
> +			 * PWM fan with the scale of 2 pulses per rotation.
> +			 */
> +			rotations = pulses >> 1;
> +			time = time_now - fi->time_prev;
> +
> +			if (unlikely(!time)) {
> +				ret = -EAGAIN;
> +				mutex_unlock(&hwmon->hwmon_lock);
> +				break;
> +			}
> +
> +			/* Convert to minutes for calculating RPM */
> +			*val = DIV_ROUND_UP(rotations * (60 * MSEC_PER_SEC), time);
> +
> +			fi->reg_val_prev = reg_val;
> +			fi->time_prev = time_now;
> +
> +			mutex_unlock(&hwmon->hwmon_lock);
> +		}
> +		return ret;
> +	default:
> +		return -EOPNOTSUPP;
> +	}

same here, can we make this function:

if (attr != hwmon_fan_input)
	return -EOPNOTSUPP;

and then save all the indentation.

Are we expecting more cases here?

Andi

