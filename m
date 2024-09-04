Return-Path: <linux-kernel+bounces-315432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E19B396C2AE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D634281648
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62601DCB01;
	Wed,  4 Sep 2024 15:42:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C9FFC1D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 15:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725464531; cv=none; b=CtlVeJ2ihaKL+8AQenTkPA+zS2Zb/hizzx6HwBv4FFxx6aDnj5tmVaqT0NmHE+0RQ0+dZb+hluz9RESs8vQ7otp7HqDoE2GsyozomgSAMROU7iwcFl6bzglJhco13/epNh6J2im/j8+R4QCinSS6NtGa2HAazGQhhu++QPdjXyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725464531; c=relaxed/simple;
	bh=WXqVMEPhAqQEHeHg6JMAVBSWvqNx5vVJjEp/4AaHW6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IiSnn1iQkzBPE97EWZ2zjPhOsB1UCp6dmju1d08x6enArNY8xt4Ak9/9zaCxA44f33XZeyzS/KKDFSAQbXNo4MN3gOzDiFl6TPjnoPYoEP7xR6fxTrKNh7Vu+BOzWX7mi9fBJMnZEmyQ2P7vLEHVlyg7ITuOTCTVQXwpHzgKMMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7865BFEC;
	Wed,  4 Sep 2024 08:42:35 -0700 (PDT)
Received: from [10.163.62.239] (unknown [10.163.62.239])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72F283F73F;
	Wed,  4 Sep 2024 08:42:00 -0700 (PDT)
Message-ID: <98f73b2f-ec1c-4e81-bfb2-6e02ebc4cdae@arm.com>
Date: Wed, 4 Sep 2024 21:11:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Do not shatter hugezeropage on wp-fault
To: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org,
 david@redhat.com, willy@infradead.org, kirill.shutemov@linux.intel.com
Cc: anshuman.khandual@arm.com, catalin.marinas@arm.com, cl@gentwo.org,
 vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 jack@suse.cz, mark.rutland@arm.com, hughd@google.com,
 aneesh.kumar@kernel.org, yang@os.amperecomputing.com, peterx@redhat.com,
 ioworker0@gmail.com, jglisse@google.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240904100923.290042-1-dev.jain@arm.com>
 <2427338d-7be5-4939-8d01-6d99b9167fea@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <2427338d-7be5-4939-8d01-6d99b9167fea@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/4/24 17:06, Ryan Roberts wrote:
> Hi Dev,
>
> On 04/09/2024 11:09, Dev Jain wrote:
>> It was observed at [1] and [2] that the current kernel behaviour of
>> shattering a hugezeropage is inconsistent and suboptimal. For a VMA with
>> a THP allowable order, when we write-fault on it, the kernel installs a
>> PMD-mapped THP. On the other hand, if we first get a read fault, we get
>> a PMD pointing to the hugezeropage; subsequent write will trigger a
>> write-protection fault, shattering the hugezeropage into one writable
>> page, and all the other PTEs write-protected. The conclusion being, as
>> compared to the case of a single write-fault, applications have to suffer
>> 512 extra page faults if they were to use the VMA as such, plus we get
>> the overhead of khugepaged trying to replace that area with a THP anyway.
>>
>> Instead, replace the hugezeropage with a THP on wp-fault.
>>
>> v1->v2:
>>   - Wrap do_huge_zero_wp_pmd_locked() around lock and unlock
>>   - Call thp_fault_alloc() before do_huge_zero_wp_pmd_locked() to avoid
>>   - calling sleeping function from spinlock context
>>
>> [1]: https://lore.kernel.org/all/3743d7e1-0b79-4eaf-82d5-d1ca29fe347d@arm.com/
>> [2]: https://lore.kernel.org/all/1cfae0c0-96a2-4308-9c62-f7a640520242@arm.com/
>>
>> Dev Jain (2):
>>    mm: Abstract THP allocation
>>    mm: Allocate THP on hugezeropage wp-fault
>>
>>   include/linux/huge_mm.h |   6 ++
>>   mm/huge_memory.c        | 171 +++++++++++++++++++++++++++++-----------
>>   mm/memory.c             |   5 +-
>>   3 files changed, 136 insertions(+), 46 deletions(-)
>>
> What is the base for this? It doesn't apply on top of mm-unstable.

Sorry, forgot to mention, it applies on v6.11-rc5.

>
> Thanks,
> Ryan
>

