Return-Path: <linux-kernel+bounces-266036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F4093F9AC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13077282EEB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B861215A84D;
	Mon, 29 Jul 2024 15:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KTURE0NX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E3313BC3F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267542; cv=none; b=ntyI3U/3oq8TbwEEAlL0QABr4kGkzL4RNuHMd6RP3ifDz41d9JvYJ3Ea1+9SEyi1wV22ni4LcJnoinrQHjtFtknRikMnWTRGY7CYE7PN1vsJbZ7OJ86Q0WnkShbZt3wF6PXl35LUgDPmHNlL3P0liA9zg6iIxNmsEtnqIG4+brM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267542; c=relaxed/simple;
	bh=O6QAspJHeXVwExOooCgkOhCym34IUm1sotkydfLGmgI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ImZCXIP18/4G8LqsqxJrii8MnMRAOOBCVwPjC5LBtzcP739YHxO7mxbLsuoncoSbpMT7Y9tqAFZIe92J80whwfCtqpvqrzFCGC0qbTRI94rOArfztxXtixtzA1Vy8ZIxLqLFtixlhMyW+wH6uJoDKF/xQXF3g0dElpH55H4YwPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KTURE0NX; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722267541; x=1753803541;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=O6QAspJHeXVwExOooCgkOhCym34IUm1sotkydfLGmgI=;
  b=KTURE0NXDE4fK8XdXaiR+s5Sn7ODeYB/HrHg0s4xRqjll/O4kBDluOD/
   /8EkS8ZCMxaEUwxFaBf0vA+yv6+M+z8HcDfQg+6pmVQd5ifC+c0U38qrq
   AG0lXHnsDxpJyvgGOvd096yQ4y3kWtla+wO3twi9N7lFoeyIUHBEcnJnZ
   bpHxcQ4dyymspNXGomvl2qtcRjSgPZiwV+j/O0fNajS6nxJr3W1cizoD2
   RVxjft6pyQP4KiB55E3c0zDAYYeM+Ve8E/MV+1h8T3g8Z17+Q9NsLv3iZ
   ZHEsmvPd27BRwKXWj23OrwV7WjU9RNJ6Tv0FjVkpYZl5O7m+ZC0/wJ0wK
   w==;
X-CSE-ConnectionGUID: qI6YXHrASwunP5XHMkVaPQ==
X-CSE-MsgGUID: KXEBvDbWRbGD4GT1CsOzFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="22938814"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="22938814"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 08:39:00 -0700
X-CSE-ConnectionGUID: fDDQZKOnT3a7CFWNFWeBMQ==
X-CSE-MsgGUID: lmQR161gQ5GhKhYtR7uq4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="53667278"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.151])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 08:38:56 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 29 Jul 2024 18:38:52 +0300 (EEST)
To: Palmer Dabbelt <palmer@rivosinc.com>
cc: bhelgaas@google.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Greg KH <gregkh@linuxfoundation.org>, bhe@redhat.com, 
    alison.schofield@intel.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] resource: Elide a conversion warning on 32-bit
In-Reply-To: <20240729151652.15063-2-palmer@rivosinc.com>
Message-ID: <77953469-413b-13e4-72fb-c92b7b1c6dd1@linux.intel.com>
References: <20240729151652.15063-2-palmer@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 29 Jul 2024, Palmer Dabbelt wrote:

> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> I recently ended up with a warning on some compilers along the lines of
> 
>       CC      kernel/resource.o
>     In file included from include/linux/ioport.h:16,
>                      from kernel/resource.c:15:
>     kernel/resource.c: In function 'gfr_start':
>     include/linux/minmax.h:49:37: error: conversion from 'long long unsigned int' to 'resource_size_t' {aka 'unsigned int'} changes value from '17179869183' to '4294967295' [-Werror=overflow]
>        49 |         ({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })
>           |                                     ^
>     include/linux/minmax.h:52:9: note: in expansion of macro '__cmp_once_unique'
>        52 |         __cmp_once_unique(op, type, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
>           |         ^~~~~~~~~~~~~~~~~
>     include/linux/minmax.h:161:27: note: in expansion of macro '__cmp_once'
>       161 | #define min_t(type, x, y) __cmp_once(min, type, x, y)
>           |                           ^~~~~~~~~~
>     kernel/resource.c:1829:23: note: in expansion of macro 'min_t'
>      1829 |                 end = min_t(resource_size_t, base->end,
>           |                       ^~~~~
>     kernel/resource.c: In function 'gfr_continue':
>     include/linux/minmax.h:49:37: error: conversion from 'long long unsigned int' to 'resource_size_t' {aka 'unsigned int'} changes value from '17179869183' to '4294967295' [-Werror=overflow]
>        49 |         ({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })
>           |                                     ^
>     include/linux/minmax.h:52:9: note: in expansion of macro '__cmp_once_unique'
>        52 |         __cmp_once_unique(op, type, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
>           |         ^~~~~~~~~~~~~~~~~
>     include/linux/minmax.h:161:27: note: in expansion of macro '__cmp_once'
>       161 | #define min_t(type, x, y) __cmp_once(min, type, x, y)
>           |                           ^~~~~~~~~~
>     kernel/resource.c:1847:24: note: in expansion of macro 'min_t'
>      1847 |                addr <= min_t(resource_size_t, base->end,
>           |                        ^~~~~
>     cc1: all warnings being treated as errors
> 
> which this elides via an extra cast.

I think you should describe the configuration which triggers this a bit 
more here because it's not just about 32-bit build but also requires 
MAX_PHYSMEM_BITS to be larger than 32.

> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> Not sure if there's a better way to do this, but I didn't see any
> reports yet and my tester is failing so I figured it'd be best to get
> something on the lists.
> ---
>  kernel/resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 14777afb0a99..6459561b746e 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -1845,7 +1845,7 @@ static bool gfr_continue(struct resource *base, resource_size_t addr,
>  	 */
>  	return addr > addr - size &&
>  	       addr <= min_t(resource_size_t, base->end,
> -			     (1ULL << MAX_PHYSMEM_BITS) - 1);
> +			     (resource_size_t)((1ULL << MAX_PHYSMEM_BITS) - 1));

So this effectively casts away 2 bits hiding the warning? It would be 
more proper to limit it with RESOURCE_SIZE_MAX instead of casting the 
bits away if that's the intention of this code (of which I'm not sure).

And why are you fixing just one line when there is another similar
expression?

-- 
 i.


