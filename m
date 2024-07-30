Return-Path: <linux-kernel+bounces-267766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FC6941538
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A6EEB25B1A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7987D1A38C1;
	Tue, 30 Jul 2024 15:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jARDfFkA"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32CF19F460;
	Tue, 30 Jul 2024 15:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722352452; cv=none; b=apx4wgGdbE+LU2qxANgJ9lvFOUq8XgJU9CIGyjuL212wrCycIqU5K5OltsRG4OUPQFKKZ3qRpUGjnTXw1rH88n9AQQNMK9K6GKTVSmsWVRGSHPGePzbyVfTiSwwu2gXB/3jnb0ExeXkievG57w4AdkHQ619zTLD0aCNDtz6jcGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722352452; c=relaxed/simple;
	bh=G7olTp+JVH0komHzy6yisCwS5gsRYI99eQm8NvwiO4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s0Hs3gk1dsbgGiYOU6Mh/biYQ3ha4NR++ytYC4KHsObCl8e353ourT3gMal0n8GAFgljlo17WjoCGj2vN40XYL8uuiOqxD+wxS1MFqshmfxjLAPIk0XFEDGY6jZFZtF2bEguXrxPebGVY+rTueK65ruXrxkH4WTnLCa7uADYM9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jARDfFkA; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f035ae1083so62237221fa.3;
        Tue, 30 Jul 2024 08:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722352448; x=1722957248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Di2/8YssPRfers/vmrU3+BsD5CicPCCbwFzOYDiAck=;
        b=jARDfFkAr9/RniYuCKZ7I3jaK51qtud052PVWaUG1/lAitBlEHmdmAGePggXYWGifs
         ba+AGPAGJXxFQJo9evoEYC3op6bqN6YnLj2z5sJ2vL73cimzY4+5cLTb1ZC2Lf38d/d6
         1hCXJu5oU2Qcu9s0aUv0fBYoeUYEpjU2OMV90IRa593vqaAWZg0i5AX7ovtkF6LEx9+3
         kjtyZyDDHp6GlJVXkAFzCcGN3cIAO3mrQPHWQDC3DndDwJdBGyTYZqheQq3g4g96Ke2d
         ENZOlpZv59Q3RTbOwwJinny86mMukzK2jfoF0uG4BOpKGl/Irt/uoWYzxqJ1irg2SEnv
         dtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722352448; x=1722957248;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Di2/8YssPRfers/vmrU3+BsD5CicPCCbwFzOYDiAck=;
        b=G7mGkfXGFVSg8YXPs02ommekr+DwpVwyP/cShz1ZTA+Bb+z1MIPBYeAl9KfvlB7VWF
         MlZLNn2Dd1y7DE0QxAoSjhP1ItQ0E05SXXTket30v1fuzMMqQg5wn88T12mqe38G4Lhu
         1JETK0QWMR9FOeTc4h4sz1GTnOqphWxUIQDaPIy7UhgDK1U1yCeP6FvgpohyIzO5sTRb
         v/6U6sIELYDYls9KdbAPQZ7T8LX3rhm2z+1hz5k5ErMPIRldVzaFmYE0+Bh3yJ9GPZ/W
         Lz0frxFJC4q9snVgcMSpvCsrlouF52lATOsMSVvmz9ughu+ukr6icwX9NQzsocorin9V
         8V5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXSXeN4hXuLL3D5Gy6yC/x7YXkUi4+59C1h+VpDA82k32eLyLDv4F/OgCZTv61ej5nW7035JcL4KxzuW6YtAIJ8VB9ciKllrVUDpP4tQmMNu/TiBIz6o7YKQ7JtuOo28PuWDdsTj7j5
X-Gm-Message-State: AOJu0YzIcgAziGpEBp4cpvcgtaAY7px7xIPhXiLwUHC0UoQ/768aO2sF
	9waXyhpC6N0KawCVLY4z/HeSxInbyomsRFaGO/l9eVzcwbztiIYj
X-Google-Smtp-Source: AGHT+IE/Lt8axMzl77LE+H3Ini9UrgGDIsDI6nB4O+v5YpjSHw23iRYXLlWkI8h6dhjDCu1jBAI5LQ==
X-Received: by 2002:a2e:330e:0:b0:2ef:2472:300a with SMTP id 38308e7fff4ca-2f12edfc2a1mr73952151fa.2.1722352447300;
        Tue, 30 Jul 2024 08:14:07 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::4:6947])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63590e7esm7306190a12.36.2024.07.30.08.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 08:14:07 -0700 (PDT)
Message-ID: <3cd1b07d-7b02-4d37-918a-5759b23291fb@gmail.com>
Date: Tue, 30 Jul 2024 16:14:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] mm: split underutilized THPs
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev,
 roman.gushchin@linux.dev, yuzhao@google.com, baohua@kernel.org,
 ryan.roberts@arm.com, rppt@kernel.org, willy@infradead.org,
 cerasuolodomenico@gmail.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20240730125346.1580150-1-usamaarif642@gmail.com>
 <dc00a32f-e4aa-4f48-b82a-176c9f615f3e@redhat.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <dc00a32f-e4aa-4f48-b82a-176c9f615f3e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 30/07/2024 15:35, David Hildenbrand wrote:
> On 30.07.24 14:45, Usama Arif wrote:
>> The current upstream default policy for THP is always. However, Meta
>> uses madvise in production as the current THP=always policy vastly
>> overprovisions THPs in sparsely accessed memory areas, resulting in
>> excessive memory pressure and premature OOM killing.
>> Using madvise + relying on khugepaged has certain drawbacks over
>> THP=always. Using madvise hints mean THPs aren't "transparent" and
>> require userspace changes. Waiting for khugepaged to scan memory and
>> collapse pages into THP can be slow and unpredictable in terms of performance
>> (i.e. you dont know when the collapse will happen), while production
>> environments require predictable performance. If there is enough memory
>> available, its better for both performance and predictability to have
>> a THP from fault time, i.e. THP=always rather than wait for khugepaged
>> to collapse it, and deal with sparsely populated THPs when the system is
>> running out of memory.
>>
>> This patch-series is an attempt to mitigate the issue of running out of
>> memory when THP is always enabled. During runtime whenever a THP is being
>> faulted in or collapsed by khugepaged, the THP is added to a list.
>> Whenever memory reclaim happens, the kernel runs the deferred_split
>> shrinker which goes through the list and checks if the THP was underutilized,
>> i.e. how many of the base 4K pages of the entire THP were zero-filled.
>> If this number goes above a certain threshold, the shrinker will attempt
>> to split that THP. Then at remap time, the pages that were zero-filled are
>> not remapped, hence saving memory. This method avoids the downside of
>> wasting memory in areas where THP is sparsely filled when THP is always
>> enabled, while still providing the upside THPs like reduced TLB misses without
>> having to use madvise.
>>
>> Meta production workloads that were CPU bound (>99% CPU utilzation) were
>> tested with THP shrinker. The results after 2 hours are as follows:
>>
>>                              | THP=madvise |  THP=always   | THP=always
>>                              |             |               | + shrinker series
>>                              |             |               | + max_ptes_none=409
>> -----------------------------------------------------------------------------
>> Performance improvement     |      -      |    +1.8%      |     +1.7%
>> (over THP=madvise)          |             |               |
>> -----------------------------------------------------------------------------
>> Memory usage                |    54.6G    | 58.8G (+7.7%) |   55.9G (+2.4%)
>> -----------------------------------------------------------------------------
>> max_ptes_none=409 means that any THP that has more than 409 out of 512
>> (80%) zero filled filled pages will be split.
>>
>> To test out the patches, the below commands without the shrinker will
>> invoke OOM killer immediately and kill stress, but will not fail with
>> the shrinker:
>>
>> echo 450 > /sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none
>> mkdir /sys/fs/cgroup/test
>> echo $$ > /sys/fs/cgroup/test/cgroup.procs
>> echo 20M > /sys/fs/cgroup/test/memory.max
>> echo 0 > /sys/fs/cgroup/test/memory.swap.max
>> # allocate twice memory.max for each stress worker and touch 40/512 of
>> # each THP, i.e. vm-stride 50K.
>> # With the shrinker, max_ptes_none of 470 and below won't invoke OOM
>> # killer.
>> # Without the shrinker, OOM killer is invoked immediately irrespective
>> # of max_ptes_none value and kill stress.
>> stress --vm 1 --vm-bytes 40M --vm-stride 50K
>>
>> Patches 1-2 add back helper functions that were previously removed
>> to operate on page lists (needed by patch 3).
>> Patch 3 is an optimization to free zapped tail pages rather than
>> waiting for page reclaim or migration.
>> Patch 4 is a prerequisite for THP shrinker to not remap zero-filled
>> subpages when splitting THP.
>> Patches 6 adds support for THP shrinker.
>>
>> (This patch-series restarts the work on having a THP shrinker in kernel
>> originally done in
>> https://lore.kernel.org/all/cover.1667454613.git.alexlzhu@fb.com/.
>> The THP shrinker in this series is significantly different than the
>> original one, hence its labelled v1 (although the prerequisite to not
>> remap clean subpages is the same).)
> 
> As shared previously, there is one issue with uffd (even when currently not active for a VMA!), where we must not zap present page table entries.
> 
> Something that is always possible (assuming no GUP pins of course, which) is replacing the zero-filled subpages by shared zeropages.
> 
> Is that being done in this patch set already, or are we creating pte_none() entries?
> 

I think thats done in Patch 4/6. In function try_to_unmap_unused, we have below which I think does what you are suggesting? i.e. point to shared zeropage and not clear pte for uffd armed vma.

	if (userfaultfd_armed(pvmw->vma)) {
		newpte = pte_mkspecial(pfn_pte(page_to_pfn(ZERO_PAGE(pvmw->address)),
					       pvmw->vma->vm_page_prot));
		ptep_clear_flush(pvmw->vma, pvmw->address, pvmw->pte);
		set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, newpte);
	}

