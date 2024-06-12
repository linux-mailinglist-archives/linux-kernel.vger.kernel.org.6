Return-Path: <linux-kernel+bounces-211059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1481F904C9F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BD6528606D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8587016B75B;
	Wed, 12 Jun 2024 07:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P721UT+q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F350D16B736
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176956; cv=none; b=M2gnt6WzdgA811E0Gqb9Tsoopelw126W+ppYqWnoxtRUDNUZaeYZ6ocO7+ienFlzuvTYVO+wbTIc2ku7MHV5jahkrcEVuns+Ax+cQFkU9Fv5McDAl8HI+cXNfAaRY5md3yUe0vnwIAvSFGdbP4XTj9WoDiqYt86iNf/9ogPwaOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176956; c=relaxed/simple;
	bh=7jrTYdeBADn5LaWf8IOcyVRRUWfz92pgbF9RfoJEwBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UOiHy4THugGpJKGLo8aQavOGufWGyFNs1od+CzRt1GCyXVCuLPHa4jAwQ9yS38hmTQpkh17F/PkUZNO8x3HqOuI3vqABEa/jmQqV4LaCg3RomTkV54IBDBFbf3PbzYQUZBybM+4JZwsJNXdknA78nx23OrhnbRfPXVjxTN7iLWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P721UT+q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718176953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IsysMuQZtmODlcsfA4iD91Sp9eeYUlHGeSIpvaoB8M8=;
	b=P721UT+qX1TTocpijZlTEHO9mGQLGRGAOSbShfoYqLxduW+KVnsfFvpkSCrDulqmG+WdrQ
	PKnp256Pa12Ass0rGXE/O+ulPvn6OCJEQiMxjuHATVwsjTSXWnCE6X6YFOEQV14CY78W56
	0vefiYQGYqbK/mKH9rSbOGeduAGqIWw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-h8S9C81DP7i-qWE0sGh5aQ-1; Wed, 12 Jun 2024 03:22:29 -0400
X-MC-Unique: h8S9C81DP7i-qWE0sGh5aQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52c844aec2eso2787230e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 00:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718176948; x=1718781748;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IsysMuQZtmODlcsfA4iD91Sp9eeYUlHGeSIpvaoB8M8=;
        b=gZ9wVA++7oYUVCa/UneebtNvRBM7V/3nLWKYdF56ocIERBnw5N9BD8NSyALRmOLh4w
         AR+gKxgkM0olXlbBEPwt51Go1lZ0gPxNxSVneK1p1p9Qq6waD8xp/P+0wP4uDcq3MKR2
         i0gMyydve3TIFJvF5zPkbPwODG2f12q30V2BcCYDP6Fy3ORJqPGVco5xVsSPeGvJTrSX
         w1rq8qqBEwPUH6/MXEvqCYt5qhdTJCWY0vVh3iTSQYBckr/iVhtrMyvPx/syT9Wu+LvV
         fDUj4nMrfbgQ0ZobUvb0COCUw5nkDpCG6PCCitb/YQc8aUWEVaZMYmNAlR8ZzQ7XEfk/
         JdVg==
X-Forwarded-Encrypted: i=1; AJvYcCUVGai9boTr9N/ft1J8HtQ0w6gH4iu7pEqOANh3TnL7qvYt33plJQe//fPviM4NuMg7XEz610xMAoCWvYBVTixExiUvU3tGegoRzoRw
X-Gm-Message-State: AOJu0YyMLllf+k1a174dQhsKcHgoy4NQm59n/z36D1mi7ojr/dwPbbZP
	flpwlpaOdwqduhv7z8PsxswtlC0hNNxLA9mbdGnHCfYu/htOolMGrsqp+DlOy72bgjYzPWZucgE
	DUQ+npeVninU2hQbHzNlw9G81Pwqk4ASGDs0LQcSCxyOL/0W8Lux4MsxMWvTSQxcAk6lw6A==
X-Received: by 2002:a19:ca59:0:b0:52c:7fc3:601 with SMTP id 2adb3069b0e04-52c9a405c23mr616847e87.61.1718176948044;
        Wed, 12 Jun 2024 00:22:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEB7rCH2f+lBbS7rwN+4unQw5oDaxyfqECwKNNFktQePchFLnTKEaI3pYiLazCO6lja6L/WHA==
X-Received: by 2002:a19:ca59:0:b0:52c:7fc3:601 with SMTP id 2adb3069b0e04-52c9a405c23mr616822e87.61.1718176947506;
        Wed, 12 Jun 2024 00:22:27 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:bf00:abf6:cc3a:24d6:fa55? (p200300cbc702bf00abf6cc3a24d6fa55.dip0.t-ipconnect.de. [2003:cb:c702:bf00:abf6:cc3a:24d6:fa55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286fe7629sm14175805e9.10.2024.06.12.00.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 00:22:27 -0700 (PDT)
Message-ID: <2d0df7ca-2720-4a0c-95c5-9b665a567e5f@redhat.com>
Date: Wed, 12 Jun 2024 09:22:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mm/highmem: make nr_free_highpages() return
 "unsigned long"
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
References: <20240607083711.62833-1-david@redhat.com>
 <20240607083711.62833-3-david@redhat.com>
 <ZmZ1x6QQYPFSOd7O@localhost.localdomain>
 <99073d55-5b18-4ed2-b860-8c09e056f585@redhat.com>
 <20240611005636.g6525rkqpos43yds@master>
 <04b3dda2-c6a8-4f26-90b8-75fe7580d63e@redhat.com>
 <20240612070144.q6rpbq2hkwtielav@master>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240612070144.q6rpbq2hkwtielav@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.06.24 09:01, Wei Yang wrote:
> On Tue, Jun 11, 2024 at 11:20:00AM +0200, David Hildenbrand wrote:
>> On 11.06.24 02:56, Wei Yang wrote:
>>> On Mon, Jun 10, 2024 at 10:22:49AM +0200, David Hildenbrand wrote:
>>>> On 10.06.24 05:40, Oscar Salvador wrote:
>>>>> On Fri, Jun 07, 2024 at 10:37:11AM +0200, David Hildenbrand wrote:
>>>>>> It looks rather weird that totalhigh_pages() returns an
>>>>>> "unsigned long" but nr_free_highpages() returns an "unsigned int".
>>>>>>
>>>>>> Let's return an "unsigned long" from nr_free_highpages() to be
>>>>>> consistent.
>>>>>>
>>>>>> While at it, use a plain "0" instead of a "0UL" in the !CONFIG_HIGHMEM
>>>>>> totalhigh_pages() implementation, to make these look alike as well.
>>>>>>
>>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>>> ...
>>>>>> -static inline unsigned int nr_free_highpages(void) { return 0; }
>>>>>> -static inline unsigned long totalhigh_pages(void) { return 0UL; }
>>>>>> +static inline unsigned long nr_free_highpages(void) { return 0; }
>>>>>> +static inline unsigned long totalhigh_pages(void) { return 0; }
>>>>>
>>>>> Although I doubt it has any consequences, I would just leave them both with UL,
>>>>> so the return type is consistent with what we are returning.
>>>>
>>>> These suffixes are only required when using constants that would not fit
>>>> into the native (int) type, or converting from that native (int) type to
>>>> something else automatically by the compiler would mess things up (for example,
>>>> undesired sign extension). For 0 that is certainly impossible :)
>>>>
>>>>
>>>> That's also the reason why in include/linux we now have:
>>>>
>>>> t14s: ~/git/linux/include/linux $ git grep "return 0UL;"
>>>> skbuff.h:       return 0UL;
>>>> uaccess.h:static inline unsigned long user_access_save(void) { return 0UL; }
>>>> t14s: ~/git/linux/include/linux $ git grep "0UL;"
>>>> bitmap.h:               *dst = ~0UL;
>>>> dax.h:          return ~0UL;
>>>> mtd/map.h:                      r.x[i] = ~0UL;
>>>> netfilter.h:    return ((ul1[0] ^ ul2[0]) | (ul1[1] ^ ul2[1])) == 0UL;
>>>> skbuff.h:       return 0UL;
>>>> uaccess.h:static inline unsigned long user_access_save(void) { return 0UL; }
>>>>
>>>>
>>>> ... compared to a long list if "unsigned long" functions that simply "return 0;"
>>>>
>>>
>>> Seems this is the current status.
>>>
>>> Then my question is do we have a guide line for this? Or 0 is the special
>>> case? Sounds positive value has no sign extension problem. If we need to
>>> return 1, we suppose to use 1 or 1UL? I found myself confused.
>>>
>>> I grepped "return 1" and do find some cases without UL:
>>>
>>> backing-dev.h: wb_stat_error() return 1 for unsigned long.
>>> pgtable.h: pte_batch_hint() return 1 for unsigned int.
>>>
>>> So the guide line is for positive value, it is not necessary to use UL?
>>
>> I think when returning simple values (0/1/-1), we really don't need these
>> suffices at all. The standard says "The type of an integer constant is the
>> first of the corresponding list in which its value can be represented.". I
>> thought it would always use an "int", but that is not the case.
>>
>> So, if we use "-1", the compiler will use an "int", and sign extension to
>> "unsigned" long will do the right thing.
>>
>> Simple test:
>>
>> -1 results in: 0xffffffffffffffff
>> -1U results in: 0xffffffff
>> -1UL results in: 0xffffffffffffffff
>> 0xffffffff results in: 0xffffffff
>> 0xffffffffU results in: 0xffffffff
>> 0xffffffffUL results in: 0xffffffff
>> ~0xffffffff results in: 0x0
>> ~0xffffffffU results in: 0x0
>> ~0xffffffffUL results in: 0xffffffff00000000
>> 0xffffffffffffffff results in: 0xffffffffffffffff
>> 0xffffffffffffffffU results in: 0xffffffffffffffff
> 
> I expect this to be 0xffffffff. Why this extend it to a UL?

Apparently, the "U" only restricts the set of types to "unsigned ones".

https://en.cppreference.com/w/cpp/language/integer_literal

So the compiler will use the first "unsigned" type that can hold that value.

-- 
Cheers,

David / dhildenb


