Return-Path: <linux-kernel+bounces-183538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BC08C9A5B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1C431C215A8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 09:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3DD1F61C;
	Mon, 20 May 2024 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JMVxeqLr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9D81CA81
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 09:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716197389; cv=none; b=uJGoA8jCqNoLp2joa1yi5BJRavvg8vT7LTlz8y61dN6z0OhVCAJ+0EUnY5JTn/YDDNC2Vcugznl9TBsIW2yQeWkbEe66SRe+fcbQ2k4Inenk1Z9AnVltCgi0Uus9Y7Osi7SDKhs947SBh4QhyHMU7c+mxExgMegcUS+4pQNKpdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716197389; c=relaxed/simple;
	bh=Z6En2rQ56rYKGpCjhvIFLvYQgqhZLyaWZXFlrV2UYzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTGOxwQowd/AzBMY2l5Um6R8x/1Z48w+2jyhCnx4Ok5a2q7nM1q3l3rpFAoo9VJ+6E60G01iWcFHMIrgs+W0a65lhVssJPO6il1VF0sWc/sCyAUwN4Je8re9A0X99EJkGr3O6xnrcN87IlCsR61CVrV/Bgpg7QJNI3bGtQoZRc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JMVxeqLr; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716197387; x=1747733387;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z6En2rQ56rYKGpCjhvIFLvYQgqhZLyaWZXFlrV2UYzI=;
  b=JMVxeqLretVCxeLxGrELzRP0NeV4Jz8jxp6uWH9JM4F4+0HzBXiKbY32
   cTHcaeuKUp6s3f3GoFdKt7XasRfVzn8qE5Tk3inAfP4VqT16/hdsCjbIA
   V1DchWxDvLmPADtk7ufK4aBrYwUJdZHGF+1YyBuQqGsnI/VHfuasARF3F
   CmvTRZAWIadwtG1pSWUJd3ZaEijCihcENhY9hY7g7Eg3O/IcS/Nfq3edE
   aF9DzTwfX1x0O3hBCXsJlLJ3fBbWMCP8p+mHP1Ljw/ROvn1aOcDAcX9DA
   J6CPYXzpr4RsonjrcDBLHiCVf2cWG2H6vWdDRHCNh6ljYbgr8p3Zxqoh7
   Q==;
X-CSE-ConnectionGUID: SodvZXBNRIqVkznHzQJmSg==
X-CSE-MsgGUID: GPY1l5/ZQEeqpwkVaOqSvw==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="12255558"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="12255558"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 02:29:47 -0700
X-CSE-ConnectionGUID: usaW+o1zQ/muIcggFC+9Yg==
X-CSE-MsgGUID: lNzpnIzCR2iuKpS7LCl60A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="32495689"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 02:29:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s8zKv-00000009GKJ-0Cwl;
	Mon, 20 May 2024 12:29:41 +0300
Date: Mon, 20 May 2024 12:29:40 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: broonie@kernel.org, i-salazar@ti.com,
	pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, kevin-lu@ti.com, tiwai@suse.de,
	baojun.xu@ti.com, soyer@irl.hu, Baojun.Xu@fpt.com
Subject: Re: [PATCH v1] ASoC: tas2552: Add TX path for capturing AUDIO-OUT
 data
Message-ID: <ZksYBOk_gHprCd_x@smile.fi.intel.com>
References: <20240518033515.866-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240518033515.866-1-shenghao-ding@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, May 18, 2024 at 11:35:15AM +0800, Shenghao Ding wrote:
> TAS2552 is a Smartamp with I/V sense data, add TX path
> to support capturing I/V data.

..

>  /*
>   * tas2552.c - ALSA SoC Texas Instruments TAS2552 Mono Audio Amplifier
>   *
> - * Copyright (C) 2014 Texas Instruments Incorporated -  https://www.ti.com
> + * Copyright (C) 2014 - 2024 Texas Instruments Incorporated -
> + *	https://www.ti.com

Is it okay to wrap the (c) line? (Just asking.)

>   * Author: Dan Murphy <dmurphy@ti.com>
>   */

-- 
With Best Regards,
Andy Shevchenko



