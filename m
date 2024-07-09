Return-Path: <linux-kernel+bounces-245074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8322B92ADEF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 03:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D66D4281201
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 01:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE2F2BAE3;
	Tue,  9 Jul 2024 01:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aIZY6EX4"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C784A05
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 01:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720489742; cv=none; b=ftjCYTq+QRp9duvAeiW2RpBWhBwZcY9cYTHEFtxh+YcA6EFFz8YEDlp6I9E00pg4IzwtX9bkLY+uYRH41A4xe/x8zTDrgxc5QBVNImZteM42qJaxSvaLpLLF/hZKPu7wiLUoGedh5geUxdnigQS8XLb+i47tBlgHxOuVWqs9SnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720489742; c=relaxed/simple;
	bh=qCjFDeRipwfRqTSx4+MX3Ax3jzsGz5LiyDTMeFejz1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VWuZKMcZeph7uqWaVJKeijRn1UbN+VkZyoY1pIuC5CL+CMXBAgUx1YC3yvQXowYomn81ac61Q4YZEyU5frNvcsXBprEeA66xF7/CGRwnv5Kc9YINxvz56trvSfyvpyTiuAyJTte2eq4Gna9HF4elxXIPBqK6Odl4eNKcAZoXY4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aIZY6EX4; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720489736; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3zCVRopH8rldnh7e3UYS9KcHE12Nh6EGAjAplapUpmA=;
	b=aIZY6EX4u+j55kf0oAOhxcuDM/stohfO0gs5TGYLIwt1oug1Dg+0yNifAo+mP6jabRlu1tgSIJl2xoR+0w/DtsNkSRJpIFHnqWOvb/bJrYUkgV+buUbFxbeBDiv7vgG8hQYA870duOvk1+PybHvmdylzATXYsf5K2+AG3Q21sCM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0WA9qAr5_1720489735;
Received: from 30.97.56.68(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WA9qAr5_1720489735)
          by smtp.aliyun-inc.com;
          Tue, 09 Jul 2024 09:48:55 +0800
Message-ID: <4e30c29c-e310-4391-9d3c-09753f173770@linux.alibaba.com>
Date: Tue, 9 Jul 2024 09:48:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/migrate: Putback split folios when numa hint migration
 fails
To: Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Yang Shi <shy828301@gmail.com>, Hugh Dickins <hughd@google.com>,
 Huang Ying <ying.huang@intel.com>, David Hildenbrand <david@redhat.com>
References: <20240708215537.2630610-1-peterx@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240708215537.2630610-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/7/9 05:55, Peter Xu wrote:
> This issue is not from any report yet, but by code observation only.
> 
> This is yet another fix besides Hugh's patch [1] but on relevant code path,
> where eager split of folio can happen if the folio is already on deferred
> list during a folio migration.
> 
> Here the issue is NUMA path (migrate_misplaced_folio()) may start to
> encounter such folio split now even with MR_NUMA_MISPLACED hint applied.
> Then when migrate_pages() didn't migrate all the folios, it's possible the
> split small folios be put onto the list instead of the original folio.
> Then putting back only the head page won't be enough.
> 
> Fix it by putting back all the folios on the list.
> 
> [1] https://lore.kernel.org/all/46c948b4-4dd8-6e03-4c7b-ce4e81cfa536@google.com/
> 
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Fixes: 7262f208ca68 ("mm/migrate: split source folio if it is on deferred split list")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

Good catch. With fixing the building issue pointed by Andrew, please 
feel free to add:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> 
> Don't need to copy stable if this can still hit 6.10..  Only smoke tested.
> ---
>   mm/migrate.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index e10d2445fbd8..20da2595527a 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2615,14 +2615,8 @@ int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
>   	nr_remaining = migrate_pages(&migratepages, alloc_misplaced_dst_folio,
>   				     NULL, node, MIGRATE_ASYNC,
>   				     MR_NUMA_MISPLACED, &nr_succeeded);
> -	if (nr_remaining) {
> -		if (!list_empty(&migratepages)) {
> -			list_del(&folio->lru);
> -			node_stat_mod_folio(folio, NR_ISOLATED_ANON +
> -					folio_is_file_lru(folio), -nr_pages);
> -			folio_putback_lru(folio);
> -		}
> -	}
> +	if (nr_remaining && !list_empty(&migratepages))

Nit: you can drop the '!list_empty(&migratepages)' validation, since 
putback_movable_pages() can handle this unusual case.

> +		putback_movable_pages(&migratepages);
>   	if (nr_succeeded) {
>   		count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
>   		if (!node_is_toptier(folio_nid(folio)) && node_is_toptier(node))

