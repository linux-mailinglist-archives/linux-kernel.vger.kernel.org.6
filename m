Return-Path: <linux-kernel+bounces-198823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2758D7DF8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F5B7B20B43
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E596376EEA;
	Mon,  3 Jun 2024 08:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nCkImw7m"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A0C7604F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 08:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717405151; cv=none; b=pKbFdP0THdBtZmh2/Iim1pa/bLd6wZM4enTf73qKi1UBxPwjzrDFbkxJ9OBmApdQZ0DdKfTj9TAwzSHTAEbVcftQ6g/HPO4Gw8PWlDswkqhiH/kVmqhSWTLrqg/HArPFpD/vJuTCmaO1AT64Woc0uDAgJC4Y8i1EJnXce7TAkvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717405151; c=relaxed/simple;
	bh=W3fg5nl6HNyYLjlSngUjxtPZxz3YW1afDlPZUYbTL5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q4hE9RMifqz4EKqoBs+8yv9OgY13o33Ikj+9fdZZ9LQ2GLC8Ll+pJvy+BkJFt1gjqw9nxSYafWjFiQS0qZIXw0vP8/Nue5fTr4hqBimkohNMul6hzfOwmy5GdoREZkKp5A7PmUivRYH4LZd5DAly9q1Pohy63+fVPf7u3XPeU+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nCkImw7m; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717405140; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=TzPdstqt9IZKp/sl6m9OBFjYtVVR9pYii9OkkWcJFLc=;
	b=nCkImw7mEpRAE+qiSbcFM68Z0cW3cCsPAaCRAAQViiWUdNxgsg9wcUun/LcSydWs2MlQTEsMMiSrRVWmvGsk9FjBfdJOFHe8JA1WSoiS45U7M6ZNUcYM+jHAtiRGdKwx5KKnH2bahSgRlXJv7XBbvyQ3im6NaHwqE9PKt0ioRVI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W7lDG5c_1717405138;
Received: from 30.97.56.74(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W7lDG5c_1717405138)
          by smtp.aliyun-inc.com;
          Mon, 03 Jun 2024 16:58:59 +0800
Message-ID: <c925eae9-5c7e-47d2-bab3-708edec88990@linux.alibaba.com>
Date: Mon, 3 Jun 2024 16:58:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/mlock: implement folio_mlock_step() using
 folio_pte_batch()
To: Barry Song <21cnbao@gmail.com>, Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, david@redhat.com,
 ziy@nvidia.com, fengwei.yin@intel.com, ying.huang@intel.com,
 libang.li@antgroup.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240603033118.76457-1-ioworker0@gmail.com>
 <CAGsJ_4wxPk+bk9UM+PvA3x=LJG+mWmTD3e2HSEsS83X3vMWTJQ@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAGsJ_4wxPk+bk9UM+PvA3x=LJG+mWmTD3e2HSEsS83X3vMWTJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/6/3 12:14, Barry Song wrote:
> On Mon, Jun 3, 2024 at 3:31 PM Lance Yang <ioworker0@gmail.com> wrote:
>>
>> Let's make folio_mlock_step() simply a wrapper around folio_pte_batch(),
>> which will greatly reduce the cost of ptep_get() when scanning a range of
>> contptes.
>>
>> Signed-off-by: Lance Yang <ioworker0@gmail.com>
>> ---
>>   mm/mlock.c | 23 ++++++-----------------
>>   1 file changed, 6 insertions(+), 17 deletions(-)
>>
>> diff --git a/mm/mlock.c b/mm/mlock.c
>> index 30b51cdea89d..1ae6232d38cf 100644
>> --- a/mm/mlock.c
>> +++ b/mm/mlock.c
>> @@ -307,26 +307,15 @@ void munlock_folio(struct folio *folio)
>>   static inline unsigned int folio_mlock_step(struct folio *folio,
>>                  pte_t *pte, unsigned long addr, unsigned long end)
>>   {
>> -       unsigned int count, i, nr = folio_nr_pages(folio);
>> -       unsigned long pfn = folio_pfn(folio);
>> -       pte_t ptent = ptep_get(pte);
>> -
>> -       if (!folio_test_large(folio))
>> +       if (likely(!folio_test_large(folio)))
>>                  return 1;
>>
>> -       count = pfn + nr - pte_pfn(ptent);
>> -       count = min_t(unsigned int, count, (end - addr) >> PAGE_SHIFT);
>> -
>> -       for (i = 0; i < count; i++, pte++) {
>> -               pte_t entry = ptep_get(pte);
>> -
>> -               if (!pte_present(entry))
>> -                       break;
>> -               if (pte_pfn(entry) - pfn >= nr)
>> -                       break;
>> -       }
>> +       const fpb_t fpb_flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
>> +       int max_nr = (end - addr) / PAGE_SIZE;
>> +       pte_t ptent = ptep_get(pte);
>>
>> -       return i;
>> +       return folio_pte_batch(folio, addr, pte, ptent, max_nr, fpb_flags, NULL,
>> +                              NULL, NULL);
>>   }
> 
> what about a minimum change as below?
> index 30b51cdea89d..e8b98f84fbd2 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -307,26 +307,15 @@ void munlock_folio(struct folio *folio)
>   static inline unsigned int folio_mlock_step(struct folio *folio,
>                  pte_t *pte, unsigned long addr, unsigned long end)
>   {
> -       unsigned int count, i, nr = folio_nr_pages(folio);
> -       unsigned long pfn = folio_pfn(folio);
> +       unsigned int count = (end - addr) >> PAGE_SHIFT;
>          pte_t ptent = ptep_get(pte);
> +       const fpb_t fpb_flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
> 
>          if (!folio_test_large(folio))
>                  return 1;
> 
> -       count = pfn + nr - pte_pfn(ptent);
> -       count = min_t(unsigned int, count, (end - addr) >> PAGE_SHIFT);
> -
> -       for (i = 0; i < count; i++, pte++) {
> -               pte_t entry = ptep_get(pte);
> -
> -               if (!pte_present(entry))
> -                       break;
> -               if (pte_pfn(entry) - pfn >= nr)
> -                       break;
> -       }
> -
> -       return i;
> +       return folio_pte_batch(folio, addr, pte, ptent, count, fpb_flags, NULL,
> +                              NULL, NULL);
>   }

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

