Return-Path: <linux-kernel+bounces-314782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4779096B87F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C55B1C21142
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A0A1CB320;
	Wed,  4 Sep 2024 10:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P9i1fC0j"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6575E1CF5F1;
	Wed,  4 Sep 2024 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445742; cv=none; b=Qfx0iAh5wIknbRdrv3JGxpZPjI42+suZiJONdPBhR7eE1QnvA23IUiExrNzUoflGxnqm9M4zruu26hRzmDDbICmss3wyKcUNYwUozZj3BgoXdgG51efCeAhYruNmQ1wdNXpm+MKSJw1mX7ZWcT8w4DpzMF+pxx0NMidOwrgIlfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445742; c=relaxed/simple;
	bh=Lm/SyeR4oJVd5iwgmvFipAcs/tuzkm5769merckReFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdLkZu8k7vI9GTf0v2O7E17hbA8QnZYXctCr/nunKctKNiEvTxPQU2oV254PtOeT8h9XMhsoHoGpwFIjhmDt0eQfuwRA/SOfsdRSx2fxtU1JO8Kd5fd2jB7gTAtSCnLzOWaPmwcw/un0GINQ33dHwMRAFx/wj+W2SXUjeuKEQ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P9i1fC0j; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725445740; x=1756981740;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lm/SyeR4oJVd5iwgmvFipAcs/tuzkm5769merckReFw=;
  b=P9i1fC0jTRf5Ea9jQWyeVIOiO0W6w/P9aJE0TFTvQnSuh/JvEJ/xpl1x
   W6V+th3h83RDTXxbkm1tM6L37vaOwSBPATIssGbu+DJIUqdVmt/auWtKa
   vHAJdzkb0LQ0PJWWHV+LWmumj2OapsSZ6nddCJw/7dIXrKs7BiAf+wCkj
   Yf03uKhuFx6t6lef1AocwlB8a0UpQIga+qukMfhOm8e2gEuxVr8y319Tv
   t9iyyge2RjGRkUzcSOSXKLNQ2R14ORIO1C+/v+UWn1yg/C5W4gIJ6q6V/
   gbDe13MqdrJTunKB7ixm6rhIhIVWYDF9QCgWmXp4tielyDqSuYYqO6miH
   Q==;
X-CSE-ConnectionGUID: 3YKo3wdRQdiA9QdTfMWofw==
X-CSE-MsgGUID: fzGiX8GxT1uCkNhhWQoBag==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="24049975"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="24049975"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 03:29:00 -0700
X-CSE-ConnectionGUID: WxMWFJITRmmodpteAI4NbQ==
X-CSE-MsgGUID: /wMAPsQ9S76BngIagmzbuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="70096287"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 03:28:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1slnFu-00000005208-2Jqr;
	Wed, 04 Sep 2024 13:28:54 +0300
Date: Wed, 4 Sep 2024 13:28:54 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Gergo Koteles <soyer@irl.hu>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ike Panhc <ike.pan@canonical.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] platform/x86: ideapad-laptop: Make the
 scope_guard() clear of its scope
Message-ID: <Ztg2ZjfuEe5PuvF8@smile.fi.intel.com>
References: <20240829165105.1609180-1-andriy.shevchenko@linux.intel.com>
 <cf8c73dd91dbbb11b562a5e0d9ac6b4035c32d28.camel@irl.hu>
 <Ztcn2Yu2TNSOYbhP@smile.fi.intel.com>
 <0e53a8b6eeb457f11a8a514b12c0598d1727b43d.camel@irl.hu>
 <Ztct4P_PvQmeq_ih@smile.fi.intel.com>
 <20240904012242.GA1110859@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904012242.GA1110859@thelio-3990X>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Sep 03, 2024 at 06:22:42PM -0700, Nathan Chancellor wrote:
> On Tue, Sep 03, 2024 at 06:40:16PM +0300, Andy Shevchenko wrote:
> > On Tue, Sep 03, 2024 at 05:29:02PM +0200, Gergo Koteles wrote:
> > > On Tue, 2024-09-03 at 18:14 +0300, Andy Shevchenko wrote:
> > > > On Tue, Sep 03, 2024 at 05:00:51PM +0200, Gergo Koteles wrote:
> > > > > On Thu, 2024-08-29 at 19:50 +0300, Andy Shevchenko wrote:
> > > > > > First of all, it's a bit counterintuitive to have something like
> > > > > > 
> > > > > > 	int err;
> > > > > > 	...
> > > > > > 	scoped_guard(...)
> > > > > > 		err = foo(...);
> > > > > > 	if (err)
> > > > > > 		return err;
> > > > > > 
> > > > > > Second, with a particular kernel configuration and compiler version in
> > > > > > one of such cases the objtool is not happy:
> > > > > > 
> > > > > >   ideapad-laptop.o: warning: objtool: .text.fan_mode_show: unexpected end of section
> > > > > > 
> > > > > > I'm not an expert on all this, but the theory is that compiler and
> > > > > > linker in this case can't understand that 'result' variable will be
> > > > > > always initialized as long as no error has been returned. Assigning
> > > > > > 'result' to a dummy value helps with this. Note, that fixing the
> > > > > > scoped_guard() scope (as per above) does not make issue gone.
> > > > > > 
> > > > > > That said, assign dummy value and make the scope_guard() clear of its scope.
> > > > > > For the sake of consistency do it in the entire file.
> > > > > > 
> > > > > 
> > > > > Interestingly, if I open a scope manually and use the plain guard, the
> > > > > warning disappears.
> > > > 
> > > > Yes, that's what I also have, but I avoid that approach because in that case
> > > > the printing will be done inside the lock, widening the critical section for
> > > > no benefits.
> > > > 
> > > 
> > > This is intended to be an inner block scope within the function, it
> > > does not expand the critical section.
> > 
> > I'm not sure I understand.
> > 
> > scoped_guard() has a marked scope (with {} or just a line coupled with it).
> > The guard() has a scope starting at it till the end of the function. In the
> > latter case the sysfs_emit() becomes part of the critical section.
> > 
> > > > > 	unsigned long result;
> > > > > 	int err;
> > > > > 
> > > > > 	{
> > > > > 		guard(mutex)(&priv->vpc_mutex);
> > > > > 		err = read_ec_data(priv->adev->handle, VPCCMD_R_FAN,
> > > > > &result);
> > > > > 		if (err)
> > > > > 			return err;
> > > > > 	}
> > 
> > But looking again into the code above now I got what you meant.
> > You have added a nested scope inside the function, like
> > 
> > 	do {
> > 		...
> > 	} while (0);
> > 
> > Yes, this is strange and not what we want to have either. So I prefer to hear
> > what objtool / clang people may comment on this.
> 
> So this does not appear to happen when CONFIG_KCOV is disabled with the
> configuration from the original report. I have spent some time looking
> at the disassembly but I am a little out of my element there. If I
> remember correctly, the "unexpected end of section" warning from objtool
> can appear when optimizations play fast and loose with the presence of
> potential undefined behavior (or cannot prove that there is no undefined
> behavior through inlining or analysis). In this case, I wonder if KCOV
> prevents LLVM from realizing that the for loop that scoped_guard()
> results in will run at least once, meaning that err and result would be
> potentially used uninitialized? That could explain why this change
> resolves the warning, as it ensures that no undefined behavior could
> happen regardless of whether or not the loop runs?
> 
> Josh and Peter may have more insight.

Thanks for looking into this. Josh already keeps an eye on this.

-- 
With Best Regards,
Andy Shevchenko



