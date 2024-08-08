Return-Path: <linux-kernel+bounces-279054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A46C294B850
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B3F81F21A58
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFEE188CC8;
	Thu,  8 Aug 2024 07:56:42 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C04185E6E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 07:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723103802; cv=none; b=oOlQic0299gcO5R9nuDXYo+k7ucjnpTOpA9lO64d+Or3vBEoTUJYOOoZIl3kuy+bDNRuNLnyNf32e8Noq1PNVlA1sO54CPAucjRUv/uzSKqB29VnUOHGB5CjqSGArAwVzQ5B1GF7QykFJE9FTtNhEPhj0DAhsDGrUWo8TkTaUnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723103802; c=relaxed/simple;
	bh=jayfhbTV8mL7TAk3sS9kL8Mzt8EW0w+l8cYXusEqeZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pMwtA0aOd6pAkzFyku9o8iYGc0rdXQiBOssaMTkg6/zm31QZLr1bqITu8VXDYcqIgfVC0yMlZme4vk4Xd04z61xX+g+OCvyoV0YBnb0slh5ilpW0VyVZJ2/tVFX5KMzI3AiMss7gkQtiiv5X8eX7t1iD73/wK0is9p4Eeh7cMZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WffV54tM4zpTDg;
	Thu,  8 Aug 2024 15:55:25 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 20577140604;
	Thu,  8 Aug 2024 15:56:37 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 8 Aug 2024 15:56:36 +0800
Message-ID: <e01df216-0225-ef49-8eb3-2ccdcb424785@huawei.com>
Date: Thu, 8 Aug 2024 15:56:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] crash: Fix riscv64 crash memory reserve dead loop
Content-Language: en-US
To: Catalin Marinas <catalin.marinas@arm.com>, Baoquan He <bhe@redhat.com>
CC: <vgoyal@redhat.com>, <dyoung@redhat.com>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <chenjiahao16@huawei.com>,
	<akpm@linux-foundation.org>, <kexec@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, Will Deacon <will@kernel.org>
References: <20240802090105.3871929-1-ruanjinjie@huawei.com>
 <ZqywtegyIS/YXOVv@MiWiFi-R3L-srv> <ZrJ1JkyDVpRRB_9e@arm.com>
 <ZrJ60vopeGDXFZyK@arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <ZrJ60vopeGDXFZyK@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/8/7 3:34, Catalin Marinas wrote:
> On Tue, Aug 06, 2024 at 08:10:30PM +0100, Catalin Marinas wrote:
>> On Fri, Aug 02, 2024 at 06:11:01PM +0800, Baoquan He wrote:
>>> On 08/02/24 at 05:01pm, Jinjie Ruan wrote:
>>>> On RISCV64 Qemu machine with 512MB memory, cmdline "crashkernel=500M,high"
>>>> will cause system stall as below:
>>>>
>>>> 	 Zone ranges:
>>>> 	   DMA32    [mem 0x0000000080000000-0x000000009fffffff]
>>>> 	   Normal   empty
>>>> 	 Movable zone start for each node
>>>> 	 Early memory node ranges
>>>> 	   node   0: [mem 0x0000000080000000-0x000000008005ffff]
>>>> 	   node   0: [mem 0x0000000080060000-0x000000009fffffff]
>>>> 	 Initmem setup node 0 [mem 0x0000000080000000-0x000000009fffffff]
>>>> 	(stall here)
>>>>
>>>> commit 5d99cadf1568 ("crash: fix x86_32 crash memory reserve dead loop
>>>> bug") fix this on 32-bit architecture. However, the problem is not
>>>> completely solved. If `CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX` on 64-bit
>>>> architecture, for example, when system memory is equal to
>>>> CRASH_ADDR_LOW_MAX on RISCV64, the following infinite loop will also occur:
>>>
>>> Interesting, I didn't expect risc-v defining them like these.
>>>
>>> #define CRASH_ADDR_LOW_MAX              dma32_phys_limit
>>> #define CRASH_ADDR_HIGH_MAX             memblock_end_of_DRAM()
>>
>> arm64 defines the high limit as PHYS_MASK+1, it doesn't need to be
>> dynamic and x86 does something similar (SZ_64T). Not sure why the
>> generic code and riscv define it like this.
>>
>>>> 	-> reserve_crashkernel_generic() and high is true
>>>> 	   -> alloc at [CRASH_ADDR_LOW_MAX, CRASH_ADDR_HIGH_MAX] fail
>>>> 	      -> alloc at [0, CRASH_ADDR_LOW_MAX] fail and repeatedly
>>>> 	         (because CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX).
>>>>
>>>> Before refactor in commit 9c08a2a139fe ("x86: kdump: use generic interface
>>>> to simplify crashkernel reservation code"), x86 do not try to reserve crash
>>>> memory at low if it fails to alloc above high 4G. However before refator in
>>>> commit fdc268232dbba ("arm64: kdump: use generic interface to simplify
>>>> crashkernel reservation"), arm64 try to reserve crash memory at low if it
>>>> fails above high 4G. For 64-bit systems, this attempt is less beneficial
>>>> than the opposite, remove it to fix this bug and align with native x86
>>>> implementation.
>>>
>>> And I don't like the idea crashkernel=,high failure will fallback to
>>> attempt in low area, so this looks good to me.
>>
>> Well, I kind of liked this behaviour. One can specify ,high as a
>> preference rather than forcing a range. The arm64 land has different
>> platforms with some constrained memory layouts. Such fallback works well
>> as a default command line option shipped with distros without having to
>> guess the SoC memory layout.
> 
> I haven't tried but it's possible that this patch also breaks those
> arm64 platforms with all RAM above 4GB when CRASH_ADDR_LOW_MAX is
> memblock_end_of_DRAM(). Here all memory would be low and in the absence
> of no fallback, it fails to allocate.
> 
> So, my strong preference would be to re-instate the current behaviour
> and work around the infinite loop in a different way.

Hi, baoquan, What's your opinion?

Only this patch should be re-instate or all the 3 dead loop fix patch?

> 
> Thanks.
> 

