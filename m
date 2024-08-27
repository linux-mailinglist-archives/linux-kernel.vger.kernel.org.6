Return-Path: <linux-kernel+bounces-302515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270DC95FF9E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 05:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DBE9B22153
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 03:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F4F18030;
	Tue, 27 Aug 2024 03:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="B+rBYa8Q"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6A71DA22
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 03:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724728010; cv=none; b=E2DKTNYBjW63ZMmYK5EVgMww64VqU2fWdxIEWuKLbCHMlW1yfo6EGovZqX1cLkmBGk25lKS6KTuLoEGGEjgua6BKQ5eVJh6+oxDlJbNPJ5n5YvVz4Wa2xn9v2NFvTFM8kMLmPtcfOvf0iRuOSn4JsfPuaNssot9ulqwElBVq1nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724728010; c=relaxed/simple;
	bh=LRp0lPuItXBqFMBlwAy2tjdlrOfBJzC3jtR4GKj6cKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rCZIxJfKX9ynhiFQf2FuPO8Nw64bSmR6NF6RGay1FGqbphNhwiFZOT+ZsFUXLXrCJkS79LSpWUA3E6TyGW03O84Qgcuk0CHp9sGKxTYJe++H86K366oYsYzoLXRpWFkJ6wJS+x7lZhHgukgM9sCbA/jnmdzhSyVe166fNe7yDCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=B+rBYa8Q; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724727997; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=StoVR4gs7cahfEfiJN6AgpKDWBI3QRTdteP01wTy10w=;
	b=B+rBYa8QP9UGyzCWYp3enthuBy8/Vg5AsnJR3Y7dJ4K2BTVUrOIY1CfBa0QDkYcwV7SFrDcwY3+ZrGuYtM/7e25xzoHK0AybYonwxCjxzMtLCBUf/eFnb+Nm08stszupKZqiZjaiyg3TMaNfianMzcm/hAQBLzsGNfJ5QSrw/Z0=
Received: from 30.97.56.57(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WDl2qA4_1724727994)
          by smtp.aliyun-inc.com;
          Tue, 27 Aug 2024 11:06:35 +0800
Message-ID: <5b1e9c5a-7f61-4d97-a8d7-41767ca04c77@linux.alibaba.com>
Date: Tue, 27 Aug 2024 11:06:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/9] mm: shmem: support large folio allocation for
 shmem_replace_folio()
To: Hugh Dickins <hughd@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@redhat.com,
 wangkefeng.wang@huawei.com, chrisl@kernel.org, ying.huang@intel.com,
 21cnbao@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com,
 ziy@nvidia.com, ioworker0@gmail.com, da.gomez@samsung.com,
 p.raghav@samsung.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1723434324.git.baolin.wang@linux.alibaba.com>
 <a41138ecc857ef13e7c5ffa0174321e9e2c9970a.1723434324.git.baolin.wang@linux.alibaba.com>
 <ab9070f8-a949-2fb0-5f7b-e392f3242928@google.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ab9070f8-a949-2fb0-5f7b-e392f3242928@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/8/26 06:05, Hugh Dickins wrote:
> On Mon, 12 Aug 2024, Baolin Wang wrote:
> 
>> To support large folio swapin for shmem in the following patches, add
>> large folio allocation for the new replacement folio in shmem_replace_folio().
>> Moreover large folios occupy N consecutive entries in the swap cache
>> instead of using multi-index entries like the page cache, therefore
>> we should replace each consecutive entries in the swap cache instead
>> of using the shmem_replace_entry().
>>
>> As well as updating statistics and folio reference count using the number
>> of pages in the folio.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/shmem.c | 54 +++++++++++++++++++++++++++++++-----------------------
>>   1 file changed, 31 insertions(+), 23 deletions(-)
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index f6bab42180ea..d94f02ad7bd1 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -1889,28 +1889,24 @@ static bool shmem_should_replace_folio(struct folio *folio, gfp_t gfp)
>>   static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
>>   				struct shmem_inode_info *info, pgoff_t index)
>>   {
>> -	struct folio *old, *new;
>> -	struct address_space *swap_mapping;
>> -	swp_entry_t entry;
>> -	pgoff_t swap_index;
>> -	int error;
>> -
>> -	old = *foliop;
>> -	entry = old->swap;
>> -	swap_index = swap_cache_index(entry);
>> -	swap_mapping = swap_address_space(entry);
>> +	struct folio *new, *old = *foliop;
>> +	swp_entry_t entry = old->swap;
>> +	struct address_space *swap_mapping = swap_address_space(entry);
>> +	pgoff_t swap_index = swap_cache_index(entry);
>> +	XA_STATE(xas, &swap_mapping->i_pages, swap_index);
>> +	int nr_pages = folio_nr_pages(old);
>> +	int error = 0, i;
>>   
>>   	/*
>>   	 * We have arrived here because our zones are constrained, so don't
>>   	 * limit chance of success by further cpuset and node constraints.
>>   	 */
>>   	gfp &= ~GFP_CONSTRAINT_MASK;
>> -	VM_BUG_ON_FOLIO(folio_test_large(old), old);
>> -	new = shmem_alloc_folio(gfp, 0, info, index);
>> +	new = shmem_alloc_folio(gfp, folio_order(old), info, index);
> 
> It is not clear to me whether folio_order(old) will ever be more than 0
> here: but if it can be, then care will need to be taken over the gfp flags,

With this patch set, it can be a large folio. If a large folio still 
exists in the swap cache, we will get a large folio during swap in.

And yes, the gfp flags should be updated. How about the following fix?

> that they are suited to allocating the large folio; and there will need to
> be (could be awkward!) fallback to order 0 when that allocation fails.

I do not think we should fallback to order 0 for a large folio, which 
will introduce more complex logic, for example, we should split the 
original large swap entries in shmem mapping, and it is tricky to free 
large swap entries, etc. So I want to keept it simple now.

> My own testing never comes to shmem_replace_folio(): it was originally for
> one lowend graphics driver; but IIRC there's now a more common case for it.

Good to know. Thank you very much for your valuable input.


[PATCH] mm: shmem: fix the gfp flag for large folio allocation

In shmem_replace_folio(), it may be necessary to allocate a large folio,
so we should update the gfp flags to ensure it is suitable for 
allocating the large folio.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
  mm/shmem.c | 18 +++++++++++++-----
  1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index dd384d4ab035..d8038a66b110 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -155,7 +155,7 @@ static unsigned long shmem_default_max_inodes(void)

  static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
                         struct folio **foliop, enum sgp_type sgp, gfp_t 
gfp,
-                       struct mm_struct *fault_mm, vm_fault_t *fault_type);
+                       struct vm_area_struct *vma, vm_fault_t *fault_type);

  static inline struct shmem_sb_info *SHMEM_SB(struct super_block *sb)
  {
@@ -1887,7 +1887,8 @@ static bool shmem_should_replace_folio(struct 
folio *folio, gfp_t gfp)
  }

  static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
-                               struct shmem_inode_info *info, pgoff_t 
index)
+                               struct shmem_inode_info *info, pgoff_t 
index,
+                               struct vm_area_struct *vma)
  {
         struct folio *new, *old = *foliop;
         swp_entry_t entry = old->swap;
@@ -1902,6 +1903,12 @@ static int shmem_replace_folio(struct folio 
**foliop, gfp_t gfp,
          * limit chance of success by further cpuset and node constraints.
          */
         gfp &= ~GFP_CONSTRAINT_MASK;
+       if (nr_pages > 1) {
+               gfp_t huge_gfp = vma_thp_gfp_mask(vma);
+
+               gfp = limit_gfp_mask(huge_gfp, gfp);
+       }
+
         new = shmem_alloc_folio(gfp, folio_order(old), info, index);
         if (!new)
                 return -ENOMEM;
@@ -2073,10 +2080,11 @@ static int shmem_split_large_entry(struct inode 
*inode, pgoff_t index,
   */
  static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
                              struct folio **foliop, enum sgp_type sgp,
-                            gfp_t gfp, struct mm_struct *fault_mm,
+                            gfp_t gfp, struct vm_area_struct *vma,
                              vm_fault_t *fault_type)
  {
         struct address_space *mapping = inode->i_mapping;
+       struct mm_struct *fault_mm = vma ? vma->vm_mm : NULL;
         struct shmem_inode_info *info = SHMEM_I(inode);
         struct swap_info_struct *si;
         struct folio *folio = NULL;
@@ -2162,7 +2170,7 @@ static int shmem_swapin_folio(struct inode *inode, 
pgoff_t index,
         arch_swap_restore(folio_swap(swap, folio), folio);

         if (shmem_should_replace_folio(folio, gfp)) {
-               error = shmem_replace_folio(&folio, gfp, info, index);
+               error = shmem_replace_folio(&folio, gfp, info, index, vma);
                 if (error)
                         goto failed;
         }
@@ -2243,7 +2251,7 @@ static int shmem_get_folio_gfp(struct inode 
*inode, pgoff_t index,

         if (xa_is_value(folio)) {
                 error = shmem_swapin_folio(inode, index, &folio,
-                                          sgp, gfp, fault_mm, fault_type);
+                                          sgp, gfp, vma, fault_type);
                 if (error == -EEXIST)
                         goto repeat;

