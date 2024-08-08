Return-Path: <linux-kernel+bounces-279119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA20C94B92B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6240D1F217C8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8552D1898F2;
	Thu,  8 Aug 2024 08:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gTTS2QST"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3507718950C
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723106433; cv=none; b=iUgFUIlgpg3qVwfxCCrsA8LXOw7GQTrd7ocRs62x1vx1XG5qy8fnoZQW18KfzisB+Ec6rOdBsG5s4paHbgCMGOtCbH/6+/7bE5h1ecSNgKTsL5NQeyNYOcLJvfF2Uqm4KWtmFdkr1+fLT2CQ3Rxu7FTyRK66vv14+VajYSt2u9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723106433; c=relaxed/simple;
	bh=ILIVNd0d7PFN6eKtpQ0yw2fOb+XUxKGhOmkekcRWTIQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ngrkgOjJKHQ3yD2vv6dAZgmXfuLqJndKXg7dHvnDHR7PoKst4Y/Jn+btaybq+lMHX5nRLdgAQgGMDuGEUF6SV5CLl15FqlM7q0loSb1viXz/ZyQ6zbu14J8dyuh5ZlSokNcl7CAY8GRvZDtLwnAijjdnz8GcBz7yEPEaa+rfdIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gTTS2QST; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723106432; x=1754642432;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ILIVNd0d7PFN6eKtpQ0yw2fOb+XUxKGhOmkekcRWTIQ=;
  b=gTTS2QSTrqxygMP5NhWqdbx4Yb7Q/zXZn2fb8peU4LZQEx1Vz9iAux3A
   tRvmtCQX/DZ5qXVgvTzMGzPshU4WZZ6LOyf7NBw9yW88xOWoCiGqJ1gt8
   ovGjZUY5pBzsckGti5xmBp3tXMMIxmrKJznzMhalZUjKW6mhofl1Qk8/z
   6RwOTna3fX9gukocqQgVhG0O9P3ab/gYWyd3Cu+vCVytLUZv0+3qalreQ
   oQZFKuEVHqvsk+dPDSZuNhg7QlkVBbJBVX2fYG3q2+fZHMVPI2dMO5/BH
   g/rIed/BJBGF9yPLQUhYvnsPYOi/jntxUcLGJThHCzJ2876+U43WYEb4w
   w==;
X-CSE-ConnectionGUID: R5SZPXpnQxOh88OrxM6hgQ==
X-CSE-MsgGUID: fzJzeW7/Q9+g36RiZmLETQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="43739349"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="43739349"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 01:40:31 -0700
X-CSE-ConnectionGUID: fSXnMxYVT3aUSeQ1rPE45A==
X-CSE-MsgGUID: i6v3MAsxQSaGZJYlLO9FbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="61793401"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 01:40:29 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: David Hildenbrand <david@redhat.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Chris Li <chrisl@kernel.org>,  Hugh Dickins
 <hughd@google.com>,  Ryan Roberts <ryan.roberts@arm.com>,  Kalesh Singh
 <kaleshsingh@google.com>,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  Barry Song <baohua@kernel.org>
Subject: Re: [PATCH v5 0/9] mm: swap: mTHP swap allocator base on swap
 cluster order
In-Reply-To: <CAMgjq7CWwK75_2Zi5P40K08pk9iqOcuWKL6khu=x4Yg_nXaQag@mail.gmail.com>
	(Kairui Song's message of "Thu, 1 Aug 2024 17:59:17 +0800")
References: <20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org>
	<3c79021a-e9a0-4669-a4e7-7060edf12d58@redhat.com>
	<CAMgjq7CWwK75_2Zi5P40K08pk9iqOcuWKL6khu=x4Yg_nXaQag@mail.gmail.com>
Date: Thu, 08 Aug 2024 16:36:56 +0800
Message-ID: <87le17z9zr.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Kairui Song <ryncsn@gmail.com> writes:

[snip]

> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -450,7 +450,10 @@ static void __free_cluster(struct swap_info_struct *si, struct swap_cluster_info
>  	lockdep_assert_held(&si->lock);
>  	lockdep_assert_held(&ci->lock);
>  
> -	list_move_tail(&ci->list, &si->free_clusters);
> +	if (ci->flags)
> +		list_move_tail(&ci->list, &si->free_clusters);
> +	else
> +		list_add_tail(&ci->list, &si->free_clusters);

If we use list_del_init() to delete the cluster, we can always use
list_move_tail()?  If so, the logic can be simplified.

>  	ci->flags = CLUSTER_FLAG_FREE;
>  	ci->order = 0;
>  }
> @@ -474,7 +477,6 @@ static void swap_do_scheduled_discard(struct swap_info_struct *si)
>  				SWAPFILE_CLUSTER);
>  
>  		spin_lock(&si->lock);
> -
>  		spin_lock(&ci->lock);
>  		__free_cluster(si, ci);
>  		memset(si->swap_map + idx * SWAPFILE_CLUSTER,
> @@ -666,7 +668,7 @@ static void cluster_alloc_range(struct swap_info_struct *si, struct swap_cluster
>  		if (ci->flags & CLUSTER_FLAG_FRAG)
>  			si->frag_cluster_nr[ci->order]--;
>  		list_move_tail(&ci->list, &si->full_clusters);
> -		ci->flags = 0;
> +		ci->flags = CLUSTER_FLAG_FULL;
>  	}
>  }

--
Best Regards,
Huang, Ying

