Return-Path: <linux-kernel+bounces-330518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F35979F91
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 12:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 152EE283EAD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1161414F9E2;
	Mon, 16 Sep 2024 10:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bf69fvHW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252FB14A4D6;
	Mon, 16 Sep 2024 10:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726483264; cv=none; b=ubAC5vXLW4OGlBQMcbOp/bEY9WDoyg3u1/WPVKSnawwJKAGjvznnPhwMcYRhM7YlkUC4MQ6G783i3WJUGm+sVJFE8DdM1GdFt9TDaHUbvBUqJm4a2DYpMC+ykd8th7GbkULD280p8ap21KnAaj1XfGdYtojWX0dsz0lO1PyqEuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726483264; c=relaxed/simple;
	bh=QJSogLodkp4fLMxYum1X3Twzgv9uPxOOc3on5SLpiPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ql4xkQPKS6Fa+z+1w4hn8Gn2rHXaQU0vMTGiDa3sIF1USUIV8T1RmGyHQNIZcXJHyTJwSSwDdfN2hUIrkpT/RPBg+VZ2ggEj+DKlqkzOGYcHMGsaa8Gn2qiXiz0QGyJxq3U0yfmlGxIi3cuR2lxU0++nUaWck51PCWYhwmPt5nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bf69fvHW; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726483263; x=1758019263;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QJSogLodkp4fLMxYum1X3Twzgv9uPxOOc3on5SLpiPI=;
  b=bf69fvHWDEbZsWxjLV0jUiiXWg4r1owIK8fPrgaMQEd8tLyHfyrZPox5
   43me87obo9wLWvC7x1dcnikySHhvby9MwIBy6Y60DVRT4qj/VpR2vKZ4g
   6FxODLuITBlbX/x4tTmWTJpF2i2O8KRFgXooNnl+wO9D+ElntAm4J7oQV
   kooK+AZlz/PsDjOPevf/OBVDCxAXE10lYTk/foXUebyfShlQpOG9Jwydq
   2WpBhZ48MtxsMQK6GPUf3v63p3ZPl8V0xytuXsVJKKjsNV4YKibMmqA3d
   KqJvgkT2/4+ahpY5bTFQUptpOOt617z7srvToZ26X9lILWoRjE6fI7FMq
   g==;
X-CSE-ConnectionGUID: lAxYJJNpSu+j3TzpGrIcVg==
X-CSE-MsgGUID: hjq3PzlARRe5ivlxQJP98w==
X-IronPort-AV: E=McAfee;i="6700,10204,11196"; a="25175543"
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="25175543"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 03:40:57 -0700
X-CSE-ConnectionGUID: JbW+q7FBRnSHANCuIl9pTA==
X-CSE-MsgGUID: wOvtWHrDSna5J2jM5f4XEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="69324450"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 03:40:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sq9A3-00000009QSd-1r5O;
	Mon, 16 Sep 2024 13:40:51 +0300
Date: Mon, 16 Sep 2024 13:40:51 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Gergo Koteles <soyer@irl.hu>, Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ike Panhc <ike.pan@canonical.com>,
	Peter Zijlstra <peterz@infradead.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] platform/x86: ideapad-laptop: Make the
 scope_guard() clear of its scope
Message-ID: <ZugLM6oe2caYHLX8@smile.fi.intel.com>
References: <20240829165105.1609180-1-andriy.shevchenko@linux.intel.com>
 <20240904045201.v3mp4u7pcqj7qrdp@treble>
 <Ztg1wzHB-so2qV2L@smile.fi.intel.com>
 <20240906031601.4yodvhurcyi26qb2@treble>
 <20240913233324.GA306935@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913233324.GA306935@thelio-3990X>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 13, 2024 at 04:33:24PM -0700, Nathan Chancellor wrote:
> On Thu, Sep 05, 2024 at 08:16:01PM -0700, Josh Poimboeuf wrote:
> > On Wed, Sep 04, 2024 at 01:26:11PM +0300, Andy Shevchenko wrote:
> > > On Tue, Sep 03, 2024 at 09:52:01PM -0700, Josh Poimboeuf wrote:
> > > > I'm not sure I buy that, we should look closer to understand what the
> > > > issue is.  Can you share the config and/or toolchain version(s) need to
> > > > trigger the warning?
> > > 
> > > .config is from the original report [1], toolchain is
> > > Debian clang version 18.1.8 (9)
> > > 	Target: x86_64-pc-linux-gnu
> > > 	Thread model: posix
> > > 	InstalledDir: /usr/bin
> > > 
> > > (Just whatever Debian unstable provides)
> > > 
> > > [1]: https://lore.kernel.org/oe-kbuild-all/202408290219.BrPO8twi-lkp@intel.com/
> > 
> > The warning is due to a (minor?) Clang bug, almost like it tried to
> > optimize but didn't quite finish.
> ...
> > In this case, mutex is an unconditional guard, so the constructor just
> > returns the original value of '&priv->vpc_mutex'.  So if the original
> > '&priv->vpc_mutex' is never NULL, the condition would always be true.
> 
> Thanks a lot for that Josh. I have a somewhat trivial reproducer for the
> clang folks to take a look at. I should have some time on Monday to get
> that reported upstream and I will see if I can find anyone to take a
> look at it.
> 
> For what it is worth, I don't think the workaround for this is too bad
> and it seems like it only shows up with KCOV.

FWIW, Hans queued the workaround.

-- 
With Best Regards,
Andy Shevchenko



