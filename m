Return-Path: <linux-kernel+bounces-267778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0137594155D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82DD81F24611
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66C91A3BBD;
	Tue, 30 Jul 2024 15:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCF4N//f"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7A21A38D7;
	Tue, 30 Jul 2024 15:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722352782; cv=none; b=tKjykerXMeB8jqZMueIIAowoDVM+1ikxbjKNn3Lmtav32BLUdbMdLUyT4Z3PhQOQr+N2gmzI6RE6+TH/Vv8pksSFXxlmU3z3Zxz6kKuZ++WbGPOyQ4u9F1AX8JXg3oV1i9vMV81gOKLlSxx1Bqrkd90AhPS4mvw8XY4rfz8AOdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722352782; c=relaxed/simple;
	bh=w1/u0Z0jOAKJI7sre8Y0r/w7YTvezznWjJcNoSAdlQ0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sJctmJIjgD+kVz4Cu3qBDMkuET9FWeKud+xiHvFw5JuLskF6OdvNc8XcVEN8j8oNhmYKp4yj1DbnwV9+hcfxmUJ7Kw3UWadeeRMJAtXiabVWM3dvzON5UuJJZTrfKjP5F0DyexHIaLFWqH8gwdJJYXlEo5qxek/4fEu2wv5dqDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCF4N//f; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7a81bd549eso442431866b.3;
        Tue, 30 Jul 2024 08:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722352779; x=1722957579; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eHB8wsNtQM0jQmp43r431yPVklm/f1PUXfgTnNmnzKA=;
        b=QCF4N//f9VRDCV2Mc772mrPgLmqCqSp1wiUhIzWBRrg+naH4ESnuv5Hkzu2wD2/sd+
         5aZiC4vlxjBCbxkOHSJU5rZUThovR1lBPzoRtZywz4msee0f8s9ITWRfxomhw7kF4Lq2
         0N4bT0BTzpWTIEtxjKkCR9Tj6sPLvFh8+aVpGFUgb0U4Mx2j/8z35J3lQzD36IuiAnB3
         ghlf4zzuIkQZUxPV7HTfSzyUpjnyPLrcw790ske/JTJ6Zx/lflxzbA2I9blW7xlf3qgm
         wMvf1Lys3qn3SKzSO1oWc4lDMbZQSLOTLAEzDd/aOPRbGkxf3qv9NGSZ9xEqzs4qBJIn
         hwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722352779; x=1722957579;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eHB8wsNtQM0jQmp43r431yPVklm/f1PUXfgTnNmnzKA=;
        b=ukOyAQw6tXTmYID11H39X8dx21GdsSP73M5FX3UeASdjLFi9Jz3OWfDWQMMjhH2ORe
         dYlqXP4tscbqsKKZYM5uUsM4tHijfIxDWFwLo+KPIQhHFzDvWG1W/tgiojLvw5yEtZQh
         87y5gytK2KP6XMWSF/yKHEimdLcqsm/M+tFdQQfCp+8hOcDBpCewpDPvvkw5uxk9zIPZ
         kadiLcRUURsuf005mgxXA98MQtJwKs1zGJ5gcaIlFipW3VF/FfDOfYpAl0QPMaAnB9A1
         bZfpsl1zApkrJkYoqEt0gtnIVA5SV4EEix4EKo6TefDrfWybP2NnzY7JqYBn/dvbEYNs
         WcOg==
X-Forwarded-Encrypted: i=1; AJvYcCXEtXsLU2r7LKhfp2pM/Lh41qO6VCPbSMc4xTy3s8Rq40QNFeameO2ePja+YtTAGIiESzyRaq3PhpvQR/ooCrJ+YQjnVoKMODlQJLs8KzbMOoaDJgEMZmBtZX1OFUXIpzksNqPvOrQH
X-Gm-Message-State: AOJu0YwxdJDvUX5bFdL6/fS+1c6GxuF++FBo8bFY+GCA5ho0f2376oQm
	UdXN6qnUoCx7S/nwnWe9BBv2qd3I5XvEaFQaAwYpzruFkgWTJfNm
X-Google-Smtp-Source: AGHT+IGs11AYO4xwAn5557+PuXhwriowqcH1vobWUOSOVDyy55bquyq/3Qmck1ti02y41QEfv9gl7Q==
X-Received: by 2002:a17:907:7209:b0:a77:c84b:5a60 with SMTP id a640c23a62f3a-a7d4005a6b7mr865847166b.26.1722352778866;
        Tue, 30 Jul 2024 08:19:38 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::4:6947])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab22ff1sm655739566b.35.2024.07.30.08.19.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 08:19:38 -0700 (PDT)
Message-ID: <73b97a03-3742-472f-9a36-26ba9009d715@gmail.com>
Date: Tue, 30 Jul 2024 16:19:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] mm: split underutilized THPs
From: Usama Arif <usamaarif642@gmail.com>
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev,
 roman.gushchin@linux.dev, yuzhao@google.com, baohua@kernel.org,
 ryan.roberts@arm.com, rppt@kernel.org, willy@infradead.org,
 cerasuolodomenico@gmail.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20240730125346.1580150-1-usamaarif642@gmail.com>
 <dc00a32f-e4aa-4f48-b82a-176c9f615f3e@redhat.com>
 <3cd1b07d-7b02-4d37-918a-5759b23291fb@gmail.com>
Content-Language: en-US
In-Reply-To: <3cd1b07d-7b02-4d37-918a-5759b23291fb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 30/07/2024 16:14, Usama Arif wrote:
> 
> 
> On 30/07/2024 15:35, David Hildenbrand wrote:
>> On 30.07.24 14:45, Usama Arif wrote:
>>> The current upstream default policy for THP is always. However, Meta
>>> uses madvise in production as the current THP=always policy vastly
>>> overprovisions THPs in sparsely accessed memory areas, resulting in
>>> excessive memory pressure and premature OOM killing.
>>> Using madvise + relying on khugepaged has certain drawbacks over
>>> THP=always. Using madvise hints mean THPs aren't "transparent" and
>>> require userspace changes. Waiting for khugepaged to scan memory and
>>> collapse pages into THP can be slow and unpredictable in terms of performance
>>> (i.e. you dont know when the collapse will happen), while production
>>> environments require predictable performance. If there is enough memory
>>> available, its better for both performance and predictability to have
>>> a THP from fault time, i.e. THP=always rather than wait for khugepaged
>>> to collapse it, and deal with sparsely populated THPs when the system is
>>> running out of memory.
>>>
>>> This patch-series is an attempt to mitigate the issue of running out of
>>> memory when THP is always enabled. During runtime whenever a THP is being
>>> faulted in or collapsed by khugepaged, the THP is added to a list.
>>> Whenever memory reclaim happens, the kernel runs the deferred_split
>>> shrinker which goes through the list and checks if the THP was underutilized,
>>> i.e. how many of the base 4K pages of the entire THP were zero-filled.
>>> If this number goes above a certain threshold, the shrinker will attempt
>>> to split that THP. Then at remap time, the pages that were zero-filled are
>>> not remapped, hence saving memory. This method avoids the downside of
>>> wasting memory in areas where THP is sparsely filled when THP is always
>>> enabled, while still providing the upside THPs like reduced TLB misses without
>>> having to use madvise.
>>>
>>> Meta production workloads that were CPU bound (>99% CPU utilzation) were
>>> tested with THP shrinker. The results after 2 hours are as follows:
>>>
>>>                              | THP=madvise |  THP=always   | THP=always
>>>                              |             |               | + shrinker series
>>>                              |             |               | + max_ptes_none=409
>>> -----------------------------------------------------------------------------
>>> Performance improvement     |      -      |    +1.8%      |     +1.7%
>>> (over THP=madvise)          |             |               |
>>> -----------------------------------------------------------------------------
>>> Memory usage                |    54.6G    | 58.8G (+7.7%) |   55.9G (+2.4%)
>>> -----------------------------------------------------------------------------
>>> max_ptes_none=409 means that any THP that has more than 409 out of 512
>>> (80%) zero filled filled pages will be split.
>>>
>>> To test out the patches, the below commands without the shrinker will
>>> invoke OOM killer immediately and kill stress, but will not fail with
>>> the shrinker:
>>>
>>> echo 450 > /sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none
>>> mkdir /sys/fs/cgroup/test
>>> echo $$ > /sys/fs/cgroup/test/cgroup.procs
>>> echo 20M > /sys/fs/cgroup/test/memory.max
>>> echo 0 > /sys/fs/cgroup/test/memory.swap.max
>>> # allocate twice memory.max for each stress worker and touch 40/512 of
>>> # each THP, i.e. vm-stride 50K.
>>> # With the shrinker, max_ptes_none of 470 and below won't invoke OOM
>>> # killer.
>>> # Without the shrinker, OOM killer is invoked immediately irrespective
>>> # of max_ptes_none value and kill stress.
>>> stress --vm 1 --vm-bytes 40M --vm-stride 50K
>>>
>>> Patches 1-2 add back helper functions that were previously removed
>>> to operate on page lists (needed by patch 3).
>>> Patch 3 is an optimization to free zapped tail pages rather than
>>> waiting for page reclaim or migration.
>>> Patch 4 is a prerequisite for THP shrinker to not remap zero-filled
>>> subpages when splitting THP.
>>> Patches 6 adds support for THP shrinker.
>>>
>>> (This patch-series restarts the work on having a THP shrinker in kernel
>>> originally done in
>>> https://lore.kernel.org/all/cover.1667454613.git.alexlzhu@fb.com/.
>>> The THP shrinker in this series is significantly different than the
>>> original one, hence its labelled v1 (although the prerequisite to not
>>> remap clean subpages is the same).)
>>
>> As shared previously, there is one issue with uffd (even when currently not active for a VMA!), where we must not zap present page table entries.
>>
>> Something that is always possible (assuming no GUP pins of course, which) is replacing the zero-filled subpages by shared zeropages.
>>
>> Is that being done in this patch set already, or are we creating pte_none() entries?
>>
> 
> I think thats done in Patch 4/6. In function try_to_unmap_unused, we have below which I think does what you are suggesting? i.e. point to shared zeropage and not clear pte for uffd armed vma.
> 
> 	if (userfaultfd_armed(pvmw->vma)) {
> 		newpte = pte_mkspecial(pfn_pte(page_to_pfn(ZERO_PAGE(pvmw->address)),
> 					       pvmw->vma->vm_page_prot));
> 		ptep_clear_flush(pvmw->vma, pvmw->address, pvmw->pte);
> 		set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, newpte);
> 	}


Ah are you suggesting userfaultfd_armed(pvmw->vma) will evaluate to false even if its uffd? I think something like below would work in that case.

diff --git a/mm/migrate.c b/mm/migrate.c
index 2731ac20ff33..52aa4770fbed 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -206,14 +206,10 @@ static bool try_to_unmap_unused(struct page_vma_mapped_walk *pvmw,
        if (dirty)
                return false;
 
-       pte_clear_not_present_full(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, false);
-
-       if (userfaultfd_armed(pvmw->vma)) {
-               newpte = pte_mkspecial(pfn_pte(page_to_pfn(ZERO_PAGE(pvmw->address)),
-                                              pvmw->vma->vm_page_prot));
-               ptep_clear_flush(pvmw->vma, pvmw->address, pvmw->pte);
-               set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, newpte);
-       }
+       newpte = pte_mkspecial(pfn_pte(page_to_pfn(ZERO_PAGE(pvmw->address)),
+                                       pvmw->vma->vm_page_prot));
+       ptep_clear_flush(pvmw->vma, pvmw->address, pvmw->pte);
+       set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, newpte);
 
        dec_mm_counter(pvmw->vma->vm_mm, mm_counter(folio));
        return true;


