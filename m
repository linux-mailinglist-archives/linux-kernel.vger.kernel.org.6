Return-Path: <linux-kernel+bounces-259523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFF49397D6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 03:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA9BEB21CFF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 01:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB1D12E1DB;
	Tue, 23 Jul 2024 01:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FdspYOsO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FCF26AE6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 01:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721697579; cv=none; b=T1H/vNSWDG7kIArdLzgMeX+jxfIJPZb9/utmoQJ8udvKBNAonX1B9vkPlD4GTFHZmYC/QjhMjIuwpRBuN41ZL/Pz1tDe0UBoKcjeOSqJg5cGen7HmZdFLbW5khIthwGoDzCcSmOlQ/EQ/OP8HbeRdwOqAL1Zskr7R5xKSP9/k4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721697579; c=relaxed/simple;
	bh=uQId9yvXpctcPoyCmgZd8/FtklDpyd+YOvMsRcNbkWU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B4aPeWjZpgfWmOss2agqaWJa8m8l77e4jxv9cdLrC0YOn1RHzJgkmv7OluuYzqI6uIZ4Ai45EPY366q0CtpNZs4RZn9OfSVq9viRF2RQA/4oju9402J4uIhi5SBFH5KAibi+Bgfb6Z0HwQzHhdXHkWskbGGOsqiLpePsVWjaqbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FdspYOsO; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721697578; x=1753233578;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=uQId9yvXpctcPoyCmgZd8/FtklDpyd+YOvMsRcNbkWU=;
  b=FdspYOsOQkSSfuF6m0eVGzvkW8HjvI5QaZ6iYikfsA8S5MstdMiNraF0
   //NET0MvsXcSAHSKSAcC6l5x9Blrp4hH5caB063TCf2Rwt5IPTF29fdtH
   78geQ3IT68Xd4FXXOjKSGOb7d4yeepnO9Pp4sNY/YjaU+NPOyaAkIWMhv
   fPX1o5f+5LkCGd+tygwkaky7VChDz5ur0jRSJDh1882vUAy0gt8+4t2Si
   /fvUYr3I9p6qJjDQN4rtAFVOz5Iwm/NoGKgmMTeBQ6deuePvGp4FIHZBh
   b8H5MLfsB2GTR7IQxsOn25Q34B+uVbEHU+3WEpiDQu3jFWyfekd+D77JP
   A==;
X-CSE-ConnectionGUID: 8+j+M0Y5TaGgTtf+Lzhy/A==
X-CSE-MsgGUID: KUDnPmn5S7qLMdqQTg/nFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="36741534"
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="36741534"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 18:19:37 -0700
X-CSE-ConnectionGUID: 54FM8z5JRVWs2KJhjlcbLg==
X-CSE-MsgGUID: KoaRHLK1RCae7dgYAvtmGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="52809836"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 18:19:34 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>,  <linux-mm@kvack.org>,  Andrew
 Morton <akpm@linux-foundation.org>,  Baolin Wang
 <baolin.wang@linux.alibaba.com>,  <linux-kernel@vger.kernel.org>,  Mel
 Gorman <mgorman@techsingularity.net>
Subject: Re: [RFC PATCH 3/3] mm/migrate: move common code to
 numa_migrate_check (was numa_migrate_prep)
In-Reply-To: <B9364CE0-1F23-45DD-8AD7-AAC8461FE6D8@nvidia.com> (Zi Yan's
	message of "Mon, 22 Jul 2024 11:21:27 -0400")
References: <20240712024455.163543-1-zi.yan@sent.com>
	<20240712024455.163543-4-zi.yan@sent.com>
	<87zfqfw0yw.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<735B3DEE-5C4A-43BD-B003-17F4B1F0DC98@nvidia.com>
	<87sew2jiyr.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<1844A1CA-7120-4DB2-8F67-8F91BA5B18C6@nvidia.com>
	<B9364CE0-1F23-45DD-8AD7-AAC8461FE6D8@nvidia.com>
Date: Tue, 23 Jul 2024 09:16:01 +0800
Message-ID: <87frs0kiwe.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Zi Yan <ziy@nvidia.com> writes:

> On 22 Jul 2024, at 10:01, Zi Yan wrote:
>
>> On 21 Jul 2024, at 21:47, Huang, Ying wrote:
>>
>>> Zi Yan <ziy@nvidia.com> writes:
>>>
>>>> On 18 Jul 2024, at 4:36, Huang, Ying wrote:
>>>>
>>>>> Zi Yan <zi.yan@sent.com> writes:
>>>>>
>>>>>> From: Zi Yan <ziy@nvidia.com>
>>>>>>
>>>>>> do_numa_page() and do_huge_pmd_numa_page() share a lot of common cod=
e. To
>>>>>> reduce redundancy, move common code to numa_migrate_prep() and rename
>>>>>> the function to numa_migrate_check() to reflect its functionality.
>>>>>>
>>>>>> There is some code difference between do_numa_page() and
>>>>>> do_huge_pmd_numa_page() before the code move:
>>>>>>
>>>>>> 1. do_huge_pmd_numa_page() did not check shared folios to set TNF_SH=
ARED.
>>>>>> 2. do_huge_pmd_numa_page() did not check and skip zone device folios.
>>>>>>
>>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>>>> ---
>>>>>>  mm/huge_memory.c | 28 ++++++-----------
>>>>>>  mm/internal.h    |  5 +--
>>>>>>  mm/memory.c      | 81 +++++++++++++++++++++++----------------------=
---
>>>>>>  3 files changed, 52 insertions(+), 62 deletions(-)
>>>>>>
>>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>>>> index 8c11d6da4b36..66d67d13e0dc 100644
>>>>>> --- a/mm/huge_memory.c
>>>>>> +++ b/mm/huge_memory.c
>>>>>> @@ -1670,10 +1670,10 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_f=
ault *vmf)
>>>>>>  	pmd_t pmd;
>>>>>>  	struct folio *folio;
>>>>>>  	unsigned long haddr =3D vmf->address & HPAGE_PMD_MASK;
>>>>>> -	int nid =3D NUMA_NO_NODE;
>>>>>> -	int target_nid, last_cpupid =3D (-1 & LAST_CPUPID_MASK);
>>>>>> +	int target_nid =3D NUMA_NO_NODE;
>>>>>> +	int last_cpupid =3D (-1 & LAST_CPUPID_MASK);
>>>>>>  	bool writable =3D false;
>>>>>> -	int flags =3D 0;
>>>>>> +	int flags =3D 0, nr_pages;
>>>>>>
>>>>>>  	vmf->ptl =3D pmd_lock(vma->vm_mm, vmf->pmd);
>>>>>>  	if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
>>>>>> @@ -1693,21 +1693,13 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_f=
ault *vmf)
>>>>>>  		writable =3D true;
>>>>>>
>>>>>>  	folio =3D vm_normal_folio_pmd(vma, haddr, pmd);
>>>>>> -	if (!folio)
>>>>>> +	if (!folio || folio_is_zone_device(folio))
>>>>>
>>>>> This change appears unrelated.  Can we put it in a separate patch?
>>>>>
>>>>> IIUC, this isn't necessary even in do_numa_page()?  Because in
>>>>> change_pte_range(), folio_is_zone_device() has been checked already.
>>>>> But It doesn't hurt too.
>>>>>
>>>>>>  		goto out_map;
>>>>>>
>>>>>> -	/* See similar comment in do_numa_page for explanation */
>>>>>> -	if (!writable)
>>>>>> -		flags |=3D TNF_NO_GROUP;
>>>>>> +	nr_pages =3D folio_nr_pages(folio);
>>>>>>
>>>>>> -	nid =3D folio_nid(folio);
>>>>>> -	/*
>>>>>> -	 * For memory tiering mode, cpupid of slow memory page is used
>>>>>> -	 * to record page access time.  So use default value.
>>>>>> -	 */
>>>>>> -	if (folio_has_cpupid(folio))
>>>>>> -		last_cpupid =3D folio_last_cpupid(folio);
>>>>>> -	target_nid =3D numa_migrate_prep(folio, vmf, haddr, nid, &flags);
>>>>>> +	target_nid =3D numa_migrate_check(folio, vmf, haddr, writable,
>>>>>> +			&flags, &last_cpupid);
>>>>>>  	if (target_nid =3D=3D NUMA_NO_NODE)
>>>>>>  		goto out_map;
>>>>>>  	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
>>>>>> @@ -1720,8 +1712,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fau=
lt *vmf)
>>>>>>
>>>>>>  	if (!migrate_misplaced_folio(folio, vma, target_nid)) {
>>>>>>  		flags |=3D TNF_MIGRATED;
>>>>>> -		nid =3D target_nid;
>>>>>>  	} else {
>>>>>> +		target_nid =3D NUMA_NO_NODE;
>>>>>>  		flags |=3D TNF_MIGRATE_FAIL;
>>>>>>  		vmf->ptl =3D pmd_lock(vma->vm_mm, vmf->pmd);
>>>>>>  		if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
>>>>>> @@ -1732,8 +1724,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fau=
lt *vmf)
>>>>>>  	}
>>>>>>
>>>>>>  out:
>>>>>> -	if (nid !=3D NUMA_NO_NODE)
>>>>>> -		task_numa_fault(last_cpupid, nid, HPAGE_PMD_NR, flags);
>>>>>> +	if (target_nid !=3D NUMA_NO_NODE)
>>>>>> +		task_numa_fault(last_cpupid, target_nid, nr_pages, flags);
>>>>>
>>>>> This appears a behavior change.  IIUC, there are 2 possible issues.
>>>>>
>>>>> 1) if migrate_misplaced_folio() fails, folio_nid() should be used as
>>>>> nid.  "target_nid" as variable name here is confusing, because
>>>>> folio_nid() is needed in fact.
>>>>>
>>>>> 2) if !pmd_same(), task_numa_fault() should be skipped.  The original
>>>>> code is buggy.
>>>>>
>>>>> Similar issues for do_numa_page().
>>>>>
>>>>> If my understanding were correct, we should implement a separate patch
>>>>> to fix 2) above.  And that may need to be backported.
>>>>
>>>> Hmm, the original code seems OK after I checked the implementation.
>>>> There are two possible !pte_same()/!pmd_same() locations:
>>>> 1) at the beginning of do_numa_page() and do_huge_pmd_numa_page() and =
the faulted
>>>> PTE/PMD changed before the folio can be checked, task_numa_fault() sho=
uld not be
>>>> called.
>>>
>>> Yes.
>>>
>>>> 2) when migrate_misplaced_folio() failed and the PTE/PMD changed, but =
the folio
>>>> has been determined and checked. task_numa_fault() should be called ev=
en if
>>>> !pte_same()/!pmd_same(),
>>>
>>> IIUC, if !pte_same()/!pmd_same(), the fault has been processed on
>>> another CPU.  For example, do_numa_page()/do_huge_pmd_numa_page() has
>>> been called on another CPU and task_numa_fault() has been called for the
>>> PTE/PMD already.
>>
>> Hmm, this behavior at least dates back to 2015 at
>> commit 074c238177a7 ("mm: numa: slow PTE scan rate if migration failures=
 occur=E2=80=9D).
>> So cc Mel.
>>
>> The code is https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/lin=
ux.git/tree/mm/memory.c?id=3D074c238177a75f5e79af3b2cb6a84e54823ef950#n3102=
. I have not checked older
>> commits.
>>
>> I wonder how far we should trace back.
>
> OK, I find the commit where task_numa_fault policy settled:
> 8191acbd30c7 ("mm: numa: Sanitize task_numa_fault() callsites=E2=80=9D).
>
> It says:
> =E2=80=9CSo modify all three sites to always account; we did after all re=
ceive
> the fault; and always account to where the page is after migration,
> regardless of success.=E2=80=9C, where the three call sites were:
> do_huge_pmd_numa_page(), do_numa_page(), and do_pmd_numa_page().
>
> The current code still follows what the commit log does.

Per my understanding, the issue is introduced in commit b99a342d4f11
("NUMA balancing: reduce TLB flush via delaying mapping on hint page
fault").  Before that, the PTE is restored before migration, so
task_numa_fault() should be called for migration failure too.  After
that, the PTE is restored after migration failure, if the PTE has been
changed by someone else, someone else should have called
task_numa_fault() if necessary, we shouldn't call it again.

--
Best Regards,
Huang, Ying

