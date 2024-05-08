Return-Path: <linux-kernel+bounces-173674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 385B08C03CD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69F2D1C21CC0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522E512B163;
	Wed,  8 May 2024 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wd7OCTgh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA4812B14B
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 17:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715190825; cv=none; b=bWHZfTFdAdIz+0ERHsWnpIRqFmoNC56ZbVkSI+c/opypCKnVAC246J2Cek9MLVt4BF/Guv2/UxOReRezaOpc9ACROYd3/8O7SXnKRhTg64nNIJWFPchWq7UVz1Wp4mIhU92n5RAFbtf+u+V9KLCh4PgNdV0voDPsNJwCLRtHN9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715190825; c=relaxed/simple;
	bh=da7eBN+RCnZYS2bJ+PqxlbsRBwzsYBthm4w6NriSzsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dO0rO1/w3gWHCG72MfF4nlPnMvSKrMFUWFE8b55py9BAERgteRxzbNA3L99iz3j0+LMAoqizcAHR/9sl1JnNv44ha+kBTzkW9PfMKWFHhvilKuDr5BZuQDz1GXVblekYt4Ei4DvjKD+5G7ndAb8Z3c5x33TnsQVyZWTqNyuD2ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wd7OCTgh; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715190825; x=1746726825;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=da7eBN+RCnZYS2bJ+PqxlbsRBwzsYBthm4w6NriSzsM=;
  b=Wd7OCTghlr5AlgFHZw+JJC1Znh3ZW9IHaK4jsRd3ZHEh1inV/rDuDVJg
   KG/B/8AubNiwOVLuyMFxkYzQZkN5wIjiacDccFtZXL/QGhdeLsc/uRVSP
   yYYoGhsdBVwUjJKQnm+EnwQkVLUbAhnCZ/zv01LhkfsnOepGNOuZQhflA
   B/EMbzmc08n9C3XSqWtHXC74bLosIrXWJi5zCsG6vqvS0ag9sw6+75uvz
   MK4y5QSoBFUcuk47z8GADMxUQU2Df0rzeWHvDZAI50/WBoc4i6on1vUTb
   xQebdsSGpnx8WXDlej59kCf3HVqKScU5JdKGH07gj9PHB34u9m3jLQ+70
   w==;
X-CSE-ConnectionGUID: Tmqxpk6cSY23CvHCy52DIQ==
X-CSE-MsgGUID: S0KYD0KiS+GCOAd7KPZs8g==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="22224102"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="22224102"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 10:53:44 -0700
X-CSE-ConnectionGUID: 9Bra/CBrRnqTGHL0eAcyFA==
X-CSE-MsgGUID: FeVJ71DUSVuEx93t50Wyfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28909170"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 10:53:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1s4lTy-00000005Wu3-46qY;
	Wed, 08 May 2024 20:53:34 +0300
Date: Wed, 8 May 2024 20:53:34 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH 2/2] eeprom: 93xx46: drop unneeded MODULE_ALIAS
Message-ID: <Zju8HpBCiOjjIZ1j@smile.fi.intel.com>
References: <20240414154957.127113-1-krzk@kernel.org>
 <20240414154957.127113-3-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414154957.127113-3-krzk@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Apr 14, 2024 at 05:49:57PM +0200, Krzysztof Kozlowski wrote:
> The ID table already has respective entry and MODULE_DEVICE_TABLE and
> creates proper alias for SPI driver.  Having another MODULE_ALIAS causes
> the alias to be duplicated.

..

>  MODULE_ALIAS("spi:93xx46");

I was stumbled over this (leftover?).
Commit message doesn't elaborate this bit.
Any comments?

> -MODULE_ALIAS("spi:eeprom-93xx46");
> -MODULE_ALIAS("spi:93lc46b");

-- 
With Best Regards,
Andy Shevchenko



