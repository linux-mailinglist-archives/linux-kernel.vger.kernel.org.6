Return-Path: <linux-kernel+bounces-258548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7031938990
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24E141C20F50
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 07:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F0212B73;
	Mon, 22 Jul 2024 07:04:50 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4E918042
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 07:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721631889; cv=none; b=XUxF4nSx7dxLz5dFvIfSWY0SnBxdhidVgWMvmPgaB9/Y06myXG1NoFOjNUbMM2xRUhNK1T2BB7c4lsWNGwEdoX5ESuKCEvsRffVdzt3AkLl1hzJwN8LU4kTBqmwbnPaWdt4yAGMot2QtiwMvku8k+ekuB20FxxZmGiV6zMbfydI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721631889; c=relaxed/simple;
	bh=91YHHU0Ho01lRxigngZ6ZLyu6re5ZKcuyX+U4xCo1Sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F6/G9e9quWemw5a2vmlGpIpbwpJizlBYzPFx2SrtVEC8TWxqX/R/JV1J3npzM2uyiIujbZyJntDZiS6k/K+7m9EwOMNaFIEzvXB1Zse6S2sOdzCQby5f0FSxeAfjErU0tnVxKqC/Bip2rGEgpwid61kPgz3ugYuQNZqtcZTpt0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WSB7M22WLzdjk9;
	Mon, 22 Jul 2024 15:02:55 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 582A518009B;
	Mon, 22 Jul 2024 15:04:41 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 22 Jul 2024 15:04:40 +0800
Message-ID: <32100260-53a3-cebc-9aaf-a94a6ac07793@huawei.com>
Date: Mon, 22 Jul 2024 15:04:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 3/3] riscv: kdump: Fix crash memory reserve exceed
 system memory bug
Content-Language: en-US
To: Mike Rapoport <rppt@kernel.org>
CC: <linux@armlinux.org.uk>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<arnd@arndb.de>, <gregkh@linuxfoundation.org>, <deller@gmx.de>,
	<javierm@redhat.com>, <bhe@redhat.com>, <robh@kernel.org>,
	<alexghiti@rivosinc.com>, <bjorn@rivosinc.com>, <akpm@linux-foundation.org>,
	<namcao@linutronix.de>, <dawei.li@shingroup.cn>, <chenjiahao16@huawei.com>,
	<julian.stecklina@cyberus-technology.de>, <rafael.j.wysocki@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20240722035701.696874-1-ruanjinjie@huawei.com>
 <20240722035701.696874-4-ruanjinjie@huawei.com> <Zp3-dZHhN7LbMggc@kernel.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <Zp3-dZHhN7LbMggc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/7/22 14:38, Mike Rapoport wrote:
> Hi,
> 
> On Mon, Jul 22, 2024 at 11:57:01AM +0800, Jinjie Ruan wrote:
>> Similar with x86_32, on Riscv32 Qemu "virt" machine with 1GB memory, the
>> crash kernel "crashkernel=4G" is ok as below:
>> 	crashkernel reserved: 0x00000000bf400000 - 0x00000001bf400000 (4096 MB)
>>
>> The cause is that the crash_size is parsed and printed with "unsigned long
>> long" data type which is 8 bytes but allocated used with "phys_addr_t"
>> which is 4 bytes in memblock_phys_alloc_range().
>>
>> Fix it by checking if the crash_size is greater than system RAM size and
>> warn out as parse_crashkernel_mem() do it if so.
>>
>> After this patch, it fails and there is no above confusing reserve
>> success info.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  arch/riscv/mm/init.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index bfa2dea95354..5d66a4937fcd 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -1381,6 +1381,11 @@ static void __init arch_reserve_crashkernel(void)
>>  	if (ret)
>>  		return;
>>  
>> +	if (crash_size >= memblock_phys_mem_size()) {
>> +		pr_warn("Crashkernel: invalid size.");
>> +		return;
>> +	}
>> +
> 
> What the point of adding three identical checks right after the call to
> parse_crashkernel()?

Maybe you are right, the original version checks in parse_crashkernel
(), but there's a problem.

> 
> This check should be there and parse_crashkernel() should return error in
> this case.

Thank you very much, I'll fix it like this in v5.

> 
>>  	reserve_crashkernel_generic(cmdline, crash_size, crash_base,
>>  				    low_size, high);
>>  }
>> -- 
>> 2.34.1
>>
> 

