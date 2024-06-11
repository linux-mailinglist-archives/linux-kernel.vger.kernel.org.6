Return-Path: <linux-kernel+bounces-209220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39498902F22
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 05:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B6EEB20F0E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 03:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC483139CE2;
	Tue, 11 Jun 2024 03:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Qu5BMh5v"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB0423D2
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 03:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718076707; cv=none; b=tOCbpgDrrNGQGWzZ9mHmsFJMvRltL6AwJIUPxDhXc5Jk7tXglZr4dwCQMTj5yuX13w/x5386uc9Qq1af1R8CVLnXTOA+7DRJQMLYbh4QHWUVMn+YpX2rfouHQcOUPUTbtbFxEnTGSGSTy9lpWCXj3/wL0EQSVwpW8jGg5hQrLxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718076707; c=relaxed/simple;
	bh=XYRgPRqsUZtl/GLL2YXIuGD5Izp4hyFdPEYTD+nVN8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UJvDtnokfHJs+4tw8j7lW6qw75oX/xoF9dUTbZFd/4VKFIaaMUH56H7Fv4VefX2eOtD+LpXQmkAXexOC1Cq5gSd+vVn8r70hnsrPW1cr74+PKyyNsTMhCJGIee35QVqhByZS+ExHqoK9FoZ3TrImPffBzyBlLunPp6G9t0+b4n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Qu5BMh5v; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718076703; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=V4mjA+2MP8zAV5Ww2U2WGaYSldk2hCBukxkFLeMugYE=;
	b=Qu5BMh5v85oodHnegWj1ru9uZDVvHOMCKajPzZlG9eBaaa2Ig0JGgadK/puSKD9yM2NwGaxWh7+MSKmFzi6n14LRL+RzhytXXzWgjf4JuzmTo0e2NX92QL8xzqMhRog4AbTuIMK6/3CH1QolatOKR1B5IZGO9At4zmPQ9g7Zg1Q=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W8EoriA_1718076700;
Received: from 30.97.56.68(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8EoriA_1718076700)
          by smtp.aliyun-inc.com;
          Tue, 11 Jun 2024 11:31:41 +0800
Message-ID: <99ba4e0d-ef36-4516-a275-014cf5eb22fd@linux.alibaba.com>
Date: Tue, 11 Jun 2024 11:31:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] mm: add new 'orders' parameter for find_get_entries()
 and find_lock_entries()
To: Daniel Gomez <da.gomez@samsung.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "hughd@google.com" <hughd@google.com>,
 "willy@infradead.org" <willy@infradead.org>,
 "david@redhat.com" <david@redhat.com>,
 "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
 "chrisl@kernel.org" <chrisl@kernel.org>,
 "ying.huang@intel.com" <ying.huang@intel.com>,
 "21cnbao@gmail.com" <21cnbao@gmail.com>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "shy828301@gmail.com" <shy828301@gmail.com>, "ziy@nvidia.com"
 <ziy@nvidia.com>, "ioworker0@gmail.com" <ioworker0@gmail.com>,
 Pankaj Raghav <p.raghav@samsung.com>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1717673614.git.baolin.wang@linux.alibaba.com>
 <5304c4c54868336985b396d2c46132c2e0cdf803.1717673614.git.baolin.wang@linux.alibaba.com>
 <CGME20240610152307eucas1p10417f113fcc5e1729bdf638f370d54e4@eucas1p1.samsung.com>
 <v3dqmzgrfpqmfckqnl4voelofevm56q4n4lbk2fq5o5rfclylb@wmtz6ms22ep2>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <v3dqmzgrfpqmfckqnl4voelofevm56q4n4lbk2fq5o5rfclylb@wmtz6ms22ep2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/10 23:23, Daniel Gomez wrote:
> Hi Baolin,
> 
> On Thu, Jun 06, 2024 at 07:58:55PM +0800, Baolin Wang wrote:
>> In the following patches, shmem will support the swap out of large folios,
>> which means the shmem mappings may contain large order swap entries, so an
>> 'orders' array is added for find_get_entries() and find_lock_entries() to
>> obtain the order size of shmem swap entries, which will help in the release
>> of shmem large folio swap entries.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/filemap.c  | 27 +++++++++++++++++++++++++--
>>   mm/internal.h |  4 ++--
>>   mm/shmem.c    | 17 +++++++++--------
>>   mm/truncate.c |  8 ++++----
>>   4 files changed, 40 insertions(+), 16 deletions(-)
>>
>> diff --git a/mm/filemap.c b/mm/filemap.c
>> index 37061aafd191..47fcd9ee6012 100644
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -2036,14 +2036,24 @@ static inline struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,
>>    * Return: The number of entries which were found.
>>    */
>>   unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
>> -		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices)
>> +		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices,
>> +		int *orders)
>>   {
>>   	XA_STATE(xas, &mapping->i_pages, *start);
>>   	struct folio *folio;
>> +	int order;
>>   
>>   	rcu_read_lock();
>>   	while ((folio = find_get_entry(&xas, end, XA_PRESENT)) != NULL) {
>>   		indices[fbatch->nr] = xas.xa_index;
>> +		if (orders) {
>> +			if (!xa_is_value(folio))
>> +				order = folio_order(folio);
>> +			else
>> +				order = xa_get_order(xas.xa, xas.xa_index);
>> +
>> +			orders[fbatch->nr] = order;
>> +		}
>>   		if (!folio_batch_add(fbatch, folio))
>>   			break;
>>   	}
>> @@ -2056,6 +2066,8 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
>>   		folio = fbatch->folios[idx];
>>   		if (!xa_is_value(folio))
>>   			nr = folio_nr_pages(folio);
>> +		else if (orders)
>> +			nr = 1 << orders[idx];
>>   		*start = indices[idx] + nr;
>>   	}
>>   	return folio_batch_count(fbatch);
>> @@ -2082,10 +2094,12 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
>>    * Return: The number of entries which were found.
>>    */
>>   unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
>> -		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices)
>> +		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices,
>> +		int *orders)
>>   {
>>   	XA_STATE(xas, &mapping->i_pages, *start);
>>   	struct folio *folio;
>> +	int order;
>>   
>>   	rcu_read_lock();
>>   	while ((folio = find_get_entry(&xas, end, XA_PRESENT))) {
>> @@ -2099,9 +2113,16 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
>>   			if (folio->mapping != mapping ||
>>   			    folio_test_writeback(folio))
>>   				goto unlock;
>> +			if (orders)
>> +				order = folio_order(folio);
>>   			VM_BUG_ON_FOLIO(!folio_contains(folio, xas.xa_index),
>>   					folio);
>> +		} else if (orders) {
>> +			order = xa_get_order(xas.xa, xas.xa_index);
>>   		}
>> +
>> +		if (orders)
>> +			orders[fbatch->nr] = order;
>>   		indices[fbatch->nr] = xas.xa_index;
>>   		if (!folio_batch_add(fbatch, folio))
>>   			break;
>> @@ -2120,6 +2141,8 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
>>   		folio = fbatch->folios[idx];
>>   		if (!xa_is_value(folio))
>>   			nr = folio_nr_pages(folio);
>> +		else if (orders)
>> +			nr = 1 << orders[idx];
>>   		*start = indices[idx] + nr;
>>   	}
>>   	return folio_batch_count(fbatch);
>> diff --git a/mm/internal.h b/mm/internal.h
>> index 3419c329b3bc..0b5adb6c33cc 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -339,9 +339,9 @@ static inline void force_page_cache_readahead(struct address_space *mapping,
>>   }
>>   
>>   unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
>> -		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
>> +		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices, int *orders);
>>   unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
>> -		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
>> +		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices, int *orders);
>>   void filemap_free_folio(struct address_space *mapping, struct folio *folio);
>>   int truncate_inode_folio(struct address_space *mapping, struct folio *folio);
>>   bool truncate_inode_partial_folio(struct folio *folio, loff_t start,
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 0ac71580decb..28ba603d87b8 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -840,14 +840,14 @@ static void shmem_delete_from_page_cache(struct folio *folio, void *radswap)
>>    * Remove swap entry from page cache, free the swap and its page cache.
>>    */
>>   static int shmem_free_swap(struct address_space *mapping,
>> -			   pgoff_t index, void *radswap)
>> +			   pgoff_t index, void *radswap, int order)
>>   {
>>   	void *old;
> 
> Matthew Wilcox suggested [1] returning the number of pages freed in shmem_free_swap().
> 
> [1] https://lore.kernel.org/all/ZQRf2pGWurrE0uO+@casper.infradead.org/
> 
> Which I submitted here:
> https://lore.kernel.org/all/20231028211518.3424020-5-da.gomez@samsung.com/
> 
> Do you agree with the suggestion? If so, could we update my patch to use
> free_swap_and_cache_nr() or include that here?

Yes, this looks good to me. But we still need some modification for 
find_lock_entries() and find_get_entries() to update the '*start' 
correctly. I will include your changes into this patch in next version. 
Thanks.

