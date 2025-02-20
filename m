Return-Path: <linux-kernel+bounces-524695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5683A3E5ED
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6927E3A2EA9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AED220485B;
	Thu, 20 Feb 2025 20:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PmpSPMKK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2761DE896
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 20:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740083823; cv=none; b=jggO7+CEwZFOFlkUTxTgbNcncVHA5HOgGQm9iu+Wpmb0BrMNtBuZm7SZPJ6OAbpmm3aB/gEshQ+fpinByv0Ha4voEOwK04fw+lxnsfDorsBthrpIXMeBqy5hDdDRHbtMeKUeXF0zyik2rhqYejx99S2L6QquU0gs77D3GYgBatY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740083823; c=relaxed/simple;
	bh=dIKzHTrLcGdCFTzsH2Ihl0C8Yzic0mbstVpJ7SbAfP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Un1oD4juxgq/HuOEmwJEjxa8ok8QlqXqC9jRw0VjdmwUZokb5Rt250SoxpEdAxjsdEJIyDk/jG9fkqoZABhp/ejfJF/K7APjUtfd3qifapIjBMGHGmyJmSQ6aaZ0eeppYn4asBcZBikPw0SlEJ6M5cJU1gTOfryUCzdZhzBBzTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PmpSPMKK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740083819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IMhy9qiICvzONWp5u6SxcMcMKcO6AHzHEe89orkSRsM=;
	b=PmpSPMKK1ynMxmTOKkIQ3FUZ2UydWo222UmalUQ0mQeOlHae0NCo/jzz9zExlzz5TvAUxB
	bq8KfXEAQyH19nNZ8JnPjac5fGmMj7cHnrG0caQmpP3L7AVHCAS9/ACUwplvQpOd8qedkj
	SoUy/8py+nGWgHHWsw22T0Z5n5zea98=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-GAQk1KrqMymTgUxL6BuDAg-1; Thu, 20 Feb 2025 15:36:58 -0500
X-MC-Unique: GAQk1KrqMymTgUxL6BuDAg-1
X-Mimecast-MFC-AGG-ID: GAQk1KrqMymTgUxL6BuDAg_1740083818
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c0b7ee195bso248451285a.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:36:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740083818; x=1740688618;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IMhy9qiICvzONWp5u6SxcMcMKcO6AHzHEe89orkSRsM=;
        b=karClU/cnhwx4CsuBC8bWpjeUdYn1hrQhG/OzXY2HVm1Jo6O0TVxWqm76K9uFoqHZO
         EsCPhQ6GPBnDaWtj4Xbl4khg6Tw7cBwCobMBjMYrUsUalyLltS2+xBKwtJbLsbo5kRX7
         mSH5BiGEyDMCw7u5mutFeAiD6eivPwI4fvdg/Ksq/2uAo/1h6tou9xm45ZJKzpIDIx9z
         jmtgvPjQpFMCSWj4lQ//+hFvVzSD9FIIIM+AdyJnmMUi+Ym/rI6w2fpshg5YO/9rlXk/
         3Ixk+AbBx7OItV6FjLXtYPdtXOvuCN+Cp8XGVzxOSTJPGv9tS2DOHBdypaOzGIGSX5y3
         T4yA==
X-Forwarded-Encrypted: i=1; AJvYcCVBKMlkeEJ7b49NcluG/sN7Y6x9U6DESZt8RoorNDIkegvctEnzZG2iTOpPtNuiEfsHaN/dr/bptsT0Sjg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmwj2hljddGlbaw+2kxZB3W+KK/SCNVGtdLJ9IyCyx8AQ1jZKs
	dGcbKLILSGyPBEEI88vZzsFl8ZwKkUu/v1A8sLgYj/isDVrpqjuhosQb/2eY7kIqLht7blWh+zD
	EjNkPnkT7A1KBRf99U3ZUWcR8Wpj0MUFuS6v/dhl8xOrT7sqg0a9t+TlUTjV7MQ==
X-Gm-Gg: ASbGncvJqE+Nm3CxnLer4wtd6azEt3etOUzeckGexidNb3C1XkMvsBenjlWmDBUIFkX
	ZmLz504Ab+Bk8v0a2ll4RDuqXfZJkblF7OVGtyO03W52DpLPUXPpYEeGKryOToQdnt4ClProC2q
	O2pcu0vlLCjhIZ40QBYB0ZXHurpagu4l7HOF5aKwP0aw/yZObo36mpeEPvQM275yN0ggBGDcqhG
	0Kc32AfAmqjmPxiEVld5xkJO/rugdP6WQl7vY4rd9sBlVPELQ7+JE9GnPzdA4441gvW9wkgWN5J
	y8qk
X-Received: by 2002:a05:620a:269f:b0:7c0:c568:2ab9 with SMTP id af79cd13be357-7c0cf953f67mr30937685a.35.1740083818088;
        Thu, 20 Feb 2025 12:36:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4OTd1+4Kk9zClIjp8SNBVcJyux52H4N1MVp9g47S8DyVsnoN7iPs0orNbXKfk0IPgzBwf+w==
X-Received: by 2002:a05:620a:269f:b0:7c0:c568:2ab9 with SMTP id af79cd13be357-7c0cf953f67mr30933585a.35.1740083817755;
        Thu, 20 Feb 2025 12:36:57 -0800 (PST)
Received: from [192.168.2.110] ([70.52.22.87])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c096e87af7sm561315085a.79.2025.02.20.12.36.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 12:36:57 -0800 (PST)
Message-ID: <0a8bd481-0b97-416d-935e-84828016445d@redhat.com>
Date: Thu, 20 Feb 2025 15:36:46 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mm: page_ext: add an iteration API for page
 extensions
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, yuzhao@google.com, pasha.tatashin@soleen.com
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, muchun.song@linux.dev
References: <cover.1739931468.git.luizcap@redhat.com>
 <3f0e058aef3951b39cf6bb4259c247352d4fe736.1739931468.git.luizcap@redhat.com>
 <4cb93166-29fd-4aea-965b-5dfb62d4dc8c@redhat.com>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <4cb93166-29fd-4aea-965b-5dfb62d4dc8c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-02-20 05:59, David Hildenbrand wrote:
> On 19.02.25 03:17, Luiz Capitulino wrote:
>> The page extension implementation assumes that all page extensions of
>> a given page order are stored in the same memory section. The function
>> page_ext_next() relies on this assumption by adding an offset to the
>> current object to return the next adjacent page extension.
>>
>> This behavior works as expected for flatmem but fails for sparsemem when
>> using 1G pages. The commit cf54f310d0d3 ("mm/hugetlb: use __GFP_COMP for
>> gigantic folios") exposes this issue, making it possible for a crash when
>> using page_owner or page_table_check page extensions.
>>
>> The problem is that for 1G pages, the page extensions may span memory
>> section boundaries and be stored in different memory sections. This issue
>> was not visible before commit cf54f310d0d3 ("mm/hugetlb: use __GFP_COMP
>> for gigantic folios") because alloc_contig_pages() never passed more than
>> MAX_PAGE_ORDER to post_alloc_hook(). However, the series introducing
>> mentioned commit changed this behavior allowing the full 1G page order
>> to be passed.
>>
>> Reproducer:
>>
>>   1. Build the kernel with CONFIG_SPARSEMEM=y and table extensions
>>      support
>>   2. Pass 'default_hugepagesz=1 page_owner=on' in the kernel command-line
>>   3. Reserve one 1G page at run-time, this should crash (backtrace below)
>>
>> To address this issue, this commit introduces a new API for iterating
>> through page extensions. The main iteration loops are for_each_page_ext()
>> and for_each_page_ext_order(). Both must be called with the RCU read
>> lock taken. Here's an usage example:
>>
>> """
>> struct page_ext_iter iter;
>> struct page_ext *page_ext;
>>
>> ...
>>
>> rcu_read_lock();
>> for_each_page_ext_order(page, order, page_ext, iter) {
>>     struct my_page_ext *obj = get_my_page_ext_obj(page_ext);
>>     ...
>> }
>> rcu_read_unlock();
>> """
>>
> 
> [...]
> 
>> +struct page_ext *page_ext_iter_begin(struct page_ext_iter *iter, struct page *page);
>> +struct page_ext *page_ext_iter_next(struct page_ext_iter *iter);
>> +
>> +/**
>> + * page_ext_iter_get() - Get current page extension
>> + * @iter: page extension iterator.
>> + *
>> + * Return: NULL if no page_ext exists for this iterator.
>> + */
>> +static inline struct page_ext *page_ext_iter_get(const struct page_ext_iter *iter)
>> +{
>> +    return iter->page_ext;
>> +}
>> +
>> +/**
>> + * for_each_page_ext(): iterate through page_ext objects.
>> + * @__page: the page we're interested in
>> + * @__pgcount: how many pages to iterate through
>> + * @__page_ext: struct page_ext pointer where the current page_ext
>> + *              object is returned
>> + * @__iter: struct page_ext_iter object (defined in the stack)
>> + *
>> + * IMPORTANT: must be called with RCU read lock taken.
>> + */
>> +#define for_each_page_ext(__page, __pgcount, __page_ext, __iter) \
>> +    __page_ext = page_ext_iter_begin(&__iter, __page);     \
> 
> Doing stuff out of the loop is dangerous. Assume something does
> 
> if (xxx)
>      for_each_page_ext()
> 
> Just move that inside the for().
> 
> for (__page_ext = page_ext_iter_begin(&__iter, __page), __iter.index = 0)

Oh, good point. Will do the change.

>> +    for (__iter.index = 0;                                 \
>> +        __page_ext && __iter.index < __pgcount;        \
>> +        __page_ext = page_ext_iter_next(&__iter),      \
>> +        __iter.index++)
> 
> Hm, if we now have an index, why not turn iter.pfn -> iter.start_pfn, and only adjust the index in page_ext_iter_next?
> 
> Then you can set the index to 0 in page_ext_iter_begin() and have here
> 
> for (__page_ext = page_ext_iter_begin(&__iter, __page),
>       __page_ext && __iter.index < __pgcount,
>       __page_ext = page_ext_iter_next(&__iter);)

I can do this if you feel strong about it, but I prefer explicitly over
implicitly. I moved the index into the iter object just to avoid having
to define it in the macro's body. Also, the way I did it allows for
using page_ext_iter_begin()/page_ext_iter_next() own their if the need
arises.

> A page_ext_iter_reset() could then simply reset the index=0 and
> lookup the page_ext(start_pfn + index) == page_ext(start_pfn)

Just note we don't have page_ext_iter_reset() today (and I guess it's
not needed).

>> +
>> +/**
>> + * for_each_page_ext_order(): iterate through page_ext objects
>> + *                            for a given page order
>> + * @__page: the page we're interested in
>> + * @__order: page order to iterate through
>> + * @__page_ext: struct page_ext pointer where the current page_ext
>> + *              object is returned
>> + * @__iter: struct page_ext_iter object (defined in the stack)
>> + *
>> + * IMPORTANT: must be called with RCU read lock taken.
>> + */
>> +#define for_each_page_ext_order(__page, __order, __page_ext, __iter) \
>> +    for_each_page_ext(__page, (1UL << __order), __page_ext, __iter)
>> +
>>   #else /* !CONFIG_PAGE_EXTENSION */
>>   struct page_ext;
>> diff --git a/mm/page_ext.c b/mm/page_ext.c
>> index 641d93f6af4c1..508deb04d5ead 100644
>> --- a/mm/page_ext.c
>> +++ b/mm/page_ext.c
>> @@ -549,3 +549,44 @@ void page_ext_put(struct page_ext *page_ext)
>>       rcu_read_unlock();
>>   }
>> +
>> +/**
>> + * page_ext_iter_begin() - Prepare for iterating through page extensions.
>> + * @iter: page extension iterator.
>> + * @page: The page we're interested in.
>> + *
>> + * Must be called with RCU read lock taken.
>> + *
>> + * Return: NULL if no page_ext exists for this page.
>> + */
>> +struct page_ext *page_ext_iter_begin(struct page_ext_iter *iter, struct page *page)
>> +{
>> +    iter->pfn = page_to_pfn(page);
>> +    iter->page_ext = lookup_page_ext(page);
>> +
>> +    return iter->page_ext;
>> +}
>> +
>> +/**
>> + * page_ext_iter_next() - Get next page extension
>> + * @iter: page extension iterator.
>> + *
>> + * Must be called with RCU read lock taken.
>> + *
>> + * Return: NULL if no next page_ext exists.
>> + */
>> +struct page_ext *page_ext_iter_next(struct page_ext_iter *iter)
>> +{
>> +    if (WARN_ON_ONCE(!iter->page_ext))
>> +        return NULL;
>> +
>> +    iter->pfn++;
>  > +> +    if (page_ext_iter_next_fast_possible(iter->pfn)) {
>> +        iter->page_ext = page_ext_next(iter->page_ext);
>> +    } else {
>> +        iter->page_ext = lookup_page_ext(pfn_to_page(iter->pfn));
>> +    }
>> +
>> +    return iter->page_ext;
>> +}
> 
> We now always have a function call when calling into page_ext_iter_next(). Could we move that to the header and rather expose lookup_page_ext() ?

I personally don't like over-using inline functions, also I don't think this
code needs optimization since the current clients make the affected code paths
slow anyways (and this also applies to the likely/unlikely use in page_owner
and page_table_check, I'd drop all of them if you ask me). But again, I can
change if this would prevent you from giving your ACK :)


