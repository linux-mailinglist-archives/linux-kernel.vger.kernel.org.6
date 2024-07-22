Return-Path: <linux-kernel+bounces-258392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 912D9938769
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 03:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A5A21F2134E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 01:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C978BFF;
	Mon, 22 Jul 2024 01:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LFX3B4FB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76AE3232
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 01:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721613077; cv=none; b=bc08QC2B33sdAYCgBCZE5exm8B+siuTAGCcVb7QRYbF7hHsQwNofNpebdhxwQsr0efHp4oTQs+Dl8L7I7JeD3/1XNeBrx1GLS5wQWEMP7v3+7kHTlvDm2Yu7Uq/9LqZjHB0+9hyJaq1nNROVED0l6X6MDexzgQcIto3pBmN/5To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721613077; c=relaxed/simple;
	bh=cAt92c2u4pJpgHPwgKHECJkZLu5EDukZ29rPgn9SoRA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ltbA5Zblfd7VBit19Xz/FnClO24Ycczi2vVwGwMxLGg3+KuG+tCJqBYJtZtsTi1ZjmPQHJ/ilXGTVmFOK7k/HjEUsIf2lmeUQlUfOZbl92ys3ta0SqVhcKyWvbhaV24pxzIaCY3ftruSmwXQkzShG0zSqMw+4t32Ybav1CLsW/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LFX3B4FB; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721613076; x=1753149076;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=cAt92c2u4pJpgHPwgKHECJkZLu5EDukZ29rPgn9SoRA=;
  b=LFX3B4FBGMrdz8H3ZMXrOkM83gKl+Njmb3szBUABuREqZZr9hskmCT2v
   bEwd5/EwraxnwYIwbJ5TegYxKosRtH/zH0LMFP8cALu8x3xEv0BLwz7WL
   koni/yu6G9KlFwhc57bwNw0c/dbrMPfoPS+KqsWrfuRRbo90Z5h3j3M2g
   lga9S5IlT7LZMbhpxEouASB4E2+nm51Dg+nrYrIuzrxXL37QLN19+btCb
   9Ex0nOtUL+onhUNUN22SQjzJJtJ2o1dbEe/mWEzHuIRyRX1hlIik+Rryb
   +qD6o36/2nqMWH3qj9obizh3Svlla6WH4SOmF53HI78Wm3kBCjD4KL31E
   g==;
X-CSE-ConnectionGUID: yvsAh/rcSCKryWM6FWSgfg==
X-CSE-MsgGUID: vTtIsAMKRwSnyINfo8KrFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="18975343"
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; 
   d="scan'208";a="18975343"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2024 18:51:15 -0700
X-CSE-ConnectionGUID: 86LHyG1RSpu5YW+EhjNrUg==
X-CSE-MsgGUID: +w7KXqlTTmyePRTA4d0fMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; 
   d="scan'208";a="51439474"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2024 18:51:13 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>,  <linux-mm@kvack.org>,  Andrew
 Morton <akpm@linux-foundation.org>,  Baolin Wang
 <baolin.wang@linux.alibaba.com>,  <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 3/3] mm/migrate: move common code to
 numa_migrate_check (was numa_migrate_prep)
In-Reply-To: <735B3DEE-5C4A-43BD-B003-17F4B1F0DC98@nvidia.com> (Zi Yan's
	message of "Fri, 19 Jul 2024 16:19:04 -0400")
References: <20240712024455.163543-1-zi.yan@sent.com>
	<20240712024455.163543-4-zi.yan@sent.com>
	<87zfqfw0yw.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<735B3DEE-5C4A-43BD-B003-17F4B1F0DC98@nvidia.com>
Date: Mon, 22 Jul 2024 09:47:40 +0800
Message-ID: <87sew2jiyr.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Zi Yan <ziy@nvidia.com> writes:

> On 18 Jul 2024, at 4:36, Huang, Ying wrote:
>
>> Zi Yan <zi.yan@sent.com> writes:
>>
>>> From: Zi Yan <ziy@nvidia.com>
>>>
>>> do_numa_page() and do_huge_pmd_numa_page() share a lot of common code. To
>>> reduce redundancy, move common code to numa_migrate_prep() and rename
>>> the function to numa_migrate_check() to reflect its functionality.
>>>
>>> There is some code difference between do_numa_page() and
>>> do_huge_pmd_numa_page() before the code move:
>>>
>>> 1. do_huge_pmd_numa_page() did not check shared folios to set TNF_SHARED.
>>> 2. do_huge_pmd_numa_page() did not check and skip zone device folios.
>>>
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> ---
>>>  mm/huge_memory.c | 28 ++++++-----------
>>>  mm/internal.h    |  5 +--
>>>  mm/memory.c      | 81 +++++++++++++++++++++++-------------------------
>>>  3 files changed, 52 insertions(+), 62 deletions(-)
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 8c11d6da4b36..66d67d13e0dc 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -1670,10 +1670,10 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>>>  	pmd_t pmd;
>>>  	struct folio *folio;
>>>  	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
>>> -	int nid = NUMA_NO_NODE;
>>> -	int target_nid, last_cpupid = (-1 & LAST_CPUPID_MASK);
>>> +	int target_nid = NUMA_NO_NODE;
>>> +	int last_cpupid = (-1 & LAST_CPUPID_MASK);
>>>  	bool writable = false;
>>> -	int flags = 0;
>>> +	int flags = 0, nr_pages;
>>>
>>>  	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
>>>  	if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
>>> @@ -1693,21 +1693,13 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>>>  		writable = true;
>>>
>>>  	folio = vm_normal_folio_pmd(vma, haddr, pmd);
>>> -	if (!folio)
>>> +	if (!folio || folio_is_zone_device(folio))
>>
>> This change appears unrelated.  Can we put it in a separate patch?
>>
>> IIUC, this isn't necessary even in do_numa_page()?  Because in
>> change_pte_range(), folio_is_zone_device() has been checked already.
>> But It doesn't hurt too.
>>
>>>  		goto out_map;
>>>
>>> -	/* See similar comment in do_numa_page for explanation */
>>> -	if (!writable)
>>> -		flags |= TNF_NO_GROUP;
>>> +	nr_pages = folio_nr_pages(folio);
>>>
>>> -	nid = folio_nid(folio);
>>> -	/*
>>> -	 * For memory tiering mode, cpupid of slow memory page is used
>>> -	 * to record page access time.  So use default value.
>>> -	 */
>>> -	if (folio_has_cpupid(folio))
>>> -		last_cpupid = folio_last_cpupid(folio);
>>> -	target_nid = numa_migrate_prep(folio, vmf, haddr, nid, &flags);
>>> +	target_nid = numa_migrate_check(folio, vmf, haddr, writable,
>>> +			&flags, &last_cpupid);
>>>  	if (target_nid == NUMA_NO_NODE)
>>>  		goto out_map;
>>>  	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
>>> @@ -1720,8 +1712,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>>>
>>>  	if (!migrate_misplaced_folio(folio, vma, target_nid)) {
>>>  		flags |= TNF_MIGRATED;
>>> -		nid = target_nid;
>>>  	} else {
>>> +		target_nid = NUMA_NO_NODE;
>>>  		flags |= TNF_MIGRATE_FAIL;
>>>  		vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
>>>  		if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
>>> @@ -1732,8 +1724,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>>>  	}
>>>
>>>  out:
>>> -	if (nid != NUMA_NO_NODE)
>>> -		task_numa_fault(last_cpupid, nid, HPAGE_PMD_NR, flags);
>>> +	if (target_nid != NUMA_NO_NODE)
>>> +		task_numa_fault(last_cpupid, target_nid, nr_pages, flags);
>>
>> This appears a behavior change.  IIUC, there are 2 possible issues.
>>
>> 1) if migrate_misplaced_folio() fails, folio_nid() should be used as
>> nid.  "target_nid" as variable name here is confusing, because
>> folio_nid() is needed in fact.
>>
>> 2) if !pmd_same(), task_numa_fault() should be skipped.  The original
>> code is buggy.
>>
>> Similar issues for do_numa_page().
>>
>> If my understanding were correct, we should implement a separate patch
>> to fix 2) above.  And that may need to be backported.
>
> Hmm, the original code seems OK after I checked the implementation.
> There are two possible !pte_same()/!pmd_same() locations:
> 1) at the beginning of do_numa_page() and do_huge_pmd_numa_page() and the faulted
> PTE/PMD changed before the folio can be checked, task_numa_fault() should not be
> called.

Yes.

> 2) when migrate_misplaced_folio() failed and the PTE/PMD changed, but the folio
> has been determined and checked. task_numa_fault() should be called even if
> !pte_same()/!pmd_same(),

IIUC, if !pte_same()/!pmd_same(), the fault has been processed on
another CPU.  For example, do_numa_page()/do_huge_pmd_numa_page() has
been called on another CPU and task_numa_fault() has been called for the
PTE/PMD already.

> Let me know if I get this wrong. Thanks.
>

--
Best Regards,
Huang, Ying

