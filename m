Return-Path: <linux-kernel+bounces-305580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2839630C9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31D411F252F6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704691AB53B;
	Wed, 28 Aug 2024 19:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DTpygrCU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD161AAE0F;
	Wed, 28 Aug 2024 19:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724872411; cv=none; b=qIie9XipvPGzK7Ic7O7NHVaYNqZectHwo422o+zYYGRvMKF+Dzycd6VVLDV0FRJbF9r2Up8paUaY3iRo4OpdnC6hSi7BKs/PTQdWeukA06F97IlPOKWP7ZPlogyQ13X2ix9iFKUh19f7ta9KPckuhjNFlIBEjs7DINvmiHLVPLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724872411; c=relaxed/simple;
	bh=m0Xt2Ak3rlq9h+7vtRXskxCt/q1SHK/xbRP6OD81bH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvaktpI0M8Y2rdoM1ulls9NA23tjWBRY451oNsTWpgROYCdd63c4A1wVeGtH66V5ls12KEBKG7zKwPr162/pyv20pmcS6pyGiKZIzL/muDcNCyKrYHAnbIEkyJIX+S+C/smqA3onoagvZ5SnZyFsqtsWun27G6jHpy3EoIScNqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DTpygrCU; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724872410; x=1756408410;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m0Xt2Ak3rlq9h+7vtRXskxCt/q1SHK/xbRP6OD81bH0=;
  b=DTpygrCUAh7KTOxYEJ0d9XgIUA5q8Tj3L9jbgvBR/R+zKQLj6q44kw/Z
   K9yACx689Qk5dQdto5/+ViLcXc0wgyYInGCyldzpdSCHwxMDJhfy7bnAw
   O2tdeZmLX2xnvZy+CtV7XdMz4HKnUEWCq7xb3e/FYBBNYraGI5rDU/kXw
   HnZMHuE9uc8+c/lxcG9MasHzEOMvD6o4U66y1t3X7LK4YBmCMfeHE8Pvg
   TAMeuPXXxNu3YoeWkmV5f12B1U8WzyKpq8A68IUNeFtgoZCU/FHL4RiIX
   G0HkI9TXQUUW3j7qR0InVs6i9oOxqMhRPfgt5269962Mw0rLL5IZon7Nw
   g==;
X-CSE-ConnectionGUID: jhA46x05Sqq7uqPWG8BcaQ==
X-CSE-MsgGUID: 2/B1Qc2ATyC2h7rTGCDQGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="26326597"
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="26326597"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 12:13:29 -0700
X-CSE-ConnectionGUID: +yEnfE28RkyRKYYYaTya2w==
X-CSE-MsgGUID: mbfGMMwsQneFJtvSmHSMlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="94045694"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 12:13:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sjO6f-00000002lOa-1P9i;
	Wed, 28 Aug 2024 22:13:25 +0300
Date: Wed, 28 Aug 2024 22:13:25 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v1 1/1] clk: devres: Simplify devres handling functions
Message-ID: <Zs921Yj-lqg54wZs@smile.fi.intel.com>
References: <20240822155822.1771677-1-andriy.shevchenko@linux.intel.com>
 <9e16ddb1c1a697464ce1f5438ab9ca31.sboyd@kernel.org>
 <Zs8hRPA9Lya29d6d@smile.fi.intel.com>
 <def27b96be1c2a8b84f83a55e310bf95.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <def27b96be1c2a8b84f83a55e310bf95.sboyd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Aug 28, 2024 at 11:39:51AM -0700, Stephen Boyd wrote:
> Quoting Andy Shevchenko (2024-08-28 06:08:20)
> > On Tue, Aug 27, 2024 at 05:19:04PM -0700, Stephen Boyd wrote:
> > > Quoting Andy Shevchenko (2024-08-22 08:58:22)

...

> > > > -       state = devres_alloc(devm_clk_release, sizeof(*state), GFP_KERNEL);
> > > > +       state = devm_kmalloc(dev, sizeof(*state), GFP_KERNEL);
> > > 
> > > When is this allocation freed if the get() fails? When the calling
> > > device driver detaches?
> > 
> > At device unbinding. Is it a problem?
> 
> It is a change, and the commit text said no functional change :(

Ah, I see. I think it's possible to actually make it happen that there will be
no dangling memory in case of failure. I'll think about that.

-- 
With Best Regards,
Andy Shevchenko



