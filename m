Return-Path: <linux-kernel+bounces-316646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2C996D250
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CD751C227FB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518C7194C78;
	Thu,  5 Sep 2024 08:37:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EFF1898E4;
	Thu,  5 Sep 2024 08:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725525420; cv=none; b=f8mW0vQWhZkI2DWJsW1ymU2ToIadXAmsDly1N21fYEMvykMHFneIpBYmvYVb7Pze94O4XeX9elJJA9YaoxWD5OlGZT48NYN2CV7gryjvjVovMwhzJmVdd1OwXH88xN7AQg/BVRFfs4S12vTaIwaJVTIRlBvd5bF3OGnRYsZw2B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725525420; c=relaxed/simple;
	bh=HL3AFN93sVAtyqwAiq4TtJ5qBuNx8F4k3i/pvUwbjec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjIjPAB3HAWOsg+avjGnubmy52Tcgfh1fpQf17gJ4eeX0RHk7lw0QnLN+oyZF88+bQ117X1N5hDXhNwTo6CAFVsyUZtZ+1yTjs98ipjmmO7/nON88ZeYem/zmO94fNQT29RKe1+2LI00uO3fiXNXHk49R4Gvcust8pCdbxqMR2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: jo54b/OYR3yHxLG96C4q5g==
X-CSE-MsgGUID: c56P0ZUXStOLFcq2yMcV8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="24091413"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="24091413"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 01:36:57 -0700
X-CSE-ConnectionGUID: 3tJ2ZgUWQLqcvfYD66K1/g==
X-CSE-MsgGUID: odFxv4WuT0+tyjkIJTL2Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="65867733"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 01:36:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1sm7z1-00000005KmM-1cGK;
	Thu, 05 Sep 2024 11:36:51 +0300
Date: Thu, 5 Sep 2024 11:36:51 +0300
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Gergo Koteles <soyer@irl.hu>, platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ike Panhc <ike.pan@canonical.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] platform/x86: ideapad-laptop: Make the
 scope_guard() clear of its scope
Message-ID: <Ztlto06GyFxLXz1y@smile.fi.intel.com>
References: <20240829165105.1609180-1-andriy.shevchenko@linux.intel.com>
 <8a106cfe-f7cd-4660-983a-feba627cdcab@redhat.com>
 <ZtjAmavK5tr4mvka@surfacebook.localdomain>
 <8d35db80-5bf3-40ca-b041-8a94e76739c7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d35db80-5bf3-40ca-b041-8a94e76739c7@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Sep 05, 2024 at 10:33:22AM +0200, Hans de Goede wrote:
> On 9/4/24 10:18 PM, Andy Shevchenko wrote:
> > Wed, Sep 04, 2024 at 08:14:53PM +0200, Hans de Goede kirjoitti:
> >> On 8/29/24 6:50 PM, Andy Shevchenko wrote:

> >>> First of all, it's a bit counterintuitive to have something like
> >>>
> >>> 	int err;
> >>> 	...
> >>> 	scoped_guard(...)
> >>> 		err = foo(...);
> >>> 	if (err)
> >>> 		return err;
> >>>
> >>> Second, with a particular kernel configuration and compiler version in
> >>> one of such cases the objtool is not happy:
> >>>
> >>>   ideapad-laptop.o: warning: objtool: .text.fan_mode_show: unexpected end of section
> >>>
> >>> I'm not an expert on all this, but the theory is that compiler and
> >>> linker in this case can't understand that 'result' variable will be
> >>> always initialized as long as no error has been returned. Assigning
> >>> 'result' to a dummy value helps with this. Note, that fixing the
> >>> scoped_guard() scope (as per above) does not make issue gone.
> >>>
> >>> That said, assign dummy value and make the scope_guard() clear of its scope.
> >>> For the sake of consistency do it in the entire file.
> >>>
> >>> Fixes: 7cc06e729460 ("platform/x86: ideapad-laptop: add a mutex to synchronize VPC commands")
> >>> Reported-by: kernel test robot <lkp@intel.com>
> >>> Closes: https://lore.kernel.org/oe-kbuild-all/202408290219.BrPO8twi-lkp@intel.com/
> >>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> >> Thank you for your patch, I've applied this patch to my review-hans 
> >> branch:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
> > 
> > Have you had a chance to go through the discussion?
> 
> Yes I did read the entire discussion.
> 
> > TL;DR: please defer this. There is still no clear understanding of the root
> > cause and the culprit.
> 
> My gist from the discussion was that this was good to have regardless of
> the root cause.
> 
> IMHO the old construction where the scoped-guard only guards the function-call
> and not the "if (ret)" on the return value of the guarded call was quite ugly /
> convoluted / hard to read and this patch is an improvement regardless.

Okay, if you think it's good to go, you are welcome!

Thanks!

-- 
With Best Regards,
Andy Shevchenko



