Return-Path: <linux-kernel+bounces-280655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9716194CD58
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 098F2B2175A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A0B190693;
	Fri,  9 Aug 2024 09:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="imAfVbxe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC63E1DA21
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723195929; cv=none; b=oaRALnIF5QngSdhnST07s1P1ldHFFN8t1xJGwUFxOa4Sl8kjjDKhiplxksLlK8bAAIQS0Qv657rNZJIMnfHwoSmZ5QNBUo8B0ejMBcc1bvlltL3HOxPmqjTWWSpMsuR3TBc00prVouNm1yOEoaf9tGyTAWVuzEiqVihyO+MS6rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723195929; c=relaxed/simple;
	bh=MZtrc+qqLl5WV4zVWeEkPoUY4V+0Wf3ShRI1Gy8ZiU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ozwjoWOXDrl8lyosKAZSi6sVMwiWwaBf39BPf/8qOqnMXrnfSI2sHXh6lXXT5pHPEF35Fat3Dl7s5NgK/8zvdOza7nmxu3xXHavJqw2UEN6Jw3NiMKRVBppOXzXT2bOt+wkSJyFxvCcHOxizdq8WT3JUXKKWhoHj9r4+KWJ9Rt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=imAfVbxe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723195926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OWYiUElLkfdUg+lpzwRgYF9R8MuRVbDbDgZSgsoIVkA=;
	b=imAfVbxe+GfplwoIlqvZie/GllbyLShZSCi3i7OX5lr2XW9pJJrNbT1tmkJDUZU/xpiE78
	u5hWSNSlIGdNsyhdLIvbX6QZ21q4K6QgfHYtuLTGHkb8D+UVcF/ekNHO02a/D//oAILO2I
	RL0d5QeI+ZtDz0a7Njb9zPUpYg0jNt8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-TKYcBD3kO0y5Slb6qczpwQ-1; Fri, 09 Aug 2024 05:32:05 -0400
X-MC-Unique: TKYcBD3kO0y5Slb6qczpwQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3684ea1537fso833925f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 02:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723195924; x=1723800724;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OWYiUElLkfdUg+lpzwRgYF9R8MuRVbDbDgZSgsoIVkA=;
        b=ppdUt5N9VpGIMMAYaKp1cb/IjHPrPArjIW+StiHs68heIPqbgtswyCgUuTgDqad7sQ
         8iHXhRocL9h2hW+/VRa35asRleIBav1KhL3nEPw/hmbBM7lDc0wYC9RxhkcTC3wX27WJ
         +lJj4Jw2dXe6cMuUQ1WU2tRa0LHKQ2t3Sl4OrDQefjGhodEGPLP6Dli+0kNE09g/5J8P
         gyHp2YfbJAFI0f+BmI+argFxSGaZJp3nnH0uOqSGNTdNMhfsuSEf+aR58L/1yAs68bBt
         34sPY9wKP546hEkyzxcvvfGNhM3+uJfzh1vIs4GH307r8E7ukRF6X+RzzdYKYuIUE+q9
         TLtg==
X-Forwarded-Encrypted: i=1; AJvYcCXzelU2SV8sAon7Yj1STAkoPr+jkHT1Nlkq3fDVlPFM2hRwUfhSZmlE39PXgpFn7bmGApTUISVwma9Oeqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZElEP35ZnJ5g4n8y20VzS+VKAWZL0pTa/5UxxwM7yxBueHcCy
	+ClGlBBOnWyjOhhxdpcGii+hcWNgyNxJk3gPWVmnPDT8RP0xJiXiBf7Q3C333+hHK/Ig4Oe24Yt
	oajK3UCo31FinZ0o1on39sOdlJSvHgmhelzOK5xLvv0XcrxVYYtk5lmamqMq4gQ==
X-Received: by 2002:a05:6000:1813:b0:36b:bd38:c724 with SMTP id ffacd0b85a97d-36d616e2a5fmr745105f8f.47.1723195923893;
        Fri, 09 Aug 2024 02:32:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2a+r1bLn8Fwb4AjfMB5RfdwLekL4TjdrZzkU7NJKI7oPV6OsLuaQr55uRSzJRt2eXNx00jA==
X-Received: by 2002:a05:6000:1813:b0:36b:bd38:c724 with SMTP id ffacd0b85a97d-36d616e2a5fmr745081f8f.47.1723195923387;
        Fri, 09 Aug 2024 02:32:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71c:4e00:b097:7075:f6ba:300a? (p200300cbc71c4e00b0977075f6ba300a.dip0.t-ipconnect.de. [2003:cb:c71c:4e00:b097:7075:f6ba:300a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d2715716esm4728486f8f.5.2024.08.09.02.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 02:32:02 -0700 (PDT)
Message-ID: <75eb6e75-8a6d-460a-8e96-7496ed1396b7@redhat.com>
Date: Fri, 9 Aug 2024 11:32:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: Override mTHP "enabled" defaults at kernel cmdline
To: Barry Song <baohua@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 Lance Yang <ioworker0@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240808101700.571701-1-ryan.roberts@arm.com>
 <99b78488-c524-4269-b1fb-a13eaa4f274c@redhat.com>
 <CAGsJ_4z2D2yWWZhUM_yDSdn9=zpkYkHhzAKO8CQ1Xu3gDaECRA@mail.gmail.com>
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
In-Reply-To: <CAGsJ_4z2D2yWWZhUM_yDSdn9=zpkYkHhzAKO8CQ1Xu3gDaECRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09.08.24 11:24, Barry Song wrote:
> On Fri, Aug 9, 2024 at 5:19 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 08.08.24 12:16, Ryan Roberts wrote:
>>> Add thp_anon= cmdline parameter to allow specifying the default
>>> enablement of each supported anon THP size. The parameter accepts the
>>> following format and can be provided multiple times to configure each
>>> size:
>>>
>>> thp_anon=<size>[KMG]:<value>
>>>
>>> See Documentation/admin-guide/mm/transhuge.rst for more details.
>>>
>>> Configuring the defaults at boot time is useful to allow early user
>>> space to take advantage of mTHP before its been configured through
>>> sysfs.
>>
>> I suspect a khugeapged enhancement and/or kernel-config-dependant
>> defaults and/or early system settings will also be able to mitigate that
>> without getting kernel cmdlines involved in the future.
>>
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>
>>> Hi All,
>>>
>>> I've split this off from my RFC at [1] because Barry highlighted that he would
>>> benefit from it immediately [2]. There are no changes vs the version in that
>>> series.
>>>
>>> It applies against today's mm-unstable (275d686abcb59). (although I had to fix a
>>> minor build bug in stackdepot.c due to MIN() not being defined in this tree).
>>>
>>> Thanks,
>>> Ryan
>>>
>>>
>>>    .../admin-guide/kernel-parameters.txt         |  8 +++
>>>    Documentation/admin-guide/mm/transhuge.rst    | 26 +++++++--
>>>    mm/huge_memory.c                              | 55 ++++++++++++++++++-
>>>    3 files changed, 82 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>> index bcdee8984e1f0..5c79b58c108ec 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -6631,6 +6631,14 @@
>>>                        <deci-seconds>: poll all this frequency
>>>                        0: no polling (default)
>>>
>>> +     thp_anon=       [KNL]
>>> +                     Format: <size>[KMG]:always|madvise|never|inherit
>>> +                     Can be used to control the default behavior of the
>>> +                     system with respect to anonymous transparent hugepages.
>>> +                     Can be used multiple times for multiple anon THP sizes.
>>> +                     See Documentation/admin-guide/mm/transhuge.rst for more
>>> +                     details.
>>> +
>>>        threadirqs      [KNL,EARLY]
>>>                        Force threading of all interrupt handlers except those
>>>                        marked explicitly IRQF_NO_THREAD.
>>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
>>> index 24eec1c03ad88..f63b0717366c6 100644
>>> --- a/Documentation/admin-guide/mm/transhuge.rst
>>> +++ b/Documentation/admin-guide/mm/transhuge.rst
>>> @@ -284,13 +284,27 @@ that THP is shared. Exceeding the number would block the collapse::
>>>
>>>    A higher value may increase memory footprint for some workloads.
>>>
>>> -Boot parameter
>>> -==============
>>> +Boot parameters
>>> +===============
>>>
>>> -You can change the sysfs boot time defaults of Transparent Hugepage
>>> -Support by passing the parameter ``transparent_hugepage=always`` or
>>> -``transparent_hugepage=madvise`` or ``transparent_hugepage=never``
>>> -to the kernel command line.
>>> +You can change the sysfs boot time default for the top-level "enabled"
>>> +control by passing the parameter ``transparent_hugepage=always`` or
>>> +``transparent_hugepage=madvise`` or ``transparent_hugepage=never`` to the
>>> +kernel command line.
>>> +
>>> +Alternatively, each supported anonymous THP size can be controlled by
>>> +passing ``thp_anon=<size>[KMG]:<state>``, where ``<size>`` is the THP size
>>> +and ``<state>`` is one of ``always``, ``madvise``, ``never`` or
>>> +``inherit``.
>>> +
>>> +For example, the following will set 64K THP to ``always``::
>>> +
>>> +     thp_anon=64K:always
>>> +
>>> +``thp_anon=`` may be specified multiple times to configure all THP sizes as
>>> +required. If ``thp_anon=`` is specified at least once, any anon THP sizes
>>> +not explicitly configured on the command line are implicitly set to
>>> +``never``.
>>
>> I suggest documenting that "thp_anon=" will not effect the value of
>> "transparent_hugepage=", or any configured default.
>>
>> Wondering if a syntax like
>>
>> thp_anon=16K,32K,64K:always;1048K,2048K:madvise
>>
>> (one could also support ranges, like "16K-64K")
>>
>> Would be even better. Then, maybe only allow a single instance.
>>
>> Maybe consider it if it's not too crazy to parse ;)
> 
> I prefer the current approach because it effectively filters cases like this.
> 
> [    0.000000] huge_memory: thp_anon=8K:inherit: cannot parse, ignored
> [    0.000000] Unknown kernel command line parameters
> "thp_anon=8K:inherit", will be passed to user space.
> 
> if we put multiple sizes together, 8K,32K,64K:always
> 
> We can't determine whether this command line is legal or illegal as it
> is partially legal and partially illegal.

Besides: I wouldn't bother about this "user does something stupid" 
scenario that much.

But yes, once we support more sizes a cmdline might turn invalid on an 
older kernel.

However, I don't see the problem here. User passed a non-existant size. 
Ignore that one but handle the others, like you would with multiple 
commands?

It can be well defined and documented. The command line is legal, just 
one size does not exist.

The world will continue turning :)

-- 
Cheers,

David / dhildenb


