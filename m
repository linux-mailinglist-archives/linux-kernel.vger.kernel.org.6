Return-Path: <linux-kernel+bounces-201087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B568FB928
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32F51F220EB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311C114830B;
	Tue,  4 Jun 2024 16:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NgIm8cRz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F6B33F6
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717518989; cv=none; b=hvxouuwSNn/HpXTMmSlrGL6p8NJQDMd7wlcGhEgBLfucCMiiUe4GW7jFn3mvV9HYOFhRk5DsfCzQ6AkjRNQnGqugGWanZNkFnLokenikEdrdja0oXqRMIjSVJDYFltZIdx6LfFVTxFf+ZQE86UehWl2KNXRfmNY5pgCmWUsQ8MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717518989; c=relaxed/simple;
	bh=3Y+YcVnodDaP4bqYvvnm8//OeGFbUjywXsRzNzmocdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdYLXYD0Ugk1c5nEwj07q9syqwMOmWXCSKEOiOJHboI1blncOLH4YURXAWhs3XZUWd0ZWvlQS/3xhyF6lG00b8eAJpWnXD1CLPn46SeRDUcn1BKm6h3tYUQw2/VdDkkwMevMkcUv4Vazd/059fb9bqHZBouBdZYSGh9qOhBvHqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NgIm8cRz; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717518988; x=1749054988;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3Y+YcVnodDaP4bqYvvnm8//OeGFbUjywXsRzNzmocdY=;
  b=NgIm8cRzfj4ggMRFN61dlh7IUzBPeidrrZCscviyb0FN4HHRoaNWxJkt
   EPRcXIRloNTa7GTwvJIb93XO6ugn3MdFE1xVNhtT9Awfa0J80l0vj6/dv
   /rIdbJcZtgPq4wP/kZPF2Q/9oHiWt4KusjlJ1NolRYoeDrtAJTfj3jYLz
   WMi4784kDqM8vGqBAMkg71mX2mde8x4XRHwOz1T7lXXSEDq2mwncOWt3H
   VXYVqIzmoIREMyAgQLz00uxwpvJnqsXkjk2BE/Lb+efhBCrCWF7tz+5tw
   HZVQt1DXiolbBwjf9DRM5ceb+99Rh4eQo5q46FTAua28pr7VlL1gsLFOB
   g==;
X-CSE-ConnectionGUID: bCavaAo0S5inAGVqW7oRMA==
X-CSE-MsgGUID: nCwxmk38Q9qbewcjUomxLg==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="24741903"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="24741903"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 09:36:27 -0700
X-CSE-ConnectionGUID: 1gISvojnQJGi44yFbAOXBQ==
X-CSE-MsgGUID: gJxRvN+PSa6oaw+7dpzfVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="37283557"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 09:36:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sEX94-0000000DbeM-3j78;
	Tue, 04 Jun 2024 19:36:22 +0300
Date: Tue, 4 Jun 2024 19:36:22 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v1 1/1] treewide: Align match_string() with
 sysfs_match_string()
Message-ID: <Zl9ChheV8lS8_DUd@smile.fi.intel.com>
References: <20240603211538.289765-1-andriy.shevchenko@linux.intel.com>
 <87tti9cfry.fsf@intel.com>
 <20240604115235.044acfd6@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604115235.044acfd6@gandalf.local.home>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jun 04, 2024 at 11:52:35AM -0400, Steven Rostedt wrote:
> On Tue, 04 Jun 2024 10:45:37 +0300
> Jani Nikula <jani.nikula@linux.intel.com> wrote:
> 
> > On Sun, 02 Jun 2024, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > Make two APIs look similar. Hence convert match_string() to be
> > > a 2-argument macro. In order to avoid unneeded churn, convert
> > > all users as well. There is no functional change intended.  
> > 
> > Why do we think it's a good idea to increase and normalize the use of
> > double-underscore function names across the kernel, like
> > __match_string() in this case? It should mean "reserved for the
> > implementation, not to be called directly".
> > 
> > If it's to be used directly, it should be named accordingly, right?
> > 
> > Being in line with __sysfs_match_string() isn't a great argument alone,
> > because this adds three times the number of __match_string() calls than
> > there are __sysfs_match_string() calls. It's not a good model to follow.
> > Arguably both should be renamed.
> 
> Agreed. I want to get rid of any functions starting with an underscore
> except for those that are basically the same function used internally for
> convenience.
> 
> Perhaps "match_string_dynamic()"? Where it is used for dynamically
> allocated arrays without known size. Or, allow a third parameter for
> dynamic arrays.
> 
> #define match_string(_a, _s, ...)
> 	char _______STR[] = __stringify((__VA_ARGS__));	\
> 	if (sizeof(_______STR) > 3)			\
> 		__match_string(_a, _s, ##__VA_ARGS__);  \
> 	else						\
> 		__match_string(_a, _s, ARRAY_SIZE(_a));
> 
> What the above stringify((__VA_ARGS__)) does is to check the size of any
> args added to match_string(). if there isn't any, it will turn into:
> "()\0", which is of size 3. If you add an argument, it will be:
> "(<arg>)\0", which will have a size greater than three.

We have args.h for such tricks.

> (trace_printk() does this trick in include/linux/kernel.h).
> 
> This way, both:
> 
>  match_string(array, sting);
> 
> or
> 
>  match_string(array, string, size);
> 
> will work.

But Linus already gave a few good advice including the name. I don't wont to
switch to this magic for match_string() as it's fine to have a simple macro.

-- 
With Best Regards,
Andy Shevchenko



