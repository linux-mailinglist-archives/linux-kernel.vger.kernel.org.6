Return-Path: <linux-kernel+bounces-575749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53545A706D2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E09BF1897251
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA3825DB0B;
	Tue, 25 Mar 2025 16:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hVwxr4jJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFD219C574
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919869; cv=none; b=QEGH6nVc4zO6oTPWsJDXIMKPSTDAM3uzMQkoXFNBwqu2u7BF237vIR255uyoUPxRZ1rPjvJhLQ0Zz4jehpg7JMSFM+CJ8QcPb36iz8jiXugUsMpNN9z1YokWGGb2v/nlxxFihwjUTWxh8dGnehO11p5Mze9b10tN6f9M+z4/LVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919869; c=relaxed/simple;
	bh=O6zgiQy9PurDUfDFlX9BIxqNQbwiYYtsMkbmcnI3ETA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOEdPkifV6yPiOug9ZViTPB/b038bXyrMHObJvgNHQPecjWrNtLg7vfuf1VdZ7l5x2W1qOShOb43VfzeZbMuHJYbaDxAA9Dz5et+hD0h/0WJreWIspI9Ncz4E//RaPTzi7jf+VMcrILvvIL7dN9yvi+2wukGbioZnK0v2KXEfE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hVwxr4jJ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742919867; x=1774455867;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O6zgiQy9PurDUfDFlX9BIxqNQbwiYYtsMkbmcnI3ETA=;
  b=hVwxr4jJaemEz7MPC8xsZ6xFChPbYY9hjiuHtEkwnlLWF6T6cJyc+rJQ
   NtktVjIoGmUvE6Y/HsQ7SAUYyfzQ7ipGnPk2i6Nc447Wrp9eHm3wTyQsS
   wS+IF3frkR5uGbpD7NwzDTeQCTI8T4FJqrDLEgsWFENP4dkdaPU4mBrFV
   WpwMv8EhFGvK1KGscTiPFHuN+tMXNt13UPYqmSz0s9TDuBXPbinXujYnN
   ZFwVA1/GAc9X8zwG1ChYWiGPKrDqwfpyiq8ylAyE0ItTwBZ3KQo9KD11O
   w2Kysmjta9My25J7iy56VKdDARbrxqGY4cVv/ZUV1tgnvYrz9wkkDI0UZ
   g==;
X-CSE-ConnectionGUID: +4n1XfbOTGqGNRLswA11sA==
X-CSE-MsgGUID: oRKnvhQvSXqJ4T9yNbG56g==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="54825755"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="54825755"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 09:24:26 -0700
X-CSE-ConnectionGUID: nzc9vcrxQ/+kqPwoeiOqSw==
X-CSE-MsgGUID: gCtk4bmRQT+ihdrBce7azg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="124897126"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 09:24:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tx74d-00000005njC-1USU;
	Tue, 25 Mar 2025 18:24:19 +0200
Date: Tue, 25 Mar 2025 18:24:19 +0200
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
	linux-arm-kernel@lists.infradead.org,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v8 2/6] bits: introduce fixed-type GENMASK_U*()
Message-ID: <Z-LYs9D8_Q76bDQk@smile.fi.intel.com>
References: <20250326-fixed-type-genmasks-v8-0-24afed16ca00@wanadoo.fr>
 <20250326-fixed-type-genmasks-v8-2-24afed16ca00@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326-fixed-type-genmasks-v8-2-24afed16ca00@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 26, 2025 at 12:59:57AM +0900, Vincent Mailhol via B4 Relay wrote:
> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> 
> Add GENMASK_TYPE() which generalizes __GENMASK() to support different
> types, and implement fixed-types versions of GENMASK() based on it.
> The fixed-type version allows more strict checks to the min/max values
> accepted, which is useful for defining registers like implemented by
> i915 and xe drivers with their REG_GENMASK*() macros.
> 
> The strict checks rely on shift-count-overflow compiler check to fail

-Wshift-count-overflow

but it's not so important here. It's good that it's fixed in the comment.
In any case if Yury wants/can do the change, it might be done when applying.
(I.o.w. no need to resend)

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
> The result is casted to the corresponding fixed width type. For
> example, GENMASK_U8() returns an u8. Note that because of the C
> promotion rules, GENMASK_U8() and GENMASK_U16() will immediately be
> promoted to int if used in an expression. Regardless, the main goal is
> not to get the correct type, but rather to enforce more checks at
> compile time.
> 
> While GENMASK_TYPE() is crafted to cover all variants, including the
> already existing GENMASK(), GENMASK_ULL() and GENMASK_U128(), for the
> moment, only use it for the newly introduced GENMASK_U*(). The
> consolidation will be done in a separate change.

The change LGTM, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



