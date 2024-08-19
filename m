Return-Path: <linux-kernel+bounces-291552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B93C956401
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F11B1C2032A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 06:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BC615820E;
	Mon, 19 Aug 2024 06:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q0gKTbfM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178A6155A59;
	Mon, 19 Aug 2024 06:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724050238; cv=none; b=tbjD58ERnuthhjzG9QI3ywVZGT96DPV1ZacZ8dYyTGW16LA3KaQbxdgtreZu6aakANs9EYGtJBoe5q/aglqCR0iy4KBG/GBzPER/x3WGKjhJrkSVb139Ce9F8iIFeYHPmgyYBDwxQxikcyw4Y9FGXWe1e1ZdDgOxJ1rvCok2wvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724050238; c=relaxed/simple;
	bh=oj3Y9pH17xNfiWjKVNwaUDErHrAbG48YkAEs7w5hNqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvMmW29g580hSlQWSbAX840rsBHEr0k7LNxZeK9eYIWZmbichC8/jQQAqLmYPX9cvyJyDwP3i/mYgrM2MbmaaY/AvT3T96DqM6c7gB0BRi2dLusDIUCQntbcRArbsR6lS5aaejcFILmaEL5RCOwyCmpOPPivS2cDC+hZpWyfxQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q0gKTbfM; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724050237; x=1755586237;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=oj3Y9pH17xNfiWjKVNwaUDErHrAbG48YkAEs7w5hNqE=;
  b=Q0gKTbfMHIrgX8xP21QbFInsKNiBGs446G/Bhe6Rx0NnQ/Wp+bbGYhlV
   RCX4W6MuNE2qEKIONKyD078PAEcDUzmShpnRTbNw2VCL2byFgCC3i0KMc
   XJ32BpD19Yx1FdaLduvv3HKZzRHkL5lUcHh1czgSnMaY6kF7MfBG2Nzwn
   2nN42ogeD+HzV2epsc1V7W6OdYRd9tEgwngD+09JQrQeMYpno4+/d8omr
   eSPTde5Ma0fRD13Q7spSRYRMNAX+ZBYOqoAvP8M4oHA2ykSqHLNbMzh/s
   HKCeE10JCVth3Av25Vk2hdVQWDAc0X2ZxpNeR9BFnnWX7fmTR95Kq6Zf3
   w==;
X-CSE-ConnectionGUID: wy4VHY29SD6qcsPhY3faGg==
X-CSE-MsgGUID: KTUA/9/pSa2nXbNHI6Yujg==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="26149679"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="26149679"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 23:50:34 -0700
X-CSE-ConnectionGUID: 0atrH+wPTZeHjmFXJYOQxQ==
X-CSE-MsgGUID: mC6FAfWsTryxmG5IwJ3sBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="91020759"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 23:50:16 -0700
Date: Mon, 19 Aug 2024 09:50:13 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: "Nilawar, Badal" <badal.nilawar@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>
Cc: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com,
	daniel@ffwll.ch, linux@roeck-us.net,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	anshuman.gupta@intel.com, riana.tauro@intel.com,
	ashutosh.dixit@intel.com, karthik.poosa@intel.com,
	andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH v4] drm/i915/hwmon: expose fan speed
Message-ID: <ZsLrJVdBmfZhZaaR@black.fi.intel.com>
References: <20240809061525.1368153-1-raag.jadav@intel.com>
 <23dc7824-50cd-4ba3-be5a-df141e8fe69a@intel.com>
 <ZrXslA1c-BhO6zYr@ashyti-mobl2.lan>
 <88320f60-d55b-4aa5-881f-530375659c27@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88320f60-d55b-4aa5-881f-530375659c27@intel.com>

On Wed, Aug 14, 2024 at 02:07:44PM +0530, Nilawar, Badal wrote:
> 
> Hi Andi,
> 
> On 09-08-2024 15:46, Andi Shyti wrote:
> > Hi Badal,
> > 
> > > > +static int
> > > > +hwm_fan_read(struct hwm_drvdata *ddat, u32 attr, long *val)
> > > > +{
> > > > +	struct i915_hwmon *hwmon = ddat->hwmon;
> > > > +	struct hwm_fan_info *fi = &ddat->fi;
> > > > +	u32 reg_val, pulses, time, time_now;
> > > > +	intel_wakeref_t wakeref;
> > > > +	long rotations;
> > > > +	int ret = 0;
> > > > +
> > > > +	if (attr != hwmon_fan_input)
> > > > +		return -EOPNOTSUPP;
> > > Using a switch case in rev3 is more logical here. It will also simplify
> > > adding more fan attributes in the future. This is why switch cases are used
> > > in other parts of the file.
> > 
> > it was my suggestion and to be honest I would rather prefer it
> > this way. I can understand it if we were expecting more cases in
> > the immediate, like it was in your case.
> > 
> > But I wouldn't have an ugly and unreadable one-case-switch in the
> > eventuality that something comes in the future. In that case, we
> > can always convert it.
> 
> My rationale for suggesting a switch case is that in the current alignment
> hwm_XX_read() function is designed to handle all possible/supported
> attributes of the XX sensor type.
> With the proposed change, hwm_fan_read() would only manage the
> hwmon_fan_input attribute.
> If a single switch case isn’t preferred, I would recommend creating a helper
> function dedicated to hwmon_fan_input.
> 
> hwm_fan_read()
> {
> 	if (attr == hwmon_fan_input)
> 		return helper(); //hwmon_fan_input_read()
> 	return -EOPNOTSUPP;
> }

Hi Andi,

If you agree with this, please let me know.
Will send out a v6 accordingly.

Raag

