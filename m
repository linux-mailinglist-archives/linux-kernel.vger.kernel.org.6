Return-Path: <linux-kernel+bounces-412883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 922589D1093
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 280F7B22FAC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C23199381;
	Mon, 18 Nov 2024 12:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UiABuY1n"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A98C190665
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 12:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731933178; cv=none; b=RBLZkN6irANcDIvMSW/YDThcyfYVc+xuwUJzvI9Yh0eEZLJcwYCnijmc7GhUFxY8LyMwzTMx9Nyp0VXOz9sEfJeDAVL6EMG8xtWtJB4V59s3hagEjGDarJqavQVV6FlyDSelXChVK2RkieeFPDY27IjiLGpJaabnJAZ4ZrV2ung=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731933178; c=relaxed/simple;
	bh=jIaEOjK0mS7sbPkYVSxnP3VGbdEHlavlnKhav5Y1SV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcPkEpg9HC2ebCM4Mah7YCGCMy/ttGbRYSlPeZz++h+BzYEcr4Hjaadf3B9/Shmo5gi5XcipBaeoF4zJnbvxM9LLfu7P6qzPdXn3irw+jGgAzX94+0QsHj3y+2hQur7b275Hi8lUnCQZByvd4Rl3MQvwHXzg+itDHu2SbRwQnzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UiABuY1n; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731933176; x=1763469176;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jIaEOjK0mS7sbPkYVSxnP3VGbdEHlavlnKhav5Y1SV8=;
  b=UiABuY1ncNhSEbFiNUdEKJBVTr+l4cVJk/HJC8TxDjmgCG5oVprcpHPR
   biLLbvD9yQbV/Jtfpu2oaPgaxQWKmIPMCY1yEX0mZRj5G+N/FpYQkYGq7
   ZeUIkHnLdkAprr7SpUyisfIPqLxtYiiMGEFnYl8H1np/wEno4cyfjoDCa
   ewWxauUAvxdmcaKDIJXktXYo57NMRw3lunjQfbGVj//4xDvg/vvWr6/fs
   gI8CsnuMmuz+wwxgguQvEq8H0cz/q2in6xsTSZntO21zxY4b5MOtTPorO
   HT+zehfQ0vSDYGEKYMkMPhyozfrxdBgXGd1Qn/43GKoB7tfb0nureKq2c
   w==;
X-CSE-ConnectionGUID: mVAwRUghSRmrmUTgv1LSMw==
X-CSE-MsgGUID: DbowVU9GSMWZkn9xkGdC2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="32037880"
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="32037880"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 04:32:56 -0800
X-CSE-ConnectionGUID: 1qjbz5mMQamSG6XBdojX1w==
X-CSE-MsgGUID: YKPyKPjFSOKMkok5yEjWPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="94266911"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 04:32:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tD0vz-0000000G0Bj-1X7S;
	Mon, 18 Nov 2024 14:32:51 +0200
Date: Mon, 18 Nov 2024 14:32:51 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: Re: [PATCH v1 1/1] powerpc/8xx: Drop legacy-of-mm-gpiochip.h header
Message-ID: <Zzsz81-quzIZ_13L@smile.fi.intel.com>
References: <20241115133802.3919003-1-andriy.shevchenko@linux.intel.com>
 <5b44abcc-f629-4250-9edf-7f173b78172c@csgroup.eu>
 <ZzsG9EjzV82Crl2W@smile.fi.intel.com>
 <124ab5ab-3bfd-4ad7-a75d-981da9c03423@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <124ab5ab-3bfd-4ad7-a75d-981da9c03423@csgroup.eu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Nov 18, 2024 at 12:02:44PM +0100, Christophe Leroy wrote:
> Le 18/11/2024 à 10:20, Andy Shevchenko a écrit :
> > On Sat, Nov 16, 2024 at 11:44:35AM +0100, Christophe Leroy wrote:
> > > Le 15/11/2024 à 14:38, Andy Shevchenko a écrit :
> > > > Remove legacy-of-mm-gpiochip.h header file, replace of_* functions
> > > > and structs with appropriate alternatives.
> > > 
> > > Looks like you don't really have an alternative to
> > > of_mm_gpiochip_add_data(), you are replacing one single line by 11 new ones,
> > > and that is done twice (once for cpm1_gpiochip_add16(), once for
> > > cpm1_gpiochip_add32()).

Note, the overall statistics is +1 LoC only!

> > True, but that's the issue that we have of_specific API. If someone propose
> > the common API for the agnostic approach,  it would be nice, but I am not
> > the one. And TBH I do not see the advantage of it right now as almost every
> > GPIO driver is using its own labeling schema (*). Note, that this patch also
> > fixes a memory leak as a side effect.
> 
> Can you explain that in the commit message instead of saying you use
> appropriate alternatives that do not exist ?
> 
> Don't hesitate to mention the memory leak it in the commit message as well.
> 
> > *) the legacy API is mostly used by PPC code, do you want that of_mm_* thingy
> > to be moved to PPC specific code instead of killing it? Would be done this
> > way as well.
> 
> No no, your change is ok for me, just need an accurate commit message.

Fine, just sent a v2, which is now compile-tested as suggested below.

...

> > > Does not build:
> > 
> > Crap, I most likely built something else and not these files...
> > I have carefully build-test this for v2.
> 
> Just use mpc885_ads_defconfig

Thanks, that is helpful!

-- 
With Best Regards,
Andy Shevchenko



