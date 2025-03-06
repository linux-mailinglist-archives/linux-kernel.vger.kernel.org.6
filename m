Return-Path: <linux-kernel+bounces-548545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304A2A5464A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 426A73B16FA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9878C20A5C9;
	Thu,  6 Mar 2025 09:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vd5ZJhEX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987ED209F38
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253310; cv=none; b=K+K0oHBHmXUgNbD4o9kCoICBrD3FEDJ7eeKExnqhCc2F+h2WvPzK1qpLm5INEOVjxvv8T8B1byCv0GbzHZW4nMgNreCzaG3VRtsGKE5wEMcuD7tu0/miErEwnKBVqRTaXnS40Z9ihV3C1oowNBHdlT4RdIlVB9FfDtB2LAfMe9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253310; c=relaxed/simple;
	bh=gCm3jqfBHBVDSlHh9e4EYcGIKf1bGwC1Jxmrafx2SwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDFZxILpsN9mUM3JOmaCGp2qYsJjByh9dkXhwPce25kTGmCqosmmDAwJ2lNyPqf6/1q0+etoJrmidFSHmrMtdgLjgNisVByAaocxlfdCKzsEbaavG46qi/0ifnpNk5mNXrPN/vL+50LYAQsPHBVgaGnaPB7L1nEDWQHWwx+7vBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vd5ZJhEX; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741253309; x=1772789309;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gCm3jqfBHBVDSlHh9e4EYcGIKf1bGwC1Jxmrafx2SwQ=;
  b=Vd5ZJhEXufCfvrXHearb39mULpZrM6GOsC1h9lxy4lnH4fmOPSQAF707
   Y3YI2IKUNnFQLNLCtTczGBrpyGnMzw5+9N1xm7RzU7Q1exZYX7oh1lDrQ
   WPdDGIGgLQ56rNiSC7To7jmHwSnD7sb/xxS/fauSEzfJJ8yF+lHYqGEm2
   c2bkxTUPOhkBSP739TOo1SWVjTDgZ6JyGCtsmBXkt2Bgfxx3zHxOo3Igu
   fUGS9Pulz/cq7dX1QgGn+4jc2Q/XXjlx2MEXfqVLfd8s8ffeGcynmIEjW
   CPiuFxoFdWYfB4mTUNPESerGxCINFBWSyNUsMi52CTcXUVxhNrUdq5FJL
   g==;
X-CSE-ConnectionGUID: +bivrzP+ShCbFpNS9mJlOg==
X-CSE-MsgGUID: SK0RW3H9SvWDdNVN7agfMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52462531"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="52462531"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 01:28:28 -0800
X-CSE-ConnectionGUID: 1FeS51RZSbCkwzxABrj+ZA==
X-CSE-MsgGUID: CIOV+UozSBuSveAsGMymcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123126128"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 01:28:23 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tq7We-000000004hV-3KwV;
	Thu, 06 Mar 2025 11:28:20 +0200
Date: Thu, 6 Mar 2025 11:28:20 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
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
Message-ID: <Z8lqtLrlIv75lK5d@smile.fi.intel.com>
References: <20250305-fixed-type-genmasks-v4-0-1873dcdf6723@wanadoo.fr>
 <20250305-fixed-type-genmasks-v4-3-1873dcdf6723@wanadoo.fr>
 <Z8hx9AaUX_GvYq_A@thinkpad>
 <8301ecbc-d035-4257-9b04-c6ef9be4ce32@wanadoo.fr>
 <Z8ipvnURG_iejzSX@smile.fi.intel.com>
 <7063c8b4-5869-457d-91b1-3185d9e1181e@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7063c8b4-5869-457d-91b1-3185d9e1181e@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 06, 2025 at 06:22:33PM +0900, Vincent Mailhol wrote:
> On 06/03/2025 at 04:45, Andy Shevchenko wrote:
> >>> But GENMASK_U128() becomes a special case now.
> >>> The 128-bit GENMASK is unsued, but it's exported in uapi. Is there any
> >>> simple way to end up with a common implementation for all fixed-type
> >>> GENMASKs?
> >>
> >> What bothers me is that the 128 bit types are not something available on
> >> all architectures, c.f. the CONFIG_ARCH_SUPPORTS_INT128. So, I would
> >> need a U128() equivalent to the ULL() but which does not break on
> >> architectures which do not support 128 bits integers.
> >>
> >> This is where I am stuck. If someone can guide me on how to write a
> >> robust U128() macro, then I think the common implementation could be
> >> feasible.
> > 
> > I think we may leave that U128 stuff alone for now.
> 
> I found the solution! The trick is to use type_max() from overflow.h.
> 
> With this, GENMASK_TYPE() becomes:
> 
>   #define GENMASK_TYPE(t, h, l)					\
>   	((t)(GENMASK_INPUT_CHECK(h, l) +			\
>   	     (type_max(t) << (l) &				\
>   	      type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
> 
> and works with all the GENMASK variants, including the U128 one! The
> unit tests under lib/test_bits.c are all green.
> 
> Of course, this does *not* work in assembly. But as explained before,
> GENMASK_TYPE() is guarded by a #if !defined(__ASSEMBLY__), so all good!
> 
> The question raised by Yury on whether or not we should keep
> __GENMASK_U128() in the uapi still remains. And in full honesty, I will
> not touch that one. This is not in the scope of this series.

I vote for not touching it right now independently on its destiny.

-- 
With Best Regards,
Andy Shevchenko



