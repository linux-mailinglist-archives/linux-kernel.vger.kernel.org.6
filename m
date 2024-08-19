Return-Path: <linux-kernel+bounces-291835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1970C9567C7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AE2AB21E8E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1737115B147;
	Mon, 19 Aug 2024 10:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iWu3Lnso"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D05C33C0
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 10:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724061908; cv=none; b=GTFLRi8VRAHDjkF5B+OItV0XigClW7Haqd9I8Za2CjmmYYz5i/Ax1qqyeP5ei1ovu3C0fHR4K+m/tV4X3+vBMvhE2E3Mi/WzPn2ZdD6SmaAQh2LMKps9iLE/95jZ5U/QnsEdCQGumqRTDzIA+9T9twxhb9E7KkUzV2XBvuSKeZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724061908; c=relaxed/simple;
	bh=liHq5bpT95/0+z2SFRHqocFxeOo1NvcbshDwkxiN62s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hT35AbpVXLRCdPzIAIEW4SVgJYqv8eR3CKVSwa8b+oGVo3jP4DzeHx/Rqy5QmM8mwa27dVLw5sw6GX2LYpWbxck1zLlWYayfNhnZJJoqXRdnW6EhQ6zMr7lALO4jVouU+1kor9G2inkNMyk8zvy1bBmJ5vGvsIDvTI0D4G8apgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iWu3Lnso; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724061903; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=MCjqsG6JtfvWAirwZ/LCpeLTqCVtGz+HtJHJeKy+33A=;
	b=iWu3LnsoqLTo0fiTnZZsJkpAJvqLNyfMgpi0fzappdoKR/F+aGiC4XI18Pk0Ht02gI8oObhgT+sxrmN9UxNMd+H7OpMyjlhD41n342cyDqQupUkIIvs9ZsuMWluG4G6nYJZ9cgRkrEBYzsnIuN+vZtG5N7KO3EiAHXNXuWMagTk=
Received: from 30.97.56.67(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WDA.YfX_1724061901)
          by smtp.aliyun-inc.com;
          Mon, 19 Aug 2024 18:05:02 +0800
Message-ID: <3802c50b-325e-491f-9f8d-8ab309121935@linux.alibaba.com>
Date: Mon, 19 Aug 2024 18:05:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] mm: khugepaged: use the number of pages in the folio
 to check the reference count
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc: hughd@google.com, willy@infradead.org, 21cnbao@gmail.com,
 ryan.roberts@arm.com, shy828301@gmail.com, ziy@nvidia.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1724054125.git.baolin.wang@linux.alibaba.com>
 <c6038c7e823d4162f745147628616f7876585a97.1724054125.git.baolin.wang@linux.alibaba.com>
 <966bfe10-6123-48db-95b7-ade2f794700d@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <966bfe10-6123-48db-95b7-ade2f794700d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/8/19 17:40, David Hildenbrand wrote:
> On 19.08.24 10:14, Baolin Wang wrote:
>> Use the number of pages in the folio to check the reference count as
>> preparation for supporting shmem mTHP collapse.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/khugepaged.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index f11b4f172e61..60d95f08610c 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -1994,7 +1994,7 @@ static int collapse_file(struct mm_struct *mm, 
>> unsigned long addr,
>>           /*
>>            * We control three references to the folio:
> 
> ^ "three" is wrong now.

Ah, good catch. Will change to '2 + nr_pages'.

> 
>>            *  - we hold a pin on it;
>> -         *  - one reference from page cache;
>> +         *  - nr_pages reference from page cache;
>>            *  - one from lru_isolate_folio;
>>            * If those are the only references, then any new usage
>>            * of the folio will have to fetch it from the page
>> @@ -2002,7 +2002,7 @@ static int collapse_file(struct mm_struct *mm, 
>> unsigned long addr,
>>            * truncate, so any new usage will be blocked until we
>>            * unlock folio after collapse/during rollback.
>>            */
>> -        if (folio_ref_count(folio) != 3) {
>> +        if (folio_ref_count(folio) != 2 + folio_nr_pages(folio)) {
>>               result = SCAN_PAGE_COUNT;
>>               xas_unlock_irq(&xas);
>>               folio_putback_lru(folio);
>> @@ -2185,7 +2185,7 @@ static int collapse_file(struct mm_struct *mm, 
>> unsigned long addr,
>>           folio_clear_active(folio);
>>           folio_clear_unevictable(folio);
>>           folio_unlock(folio);
>> -        folio_put_refs(folio, 3);
>> +        folio_put_refs(folio, 2 + folio_nr_pages(folio));
>>       }
>>       goto out;
> 
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks for reviewing.

