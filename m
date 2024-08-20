Return-Path: <linux-kernel+bounces-294072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2634595888F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5839D1C20E29
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6026B1917E3;
	Tue, 20 Aug 2024 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YJAbToZe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F8E190486;
	Tue, 20 Aug 2024 14:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162809; cv=none; b=Wyuo7tmx6PqaZj606/hq/eKCYxA9zibJZjq0+/7unmeeqn4rdtXr6m4Bz0+blpfJrU83oEHx5O5wSgmSX+FA8GOI4RZZ5xShtXLtEg6FuElt+tRW+q2pvWJRJVCGCO3ljJDWx7Q8qGO2HBh4DsfcEmBzyCx0pSz6pJGrSd/CfdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162809; c=relaxed/simple;
	bh=MrJaVukCblbAF5beCEIvjekC35gWWd06PuqyDAECCUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdIzfwKH1RSWH1zGcvBvtTaEV5o+p9aDVXYd05V8Z4p6tgnC9IDfF4VLee/P33uSwTKVqK83NLv9ULt/Py49ws/wQPYLgAB6VnID7W9IyRtRIvfIDzt0nuBpNfbRN+zZ/0I0FRnwPDUTuCm3AyzVtl5OCsLAH4xkFKD+ighfsGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YJAbToZe; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724162808; x=1755698808;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MrJaVukCblbAF5beCEIvjekC35gWWd06PuqyDAECCUg=;
  b=YJAbToZeQOxGr5AWIF5Ht+I8HyBM/z4/JMlE6gzof7R+LrLJcDiAlmB/
   GJRLirOa3awiUS5PKusrUmVT9j+32sC0b7g0sUpZ4PM7FpYuznoO2E1WQ
   hWdd6UuD9hzDqxPjit6Wlek3M7B4WBQZICfYNKD0e0QaTd2shhCgCOUog
   OzW22mCBfBrp+F+Eyd/Y3SqHspWM6k4l5KSWZDa751GJTzXAaJh5o/h2v
   qRp+iT5LfwdVPY2FLyj3IZQlK0lq7O1aSTXGZVSxlhScvNn00r8mMq+Wc
   Voug3zgTCrzoPZDQxoHzEwja4tKfG07WvpAAZfSWhoPRQ76+aW53xrBfF
   A==;
X-CSE-ConnectionGUID: e4fnKxOXQtWXDGtKfxe3VQ==
X-CSE-MsgGUID: NuB769LIRGCU1ISmzh/fgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="22271125"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="22271125"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 07:06:48 -0700
X-CSE-ConnectionGUID: J7DTI9/XSIq/QAtQsPVswQ==
X-CSE-MsgGUID: 0ny/ekFmTUmrK9wF7VudZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="65610152"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 07:06:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sgPVQ-0000000HKD3-0nFm;
	Tue, 20 Aug 2024 17:06:40 +0300
Date: Tue, 20 Aug 2024 17:06:39 +0300
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
Subject: Re: [PATCH v6] drm/i915/hwmon: expose fan speed
Message-ID: <ZsSi73YyfKletmgk@smile.fi.intel.com>
References: <20240820062010.2000873-1-raag.jadav@intel.com>
 <ZsRup8uKiqUvADFl@smile.fi.intel.com>
 <ZsSWTtew8nCYWrxF@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsSWTtew8nCYWrxF@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Aug 20, 2024 at 04:12:46PM +0300, Raag Jadav wrote:
> On Tue, Aug 20, 2024 at 01:23:35PM +0300, Andy Shevchenko wrote:
> > On Tue, Aug 20, 2024 at 11:50:10AM +0530, Raag Jadav wrote:

...

> > > v6: Drop overflow logic (Andy)
> > >     Aesthetic adjustments (Badal)
> > 
> > But it still has an issue with 64-bit division on 32-bit platforms, right?

...

> > > +	/*
> > > +	 * Calculate fan speed in RPM by time averaging two subsequent
> > > +	 * readings in minutes.
> > > +	 * RPM = number of rotations * msecs per minute / time in msecs
> > > +	 */
> > > +	*val = DIV_ROUND_UP(rotations * (MSEC_PER_SEC * 60), time);
> > 
> > ...somewhere here?
> 
> Use div64_u64() instead? Or is there a better alternative?

I don't know the code well to offer anything better. Probably for a starter
you can switch to use DIV_ROUND_UP_ULL().

-- 
With Best Regards,
Andy Shevchenko



