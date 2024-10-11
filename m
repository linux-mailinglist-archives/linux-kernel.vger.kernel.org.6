Return-Path: <linux-kernel+bounces-360833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC2899A053
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE318B2262C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574CE210191;
	Fri, 11 Oct 2024 09:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ir2CN8YO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C6F20FA92
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 09:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728640113; cv=none; b=vBAw9h0ba++TPaNzd8zR3G8JRz2DDi9023wF9jwO5NetTXcHQ9hwkO+PlyBf42Z2dKr00VKBW55s5Ei0KNlKifFV04eiyqVcLrNkQGxlEmXpkRAj8ZBVceQ9YZ47GBmVbQKcoKulH2INd0xx1B78hJMozXfnxAZfslx4Z1HPirM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728640113; c=relaxed/simple;
	bh=6zLrCxvPWp/HfBePygSl4UEA5jCtWhS8Xlx9eW/+QxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pE7nzcy1JsY+wWTn6TtlgFyybFxNCy16oiFa6AjdSrXxN8NsU7qFO+kZ7ahFM8ZkPZP9qV9CUxQkvHURSdfi7jub4X+oriIKO61tcOT5j62+jJ+eOFtG3ajEhh9V4eiNXPxGf7LS8G6GcVgYeacZl+TLu+gjmq4rtwZzk+zEE8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ir2CN8YO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728640111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nFml5bu07TjtsGgoGy1G/ldM+ZV3Omcp3k9SfVkcSQM=;
	b=Ir2CN8YOcGxRljGbor8MqAPV1vO+iy2TMFxozSw70osgYWi4vHVOez5oem0qplrJebxTl5
	8Qv2vUem00r/M+A32Lr0fXSLnIW5+F5xdEDwwR9Y0Jut/9Cd0QNiqugDuXr859bHDh7rrC
	E/7SsKEMgp6XYEialR+gJyIAzpntsho=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-vSKQpvyaOm26C8n75UQh6Q-1; Fri, 11 Oct 2024 05:48:27 -0400
X-MC-Unique: vSKQpvyaOm26C8n75UQh6Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4311c47684aso4681435e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 02:48:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728640107; x=1729244907;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFml5bu07TjtsGgoGy1G/ldM+ZV3Omcp3k9SfVkcSQM=;
        b=Ql4yhkWpkr/y/sFebcUKgSyRvNjGoZi8pU3m8HicArfJ4Hvj4omsFupSRY/Fwo0ojG
         kqFUcvbL5FJfF54ZAYHVcnaUyoY2XMkpWGmImlWrtmIS4sl1KYtsLeW0FLezXgfB3wSR
         7uZTesfR5IbxnS/QCwiqXfMok1+csy+ASWnCrSLj0s0J2oGisNjN4il4ix9HLr3X4nAe
         EwIwt5AsTfO3rRIo6vfPhdxbAt8385FBqbYpSQnlzWToZ4vLensLBgSS7fPMpqwZNP1f
         5HBIPb2RSHwqlFd8IHjxRw8V2V9mPaC0ItPWAIAVgxIcpf1u66NdsmKxuIezRFK0dF+C
         7awg==
X-Forwarded-Encrypted: i=1; AJvYcCVjdirNathQhaIaiknnovgddjmsz9tNxoey63zWr+Zenru6MNmjdwgDlRV3j9FNQtnsdNdtrjTSliWwVWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvD4PMk6qFXJOjk2/YF9Xxp7GHjd2Tgmsvh3Uw8LzOyF8qG2dS
	Qpd7u/DmdImGDeKuMUO+H0ubntSu8H83RXLD0aSsgT+7fC0vQTDoUGDEKfIBoGLei0voukE53We
	A6t0vYepl91Z81WWL5UoPBwPiV51V3K8AIEKSO5OrWyDHQPMz0kLTku6S9u5pOw==
X-Received: by 2002:a05:600c:1d0e:b0:431:1575:2e83 with SMTP id 5b1f17b1804b1-4311ded1b02mr13651035e9.10.1728640106708;
        Fri, 11 Oct 2024 02:48:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/ywSqey+Mf6IeCMC4/m/fXHc33V5jKaT5QQ3u/c1qmdPgsV1I/ucAMlKe8fOi9FNwsuX/Zg==
X-Received: by 2002:a05:600c:1d0e:b0:431:1575:2e83 with SMTP id 5b1f17b1804b1-4311ded1b02mr13650815e9.10.1728640106306;
        Fri, 11 Oct 2024 02:48:26 -0700 (PDT)
Received: from ?IPV6:2003:cb:c749:9100:c078:eec6:f2f4:dd3b? (p200300cbc7499100c078eec6f2f4dd3b.dip0.t-ipconnect.de. [2003:cb:c749:9100:c078:eec6:f2f4:dd3b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d748d450sm70323745e9.39.2024.10.11.02.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 02:48:25 -0700 (PDT)
Message-ID: <4bc038a4-e8ff-4441-acb1-63fcb3dc9068@redhat.com>
Date: Fri, 11 Oct 2024 11:48:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -V2] tdx, memory hotplug: Check whole hot-adding memory
 range for TDX
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org,
 linux-coco@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 Kai Huang <kai.huang@intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, Oscar Salvador <osalvador@suse.de>
References: <20241010074726.1397820-1-ying.huang@intel.com>
 <037801d9-8923-4d49-8423-072fd7c73069@redhat.com>
 <87o73ra0p7.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <71dc3853-45a6-4fa5-b3c6-b165e0ab6a1b@redhat.com>
 <87v7xz81jk.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <87v7xz81jk.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.10.24 10:51, Huang, Ying wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 11.10.24 03:27, Huang, Ying wrote:
>>> David Hildenbrand <david@redhat.com> writes:
>>>
>>>>>     extern u64 max_mem_size;
>>>>>       extern int mhp_online_type_from_str(const char *str);
>>>>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>>>>> index 621ae1015106..c4769f24b1e2 100644
>>>>> --- a/mm/memory_hotplug.c
>>>>> +++ b/mm/memory_hotplug.c
>>>>> @@ -1305,6 +1305,11 @@ int try_online_node(int nid)
>>>>>     	return ret;
>>>>>     }
>>>>>     +int __weak arch_check_hotplug_memory_range(u64 start, u64 size)
>>>>> +{
>>>>> +	return 0;
>>>>> +}
>>>>
>>>> BTW, I remember that "__weak" doesn't always behave the way it would
>>>> seem, which is the reason we're usually using
>>>>
>>>> #define arch_check_hotplug_memory_range arch_check_hotplug_memory_range
>>>>
>>>> #ifndef arch_check_hotplug_memory_range
>>>> ...
>>>> #endif
>>>>
>>>>
>>>> Not that I remember the details, just that it can result in rather
>>>> surprising outcomes (e.g., the wrong function getting called).
>>> I can replace __weak with #define/#ifndef.
>>> However, it appears that "__weak" is still widely used now.
>>
>> Probably better to avoid new ones.
> 
> Sure.  Will do that in the future versions.
> 
>> See also
>> Documentation/dev-tools/checkpatch.rst
>>
>> I assume checkpatch.pl should complain as well?
> 
> Double checked again.  It doesn't complain for that.

Indeed, it only checks for usage of "weak" for *declarations*. So maybe 
it's fine after all and I am misremembering things. So just leave it as 
is for the time being.

-- 
Cheers,

David / dhildenb


