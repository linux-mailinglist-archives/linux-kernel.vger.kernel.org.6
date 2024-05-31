Return-Path: <linux-kernel+bounces-197172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 305B98D670A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62B1F1C22DF7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD19415D5AA;
	Fri, 31 May 2024 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kSq76kXH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB99612EB
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717173659; cv=none; b=PMdr4V5UBkhzhqTrFkFPADJw4ughQUsJARlL2iWiLXvIDAvYT5HoPHaNOdkUID2g1vk1xnQJeoZ3pvSGgyF8QR/WSe0dRiabeJR0jZYC5yh+VoXWcOMGDgBZw3gI6eaLg+fesAvp+FECcIsRPgEcOqT+gMFwhLuN2qWXccE/ycw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717173659; c=relaxed/simple;
	bh=F1ZcRDTVT6Oo2uPruzo0m8jzfugD+UyP8c09acgpfPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APl82SPdjFwVaEwhXww6B8Mc8zGVqFk5QO6syW7FDbeFrajd4qgDrAdsvgjtzFw4ObiTZEM3KPhkH0CyDTOdkjFYvN/alliO+D8PAdppuR0VDKxBkaESN7lNQWzLECL1Hf8UgMFPOiUrrGtErpFk+lfwNRVlc9t7TSYGWDpyRxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kSq76kXH; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717173658; x=1748709658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F1ZcRDTVT6Oo2uPruzo0m8jzfugD+UyP8c09acgpfPY=;
  b=kSq76kXHY+ej5piipH2MCZ4iBLQXdmbXFU1yskRL25nP+brFwK0jYron
   OHdhzLqqq3ovXsILgLiPIt9TuX9fKM5FH0r8YcvlaIxb+T8f6OVm0kG8p
   aEXVzDsX5zoKh1Gbij7gNa5ZuWUCM1dAuLCVHaHdlwSUfUJ73NxmQ5+iw
   z7/8gZzzHuTSwJE34sTZGh8M2edI2AkoFEWIELE9GV/uEwLT4E/zYxwUh
   HEmb1yULyZ5E5N5Hjh8T6xJFEd6GhNmmHRJs1dp31/k6WVGJHIoZOzO7U
   Mo9CWrle887YdAlRD6QoFTJQ8/y70SHToPzUqnE7cUTo+uMeUa25z4yQ7
   A==;
X-CSE-ConnectionGUID: UcYM4goySs+1YGdguce2JA==
X-CSE-MsgGUID: jM47t74LTJSZGMm847jhDg==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="17555647"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="17555647"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 09:40:57 -0700
X-CSE-ConnectionGUID: fPR0vg/1Tp+8B9TsRZbLNg==
X-CSE-MsgGUID: 2g1ga4BVTP+pW4ghmfdBJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="41134538"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 09:40:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sD5JF-0000000CWSe-3Plv;
	Fri, 31 May 2024 19:40:53 +0300
Date: Fri, 31 May 2024 19:40:53 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/2] mfd: lm3533: Hide legacy platform data in the
 driver
Message-ID: <Zln9lRvKJYwlSM3l@smile.fi.intel.com>
References: <20240508104848.846580-1-andriy.shevchenko@linux.intel.com>
 <20240508104848.846580-2-andriy.shevchenko@linux.intel.com>
 <20240531150048.GO1005600@google.com>
 <Zlnn89KPSHSCp3Bh@smile.fi.intel.com>
 <20240531155445.GS1005600@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531155445.GS1005600@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 31, 2024 at 04:54:45PM +0100, Lee Jones wrote:
> On Fri, 31 May 2024, Andy Shevchenko wrote:
> > On Fri, May 31, 2024 at 04:00:48PM +0100, Lee Jones wrote:
> > > On Wed, 08 May 2024, Andy Shevchenko wrote:
> > > 
> > > > First of all, there is no user for the platform data in the kernel.
> > > > Second, it needs a lot of updates to follow the modern standards
> > > > of the kernel, including proper Device Tree bindings and device
> > > > property handling.
> > > > 
> > > > For now, just hide the legacy platform data in the driver's code.
> > > 
> > > Why not just rip it out entirely?
> > 
> > You mean the driver?
> 
> The unused platform data.

Good question. In any case these drivers are non-functional anyway without OOT
board code. If we rip out the main platform data completely, the logical following
question arises: why do we need the per-device platform data? If we rip that out,
we basically make non-functional driver a 100% dead code. Hence what you propose
mostly equals to ripping out the drivers completely.

TL;DR: with the main platform data being ripped out the driver code will be in
inconsistent state.

-- 
With Best Regards,
Andy Shevchenko



