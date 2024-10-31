Return-Path: <linux-kernel+bounces-391350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A3F9B8574
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57B50284E8A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12001CCEFE;
	Thu, 31 Oct 2024 21:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JS3pFYNB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0431CC8AF
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 21:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730410791; cv=none; b=H1WyK0ICGyTW1kuuQBz3XIqyKwazIIqVW89bGmCpgOIbSNwAu+oXPJ3fe/fuZNTCsE0tWPtCZYM7LaumSJaVxCB/0Eo1d8l2jjOV1GPvjGEsuchIKtdBE96PeMpxMdS8UEkC1iF5HpONUankvVB9u20b1LTBYHT/fUcFSSRHCkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730410791; c=relaxed/simple;
	bh=hmZEoE9F1KOcW36e3uTA3ZMp9t9/NxyYPFC1dw7nd2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pOdw4G3dPV8/EI8KOpkxFweKwJFeJ/TAZNuKmOYhXj0FNE/j3V0WGhGxIXa9wVsICG3M2DCdP3knDZFUo/LXYEXqsVIsekYg6vMPhHQ+pWo3ORkafcqJEibTtKMhW4dQOjymqXV4uVqFJnoLywNq+SIQb8FNefWWgzeY1pw2tVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JS3pFYNB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730410784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fS8gDTZFJocEezC83019NI02fuHlBLQO1gTHctRA88I=;
	b=JS3pFYNBvSpsoxoHz/0HR4o66NE8jFVBwv4IfHChfppjTe27WQq4SFnw4T2NZCAW0aDYFD
	AL17PRJ3B8hsZJIXn1uC6e0tNox5Oa9tD6+toXpSoyjIVUjIefN7mSSgEFFikZzJ9wvnSk
	Jisv9IYSf0f2+rAeehE4Qcmrtlg65cQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-dE5lZZkYMQeJVpTzv2fcGg-1; Thu, 31 Oct 2024 17:39:42 -0400
X-MC-Unique: dE5lZZkYMQeJVpTzv2fcGg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d52ca258eso682085f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 14:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730410780; x=1731015580;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fS8gDTZFJocEezC83019NI02fuHlBLQO1gTHctRA88I=;
        b=vdioqUMG7CjyHTkU5lUp2tTRyKHcM+/ZqCbxvimGTgK/wCJ+DY2Vpi/TeDOhVPHMzw
         p/7TVhEHq84ZbDfYJX3W2o15USjPdqR7JB9x48FwyzXr+1iSsNekW9u8Bb3yVjW5T+BC
         ws7NxqFQlNnsU4bmx0/17z8dYgnZ3pTgQrCVvsbNqxzUhLnBDBC2I7S89u2WFJCuK20I
         1cCzty8FbrB+qWcszvC6E4Y7bWDrW3dHiq9haxIuyNY+/J938opzBMmFUErsiv/igjAX
         P2vhxssiv5ZcLuX+xsAp2xNT8sdKMKrnA6UAGv64GLo4gtFe9QDfLDBJiL7KDIp8GBL4
         STrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXARGlChN9ypr8G6qL9T5YNKCjXBmYHLJ4DrgnqjKzlG1ETlFk+9ZyR4o205jkpWTNKINo1tV2bW4FvCx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSBiFPUodJiQs3KMIyqXvOWIEdGQFb9dO6b3jXN8zXLwV5jrer
	YZWnXT9ywvSnY8m1rnfTOIVOZcScM6BSdoij826XM5zMGyGtwwddcKBeN1US7yBPpeP1TY4T7hd
	EnEhRrR5i5kzTV1KhV7lBasFZhDVm9K+KSU3Zhc3G98w+JggmTqdsQJFQo+R6ag==
X-Received: by 2002:adf:ee4d:0:b0:37d:45f0:b33 with SMTP id ffacd0b85a97d-381b7056d6amr6777251f8f.9.1730410780501;
        Thu, 31 Oct 2024 14:39:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENOxIGk6gyTscvzdN2IufYd95BCndSW0PH0URMhHpqGHW7gsAlNh6s+kWKbfa51JfOcQCEvQ==
X-Received: by 2002:adf:ee4d:0:b0:37d:45f0:b33 with SMTP id ffacd0b85a97d-381b7056d6amr6777232f8f.9.1730410780072;
        Thu, 31 Oct 2024 14:39:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:ed00:7ddf:1ea9:4f7a:91fe? (p200300cbc70aed007ddf1ea94f7a91fe.dip0.t-ipconnect.de. [2003:cb:c70a:ed00:7ddf:1ea9:4f7a:91fe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e51csm3203248f8f.79.2024.10.31.14.39.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 14:39:39 -0700 (PDT)
Message-ID: <ec69b1ee-89f4-47d2-a223-f277b7aad76b@redhat.com>
Date: Thu, 31 Oct 2024 22:39:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] mm: shmem: override mTHP shmem default with a
 kernel parameter
To: Barry Song <21cnbao@gmail.com>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Lance Yang
 <ioworker0@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
References: <20241030130308.1066299-1-mcanal@igalia.com>
 <20241030130308.1066299-4-mcanal@igalia.com>
 <2c507326-3267-431e-936a-23e2ab6a3baf@redhat.com>
 <899284fa-953f-48a1-af29-222d0d55881c@igalia.com>
 <cfcfaed5-8612-46f4-b3dd-67e1d81d049f@redhat.com>
 <95c48a30-0696-4110-950e-e81afb4ffc2a@igalia.com>
 <5745d2ca-4d87-4d1f-b38f-734c7086f462@redhat.com>
 <d65176f1-df6f-4e21-b281-469ec958f26f@igalia.com>
 <CAGsJ_4zObE7hsFangzmKK0c6wZ7xZS3fCEYdx5W6HkAHqcP20g@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4zObE7hsFangzmKK0c6wZ7xZS3fCEYdx5W6HkAHqcP20g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 31.10.24 22:12, Barry Song wrote:
> On Fri, Nov 1, 2024 at 3:20 AM Maíra Canal <mcanal@igalia.com> wrote:
>>
>> On 31/10/24 10:33, David Hildenbrand wrote:
>>> On 31.10.24 14:24, Maíra Canal wrote:
>>>> Hi David,
>>>>
>>>> On 31/10/24 09:57, David Hildenbrand wrote:
>>>>> On 31.10.24 13:51, Maíra Canal wrote:
>>>>>> Hi David,
>>>>>>
>>>>>> On 31/10/24 09:37, David Hildenbrand wrote:
>>>>>>> On 30.10.24 13:58, Maíra Canal wrote:
>>>>>>>> Add the ``thp_shmem=`` kernel command line to allow specifying the
>>>>>>>> default policy of each supported shmem hugepage size. The kernel
>>>>>>>> parameter
>>>>>>>> accepts the following format:
>>>>>>>>
>>>>>>>> thp_shmem=<size>[KMG],<size>[KMG]:<policy>;<size>[KMG]-
>>>>>>>> <size>[KMG]:<policy>
>>>>>>>>
>>>>>>>> For example,
>>>>>>>>
>>>>>>>> thp_shmem=16K-64K:always;128K,512K:inherit;256K:advise;1M-2M:never;4M-8M:within_size
>>>>>>>>
>>>>>>>> By configuring the default policy of several shmem hugepages, the
>>>>>>>> user
>>>>>>>> can take advantage of mTHP before it's been configured through sysfs.
>>>>>>>>
>>>>>>>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>>>>>>>> ---
>>>>>>>>      .../admin-guide/kernel-parameters.txt         |  10 ++
>>>>>>>>      Documentation/admin-guide/mm/transhuge.rst    |  17 +++
>>>>>>>>      mm/shmem.c                                    | 109 +++++++++++++
>>>>>>>> ++++-
>>>>>>>>      3 files changed, 135 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>
>>>>>> [...]
>>>>>>
>>>>>>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>>>>>>> index dfcc88ec6e34..c2299fa0b345 100644
>>>>>>>> --- a/mm/shmem.c
>>>>>>>> +++ b/mm/shmem.c
>>>>>>>> @@ -136,6 +136,7 @@ static unsigned long huge_shmem_orders_always
>>>>>>>> __read_mostly;
>>>>>>>>      static unsigned long huge_shmem_orders_madvise __read_mostly;
>>>>>>>>      static unsigned long huge_shmem_orders_inherit __read_mostly;
>>>>>>>>      static unsigned long huge_shmem_orders_within_size __read_mostly;
>>>>>>>> +static bool shmem_orders_configured __initdata;
>>>>>>>>      #endif
>>>>>>>>      #ifdef CONFIG_TMPFS
>>>>>>>> @@ -5027,7 +5028,8 @@ void __init shmem_init(void)
>>>>>>>>           * Default to setting PMD-sized THP to inherit the global
>>>>>>>> setting and
>>>>>>>>           * disable all other multi-size THPs.
>>>>>>>>           */
>>>>>>>> -    huge_shmem_orders_inherit = BIT(HPAGE_PMD_ORDER);
>>>>>>>> +    if (!shmem_orders_configured)
>>>>>>>> +        huge_shmem_orders_inherit = BIT(HPAGE_PMD_ORDER);
>>>>>>>>      #endif
>>>>>>>>          return;
>>>>>>>> @@ -5180,6 +5182,26 @@ struct kobj_attribute
>>>>>>>> thpsize_shmem_enabled_attr =
>>>>>>>>      #if defined(CONFIG_TRANSPARENT_HUGEPAGE)
>>>>>>>> +static inline int get_order_from_str(const char *size_str)
>>>>>>>> +{
>>>>>>>> +    unsigned long size;
>>>>>>>> +    char *endptr;
>>>>>>>> +    int order;
>>>>>>>> +
>>>>>>>> +    size = memparse(size_str, &endptr);
>>>>>>>> +
>>>>>>>> +    if (!is_power_of_2(size))
>>>>>>>> +        goto err;
>>>>>>>> +    order = get_order(size);
>>>>>>>> +    if (BIT(order) & ~THP_ORDERS_ALL_FILE_DEFAULT)
>>>>>>>> +        goto err;
>>>>>>>> +
>>>>>>>> +    return order;
>>>>>>>> +err:
>>>>>>>> +    pr_err("invalid size %s in thp_shmem boot parameter\n",
>>>>>>>> size_str);
>>>>>>>> +    return -EINVAL;
>>>>>>>> +}
>>>>>>>
>>>>>>> Hm, mostly copy and paste. You could reuse existing
>>>>>>> get_order_from_str()
>>>>>>> simply by passing in the supported orders and moving error
>>>>>>> reporting to
>>>>>>> the caller.
>>>>>>>
>>>>>>
>>>>>> Can I use functions from mm/huge_memory.c here?
>>>>>
>>>>> Yes, that's the idea.
>>>>>
>>>>
>>>> Unfortunately, it isn't possible without adding the function to a
>>>> header.
>>>
>>> Well ... sure, what's the problem with that?
>>
>> David & Barry, how do you feel about adding `get_order_from_str()` to
>> lib/cmdline.c?
> 
> I'd vote to leave it as is. If, at some point, the controls for shared memory
> and anonymous memory are moved to a file, that would be the right time
> to call the same get_order_from_str() for both.
 > > This is too trivial to warrant being an exposed API in huge_memory.h
> or cmdline.

I ... don't quite agree. cmdline.c is probably a bit excessive and I 
wouldn't suggest that at this point.

This seems like a reasonable helper function to have as inline in 
mm/internal.h.

... unless I am missing something important and the obvious code 
duplication is warranted.

-- 
Cheers,

David / dhildenb


