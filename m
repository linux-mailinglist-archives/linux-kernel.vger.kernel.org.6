Return-Path: <linux-kernel+bounces-302586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F1696008F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 161A7283618
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 04:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0BB74413;
	Tue, 27 Aug 2024 04:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lhTUL/jJ"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B110F84D3E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 04:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724734429; cv=none; b=Zs0Dsjj4fwSG2c3eRYU4PofD80jiXRuoLU3xXhStjnbB66YV2joWdeWb3Gytmn6QVs7+fyiqHdwe9Macob73+n0QIf9Gz7Mst3cgjAa7rlvZrr/VD8tMxKjOePo0q3adzgZdjY/M0xz8KnNfc9EM7O7i0gHVfVLUpknYH06KB/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724734429; c=relaxed/simple;
	bh=HCagZvCrZHaytv1NYUg2rh9lg4ucZ87nY3vNvdjVMgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZFmvghhwFCBJKzXetzKPPtlE+qckjwtYWB23Oz6wwwFkMadHizdJKD0dbASGk6qzBoWpxyifwlLlXFXrq0UY4HKRALhowCJc3J9linyJwE5m+PBImj1fZC0ss13N9oAkYhmUXFfo1FcxveNMglIiuhtfQ58KPjURxYeqv0U6bFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lhTUL/jJ; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso4901560276.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 21:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724734426; x=1725339226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gL0CtwyQELiqJJaIVlxrXuLFauzAqYM0sY701FPxABY=;
        b=lhTUL/jJliFshOHKjo7ghfKVJxo06BbeAaV8K2q5jwf1oj6m35q8jycElvhMOUVOVw
         pMcpg2j0UAKK/w8Fm17qVtrHNedTMmHfqMkBaKmCAeZHXkAZzVQSSoAb5/VfyeMxvC0X
         9KRGY9zl20BDj0PRnqN+3YIyao7uLUuT2dP5dynxy3pp08/g4Ghwb9y3hewSNfha6Uq2
         wngqe5oMMAqI6Jgjhljmi0CMAnMQeRGmatX9he6z09xZWqvf+GmlbJmJ+mgEAni77KQL
         XNZax8drbKpQZxtpNJ/F/otKHBC5mMI9aTWsmLlq46HgO3kVu0k4YFCJ3TGJJxWMQYzV
         tUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724734426; x=1725339226;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gL0CtwyQELiqJJaIVlxrXuLFauzAqYM0sY701FPxABY=;
        b=oxbbYkYXscWTnvt9L0F4+DJ16dTqvsCmRc9oz3fQhBaS2HQQZ6ogmXgGCbplp5KOcM
         EIst5NGEOoekzWFVzYC261xHqot4IVRZtWjrI39p9mg7A9Ep0ELeqMv29KsnUY6TNLsr
         mJMqSTCW+L/d2Z4l+YMzmEzRJ1DDtKDDfIE6KHMRtmSJQe+pznKMP0P0v+6LLT0e+Mam
         9cByjyb++U67M7PFDoEez8tPhL7SnbwONwqMY2nJTlU4H/EJMJb3rGwhIlFRDVnpulIl
         GBaq4GcrXI8aEGpyIv8HiIbVkVBliVm8FBCPAGiDqVYQuPjRfJCoKTuHW20ViOknB6dM
         DrYw==
X-Forwarded-Encrypted: i=1; AJvYcCXNswCV2NTVgVq9YilyYQqE/Vzn3MrtLfjLP1Y1rqzYcyybtWJAw+evjyveKl51ejedGW6GZiF8hxJ26lY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBaelP0/glUgsNBUTt7vgugTaWYm3O0wKcZ01hvjnTK/tY0fcn
	qYxWR3RCJ4hEKtcPgCuobyZU9vj+QOeQ9Yu3oh0vLixkDcn6T+TCnRFh1WC2BNTTq3z3qh54Kk6
	F
X-Google-Smtp-Source: AGHT+IHvJKgGgS8F6PA+OGYeR1MSS8jBA76sh6PwAVPa/wEnz55WlDC55HealKCjGZuy9Cax5P2SIA==
X-Received: by 2002:a05:6902:849:b0:e13:e6c1:ce3d with SMTP id 3f1490d57ef6-e1a2a978a80mr2069360276.43.1724734426374;
        Mon, 26 Aug 2024 21:53:46 -0700 (PDT)
Received: from [10.4.59.158] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d21700a48csm359552a12.85.2024.08.26.21.53.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 21:53:46 -0700 (PDT)
Message-ID: <581a7d44-25c6-4498-b11a-9c0029bb9d78@bytedance.com>
Date: Tue, 27 Aug 2024 12:53:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/14] mm: handle_pte_fault() use
 pte_offset_map_rw_nolock()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: hughd@google.com, willy@infradead.org, muchun.song@linux.dev,
 vbabka@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
 vishal.moola@gmail.com, peterx@redhat.com, ryan.roberts@arm.com,
 christophe.leroy2@cs-soprasteria.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
References: <cover.1724310149.git.zhengqi.arch@bytedance.com>
 <5acabedfae7ded01b075960b4a91f2e15b4d76b5.1724310149.git.zhengqi.arch@bytedance.com>
 <ea518cf0-890d-4292-b775-dd3880c85bc6@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <ea518cf0-890d-4292-b775-dd3880c85bc6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/8/26 23:36, David Hildenbrand wrote:
> On 22.08.24 09:13, Qi Zheng wrote:
>> In handle_pte_fault(), we may modify the vmf->pte after acquiring the
>> vmf->ptl, so convert it to using pte_offset_map_rw_nolock(). But since we
>> will do the pte_same() check, so there is no need to get pmdval to do
>> pmd_same() check, just pass a dummy variable to it.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   mm/memory.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 93c0c25433d02..7b6071a0e21e2 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -5499,14 +5499,22 @@ static vm_fault_t handle_pte_fault(struct 
>> vm_fault *vmf)
>>           vmf->pte = NULL;
>>           vmf->flags &= ~FAULT_FLAG_ORIG_PTE_VALID;
>>       } else {
>> +        pmd_t dummy_pmdval;
>> +
>>           /*
>>            * A regular pmd is established and it can't morph into a huge
>>            * pmd by anon khugepaged, since that takes mmap_lock in write
>>            * mode; but shmem or file collapse to THP could still morph
>>            * it into a huge pmd: just retry later if so.
>> +         *
>> +         * Use the maywrite version to indicate that vmf->pte will be
>> +         * modified, but since we will use pte_same() to detect the
>> +         * change of the pte entry, there is no need to get pmdval, so
>> +         * just pass a dummy variable to it.
>>            */
>> -        vmf->pte = pte_offset_map_nolock(vmf->vma->vm_mm, vmf->pmd,
>> -                         vmf->address, &vmf->ptl);
>> +        vmf->pte = pte_offset_map_rw_nolock(vmf->vma->vm_mm, vmf->pmd,
>> +                            vmf->address, &dummy_pmdval,
>> +                            &vmf->ptl);
>>           if (unlikely(!vmf->pte))
>>               return 0;
>>           vmf->orig_pte = ptep_get_lockless(vmf->pte);
> 
> No I understand why we don't need the PMD val in these cases ... the PTE 
> would also be pte_none() at the point the page table is freed, so we 
> would detect the change as well.

Yes.

> 
> I do enjoy documenting why we use a dummy value, though. Likely without 
> that, new users will just pass NULL and call it a day.

OK, how about the following:

Use the maywrite version to indicate that vmf->pte will be
modified, but since we will use pte_same() to detect the
change of the !pte_none() entry, there is no need to recheck
the pmdval. Here we chooes to pass a dummy variable instead
of NULL, which helps new user think about why this place is
special.

> 
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks!

> 

