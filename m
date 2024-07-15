Return-Path: <linux-kernel+bounces-252819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCF793186E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B9641F221DF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6BB1C693;
	Mon, 15 Jul 2024 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L4wjSu1R"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377DC1AACB
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 16:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721060494; cv=none; b=mS2lrbn60BbTRiGZ39OmoDbotJpB9fpK6JepKgNmcbUM8n8imFF+d/c5md3I8ETm3Bv2BFD/F8zYslRQtu6nIUnYDgyv9xSuy379vROmXK/Q12gDuDNGHyZaaMMUoGXbMgCZz5z27re8JRt1JFEBc1EJTanQW10UFvcjGNH5+lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721060494; c=relaxed/simple;
	bh=pui1qQW4P2gyiC13rLW5f2DA/jS0T1Q5TtdKAdDUgOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HDJV2VWn81TuHeyfZWJr9C+1evZBNz6cmp6oNvAEI48/+tCCCkziRba/9EI4bRblJbD3CsYHXTrnLkq9Xjasy7DEdD/1VSLO3A9iRztYV9WVlBqlYc8//Nsl0FxPawcD76TNkpaxE5hRXoCTAJKWYuBMj5yyibA2cW2VoJxeRLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L4wjSu1R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721060492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FhQwthqdOwp7wCdTkaE+tXfAhMlT2gApJoQckxJNldI=;
	b=L4wjSu1RKJpJK/CGxcXDNxJ0KgQVscSSyPdu572KJPmSyKBFC/eSTK7kRsGk1kOfvuT685
	2c08v3xyspXh9AtUloIELHhzQFzPVt45aGTIijXwqawQVW9gv20+yJAtQ0HMlPCrj/ersW
	1C1v6aajKzHVOWYetnqmljis/kRUHt0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-nd5-gvAEPwO5GW9mKGam6w-1; Mon, 15 Jul 2024 12:21:28 -0400
X-MC-Unique: nd5-gvAEPwO5GW9mKGam6w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4264dc624a5so29029675e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 09:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721060487; x=1721665287;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhQwthqdOwp7wCdTkaE+tXfAhMlT2gApJoQckxJNldI=;
        b=CYWmViDZqd+Mo/+bpJZi4cB7FzSD1tndGEBHz6sQgIrn0iP372vtsD/wwRMupOW1sI
         ZGbCR/U9hdNjkAqyBt1TzE+c/CT9I+pnfGukVGECaRMvSpwzskNMp4qE2YrQ70rnJxiG
         DMIRmQFBwy7JkrZc0DHd6noKN3XZhxsmHe7uzq+ig15POeaVHigBcEDF5mVsDCYiMsrU
         TKUgyJTkYHFbFfijnhCT1ZJ5JGqNELWeb3Fko2gAH2lQT/XGbfjAsyYZqPcXRkOy4NRV
         Va73Oq/R7I6MTssQM4VPqJMG0s6ihqOiKYHwpm1hm+J2Fc7orzEnYchkCNBZqjTB6fJc
         EsQw==
X-Forwarded-Encrypted: i=1; AJvYcCU3DoYC26/Vbs2NmZa4wP8/qIGp/apPzNNHnDuypvZ5ooUsCxP/+4/fjfBo6qjHQA2f3LYwyVhgiuNrAWWWngfZxfU3nhCdGjhhNJPq
X-Gm-Message-State: AOJu0YyBHTcBicGd2M1qwHn8WtoRJOhwC633/jq9GfSPemmNwNc4AU9s
	djTGj8QtBjElJjAUYgJbNHwR/OYephwsw6JXyfPUhMfqdjxskwICldgTQjj7He7v5fiYF8m8Yru
	YW6Xqc+MnBBw4cmiEU+2d1ThUNjUpdhsEnaOI0kczzE0THjLRBa3yd38UXmCzKlvJRv8PTA==
X-Received: by 2002:a05:600c:a086:b0:426:6087:198f with SMTP id 5b1f17b1804b1-427b88d06b4mr901025e9.39.1721060487536;
        Mon, 15 Jul 2024 09:21:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUMz8cu7y7PXAMQogYWxHoUpKtVPhZXk097I1U4qf/GI6hwmzSyG8UfIW6zkCDKDp+puRdrg==
X-Received: by 2002:a05:600c:a086:b0:426:6087:198f with SMTP id 5b1f17b1804b1-427b88d06b4mr900865e9.39.1721060487157;
        Mon, 15 Jul 2024 09:21:27 -0700 (PDT)
Received: from [10.0.229.2] (ip-037-024-227-121.um08.pools.vodafone-ip.de. [37.24.227.121])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafb91csm6915360f8f.74.2024.07.15.09.21.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 09:21:26 -0700 (PDT)
Message-ID: <dc1124d8-80d7-4cc3-8111-99ad7ee09ba4@redhat.com>
Date: Mon, 15 Jul 2024 18:21:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/20] mm/zsmalloc: add zpdesc memory descriptor for
 zswap.zpool
To: Alex Shi <seakeel@gmail.com>, alexs@kernel.org,
 Vitaly Wool <vitaly.wool@konsulko.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, minchan@kernel.org, willy@infradead.org,
 senozhatsky@chromium.org, 42.hyeyoo@gmail.com,
 Yosry Ahmed <yosryahmed@google.com>, nphamcs@gmail.com
References: <20240708063344.1096626-1-alexs@kernel.org>
 <8007538a-5680-4e43-b204-21ce62943eee@gmail.com>
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
In-Reply-To: <8007538a-5680-4e43-b204-21ce62943eee@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.07.24 03:33, Alex Shi wrote:
> 
> 
> On 7/8/24 2:33 PM, alexs@kernel.org wrote:
>> From: Alex Shi (Tencent) <alexs@kernel.org>
>>
>> According to Metthew's plan, the page descriptor will be replace by a 8
>> bytes mem_desc on destination purpose.
>> https://lore.kernel.org/lkml/YvV1KTyzZ+Jrtj9x@casper.infradead.org/
>>
>> Here is a implement on zsmalloc to replace page descriptor by 'zpdesc',
>> which is still overlay on struct page now. but it's a step move forward
>> above destination.
>>
>> To name the struct zpdesc instead of zsdesc, since there are still 3
>> zpools under zswap: zbud, z3fold, zsmalloc for now(z3fold maybe removed
>> soon), and we could easyly extend it to other zswap.zpool in needs.
>>
>> For all zswap.zpools, they are all using single page since often used
>> under memory pressure. So the conversion via folio series helper is
>> better than page's for compound_head check saving.
>>
>> For now, all zpools are using some page struct members, like page.flags
>> for PG_private/PG_locked. and list_head lru, page.mapping for page migration.
>>
>> This patachset does not increase the descriptor size nor introduce any
>> functional changes, and could save about 122Kbytes zsmalloc.o size.
>>
>> Thanks
>> Alex
>>
> 
> Any comments for this patchset?

Planning on taking a peek soon (busy traveling), but I'm hoping that 
people more familiar with the code can provide feedback.

-- 
Cheers,

David / dhildenb


