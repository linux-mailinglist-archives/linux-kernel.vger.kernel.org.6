Return-Path: <linux-kernel+bounces-271060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CC09448FD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEAC1282EEC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA1E183CA3;
	Thu,  1 Aug 2024 10:07:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211F016D33D
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722506822; cv=none; b=ak47h3nRGA65qM2E+pBONnKKiWLPT8wTzws0lV50A4lPDywn+K2r3ody3VKSi6ymYALw4YPLvcR++fwp1VVXt1FolQFNHXMHYFDHifaGijoKnvqFxTlXQYOrpDDlBUjnDkF5qLqZeBIPrjejwoJ3j1rm+jN7HUVNnuVOy0a/4v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722506822; c=relaxed/simple;
	bh=Ja6dsv7f8ujc2kS7Sk/mTpP9nVFTF+WTCfBKji6LE1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bacHlm8xVp75O7SJsfYQnsmjYD4kR5AeqZP/3Y6iw/yE7qK/ninpleUf7Y3KLMzJl60L/vH/ikomJuekRGsh7P2rbBKm4BFAMqJQZQ7yhovhO3WCg9wueovDq8oIZHBcspgutCkZMCFzUmbzhwJpy5VWFHbS1sYWuX+k37Fwt0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2542115A1;
	Thu,  1 Aug 2024 03:07:26 -0700 (PDT)
Received: from [10.1.28.152] (XHFQ2J9959.cambridge.arm.com [10.1.28.152])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B66C63F5A1;
	Thu,  1 Aug 2024 03:06:56 -0700 (PDT)
Message-ID: <738342dc-4a87-4dcc-a515-a9dc085e3186@arm.com>
Date: Thu, 1 Aug 2024 11:06:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Race condition observed between page migration and page fault
 handling on arm64 machines
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, Dev Jain <dev.jain@arm.com>,
 akpm@linux-foundation.org, willy@infradead.org
Cc: anshuman.khandual@arm.com, catalin.marinas@arm.com, cl@gentwo.org,
 vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com, osalvador@suse.de,
 baolin.wang@linux.alibaba.com, dave.hansen@linux.intel.com, will@kernel.org,
 baohua@kernel.org, ioworker0@gmail.com, gshan@redhat.com,
 mark.rutland@arm.com, kirill.shutemov@linux.intel.com, hughd@google.com,
 aneesh.kumar@kernel.org, yang@os.amperecomputing.com, peterx@redhat.com,
 broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240801081657.1386743-1-dev.jain@arm.com>
 <3b82e195-5871-4880-9ce5-d01bb751f471@redhat.com>
 <bbe411f2-4c68-4f92-af8c-da184669dca8@arm.com>
 <a6a38ad5-c754-44ad-a64b-f9ea5b764291@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <a6a38ad5-c754-44ad-a64b-f9ea5b764291@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01/08/2024 10:41, David Hildenbrand wrote:
> On 01.08.24 11:38, Dev Jain wrote:
>>
>> On 8/1/24 14:12, David Hildenbrand wrote:
>>> On 01.08.24 10:16, Dev Jain wrote:
>>>> I and Ryan had a discussion and we thought it would be best to get
>>>> feedback
>>>> from the community.
>>>>
>>>> The migration mm selftest currently fails on arm64 for shared anon
>>>> mappings,
>>>> due to the following race:
>>>
>>> Do you mean MAP_SHARED|MAP_ANON or MAP_PRIVATE|MAP_ANON_fork? Because
>>> you note shmem below, I assume you mean MAP_SHARED|MAP_ANON
>>
>>
>> Yes.
>>
>>>
>>>>
>>>> Migration:                        Page fault:
>>>> try_to_migrate_one():                    handle_pte_fault():
>>>> 1. Nuke the PTE                        PTE has been deleted =>
>>>> do_pte_missing()
>>>> 2. Mark the PTE for migration                PTE has not been deleted
>>>> but is just not "present" => do_swap_page()
>>>>
>>>
>>> In filemap_fault_recheck_pte_none() we recheck under PTL to make sure
>>> that a temporary pte_none() really was persistent pte_none() and not a
>>> temporary pte_none() under PTL.
>>>
>>> Should we do something similar in do_fault()? I see that we already do
>>> something like that on the "!vma->vm_ops->fault" path.
>>>
>>> But of course, there is a tradeoff between letting migration
>>> (temporarily) fail and grabbing the PTL during page faults.
>>
>>
>> To dampen the tradeoff, we could do this in shmem_fault() instead? But
>> then, this would mean that we do this in all
>>
>> kinds of vma->vm_ops->fault, only when we discover another reference
>> count race condition :) Doing this in do_fault()
>>
>> should solve this once and for all. In fact, do_pte_missing() may call
>> do_anonymous_page() or do_fault(), and I just
>>
>> noticed that the former already checks this using vmf_pte_changed().
> 
> What I am still missing is why this is (a) arm64 only; and (b) if this is
> something we should really worry about. There are other reasons (e.g.,
> speculative references) why migration could temporarily fail, does it happen
> that often that it is really something we have to worry about?

The test fails consistently on arm64. It's my rough understanding that it's
failing due to migration backing off because the fault handler has raised the
ref count? (Dev correct me if I'm wrong).

So the real question is, is it a valid test in the first place? Should we just
delete the test or do we need to strengthen the kernel's guarrantees around
migration success?



