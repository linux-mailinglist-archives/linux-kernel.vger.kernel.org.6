Return-Path: <linux-kernel+bounces-295286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D3E959953
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B61351C21289
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EABE1CE6EA;
	Wed, 21 Aug 2024 09:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jsHiom2a"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08341CE6E3
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233893; cv=none; b=m+rfZsdK1q0xWIjBtN9WecZYJRcoHzh/+8uV8bY8JpaxjzJQE83duG4Sh+Ym7WzSNT/3jDaCKrygXXC9L809V0X4hx28kxTtrUoFZgza7qr4zRcvrjh9yhIytQki+VfGFbZSK2q0QO1s2+ldZ88Lo7Tk2HRTsbxNUShoTa0CWpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233893; c=relaxed/simple;
	bh=V0U2GEi4A8/FDq1UDPKeMvOAQxCi0vOENx3x79wwGOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a+6RfAgR3oHZ6vM0RQV78wSozDdY/4TVVgAZsYh/u4xAatVl/Rquz4H2jBKidU0rKvLL0oLEvVW4uPpKVbiAXX2AFEVQNXjWWjyXVC5zr4UsnIKRAa1PArU6xry+12jVdL1EqlsTRlq21qlicGfE/bUfnnwYQhNsLM3g7caxwB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jsHiom2a; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d439572aeaso428814a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 02:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724233890; x=1724838690; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QrfsoI7+/y7gPIc6zH2vT6eGjRus/vFY8lyFc42bTUs=;
        b=jsHiom2aYDn5NbjX/MflO3IsU3TVg6QKCHkI2gH14LB+RMKm/LrzsvaW7/7oo7siWv
         vsSom/5OfN9QBO6sI75v3vlRrHRu3cOFJQykBH8BJRNkst3pz4p5KFmcUmAeW6O2KGvs
         B4Xa1Hj4+cAJIhWHP4Ba9TXgo0KdkE06RahQ2ZUMKbxq7kZ5UKnbboTxla6IHhGb98cg
         BQX+q8LFgmw/sVx8rCOTVsnxV5z+pZllIB0tUYiO95Zb2W7VHg2o/Ikjq/p8shtiZecd
         U7YpAvqxZAsttvC4LgOj0S9d2OZP+EPz2lGeTeOejMGAFifdRhZ2z49MBwZdgvvJND8/
         FnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724233890; x=1724838690;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QrfsoI7+/y7gPIc6zH2vT6eGjRus/vFY8lyFc42bTUs=;
        b=SYQEhZgHHte4++495AgzY7qju9HC4bf7PprWU50DilrkcfBI46eowyWZBO5XMxcZcB
         55B+yfG1QiSdXjmpBJbWPVF+aQyk1fFqw6mdAaHK3LIfHFkZmc8wjP75vEtaZYrVNmP8
         b2hWtLnKwSVqHdRZn+d2uS75qgRtBBvEIWYiOIzJ+l8/2cIJMSgYXwkWWwueIY1eQYpJ
         xsQ4CJj92glefI3bCfSB9Ajx2NZ+MQwiDhrz+fsQEzW/K6cSu2+uY6dKo2N+O+4/m0gP
         QSMZXidvh+o/p9jujtQX4CKDyWV+jY1n0Yaxb67nOJst7tnX4Rfi9E0bp66tcGqkTEcg
         XwAw==
X-Forwarded-Encrypted: i=1; AJvYcCUqovsh0RvnTUi8nreBuKoUwX7E1xxbTkSJrGXuIrr/y2zNBA/dGFrALIFL/VNaCmROFi++LSZhbOhR/ow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxo2ppwV82VzmEvDP2wPm4O4wKTn6vz2yQkz6BvBnsle+Gf368
	W8z9ST2xg0/PrNfyTzTUyewsFAgTWkqv4r5dHqr1ew8A+U31M7eY75IfwDrCk24=
X-Google-Smtp-Source: AGHT+IH39FxZGyvulFfIBDs9fMR7pRrcFkJNeekEukWGwpJYqyx+HQvEFVfN+uyRXPCwbuMHV6p+iw==
X-Received: by 2002:a17:90a:ca04:b0:2cb:56bd:5d7 with SMTP id 98e67ed59e1d1-2d5e995be3emr3063558a91.5.1724233890327;
        Wed, 21 Aug 2024 02:51:30 -0700 (PDT)
Received: from [10.84.144.49] ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5ebbb0b27sm1297201a91.45.2024.08.21.02.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 02:51:29 -0700 (PDT)
Message-ID: <ef40c2ef-e4a4-4b02-85b8-a930285a3d0e@bytedance.com>
Date: Wed, 21 Aug 2024 17:51:21 +0800
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
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <4b867535-8481-4fa1-bed1-ad25a76682f0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/8/21 17:41, David Hildenbrand wrote:
> On 21.08.24 11:24, Qi Zheng wrote:
>>
>>
>> On 2024/8/21 17:17, LEROY Christophe wrote:
>>>
>>>
>>> Le 21/08/2024 à 10:18, Qi Zheng a écrit :
>>>> In handle_pte_fault(), we may modify the vmf->pte after acquiring the
>>>> vmf->ptl, so convert it to using pte_offset_map_maywrite_nolock(). But
>>>> since we already do the pte_same() check, so there is no need to get
>>>> pmdval to do pmd_same() check, just pass NULL to pmdvalp parameter.
>>>>
>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>> ---
>>>>     mm/memory.c | 9 +++++++--
>>>>     1 file changed, 7 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>> index 93c0c25433d02..d3378e98faf13 100644
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>> @@ -5504,9 +5504,14 @@ static vm_fault_t handle_pte_fault(struct 
>>>> vm_fault *vmf)
>>>>              * pmd by anon khugepaged, since that takes mmap_lock in 
>>>> write
>>>>              * mode; but shmem or file collapse to THP could still 
>>>> morph
>>>>              * it into a huge pmd: just retry later if so.
>>>> +         *
>>>> +         * Use the maywrite version to indicate that vmf->pte will be
>>>> +         * modified, but since we will use pte_same() to detect the
>>>> +         * change of the pte entry, there is no need to get pmdval.
>>>>              */
>>>> -        vmf->pte = pte_offset_map_nolock(vmf->vma->vm_mm, vmf->pmd,
>>>> -                         vmf->address, &vmf->ptl);
>>>> +        vmf->pte = pte_offset_map_maywrite_nolock(vmf->vma->vm_mm,
>>>> +                              vmf->pmd, vmf->address,
>>>> +                              NULL, &vmf->ptl);
> 
> I think we discussed that passing NULL should be forbidden for that 
> function.

Yes, but for some maywrite case, there is no need to get pmdval to
do pmd_same() check. So I passed NULL and added a comment to
explain this.

> 
>>>
>>> This might be the demonstration that the function name is becoming 
>>> too long.
>>>
>>> Can you find shorter names ?
>>
>> Maybe use abbreviations?
>>
>> pte_offset_map_ro_nolock()
>> pte_offset_map_rw_nolock()
> 
> At least the "ro" is better, but "rw" does not express the "maywrite" -- 
> because without taking the lock we are not allowed to write. But maybe 
> "rw" is good enough for that if we document it properly.

OK, will change to it in the next version.

> 
> And you can use up to 100 characters, if it helps readability

Got it.

> 

