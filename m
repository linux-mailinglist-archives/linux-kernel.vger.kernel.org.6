Return-Path: <linux-kernel+bounces-248275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A36092DB1C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2CE7285152
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84C413B59F;
	Wed, 10 Jul 2024 21:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jLeiKRrG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ADE83CCB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 21:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720647624; cv=none; b=WJpm2hGeZ4Z00Yz1FgC84DrQkKu1Wurx9a53J8fjay+pZayxc2Mr9k3/xVMC/csjQy3UPH/AV0vJrFhuVWOWGj/wiZU7E7N0rya5E2aMTTuXJ1RokNTBlLWNiE7mXXa+528rJqzSWDAUsURjdfaGRTo4kkcITmGSoZg8sUfAP3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720647624; c=relaxed/simple;
	bh=opNZAY5HHlY+L2OfYvyO/zVAt7fOIwzpmn3+AQHV9AA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F7CHmU+1NZ13uyEGPNKPIex3VrnVVjjmmVZf0rYKQvroyrCOLUugCr4xuoTysqK0G1VbsPoHOMv9x/wTxobaAv5vW6GUZUE1ixD6DErWMt6bOjMpqNEW0ERSchdKW61zFbbJ7vRF+a372vN45/YjTn79wmIetGcjYEmsURdR+Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jLeiKRrG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720647621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZgJZ0T6r3P+qXMQykm3Ll9hYnB+GPHH+i4htPza+heI=;
	b=jLeiKRrGJIZjXsHKCvOTDCkJ8Cf77rtfjUuUCMB/FVQsJxf8EkYmd/0lTctRxIsx70XFld
	PLrZN65A6QgjFmqLAF1RIyVx4RYRtJ9FgZfMr9YxYCN2SbZ9m++yOhGrKtKO7dlhYkRSLv
	Hhl09YsYvXLNO0o42MKo/rW5I7wFX9A=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-EXJECa9lN7SmgsUq4YCZTg-1; Wed, 10 Jul 2024 17:40:19 -0400
X-MC-Unique: EXJECa9lN7SmgsUq4YCZTg-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-70afe95d6d5so257413b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 14:40:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720647618; x=1721252418;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZgJZ0T6r3P+qXMQykm3Ll9hYnB+GPHH+i4htPza+heI=;
        b=QmIGOX4jEPU9vcmkfH/gidp5gxQsiSCMfUCfCcM1yTL0F1O3AbhrKNwES2yLdR3An5
         V5STKZK9+toNtjROtprqylFuQ1P/JQa3xbBvANgJZ6K1sQSSlz0xAPdm3haP6MQJKCZf
         jqrl6gRebgAHfRG5lgX0p6Mx6XspbIzzfv+U4U282KXPJClyeEwyWebD9rQqTFp+4X6p
         njnovc26shSMM92Rnq7XsoV8aIpwJxeVeYIHc4esmyZ1RmPG9A+eJ2PRDwx9uVWWM7io
         amdMJMwQoWkrE2qXi6EHNHyhuyMNouSKiw+aIGyHuVlfKshWoAb7XcxA1DJo2CTYNN9M
         OHtA==
X-Gm-Message-State: AOJu0YwGrJAX9ZIw4tx9CVPB504M4lGaBXhskYzZamEimWmSXeNWxq0V
	nc0QPp7aSLwvFDCAhT2voO7ORX8a4Hpw5aIkMpLFbMA1w7Cp5psfgerE+y+kydTTZ9QxiVb2RzJ
	VMJ56PPfEPssj5wZ7yaDmg4rl8DPhbiqCxdsY0gCDAa6Hk+j6rS/9j0HARPvaEg==
X-Received: by 2002:a05:6a00:1955:b0:70a:f5c5:135d with SMTP id d2e1a72fcca58-70b43667750mr8053505b3a.32.1720647618550;
        Wed, 10 Jul 2024 14:40:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPTuTQRQE30zFBM0t8+WCUxb2VC4RLEEJeQ4IxECNg0RAHwUr/Q/CjeWUsChjiQaCkqSL2Pg==
X-Received: by 2002:a05:6a00:1955:b0:70a:f5c5:135d with SMTP id d2e1a72fcca58-70b43667750mr8053487b3a.32.1720647618108;
        Wed, 10 Jul 2024 14:40:18 -0700 (PDT)
Received: from [10.35.209.243] ([208.115.86.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b439afda9sm4242396b3a.169.2024.07.10.14.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 14:40:17 -0700 (PDT)
Message-ID: <25a87009-5318-457b-926b-69185767b274@redhat.com>
Date: Wed, 10 Jul 2024 23:40:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/rmap: cleanup partially-mapped handling in
 __folio_remove_rmap()
To: Yosry Ahmed <yosryahmed@google.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240618151026.521019-1-david@redhat.com>
 <CAJD7tkax7gJdLAMUZ=x7bmDievcLv-w_ridqpTZxC4R-tsAoiw@mail.gmail.com>
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
In-Reply-To: <CAJD7tkax7gJdLAMUZ=x7bmDievcLv-w_ridqpTZxC4R-tsAoiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24.06.24 13:48, Yosry Ahmed wrote:
> On Tue, Jun 18, 2024 at 8:10 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> Let's simplify and reduce code indentation. In the RMAP_LEVEL_PTE case, we
>> already check for nr when computing partially_mapped.
>>
>> For RMAP_LEVEL_PMD, it's a bit more confusing. Likely, we don't need the
>> "nr" check, but we could have "nr < nr_pmdmapped" also if we stumbled
>> into the "/* Raced ahead of another remove and an add? */" case. So
>> let's simply move the nr check in there.
>>
>> Note that partially_mapped is always false for small folios.
>>
>> No functional change intended.
>>
>> Cc: Yosry Ahmed <yosryahmed@google.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Makes sense to me. FWIW:
> 
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> 
>> ---
>>   mm/rmap.c | 10 ++++------
>>   1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index afec4b6800caf..aa900e46cdf82 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1551,11 +1551,12 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>>                          }
>>                  }
>>
>> -               partially_mapped = nr < nr_pmdmapped;
>> +               partially_mapped = nr && nr < nr_pmdmapped;
>>                  break;
>>          }
>>
>> -       if (nr) {
>> +       if (partially_mapped && folio_test_anon(folio) &&
>> +           list_empty(&folio->_deferred_list))
>>                  /*
>>                   * Queue anon large folio for deferred split if at least one
>>                   * page of the folio is unmapped and at least one page
>> @@ -1563,10 +1564,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>>                   *
>>                   * Check partially_mapped first to ensure it is a large folio.
>>                   */
>> -               if (folio_test_anon(folio) && partially_mapped &&
>> -                   list_empty(&folio->_deferred_list))
>> -                       deferred_split_folio(folio);
>> -       }
>> +               deferred_split_folio(folio);
> 
> FWIW, I prefer moving the comment out of the one-line if block as you
> originally suggested in [1].
> 
> [1]https://lore.kernel.org/lkml/1a408ed1-7e81-457e-a205-db274b4d6b78@redhat.com/

Sorry for the late reply, crazy times here.

Let me do that and resend, thanks!

-- 
Cheers,

David / dhildenb


