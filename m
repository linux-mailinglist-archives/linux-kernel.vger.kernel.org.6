Return-Path: <linux-kernel+bounces-547114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A598AA50328
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34FE6188AA7B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6284E24EF86;
	Wed,  5 Mar 2025 15:02:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FDD24C68D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186978; cv=none; b=Zdjq+B1GP6NEVRIbUhq4SCh8CCFywHgFekL1R2r4l5k11zP6qUFZjSE6wIYvww9KdfO5kcWxPckIZ3GO1naSny2aymgdIXKu9Ycsb0U5Qsem3W1QlZUk+1C+1G8K0pvZDKTXVC4oteRQ4AtFODqRTeYhzlBMQSKo1EO70ZgCmPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186978; c=relaxed/simple;
	bh=rwxs2qHmdeQKe1U8LtwGFdJo7B87r155p+txMieverQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=X/15uvKZ5pgGYU3rQEGSi19ItiXYs7MomHAy5iRjaEVhVkSgvOe+pvw2NVv+RRNXQGIGDHfex0sxblBq1Z0C3+Se0+1i17R8F4AeuDLlJ/GbHAyQOPNZCuDb9Fq634oyvw7s+eQ5ADhjukkxnFxvAzZ4zRmVjTjWDITGI9ezXqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9535FFEC;
	Wed,  5 Mar 2025 07:03:08 -0800 (PST)
Received: from [10.174.36.147] (unknown [10.174.36.147])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 065973F673;
	Wed,  5 Mar 2025 07:02:52 -0800 (PST)
Message-ID: <3c3f3cfe-9fa7-41d7-9759-cc67306f13f5@arm.com>
Date: Wed, 5 Mar 2025 20:32:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QUESTION] Plain dereference and READ_ONCE() in fault handler
To: David Hildenbrand <david@redhat.com>, willy@infradead.org,
 ziy@nvidia.com, hughd@google.com, ryan.roberts@arm.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250305102159.96420-1-dev.jain@arm.com>
 <8477d9ec-b9ce-4a3d-b61f-1bd44d3360a5@redhat.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <8477d9ec-b9ce-4a3d-b61f-1bd44d3360a5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 05/03/25 4:16 pm, David Hildenbrand wrote:
> On 05.03.25 11:21, Dev Jain wrote:
>> In __handle_mm_fault(),
>>
>> 1. Why is there a barrier() for the PUD logic?
> 
> Good question. It was added in
> 
> commit a00cc7d9dd93d66a3fb83fc52aa57a4bec51c517
> Author: Matthew Wilcox <willy@infradead.org>
> Date:   Fri Feb 24 14:57:02 2017 -0800
> 
>      mm, x86: add support for PUD-sized transparent hugepages
> 
> Maybe it was an alternative to performing a READ_ONCE(*vmf.pud).
> 
> Maybe it was done that way, because pudp_get_lockless() does not exist. 
> And it would likely not be required, because on architectures where 
> ptep_get_lockless() does some magic (see below, mostly 32bit), PUD THP 
> are not applicable.

Thanks for your reply David.

> 
> 
>> 2. For the PMD logic, in the if block, we use *vmf.pmd, and in the 
>> else block
>>     we use pmdp_get_lockless(); what if someone changes the pmd just 
>> when we
>>     have begun processing the conditions in the if block, fail in the 
>> if block
>>     and then the else block operates on a different pmd value. 
>> Shouldn't we cache
>>     the value of the pmd and operate on a single consistent value 
>> until we take the
>>     lock and then finally check using pxd_same() and friends?
> 
> The pmd_none(*vmf.pmd) is fine. create_huge_pmd() must be able to deal 
> with races, because we are not holding any locks.

I had a mental hiccup, yes we don't need the cached value even before 
the if block, as the relevant path will eventually check after taking 
the lock. I was thinking of all sorts of weird races.

> 
> We only have to use pmdp_get_lockless() when we want to effectively 
> perform a READ_ONCE(), and make sure that we read something "reasonable" 
> that we can operate on, even with concurrent changes. (e.g., not read a 
> garbage PFN just because of some concurrent changes)

Oh I just looked at the arm64 definition and assumed ptep_get_lockless() 
== READ_ONCE() :) Now this makes sense. So I am guessing that we can 
still get away with a *vmf.pmd on 64-bit arches?

A separate question: When taking the create_huge_pmd() path with a read 
fault and after taking the pmd lock, why shouldn't we check with 
pmd_none(pmdp_get_lockless(vmf.pmd)) instead of plain *vmf.pmd...surely 
now we must load the actual correct value from memory since we are 
committing into mapping the huge zero folio?
And after looking somewhat more, why even is a pmd_none(*pmd) there in 
set_huge_zero_folio()...it should be the responsibility of the caller to 
verify this? Any caller will just assume that it got the huge zero folio 
mapped so this check should be redundant.

> 
> We'll store the value in vmf.orig_pmd, on which we'll operate and try to 
> detect later changes using pmd_same(). So we really want something 
> consistent in there.
> 
> See the description above ptep_get_lockless(), why we cannot simply do a 
> READ_ONCE on architectures where a PTE cannot be read atomically (e.g., 
> 8 byte PTEs on 32bit architecture).
>



