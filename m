Return-Path: <linux-kernel+bounces-197227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5198D67CA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 19:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CAC91C26BF1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 17:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FFE17C7DE;
	Fri, 31 May 2024 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ncttfJ1Y"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88528172793
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 17:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717175397; cv=none; b=B5Gc5r9KWQra3ziFc6sAsugbZjabNuQ10BItDwo1v+yFw2pS9Io99TWVpasenlXcxtXD4XlKKGGkBO+mp92VgabaSZNgVYg7VEg2UyV7iKpUnFNS1ii2jwJ5C2UFOCXKRakwseUj58G0IhA1ZdwuYbfuzzmMfkqtsg7hcjL0Ud8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717175397; c=relaxed/simple;
	bh=illyVfqkMZ3RT7JchNe9HZ/6YD3Q7Pxu1jPdIzbxAuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLfl68V6INwNiEb9pRWj2z3JCJcftUV0+tg2hdXr2IFjZWb09Im2M67VzTFg3uUZcM6uaT/RBXLUbKh57vOlfh9A2HensJCUWt7TcodPDkYmon8Q4Lp2Zf6UVo70nVCb6hzaHT4kKDQOnZdcg1gMteMpknlV9enOyzOEs8cl+vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ncttfJ1Y; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717175397; x=1748711397;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=illyVfqkMZ3RT7JchNe9HZ/6YD3Q7Pxu1jPdIzbxAuc=;
  b=ncttfJ1YXfhoEbAX0q9OKi+h8t75rRLIpKFZoD5whm8oNbAjwczolWfo
   ig6VCg3JH7799ZkAlend+xF2QduV5JnBbdgh1SndRwypTxMNwksLE6mR0
   M3qTstL5y9ma3/RMWsQ6OHi2dly3VnQ/va6JQzTtwMNoEQ8wPOxPPDKab
   UKO9r9CWjjvTz3yYuIkd43kvJSb7a2Y4U+KklafwWD6eln41ZQOPHboR5
   ObXu3meP8hgKxvI5+Av8KgBY0Hl5kjpVoAglgdVNFzZKD1WXr8GXpFWFE
   Qoj4SDQ0+D9eGZr+7cqTPbrthkbQsoo8co/SrchqlK4fRHObEkQxej+l2
   A==;
X-CSE-ConnectionGUID: vyVVklWZT96OBC/UId2NnQ==
X-CSE-MsgGUID: 5qcnoNFoRr6c/lxMiPQ1AA==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="25132052"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="25132052"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 10:09:56 -0700
X-CSE-ConnectionGUID: 71jAqf05RxKcZZu8gKBJhg==
X-CSE-MsgGUID: MJ6V8kS/QTyholM+HXymkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="36148244"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 10:09:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sD5lI-0000000CWsR-2Ve8;
	Fri, 31 May 2024 20:09:52 +0300
Date: Fri, 31 May 2024 20:09:52 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee@kernel.org>
Cc: johan@kernel.org, linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/2] mfd: lm3533: Hide legacy platform data in the
 driver
Message-ID: <ZloEYAJ6W0SkBIIu@smile.fi.intel.com>
References: <20240508104848.846580-1-andriy.shevchenko@linux.intel.com>
 <20240508104848.846580-2-andriy.shevchenko@linux.intel.com>
 <20240531150048.GO1005600@google.com>
 <Zlnn89KPSHSCp3Bh@smile.fi.intel.com>
 <20240531155445.GS1005600@google.com>
 <Zln9lRvKJYwlSM3l@smile.fi.intel.com>
 <20240531165834.GA1204315@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531165834.GA1204315@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 31, 2024 at 05:58:34PM +0100, Lee Jones wrote:
> On Fri, 31 May 2024, Andy Shevchenko wrote:
> 
> > On Fri, May 31, 2024 at 04:54:45PM +0100, Lee Jones wrote:
> > > On Fri, 31 May 2024, Andy Shevchenko wrote:
> > > > On Fri, May 31, 2024 at 04:00:48PM +0100, Lee Jones wrote:
> > > > > On Wed, 08 May 2024, Andy Shevchenko wrote:
> > > > > 
> > > > > > First of all, there is no user for the platform data in the kernel.
> > > > > > Second, it needs a lot of updates to follow the modern standards
> > > > > > of the kernel, including proper Device Tree bindings and device
> > > > > > property handling.
> > > > > > 
> > > > > > For now, just hide the legacy platform data in the driver's code.
> > > > > 
> > > > > Why not just rip it out entirely?
> > > > 
> > > > You mean the driver?
> > > 
> > > The unused platform data.
> > 
> > Good question. In any case these drivers are non-functional anyway without OOT
> > board code. If we rip out the main platform data completely, the logical following
> > question arises: why do we need the per-device platform data? If we rip that out,
> > we basically make non-functional driver a 100% dead code. Hence what you propose
> > mostly equals to ripping out the drivers completely.
> > 
> > TL;DR: with the main platform data being ripped out the driver code will be in
> > inconsistent state.
> 
> What do you think Johan?  Do you see any reason to keep it around?

FWIW, I just have sent a removal. My main objective here is to get rid of
legacy GPIO APIs. Other than that I don't care if driver will stay or go.

-- 
With Best Regards,
Andy Shevchenko



