Return-Path: <linux-kernel+bounces-185847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642C88CBBD5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 09:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DA552828B8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 07:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2EB79B84;
	Wed, 22 May 2024 07:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="goy//SBk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B959474C14
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 07:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716362283; cv=none; b=mIJa0dFHLMJ+lrX65F8MN9KrEAR1WhfHQsuTc3y2E5XG6ZkFVWo6sHMFYxuNqk1+uj56v+4/pZA25WQTDgrhj3obIFQ2D0XbdOgSnqaTNHK18/jgLoclge9T0tu82Mj0JigWpWSkjhv9G7zh6XeLAZganqvQbE1YbD7Du+DGxzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716362283; c=relaxed/simple;
	bh=r3l/ggpM98iN9cvyHo4cv5BChwmtMqwhd9kq2chKAZo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CodvzssvlXPhJngdEVQwtsRGkpB1R8VTrXs2XTerR8oo4boKevcr04R3VN3hfUXKfX/k8c8VUeJoAUHrjhzsJsVRWMc7o0dcSvMklhy8R3fNYx2kDwJR8tqgtGG2ds1u7uAKlyfLFBj8k9n5hlzq/6SiLWjRTaruJh4JuE4EBa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=goy//SBk; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716362282; x=1747898282;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=r3l/ggpM98iN9cvyHo4cv5BChwmtMqwhd9kq2chKAZo=;
  b=goy//SBkWpV30loaD0W+M0HURv1Gn7rDCpXptl8TDDFzqe3nyw8wh6fa
   EGE0HCqvDgDwwRgMRbciV+6JxLvFAcWD+AlEjD61H9kj59W0pzDCky6+C
   45uwVQYi2oqpHWQxV7wbv4aGxrk00Gh7pmrJRwlCi/fm37JbtQhwGOzVg
   6PAPD2u3SZ8x4ObABRFjrbXO4jnj/JBmjMMOYiwkdU9T8zpj9KQJjEZOB
   cuULSfvjam6kVDZ2otBdjE3PRB/nE4e341N0wO6lE9eg2/MnWlIEfrr9P
   bSZOpYAOWUaNG5088TT/HSbq6FkdmfyDadBgymS3sCW1CXWtSoN/MCeI2
   g==;
X-CSE-ConnectionGUID: 2AUF7EuwRde7ni92lr6lmw==
X-CSE-MsgGUID: nCk03wFJSg6I4zsUHvmRcA==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="16423319"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="16423319"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 00:18:01 -0700
X-CSE-ConnectionGUID: x4GNIGASR5GBST9anVjgAA==
X-CSE-MsgGUID: H/fnTJoAQx+f85lBEKbvqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="33783486"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 00:17:57 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org,  hughd@google.com,  <willy@infradead.org>,
  <david@redhat.com>,  <ioworker0@gmail.com>,  <hrisl@kernel.org>,
  <p.raghav@samsung.com>,  <da.gomez@samsung.com>,
  <wangkefeng.wang@huawei.com>,  <21cnbao@gmail.com>,
  <ryan.roberts@arm.com>,  <shy828301@gmail.com>,  <ziy@nvidia.com>,
  <linux-mm@kvack.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/8] mm: fix shmem swapout statistic
In-Reply-To: <f467d0e9a021f4bd95588b9d888f1740fab3e3bc.1716285099.git.baolin.wang@linux.alibaba.com>
	(Baolin Wang's message of "Tue, 21 May 2024 19:03:11 +0800")
References: <cover.1716285099.git.baolin.wang@linux.alibaba.com>
	<f467d0e9a021f4bd95588b9d888f1740fab3e3bc.1716285099.git.baolin.wang@linux.alibaba.com>
Date: Wed, 22 May 2024 15:16:05 +0800
Message-ID: <87le42b9l6.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> As we know, shmem not only supports the sharing of anonymous pages, but also
> the RAM-based temporary filesystem. Therefore, shmem swapouts should not be
> marked as anonymous swapout statistics. Fix it by adding folio_test_anon().
>
> Fixes: d0f048ac39f6 ("mm: add per-order mTHP anon_swpout and anon_swpout_fallback counters")
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/page_io.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 46c603dddf04..b181b81f39e3 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -217,7 +217,9 @@ static inline void count_swpout_vm_event(struct folio *folio)
>  		count_memcg_folio_events(folio, THP_SWPOUT, 1);
>  		count_vm_event(THP_SWPOUT);
>  	}
> -	count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_SWPOUT);
> +
> +	if (folio_test_anon(folio))
> +		count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_SWPOUT);

Do we need to distinguish anonymous swapout and non-anonymous swapout?
IMHO, we don't.  Just like we have done for small folio and THP.

If so, how about fix this in another direction?  That is, remove "ANON"
from mTHP swapout statistics?

>  #endif
>  	count_vm_events(PSWPOUT, folio_nr_pages(folio));
>  }

--
Best Regards,
Huang, Ying

