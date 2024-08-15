Return-Path: <linux-kernel+bounces-288461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CF1953A59
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 20:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0BEF285D6F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B00744C7C;
	Thu, 15 Aug 2024 18:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUSoUEws"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F3238382
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 18:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723747687; cv=none; b=kohwMlxcARmz1qUbf5EWu0mkMQ1eSoxAVz1T2lOrf+RrGi2N5gO/InfY+BFrWHVoYG0vNASZDsjD1Rd8/G9StylY03BGee9tKwbxEWJjTThgFlGYIbRn+uaVVOkMb/cEA1/nf3G3PJC2qqOxJPi6+CjbRz14TZ5YqWqJdE+0bAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723747687; c=relaxed/simple;
	bh=CvX62ZxJqj6LSFFCE2OrD49nT4h+rMNSHZYlDc1vGmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cWJo0FUM7M8SvJ/Oi0ZJQ5lb7n3vg2KiD38+qg1CSM2KAwQb1jRiiEh06yMUMPYuWMSrC5Yd5d27CC/cSQ232jOsuReXhWkzvoNCtcZqKMwzGpnB6mVwWQBR1xdeLPuigIdViSvX7r9+GGdHH2+XdxxrD8BxWGGF8C34RYoTxy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUSoUEws; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42809d6e719so8607805e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 11:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723747684; x=1724352484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GMuOj9Mdm0JKv0Lrfny/0hBubHJ6XoibClFzab+wqoA=;
        b=AUSoUEwscqIJ7lhCN4HipgwfocZuub0cfSzm+GWe7itpHV/tHJ6taiikAujwSjd9r7
         f7wTxXNjPyABr7+c6u8sl6O6n4I7hASwhGAd81HlsP/z0BmQEl0hm9486GpXlK/OYGw8
         aOM+LtknQCZBcpzA9GjFDr8YtOMpPJmWTTJmrh3ecvU+jLkNKgQ2SZsRf6i57gzrlRFo
         q4Bq1qK3/Ga+khTpSK0T/ncnyR994nXwTtbAK2fGVuH+2snipXINFDXhbPo060cdRRZq
         3CMhB1VFe1tQin57RBANDlVFsutKhNIcdq/uc2YJpub/+yu53/jM3jx9ykPPgVbM39xN
         jq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723747684; x=1724352484;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GMuOj9Mdm0JKv0Lrfny/0hBubHJ6XoibClFzab+wqoA=;
        b=SIbPzcO11UjTo6IKWZ/2Ft3kh6YdpVD7jRAFfjvHHedyyTivljHztZMMMhRQ4vYY+c
         YCsEe6I4WYszpDN6gK7+iO9ZB+7pmUv3+cisZkLOwc27gzchUwYlyJqE7qsbgv1RwLlG
         nVzZEMjAcrV7QA3ZI6e3Q8rBT7MXv5ShPwFBsUUaHEux9vDMl8f3lZqQDed/uC7MoxsO
         RVxpa75Q/QlSb1KhQvxcV6qEGWv2PS3LYI6Z9zLsCOMh1nv6uaH/1pK5OGzU1zsYA00o
         VCuEUtZBh850ntTc9Zxn2OBngE14p/chQyE1pfZnQiemnW5rSXHqL7+0DwTKcsVl4XRz
         mhCw==
X-Forwarded-Encrypted: i=1; AJvYcCX73Qe/ziF9e277ISkDrHxSpz6bdmJoIxxPnvVBr8v8Pdg/kWMs+YfIVrNzb3LIaZVkc7yVTpPHXczQT11Xc6UFRko+ms1IGYVn2uag
X-Gm-Message-State: AOJu0YxpMAnqk7fGwAAv9RQkDFBwF5BPTCA+GzjFeW8mTStVZT0GiIFc
	058wb9BB8rYN5UMuXmjm40wbYyqXzYlpoeZGZVD+U7qR85QOg2Na
X-Google-Smtp-Source: AGHT+IE1uwI/qWr+/pX0dMTFpEHgPo3UrJhYENMPGU5Mlv/RiVcvanRBXjjH3iHMZHyWt+ejM7b0jQ==
X-Received: by 2002:a5d:6385:0:b0:371:8698:3740 with SMTP id ffacd0b85a97d-371946a5801mr177866f8f.39.1723747683577;
        Thu, 15 Aug 2024 11:48:03 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e750:7600:c5:51ce:2b5:970b? ([2a02:6b6f:e750:7600:c5:51ce:2b5:970b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed648f3fsm2246935e9.6.2024.08.15.11.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 11:48:03 -0700 (PDT)
Message-ID: <0d87c81b-6bf3-4e46-a2d1-a2f9f3a551dd@gmail.com>
Date: Thu, 15 Aug 2024 19:48:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable v1 2/3] mm/cma: add cma_alloc_folio()
To: Yu Zhao <yuzhao@google.com>, Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Zi Yan <ziy@nvidia.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240811212129.3074314-1-yuzhao@google.com>
 <20240811212129.3074314-3-yuzhao@google.com>
 <6d19d790-92d2-40f9-9797-cc08bf3921fe@huawei.com>
 <CAOUHufbJ3jXUp3-w5jfiRrf37vZxon+VyVdPP+6Y07vgxCwkQA@mail.gmail.com>
 <CAOUHufZ==+ETxNW5qwbTeEbSgOic7WA-JgqPPGTngeKNY-RKDA@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAOUHufZ==+ETxNW5qwbTeEbSgOic7WA-JgqPPGTngeKNY-RKDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 15/08/2024 19:25, Yu Zhao wrote:
> On Thu, Aug 15, 2024 at 12:04 PM Yu Zhao <yuzhao@google.com> wrote:
>>
>> On Thu, Aug 15, 2024 at 8:41 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>>
>>>
>>>
>>> On 2024/8/12 5:21, Yu Zhao wrote:
>>>> With alloc_contig_range() and free_contig_range() supporting large
>>>> folios, CMA can allocate and free large folios too, by
>>>> cma_alloc_folio() and cma_release().
>>>>
>>>> Signed-off-by: Yu Zhao <yuzhao@google.com>
>>>> ---
>>>>   include/linux/cma.h |  1 +
>>>>   mm/cma.c            | 47 ++++++++++++++++++++++++++++++---------------
>>>>   2 files changed, 33 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/include/linux/cma.h b/include/linux/cma.h
>>>> index 9db877506ea8..086553fbda73 100644
>>>> --- a/include/linux/cma.h
>>>> +++ b/include/linux/cma.h
>>>> @@ -46,6 +46,7 @@ extern int cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
>>>>                                       struct cma **res_cma);
>>>>   extern struct page *cma_alloc(struct cma *cma, unsigned long count, unsigned int align,
>>>>                             bool no_warn);
>>>> +extern struct folio *cma_alloc_folio(struct cma *cma, int order, gfp_t gfp);
>>>>   extern bool cma_pages_valid(struct cma *cma, const struct page *pages, unsigned long count);
>>>>   extern bool cma_release(struct cma *cma, const struct page *pages, unsigned long count);
>>>>
>>>> diff --git a/mm/cma.c b/mm/cma.c
>>>> index 95d6950e177b..46feb06db8e7 100644
>>>> --- a/mm/cma.c
>>>> +++ b/mm/cma.c
>>>> @@ -403,18 +403,8 @@ static void cma_debug_show_areas(struct cma *cma)
>>>>       spin_unlock_irq(&cma->lock);
>>>>   }
>>>>
>>>> -/**
>>>> - * cma_alloc() - allocate pages from contiguous area
>>>> - * @cma:   Contiguous memory region for which the allocation is performed.
>>>> - * @count: Requested number of pages.
>>>> - * @align: Requested alignment of pages (in PAGE_SIZE order).
>>>> - * @no_warn: Avoid printing message about failed allocation
>>>> - *
>>>> - * This function allocates part of contiguous memory on specific
>>>> - * contiguous memory area.
>>>> - */
>>>> -struct page *cma_alloc(struct cma *cma, unsigned long count,
>>>> -                    unsigned int align, bool no_warn)
>>>> +static struct page *__cma_alloc(struct cma *cma, unsigned long count,
>>>> +                             unsigned int align, gfp_t gfp)
>>>>   {
>>>>       unsigned long mask, offset;
>>>>       unsigned long pfn = -1;
>>>> @@ -463,8 +453,7 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
>>>>
>>>>               pfn = cma->base_pfn + (bitmap_no << cma->order_per_bit);
>>>>               mutex_lock(&cma_mutex);
>>>> -             ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA,
>>>> -                                  GFP_KERNEL | (no_warn ? __GFP_NOWARN : 0));
>>>> +             ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA, gfp);
>>>>               mutex_unlock(&cma_mutex);
>>>>               if (ret == 0) {
>>>>                       page = pfn_to_page(pfn);
>>>> @@ -494,7 +483,7 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
>>>>                       page_kasan_tag_reset(nth_page(page, i));
>>>>       }
>>>>
>>>> -     if (ret && !no_warn) {
>>>> +     if (ret && !(gfp & __GFP_NOWARN)) {
>>>>               pr_err_ratelimited("%s: %s: alloc failed, req-size: %lu pages, ret: %d\n",
>>>>                                  __func__, cma->name, count, ret);
>>>>               cma_debug_show_areas(cma);
>>>> @@ -513,6 +502,34 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
>>>>       return page;
>>>>   }
>>>>
>>>> +/**
>>>> + * cma_alloc() - allocate pages from contiguous area
>>>> + * @cma:   Contiguous memory region for which the allocation is performed.
>>>> + * @count: Requested number of pages.
>>>> + * @align: Requested alignment of pages (in PAGE_SIZE order).
>>>> + * @no_warn: Avoid printing message about failed allocation
>>>> + *
>>>> + * This function allocates part of contiguous memory on specific
>>>> + * contiguous memory area.
>>>> + */
>>>> +struct page *cma_alloc(struct cma *cma, unsigned long count,
>>>> +                    unsigned int align, bool no_warn)
>>>> +{
>>>> +     return __cma_alloc(cma, count, align, GFP_KERNEL | (no_warn ? __GFP_NOWARN : 0));
>>>> +}
>>>> +
>>>> +struct folio *cma_alloc_folio(struct cma *cma, int order, gfp_t gfp)
>>>> +{
>>>> +     struct page *page;
>>>> +
>>>> +     if (WARN_ON(order && !(gfp | __GFP_COMP)))
>>>> +             return NULL;
>>>> +
>>>> +     page = __cma_alloc(cma, 1 << order, order, gfp);
>>>> +
>>>> +     return page ? page_folio(page) : NULL;
>>>
>>> We don't set large_rmappable for cma alloc folio, which is not consistent
>>> with  other folio allocation, eg  folio_alloc/folio_alloc_mpol(),
>>> there is no issue for HugeTLB folio, and for HugeTLB folio must without
>>> large_rmappable, but once we use it for mTHP/THP, it need some extra
>>> handle, maybe we set large_rmappable here, and clear it in
>>> init_new_hugetlb_folio()?
>>
>> I want to hear what Matthew thinks about this.
>>
>> My opinion is that we don't want to couple largely rmappable (or
>> deferred splittable) with __GFP_COMP, and for that matter, with large
>> folios, because the former are specific to THPs whereas the latter can
>> potentially work for most types of high order allocations.
>>
>> Again, IMO, if we want to seriously answer the question of
>>   Can we get rid of non-compound multi-page allocations? [1]
>> then we should start planning on decouple large rmappable from the
>> generic folio allocation API.
>>
>> [1] https://lpc.events/event/18/sessions/184/#20240920
> 
> Also along the similar lines, Usama is trying to add
> PG_partially_mapped [1], which I have explicitly asked him not to
> introduce that flag to hugeTLB, unless there are good reasons (none
> ATM).
> 
> [1] https://lore.kernel.org/CAOUHufbmgwZwzUuHVvEDMqPGcsxE2hEreRZ4PhK5yz27GdK-Tw@mail.gmail.com/

PG_partially_mapped won't be cleared for hugeTLB in the next revision of the series as suggested by Yu.
Its not there in the fix patch I posted as well in  https://lore.kernel.org/all/4acdf2b7-ed65-4087-9806-8f4a187b4eb5@gmail.com/

