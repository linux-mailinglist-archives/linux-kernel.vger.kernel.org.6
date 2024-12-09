Return-Path: <linux-kernel+bounces-437790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0299E98A4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC6E284D7A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA301ACEDB;
	Mon,  9 Dec 2024 14:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VUGQkSPA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79991B4223
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754159; cv=none; b=l2rQFaSdd+Yhx9gtRqz+lEcgow5Dij9u71OBZX43ZgCUrVLag++agl7do0bzb8p/qNtULoZy0WUI+Ufw+VBRv4B/pnIxmYl4DybSfe22l/Ir2iP741Tldqe/O6UFlp2i0RpP+HD9X3ZxxwnEGaZdjsv22QrWbwsdMeD8lDDnCMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754159; c=relaxed/simple;
	bh=dW5RYeM/gYngnM/Obmtes1f0bNczFoVhU0hFOhUZjjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s9Sq10dxj/As+54s7Ak7IWGJF5SU7XV7/DYJh1czY6iei98gPaSf9k1KBHAR/ZZKJUN0beN56uD6l3Wpe0vqgvMtKyEgVL+RDjijkQDUBIIBwL5zbXXfGrrHgJ7w3/wWb/RUORvZ+nCKT2B92IDyuBrkZ3FC4fOuBlL1o0921Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VUGQkSPA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733754156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Mrc3k+K/yTD9d27E3LfzBWeCtSATx6WkPMaFyVBe5Dk=;
	b=VUGQkSPADTikdlqcBpK2Uto1ioQAA4/QCk6+CEV8T2WAOfIZI7h65s86gC5EKILjYUTX9v
	yUcv0yQqFFPdRtcjsiaE2+vL5BlQkLTraFJZ8KS7BmIOTMxuB3YVg1ugPJ9iJDAdE8o5Tf
	i0noJoj3iPmK+PedvMfepot8YkKynaA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-WWCm9LN4PHqN06edRE0J4g-1; Mon, 09 Dec 2024 09:22:35 -0500
X-MC-Unique: WWCm9LN4PHqN06edRE0J4g-1
X-Mimecast-MFC-AGG-ID: WWCm9LN4PHqN06edRE0J4g
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434f112d83aso14001805e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 06:22:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733754154; x=1734358954;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mrc3k+K/yTD9d27E3LfzBWeCtSATx6WkPMaFyVBe5Dk=;
        b=jW1MnGkLcj8kSdsfJ0aks+g7jfwfNnScput13Ti99DU+KJ285O5EpOd8Z8Pfqtv1Ai
         XrLwzNfVAwiiko7PG68qpVnQ5UgL/L1n6MRWECDQZHPzGMCdBMasmAEn3lvrpqAFoHdT
         x00HWs0XbdUqDWg2fI36EIswYe+nvEcj/zq3TuEzNAWF4YhN8NcJLHtKnPfZ3366t/lV
         1H3G+97QglDT3V/t+5xE7TRCBimxsdQEFh6uFWB7pB9E+eSmutoU0lAAVu9x5anXKpBf
         vxe1iHa2Gcyo5Mv0L+U5hi3+n7x+XPdNfCsztg379/xVMPLz4U2Dw+YRelxW7tt1Cq27
         91NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB0XugxjxDJ5ahRzXlacy8xF+H3w60mm/AsJcB6y8uWgs1Ou/WoScpIb9k2JXgwqesTLQe1iItss5+RD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMa6G8ZUfHIWya2BKlOdqAi8E3ejhSvSXYHmDpQU2+ApyL7suR
	XQ0n+yo3/7S0eXMKeEjAntziF64LS3czGZ92bAcTIjOjHzp1t/TTeVXl6GR24fSFLt+SHkcmx9H
	UJ+pFlfCe4kaDAMJ/1aRIhm7EF5nzYAZbtEbRSHIY+/xnYv0chmDQIYjPmikoVg==
X-Gm-Gg: ASbGnctMxxHIQjwBUbAwp7cwxntayeOgBUtm42ZtT/e9YF9KrsHzZYiCLpmTl10nOFx
	ltNqz8wDC2xcp113U+z3c38opncd0OI1i+cYzLjhItoVXxgex5OaGWljlwH4HjX5cAnEggOT+LW
	BclmAWYKy+r9q1qOQE1rTRXoasggbx71aVNOYW06NeYBb0bE5cD/6AS6Y6suv1jFW+9MnZyS7/y
	1U73MHJzkwa6K1Q9cLvJ5AO3a6NIG5z8k7WdV8ANik6VlVSPTxarp6aPj+MHR2XP5EZA4GOgXdL
	HNP3uzIX
X-Received: by 2002:a05:6000:1f83:b0:385:faf5:eba6 with SMTP id ffacd0b85a97d-3862b331626mr11671071f8f.1.1733754154463;
        Mon, 09 Dec 2024 06:22:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEVggv+QrPgNi5/mUpTV5M0JPuQqNJyYGPboXbEyB99ijiLiFn2Iz70GdrlEAnpYfKWwp8ig==
X-Received: by 2002:a05:6000:1f83:b0:385:faf5:eba6 with SMTP id ffacd0b85a97d-3862b331626mr11671041f8f.1.1733754154087;
        Mon, 09 Dec 2024 06:22:34 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862190966bsm13527404f8f.75.2024.12.09.06.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 06:22:32 -0800 (PST)
Message-ID: <f5a65bf5-5105-4376-9c1c-164a15a4ab79@redhat.com>
Date: Mon, 9 Dec 2024 15:22:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: remove an avoidable load of page refcount in
 page_ref_add_unless
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: yuzhao@google.com, akpm@linux-foundation.org, willy@infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20241207082931.1707465-1-mjguzik@gmail.com>
 <94d0dcbe-2001-4a9c-a767-b337b688b616@redhat.com>
 <CAGudoHEggB=F9j7r+ndQs1WxpRWB4O5VdBo+PLx+yd1xrj4-Ew@mail.gmail.com>
 <606fbf9a-c9ba-4f08-a708-db38fe6065ce@redhat.com>
 <CAGudoHFLTet0ZpOkDMFBh0yBDhJ47st-aRrCLZojdrCgQKznUQ@mail.gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGudoHFLTet0ZpOkDMFBh0yBDhJ47st-aRrCLZojdrCgQKznUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09.12.24 13:33, Mateusz Guzik wrote:
> On Mon, Dec 9, 2024 at 11:56 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 09.12.24 11:25, Mateusz Guzik wrote:
>>> On Mon, Dec 9, 2024 at 10:28 AM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 07.12.24 09:29, Mateusz Guzik wrote:
>>>>> Explicitly pre-checking the count adds nothing as atomic_add_unless
>>>>> starts with doing the same thing. iow no functional changes.
>>>>
>>>> I recall that we added that check because with the hugetlb vmemmap
>>>> optimization, some of the tail pages we don't ever expect to be modified
>>>>     (because they are fake-duplicated) might be mapped R/O.
>>>>
>>>> If the arch implementation of atomic_add_unless() would trigger an
>>>> unconditional write fault, we'd be in trouble. That would likely only be
>>>> the case if the arch provides a dedicate instruction.
>>>>
>>>> atomic_add_unless()->raw_atomic_add_unless()
>>>>
>>>> Nobody currently defines arch_atomic_add_unless().
>>>>
>>>> raw_atomic_fetch_add_unless()->arch_atomic_fetch_add_unless() is defined
>>>> on some architectures.
>>>>
>>>> I scanned some of the inline-asm, and I think most of them perform a
>>>> check first.
>>>>
>>>
>>> Huh.
>>>
>>> Some arch triggering a write fault despite not changing the value is
>>> not something I thought about. Sounds pretty broken to me if any arch
>>> was to do it, but then stranger things did happen.
>>
>> Yeah, it really depends on what the architecture defines. For example,
>> on s390x for "COMPARE AND SWAP" the spec states something like
>>
> [snip]
> 
> Well in this context you need to do the initial load to even know what
> to CAS with, unless you want to blindly do it hoping to get lucky,
> which I'm assuming no arch is doing.
> 
> Granted, if there was an architecture which had an actual "cas unless
> the value is x" then this would not hold, but I don't know of any.
> [such an extension would be most welcome fwiw]

Apparently, we prepared for that via arch_atomic_add_unless(), which has no users.

> 
> Assuming you indeed want the patch after all, can you sort out adding
> a comment to atomic_add_unless yourself? ;) I presume you know the
> right people and whatnot, so this would cut down on back and forth.
> 
> That is to say I think this thread just about exhausted the time
> warranted by this patch. No hard feelz if it gets dropped, but then I
> do strongly suggest adding a justification to the extra load.

Maybe it's sufficient for now to simply do your change with a comment:

diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index 8c236c651d1d6..1efc992ad5687 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -234,7 +234,13 @@ static inline bool page_ref_add_unless(struct page *page, int nr, int u)
  
         rcu_read_lock();
         /* avoid writing to the vmemmap area being remapped */
-       if (!page_is_fake_head(page) && page_ref_count(page) != u)
+       if (!page_is_fake_head(page))
+               /*
+                * atomic_add_unless() will currently never modify the value
+                * if it already is u. If that ever changes, we'd have to have
+                * a separate check here, such that we won't be writing to
+                * write-protected vmemmap areas.
+                */
                 ret = atomic_add_unless(&page->_refcount, nr, u);
         rcu_read_unlock();
  

It would bail out during testing ... hopefully, such that we can detect any such change.

-- 
Cheers,

David / dhildenb


