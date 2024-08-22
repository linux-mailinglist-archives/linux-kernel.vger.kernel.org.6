Return-Path: <linux-kernel+bounces-297357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DFA95B6A1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D01041F2503E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 13:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4881CBE93;
	Thu, 22 Aug 2024 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cLBCrCII"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4513D1CB158;
	Thu, 22 Aug 2024 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724333311; cv=none; b=eaEpt/xDyeE1i6sLFUT4A/LtgB0bXKH+PGjrOQ7XymMTSSbJowlm/QopRfuKDStEyeZxLKsAGYcqK4r45w9dppX2GS7gtvuNMbEZXejxLon0FjNeYbjr5zgi6Elexfh8acmI8zuwa9jdlZ4mGECE+IdV76tagnnacOSwDcgc0BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724333311; c=relaxed/simple;
	bh=9N41foLL/2Pxt3ECs2i8yc04fwv+tCy+a3YYGiA2Rlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNRYiNOaXGrm4VV4x3NG6oV5VVSn3DW+X+imgj1pKlNNfY5rtcCenf241WyuY+6J7yEbsNx8aBnTD83IBUDpOno9KmLTQuDXpZQjSMS6l6s/fS1ngWyrpb5Hl/V1Jlw4pbBHtbWuzuKs4vCTFg3AZ9qw5SqHX3NwtXoZk7lFTxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cLBCrCII; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724333310; x=1755869310;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9N41foLL/2Pxt3ECs2i8yc04fwv+tCy+a3YYGiA2Rlk=;
  b=cLBCrCIIR8D/Wxec1HA22z56hZvNnmy/0CQwrEVs7vdls9Y4RPmlTbXV
   UGoBw7RP+dM8B/H03XlXDVgITQuGms/BGQ66uGDCX/g59BhBq0p+6YMTp
   +e7uNzeeE+dQe9Y1mkyn1kczkSKcBzT6hc8OS5UD+wW2bSzc8hGeCLm92
   t8+sjfbiSVQSGG6UgYCLSi9YxQ+ZPgG59ADi/kcZagrJWkygaqxLWqwXW
   +5nt1xK/tmYd84SaFvYpy+CfY+D9kCAXufOc1976cVkcbvFxsVzwgHzdI
   qVHvApizENEKEoy+wVPnj50mRJLDztfwANDX0ckGUfuS95yrBbhB1qQmV
   Q==;
X-CSE-ConnectionGUID: G2H12dyjTzaOKNuscKK1vg==
X-CSE-MsgGUID: wSTUvatAQraDrno/gX9jJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="22614778"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="22614778"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 06:28:29 -0700
X-CSE-ConnectionGUID: DuVE3U6PRY6uJ/HMWnMkcw==
X-CSE-MsgGUID: GGD5zlrgRBqouPAqROU2Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="61596851"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 06:28:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sh7rQ-00000000Snz-2X7J;
	Thu, 22 Aug 2024 16:28:20 +0300
Date: Thu, 22 Aug 2024 16:28:06 +0300
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
Message-ID: <Zsc85iQIBpOPJOKp@smile.fi.intel.com>
References: <20240820062010.2000873-1-raag.jadav@intel.com>
 <ZsRup8uKiqUvADFl@smile.fi.intel.com>
 <ZsSWTtew8nCYWrxF@black.fi.intel.com>
 <ZsSi73YyfKletmgk@smile.fi.intel.com>
 <ZsbophGauSzh15lz@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsbophGauSzh15lz@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Aug 22, 2024 at 10:28:38AM +0300, Raag Jadav wrote:
> On Tue, Aug 20, 2024 at 05:06:39PM +0300, Andy Shevchenko wrote:
> > On Tue, Aug 20, 2024 at 04:12:46PM +0300, Raag Jadav wrote:
> > > On Tue, Aug 20, 2024 at 01:23:35PM +0300, Andy Shevchenko wrote:
> > > > On Tue, Aug 20, 2024 at 11:50:10AM +0530, Raag Jadav wrote:
> > > > 
> > > > But it still has an issue with 64-bit division on 32-bit platforms, right?
> > > > 
> > > > > +	/*
> > > > > +	 * Calculate fan speed in RPM by time averaging two subsequent
> > > > > +	 * readings in minutes.
> > > > > +	 * RPM = number of rotations * msecs per minute / time in msecs
> > > > > +	 */
> > > > > +	*val = DIV_ROUND_UP(rotations * (MSEC_PER_SEC * 60), time);
> > > > 
> > > > ...somewhere here?
> > > 
> > > Use div64_u64() instead? Or is there a better alternative?
> > 
> > I don't know the code well to offer anything better. Probably for a starter
> > you can switch to use DIV_ROUND_UP_ULL().
> 
> This one seems to work. Does it warrant an explanation here?

You mean _ULL part? No.

-- 
With Best Regards,
Andy Shevchenko



