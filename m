Return-Path: <linux-kernel+bounces-547033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D23A501FA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E2297A1544
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62BA24633D;
	Wed,  5 Mar 2025 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hxQanYtC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9689120C497
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185018; cv=none; b=b1u1Hh3Y4aRrVyw3GOSOkAUf9b6oKv+4+vwUkv7f8QjNU+tLpbqYz0ZMdo8viYeFNzc5CG96LhyDmYDp1etxHsoZNIALuNqbiNY4VcW2DKnJCC3ympFImvSblruX57qaPYmdS7D+FsuGozzt5pmW5LOioA/RKuaKF5xZdb3mNuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185018; c=relaxed/simple;
	bh=CztryvVz724A/C9Jw9j1kRy7SYjxYHASl8pVk3UD3r4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4shhQOQbZ9hTkkg+APL6lsGnizcrwnkLn730lbB+ueKhdNw5133WliUuMzQWI027tUnTaHXe6Bi3nX8lUaNHlzAvO7UEZ+lknYk7ijYxIax5tk6sRPK4aN7HYHWMahSNRQzrzIs/fdPArhwLfgHFGGIwSk0Pz/k4o9fjaBNpRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hxQanYtC; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741185016; x=1772721016;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CztryvVz724A/C9Jw9j1kRy7SYjxYHASl8pVk3UD3r4=;
  b=hxQanYtCABl/BFzi/f9jc5czBEoBLLMYHDwLxN8g7sEXYDZI7H/JFRO4
   j210lUseii3GR9OX/gs72f3aZHdc4O7CLFFPkIF/blapmdxuy/5lmvuub
   CQS9HeEbA+vG/GIInodI1745P7ZQNDujX/H/93SfKFh/1MNq9/KgebxdT
   cLJvIdbOR9Nft5WTj1klK1izf3knsCfoiU2niuqW5ehTTA5UciytR+MA/
   LHAmo9iIWgvZ73LRetloq1ouPJ6zwiQSDFQrYR06ybA/PPbsZmG52TyZv
   DgX5Ak2uK597yUK9VqWP9m1lzGLxWuuFeuOsgMkDtbcuGi8fcZB7k5lOp
   Q==;
X-CSE-ConnectionGUID: bnD+ydx2T6iwF02z9/OQpA==
X-CSE-MsgGUID: iCMSrdVfSayiztr8/8JyuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42277938"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="42277938"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 06:30:14 -0800
X-CSE-ConnectionGUID: NtE6aXaWTTCzCINz83RB0g==
X-CSE-MsgGUID: RiH//TIOTqm2C+aBtY8FMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="119396347"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 06:30:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tppl8-0000000HR7Z-2G7H;
	Wed, 05 Mar 2025 16:30:06 +0200
Date: Wed, 5 Mar 2025 16:30:06 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: mailhol.vincent@wanadoo.fr
Cc: Yury Norov <yury.norov@gmail.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
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
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v4 3/8] bits: introduce fixed-type genmasks
Message-ID: <Z8hf7pN84-64LWPv@smile.fi.intel.com>
References: <20250305-fixed-type-genmasks-v4-0-1873dcdf6723@wanadoo.fr>
 <20250305-fixed-type-genmasks-v4-3-1873dcdf6723@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305-fixed-type-genmasks-v4-3-1873dcdf6723@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 05, 2025 at 10:00:15PM +0900, Vincent Mailhol via B4 Relay wrote:
> From: Yury Norov <yury.norov@gmail.com>
> 
> Add __GENMASK_t() which generalizes __GENMASK() to support different

Is it with double underscore? I do not see it.

_t is used for typedef simple types. It's unfortunate to have it
in such a macro. Perhaps T or TYPE will suffice. Or perhaps we want
__GENMASK_Uxx() here?

> types, and implement fixed-types versions of GENMASK() based on it.
> The fixed-type version allows more strict checks to the min/max values
> accepted, which is useful for defining registers like implemented by
> i915 and xe drivers with their REG_GENMASK*() macros.
> 
> The strict checks rely on shift-count-overflow compiler check to fail
> the build if a number outside of the range allowed is passed.
> Example:
> 
> 	#define FOO_MASK GENMASK_U32(33, 4)
> 
> will generate a warning like:
> 
> 	../include/linux/bits.h:41:31: error: left shift count >= width of type [-Werror=shift-count-overflow]
> 	   41 |          (((t)~0ULL - ((t)(1) << (l)) + 1) & \
> 	      |                               ^~

...

> + * __GENMASK_U*() depends on BITS_PER_TYPE() which would not work in the asm

Where are the double underscore variants? I see it only for U128.

> + * code as BITS_PER_TYPE() relies on sizeof(), something not available in
> + * asm. Nethertheless, the concept of fixed width integers is a C thing which
> + * does not apply to assembly code.

-- 
With Best Regards,
Andy Shevchenko



