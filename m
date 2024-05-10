Return-Path: <linux-kernel+bounces-175894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D86E8C26BC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 16:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05B9A284250
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D75170843;
	Fri, 10 May 2024 14:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MTpOCqjL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29714C7D;
	Fri, 10 May 2024 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715351018; cv=none; b=WwKJwneNlU/5sLOFcbrCLkSZor1VP/8ZSzEOkbsZJ5drQ2OcucXvmh7gaBwaRL2BbaQMqeyYHSW4dx9ZnpkY2px6jULsHyAluUySZ2ZwamwecctIfTLY2qGxt7c3JgX6denTiLHlzwDm2SDkm8XMi8eFlo1Nf3YwT1AvgFOHBIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715351018; c=relaxed/simple;
	bh=Z48LlJ3Z8srSQHu5V3rVv+goUQkwYLlS7gGZiYysLAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLD6ixoKV6+Iv/ondOTAGT4AyPYYzMVjoocRx0kBM+b93b632F3POExO96M7S8cEsb8NSa44Vxp4abW/VinMMaWMVsT0cT8nGyRSO3rbY0Wou1sZJI5Yjhi8szyMbv1r/Z4pN+SpvWnfVb/Si2PFTp2dt6hVelt+MMqgLuSnR6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MTpOCqjL; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715351016; x=1746887016;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z48LlJ3Z8srSQHu5V3rVv+goUQkwYLlS7gGZiYysLAY=;
  b=MTpOCqjLIe6/MoihUw8ZBOBY4fuP+aK76ues8QwyUuqTs2QcU3g4QU0u
   dbGrWjfH/RsmITg9G+4X4TseLEDvDE86BIaw2WsyOeckfXbHeyGQQZtTO
   3k4aekKkgHmW4CjT+Ewqp9YyP7KifRU+M8Uv14c5mcd5fw0ehKTWoCJYD
   NBdbUg0jNQvGdjBQd5mo17Y5lw9OJPTV6x4wVl2Ob1PX2yO0vLeYzjG49
   gMNwBh+Oh5jG7mgo6SrQ0+9UadXuTKRzilOlNH8OIaqjp6cT0bZSjHI/N
   Sc4q88EU6qOx/VzJiSehH5kFtQ937+jLdkMUDgdNe/GPCwfG7WJ6MHL2c
   g==;
X-CSE-ConnectionGUID: JRStkU7USHeZWPGjP9lmVA==
X-CSE-MsgGUID: 0qutUi3rQay6Jkb8fvtmcw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11170459"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="11170459"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:23:36 -0700
X-CSE-ConnectionGUID: D1MMH9fVSv+GbVQZTf9AdQ==
X-CSE-MsgGUID: 734wwzgFRzu1HZhaULXFeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="29576126"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:23:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s5R9o-000000067tN-0bg0;
	Fri, 10 May 2024 17:23:32 +0300
Date: Fri, 10 May 2024 17:23:31 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] usb: fotg210: Add missing kernel doc description
Message-ID: <Zj4t4zOjMlW3o57c@smile.fi.intel.com>
References: <20240508150335.1378629-1-andriy.shevchenko@linux.intel.com>
 <2024051047-scrabble-variable-6e29@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024051047-scrabble-variable-6e29@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 10, 2024 at 10:34:05AM +0100, Greg Kroah-Hartman wrote:
> On Wed, May 08, 2024 at 06:03:35PM +0300, Andy Shevchenko wrote:
> > kernel-doc validator is not happy:
> > 
> >   warning: Function parameter or struct member 'fotg' not described in 'fotg210_vbus'
> > 
> > Add missing description.

..

> >  /**
> >   * fotg210_vbus() - Called by gadget driver to enable/disable VBUS
> > + * @fotg210: pointer to a private fotg210 object
> >   * @enable: true to enable VBUS, false to disable VBUS
> >   */
> >  void fotg210_vbus(struct fotg210 *fotg, bool enable)
> 
> I don't think you actually built the documentation after this patch :(

Yeah, it slips over my fingers, sorry. I will try again.

-- 
With Best Regards,
Andy Shevchenko



