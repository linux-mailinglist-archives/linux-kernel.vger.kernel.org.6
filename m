Return-Path: <linux-kernel+bounces-299095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4703795D015
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0492DB2A06E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 14:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4991991AC;
	Fri, 23 Aug 2024 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cRoM0eyq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65145188937;
	Fri, 23 Aug 2024 14:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724423068; cv=none; b=jbC/P0screEKs15J/CDY3cQsS1FVhK/u53Chd73rqtM0d/buNTa1u3Jq6lqQxGXgVXxaCTzKp/BeUiyPOuG2y268dd9UevuN1XFoGcOhprl7Hpquci6Hj6Afzm7janVDxkrrdNXnP8+n1ujurYYwSbqCfZCOti+Xv8zNavvgnSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724423068; c=relaxed/simple;
	bh=vwghNAchrEC2r0wG0GawuHbrPuP/OZEDrYilXmYG7UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQSpfxV1XQ/G2Jwyt7A1k64pBV+j26GzSgkEHY5AEZod+WltUIXlACuGfp73yHl0v5y75uN9fM+IvHQt9vmTcQfO2rACnYcsyKA1bevlOmleGGwu5zjtr1ViGIiirv+0X8/SuVDBmJOGeSQwTAbDUM3Kk+084WfPN3wBKWWGcsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cRoM0eyq; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724423067; x=1755959067;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vwghNAchrEC2r0wG0GawuHbrPuP/OZEDrYilXmYG7UY=;
  b=cRoM0eyqVcOMLJFXsS21gNSgDPeGDHU8JdtrH28aMLtdoN7lNL0cDanh
   rPniOXc5PDdr3KhvbxQ40VCcPvLAIi5nS/sSuGECA7gJ0GODR7m2JlgCr
   iy2nKNgUCTNQj2M8m9hWmu/j5x4EmoyUhYRDaSRifkxgTqa2WPF9AFciJ
   +IdOZxthJLZKMszt3mBsvSGTpbBCwhDmJazFn2nIRk8mmmk1UAIaSYr8j
   GzFiZyKZ/tQ+DkjMzA4zOiZ8OTXP7oU60xG8bHCAVlXVHMcNJn9AS6JdE
   GSdwjPP3hAsRaP4hiFRjZEtkZexi7EgEUEyfyXwo51KWP15am4w+shxCG
   w==;
X-CSE-ConnectionGUID: yy8VfHXxTvOLWIvFYRLZXA==
X-CSE-MsgGUID: U2tbvM7TQWiuhSVvq2gqog==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="34309184"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="34309184"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 07:24:27 -0700
X-CSE-ConnectionGUID: C1dZ5DV3SLaGHKoI9IJIaQ==
X-CSE-MsgGUID: z+hcqswCTgWpo9fvVMnQGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="61810721"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 07:24:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1shVDA-00000000opy-3xIt;
	Fri, 23 Aug 2024 17:24:20 +0300
Date: Fri, 23 Aug 2024 17:24:20 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: subramanian.mohan@intel.com
Cc: gregkh@linuxfoundation.org, tglx@linutronix.de, giometti@enneenne.com,
	corbet@lwn.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, eddie.dong@intel.com,
	christopher.s.hall@intel.com, pandith.n@intel.com,
	thejesh.reddy.t.r@intel.com, david.zage@intel.com,
	srinivasan.chinnadurai@intel.com
Subject: Re: [PATCH v12 3/3] ABI: pps: Add ABI documentation for Intel TIO
Message-ID: <ZsiblBUJ08PwustJ@smile.fi.intel.com>
References: <20240823070109.27815-1-subramanian.mohan@intel.com>
 <20240823070109.27815-4-subramanian.mohan@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823070109.27815-4-subramanian.mohan@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Aug 23, 2024 at 12:31:08PM +0530, subramanian.mohan@intel.com wrote:
> From: Subramanian Mohan <subramanian.mohan@intel.com>
> 
> Document sysfs interface for Intel Timed I/O PPS driver.

...

> +Contact:	Christopher Hall <christopher.s.hall@intel.com>
> +		Subramanian Mohan<subramanian.mohan@intel.com>

Missing space. This seems like a warrant for v13, but again, let's wait a bit
for others to comment.

-- 
With Best Regards,
Andy Shevchenko



