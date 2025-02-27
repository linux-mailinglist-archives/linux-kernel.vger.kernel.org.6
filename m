Return-Path: <linux-kernel+bounces-535608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D72A47512
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 06:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9B931887E80
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A7B1E8357;
	Thu, 27 Feb 2025 05:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OholmMlP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB6E1E833A
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 05:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740633223; cv=none; b=AH4Bv5RSXjtfZk16wJq+e1HO5jopRw3lchoLyNH9mBQM+tnJfPE7kot86A+O1ey0AjzhRFlTh2g6lqjT7yFokB62Mm3jT8JPjHJv+102kcIPHzavsO9AvorBhHPy/bGK+lRpJUBzmgRwL5Lpmx+Oc9GR1cAouuyqRxCSf+0c9L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740633223; c=relaxed/simple;
	bh=vvCV22so1Msx3O2wDekgW5ZeubkEpJeKdX6RQLEw3ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRfuK4V8vNJaBJZch9fUjE+JlnSe1v2ZAR9E4CRaOyWr9V6kNsE0fI7wHMoUazJK8OLvwy2GGyarq1y/HUj7hWCA+L4sWtWJDT7B5J6llikPYaSdkyToy55JZ6NecWK+jrcrEbKiDJWFhAyCpyLRHxYrBJ4LVaVcATVxQPCxxTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OholmMlP; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740633223; x=1772169223;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vvCV22so1Msx3O2wDekgW5ZeubkEpJeKdX6RQLEw3ls=;
  b=OholmMlPH9GTuq9iusNS2+kOJLKvfBcUzc6+moKkJKNN+/E6qOCW7Nto
   Mpp/xacsEEY24hC/mT8JVkb0tSdnELfG7II2DvtyGGn1L7Lui9ErYxAHF
   MLS85wEeg3cfidvk4jXBWDufNrUGKVAjtqa+YUt3U/LL43Z/C+D6vi00G
   dzwtDkuF4krwN4r8+Ew17hiVqYaxJVc0Wx0cHFvICXxbvKssAm3DRR0jL
   DBWHL2ZAQNjPXwx9QcpCT0xu6xinuvdx2enL0ZCR6gm99XVwJNYyoE8bF
   luQcMVUQ9Ls6NAba8cWjT1H+Ctikyo8sKVEX6mX213/LSVybCky34xx1U
   g==;
X-CSE-ConnectionGUID: H40WHVsuSSeVo6VKXgU29A==
X-CSE-MsgGUID: IGS1ud9AQxitjqUI5o5tgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="51717152"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="51717152"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 21:13:42 -0800
X-CSE-ConnectionGUID: Sf1gvKgHTPWja6E9c3QZvw==
X-CSE-MsgGUID: r36inP5ISUuS8RMFxi4iig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="121928449"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 21:13:40 -0800
Date: Thu, 27 Feb 2025 07:13:36 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: lee@kernel.org, giometti@enneenne.com, gregkh@linuxfoundation.org,
	raymond.tan@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] mfd: intel-ehl: Introduce Intel Elkhart Lake PSE
 GPIO and TIO
Message-ID: <Z7_0gJJL_h6lq4cz@black.fi.intel.com>
References: <20250226061527.3031250-1-raag.jadav@intel.com>
 <20250226061527.3031250-5-raag.jadav@intel.com>
 <Z78VIjgkzf_GlauU@smile.fi.intel.com>
 <Z78VkEnJh8l9MWF7@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z78VkEnJh8l9MWF7@smile.fi.intel.com>

On Wed, Feb 26, 2025 at 03:22:24PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 26, 2025 at 03:20:35PM +0200, Andy Shevchenko wrote:
> > On Wed, Feb 26, 2025 at 11:45:27AM +0530, Raag Jadav wrote:
> 
> ...
> 
> > > +++ b/drivers/mfd/intel-ehl-gpio.c
> > 
> > We are usually align the file name and Kconfig option, and I like Kconfig
> > choice, so intel_ehl_pse_gpio.c (also note the style with other intel_$SOC_*
> > files in the folder.

More than 3 words is a bit of an overstretch, no?

> And also Subject, you have currently 3 different names for the same:
> Kconfig, Subject, filename.

Yeah just trying to dial down the acronym syndrome, you know how it has
plagued our minds.

Raag

