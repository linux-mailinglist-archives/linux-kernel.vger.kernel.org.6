Return-Path: <linux-kernel+bounces-170860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C8F8BDD09
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C69BB231EC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 08:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E78D13C900;
	Tue,  7 May 2024 08:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i5OPnU5Y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51DD13B78A
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 08:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715069834; cv=none; b=HDDH+2ceY7MLCu3NFSPfmAz5qvXhZNz30KcXk1yfrO9i1ty6kSHtnMfJDoN67gtDsSYpqxspGZIV6EjZCtovILaxsoBqT1xoFZ+UUnAIF+2GThvm6DmMZZ2tfMqfbl1R+OujwKuc3YUSEOOwfI9qUKV5E00lsttX82LCqA5Mr/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715069834; c=relaxed/simple;
	bh=nXbjA731s0fb0JqbzWZ5U8ckYAHCaTkStHRcpCaTX0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V9gWXbYZeU2MoQFTCVo+ON1VUkKj6qDTxritb79gCL3EYMsBjc4vNkUGptIRKfJIvYaJAdI+zd2CIlEk6MVPrP1rQBrGWL8r+nfWwkE7yxWCHMxUFHK3x+co0xGoDjXeLYnhM43klgY0HmN3xGSIkUrygOoEbj8bTP1NJ/QZcAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i5OPnU5Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715069831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mfUZc1p9raqNK7Ae42296i832t6G06pqME1gtnwXYU8=;
	b=i5OPnU5Yi+C74nkJRWdC80RwLwwMmv8XB2fyQTc+sG1yqEnCxWC6RuTrxOWVxr7dcBAH9d
	VpemUvdi+KlmeHXNIUy2Oiailv12cRc0QaVmbZpAdQH/4fTwIX5hXWdRsNnUydEfK9bjB8
	mR1JhJKIETZ4QWc/wxEPsTfMo11UP9Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-PnDLyLoWOX2k4N4pGKbCzg-1; Tue, 07 May 2024 04:17:10 -0400
X-MC-Unique: PnDLyLoWOX2k4N4pGKbCzg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-41c025915a9so12019605e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 01:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715069829; x=1715674629;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mfUZc1p9raqNK7Ae42296i832t6G06pqME1gtnwXYU8=;
        b=G+GQ9ohbBEMIDSFputxtKXM3s8PAJueH5j3tBjJYDZ+PwwqBVlZ6wggTkstxnAaiWz
         wpPcN9R0IbRTHcUmVABasVuQP4jj2myEB8qtyPz6BAHsCws7Ama9WbSjjf9v7HKIbMqa
         DVqeTBV+v+5wqNvvHBDrZ4uaAj3ntA2W0SShwYEZyXch/fhtA2w8v8CwY14FyJYnJlDD
         CKabWPPN//Q3gMX7a1sKef0DhligcuyqZG+UCdWUiDexQg8efxVBDoQg45m0sj2Ogg0B
         u+NGbsUo/Go8wtFxAwo1pW4KmL2l3nTCmrrakfBLHxFRjggMQe0gET4zFSIcTVpj4gvR
         9cOw==
X-Forwarded-Encrypted: i=1; AJvYcCUkSWw/1i4Vt7MZVdlrG9m7lOwq40R5kQCDpE05vGp1kw97Ea1O6FUZp6Sl/GiXcLEx8t7i8+C5SvHHrb+5mzAUIaoe0O3TOMH1lanR
X-Gm-Message-State: AOJu0YyCTkuk0H50sZi8kbXTGE5tnzY8zR6EGbaecEYu6KppOThFKqyw
	GyakPhLupDH0jtJpD59FcODVAmP0FGwwCiB56PyZgg7Zh51KJ8qzEB+Z70Tmunp6rgeQSE3VMkG
	CjBLO6zGUwAgVZuE7yZNw0lLnTRrvO5Nnm6oaIjqhOva3j36Sq2nPY/e8RiNjHw==
X-Received: by 2002:a05:600c:4f08:b0:41a:2044:1b3e with SMTP id l8-20020a05600c4f0800b0041a20441b3emr9023697wmq.32.1715069828858;
        Tue, 07 May 2024 01:17:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzmrsCmCsQm2g0fnh3GH0wLfj5Hhxfwd3rroOpwmM//0/ARq23fI44GGvUg5+pWaeQtWUsYA==
X-Received: by 2002:a05:600c:4f08:b0:41a:2044:1b3e with SMTP id l8-20020a05600c4f0800b0041a20441b3emr9023672wmq.32.1715069828405;
        Tue, 07 May 2024 01:17:08 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id w6-20020a05600c474600b004182b87aaacsm18736878wmo.14.2024.05.07.01.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 01:17:08 -0700 (PDT)
Message-ID: <a8f7a8da-c2e1-443c-9220-a224d97b1c81@redhat.com>
Date: Tue, 7 May 2024 10:17:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] mm/rmap: integrate PMD-mapped folio splitting into
 pagewalk loop
To: Lance Yang <ioworker0@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, sj@kernel.org,
 maskray@google.com, ziy@nvidia.com, ryan.roberts@arm.com, 21cnbao@gmail.com,
 mhocko@suse.com, fengwei.yin@intel.com, zokeefe@google.com,
 shy828301@gmail.com, xiehuan09@gmail.com, libang.li@antgroup.com,
 wangkefeng.wang@huawei.com, songmuchun@bytedance.com, peterx@redhat.com,
 minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240501042700.83974-1-ioworker0@gmail.com>
 <20240501042700.83974-3-ioworker0@gmail.com>
 <cc9fd23f-7d87-48a7-a737-acbea8e95fb7@linux.alibaba.com>
 <CAK1f24kyCj2Svguuu07wDuVEWYYbcmRc_18ihgVAzSjoJ9ox2A@mail.gmail.com>
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
In-Reply-To: <CAK1f24kyCj2Svguuu07wDuVEWYYbcmRc_18ihgVAzSjoJ9ox2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>>
>>> +             if (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)) {
>>> +                     /*
>>> +                      * We temporarily have to drop the PTL and start once
>>> +                      * again from that now-PTE-mapped page table.
>>> +                      */
>>> +                     split_huge_pmd_locked(vma, range.start, pvmw.pmd, false,
>>> +                                           folio);
>>> +                     pvmw.pmd = NULL;
>>> +                     spin_unlock(pvmw.ptl);
>>
>> IMO, you should also make the 'pvmw.ptl = NULL;' after unlocking as
>> page_vma_mapped_walk() did, in case some corner case met.
> 
> Yep, I'll also set pvmw.ptl to NULL here if any corner cases arise.
> 

This series already resides in mm-stable. I asked Andrew to remove it 
for now. If that doesn't work, we'll need fixup patches to address any 
review feedback.

-- 
Cheers,

David / dhildenb


