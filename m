Return-Path: <linux-kernel+bounces-358596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9AF99814F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 223BAB2649E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0AA1BBBFC;
	Thu, 10 Oct 2024 08:59:18 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCCBB66C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728550757; cv=none; b=ZYcGHnObl2XseG7kA8S3zxTe/wJ1m51jvV4TNWcY2Bcu4UOZw56nUn0aMLmbDhvharK2AYaFc1E8ScFISQ5sLHYm1zmqfFQG/0AlRW3KC63iresijJuQO7Y2kahQXWyf4m9I2CLflU3YZrM7QAtAamxDMRaT3FvLwO6bjYtE9xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728550757; c=relaxed/simple;
	bh=kd95R682gGsFXriE/y/5bGtakgLWfIY8rFjx6eOYHY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qxMsUq8wPgwQUnbyD06l/uTmsvaJAvFhDx54n5sVsOd9O6zPBlnKg666B6WwhFdL+Ez+EiEubSZP824IdUU8AQrd78ZA+ON4aqkb0Y8+bdnjRRxU5fiQB3VMJdH1L9iehf4ysG4Ku/BvSgHU0gx6Uz6qXYtjsRphsnluHs9y/+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XPNtJ3FmCzpWhL;
	Thu, 10 Oct 2024 16:57:12 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 13F011400D8;
	Thu, 10 Oct 2024 16:59:12 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 16:59:11 +0800
Message-ID: <c3f2c5e2-4804-46e8-86ff-1f6a79ea9a7c@huawei.com>
Date: Thu, 10 Oct 2024 16:59:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/vmscan: stop the loop if enough pages have been
 page_out
To: Chen Ridong <chenridong@huaweicloud.com>, <akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<chenridong@huawei.com>, <wangweiyang2@huawei.com>, Michal Hocko
	<mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed
	<yosryahmed@google.com>, Yu Zhao <yuzhao@google.com>, David Hildenbrand
	<david@redhat.com>, Matthew Wilcox <willy@infradead.org>, Ryan Roberts
	<ryan.roberts@arm.com>, Barry Song <baohua@kernel.org>
References: <20241010081802.290893-1-chenridong@huaweicloud.com>
Content-Language: en-US
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20241010081802.290893-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf100008.china.huawei.com (7.185.36.138)

Hi Ridong,

This should be the first version for upstream, and the issue only
occurred when large folio is spited.

Adding more CCs to see if there's more feedback.


On 2024/10/10 16:18, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> An issue was found with the following testing step:
> 1. Compile with CONFIG_TRANSPARENT_HUGEPAGE=y
> 2. Mount memcg v1, and create memcg named test_memcg and set
>     usage_in_bytes=2.1G, memsw.usage_in_bytes=3G.
> 3. Create a 1G swap file, and allocate 2.2G anon memory in test_memcg.
> 
> It was found that:
> 
> cat memory.usage_in_bytes
> 2144940032
> cat memory.memsw.usage_in_bytes
> 2255056896
> 
> free -h
>                total        used        free
> Mem:           31Gi       2.1Gi        27Gi
> Swap:         1.0Gi       618Mi       405Mi
> 
> As shown above, the test_memcg used about 100M swap, but 600M+ swap memory
> was used, which means that 500M may be wasted because other memcgs can not
> use these swap memory.
> 
> It can be explained as follows:
> 1. When entering shrink_inactive_list, it isolates folios from lru from
>     tail to head. If it just takes folioN from lru(make it simple).
> 
>     inactive lru: folio1<->folio2<->folio3...<->folioN-1
>     isolated list: folioN
> 
> 2. In shrink_page_list function, if folioN is THP, it may be splited and
>     added to swap cache folio by folio. After adding to swap cache, it will
>     submit io to writeback folio to swap, which is asynchronous.
>     When shrink_page_list is finished, the isolated folios list will be
>     moved back to the head of inactive lru. The inactive lru may just look
>     like this, with 512 filioes have been move to the head of inactive lru.
> 
>     folioN512<->folioN511<->...filioN1<->folio1<->folio2...<->folioN-1
> 
> 3. When folio writeback io is completed, the folio may be rotated to tail
>     of lru. The following lru list is expected, with those filioes that have
>     been added to swap cache are rotated to tail of lru. So those folios
>     can be reclaimed as soon as possible.
> 
>     folio1<->folio2<->...<->folioN-1<->filioN1<->...folioN511<->folioN512
> 
> 4. However, shrink_page_list and folio writeback are asynchronous. If THP
>     is splited, shrink_page_list loops at least 512 times, which means that
>     shrink_page_list is not completed but some folios writeback have been
>     completed, and this may lead to failure to rotate these folios to the
>     tail of lru. The lru may look likes as below:
> 
>     folioN50<->folioN49<->...filioN1<->folio1<->folio2...<->folioN-1<->
>     folioN51<->folioN52<->...folioN511<->folioN512
> 
>     Although those folios (N1-N50) have been finished writing back, they
>     are still at the head of lru. When isolating folios from lru, it scans
>     from tail to head, so it is difficult to scan those folios again.
> 
> What mentioned above may lead to a large number of folios have been added
> to swap cache but can not be reclaimed in time, which may reduce reclaim
> efficiency and prevent other memcgs from using this swap memory even if
> they trigger OOM.
> 
> To fix this issue, it's better to stop looping if THP has been splited and
> nr_pageout is greater than nr_to_reclaim.
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   mm/vmscan.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 749cdc110c74..fd8ad251eda2 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1047,7 +1047,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>   	LIST_HEAD(demote_folios);
>   	unsigned int nr_reclaimed = 0;
>   	unsigned int pgactivate = 0;
> -	bool do_demote_pass;
> +	bool do_demote_pass, splited = false;
>   	struct swap_iocb *plug = NULL;
>   
>   	folio_batch_init(&free_folios);
> @@ -1065,6 +1065,16 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>   
>   		cond_resched();
>   
> +		/*
> +		 * If a large folio has been split, many folios are added
> +		 * to folio_list. Looping through the entire list takes
> +		 * too much time, which may prevent folios that have completed
> +		 * writeback from rotateing to the tail of the lru. Just
> +		 * stop looping if nr_pageout is greater than nr_to_reclaim.
> +		 */
> +		if (unlikely(splited && stat->nr_pageout > sc->nr_to_reclaim))
> +			break;
> +
>   		folio = lru_to_folio(folio_list);
>   		list_del(&folio->lru);
>   
> @@ -1273,6 +1283,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>   		if ((nr_pages > 1) && !folio_test_large(folio)) {
>   			sc->nr_scanned -= (nr_pages - 1);
>   			nr_pages = 1;
> +			splited = true;
>   		}
>   
>   		/*
> @@ -1375,12 +1386,14 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>   				if (nr_pages > 1 && !folio_test_large(folio)) {
>   					sc->nr_scanned -= (nr_pages - 1);
>   					nr_pages = 1;
> +					splited = true;
>   				}
>   				goto activate_locked;
>   			case PAGE_SUCCESS:
>   				if (nr_pages > 1 && !folio_test_large(folio)) {
>   					sc->nr_scanned -= (nr_pages - 1);
>   					nr_pages = 1;
> +					splited = true;
>   				}
>   				stat->nr_pageout += nr_pages;
>   
> @@ -1491,6 +1504,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>   		if (nr_pages > 1) {
>   			sc->nr_scanned -= (nr_pages - 1);
>   			nr_pages = 1;
> +			splited = true;
>   		}
>   activate_locked:
>   		/* Not a candidate for swapping, so reclaim swap space. */


