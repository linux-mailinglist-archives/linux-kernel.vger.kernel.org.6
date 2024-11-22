Return-Path: <linux-kernel+bounces-418141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D9B9D5DAC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2892CB24A03
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3CF1DE3C7;
	Fri, 22 Nov 2024 11:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H7Bw/421"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76F31DE2C6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732273234; cv=none; b=sKq3bZ13LlY3uWDRAC1g69QnR9gEhXNcT8QcgGYsQoIBpnW4HXsgOz0vLShNZIAYraRuNeMVjZ/5/PX4gffoTq3yTVJUTMHAGvtwGPgW5wIugzkzqjbTRciNV+f5yNxzJt6R6M7dBWRpbJ/yNCPS7neEEfVb+YB2pugrY17oi3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732273234; c=relaxed/simple;
	bh=03P+jm/UD8uGJemwJugFZCx3aQFkmvVtPvlPY4dSdws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RzwbCiajr3vQ1JXX5Ub4OIFdnBnYwYsWUq4zFt6CMRImJc9fL4Jq32iV2HcwpX47eNomVmznWoFH1XDHhOyNeLLlKjt4WyN/fOPB6pTzSxbfwVo/UUBNzaah/vrlojVbjckyZXp4wSsZgQQsmKkEcoo31l9l1utvzGYFY935fH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H7Bw/421; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732273230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MIuv1Hyk+rpQWVfQszyiZRq7vLSri1bG1Iy9YTXRbuQ=;
	b=H7Bw/421yFkxHQ82RISpYlN3m8MryQI/n+9bTlZaf4yH5U6FhhrcfXuLLLVwnFoX2tlre2
	KVyIZIwvtpPUqR3CPpcgRuzgziRaZ/JnRIa4ze+XPdkiU60b6Av7EHtqSaklQ3+e+9EUYN
	EMIiD+vnwb59vSJYyzHfxTGmVjimZfA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-Yp7Gd7INN9y0Q_9x72-N0w-1; Fri, 22 Nov 2024 06:00:29 -0500
X-MC-Unique: Yp7Gd7INN9y0Q_9x72-N0w-1
X-Mimecast-MFC-AGG-ID: Yp7Gd7INN9y0Q_9x72-N0w
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-382428c2564so1178541f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 03:00:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732273228; x=1732878028;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MIuv1Hyk+rpQWVfQszyiZRq7vLSri1bG1Iy9YTXRbuQ=;
        b=Pp2JwiFkEzMd35d34/1miNLrWAgUBus+lFQ7On07ObmuW1f4whf2uiWiiLvgfO0ukb
         0PCkrjuqddxChdWVKdaU+uil5/fC60UcC14wt7tYccseIE5WBJ94vCkywYzPpqxstX9+
         X5uryI8WDAL2bDPK0taOIgzR71GgZ5dPHg1GgWK9OCPtfnUFbD3u3ji7ebLkH9RQA6WW
         2PeDP2Q3FD2ajEbkrrWfnwEWHHxOynBZ7AEj3oe4QaLF6XNMDRSbLYndg48iV2vVCD13
         97Rc7eztq95SI4Ic6WYe5o1/IR/HTEOQVfG5iacPO1MPOSKTeAIm49s2ZKmUHqzCF+RE
         mt0A==
X-Forwarded-Encrypted: i=1; AJvYcCXm4jSwu7sp59ZTpXSpFN5VQfVopJAJJVJKXGnGBKNn9xznv3Wh4NtpypNhsZJUt99j7FgTDi7uOqfb9CY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtqMu2LoBJ0+PLVr/RFM5P0qpto3a79oprYnDqa8bg65ZTrCVx
	cixgUqOFKBYC24VkPBqk1PtNxg5k+bugliNzgn27kfTJk+16uyVs5pJYo0hE5KbG7korXeQSs9w
	XUBmXvPRMj957XiPeCcdIvgs4nbQ5DrucRowhNlOVVPEaMI52GMOVxqi+Ff6uyA==
X-Gm-Gg: ASbGncumv2QikS8Uj8N+niJBQFlrM8/Vc3HeghBxxny8YtKXQRYqxlvSz7vrw+kMVzi
	DEuKEvurwPUJF+sgfyZo6vkIkmF/beT5hjDuRxJBT8b8pVzAlZLuyNCXQ1prBHTyxz5QDfinHc3
	QIC12cWK58JqFOzYC5ThkSyC9vD0Q/v3O2WOARSGJO84oud3Qzd4JvQGUF/me/tvLlVnmmnCoQR
	a9AP5K79W+eBYQ7Hc0Pm3BmNyVSfwBC8TPAB1XarnHnBQUYwQJ28ZAXVA4RHQn7FyYqxVP8UJhj
	0FurZAGXPdJ6AwTgDct2eAlTBJXCD7jdvIkmUoxkxa97BqWFsU10+h3GIwEbhZIAU0D7qxa99H0
	=
X-Received: by 2002:a5d:47c6:0:b0:382:5016:fd0b with SMTP id ffacd0b85a97d-38260be5406mr1420438f8f.50.1732273227873;
        Fri, 22 Nov 2024 03:00:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtHXS6ldIOHORyT7grnYjt57tXtWF/11CwoKnbZVjvg+EK+waYBzmjdCPJSzBxwYuZ1ff5Nw==
X-Received: by 2002:a5d:47c6:0:b0:382:5016:fd0b with SMTP id ffacd0b85a97d-38260be5406mr1420409f8f.50.1732273227417;
        Fri, 22 Nov 2024 03:00:27 -0800 (PST)
Received: from ?IPV6:2003:cb:c70b:7a00:9ccd:493:d8e2:9ac8? (p200300cbc70b7a009ccd0493d8e29ac8.dip0.t-ipconnect.de. [2003:cb:c70b:7a00:9ccd:493:d8e2:9ac8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825faf9829sm2094715f8f.31.2024.11.22.03.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 03:00:26 -0800 (PST)
Message-ID: <bab52d30-8e47-4501-b0b1-0d26cc395898@redhat.com>
Date: Fri, 22 Nov 2024 12:00:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] /dev/mem: Add a new parameter strict_devmem to bypass
 strict devmem
To: Yafang Shao <laoar.shao@gmail.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: mingo@redhat.com, arnd@arndb.de, x86@kernel.org,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
References: <20241120122858.22190-1-laoar.shao@gmail.com>
 <0aa9f3bd-b1b6-4089-b9eb-5b72d7a1541a@redhat.com>
 <CALOAHbBMebKtsRnfOFvNKorQk_4KGoCzKd0JcYv2p6pXhJqYbQ@mail.gmail.com>
 <2024112134-theater-jasmine-61f3@gregkh>
 <CALOAHbCGH6_n2v65SMzpXf44EvKcr4AZCjOMaDRHUynNPZNksA@mail.gmail.com>
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
In-Reply-To: <CALOAHbCGH6_n2v65SMzpXf44EvKcr4AZCjOMaDRHUynNPZNksA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22.11.24 03:26, Yafang Shao wrote:
> On Thu, Nov 21, 2024 at 11:15 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Thu, Nov 21, 2024 at 10:31:12PM +0800, Yafang Shao wrote:
>>> On Thu, Nov 21, 2024 at 4:51 PM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 20.11.24 13:28, Yafang Shao wrote:
>>>>> When CONFIG_STRICT_DEVMEM is enabled, writing to /dev/mem to override
>>>>> kernel data for debugging purposes is prohibited. This configuration is
>>>>> always enabled on our production servers. However, there are times when we
>>>>> need to use the crash utility to modify kernel data to analyze complex
>>>>> issues.
>>>>>
>>>>> As suggested by Ingo, we can add a boot time knob of soft-enabling it.
>>>>> Therefore, a new parameter "strict_devmem=" is added. The reuslt are as
>>>>> follows,
>>>>>
>>>>> - Before this change
>>>>>     crash> wr panic_on_oops 0
>>>>>     wr: cannot write to /proc/kcore      <<<< failed
>>>>>
>>>>> - After this change
>>>>>     - default
>>>>>       crash> wr panic_on_oops 0
>>>>>       wr: cannot write to /proc/kcore    <<<< failed
>>>>>
>>>>>     - strict_devmem=off
>>>>>       crash> p panic_on_oops
>>>>>       panic_on_oops = $1 = 1
>>>>>       crash> wr panic_on_oops 0
>>>>>       crash> p panic_on_oops
>>>>>       panic_on_oops = $2 = 0            <<<< succeeded
>>>>>
>>>>>     - strict_devmem=invalid
>>>>>       [    0.230052] Invalid option string for strict_devmem: 'invalid'
>>>>>       crash> wr panic_on_oops 0
>>>>>       wr: cannot write to /proc/kcore  <<<< failed
>>>>>
>>>>> Suggested-by: Ingo Molnar <mingo@kernel.org>
>>>>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>>>>> ---
>>>>>    .../admin-guide/kernel-parameters.txt         | 16 ++++++++++++++
>>>>>    drivers/char/mem.c                            | 21 +++++++++++++++++++
>>>>>    2 files changed, 37 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>>>> index 1518343bbe22..7fe0f66d0dfb 100644
>>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>>> @@ -6563,6 +6563,22 @@
>>>>>                        them frequently to increase the rate of SLB faults
>>>>>                        on kernel addresses.
>>>>>
>>>>> +     strict_devmem=
>>>>> +                     [KNL] Under CONFIG_STRICT_DEVMEM, whether strict devmem
>>>>> +                     is enabled for this boot. Strict devmem checking is used
>>>>> +                     to protect the userspace (root) access to all of memory,
>>>>> +                     including kernel and userspace memory. Accidental access
>>>>> +                     to this is obviously disastrous, but specific access can
>>>>> +                     be used by people debugging the kernel. Note that with
>>>>> +                     PAT support enabled, even in this case there are
>>>>> +                     restrictions on /dev/mem use due to the cache aliasing
>>>>> +                     requirements.
>>>>> +             on      If IO_STRICT_DEVMEM=n, the /dev/mem file only allows
>>>>> +                     userspace access to PCI space and the BIOS code and data
>>>>> +                     regions. This is sufficient for dosemu and X and all
>>>>> +                     common users of /dev/mem. (default)
>>>>> +             off     Disable strict devmem checks.
>>>>> +
>>>>>        sunrpc.min_resvport=
>>>>>        sunrpc.max_resvport=
>>>>>                        [NFS,SUNRPC]
>>>>
>>>> This will allow to violate EXCLUSIVE_SYSTEM_RAM, and I am afraid I don't
>>>> enjoy seeing devmem handling+config getting more complicated.
>>>
>>> That poses a challenge. Perhaps we should also consider disabling
>>> functions that rely on EXCLUSIVE_SYSTEM_RAM when strict_devmem=off,
>>> but implementing such a change seems overly complex.
>>>
>>> Our primary goal is to temporarily bypass STRICT_DEVMEM for live
>>> kernel debugging. In an earlier version, I proposed making the
>>> fucntion devmem_is_allowed() error-injectable, but Ingo pointed out
>>> that it violates the principles of STRICT_DEVMEM.
>>
>> I think that "primary goal" is the problem here.  We don't want to do
>> that, at all, for all the reasons why we implemented STRICT_DEVMEM and
>> for why people enable it.
>>
>> Either you enable it because you want the protection and "security" it
>> provides, or you do not.  Don't try to work around it please.
>>
>>> Do you have any suggestions on enabling write access to /dev/mem in
>>> debugging tools like the crash utility, while maintaining
>>> compatibility with the existing rules?
>>
>> I think you just don't provide write access to /dev/mem for debugging
>> tools as it's a huge security hole that people realized and have plugged
>> up.  If you want to provide access to this for "debugging" then just
>> don't enable that option and live with the risk involved, I don't see
>> how you can have it both ways.
> 
> I don’t quite see how STRICT_DEVMEM could pose a significant security
> concern. If you’re root, you already have the ability to do whatever
> you want on the system if you’re determined to. This option primarily
> serves to prevent reckless or accidental writes to kernel memory.
> 
> As I understand it, STRICT_DEVMEM is more about enabling functionality
> for features like page table checking and virtio_mem than about
> enforcing security.

If you look at the history, there were all mechanisms added way after 
STRICT_DEVMEM.

I mean, just take a look at who relies on STRICT_DEVMEM.

HARDENED_USERCOPY in security/Kconfig ..

So NACK.

-- 
Cheers,

David / dhildenb


