Return-Path: <linux-kernel+bounces-305024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EE5962852
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71327281CE5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B8A17C9BA;
	Wed, 28 Aug 2024 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V5NiAfZk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05DD176FDB;
	Wed, 28 Aug 2024 13:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724850721; cv=none; b=JV9lRlAho7EVMVNoAFI8UZP+fRcH8HLK4KnQmnb8qwYl/aph1jKRfplWZk3zC/O4M8H4RXYcHja5GslUBBZhyT0BJM+FkmFopACMN7x+wtIZjiSLVAK4eAO8Xhf1E1gk2qyi/c/V9BUonq0lM49PPAkHKDcamhC+4V32xrsNS1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724850721; c=relaxed/simple;
	bh=qpQyyUV/wrK7/kBpOT8YdWqj1dwu3WxVcSyZDytjA+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRDvjOkYZ2z8y5aVlSMZqZmgCTdVNuXIzTmLFtqbwOf3o2jaX5uSEBoRpEZnD2yP+T2mYy3lVGcmK2s5NfbwijineSrcBhNLieOKx6dUiouDRCyE2Bd2Fxz9E+/eiAgKji/G7LoF6PDL+xcdCVkM67v+LsJ22nNoES+COl+NCuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V5NiAfZk; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724850720; x=1756386720;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qpQyyUV/wrK7/kBpOT8YdWqj1dwu3WxVcSyZDytjA+g=;
  b=V5NiAfZk15848wVH59z5tQ8Bc7XvuvruEgMmxfOEMc6J/LyvN5seLR83
   rbCq4HlcJPhU6dfqZ1aNEiNlQkvj8nrc3BamvJqSo/qNNQ6lIXvd8RkFm
   QoDa6uuLg7qtNadk+X02S0y0GiCrvecv9181co5aQa0sxlhRI8kOzGSQ0
   98st61WZVKy1W2TmH2ULmFPJd7XSwpE4QvumL+NRtzZMXgmHjwsmAgYZ9
   Wpq+GVX1tJTrWnUninOFvQvhqm3cbHsDWf26n0uLaa8KwHefOUCyF3Ztl
   E4pUJZPEuqM2PQuC2mj+tC+eg27vK77q+GMs9r2aoveniyfA+PwN3IwB9
   A==;
X-CSE-ConnectionGUID: T1aOsao4T4uA/nRviRneKw==
X-CSE-MsgGUID: QAwX4miASfGJhWV7Sfeffg==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="34534962"
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="34534962"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 06:11:59 -0700
X-CSE-ConnectionGUID: rP4eJrySTrmgVJF0xyqwbg==
X-CSE-MsgGUID: kMLWcatySlGt4luWiVmmEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="62873601"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 06:11:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sjISp-00000002eTv-3QT5;
	Wed, 28 Aug 2024 16:11:55 +0300
Date: Wed, 28 Aug 2024 16:11:55 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v1 1/2] clk: x86: lpss-atom: Use predefined constants
 from units.h
Message-ID: <Zs8iGy8zLG2zs34J@smile.fi.intel.com>
References: <20240822161452.1780149-1-andriy.shevchenko@linux.intel.com>
 <20240822161452.1780149-2-andriy.shevchenko@linux.intel.com>
 <3e782ac88cc28fb5fa7ed71e7573e60f.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e782ac88cc28fb5fa7ed71e7573e60f.sboyd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Aug 27, 2024 at 05:21:00PM -0700, Stephen Boyd wrote:
> Quoting Andy Shevchenko (2024-08-22 09:14:07)

...

> >  static int lpss_atom_clk_probe(struct platform_device *pdev)
> >  {
> >         struct lpss_clk_data *drvdata;
> >         struct clk *clk;
> > +       u32 rate;
> 
> Do we need a local variable?

Hmm... The idea was to allow retrieving this via device properties, that's why
a separate variable, but that patch wasn't included here.

Nevertheless, despite above the separate variable makes code a bit better to
read as we can see what is this value about.

> >         drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
> >         if (!drvdata)
> >                 return -ENOMEM;
> >  
> > +       /* Default frequency is 100MHz */
> > +       rate = 100 * HZ_PER_MHZ;
> > +
> >         /* LPSS free running clock */
> >         drvdata->name = "lpss_clk";
> > -       clk = clk_register_fixed_rate(&pdev->dev, drvdata->name, NULL,
> > -                                     0, 100000000);
> > +       clk = clk_register_fixed_rate(&pdev->dev, drvdata->name, NULL, 0, rate);
> 
> This should be a one line patch.

I don't get this. You mean the entire thingy?

It's possible, but as I mentioned above there is a rationale for making it with
a temporary variable.

> >         if (IS_ERR(clk))
> >                 return PTR_ERR(clk);

-- 
With Best Regards,
Andy Shevchenko



