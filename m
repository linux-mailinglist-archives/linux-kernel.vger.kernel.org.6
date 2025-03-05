Return-Path: <linux-kernel+bounces-547049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C42AA50260
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24A51162954
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA15521480C;
	Wed,  5 Mar 2025 14:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MkyQhRRb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997A714A09A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185480; cv=none; b=R39XzfUeg7pRAKcDg0nwymqCUHqaMW1Yjb+kXpZ5lsTiBo1hJJ1ptNJoXa44TY06zbux+cFJyZfGweHQuLquNBjyiZbEJuhSgHdHhJWKZwsMSONUDcrWedfhJN+0t05hbmdssgEFJLT4cYTprWYfBmSDRl3HkKYu4LGy9vmaPus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185480; c=relaxed/simple;
	bh=CSy21FFYCfkrs1Vebz77But+YBdPWb0R0yTM3O4u1EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nN1SU1HGZw8vL1ZNU++ceMV5bnCjdMFSKG+E6LEYGzgJJl93ePNLIIwiVZHIS6gthKe69Cui5JXiKu06aIJbADwEe6haLT8dm7DmxhB7YCRlGg54k0C8p+nTRjZ1ZA83Q4JAUNOKAtCukQp9n4vHijd2AXsC4PgZkg/ewwHUtdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MkyQhRRb; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741185479; x=1772721479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CSy21FFYCfkrs1Vebz77But+YBdPWb0R0yTM3O4u1EQ=;
  b=MkyQhRRbGYeqsqbCAlcP6CCPDuIsAwMq1+2oSTocrslkoWuBuOw7hSOu
   3jIovb/vMpcOAPuZ8DR4ZEX28XH9Y29jOsh+dJ7hgIQQE0qHGeju6s76W
   at8E5olK4YRqMiS5+QzGySLu+S3ABARGekVhV6D9NsvJ4/Zy2kZ5UplK2
   eJGth1pRaVIvkNRq3CplQ0wrKZp/MQTnhsbM7ilYYx4HT/dNhJ+bHVnYf
   nfcU4KnIxLFcpEIwyS/tfa4pD4xPjNeNXmbpOK0Ar7Qp1rowbz2g6sfJZ
   Lq1B/VkYmeRAAeDB2cDb5hFnOaMGCqVssWb8ibYiQGLVHp3i3dN5o2Tqh
   g==;
X-CSE-ConnectionGUID: 4zYksdVrQra0k+2vs+xOHQ==
X-CSE-MsgGUID: RnR1kQ1TTgmJJg43fr6vFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42350773"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="42350773"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 06:37:58 -0800
X-CSE-ConnectionGUID: yba5WHXCRs6NCv7yprlgGg==
X-CSE-MsgGUID: /XxRzxeSShWGF56o44N/DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="118526770"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 06:37:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tppsc-0000000HRDU-3UrN;
	Wed, 05 Mar 2025 16:37:50 +0200
Date: Wed, 5 Mar 2025 16:37:50 +0200
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
Subject: Re: [PATCH v4 5/8] drm/i915: Convert REG_GENMASK* to fixed-width
 GENMASK_*
Message-ID: <Z8hhvovVmX-xLStQ@smile.fi.intel.com>
References: <20250305-fixed-type-genmasks-v4-0-1873dcdf6723@wanadoo.fr>
 <20250305-fixed-type-genmasks-v4-5-1873dcdf6723@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305-fixed-type-genmasks-v4-5-1873dcdf6723@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 05, 2025 at 10:00:17PM +0900, Vincent Mailhol via B4 Relay wrote:
> From: Lucas De Marchi <lucas.demarchi@intel.com>
> 
> Now that include/linux/bits.h implements fixed-width GENMASK_*, use them

GENMASK_*()

and in the Subject

REG_GENMASK*()

> to implement the i915/xe specific macros. Converting each driver to use
> the generic macros are left for later, when/if other driver-specific
> macros are also generalized.

-- 
With Best Regards,
Andy Shevchenko



