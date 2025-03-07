Return-Path: <linux-kernel+bounces-551689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E58E7A56F87
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A51E1762E7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34CF23BD1C;
	Fri,  7 Mar 2025 17:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AMO7dmMT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5C6218AD4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 17:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369704; cv=none; b=p0rTtGYx1G2b/Vc3XWnvgLhPn5Ztdm5uuufdgJd1/ncPSyfrEWxblx247yqnMkWhvVt+op/yOD0iBM7GDLAyBWwFrK3ORqCncK0ju1jHKfKN8yazMqfdgbqEwG1hu244AmSv50lGNNc2N7rpbPP6yR5Q1DFQC37GkvFu4CeQLzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369704; c=relaxed/simple;
	bh=B8llukmjpnYTZeJDVBXphW31+bV8O5TYaK3otj6LuiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxGzojNxe7tK0UGNw9Fh+N+hS0NhaDITjbMZVFc1fPS/+mVlRXR1oXMIf0R9HGaZ8LpH/cPWxeXyOx7bdIWWtTy7pad+oelUHamYCqsL1nHkjXdcheaZz20IjbACe/x0BFr3zSYDCeDMixrhOcSLbTQX8GjGIlIUaNLYP3YSsHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AMO7dmMT; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741369703; x=1772905703;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B8llukmjpnYTZeJDVBXphW31+bV8O5TYaK3otj6LuiY=;
  b=AMO7dmMTk8oDRSVMXx+kZX4TrmSK1esAYRHvSBoEoR4leZm3hg9Oa7xv
   Zy0LuLR2Rgl80hbhW/le12CZ+794SagQstg1OC5vbw7lrhp8a9Rds31Gr
   wCSd5APLPDnZW6hapKQiSCBRy3XDTwOaVo1agoryflRLbd6uVhopfJ+cd
   Nb/C9dbLu3hTrC8Dqw8KyCu3l2CXQZfRO33SaXhkdkELznyOiOkYlrm1A
   pwtFYMrN8fV2e7i7D/i1KLYlSOzxfsDdsUffw6HEJznqIQw5tU9srWfQo
   4ecJJvFnz3j8VbrJKpUyVdDE5zi8ynimvF+Xkvbspyz/S4bRGWDzy9K90
   w==;
X-CSE-ConnectionGUID: sTxS2M7yQOmK1xXPJYyp+w==
X-CSE-MsgGUID: 2kqMYcOmSKaDErv+uyc72g==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="46208129"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="46208129"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 09:48:22 -0800
X-CSE-ConnectionGUID: CuEhmC5tQfedXFcSOLBxtg==
X-CSE-MsgGUID: k3JJJ6D/SCi+V3YKyNBjoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119908613"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 09:48:06 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tqbnl-00000000TZX-33Lr;
	Fri, 07 Mar 2025 19:48:01 +0200
Date: Fri, 7 Mar 2025 19:48:01 +0200
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
Subject: Re: [PATCH v6 3/7] bits: introduce fixed-type BIT_U*()
Message-ID: <Z8sxUTR-5j5XmZnO@smile.fi.intel.com>
References: <20250308-fixed-type-genmasks-v6-0-f59315e73c29@wanadoo.fr>
 <20250308-fixed-type-genmasks-v6-3-f59315e73c29@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308-fixed-type-genmasks-v6-3-f59315e73c29@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Mar 08, 2025 at 01:48:50AM +0900, Vincent Mailhol via B4 Relay wrote:
> From: Lucas De Marchi <lucas.demarchi@intel.com>
> 
> Implement fixed-type BIT_U*() to help drivers add stricter checks,
> like it was done for GENMASK_U*().

...

>  /*
>   * Missing asm support
>   *
> - * GENMASK_U*() depends on BITS_PER_TYPE() which relies on sizeof(),
> - * something not available in asm. Nethertheless, fixed width integers
> - * is a C concept. Assembly code can rely on the long and long long
> - * versions instead.
> + * GENMASK_U*() and BIT_U*() depend on BITS_PER_TYPE() which relies on
> + * sizeof(), something not available in asm. Nethertheless, fixed
> + * width integers is a C concept. Assembly code can rely on the long
> + * and long long versions instead.
>   */

I don't like this hunk. You just introduced a message which is rewritten
completely in the immediate followup. Can you come up in a better text
here and/or there so it will give only + LoCs (or minimizes - to 1:ish)?

-- 
With Best Regards,
Andy Shevchenko



