Return-Path: <linux-kernel+bounces-197733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8F18D6E88
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 08:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02BD12899FE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 06:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA20F134BC;
	Sat,  1 Jun 2024 06:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJUXXgzF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CE5DDB8
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 06:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717224290; cv=none; b=rRbRBSCio+82G6hfwtteQgMR6EIp3aPsqc3h7l2Q8sF1mzJ+jag3fFMFwTdiVEa1mldlGQPu+SOQOewrHQyYh/ZeySq6Ur/LSCG8Kh4Cl02X6ZpiISfpRJEZ9M4cHCA910BZUjgHhhZTiOMHFSTf4EJSsv+wiREUoWhX8FDYzXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717224290; c=relaxed/simple;
	bh=e+PTCo589xTEgY90J5HUmu2tDNfSaOg+AxLy4QLCeNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=io6wU3bfAliXvWYD7A6bdPNZQQrsC6sdpsSaA2LVONXTZpDIYB3IyFpQ3thwonMBkc42r0ZdHGPcvVigcwgyEFdU0HFHdX2toEPnE1j+5v2YKD/VOkI2xNtXGxC622aqaI6OY6W72Ps2smPffBXwAp5d39wmJaAGs/p5iYoGTCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XJUXXgzF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717224287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bV//IZXKmmB/cI+410WyqC8NPdVn7fVm2YZQJyzhfFA=;
	b=XJUXXgzFZ+JkMDNJ+/aQw973/d3099PuYcoh1vojygaQQwyl17uGwARE0Gm35qQw6+ZSex
	zpIvZoT7xihhhNGTpfLvKqBfkEs1xi7bZ8ngAO7yraw+1oqhqGli3ln3WWWiGl0tAWm6mG
	fW8pPbigcoFqwStLSqfbQEUAOKLb/d4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-SxpU-vnnON2m62DvnTI8mQ-1; Sat, 01 Jun 2024 02:44:45 -0400
X-MC-Unique: SxpU-vnnON2m62DvnTI8mQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ea8f9159f4so12361011fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 23:44:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717224284; x=1717829084;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bV//IZXKmmB/cI+410WyqC8NPdVn7fVm2YZQJyzhfFA=;
        b=N9lp7V9lLmEw0/2lhkU2KhCXE5S0lcoZ5RJzzRMfBLbCror2dFLWPV2IMfc0eWXyoz
         AFxPNYL0C5QvbPc61Rm9jWBEscJOZ7Rm0i11Y3MEZqyQs+H/HiBuozohGatuqPTTdA0i
         /TIre9coTVvYPXvJdaHIeovMtB0bKqHNYw2qvsMlVM0GA4aZmp+1BwDKFkd5j/fdCT28
         khxxMIY4OOaVglv+dflKllePZi0G2UyPoGRz9ut2O8g18EH/Ak4V90ilYznEX/8iEOkf
         AWUeYKuc4errdDhtdvkwp8hokd2r2/XwrQcNW2g0Pn+HKeI2ylbyv7DDGR3bom8K8+7u
         02Ow==
X-Forwarded-Encrypted: i=1; AJvYcCV5Ji1MaO9/CFzqFMRhDY1lSsRS0ZP8E2CRiC3ZGLGfIjwOzlW5LgJBqeKmUU5QRlTbdZIPy9DpvVBGWsrOGhc69oHiTAgpE3uYEmt5
X-Gm-Message-State: AOJu0YyqkZpX7twrQfrCH0cBRLNykdt5VBHsLmYEm4y8PG+32y3rqq4O
	hJjon9MzIoXfLe6I/QZICMWbH3UZS3ZTF+5P/Mi5KI+/OWefTs0+PL1xOz/DtPZtl9a78/NvPu+
	bQCnd995zIR0EeNkGpubCnYhWWOYbHJx1V+ynNIMKfiCwj7EBCULQNoNHUSn2X94YI9x1+g==
X-Received: by 2002:a05:651c:78a:b0:2ea:772a:ddb4 with SMTP id 38308e7fff4ca-2ea951ac7e3mr23853321fa.34.1717224284289;
        Fri, 31 May 2024 23:44:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2Kfdgj7cvmwkGlrYhR9q6t44XFUgHP9L3vy/kt/cwB/pFSYLlcltTHcj6AWTI4KFaxl54fw==
X-Received: by 2002:a05:651c:78a:b0:2ea:772a:ddb4 with SMTP id 38308e7fff4ca-2ea951ac7e3mr23853161fa.34.1717224283684;
        Fri, 31 May 2024 23:44:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71f:b300:1d59:157a:ba27:f7e0? (p200300cbc71fb3001d59157aba27f7e0.dip0.t-ipconnect.de. [2003:cb:c71f:b300:1d59:157a:ba27:f7e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b8b76f3sm44775025e9.47.2024.05.31.23.44.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 23:44:43 -0700 (PDT)
Message-ID: <3be98b72-eb54-4963-a130-ec6033ab1403@redhat.com>
Date: Sat, 1 Jun 2024 08:44:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: swap: reuse exclusive folio directly instead of
 wp page faults
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, chrisl@kernel.org,
 surenb@google.com, kasong@tencent.com, minchan@kernel.org,
 willy@infradead.org, ryan.roberts@arm.com, linux-kernel@vger.kernel.org,
 Barry Song <v-songbaohua@oppo.com>
References: <20240531104819.140218-1-21cnbao@gmail.com>
 <87ac9610-5650-451f-aa54-e634a6310af4@redhat.com>
 <CAGsJ_4zgf8j0oRnVBhe-__=K2RFDHTCo-JnMak95HTvxtMUwnQ@mail.gmail.com>
 <d4c1a9ad-4945-40d7-9b7a-5b02df805884@redhat.com>
 <CAGsJ_4xpDwTTbwzMx8ipmpCyNmVmABpRN1f9yfZfFiOaGMKiew@mail.gmail.com>
 <CAGsJ_4yX52k=Wx2x3jwXzNBG=rDGJrzGNwGCAh0puUP7zby=QA@mail.gmail.com>
 <821d29b9-cb06-49db-9fe8-6c054c8787fb@redhat.com>
 <CAGsJ_4xrH0iQ1KU6ATWVx4SutfWqCBC6bF-a1tJyRFRKcOUV4A@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
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
In-Reply-To: <CAGsJ_4xrH0iQ1KU6ATWVx4SutfWqCBC6bF-a1tJyRFRKcOUV4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01.06.24 02:48, Barry Song wrote:
> On Sat, Jun 1, 2024 at 12:35 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 31.05.24 14:30, Barry Song wrote:
>>> On Sat, Jun 1, 2024 at 12:20 AM Barry Song <21cnbao@gmail.com> wrote:
>>>>
>>>> On Sat, Jun 1, 2024 at 12:10 AM David Hildenbrand <david@redhat.com> wrote:
>>>>>
>>>>> On 31.05.24 13:55, Barry Song wrote:
>>>>>> On Fri, May 31, 2024 at 11:08 PM David Hildenbrand <david@redhat.com> wrote:
>>>>>>>
>>>>>>> On 31.05.24 12:48, Barry Song wrote:
>>>>>>>> From: Barry Song <v-songbaohua@oppo.com>
>>>>>>>>
>>>>>>>> After swapping out, we perform a swap-in operation. If we first read
>>>>>>>> and then write, we encounter a major fault in do_swap_page for reading,
>>>>>>>> along with additional minor faults in do_wp_page for writing. However,
>>>>>>>> the latter appears to be unnecessary and inefficient. Instead, we can
>>>>>>>> directly reuse in do_swap_page and completely eliminate the need for
>>>>>>>> do_wp_page.
>>>>>>>>
>>>>>>>> This patch achieves that optimization specifically for exclusive folios.
>>>>>>>> The following microbenchmark demonstrates the significant reduction in
>>>>>>>> minor faults.
>>>>>>>>
>>>>>>>>      #define DATA_SIZE (2UL * 1024 * 1024)
>>>>>>>>      #define PAGE_SIZE (4UL * 1024)
>>>>>>>>
>>>>>>>>      static void *read_write_data(char *addr)
>>>>>>>>      {
>>>>>>>>              char tmp;
>>>>>>>>
>>>>>>>>              for (int i = 0; i < DATA_SIZE; i += PAGE_SIZE) {
>>>>>>>>                      tmp = *(volatile char *)(addr + i);
>>>>>>>>                      *(volatile char *)(addr + i) = tmp;
>>>>>>>>              }
>>>>>>>>      }
>>>>>>>>
>>>>>>>>      int main(int argc, char **argv)
>>>>>>>>      {
>>>>>>>>              struct rusage ru;
>>>>>>>>
>>>>>>>>              char *addr = mmap(NULL, DATA_SIZE, PROT_READ | PROT_WRITE,
>>>>>>>>                              MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>>>>>>>>              memset(addr, 0x11, DATA_SIZE);
>>>>>>>>
>>>>>>>>              do {
>>>>>>>>                      long old_ru_minflt, old_ru_majflt;
>>>>>>>>                      long new_ru_minflt, new_ru_majflt;
>>>>>>>>
>>>>>>>>                      madvise(addr, DATA_SIZE, MADV_PAGEOUT);
>>>>>>>>
>>>>>>>>                      getrusage(RUSAGE_SELF, &ru);
>>>>>>>>                      old_ru_minflt = ru.ru_minflt;
>>>>>>>>                      old_ru_majflt = ru.ru_majflt;
>>>>>>>>
>>>>>>>>                      read_write_data(addr);
>>>>>>>>                      getrusage(RUSAGE_SELF, &ru);
>>>>>>>>                      new_ru_minflt = ru.ru_minflt;
>>>>>>>>                      new_ru_majflt = ru.ru_majflt;
>>>>>>>>
>>>>>>>>                      printf("minor faults:%ld major faults:%ld\n",
>>>>>>>>                              new_ru_minflt - old_ru_minflt,
>>>>>>>>                              new_ru_majflt - old_ru_majflt);
>>>>>>>>              } while(0);
>>>>>>>>
>>>>>>>>              return 0;
>>>>>>>>      }
>>>>>>>>
>>>>>>>> w/o patch,
>>>>>>>> / # ~/a.out
>>>>>>>> minor faults:512 major faults:512
>>>>>>>>
>>>>>>>> w/ patch,
>>>>>>>> / # ~/a.out
>>>>>>>> minor faults:0 major faults:512
>>>>>>>>
>>>>>>>> Minor faults decrease to 0!
>>>>>>>>
>>>>>>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>>>>>>> ---
>>>>>>>>      mm/memory.c | 7 ++++---
>>>>>>>>      1 file changed, 4 insertions(+), 3 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>>>>> index eef4e482c0c2..e1d2e339958e 100644
>>>>>>>> --- a/mm/memory.c
>>>>>>>> +++ b/mm/memory.c
>>>>>>>> @@ -4325,9 +4325,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>>>>>           */
>>>>>>>>          if (!folio_test_ksm(folio) &&
>>>>>>>>              (exclusive || folio_ref_count(folio) == 1)) {
>>>>>>>> -             if (vmf->flags & FAULT_FLAG_WRITE) {
>>>>>>>> -                     pte = maybe_mkwrite(pte_mkdirty(pte), vma);
>>>>>>>> -                     vmf->flags &= ~FAULT_FLAG_WRITE;
>>>>>>>> +             if (vma->vm_flags & VM_WRITE) {
>>>>>>>> +                     pte = pte_mkwrite(pte_mkdirty(pte), vma);
>>>>>>>> +                     if (vmf->flags & FAULT_FLAG_WRITE)
>>>>>>>> +                             vmf->flags &= ~FAULT_FLAG_WRITE;
>>>>>>>
>>>>>>> This implies, that even on a read fault, you would mark the pte dirty
>>>>>>> and it would have to be written back to swap if still in the swap cache
>>>>>>> and only read.
>>>>>>>
>>>>>>> That is controversial.
>>>>>>>
>>>>>>> What is less controversial is doing what mprotect() via
>>>>>>> change_pte_range()/can_change_pte_writable() would do: mark the PTE
>>>>>>> writable but not dirty.
>>>>>>>
>>>>>>> I suggest setting the pte only dirty if FAULT_FLAG_WRITE is set.
>>>>>>
>>>>>> Thanks!
>>>>>>
>>>>>> I assume you mean something as below?
>>>>>
>>>>> It raises an important point: uffd-wp must be handled accordingly.
>>>>>
>>>>>>
>>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>>> index eef4e482c0c2..dbf1ba8ccfd6 100644
>>>>>> --- a/mm/memory.c
>>>>>> +++ b/mm/memory.c
>>>>>> @@ -4317,6 +4317,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>>>            add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
>>>>>>            pte = mk_pte(page, vma->vm_page_prot);
>>>>>>
>>>>>> +       if (pte_swp_soft_dirty(vmf->orig_pte))
>>>>>> +               pte = pte_mksoft_dirty(pte);
>>>>>> +       if (pte_swp_uffd_wp(vmf->orig_pte))
>>>>>> +               pte = pte_mkuffd_wp(pte);
>>>>>>            /*
>>>>>>             * Same logic as in do_wp_page(); however, optimize for pages that are
>>>>>>             * certainly not shared either because we just allocated them without
>>>>>> @@ -4325,18 +4329,19 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>>>             */
>>>>>>            if (!folio_test_ksm(folio) &&
>>>>>>                (exclusive || folio_ref_count(folio) == 1)) {
>>>>>> -               if (vmf->flags & FAULT_FLAG_WRITE) {
>>>>>> -                       pte = maybe_mkwrite(pte_mkdirty(pte), vma);
>>>>>> -                       vmf->flags &= ~FAULT_FLAG_WRITE;
>>>>>> +               if (vma->vm_flags & VM_WRITE) {
>>>>>> +                       if (vmf->flags & FAULT_FLAG_WRITE) {
>>>>>> +                               pte = pte_mkwrite(pte_mkdirty(pte), vma);
>>>>>> +                               vmf->flags &= ~FAULT_FLAG_WRITE;
>>>>>> +                       } else if ((!vma_soft_dirty_enabled(vma) ||
>>>>>> pte_soft_dirty(pte))
>>>>>> +                                   && !userfaultfd_pte_wp(vma, pte)) {
>>>>>> +                                       pte = pte_mkwrite(pte, vma);
>>>>>
>>>>> Even with FAULT_FLAG_WRITE we must respect uffd-wp and *not* do a
>>>>> pte_mkwrite(pte). So we have to catch and handle that earlier (I could
>>>>> have sworn we handle that somehow).
>>>>>
>>>>> Note that the existing
>>>>>           pte = pte_mkuffd_wp(pte);
>>>>>
>>>>> Will fix that up because it does an implicit pte_wrprotect().
>>>>
>>>> This is exactly what I have missed as I am struggling with why WRITE_FAULT
>>>> blindly does mkwrite without checking userfaultfd_pte_wp().
>>>>
>>>>>
>>>>>
>>>>> So maybe what would work is
>>>>>
>>>>>
>>>>> if ((vma->vm_flags & VM_WRITE) && !userfaultfd_pte_wp(vma, pte) &&
>>>>>        !vma_soft_dirty_enabled(vma)) {
>>>>>           pte = pte_mkwrite(pte);
>>>>>
>>>>>           /* Only set the PTE dirty on write fault. */
>>>>>           if (vmf->flags & FAULT_FLAG_WRITE) {
>>>>>                   pte = pte_mkdirty(pte);
>>>>>                   vmf->flags &= ~FAULT_FLAG_WRITE;
>>>>>           }
>>>
>>> WRITE_FAULT has a pte_mkdirty, so it doesn't need to check
>>> "!vma_soft_dirty_enabled(vma)"?
>>> Maybe I thought too much, just the simple code below should work?
>>
>> That would likely not handle softdirty correctly in case we end up in
>> pte_mkwrite(pte, vma); note that pte_mksoft_dirty() will not wrprotect ...
> 
> if SOFTDIRTY has been set, we shouldn't do wrprotect? till the dirty
> is cleared, we don't rely on further write fault to set soft dirty, right?

If softidrty is enabled for the VMA and the PTE is softdirty, we can 
(not should) map it writable.

My point is that softdirty tracking is so underused that optimizing it 
here is likely not required.

> 
> so we should better do pte_mkwrite if pte_soft_dirty(pte) == true?
> 
>   if ((vma->vm_flags & VM_WRITE) && !userfaultfd_pte_wp(vma, pte) &&
>        (!vma_soft_dirty_enabled(vma) || pte_soft_dirty(pte)))
> 
>>
>> (note that we shouldn't optimize for softdirty handling)
>>
>>>
>>>           if (!folio_test_ksm(folio) &&
>>>               (exclusive || folio_ref_count(folio) == 1)) {
>>>                   if (vma->vm_flags & VM_WRITE) {
>>>                           if (vmf->flags & FAULT_FLAG_WRITE) {
>>>                                   pte = pte_mkwrite(pte_mkdirty(pte), vma);
>>>                                   vmf->flags &= ~FAULT_FLAG_WRITE;
>>>                           } else {
>>>                                   pte = pte_mkwrite(pte, vma);
>>>                           }
>>>                   }
>>>                   rmap_flags |= RMAP_EXCLUSIVE;
>>>           }
>>>
>>>           if (pte_swp_soft_dirty(vmf->orig_pte))
>>>                   pte = pte_mksoft_dirty(pte);
>>>           if (pte_swp_uffd_wp(vmf->orig_pte))
>>>                   pte = pte_mkuffd_wp(pte);
>>>
>>> This still uses the implicit wrprotect of pte_mkuffd_wp.
>>
>> But the wrprotected->writable->wrprotected path really is confusing. I'd
>> prefer to set these bits ahead of time instead, so we can properly rely
>> on them -- like we do in other code.
> 
> I agree. we are setting WRITE then reverting the WRITE. It is confusing.
> 
> So in conclusion, we get the belows?
> 
>          if (pte_swp_soft_dirty(vmf->orig_pte))
>                  pte = pte_mksoft_dirty(pte);
>          if (pte_swp_uffd_wp(vmf->orig_pte))
>                  pte = pte_mkuffd_wp(pte);
> 
>          /*
>           * Same logic as in do_wp_page(); however, optimize for pages that are
>           * certainly not shared either because we just allocated them without
>           * exposing them to the swapcache or because the swap entry indicates
>           * exclusivity.
>           */
>          if (!folio_test_ksm(folio) &&
>              (exclusive || folio_ref_count(folio) == 1)) {
>                  if (vma->vm_flags & VM_WRITE && !userfaultfd_pte_wp(vma, pte)
>                      && (!vma_soft_dirty_enabled(vma) || pte_soft_dirty(pte))) {

And here the code gets ugly. Just do

if ((vma->vm_flags & VM_WRITE) && !userfaultfd_pte_wp(vma, pte) &&
     !vma_soft_dirty_enabled(vma)) {
	...
}

and don't optimize softdirty. Or if you really want to, have a helper 
function like userfaultfd_pte_wp() that wraps both checks.

>                          if (vmf->flags & FAULT_FLAG_WRITE) {
>                                  pte = pte_mkwrite(pte_mkdirty(pte), vma);
>                                  vmf->flags &= ~FAULT_FLAG_WRITE;
>                          } else {
>                                  pte = pte_mkwrite(pte, vma);
>                          }
>                  }

why not

pte = pte_mkwrite(pte, vma);
if (vmf->flags & FAULT_FLAG_WRITE) {
	pte = pte_mkdirty(pte);
	vmf->flags &= ~FAULT_FLAG_WRITE;
}


Conceptually, I think this should be fine.

-- 
Cheers,

David / dhildenb


