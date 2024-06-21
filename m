Return-Path: <linux-kernel+bounces-224930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5A89128CB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF5391C25E32
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A9753363;
	Fri, 21 Jun 2024 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GZK1x7Cf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE75D3AC0C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718982161; cv=none; b=QPHgVe+l0LKGOmwycTJxmLs0CUDX+B/Ma/dPtVU5l6tX8RjV/UMZzgQWzkd64qX3qvMdsGbgfiUwnj4H72QHnwXbiGwtBwSsGHa3zLIoKr147UKUgcIfNbaftqsRQ+G2yy1hqLql9hMX5Rw+IbIgthtsyGNODfhPW/wAFZHG5RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718982161; c=relaxed/simple;
	bh=xpHy9iak7aLFOSekzIc/FTqROoXHuj3oc1ePwYeDMOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9k3RaLFAEEeuwKJl/Y8YfQ5KCAlz2BDcirQBfq7a+RM8mcCWr/ZvmcvG07QWON93y8hCUaTQuPuhJqBbesWtqw3hdxz/Ve1d0HbEH54TLN0dEasr9xbYMwpc+q59hAuwQBmO7HjAIfiNOnqgROvmkCjkIDa2l+NNJ2pFUomd0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GZK1x7Cf; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718982160; x=1750518160;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xpHy9iak7aLFOSekzIc/FTqROoXHuj3oc1ePwYeDMOg=;
  b=GZK1x7Cfy8K4UOWRCbM+85GUWbDjnmDuSn1wz6KIX+eSiapE9+u3ybam
   0NGXYReCgiLo/ko3zFmTcKtMypx7PxBb/dDkqEe4E0AOPYa7Icvi7nq/b
   s2b1nKH5BDHzjSuIJKLZGhovGxDnedKSi8QroFPWx38iw35UADEsKG6dq
   d4EacKAf3lzKJFTVICqcInL8Ctr9qKqcXN/dnO/KHIa+xqm4C8aCpp1tz
   VvmXswvHLghgm6Aa3KuCESaiurTDhKtvhDqBVix9oqj2Vh7GglGls06v/
   fcGbMzE/l+EUbDn7lB+qZCrtE1wutiTity4j05LkfZQSPQFE5gsjxoN3h
   Q==;
X-CSE-ConnectionGUID: JLxz2X78Tquipj0jQBpWqQ==
X-CSE-MsgGUID: KPd4mYo2SAKo7tPC1YtcQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="26705687"
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="26705687"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 08:02:30 -0700
X-CSE-ConnectionGUID: pHiuskksQ9SWgl8c9a5F+w==
X-CSE-MsgGUID: ncj+Et7DRFmffSWXyVPxCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="42585370"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 21 Jun 2024 08:02:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id B91E01D6; Fri, 21 Jun 2024 18:02:26 +0300 (EEST)
Date: Fri, 21 Jun 2024 18:02:26 +0300
From: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To: Alexander Potapenko <glider@google.com>
Cc: elver@google.com, dvyukov@google.com, dave.hansen@linux.intel.com, 
	peterz@infradead.org, akpm@linux-foundation.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH 2/3] lib/Kconfig.debug: disable LOCK_DEBUGGING_SUPPORT
 under KMSAN
Message-ID: <meity7zml7rsrf6lhlj6a33chvye7uipztqjbhgvqwx3sbyzoi@gh47yptppwu6>
References: <20240621094901.1360454-1-glider@google.com>
 <20240621094901.1360454-2-glider@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621094901.1360454-2-glider@google.com>

On Fri, Jun 21, 2024 at 11:49:00AM +0200, Alexander Potapenko wrote:
> At least on x86 KMSAN is seriously slown down by lockdep, as every
> pfn_valid() call (which is done on every instrumented memory access
> in the kernel) performs several lockdep checks, all of which, in turn,
> perform additional memory accesses and call KMSAN instrumentation.
> 
> Right now lockdep overflows the stack under KMSAN, but even if we use
> reentrancy counters to avoid the recursion on the KMSAN side, the slowdown
> from lockdep remains big enough for the kernel to become unusable.
> 
> Reported-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Closes: https://github.com/google/kmsan/issues/94
> Link: https://groups.google.com/g/kasan-dev/c/ZBiGzZL36-I/m/WtNuKqP9EQAJ
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
>  lib/Kconfig.debug | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 59b6765d86b8f..036905cf1dbe9 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1339,7 +1339,7 @@ menu "Lock Debugging (spinlocks, mutexes, etc...)"
>  
>  config LOCK_DEBUGGING_SUPPORT
>  	bool
> -	depends on TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
> +	depends on TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT && !KMSAN

Nit: no need to pile everything in one line. Add "depends on !KMSAN" on a
separate line.

Otherwise, looks sane.

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

