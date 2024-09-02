Return-Path: <linux-kernel+bounces-311065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D274968478
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D78E91F21D8C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0B113D881;
	Mon,  2 Sep 2024 10:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e8guYUIn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5293713B284;
	Mon,  2 Sep 2024 10:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725272352; cv=none; b=trNUbUafdZuYkgINJEaivoTgxx+rraRJlfA97tAoQs0P4j0s5ww3Umd1OrGOZ8+msPkkeIA9Ktlu4sF2T5wH5E/5oxCXW3Soq2TXtu42bepoMbgu2QDM+wjFd7YItcU8wwK1OWbU0HT3hbm9eUWJbvoytBd4qhvXOVgMNsY8BFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725272352; c=relaxed/simple;
	bh=NGkgT9iAC3JSZzqhTF0bmbuB4C+mzkBbp0PHCab20Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJyq/LyCr/9J3UUVvqvl6clOFTSWH+1QUE2ElzrFqIegjaeTfpdl2xaet13xwVL31dKLQ1Z5GrE1sHZIlE4bxH78/8a9g9B6e+bDS7LGD3h2ltkNuEF+nYCrIhnXdkiNTUCrAEtQmGaJKDgSHrTRwKn1NPGcfAaoLI4KwDtGLEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e8guYUIn; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725272352; x=1756808352;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NGkgT9iAC3JSZzqhTF0bmbuB4C+mzkBbp0PHCab20Ho=;
  b=e8guYUIncZFcayo8PLfhu0yXbJGr7h65+DjGqy5WLL8iKxP23BLxlWIi
   itARzHOuYFUCI53PigrTyj7UPf63SHqiltJzPY1Faa6s37EiEtr2Eqds5
   TtulQSYO24aHF8giU8P4/00cW77mJtez31m+RrjieZB0g5Iya+4MRMGpI
   qDXWOeuO3QS6RA0b3s8znM0X36BfJ01CGsTni/+SNAurlk2LIQ0YZgwJg
   MpA3R7HryZVw/343m9UeMXz4uymZ18K7EyNF5xIGKW5t5ZCQ7X7gpaDR2
   LMyefC/Q48C1KFpIazJ584yTvm0TNUQN2vIsf+KCHmu8Q97oRhaDPxO/q
   A==;
X-CSE-ConnectionGUID: AXoVV42SSoKHk2yvUs72Tg==
X-CSE-MsgGUID: lGj5PFahR8WMsC7qUgMtrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="34412730"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="34412730"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 03:19:11 -0700
X-CSE-ConnectionGUID: P9gMKnGpTcWtfb70K6cfOA==
X-CSE-MsgGUID: nA2CLyYMS0Sygclm9Hvd2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="69188555"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 03:19:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sl49K-00000004JgD-2JNj;
	Mon, 02 Sep 2024 13:19:06 +0300
Date: Mon, 2 Sep 2024 13:19:06 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>
Subject: Re: [PATCH v2 0/4] platform/x86: int3472: A few cleanups
Message-ID: <ZtWRGgb-ZsLp25np@smile.fi.intel.com>
References: <20240822130722.1261891-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822130722.1261891-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Aug 22, 2024 at 04:05:37PM +0300, Andy Shevchenko wrote:
> A few cleanups to the driver. It includes an amendment to
> dev_err_probe() to ignore 0 error code. The patches 1 and 2 are
> dependent, while patches 2 and 3 may be applied in any order.
> 
> Assumed to go via PDx86 tree if no objections to the code.

Ilpo, Hans, the patches 3 and 4 are independent from 1&2 and may be applied
separately, if you have no objections.

-- 
With Best Regards,
Andy Shevchenko



