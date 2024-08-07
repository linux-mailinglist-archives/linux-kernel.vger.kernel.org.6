Return-Path: <linux-kernel+bounces-277169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D88949D6C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 03:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78AB21C2182B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 01:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4134E15B999;
	Wed,  7 Aug 2024 01:40:57 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BF010E6
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 01:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722994856; cv=none; b=oSVJzU7Q9A+mB+9yJXINGiVHOhUmI6mfN/ti+SxE1lC0+4+v38b8it293da+f9BRf6AEYzYuLdkwFhoeRb0hcMh1zrCEQzSdPMfD56iDtFSCnazHHm0/1aFdfwb46srtxmrnvdI6OUe6u63uQUkWltPzVGCBqMUroJDEytAMa/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722994856; c=relaxed/simple;
	bh=UyZbVfwTrOe1vpEa+SN88ZQlemoZ5SButUjr+cwHdUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lb2f+IQa6oh3Vbe5lIJScYiZHBD7gIwivIjg57ulSSNX/CxHwc+ML3FN54qnzTlgRsM4t/19LrB0qM0WY0KGJr5bWpBZXfIpedqXx5ApZYG0CXDYVlbD+7CVnP240mYFcw7+nZUaVLKuhUIAcEC/xRz4ZaC/z3Nd2xQQn/GrXk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WdtC11RfszpSxC;
	Wed,  7 Aug 2024 09:39:41 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id B0B41180AE6;
	Wed,  7 Aug 2024 09:40:50 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 7 Aug 2024 09:40:49 +0800
Message-ID: <795d228c-eec5-d3ff-698e-61d93338cb42@huawei.com>
Date: Wed, 7 Aug 2024 09:40:48 +0800
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
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <ZrJ1JkyDVpRRB_9e@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/8/7 3:10, Catalin Marinas wrote:
> To Jinjie, if you make generic changes that affect other architectures,
> please either cc the individual lists/maintainers or at least cross-post
> to linux-arch. I don't follow lkml, there's just too much traffic there.

Sorry, I forgot to Cc to the other architectures.

> 
> On Fri, Aug 02, 2024 at 06:11:01PM +0800, Baoquan He wrote:
>> On 08/02/24 at 05:01pm, Jinjie Ruan wrote:
>>> On RISCV64 Qemu machine with 512MB memory, cmdline "crashkernel=500M,high"
>>> will cause system stall as below:
>>>
>>> 	 Zone ranges:
>>> 	   DMA32    [mem 0x0000000080000000-0x000000009fffffff]
>>> 	   Normal   empty
>>> 	 Movable zone start for each node
>>> 	 Early memory node ranges
>>> 	   node   0: [mem 0x0000000080000000-0x000000008005ffff]
>>> 	   node   0: [mem 0x0000000080060000-0x000000009fffffff]
>>> 	 Initmem setup node 0 [mem 0x0000000080000000-0x000000009fffffff]
>>> 	(stall here)
>>>
>>> commit 5d99cadf1568 ("crash: fix x86_32 crash memory reserve dead loop
>>> bug") fix this on 32-bit architecture. However, the problem is not
>>> completely solved. If `CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX` on 64-bit
>>> architecture, for example, when system memory is equal to
>>> CRASH_ADDR_LOW_MAX on RISCV64, the following infinite loop will also occur:
>>
>> Interesting, I didn't expect risc-v defining them like these.
>>
>> #define CRASH_ADDR_LOW_MAX              dma32_phys_limit
>> #define CRASH_ADDR_HIGH_MAX             memblock_end_of_DRAM()
> 
> arm64 defines the high limit as PHYS_MASK+1, it doesn't need to be
> dynamic and x86 does something similar (SZ_64T). Not sure why the
> generic code and riscv define it like this.
> 
>>> 	-> reserve_crashkernel_generic() and high is true
>>> 	   -> alloc at [CRASH_ADDR_LOW_MAX, CRASH_ADDR_HIGH_MAX] fail
>>> 	      -> alloc at [0, CRASH_ADDR_LOW_MAX] fail and repeatedly
>>> 	         (because CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX).
>>>
>>> Before refactor in commit 9c08a2a139fe ("x86: kdump: use generic interface
>>> to simplify crashkernel reservation code"), x86 do not try to reserve crash
>>> memory at low if it fails to alloc above high 4G. However before refator in
>>> commit fdc268232dbba ("arm64: kdump: use generic interface to simplify
>>> crashkernel reservation"), arm64 try to reserve crash memory at low if it
>>> fails above high 4G. For 64-bit systems, this attempt is less beneficial
>>> than the opposite, remove it to fix this bug and align with native x86
>>> implementation.
>>
>> And I don't like the idea crashkernel=,high failure will fallback to
>> attempt in low area, so this looks good to me.
> 
> Well, I kind of liked this behaviour. One can specify ,high as a
> preference rather than forcing a range. The arm64 land has different
> platforms with some constrained memory layouts. Such fallback works well
> as a default command line option shipped with distros without having to
> guess the SoC memory layout.
> 
> Something like below should fix the issue as well (untested):

I tested it on QEMU and it is good to fix this dead loop problem.

> 
> diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
> index d3b4cd12bdd1..ae92d6745ef4 100644
> --- a/kernel/crash_reserve.c
> +++ b/kernel/crash_reserve.c
> @@ -420,7 +420,8 @@ void __init reserve_crashkernel_generic(char *cmdline,
>  		 * For crashkernel=size[KMG],high, if the first attempt was
>  		 * for high memory, fall back to low memory.
>  		 */
> -		if (high && search_end == CRASH_ADDR_HIGH_MAX) {
> +		if (high && search_end == CRASH_ADDR_HIGH_MAX &&
> +		    CRASH_ADDR_LOW_MAX < CRASH_ADDR_HIGH_MAX) {
>  			search_end = CRASH_ADDR_LOW_MAX;
>  			search_base = 0;
>  			goto retry;
> 

