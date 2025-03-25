Return-Path: <linux-kernel+bounces-575757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D3EA706C9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4C0D7A1CEF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F0E25A64C;
	Tue, 25 Mar 2025 16:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XYzSaQzI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CE078F24
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742920016; cv=none; b=gVrKIPVgVrGQ1r2n67bxzA8UPiLFOmnocsumLT+ainw+X0QOjJIUetzCF1P9Cj8eVg6i8UmfPSHArF1ZnKfoZCVe6hkMK9cMCKPZMNbYbkcMyfYl8gnVVrkofZskleu4H8dR06v/4HP6gadVvbtRiB/VUxZCk2Jq0IkJ3EUyEUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742920016; c=relaxed/simple;
	bh=aUoNv4oYa8qCJxrDcUluP80WU2qGEeImHsJYH4SlPvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0F2zB2yTXy0RRbhSfa8A3b6l1iDnAApahd4DGRh2La4h/eje0m5zXpKzXlacV6/J6nCIfb4ycK2wNfyBx9AqMkLt+rCATaQxk9mnqIDFO7tKDrDYtc30nknKl1ulEgaxYd/hq7YOm18nCsCj9m/lFCSJmU5Q321hRwChyrLj5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XYzSaQzI; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742920016; x=1774456016;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aUoNv4oYa8qCJxrDcUluP80WU2qGEeImHsJYH4SlPvY=;
  b=XYzSaQzIEaHbsnzNHd9m8t/7ERkD6T2B/fuaS5NnbcRQZVeogMfpw3kp
   hg5mktA9lNkurG4epo4jVlWBYSh9wl9IL9B34uV4waUTqXHWgv0KfFQj0
   DixcrX7ztKeVVs1cIkl4ccMp1IKiJyQz7g9WW5sSnFQpI8S1c/1pQ0n+q
   dG1jiAeO8mcPJQ9NBU9PBUYWgHpTwUfsrPqoFKPf2HUeIEA28Z7knZuUG
   Vnr48MNG0otHz2aAqVrU/2PxVScka31lHPOormWAMy7gBg0g2CSKXHRsH
   q2xr+GBDPjr/r3+2vzusWDRg97qn/++DBK1NvAkafmncOCR0f+S2B1yoj
   A==;
X-CSE-ConnectionGUID: OdQAtzA6QzWqYIzBwykBgA==
X-CSE-MsgGUID: FLByvrarRtmnHogrfInwxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="44103815"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="44103815"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 09:26:43 -0700
X-CSE-ConnectionGUID: JlxV2pRcQ2aEbRUQGA2njA==
X-CSE-MsgGUID: t1wgPdBMRwGB6RhGZYQreQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="124401977"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 09:26:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tx76o-00000005nl0-3rmp;
	Tue, 25 Mar 2025 18:26:34 +0200
Date: Tue, 25 Mar 2025 18:26:34 +0200
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
	Catalin Marinas <catalin.marinas@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 6/6] test_bits: add tests for BIT_U*()
Message-ID: <Z-LZOoE0tYc51Xlx@smile.fi.intel.com>
References: <20250326-fixed-type-genmasks-v8-0-24afed16ca00@wanadoo.fr>
 <20250326-fixed-type-genmasks-v8-6-24afed16ca00@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326-fixed-type-genmasks-v8-6-24afed16ca00@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 26, 2025 at 01:00:01AM +0900, Vincent Mailhol via B4 Relay wrote:
> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> 
> Add some additional tests in lib/tests/test_bits.c to cover the
> expected results of the fixed type BIT_U*() macros.
> 
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

New tests always have a green light to go from my point of view,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



