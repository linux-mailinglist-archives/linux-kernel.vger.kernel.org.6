Return-Path: <linux-kernel+bounces-573260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC36A6D4F7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C53C93A998F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 07:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B6A19307F;
	Mon, 24 Mar 2025 07:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="co4hRIRG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C749433B3
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 07:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742800934; cv=none; b=f2WvD7l579NiiaeyrlF54R2SEB+umPWpUQlattjAbvFkDUDB3+W0gAkMNo/Q1J7QlMXMQbG6qR0+o0t0NsSlDwmwdsMpvko97csWWkYxOLinVXnrdCehVl41kkOaF2ZIIEDHUqKw8T/Newuwf2SGqRlklDrR6dQ38i/rICKFaq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742800934; c=relaxed/simple;
	bh=Bi0VOtxBb5PPiHhSEn+o+czd1m/PRweXqLBe9D7NXXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1khcBg3NpZplLh7KXuvmfH0J8hqV5LuVqMSWM+7YB1n6ObI+GdYBqN+oj9j5duJHM02rdGBBWY41Twaf5NzivCTQWe+lbN0lGVVxH7biGg3NUO6koErWD2yNoUko3amJTEf9DpbNCsMDdJvLivL9ubew9YrEr1trUNcKYRoMoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=co4hRIRG; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742800932; x=1774336932;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bi0VOtxBb5PPiHhSEn+o+czd1m/PRweXqLBe9D7NXXo=;
  b=co4hRIRG6MqXG4aGn90ZnMsrMPAHBWQXP88KL5eEmyrGxa8aSZEwgUYc
   f+PAD7b2F2cTiYI7sH79RU9Eu+VbVrxsUAqyX8DHo18DR2L6OPDphF9pm
   EVFBpEuzgbHi7UQhb1DV7jesmxT1+KKTITvTw8VZ1at5tv2S+0I964gEP
   j1ae7FHmc1WjlqllgIfV06hVS2X791GlBBTMNQ+GP/YMImqD8k/KDFPJl
   k2KEmtKt+u2fcZ5xa691etCresbQVlWNxwJOpnMWVfQHItHifLqyc/NGG
   swjtjxRBKxBndilQWzejkcaY5j1Z3WmQ09PoQfHRuVdBDU3u+QAkpzG3U
   g==;
X-CSE-ConnectionGUID: AvwDpnVCSoC4VAB5ushNwQ==
X-CSE-MsgGUID: jzOD0vykTRaXuI3soHWV6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="43867246"
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="43867246"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 00:22:12 -0700
X-CSE-ConnectionGUID: sUVwKoHDQxyIOIn75Tj2xw==
X-CSE-MsgGUID: 4tE2DzzsS9mDO64YU8DZ3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="124916036"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 00:22:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1twc8K-00000005Gbk-2ZyD;
	Mon, 24 Mar 2025 09:22:04 +0200
Date: Mon, 24 Mar 2025 09:22:04 +0200
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
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v7 1/5] bits: introduce fixed-type GENMASK_U*()
Message-ID: <Z-EIHBCkUiBh63JE@smile.fi.intel.com>
References: <20250322-fixed-type-genmasks-v7-0-da380ff1c5b9@wanadoo.fr>
 <20250322-fixed-type-genmasks-v7-1-da380ff1c5b9@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250322-fixed-type-genmasks-v7-1-da380ff1c5b9@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Mar 22, 2025 at 06:23:12PM +0900, Vincent Mailhol via B4 Relay wrote:
> 
> Add GENMASK_TYPE() which generalizes __GENMASK() to support different
> types, and implement fixed-types versions of GENMASK() based on it.
> The fixed-type version allows more strict checks to the min/max values
> accepted, which is useful for defining registers like implemented by
> i915 and xe drivers with their REG_GENMASK*() macros.
> 
> The strict checks rely on shift-count-overflow compiler check to fail
> the build if a number outside of the range allowed is passed.
> Example:
> 
>   #define FOO_MASK GENMASK_U32(33, 4)
> 
> will generate a warning like:
> 
>   include/linux/bits.h:51:27: error: right shift count >= width of type [-Werror=shift-count-overflow]
>      51 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
>         |                           ^~
> 
> While GENMASK_TYPE() is crafted to cover all variants, including the
> already existing GENMASK(), GENMASK_ULL() and GENMASK_U128(), for the
> moment, only use it for the newly introduced GENMASK_U*(). The
> consolidation will be done in a separate change.

...

>  #if !defined(__ASSEMBLY__)
> +

> -#else

> +#else /* defined(__ASSEMBLY__) */

> -#endif
> +
> +#endif /* !defined(__ASSEMBLY__) */

Up to you, but if new version is needed or maintainer require, I would move the
above changes either to a separate patch (prerequisite) or dropped them at all.
These are not big but unneeded churn,


-- 
With Best Regards,
Andy Shevchenko



