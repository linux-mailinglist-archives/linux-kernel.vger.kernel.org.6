Return-Path: <linux-kernel+bounces-284684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A908995040A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC3BB1C2250E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE70199239;
	Tue, 13 Aug 2024 11:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EnMLezDq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40649170A2B;
	Tue, 13 Aug 2024 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723549656; cv=none; b=S5sAFKc2k1h9pBhQ6kJnrTDwSWGoMN49ntVFBXsxs72pnwUBOWt6pB2hfKagAeRM2jPRj63v1f9ob6oq4cHYt5CwGcj8IOJ6tuBmBT48cLNws/I1fTEpjp36yzp49DF+LVRI5k8IexT/LlEV6tyAjwGCOCXzIs1TvVgYuxTtSMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723549656; c=relaxed/simple;
	bh=G3pOGZVBqXB7sYa2biEjElbdDn1qcCVetk8yRjFI7VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yi/MSFTno3VEvC1H/1hv/9a7r3tvdds/zzYAoC4CbmLd39OzfyAsREJDdsAJd5SrjIHHUjYlDld9dUvPTXr5zX9DorJHvfmhFxES3c9HPYcHnXq1pCPK49n4TuTq4Zgkzc3QsqyvDjIongkLseozvavI/t7Zkomk5IMGkbzhZ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EnMLezDq; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723549655; x=1755085655;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G3pOGZVBqXB7sYa2biEjElbdDn1qcCVetk8yRjFI7VY=;
  b=EnMLezDqBNHPWTSdYnU33I/gWqbZeP3sN7Q8m0KHQ16ku9RLPuheaWIl
   hYwRNcAuCktYwr8cWFeXP8dX4pvBkO54iawqae3d3ObTjHPeN0zyMl/+n
   IGjbd6VdOU0HbyPs2ClowqYtYzvqdxLyQnBflE2wla4gH5KcIf9KpAnAQ
   PqdfsEz63IaeENuefBdaHU0+K+XLzx8AoY2Ihy2BUxYAUs23tMpHBwJRX
   CPOuj6T77DO8O05F+ptku4Bhbkx3txC7RaVpd61MvnknU6Vqd8oVMOA7Y
   jBUb1QhQTR53E1BtOJL8iYjpquCOdcJZfMhwWkIFfobSKp1N7pJv9Ve+Y
   g==;
X-CSE-ConnectionGUID: bnvg5LeKS+6PtVjF5/P1DQ==
X-CSE-MsgGUID: xTutnZ81RxmudOgWL05MBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21523385"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="21523385"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 04:47:35 -0700
X-CSE-ConnectionGUID: VQZ2r7WpSwadk3elOT4wXg==
X-CSE-MsgGUID: EAyy5BgcTr6dvpG+kQFuLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="63038013"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 04:47:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sdpzs-0000000EiH4-0Rht;
	Tue, 13 Aug 2024 14:47:28 +0300
Date: Tue, 13 Aug 2024 14:47:27 +0300
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
Subject: Re: [PATCH v4] drm/i915/hwmon: expose fan speed
Message-ID: <ZrtHz1aY_Lf_XIsL@smile.fi.intel.com>
References: <20240809061525.1368153-1-raag.jadav@intel.com>
 <ZrYB-GI9L2RSc2bt@smile.fi.intel.com>
 <ZrtCIU8On4ZKILmh@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrtCIU8On4ZKILmh@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Aug 13, 2024 at 02:23:13PM +0300, Raag Jadav wrote:
> On Fri, Aug 09, 2024 at 02:48:08PM +0300, Andy Shevchenko wrote:
> > On Fri, Aug 09, 2024 at 11:45:25AM +0530, Raag Jadav wrote:

...

> > > +	/*
> > > +	 * HW register value is accumulated count of pulses from
> > > +	 * PWM fan with the scale of 2 pulses per rotation.
> > > +	 */
> > > +	rotations = pulses >> 1;
> > 
> > In accordance with the comment the
> > 
> > 	rotations = pulses / 2;
> > 
> > looks better.
> 
> This change seems to cause a build error in v5.
> Something to do with __udivdi3 on i386.

No, it's not this change.
Please, read report carefully.

-- 
With Best Regards,
Andy Shevchenko



