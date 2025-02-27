Return-Path: <linux-kernel+bounces-535752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89081A476B8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49378188B6A4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689D7221F08;
	Thu, 27 Feb 2025 07:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZI98/mm8"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD7321D587
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740642049; cv=none; b=SQu1jnC9P8ZCk9w+rtuHPkWNuJ6e2cHReuDp3aFRVRV9ZsDhAIwYK4UEFem7BT3Ei7sWMXElcasI2XccV9up5QFk8XgDBoUkpph8yoVy+OideKdnCaDVdAX5LosepkCWOVZkQRuyQHJOpjJG8Wp13vxuNhy03bxAWtuedf0812c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740642049; c=relaxed/simple;
	bh=i5i5/2WtwcEwL6yfATVhVUfAvygcEdaPGTM1LRPGSAs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=slpf6AyFzSxIDUXw8z+YDacK3Vp4aCE9IbwB9tux0KaRgHqlevKsMN64RIiBZQkL50HPK+1WnANGY8reiFYWSfJjD2YGg8g+7FbaUWSUIk863PuHKtC9XHQdsz9OYb7jruV4xNKH5JN5yKWALYrVdx+ai0emXNaWjbrwZO1DjgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZI98/mm8; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22359001f1aso3765175ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 23:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740642046; x=1741246846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5Gzl06H2T5FbZ9IOLR6EjrtJZgeU6uFgDyakJm+mzM=;
        b=ZI98/mm8VeyBhQz2Zg7Rle8zcVBOHqo5hl6MmoRw5VzB1ISbzZOrNFyiztJePaDQpY
         aP3eu57DianbPnPRGW7AeG7Rkkq1idshMZrVvQuVp15sAS+OS9Bt0t1/b0fOHeePyl8e
         jenrtSgiIIy98OLdYVB/+SMUZ9EVmg6qAc0Oei1dRQJYCaNWFBcpmXw/E5Jh+38LSJOv
         LS3du2Gh+CYCkx571ksdMZRrcib8dzhFuUUHIcYhscZTcl4pQGbzt9GTJnIuIR3mVF0S
         L2DAqD5cfhBDE3YAE3oMwFZrCeXxs4ABuDXx0WJTcf1Xmp8n167LaMtRo0WyUDzdWCd/
         JSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740642046; x=1741246846;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z5Gzl06H2T5FbZ9IOLR6EjrtJZgeU6uFgDyakJm+mzM=;
        b=ksokG7hgrxfr/XJKn3lCtIXp4JxvM6qmvvxqiWCHli7jZrlUddiNzB04dN5TNzSuK1
         JNmHrtxipKk72GQvV5QCCWjIcBju8zTHwMaARySuDEV4zLgWpDjjJY3gEZFxa1Laon6P
         53jV+R5x3d2T/RYFVEc42XDWO0xqjJu4lay1fiBDOxLDT/xoVzpXW/nWOhr0+lHxRpBZ
         DtS9xSd4L4RX4wvgaWsr8J3bHH6NmQD1a5ZMb/3oiLk5EjEFmpNfh7WosGap2t/Ognzy
         5nxwhWUf3Pgz5yJIe6EhQNiNDIr+cHc55RhoaEJRB6aKHoCWwww1cDd+lAMhwxfNGjFU
         dfzA==
X-Forwarded-Encrypted: i=1; AJvYcCU0pmHvOYQatiKSbo50w3KiO8XtvCoQahZM0yKeP7OhMA3cXEzDWiSloXosICUgWHk628185ueFHY0shJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2S2l0+lZokWh383wjP1XAnIyqNJqvn3tMMSP2KCQwb0eRlu97
	yL6E6fpRmVDnIAxcsbTb4UmZ+iTYEBOw0lzgH0B6HLO7eRd9uny8Wkb/5b6QUhE=
X-Gm-Gg: ASbGncucL18Yu+7ibvhvb1zluFpOZjy5/JoaA9rPborQ0z0whM8l3ten8KZvIlQKGnx
	w4erJEGL5PlX2UakQnVQ5B8hnX21nL6dIGP8lq/ksJi3wRA3EnUK9zSCV7eD5WGK+IAzsmXYUPb
	TIRDyrhAJCaPW/FWTS9xBwS3OE4wT53dx/p52GPEsYJZ5DKIifxhBRe4VIZbhkD76ZDAxaNihd0
	NUYqyE1vhe6Ed/paHTuSZrJt5uf7ahEF1wHqxR8uxsnuWJYMQSLF9uJr5HMeM4afOpJvWXEW/kP
	TsxzCpxGZHnEDxYmmWF13JhabqZxwx/0yx+dJFN+wGpvvSzJqQ==
X-Google-Smtp-Source: AGHT+IEWhr28ouNGqr2cMLn6viCM/3ClvBIDRbvTbC18jRLu78wwmIB+H6DOh64BYZadBUL1LgBoxg==
X-Received: by 2002:a05:6a20:728f:b0:1ee:e33d:f477 with SMTP id adf61e73a8af0-1eef52e9a19mr44559120637.15.1740642046190;
        Wed, 26 Feb 2025 23:40:46 -0800 (PST)
Received: from [10.68.122.90] ([63.216.146.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a0040208sm843218b3a.154.2025.02.26.23.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 23:40:45 -0800 (PST)
Message-ID: <2d73d888-fcb2-4b3b-a9ec-ad9c80d7cbe9@bytedance.com>
Date: Thu, 27 Feb 2025 15:40:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CONFIG_PT_RECLAIM
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: Johannes Weiner <hannes@cmpxchg.org>, peterz@infradead.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250226183013.GB1042@cmpxchg.org>
 <a77923d3-ce26-4e29-bb98-b908ce2355c2@bytedance.com>
 <20250227060820.GC110982@cmpxchg.org>
 <6281ffc9-398e-44b9-a95c-2527004e09b7@bytedance.com>
In-Reply-To: <6281ffc9-398e-44b9-a95c-2527004e09b7@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/27/25 2:58 PM, Qi Zheng wrote:
> Hi Johannes,
> 
> On 2/27/25 2:08 PM, Johannes Weiner wrote:
>> On Thu, Feb 27, 2025 at 11:04:51AM +0800, Qi Zheng wrote:
>>> Hi Johannes,
>>>
>>> On 2/27/25 2:30 AM, Johannes Weiner wrote:
>>>> Does PT_RECLAIM need to be configurable by the user?
>>>
>>> The PT_RECLAIM will select MMU_GATHER_RCU_TABLE_FREE, but not all archs
>>> support MMU_GATHER_RCU_TABLE_FREE, and even before Rik's a37259732a7dc
>>> ("x86/mm: Make MMU_GATHER_RCU_TABLE_FREE unconditional"), x86 only
>>> supports MMU_GATHER_RCU_TABLE_FREE in the case of PARAVIRT.
>>>
>>> Therefore, PT_RECLAIM also implies the meaning of enabling
>>> MMU_GATHER_RCU_TABLE_FREE, so I made it user-configurable. And I just
>>> thought that as a new feature, it would be better to give users the
>>> ability to turn it on and off.
>>
>> New *features*, yes - something that has a significant enough cost
>> that clearly not all users want to pay for the benefits.
> 
> Got it.
> 
>>
>> But it's hard to imagine anybody would WANT to keep the page tables
>> around if they madvised away all the pages inside of them. It's a
>> great optimization, what would be a reason to opt out?
> 
> OK, now I think it makes sense to change it to 'def_bool y'.
> 
>>
>>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>>> index 2761098dbc1a..99383c93db33 100644
>>>> --- a/mm/Kconfig
>>>> +++ b/mm/Kconfig
>>>> @@ -1309,16 +1309,9 @@ config ARCH_SUPPORTS_PT_RECLAIM
>>>>        def_bool n
>>>>    config PT_RECLAIM
>>>> -    bool "reclaim empty user page table pages"
>>>> -    default y
>>>> +    def_bool y
>>>>        depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
>>>>        select MMU_GATHER_RCU_TABLE_FREE
>>>> -    help
>>>> -      Try to reclaim empty user page table pages in paths other 
>>>> than munmap
>>>> -      and exit_mmap path.
>>>> -
>>>> -      Note: now only empty user PTE page table pages will be 
>>>> reclaimed.
>>>> -
>>>
>>> Maybe keep the help information?
>>
>> I don't find it very helpful :( Which "other paths?" It doesn't
>> explain any pros and cons, and why anybody might choose to enable or
>> disable it. The Note repeats what's in the sentence before it.
> 
> Sorry about that. :(
> 
>>
>> Maybe I'm missing something. Could this not just be an #ifdef block
>> inside mm/madvise.c, instead of living inside a new file with two new
>> config symbols?
>>
>> #ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
>> ...
>> #endif
>>
>> Is there an arch-specific feature that it requires besides
>> MMU_GATHER_RCU_TABLE_FREE such that only x86 supports it now?
> 
> No, it only needs MMU_GATHER_RCU_TABLE_FREE.
> 

And I originally planned to support more architectures. The following 
link has some of my previous plans:

https://lore.kernel.org/all/0ca36b2e-463e-493f-aede-aff9aec3c7fa@bytedance.com/

It would be better if more people could discuss and participate. ;)

Thanks!

> 


