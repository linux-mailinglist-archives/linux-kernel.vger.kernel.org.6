Return-Path: <linux-kernel+bounces-360576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEF8999CCF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A94928318D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1200820897F;
	Fri, 11 Oct 2024 06:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lf/NVyor"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EC219F475
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 06:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728628774; cv=none; b=MN6r/3weQpHy5M2xJDgbwOtQ/Q4VHd6THK0QUX7Pgtdz2RIr6utuijYkx4wIUlNmjThR5r7i15uILBwU8tZO8dD2V1+GFN352SGpeJCpRdxIBpJ0T5AfVeTKBrLma70k/zG5rY5QsmhVVW1GdJSVMCorh5+1XmDTOAhFP0PQor0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728628774; c=relaxed/simple;
	bh=t8ndc68REzy0V04Ih0kE9ZDNBGZxzSR2F9ssw+uQoxQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bh6E4u8+PfZacA+M4UnyTpv4a9+8w10WXEytRQY4m0IWEWp/6nvZzAvDQRmUQnt0oucrXDqCaN0hHDhQ1syjzgfLcOqNRE/Bk+jluedps8LqEW+QCUub209iPozx2aa3YLk10YRnBavxSH2yZz54ky2YM8NiMXuK7HEM57MPaCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lf/NVyor; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728628773; x=1760164773;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=t8ndc68REzy0V04Ih0kE9ZDNBGZxzSR2F9ssw+uQoxQ=;
  b=lf/NVyorsRFsyuAchXTK+teUTiSse1GDKjBtVm3V61HlKbbIDW4vmoAJ
   YOaGytX4l7Dq9F2JTR5RlVowli5AE9mJESHw8SQsGypGz7ripmjP9hB2i
   dvS8BsTkSgJ2CLrJPucUmL933N1eBy44l794RsikKyBQSvcMEoDJb82IO
   88d+52Ptr5yQtCP3rn1s2xPLOdETJkVmSlX/H8rlFUUrjjMnDRvboWTyE
   Q6PvD1A87HQgK3ZZskrGZRgwePJy5dGSrYAt/Gjvj55b4WteS9Q20qLvm
   tEHN14B0gp0FUZpVD+pMtiX8XsMq5Sw5HolK9FtF7C/5RrFEdE+6ndWBP
   A==;
X-CSE-ConnectionGUID: qk7r4NCzR8yV1MIYB3VLng==
X-CSE-MsgGUID: 6ZefBbcEQxW2bQ6qElragQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="28128577"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="28128577"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 23:39:32 -0700
X-CSE-ConnectionGUID: Hy4aaEyiT72UlcXdzP8KAw==
X-CSE-MsgGUID: wg5IyUUZRyCQQOpbDmO1Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="81437071"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 23:39:28 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org,  hannes@cmpxchg.org,  yosryahmed@google.com,
  hughd@google.com,  shakeel.butt@linux.dev,  ryan.roberts@arm.com,
  chrisl@kernel.org,  david@redhat.com,  kasong@tencent.com,
  willy@infradead.org,  viro@zeniv.linux.org.uk,  baohua@kernel.org,
  chengming.zhou@linux.dev,  v-songbaohua@oppo.com,  linux-mm@kvack.org,
  kernel-team@meta.com,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] swap: shmem: remove SWAP_MAP_SHMEM
In-Reply-To: <20241002012042.2753174-2-nphamcs@gmail.com> (Nhat Pham's message
	of "Tue, 1 Oct 2024 18:20:42 -0700")
References: <20241002012042.2753174-1-nphamcs@gmail.com>
	<20241002012042.2753174-2-nphamcs@gmail.com>
Date: Fri, 11 Oct 2024 14:35:55 +0800
Message-ID: <87cyk79mes.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Nhat Pham <nphamcs@gmail.com> writes:

[snip]

> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 0cded32414a1..9bb94e618914 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1381,12 +1381,6 @@ static unsigned char __swap_entry_free_locked(struct swap_info_struct *si,
>  	if (usage == SWAP_HAS_CACHE) {
>  		VM_BUG_ON(!has_cache);
>  		has_cache = 0;
> -	} else if (count == SWAP_MAP_SHMEM) {
> -		/*
> -		 * Or we could insist on shmem.c using a special
> -		 * swap_shmem_free() and free_shmem_swap_and_cache()...
> -		 */
> -		count = 0;
>  	} else if ((count & ~COUNT_CONTINUED) <= SWAP_MAP_MAX) {
>  		if (count == COUNT_CONTINUED) {
>  			if (swap_count_continued(si, offset, count))
> @@ -3626,7 +3620,6 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
>  
>  	offset = swp_offset(entry);
>  	VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
> -	VM_WARN_ON(usage == 1 && nr > 1);
>  	ci = lock_cluster_or_swap_info(si, offset);
>  
>  	err = 0;
> @@ -3652,6 +3645,13 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
>  				err = -EEXIST;
>  		} else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX) {
>  			err = -EINVAL;
> +		} else {
> +			/*
> +			 * The only swap_duplicate_nr() caller that passes nr > 1 is shmem,
> +			 * who never re-duplicates any swap entry it owns. So this should
> +			 * not happen.
> +			 */
> +			VM_WARN_ON(nr > 1 && (count & ~COUNT_CONTINUED) == SWAP_MAP_MAX);

Why not

	VM_WARN_ON_ONCE(nr > 1 && count);

?

IIUC, count == 0 is always true for shmem swap entry allocation.  Then
developers who use __swap_duplicate() with nr > 1 without noticing the
unsupported feature can get warning during development immediately.
"(count & ~COUNT_CONTINUED) == SWAP_MAP_MAX" is hard to be triggered
during common swap test.

>  		}
>  
>  		if (err)
> @@ -3686,27 +3686,28 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
>  	return err;
>  }
  
[snip]

--
Best Regards,
Huang, Ying

