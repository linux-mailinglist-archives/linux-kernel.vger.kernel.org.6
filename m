Return-Path: <linux-kernel+bounces-313281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC4396A310
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC16B2853C5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF4A189536;
	Tue,  3 Sep 2024 15:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YvBy7Qdj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C40188929;
	Tue,  3 Sep 2024 15:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725378028; cv=none; b=BVqbxqpE56HF26WI5CUPFHGR6pH2po1olSdZl72ixBRDBL8OMPHkjQ3jd6XUTgeCUjXX/xrfWU3VUwvnIqVIRbmpzz04fq0Vz/33PVoQ3ZxgUGJqiml2hZBN70bg4efmPhdiCm0MF/YG5XBtv6SsK22++vB58dgo7vWVf8Vfuhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725378028; c=relaxed/simple;
	bh=LwT0DlrGGH8heL10AfjDdQBTi3BDUJzBfZBunyRNztI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=poVNfeCW2KLfRPzVIrTrrQmZheA1WZfWBgxo+09oscGqZSYF3nTzCVp8ZcxPJRP01Et5UWTo1+aVwbaL0Byby2Kd+Bg3O564e1faQWQ6VULn0CHy63N4jGkZU5R55cz3fg7S1/DZIlBYrx9sF46Gvqq/FU7OMtLRcylj15Ss3pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YvBy7Qdj; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725378026; x=1756914026;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LwT0DlrGGH8heL10AfjDdQBTi3BDUJzBfZBunyRNztI=;
  b=YvBy7QdjRVdC71ll6aSimxvdU6914ImH3tehiHjudOOjYOKJ6P7QGarc
   AthVKnSgpemjU5HIeEWKNhf3RJoOWD2CIbtkWEunS399jytVFkNP24Y6h
   hq+InBhe1eUZXLcaJ5ybBI80gjHaYEQujiWn3dKJn4TKeKhtShAmVQRRt
   9nXc0GoiF7DuuAaCdSNNsqkH8jJ4aZ6IAsDFLzawzbiIGYYUATtW45hLI
   Bxveh6jLFpcWK+px1EkL9GiCi40AMbya9LCwi1QMRHO0Qg6FGDUFtXvQH
   enOBB1aBzA4BR3Evwr2UP3YL/p+Vozr9bgL18Av9KVeYJKkr3kpvX3UQs
   w==;
X-CSE-ConnectionGUID: i/QP5J0/QhmH1+bq3LtOcw==
X-CSE-MsgGUID: Xot56LjRSGCWzDHR17y0Qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="23552238"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="23552238"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 08:40:25 -0700
X-CSE-ConnectionGUID: i7ETKaiJR7CA9WG5IhVYnQ==
X-CSE-MsgGUID: yMTHsEq0T42gSF9Sa052ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="64945293"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 08:40:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1slVdg-00000004kvO-27Xs;
	Tue, 03 Sep 2024 18:40:16 +0300
Date: Tue, 3 Sep 2024 18:40:16 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Gergo Koteles <soyer@irl.hu>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ike Panhc <ike.pan@canonical.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] platform/x86: ideapad-laptop: Make the
 scope_guard() clear of its scope
Message-ID: <Ztct4P_PvQmeq_ih@smile.fi.intel.com>
References: <20240829165105.1609180-1-andriy.shevchenko@linux.intel.com>
 <cf8c73dd91dbbb11b562a5e0d9ac6b4035c32d28.camel@irl.hu>
 <Ztcn2Yu2TNSOYbhP@smile.fi.intel.com>
 <0e53a8b6eeb457f11a8a514b12c0598d1727b43d.camel@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e53a8b6eeb457f11a8a514b12c0598d1727b43d.camel@irl.hu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Sep 03, 2024 at 05:29:02PM +0200, Gergo Koteles wrote:
> On Tue, 2024-09-03 at 18:14 +0300, Andy Shevchenko wrote:
> > On Tue, Sep 03, 2024 at 05:00:51PM +0200, Gergo Koteles wrote:
> > > On Thu, 2024-08-29 at 19:50 +0300, Andy Shevchenko wrote:
> > > > First of all, it's a bit counterintuitive to have something like
> > > > 
> > > > 	int err;
> > > > 	...
> > > > 	scoped_guard(...)
> > > > 		err = foo(...);
> > > > 	if (err)
> > > > 		return err;
> > > > 
> > > > Second, with a particular kernel configuration and compiler version in
> > > > one of such cases the objtool is not happy:
> > > > 
> > > >   ideapad-laptop.o: warning: objtool: .text.fan_mode_show: unexpected end of section
> > > > 
> > > > I'm not an expert on all this, but the theory is that compiler and
> > > > linker in this case can't understand that 'result' variable will be
> > > > always initialized as long as no error has been returned. Assigning
> > > > 'result' to a dummy value helps with this. Note, that fixing the
> > > > scoped_guard() scope (as per above) does not make issue gone.
> > > > 
> > > > That said, assign dummy value and make the scope_guard() clear of its scope.
> > > > For the sake of consistency do it in the entire file.
> > > > 
> > > 
> > > Interestingly, if I open a scope manually and use the plain guard, the
> > > warning disappears.
> > 
> > Yes, that's what I also have, but I avoid that approach because in that case
> > the printing will be done inside the lock, widening the critical section for
> > no benefits.
> > 
> 
> This is intended to be an inner block scope within the function, it
> does not expand the critical section.

I'm not sure I understand.

scoped_guard() has a marked scope (with {} or just a line coupled with it).
The guard() has a scope starting at it till the end of the function. In the
latter case the sysfs_emit() becomes part of the critical section.

> > > 	unsigned long result;
> > > 	int err;
> > > 
> > > 	{
> > > 		guard(mutex)(&priv->vpc_mutex);
> > > 		err = read_ec_data(priv->adev->handle, VPCCMD_R_FAN,
> > > &result);
> > > 		if (err)
> > > 			return err;
> > > 	}

But looking again into the code above now I got what you meant.
You have added a nested scope inside the function, like

	do {
		...
	} while (0);

Yes, this is strange and not what we want to have either. So I prefer to hear
what objtool / clang people may comment on this.

Sorry that I missed this.

> > > This looks a bit strange, but is probably easier for the compiler than
> > > the for loop of scoped_guard.
> > > 
> > > But I don't know how well this style fits into the kernel.

-- 
With Best Regards,
Andy Shevchenko



