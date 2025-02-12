Return-Path: <linux-kernel+bounces-510469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 899D2A31D74
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 05:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F118F1887EF9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 04:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5151DA612;
	Wed, 12 Feb 2025 04:18:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD4E18E2A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 04:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739333926; cv=none; b=Ghm5GMu3qeWsqURa48Rs9LHm+mol4j9/ULZRMEAOqwU+jBQMWKo6t47xoLLZVZ3YrC9nuommTP3yRahshWRxnV8dXCrwx1sYpCqH5NtnKhxcJphovtpK+ugZSoOHzkBSEa8XF9lg82sVDRfmyoFfxG7ZHtiG10u2XlgLEmS5UsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739333926; c=relaxed/simple;
	bh=V9SL1BoV/fnZubu7pKepWIq5Qexy7CMp24jC9reNRw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mPAQ50n5E1b1Za5Ud/Qba9A8kMLfBplNbq5z9wq+bwdW95ETEQbjtRDOZGjK6fnuA/Y2AFiEfV4I1/FtlA+pNSxRBrielxgY5YN1w/SAH8S4Zq53zk/Ve7yf7aA9vH0iJ7RfTFb2u2W17tqr+5+5T2dpt1bdx4VgAM9yuQEJIZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D137D13D5;
	Tue, 11 Feb 2025 20:19:02 -0800 (PST)
Received: from [10.162.43.26] (unknown [10.162.43.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1525F3F5A1;
	Tue, 11 Feb 2025 20:18:30 -0800 (PST)
Message-ID: <cf6a3679-6d35-40c4-9bd8-df835797a3a3@arm.com>
Date: Wed, 12 Feb 2025 09:48:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] khugepaged: Asynchronous mTHP collapse
To: Andrew Morton <akpm@linux-foundation.org>
Cc: david@redhat.com, willy@infradead.org, kirill.shutemov@linux.intel.com,
 npache@redhat.com, ryan.roberts@arm.com, anshuman.khandual@arm.com,
 catalin.marinas@arm.com, cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com,
 apopple@nvidia.com, dave.hansen@linux.intel.com, will@kernel.org,
 baohua@kernel.org, jack@suse.cz, srivatsa@csail.mit.edu,
 haowenchao22@gmail.com, hughd@google.com, aneesh.kumar@kernel.org,
 yang@os.amperecomputing.com, peterx@redhat.com, ioworker0@gmail.com,
 wangkefeng.wang@huawei.com, ziy@nvidia.com, jglisse@google.com,
 surenb@google.com, vishal.moola@gmail.com, zokeefe@google.com,
 zhengqi.arch@bytedance.com, jhubbard@nvidia.com, 21cnbao@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250211111326.14295-1-dev.jain@arm.com>
 <20250211152341.3431089327c5e0ec6ba6064d@linux-foundation.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250211152341.3431089327c5e0ec6ba6064d@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/02/25 4:53 am, Andrew Morton wrote:
> On Tue, 11 Feb 2025 16:43:09 +0530 Dev Jain <dev.jain@arm.com> wrote:
> 
>> This patchset extends khugepaged from collapsing only PMD-sized THPs to
>> collapsing anonymous mTHPs.
>>
>> mTHPs were introduced in the kernel to improve memory management by allocating
>> chunks of larger memory, so as to reduce number of page faults, TLB misses (due
>> to TLB coalescing), reduce length of LRU lists, etc. However, the mTHP property
>> is often lost due to CoW, swap-in/out, and when the kernel just cannot find
>> enough physically contiguous memory to allocate on fault. Henceforth, there is a
>> need to regain mTHPs in the system asynchronously. This work is an attempt in
>> this direction, starting with anonymous folios.
>>
>> In the fault handler, we select the THP order in a greedy manner; the same has
>> been used here, along with the same sysfs interface to control the order of
>> collapse. In contrast to PMD-collapse, we (hopefully) get rid of the mmap_write_lock().
>>
>> ---------------------------------------------------------
>> Testing
>> ---------------------------------------------------------
>>
>> The set has been build tested on x86_64.
>> For Aarch64,
>> 1. mm-selftests: No regressions.
>> 2. Analyzing with tools/mm/thpmaps on different userspace programs mapping
>>     aligned VMAs of a large size, faulting in basepages/mTHPs (according to sysfs),
>>     and then madvise()'ing the VMA, khugepaged is able to 100% collapse the VMAs.
> 
> It would be nice to provide some evidence that this patchset actually
> makes Linux better for our users, and by how much.
> 
> Thanks, I think I'll skip v2 and shall await reviewer input.

Hi Andrew, thanks for your reply.

Although the introduction of mTHPs leads to the natural conclusion of 
extending khugepaged to support mTHP collapse, I'll try to get some 
performance statistics out.


