Return-Path: <linux-kernel+bounces-265041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7775693EBD2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 05:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07AF4B20FBA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 03:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36FF7E782;
	Mon, 29 Jul 2024 03:24:30 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688EA1E519
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 03:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722223470; cv=none; b=ZJ1uYEgWqfEIMM5RiPOb04eAu9M2DkUnMK6CrXtGEoerFDw/6q464KOm3QSsi4DG5siVa1IjOHhAEelIWeEUlPgjv8PQH0vXE8eejckcqSJkRJTSPmOhqoaVkMZD6KetWlZq9NEiZYNyNLmEY5ObrF7usDJvlnEfxMSFXMEcnxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722223470; c=relaxed/simple;
	bh=Bva/JzVXr203viIyjg4oY3XJzNBRJqfdLmLgk+52V/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tCE7jZzeIg9Dj3FwSX4HkzgzId8LtgvOAnyyhK6MI78+O+q8F0s60EQ9Pq3g1bdCmOktL+vvg7+YyVPKTOK6eiu7bpbwFnjc2WUW/xVpwmMt9ZGISkRc5KFNs0FztW98FS0wYMezSgngMqiORkoYs/wxIJpNohUCtOdqdt6+xcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WXNvs6QshzdkLj;
	Mon, 29 Jul 2024 11:22:33 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 482851800D0;
	Mon, 29 Jul 2024 11:24:23 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 29 Jul 2024 11:24:22 +0800
Message-ID: <564e362d-5e8c-5d23-9c54-bfb811794169@huawei.com>
Date: Mon, 29 Jul 2024 11:24:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v5] crash: Fix crash memory reserve exceed system memory
 bug
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
CC: <vgoyal@redhat.com>, <dyoung@redhat.com>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <rppt@kernel.org>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240723020746.3945016-1-ruanjinjie@huawei.com>
 <Zp8859QW+YV1KqQ9@MiWiFi-R3L-srv>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <Zp8859QW+YV1KqQ9@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/7/23 13:17, Baoquan He wrote:
> On 07/23/24 at 10:07am, Jinjie Ruan wrote:
>> On x86_32 Qemu machine with 1GB memory, the cmdline "crashkernel=4G" is ok
>> as below:
>> 	crashkernel reserved: 0x0000000020000000 - 0x0000000120000000 (4096 MB)
>>
>> It's similar on other architectures, such as ARM32 and RISCV32.
>>
>> The cause is that the crash_size is parsed and printed with "unsigned long
>> long" data type which is 8 bytes but allocated used with "phys_addr_t"
>> which is 4 bytes in memblock_phys_alloc_range().
>>
>> Fix it by checking if crash_size is greater than system RAM size and
>> return error if so.
>>
>> After this patch, there is no above confusing reserve success info.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> Suggested-by: Baoquan He <bhe@redhat.com>
>> Suggested-by: Mike Rapoport <rppt@kernel.org>
> 
> 
> My Suggested-by can be taken off because I suggested to check the parsed
> value after parse_crashkernel(), Mike's suggestion is better.

Hi, Can the suggested-by be removed when this version is merged, or a
new version needs to be sent?

> 
> For this version,
> 
> Acked-by: Baoquan He <bhe@redhat.com>
> 
>> ---
>> v5:
>> - Fix it in common parse_crashkernel() instead of per-arch.
>> - Add suggested-by.
>>
>> v4:
>> - Update the warn info to align with parse_crashkernel_mem().
>> - Rebased on the "ARM: Use generic interface to simplify crashkernel
>>   reservation" patch.
>> - Also fix for riscv32.
>> - Update the commit message.
>>
>> v3:
>> - Handle the check in reserve_crashkernel() Baoquan suggested.
>> - Split x86_32 and arm32.
>> - Add Suggested-by.
>> - Drop the wrong fix tag.
>>
>> v2:
>> - Also fix for x86_32.
>> - Update the fix method.
>> - Peel off the other two patches.
>> - Update the commit message.
>> ---
>>  kernel/crash_reserve.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
>> index ad5b3f2c5487..5387269114f6 100644
>> --- a/kernel/crash_reserve.c
>> +++ b/kernel/crash_reserve.c
>> @@ -335,6 +335,9 @@ int __init parse_crashkernel(char *cmdline,
>>  	if (!*crash_size)
>>  		ret = -EINVAL;
>>  
>> +	if (*crash_size >= system_ram)
>> +		ret = -EINVAL;
>> +
>>  	return ret;
>>  }
>>  
>> -- 
>> 2.34.1
>>
> 
> 

