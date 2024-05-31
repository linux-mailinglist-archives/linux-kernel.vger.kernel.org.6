Return-Path: <linux-kernel+bounces-197028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2ED08D652D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 17:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 301751C23E68
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C545374BE4;
	Fri, 31 May 2024 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WF34Tse6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB36A7483
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717168121; cv=none; b=TgidMjBsCV/1LwsYC/iUNp5yhdFUEunhNsdJw0pd9DYI8eBG9bHlQMA3iyFhpvrgLKw2fW+dTIOdnZVsIpA0L176NQf7fi46XTmblBfFNFqQaBWqespZGy67iaOkUGrcPS6K940kYE0NQxWS9A31idAZQnfLux37Hp4P56jk85U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717168121; c=relaxed/simple;
	bh=HSwJT7e7LZkft2xg3k1dYrfRx/d2rdv7pyi/sG/FWc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIiWYCjiTWNjXa3nEW3tspzC1u+WuKb7ED9qMSB+rCXrjC/fZCiRR407v+bkfmYw6VjSG1S4xqBdnP4/OBNWztYOJvGaAjtA+klIZexroK51PczL5rnD0VFbfpMF1wTTWaSNIPe7zcVFXt5GLbCKtvHTIxybobaZN9UrMATRj14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WF34Tse6; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717168119; x=1748704119;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HSwJT7e7LZkft2xg3k1dYrfRx/d2rdv7pyi/sG/FWc0=;
  b=WF34Tse6E7MZxk5cBTkT0lI0136ra3ImDk8gJbGif7ay4S7eTvEwQHMu
   y6hlmTK+bG3nz9gVHEcVSkFwbjhgHu7gte8uLP/BXlsZjuvRsbISiwaS2
   0ziY7/3aXeYyhbiyANL4+WjiqazNa8iIg2Oyr5fRfG0qbnWkT5nCpoQIR
   OjKr47+XZqaVhSHXjDVHaQmgBqJxUJX7hCrl9aealZCbxDfRnfzzNSOr1
   OSv66JBB+26VYYffW2NsFTeTdnXThRtbaM7tYl6ZETxWL5sO87H8duQNU
   UHaNqWydyQ5liuqWWyfeNp7ML+FDF7f+/LRkm6h+BQeeaADcYUQJSy5En
   g==;
X-CSE-ConnectionGUID: STpFZiMJTeW3P9CiIPWMvQ==
X-CSE-MsgGUID: VN30nbgQR3erE6huW4Gp4A==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24837310"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="24837310"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 08:08:39 -0700
X-CSE-ConnectionGUID: vmhnK+isRrmlKRkVQk5Ceg==
X-CSE-MsgGUID: dYKVAP75Qaqswh4ESQU+PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="36806647"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 08:08:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sD3rv-0000000CV6I-2HVJ;
	Fri, 31 May 2024 18:08:35 +0300
Date: Fri, 31 May 2024 18:08:35 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/2] mfd: lm3533: Hide legacy platform data in the
 driver
Message-ID: <Zlnn89KPSHSCp3Bh@smile.fi.intel.com>
References: <20240508104848.846580-1-andriy.shevchenko@linux.intel.com>
 <20240508104848.846580-2-andriy.shevchenko@linux.intel.com>
 <20240531150048.GO1005600@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531150048.GO1005600@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 31, 2024 at 04:00:48PM +0100, Lee Jones wrote:
> On Wed, 08 May 2024, Andy Shevchenko wrote:
> 
> > First of all, there is no user for the platform data in the kernel.
> > Second, it needs a lot of updates to follow the modern standards
> > of the kernel, including proper Device Tree bindings and device
> > property handling.
> > 
> > For now, just hide the legacy platform data in the driver's code.
> 
> Why not just rip it out entirely?

You mean the driver?

-- 
With Best Regards,
Andy Shevchenko



