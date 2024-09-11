Return-Path: <linux-kernel+bounces-324914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EAF97528A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1983F1C2213E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66E2185B4C;
	Wed, 11 Sep 2024 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S+XUqa8S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2045A17C230
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 12:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726058133; cv=none; b=QiHuMUoDA6xpYr0m90PqfLGwYlFa8U6UUbl2KSKqPATL1tfb/zmWa/qf/PWEVeuxYlZKUsRgMdxxfdqLX/5S5hhg4cC1Qygg2A/olBkxWqxW8qN92RtkVLaWPQ79v2c/M+OHEeFOli1OoE9rivMoONsif2qOu7JQEd4mK1AGkjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726058133; c=relaxed/simple;
	bh=m+35+3B27XTVbyKdRw/IB9+7k3xE/FjKeVzeSikw80I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DAc7vvOau/9pIoS/1EMZTfORXMMzuETA5IYAn3bkI6r54WgA9dVSS9HOLn/YUTr8uiciAib/Xk1zZWGHHaiSRhm21DwMAb3ZF7T6RVYsQqJolaw4woJCIw7bRvfJHxGkDF8yPZ6+QC9uB/msEOJ0RIAp6ieSvTpFOQi5v5NXwr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S+XUqa8S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726058131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qr4is0ZYIE9ia9PvZCdwNiQBP5qKQw7ZkcaskQQwbNQ=;
	b=S+XUqa8S6I7IO2m+z9WD9tlieMXEG1HDsZ48olVdI42H6WmHBtrkz6uczdAQvFEMmfzPMr
	DoplJlcLdhh5lHPnHWt0yld0FjmO2B9yj1omLgiuKVexoy4fw5cyjV/FhYXkOe+RSLCFRH
	CG17CFFkHkHrWM5HT9LDr0wzR/j5aXQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-5akqkVPSO-G_sUdkFp1ocQ-1; Wed, 11 Sep 2024 08:35:29 -0400
X-MC-Unique: 5akqkVPSO-G_sUdkFp1ocQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374b69e65e8so821965f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 05:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726058128; x=1726662928;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qr4is0ZYIE9ia9PvZCdwNiQBP5qKQw7ZkcaskQQwbNQ=;
        b=fDkSHog5/vG8NbqXWsnC9PTVre8TFLkAOiRNnH9MW9Ezt6AlXtmeYmgzr4cD967o1t
         XQUcMqhWVsuMFgNMh0lFOWTGm/bNDVOQBkrgEgisqaRpmG1cBOG6eQcdKW5LhYLRcL3z
         1rK0+la1dIfzZloSC9YlmZZUKQuL8QQtUpCj82XRP2M90eMAMvj7oXV/kpU2oIMrUPYE
         wLb9gGLhTKgx/m77u8iL54QlbrrSoIZU67OoEJZhru01nH+0RRsFS66bRQJ4ZUqH++mV
         goRGaIoDc61zWdXPvrnQifumMvnzliVD7gVkTWeW8V8NsgfoFyvH10U0pZr9PlcnW84h
         4Ftg==
X-Forwarded-Encrypted: i=1; AJvYcCXUZx34FHZEQAjSSnLNVsEPvSmIp2AYuBm4ebpvOsvTe+dup4AHPHpYcn4X4zWzzGFDGaTfI+6WfQ8g/14=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk2APJuZqWur1x2jA7RhUV4ZQHRw/rL1RTR2PiO6OkgrHROBLT
	SWfd03gtFzh2ebHKPIvrSW+QxMlEYaJqqVf3HsZp29cn8PIkCQpoyQE2Xjz2ZuQvbSs2bSb2b3e
	YXQZgNjTbhLyRlDosvR43gNulDk7fIwCUT744/AfVx3+JD/PoxS1EAjUo8pO87g==
X-Received: by 2002:a5d:69ca:0:b0:374:c3cd:73ea with SMTP id ffacd0b85a97d-378b07cf82dmr1733944f8f.35.1726058128528;
        Wed, 11 Sep 2024 05:35:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHbfYudpntwvdXRpX2vad1NWjstqk/jE9bThbS70l5qy8Wm46gjmhvxb+Wn/wF9dFy3N6NGw==
X-Received: by 2002:a5d:69ca:0:b0:374:c3cd:73ea with SMTP id ffacd0b85a97d-378b07cf82dmr1733925f8f.35.1726058127934;
        Wed, 11 Sep 2024 05:35:27 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:7e00:c672:608:5b3e:df8c? (p200300cbc7007e00c67206085b3edf8c.dip0.t-ipconnect.de. [2003:cb:c700:7e00:c672:608:5b3e:df8c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789564a2a5sm11446997f8f.17.2024.09.11.05.35.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 05:35:27 -0700 (PDT)
Message-ID: <18271c5b-d190-448a-b513-34c20de1dcd2@redhat.com>
Date: Wed, 11 Sep 2024 14:35:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mm: Abstract THP allocation
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org,
 willy@infradead.org, kirill.shutemov@linux.intel.com
Cc: ryan.roberts@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 jack@suse.cz, mark.rutland@arm.com, hughd@google.com,
 aneesh.kumar@kernel.org, yang@os.amperecomputing.com, peterx@redhat.com,
 ioworker0@gmail.com, jglisse@google.com, wangkefeng.wang@huawei.com,
 ziy@nvidia.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240911065600.1002644-1-dev.jain@arm.com>
 <20240911065600.1002644-2-dev.jain@arm.com>
 <f610e933-278e-4f95-a363-8f023a5e7aa9@redhat.com>
 <552e9b77-c1ea-4a60-8434-e360ca692f1f@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <552e9b77-c1ea-4a60-8434-e360ca692f1f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[...]

>>
>>> +
>>> +static void map_pmd_thp(struct folio *folio, struct vm_fault *vmf,
>>> +            struct vm_area_struct *vma, unsigned long haddr)
>>> +{
>>> +    pmd_t entry;
>>> +
>>> +    entry = mk_huge_pmd(&folio->page, vma->vm_page_prot);
>>> +    entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
>>> +    folio_add_new_anon_rmap(folio, vma, haddr, RMAP_EXCLUSIVE);
>>> +    folio_add_lru_vma(folio, vma);
>>> +    set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
>>> +    update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
>>
>> It's quite weird to see a mixture of haddr and vmf->address, and
>> likely this mixture is wrong or not not required.
>>
>> Looking at arc's update_mmu_cache_pmd() implementation, I cannot see
>> how passing in the unaligned address would do the right thing. But
>> maybe arc also doesn't trigger that code path ... who knows :)
>>
>>
>> Staring at some other update_mmu_cache_pmd() users, it's quite
>> inconsistent. Primarily only do_huge_pmd_numa_page() and
>> __do_huge_pmd_anonymous_page() use the unaligned address. The others
>> seem to use the aligned address ... as one would expect when modifying
>> a PMD.
>>
>>
>> I suggest to change this function to *not* pass in the vmf, and rename
>> it to something like:
>>
>> static void folio_map_anon_pmd(struct folio *folio, struct
>> vm_area_struct *vma, pmd_t *pmd, unsigned long haddr)
>>
>> Then use haddr also to do the update_mmu_cache_pmd().
> 
> The code I changed, already was passing vmf->address to
> update_mmu_cache_pmd().
> I did not change any of the haddr and vmf->address semantics, so really
> can't comment
> on this.

I'm not saying that you changed it. I say, "we touch it we fix it" :). 
We could do that in a separate cleanup patch upfront.

> I agree with the name change; vmf will be required for
> set_pmd_at(vmf->pmd), so I should
> just pass pmd?
>>
>>> +    add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
>>> +    mm_inc_nr_ptes(vma->vm_mm);
>>> +}
>>> +
>>> +static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
>>> +{
>>> +    struct vm_area_struct *vma = vmf->vma;
>>> +    struct folio *folio;
>>> +    pgtable_t pgtable;
>>> +    unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
>>> +    vm_fault_t ret = 0;
>>> +    gfp_t gfp = vma_thp_gfp_mask(vma);
>>
>> Nit: While at it, try to use reverse christmas-tree where possible,
>> makes things more reasible. You could make haddr const.
>>
>> struct vm_area_struct *vma = vmf->vma;
>> unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
>> gfp_t gfp = vma_thp_gfp_mask(vma);
>> struct folio *folio;
>> vm_fault_t ret = 0;
> 
> Okay.
>> ...
>>
>>> +
>>> +    folio = pmd_thp_fault_alloc(gfp, vma, haddr, vmf->address);
>>> +    if (unlikely(!folio)) {
>>> +        ret = VM_FAULT_FALLBACK;
>>> +        goto release;
>>> +    }
>>> +
>>> +    pgtable = pte_alloc_one(vma->vm_mm);
>>> +    if (unlikely(!pgtable)) {
>>> +        ret = VM_FAULT_OOM;
>>> +        goto release;
>>> +    }
>>>          vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
>>> +
>>
>> Nit Unrelated change.
> 
> Are you asking me to align this line with the below line?

No, just pointing out that you add a newline in a code section you don't 
really touch. Sometimes that's deliberate, sometimes not (e.g., going 
back and forth while reworking the code and accidentally leaving that 
in). We try to avoid such unrelated changes because it adds noise to the 
patches.

If it was deliberate, feel free to leave it in.

-- 
Cheers,

David / dhildenb


