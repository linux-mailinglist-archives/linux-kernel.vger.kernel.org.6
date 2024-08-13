Return-Path: <linux-kernel+bounces-284170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2098994FDD8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B819E1F21D0A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984583A8D8;
	Tue, 13 Aug 2024 06:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eQ/UimrU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D352A38;
	Tue, 13 Aug 2024 06:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723530634; cv=none; b=cZVOrUPtnMJyVRC2iHI5tpU2VLoLIfmTOwhW2jRHShzPnBYmGPuNEvyxWfKy1dGVvkcZpzUaKxY3vtIFNYGv/rzM14TWOYPbM2a6JEpRgMcRqO5elt5SBqSRM0/d/hue81nZP2iLx5oa4d+gHimEZby6gZQV6Fhuut44qRUT5wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723530634; c=relaxed/simple;
	bh=DmKnLXUCM72x1dzkF1cuvWtBK8szozZg09Qg4VMff0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YE17TJBCA0gwLU9LKvW4CpRP+SfOscQjDwplrrCD5OfmC5j27lgsp7FdBlo2uva8FKZE82wnBs7GeU0SvfrRjBAPfmzB/DtzRyZnapLoAlQTywp321S4qFsmK0G/tQw90SO7RxkuY1fmi1KNj0UvQFnP2dojV0AxUI1VY/crhEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eQ/UimrU; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723530633; x=1755066633;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DmKnLXUCM72x1dzkF1cuvWtBK8szozZg09Qg4VMff0U=;
  b=eQ/UimrUwtpXzLBw+o80gBeAcCe2d56nXF2MiDd9ouYnkvLlDf/twt5j
   0VVSwW+eDq9XqmzPL80zcVYmhb/5Y59Scrr20MEvwIqQ+Xmn18QrRCCgN
   sJjp32lgwVHKILROenNo1Js+ZTHQYW99z48dqVRYgY5P9t+2anOYw3rdn
   v0i2EankwGHjGGUntZZPqczUrao1VTUrT+EV63G5y2rGo2x6QkLuG2ZJn
   uXOjW9sYHNt8rpK4A1gvQmqeQeQyHaaszdxL9clxYVMOA6QK3ESrRIoSF
   pOXiWTOTp6Fh/D89WWlu50//iW9lC7Rr6cojg5op6LD2E8JbzoEw1xF3G
   g==;
X-CSE-ConnectionGUID: MWZEFqH2SXi9JeIQ1PKMdw==
X-CSE-MsgGUID: jTZNG0kcTHqf3M+xQ/BAzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="32819302"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="32819302"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 23:30:30 -0700
X-CSE-ConnectionGUID: OK0xb/X4QSK98fK2qnVG0A==
X-CSE-MsgGUID: yIz5n0FASNiiwTlY+NexCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="58632017"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 23:30:25 -0700
Date: Tue, 13 Aug 2024 09:30:22 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: Andi Shyti <andi.shyti@linux.intel.com>
Cc: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com,
	daniel@ffwll.ch, linux@roeck-us.net,
	andriy.shevchenko@linux.intel.com, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, anshuman.gupta@intel.com,
	badal.nilawar@intel.com, riana.tauro@intel.com,
	ashutosh.dixit@intel.com, karthik.poosa@intel.com
Subject: Re: [PATCH v5] drm/i915/hwmon: expose fan speed
Message-ID: <Zrr9fobk-zahLpIO@black.fi.intel.com>
References: <20240812081538.1457396-1-raag.jadav@intel.com>
 <ZroTN3UudwvIJ7oR@ashyti-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZroTN3UudwvIJ7oR@ashyti-mobl2.lan>

On Mon, Aug 12, 2024 at 03:50:47PM +0200, Andi Shyti wrote:
> Hi Raag,
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
> > +
> > +	/* Handle HW register overflow */
> > +	if (reg_val >= fi->reg_val_prev)
> > +		pulses = reg_val - fi->reg_val_prev;
> > +	else
> > +		pulses = UINT_MAX - fi->reg_val_prev + reg_val;
> > +
> > +	/*
> > +	 * HW register value is accumulated count of pulses from
> > +	 * PWM fan with the scale of 2 pulses per rotation.
> > +	 */
> > +	rotations = pulses / 2;
> > +
> > +	time = jiffies_delta_to_msecs(time_now - fi->time_prev);
> > +	if (unlikely(!time)) {
> > +		ret = -EAGAIN;
> > +		goto exit;
> > +	}
> 
> Can you please add a comment describing how you obtain the speed
> calculation?

That's what I initially tried but ended up dropping it in favour of RPM
formula below, which I found to be doing a better job of explaining than
a few lines of description.

> Basically at every read you store the values. Is it possible that
> we don't have reads for a long time and the register resets more
> than once?

Considering a fan continuously running at higher speeds (for example 4000 RPM
which is quite optimistic), with the scale of 2 pulses per rotation, a 32 bit
register will take around a year to overflow, which is more than most usecases
I could think of.

Raag

> > +	/*
> > +	 * Convert to minutes for calculating RPM.
> > +	 * RPM = number of rotations * msecs per minute / time in msecs
> > +	 */
> > +	*val = DIV_ROUND_UP(rotations * (MSEC_PER_SEC * 60), time);
> > +
> > +	fi->reg_val_prev = reg_val;
> > +	fi->time_prev = time_now;
> > +exit:
> > +	mutex_unlock(&hwmon->hwmon_lock);
> > +	intel_runtime_pm_put(ddat->uncore->rpm, wakeref);
> > +	return ret;
> > +}

