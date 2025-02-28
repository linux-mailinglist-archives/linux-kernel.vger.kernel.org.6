Return-Path: <linux-kernel+bounces-539193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23238A4A1DC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3164817669D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737FA27CCF2;
	Fri, 28 Feb 2025 18:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A/9ZS4mn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6E227CCC3
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740768137; cv=none; b=JGMAjtwQTAzSo/p6NBcsUdYXWgZF5mrPtgbc1xlAkD+4DpM7WclzlCnIZN0bGmsQzEX8TUaD7dZ8GsNgy6V4uJ8lXzEyWzvyibdcpkRR9hcKLBUjeq9m5sOvyHTAfv2k8aCNL0uDY+QqDqsIdsHG+Tv71YrxsfwQ50Dv5kI0+W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740768137; c=relaxed/simple;
	bh=FFhMlv9xcgDCpW0iUrfDsNOA+dAnIUA8kxg7pEuGjyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MydIyycRI1OsS/JGDL5mG67N6YRL8Amj5icCiCjhKgRFLCofowMsCGatvH3zkIdwbtX6aey5u8Qgq67tm5KRodwYo/MOz7GdCwpkTlJU8q4/2SvhyP+a7UjRBHkuy8qjkL4hCSRShubY7QdvTimbAiVFsnqlsQ+kUiVZ4RsAAVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A/9ZS4mn; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740768136; x=1772304136;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FFhMlv9xcgDCpW0iUrfDsNOA+dAnIUA8kxg7pEuGjyU=;
  b=A/9ZS4mnOho5Bocg6Ta7T0aLPLx+3LOiyWKbeO/rNEc7pgZBg2t3ZNwr
   48njzf3Y7NiIN1f/7jjiOM6QjaUB3x/nB8CB9FS2kkeiGLKDBAHbbEy92
   wFt5m8HsXs4Bgn5gjsIvpOO4WBrGFE/3/xHT6R6PfNY/txJLkO+CPsrzF
   jH/pz30qC8Kmj8E8RPA4VVudp53zfoVvilQRKLT7E0tJqAumT4xPpRBts
   15PjEc6QT0Jb0dWWV5e70jXxZYNmBHgbcwvTKAo3CR6bZeLaf/2mdoKJA
   6wNkPltPzxH+X9VPUbxzAbL8VrIub6uFf2VYoi8lN/FVpAeHFAbI52XbL
   g==;
X-CSE-ConnectionGUID: RWLK7c5ZQ76ePXvgfncWDQ==
X-CSE-MsgGUID: PZlVRStNQUqtEFmwRaFD1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="53117875"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="53117875"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 10:42:15 -0800
X-CSE-ConnectionGUID: Cum14mOhQmWX2ZaCL5RFFw==
X-CSE-MsgGUID: N4LF4d+aTeKvq4XD20VfLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="122547909"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 10:42:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1to5JL-0000000G3bz-0EhE;
	Fri, 28 Feb 2025 20:42:11 +0200
Date: Fri, 28 Feb 2025 20:42:10 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Cleanup io.h
Message-ID: <Z8IDgmrLx5DQADxJ@smile.fi.intel.com>
References: <20250227070747.3105451-1-raag.jadav@intel.com>
 <Z8CD33_OWK2LB6IZ@smile.fi.intel.com>
 <0011035a-5816-48c4-9fe4-c0b9db3c8e72@app.fastmail.com>
 <Z8H1Y2_RlFnXeNEa@black.fi.intel.com>
 <Z8IDXD2bkO1t71yB@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8IDXD2bkO1t71yB@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 28, 2025 at 08:41:33PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 28, 2025 at 07:41:55PM +0200, Raag Jadav wrote:
> > On Fri, Feb 28, 2025 at 06:11:16PM +0100, Arnd Bergmann wrote:
> > > On Thu, Feb 27, 2025, at 16:25, Andy Shevchenko wrote:
> > > > On Thu, Feb 27, 2025 at 12:37:45PM +0530, Raag Jadav wrote:
> > > >> This series attempts to cleanup io.h with "include what you use" approach.
> > > >> This depends on changes available on immutable tag[1].
> > > >> 
> > > >> Although this series is too trivial in the grand scheme of things, it is
> > > >> still a tiny step towards untangling core headers. I have success results
> > > >> from LKP for this series but there can still be corner cases. So perhaps
> > > >> we can queue this on a temporary branch which we can use to submit fixes
> > > >> in case of fallout.
> > > >> 
> > > >> Future plan is to use the excellent analysis[2][3] by Arnd to cleanup other
> > > >> headers.
> > > >> 
> > > >> [1] https://lore.kernel.org/r/Z7xGpz3Q4Zj6YHx7@black.fi.intel.com
> > > >> [2] https://lore.kernel.org/r/2342b516-2c6e-42e5-b4f4-579b280823ba@app.fastmail.com
> > > >> [3] https://lore.kernel.org/r/f6eb011b-40fb-409a-b2b2-a09d0e770bbd@app.fastmail.com
> > > >
> > > > I believe Arnd can take it through his tree for headers as DRM part is 
> > > > Acked already.
> > > 
> > > I've applied it yesterday and not seen any regression reports so far.
> > 
> > Probably because the immutable tag is already in -next?
> 
> Is there any?

Ah, you mean devres related?

-- 
With Best Regards,
Andy Shevchenko



