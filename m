Return-Path: <linux-kernel+bounces-248452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2419192DD51
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 02:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 170CC1C21AF1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 00:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656821C3D;
	Thu, 11 Jul 2024 00:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+41Qd+N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B4D372
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 00:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720656947; cv=none; b=PHH4d1SMVy0LHRaCxguHHTPUombxloSKoC6eCeVIZ22M4wgC26ygEKBLCIK94AlYTcMukYpwjWtNqlNMC4YaoL0z+uNSsBqw555qsXnuxs3adW2gNPIfpMFUXNhqFAl84vrL+t2HLQsChhDA9+8RiLFXv/y2h/g0Wh66EsVebHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720656947; c=relaxed/simple;
	bh=Yxn2dD6O9tTCs+N9LwAhbf3AXahUtn5J4s/YdJ04v30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R/ozGr6aapWs9G/HJDYmyxdNplUHbA+6a/md4jZPEufezAgN+zwxWvnOgcyDIx37k4Dd318LEnYJ2WseM4dK9enotpj1obVuIjNGf652NFVZPl/iETiWTAIi2NRrUtA2Xq5+WUgXaOYLGt+pP7J5TUGGI07ehTZ9olZ4XhrU5pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A+41Qd+N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720656943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/d7XeFDF7FM1McGtbsjWX4DZCJtG78BLFsY5zvJstE0=;
	b=A+41Qd+NlLTMYiuYQFLcD3n58LkXVxtShjvhDJkQJRnEeUkG1YcmZYG8gTZZ50CXzfpFTQ
	ctTLBgY8kCQ+0Zvos1YbsVkVd4RZKkiXL5ucTMv8Vqe6+RdsR8+AavCqPeMX4eNunge4CA
	YPR+I0Ajj4255yp0PNa5Uqbe66fNZr4=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-VDdb3NwOMO6xA6roe8aI0w-1; Wed, 10 Jul 2024 20:15:41 -0400
X-MC-Unique: VDdb3NwOMO6xA6roe8aI0w-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-70445cdc3f5so204547a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:15:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720656941; x=1721261741;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/d7XeFDF7FM1McGtbsjWX4DZCJtG78BLFsY5zvJstE0=;
        b=Al4FHKdZgtkT+JT8HTrePD9s4PdMuhnGNPvuuO0Do6dNGGxFDjv8rOa5k1iuGPFjdd
         SqLZEPzK1BwNLMp9SW8eIBnywsgb//JxljCPs7tyvoUoCj8lA5F4AgnuiymcwuBTFcOn
         hfUsYv8XKgyNuUpU+w5F+p0NFqTDzMEFnAOVcYCFSjshYDdYHHHoe0Izq1YxDu5ZITTV
         CV2iKGXaQuVHNmPXVCP38aISqDHEr7NjBywIOy5Mnuu/vFNTCOPyaU6+5iN1aaxuLgJf
         qKONaQGOfwj7SEj4i3Pn7gA4oehXD6pXgduiqKGU28o1NbY2odIQQ9pr34215gcova5K
         ULBg==
X-Forwarded-Encrypted: i=1; AJvYcCWtMt29dOzP4K8qQDg6HRP93c6CBgIRpvgkKSqWdfK04EesMInUP6bCUvwF1aauXwRKHKLPZOUmjubq4n43dDk6be8fE64yrLeEc6Cs
X-Gm-Message-State: AOJu0YzcQMJJ61o6OoJvlXJBgbAC41/qJP8O1H0nx4YXG8iYEoMUBuRZ
	S5tEyARaKg/OY70trGFAkES6hDzuH9+/AwswBa0WXYHssOiJdYFeIhBpuBK9egOZH3Eh+9ggtsn
	Sor4pQVOZVtfytkrMxtcsScqy8qTblwF30njrfOhWmnTI3/iPwGr0mKXWYerWpQ==
X-Received: by 2002:a05:6870:8a29:b0:24f:d159:ea2 with SMTP id 586e51a60fabf-25eae82aaa4mr5651278fac.28.1720656941135;
        Wed, 10 Jul 2024 17:15:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrqmKUYOlaz30bRtPTAhiPuI1B0LBP3gRAV/+4vVg92ebDlf6vGb3plk0OGjJz5KtBsuoUlg==
X-Received: by 2002:a05:6870:8a29:b0:24f:d159:ea2 with SMTP id 586e51a60fabf-25eae82aaa4mr5651256fac.28.1720656940668;
        Wed, 10 Jul 2024 17:15:40 -0700 (PDT)
Received: from [10.35.209.243] ([208.115.86.71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b4396841esm4376749b3a.132.2024.07.10.17.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 17:15:40 -0700 (PDT)
Message-ID: <0f01c613-9e4f-47b6-af2b-09aa90437d90@redhat.com>
Date: Thu, 11 Jul 2024 02:15:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/45] hugetlb pagewalk unification
To: Oscar Salvador <osalvador@suse.de>
Cc: Peter Xu <peterx@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Muchun Song <muchun.song@linux.dev>, SeongJae Park <sj@kernel.org>,
 Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>,
 Matthew Wilcox <willy@infradead.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jason Gunthorpe <jgg@nvidia.com>, Ryan Roberts <ryan.roberts@arm.com>
References: <20240704043132.28501-1-osalvador@suse.de>
 <617169bc-e18c-40fa-be3a-99c118a6d7fe@redhat.com> <Zoax9nwi5qmgTQR4@x1n>
 <84d4e799-90da-487e-adba-6174096283b5@redhat.com>
 <Zoug1swoTOqNUPJo@localhost.localdomain>
 <9d5980e3-72e6-4848-b1ac-83ffab8522c4@redhat.com>
 <Zo5v_hefrYFImqBC@localhost.localdomain>
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
In-Reply-To: <Zo5v_hefrYFImqBC@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> (as a side note, cont-pte/cont-pmd should primarily be a hint from arch code
>> on how many entries we can batch, like we do in folio_pte_batch(); point is
>> that we want to batch also on architectures where we don't have such bits,
>> and prepare for architectures that implement various sizes of batching;
>> IMHO, having cont-pte/cont-pmd checks in common code is likely the wrong
>> approach. Again, folio_pte_batch() is where we tackled the problem
>> differently from the THP perspective)
> 
> I must say I did not check folio_pte_batch() and I am totally ignorant
> of what/how it does things.
> I will have a look.
> 
>> I have an idea for a better page table walker API that would try batching
>> most entries (under one PTL), and walkers can just register for the types
>> they want. Hoping I will find some time to at least scetch the user
>> interface soon.
>>
>> That doesn't mean that this should block your work, but the
>> cont-pte/cont/pmd hugetlb stuff is really nasty to handle here, and I don't
>> particularly like where this is going.
> 
> Ok, let me take a step back then.
> Previous versions of that RFC did not handle cont-{pte-pmd} wide in the
> open, so let me go back to the drawing board and come up with something
> that does not fiddle with cont- stuff in that way.
> 
> I might post here a small diff just to see if we are on the same page.
> 
> As usual, thanks a lot for your comments David!

Feel free to reach out to discuss ways forward. I think we should

(a) move to the automatic cont-pte setting as done for THPs via
     set_ptes().
(b) Batching PTE updates at all relevant places, so we get no change in
     behavior: cont-pte bit will remain set.
(c) Likely remove the use of cont-pte bits in hugetlb code for anything
     that is not a present folio (i.e., where automatic cont-pte bit
     setting would never set it). Migration entries might require
     thought (we can easily batch to achieve the same thing, but the
     behavior of hugetlb likely differs to the generic way of handling
     migration entries on multiple ptes: reference the folio vs.
     the respective subpages of the folio).

Then we are essentially replacing what the current hugetlb_ functions do 
by the common way it is being done for THP (which does not exist for 
cont-pmd yet ... ). The only real alternative is special casing hugetlb 
all over the place to still call the hugetlb_* functions.

:( it would all be easier without that hugetlb cont-pte/cont-pmd usage.

CCing Ryan so he's aware.

-- 
Cheers,

David / dhildenb


