Return-Path: <linux-kernel+bounces-289405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 387419545DB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84B7CB241C6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6AE12BF25;
	Fri, 16 Aug 2024 09:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WwbAJvjr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404B612D1FA
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800826; cv=none; b=bpuTb1gjUBHsIhWoQ9tDAl12jPuaNwkjjql5+KNp2usy0kzP62ysnIYcNIOTzyd78UCNekjyXE/fOcqk2RYJzilslv6Bu+HeU50GaW6gWyHLNH5YYpmsGzmHqhJ7MwX4V5mJb5tVC2atbCkU0p1tN1E17wEzKJRDE3IzVVV1CNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800826; c=relaxed/simple;
	bh=9D6VS9ufMHodtD0YMDSLi/cD7T4e5rcKVugYFOK0KbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QnA+7FmwjdYFwPd3dnQ/ip9w9LuuxGrF3lxVv861QhqQwHvCMR7/YjePIrcotlioQeEzIJqkmBo6auU7JVhRtDM6C+oYfdBYMFCBiWqNTvWL8sU45JMHzSMNnqPDbJ/Kk+Y8XREjKHxwT5bPiO4PQpZKNv67mzKd6pC8YbT65IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WwbAJvjr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723800824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/aLIE9Wy2cX4IVGcjEJxINhx9bCUu1A5IloneKdrMQs=;
	b=WwbAJvjr/q7cY153iSsbgqzyRpHfIz6GxPt1iPtzzYLiD9XH+pDVtRQmnxexN+xN5sR4s/
	ad1RidTsHgjXjFpIVNyqcJmckfr+68hvdqHRZSkxe7EeVeumFEo+RcIWG05W97SQ/QFBNz
	3V2AjT/ifJWSuYESLpcOxUn7CfZ8MPo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-lB24M_j5MbOyX9wiJcgfWw-1; Fri, 16 Aug 2024 05:33:41 -0400
X-MC-Unique: lB24M_j5MbOyX9wiJcgfWw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3717cc80ce1so932710f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 02:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723800820; x=1724405620;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/aLIE9Wy2cX4IVGcjEJxINhx9bCUu1A5IloneKdrMQs=;
        b=U/71jJoEMyX3GIwr8wBmEleaU5YHre7PwiIu6Fx2Kiq0/cDJEt3wQsw6H40liiYuJG
         MfiAcLmd76imQmPS+2Lzi2jRkF8HRwu9YuA9AY+swGvaoryvJlA1daQQ79MOzrXUJLSu
         9HIcfyB1H83o6DlnVObQeSFPSKaqb8V5GdM2WSbKIs1B9UyEa+6oEjXo2neWLlVtAZWI
         yFOavvy4+Vech7NElSYy9y2bw/fPeAOeYalPTqVv3qiJkZixYSXwlKGh2WKYyL7/qZDz
         CrsWU1hb6Eeyni5vAbQaEO6lI/zP8xp6pVVgPTShSzEyRk9ylGYsb9bxw8rS6A25oWhE
         VE5A==
X-Forwarded-Encrypted: i=1; AJvYcCWRD+1jdifcdFdJiwvAL+FnYQFxOVJOn6aXcbvtnkTa+7VMdEA+xdmzs/+LsvxF0WpLO2tfSJxkLUadUFKUeQ8o7jhy3p640QrZedmF
X-Gm-Message-State: AOJu0Yy1XnsyxlD+lrZt05cbXHUbd81g2jHJgmK1yrBhxEHE0t96C8WZ
	H/qGOQrqOSa+Pj5f4uFRJHoYHuOffYYraNwbhGFcZGPdQTq5f/uKCovgPsu3ZjAgGVBmsPHvLp4
	GaJ5XkQdqzlDm0uOPVudcJWSwKCU6vu/7ZHZfkQf61LyL1AGTM+QXSrdSJ3QPOg==
X-Received: by 2002:a5d:4dce:0:b0:36b:555a:e966 with SMTP id ffacd0b85a97d-3719465fc3amr1662229f8f.35.1723800819804;
        Fri, 16 Aug 2024 02:33:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEknS3w7aPrZ5mVy6ECUybeOVv4tm6JhNwQWmyeWxcbM+875XWLiNBj1q35MS7Aw6g16iWPLQ==
X-Received: by 2002:a5d:4dce:0:b0:36b:555a:e966 with SMTP id ffacd0b85a97d-3719465fc3amr1662201f8f.35.1723800819247;
        Fri, 16 Aug 2024 02:33:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c721:b900:4f34:b2b7:739d:a650? (p200300cbc721b9004f34b2b7739da650.dip0.t-ipconnect.de. [2003:cb:c721:b900:4f34:b2b7:739d:a650])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898aa8casm3251106f8f.93.2024.08.16.02.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 02:33:38 -0700 (PDT)
Message-ID: <d4f302e6-033a-4a6a-9c42-077331b32bd1@redhat.com>
Date: Fri, 16 Aug 2024 11:33:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm: Override mTHP "enabled" defaults at kernel cmdline
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, corbet@lwn.net, ioworker0@gmail.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, ryan.roberts@arm.com,
 v-songbaohua@oppo.com
References: <6e23c705-3d67-419b-b085-f19f5101124c@redhat.com>
 <20240815235001.96624-1-21cnbao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240815235001.96624-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16.08.24 01:50, Barry Song wrote:
> On Thu, Aug 15, 2024 at 10:26 PM David Hildenbrand <david@redhat.com> wrote:
>>
>>>>> +static inline int get_order_from_str(const char *size_str)
>>>>> +{
>>>>> +     unsigned long size;
>>>>> +     char *endptr;
>>>>> +     int order;
>>>>> +
>>>>> +     size = memparse(size_str, &endptr);
>>>>
>>>> Do we have to also test if is_power_of_2(), and refuse if not? For
>>>> example, what if someone would pass 3K, would the existing check catch it?
>>>
>>> no, the existing check can't catch it.
>>>
>>> I passed thp_anon=15K-64K:always, then I got 16K enabled:
>>>
>>> / # cat /sys/kernel/mm/transparent_hugepage/hugepages-16kB/enabled
>>> [always] inherit madvise never
>>>
>>
>> Okay, so we should document then that start/end of the range must be
>> valid THP sizes.
> 
> Ack
> 
>>
>>> I can actually check that by:
>>>
>>> static inline int get_order_from_str(const char *size_str)
>>> {
>>>        unsigned long size;
>>>        char *endptr;
>>>        int order;
>>>
>>>        size = memparse(size_str, &endptr);
>>>
>>>        if (!is_power_of_2(size >> PAGE_SHIFT))
>>
>> No need for the shift.
>>
>> if (!is_power_of_2(size))
>>
>> Is likely even more correct if someone would manage to pass something
>> stupid like
>>
>> 16385 (16K + 1)
> 
> Ack
> 
>>
>>>                goto err;
>>>        order = get_order(size);
>>>        if ((1 << order) & ~THP_ORDERS_ALL_ANON)
>>>                goto err;
>>>
>>>        return order;
>>> err:
>>>        pr_err("invalid size %s in thp_anon boot parameter\n", size_str);
>>>        return -EINVAL;
>>> }
>>>
>>>>
>>>>> +     order = fls(size >> PAGE_SHIFT) - 1;
>>>>
>>>> Is this a fancy way of writing
>>>>
>>>> order = log2(size >> PAGE_SHIFT);
>>>>
>>>> ? :)
>>>
>>> I think ilog2 is implemented by fls ?
>>
>> Yes, so we should have used that instead. But get_order()
>> is even better.
>>
>>>
>>>>
>>>> Anyhow, if get_order() wraps that, all good.
>>>
>>> I guess it doesn't check power of 2?
>>>
>>>>
>>>>> +     if ((1 << order) & ~THP_ORDERS_ALL_ANON) {
>>>>> +             pr_err("invalid size %s(order %d) in thp_anon boot parameter\n",
>>>>> +                     size_str, order);
>>>>> +             return -EINVAL;
>>>>> +     }
>>>>> +
>>>>> +     return order;
>>>>> +}
>>>>
>>>> Apart from that, nothing jumped at me.
>>>
>>> Please take a look at the new get_order_from_str() before I
>>> send v5 :-)
>>
>> Besides the shift for is_power_of_2(), LGTM, thanks!
> 
> Thanks, David!
> 
> Hi Andrew,
> 
> Apologies for sending another squash request. If you'd
> prefer me to send a new v5 that includes all the changes,
> please let me know.
> 
> 
> Don't shift the size, as it can still detect invalid sizes
> like 16K+1. Also, document that the size must be a valid THP
> size.
> 
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index 15404f06eefd..4468851b6ecb 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -294,8 +294,9 @@ kernel command line.
>   
>   Alternatively, each supported anonymous THP size can be controlled by
>   passing ``thp_anon=<size>,<size>[KMG]:<state>;<size>-<size>[KMG]:<state>``,
> -where ``<size>`` is the THP size and ``<state>`` is one of ``always``,
> -``madvise``, ``never`` or ``inherit``.
> +where ``<size>`` is the THP size (must be a power of 2 of PAGE_SIZE and
> +supported anonymous THP)  and ``<state>`` is one of ``always``, ``madvise``,
> +``never`` or ``inherit``.
>   
>   For example, the following will set 16K, 32K, 64K THP to ``always``,
>   set 128K, 512K to ``inherit``, set 256K to ``madvise`` and 1M, 2M
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index d6dade8ac5f6..903b47f2b2db 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -953,7 +953,7 @@ static inline int get_order_from_str(const char *size_str)
>   
>   	size = memparse(size_str, &endptr);
>   
> -	if (!is_power_of_2(size >> PAGE_SHIFT))
> +	if (!is_power_of_2(size))
>   		goto err;


Reading your documentation above, do we also want to test "if (size < 
PAGE_SIZE)", or is that implicitly covered? (likely not I assume?)

I assume it's implicitly covered: if we pass "1k" , it would be mapped 
to "4k" (order-0) and that is not a valid mTHP size, right?

I would appreciate a quick v5, just so can see the final result more 
easily :)

-- 
Cheers,

David / dhildenb


