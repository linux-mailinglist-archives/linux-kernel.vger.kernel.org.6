Return-Path: <linux-kernel+bounces-518713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 954DFA393AA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56BAB3B32CA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 07:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8369C1ACEB5;
	Tue, 18 Feb 2025 07:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eePwfrfl"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE7033E4
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 07:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739862373; cv=none; b=uG1JkVUCiwXyujau3vRwN12FjRXFf20Rt3nGgQGdjIs+TQB8ko+WMW/JhVYQtLI5M0MXvlwXp0Rz/OnJ1+mGuauK33R184f00Ri0+DcjMKpD26X9SI4aCcYzLDYmaXgQLiICm1ZNGkjUAf6gjkr5CxXbAomtDJrtdDkP1hqM2wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739862373; c=relaxed/simple;
	bh=OxOLf6nGovmG96Y/Nc9k1PszSMNWPW6wXkxHlnHygO8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=UnmFck9cuvAqqDf/3hY7CQ+1qWTZ4AHiOBbNXtW4vHegHDTMSbzafzOY6aXoKR8nid0/a5GdA3JGw80H5l6h095hKOij+SZuHQMTCWPSZKrMDPZYypnzNL284jwLaoCZzq856CPPCn5yVw8Lf0iPQXOJA8qdG4guMN8AdeZvIlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eePwfrfl; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739862366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eyl6WgjL1XiGk5qWO8immzuKe7Gz2yvBndli/Sz5Ra0=;
	b=eePwfrflks+k1sWQ9Br10G/dZioRG/ePOtfm+PclxERTgdiQdzvUwZKwwCFC+pD5s95h2K
	2Jm/Szj8OYfQADNmhKehNbcsXfktHNIv5hRhRuGX37RxYJkSKAzQkmrZd3MD9hxG4qNjKB
	vTv9jTagJvvUOgFCWrciO9vjDPBiO5E=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH V2] mm/hugetlb: wait for hugepage folios to be freed
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <1739604026-2258-1-git-send-email-yangge1116@126.com>
Date: Tue, 18 Feb 2025 15:05:29 +0800
Cc: akpm@linux-foundation.org,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 21cnbao@gmail.com,
 david@redhat.com,
 baolin.wang@linux.alibaba.com,
 osalvador@suse.de,
 liuzixing@hygon.cn
Content-Transfer-Encoding: quoted-printable
Message-Id: <BEEBE7BB-E242-40F0-B752-E878865B56EB@linux.dev>
References: <1739604026-2258-1-git-send-email-yangge1116@126.com>
To: yangge1116@126.com
X-Migadu-Flow: FLOW_OUT



> On Feb 15, 2025, at 15:20, yangge1116@126.com wrote:
>=20
> From: Ge Yang <yangge1116@126.com>
>=20
> Since the introduction of commit b65d4adbc0f0 ("mm: hugetlb: defer =
freeing
> of HugeTLB pages"), which supports deferring the freeing of HugeTLB =
pages,
> the allocation of contiguous memory through cma_alloc() may fail
> probabilistically.
>=20
> In the CMA allocation process, if it is found that the CMA area is =
occupied
> by in-use hugepage folios, these in-use hugepage folios need to be =
migrated
> to another location. When there are no available hugepage folios in =
the
> free HugeTLB pool during the migration of in-use HugeTLB pages, new =
folios
> are allocated from the buddy system. A temporary state is set on the =
newly
> allocated folio. Upon completion of the hugepage folio migration, the
> temporary state is transferred from the new folios to the old folios.
> Normally, when the old folios with the temporary state are freed, it =
is
> directly released back to the buddy system. However, due to the =
deferred
> freeing of HugeTLB pages, the PageBuddy() check fails, ultimately =
leading
> to the failure of cma_alloc().
>=20
> Here is a simplified call trace illustrating the process:
> cma_alloc()
>    ->__alloc_contig_migrate_range() // Migrate in-use hugepage
>        ->unmap_and_move_huge_page()
>            ->folio_putback_hugetlb() // Free old folios
>    ->test_pages_isolated()
>        ->__test_page_isolated_in_pageblock()
>             ->PageBuddy(page) // Check if the page is in buddy
>=20
> To resolve this issue, we have implemented a function named
> wait_for_hugepage_folios_freed(). This function ensures that the =
hugepage
> folios are properly released back to the buddy system after their =
migration
> is completed. By invoking wait_for_hugepage_folios_freed() before =
calling
> PageBuddy(), we ensure that PageBuddy() will succeed.
>=20
> Fixes: b65d4adbc0f0 ("mm: hugetlb: defer freeing of HugeTLB pages")

The actual blamed commit should be the

commit c77c0a8ac4c52 ("mm/hugetlb: defer freeing of huge pages if in =
non-task context")

which is the first to introducing the delayed work to free the hugetlb =
pages.
It was removed by commit db71ef79b59bb2 and then was brought back by =
commit
b65d4adbc0f0 immediately.

> Signed-off-by: Ge Yang <yangge1116@126.com>
> ---
>=20
> V2:
> - flush all folios at once suggested by David
>=20
> include/linux/hugetlb.h |  5 +++++
> mm/hugetlb.c            |  8 ++++++++
> mm/page_isolation.c     | 10 ++++++++++
> 3 files changed, 23 insertions(+)
>=20
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 6c6546b..04708b0 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -697,6 +697,7 @@ bool hugetlb_bootmem_page_zones_valid(int nid, =
struct huge_bootmem_page *m);
>=20
> int isolate_or_dissolve_huge_page(struct page *page, struct list_head =
*list);
> int replace_free_hugepage_folios(unsigned long start_pfn, unsigned =
long end_pfn);
> +void wait_for_hugepage_folios_freed(void);
> struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
> 				unsigned long addr, bool =
cow_from_owner);
> struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int =
preferred_nid,
> @@ -1092,6 +1093,10 @@ static inline int =
replace_free_hugepage_folios(unsigned long start_pfn,
> 	return 0;
> }
>=20
> +static inline void wait_for_hugepage_folios_freed(void)
> +{
> +}
> +
> static inline struct folio *alloc_hugetlb_folio(struct vm_area_struct =
*vma,
>   			unsigned long addr,
>   			bool cow_from_owner)
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 30bc34d..36dd3e4 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2955,6 +2955,14 @@ int replace_free_hugepage_folios(unsigned long =
start_pfn, unsigned long end_pfn)
> return ret;
> }
>=20
> +void wait_for_hugepage_folios_freed(void)

We usually use the "hugetlb" term now instead of "huge_page" to =
differentiate with THP.
So I suggest naming it as wait_for_hugetlb_folios_freed().

> +{
> + 	struct hstate *h;
> +
> + 	for_each_hstate(h)
> + 		flush_free_hpage_work(h);

Because all hstate use the shared work to defer the freeing of hugetlb =
pages, we only
need to flush once. Directly useing flush_work(&free_hpage_work) is =
enough.

> +}
> +
> typedef enum {
> 	/*
> * For either 0/1: we checked the per-vma resv map, and one resv
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index 8ed53ee0..f56cf02 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -615,6 +615,16 @@ int test_pages_isolated(unsigned long start_pfn, =
unsigned long end_pfn,
> int ret;
>=20
> 	/*
> +	 * Due to the deferred freeing of HugeTLB folios, the hugepage =
folios may
> +	 * not immediately release to the buddy system. This can cause =
PageBuddy()
> +	 * to fail in __test_page_isolated_in_pageblock(). To ensure =
that the
> +	 * hugepage folios are properly released back to the buddy =
system, we

hugetlb folios.

Muchun,
Thanks.

> +	 * invoke the wait_for_hugepage_folios_freed() function to wait =
for the
> +	 * release to complete.
> +	 */
> + 	wait_for_hugepage_folios_freed();
> +
> + 	/*
> 	 * Note: pageblock_nr_pages !=3D MAX_PAGE_ORDER. Then, chunks of =
free
> 	 * pages are not aligned to pageblock_nr_pages.
> 	 * Then we just check migratetype first.
> --=20
> 2.7.4
>=20


