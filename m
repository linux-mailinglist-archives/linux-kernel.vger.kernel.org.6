Return-Path: <linux-kernel+bounces-389780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CCC9B7134
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 01:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F4C28215D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 00:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26D81BC20;
	Thu, 31 Oct 2024 00:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PyYI2esn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792C7819
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 00:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730335196; cv=none; b=SDkPGqfg/eKHPcTm2DvaerL9hfs/pVb0BYoi/+8cp3+oBH7bdAX55ZC11QvvUVeHHwodFwlVvgtUHNGhYC5Qe01Yv2VBGPIxbCT7Hn/AMd7irwzRVLhpTdVsrbgLnbfCT5ReD7EfTCEgDAVXgAfJiEQuXEelzfl6rpShcFvk+h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730335196; c=relaxed/simple;
	bh=BVVc/SXQ4JbqD4u61eN858mgOHeLPYYZ0jA5cibVNuE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W+1lAjuS174rh2QvNoTDwVSBbJXkkOMmK88h7PH4gXHVLGrsDEfLF9mYvZqnryKipOmZMrUHhQfmm1W8AvFmrrmUeSesazJilc1L+JqtXaSgkPNlTbLiXDv/SK6LtHv91neeUN7EX802xAvEsvfKCJ+HxuDbc5/Hhn3Ui3nEcww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PyYI2esn; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730335193; x=1761871193;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=BVVc/SXQ4JbqD4u61eN858mgOHeLPYYZ0jA5cibVNuE=;
  b=PyYI2esn7lPzFsF8ZgSo4mcoAsfIxtucZrlxf+DyF97C6pA4bWN/kmqp
   6khXOrS1bH/979VLy7SGl4v5z3N3cPtEwtElDNSrxTqy/gQ5xoWGQM+U3
   CbZvn2fnSK251kDhjWEIbBI4D2CNbV5Tc4qLQZWG+v94Vek3wxd3XXSLf
   kTwMJdkPYUUcipW2lLgI2ev2F+e1nbxSdgQK24JEpD4kAd9WPOnI0PL6A
   QmM8TLnVShVHb1bJPpsZqcw5GKyC85tKIHYiOz+EZHHd8hD0RQHOYD9J8
   t5tg9bLNWC7TR0/6L1aIU1tW5P0hNUA7AEigHfcVFAGdXhOhDmvCd7Cyi
   g==;
X-CSE-ConnectionGUID: PnrVkWvlSw6wjiQKJCDsAg==
X-CSE-MsgGUID: E1i6ZZzdTrOg9Fh471srjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="40637601"
X-IronPort-AV: E=Sophos;i="6.11,246,1725346800"; 
   d="scan'208";a="40637601"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 17:39:53 -0700
X-CSE-ConnectionGUID: 8ldWuHaXQx6I/nZdzXZAXw==
X-CSE-MsgGUID: IWYVHXq2SrW276DWBeKiag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,246,1725346800"; 
   d="scan'208";a="105800185"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 17:39:49 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  Barry Song <v-songbaohua@oppo.com>,
  Baolin Wang <baolin.wang@linux.alibaba.com>,  David Hildenbrand
 <david@redhat.com>,  Chris Li <chrisl@kernel.org>,  Yosry Ahmed
 <yosryahmed@google.com>,  Kairui Song <kasong@tencent.com>,  Ryan Roberts
 <ryan.roberts@arm.com>,  Kanchana P Sridhar
 <kanchana.p.sridhar@intel.com>,  Usama Arif <usamaarif642@gmail.com>
Subject: Re: [PATCH v2] mm: add per-order mTHP swpin counters
In-Reply-To: <20241030233423.80759-1-21cnbao@gmail.com> (Barry Song's message
	of "Thu, 31 Oct 2024 12:34:23 +1300")
References: <20241030233423.80759-1-21cnbao@gmail.com>
Date: Thu, 31 Oct 2024 08:36:16 +0800
Message-ID: <87cyjh9khr.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Barry Song <21cnbao@gmail.com> writes:

> From: Barry Song <v-songbaohua@oppo.com>
>
> This helps profile the sizes of folios being swapped in. Currently,
> only mTHP swap-out is being counted.
> The new interface can be found at:
> /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
>          swpin

This looks strange, why isn't it

/sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats/swpin

?

> For example,
> cat /sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpin
> 12809
> cat /sys/kernel/mm/transparent_hugepage/hugepages-32kB/stats/swpin
> 4763

You miss "$"?

$ cat /sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpin
12809
$ cat /sys/kernel/mm/transparent_hugepage/hugepages-32kB/stats/swpin
4763

> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Cc: Chris Li <chrisl@kernel.org>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Kairui Song <kasong@tencent.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> Cc: Usama Arif <usamaarif642@gmail.com>
> ---
>  -v2:
>  * collect Baolin's reviewed-by and David's acked-by, thanks!
>  * add some examples for the interface in the changelog, Per
>    Huang, Ying. thanks!
>  * add a blank line in doc which was missed in v1.
>
>  Documentation/admin-guide/mm/transhuge.rst | 4 ++++
>  include/linux/huge_mm.h                    | 1 +
>  mm/huge_memory.c                           | 3 +++
>  mm/page_io.c                               | 3 +++
>  4 files changed, 11 insertions(+)
>
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index 2a171ed5206e..5caa3fb2feb1 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -534,6 +534,10 @@ zswpout
>  	is incremented every time a huge page is swapped out to zswap in one
>  	piece without splitting.
>  
> +swpin
> +	is incremented every time a huge page is swapped in from a non-zswap
> +	swap device in one piece.
> +
>  swpout
>  	is incremented every time a huge page is swapped out to a non-zswap
>  	swap device in one piece without splitting.
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index c59e5aa9b081..b94c2e8ee918 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -120,6 +120,7 @@ enum mthp_stat_item {
>  	MTHP_STAT_ANON_FAULT_FALLBACK,
>  	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
>  	MTHP_STAT_ZSWPOUT,
> +	MTHP_STAT_SWPIN,
>  	MTHP_STAT_SWPOUT,
>  	MTHP_STAT_SWPOUT_FALLBACK,
>  	MTHP_STAT_SHMEM_ALLOC,
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index b26c6503e993..f92068864469 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -616,6 +616,7 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_alloc, MTHP_STAT_ANON_FAULT_ALLOC);
>  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
>  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
>  DEFINE_MTHP_STAT_ATTR(zswpout, MTHP_STAT_ZSWPOUT);
> +DEFINE_MTHP_STAT_ATTR(swpin, MTHP_STAT_SWPIN);
>  DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
>  DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
>  #ifdef CONFIG_SHMEM
> @@ -635,6 +636,7 @@ static struct attribute *anon_stats_attrs[] = {
>  	&anon_fault_fallback_charge_attr.attr,
>  #ifndef CONFIG_SHMEM
>  	&zswpout_attr.attr,
> +	&swpin_attr.attr,
>  	&swpout_attr.attr,
>  	&swpout_fallback_attr.attr,
>  #endif
> @@ -666,6 +668,7 @@ static struct attribute_group file_stats_attr_grp = {
>  static struct attribute *any_stats_attrs[] = {
>  #ifdef CONFIG_SHMEM
>  	&zswpout_attr.attr,
> +	&swpin_attr.attr,
>  	&swpout_attr.attr,
>  	&swpout_fallback_attr.attr,
>  #endif
> diff --git a/mm/page_io.c b/mm/page_io.c
> index c69fab5060a1..5d9b6e6cf96c 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -487,6 +487,7 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
>  		for (p = 0; p < sio->pages; p++) {
>  			struct folio *folio = page_folio(sio->bvec[p].bv_page);
>  
> +			count_mthp_stat(folio_order(folio), MTHP_STAT_SWPIN);
>  			count_memcg_folio_events(folio, PSWPIN, folio_nr_pages(folio));
>  			folio_mark_uptodate(folio);
>  			folio_unlock(folio);
> @@ -573,6 +574,7 @@ static void swap_read_folio_bdev_sync(struct folio *folio,
>  	 * attempt to access it in the page fault retry time check.
>  	 */
>  	get_task_struct(current);
> +	count_mthp_stat(folio_order(folio), MTHP_STAT_SWPIN);
>  	count_memcg_folio_events(folio, PSWPIN, folio_nr_pages(folio));
>  	count_vm_events(PSWPIN, folio_nr_pages(folio));
>  	submit_bio_wait(&bio);
> @@ -589,6 +591,7 @@ static void swap_read_folio_bdev_async(struct folio *folio,
>  	bio->bi_iter.bi_sector = swap_folio_sector(folio);
>  	bio->bi_end_io = end_swap_bio_read;
>  	bio_add_folio_nofail(bio, folio, folio_size(folio), 0);
> +	count_mthp_stat(folio_order(folio), MTHP_STAT_SWPIN);
>  	count_memcg_folio_events(folio, PSWPIN, folio_nr_pages(folio));
>  	count_vm_events(PSWPIN, folio_nr_pages(folio));
>  	submit_bio(bio);

--
Best Regards,
Huang, Ying

