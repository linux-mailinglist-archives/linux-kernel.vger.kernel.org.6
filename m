Return-Path: <linux-kernel+bounces-295250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4961D959909
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8861F237EE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D951FA76A;
	Wed, 21 Aug 2024 09:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYc4Welv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74DD1FA763
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 09:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233326; cv=none; b=hdnh7tTUrUpLcEQemjmMyYSmLjD6GBJ3lifqkO2I3t6/8eCJeuF/pW3Bc+UZBdCPpRUu1wgUnZ+aVhPfHgS6HtGhDV/OyMvA/IzLFaPC1+kxtVPSEIcphUzqJGKV3Agohm6d5C0IOtP/b291e9lQlhjVdihjo44QmMxWSoDSlQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233326; c=relaxed/simple;
	bh=x6w69FOfN0JDJ9r41oVIBmQJZeB5SIDcfQlLkOsTjbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XbKu9+1ifGlmuUtvfQSipgjjQlIzUKWgthtkLeuxK1elXQ/Hw1wpP5V44BsiOzInaw/+fi9DjesNsWsE6Lm4z+/yGExmRiuCJpJUK7jPBjHBYUmxn9WUd+LKY6v7MGkfxDcBClCsCoC8XpVUCN+xOf3o0abfack/pwZ13L/w78I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JYc4Welv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724233323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZbsVHgO39wK2YFFRzsnUaNf+VhwFz28zLa/5pXOkFvM=;
	b=JYc4WelvxJEyZpbflA563gT3tT1PTkde1FnCow1Iy9ZYxHxCs0THWIpqZ362DI584MExHv
	yjAB0CALRMW2vk7uWWeO9ywJPETq2mQ4HkQP8gbaxEBxyr6HwdL8ODeYPNklEDMVv0E0Et
	unF9RwdrQYk/MgZ/DlvCSlgAK0ESrOw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-Yjo5ObswNcS5onoPeHW3Tg-1; Wed, 21 Aug 2024 05:42:01 -0400
X-MC-Unique: Yjo5ObswNcS5onoPeHW3Tg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4280c0b3017so56094095e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 02:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724233320; x=1724838120;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZbsVHgO39wK2YFFRzsnUaNf+VhwFz28zLa/5pXOkFvM=;
        b=tbn2pQeXCdkaHC6qtFZN7GuhjiNB6n49IIOKkz29LmCwloIeEhyY2alBy5phkTevrV
         wjZudTPI2A0tHyr7mDyNmtE18OHqD50qf9/j7oD7kv7Qcb16tepoauo5ob1NTqLx+GVb
         TvRgYn9Q4oz5FhIMY8rgui14V6lvlRISqzBmC44BlPnWO82z8o9thbKa/mtUoCtb19uc
         K+cyxVjeDAZDEjxtjjoaeEC17G4Ge/AyvxWsoPqqF5EdSLS7uy3Xg2EKq76+fNY788qn
         Iiz8ZeBi/Dgd2TYdlJf8hD6CM/FZOwpOPR9iWERA5qn/M6+CTY9tWiLGvEbXJWa9AZUt
         77qw==
X-Forwarded-Encrypted: i=1; AJvYcCV3SdBfhARczB5GypnDNHkTVLXXbWn2fae/v+ncnnv3RX+vWGFGE3keefMEZpBi25OXiTf05UgILhf7jYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWOYjL7ogLP51FxzeReAdQ7yqt4bbpGvBC5kD6Fv2D2dshnNUN
	xGqH3pnm/zkqvu5CiHuoxSFaeIojHPyVN2LW27cBOmsl2+Jk/pjgUsHq8DtjXTazYsl7EiCFBWb
	o340Fzp1Kqa/hKKdyZMcYKZdgst21CYdrg1M8cSQhBDCWVcL3XH1qlhqbPsr4Ew==
X-Received: by 2002:a05:600c:4f16:b0:426:627e:37af with SMTP id 5b1f17b1804b1-42abd111fa6mr13200735e9.3.1724233320410;
        Wed, 21 Aug 2024 02:42:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+J/R+dRqKSLP4LEuzopvwm1A0w8OV/3YEoYoiuxHeCmipgshfH6pdw8qb77/tYGODfu/XIw==
X-Received: by 2002:a05:600c:4f16:b0:426:627e:37af with SMTP id 5b1f17b1804b1-42abd111fa6mr13200405e9.3.1724233319564;
        Wed, 21 Aug 2024 02:41:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:4300:16d5:c5b:8388:a734? (p200300cbc705430016d50c5b8388a734.dip0.t-ipconnect.de. [2003:cb:c705:4300:16d5:c5b:8388:a734])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189897008sm15168268f8f.84.2024.08.21.02.41.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 02:41:59 -0700 (PDT)
Message-ID: <4b867535-8481-4fa1-bed1-ad25a76682f0@redhat.com>
Date: Wed, 21 Aug 2024 11:41:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] mm: handle_pte_fault() use
 pte_offset_map_maywrite_nolock()
To: Qi Zheng <zhengqi.arch@bytedance.com>,
 LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
Cc: "hughd@google.com" <hughd@google.com>,
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <b4bf605a-d31a-40ad-8cee-fe505e45dc64@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21.08.24 11:24, Qi Zheng wrote:
> 
> 
> On 2024/8/21 17:17, LEROY Christophe wrote:
>>
>>
>> Le 21/08/2024 à 10:18, Qi Zheng a écrit :
>>> In handle_pte_fault(), we may modify the vmf->pte after acquiring the
>>> vmf->ptl, so convert it to using pte_offset_map_maywrite_nolock(). But
>>> since we already do the pte_same() check, so there is no need to get
>>> pmdval to do pmd_same() check, just pass NULL to pmdvalp parameter.
>>>
>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>> ---
>>>     mm/memory.c | 9 +++++++--
>>>     1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 93c0c25433d02..d3378e98faf13 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -5504,9 +5504,14 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
>>>     		 * pmd by anon khugepaged, since that takes mmap_lock in write
>>>     		 * mode; but shmem or file collapse to THP could still morph
>>>     		 * it into a huge pmd: just retry later if so.
>>> +		 *
>>> +		 * Use the maywrite version to indicate that vmf->pte will be
>>> +		 * modified, but since we will use pte_same() to detect the
>>> +		 * change of the pte entry, there is no need to get pmdval.
>>>     		 */
>>> -		vmf->pte = pte_offset_map_nolock(vmf->vma->vm_mm, vmf->pmd,
>>> -						 vmf->address, &vmf->ptl);
>>> +		vmf->pte = pte_offset_map_maywrite_nolock(vmf->vma->vm_mm,
>>> +							  vmf->pmd, vmf->address,
>>> +							  NULL, &vmf->ptl);

I think we discussed that passing NULL should be forbidden for that 
function.

>>
>> This might be the demonstration that the function name is becoming too long.
>>
>> Can you find shorter names ?
> 
> Maybe use abbreviations?
> 
> pte_offset_map_ro_nolock()
> pte_offset_map_rw_nolock()

At least the "ro" is better, but "rw" does not express the "maywrite" -- 
because without taking the lock we are not allowed to write. But maybe 
"rw" is good enough for that if we document it properly.

And you can use up to 100 characters, if it helps readability.

-- 
Cheers,

David / dhildenb


