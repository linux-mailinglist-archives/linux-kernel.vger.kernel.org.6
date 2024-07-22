Return-Path: <linux-kernel+bounces-258551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5A19389A1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A36FB21367
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 07:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF83817BD5;
	Mon, 22 Jul 2024 07:08:38 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC443DF51
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 07:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721632118; cv=none; b=uVgjYttU9cbAVeN2TN+qwPp01UDZ/KiBc9femEEQDIjW4S3Js0LnSlbgVXbszK60kFGrvcB4+4Y8Li0zzfaCiGd7WRgUnCmd5g977ahL2mQ821q2exwhQ2He4N3BVtM1fxosFSV1vvlGHyXSsK82/j9yYwXYgC0zD6r9Emd7wjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721632118; c=relaxed/simple;
	bh=zR0fiIg21DFh/exHdAf9KRFt3nu7sGyvhkwqQpW1Zdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VgyASaQiEVSfijItl0+mdQbHR72tScReIipH5XgodJ18Ml+SOcuC09/eHkfya8RNGt6sJ2Xege9SSm2BW1G7pZ/9jAZaI6J38SssRlfwCCAbuAQnGGGKce2QSYre5PyisyDfRkFwU1kqC2qmmf982XUAMyu/AS9kjTluPIcfqD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WSB860gDrzxTgY;
	Mon, 22 Jul 2024 15:03:34 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 63AF4140427;
	Mon, 22 Jul 2024 15:08:32 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 22 Jul 2024 15:08:31 +0800
Message-ID: <5816d4d5-e038-c90b-5ac2-1a3b3a8b9e46@huawei.com>
Date: Mon, 22 Jul 2024 15:08:29 +0800
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
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
> 
> This check should be there and parse_crashkernel() should return error in
> this case.

Hi, Mike

How about the folling rough patch?

--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -313,7 +313,7 @@ int __init parse_crashkernel(char *cmdline,
        if (high && ret == -ENOENT) {
                ret = __parse_crashkernel(cmdline, 0, crash_size,
                                crash_base, suffix_tbl[SUFFIX_HIGH]);
-               if (ret || !*crash_size)
+               if (ret || !*crash_size || crash_size >= system_ram)
                        return -EINVAL;

                /*
@@ -332,7 +332,7 @@ int __init parse_crashkernel(char *cmdline,
                *high = true;
        }
 #endif
-       if (!*crash_size)
+       if (!*crash_size || crash_size >= system_ram)
                ret = -EINVAL;


> 
>>  	reserve_crashkernel_generic(cmdline, crash_size, crash_base,
>>  				    low_size, high);
>>  }
>> -- 
>> 2.34.1
>>
> 

