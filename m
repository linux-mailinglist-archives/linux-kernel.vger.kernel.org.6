Return-Path: <linux-kernel+bounces-282771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8825194E864
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACD731C213BC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7984F16ABF3;
	Mon, 12 Aug 2024 08:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RtkryVI7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61161876
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723450837; cv=none; b=mQURPDaFrcIjn+pGZGMdHrihzNWz+NIc7TteVDxXEiLbnfEW4bHZyy2F3fDDp/arzoEVOfeIsNc8KQrwrKlcXadUQPFE9/dRdtS6IkL7sNK63s3f90Ek+0Xsgtg3hns3FlcebfoqVZhlPJeIL/4KShL67saYFxHm1wo9VhNvvu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723450837; c=relaxed/simple;
	bh=iu8SZFy7Eyx67y51cYJ5RsqUAykRnYLBHwB9NR1pYG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JA03c5pLII6AVNuKf6YTHuYt3LoHnX6eOPFEjzDZzUFR5WMKkHxQY9nsMHQV9FW370s1lk5texjfSUOC3AhjGQpWW+ODX5G4si5fmmf187PbdiUhcARdqcS4j2FSLWbfZeJ2FpbZr+Umt60oqDtcHoLVtHVACNXeCipUx4vGA9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RtkryVI7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723450834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8n5Bdq2+ysZmFgqFiKNYzPXPQ5JCOsP49BcpjOoNbFs=;
	b=RtkryVI7DvLBjN0he5jZUV/lnC7XVTaJ/4lBYt7WPL8K01yiMRlWHK9+YF2Guu6Z/1BJ/+
	Rjl9V2674xu69NPbC52Z9OKBDi7qCYJQO5MDtvXPHeDGTZKm/X3pnfyzxYpvnY55avLQ/O
	9gpuk69SasoVbtV0TOI4BsfT1fLjDvc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-g8saqfr1Nu22MYg8MSrKsA-1; Mon, 12 Aug 2024 04:20:33 -0400
X-MC-Unique: g8saqfr1Nu22MYg8MSrKsA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3684ea1537fso2000361f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 01:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723450832; x=1724055632;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8n5Bdq2+ysZmFgqFiKNYzPXPQ5JCOsP49BcpjOoNbFs=;
        b=wgRT3x8ZFQGZuQG3PNJEgj2RG3N5A0FF3rYWDK5v/h+gnt/SMXSAtpvnGFTBAdxyn0
         emmhw2AfG7e14TgUfHSKkrnoDkQXG3XdWWvaM77rB1vgnH19sw+rs2y4Y2xpKQCgBQFb
         RZeEB08+SpVdV35MQ/B4aK+v9waaFjFp6X5qdO84TClOAMAgNgz+T5QSQW82xU0vjWXC
         QlYt1kJ6cRX+JuC+I/axWdth7kA4nSf0+tt/Yiqoj/4MFrJVy9bxH4NPaSp982iTVi57
         75CcNnA/YEGgjQwJB/ybu9V3VUq+iz9PAH8CDd007LbMuYpgxdJgmRiFgRyk7w/o73s1
         N/rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCdw1lyWmxZ9yoBt9PfAmrCTgNvKg7mkeo6qIcEhi3GNugDXd1IV3XnsIPP3Qb1rx5XGBf1cD0zfhzo0Mf7A1/qxngZnHWJofq4RX7
X-Gm-Message-State: AOJu0Yy8CW1D4zs37H7ndzrS2tLXCxWv/Xq50LL6UvUsFB3O6W1Ygc8y
	L+okbXfG3NqiXGACsFdyWVj7p1fC+y9VtulVXMDAHVHmbTFMTPkS8gSwr3AuNj67xnX7QLGZe7N
	NXizevegmjMGDUZXBiEy4BjbyUtieUZdNaSNNGVmv9x0fz+L5fZ9c8v+x/fXLOw==
X-Received: by 2002:a5d:6e08:0:b0:35f:cd7:5ba1 with SMTP id ffacd0b85a97d-36d61cc3b96mr5929734f8f.60.1723450832109;
        Mon, 12 Aug 2024 01:20:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYDc0h4oIDF0OefjGsqQgwLJovB7t+/zX/4xsDVkZbdwDgCgi2/v0ot+8GdsKsDc7syY7dcQ==
X-Received: by 2002:a5d:6e08:0:b0:35f:cd7:5ba1 with SMTP id ffacd0b85a97d-36d61cc3b96mr5929718f8f.60.1723450831648;
        Mon, 12 Aug 2024 01:20:31 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:3f00:d228:bd67:7baa:d604? (p200300d82f093f00d228bd677baad604.dip0.t-ipconnect.de. [2003:d8:2f09:3f00:d228:bd67:7baa:d604])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4d1db515sm6829364f8f.64.2024.08.12.01.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 01:20:31 -0700 (PDT)
Message-ID: <08390990-b47a-4663-8eae-ee51aac55b45@redhat.com>
Date: Mon, 12 Aug 2024 10:20:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: Override mTHP "enabled" defaults at kernel cmdline
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, corbet@lwn.net, ioworker0@gmail.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, ryan.roberts@arm.com
References: <8258bf4c-ecec-4e06-ada0-da9fb99b1219@redhat.com>
 <20240812053636.97700-1-21cnbao@gmail.com>
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
In-Reply-To: <20240812053636.97700-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12.08.24 07:36, Barry Song wrote:
> On Sat, Aug 10, 2024 at 1:15 AM David Hildenbrand <david@redhat.com> wrote:
>>
>>>>>>> -You can change the sysfs boot time defaults of Transparent Hugepage
>>>>>>> -Support by passing the parameter ``transparent_hugepage=always`` or
>>>>>>> -``transparent_hugepage=madvise`` or ``transparent_hugepage=never``
>>>>>>> -to the kernel command line.
>>>>>>> +You can change the sysfs boot time default for the top-level "enabled"
>>>>>>> +control by passing the parameter ``transparent_hugepage=always`` or
>>>>>>> +``transparent_hugepage=madvise`` or ``transparent_hugepage=never`` to the
>>>>>>> +kernel command line.
>>>>>>> +
>>>>>>> +Alternatively, each supported anonymous THP size can be controlled by
>>>>>>> +passing ``thp_anon=<size>[KMG]:<state>``, where ``<size>`` is the THP size
>>>>>>> +and ``<state>`` is one of ``always``, ``madvise``, ``never`` or
>>>>>>> +``inherit``.
>>>>>>> +
>>>>>>> +For example, the following will set 64K THP to ``always``::
>>>>>>> +
>>>>>>> +     thp_anon=64K:always
>>>>>>> +
>>>>>>> +``thp_anon=`` may be specified multiple times to configure all THP sizes as
>>>>>>> +required. If ``thp_anon=`` is specified at least once, any anon THP sizes
>>>>>>> +not explicitly configured on the command line are implicitly set to
>>>>>>> +``never``.
>>>>>>
>>>>>> I suggest documenting that "thp_anon=" will not effect the value of
>>>>>> "transparent_hugepage=", or any configured default.
>>>
>>> Did you see the previous conversation with Barry about whether or not to honour
>>> configured defaults when any thp_anon= is provided [1]? Sounds like you also
>>> think we should honour the PMD "inherit" default if not explicitly provided on
>>> the command line? (see link for justification for the approach I'm currently
>>> taking).
>>
>> I primarily think that we should document it :)
>>
>> What if someone passes "transparent_hugepage=always" and "thp_anon=..."?
>> I would assume that transparent_hugepage would only affect the global
>> toggle then?
>>
>>>
>>> [1]
>>> https://lore.kernel.org/linux-mm/CAGsJ_4x8ruPspuk_FQVggJMWcXLbRuZFq44gg-Dt7Ewt3ExqTw@mail.gmail.com/
>>>
>>>>>>
>>>>>> Wondering if a syntax like
>>>>>>
>>>>>> thp_anon=16K,32K,64K:always;1048K,2048K:madvise
>>>
>>> Are there examples of that syntax already or have you just made it up? I found
>>> examples with the colon (:) but nothing this fancy. I guess that's not a reason
>>> not to do it though (other than the risk of screwing up the parser in a subtle way).
>>
>> I made it up -- mostly ;) I think we are quite flexible on what we can
>> do. As always, maybe we can keep it bit consistent with existing stuff.
>>
>> For hugetlb_cma we have things like
>>          "<node>:nn[KMGTPE|[,<node>:nn[KMGTPE]]
>>
>> "memmap=" options are more ... advanced, including memory ranges. There
>> are a bunch more documented in kernel-parameters.txt that have more
>> elaborate formats.
>>
>> Ranges would probably be the most valuable addition. So maybe we should
>> start with:
>>
>>          thp_anon=16K-64K:always,1048K-2048K:madvise
>>
>> So to enable all THPs it would simply be
>>
>>          thp_anon=16K-2M:always
>>
>> Interesting question what would happen if someone passes:
>>
>>          thp_anon=8K-2M:always
>>
>> Likely we simply would apply it to any size in the range, even if
>> start/end is not a THP size.
>>
>> But we would want to complain to the user if someone only specifies a
>> single one (or a range does not even select a single one) that does not
>> exist:
>>
>>          thp_anon=8K:always
> 
> How about rejecting settings with any illegal size or policy?
> 
> I found there are too many corner cases to say "yes" or "no". It seems
> the code could be much cleaner if we simply reject illegal settings.
> On the other hand, we should rely on smart users to provide correct
> settings, shouldn’t we? While working one the code, I felt that
> extracting partial correct settings from incorrect ones and supporting
> them might be a bit of over-design.

No strong opinion on failing configs. Ignoring non-existing sizes might 
lead to more portable cmdlines between kernel versions.

> 
> I have tested the below code by
> 
> "thp_anon=16K-64K:always;128K,512K:inherit;256K:madvise;1M-2M:never"

There are some parameters that separate individual options by ";" 
already (config_acs). Most parameters use ",". No idea what's better 
here, and which separator to use for sizes instead when using "," for 
options. No strong opinion.


-- 
Cheers,

David / dhildenb


