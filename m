Return-Path: <linux-kernel+bounces-306926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F26CC964592
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9752C1F2999C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2038C1991B5;
	Thu, 29 Aug 2024 12:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d3RlyJMb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3E915E5C0
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 12:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724936064; cv=none; b=SOJhgPrPOXc+/H1ozr+p697VYeuIpTmnkGyppWMS9mML4tgA5rL24L325+t4uKOMFH6K8S/YqaKG1MeABM+31ewI1eNl/CgWQzitzhPhineP24qSCvtRUokYnWSFORRsiPtd5g5bSIk6Zu3Pg71Y9ZbNNQBwQopeNMDRgsatF6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724936064; c=relaxed/simple;
	bh=l4RDSamBtj1+Itgqz3D8woWD9RjtJlf8HTC19vB/Lek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2SqFV+Lh5POS46WyvbYAGJwnFGP+HpyTTHgPynphckPgBp9WDJuFLSkGYKSOoVy64o8L9RjUhqBgnQGb5TlPNgRc5ynLAQKorfb4SDyhckte881jeMA4QTjWoWyDfbAZ+0EkHoBESpaegT+SIFAtVvSfAm1wEymdJiXb/tlBPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d3RlyJMb; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724936064; x=1756472064;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l4RDSamBtj1+Itgqz3D8woWD9RjtJlf8HTC19vB/Lek=;
  b=d3RlyJMbnKW/wyjb3emAmsZgytu5Rcmi6nzKNDXz2z+2lGf0Vmzbb9oJ
   vRK5oT6gkOh/R9DTYTPad8vcn1r4zPREQ2WLv0g0mfey6Ubfj+whg2owJ
   q0AGenCd7lFUAvp7TypXpV+q7uJN10nMmjczZr2d7Kbv6slTdjG9EV3dZ
   N/BD05BcaQ/LOinHmWKalnqpgbiI6V87kalvfbu2/iZ+yl9lPkVYxoCKL
   BrSFFH0IV7kJRenS/sxOkdRQqg9SXny2EsojkifuYdqHSIjGaGnGOwohr
   XhMoOg9QchUe+NBogBNYSoCQKJYnSvp5ymSBeMaCCiPr7pu/bb+S2xslb
   w==;
X-CSE-ConnectionGUID: 9gSh9eTlRBSN1TpT+6PrCg==
X-CSE-MsgGUID: T0X1cOd5TAa6FPY5FDosMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23653786"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="23653786"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 05:54:23 -0700
X-CSE-ConnectionGUID: rbI8Exn/TdGCaqdYM2y6oQ==
X-CSE-MsgGUID: 8v/Ryq9ZQZugrIr92sSVSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="68457480"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 05:54:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sjefK-00000003014-2pxU;
	Thu, 29 Aug 2024 15:54:18 +0300
Date: Thu, 29 Aug 2024 15:54:18 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 00/10] regulator: kerneldoc section fixes
Message-ID: <ZtBvepC8yjNtY0g-@smile.fi.intel.com>
References: <20240829085131.1361701-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829085131.1361701-1-wenst@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Aug 29, 2024 at 04:51:20PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> This is v2 of my regulator kerneldoc fixes series. The series sort of
> came as a request from Andy to not move code that already had warnings
> without fixing said warnings. So here I'm fixing them first.

> The bulk of the fixes are in the regulator core and OF code, but I also
> fixed up a few bits in common code that were missing "Return" sections.
> There's also a final patch to align terminology around "negative error
> number" within the regulator subsystem. These are purely kerneldoc and
> comment fixes and don't touch any actual code. I left the devres code
> and helpers alone for now.

> The patch series is based on next-20240829.

Instead of or in addition to this, please use --base parameter when formatting
patch series.

> Please merge if possible.
> I will rebase my I2C OF component prober series [1] on top of them.

Briefly looked again and all seems all right with some nit-picks, that I have
already sent individually.

Since Mark acknowledged English, I believe it's fine to go.

Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



