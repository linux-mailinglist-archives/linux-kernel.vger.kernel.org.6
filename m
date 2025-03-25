Return-Path: <linux-kernel+bounces-575755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE18EA706D7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D878C3B72BE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC8825D21F;
	Tue, 25 Mar 2025 16:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AnBdRvKf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707C61C8621
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919977; cv=none; b=ZABjUaqFHAqaafBjuCWPdMghWXTNtj3jts21y88UPeeDxmKZrTlIpSgMEvLZHD/wP0FdRecBTrRIt83FdFS08AdELbNT6uD6ZXsgnjToyyVjWvifAd41hL7KhOos8jUHu4dhD4VU13aUW6vE4vAQp1/A2+mjPJtLOfVcLbfJHVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919977; c=relaxed/simple;
	bh=zLF1T+Svm2nyklPUfhrXKb/s3OtiLT/we109JVFOEz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQrw9HbBFMOl7H6H+9/nfMERaJPW6qW+SlAtsOvoJhHEVuAvfLdYwQS5HIH/AP6olQOdkNq3NQpCBGR5x5Dy5Q6SKQutORg7B+SSJ6qCKYquF4IO53vLc3ZdbM/ipnpjNDfW6ABelSAnQrss9+jU8n5INrCq5TtBctoV1OKMuAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AnBdRvKf; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742919976; x=1774455976;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zLF1T+Svm2nyklPUfhrXKb/s3OtiLT/we109JVFOEz8=;
  b=AnBdRvKfl36NwsvxiCq1GoOiv8jZ7YQ+sf8LBHtPqcIaZJNCzi+SDFaL
   gmqRBi+BacXwNqvvJ9swsOXfwCa/43dWKwqT/3Rg3Ny1EYhhhcGppO0Db
   EFoXGxmIS4xNQk3Lj/lVKEHG8pQ9H+9fKIa4cp8DoISW5UEutRXq93mPp
   H9CJllZesftFpTQfqb3hq/WSrsQ25RS6J5EO7JrfC3oshs/oW0sieYK/R
   BiD2gAOP2mbgwTgsDdDjO87KZhByT5oC6NM+4bNZJXwhYIjWFOgtzdoys
   HhwIJ7/shMwPwHJKmiP6Y1bXHAr+jifZl5dDpm+/UojnepHPrAUuF7J2I
   w==;
X-CSE-ConnectionGUID: dCz6w/cmTMm2q7JeRH++Yg==
X-CSE-MsgGUID: GayJc5IxTkiFo0kBEhS9OQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="43332910"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="43332910"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 09:26:13 -0700
X-CSE-ConnectionGUID: 5lFr19JRTeWxFDbZy+SCqA==
X-CSE-MsgGUID: /wrgWLZpSzWFt4lXGFYYkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="125362586"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 09:26:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tx76L-00000005nkX-0spP;
	Tue, 25 Mar 2025 18:26:05 +0200
Date: Tue, 25 Mar 2025 18:26:04 +0200
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
Subject: Re: [PATCH v8 5/6] test_bits: add tests for GENMASK_U*()
Message-ID: <Z-LZHD7sxiOImzu3@smile.fi.intel.com>
References: <20250326-fixed-type-genmasks-v8-0-24afed16ca00@wanadoo.fr>
 <20250326-fixed-type-genmasks-v8-5-24afed16ca00@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326-fixed-type-genmasks-v8-5-24afed16ca00@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 26, 2025 at 01:00:00AM +0900, Vincent Mailhol via B4 Relay wrote:
> From: Lucas De Marchi <lucas.demarchi@intel.com>
> 
> Add some additional tests in lib/tests/test_bits.c to cover the
> expected/non-expected values of the fixed-type GENMASK_U*() macros.
> 
> Also check that the result value matches the expected type. Since
> those are known at build time, use static_assert() instead of normal
> kunit tests.

New tests always have a green light to go from my point of view,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



