Return-Path: <linux-kernel+bounces-320485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E4E970B2A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 03:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D05EB2115A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 01:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEFBBA42;
	Mon,  9 Sep 2024 01:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TNCy29nJ"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE046C8D7
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 01:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725844948; cv=none; b=soymYmvFOnze3fVECSpvTQDWYs0jc/w30AujSTN0Mhs4QiVe1W5BpJ1hOUnZhFGsUJCEFgL+vQJLBoO0Ggo0uxzLSJ3WbTFGZsGk7XTC32oehMZO9o7Ll+WJG0hHNJ5N+0+YFw91n+kFUKROaUi5xVvpEcJOrWQUU+S5Vb32SBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725844948; c=relaxed/simple;
	bh=b1PmgMcpXLm/0Ne9+AZSQIYWcJPcEsIyGh1cxP/mInM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A9G6jFTtvQGNkjGLutAn1FY0jk8X2IWyBhWykURHhXIPFsJZDaS3PTStW4+XBAsVKO6vOUTerjun9eLpX7mnBOJi3gYLVVWE7Ubv3VZs3lXSuBluPa4zPA/gn0z9N3yXiPgvEU12qne/4kOasR1jlLqv3x4Th6ZZgo7QIrLRDMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TNCy29nJ; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725844937; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=80WCtbj8jM9c9NM49mgaWLX8tfT9emUWMYbHRmGHerc=;
	b=TNCy29nJ1pK1Tgs6VpOwBhZLHb+Fy+NNnMT7vhBb6qCqGIqxVWI49saUWJEosm4fOIq5YoD+0POcYBNUx/bCB9Iew8XYMSs29Ch3m3hwlQfgNsp37rq0ZjEAKZ1mQBDi7k+hYXkl4HOBoRKPXH3TEva/MbeyrJGT9UPC+MrLeqg=
Received: from 30.74.144.122(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WEVg-uL_1725844936)
          by smtp.aliyun-inc.com;
          Mon, 09 Sep 2024 09:22:17 +0800
Message-ID: <e8761f5a-3a7a-4ca5-9e38-325a0d2d2386@linux.alibaba.com>
Date: Mon, 9 Sep 2024 09:22:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: shmem: fix khugepaged activation policy for shmem
To: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, david@redhat.com, 21cnbao@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <7c796904528e21152ba5aa639e963e0ae45b7040.1725600217.git.baolin.wang@linux.alibaba.com>
 <58cf63c1-25e5-4958-96cb-a9d65390ca3e@arm.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <58cf63c1-25e5-4958-96cb-a9d65390ca3e@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/9/6 16:55, Ryan Roberts wrote:
> On 06/09/2024 06:28, Baolin Wang wrote:
>> Shmem has a separate interface (different from anonymous pages) to control
>> huge page allocation, that means shmem THP can be enabled while anonymous
>> THP is disabled. However, in this case, khugepaged will not start to collapse
>> shmem THP, which is unreasonable.
>>
>> To fix this issue, we should call start_stop_khugepaged() to activate or
>> deactivate the khugepaged thread when setting shmem mTHP interfaces.
>> Moreover, add a new helper shmem_hpage_pmd_enabled() to help to check
>> whether shmem THP is enabled, which will determine if khugepaged should
>> be activated.
>>
>> Reported-by: Ryan Roberts <ryan.roberts@arm.com>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>> Hi Ryan,
>>
>> I remember we discussed the shmem khugepaged activation issue before, but
>> I haven’t seen any follow-up patches to fix it. Recently, I am trying to
>> fix the shmem mTHP collapse issue in the series [1], and I also addressed
>> this activation issue. Please correct me if you have a better idea. Thanks.
> 
> Thanks for for sorting this - it looks like a good approach to me! Just a couple
> of nits. Regardless:
> 
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

Thanks for reviewing.

> 
>>
>> [1] https://lore.kernel.org/all/cover.1724140601.git.baolin.wang@linux.alibaba.com/T/#u
>> ---
>>   include/linux/shmem_fs.h |  6 ++++++
>>   mm/khugepaged.c          |  2 ++
>>   mm/shmem.c               | 29 +++++++++++++++++++++++++++--
>>   3 files changed, 35 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
>> index 515a9a6a3c6f..ee6635052383 100644
>> --- a/include/linux/shmem_fs.h
>> +++ b/include/linux/shmem_fs.h
>> @@ -114,6 +114,7 @@ int shmem_unuse(unsigned int type);
>>   unsigned long shmem_allowable_huge_orders(struct inode *inode,
>>   				struct vm_area_struct *vma, pgoff_t index,
>>   				loff_t write_end, bool shmem_huge_force);
>> +bool shmem_hpage_pmd_enabled(void);
>>   #else
>>   static inline unsigned long shmem_allowable_huge_orders(struct inode *inode,
>>   				struct vm_area_struct *vma, pgoff_t index,
>> @@ -121,6 +122,11 @@ static inline unsigned long shmem_allowable_huge_orders(struct inode *inode,
>>   {
>>   	return 0;
>>   }
>> +
>> +static inline bool shmem_hpage_pmd_enabled(void)
>> +{
>> +	return false;
>> +}
>>   #endif
>>   
>>   #ifdef CONFIG_SHMEM
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index f9c39898eaff..caf10096d4d1 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -430,6 +430,8 @@ static bool hugepage_pmd_enabled(void)
>>   	if (test_bit(PMD_ORDER, &huge_anon_orders_inherit) &&
>>   	    hugepage_global_enabled())
>>   		return true;
>> +	if (shmem_hpage_pmd_enabled())
>> +		return true;
> 
> nit: There is a comment at the top of this function, perhaps that could be
> extended to cover shmem too?

Sure. How about the following changes?

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 945c0f2aff81..b0ac46ae561b 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -416,9 +416,11 @@ static inline int 
hpage_collapse_test_exit_or_disable(struct mm_struct *mm)
  static bool hugepage_pmd_enabled(void)
  {
         /*
-        * We cover both the anon and the file-backed case here; file-backed
+        * We cover the anon, shmem and the file-backed case here; 
file-backed
          * hugepages, when configured in, are determined by the global 
control.
          * Anon pmd-sized hugepages are determined by the pmd-size control.
+        * Shmem pmd-sized hugepages are also determined by its pmd-size 
control,
+        * except when the global shmem_huge is set to SHMEM_HUGE_DENY.
          */
         if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
             hugepage_global_enabled())

>>   	return false;
>>   }
>>   
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 74f093d88c78..d7c342ae2b37 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -1653,6 +1653,23 @@ static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp)
>>   }
>>   
>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +bool shmem_hpage_pmd_enabled(void)
>> +{
>> +	if (shmem_huge == SHMEM_HUGE_DENY)
>> +		return false;
>> +	if (test_bit(HPAGE_PMD_ORDER, &huge_shmem_orders_always))
> 
> question: When is it correct to use HPAGE_PMD_ORDER vs PMD_ORDER? I tend to use
> PMD_ORDER (in hugepage_pmd_enabled() for example).

In shmem, the HPAGE_PMD_* related macros are all controlled by 
CONFIG_TRANSPARENT_HUGEPAGE, and at this point, HPAGE_PMD_ORDER and 
PMD_ORDER are equal. I would like to keep consistency in the shmem code 
by using the HPAGE_PMD_* related macros.

