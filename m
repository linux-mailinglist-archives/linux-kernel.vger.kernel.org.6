Return-Path: <linux-kernel+bounces-305021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD7196283F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEF751F21E34
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1E6181328;
	Wed, 28 Aug 2024 13:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gVfdxwB9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B3D178399;
	Wed, 28 Aug 2024 13:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724850506; cv=none; b=JqUWFmXKzXFvCFo/YGmgU3Gu1uxpY/tbwMxlr8HhPuqpaHKS0gXlEv0tfGRdHkphLnmKiIKObhbzSQnQcl5DzPLwYkZ1JsulcC1/dsmxVq2EDNYVRdbrAjcAGZrf7OdVG5MvMyfkPF+aizzpT/6xBR1MAChvip4kfWrm/5bZ/DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724850506; c=relaxed/simple;
	bh=AaZvISxeByNLSJ2mWzj6u/5KcGJrceMC6IDkphTSzKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJQfMFQBkxbHUm5H60c66RAywYpyzF56gyVf/+hGKprPgot2DdqjoCgLH5Zt39n5egsyTM5vxpLdsYnh++OiG+3DxRxI2VBLWUXL2R0JO490LC6/z/PGEQq9Qmcc8SKqLdEVJtsx8J18cShYJwtszP+mao6q30sX/WTsgTXQNKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gVfdxwB9; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724850505; x=1756386505;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AaZvISxeByNLSJ2mWzj6u/5KcGJrceMC6IDkphTSzKA=;
  b=gVfdxwB9Tj+arsopFD16ARtKDtjlvTvvCJF2AT7my5WIh8mkw1aHYeLj
   cf170T/ARnNIFA1lnV2z3xb+/mEUtsoehJv9UPvbJp0yUlkMsMJVHgPUZ
   K9XmNar4SztGd4T+4AEnI38/C+9UkKVTeic4SoOnE583MBUJQNkHmmqz4
   U1c6OsA15qDrk9zD4BxXNKZ78+yw14jdyHN4FV6tt84Sd+kdDay2rI9bX
   KdFwl7gUz63/pfgcYivOvxOkjqYLH17QdkF23KF8Lqpf9Lg7DnEpr9U1C
   zuUwQuI7ub3Tr8/X6Vbiy3DQP0M13k/3dhcoo+LcUHo3atOKk75rf1lFS
   w==;
X-CSE-ConnectionGUID: 4mskj7TzQW+kLhEZPTM60g==
X-CSE-MsgGUID: uFTidn+jRWqT1NnIiWplqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="40852377"
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="40852377"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 06:08:25 -0700
X-CSE-ConnectionGUID: xcw9Y7zdRFiqp7Okt45Oug==
X-CSE-MsgGUID: DVgp4aoET4eXEggHMniwRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="86413265"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 06:08:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sjIPM-00000002eQD-3R1i;
	Wed, 28 Aug 2024 16:08:20 +0300
Date: Wed, 28 Aug 2024 16:08:20 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v1 1/1] clk: devres: Simplify devres handling functions
Message-ID: <Zs8hRPA9Lya29d6d@smile.fi.intel.com>
References: <20240822155822.1771677-1-andriy.shevchenko@linux.intel.com>
 <9e16ddb1c1a697464ce1f5438ab9ca31.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e16ddb1c1a697464ce1f5438ab9ca31.sboyd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Aug 27, 2024 at 05:19:04PM -0700, Stephen Boyd wrote:
> Quoting Andy Shevchenko (2024-08-22 08:58:22)

...

> > -       state = devres_alloc(devm_clk_release, sizeof(*state), GFP_KERNEL);
> > +       state = devm_kmalloc(dev, sizeof(*state), GFP_KERNEL);
> 
> When is this allocation freed if the get() fails? When the calling
> device driver detaches?

At device unbinding. Is it a problem?

...

> > +       ret = devm_add_action_or_reset(dev, devm_clk_release, state);
> > +       if (ret)
> > +               goto err_clk_init;
> 
> Shouldn't we return an error here? Otherwise we call clk_put() twice?

Or use devm_add_action().
Thanks for catching this!

> >         return clk;
> >  
> >  err_clk_init:
> >         clk_put(clk);
> >         return ERR_PTR(ret);
> >  }

...

> I stopped reading, sorry! If you want to do this, please add a bunch of
> KUnit tests.

Sure. It's a good idea.

-- 
With Best Regards,
Andy Shevchenko



