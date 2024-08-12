Return-Path: <linux-kernel+bounces-283218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1BD94EEBE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDA8B1C203F5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5191017D8A9;
	Mon, 12 Aug 2024 13:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dd3niisA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1BE17A92F;
	Mon, 12 Aug 2024 13:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470659; cv=none; b=byZDgWPCxmlL0xo4TmBWXn7FKEJgcD5GzIwkHQFjBzkjpouPh3nnta1ex9vyeT60E/jGGnnrrkiWFHnIwJiojuVM9QSzhQqkpi63O8pWIJVsRsur4WAvH7l0rwbQXCfiOj4r4Dm2Tu+93ub0ZpgNv+mxtu8AGD4MMPtgVeBdw9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470659; c=relaxed/simple;
	bh=iZp5l59CAGjLpHSJneafAUtnEDyDDH25DA7+A9E6wP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lA8GTkbr2orpw2lJxh2ZxOh0PAPBPskzJfwYx2q4qsl5s9BF9h21i0WNTcGBEbx7W/smqX/xakyCsbUgGw9jdCUHl3LOGMmDqLXYF2wV9CdChbswk9T8nS2brl16GwxU6xWdhHisP1lJgLB26NhyiwsOSKFqrpmsIw5QUKk1UbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dd3niisA; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723470658; x=1755006658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iZp5l59CAGjLpHSJneafAUtnEDyDDH25DA7+A9E6wP8=;
  b=dd3niisAd0ekOeuqFs9WFTJdztL8Q0aesAkJZTIUY1yrQD8uglqHdMVd
   ybA/ntgOeJ9oRl7Nm7lSXiGH0YXHxjyzY40oeq6Tx5CCGmYVTXaWGXhHG
   M2FUMqgzPd3pU3dExgm+GLxSWo7Nb51HkgAIUPH+AD0hK/HaIcs6AWWx/
   Ukf6bDkyJRdSmlZXW/e0ZVFuark4KCXfXh5XMXmRIHY6Q9iaNifQHvQzv
   QJ8RuOt1QTeimDItXP7E6K+RjoKkJZshdIt4afyhzzVyIpeKkDadJJ7ML
   hOwKFIbrwO8Qw2ds3G3qj3hVZf0eQo8wq0JKRQkE3DP3iOYIPYl1cX7wY
   A==;
X-CSE-ConnectionGUID: V8fuBa87QpeSbHCULqTbIQ==
X-CSE-MsgGUID: uZ5juxveTpeOQy3n3f0yjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="24488318"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="24488318"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 06:50:57 -0700
X-CSE-ConnectionGUID: yU49dKNsSOSVTrqEuovdIg==
X-CSE-MsgGUID: C6k8NsNYRsqMqzjvAcWSuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="58212835"
Received: from slindbla-desk.ger.corp.intel.com (HELO intel.com) ([10.245.246.165])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 06:50:50 -0700
Date: Mon, 12 Aug 2024 15:50:47 +0200
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com,
	daniel@ffwll.ch, linux@roeck-us.net, andi.shyti@linux.intel.com,
	andriy.shevchenko@linux.intel.com, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, anshuman.gupta@intel.com,
	badal.nilawar@intel.com, riana.tauro@intel.com,
	ashutosh.dixit@intel.com, karthik.poosa@intel.com
Subject: Re: [PATCH v5] drm/i915/hwmon: expose fan speed
Message-ID: <ZroTN3UudwvIJ7oR@ashyti-mobl2.lan>
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

Hi Raag,

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
> +
> +	/* Handle HW register overflow */
> +	if (reg_val >= fi->reg_val_prev)
> +		pulses = reg_val - fi->reg_val_prev;
> +	else
> +		pulses = UINT_MAX - fi->reg_val_prev + reg_val;
> +
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

Can you please add a comment describing how you obtain the speed
calculation?

Basically at every read you store the values. Is it possible that
we don't have reads for a long time and the register resets more
than once?

Thanks,
Andi

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

