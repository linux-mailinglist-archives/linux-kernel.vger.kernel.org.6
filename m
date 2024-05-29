Return-Path: <linux-kernel+bounces-193838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE638D32E8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E0171C238AD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 09:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C1B169AF0;
	Wed, 29 May 2024 09:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="acdtmzeo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBD913E8BD
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716974807; cv=none; b=XtnHqPiFq3axbt76hAOwjmIrTG4En/hdzvpiOGiEvP2vyFCpLzHKfHMTnHi2JnzYknl8xFYQOX01D9vzs+MioEHMm80cozRpEb29k02kljTZpTLfrdaYWD/Iq8Ftk5CqGCuk3ToDZHfaq+4kmQGqGYJtTwHfwXFYT+aNhsmVvfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716974807; c=relaxed/simple;
	bh=ijXHrEeuJaWBnQhJyxtNR1JF+hAoVSjKQuuiusB+JT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jh+Qk4OtjkE1eI8BRmnuGmpl3nAwDT8xwmci3kUdPYm7zoydpN97booae6FJmqCHHpbijpvbtl76OlATFdgl4/079TIvD3kasmcTS5GFZkjUxXfBOyxS8fwhW14/7bHcI77FVni2E9s1JVOyqziGRHN0cViy8mKPQOU6qC0l4tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=acdtmzeo; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716974806; x=1748510806;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ijXHrEeuJaWBnQhJyxtNR1JF+hAoVSjKQuuiusB+JT0=;
  b=acdtmzeoZ4488ExsSaElXtJSrEIv6Dtp5uxF8ytSYFYfBbFP22rZnpah
   xZ3qXJ4wc15n2HB01Ycq9cuJPDXXEd5jKjbVgi9t+NxM+ETAzH4+mNi82
   /LkSdflkXhR4a7lOyDWR77nZTtZJJs/pwO7Z9wNqnCH1g7j1BK2SegHrk
   TKnGzkYGQtvJ4kW2Shq+lsD8eZY0LLdHs1hLiX4yeWv+r1W/dNCoRsv2E
   aLEIZLCytjyNgHPK3Pq9j1OLFKFSJQgJju7dh+mClPfspSInW14gvXpYn
   mQQlTP0yx//tsGpKFefcfq2cT/CYvVtBnyrb6eOvi3k5/0/9OanjnwV6R
   w==;
X-CSE-ConnectionGUID: 5pmZXJ+6QJOpLn9t3jLgBQ==
X-CSE-MsgGUID: GoxDbH21RaSZddEPwagQLw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="17199338"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="17199338"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 02:26:45 -0700
X-CSE-ConnectionGUID: hrtsej3cTBy72BYnTHoe+g==
X-CSE-MsgGUID: m4IciKliTJWiGxcKLFzbhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="35457346"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 02:26:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sCFZw-0000000Bl08-3JTe;
	Wed, 29 May 2024 12:26:40 +0300
Date: Wed, 29 May 2024 12:26:40 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: [PATCH v1 1/1] MAINTAINERS: Add Intel MID section
Message-ID: <Zlb00IRVZQB1b0xF@smile.fi.intel.com>
References: <20240521142758.2298717-1-andriy.shevchenko@linux.intel.com>
 <26e49d69-bcec-4f4c-9e7f-5c3b91b8f24c@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26e49d69-bcec-4f4c-9e7f-5c3b91b8f24c@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, May 28, 2024 at 11:19:54AM -0700, Dave Hansen wrote:
> On 5/21/24 07:27, Andy Shevchenko wrote:
> > +INTEL MID (Mobile Internet Device) PLATFORM
> > +M:	Andy Shevchenko <andy@kernel.org>
> > +L:	linux-kernel@vger.kernel.org
> > +S:	Maintained
> 
> Hey Andy,
> 
> I would have expected you to mark this as "Supported":

Okay! I think I also want to add something more to the file list.

> >            Supported:   Someone is actually paid to look after this.
> >            Maintained:  Someone actually looks after it.
> 
> Or were you trying to make this point you're maintaining this without
> your Intel hat on?

In the future (if it ever happens to maintain this while not being an Intel
employee anymore) why not?

-- 
With Best Regards,
Andy Shevchenko



