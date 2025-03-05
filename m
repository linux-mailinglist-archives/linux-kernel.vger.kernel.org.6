Return-Path: <linux-kernel+bounces-547173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC7EA503CE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 716613AE202
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7953224E014;
	Wed,  5 Mar 2025 15:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eafJyvhI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804162054FA
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741189835; cv=none; b=NV3Ae6PPnTxRgJT6ocmn9dyHppFFSqWM2ZjeNCrvX9PRDNJYBCL1G7zDhqcZ1FRzcgWDVd+6fWrRCX1coz/0Fb+hNAzz1iYgcw+uaPstDVyc9F6s9gDyWsZox7x07MqXxok+QTO+tpNtOToqJLQ53irXOccXfNqNP/3dZLKsanQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741189835; c=relaxed/simple;
	bh=KbfYNGaAmTO2nVM2SPkbDPg2fWB59a3naALF8YWvxrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/HcAU9yD9FKStMC51gWSc7aCbdDTIZ+h9cES8kliWZbcH/oAHPXEJJm0adWzz+enMUG4aC1C1b82Av1wX0+apaMy2nmnrOVpawFArPXfninouLPwIKitOSfiQKVeU05b97eq5zEBpllj4YGHULe1uLpHCMqB1l9X0IcBtB4ZQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eafJyvhI; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741189835; x=1772725835;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KbfYNGaAmTO2nVM2SPkbDPg2fWB59a3naALF8YWvxrQ=;
  b=eafJyvhIZXrqQ/qEHUOOw+aCCA+BpDILi4juGLfGKYe+9ckn2GLMOB2v
   GRVy45Ty9rHbXXr02WYygaLRe/lcJyJMSN3R+udYyLT5/fbKxMLSq+Yxw
   L7ScIvh0bfStzr5Ns4HPXBHwtDRGUj33BDYngFl+yLvAfHLC5xZ761xIV
   b7epo68wviAf1SZYV5qkR5rOwX/8bWz2AuPR8/5Pe7C67jRnwDVnXCAJC
   jIvdOIigfvaFD5nJr2QrjKRQg838lpujhOAetTYVh4syV9ULAFl1uIMYY
   C+8dXkXBxUG2kmqcgS9eWOujh/XhuJ+x0teSK/WOohCMKYky2yWVO5SLy
   g==;
X-CSE-ConnectionGUID: LtpQQ9fzRWuJJ6yyI69dAQ==
X-CSE-MsgGUID: lNRz5nXsRRuloZqOyIKanA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="45815544"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="45815544"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 07:50:27 -0800
X-CSE-ConnectionGUID: OiKFD55tSaiH3SnDUhnYgA==
X-CSE-MsgGUID: LJfdD3M5Tt6tJDJH2VcfkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="141967616"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 07:50:22 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tpr0k-0000000HSHY-3j1k;
	Wed, 05 Mar 2025 17:50:18 +0200
Date: Wed, 5 Mar 2025 17:50:18 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: mailhol.vincent@wanadoo.fr, Lucas De Marchi <lucas.demarchi@intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Andi Shyti <andi.shyti@linux.intel.com>,
	David Laight <David.Laight@aculab.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v4 3/8] bits: introduce fixed-type genmasks
Message-ID: <Z8hyui13BaeKrWCs@smile.fi.intel.com>
References: <20250305-fixed-type-genmasks-v4-0-1873dcdf6723@wanadoo.fr>
 <20250305-fixed-type-genmasks-v4-3-1873dcdf6723@wanadoo.fr>
 <Z8hsRJvpjYoqh9RG@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8hsRJvpjYoqh9RG@thinkpad>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 05, 2025 at 10:22:44AM -0500, Yury Norov wrote:
> + Anshuman Khandual <anshuman.khandual@arm.com>
> 
> Anshuman,
> 
> I merged your GENMASK_U128() because you said it's important for your
> projects, and that it will get used in the kernel soon.
> 
> Now it's in the kernel for more than 6 month, but no users were added.
> Can you clarify if you still need it, and if so why it's not used?
> 
> As you see, people add another fixed-types GENMASK() macros, and their
> implementation differ from GENMASK_U128().
> 
> My second concern is that __GENMASK_U128() is declared in uapi, while
> the general understanding for other fixed-type genmasks is that they
> are not exported to users. Do you need this macro to be exported to
> userspace? Can you show how and where it is used there?

FWIW, have you browsed via Debian source code browser? If you can't find it
there, you may remove from uAPI with a little chance of the ABI regression.

-- 
With Best Regards,
Andy Shevchenko



