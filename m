Return-Path: <linux-kernel+bounces-222033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9848690FBD9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 06:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4958C1F23697
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 04:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52C8374FA;
	Thu, 20 Jun 2024 04:10:08 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A194B1DA4E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 04:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718856608; cv=none; b=G9tSbROGhYavbHlTcyhWGkXBdb/Qwt4btuC/ZqgpSnbpMw4YyLR0ZAt+cbWsaR2U6E6mX9cPSAjySkXqFMue8UBlXbUJtr1Kk983XXhSkdJD0FWvJlM9YaHc4PjsuuXzpjmLXf7UbAVPEh5PXmBdogytSlZGXzyp0hqsUE1k98A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718856608; c=relaxed/simple;
	bh=wD2TP6CDuh4Bq+NcZ//Ls5kwrvCEIa35VKHZxdUfXPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QXUEbsjodMHjx/qMNRm1PHuz+QcZxGNo9TkjwJ32COe5JWbAea2+3YEFHXRPwIk07F5Gxz5SQfVyHq5KF/pWEGOcZUUK8vPa//azboiAwc9BaxtJAONN2/WLESnXUQHB45wfk4n+AawnbSwHag9x1IIN+nDiwaOtTJYksNMQxh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4W4RKC3Z37z1N837;
	Thu, 20 Jun 2024 11:47:59 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D6EA18007E;
	Thu, 20 Jun 2024 11:52:15 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 11:52:14 +0800
Message-ID: <eeb78b0e-73cf-37ae-d780-08ae6b8211ac@huawei.com>
Date: Thu, 20 Jun 2024 11:52:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] arm64: smp: Fix missing IPI statistics
To: Will Deacon <will@kernel.org>
CC: <catalin.marinas@arm.com>, <mark.rutland@arm.com>,
	<dianders@chromium.org>, <swboyd@chromium.org>, <sumit.garg@linaro.org>,
	<frederic@kernel.org>, <scott@os.amperecomputing.com>,
	<misono.tomohiro@fujitsu.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20240607074716.4068975-1-ruanjinjie@huawei.com>
 <20240619133258.GA3526@willie-the-truck>
Content-Language: en-US
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240619133258.GA3526@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/6/19 21:32, Will Deacon wrote:
> On Fri, Jun 07, 2024 at 03:47:16PM +0800, Jinjie Ruan wrote:
>> commit 83cfac95c018 ("genirq: Allow interrupts to be excluded from
>> /proc/interrupts") is to avoid IPIs appear twice in /proc/interrupts.
>> But the commit 331a1b3a836c ("arm64: smp: Add arch support for backtrace
>> using pseudo-NMI") and commit 2f5cd0c7ffde("arm64: kgdb: Implement
>> kgdb_roundup_cpus() to enable pseudo-NMI roundup") set CPU_BACKTRACE and
>> KGDB_ROUNDUP IPIs "IRQ_HIDDEN" flag but not show them in
>> arch_show_interrupts(), which cause the interrupt kstat_irqs accounting
>> is missing in display.
>>
>> Fixes: 331a1b3a836c ("arm64: smp: Add arch support for backtrace using pseudo-NMI")
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  arch/arm64/kernel/smp.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>> index 31c8b3094dd7..7f9a5cf0f3b8 100644
>> --- a/arch/arm64/kernel/smp.c
>> +++ b/arch/arm64/kernel/smp.c
>> @@ -1039,7 +1039,8 @@ void __init set_smp_ipi_range(int ipi_base, int n)
>>  		}
>>  
>>  		ipi_desc[i] = irq_to_desc(ipi_base + i);
>> -		irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
>> +		if (i < NR_IPI)
>> +			irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
>>  	}
> 
> Please can you show the contents of /proc/interrupts before and after
> this patch and put that in the commit message? I'm not seeing how the
> two new IPIs get picked up by arch_show_interrupts().


Before this patch, CPU_BACKTRACE and KGDB_ROUNDUP IPIs are missing as below:

/ # cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
 11:        463        656        243        654     GICv3  27 Level
arch_timer
 13:         14          0          0          0     GICv3  33 Level
uart-pl011
 17:          0          0          0          0   ITS-MSI 16384 Edge
  virtio2-config
 18:          0          5          0          0   ITS-MSI 16385 Edge
  virtio2-input
 19:         68          0          0          0     GICv3  78 Edge
virtio0
 20:          0          0          0          0     GICv3  79 Edge
virtio1
 21:          0          0          0          0     GICv3  34 Level
rtc-pl031
 22:          2          2          2          2     GICv3  23 Level
arm-pmu
 23:          0          0          0          0   ITS-MSI 32768 Edge
  virtio3-config
 24:          0          0          0          0   ITS-MSI 32769 Edge
  virtio3-requests
 25:          0          0          0          0 9030000.pl061   3 Edge
    GPIO Key Poweroff
IPI0:        15         13          5         21       Rescheduling
interrupts
IPI1:       385        129        282        194       Function call
interrupts
IPI2:         0          0          0          0       CPU stop interrupts
IPI3:         0          0          0          0       CPU stop (for
crash dump) interrupts
IPI4:         0          0          0          0       Timer broadcast
interrupts
IPI5:         1          0          0          0       IRQ work interrupts
Err:          0


After this patch the hwirq6/7 IPI is also displayed:

/ # cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
  7:          0          0          0          0     GICv3   6 Edge      IPI
  8:          0          0          0          0     GICv3   7 Edge      IPI
 11:        414        433        424        422     GICv3  27 Level
arch_timer
 13:         21          0          0          0     GICv3  33 Level
uart-pl011
 17:          0          0          0          0   ITS-MSI 16384 Edge
  virtio2-config
 18:          0          6          0          0   ITS-MSI 16385 Edge
  virtio2-input
 19:         60          0          0          0     GICv3  78 Edge
virtio0
 20:          0          0          0          0     GICv3  79 Edge
virtio1
 21:          0          0          0          0     GICv3  34 Level
rtc-pl031
 22:          3          3          3          3     GICv3  23 Level
arm-pmu
 23:          0          0          0          0   ITS-MSI 32768 Edge
  virtio3-config
 24:          0          0          0          0   ITS-MSI 32769 Edge
  virtio3-requests
 25:          0          0          0          0 9030000.pl061   3 Edge
    GPIO Key Poweroff
IPI0:        15         13         19         12       Rescheduling
interrupts
IPI1:       241        162        328        252       Function call
interrupts
IPI2:         0          0          0          0       CPU stop interrupts
IPI3:         0          0          0          0       CPU stop (for
crash dump) interrupts
IPI4:         0          0          0          0       Timer broadcast
interrupts
IPI5:         0          1          0          0       IRQ work interrupts
Err:          0


> 
> Thanks,
> 
> Will

