Return-Path: <linux-kernel+bounces-291713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8BC9565D1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 516CD1F23E1B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C57F15C128;
	Mon, 19 Aug 2024 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rmpWrNZZ"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0728515B551
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724056934; cv=none; b=pw6GjWKvOFPaHHtD/MY3iz+BGwKY3XbMQqv7Kd93kJX3aPqK7QUjb0DSRSWeGZLLY3kIhL9sR5Gy7HYcTyydj2bzDlRClBx9zVF204/5l25Fz+JwjtYyOIFy3RV2gDd9z6hr7HYa4TxfnSdvx5NB9wZDoM7/uKvA4Uf51bZ8SjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724056934; c=relaxed/simple;
	bh=nsNrokjPtlMyX9xC/z629EiU6DQLwAN+FixNCRobCbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nWFbJzOR5AmGh9nHolSgV7JAhP8b+XI3yRFbRk78EMic0VnVmE0WrTKy8VHdTClUe+Mcb+4mEqYxwyrPDBndGm16CYa3UuAjrCHFAKUgsOY0EKwop4O3EMVM4K4CyRv2pCB0P75YXONPUlZL3fxJFPjAoqLAXGKMKQz41U3bdLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rmpWrNZZ; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724056928; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=KLMHvwzxuIVKCo2bV13G0bukH2Tmr6a3PUkasa/nnJk=;
	b=rmpWrNZZIdFDHFvJVvWy8P8Vi4wuVYhEI1aM+IYnYx79WlAcV0VhsKz4AgI3wBdiZVUUH0nAV7O5orW9el9QRGT9tjHGTckeazUPJO7c/TgnHvZKWyuZijRIFiugn55gjEolAk3JYYqoA0mSwmIlb8rlnzZKLZclT5CGomZ14bc=
Received: from 30.97.56.67(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WD9cnkN_1724056927)
          by smtp.aliyun-inc.com;
          Mon, 19 Aug 2024 16:42:07 +0800
Message-ID: <3db665f2-4525-4942-abfb-0c1fdea2f729@linux.alibaba.com>
Date: Mon, 19 Aug 2024 16:42:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] mm: khugepaged: expand the is_refcount_suitable() to
 support file folios
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc: hughd@google.com, willy@infradead.org, 21cnbao@gmail.com,
 ryan.roberts@arm.com, shy828301@gmail.com, ziy@nvidia.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1724054125.git.baolin.wang@linux.alibaba.com>
 <d6f8e4451910da1de0420eb82724dd85c368741c.1724054125.git.baolin.wang@linux.alibaba.com>
 <c53887da-ebbe-432e-bf81-308085215420@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <c53887da-ebbe-432e-bf81-308085215420@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/8/19 16:36, David Hildenbrand wrote:
> On 19.08.24 10:14, Baolin Wang wrote:
>> Expand the is_refcount_suitable() to support reference checks for file 
>> folios,
>> as preparation for supporting shmem mTHP collapse.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/khugepaged.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index cdd1d8655a76..f11b4f172e61 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -549,8 +549,14 @@ static bool is_refcount_suitable(struct folio 
>> *folio)
>>       int expected_refcount;
>>       expected_refcount = folio_mapcount(folio);
>> -    if (folio_test_swapcache(folio))
>> +    if (folio_test_anon(folio)) {
>> +        expected_refcount += folio_test_swapcache(folio) ?
>> +                    folio_nr_pages(folio) : 0;
>> +    } else {
>>           expected_refcount += folio_nr_pages(folio);
>> +        if (folio_test_private(folio))
>> +            expected_refcount++;
>> +    }
> 
> Alternatively, a bit neater
> 
> if (!folio_test_anon(folio) || folio_test_swapcache(folio))
>      expected_refcount += folio_nr_pages(folio);
> if (folio_test_private(folio))
>      expected_refcount++;
> 
> The latter check should be fine even for anon folios (although always 
> false)

Looks better. Will do in v2.

>>       return folio_ref_count(folio) == expected_refcount;
>>   }
>> @@ -2285,8 +2291,7 @@ static int hpage_collapse_scan_file(struct 
>> mm_struct *mm, unsigned long addr,
>>               break;
>>           }
>> -        if (folio_ref_count(folio) !=
>> -            1 + folio_mapcount(folio) + folio_test_private(folio)) {
> 
> The "1" is due to the pagecache, right? IIUC, we don't hold a raised 
> folio refcount as we do the xas_for_each().

Right.

