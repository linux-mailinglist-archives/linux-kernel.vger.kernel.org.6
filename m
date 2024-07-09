Return-Path: <linux-kernel+bounces-245102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B280E92AE5B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 04:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37201C21314
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 02:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C707D3EA64;
	Tue,  9 Jul 2024 02:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GD6eoRZA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5A53CF6A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 02:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720493804; cv=none; b=coX97jhDddTNTlrsN0meImOwnncy2ie9F5eYiOdBpMvVh0yTCaGBZpARhgjwfAjWMvNRY51yQXb0Cs/Q3/ZWPgBfyAVXOD23+DDY+gn+fIfslD6FylGi8b6ep2oBYM5MJ/dN6qI23TQPlkrWyPTPNW6c+I1L0qFGwtIcS66nQgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720493804; c=relaxed/simple;
	bh=nDWgDNwoTZyQWihVkwvb1NUUAyAKdjrIrlWJ/fdXGcI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oMDQHnpDHCqBhI+j4W2jNLiaWdcO+KKteePIzM4mED5VIkN5fre8/7t7wetQX53sibhvrQf3lwDRivK1twi+FMb41wxfdh5zMciFL+ATHDypa3KXNS4CXH1WWRjP4K9KpG1uq6RXQYh9T560oIargJRgx2Ak06jlNKXnwmGc4S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GD6eoRZA; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720493802; x=1752029802;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nDWgDNwoTZyQWihVkwvb1NUUAyAKdjrIrlWJ/fdXGcI=;
  b=GD6eoRZALzzlqmJk22rnj+TS9dlkBbIFCdcigFXHdfOhFd53pk8RUw7v
   LuPn+A7hKpZ9FMZYJp04eqeNtDX2GXx9f7X6Kis2dNjV939G+y8mJeD+E
   SyERfstIoGZbY85SB/DNiITMt1P0hMACFIv8YgZQYdogJcXEuSgBDBN8D
   8DkRcin3pA3U6xEHhE9R+Dl0juU1rN4eVspZG+m4cuVYHFmhU2BiDJGTF
   kGxXdWMEti0aRj/dNkk+BKMPAgLuNCPZynALOgP4lH4SfKWU7zXG4dEWQ
   OtSBbazEAgkgWoHKWNggphGO+Bz6ycy/DaU8izfcKFVzUQGnM0sQBCYbu
   g==;
X-CSE-ConnectionGUID: DIRIqdDJSE+1e7gyt1mnTw==
X-CSE-MsgGUID: DuvPANqWTjyX9hqHhQeZ6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="28323685"
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="28323685"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 19:56:42 -0700
X-CSE-ConnectionGUID: 2sLPeJyISYiqS38PIwxfAQ==
X-CSE-MsgGUID: NCgG+39UQUWlXGW+DDgslQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="47669414"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa008.fm.intel.com with ESMTP; 08 Jul 2024 19:56:40 -0700
Message-ID: <66e0f183-83ca-428d-af53-0fac69af7d42@linux.intel.com>
Date: Tue, 9 Jul 2024 10:53:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix aligned pages in
 calculate_psi_aligned_address()
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Louis Maliyam <louispm@google.com>
References: <20240708121417.18705-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240708121417.18705-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/24 8:14 PM, Lu Baolu wrote:
> The helper calculate_psi_aligned_address() is used to convert an arbitrary
> range into a size-aligned one.
> 
> The aligned_pages variable is calculated from input start and end, but is
> not adjusted when the start pfn is not aligned and the mask is adjusted,
> which results in an incorrect number of pages returned.
> 
> The number of pages is used by qi_flush_piotlb() to flush caches for the
> first-stage translation. With the wrong number of pages, the cache is not
> synchronized, leading to inconsistencies in some cases.
> 
> Fixes: c4d27ffaa8eb ("iommu/vt-d: Add cache tag invalidation helpers")
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/cache.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
> index e8418cdd8331..113834742107 100644
> --- a/drivers/iommu/intel/cache.c
> +++ b/drivers/iommu/intel/cache.c
> @@ -246,6 +246,7 @@ static unsigned long calculate_psi_aligned_address(unsigned long start,
>   		 */
>   		shared_bits = ~(pfn ^ end_pfn) & ~bitmask;
>   		mask = shared_bits ? __ffs(shared_bits) : BITS_PER_LONG;
> +		aligned_pages = 1UL << mask;

Hmm, it appears that if mask is equal to BITS_PER_LONG (which is
typically 64), the left shift operation will overflow.

So perhaps we need another line of change:

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index 113834742107..44e92638c0cd 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -245,7 +245,7 @@ static unsigned long 
calculate_psi_aligned_address(unsigned long start,
                  * shared_bits are all equal in both pfn and end_pfn.
                  */
                 shared_bits = ~(pfn ^ end_pfn) & ~bitmask;
-               mask = shared_bits ? __ffs(shared_bits) : BITS_PER_LONG;
+               mask = shared_bits ? __ffs(shared_bits) : 
MAX_AGAW_PFN_WIDTH;
                 aligned_pages = 1UL << mask;
         }

I will make above another fix as it already causes overflow in another
path.

Kevin, sound good to you?

Thanks,
baolu

