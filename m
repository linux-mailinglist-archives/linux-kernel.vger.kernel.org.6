Return-Path: <linux-kernel+bounces-295308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA6995998C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D44B28056F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9E41B2ED9;
	Wed, 21 Aug 2024 10:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BCwFgMVT"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F371BFE18
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 10:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724234619; cv=none; b=TupcKx6Lpkjkd/EeOcdsXkv343G2ZLo7qzW6bbN0taabHTK9g6T05ozASTHPLVeG+ZmwKrHfhMI4Zq0ei6UCK2rO6pRRfRYEmVVheX9uZ+qAn04o10sDd42m4cWRpK/Zvma5+AZV4SIjy3ySoPH8ws2BvZTy8Wa/kchFQvlGHrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724234619; c=relaxed/simple;
	bh=6bZ7/iuSWrOCnTdKccC7MLCgsII3Qg3gHUVex/8ylqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PHDu+C0VJSwoEkKs5eyzmNKKgqQuSAseTNWfPO+s0YSpNfeI20hOSoNSZM6+O5XWI+VmD6sC6NHNmZuvDXc7fJYiFHKf7WG7UH8YI4wU8sBFpC7TMjsvZl5icJVFuKTJYmBF6q6a86YEk9kusHlGXyyFHHesTbP+BlvmLKUbBZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BCwFgMVT; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7141e20e31cso930682b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 03:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724234617; x=1724839417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hc9KXq9HiCmVA6sa8jp61udoxCJLWx+IYCHX8J3fcJQ=;
        b=BCwFgMVTnabY0o31x+Vuu7f75hBN/vzbWQ+OYZl9VdsA4+5yhgBCNyYUNJECOgDWtI
         yTWPXvL+li+853Ru5J2Um3qZigBNNjzC0LgicS6Uhr5TZYfqgyjSVtuDS7uTLLEbfKU+
         0ONqmjs9sGUXVQfIYNBcPNwUyp6ekiR5V+68hufxqKtdJmPWQkbD7jmgx5uQ1BaCHzmC
         Pl6+QPKGJUcBiQ1ifGFI6f2Bt+amfuc1Tz0zN3FWFFCBSf5D1WVkpy/t2ynhxGfIQ/GF
         4s1UJnWIqb0K5btEOOP800PTI2lk6WtZ/PIvqGmoFln5VpmXJKUMzQZHvCM6RtKQ0zIK
         QXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724234617; x=1724839417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hc9KXq9HiCmVA6sa8jp61udoxCJLWx+IYCHX8J3fcJQ=;
        b=Db8n1WwEp/jRPaWQNLIP1i0A29mtx2UeiLicvKKMwqmeT+4nuADci7M5VrfTosJr2G
         NxW0xKfhAKnxA+XAyVzBVQVlT5Bz+09l9/bNNzEIZIZDHY+m45WPQXfAGlFyx0l9bwYJ
         B8IJqJk4j6FBUe8O4lKEkYqx3BioHoGHJ9alJT84CbKtu+BkuBDYeDSWSeUhyFqJenSI
         ES0AWQ79YFasNcSkDnQ6Lv76cjjGI/EXlzRq8wWOqSBKIexgStKJocBuHt6zecuOV1th
         eqdsVpZ1fZH8ijWc89PxwBBEfJwGYc/+3HHuLZueoLxXwjaRIKVY4BChrzKJph/wuOec
         8xng==
X-Forwarded-Encrypted: i=1; AJvYcCV4Oag3x1YAf5FpcwuqXuBt9xDBd10ZmDyDevTe6HLr1n8szNXSiHTK+TFm7OEIL8Gbu2YTBBZEabs6Ekc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXqoeYMTtEYbxFnjW2emoHklEIkcCwtjhPh5b7TrDzHgpa+XL6
	C8rQArs2gE7DtqQ5kBsV8wUU3hZZ1c46yJtM6wQRZxtLcCT2QWBekBXbG+Zzy4w=
X-Google-Smtp-Source: AGHT+IHzEyIAn5BZKdsgEF+tkgsjaGhBmdzJxEgxGtA7eOAAo7NB0TYXIZ9VX90RiBa6VatggNPMRg==
X-Received: by 2002:a05:6a20:9f4e:b0:1c4:a531:bafd with SMTP id adf61e73a8af0-1cad7f8b77dmr2391092637.18.1724234617078;
        Wed, 21 Aug 2024 03:03:37 -0700 (PDT)
Received: from [10.84.144.49] ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef610esm9588632b3a.129.2024.08.21.03.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 03:03:36 -0700 (PDT)
Message-ID: <83142dc8-edcf-4e47-8215-8b359a2b7156@bytedance.com>
Date: Wed, 21 Aug 2024 18:03:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] mm: handle_pte_fault() use
 pte_offset_map_maywrite_nolock()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>,
 "hughd@google.com" <hughd@google.com>,
 "willy@infradead.org" <willy@infradead.org>,
 "muchun.song@linux.dev" <muchun.song@linux.dev>,
 "vbabka@kernel.org" <vbabka@kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "rppt@kernel.org" <rppt@kernel.org>,
 "vishal.moola@gmail.com" <vishal.moola@gmail.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <cover.1724226076.git.zhengqi.arch@bytedance.com>
 <239432a0bc56464e58a6baf3622fdc72526c8d57.1724226076.git.zhengqi.arch@bytedance.com>
 <6a586524-5116-4eaf-b4f3-c1aea290d7c1@cs-soprasteria.com>
 <b4bf605a-d31a-40ad-8cee-fe505e45dc64@bytedance.com>
 <4b867535-8481-4fa1-bed1-ad25a76682f0@redhat.com>
 <ef40c2ef-e4a4-4b02-85b8-a930285a3d0e@bytedance.com>
 <61c05197-0baa-4680-ad24-5965ba37dc35@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <61c05197-0baa-4680-ad24-5965ba37dc35@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/8/21 17:53, David Hildenbrand wrote:
> On 21.08.24 11:51, Qi Zheng wrote:
>>
>>
>> On 2024/8/21 17:41, David Hildenbrand wrote:
>>> On 21.08.24 11:24, Qi Zheng wrote:
>>>>
>>>>
>>>> On 2024/8/21 17:17, LEROY Christophe wrote:
>>>>>
>>>>>
>>>>> Le 21/08/2024 à 10:18, Qi Zheng a écrit :
>>>>>> In handle_pte_fault(), we may modify the vmf->pte after acquiring the
>>>>>> vmf->ptl, so convert it to using pte_offset_map_maywrite_nolock(). 
>>>>>> But
>>>>>> since we already do the pte_same() check, so there is no need to get
>>>>>> pmdval to do pmd_same() check, just pass NULL to pmdvalp parameter.
>>>>>>
>>>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>>> ---
>>>>>>      mm/memory.c | 9 +++++++--
>>>>>>      1 file changed, 7 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>>> index 93c0c25433d02..d3378e98faf13 100644
>>>>>> --- a/mm/memory.c
>>>>>> +++ b/mm/memory.c
>>>>>> @@ -5504,9 +5504,14 @@ static vm_fault_t handle_pte_fault(struct
>>>>>> vm_fault *vmf)
>>>>>>               * pmd by anon khugepaged, since that takes mmap_lock in
>>>>>> write
>>>>>>               * mode; but shmem or file collapse to THP could still
>>>>>> morph
>>>>>>               * it into a huge pmd: just retry later if so.
>>>>>> +         *
>>>>>> +         * Use the maywrite version to indicate that vmf->pte 
>>>>>> will be
>>>>>> +         * modified, but since we will use pte_same() to detect the
>>>>>> +         * change of the pte entry, there is no need to get pmdval.
>>>>>>               */
>>>>>> -        vmf->pte = pte_offset_map_nolock(vmf->vma->vm_mm, vmf->pmd,
>>>>>> -                         vmf->address, &vmf->ptl);
>>>>>> +        vmf->pte = pte_offset_map_maywrite_nolock(vmf->vma->vm_mm,
>>>>>> +                              vmf->pmd, vmf->address,
>>>>>> +                              NULL, &vmf->ptl);
>>>
>>> I think we discussed that passing NULL should be forbidden for that
>>> function.
>>
>> Yes, but for some maywrite case, there is no need to get pmdval to
>> do pmd_same() check. So I passed NULL and added a comment to
>> explain this.
> 
> I wonder if it's better to pass a dummy variable instead. One has to 
> think harder why that is required compared to blindly passing "NULL" :)

You are afraid that subsequent caller will abuse this function, right?
My initial concern was that this would add a useless local vaiable, but
perhaps that is not a big deal.

Both are fine for me. ;)

> 

