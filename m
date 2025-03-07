Return-Path: <linux-kernel+bounces-551679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25764A56F72
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FF107AC220
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2033C2417C4;
	Fri,  7 Mar 2025 17:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FRQ4nIZv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283C023CEF9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 17:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369388; cv=none; b=rAPmX9gvscFhBYWCfSh3Ojm/wgAPB74mUN0JSTULARW2zV0irthCXqOF0+GL3N+4FlBno/Q3YmLtWQNA7/Z4t0M6zCwNtZ/19Bga8WhrR+ySXJ96jZPZ/Fg54jM5rPWvSszj22idB1VEmX+HUVdjMyGYJ5WV2F/0lnylxEtS9Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369388; c=relaxed/simple;
	bh=+kt9trydWppjyLTS1v06E/6kn1cAIhEtv++sHef4MMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1D/fb9jXdlbB5njjv9ARnFn0iGle3CuEHu6rmBi/Wp4U5jEBDGtxeP3TxBotAawVSk/KEejesfPVXVPNFd9Z2ou923oWrRr+p2a52gS+5FjRPiE4a0ZZOIWrod7wiLkax0J2Xs0Tr4GJEmlbFaR/T+3PL7t6Yow0Go0vcC8XsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FRQ4nIZv; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741369388; x=1772905388;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+kt9trydWppjyLTS1v06E/6kn1cAIhEtv++sHef4MMw=;
  b=FRQ4nIZvgyA8eVYQP4kquE1MmPUOitUF8vnMLzWJanZXfWbV61nJ2LF3
   5Jve5O/2DhASZQ1hpdV13YxrBNSFpApTRBjGPQWas5yWRvQo1VZqgd22S
   LCAf9KnOHSjwbtRPCpWYiYnYJkoeayjTZZIHi89Ka4tK0qo9L42/0j5ly
   rdiGbfIxEfr+68AkSIXb2MlfgXQJgBUl0aOz2Y+GC4zbLmDpxuu18unZE
   RvepCFrgf5YHQccLiR4RubT0js6TP5k6nDWe7gi+zFRQwWQLFglLBLpcK
   TBROfIWgnLG0VnwE4qqHIzmpYD9gI7sLs+8faUQIuYK34fUYonehUZBym
   g==;
X-CSE-ConnectionGUID: 9NvIMCWsQ9qLpUsq18pHqg==
X-CSE-MsgGUID: UYauZrlLSTOz50AT9MH/wA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42461693"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="42461693"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 09:43:07 -0800
X-CSE-ConnectionGUID: RlVyw6roQzWlw+azXoMNUg==
X-CSE-MsgGUID: 8HzF3/4YSjGNPswqX4cnMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="120083673"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 09:43:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tqbis-00000000TVI-4BqQ;
	Fri, 07 Mar 2025 19:42:59 +0200
Date: Fri, 7 Mar 2025 19:42:58 +0200
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
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v6 1/7] bits: split the definition of the asm and non-asm
 GENMASK()
Message-ID: <Z8swIt7fqpVAp2P8@smile.fi.intel.com>
References: <20250308-fixed-type-genmasks-v6-0-f59315e73c29@wanadoo.fr>
 <20250308-fixed-type-genmasks-v6-1-f59315e73c29@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308-fixed-type-genmasks-v6-1-f59315e73c29@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Mar 08, 2025 at 01:48:48AM +0900, Vincent Mailhol via B4 Relay wrote:
> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> 
> In an upcoming change, GENMASK() and its friends will indirectly
> depend on sizeof() which is not available in asm.
> 
> Instead of adding further complexity to __GENMASK() to make it work
> for both asm and non asm, just split the definition of the two
> variants.

...

> -/*
> - * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
> - * disable the input check if that is the case.
> - */

> +/*
> + * BUILD_BUG_ON_ZERO() is not available in h files included from asm files, so
> + * no input checks in assembly.
> + */

In case of a new version I would reformat this as

/*
 * BUILD_BUG_ON_ZERO() is not available in h files included from asm files,
 * so no input checks in assembly.
 */

It makes easier to review the changes and see that the first line is kept
the same.

-- 
With Best Regards,
Andy Shevchenko



