Return-Path: <linux-kernel+bounces-398093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2769BE53C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 12:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C56741F21C4A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 11:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BCB1DE4C5;
	Wed,  6 Nov 2024 11:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nJBRWsqy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84D71DDA15
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 11:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730891335; cv=none; b=KBVKcl/NJwzYiyblcBF+KsYGUnJQnNAZwSFqJ6kx0TnHhpfaFaPO1+Y4Ctv9ocyak1fEKvh+WriKORiE6EIxrB9WwiITZTM+5crD6M1n/qYykeGNZbcXxyhZ6faRU3dnkWVZzXVP8pbQgz3YDavCHYkD1GP8KA9pGgQJYOPEIEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730891335; c=relaxed/simple;
	bh=F2BXgCM0xWZBgpe333JVy4snkckz6II4fuPM822ioYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bI8O4gjYrpJvkqcYfVjxOPs02D6IY3/iS0faV1w+ZOCPbl61w+LPlxzePmCVBagvDBm2BMFtZ2dUoqujeB3dHfeZa2fPcSzdzSq9PKJg67eVAwivyjDNTT9ADA3IQ+VLvH5aNQgiwNM5rEWHwbr8J5VM7A5VE+LjeaYxfK6ypG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nJBRWsqy; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730891334; x=1762427334;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F2BXgCM0xWZBgpe333JVy4snkckz6II4fuPM822ioYk=;
  b=nJBRWsqyBwZny9Vfu156dOXIupoR8i9VnsrIz96G0jYuJYtS0dSbCCwn
   fvbwMNT6LPtQ97/H79q2YQD+08izJZG+2Hgjk1Nrx1FB4mJxpg/OhoJ/o
   0mtuqeesWGFuNN7lMdrzUnJmFRNcT6phmbQ84OLOSqEeiJl65IyU/AfMe
   /s0zObd2VPr/BH7iO8eUTUOZteWxgNsczQzbBAyxa4J3xG902Uhj2GCEO
   n85YZJy2Ojfht3Qxh9nGpCW5HkjenCBuTjX5Vy0kWlHlMa0VQbkfZ/2Vw
   RcOGqf9u2FtixVWhT0AYZHAm2QlpmfBMspHdq26b2dxmZw+RCvHu2LKyc
   Q==;
X-CSE-ConnectionGUID: XbmPEgTyTTGKUmLhwbmaiQ==
X-CSE-MsgGUID: 8lirYM4LRESa1luZKQxJjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="42082724"
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="42082724"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 03:08:53 -0800
X-CSE-ConnectionGUID: n/KeWUJNRQWWuZOUZ7oJ4A==
X-CSE-MsgGUID: Ztn7PRLrRdm7ZJYG2iO34Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="84890985"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 03:05:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t8drI-0000000Blgh-0nAQ;
	Wed, 06 Nov 2024 13:05:56 +0200
Date: Wed, 6 Nov 2024 13:05:55 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/platform/intel-mid: Replace deprecated PCI functions
Message-ID: <ZytNkxLzgBnQn_pV@smile.fi.intel.com>
References: <20241105112521.58638-2-pstanner@redhat.com>
 <ZyoxPQPupkorXPoa@smile.fi.intel.com>
 <b778fb587d7ce15b89847627ba3caca2d8d060d8.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b778fb587d7ce15b89847627ba3caca2d8d060d8.camel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Nov 06, 2024 at 09:37:51AM +0100, Philipp Stanner wrote:
> On Tue, 2024-11-05 at 16:52 +0200, Andy Shevchenko wrote:
> > On Tue, Nov 05, 2024 at 12:25:22PM +0100, Philipp Stanner wrote:

...

> > > -	ret = pcim_iomap_regions(pdev, 1 << 0, pci_name(pdev));
> > > -	if (ret) {
> > > -		dev_err(&pdev->dev, "I/O memory remapping
> > > failed\n");
> > 
> > Btw, do we have a similar message to be printed inside the new call?
> 
> Hm, no, it seems I forgot. Normally I keep those messages.
> 
> In this particular case we probably want to say "I/O memory request /
> remapping failed\n", though.
> 
> And/or we give back the error code, which would reveal the exact issue
> through -ENOMEM / -EBUSY

I would expect this to behave in a similar way to devm_*ioremap*() which prints
message(s) and returns different error codes depending on the failure.

> > > -		return ret;
> > > -	}

...

> > > +	pwr->regs = pcim_iomap_region(pdev, 0, "intel_mid_pwr");
> > > +	if (IS_ERR(pwr->regs))
> > > +		return PTR_ERR(pwr->regs);

-- 
With Best Regards,
Andy Shevchenko



