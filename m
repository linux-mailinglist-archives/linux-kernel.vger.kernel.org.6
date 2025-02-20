Return-Path: <linux-kernel+bounces-523235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC6BA3D3D4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33E84189DFD7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6989F1E990E;
	Thu, 20 Feb 2025 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SH55oKdC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79EE1EDA11
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740041866; cv=none; b=nJQHAjJMWjZer2ZMLtos9jyD9b/rGb9GFq47oWKDlr8DsfOFTQoSg+WZxiCQpkPrx0bfQsuJ2Fu7xOVLt207jlR3yVDjxssnR+MPL/bZER8XG8krF0uEqdM8aFDPZxpGMK1+KSQT1eRmrN5YJEx7n4+1DJE2Hcvt8KuII6HK73s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740041866; c=relaxed/simple;
	bh=X0eTqkdoxYwiQdVixkGHT8qHF7pQmm18yTApvP8PwdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AcA3uALwKXI5WjvgJMwOq8zfejsyzWwQ7DMtPea0YV+XFabgSiAtEGVPOZicxOcsmPyGfy0HGkOV1Mx4AQzuCBLypnMFvwwhKXCnu4hAKr01zWksq/yEscBc/soQ9qrIG/786E0s9Xs2U4zcoKHkKhW5WuWm3QhcA7TMShqAWJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SH55oKdC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740041863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UeFkIT0ugeivRGt1yANJd8utrpqqSMtB02Et1S07bPk=;
	b=SH55oKdCxNupXnOh/d5XTY00VBKXgWe/0VkcaQwTJIwMx4YNAP3RYyHnogy4TOoq13oElz
	AwYFEAnnQeHu3oVkh/MwG9+o0nFUTcZIqOBC5JGwPdhFoloITsClYyODMY+vmUtJqjOn0W
	vCN4QCF/D3/uG74o3OBhdUhfc1KyycM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-x7erTAX8NUyaKYq7BR2sEg-1; Thu, 20 Feb 2025 03:57:42 -0500
X-MC-Unique: x7erTAX8NUyaKYq7BR2sEg-1
X-Mimecast-MFC-AGG-ID: x7erTAX8NUyaKYq7BR2sEg_1740041861
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4394040fea1so3477745e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 00:57:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740041861; x=1740646661;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UeFkIT0ugeivRGt1yANJd8utrpqqSMtB02Et1S07bPk=;
        b=YNhT354du+/4re1svGuIe43DPekIwZP10rq9FAIHUlwqLYrkt5R52T0IbNbksStCL5
         UmnHmiBbgrVmRNNgAEFtGh234aC1v6sXTSN7noXX2wZuSh5uGW2ILjz87+1eW+tgYfgj
         6oCSAoKg1VuhOglacq22/y1Xlaf5MTpn2AjfvX2Xx5UyO6KpRAeRlwhEWh7xtZZM2xCj
         VfcUqb86vHem+LY5PqcXfh7Ql5ffFnpf1MW+PIfqP6NckI5W61Dw1s44ZZ0JvCIORC/v
         m7WtKbqetsGxgzugvDACuTuvtP9+GvCLigkRM+SzoTAF6SGT4mxVir71Vqj4s/Ii5uuH
         DXaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVL63Atv9pQsieBYcMNB+BzvvOfDBRBXWOYoA1EykOC92ZzQQCGMhRrrWBQD8VfqratZIe865EAkeVRtjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8b6TMnPE0D7rvBAu8fybkGG0QPjfsfRAaBmFAdlylkgl8Dc4r
	AP574y5pvyA2ZhBT2mRlvx2cRykSKuPeuHpnBWVAkrcLxr6dPLJXEqEP0awzJ0LqRCS0JUERgT1
	Ps0+15SRW5HX82LCAJ1+3+6I7MDhWW7BKJ1/Jz84Zg1L/yIzAyz924NQJ936AmA==
X-Gm-Gg: ASbGncvLMHAIudbczfT+mv4+NiVhZQ5ltBJStowczJySBOXoiPmjahKUr6zOmII3SUA
	pT1qgNdPO2cbMf8wUk6B3c8ZEMeahyRZbyPAD16Mhs5eRC/dxSuWZ41uaeTm0v9Ad/DfztWPYgW
	PbyzcwcS9Fpa8Xk5YWMPLxQxICpRgQPz09JuEwPgWGNaLjISDnZp1zOzFjhwMwHo1wq9IMsfNjW
	8Y2+ZdUNsi329F+i9UkFcziXXIv8e2fanW8IUewH1Aqzxu3eKHGn/+2VzkmxA2/Ri3n2O1FTbF3
	Z/vE+DCsler36WJeGQfic3+UR6+Cf6Rg6av8jUvId6h0SeRh8oMUCFlOL2z71wrvkaRIOzmmyP9
	Fe3TJOS9h75cy+RP26NPvx/TqSnH3YQ==
X-Received: by 2002:a05:600c:54ea:b0:439:871d:d4c0 with SMTP id 5b1f17b1804b1-439a2eb09f6mr19814255e9.3.1740041860986;
        Thu, 20 Feb 2025 00:57:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRGm4RWVPkCp5Jxz8CVe7/k4BWSnF2CtMcw4wGGvQ2czSaK/WB8yggsUUR4m5qv+MlkFvLDA==
X-Received: by 2002:a05:600c:54ea:b0:439:871d:d4c0 with SMTP id 5b1f17b1804b1-439a2eb09f6mr19813995e9.3.1740041860532;
        Thu, 20 Feb 2025 00:57:40 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:2000:e44c:bc46:d8d3:be5? (p200300cbc7062000e44cbc46d8d30be5.dip0.t-ipconnect.de. [2003:cb:c706:2000:e44c:bc46:d8d3:be5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a04f8a2sm234398405e9.2.2025.02.20.00.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 00:57:39 -0800 (PST)
Message-ID: <4aa97b5c-3ddc-442b-8ec9-cc43ebe9e599@redhat.com>
Date: Thu, 20 Feb 2025 09:57:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] mm: permit guard regions for file-backed/shmem
 mappings
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Kalesh Singh <kaleshsingh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
 "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
 Juan Yescas <jyescas@google.com>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
 <CAC_TJveMB1_iAUt81D5-+z8gArbVcbfDM=djCZG_bRVaCEMRmg@mail.gmail.com>
 <45297010-a0a4-4a42-84e8-6f4764eab3b3@lucifer.local>
 <41af4ffb-0383-4d00-9639-0bf16e1f5f37@redhat.com>
 <a2e12142-3eb2-48c9-b0d9-35a86cb56eec@lucifer.local>
 <CAC_TJvf6fOACObzR0ANFFrD+ecrP8MbXEZ_ZdzRu0Lg4RunS9g@mail.gmail.com>
 <e07dfd31-197c-49d0-92bd-12aad02daa7e@lucifer.local>
 <CAC_TJvfBvZZc=xyB0jez2VCDit-rettfQf7H4xhQbN7bYxKw-A@mail.gmail.com>
 <6e356431-5ac9-4363-b876-78a69ae7622a@lucifer.local>
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
In-Reply-To: <6e356431-5ac9-4363-b876-78a69ae7622a@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.02.25 09:51, Lorenzo Stoakes wrote:
> On Wed, Feb 19, 2025 at 12:56:31PM -0800, Kalesh Singh wrote:
>>> We also can't change smaps in the way you want, it _has_ to still give
>>> output per VMA information.
>>
>> Sorry I wasn't suggesting to change the entries in smaps, rather
>> agreeing to your marker suggestion. Maybe a set of ranges for each
>> smaps entry that has guards? It doesn't solve the use case, but does
>> make these regions visible to userspace.
> 
> No, you are not providing a usecase for this. /proc/$pid/pagemaps does not
> contaminate the smaps output, mess with efforts to make it RCU readable,
> require updating the ioctl interface, etc. so it is clearly the better
> choice.
> 
>>
>>>
>>> The proposed change that would be there would be a flag or something
>>> indicating that the VMA has guard regions _SOMEWHERE_ in it.
>>>
>>> Since this doesn't solve your problem, adds complexity, and nobody else
>>> seems to need it, I would suggest this is not worthwhile and I'd rather not
>>> do this.
>>>
>>> Therefore for your needs there are literally only two choices here:
>>>
>>> 1. Add a bit to /proc/$pid/pagemap OR
>>> 2. a new interface.
>>>
>>> I am not in favour of a new interface here, if we can just extend pagemap.
>>>
>>> What you'd have to do is:
>>>
>>> 1. Find virtual ranges via /proc/$pid/maps
>>> 2. iterate through /proc/$pid/pagemaps to retrieve state for all ranges.
>>>
>>
>> Could we also consider an smaps field like:
>>
>> VmGuards: [AAA, BBB), [CCC, DDD), ...
>>
>> or something of that sort?
> 
> No, absolutely, categorically not. You realise these could be thousands of
> characters long right?
> 
> /proc/$pid/pagemaps resolves this without contaminating this output.
> 
>>> Well I'm glad that you guys find it useful for _something_ ;)
>>>
>>> Again this wasn't written only for you (it is broadly a good feature for
>>> upstream), but I did have your use case in mind, so I'm a little
>>> disappointed that it doesn't help, as I like to solve problems.
>>>
>>> But I'm glad it solves at least some for you...
>>
>> I recall Liam had a proposal to store the guard ranges in the maple tree?
>>
>> I wonder if that can be used in combination with this approach to have
>> a better representation of this?
> 
> This was an alternative proposal made prior to the feature being
> implemented (and you and others at Google were welcome to comment and many
> were cc'd, etc.).
> 
> There is no 'in combination with'. This feature would take weeks/months to
> implement, fundamentally impact the maple tree VMA implementation
> and... not actually achieve anything + immediately be redundant.
> 
> Plus it'd likely be slower, have locking implications, would have kernel
> memory allocation implications, a lot more complexity and probably other
> problems besides (we discussed this at length at the time and a number of
> issues came up, I can't recall all of them).
> 
> To be crystal clear - we are empathically NOT changing /proc/$pid/maps to
> lie about VMAs regardless of underlying implementation, nor adding
> thousands of characters to /proc/$pid/smaps entries.

Yes. Calling it a "guard region" might be part of the problem 
(/"misunderstanding"), because it reminds people of "virtual memory 
regions".

"Guard markers" or similar might have been clearer that these operate on 
individual PTEs, require page table scanning etc ... which makes them a 
lot more scalable and fine-grained and provides all these benfits, with 
the downside being that we don't end up with that many "virtual memory 
regions" that maps/smaps operate on.

[...]

> 
> As I said to you earlier, the _best_ we could do in smaps would be to add a
> flag like 'Grd' or something to indicate some part of the VMA is
> guarded. But I won't do that unless somebody has an -actual use case- for
> it.

Right, and that would limit where you have to manually scan. Something 
similar is being done with uffd-wp markers IIRC.

-- 
Cheers,

David / dhildenb


