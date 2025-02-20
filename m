Return-Path: <linux-kernel+bounces-524728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8063A3E661
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86EE42343A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C5C2641EB;
	Thu, 20 Feb 2025 21:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YAgozemC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA47D1DF735
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 21:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740085965; cv=none; b=CUXmHbh9Mkvb02l7Q05H2ANqRgSq1cZsuIfdsXRE1VO+akWDxCgMJgMVLp3wSl2hMbzd7h5PJkJcYw/bfVXK7P68nBBEQwl2QDfN3ZaEIY9k8IQdvum+2/CgmHgH+orPqL7NnNUf/LxV9NdJ5Ut2Ay2erWeUzcE7UpVouukyw88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740085965; c=relaxed/simple;
	bh=fvoYYub71YsjMQVRYkfpAozSuAkIEhbGBFcQaRMuKRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MaG7q736g8+racGoy37WDXRxMc36w7Jk4wFvpr7syIfhD6Q1LJibRxT9FjLcYZqk85zCd37E3e4uDwg30bMs3NUF2RkCHjtGKME2NaYIAHbRUhCo2Jh9BWpAORIb7ZONv/e5EVb7L+pmVJd7x/cjFyStfq71iKd1pRQkM4HpkGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YAgozemC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740085962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MGcNCNTpXqgcRd/FOw7KJikXMi7I5/lkRCqCXZ2bgxA=;
	b=YAgozemCcsQAyXSuHb/Lb9rlA5UTKzD0qLa7PcjFD4/bSftcCSecI5I8v8E8m8y0pRUeIy
	8urGYo7TONnyb/30j2X2XktgUL00Qa/cpCA3aHKcr8zzo5D3duvseZb3lRS9ogn15kRZU2
	TOL4IaV9E39VjJ7emqK2eLo+wH2U9r0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-ZeO2fsvANj6PycE1UyPIiw-1; Thu, 20 Feb 2025 16:12:40 -0500
X-MC-Unique: ZeO2fsvANj6PycE1UyPIiw-1
X-Mimecast-MFC-AGG-ID: ZeO2fsvANj6PycE1UyPIiw_1740085959
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-47217c14be9so37528361cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 13:12:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740085959; x=1740690759;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MGcNCNTpXqgcRd/FOw7KJikXMi7I5/lkRCqCXZ2bgxA=;
        b=QZk7oKAeMlG+BWsBy8j2ecwQ4PFyKmy856GTR6WSapmrJ+9D925dcAZICIHy/PPguj
         jgRuLrMqf+m8o1MXsy5rGJBV7U+nd/lErlbdNqD+Np7xC2TTBAq2v9VHvYI/UhKQ0+2n
         qWzfUYlhbzMDBIAObXVJsVA8NSna25y2uRwBeSmepXLXQ3/c4eNqrZlVgJWhVTDxa7go
         HWkEE/mOnf1pwxizKdi0fI+C+/DQ1xlYAw6LYomFgtL0o5r9bxMtduH4rRp/ncomdIsA
         0235fuW/oVOnGg9kNmOV7TmM+uk6l4gAal2NAm3Hz/eAbv+Rgd66Xkg8xC/Heue/c7At
         WBAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmk1z20t75dpzxeBcBruJGgUc247IHHcajpL4L/ie+1CHHc4sLw9Wtu7pXk0U7E58TektQ3JDTKZqrd3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrT26p7/Td4sh2bseRk6T5wlePqmBoWmVZkJeSEvQobLbwJ/47
	y7GTEbnnd9MVakE0YA+2dzahalkJMS+ZacnTwyepEffdKcvEYUOUhJMv3mA6zplLInatGvSt12I
	suUn5nnJGJ8TFfuGPVNRV5xp/bP4S/MWFrn96AcG2iyaLFCRJcIphPNrrp7+Wsg==
X-Gm-Gg: ASbGncsSRejkSwQFlZd5OCBvCTX8G+ytv3UEtohUXVqGFOxOUV1vpimuax5E7xoXDma
	NdwYmi84b5TJAbwkHOOc5JvKSbJvI7c5DWTG4R2oiGomtNXGpJypyvnsVTGVp/kTqg2PW31f7Yv
	GOmoUfN8qwEDHdWShmzc+4oU32QwC695V/gmtTMN8EWXczTdTFGOLTy1eJwNbt6y3v6VA661RLY
	rOA8oyZebtIcudLKwCjTMlcusyUoohBCHcG1lUB1uMWleaFgTeGjTIckVCK98nRaowgWjScEtYf
	Zd3B
X-Received: by 2002:ac8:7d12:0:b0:471:f9e7:5042 with SMTP id d75a77b69052e-472228c8a05mr12768541cf.14.1740085959468;
        Thu, 20 Feb 2025 13:12:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeQfu058LR1kRfqUXheBmLeMkDI9GrPLeFQePU0jOVNla+OHHae6F1M0ual5fuW+EP0kWHsA==
X-Received: by 2002:ac8:7d12:0:b0:471:f9e7:5042 with SMTP id d75a77b69052e-472228c8a05mr12768241cf.14.1740085959143;
        Thu, 20 Feb 2025 13:12:39 -0800 (PST)
Received: from [192.168.2.110] ([70.52.22.87])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-472042563edsm31506991cf.2.2025.02.20.13.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 13:12:38 -0800 (PST)
Message-ID: <14156018-a4ad-48ba-98e1-4b1f6e732dd2@redhat.com>
Date: Thu, 20 Feb 2025 16:12:28 -0500
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
 <0a8bd481-0b97-416d-935e-84828016445d@redhat.com>
 <70971ae0-3933-4e55-983a-24c6b65ef913@redhat.com>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <70971ae0-3933-4e55-983a-24c6b65ef913@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-02-20 15:45, David Hildenbrand wrote:
>>>> +    for (__iter.index = 0;                                 \
>>>> +        __page_ext && __iter.index < __pgcount;        \
>>>> +        __page_ext = page_ext_iter_next(&__iter),      \
>>>> +        __iter.index++)
>>>
>>> Hm, if we now have an index, why not turn iter.pfn -> iter.start_pfn, and only adjust the index in page_ext_iter_next?
>>>
>>> Then you can set the index to 0 in page_ext_iter_begin() and have here
>>>
>>> for (__page_ext = page_ext_iter_begin(&__iter, __page),
>>>        __page_ext && __iter.index < __pgcount,
>>>        __page_ext = page_ext_iter_next(&__iter);)
>>
>> I can do this if you feel strong about it, but I prefer explicitly over
>> implicitly. I moved the index into the iter object just to avoid having
>> to define it in the macro's body. Also, the way I did it allows for
>> using page_ext_iter_begin()/page_ext_iter_next() own their if the need
>> arises.
> 
> Ah, I see what you mean.
> 
> for (__page_ext = page_ext_iter_begin(&__iter, __page, __pgcount);
>       __page_ext;
>       __page_ext = page_ext_iter_next(&__iter))
> 
> Could do that I guess by moving the count in there as well and performing the check+increment in page_ext_iter_next.
> 
> That looks very clean to me, but no strong opinion. Having the index in there just to make a macro happy is rather weird.

OK, I'll give this a try.

>>> A page_ext_iter_reset() could then simply reset the index=0 and
>>> lookup the page_ext(start_pfn + index) == page_ext(start_pfn)
>>
>> Just note we don't have page_ext_iter_reset() today (and I guess it's
>> not needed).
> 
> Right, was writing this before reviewing the other patch.
> 
>>
>>>> +
>>>> +/**
>>>> + * for_each_page_ext_order(): iterate through page_ext objects
>>>> + *                            for a given page order
>>>> + * @__page: the page we're interested in
>>>> + * @__order: page order to iterate through
>>>> + * @__page_ext: struct page_ext pointer where the current page_ext
>>>> + *              object is returned
>>>> + * @__iter: struct page_ext_iter object (defined in the stack)
>>>> + *
>>>> + * IMPORTANT: must be called with RCU read lock taken.
>>>> + */
>>>> +#define for_each_page_ext_order(__page, __order, __page_ext, __iter) \
>>>> +    for_each_page_ext(__page, (1UL << __order), __page_ext, __iter)
>>>> +
>>>>    #else /* !CONFIG_PAGE_EXTENSION */
>>>>    struct page_ext;
>>>> diff --git a/mm/page_ext.c b/mm/page_ext.c
>>>> index 641d93f6af4c1..508deb04d5ead 100644
>>>> --- a/mm/page_ext.c
>>>> +++ b/mm/page_ext.c
>>>> @@ -549,3 +549,44 @@ void page_ext_put(struct page_ext *page_ext)
>>>>        rcu_read_unlock();
>>>>    }
>>>> +
>>>> +/**
>>>> + * page_ext_iter_begin() - Prepare for iterating through page extensions.
>>>> + * @iter: page extension iterator.
>>>> + * @page: The page we're interested in.
>>>> + *
>>>> + * Must be called with RCU read lock taken.
>>>> + *
>>>> + * Return: NULL if no page_ext exists for this page.
>>>> + */
>>>> +struct page_ext *page_ext_iter_begin(struct page_ext_iter *iter, struct page *page)
>>>> +{
>>>> +    iter->pfn = page_to_pfn(page);
>>>> +    iter->page_ext = lookup_page_ext(page);
>>>> +
>>>> +    return iter->page_ext;
>>>> +}
>>>> +
>>>> +/**
>>>> + * page_ext_iter_next() - Get next page extension
>>>> + * @iter: page extension iterator.
>>>> + *
>>>> + * Must be called with RCU read lock taken.
>>>> + *
>>>> + * Return: NULL if no next page_ext exists.
>>>> + */
>>>> +struct page_ext *page_ext_iter_next(struct page_ext_iter *iter)
>>>> +{
>>>> +    if (WARN_ON_ONCE(!iter->page_ext))
>>>> +        return NULL;
>>>> +
>>>> +    iter->pfn++;
>>>   > +> +    if (page_ext_iter_next_fast_possible(iter->pfn)) {
>>>> +        iter->page_ext = page_ext_next(iter->page_ext);
>>>> +    } else {
>>>> +        iter->page_ext = lookup_page_ext(pfn_to_page(iter->pfn));
>>>> +    }
>>>> +
>>>> +    return iter->page_ext;
>>>> +}
>>>
>>> We now always have a function call when calling into page_ext_iter_next(). Could we move that to the header and rather expose lookup_page_ext() ?
>>
>> I personally don't like over-using inline functions, also I don't think this
>> code needs optimization since the current clients make the affected code paths
>> slow anyways (and this also applies to the likely/unlikely use in page_owner
>> and page_table_check, I'd drop all of them if you ask me). But again, I can
>> change if this would prevent you from giving your ACK :)
> 
> Well, 512^512 function calls for a 1 GiB page just to traverse the page ext? :)

Page_owner may allocate memory, do hash lookup and what not from that code path.
But you have a point that other clients (such as page_table_check) may benefit.


