Return-Path: <linux-kernel+bounces-315493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 854E996C348
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C1D41F29356
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E471DFE09;
	Wed,  4 Sep 2024 16:01:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96912FC1D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 16:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725465715; cv=none; b=ux56FXJmS+r0S1wIaZG+FqLzFbkiZXqCn5j3g/2ajGzWt5nN+k8nZuvK87gBWK0EakaF155trezz8zFz49dhv5ToT5tsdmMwk9vJzYQbIQouFku59MJcMBbqs0+8ZQk8LrMVbz+CjmIy7Jl/q+jyXWsAmP/wEKrCRQWLKip+4r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725465715; c=relaxed/simple;
	bh=lSUMwSmWSwy7rFl69KtEi7NAoauuw1/sm9LSVhNiIL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZfgHQ7aPpSERDl23HuaMyKDxxx89wCpKJy0dUSvTcJT26yhn3gbX5mIwM4WP/kDxiFnxIIKtqJcL6H0hSUGjg66OLEqLA24M3clVyi2LWNBGSBO51V46b2RoIuby4EaRH9/581BRB2Y7obbz5W8ve54yZU0PUvuqWswLLiE5Nh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3250FFEC;
	Wed,  4 Sep 2024 09:02:19 -0700 (PDT)
Received: from [10.57.87.65] (unknown [10.57.87.65])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84B9D3F73B;
	Wed,  4 Sep 2024 09:01:49 -0700 (PDT)
Message-ID: <91a2d578-3ff2-41e1-a980-0d78c0663959@arm.com>
Date: Wed, 4 Sep 2024 17:01:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Do not shatter hugezeropage on wp-fault
Content-Language: en-GB
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, david@redhat.com,
 willy@infradead.org, kirill.shutemov@linux.intel.com
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
 <98f73b2f-ec1c-4e81-bfb2-6e02ebc4cdae@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <98f73b2f-ec1c-4e81-bfb2-6e02ebc4cdae@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/09/2024 16:41, Dev Jain wrote:
> 
> On 9/4/24 17:06, Ryan Roberts wrote:
>> Hi Dev,
>>
>> On 04/09/2024 11:09, Dev Jain wrote:
>>> It was observed at [1] and [2] that the current kernel behaviour of
>>> shattering a hugezeropage is inconsistent and suboptimal. For a VMA with
>>> a THP allowable order, when we write-fault on it, the kernel installs a
>>> PMD-mapped THP. On the other hand, if we first get a read fault, we get
>>> a PMD pointing to the hugezeropage; subsequent write will trigger a
>>> write-protection fault, shattering the hugezeropage into one writable
>>> page, and all the other PTEs write-protected. The conclusion being, as
>>> compared to the case of a single write-fault, applications have to suffer
>>> 512 extra page faults if they were to use the VMA as such, plus we get
>>> the overhead of khugepaged trying to replace that area with a THP anyway.
>>>
>>> Instead, replace the hugezeropage with a THP on wp-fault.
>>>
>>> v1->v2:
>>>   - Wrap do_huge_zero_wp_pmd_locked() around lock and unlock
>>>   - Call thp_fault_alloc() before do_huge_zero_wp_pmd_locked() to avoid
>>>   - calling sleeping function from spinlock context
>>>
>>> [1]: https://lore.kernel.org/all/3743d7e1-0b79-4eaf-82d5-d1ca29fe347d@arm.com/
>>> [2]: https://lore.kernel.org/all/1cfae0c0-96a2-4308-9c62-f7a640520242@arm.com/
>>>
>>> Dev Jain (2):
>>>    mm: Abstract THP allocation
>>>    mm: Allocate THP on hugezeropage wp-fault
>>>
>>>   include/linux/huge_mm.h |   6 ++
>>>   mm/huge_memory.c        | 171 +++++++++++++++++++++++++++++-----------
>>>   mm/memory.c             |   5 +-
>>>   3 files changed, 136 insertions(+), 46 deletions(-)
>>>
>> What is the base for this? It doesn't apply on top of mm-unstable.
> 
> Sorry, forgot to mention, it applies on v6.11-rc5.

Thanks, I'll give it a review tomorrow. Although I suspect that Andrew will want
it based against mm-unstable once it gets into shape for merging.

> 
>>
>> Thanks,
>> Ryan
>>


