Return-Path: <linux-kernel+bounces-242128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 004DF9283EE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0723289BA6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36AD145B23;
	Fri,  5 Jul 2024 08:42:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF161422DD
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720168975; cv=none; b=ntXC2xJXDeJvk59wvarSMS7XSrjWVseFE5zCII+ea/4wB4hSH8Aj88Yx8YOWgvLY1WiQ3gqfNo7YuA6RrKEmk7QNFZre9v3k3MN5KMx4SUh/pAHsM7khp8WtI+HcGqb55jCNxLM6xGFs3T28p963TXd81tjyaDty82yUjoraEmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720168975; c=relaxed/simple;
	bh=eizjPo3aNLKcojOvFJGbEOKqmNTs9eAlTe3QwrkuoAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SdYoimgzKRwPIihtsZkEnNH5ohs+SiqP7nMX4B9Qj78a41/M3pIUyMRu9MumfRdYKMhpdwJTvLlrjW/iKGaFKBPpsxi5GC4ahdge1ajpRj3FhEdw6LTninnMszHobEUcjgdgbpiVhTAX+8BnF4sgZvRa5Jsk09vkg5JatiyiQj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFE8B367;
	Fri,  5 Jul 2024 01:43:16 -0700 (PDT)
Received: from [10.57.74.223] (unknown [10.57.74.223])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24AE93F762;
	Fri,  5 Jul 2024 01:42:49 -0700 (PDT)
Message-ID: <96625631-ef7d-44a2-ad5f-f7beb64f0ed0@arm.com>
Date: Fri, 5 Jul 2024 09:42:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] mm: shmem: add mTHP support for anonymous shmem
Content-Language: en-GB
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Bang Li <libang.linux@gmail.com>, akpm@linux-foundation.org, hughd@google.com
Cc: willy@infradead.org, david@redhat.com, wangkefeng.wang@huawei.com,
 ying.huang@intel.com, 21cnbao@gmail.com, shy828301@gmail.com,
 ziy@nvidia.com, ioworker0@gmail.com, da.gomez@samsung.com,
 p.raghav@samsung.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1718090413.git.baolin.wang@linux.alibaba.com>
 <65796c1e72e51e15f3410195b5c2d5b6c160d411.1718090413.git.baolin.wang@linux.alibaba.com>
 <65c37315-2741-481f-b433-cec35ef1af35@arm.com>
 <475332ea-a80b-421c-855e-a663d1d5bfc7@linux.alibaba.com>
 <a3910f60-6e2e-4ede-b3f3-47d8dfe9f23b@gmail.com>
 <076550c4-0e8a-4344-9f8a-31ae9e1051b5@linux.alibaba.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <076550c4-0e8a-4344-9f8a-31ae9e1051b5@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/07/2024 04:01, Baolin Wang wrote:
> 
> 
> On 2024/7/4 22:46, Bang Li wrote:
>> Hi Bao lin,
>>
>> On 2024/7/4 19:15, Baolin Wang wrote:
>>>
>>>>> +
>>>>> +    /*
>>>>> +     * Only allow inherit orders if the top-level value is 'force', which
>>>>> +     * means non-PMD sized THP can not override 'huge' mount option now.
>>>>> +     */
>>>>> +    if (shmem_huge == SHMEM_HUGE_FORCE)
>>>>> +        return READ_ONCE(huge_shmem_orders_inherit);
>>>>
>>>> I vaguely recall that we originally discussed that trying to set 'force' on the
>>>> top level control while any per-size controls were set to 'inherit' would be an
>>>> error, and trying to set 'force' on any per-size control except the PMD-size
>>>> would be an error?
>>>
>>> Right.
>>>
>>>> I don't really understand this logic. Shouldn't we just be looking at the
>>>> per-size control settings (or the top-level control as a proxy for every
>>>> per-size control that has 'inherit' set)?
>>>
>>> ‘force’ will apply the huge orders for anon shmem and tmpfs, so now we only
>>> allow pmd-mapped THP to be forced. We should not look at per-size control
>>> settings for tmpfs now (mTHP for tmpfs will be discussed in future).
>>>
>>>>
>>>> Then for tmpfs, which doesn't support non-PMD-sizes yet, we just always use the
>>>> PMD-size control for decisions.
>>>>
>>>> I'm also really struggling with the concept of shmem_is_huge() existing along
>>>> side shmem_allowable_huge_orders(). Surely this needs to all be refactored into
>>>> shmem_allowable_huge_orders()?
>>>
>>> I understood. But now they serve different purposes: shmem_is_huge() will be
>>> used to check the huge orders for the top level, for *tmpfs* and anon shmem;
>>> whereas shmem_allowable_huge_orders() will only be used to check the per-size
>>> huge orders for anon shmem (excluding tmpfs now). However, as I plan to add
>>> mTHP support for tmpfs, I think we can perform some cleanups. 
>>
>> Please count me in, I'd be happy to contribute to the cleanup and enhancement
>> process if I can.
> 
> Good. If you have time, I think you can look at the shmem khugepaged issue from
> the previous discussion [1], which I don't have time to look at now.
> 
> "
> (3) khugepaged
> 
> khugepaged needs to handle larger folios properly as well. Until fixed,
> using smaller THP sizes as fallback might prohibit collapsing a
> PMD-sized THP later. But really, khugepaged needs to be fixed to handle
> that.
> "

khugepaged can already collapse "folios of any order less then PMD-size" to
PMD-size, for anon memory. Infact I modified the selftest to be able to test
that in commit 9f0704eae8a4 ("selftests/mm/khugepaged: enlighten for multi-size
THP"). I'd be surprised if khugepaged can't alreay handle the same for shmem?
Although the test will definitely want to be extended to test it.

Thanks,
Ryan

> 
> [1]
> https://lore.kernel.org/all/f1783ff0-65bd-4b2b-8952-52b6822a0835@redhat.com/T/#u


