Return-Path: <linux-kernel+bounces-284406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5572950090
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A168D28228A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483CD17A584;
	Tue, 13 Aug 2024 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a5H6mRCy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3328B16DEA9
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723539523; cv=none; b=L4B0ox68aY0+QIreGC+bhdexOoJKnaS6uSkr0HU01z1jMYxgVKGo5fLSo+VZ9g2XYJRxtEIWMB6OmOkGktbcNB1Upps3jkst+9UET1yfGI7tI3sjMAVRWRObpLb//VjQ+MG1iP6z0vnxGe40eQBod9Z2/H/tdm+zeYycdelaxRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723539523; c=relaxed/simple;
	bh=xhW5B081ZHwaTydzE8ITH5iE0gMJFJtC0dKffU7RnQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efWkp9Z5bztCtooVRYvTA/WEAKM4nmQI8Q67i9HB03qOK3q2G4MLYVu+y7juSWJHNZpDq6PXGaxZ7MN/ZuW47/a9n8QIosvET3T0S+Q6AuLiG+TCOML49d1GzuHoZPMgR3yJNg9ysH/xwQ/JhEHW4cjHTzQfuv0jwdqFLZokNls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a5H6mRCy; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723539522; x=1755075522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xhW5B081ZHwaTydzE8ITH5iE0gMJFJtC0dKffU7RnQU=;
  b=a5H6mRCy/7QUv40GuLfQbSf17NBYxV3osm4bEr2I9YJ/iC6rRKeDzsZd
   LemnDGdDJBRCNnturp3z48So0G0QwITbhd91ns+eMvVIBVLRLLepL8Evj
   C3RoTxjh5/odNKJVOhhOqAGUHwAQwrJL/6Nc9156mqHOL1IBuqbQj5nRp
   3BhaGL+Pcx04Umw6Hm8AcFyvyQZfynlYQHr6GAtQopbyxxQihPevE/2Tz
   Y52Vnj9p1XWlihn/S1q59nkvFbrXom/EmvRbHJ1hEqfGVBVn0DGea17Jq
   wIXw5E6xlTb5usKxBIiOTnp43NuKz/BFRMsX8b0X0cow76TU6hstKBehI
   g==;
X-CSE-ConnectionGUID: 0/KXoREdR9Ks/8yJsuRrdw==
X-CSE-MsgGUID: nMP/N3doSQyAbf8bUhLSxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21831413"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="21831413"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 01:58:41 -0700
X-CSE-ConnectionGUID: Q2uoRRdZQFOkD8xr8YMFRg==
X-CSE-MsgGUID: UnNbS80ZQGG6T0inChlm4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="63291175"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 01:58:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sdnMS-0000000EfRD-1Uu2;
	Tue, 13 Aug 2024 11:58:36 +0300
Date: Tue, 13 Aug 2024 11:58:36 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Herve Codina <herve.codina@bootlin.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 1/2] irqdomain: Unify checks for bus_token
Message-ID: <ZrsgPHPVp7HelXkH@smile.fi.intel.com>
References: <20240812193101.1266625-1-andriy.shevchenko@linux.intel.com>
 <20240812193101.1266625-2-andriy.shevchenko@linux.intel.com>
 <87o75wrff7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o75wrff7.ffs@tglx>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Aug 13, 2024 at 10:32:44AM +0200, Thomas Gleixner wrote:
> On Mon, Aug 12 2024 at 22:29, Andy Shevchenko wrote:
> > The code uses if (bus_token) and if (bus_token == DOMAIN_BUS_ANY).
> > Since bus_token is enum, the later is more robust against changes.
> > Unify all checks to follow the latter variant.
> >
> > Fixes: 0b21add71bd9 ("irqdomain: Handle domain bus token in irq_domain_create()")
> > Fixes: 1bf2c9282927 ("irqdomain: Cleanup domain name allocation")
> 
> I'm fine with the change per se, but what does this fix? It's correct
> code, no?

Technically yes, it's correct code as long as nobody touches the mentioned enum.
It fixes the style and makes it robust against the changes.

-- 
With Best Regards,
Andy Shevchenko



