Return-Path: <linux-kernel+bounces-202191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 181418FC8E7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 12:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85670283013
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C12190490;
	Wed,  5 Jun 2024 10:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LourmeAb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060B31946D2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 10:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717583097; cv=none; b=NxeCBkQSoETYbN1QAHXQTTwGqa6Yrs/9CeSsOR7Vv/O6cbTDcQoBjiNEpZlvXJsoS7Zf8qZhyrJBuVZC9vU2Y4fOtJFbyfXG2IQW/lwHBQPXbhJnHXMwhleG2dajUxW3uP7x407/7TxJOFPnGWCfVL+vZQu4c8DCC12snKdQfYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717583097; c=relaxed/simple;
	bh=V5Vce6aPe2R4eGnAe8zIDJ2hB3Yq22pRZtmZz6caqQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exNCXZf4dOPZhVFfYtRw0Ygx+vfe3BbXMfvGwee8Q+hv1g+pEK3Ops0NCSDRNDf3zMxPdRuPUDSzGPT43os0RCpyND0vcVqRXt8WMHD2sK3j4RAHTIGNSwoNHWN7kYo8jSWgJY4fu34Je98fCH6KuvuVelu8SbEKnBGXfMmBUcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LourmeAb; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717583096; x=1749119096;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V5Vce6aPe2R4eGnAe8zIDJ2hB3Yq22pRZtmZz6caqQ4=;
  b=LourmeAbj4eJ163zWXvjBob/AQGl4nbzd9EdUnWCNssiP/+W31g9Cs7V
   b3nqK2YCzjQvCM/fL2LC5mtaR+V4OsKTL0Iaw2Bp78I3h3qJZAGxnRFfa
   Yre5audc9dMbrTHntsvqbHjzWb61kZsCWciZ/2M4lr3gpnn/RYc/WOFAp
   ioNM7hXOCyqF2ZnOVDOZr76oQE8aGOERQSMlnrmCtT/STdE9gbF5pCZUo
   hiGMpkFTGOVBjewYwoWJ2J5q776CM0CakpcScknZn3/vVzgNIwxLgKmgv
   +kOqg6vkXe1l8qZb7FRG1HERYJDK8S3Xj7Sqh2LhLBTlXCWoxlM/YMRyh
   w==;
X-CSE-ConnectionGUID: hBmsBDAHTtaSKBWr9F90yQ==
X-CSE-MsgGUID: vZIyuYWESTapee7aDPoQng==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="14022388"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="14022388"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 03:24:55 -0700
X-CSE-ConnectionGUID: 7yZrZe7UR9y29FNt/A0DFg==
X-CSE-MsgGUID: deO/vcaBSBusDec4WXFrqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="37540817"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 03:24:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sEnp5-0000000DpNU-0CKg;
	Wed, 05 Jun 2024 13:24:51 +0300
Date: Wed, 5 Jun 2024 13:24:50 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chia-I Wu <olvaffe@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] resource: add a simple test for walk_iomem_res_desc()
Message-ID: <ZmA88rFW1ZxbgJSh@smile.fi.intel.com>
References: <20240604220128.682745-1-olvaffe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604220128.682745-1-olvaffe@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jun 04, 2024 at 03:01:14PM -0700, Chia-I Wu wrote:
> This mainly tests that find_next_iomem_res() does not miss resources.

...

It's better, but still hard to follow, see below what I meant

> +	res[0] = DEFINE_RES_NAMED(root.start, SZ_1K, "SYSRAM 1",
> +			IORESOURCE_SYSTEM_RAM);
> +	res[1] = DEFINE_RES_NAMED(root.start + SZ_1K, SZ_1K, "OTHER", 0);
> +
> +	res[2] = DEFINE_RES_NAMED(root.start + SZ_1K * 3, SZ_1K, "NESTED", 0);
> +	res[3] = DEFINE_RES_NAMED(root.start + SZ_1K * 3 + SZ_512, SZ_512,
> +			"SYSRAM 2", IORESOURCE_SYSTEM_RAM);
> +
> +	res[4] = DEFINE_RES_NAMED(root.start + SZ_1K * 4, SZ_1K, "SYSRAM 3",
> +			IORESOURCE_SYSTEM_RAM);

	res[0] = DEFINE_RES_NAMED(root.start + 0x0000, 0x0400, "SYSRAM 1",
				  IORESOURCE_SYSTEM_RAM);
	res[1] = DEFINE_RES_NAMED(root.start + 0x0400, 0x0400, "OTHER", 0);

	res[2] = DEFINE_RES_NAMED(root.start + 0x0c00, 0x0400, "NESTED", 0);
	res[3] = DEFINE_RES_NAMED(root.start + 0x0e00, 0x0200, "SYSRAM 2",
				  IORESOURCE_SYSTEM_RAM);

	res[4] = DEFINE_RES_NAMED(root.start + 0x1000, 0x0400, "SYSRAM 3",
				  IORESOURCE_SYSTEM_RAM);

Also pay attention to indentation.

-- 
With Best Regards,
Andy Shevchenko



