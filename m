Return-Path: <linux-kernel+bounces-383977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 816B19B22B9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 03:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE78E1C211D6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 02:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CA1156F3C;
	Mon, 28 Oct 2024 02:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hKVMhQBT"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D0B374FF
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 02:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730082566; cv=none; b=lNy6zfxbxL2+DWZ7t5LsIWnRygS/CvhJjvPvWXw5H9UyMVxf6qLliMlDsLN4ZpfwrTVoWO9BVf3Z0mCwN0RL1U4QkAkXT1cYQrQTHUDn+zcDZkcuiEa8jG7z6S1NLclZ7pJC7k8SCHm747+sklWEbPJmxUedBGZcI2mSLawYPO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730082566; c=relaxed/simple;
	bh=ZHSv9Xu1PFvwTAmvaFu/PaWhs9wKQRlU/HEVz+jswIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rgHKZvRgNHuQJ/X0zFzEZyZkK2ncTIDXYB3yzCCbcVLUMgzWrnAq3QqxojG1xkiSi7dQ5l6eMYZnvosJRzsmzyKyEOs7+cHpuoz4HtCEil39lE7depHd1T4uYX59rMdmT4NKvT7oZPeLdaezhkD81P3Qf7IgIFXBYmfzGBqT70w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hKVMhQBT; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730082555; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qrUz0Mm8myz58np+kw3p9Sjhn9DNIeB0R92nfRVgAU8=;
	b=hKVMhQBTt74lFLAgX1iiW8QKAs9wCTGyrxylS0oM6MLorLWri1z7QDmgi31s9FQ/sYnrrzv2MwE0zYwXrZcmqt0Ey5lwIxDhkNJ1XYrF8/is11/0Hg3gfWdOy+jH/0DaycPMYblJIBkEPLE3zvRMQd0hrrgDNRM1b5AoCVVFU5c=
Received: from 30.74.144.158(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WHzA9IO_1730082552 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 28 Oct 2024 10:29:13 +0800
Message-ID: <73ddad71-47c2-4258-bfc3-a5c5283689fb@linux.alibaba.com>
Date: Mon, 28 Oct 2024 10:29:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: add per-order mTHP swpin counters
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 David Hildenbrand <david@redhat.com>, Chris Li <chrisl@kernel.org>,
 Yosry Ahmed <yosryahmed@google.com>, "Huang, Ying" <ying.huang@intel.com>,
 Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
 Usama Arif <usamaarif642@gmail.com>
References: <20241026082423.26298-1-21cnbao@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20241026082423.26298-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/10/26 16:24, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> This helps profile the sizes of folios being swapped in. Currently,
> only mTHP swap-out is being counted.
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Chris Li <chrisl@kernel.org>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Kairui Song <kasong@tencent.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> Cc: Usama Arif <usamaarif642@gmail.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

Looks reasonable to me.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   Documentation/admin-guide/mm/transhuge.rst | 3 +++
>   include/linux/huge_mm.h                    | 1 +
>   mm/huge_memory.c                           | 3 +++
>   mm/page_io.c                               | 3 +++
>   4 files changed, 10 insertions(+)
> 
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index 2a171ed5206e..203ba7aaf5fc 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -533,6 +533,9 @@ anon_fault_fallback_charge
>   zswpout
>   	is incremented every time a huge page is swapped out to zswap in one
>   	piece without splitting.
> +swpin
> +	is incremented every time a huge page is swapped in from a non-zswap
> +	swap device in one piece.
>   
>   swpout
>   	is incremented every time a huge page is swapped out to a non-zswap
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index c59e5aa9b081..b94c2e8ee918 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -120,6 +120,7 @@ enum mthp_stat_item {
>   	MTHP_STAT_ANON_FAULT_FALLBACK,
>   	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
>   	MTHP_STAT_ZSWPOUT,
> +	MTHP_STAT_SWPIN,
>   	MTHP_STAT_SWPOUT,
>   	MTHP_STAT_SWPOUT_FALLBACK,
>   	MTHP_STAT_SHMEM_ALLOC,
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 830d6aa5bf97..846c1a43f61c 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -616,6 +616,7 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_alloc, MTHP_STAT_ANON_FAULT_ALLOC);
>   DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
>   DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
>   DEFINE_MTHP_STAT_ATTR(zswpout, MTHP_STAT_ZSWPOUT);
> +DEFINE_MTHP_STAT_ATTR(swpin, MTHP_STAT_SWPIN);
>   DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
>   DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
>   #ifdef CONFIG_SHMEM
> @@ -635,6 +636,7 @@ static struct attribute *anon_stats_attrs[] = {
>   	&anon_fault_fallback_charge_attr.attr,
>   #ifndef CONFIG_SHMEM
>   	&zswpout_attr.attr,
> +	&swpin_attr.attr,
>   	&swpout_attr.attr,
>   	&swpout_fallback_attr.attr,
>   #endif
> @@ -666,6 +668,7 @@ static struct attribute_group file_stats_attr_grp = {
>   static struct attribute *any_stats_attrs[] = {
>   #ifdef CONFIG_SHMEM
>   	&zswpout_attr.attr,
> +	&swpin_attr.attr,
>   	&swpout_attr.attr,
>   	&swpout_fallback_attr.attr,
>   #endif
> diff --git a/mm/page_io.c b/mm/page_io.c
> index c69fab5060a1..5d9b6e6cf96c 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -487,6 +487,7 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
>   		for (p = 0; p < sio->pages; p++) {
>   			struct folio *folio = page_folio(sio->bvec[p].bv_page);
>   
> +			count_mthp_stat(folio_order(folio), MTHP_STAT_SWPIN);
>   			count_memcg_folio_events(folio, PSWPIN, folio_nr_pages(folio));
>   			folio_mark_uptodate(folio);
>   			folio_unlock(folio);
> @@ -573,6 +574,7 @@ static void swap_read_folio_bdev_sync(struct folio *folio,
>   	 * attempt to access it in the page fault retry time check.
>   	 */
>   	get_task_struct(current);
> +	count_mthp_stat(folio_order(folio), MTHP_STAT_SWPIN);
>   	count_memcg_folio_events(folio, PSWPIN, folio_nr_pages(folio));
>   	count_vm_events(PSWPIN, folio_nr_pages(folio));
>   	submit_bio_wait(&bio);
> @@ -589,6 +591,7 @@ static void swap_read_folio_bdev_async(struct folio *folio,
>   	bio->bi_iter.bi_sector = swap_folio_sector(folio);
>   	bio->bi_end_io = end_swap_bio_read;
>   	bio_add_folio_nofail(bio, folio, folio_size(folio), 0);
> +	count_mthp_stat(folio_order(folio), MTHP_STAT_SWPIN);
>   	count_memcg_folio_events(folio, PSWPIN, folio_nr_pages(folio));
>   	count_vm_events(PSWPIN, folio_nr_pages(folio));
>   	submit_bio(bio);

